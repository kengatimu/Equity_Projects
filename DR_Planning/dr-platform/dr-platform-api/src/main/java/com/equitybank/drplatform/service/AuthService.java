package com.equitybank.drplatform.service;

import com.equitybank.drplatform.audit.AuditContext;
import com.equitybank.drplatform.audit.Auditable;
import com.equitybank.drplatform.config.UuidV7Generator;
import com.equitybank.drplatform.dto.request.LoginRequest;
import com.equitybank.drplatform.dto.request.MfaVerifyRequest;
import com.equitybank.drplatform.dto.response.AuthResponse;
import com.equitybank.drplatform.dto.response.UserDto;
import com.equitybank.drplatform.entity.RefreshTokenEntity;
import com.equitybank.drplatform.entity.UserEntity;
import com.equitybank.drplatform.exception.ResourceNotFoundException;
import com.equitybank.drplatform.exception.ValidationException;
import com.equitybank.drplatform.repository.RefreshTokenRepository;
import com.equitybank.drplatform.repository.UserRepository;
import com.equitybank.drplatform.security.JwtService;
import com.equitybank.drplatform.security.LdapAuthProvider;
import com.equitybank.drplatform.service.EmailOtpService.OtpSendResult;
import com.equitybank.drplatform.service.EmailOtpService.OtpVerifyResult;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.Instant;
import java.util.HexFormat;
import java.util.UUID;

