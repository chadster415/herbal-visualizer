SET search_path TO herbal, public;

-- Respiratory - Lower case study (asthma patient).
-- Blocks 1, 2, 3: disorder, lifestyle notes, actions indicated, prescriptions, herb_primary_actions sync.

-- Block 1: Disorder, lifestyle notes, actions indicated, disorder action herbs
DO $$
DECLARE
  v_sys_id    INTEGER;
  v_dis_id    INTEGER;
  v_action_id INTEGER;
  v_herb_id   INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Respiratory - Lower';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order, is_case_study)
  VALUES ('Case Study', v_sys_id, 0, TRUE)
  ON CONFLICT (name, body_system_id) DO NOTHING;

  SELECT id INTO v_dis_id FROM herbal.disorders
  WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  -- Lifestyle / Plan notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section) VALUES
    (v_dis_id, 'Box breathing immediately after bike rides and other exercise — inhale 4 counts, hold 4, exhale 4, hold 4 — to reduce exercise-induced bronchospasm', 10, 'general')
  ON CONFLICT DO NOTHING;

  -- Actions Indicated
  v_action_id := herbal.ensure_action('Antispasmodic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Break the cough-spasm feedback loop; relieve bronchospasm and chest tightness driving exercise-induced and acute asthma episodes.', 10)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Expectorant');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Facilitate clearance of mucus from irritated airways; address both the dry baseline cough and wet productive coughs during flare-ups.', 20)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Demulcent');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Soothe and repair chronically irritated mucous membranes; support moisture and integrity of bronchial tissue against ongoing pollution and allergic insult.', 30)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Nervine');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Address the anxiety-asthma cycle; reduce fear, stress-triggered exacerbations, and the panic that accompanies acute episodes.', 40)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  -- Disorder action herbs: Antispasmodic
  v_action_id := herbal.ensure_action('Antispasmodic');
  v_herb_id := herbal.ensure_herb('Lobelia inflata', 'Lobelia');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Angelica archangelica', 'Angelica');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 20) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Passiflora incarnata', 'Passionflower');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 30) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Disorder action herbs: Expectorant
  v_action_id := herbal.ensure_action('Expectorant');
  v_herb_id := herbal.ensure_herb('Anemopsis californica', 'Yerba Mansa');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Angelica archangelica', 'Angelica');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 20) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Lobelia inflata', 'Lobelia');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 30) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Plantago major', 'Plantain');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 40) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Disorder action herbs: Demulcent
  v_action_id := herbal.ensure_action('Demulcent');
  v_herb_id := herbal.ensure_herb('Anemopsis californica', 'Yerba Mansa');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Plantago major', 'Plantain');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 20) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Calendula officinalis', 'Calendula');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 30) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Disorder action herbs: Nervine
  v_action_id := herbal.ensure_action('Nervine');
  v_herb_id := herbal.ensure_herb('Passiflora incarnata', 'Passionflower');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  RAISE NOTICE 'Respiratory - Lower case study Block 1 done';
END $$;

-- Block 2: Prescriptions
DO $$
DECLARE
  v_sys_id  INTEGER;
  v_dis_id  INTEGER;
  v_rx_id   INTEGER;
  v_herb_id INTEGER;
  v_ph_id   INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Respiratory - Lower';
  SELECT id INTO v_dis_id FROM herbal.disorders WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  -- Prescription 1: Respiratory Tincture
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_dis_id, 'Respiratory Tincture', '2 droppers 3× daily. In acute episodes, increase to 4× daily.', 10)
  ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Anemopsis californica', 'Yerba Mansa');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
    VALUES (v_rx_id, v_herb_id, '1 part', 'acute respiratory; chronic mucous membrane support', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Demulcent'))   ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Expectorant')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Angelica archangelica', 'Angelica');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
    VALUES (v_rx_id, v_herb_id, '1 part', 'breaks cough-spasm feedback loop', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Expectorant'))   ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Passiflora incarnata', 'Passionflower');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
    VALUES (v_rx_id, v_herb_id, '1 part', 'specific for asthma picture; addresses anxiety-asthma cycle', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine'))       ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 2: Lobelia Tincture (simple)
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_dis_id, 'Lobelia Tincture', '10–20 drops as needed in acute episodes. Use cautiously — emetic at high doses.', 20)
  ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Lobelia inflata', 'Lobelia');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, 'simple', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Expectorant'))   ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 3: Nourishing Tea
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_dis_id, 'Nourishing Tea', 'Equal parts. Steep 1 tbsp per cup, covered, 15 minutes. Drink 2–3 cups daily long-term.', 30)
  ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Equisetum arvense', 'Horsetail');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
    VALUES (v_rx_id, v_herb_id, '1 part', 'silica-rich; connective tissue and airway repair', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nutritive')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Calendula officinalis', 'Calendula');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Demulcent'))         ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Plantago major', 'Plantain');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Demulcent'))   ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Expectorant')) ON CONFLICT DO NOTHING;
  END IF;

  RAISE NOTICE 'Respiratory - Lower case study Block 2 done';
END $$;

-- Block 3: Sync prescription herb actions → herb_primary_actions
DO $$
DECLARE v_sys_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Respiratory - Lower';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT DISTINCT ph.herb_id, pha.primary_action_id, v_sys_id
  FROM herbal.prescription_herb_actions pha
  JOIN herbal.prescription_herbs ph ON ph.id = pha.prescription_herb_id
  JOIN herbal.disorder_prescriptions dp ON dp.id = ph.prescription_id
  JOIN herbal.disorders d ON d.id = dp.disorder_id
  WHERE d.body_system_id = v_sys_id AND d.is_case_study = TRUE
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  RAISE NOTICE 'Respiratory - Lower case study: herb_primary_actions synced';
END $$;
