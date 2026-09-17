-- Migration 336: Class 68 - Integumentary III - Herb Pairs
-- New pair from class notes: Frankincense + Arnica (topical salve for joint inflammation)

SET search_path TO herbal, public;

DO $$
DECLARE
  v_pair_id integer;
BEGIN
  -- Frankincense (id 1597) + Arnica (id 114)
  -- LEAST = 114, GREATEST = 1597
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(114, 1597), GREATEST(114, 1597),
    'BHC Apprenticeship class notes',
    'Combined in a topical salve for chronic joint inflammation. Frankincense provides boswellic acid to reduce volatile acids and systemic joint inflammation; arnica contributes topical anti-inflammatory and analgesic action.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(114, 1597) AND herb2_id = GREATEST(114, 1597);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('chronic joint inflammation', 10),
    ('arthritis', 20),
    ('musculoskeletal pain (topical)', 30)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (114,  'Topical anti-inflammatory and analgesic; reduces bruising and local pain', 10),
    (1597, 'Boswellic acid reduces volatile acids and combats chronic joint inflammation', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);

END $$;
