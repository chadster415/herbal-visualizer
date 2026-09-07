-- Migration 282: BHC Class 40 — Jamaican Dogwood + Pedicularis herb pair
--
-- Source: BHC - Class 40 - Musculoskeletal I and II - Lisa.md
--   "skeletal pain + black cohosh, pedicularis" (Jamaican Dogwood section)
--   Transcript confirms: "For skeletal muscle pain: black cohosh, Pedicularis"
--
-- Jamaican Dogwood (2461) + Pedicularis densiflora (2624)
-- Skipped in migration 276 because Pedicularis was not yet in the DB.
-- Black Cohosh pair (2461+25) already added in migration 276.

SET search_path TO herbal, public;

DO $$
DECLARE v_pair_id int;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(2461, 2624), GREATEST(2461, 2624),
    'BHC Apprenticeship class notes',
    'Jamaican Dogwood pairs with Pedicularis for skeletal muscle pain — Jamaican Dogwood targets smooth muscle pain and nervous irritability while Pedicularis provides direct skeletal muscle relaxation and antispasmodic activity. Together they address both the nervous-system and mechanical components of musculoskeletal pain.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(2461, 2624) AND herb2_id = GREATEST(2461, 2624);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Skeletal muscle pain with nervous irritability', 10),
    ('Chronic musculoskeletal tension and spasm', 20)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (2461, 'Targets smooth muscle pain, nervous irritability, and sedation; bridges the nervous system and musculoskeletal pain components', 10),
    (2624, 'Premier skeletal muscle relaxant; directly addresses muscle tension, spasm, and holding patterns', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
END $$;
