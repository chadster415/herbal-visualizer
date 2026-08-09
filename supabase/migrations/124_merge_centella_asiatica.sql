SET search_path TO herbal, public;

-- Merge duplicate Centella asiatica entries.
-- ID 2229 (Aerial parts) is the established entry — keep it.
-- ID 2256 (no plant_part, created by migration 119) is the stray — merge and delete.

DO $$
DECLARE
  v_old_id  CONSTANT INTEGER := 2256; -- Centella asiatica, no plant_part
  v_keep_id CONSTANT INTEGER := 2229; -- Centella asiatica, Aerial parts
BEGIN
  -- herb_primary_actions: copy any rows that don't already exist, then remove old
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT v_keep_id, primary_action_id, body_system_id
  FROM herbal.herb_primary_actions WHERE herb_id = v_old_id
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  DELETE FROM herbal.herb_primary_actions WHERE herb_id = v_old_id;

  -- disorder_action_herbs: drop any rows that would conflict, then re-point the rest
  DELETE FROM herbal.disorder_action_herbs AS old_row
  WHERE herb_id = v_old_id
    AND EXISTS (
      SELECT 1 FROM herbal.disorder_action_herbs AS new_row
      WHERE new_row.herb_id = v_keep_id
        AND new_row.disorder_id = old_row.disorder_id
        AND new_row.primary_action_id = old_row.primary_action_id
    );

  UPDATE herbal.disorder_action_herbs SET herb_id = v_keep_id WHERE herb_id = v_old_id;

  -- prescription_herbs: drop conflicts, then re-point
  DELETE FROM herbal.prescription_herbs AS old_row
  WHERE herb_id = v_old_id
    AND EXISTS (
      SELECT 1 FROM herbal.prescription_herbs AS new_row
      WHERE new_row.herb_id = v_keep_id
        AND new_row.prescription_id = old_row.prescription_id
    );

  UPDATE herbal.prescription_herbs SET herb_id = v_keep_id WHERE herb_id = v_old_id;

  -- Delete the stray herb row
  DELETE FROM herbal.herbs WHERE id = v_old_id;

  RAISE NOTICE 'Merged Centella asiatica id=% (no plant_part) into id=% (Aerial parts)', v_old_id, v_keep_id;
END $$;
