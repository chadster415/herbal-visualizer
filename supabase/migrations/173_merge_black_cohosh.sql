-- Merge duplicate Black Cohosh entries.
-- ID 25 (Cimicifuga racemosa / Sheng Ma) holds all real data.
-- ID 2453 (Actaea racemosa) has only 2 primary actions and no other data.
-- After merge, update latin_name to current accepted taxonomy: Actaea racemosa.

SET search_path TO herbal, public;

DO $$
BEGIN
  -- Move the 2 "Organ Affinity" primary actions from 2453 → 25
  -- First remove any that would conflict (none expected, but safe to do)
  DELETE FROM herbal.herb_primary_actions
  WHERE herb_id = 2453
    AND (primary_action_id, body_system_id) IN (
      SELECT primary_action_id, body_system_id FROM herbal.herb_primary_actions WHERE herb_id = 25
    );

  UPDATE herbal.herb_primary_actions SET herb_id = 25 WHERE herb_id = 2453;

  -- Delete the duplicate herb row
  DELETE FROM herbal.herbs WHERE id = 2453;

  -- Update latin name to current accepted taxonomy
  UPDATE herbal.herbs SET latin_name = 'Actaea racemosa' WHERE id = 25;

  RAISE NOTICE 'Merged Black Cohosh: deleted id 2453, updated id 25 latin_name to Actaea racemosa';
END $$;
