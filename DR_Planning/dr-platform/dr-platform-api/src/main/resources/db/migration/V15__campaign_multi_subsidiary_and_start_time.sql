-- V15: Campaign multi-subsidiary support and preferred start time
-- Aligns backend with frontend: campaigns can span multiple subsidiaries,
-- and can have a preferred DR start time (e.g. "22:00")

-- 1. Create junction table for campaign ↔ subsidiaries (many-to-many)
CREATE TABLE IF NOT EXISTS campaign_subsidiaries (
    campaign_id    UUID        NOT NULL REFERENCES campaigns(id) ON DELETE CASCADE,
    subsidiary_id  VARCHAR(10) NOT NULL,
    PRIMARY KEY (campaign_id, subsidiary_id)
);

CREATE INDEX IF NOT EXISTS idx_campaign_subsidiaries_campaign
    ON campaign_subsidiaries(campaign_id);

CREATE INDEX IF NOT EXISTS idx_campaign_subsidiaries_subsidiary
    ON campaign_subsidiaries(subsidiary_id);

-- 2. Migrate existing single subsidiary_id rows into the junction table
INSERT INTO campaign_subsidiaries (campaign_id, subsidiary_id)
SELECT id, subsidiary_id
FROM campaigns
WHERE subsidiary_id IS NOT NULL
  AND subsidiary_id <> ''
ON CONFLICT DO NOTHING;

-- 3. Add preferred_start_time column to campaigns (e.g. "22:00" EAT)
ALTER TABLE campaigns
    ADD COLUMN IF NOT EXISTS preferred_start_time VARCHAR(10);

-- 4. Expand the quarter CHECK constraint to allow H1 / H2 (half-year periods)
ALTER TABLE campaigns
    DROP CONSTRAINT IF EXISTS campaigns_quarter_check;

ALTER TABLE campaigns
    ADD CONSTRAINT campaigns_quarter_check
    CHECK (quarter IN ('Q1', 'Q2', 'Q3', 'Q4', 'H1', 'H2'));

-- 5. Comments
COMMENT ON TABLE  campaign_subsidiaries                  IS 'Junction table: which subsidiaries participate in each DR campaign';
COMMENT ON COLUMN campaign_subsidiaries.subsidiary_id    IS 'Two-letter country code: KE, UG, TZ, RW, SS, CD, ET';
COMMENT ON COLUMN campaigns.preferred_start_time         IS 'Preferred DR start time in EAT, 24-hour format (e.g. 22:00)';
