-- V2: Application Registry
-- Week 2 — DR Management Platform — Equity Bank Group

CREATE TABLE IF NOT EXISTS applications (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code                    VARCHAR(100) UNIQUE NOT NULL,
    name                    VARCHAR(200) NOT NULL,
    tier                    VARCHAR(5) NOT NULL CHECK (tier IN ('T1','T2','T3')),
    subsidiary_id           VARCHAR(10) NOT NULL,
    has_dr                  BOOLEAN DEFAULT false,
    dc_endpoint             TEXT,
    dr_endpoint             TEXT,
    dc_servers              JSONB,
    dr_servers              JSONB,
    tech_owner_id           UUID REFERENCES users(id),
    business_owner          VARCHAR(200),
    description             TEXT,
    direct_customer_impact  BOOLEAN DEFAULT false,
    has_dependency          BOOLEAN DEFAULT false,
    dr_capability           VARCHAR(50),
    vendor                  VARCHAR(100),
    notes                   TEXT,
    is_active               BOOLEAN DEFAULT true,
    created_at              TIMESTAMPTZ DEFAULT NOW(),
    updated_at              TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_apps_subsidiary ON applications(subsidiary_id, is_active);
CREATE INDEX IF NOT EXISTS idx_apps_tier       ON applications(tier, is_active);
CREATE INDEX IF NOT EXISTS idx_apps_owner      ON applications(tech_owner_id);
CREATE INDEX IF NOT EXISTS idx_apps_name       ON applications(name);
