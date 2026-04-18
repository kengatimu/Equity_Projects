-- Add contact details for both owners so coordinators can reach them directly
-- without needing to navigate to a separate Users module.

ALTER TABLE applications
    ADD COLUMN IF NOT EXISTS business_owner_email VARCHAR(200),
    ADD COLUMN IF NOT EXISTS tech_owner_name      VARCHAR(200),
    ADD COLUMN IF NOT EXISTS tech_owner_email     VARCHAR(200);

COMMENT ON COLUMN applications.business_owner_email IS 'Work email of the business-side owner';
COMMENT ON COLUMN applications.tech_owner_name      IS 'Display name of the technical owner (text, pending full user-link)';
COMMENT ON COLUMN applications.tech_owner_email     IS 'Work email of the technical owner';