@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class AuthService {

    private final LdapAuthProvider      ldapAuthProvider;
    private final EmailOtpService       emailOtpService;
    private final UserRepository        userRepository;
    private final RefreshTokenRepository refreshTokenRepository;
    private final JwtService            jwtService;

    @Value("${app.jwt.refresh-token-expiry-ms}")
    private long refreshTokenExpiryMs;

    // ── LDAP login (future production path) ───────────────────────────────────

    @Auditable(action = "USER_LOGIN", resourceType = "User")
    public AuthResponse login(LoginRequest request) {
        String ip = clientIp();
        log.info("[AUTH] Login attempt  email={} ip={}", request.getEmail(), ip);

        Authentication auth = ldapAuthProvider.authenticate(
                new UsernamePasswordAuthenticationToken(request.getEmail(), request.getPassword()));

        var userDetails = (com.equitybank.drplatform.security.DrPlatformUserDetails) auth.getPrincipal();
        UserEntity user = userDetails.getUser();

        UUID sessionId = UuidV7Generator.generate();
        AuditContext.setSessionId(sessionId.toString());
        AuditContext.setActorEmail(user.getEmail());

        user.setLastLogin(Instant.now());
        userRepository.save(user);

        log.info("[AUTH] Login success  email={} role={} ip={} loginTime={}",
                user.getEmail(), user.getRole(), ip, user.getLastLogin());

        return issueTokenPair(user, sessionId);
    }

    @Auditable(action = "MFA_VERIFIED", resourceType = "User")
    public AuthResponse verifyMfa(MfaVerifyRequest request) {
        if (request.getCode() == null || request.getCode().length() != 6) {
            throw new ValidationException("Invalid MFA code");
        }
        UUID userId;
        try {
            userId = UUID.fromString(request.getMfaSession());
        } catch (IllegalArgumentException e) {
            throw new ValidationException("Invalid MFA session");
        }
        UserEntity user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User", userId));

        UUID sessionId = UuidV7Generator.generate();
        AuditContext.setSessionId(sessionId.toString());
        AuditContext.setActorEmail(user.getEmail());

        return issueTokenPair(user, sessionId);
    }

    // ── OTP login (current flow) ───────────────────────────────────────────────

    @Auditable(action = "OTP_REQUESTED", resourceType = "User")
    public boolean requestOtp(String email) {
        String ip = clientIp();
        log.info("[AUTH] OTP requested  email={} ip={}", email, ip);

        OtpSendResult result = emailOtpService.sendOtp(email);

        // Stamp AuditContext NOW (before the aspect's audit-write fires after proceed()).
        // This gives OTP_REQUESTED the same session_id that will later go into the JWT.
        AuditContext.setSessionId(result.sessionId().toString());
        AuditContext.setActorEmail(email.trim().toLowerCase());

        if (result.delivered()) {
            log.info("[AUTH] OTP delivered  email={}", email);
        } else {
            log.warn("[AUTH] OTP not delivered (SMTP unavailable)  email={}", email);
        }
        return result.delivered();
    }

    @Auditable(action = "OTP_VERIFIED", resourceType = "User")
    public AuthResponse verifyOtp(String email, String code) {
        String ip = clientIp();
        log.info("[AUTH] OTP verification attempt  email={} ip={}", email, ip);

        OtpVerifyResult result;
        try {
            result = emailOtpService.verifyAndConsumeOtp(email, code);
        } catch (Exception ex) {
            log.warn("[AUTH] OTP verification FAILED  email={} ip={} reason={}",
                    email, ip, ex.getMessage());
            throw ex;
        }

        UserEntity user      = result.user();
        UUID       sessionId = result.sessionId();

        // Re-stamp AuditContext with the confirmed session_id so OTP_VERIFIED and all
        // subsequent authenticated events share the same correlation key.
        AuditContext.setSessionId(sessionId.toString());
        AuditContext.setActorEmail(user.getEmail());

        Instant loginTime = Instant.now();
        user.setLastLogin(loginTime);
        userRepository.save(user);

        log.info("[AUTH] Login success (OTP)  email={} role={} ip={} loginTime={}",
                user.getEmail(), user.getRole(), ip, loginTime);

        return issueTokenPair(user, sessionId);
    }

    // ── Token lifecycle ────────────────────────────────────────────────────────

    @Auditable(action = "TOKEN_REFRESHED", resourceType = "User")
    public AuthResponse refreshToken(String incomingRefreshToken) {
        // Extract session context from the access token in the Authorization header
        // (the refresh endpoint is under /api/auth/ so JwtAuthFilter skips it).
        populateAuditContextFromAccessToken();

        String tokenHash = hashToken(incomingRefreshToken);
        RefreshTokenEntity stored = refreshTokenRepository.findByTokenHash(tokenHash)
                .orElseThrow(() -> new ValidationException("Invalid refresh token"));

        if (stored.isRevoked()) {
            log.warn("[AUTH] Token refresh rejected — token already revoked  userId={} ip={}",
                    stored.getUserId(), clientIp());
            throw new ValidationException("Refresh token has been revoked");
        }
        if (stored.getExpiresAt().isBefore(Instant.now())) {
            log.warn("[AUTH] Token refresh rejected — token expired  userId={} ip={}",
                    stored.getUserId(), clientIp());
            throw new ValidationException("Refresh token has expired");
        }

        stored.setRevoked(true);
        refreshTokenRepository.save(stored);

        UserEntity user = userRepository.findById(stored.getUserId())
                .orElseThrow(() -> new ResourceNotFoundException("User", stored.getUserId()));

        // Issue a fresh access token with a new session_id
        UUID newSessionId = UuidV7Generator.generate();
        AuditContext.setSessionId(newSessionId.toString());
        AuditContext.setActorEmail(user.getEmail());

        log.info("[AUTH] Token refreshed  email={} role={} ip={}",
                user.getEmail(), user.getRole(), clientIp());

        return issueTokenPair(user, newSessionId);
    }

    @Auditable(action = "USER_LOGOUT", resourceType = "User")
    public void logout(String refreshToken) {
        String ip = clientIp();

        // Extract session context from the access token in the Authorization header
        // (the logout endpoint is under /api/auth/ so JwtAuthFilter skips it).
        populateAuditContextFromAccessToken();

        try {
            String tokenHash = hashToken(refreshToken);
            refreshTokenRepository.findByTokenHash(tokenHash).ifPresentOrElse(
                t -> {
                    userRepository.findById(t.getUserId()).ifPresent(user -> {
                        AuditContext.setActorEmail(user.getEmail());
                        log.info("[AUTH] Logout  email={} role={} ip={} logoutTime={}",
                                user.getEmail(), user.getRole(), ip, Instant.now());
                    });
                    t.setRevoked(true);
                    refreshTokenRepository.save(t);
                },
                () -> log.debug("[AUTH] Logout — refresh token not found (may already be expired)  ip={}", ip)
            );
        } catch (Exception e) {
            log.debug("[AUTH] Logout token revocation error (non-fatal): {}", e.getMessage());
        }
    }

    public void revokeAllUserTokens(UUID userId) {
        log.info("[AUTH] Revoking all tokens  userId={}", userId);
        refreshTokenRepository.revokeAllByUserId(userId);
    }

    // ── Internal helpers ───────────────────────────────────────────────────────

    private AuthResponse issueTokenPair(UserEntity user, UUID sessionId) {
        String accessToken     = jwtService.generateAccessToken(user, sessionId);
        String rawRefreshToken = jwtService.generateRefreshToken(user);

        RefreshTokenEntity tokenEntity = RefreshTokenEntity.builder()
                .userId(user.getId())
                .tokenHash(hashToken(rawRefreshToken))
                .expiresAt(Instant.now().plusMillis(refreshTokenExpiryMs))
                .revoked(false)
                .build();
        refreshTokenRepository.save(tokenEntity);

        return AuthResponse.builder()
                .accessToken(accessToken)
                .refreshToken(rawRefreshToken)
                .expiresIn(jwtService.getAccessTokenExpiryMs() / 1000)
                .user(UserDto.fromEntity(user))
                .build();
    }

    /**
     * For endpoints under /api/auth/ that JwtAuthFilter skips (logout, token-refresh),
     * manually decode the access token from the Authorization header and populate
     * AuditContext so the session_id is available for the audit log writer.
     */
    private void populateAuditContextFromAccessToken() {
        try {
            ServletRequestAttributes attrs =
                    (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
            if (attrs == null) return;
            String authHeader = attrs.getRequest().getHeader("Authorization");
            if (authHeader == null || !authHeader.startsWith("Bearer ")) return;
            String accessToken = authHeader.substring(7);
            String sessionId   = jwtService.extractSessionId(accessToken);
            String email       = jwtService.extractEmail(accessToken);
            if (sessionId != null) AuditContext.setSessionId(sessionId);
            if (email     != null) AuditContext.setActorEmail(email);
        } catch (Exception ignored) { /* expired token is fine — audit still writes */ }
    }

    public String hashToken(String token) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(token.getBytes(StandardCharsets.UTF_8));
            return HexFormat.of().formatHex(hash);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-256 not available", e);
        }
    }

    private String clientIp() {
        try {
            ServletRequestAttributes attrs =
                    (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
            if (attrs != null) {
                String xff = attrs.getRequest().getHeader("X-Forwarded-For");
                if (xff != null && !xff.isBlank()) return xff.split(",")[0].trim();
                return attrs.getRequest().getRemoteAddr();
            }
        } catch (Exception ignored) {}
        return "unknown";
    }
}
