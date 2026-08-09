SET search_path TO herbal, public;

-- Add Flax (Linum usitatissimum) to the Demulcent action for the Immune case study.

DO $$
DECLARE
  v_sys_id    INTEGER;
  v_dis_id    INTEGER;
  v_action_id INTEGER;
  v_herb_id   INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Immune';
  SELECT id INTO v_dis_id FROM herbal.disorders WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  v_action_id := herbal.ensure_action('Demulcent');
  v_herb_id   := herbal.ensure_herb('Linum usitatissimum', 'Flax');

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 20)
  ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_sys_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  RAISE NOTICE 'Added Linum usitatissimum to Immune case study Demulcent action';
END $$;
