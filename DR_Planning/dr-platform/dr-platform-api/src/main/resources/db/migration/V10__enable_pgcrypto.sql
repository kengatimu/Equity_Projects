-- V10: Enable pgcrypto extension required by gen_uuid_v7()
-- Equity Bank Group — DR Management Platform
--
-- gen_uuid_v7() (created in V9) calls gen_random_bytes(16) which is provided
-- by the pgcrypto extension.  pgcrypto ships with every standard PostgreSQL
-- installation and only needs to be activated for the current database.
-- CREATE EXTENSION IF NOT EXISTS is idempotent — safe to run multiple times.
-- ─────────────────────────────────────────────────────────────────────────────
CREATE EXTENSION IF NOT EXISTS pgcrypto;
