SET search_path TO herbal, public;

-- Block 0: Add heading column to disorder_notes for SOAP sub-section grouping
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'herbal' AND table_name = 'disorder_notes' AND column_name = 'heading'
  ) THEN
    ALTER TABLE herbal.disorder_notes ADD COLUMN heading TEXT;
    RAISE NOTICE 'Added heading column to disorder_notes';
  ELSE
    RAISE NOTICE 'heading column already exists';
  END IF;
END $$;

-- Block 1: Subjective and Objective notes for GI Case Study
-- sort_orders 200+ for subjective, 600+ for objective (avoids conflicts with general notes 10-170)
DO $$
DECLARE
  v_sys_id INTEGER;
  v_dis_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Digestive';
  SELECT id INTO v_dis_id FROM herbal.disorders WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  -- Subjective: patient demographics (no heading — renders as intro text)
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section, heading)
  VALUES (v_dis_id, 'Carla is 38 years old, 137 lbs, 5''5"', 200, 'subjective', NULL)
  ON CONFLICT DO NOTHING;

  -- Subjective: Primary Health Concerns
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section, heading) VALUES
    (v_dis_id, 'Bloating',     210, 'subjective', 'Primary Health Concerns'),
    (v_dis_id, 'Constipation', 220, 'subjective', 'Primary Health Concerns'),
    (v_dis_id, 'Weight gain',  230, 'subjective', 'Primary Health Concerns'),
    (v_dis_id, 'Low energy',   240, 'subjective', 'Primary Health Concerns')
  ON CONFLICT DO NOTHING;

  -- Subjective: Nutrition
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section, heading) VALUES
    (v_dis_id, 'Avoids gluten and dairy, but not strictly', 250, 'subjective', 'Nutrition'),
    (v_dis_id, 'Reports healthy eating choices, but feels unsatisfied eating alone', 260, 'subjective', 'Nutrition'),
    (v_dis_id, 'Disordered eating with binge or compulsive eating patterns', 270, 'subjective', 'Nutrition'),
    (v_dis_id, 'Drinks 11–15 cups of water daily', 280, 'subjective', 'Nutrition')
  ON CONFLICT DO NOTHING;

  -- Subjective: Elimination
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section, heading) VALUES
    (v_dis_id, 'Urinates every 90 minutes', 290, 'subjective', 'Elimination'),
    (v_dis_id, 'Hard, dry, pellet-like stools', 300, 'subjective', 'Elimination'),
    (v_dis_id, 'Constipation sometimes lasting up to 8 days', 310, 'subjective', 'Elimination')
  ON CONFLICT DO NOTHING;

  -- Subjective: Energy and Mental State
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section, heading) VALUES
    (v_dis_id, 'Low energy, excessive fatigue', 320, 'subjective', 'Energy and Mental State'),
    (v_dis_id, 'Brain fog, anxiety, depression, poor concentration (currently seeing provider for anxiety)', 330, 'subjective', 'Energy and Mental State')
  ON CONFLICT DO NOTHING;

  -- Subjective: Digestive Symptoms
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section, heading) VALUES
    (v_dis_id, 'Heavy stomach', 340, 'subjective', 'Digestive Symptoms'),
    (v_dis_id, 'Bloating after meals', 350, 'subjective', 'Digestive Symptoms'),
    (v_dis_id, 'Hemorrhoids', 360, 'subjective', 'Digestive Symptoms'),
    (v_dis_id, 'Hard, dry stools', 370, 'subjective', 'Digestive Symptoms'),
    (v_dis_id, 'Sugar cravings', 380, 'subjective', 'Digestive Symptoms'),
    (v_dis_id, 'History of IBS as a child', 390, 'subjective', 'Digestive Symptoms')
  ON CONFLICT DO NOTHING;

  -- Subjective: Other Symptoms
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section, heading) VALUES
    (v_dis_id, '"Pass out level" of pain with ovulation', 400, 'subjective', 'Other Symptoms'),
    (v_dis_id, 'Mind-numbing cramping with menses; heavy menses, vaginal dryness, low libido', 410, 'subjective', 'Other Symptoms'),
    (v_dis_id, 'Cold hands and feet', 420, 'subjective', 'Other Symptoms'),
    (v_dis_id, 'Frequent thirst', 430, 'subjective', 'Other Symptoms'),
    (v_dis_id, 'Dizziness from sitting to standing', 440, 'subjective', 'Other Symptoms')
  ON CONFLICT DO NOTHING;

  -- Subjective: Current Supplements
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section, heading) VALUES
    (v_dis_id, 'Morning: Multi-vitamin, B-Complex, Iron, Lysine, L-Tyrosine, Glutamine, Psyllium husk', 450, 'subjective', 'Current Supplements'),
    (v_dis_id, 'Bedtime: Probiotic, Magnesium, Magnesium L-Threonate, L-Theanine', 460, 'subjective', 'Current Supplements')
  ON CONFLICT DO NOTHING;

  -- Objective: Lab Values
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section, heading) VALUES
    (v_dis_id, 'Ferritin: 38 (range 11–307 for adult females) — low-normal', 600, 'objective', 'Lab Values'),
    (v_dis_id, 'TSH: 3.49 (range 0.4–4.0 in adults) — upper side of normal', 610, 'objective', 'Lab Values')
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'GI case study: Subjective and Objective notes inserted';
END $$;
