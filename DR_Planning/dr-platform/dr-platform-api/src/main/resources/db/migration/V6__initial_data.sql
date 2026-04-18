-- V6: Initial Seed Data
-- DR Management Platform — Equity Bank Group

-- Platform Admin + Coordinator: kennedy.gatimu@equitybank.co.ke (SUPER_ADMIN covers all coordinator ops)
INSERT INTO users (id, email, display_name, role, subsidiary_id, is_active, created_at)
VALUES (
    gen_random_uuid(),
    'kennedy.gatimu@equitybank.co.ke',
    'Kennedy Gatimu',
    'SUPER_ADMIN',
    'KE',
    true,
    NOW()
) ON CONFLICT (email) DO NOTHING;

-- Test App Owner (dev/UAT — gmail.com allowed via allowed-domains config)
INSERT INTO users (id, email, display_name, role, subsidiary_id, is_active, created_at)
VALUES (
    gen_random_uuid(),
    'kengatimu@gmail.com',
    'Kennedy Gatimu (Test)',
    'APP_OWNER',
    'KE',
    true,
    NOW()
) ON CONFLICT (email) DO NOTHING;

-- Subsidiary reference data (informational — used for validation in app)
-- KE=Kenya, TZ=Tanzania, UG=Uganda, RW=Rwanda, DRC=DR Congo, SS=South Sudan, GROUP=Group Level
COMMENT ON COLUMN users.subsidiary_id IS 'KE | TZ | UG | RW | DRC | SS | GROUP';
COMMENT ON COLUMN applications.tier IS 'T1=Mission Critical, T2=Business Important, T3=Standard';
COMMENT ON COLUMN campaign_applications.dr_activity_type IS
    'FULL_FAILOVER | APP_ONLY | DB_ONLY | APP_REPOINT | PARTIAL | ACTIVE_ACTIVE | ROLLBACK_DRILL | COLD_STANDBY | TABLETOP | EXTENDED_OPS';
