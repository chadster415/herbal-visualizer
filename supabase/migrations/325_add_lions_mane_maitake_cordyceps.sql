-- Migration 325: Add Lion's Mane, Maitake, and Cordyceps mushrooms
--
-- External reference checks (pre-verified):
--   MM Materia Medica: all three absent (see SYNONYM_MAP entries added to parse-mm-materia-medica.py)
--   Stockley's: all three absent
--   Easley's Dispensatory: Cordyceps and Maitake found; Lion's Mane absent
--   Hoffmann, Tilgner: all three absent
--
-- Energetics sources:
--   Cordyceps — Easley's: "Balancing and slightly warming" → temperature=neutral, moisture=neutral (inferred)
--   Maitake   — Easley's: "Drying and nourishing" → moisture=drying, temperature=neutral (inferred)
--   Lion's Mane — no authoritative source; both neutral/inferred
--
-- New constituents created: erinacines, hericenones, cordycepin
-- Existing compounds used: beta-glucans (916), polysaccharides (1053),
--                           ergosterol (1059), adenosine (984)

SET search_path TO herbal, public;

-- =====================================================================
-- STEP 1: Insert herb rows
-- =====================================================================

INSERT INTO herbal.herbs (common_name, latin_name, plant_part)
VALUES
  ('Lion''s Mane Mushroom', 'Hericium erinaceus',  'fruiting body'),
  ('Maitake',               'Grifola frondosa',    'fruiting body'),
  ('Cordyceps',             'Cordyceps militaris', 'fruiting body')
ON CONFLICT DO NOTHING;

-- =====================================================================
-- STEP 2: Synonyms
-- =====================================================================

DO $$
DECLARE
  v_lm_id  INTEGER;
  v_mt_id  INTEGER;
  v_cd_id  INTEGER;
BEGIN
  SELECT id INTO v_lm_id FROM herbal.herbs WHERE latin_name = 'Hericium erinaceus'  AND plant_part = 'fruiting body';
  SELECT id INTO v_mt_id FROM herbal.herbs WHERE latin_name = 'Grifola frondosa'    AND plant_part = 'fruiting body';
  SELECT id INTO v_cd_id FROM herbal.herbs WHERE latin_name = 'Cordyceps militaris' AND plant_part = 'fruiting body';

  IF v_lm_id IS NULL OR v_mt_id IS NULL OR v_cd_id IS NULL THEN
    RAISE NOTICE 'One or more mushroom herbs not found — skipping synonyms';
    RETURN;
  END IF;

  UPDATE herbal.herbs SET synonyms = ARRAY['Yamabushitake', 'Hou Tou Gu', 'Monkey Head Mushroom', 'Bearded Tooth Mushroom']
  WHERE id = v_lm_id AND (synonyms IS NULL OR synonyms = '{}');

  UPDATE herbal.herbs SET synonyms = ARRAY['Hen of the Woods', 'Dancing Mushroom', 'Sheep''s Head Mushroom', 'Cloud Mushroom']
  WHERE id = v_mt_id AND (synonyms IS NULL OR synonyms = '{}');

  UPDATE herbal.herbs SET synonyms = ARRAY['Caterpillar Fungus', 'Dong Chong Xia Cao', 'Ophiocordyceps sinensis', 'CS-4']
  WHERE id = v_cd_id AND (synonyms IS NULL OR synonyms = '{}');

  RAISE NOTICE 'Mushroom synonyms set: Lion''s Mane=%, Maitake=%, Cordyceps=%', v_lm_id, v_mt_id, v_cd_id;
END $$;

-- =====================================================================
-- STEP 3: Energetics
-- =====================================================================

DO $$
DECLARE
  v_lm_id INTEGER;
  v_mt_id INTEGER;
  v_cd_id INTEGER;
