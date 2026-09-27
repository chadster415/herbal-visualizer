SET search_path TO herbal, public;

-- ============================================================
-- Case Study: Musculoskeletal
-- Primary: Back/Muscle Tension, Bone Density, Sleep, Stress
-- Patient: Mary, 56F, 155 lbs, 5'11"
-- is_case_study and heading columns already exist (migrations 119, 120)
-- ============================================================

-- Block 1 — Disorder, lifestyle notes, and actions indicated
DO $$
DECLARE
  v_sys_id    INTEGER;
  v_dis_id    INTEGER;
  v_action_id INTEGER;
  v_herb_id   INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Musculoskeletal';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order, is_case_study)
  VALUES ('Case Study', v_sys_id, 0, TRUE)
  ON CONFLICT (name, body_system_id) DO NOTHING;

  SELECT id INTO v_dis_id FROM herbal.disorders
  WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  -- General / Plan notes (green Notes box, sort_order 10–190)
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section) VALUES
    (v_dis_id, 'Increase vegetables across meals — broadens micronutrient intake supporting bone density, tissue repair, and alkaline buffering', 10, 'general'),
    (v_dis_id, 'High-quality fats with meals (olive oil, avocado, nuts, fatty fish) — essential fatty acids support tissue flexibility, skin health, hormonal function, and joint lubrication', 20, 'general'),
    (v_dis_id, 'Protein at every meal — supports bone matrix, muscle repair, and adrenal recovery; prioritize breakfast given current coffee-and-toast pattern', 30, 'general'),
    (v_dis_id, 'No screens 1 hour before bedtime — supports sleep onset and melatonin production', 40, 'general'),
    (v_dis_id, 'Natural Calm (magnesium glycinate or citrate) before bed — addresses teeth grinding, muscle tension, restless sleep, and anxiety', 50, 'general'),
    (v_dis_id, 'Dry brushing and oilination (self-massage with warm oil) — supports tissue flexibility, circulation, lymphatic flow, and skin nourishment', 60, 'general'),
    (v_dis_id, 'Increase cardiovascular exercise — supports bone density, mood regulation, and energy', 70, 'general'),
    (v_dis_id, 'Vitamin D supplementation — retest levels; current 2000 IU may be insufficient for postmenopausal bone support', 80, 'general'),
    (v_dis_id, 'Add ankle weights to daily walk — targeted resistance supports ankle stability and bone density', 90, 'general'),
    (v_dis_id, 'Prioritize grief processing — the physical holding pattern reflects emotional weight; explore creative expression, community support, or counseling', 100, 'general'),
    (v_dis_id, 'Calcium 1000 mg — ensure it is calcium citrate for best absorption; take alongside Vitamin D', 110, 'general'),
    (v_dis_id, 'Lysine supports collagen synthesis and bone integrity; continue current use', 120, 'general')
  ON CONFLICT DO NOTHING;

  -- Actions indicated
  v_action_id := herbal.ensure_action('Nervine Tonic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Nourishes and restores the exhausted nervous system depleted by chronic stress, grief, and years of upheaval; Milky Oats and Hawthorn build the nervous tissue foundation needed for sustained recovery.', 10)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Adaptogen');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Supports adrenal and HPA axis resilience; addresses the core exhaustion pattern underlying both the physical tension and the emotional depletion from grief and repeated upheaval.', 20)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Nervine Relaxant');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Releases the physical holding pattern expressed as back tension, teeth grinding, and restless sleep; Bleeding Heart specifically addresses emotional armoring and grief held in the body.', 30)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Antispasmodic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Directly addresses muscle spasm, back tension, and bruxism; Jamaican Dogwood provides stronger antispasmodic and analgesic action for nighttime pain patterns.', 40)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Nutritive');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Supports postmenopausal bone density, tissue integrity, and nutritional repletion after prolonged physical and emotional stress.', 50)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Hormonal Regulator');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Provides postmenopausal hormonal support; Black Cohosh modulates estrogen receptor activity in bone and connective tissue; Shatavari supports adrenal-to-ovarian hormone adaptation.', 60)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Anti-Inflammatory');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Addresses joint pain, inflammatory contributors to musculoskeletal decline, and systemic inflammation driven by chronic stress; Bacopa and Albizia nourish the nervous system alongside their anti-inflammatory activity.', 70)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Cardiotonic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Hawthorn addresses grief at the heart level — the emotional root of the physical holding pattern; nourishes both the cardiovascular and nervous systems simultaneously.', 80)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  -- Disorder action herbs (herb bubbles under each action in the UI)

  -- Nervine Tonic: Milky Oats, Hawthorn (leaf & flower), Gotu Kola
  v_action_id := herbal.ensure_action('Nervine Tonic');
  v_herb_id := herbal.ensure_herb('Avena sativa', 'Oat', 'milky oats');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Crataegus spp.', 'Hawthorn', 'leaf & flower');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 20) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Centella asiatica', 'Gotu Kola');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 30) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Adaptogen: Shatavari, Gotu Kola, Bacopa
  v_action_id := herbal.ensure_action('Adaptogen');
  v_herb_id := herbal.ensure_herb('Asparagus racemosus', 'Shatavari');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Centella asiatica', 'Gotu Kola');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 20) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Bacopa monnieri', 'Bacopa');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 30) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Nervine Relaxant: Bleeding Heart, Linden, Pedicularis, Catnip, Albizia (Silk Tree)
  v_action_id := herbal.ensure_action('Nervine Relaxant');
  v_herb_id := herbal.ensure_herb('Dicentra formosa', 'Bleeding Heart');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Tilia platyphyllos', 'Linden');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 20) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Pedicularis densiflora', 'Pedicularis', 'Aerial parts');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 30) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Nepeta cataria', 'Catnip');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 40) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Albizia julibrissin', 'Silk Tree');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 50) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Antispasmodic: Black Cohosh, Jamaican Dogwood, Pedicularis
  v_action_id := herbal.ensure_action('Antispasmodic');
  v_herb_id := herbal.ensure_herb('Actaea racemosa', 'Black Cohosh');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Piscidia spp.', 'Jamaican Dogwood', 'Root bark');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 20) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Pedicularis densiflora', 'Pedicularis', 'Aerial parts');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 30) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Nutritive: Milky Oats, Shatavari
  v_action_id := herbal.ensure_action('Nutritive');
  v_herb_id := herbal.ensure_herb('Avena sativa', 'Oat', 'milky oats');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Asparagus racemosus', 'Shatavari');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 20) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Hormonal Regulator: Shatavari, Black Cohosh
  v_action_id := herbal.ensure_action('Hormonal Regulator');
  v_herb_id := herbal.ensure_herb('Asparagus racemosus', 'Shatavari');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Actaea racemosa', 'Black Cohosh');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 20) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Anti-Inflammatory: Bacopa, Albizia (Silk Tree)
  v_action_id := herbal.ensure_action('Anti-Inflammatory');
  v_herb_id := herbal.ensure_herb('Bacopa monnieri', 'Bacopa');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Albizia julibrissin', 'Silk Tree');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 20) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Cardiotonic: Hawthorn (leaf & flower)
  v_action_id := herbal.ensure_action('Cardiotonic');
  v_herb_id := herbal.ensure_herb('Crataegus spp.', 'Hawthorn', 'leaf & flower');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  RAISE NOTICE 'Block 1 done — Musculoskeletal Case Study';
