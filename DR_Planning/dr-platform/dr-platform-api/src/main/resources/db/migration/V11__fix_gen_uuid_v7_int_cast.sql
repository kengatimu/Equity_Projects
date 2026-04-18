-- V11: Fix gen_uuid_v7() — explicit ::int casts on set_byte() value arguments
-- Equity Bank Group — DR Management Platform
--
-- PostgreSQL's set_byte(bytea, integer, integer) requires the value argument
-- (3rd param) to be INTEGER.  In V9, ts_ms is declared BIGINT, so bitshift
-- and bitwise-AND expressions like (ts_ms >> 40) & 255 produce BIGINT —
-- causing: "function set_byte(bytea, integer, bigint) does not exist".
--
-- This CREATE OR REPLACE replaces the V9 function body in-place with the same
-- logic but with explicit ::int casts on every ts_ms-derived argument.
-- pgcrypto (needed for gen_random_bytes) was already activated in V10.
-- ─────────────────────────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION gen_uuid_v7() RETURNS uuid
LANGUAGE plpgsql
AS $$
DECLARE
    ts_ms BIGINT := floor(extract(epoch from clock_timestamp()) * 1000)::BIGINT;
    b     BYTEA  := gen_random_bytes(16);
BEGIN
    -- Bytes 0-5: 48-bit Unix timestamp (ms, big-endian).
    -- Cast each BIGINT expression to INTEGER — set_byte requires integer, not bigint.
    b := set_byte(b, 0, ((ts_ms >> 40) & 255)::int);
    b := set_byte(b, 1, ((ts_ms >> 32) & 255)::int);
    b := set_byte(b, 2, ((ts_ms >> 24) & 255)::int);
    b := set_byte(b, 3, ((ts_ms >> 16) & 255)::int);
    b := set_byte(b, 4, ((ts_ms >>  8) & 255)::int);
    b := set_byte(b, 5, ( ts_ms        & 255)::int);
    -- Byte 6: version nibble = 0x7, keep random low nibble (get_byte already returns int)
    b := set_byte(b, 6, ((get_byte(b, 6) & x'0f'::int) | x'70'::int));
    -- Byte 8: variant = 0b10, keep 6 random bits
    b := set_byte(b, 8, ((get_byte(b, 8) & x'3f'::int) | x'80'::int));
    RETURN encode(b, 'hex')::uuid;
END;
$$;
