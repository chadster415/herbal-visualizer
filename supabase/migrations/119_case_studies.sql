SET search_path TO herbal, public;

-- Block 0: Add is_case_study column to disorders
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'herbal' AND table_name = 'disorders' AND column_name = 'is_case_study'
  ) THEN
    ALTER TABLE herbal.disorders ADD COLUMN is_case_study BOOLEAN NOT NULL DEFAULT FALSE;
    RAISE NOTICE 'Added is_case_study column to disorders';
  ELSE
    RAISE NOTICE 'is_case_study column already exists';
  END IF;
END $$;

-- Block 1: GI case study disorder, lifestyle notes, and actions indicated
DO $$
DECLARE
  v_sys_id    INTEGER;
  v_dis_id    INTEGER;
  v_action_id INTEGER;
  v_herb_id   INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Digestive';
  IF v_sys_id IS NULL THEN RAISE EXCEPTION 'GI body system not found'; END IF;

  INSERT INTO herbal.disorders (name, body_system_id, sort_order, is_case_study)
  VALUES ('Case Study', v_sys_id, 0, TRUE)
  ON CONFLICT (name, body_system_id) DO NOTHING;

  SELECT id INTO v_dis_id FROM herbal.disorders WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  -- Lifestyle recommendation notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section) VALUES
    (v_dis_id, 'Warm wet foods from a bowl', 10, 'general'),
    (v_dis_id, 'Breakfast within 1 hour of waking — high quality fat and veggies', 20, 'general'),
    (v_dis_id, 'Eating every 2–3 hours: protein, fat, and veggies', 30, 'general'),
    (v_dis_id, 'Main meal portion: two cupped hands together; protein size of one palm', 40, 'general'),
    (v_dis_id, '4–6 tablespoons high quality fat daily', 50, 'general'),
    (v_dis_id, '8–10 portions vegetables daily; eat from the rainbow', 60, 'general'),
    (v_dis_id, '50g protein daily', 70, 'general'),
    (v_dis_id, 'Spicy chai in the morning; spices (sumac, black pepper, cumin, coriander, dill seed, ginger) to increase metabolism and support digestion', 80, 'general'),
    (v_dis_id, 'Replace psyllium capsules with bulk psyllium; mix with 1 pint water, followed by a second pint of water', 90, 'general'),
    (v_dis_id, 'Replace iron supplements with food-based iron (e.g., Chlorodex)', 100, 'general'),
    (v_dis_id, 'Warm water with electrolytes in the morning', 110, 'general'),
    (v_dis_id, 'Bitters before meals', 120, 'general'),
    (v_dis_id, 'Include fermented food with meals 3–5× per week', 130, 'general'),
    (v_dis_id, 'Black salt (Kala namak) — 1/16 tsp in warm water morning and night for 7–10 days; for tenacious constipation (liquifies built-up material). Mix with Mag citrate (max 2 tsp).', 140, 'general'),
    (v_dis_id, 'Chloroxygen 7–10 drops or chlorophyll tablets for lightheadedness', 150, 'general'),
    (v_dis_id, '2 weeks of menus sent', 160, 'general'),
    (v_dis_id, 'Marshmallow root layered in later', 170, 'general')
  ON CONFLICT DO NOTHING;

  -- Actions indicated
  v_action_id := herbal.ensure_action('Adaptogen');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Support HPA axis regulation and stress adaptation; address cortisol dysregulation underlying digestive and hormonal dysfunction.', 10)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Nervine');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Support the nervous system; reduce stress-mediated digestive dysfunction and nervous exhaustion.', 20)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Hormonal Regulator');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Address underlying hormonal imbalance — progesterone support and estrogen modulation — affecting digestion, energy, and wellbeing.', 30)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Nutritive');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Rebuild and nourish depleted tissues; support vitality with high-quality fats, protein, and abundant vegetables.', 40)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Carminative');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Warming aromatic spices to stimulate digestive metabolism, relieve gas and bloating, and improve motility.', 50)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Demulcent');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Soothe and protect the intestinal mucosa; layered in as digestive function stabilizes.', 60)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  -- Disorder action herbs: Adaptogen
  v_action_id := herbal.ensure_action('Adaptogen');
  v_herb_id := herbal.ensure_herb('Asparagus racemosus', 'Shatavari');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Centella asiatica', 'Gotu Kola');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 20) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Glycyrrhiza glabra', 'Licorice');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 30) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Disorder action herbs: Nervine
  v_action_id := herbal.ensure_action('Nervine');
  v_herb_id := herbal.ensure_herb('Avena sativa', 'Milky Oats');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Centella asiatica', 'Gotu Kola');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 20) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Disorder action herbs: Hormonal Regulator
  v_action_id := herbal.ensure_action('Hormonal Regulator');
  v_herb_id := herbal.ensure_herb('Vitex agnus-castus', 'Vitex');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Paeonia lactiflora', 'White Peony');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 20) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Achillea millefolium', 'Yarrow');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 30) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Disorder action herbs: Nutritive
  v_action_id := herbal.ensure_action('Nutritive');
  v_herb_id := herbal.ensure_herb('Asparagus racemosus', 'Shatavari');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Avena sativa', 'Milky Oats');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 20) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Disorder action herbs: Demulcent
  v_action_id := herbal.ensure_action('Demulcent');
  v_herb_id := herbal.ensure_herb('Althaea officinalis', 'marshmallow');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  RAISE NOTICE 'GI case study: disorder, notes, and actions inserted';
