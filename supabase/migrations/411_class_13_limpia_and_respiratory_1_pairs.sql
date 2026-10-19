-- Migration 411: Class 13 — Limpia and Respiratory 1 herb pairs
-- Source: BHC - Class 13 - Limpia and Respiratory 1 - Rose.md
--
-- Two pairs identified:
-- 1. Elecampane (id=54) + Thyme (id=59): "mixes well with thyme; goes nicely with a thyme honey"
-- 2. Osha (id=104) + Marshmallow (id=45): "warming and drying, so use with damp/cool coughs, or make with marshmallow"

SET search_path TO herbal, public;

-- Pair 1: Elecampane + Thyme
-- herb1_id = LEAST(54,59) = 54, herb2_id = GREATEST(54,59) = 59
DO $$
DECLARE
  v_pair_id INTEGER;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(54, 59), GREATEST(54, 59),
    'BHC Apprenticeship class notes',
    'Elecampane and Thyme are a natural pairing for respiratory infection and irritable cough. Elecampane is both a relaxing and stimulating expectorant (mucilage soothes, essential oil promotes expectoration); Thyme is antimicrobial and antitussive. Together they combine broad-spectrum respiratory action. Instructor note: "mixes well with thyme" and "goes nicely with a thyme honey."'
  )
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET combined_summary = herbal.herb_pairs.combined_summary
                           || ' | BHC class notes: '
                           || EXCLUDED.combined_summary;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(54, 59) AND herb2_id = GREATEST(54, 59);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Irritable and spasmodic cough',           10),
    ('Bronchitis with infection',               20),
    ('Upper respiratory infection',             30),
    ('Chronic respiratory congestion',          40)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (54, 'Relaxing and stimulating expectorant; mucilage soothes irritation while essential oil promotes expectoration; antiviral and antimicrobial; appropriate across most lung conditions', 10),
    (59, 'Antimicrobial and antitussive; works synergistically with Elecampane in honey preparations for respiratory infections', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
END $$;

-- Pair 2: Marshmallow + Osha
-- herb1_id = LEAST(45,104) = 45, herb2_id = GREATEST(45,104) = 104
DO $$
DECLARE
  v_pair_id INTEGER;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(45, 104), GREATEST(45, 104),
    'BHC Apprenticeship class notes',
    'Osha is a warming, drying stimulating expectorant and bronchodilator — powerful but potentially too drying for some patients. Marshmallow counterbalances Osha''s drying action with its demulcent, mucilaginous quality, protecting mucous membranes while preserving Osha''s antiviral and bronchodilating benefits. Instructor note: "warming and drying, so use with damp/cool coughs, or make with marshmallow."'
  )
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET combined_summary = herbal.herb_pairs.combined_summary
                           || ' | BHC class notes: '
                           || EXCLUDED.combined_summary;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(45, 104) AND herb2_id = GREATEST(45, 104);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Respiratory infection with dry or sensitive mucous membranes', 10),
    ('Cold and damp cough requiring warming + membrane protection',  20),
    ('Bronchitis where bronchodilation is needed without drying',    30)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (45,  'Demulcent; moistens and protects mucous membranes; counterbalances Osha''s drying action', 10),
    (104, 'Warming, drying stimulating expectorant; powerful antiviral and diaphoretic; bronchodilator; use at first sign of infection', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
END $$;
