-- Migration 077: Merge Panax spp. (id 215) into Panax ginseng (id 14)
-- id 14 had 12 stale duplicate profiles (two seed passes, no editorial notes).
-- id 215 has 6 clean profiles from migration 076 with correct subscripts and editorial notes.
-- id 215 had 1 unique action (Nervine Stimulant/Cardiovascular) not on id 14.
-- Result: id 14 renamed to "Ginseng", gains the clean profiles and unique action.

SET search_path TO herbal, public;

DO $$
DECLARE
  v_keep_id  INTEGER := 14;  -- Panax ginseng (keeper)
  v_drop_id  INTEGER := 215; -- Panax spp. (merged in and deleted)
BEGIN
  -- Rename herb to plain "Ginseng" (was "Korean Ginseng")
  UPDATE herbal.herbs SET common_name = 'Ginseng' WHERE id = v_keep_id;

  -- Remove the 12 stale/duplicate profiles on id 14 (no subscripts, no editorial notes)
  DELETE FROM herbal.constituent_profiles WHERE herb_id = v_keep_id;

  -- Re-point the 6 clean profiles from id 215 to id 14
  UPDATE herbal.constituent_profiles SET herb_id = v_keep_id WHERE herb_id = v_drop_id;

  -- Merge unique primary action: Nervine Stimulant / Cardiovascular
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT v_keep_id, primary_action_id, body_system_id
  FROM herbal.herb_primary_actions WHERE herb_id = v_drop_id
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Delete Panax spp. (remaining FK refs cascade)
  DELETE FROM herbal.herbs WHERE id = v_drop_id;

  RAISE NOTICE 'Ginseng: Panax spp. (215) merged into Panax ginseng (14), renamed to Ginseng, clean profiles applied.';
END $$;