END $$;

-- Block 2: Prescriptions with herbs and herb actions
DO $$
DECLARE
  v_sys_id   INTEGER;
  v_dis_id   INTEGER;
  v_rx_id    INTEGER;
  v_herb_id  INTEGER;
  v_ph_id    INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Digestive';
  SELECT id INTO v_dis_id FROM herbal.disorders WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  -- Prescription 1: Adaptogen-Nervine Tincture
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_dis_id,
    'Adaptogen-Nervine Tincture',
    'Dosage per herb listed. Begin at the lower dose; titrate up over 1–2 weeks as tolerated.',
    10)
  ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Asparagus racemosus', 'Shatavari');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
    VALUES (v_rx_id, v_herb_id, '40–80 drops (60ml)', 'Replaced initial Ashwagandha — caused irritability and aggravation', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Adaptogen')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nutritive'))  ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Avena sativa', 'Milky Oats');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, '25–50 drops (40ml)', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine'))   ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nutritive')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Centella asiatica', 'Gotu Kola');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, '15–30 drops (20ml)', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Adaptogen')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine'))   ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 2: Reproductive Tincture
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_dis_id,
    'Reproductive Tincture',
    '2 droppers 3× daily. Total: 120ml.',
    20)
  ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Vitex agnus-castus', 'Vitex');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, '30 drops (30ml)', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hormonal Regulator')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Paeonia lactiflora', 'White Peony');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
    VALUES (v_rx_id, v_herb_id, '55 drops (30ml)', 'root', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic'))      ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hormonal Regulator')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Glycyrrhiza glabra', 'Licorice');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
    VALUES (v_rx_id, v_herb_id, '20 drops (25ml)', 'root', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Adaptogen'))         ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Achillea millefolium', 'Yarrow');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, '30 drops (35ml)', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative'))  ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Astringent')) ON CONFLICT DO NOTHING;
  END IF;

  RAISE NOTICE 'GI case study: prescriptions inserted';
END $$;

-- Block 3: Sync prescription herb actions → herb_primary_actions for GI
DO $$
DECLARE
  v_sys_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Digestive';

  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT DISTINCT ph.herb_id, pha.primary_action_id, v_sys_id
  FROM herbal.prescription_herb_actions pha
  JOIN herbal.prescription_herbs ph ON ph.id = pha.prescription_herb_id
  JOIN herbal.disorder_prescriptions dp ON dp.id = ph.prescription_id
  JOIN herbal.disorders d ON d.id = dp.disorder_id
  WHERE d.body_system_id = v_sys_id AND d.is_case_study = TRUE
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  RAISE NOTICE 'GI case study: herb_primary_actions synced';
END $$;
