-- Migration 428: Add Mexican Marigold (Tagetes lucida) with full herb data
-- Mentioned in BHC Class 1 as a ceremonial opening herb ("healing the healer") with digestive use.
-- Checked all five reference books — confirmed absent from each:
--   MM Materia Medica: not found (tagetes lucida added to SYNONYM_MAP as [])
--   Easley's Dispensatory: not found
--   Hoffmann's Medical Herbalism: not found
--   Tilgner's Heart of the Earth: not found
--   Stockley's Drug Interactions: not found
-- Central American ceremonial/medicinal herb not covered by Western reference books.

SET search_path TO herbal, public;

-- Step A: Herb row
INSERT INTO herbal.herbs (common_name, latin_name, plant_part, synonyms)
VALUES (
  'Mexican Marigold',
  'Tagetes lucida',
  'aerial parts',
  ARRAY['Pericón', 'Mexican Mint Marigold', 'Cloud Plant', 'Yauhtli', 'Texas Tarragon', 'Mexican Tarragon', 'Sweet Mace']
)
ON CONFLICT DO NOTHING;

UPDATE herbal.constituent_profiles cp
SET herb_id = h.id
FROM herbal.herbs h
WHERE cp.latin_name = h.latin_name
  AND cp.herb_id IS NULL;

-- Step B: Primary actions
DO $$
DECLARE
  v_herb_id INTEGER;
  v_dig_id  INTEGER;
  v_nerv_id INTEGER;
  v_all_id  INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Tagetes lucida';
  IF v_herb_id IS NULL THEN RAISE NOTICE 'Mexican Marigold not found'; RETURN; END IF;

  SELECT id INTO v_dig_id  FROM herbal.body_systems WHERE name = 'Digestive';
  SELECT id INTO v_nerv_id FROM herbal.body_systems WHERE name = 'Nervous';
  SELECT id INTO v_all_id  FROM herbal.body_systems WHERE name = 'All';

  -- Carminative / Digestive (primary action)
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, 11, v_dig_id,
    'Relieves gas, bloating, and digestive cramping; primary digestive herb used as tea in Mexican and Central American traditional medicine',
    'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Antispasmodic / Digestive
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, 7, v_dig_id,
    'Relaxes intestinal smooth muscle spasms; complements carminative action in colic and cramping',
    'mild')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Digestive Tonic / Digestive
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, 1248, v_dig_id,
    'Mild digestive stimulant used in ceremonial and daily digestive support; warms and activates gut function',
    'mild')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Nervine Relaxant / Nervous
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, 23, v_nerv_id,
    'Mild calming and anxiolytic effect documented in traditional use; complements digestive antispasmodic role',
    'mild')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Diaphoretic / All
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, 51, v_all_id,
    'Traditional use for fever management; promotes perspiration in acute febrile conditions',
    'mild')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  RAISE NOTICE 'Mexican Marigold primary actions: done.';
END $$;

-- Herb constituents
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := (SELECT id FROM herbal.herbs WHERE latin_name = 'Tagetes lucida');
  v_c INTEGER;
BEGIN
  -- estragole: primary — dominant volatile oil (>70% of essential oil); chemotaxonomic marker
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'estragole';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'primary',
    'Dominant volatile oil (>70% of EO); defines the characteristic anise/tarragon aroma; primary chemotaxonomic marker of Tagetes lucida.',
    10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- anethole: major — secondary phenylpropanoid ether
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'anethole';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major',
    'Secondary phenylpropanoid ether in the essential oil; contributes to the anise-like aroma alongside estragole.',
    20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- patuletin: major — NEW constituent; Tagetes-specific flavonol marker
  v_c := herbal.ensure_constituent(
    'patuletin',
    'flavonol',
    'Tagetes-specific methylated flavonol; antioxidant and anti-inflammatory activity; chemotaxonomic marker for Tagetes species.'
  );
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major',
    'Chemotaxonomic marker flavonol specific to Tagetes species; contributes to anti-inflammatory and antispasmodic actions.',
    30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- quercetin: moderate
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'quercetin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', NULL, 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- luteolin: moderate
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'luteolin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', NULL, 50)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- isorhamnetin: minor
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'isorhamnetin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 60)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- beta-caryophyllene: minor
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'beta-caryophyllene';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 70)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- ursolic acid: minor
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'ursolic acid';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 80)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- thymol: minor
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'thymol';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 90)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- linalool: trace
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'linalool';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'trace', NULL, 100)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Mexican Marigold herb_constituents: done.';
END $$;

-- Energetics (inferred: dominant volatile oils → warming/drying; pungent taste from estragole/anethole)
UPDATE herbal.herbs
SET temperature          = 'warming',
    temperature_inferred = true,
    moisture             = 'drying',
    moisture_inferred    = true,
    taste                = 'pungent',
    taste_inferred       = true
WHERE latin_name = 'Tagetes lucida';

-- Menstruum
DO $$
BEGIN
  PERFORM herbal.set_menstruum(
    'Tagetes lucida',
    50::INTEGER,
    70::INTEGER,
    NULL::INTEGER,
    NULL::INTEGER,
    true,
    '50–70% alcohol or water infusion',
    'Volatile oils (estragole, anethole) require moderate-high alcohol for complete extraction; flavonols (quercetin, luteolin, patuletin) extract in both water and alcohol. Traditional use as a tea (pericón infusion) is primary in Mexican and Central American practice.',
    false,
    false,
    false
  );
  RAISE NOTICE 'Mexican Marigold menstruum: done.';
END $$;
