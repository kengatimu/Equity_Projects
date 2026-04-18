-- V1: Auth, User Management & Audit Foundation
-- Week 1 — DR Management Platform — Equity Bank Group

CREATE TABLE IF NOT EXISTS users (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    ldap_dn             VARCHAR(500),
    email               VARCHAR(200) UNIQUE NOT NULL,
    display_name        VARCHAR(200) NOT NULL,
    role                VARCHAR(50) NOT NULL,
    subsidiary_id       VARCHAR(10) NOT NULL,
    line_manager_email  VARCHAR(200),
    is_active           BOOLEAN DEFAULT true,
    last_login          TIMESTAMPTZ,
    created_at          TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS refresh_tokens (
    id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id      UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    token_hash   VARCHAR(64) NOT NULL,
    expires_at   TIMESTAMPTZ NOT NULL,
    revoked      BOOLEAN DEFAULT false,
    device_info  TEXT,
    created_at   TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_refresh_tokens_user ON refresh_tokens(user_id, revoked);
CREATE INDEX IF NOT EXISTS idx_refresh_tokens_hash ON refresh_tokens(token_hash);

-- CRITICAL: GRANT INSERT, SELECT ONLY on audit_log — no UPDATE, no DELETE
-- Run after initial setup as superuser:
-- REVOKE UPDATE, DELETE ON audit_log FROM dr_platform_user;
CREATE TABLE IF NOT EXISTS audit_log (
    id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    actor_id         UUID,
    actor_ip         VARCHAR(45),
    actor_role       VARCHAR(50),
    action           VARCHAR(100) NOT NULL,
    resource_type    VARCHAR(100),
    resource_id      UUID,
    campaign_id      UUID,
    subsidiary_id    VARCHAR(10),
    before_state     JSONB,
    after_state      JSONB,
    session_id       VARCHAR(100),
    user_agent       TEXT,
    timestamp        TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_audit_log_actor    ON audit_log(actor_id, timestamp DESC);
CREATE INDEX IF NOT EXISTS idx_audit_log_campaign ON audit_log(campaign_id, timestamp DESC);
CREATE INDEX IF NOT EXISTS idx_audit_log_resource ON audit_log(resource_type, resource_id);
CREATE INDEX IF NOT EXISTS idx_audit_log_ts       ON audit_log(timestamp DESC);
