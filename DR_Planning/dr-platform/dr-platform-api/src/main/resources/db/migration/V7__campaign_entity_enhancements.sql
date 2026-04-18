-- V7: Align entity columns with Phase 1 service layer requirements
-- Campaigns: add planned_dr_date, activity_type, description, lifecycle timestamps

ALTER TABLE campaigns
    ADD COLUMN IF NOT EXISTS planned_dr_date      DATE,
    ADD COLUMN IF NOT EXISTS activity_type        VARCHAR(50),
    ADD COLUMN IF NOT EXISTS description          TEXT,
    ADD COLUMN IF NOT EXISTS pre_dr_opened_at     TIMESTAMP,
    ADD COLUMN IF NOT EXISTS approved_at          TIMESTAMP;

-- Convert status column to use enum values (already string-based, just add constraint)
ALTER TABLE campaigns
    DROP CONSTRAINT IF EXISTS chk_campaign_status;
ALTER TABLE campaigns
    ADD CONSTRAINT chk_campaign_status
    CHECK (status IN ('DRAFT','PRE_DR_OPEN','APPROVED','IN_PROGRESS','COMPLETED','CANCELLED'));

-- Campaign Applications: replace scheduledDate→drDate, add war_room_location, notes, deferral_reason
ALTER TABLE campaign_applications
    ADD COLUMN IF NOT EXISTS dr_date              DATE,
    ADD COLUMN IF NOT EXISTS war_room_location    VARCHAR(300),
    ADD COLUMN IF NOT EXISTS deferral_reason      TEXT,
    ADD COLUMN IF NOT EXISTS updated_at           TIMESTAMP DEFAULT NOW();

-- Back-fill dr_date from scheduled_date if it exists
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM information_schema.columns
               WHERE table_name='campaign_applications' AND column_name='scheduled_date') THEN
        UPDATE campaign_applications SET dr_date = scheduled_date WHERE dr_date IS NULL;
    END IF;
END$$;

-- Drop old columns that are now replaced
ALTER TABLE campaign_applications
    DROP COLUMN IF EXISTS scheduled_date,
    DROP COLUMN IF EXISTS scheduled_time,
    DROP COLUMN IF EXISTS rto_target_minutes,
    DROP COLUMN IF EXISTS war_room_group_id;

-- Rename notes column if it doesn't exist yet
ALTER TABLE campaign_applications
    ADD COLUMN IF NOT EXISTS notes TEXT;

ALTER TABLE campaign_applications
    DROP CONSTRAINT IF EXISTS chk_ca_status;
ALTER TABLE campaign_applications
    ADD CONSTRAINT chk_ca_status
    CHECK (status IN ('PLANNED','PRE_DR_OPEN','APPROVED','IN_EXECUTION','VALIDATION',
                      'COMPLETED','ROLLED_BACK','DEFERRED','CANCELLED'));

-- Checklist Items: add lifecycle tracking columns
ALTER TABLE checklist_items
    ADD COLUMN IF NOT EXISTS carried_forward_at  TIMESTAMP,
    ADD COLUMN IF NOT EXISTS acknowledged_by_id  UUID,
    ADD COLUMN IF NOT EXISTS acknowledged_at     TIMESTAMP,
    ADD COLUMN IF NOT EXISTS completed_by_id     UUID,
    ADD COLUMN IF NOT EXISTS completed_at        TIMESTAMP;

-- Rename description to notes if needed (entity uses 'notes' now)
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM information_schema.columns
               WHERE table_name='checklist_items' AND column_name='description')
    AND NOT EXISTS (SELECT 1 FROM information_schema.columns
               WHERE table_name='checklist_items' AND column_name='notes') THEN
        ALTER TABLE checklist_items RENAME COLUMN description TO notes;
    ELSIF EXISTS (SELECT 1 FROM information_schema.columns
               WHERE table_name='checklist_items' AND column_name='description') THEN
        -- Both exist, migrate data then drop old
        UPDATE checklist_items SET notes = description WHERE notes IS NULL AND description IS NOT NULL;
        ALTER TABLE checklist_items DROP COLUMN description;
    END IF;
END$$;

-- Remove columns no longer in entity
ALTER TABLE checklist_items
    DROP COLUMN IF EXISTS owner_user_id,
    DROP COLUMN IF EXISTS due_date,
    DROP COLUMN IF EXISTS blocker_description;

ALTER TABLE checklist_items
    DROP CONSTRAINT IF EXISTS chk_checklist_status;
ALTER TABLE checklist_items
    ADD CONSTRAINT chk_checklist_status
    CHECK (status IN ('PENDING','IN_PROGRESS','DONE','BLOCKED','CARRIED_FORWARD','VERIFIED'));

-- Checklist Blockers: add severity, escalated_to, rename resolved_notes→resolution_notes
ALTER TABLE checklist_blockers
    ADD COLUMN IF NOT EXISTS severity        VARCHAR(20) DEFAULT 'MEDIUM',
    ADD COLUMN IF NOT EXISTS escalated_to    VARCHAR(200),
    ADD COLUMN IF NOT EXISTS resolution_notes TEXT;

-- Migrate resolved_notes → resolution_notes
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM information_schema.columns
               WHERE table_name='checklist_blockers' AND column_name='resolved_notes') THEN
        UPDATE checklist_blockers SET resolution_notes = resolved_notes WHERE resolution_notes IS NULL;
        ALTER TABLE checklist_blockers DROP COLUMN resolved_notes;
    END IF;
END$$;

-- Change resolved_at to TIMESTAMP (was TIMESTAMPTZ)
ALTER TABLE checklist_blockers
    ALTER COLUMN resolved_at TYPE TIMESTAMP USING resolved_at::TIMESTAMP;

-- Pre-DR Signoffs: add coordinator_acknowledged_by_id, change column types to TIMESTAMP
ALTER TABLE pre_dr_signoffs
    ADD COLUMN IF NOT EXISTS coordinator_acknowledged_by_id UUID;

ALTER TABLE pre_dr_signoffs
    ALTER COLUMN submitted_at TYPE TIMESTAMP USING submitted_at::TIMESTAMP,
    ALTER COLUMN coordinator_acknowledged_at TYPE TIMESTAMP USING coordinator_acknowledged_at::TIMESTAMP;

-- Drop old coordinator_id column (replaced by coordinator_acknowledged_by_id)
ALTER TABLE pre_dr_signoffs DROP COLUMN IF EXISTS coordinator_id;

-- Indexes for new columns
CREATE INDEX IF NOT EXISTS idx_campaign_planned_dr ON campaigns (planned_dr_date);
CREATE INDEX IF NOT EXISTS idx_ca_dr_date ON campaign_applications (dr_date);
CREATE INDEX IF NOT EXISTS idx_ca_status ON campaign_applications (status);
CREATE INDEX IF NOT EXISTS idx_blocker_severity ON checklist_blockers (severity) WHERE resolved_at IS NULL;

COMMENT ON COLUMN campaigns.planned_dr_date IS 'The planned DR execution date for the campaign';
COMMENT ON COLUMN campaigns.activity_type IS 'DR activity type: FULL_FAILOVER, APP_ONLY, etc.';
COMMENT ON COLUMN campaign_applications.dr_date IS 'Specific DR date for this application (may differ from campaign)';
COMMENT ON COLUMN campaign_applications.deferral_reason IS 'Reason provided when application is deferred to next cycle';
COMMENT ON COLUMN checklist_blockers.severity IS 'Blocker severity: LOW, MEDIUM, HIGH, CRITICAL';
