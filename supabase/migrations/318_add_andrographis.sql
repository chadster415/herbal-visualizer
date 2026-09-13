-- Migration 318: Add Andrographis paniculata
--
-- Added for Class 33 (Skin 1 and Food Sensitivities): instructor listed
-- Andrographis as an adaptogen under "Regulate the Nervous System" in the
-- food sensitivities afternoon session.

SET search_path TO herbal, public;

DO $$
DECLARE
  v_herb_id INTEGER;
  v_sys_id  INTEGER;
  v_act_id  INTEGER;
BEGIN
  v_herb_id := herbal.ensure_herb('Andrographis paniculata', 'Andrographis');
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Nervous';
  v_act_id  := herbal.ensure_action('Adaptogen');

  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_act_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Andrographis paniculata added (herb_id = %)', v_herb_id;
END $$;