END $$;

-- Block 2 — Prescriptions
DO $$
DECLARE
  v_sys_id  INTEGER;
  v_dis_id  INTEGER;
  v_rx_id   INTEGER;
  v_herb_id INTEGER;
  v_ph_id   INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Musculoskeletal';
  SELECT id INTO v_dis_id FROM herbal.disorders WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  -- ─── Daily Restorative Tincture ──────────────────────────────
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_dis_id, 'Daily Restorative Tincture', '2ml 3× daily.', 10)
  ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    -- Milky Oats — Nervine Tonic, Nutritive
    v_herb_id := herbal.ensure_herb('Avena sativa', 'Oat', 'milky oats');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, '', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine Tonic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nutritive')) ON CONFLICT DO NOTHING;

    -- Hawthorn leaf & flower — Cardiotonic, Nervine Tonic
    v_herb_id := herbal.ensure_herb('Crataegus spp.', 'Hawthorn', 'leaf & flower');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, '', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Cardiotonic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine Tonic')) ON CONFLICT DO NOTHING;

    -- Shatavari — Adaptogen, Nutritive, Hormonal Regulator
    v_herb_id := herbal.ensure_herb('Asparagus racemosus', 'Shatavari');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, '', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Adaptogen')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nutritive')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hormonal Regulator')) ON CONFLICT DO NOTHING;

    -- Gotu Kola — Adaptogen, Nervine Tonic, Vulnerary
    v_herb_id := herbal.ensure_herb('Centella asiatica', 'Gotu Kola');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, '', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Adaptogen')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine Tonic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Vulnerary')) ON CONFLICT DO NOTHING;

    -- Bleeding Heart — Nervine Relaxant, Antispasmodic
    v_herb_id := herbal.ensure_herb('Dicentra formosa', 'Bleeding Heart');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, '', 50);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine Relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    -- Black Cohosh — Antispasmodic, Hormonal Regulator
    v_herb_id := herbal.ensure_herb('Actaea racemosa', 'Black Cohosh');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, '', 60);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hormonal Regulator')) ON CONFLICT DO NOTHING;

    -- Linden (glycerite) — Nervine Relaxant, Antispasmodic
    v_herb_id := herbal.ensure_herb('Tilia platyphyllos', 'Linden');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
    VALUES (v_rx_id, v_herb_id, '', 'glycerite', 70);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine Relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    -- Bacopa — Adaptogen, Nootropic, Anti-Inflammatory
    v_herb_id := herbal.ensure_herb('Bacopa monnieri', 'Bacopa');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, '', 80);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Adaptogen')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nootropic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-Inflammatory')) ON CONFLICT DO NOTHING;

    -- Albizia julibrissin (Silk Tree / Mimosa) — Anti-Inflammatory, Nervine Relaxant
    v_herb_id := herbal.ensure_herb('Albizia julibrissin', 'Silk Tree');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
    VALUES (v_rx_id, v_herb_id, '', 'Silk Tree / Mimosa — grief and heart nourishment', 90);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-Inflammatory')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine Relaxant')) ON CONFLICT DO NOTHING;
  END IF;

  -- ─── Sleep Tincture ──────────────────────────────────────────
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_dis_id, 'Sleep Tincture', '2ml 30–60 minutes before bed; take an additional dose if waking in the night.', 20)
  ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    -- Pedicularis — Nervine Relaxant, Antispasmodic, Sedative
    v_herb_id := herbal.ensure_herb('Pedicularis densiflora', 'Pedicularis', 'Aerial parts');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, '', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine Relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Sedative')) ON CONFLICT DO NOTHING;

    -- Jamaican Dogwood — Sedative, Antispasmodic, Analgesic
    v_herb_id := herbal.ensure_herb('Piscidia spp.', 'Jamaican Dogwood', 'Root bark');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, '', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Sedative')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Analgesic')) ON CONFLICT DO NOTHING;

    -- Catnip (glycerite) — Nervine Relaxant, Antispasmodic
    v_herb_id := herbal.ensure_herb('Nepeta cataria', 'Catnip');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
    VALUES (v_rx_id, v_herb_id, '', 'glycerite', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine Relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
  END IF;

  RAISE NOTICE 'Block 2 done — prescriptions';
END $$;

-- Block 3 — Sync herb_primary_actions from prescription_herb_actions
DO $$
DECLARE v_sys_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Musculoskeletal';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT DISTINCT ph.herb_id, pha.primary_action_id, v_sys_id
  FROM herbal.prescription_herb_actions pha
  JOIN herbal.prescription_herbs ph ON ph.id = pha.prescription_herb_id
  JOIN herbal.disorder_prescriptions dp ON dp.id = ph.prescription_id
  JOIN herbal.disorders d ON d.id = dp.disorder_id
  WHERE d.body_system_id = v_sys_id AND d.is_case_study = TRUE
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  RAISE NOTICE 'Block 3 done — synced herb_primary_actions';
END $$;

-- Block 4 — Subjective notes (sort_order 200–590)
DO $$
DECLARE
  v_sys_id INTEGER;
  v_dis_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Musculoskeletal';
  SELECT id INTO v_dis_id FROM herbal.disorders WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section, heading) VALUES
    -- Demographics (NULL heading → renders as intro paragraph)
    (v_dis_id, 'Patient is 56 years old, 155 lbs, 5''11"', 200, 'subjective', NULL),
    -- Primary Health Concerns
    (v_dis_id, 'Back pain and muscle tension', 210, 'subjective', 'Primary Health Concerns'),
    (v_dis_id, 'Improving bone density (postmenopausal)', 220, 'subjective', 'Primary Health Concerns'),
    (v_dis_id, 'Sleep disturbance — restless, 5–7 hours nightly, occasional nightmares', 230, 'subjective', 'Primary Health Concerns'),
    (v_dis_id, 'Stress and chronic exhaustion', 240, 'subjective', 'Primary Health Concerns'),
    -- Symptoms
    (v_dis_id, 'Anxiety, nervousness, and depression', 250, 'subjective', 'Symptoms'),
    (v_dis_id, 'Headaches and brain fog', 260, 'subjective', 'Symptoms'),
    (v_dis_id, 'Dry skin and low energy', 270, 'subjective', 'Symptoms'),
    (v_dis_id, 'Cold hands and feet', 280, 'subjective', 'Symptoms'),
    (v_dis_id, 'Joint pain and weak ankles', 290, 'subjective', 'Symptoms'),
    (v_dis_id, 'Teeth grinding (bruxism)', 300, 'subjective', 'Symptoms'),
    (v_dis_id, 'Acidic stomach on waking', 310, 'subjective', 'Symptoms'),
    (v_dis_id, 'Cravings for sugary foods', 320, 'subjective', 'Symptoms'),
    (v_dis_id, 'Waking to urinate at night', 330, 'subjective', 'Symptoms'),
    (v_dis_id, 'Seasonal allergies', 340, 'subjective', 'Symptoms'),
    -- Context
    (v_dis_id, 'Postmenopause for 3 years', 350, 'subjective', 'Context'),
    (v_dis_id, 'Multiple home moves in recent years — significant ongoing life disruption', 360, 'subjective', 'Context'),
    (v_dis_id, 'Recent loss of both parents — grief and emotional exhaustion are prominent', 370, 'subjective', 'Context'),
    (v_dis_id, 'Feeling creatively blocked; physically and emotionally exhausted', 380, 'subjective', 'Context'),
    -- Nutrition
    (v_dis_id, 'Breakfast: coffee and toast', 390, 'subjective', 'Nutrition'),
    (v_dis_id, 'Lunch: sandwich or raw veggies and cheese', 400, 'subjective', 'Nutrition'),
    (v_dis_id, 'Dinner: protein, grain, and roasted vegetables; likes to cook but finds it irritating when fatigued', 410, 'subjective', 'Nutrition'),
    (v_dis_id, 'Drinks approximately 7 cups of water daily', 420, 'subjective', 'Nutrition'),
    -- Exercise & Sleep
    (v_dis_id, 'Daily walk of approximately 2 miles', 430, 'subjective', 'Exercise & Sleep'),
    (v_dis_id, 'Sleeps 5–7 hours nightly; restless with occasional nightmares', 440, 'subjective', 'Exercise & Sleep'),
    -- Current Supplements
    (v_dis_id, 'Calcium 1000 mg', 450, 'subjective', 'Current Supplements'),
    (v_dis_id, 'Lysine', 460, 'subjective', 'Current Supplements'),
    (v_dis_id, 'Vitamin D 2000 IU', 470, 'subjective', 'Current Supplements')
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Block 4 done — subjective notes';
END $$;

-- Block 5 — Objective notes (sort_order 600–790)
DO $$
DECLARE
  v_sys_id INTEGER;
  v_dis_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Musculoskeletal';
  SELECT id INTO v_dis_id FROM herbal.disorders WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section, heading) VALUES
    (v_dis_id, 'No lab work available', 600, 'objective', NULL)
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Block 5 done — objective notes';
  RAISE NOTICE 'Migration 346 complete — Musculoskeletal case study inserted.';
END $$;
