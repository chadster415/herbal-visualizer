-- Update herb_primary_actions to include body_system_id from disorder context
-- This fixes entries created by migration 014 that have NULL body_system_id

SET search_path TO herbal, public;

-- Update the NULL body_system_id entries with the appropriate body system
-- from the disorder context where we found the herb-action relationship
UPDATE herbal.herb_primary_actions hpa
SET body_system_id = d.body_system_id
FROM herbal.disorder_action_herbs dah
JOIN herbal.disorders d ON dah.disorder_id = d.id
WHERE hpa.herb_id = dah.herb_id
  AND hpa.primary_action_id = dah.primary_action_id
  AND hpa.body_system_id IS NULL;

-- Summary: Show how many entries were updated
DO $$
DECLARE
  v_updated_count INTEGER;
  v_remaining_null INTEGER;
BEGIN
  -- Get count of entries that now have body systems
  SELECT COUNT(*) INTO v_updated_count
  FROM herbal.herb_primary_actions
  WHERE body_system_id IS NOT NULL;

  -- Check if any NULL entries remain
  SELECT COUNT(*) INTO v_remaining_null
  FROM herbal.herb_primary_actions
  WHERE body_system_id IS NULL;

  RAISE NOTICE 'Herb-action pairs with body system context: %', v_updated_count;
  RAISE NOTICE 'Herb-action pairs without body system (general): %', v_remaining_null;
END $$;
