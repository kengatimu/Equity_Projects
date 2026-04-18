-- V9: UUID v7 (time-ordered) for all tables + timestamp consistency
-- Equity Bank Group — DR Management Platform

-- ─────────────────────────────────────────────────────────────────────────────
-- 1. gen_uuid_v7() — PostgreSQL function for time-ordered UUID v7 (RFC 9562)
--    Layout: [48-bit unix_ms][4-bit ver=7][12-bit rand_a][2-bit var=10][62-bit rand_b]
--    Stored as standard uuid type (16 bytes binary) — no extra space vs v4.
-- ─────────────────────────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION gen_uuid_v7() RETURNS uuid
LANGUAGE plpgsql
AS $$
DECLARE
    ts_ms BIGINT := floor(extract(epoch from clock_timestamp()) * 1000)::BIGINT;
    b     BYTEA  := gen_random_bytes(16);
BEGIN
    -- Bytes 0-5: 48-bit Unix timestamp (milliseconds, big-endian)
    b := set_byte(b, 0, (ts_ms >> 40) & 255);
    b := set_byte(b, 1, (ts_ms >> 32) & 255);
    b := set_byte(b, 2, (ts_ms >> 24) & 255);
    b := set_byte(b, 3, (ts_ms >> 16) & 255);
    b := set_byte(b, 4, (ts_ms >>  8) & 255);
    b := set_byte(b, 5,  ts_ms        & 255);
    -- Byte 6: version nibble = 0x7 in high 4 bits, keep 4 random bits in low nibble
    b := set_byte(b, 6, (get_byte(b, 6) & x'0f'::int) | x'70'::int);
    -- Byte 8: variant = 0b10 in high 2 bits, keep 6 random bits in remaining bits
    b := set_byte(b, 8, (get_byte(b, 8) & x'3f'::int) | x'80'::int);
    RETURN encode(b, 'hex')::uuid;
END;
$$;

-- ─────────────────────────────────────────────────────────────────────────────
-- 2. Switch all table PK defaults from gen_random_uuid() to gen_uuid_v7()
--    Existing rows are unaffected; only new inserts use v7.
-- ─────────────────────────────────────────────────────────────────────────────
ALTER TABLE users                  ALTER COLUMN id SET DEFAULT gen_uuid_v7();
ALTER TABLE refresh_tokens         ALTER COLUMN id SET DEFAULT gen_uuid_v7();
ALTER TABLE audit_log              ALTER COLUMN id SET DEFAULT gen_uuid_v7();
ALTER TABLE applications           ALTER COLUMN id SET DEFAULT gen_uuid_v7();
ALTER TABLE dependencies           ALTER COLUMN id SET DEFAULT gen_uuid_v7();
ALTER TABLE dependency_groups      ALTER COLUMN id SET DEFAULT gen_uuid_v7();
ALTER TABLE campaign_conflicts     ALTER COLUMN id SET DEFAULT gen_uuid_v7();
ALTER TABLE campaigns              ALTER COLUMN id SET DEFAULT gen_uuid_v7();
ALTER TABLE campaign_applications  ALTER COLUMN id SET DEFAULT gen_uuid_v7();
ALTER TABLE checklist_items        ALTER COLUMN id SET DEFAULT gen_uuid_v7();
ALTER TABLE checklist_blockers     ALTER COLUMN id SET DEFAULT gen_uuid_v7();
ALTER TABLE pre_dr_signoffs        ALTER COLUMN id SET DEFAULT gen_uuid_v7();
ALTER TABLE email_otps             ALTER COLUMN id SET DEFAULT gen_uuid_v7();

-- ─────────────────────────────────────────────────────────────────────────────
-- 3. Timestamp consistency fixes
-- ─────────────────────────────────────────────────────────────────────────────

-- users: add missing updated_at
ALTER TABLE users
    ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT NOW();

-- dependencies: add missing updated_at
ALTER TABLE dependencies
    ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT NOW();

-- dependency_groups: add missing updated_at
ALTER TABLE dependency_groups
    ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT NOW();

-- dependency_group_members: add both timestamps (was missing entirely)
ALTER TABLE dependency_group_members
    ADD COLUMN IF NOT EXISTS created_at TIMESTAMPTZ DEFAULT NOW(),
    ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT NOW();

-- campaign_applications: fix updated_at type TIMESTAMP → TIMESTAMPTZ (V7 used wrong type)
ALTER TABLE campaign_applications
    ALTER COLUMN updated_at TYPE TIMESTAMPTZ USING updated_at AT TIME ZONE 'UTC';

-- ─────────────────────────────────────────────────────────────────────────────
-- 4. Backfill updated_at = created_at for all existing rows where it is null
-- ─────────────────────────────────────────────────────────────────────────────
UPDATE users                 SET updated_at = created_at WHERE updated_at IS NULL;
UPDATE dependencies          SET updated_at = created_at WHERE updated_at IS NULL;
UPDATE dependency_groups     SET updated_at = created_at WHERE updated_at IS NULL;
UPDATE dependency_group_members SET updated_at = created_at WHERE updated_at IS NULL;
