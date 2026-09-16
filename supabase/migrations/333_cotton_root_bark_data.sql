-- Migration 333: Enrich Cotton Root Bark (Gossypium herbaceum, id=2635)
-- Sources:
--   Easley's Dispensatory: energetics, contraindications, dosage, specific indications
--   MM Materia Medica: tincture dosages (lines 938-940)
--   Stockley's: not listed
--   Hoffmann's: not listed
--
-- Easley summary:
--   Uses: menstrual cramping with scanty bleeding; induce/support labor contractions;
--         Felter indications: tardy menstruation with backache and dragging pelvic pain;
--         fullness and weight in bladder with difficult micturition; sexual lassitude with
--         anemia; hysteria with pelvic atony and anemia.
--   Properties: Abortifacient and emmenagogue
--   Energetics: Warming and moistening (confirmed)
--   Warnings: Avoid during pregnancy — abortifacient; causes uterine contractions
--   Dosage: Freshly dried root (1:4, 50% alcohol); 2–4 ml 1–3× daily
-- MM dosage: Fresh Bark Tincture [1:2] 30–60 drops to 3×/day;
--            Dry Bark [1:5, 50%] 1–2 tsp to 4×/day
-- te-materia-medica.ts: 2635 → { min: 60, max: 120 }  (Easley: 2–4 ml = 60–120 drops)

SET search_path TO herbal, public;

-- ============================================================
-- Energetics, contraindications, synonyms
-- ============================================================
UPDATE herbal.herbs
SET temperature            = 'warming',
    temperature_inferred   = false,
    moisture               = 'moistening',
    moisture_inferred      = false,
    taste                  = 'bitter',
    taste_inferred         = true,
    contraindications      = 'Avoid during pregnancy — abortifacient; causes uterine contractions. Avoid in cases of active uterine inflammation.',
    contraindications_source = 'Easley''s Dispensatory',
    synonyms               = ARRAY['Cotton Root', 'Gossypium', 'Levant Cotton']
WHERE id = 2635;

-- ============================================================
-- Primary actions
-- ============================================================
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := 2635;
  v_repro_f INTEGER;
  v_urinary INTEGER;
BEGIN
  SELECT id INTO v_repro_f FROM herbal.body_systems WHERE name = 'Reproductive - Female';
  SELECT id INTO v_urinary FROM herbal.body_systems WHERE name = 'Urinary';

  -- Emmenagogue — Reproductive Female
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES
    (v_herb_id, 15, v_repro_f,
     'Stimulates tardy or suppressed menstruation; specific for scanty menses with backache and dragging pelvic pain (Felter)',
     'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Uterine Tonic — Reproductive Female
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES
    (v_herb_id, 509, v_repro_f,
     'Addresses pelvic atony and sexual lassitude with anemia; used to support and strengthen uterine contractions during labor',
     'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Antispasmodic — Reproductive Female
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES
    (v_herb_id, 7, v_repro_f,
     'Used for menstrual cramping; relaxes uterine spasm while simultaneously stimulating menstrual flow',
     'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Diuretic — Urinary
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES
    (v_herb_id, 14, v_urinary,
     'Felter specific indication: fullness and weight in the bladder with difficult micturition',
     'mild')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  RAISE NOTICE 'Cotton Root Bark primary actions: done.';
END $$;

-- ============================================================
-- Herb constituents (General Constituents)
-- Gossypol (1025, primary), quercetin (741, moderate),
-- caffeic acid (784, minor), beta-sitosterol (857, minor)
-- ============================================================
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := 2635;
BEGIN
  -- Gossypol — primary/defining sesquiterpene aldehyde
  INSERT INTO herbal.herb_constituents
    (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES
    (v_herb_id, 1025, 'primary',
     'Defining polyphenolic sesquiterpene aldehyde; responsible for abortifacient, emmenagogue, and antibacterial activity',
     10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Quercetin — moderate flavonoid
  INSERT INTO herbal.herb_constituents
    (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES
    (v_herb_id, 741, 'moderate', NULL, 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Caffeic acid — minor phenylpropanoid
  INSERT INTO herbal.herb_constituents
    (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES
    (v_herb_id, 784, 'minor', NULL, 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Beta-sitosterol — minor sterol
  INSERT INTO herbal.herb_constituents
    (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES
    (v_herb_id, 857, 'minor', NULL, 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Cotton Root Bark herb_constituents: done.';
END $$;

-- ============================================================
-- Menstruum
-- Gossypol and resins → 50–70% alcohol; quercetin/caffeic acid
-- also extract in water; decoction is a traditional form (Easley).
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.set_menstruum(
    'Gossypium herbaceum',
    50::INTEGER,
    70::INTEGER,
    NULL::INTEGER,
    NULL::INTEGER,
    true,
    '50–70% alcohol or water decoction',
    'Gossypol and resins require moderate–high alcohol (50–70%). Flavonoids and phenylpropanoids extract in both alcohol and water. Easley lists standard decoction (1–2 oz 3×/day) as a valid preparation alongside tincture.',
    false,
    false,
    false
  );
  RAISE NOTICE 'Cotton Root Bark menstruum: done.';
END $$;

-- ============================================================
-- Herb keywords
-- ============================================================
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2635, 'dysmenorrhea',        'ailment'),
  (2635, 'amenorrhea',          'ailment'),
  (2635, 'mastitis',            'ailment'),
  (2635, 'breast cysts',        'ailment'),
  (2635, 'reproductive support','ailment'),
  (2635, 'emmenagogue',         'action'),
  (2635, 'uterine tonic',       'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;
