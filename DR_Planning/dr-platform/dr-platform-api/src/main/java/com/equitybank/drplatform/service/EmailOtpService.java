package com.equitybank.drplatform.service;

import com.equitybank.drplatform.config.UuidV7Generator;
import com.equitybank.drplatform.entity.EmailOtpEntity;
import com.equitybank.drplatform.entity.UserEntity;
import com.equitybank.drplatform.enums.UserRole;
import com.equitybank.drplatform.exception.ValidationException;
import com.equitybank.drplatform.repository.EmailOtpRepository;
import com.equitybank.drplatform.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.time.Instant;
import java.util.Arrays;
import java.util.HexFormat;
import java.util.Optional;
import java.util.UUID;

@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class EmailOtpService {

    private final EmailOtpRepository emailOtpRepository;
    private final UserRepository     userRepository;
    private final JavaMailSender     mailSender;

    @Value("${app.auth.allowed-domains:equitybank.co.ke,gmail.com}")
    private String allowedDomainsConfig;

    @Value("${app.auth.otp-expiry-minutes:10}")
    private int otpExpiryMinutes;

    @Value("${spring.mail.username:noreply-dr@equitybank.co.ke}")
    private String fromEmail;

    private final SecureRandom secureRandom = new SecureRandom();

    // ── Result records ────────────────────────────────────────────────────────

    /**
     * Returned by {@link #sendOtp}: carries the delivery outcome AND the
     * session correlation ID so the caller can propagate it to the audit layer.
     */
    public record OtpSendResult(boolean delivered, UUID sessionId) {}

    /**
     * Returned by {@link #verifyAndConsumeOtp}: the resolved user AND the same
     * session ID that was created on OTP request, ready to be embedded in the JWT jti.
     */
    public record OtpVerifyResult(UserEntity user, UUID sessionId) {}

    // ── Send OTP ──────────────────────────────────────────────────────────────

    public OtpSendResult sendOtp(String email) {
        String normalized = email.trim().toLowerCase();
        validateDomain(normalized);

        emailOtpRepository.deleteExpired(Instant.now());

        String code      = String.format("%06d", secureRandom.nextInt(1_000_000));
        String hash      = hashCode(code);
        UUID   sessionId = UuidV7Generator.generate();

        EmailOtpEntity otp = EmailOtpEntity.builder()
                .email(normalized)
                .otpHash(hash)
                .expiresAt(Instant.now().plusSeconds(otpExpiryMinutes * 60L))
                .sessionId(sessionId)
                .build();
        emailOtpRepository.save(otp);

        try {
            sendEmail(normalized, code);
            log.info("OTP email sent to {}", normalized);
            return new OtpSendResult(true, sessionId);
        } catch (Exception e) {
            log.warn("SMTP unavailable — OTP for {} is: {} (dev only — never expose in API response)",
                    normalized, code);
            return new OtpSendResult(false, sessionId);
        }
    }

    // ── Verify OTP ────────────────────────────────────────────────────────────

    public OtpVerifyResult verifyAndConsumeOtp(String email, String code) {
        String normalized = email.trim().toLowerCase();
        String hash       = hashCode(code.trim());

        Optional<EmailOtpEntity> otpOpt =
                emailOtpRepository.findTopByEmailAndUsedFalseOrderByCreatedAtDesc(normalized);

        if (otpOpt.isEmpty()) {
            throw new ValidationException("No verification code found for this email. Request a new one.");
        }

        EmailOtpEntity otp = otpOpt.get();

        if (otp.getExpiresAt().isBefore(Instant.now())) {
            throw new ValidationException("Verification code has expired. Please request a new one.");
        }

        if (!otp.getOtpHash().equals(hash)) {
            throw new ValidationException("Invalid verification code.");
        }

        otp.setUsed(true);
        emailOtpRepository.save(otp);

        // Reuse the session_id that was generated at OTP request time.
        // Falls back for any legacy OTP rows that pre-date V12.
        UUID sessionId = otp.getSessionId() != null
                ? otp.getSessionId()
                : UuidV7Generator.generate();

        UserEntity user = userRepository.findByEmail(normalized).orElseGet(() -> {
            String displayName = normalized.split("@")[0].replace(".", " ");
            displayName = Arrays.stream(displayName.split(" "))
                    .map(w -> w.isEmpty() ? w : Character.toUpperCase(w.charAt(0)) + w.substring(1))
                    .reduce("", (a, b) -> a + (a.isEmpty() ? "" : " ") + b);

            UserEntity newUser = UserEntity.builder()
                    .email(normalized)
                    .displayName(displayName)
                    .role(UserRole.APP_OWNER)
                    .subsidiaryId("KE")
                    .isActive(true)
                    .build();
            log.info("First login — created new user {} with role APP_OWNER", normalized);
            return userRepository.save(newUser);
        });

        return new OtpVerifyResult(user, sessionId);
    }

    // ── Helpers ───────────────────────────────────────────────────────────────

    private void validateDomain(String email) {
        if (!email.contains("@")) {
            throw new ValidationException("Invalid email address.");
        }
        String domain = email.substring(email.indexOf('@') + 1);
        boolean allowed = Arrays.stream(allowedDomainsConfig.split(","))
                .map(String::trim)
                .anyMatch(d -> d.equalsIgnoreCase(domain));
        if (!allowed) {
            throw new ValidationException(
                    "Email domain @" + domain + " is not authorised for this platform.");
        }
    }

    private void sendEmail(String to, String code) throws Exception {
        var message = mailSender.createMimeMessage();
        var helper  = new MimeMessageHelper(message, false, "UTF-8");
        helper.setFrom(fromEmail);
        helper.setTo(to);
        helper.setSubject("Equity Bank DR Platform — Your verification code");
        helper.setText(buildEmailBody(to, code), true);
        mailSender.send(message);
    }

    private String buildEmailBody(String to, String code) {
        return """
                <div style="font-family:Arial,sans-serif;max-width:520px;margin:0 auto">
                  <div style="background:#8B1A10;padding:24px 32px;border-radius:8px 8px 0 0">
                    <p style="color:#fff;font-size:20px;font-weight:bold;margin:0">
                      &#127968; Equity Bank DR Platform
                    </p>
                  </div>
                  <div style="background:#fff;border:1px solid #e5e7eb;padding:32px;border-radius:0 0 8px 8px">
                    <p style="color:#374151;font-size:15px">Hello,</p>
                    <p style="color:#374151;font-size:15px">
                      Your verification code for <strong>%s</strong> is:
                    </p>
                    <div style="text-align:center;margin:24px 0">
                      <span style="font-size:40px;font-weight:bold;letter-spacing:12px;color:#8B1A10">%s</span>
                    </div>
                    <p style="color:#6b7280;font-size:13px">
                      This code expires in %d minutes. Do not share it with anyone.
                    </p>
                    <hr style="border:none;border-top:1px solid #e5e7eb;margin:24px 0"/>
                    <p style="color:#9ca3af;font-size:12px">
                      Equity Group Holdings PLC &middot; Confidential &middot; Internal use only
                    </p>
                  </div>
                </div>
                """.formatted(to, code, otpExpiryMinutes);
    }

    private String hashCode(String code) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(code.getBytes(StandardCharsets.UTF_8));
            return HexFormat.of().formatHex(hash);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-256 not available", e);
        }
    }
}
