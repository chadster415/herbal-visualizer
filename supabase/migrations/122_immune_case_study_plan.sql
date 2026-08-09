SET search_path TO herbal, public;

-- Immune case study (Peter) — Assessment and Plan.
-- Continues from migration 121 (Subjective / Objective).
-- Adds: lifestyle notes (general), actions indicated, disorder action herbs,
--       EoE tincture prescription, and herb_primary_actions sync.

-- Block 1: Lifestyle notes and actions indicated
DO $$
DECLARE
  v_sys_id    INTEGER;
  v_dis_id    INTEGER;
  v_action_id INTEGER;
  v_herb_id   INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Immune';
  SELECT id INTO v_dis_id FROM herbal.disorders WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  -- Lifestyle / Plan notes (general section, sort_order 10–90)
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section) VALUES
    (v_dis_id, '1/4 tsp sea salt in warm water each morning', 10, 'general'),
    (v_dis_id, 'Marshmallow root overnight cold infusion — suspend herb in cold water overnight and drink in the morning', 20, 'general'),
    (v_dis_id, 'Eliminate red meat for 2 weeks, then eliminate beer for 2 weeks — assess each change separately', 30, 'general'),
    (v_dis_id, 'Keep a food and drink journal; record timing and circumstances of vomiting or choking episodes', 40, 'general'),
    (v_dis_id, 'Low-histamine and high-histamine foods list provided', 50, 'general'),
    (v_dis_id, '2 tablespoons ground flax seed daily', 60, 'general'),
    (v_dis_id, 'Quercetin supplement: 50mg 2× daily', 70, 'general')
  ON CONFLICT DO NOTHING;

  -- Actions Indicated
  v_action_id := herbal.ensure_action('Anti-allergic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Stabilize mast cells and inhibit eosinophil-mediated allergic signaling driving esophageal inflammation.', 10)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Antihistamine');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Suppress histamine release to reduce hypersensitivity response in the esophagus.', 20)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Anti-inflammatory');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Reduce chronic esophageal inflammation and overall systemic inflammatory burden.', 30)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Immune Modulator');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Regulate aberrant immune responses; shift away from the Th2-dominant allergic pattern underlying EoE.', 40)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Demulcent');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Soothe and protect the esophageal mucosa; support mucosal barrier integrity against repeated inflammatory insult.', 50)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  -- Disorder action herbs: Anti-allergic
  v_action_id := herbal.ensure_action('Anti-allergic');
  v_herb_id := herbal.ensure_herb('Paeonia lactiflora', 'White Peony');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Scutellaria baicalensis', 'Chinese Skullcap');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 20) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Albizia lebbeck', 'Albizia');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 30) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Disorder action herbs: Antihistamine
  v_action_id := herbal.ensure_action('Antihistamine');
  v_herb_id := herbal.ensure_herb('Scutellaria baicalensis', 'Chinese Skullcap');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Disorder action herbs: Anti-inflammatory
  v_action_id := herbal.ensure_action('Anti-inflammatory');
  v_herb_id := herbal.ensure_herb('Scutellaria baicalensis', 'Chinese Skullcap');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Astragalus membranaceus', 'Astragalus');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 20) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Disorder action herbs: Immune Modulator
  v_action_id := herbal.ensure_action('Immune Modulator');
  v_herb_id := herbal.ensure_herb('Astragalus membranaceus', 'Astragalus');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Disorder action herbs: Demulcent
  v_action_id := herbal.ensure_action('Demulcent');
  v_herb_id := herbal.ensure_herb('Althaea officinalis', 'marshmallow');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  RAISE NOTICE 'Immune case study: lifestyle notes and actions inserted';
END $$;

-- Block 2: EoE Tincture prescription
DO $$
DECLARE
  v_sys_id  INTEGER;
  v_dis_id  INTEGER;
  v_rx_id   INTEGER;
  v_herb_id INTEGER;
  v_ph_id   INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Immune';
  SELECT id INTO v_dis_id FROM herbal.disorders WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_dis_id, 'EoE Tincture', '1 tsp 3× daily.', 10)
  ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Paeonia lactiflora', 'White Peony');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
    VALUES (v_rx_id, v_herb_id, '20 drops', 'inhibits mast cell mediated allergic response', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-allergic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Scutellaria baicalensis', 'Chinese Skullcap');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
    VALUES (v_rx_id, v_herb_id, '30 drops', 'inhibits mast cell activation; suppresses histamine; inhibits anaphylaxis', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-allergic'))    ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antihistamine'))    ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Astragalus membranaceus', 'Astragalus');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
    VALUES (v_rx_id, v_herb_id, '40 drops', 'immune regulation; anti-inflammatory', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Immune Modulator'))  ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Albizia lebbeck', 'Albizia');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
    VALUES (v_rx_id, v_herb_id, '60 drops', 'double down on mast cell stabilizing and inhibiting signals', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-allergic')) ON CONFLICT DO NOTHING;
  END IF;

  RAISE NOTICE 'Immune case study: EoE tincture inserted';
END $$;

-- Block 3: Sync prescription herb actions → herb_primary_actions for Immune
DO $$
DECLARE v_sys_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Immune';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT DISTINCT ph.herb_id, pha.primary_action_id, v_sys_id
  FROM herbal.prescription_herb_actions pha
  JOIN herbal.prescription_herbs ph ON ph.id = pha.prescription_herb_id
  JOIN herbal.disorder_prescriptions dp ON dp.id = ph.prescription_id
  JOIN herbal.disorders d ON d.id = dp.disorder_id
  WHERE d.body_system_id = v_sys_id AND d.is_case_study = TRUE
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  RAISE NOTICE 'Immune case study: herb_primary_actions synced';
END $$;