BEGIN
  SELECT id INTO v_lm_id FROM herbal.herbs WHERE latin_name = 'Hericium erinaceus'  AND plant_part = 'fruiting body';
  SELECT id INTO v_mt_id FROM herbal.herbs WHERE latin_name = 'Grifola frondosa'    AND plant_part = 'fruiting body';
  SELECT id INTO v_cd_id FROM herbal.herbs WHERE latin_name = 'Cordyceps militaris' AND plant_part = 'fruiting body';

  -- Lion's Mane: no authoritative source — both inferred
  UPDATE herbal.herbs
  SET temperature = 'neutral', temperature_inferred = true,
      moisture    = 'neutral', moisture_inferred    = true
  WHERE id = v_lm_id;

  -- Maitake: Easley "Drying and nourishing" — moisture from source, temperature inferred
  UPDATE herbal.herbs
  SET temperature = 'neutral', temperature_inferred = true,
      moisture    = 'drying',  moisture_inferred    = false
  WHERE id = v_mt_id;

  -- Cordyceps: Easley "Balancing and slightly warming" → neutral from source, moisture inferred
  UPDATE herbal.herbs
  SET temperature = 'neutral', temperature_inferred = false,
      moisture    = 'neutral', moisture_inferred    = true
  WHERE id = v_cd_id;

  RAISE NOTICE 'Mushroom energetics loaded.';
END $$;

-- =====================================================================
-- STEP 4: Body system actions
-- =====================================================================

