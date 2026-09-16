-- Migration 331: Class 67 (Thyroid) herb pairs
-- Source: BHC - Class 67 - Thyroid - Lisa.md, Poke section
--
-- Pairs from Poke's clinical picture:
--   1. Poke Root + Red Root      — fibrocystic acute breast disease
--   2. Poke Root + Cotton Root Bark — acute mastitis
--   3. Poke Root + Echinacea     — bacterial infections in feeble individuals
--   4. Poke Root + Wild Indigo   — bacterial infections in feeble individuals
--
-- IDs: Poke Root=35, Red Root=981, Echinacea=26, Wild Indigo=23
-- Cotton Root Bark: looked up by name (added in migration 330)

SET search_path TO herbal, public;

-- ============================================================
-- Pair 1: Poke Root (35) + Red Root (981)
-- fibrocystic acute breast disease
-- ============================================================
DO $$
DECLARE
  v_pair_id INT;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(35, 981), GREATEST(35, 981),
    'BHC Apprenticeship class notes',
    'Poke Root and Red Root are a classic pair for lymphatic stagnation with breast involvement. Poke moves deeply congested lymph and immune tissue while Red Root supports lymphatic drainage and reduces congestion in lymphoid tissue. Together they address fibrocystic breast disease and acute mastitis, where fluid stagnation and immune depression co-present.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(35, 981) AND herb2_id = GREATEST(35, 981);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Fibrocystic acute breast disease', 10),
    ('Acute mastitis', 20),
    ('Lymphatic stagnation with immune depression', 30)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id
  );

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (35,  'Moves deeply congested lymph and immune tissue; specific for thyroid hypofunction with fluid retention; dramatic mover of stagnation', 10),
    (981, 'Reduces congestion in lymphoid tissue; supports lymphatic drainage in breast and lymph nodes; specific for fibrocystic breast disease', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id
  );
END $$;

-- ============================================================
-- Pair 2: Poke Root (35) + Cotton Root Bark (looked up)
-- acute mastitis
-- ============================================================
DO $$
DECLARE
  v_cotton_id INT;
  v_pair_id   INT;
BEGIN
  SELECT id INTO v_cotton_id FROM herbal.herbs
  WHERE common_name = 'Cotton Root Bark' AND latin_name ILIKE 'Gossypium%';

  IF v_cotton_id IS NULL THEN
    RAISE NOTICE 'Cotton Root Bark not found — skipping Poke+Cotton pair';
    RETURN;
  END IF;

  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(35, v_cotton_id), GREATEST(35, v_cotton_id),
    'BHC Apprenticeship class notes',
    'Poke Root and Cotton Root Bark are paired for acute mastitis, combining Poke''s ability to move congested lymph and immune depression with Cotton Root Bark''s uterine/breast tissue affinity and decongestant action on reproductive tissues.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(35, v_cotton_id) AND herb2_id = GREATEST(35, v_cotton_id);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Acute mastitis', 10),
    ('Breast tissue congestion with lymphatic involvement', 20)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id
  );

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (35,          'Moves deeply congested lymph; specific for immune depression with fluid retention and lymph node involvement', 10),
    (v_cotton_id, 'Affinity for breast and uterine tissue; decongestant for reproductive and breast tissue in acute mastitis', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id
  );
END $$;

-- ============================================================
-- Pair 3: Poke Root (35) + Echinacea (26)
-- bacterial infections in feeble individuals
-- ============================================================
DO $$
DECLARE
  v_pair_id INT;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(35, 26), GREATEST(35, 26),
    'BHC Apprenticeship class notes',
    'Poke Root and Echinacea are paired for bacterial infections in constitutionally feeble or depleted individuals, where both immune stimulation (Echinacea) and deep lymphatic movement (Poke) are needed to overcome chronic immune depression.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(35, 26) AND herb2_id = GREATEST(35, 26);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Bacterial infections in constitutionally feeble individuals', 10),
    ('Chronic immune depression with lymphatic stagnation', 20)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id
  );

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (35, 'Moves deeply stagnant lymph; restores immune tissue function in the feeble or depleted patient; specific for chronic inflamed lymph nodes', 10),
    (26, 'Stimulates immune response; antimicrobial; supports the body''s active defense against bacterial infection', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id
  );
END $$;

-- ============================================================
-- Pair 4: Poke Root (35) + Wild Indigo / Baptisia (23)
-- bacterial infections in feeble individuals
-- ============================================================
DO $$
DECLARE
  v_pair_id INT;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(35, 23), GREATEST(35, 23),
    'BHC Apprenticeship class notes',
    'Poke Root and Wild Indigo (Baptisia) are paired for bacterial infections in feeble individuals, combining Poke''s lymphatic decongesting action with Baptisia''s strong antimicrobial and immune-stimulating properties — particularly where there is septic or putrid tendency alongside deep lymphatic involvement.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(35, 23) AND herb2_id = GREATEST(35, 23);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Bacterial infections in constitutionally feeble individuals', 10),
    ('Septic or putrid infections with lymphatic depression', 20)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id
  );

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (35, 'Moves deeply stagnant lymph; restores immune tissue in the feeble patient; specific for chronic inflamed neck nodes and immune depression', 10),
    (23, 'Potent antimicrobial and immune stimulant; specific for septic states, putrid infections, and lymph node involvement; thymoleptic action', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id
  );
END $$;
