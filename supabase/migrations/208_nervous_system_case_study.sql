SET search_path TO herbal, public;

-- ============================================================
-- Case Study: Nervous System
-- Chronic anxiety, HPA axis depletion, blood sugar dysregulation,
-- PMOS-adjacent hormonal pattern, stress-related digestive symptoms
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
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Nervous';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order, is_case_study)
  VALUES ('Case Study', v_sys_id, 0, TRUE)
  ON CONFLICT (name, body_system_id) DO NOTHING;

  SELECT id INTO v_dis_id FROM herbal.disorders
  WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  -- General / Plan notes (green Notes box, sort_order 10–190)
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section) VALUES
    (v_dis_id, 'Meal prep planning with protein-focused goals; air fryer and Instant Pot for quick, nutrient-dense meals', 10, 'general'),
    (v_dis_id, 'Prioritize regular protein-rich meals to stabilize blood sugar and break the anxiety–fatigue–cortisol cycle', 20, 'general'),
    (v_dis_id, 'Reintroduce movement as medicine — combine walks with caregiving work where possible; walking and hiking are most grounding and centering', 30, 'general'),
    (v_dis_id, 'Vitamin D supplementation: 2000 IU daily (lab-confirmed deficiency; supports hormone regulation and immune function)', 40, 'general'),
    (v_dis_id, 'Omega-3 fish oil — supports ADHD picture and neuroinflammation; especially indicated given prior concussion history', 50, 'general'),
    (v_dis_id, 'Continued follow-up with primary care provider to retest testosterone levels', 60, 'general'),
    (v_dis_id, 'Back pocket as care deepens: Lemon Balm + Skullcap for sleep; Saw Palmetto to bind excess testosterone; White Peony for neuroinflammation; B vitamins for stress and adrenal support', 70, 'general')
  ON CONFLICT DO NOTHING;

  -- Actions indicated
  v_action_id := herbal.ensure_action('Adaptogen');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Supports HPA axis regulation and builds resilience to chronic emotional and physical stress.', 10)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Nootropic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Restores cognitive function, focus, and memory — especially indicated given concussion history and chronic mental fatigue.', 20)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Nervine Tonic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Restores and nourishes depleted nervous system tissue from chronic overwhelm and caregiving depletion.', 30)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Nervine Relaxant');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Calms anxiety, overstimulation, and racing thoughts; supports restorative sleep and nervous system settling.', 40)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Hypoglycemic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Stabilizes blood sugar to break the anxiety–fatigue–cortisol dysregulation cycle and reduce cravings.', 50)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Carminative');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Relieves stress-driven abdominal bloating, gas, cramping, and loose stools — anxiety consistently settles in the gut.', 60)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Emmenagogue');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Moves stagnant blood and supports liver clearance of excess hormones contributing to the PMOS pattern and premenstrual symptoms.', 70)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Hepatic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Stimulates liver function to clear excess androgens — elevated testosterone correlates with the 3:1 LH:FSH ratio in PMOS.', 80)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Lymphagogue');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Moves lymph in the lower third and supports healthy energetic boundaries between self and others.', 90)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  -- Disorder action herbs (herb bubbles under each action in the UI)

  -- Adaptogen: Schisandra, Bacopa, Holy Basil (Tulsi)
  v_action_id := herbal.ensure_action('Adaptogen');
  v_herb_id := herbal.ensure_herb('Schisandra chinensis', 'Schizandra');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Bacopa monnieri', 'Bacopa');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 20) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Ocimum sanctum', 'Holy Basil');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 30) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Nootropic: Bacopa, Schisandra
  v_action_id := herbal.ensure_action('Nootropic');
  v_herb_id := herbal.ensure_herb('Bacopa monnieri', 'Bacopa');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Schisandra chinensis', 'Schizandra');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 20) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Nervine Tonic: Bacopa, Holy Basil
  v_action_id := herbal.ensure_action('Nervine Tonic');
  v_herb_id := herbal.ensure_herb('Bacopa monnieri', 'Bacopa');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Ocimum sanctum', 'Holy Basil');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 20) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Nervine Relaxant: Holy Basil, Linden, Hawthorn
  v_action_id := herbal.ensure_action('Nervine Relaxant');
  v_herb_id := herbal.ensure_herb('Ocimum sanctum', 'Holy Basil');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Tilia platyphyllos', 'Linden');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 20) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Crataegus spp.', 'Hawthorn', 'leaf & flower');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 30) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Hypoglycemic: Fenugreek, Bitter Melon
  v_action_id := herbal.ensure_action('Hypoglycemic');
  v_herb_id := herbal.ensure_herb('Trigonella foenum-graecum', 'Fenugreek');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Momordica charantia', 'Bitter Melon');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 20) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Carminative: Cardamom, Fenugreek
  v_action_id := herbal.ensure_action('Carminative');
  v_herb_id := herbal.ensure_herb('Elettaria cardamomum', 'Cardamom');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Trigonella foenum-graecum', 'Fenugreek');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 20) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Emmenagogue: Dong Quai, Schisandra
  v_action_id := herbal.ensure_action('Emmenagogue');
  v_herb_id := herbal.ensure_herb('Angelica sinensis', 'Dong Quai');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Schisandra chinensis', 'Schizandra');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 20) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Hepatic: Schisandra
  v_action_id := herbal.ensure_action('Hepatic');
  v_herb_id := herbal.ensure_herb('Schisandra chinensis', 'Schizandra');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Lymphagogue: Ocotillo
  v_action_id := herbal.ensure_action('Lymphagogue');
  v_herb_id := herbal.ensure_herb('Fouquieria splendens', 'Ocotillo');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  RAISE NOTICE 'Block 1 done — Nervous System Case Study';
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
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Nervous';
  SELECT id INTO v_dis_id FROM herbal.disorders WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  -- ─── Temple of Devotion Tincture ───────────────────────────
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_dis_id, 'Temple of Devotion Tincture', '30–60 drops 3× daily in water or tea. Avoid Dong Quai during heavy menstrual bleeding.', 10)
  ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    -- Schisandra 2 parts — Adaptogen, Hepatic
    v_herb_id := herbal.ensure_herb('Schisandra chinensis', 'Schizandra');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, '2 parts', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Adaptogen')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hepatic')) ON CONFLICT DO NOTHING;

    -- Bacopa 2 parts — Nootropic, Nervine Tonic
    v_herb_id := herbal.ensure_herb('Bacopa monnieri', 'Bacopa');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, '2 parts', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nootropic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine Tonic')) ON CONFLICT DO NOTHING;

    -- Fenugreek 1 part — Hypoglycemic, Carminative
    v_herb_id := herbal.ensure_herb('Trigonella foenum-graecum', 'Fenugreek');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hypoglycemic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Carminative')) ON CONFLICT DO NOTHING;

    -- Bitter Melon 1 part — Hypoglycemic
    v_herb_id := herbal.ensure_herb('Momordica charantia', 'Bitter Melon');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, '1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hypoglycemic')) ON CONFLICT DO NOTHING;

    -- Dong Quai 1 part — Emmenagogue
    v_herb_id := herbal.ensure_herb('Angelica sinensis', 'Dong Quai');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
    VALUES (v_rx_id, v_herb_id, '1 part', 'avoid if heavy bleeder during menstruation', 50);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Emmenagogue')) ON CONFLICT DO NOTHING;

    -- Ocotillo 1 part — Lymphagogue
    v_herb_id := herbal.ensure_herb('Fouquieria splendens', 'Ocotillo');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
    VALUES (v_rx_id, v_herb_id, '1 part', 'boundary medicine; moves lower third lymph', 60);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Lymphagogue')) ON CONFLICT DO NOTHING;

    -- Cardamom ½ part glycerite — Carminative
    v_herb_id := herbal.ensure_herb('Elettaria cardamomum', 'Cardamom');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
    VALUES (v_rx_id, v_herb_id, '½ part', 'glycerite; for windy digestion', 70);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Carminative')) ON CONFLICT DO NOTHING;
  END IF;

  -- ─── Nourishing Nervine Tea ─────────────────────────────────
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_dis_id, 'Nourishing Nervine Tea', '1–3 cups daily; especially morning and evening.', 20)
  ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    -- Tulsi (Holy Basil) 2 parts — Adaptogen, Nervine Tonic
    v_herb_id := herbal.ensure_herb('Ocimum sanctum', 'Holy Basil');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, '2 parts', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Adaptogen')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine Tonic')) ON CONFLICT DO NOTHING;

    -- Linden 1 part — Nervine Relaxant
    v_herb_id := herbal.ensure_herb('Tilia platyphyllos', 'Linden');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
    VALUES (v_rx_id, v_herb_id, '1 part', 'astringent and moistening', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine Relaxant')) ON CONFLICT DO NOTHING;

    -- Hawthorn leaf & flower 1 part — Nervine Relaxant
    v_herb_id := herbal.ensure_herb('Crataegus spp.', 'Hawthorn', 'leaf & flower');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
    VALUES (v_rx_id, v_herb_id, '1 part', 'boundaries; grief and heartache', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine Relaxant')) ON CONFLICT DO NOTHING;
  END IF;

  RAISE NOTICE 'Block 2 done — prescriptions';
END $$;

-- Block 3 — Sync herb_primary_actions from prescription_herb_actions
DO $$
DECLARE v_sys_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Nervous';
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
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Nervous';
  SELECT id INTO v_dis_id FROM herbal.disorders WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section, heading) VALUES
    -- Primary Health Concerns
    (v_dis_id, 'Chronic anxiety and persistent overwhelm — even routine tasks feel paralyzing', 210, 'subjective', 'Primary Health Concerns'),
    (v_dis_id, 'Difficulty focusing, organizing thoughts, and following through on tasks', 220, 'subjective', 'Primary Health Concerns'),
    (v_dis_id, 'Mental fatigue — "running on empty," mentally scattered most days', 230, 'subjective', 'Primary Health Concerns'),
    (v_dis_id, 'Undiagnosed ADHD-like picture: racing thoughts, constant task-switching without completion, decision paralysis, frequent phone-scrolling loops', 240, 'subjective', 'Primary Health Concerns'),
    (v_dis_id, 'Negative self-talk; shuts down completely when overwhelmed, spending long periods in bed despite guilt about unfinished responsibilities', 250, 'subjective', 'Primary Health Concerns'),
    -- Lifestyle and Stress
    (v_dis_id, 'Recently transitioned into emotionally demanding caregiving work with unpredictable hours', 260, 'subjective', 'Lifestyle and Stress'),
    (v_dis_id, 'Finds the work deeply meaningful but consistently neglects own needs while caring for others', 270, 'subjective', 'Lifestyle and Stress'),
    (v_dis_id, 'Naturally overextends; struggles to set boundaries and consistently places others'' needs before their own', 280, 'subjective', 'Lifestyle and Stress'),
    (v_dis_id, 'Feels emotionally depleted and no longer grounded or connected to themselves', 290, 'subjective', 'Lifestyle and Stress'),
    -- Sleep
    (v_dis_id, 'Bedtime around midnight; wakes 3:00–5:00 a.m. with anxious thoughts, often unable to return to sleep', 300, 'subjective', 'Sleep'),
    (v_dis_id, 'Wakes unrefreshed; persistent fatigue throughout the day — classic high-cortisol night-waking pattern', 310, 'subjective', 'Sleep'),
    -- Digestion
    (v_dis_id, 'Stress and anxiety consistently worsen all digestive symptoms', 320, 'subjective', 'Digestion'),
    (v_dis_id, 'Frequent abdominal bloating and gas; occasional cramping', 330, 'subjective', 'Digestion'),
    (v_dis_id, 'Loose stools 1–3× per day — heat pattern', 340, 'subjective', 'Digestion'),
    -- Nutrition
    (v_dis_id, 'Meals often rushed or skipped due to work demands', 350, 'subjective', 'Nutrition'),
    (v_dis_id, 'Craves carbohydrates and sweets throughout the day', 360, 'subjective', 'Nutrition'),
    (v_dis_id, 'Worsening irritability, anxiety, and fatigue when going long periods without eating — blood sugar yo-yo pattern', 370, 'subjective', 'Nutrition'),
    (v_dis_id, 'Breakfast typically limited to coffee and a small meal before rushing to appointments', 380, 'subjective', 'Nutrition'),
    -- Movement
    (v_dis_id, 'Previously danced regularly — found it grounding, emotionally regulating, and connecting to the body', 390, 'subjective', 'Movement'),
    (v_dis_id, 'Currently exercises infrequently; recognizes movement consistently improves both mood and energy', 400, 'subjective', 'Movement'),
    (v_dis_id, 'Walking and hiking produce the most calm and centering effect', 410, 'subjective', 'Movement'),
    -- Reproductive Health
    (v_dis_id, 'Premenstrual irritability, low mood, and cramping beginning approximately one week before menstruation', 420, 'subjective', 'Reproductive Health'),
    (v_dis_id, 'Irregular periods with long cycles', 430, 'subjective', 'Reproductive Health'),
    -- Additional History
    (v_dis_id, 'Previous concussion requiring extended recovery — possible ongoing neuroinflammatory component', 440, 'subjective', 'Additional History'),
    (v_dis_id, 'Symptom pattern consistent with PMOS: anxiety/depression, blood sugar dysregulation, irregular long cycles, fatigue, and mildly elevated testosterone', 450, 'subjective', 'Additional History')
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Block 4 done — subjective notes';
END $$;

-- Block 5 — Objective notes (sort_order 600–790)
DO $$
DECLARE
  v_sys_id INTEGER;
  v_dis_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Nervous';
  SELECT id INTO v_dis_id FROM herbal.disorders WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section, heading) VALUES
    (v_dis_id, 'Vitamin D: low — 2000 IU/day supplementation initiated', 600, 'objective', 'Lab Values'),
    (v_dis_id, 'Testosterone: mildly elevated — correlates with PMOS/PCOS-adjacent picture; elevated LH:FSH ratio (~3:1)', 610, 'objective', 'Lab Values'),
    (v_dis_id, 'Thyroid function: within normal limits', 620, 'objective', 'Lab Values'),
    (v_dis_id, 'Adipose tissue in midsection — correlates with cortisol dysregulation and high-cortisol night-waking pattern', 630, 'objective', 'Physical Exam'),
    (v_dis_id, 'Hot constitution — warm to touch; consistent with heat pattern and loose stools', 640, 'objective', 'Physical Exam')
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Block 5 done — objective notes';
END $$;
