-- V5: Pre-DR Checklist Engine
-- Week 5 — DR Management Platform — Equity Bank Group

CREATE TABLE IF NOT EXISTS checklist_items (
    id                        UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    campaign_application_id   UUID NOT NULL REFERENCES campaign_applications(id) ON DELETE CASCADE,
    title                     VARCHAR(300) NOT NULL,
    description               TEXT,
    owner_user_id             UUID REFERENCES users(id),
    due_date                  DATE,
    status                    VARCHAR(30) DEFAULT 'PENDING',
    notes                     TEXT,
    blocker_description       TEXT,
    carried_forward_from_id   UUID REFERENCES checklist_items(id),
    is_auto_generated         BOOLEAN DEFAULT false,
    sort_order                INT DEFAULT 0,
    created_at                TIMESTAMPTZ DEFAULT NOW(),
    updated_at                TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_checklist_campaign_app ON checklist_items(campaign_application_id);
CREATE INDEX IF NOT EXISTS idx_checklist_status       ON checklist_items(status);
CREATE INDEX IF NOT EXISTS idx_checklist_owner        ON checklist_items(owner_user_id);
CREATE INDEX IF NOT EXISTS idx_checklist_carried      ON checklist_items(carried_forward_from_id)
    WHERE carried_forward_from_id IS NOT NULL;

CREATE TABLE IF NOT EXISTS checklist_blockers (
    id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    checklist_item_id UUID NOT NULL REFERENCES checklist_items(id) ON DELETE CASCADE,
    description       TEXT NOT NULL,
    raised_by_id      UUID REFERENCES users(id),
    resolved_by_id    UUID REFERENCES users(id),
    resolved_at       TIMESTAMPTZ,
    resolved_notes    TEXT,
    created_at        TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_blockers_item ON checklist_blockers(checklist_item_id);

CREATE TABLE IF NOT EXISTS pre_dr_signoffs (
    id                            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    campaign_application_id       UUID UNIQUE REFERENCES campaign_applications(id) ON DELETE CASCADE,
    submitted_by_id               UUID REFERENCES users(id),
    submitted_at                  TIMESTAMPTZ,
    coordinator_acknowledged_at   TIMESTAMPTZ,
    coordinator_id                UUID REFERENCES users(id),
    notes                         TEXT,
    created_at                    TIMESTAMPTZ DEFAULT NOW()
);
