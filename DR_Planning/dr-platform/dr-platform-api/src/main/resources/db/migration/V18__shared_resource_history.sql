-- V18: Shared Resource History
-- When a shared resource is archived it moves here (hard-delete from shared_resources)
-- Pattern mirrors application_history.

CREATE TABLE IF NOT EXISTS shared_resource_history (
    id                  UUID         PRIMARY KEY,
    code                VARCHAR(50)  NOT NULL,
    name                VARCHAR(200) NOT NULL,
    resource_type       VARCHAR(50)  NOT NULL,
    description         TEXT,
    host                TEXT,
    environment         VARCHAR(20)  NOT NULL DEFAULT 'PRODUCTION',
    archived_at         TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    archived_by_id      UUID         REFERENCES users(id) ON DELETE SET NULL,
    archived_by_email   VARCHAR(200),
    original_created_at TIMESTAMPTZ
);

CREATE INDEX IF NOT EXISTS idx_sr_history_archived_at
    ON shared_resource_history(archived_at DESC);
