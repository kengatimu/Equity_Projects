-- V13: Application scheduling fields + Shared Resource Registry
-- DR Management Platform — Equity Bank Group
--
-- Two additions:
--
-- 1. Scheduling metadata on applications (maps to the Excel tracker columns:
--    Schedule H1/H2, Quarter, preferred DR month/time, interdependency flag).
--
-- 2. shared_resources table — the CMDB-lite canonical registry for shared
--    infrastructure (databases, middleware, network, APIs).
--    Problem solved: free-text resource names lead to duplicates (omni_db vs
--    omni_database). Canonical codes (e.g. ORACLE_OMNI_PROD) are unique
--    case-insensitively at the DB level. Dependencies reference shared_resource_id
--    (UUID FK) rather than a mutable text field.

-- ─── 1. Application scheduling fields ────────────────────────────────────────

ALTER TABLE applications
    ADD COLUMN IF NOT EXISTS schedule_half        VARCHAR(2),   -- H1 or H2
    ADD COLUMN IF NOT EXISTS dr_quarter           VARCHAR(3),   -- Q1 | Q2 | Q3 | Q4
    ADD COLUMN IF NOT EXISTS preferred_dr_month   VARCHAR(20),  -- January … December
    ADD COLUMN IF NOT EXISTS preferred_dr_time    VARCHAR(10),  -- e.g. 10:00 PM
    ADD COLUMN IF NOT EXISTS has_interdependency  BOOLEAN NOT NULL DEFAULT false;

COMMENT ON COLUMN applications.schedule_half       IS 'Which half of the year this application is typically scheduled for DR (H1 = Jan–Jun, H2 = Jul–Dec)';
COMMENT ON COLUMN applications.dr_quarter          IS 'Preferred DR quarter within the half (Q1–Q4)';
COMMENT ON COLUMN applications.preferred_dr_month  IS 'Preferred calendar month for DR execution';
COMMENT ON COLUMN applications.preferred_dr_time   IS 'Preferred start time for War Room (e.g. 10:00 PM)';
COMMENT ON COLUMN applications.has_interdependency IS 'True when this application has known interdependencies with other applications in the same DR window';

-- ─── 2. Shared Resource Registry ─────────────────────────────────────────────
--
-- Each row represents one canonical shared infrastructure resource.
-- code is the unique key: ORACLE_OMNI_PROD, KAFKA_PROD, ACTIVEMQ, etc.
-- Enforced case-insensitively so "oracle_omni_prod" and "ORACLE_OMNI_PROD"
-- cannot coexist.

CREATE TABLE IF NOT EXISTS shared_resources (
    id            UUID         PRIMARY KEY DEFAULT gen_uuid_v7(),
    code          VARCHAR(50)  NOT NULL,         -- canonical ID e.g. ORACLE_OMNI_PROD
    name          VARCHAR(200) NOT NULL,         -- display name
    resource_type VARCHAR(50)  NOT NULL,         -- DATABASE | MIDDLEWARE | NETWORK | API | AUTH | DNS | VPN | OTHER
    description   TEXT,
    host          TEXT,                          -- primary host/connection string (informational)
    environment   VARCHAR(20)  NOT NULL DEFAULT 'PRODUCTION',
    is_active     BOOLEAN      NOT NULL DEFAULT true,
    created_at    TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

-- Case-insensitive uniqueness: prevents ORACLE_OMNI_PROD and oracle_omni_prod
CREATE UNIQUE INDEX IF NOT EXISTS uidx_shared_resources_code
    ON shared_resources(UPPER(code));

CREATE INDEX IF NOT EXISTS idx_shared_resources_type
    ON shared_resources(resource_type, is_active);

COMMENT ON TABLE  shared_resources         IS 'CMDB-lite: canonical shared infrastructure resources. Code is the single unique identifier across all subsidiaries.';
COMMENT ON COLUMN shared_resources.code    IS 'Canonical UPPERCASE_SNAKE identifier. DB unique. Prevents omni_db vs omni_database duplicates.';

-- ─── 3. Link dependencies table to the registry ───────────────────────────────
--
-- Nullable so existing dependency rows remain valid.
-- New dependencies created through the Dependency Engine UI will reference
-- shared_resource_id; the legacy resource_name text column is kept for rows
-- migrated from Excel before the registry was populated.

ALTER TABLE dependencies
    ADD COLUMN IF NOT EXISTS shared_resource_id UUID REFERENCES shared_resources(id) ON DELETE SET NULL;

CREATE INDEX IF NOT EXISTS idx_deps_shared_resource
    ON dependencies(shared_resource_id)
    WHERE shared_resource_id IS NOT NULL;

COMMENT ON COLUMN dependencies.shared_resource_id IS 'FK to shared_resources. When set, this is the authoritative link and resource_name is derived from it.';
