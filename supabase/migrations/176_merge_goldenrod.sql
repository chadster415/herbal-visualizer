-- Merge duplicate Goldenrod entries.
-- ID 58  (Solidago virgaurea): all real data — 6 primary actions, 7 secondary, 8 constituents, prescriptions, 6 constituent_profiles
-- ID 2420 (Solidago spp.): only 1 primary action (Organ Affinity / Urinary), nothing else
-- Keep ID 58 (specific species name); move Organ Affinity action across; delete 2420.

SET search_path TO herbal, public;

DO $$
BEGIN
  -- Move Organ Affinity / Urinary from 2420 → 58 (no conflict on ID 58)
  DELETE FROM herbal.herb_primary_actions
  WHERE herb_id = 2420
    AND (primary_action_id, body_system_id) IN (
      SELECT primary_action_id, body_system_id FROM herbal.herb_primary_actions WHERE herb_id = 58
    );
  UPDATE herbal.herb_primary_actions SET herb_id = 58 WHERE herb_id = 2420;

  -- Delete the duplicate row
  DELETE FROM herbal.herbs WHERE id = 2420;

  RAISE NOTICE 'Merged Goldenrod: deleted id 2420 (Solidago spp.), consolidated into id 58 (Solidago virgaurea)';
END $$;
