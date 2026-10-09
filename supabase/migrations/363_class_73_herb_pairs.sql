-- Migration 363: Herb pair from BHC Class 73 — Blood Sugar
-- Source: instructor recommendation, TCM formula for insulin sensitivity
--
-- Pairs added:
--   1. Astragalus (225) + Dong Quai / Angelica sinensis (1009)
--      TCM formula: 5 parts Dang Gui to 1 part Astragalus for insulin sensitivity

SET search_path TO herbal, public;

DO $$
DECLARE
  v_pair_id INTEGER;
BEGIN

  -- ── 1. Astragalus (225) + Dong Quai (1009) ──────────────────────────────────
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(225, 1009), GREATEST(225, 1009),
    'BHC Apprenticeship class notes',
    'Classical TCM formula for insulin sensitivity. The traditional ratio is 5 parts Dang Gui (Angelica sinensis) to 1 part Astragalus. Astragalus improves insulin sensitivity and immune function; Dong Quai tonifies blood and works synergistically in this formula to address wasting and thirsting patterns associated with diabetes.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(225, 1009) AND herb2_id = GREATEST(225, 1009);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Insulin resistance', 10),
    ('Blood sugar dysregulation', 20),
    ('Wasting and thirsting syndrome (diabetes)', 30),
    ('Immune support in diabetic patients', 40)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (225, 'Improves insulin sensitivity; immune tonic; addresses wasting and thirsting pattern', 10),
    (1009, 'Blood tonic; works synergistically with Astragalus in 5:1 Dang Gui:Astragalus ratio', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);

  RAISE NOTICE 'Pair done: Astragalus + Dong Quai (id=%)', v_pair_id;

END $$;
