SET search_path TO herbal, public;

-- Merge duplicate Paeonia lactiflora entries and rename to White Peony.
-- ID 2238 (common_name='Peony', plant_part='Root') is the established entry — keep it.
-- ID 2261 (common_name='White Peony', no plant_part, created by case study migrations) — merge and delete.
-- After merge, rename 2238 common_name to 'White Peony'.

DO $$
DECLARE
  v_old_id  CONSTANT INTEGER := 2261; -- Paeonia lactiflora, no plant_part (stray)
  v_keep_id CONSTANT INTEGER := 2238; -- Paeonia lactiflora, Root (established)
BEGIN
  -- herb_primary_actions: copy any new rows, then remove old
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT v_keep_id, primary_action_id, body_system_id
  FROM herbal.herb_primary_actions WHERE herb_id = v_old_id
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  DELETE FROM herbal.herb_primary_actions WHERE herb_id = v_old_id;

  -- disorder_action_herbs: drop conflicts, then re-point
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
  -- (prescription_herb_actions reference prescription_herb_id and follow automatically)
  DELETE FROM herbal.prescription_herbs AS old_row
  WHERE herb_id = v_old_id
    AND EXISTS (
      SELECT 1 FROM herbal.prescription_herbs AS new_row
      WHERE new_row.herb_id = v_keep_id
        AND new_row.prescription_id = old_row.prescription_id
    );

  UPDATE herbal.prescription_herbs SET herb_id = v_keep_id WHERE herb_id = v_old_id;

  -- Delete the stray herb
  DELETE FROM herbal.herbs WHERE id = v_old_id;

  -- Rename the kept entry to White Peony
  UPDATE herbal.herbs SET common_name = 'White Peony' WHERE id = v_keep_id;

  RAISE NOTICE 'Merged Paeonia lactiflora id=% into id=%; renamed to White Peony', v_old_id, v_keep_id;
END $$;
