-- Migration 322: Andrographis paniculata — full herb data
-- herb_id = 2629 (added in migration 318)
-- Sources: Thomas Easley's Dispensatory (energetics, properties, contraindications, dosage)
--          Stockley's Drug Interactions (pages 39–41; images in public/contraindications/2629/)
--          EMA/WHO monograph + PMC metabolomics for constituent_profiles
--          Clinical phytochemistry for herb_constituents

SET search_path TO herbal, public;

-- ── 1. Energetics, taste, contraindications, synonyms ─────────────────────────

UPDATE herbal.herbs
SET
  temperature               = 'cooling',
  temperature_inferred      = false,
  moisture                  = 'drying',
  moisture_inferred         = false,
  taste                     = 'bitter',
  taste_inferred            = false,
  contraindications         = 'Not for use during pregnancy or lactation.',
  contraindications_source  = 'Easley',
  synonyms                  = ARRAY[
    'King of Bitters',
    'Kalmegh',
    'Bhunimba',
    'Chuan Xin Lian',
    'Green Chiretta',
    'Creat'
  ]
WHERE id = 2629;

-- ── 2. Primary actions ─────────────────────────────────────────────────────────
-- Already added in migration 318: Adaptogen / Nervous

DO $$
DECLARE
  v_herb_id  CONSTANT INTEGER := 2629;
  v_immune   CONSTANT INTEGER := 17;  -- Immune body system
  v_digest   CONSTANT INTEGER := 11;  -- Digestive body system
  v_immuno   INTEGER;
  v_antimicr INTEGER;
  v_hepato   INTEGER;
  v_bitter   INTEGER;
  v_cholag   INTEGER;
