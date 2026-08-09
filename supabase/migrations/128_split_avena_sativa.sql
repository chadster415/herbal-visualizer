SET search_path TO herbal, public;

-- Split Avena sativa (ID 178, currently generic 'Oat') into three plant-part entries:
--   ID 178  → Milky Oats (plant_part='milky oats')  — nervous system restorative; tinctures
--   new     → Oat Straw  (plant_part='oat straw')   — mineral-rich; Osteoporosis, Demulcent
--   new     → Oat        (plant_part='colloidal')    — topical colloidal oatmeal only
--
-- All existing references to ID 178 (nervine/antidepressant/nutritive tinctures) become
-- Milky Oats automatically. Only the Osteoporosis prescriptions, the Neuritis external
-- topical prescription, and the Nervous-Demulcent action need re-pointing.

DO $$
DECLARE
  v_nervous_id    INTEGER;
  v_demulcent_id  INTEGER;
  v_oatstraw_id   INTEGER;
  v_colloidal_id  INTEGER;
BEGIN
  -- Rename existing row to Milky Oats
  UPDATE herbal.herbs
  SET common_name = 'Milky Oats', plant_part = 'milky oats'
  WHERE id = 178;

  -- Create Oat Straw and colloidal Oat
  v_oatstraw_id  := herbal.ensure_herb('Avena sativa', 'Oat Straw', 'oat straw');
  v_colloidal_id := herbal.ensure_herb('Avena sativa', 'Oat', 'colloidal');

  -- Re-point Osteoporosis prescription_herbs (ph IDs 591 and 652) → Oat Straw
  UPDATE herbal.prescription_herbs SET herb_id = v_oatstraw_id WHERE id IN (591, 652);

  -- Re-point Neuritis External topical prescription (ph ID 318) → colloidal Oat
  UPDATE herbal.prescription_herbs SET herb_id = v_colloidal_id WHERE id = 318;

  -- Move Nervous-Demulcent herb_primary_action from Milky Oats → Oat Straw
  SELECT id INTO v_nervous_id FROM herbal.body_systems WHERE name = 'Nervous';
  v_demulcent_id := herbal.ensure_action('Demulcent');

  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_oatstraw_id, v_demulcent_id, v_nervous_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  DELETE FROM herbal.herb_primary_actions
  WHERE herb_id = 178 AND primary_action_id = v_demulcent_id AND body_system_id = v_nervous_id;

  RAISE NOTICE 'Avena sativa split: ID 178 → Milky Oats; Oat Straw id=%; colloidal Oat id=%',
    v_oatstraw_id, v_colloidal_id;
END $$;
