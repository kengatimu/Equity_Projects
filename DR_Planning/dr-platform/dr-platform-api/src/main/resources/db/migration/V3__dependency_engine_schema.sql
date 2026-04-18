-- V3: Dependency Engine
-- Week 3 — DR Management Platform — Equity Bank Group

CREATE TABLE IF NOT EXISTS dependencies (
    id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    application_id    UUID NOT NULL REFERENCES applications(id),
    depends_on_id     UUID REFERENCES applications(id),
    dependency_type   VARCHAR(50) NOT NULL,
    is_shared         BOOLEAN DEFAULT false,
    resource_name     VARCHAR(200),
    description       TEXT,
    created_at        TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(application_id, resource_name)
);

CREATE INDEX IF NOT EXISTS idx_deps_app      ON dependencies(application_id);
CREATE INDEX IF NOT EXISTS idx_deps_shared   ON dependencies(resource_name, is_shared);

CREATE TABLE IF NOT EXISTS dependency_groups (
    id                    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name                  VARCHAR(200) NOT NULL,
    shared_resource_name  VARCHAR(200) NOT NULL,
    shared_resource_type  VARCHAR(50) NOT NULL,
    created_at            TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS dependency_group_members (
    group_id        UUID NOT NULL REFERENCES dependency_groups(id) ON DELETE CASCADE,
    application_id  UUID NOT NULL REFERENCES applications(id),
    PRIMARY KEY (group_id, application_id)
);

CREATE INDEX IF NOT EXISTS idx_dgm_group ON dependency_group_members(group_id);
CREATE INDEX IF NOT EXISTS idx_dgm_app   ON dependency_group_members(application_id);

CREATE TABLE IF NOT EXISTS campaign_conflicts (
    id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    campaign_id       UUID NOT NULL,
    conflict_type     VARCHAR(50) NOT NULL,
    application_ids   UUID[] NOT NULL,
    description       TEXT NOT NULL,
    recommendation    TEXT,
    resolution        VARCHAR(50),
    resolution_reason TEXT,
    resolved_by_id    UUID REFERENCES users(id),
    resolved_at       TIMESTAMPTZ,
    created_at        TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_conflicts_campaign ON campaign_conflicts(campaign_id);
