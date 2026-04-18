-- V4: Campaign Manager
-- Week 4 — DR Management Platform — Equity Bank Group

CREATE TABLE IF NOT EXISTS campaigns (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name            VARCHAR(200) NOT NULL,
    quarter         VARCHAR(5) NOT NULL CHECK (quarter IN ('Q1','Q2','Q3','Q4')),
    year            INT NOT NULL,
    subsidiary_id   VARCHAR(10),
    coordinator_id  UUID REFERENCES users(id),
    status          VARCHAR(30) DEFAULT 'DRAFT',
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_campaigns_subsidiary ON campaigns(subsidiary_id, status);
CREATE INDEX IF NOT EXISTS idx_campaigns_year       ON campaigns(year, quarter);

CREATE TABLE IF NOT EXISTS campaign_applications (
    id                        UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    campaign_id               UUID NOT NULL REFERENCES campaigns(id) ON DELETE CASCADE,
    application_id            UUID NOT NULL REFERENCES applications(id),
    dr_activity_type          VARCHAR(50) NOT NULL,
    scheduled_date            DATE NOT NULL,
    scheduled_time            TIME,
    rto_target_minutes        INT NOT NULL,
    war_room_group_id         UUID,
    status                    VARCHAR(30) DEFAULT 'PLANNED',
    runbook_deadline          DATE,
    peer_review_deadline      DATE,
    itscm_approval_deadline   DATE,
    checklist_deadline        DATE,
    created_at                TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(campaign_id, application_id)
);

CREATE INDEX IF NOT EXISTS idx_ca_campaign   ON campaign_applications(campaign_id);
CREATE INDEX IF NOT EXISTS idx_ca_app        ON campaign_applications(application_id);
CREATE INDEX IF NOT EXISTS idx_ca_deadlines  ON campaign_applications(itscm_approval_deadline, status);
CREATE INDEX IF NOT EXISTS idx_ca_date       ON campaign_applications(scheduled_date);
