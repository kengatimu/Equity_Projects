package com.equitybank.drplatform.security;

import com.equitybank.drplatform.entity.UserEntity;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.UUID;

@Service
@Slf4j
public class JwtService {

    @Value("${app.jwt.secret}")
    private String jwtSecret;

    @Value("${app.jwt.access-token-expiry-ms}")
    private long accessTokenExpiryMs;

    @Value("${app.jwt.refresh-token-expiry-ms}")
    private long refreshTokenExpiryMs;

    private SecretKey getSigningKey() {
        return Keys.hmacShaKeyFor(jwtSecret.getBytes(StandardCharsets.UTF_8));
    }

    /**
     * Generates an access token that embeds the session correlation ID as the
     * standard JWT {@code jti} (JWT ID) claim.  {@code JwtAuthFilter} reads
     * this claim on every authenticated request and stamps it onto the current
     * HTTP request via {@link com.equitybank.drplatform.audit.AuditContext} so
     * every audit log row in the session carries the same {@code session_id}.
     */
    public String generateAccessToken(UserEntity user, UUID sessionId) {
        return Jwts.builder()
                .id(sessionId.toString())           // jti — session correlation key
                .subject(user.getId().toString())
                .claim("email", user.getEmail())
                .claim("role", user.getRole().name())
                .claim("subsidiary", user.getSubsidiaryId())
                .claim("displayName", user.getDisplayName())
                .claim("type", "access")
                .issuedAt(new Date())
                .expiration(new Date(System.currentTimeMillis() + accessTokenExpiryMs))
                .signWith(getSigningKey())
                .compact();
    }

    public String generateRefreshToken(UserEntity user) {
        return Jwts.builder()
                .subject(user.getId().toString())
                .claim("type", "refresh")
                .issuedAt(new Date())
                .expiration(new Date(System.currentTimeMillis() + refreshTokenExpiryMs))
                .signWith(getSigningKey())
                .compact();
    }

    public Claims extractAllClaims(String token) {
        return Jwts.parser()
                .verifyWith(getSigningKey())
                .build()
                .parseSignedClaims(token)
                .getPayload();
    }

    public String extractUserId(String token) {
        return extractAllClaims(token).getSubject();
    }

    /** Returns the {@code jti} claim (session correlation ID), or {@code null} if absent. */
    public String extractSessionId(String token) {
        try {
            return extractAllClaims(token).getId();
        } catch (Exception e) {
            return null;
        }
    }

    /** Returns the {@code email} custom claim, or {@code null} if absent. */
    public String extractEmail(String token) {
        try {
            return extractAllClaims(token).get("email", String.class);
        } catch (Exception e) {
            return null;
        }
    }

    public boolean isTokenExpired(String token) {
        return extractAllClaims(token).getExpiration().before(new Date());
    }

    public boolean validateToken(String token) {
        try {
            extractAllClaims(token);
            return !isTokenExpired(token);
        } catch (Exception e) {
            log.debug("JWT validation failed: {}", e.getClass().getSimpleName());
            return false;
        }
    }

    public long getAccessTokenExpiryMs() {
        return accessTokenExpiryMs;
    }
}