BEGIN
  SELECT id INTO v_immuno   FROM herbal.primary_actions WHERE name = 'Immunostimulant';
  SELECT id INTO v_antimicr FROM herbal.primary_actions WHERE name = 'Antimicrobial';
  SELECT id INTO v_hepato   FROM herbal.primary_actions WHERE name = 'Antihepatotoxic';
  SELECT id INTO v_bitter   FROM herbal.primary_actions WHERE name = 'Bitter';
  SELECT id INTO v_cholag   FROM herbal.primary_actions WHERE name = 'Cholagogue';

  -- Immune system
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES
    (v_herb_id, v_immuno, v_immune,
     'Clinical trials show Andrographis users were 2× less likely to catch colds; strongly upregulates innate immunity',
     'strong'),
    (v_herb_id, v_antimicr, v_immune,
     'Inhibits Staphylococcus aureus, Pseudomonas aeruginosa, Proteus vulgaris, Shigella dysenteriae, and E. coli; also antiviral against respiratory pathogens',
     'strong'),
    (v_herb_id, v_hepato, v_immune,
     'Inhibits lipid peroxidation; used historically for hepatitis and to support bile flow; andrographolide is the primary hepatoprotective compound',
     'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Digestive system
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES
    (v_herb_id, v_bitter, v_digest,
     'Intensely bitter taste drives digestive secretion and appetite; used in Ayurveda for dyspepsia and diarrhea',
     'strong'),
    (v_herb_id, v_cholag, v_digest,
     'Promotes bile flow; indicated for lack of bile flow and support of fat digestion',
     'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  RAISE NOTICE 'Andrographis primary actions: done.';
END $$;

-- ── 3. Secondary actions ───────────────────────────────────────────────────────

DO $$
DECLARE
  v_herb_id  CONSTANT INTEGER := 2629;
  v_all_sys  CONSTANT INTEGER := 21;  -- All body systems
  v_anti_inf INTEGER;
  v_febri_id INTEGER;
BEGIN
  SELECT id INTO v_anti_inf FROM herbal.secondary_actions WHERE name = 'Anti-inflammatory';

  -- Ensure Febrifuge exists in secondary_actions
  INSERT INTO herbal.secondary_actions (name) VALUES ('Febrifuge')
  ON CONFLICT (name) DO NOTHING;
  SELECT id INTO v_febri_id FROM herbal.secondary_actions WHERE name = 'Febrifuge';

  INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
  VALUES
    (v_herb_id, v_anti_inf, v_all_sys),
    (v_herb_id, v_febri_id, v_all_sys)
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Andrographis secondary actions: done.';
END $$;

-- ── 4. constituent_profiles ────────────────────────────────────────────────────
-- Source: EMA assessment report (drawing on WHO monograph) + PMC metabolomics
-- Four principal diterpenoids confirmed across all aerial plant parts

DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := 2629;
  v_editorial TEXT := 'Andrographis paniculata aerial parts are chemically defined by intensely bitter labdane diterpene lactones, especially andrographolide and closely related deoxyandrographolides, together with the glycoside neoandrographolide. These constituents support the herb''s characteristic anti-inflammatory, immunomodulatory, antimicrobial/anti-infective, antipyretic, and hepatoprotective actions, consistent with its traditional use for febrile and respiratory infections and digestive/hepatic complaints. Andrographolide provides the strongest individual chemical marker, while the related diterpenoids capture the broader medicinal activity of the whole herb.';
BEGIN
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part,
     constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb_id, 'Andrographis', 'Andrographis paniculata', 'Aerial parts',
     'Andrographolide', 'Terpenoid', 'Labdane diterpenoid lactone',
     'High', 'Marker',
     'Principal characteristic bitter diterpene lactone associated especially with anti-inflammatory, immunomodulatory, antimicrobial, and hepatoprotective activity.',
     v_editorial),

    (v_herb_id, 'Andrographis', 'Andrographis paniculata', 'Aerial parts',
     '14-Deoxy-11,12-didehydroandrographolide', 'Terpenoid', 'Labdane diterpenoid lactone',
     'High', 'Marker',
     'Major characteristic diterpenoid associated with immunomodulatory, anti-infective, and cardiovascular activity.',
     NULL),

    (v_herb_id, 'Andrographis', 'Andrographis paniculata', 'Aerial parts',
     'Neoandrographolide', 'Glycoside', 'Diterpenoid glycoside',
     'High', 'Major',
     'Characteristic glucosylated labdane diterpenoid associated with anti-inflammatory, anti-infective, and hepatoprotective effects.',
     NULL),

    (v_herb_id, 'Andrographis', 'Andrographis paniculata', 'Aerial parts',
     '14-Deoxyandrographolide', 'Terpenoid', 'Labdane diterpenoid lactone',
     'High', 'Major',
     'Abundant diterpenoid contributing to the herb''s immunomodulatory and anti-inflammatory pharmacology.',
     NULL)
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Andrographis constituent_profiles: done.';
END $$;

-- ── 5. herb_constituents ───────────────────────────────────────────────────────
-- Diterpenoids (10–40) researched from EMA/PMC; shared compounds (50–130) from corpus

DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := 2629;
  v_c INTEGER;
BEGIN
  -- Andrographolide: primary marker diterpene lactone
  v_c := herbal.ensure_constituent(
    'andrographolide',
    'Diterpene lactone',
    'Primary bioactive labdane diterpene of Andrographis paniculata; responsible for immunostimulant, anti-inflammatory, and hepatoprotective activity.'
  );
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'primary',
          'Marker. 1–3% in leaves; used as the standard quality-control marker for this herb.',
          10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- 14-Deoxy-11,12-didehydroandrographolide: second marker diterpenoid
  v_c := herbal.ensure_constituent(
    '14-deoxy-11,12-didehydroandrographolide',
    'Diterpene lactone',
    'Major labdane diterpene lactone of Andrographis paniculata; contributes to immunomodulatory, anti-infective, and cardiovascular activity.'
  );
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major', 'Marker. Consistently quantified alongside andrographolide in quality-control analyses.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Neoandrographolide: glucosylated diterpenoid
  v_c := herbal.ensure_constituent(
    'neoandrographolide',
    'Diterpenoid glycoside',
    'Glucosylated labdane diterpenoid of Andrographis paniculata; anti-inflammatory, anti-infective, and hepatoprotective.'
  );
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major', NULL, 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- 14-Deoxyandrographolide: abundant diterpenoid
  v_c := herbal.ensure_constituent(
    '14-deoxyandrographolide',
    'Diterpene lactone',
    'Abundant labdane diterpene lactone of Andrographis paniculata; contributes to immunomodulatory and anti-inflammatory pharmacology.'
  );
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major', NULL, 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Quercetin (already in DB)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'quercetin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', NULL, 50)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Beta-sitosterol (already in DB)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'beta-sitosterol';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', NULL, 60)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Luteolin (already in DB)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'luteolin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 70)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Apigenin (already in DB)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'apigenin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 80)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Chlorogenic acid (already in DB)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'chlorogenic acid';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 90)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Caffeic acid (already in DB)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'caffeic acid';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 100)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Ursolic acid (already in DB)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'ursolic acid';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 110)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Oleanolic acid (already in DB)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'oleanolic acid';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 120)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Stigmasterol (already in DB)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'stigmasterol';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'trace', NULL, 130)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Andrographis herb_constituents: done.';
END $$;

-- ── 6. Menstruum ───────────────────────────────────────────────────────────────
-- Andrographolide and diterpene lactones: 40–70% alcohol
-- Flavonoids (quercetin, luteolin, apigenin): 25–60% alcohol or water
-- Easley specifies dried leaf 1:5, 50% alcohol; standard infusion works (water extracts actives)
-- Overall: 45–60% alcohol; water also effective

DO $$
BEGIN
  PERFORM herbal.set_menstruum(
    'Andrographis paniculata',
    45::INTEGER,
    60::INTEGER,
    NULL::INTEGER,
    NULL::INTEGER,
    true,
    '45–60% alcohol or water infusion',
    'Andrographolide and related diterpene lactones extract in 40–70% alcohol; flavonoids also extract in water. Standard infusion is effective but intensely bitter. Easley specifies 1:5, 50% alcohol for dried leaf tincture.',
    false,
    false,
    false
  );
  RAISE NOTICE 'Andrographis menstruum: done.';
END $$;
