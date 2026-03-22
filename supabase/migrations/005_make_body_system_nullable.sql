-- Make body_system_id nullable to allow herbs without specific body system affinities
ALTER TABLE herbal.herb_primary_actions
ALTER COLUMN body_system_id DROP NOT NULL;

-- Update the unique constraint to handle NULL values properly
-- Drop the existing constraint
ALTER TABLE herbal.herb_primary_actions
DROP CONSTRAINT IF EXISTS herb_primary_actions_herb_id_primary_action_id_body_system__key;

-- Add it back (PostgreSQL handles NULL values in unique constraints properly)
ALTER TABLE herbal.herb_primary_actions
ADD CONSTRAINT herb_primary_actions_herb_id_primary_action_id_body_system__key
UNIQUE (herb_id, primary_action_id, body_system_id);

COMMENT ON COLUMN herbal.herb_primary_actions.body_system_id IS 'Body system affected (NULL if no specific body system affinity)';
