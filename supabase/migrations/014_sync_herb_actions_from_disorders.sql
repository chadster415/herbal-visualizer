-- Sync herb_primary_actions from disorder_action_herbs
-- This migration fills gaps in herb_primary_actions by finding all unique
-- herb-action pairs from disorder contexts and adding them to the general catalog

SET search_path TO herbal, public;

-- Insert missing herb-action pairs from disorder_action_herbs into herb_primary_actions
-- We'll leave body_system_id NULL since these are general actions not specific to a system
INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
SELECT DISTINCT
  dah.herb_id,
  dah.primary_action_id,
  NULL::integer as body_system_id
FROM herbal.disorder_action_herbs dah
WHERE NOT EXISTS (
  -- Only insert if this herb-action pair doesn't already exist
  SELECT 1 FROM herbal.herb_primary_actions hpa
  WHERE hpa.herb_id = dah.herb_id
    AND hpa.primary_action_id = dah.primary_action_id
)
ORDER BY dah.herb_id, dah.primary_action_id;

-- Summary: Show how many herb-action pairs were added
DO $$
DECLARE
  v_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO v_count
  FROM herbal.herb_primary_actions
  WHERE body_system_id IS NULL;

  RAISE NOTICE 'Total herb-action pairs synced: %', v_count;
  RAISE NOTICE 'These pairs now appear in the "By Action" view';
END $$;
