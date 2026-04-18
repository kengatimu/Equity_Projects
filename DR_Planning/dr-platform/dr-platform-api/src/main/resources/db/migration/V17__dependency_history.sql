-- ============================================================
-- V17: Dependency archive history table
-- ============================================================

CREATE TABLE dependency_history (
    id                  UUID            NOT NULL,
    application_id      UUID            NOT NULL,
    depends_on_id       UUID,
    dependency_type     VARCHAR(50)     NOT NULL,
    is_shared           BOOLEAN         NOT NULL DEFAULT FALSE,
    resource_name       VARCHAR(200),
    description         TEXT,
    is_active           BOOLEAN         NOT NULL DEFAULT TRUE,
    archived_at         TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    archived_by_id      UUID,
    archived_by_email   VARCHAR(200),
    original_created_at TIMESTAMPTZ,
    PRIMARY KEY (id)
);

CREATE INDEX idx_dep_history_app      ON dependency_history (application_id);
CREATE INDEX idx_dep_history_resource ON dependency_history (resource_name);
CREATE INDEX idx_dep_history_archived ON dependency_history (archived_at DESC);
