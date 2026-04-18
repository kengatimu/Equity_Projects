-- ============================================================
-- V16: Application archive history + dependency active flag
-- ============================================================

-- Archive table: full copy of applications row + who/when archived
CREATE TABLE application_history (
    id                     UUID        NOT NULL,
    code                   VARCHAR(100) NOT NULL,
    name                   VARCHAR(200) NOT NULL,
    tier                   VARCHAR(5)  NOT NULL,
    subsidiary_id          VARCHAR(10) NOT NULL,
    has_dr                 BOOLEAN     NOT NULL DEFAULT FALSE,
    dc_endpoint            TEXT,
    dr_endpoint            TEXT,
    dc_servers             JSONB,
    dr_servers             JSONB,
    tech_owner_id          UUID,
    business_owner         VARCHAR(200),
    business_owner_email   VARCHAR(200),
    tech_owner_name        VARCHAR(200),
    tech_owner_email       VARCHAR(200),
    description            TEXT,
    direct_customer_impact BOOLEAN     NOT NULL DEFAULT FALSE,
    has_dependency         BOOLEAN     NOT NULL DEFAULT FALSE,
    dr_capability          VARCHAR(50),
    vendor                 VARCHAR(100),
    notes                  TEXT,
    schedule_half          VARCHAR(2),
    dr_quarter             VARCHAR(3),
    preferred_dr_month     VARCHAR(20),
    preferred_dr_time      VARCHAR(10),
    has_interdependency    BOOLEAN     NOT NULL DEFAULT FALSE,
    original_created_at    TIMESTAMPTZ,
    original_updated_at    TIMESTAMPTZ,
    archived_at            TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    archived_by_id         UUID,
    archived_by_email      VARCHAR(200),
    PRIMARY KEY (id)
);

-- Index for looking up history by code or who archived
CREATE INDEX idx_app_history_code     ON application_history (code);
CREATE INDEX idx_app_history_archived ON application_history (archived_at DESC);

-- Add isActive flag to dependencies (soft-deactivate without removing)
ALTER TABLE dependencies
    ADD COLUMN IF NOT EXISTS is_active BOOLEAN NOT NULL DEFAULT TRUE;

CREATE INDEX idx_dep_active ON dependencies (application_id, is_active);
