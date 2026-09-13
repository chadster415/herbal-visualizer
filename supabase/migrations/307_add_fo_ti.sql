-- Migration 307: Add Fo Ti (Polygonum multiflorum / He Shou Wu) to herbs
--
-- Sources checked:
--   MM Materia Medica:         NOT found (confirmed absent; SYNONYM_MAP updated)
--   Stockley's Drug Interactions: NOT found
--   Easley's Dispensatory:     FOUND — "HE SHOU WU (HO SHOU WU, FO-TI)"
--     Energetics: Neutral and moistening
--     Dosage: Tincture dried root (1:5, 60% alcohol); 1–5 ml 2–4x/day → 30–150 drops
--     Warnings: Diarrhea, weak digestion, heavy mucus congestion; potential liver toxicity at high doses
--   Hoffmann's Medical Herbalism: NOT found
--   Tilgner's Heart of the Earth: NOT found
--
-- This herb is mentioned in Class 38 (AMAB Repro II) as an adaptogen and reproductive tonic.

SET search_path TO herbal, public;

-- ── Step A: Insert herb row ────────────────────────────────────────────────
INSERT INTO herbal.herbs (common_name, latin_name, plant_part, temperature, moisture, temperature_inferred, moisture_inferred)
VALUES ('Fo Ti', 'Polygonum multiflorum', 'root', 'neutral', 'moistening', false, false)
ON CONFLICT DO NOTHING;

-- Contraindications from Easley
UPDATE herbal.herbs
SET contraindications        = 'Not for persons with diarrhea, weak digestion, or heavy mucus congestion. There is some concern over potential liver toxicity when used in large amounts.',
    contraindications_source = 'Easley'
WHERE latin_name = 'Polygonum multiflorum'
  AND contraindications IS NULL;

-- Synonyms
UPDATE herbal.herbs
SET synonyms = ARRAY['He Shou Wu', 'Ho Shou Wu', 'Shou Wu', 'Fo-Ti']
WHERE latin_name = 'Polygonum multiflorum'
  AND synonyms = '{}';

-- Inferred taste: anthraquinones (emodin) + flavonols (quercetin) + flavan-3-ols → bitter
UPDATE herbal.herbs
SET taste = 'bitter', taste_inferred = true
WHERE latin_name = 'Polygonum multiflorum'
  AND taste IS NULL;

-- ── Step B: Primary actions ────────────────────────────────────────────────
DO $$
DECLARE
  v_herb_id   INTEGER;
  v_sys_id    INTEGER;
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Polygonum multiflorum';
  IF v_herb_id IS NULL THEN RAISE EXCEPTION 'Fo Ti not found — insert failed'; END IF;

  -- Adaptogen → Aging body system
  SELECT id INTO v_sys_id    FROM herbal.body_systems  WHERE name = 'Aging';
  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Adaptogen';
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES
    (v_herb_id, v_action_id, v_sys_id,
     'Classic anti-aging adaptogen; traditionally used to support longevity and prevent premature graying of hair', 'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Tonic → Reproductive - Male
  SELECT id INTO v_sys_id    FROM herbal.body_systems  WHERE name = 'Reproductive - Male';
  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Tonic';
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES
    (v_herb_id, v_action_id, v_sys_id,
     'Reproductive tonic paired with other adaptogens (ginsengs) for AMAB reproductive support', 'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Hypolipidemic → Cardiovascular
  SELECT id INTO v_sys_id    FROM herbal.body_systems  WHERE name = 'Cardiovascular';
  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Hypolipidemic';
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES
    (v_herb_id, v_action_id, v_sys_id,
     'Anticholesteremic action noted in Easley; helps balance blood sugar levels', 'mild')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  RAISE NOTICE 'Fo Ti primary actions: done (herb_id = %)', v_herb_id;
END $$;

-- ── Step C: Herb constituents ──────────────────────────────────────────────
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := (SELECT id FROM herbal.herbs WHERE latin_name = 'Polygonum multiflorum');
  v_c INTEGER;
BEGIN
  -- TSG (2,3,5,4''-tetrahydroxystilbene-2-O-β-D-glucoside) — defining stilbene glycoside; new to DB
  v_c := herbal.ensure_constituent(
    'TSG (tetrahydroxystilbene glucoside)',
    'stilbene glycoside',
    'Primary bioactive of Fo Ti root; responsible for antioxidant, anti-aging, and hepatoprotective activity.'
  );
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'primary', 'Marker; highest in processed (cured) root; drives the anti-aging and hair-darkening traditional reputation.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- emodin (anthraquinone — already in DB, id 888)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'emodin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major', 'Laxative anthraquinone; more prominent in unprocessed root; reduced by traditional curing.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- physcion (anthraquinone — already in DB, id 890)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'physcion';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', NULL, 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- quercetin (flavonol — already in DB, id 741)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'quercetin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- catechin (flavan-3-ol — already in DB, id 753)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'catechin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 50)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Fo Ti herb_constituents: done.';
END $$;

-- ── Step D: Best menstruum ─────────────────────────────────────────────────
-- TSG (stilbene glycoside) + anthraquinones → moderate alcohol; flavonoids → alcohol or water;
-- Easley confirms 60% tincture; traditional decoction also used.
DO $$
BEGIN
  PERFORM herbal.set_menstruum(
    'Polygonum multiflorum',
    50::INTEGER,
    65::INTEGER,
    NULL::INTEGER,
    NULL::INTEGER,
    true,
    '50–65% alcohol or water decoction',
    'TSG (defining stilbene glycoside) and anthraquinones (emodin, physcion) extract in moderate alcohol; flavonoids extract in both alcohol and water. Easley recommends 60% tincture; traditional Chinese preparation is water decoction.',
    false,
    false,
    false
  );
  RAISE NOTICE 'Fo Ti menstruum: done.';
END $$;

-- ── Step E: Re-link constituent_profiles rows (if any with matching latin_name) ──
UPDATE herbal.constituent_profiles cp
SET herb_id = h.id
FROM herbal.herbs h
WHERE cp.latin_name ILIKE '%polygonum multiflorum%'
  AND cp.herb_id IS NULL;


