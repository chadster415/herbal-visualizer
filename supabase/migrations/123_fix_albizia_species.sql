SET search_path TO herbal, public;

-- Fix: migration 122 used Albizia lebbeck; the correct DB entry is Albizia julibrissin (Silk Tree).
-- This migration re-points all Immune case study references and cleans up the stray herb row.

DO $$
DECLARE
  v_sys_id         INTEGER;
  v_dis_id         INTEGER;
  v_lebbeck_id     INTEGER;
  v_julibrissin_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Immune';
  SELECT id INTO v_dis_id FROM herbal.disorders
  WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  SELECT id INTO v_lebbeck_id FROM herbal.herbs WHERE latin_name = 'Albizia lebbeck';

  -- Ensure the correct herb exists (no-op if already present)
  v_julibrissin_id := herbal.ensure_herb('Albizia julibrissin', 'Silk Tree');

  IF v_lebbeck_id IS NULL THEN
    RAISE NOTICE 'Albizia lebbeck not found — nothing to fix';
    RETURN;
  END IF;

  -- Re-point prescription_herbs for the Immune case study prescriptions
  UPDATE herbal.prescription_herbs
  SET herb_id = v_julibrissin_id
  WHERE herb_id = v_lebbeck_id
    AND prescription_id IN (
      SELECT id FROM herbal.disorder_prescriptions WHERE disorder_id = v_dis_id
    );

  -- Re-point disorder_action_herbs
  UPDATE herbal.disorder_action_herbs
  SET herb_id = v_julibrissin_id
  WHERE herb_id = v_lebbeck_id AND disorder_id = v_dis_id;

  -- Fix herb_primary_actions: copy lebbeck's Immune-system rows to julibrissin, then remove lebbeck's
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT v_julibrissin_id, primary_action_id, body_system_id
  FROM herbal.herb_primary_actions
  WHERE herb_id = v_lebbeck_id AND body_system_id = v_sys_id
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  DELETE FROM herbal.herb_primary_actions
  WHERE herb_id = v_lebbeck_id AND body_system_id = v_sys_id;

  -- Delete the stray herb row if it has no remaining references
  IF NOT EXISTS (SELECT 1 FROM herbal.herb_primary_actions   WHERE herb_id = v_lebbeck_id)
  AND NOT EXISTS (SELECT 1 FROM herbal.prescription_herbs     WHERE herb_id = v_lebbeck_id)
  AND NOT EXISTS (SELECT 1 FROM herbal.disorder_action_herbs  WHERE herb_id = v_lebbeck_id)
  AND NOT EXISTS (SELECT 1 FROM herbal.herb_secondary_actions WHERE herb_id = v_lebbeck_id)
  AND NOT EXISTS (SELECT 1 FROM herbal.disorder_specific_remedies WHERE herb_id = v_lebbeck_id)
  AND NOT EXISTS (SELECT 1 FROM herbal.herb_constituents      WHERE herb_id = v_lebbeck_id)
  AND NOT EXISTS (SELECT 1 FROM herbal.herb_menstruum         WHERE herb_id = v_lebbeck_id)
  THEN
    DELETE FROM herbal.herbs WHERE id = v_lebbeck_id;
    RAISE NOTICE 'Deleted stray Albizia lebbeck (id=%)', v_lebbeck_id;
  ELSE
    RAISE NOTICE 'Albizia lebbeck (id=%) still has other references; left in place', v_lebbeck_id;
  END IF;

  RAISE NOTICE 'Done: Immune case study now references Albizia julibrissin (id=%)', v_julibrissin_id;
END $$;
