-- V8: Email OTP Authentication
-- Replaces LDAP bind for Phase 1; AD SSO will be re-enabled in a later phase.

CREATE TABLE email_otps (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email       VARCHAR(200) NOT NULL,
    otp_hash    VARCHAR(64)  NOT NULL,   -- SHA-256 of the 6-digit code
    expires_at  TIMESTAMPTZ  NOT NULL,
    used        BOOLEAN      DEFAULT false,
    created_at  TIMESTAMPTZ  DEFAULT NOW()
);

CREATE INDEX idx_email_otps_email   ON email_otps(email, used, expires_at);
CREATE INDEX idx_email_otps_cleanup ON email_otps(expires_at);