DO $$
DECLARE
  v_lm_id     INTEGER;
  v_mt_id     INTEGER;
  v_cd_id     INTEGER;
  v_sys_id    INTEGER;
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_lm_id FROM herbal.herbs WHERE latin_name = 'Hericium erinaceus'  AND plant_part = 'fruiting body';
  SELECT id INTO v_mt_id FROM herbal.herbs WHERE latin_name = 'Grifola frondosa'    AND plant_part = 'fruiting body';
  SELECT id INTO v_cd_id FROM herbal.herbs WHERE latin_name = 'Cordyceps militaris' AND plant_part = 'fruiting body';

  -- ── Lion's Mane ──────────────────────────────────────────────────────────

  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Nervous';

  v_action_id := herbal.ensure_action('Nootropic');
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES
    (v_lm_id, v_action_id, v_sys_id,
     'Stimulates nerve growth factor (NGF) synthesis via erinacines and hericenones; supports memory, focus, and cognitive clarity.',
     'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Nervine Tonic');
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES
    (v_lm_id, v_action_id, v_sys_id,
     'Nourishes and restores nervous system function over time; used for cognitive decline and peripheral neuropathy.',
     'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Immune';

  v_action_id := herbal.ensure_action('Immune Amphoteric');
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES
    (v_lm_id, v_action_id, v_sys_id,
     'Beta-glucans modulate immune response, supporting NK cell and macrophage activity.',
     'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- ── Maitake ──────────────────────────────────────────────────────────────

  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Immune';

  v_action_id := herbal.ensure_action('Immune Amphoteric');
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES
    (v_mt_id, v_action_id, v_sys_id,
     'Beta-glucan D-fraction activates T-cells, NK cells, macrophages, and neutrophils; primary immunomodulator.',
     'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Antiviral');
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES
    (v_mt_id, v_action_id, v_sys_id,
     'Polysaccharide fractions demonstrate antiviral activity in research models.',
     'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Cardiovascular';

  v_action_id := herbal.ensure_action('Hypoglycemic');
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES
    (v_mt_id, v_action_id, v_sys_id,
     'Regulates blood sugar; used for diabetes management and blood glucose control.',
     'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- ── Cordyceps ────────────────────────────────────────────────────────────

  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Respiratory - Lower';

  v_action_id := herbal.ensure_action('Adaptogen');
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES
    (v_cd_id, v_action_id, v_sys_id,
     'Increases oxygen utilization and respiratory capacity; traditionally used to benefit the lungs and kidneys.',
     'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Immune';

  v_action_id := herbal.ensure_action('Immune Amphoteric');
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES
    (v_cd_id, v_action_id, v_sys_id,
     'Anticancer and immune-modulatory polysaccharides; balances immune response.',
     'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Cardiovascular';

  v_action_id := herbal.ensure_action('Cardiotonic');
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES
    (v_cd_id, v_action_id, v_sys_id,
     'Supports cardiovascular system; anticholesteremic effects; used for circulation and vitality.',
     'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  RAISE NOTICE 'Mushroom body system actions loaded.';
END $$;

-- =====================================================================
-- STEP 5: Constituents — create new compounds + assign to herbs
-- =====================================================================

DO $$
DECLARE
  v_lm_id          INTEGER;
  v_mt_id          INTEGER;
  v_cd_id          INTEGER;
  v_erinacines_id  INTEGER;
  v_hericenones_id INTEGER;
  v_cordycepin_id  INTEGER;
  -- existing compound IDs
  c_beta_glucans   CONSTANT INTEGER := 916;
  c_polysaccharides CONSTANT INTEGER := 1053;
  c_ergosterol     CONSTANT INTEGER := 1059;
  c_adenosine      CONSTANT INTEGER := 984;
BEGIN
  SELECT id INTO v_lm_id FROM herbal.herbs WHERE latin_name = 'Hericium erinaceus'  AND plant_part = 'fruiting body';
  SELECT id INTO v_mt_id FROM herbal.herbs WHERE latin_name = 'Grifola frondosa'    AND plant_part = 'fruiting body';
  SELECT id INTO v_cd_id FROM herbal.herbs WHERE latin_name = 'Cordyceps militaris' AND plant_part = 'fruiting body';

  -- Create new constituents
  v_erinacines_id  := herbal.ensure_constituent('erinacines',  'cyathane diterpenoid', 'Diterpenoids from Lion''s Mane mycelium; stimulate nerve growth factor synthesis in neurons; primary neuroprotective bioactives.');
  v_hericenones_id := herbal.ensure_constituent('hericenones', 'aromatic compound',    'Benzyl alcohol derivatives from Lion''s Mane fruiting body; stimulate NGF synthesis and support myelination.');
  v_cordycepin_id  := herbal.ensure_constituent('cordycepin',  'nucleoside analog',    '3''-deoxyadenosine; the defining bioactive of Cordyceps; anti-tumor, anti-inflammatory, and adaptogenic activity.');

  -- ── Lion's Mane herb_constituents ──────────────────────────────────────
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, sort_order, notes)
  VALUES
    (v_lm_id, v_erinacines_id,  'primary',  10, 'Primarily from mycelium; NGF-stimulating diterpenoids; most concentrated in cultivated substrate.'),
    (v_lm_id, v_hericenones_id, 'primary',  20, 'Primarily from fruiting body; NGF-stimulating aromatic compounds.'),
    (v_lm_id, c_beta_glucans,   'major',    30, NULL),
    (v_lm_id, c_ergosterol,     'moderate', 40, NULL)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- ── Maitake herb_constituents ───────────────────────────────────────────
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, sort_order, notes)
  VALUES
    (v_mt_id, c_beta_glucans,    'primary',  10, 'D-fraction and MD-fraction; primary immunomodulating polysaccharides; most researched constituents.'),
    (v_mt_id, c_polysaccharides, 'major',    20, NULL),
    (v_mt_id, c_ergosterol,      'moderate', 30, NULL),
    (v_mt_id, c_adenosine,       'minor',    40, NULL)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- ── Cordyceps herb_constituents ─────────────────────────────────────────
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, sort_order, notes)
  VALUES
    (v_cd_id, v_cordycepin_id,   'primary',  10, 'Defining nucleoside of Cordyceps; anti-tumor, energy-modulating, and adaptogenic; concentration highest in C. militaris.'),
    (v_cd_id, c_adenosine,       'major',    20, NULL),
    (v_cd_id, c_polysaccharides, 'major',    30, NULL),
    (v_cd_id, c_ergosterol,      'moderate', 40, NULL)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Mushroom herb_constituents loaded.';
END $$;

-- =====================================================================
-- STEP 6: Menstruum
-- =====================================================================

DO $$
BEGIN
  PERFORM herbal.set_menstruum(
    'Hericium erinaceus',
    25::INTEGER, 60::INTEGER,
    NULL::INTEGER, NULL::INTEGER,
    true,
    '25–60% alcohol or hot water decoction',
    'Beta-glucans and polysaccharides extract in hot water; erinacines and hericenones require 40–60% alcohol. Traditional use as dual extract (hot water + higher alcohol).',
    false, false, false
  );

  PERFORM herbal.set_menstruum(
    'Grifola frondosa',
    25::INTEGER, 45::INTEGER,
    NULL::INTEGER, NULL::INTEGER,
    true,
    '25–45% alcohol or hot water decoction',
    'Beta-glucan D-fraction and polysaccharides are primary actives; hot water decoction is traditional and most bioavailable form. Moderate alcohol extracts additional minor constituents.',
    false, false, false
  );

  PERFORM herbal.set_menstruum(
    'Cordyceps militaris',
    25::INTEGER, 45::INTEGER,
    NULL::INTEGER, NULL::INTEGER,
    true,
    '25–45% alcohol or hot water decoction',
    'Cordycepin and adenosine extract in 25% alcohol (per Easley); polysaccharides require hot water. Traditional Tibetan use as decoction.',
    false, false, false
  );

  RAISE NOTICE 'Mushroom menstruum data loaded.';
END $$;

-- =====================================================================
-- STEP 7: Keywords
-- =====================================================================

-- Lion's Mane
INSERT INTO herbal.herb_keywords (herb_id, keyword, category)
SELECT h.id, kw.keyword, kw.category
FROM herbal.herbs h
CROSS JOIN (VALUES
  ('cognitive support', 'ailment'),
  ('brain fog',         'ailment'),
  ('anxiety',           'ailment'),
  ('immune support',    'ailment'),
  ('nootropic',         'action'),
  ('adaptogen',         'action'),
  ('nervine',           'action'),
  ('anti-inflammatory', 'action')
) AS kw(keyword, category)
WHERE h.latin_name = 'Hericium erinaceus' AND h.plant_part = 'fruiting body'
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Maitake
INSERT INTO herbal.herb_keywords (herb_id, keyword, category)
SELECT h.id, kw.keyword, kw.category
FROM herbal.herbs h
CROSS JOIN (VALUES
  ('type 2 diabetes',         'ailment'),
  ('blood sugar dysregulation','ailment'),
  ('immune support',          'ailment'),
  ('cancer support',          'ailment'),
  ('hepatitis',               'ailment'),
  ('immune amphoteric',       'action'),
  ('hypoglycemic',            'action'),
  ('antiviral',               'action'),
  ('hepatoprotective',        'action')
) AS kw(keyword, category)
WHERE h.latin_name = 'Grifola frondosa' AND h.plant_part = 'fruiting body'
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Cordyceps
INSERT INTO herbal.herb_keywords (herb_id, keyword, category)
SELECT h.id, kw.keyword, kw.category
FROM herbal.herbs h
CROSS JOIN (VALUES
  ('energy support',    'ailment'),
  ('fatigue',           'ailment'),
  ('respiratory infection','ailment'),
  ('immune support',    'ailment'),
  ('cancer support',    'ailment'),
  ('adaptogen',         'action'),
  ('immune amphoteric', 'action'),
  ('anti-inflammatory', 'action'),
  ('antioxidant',       'action')
) AS kw(keyword, category)
WHERE h.latin_name = 'Cordyceps militaris' AND h.plant_part = 'fruiting body'
ON CONFLICT (herb_id, keyword) DO NOTHING;
