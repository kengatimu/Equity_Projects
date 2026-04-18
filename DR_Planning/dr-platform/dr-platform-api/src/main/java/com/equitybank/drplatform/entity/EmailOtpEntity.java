package com.equitybank.drplatform.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.Instant;
import java.util.UUID;

@Entity
@Table(name = "email_otps")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EmailOtpEntity extends BaseEntity {

    @Column(name = "email", nullable = false, length = 200)
    private String email;

    @Column(name = "otp_hash", nullable = false, length = 64)
    private String otpHash;

    @Column(name = "expires_at", nullable = false)
    private Instant expiresAt;

    @Column(name = "used")
    @Builder.Default
    private boolean used = false;

    /**
     * Session correlation ID (UUID v7) generated when this OTP is created.
     * Carried through to the JWT {@code jti} claim on successful verification,
     * linking OTP_REQUESTED → OTP_VERIFIED → all authenticated actions → USER_LOGOUT
     * under one traceable session in {@code audit_log}.
     */
    @Column(name = "session_id")
    private UUID sessionId;
}
