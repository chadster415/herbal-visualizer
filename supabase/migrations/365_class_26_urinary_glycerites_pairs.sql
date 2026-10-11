-- Migration 365: BHC Class 26 - Herb Pairs
-- Source: BHC - Class 26 - Urinary I and Glycerites - Shereel.md
--
-- Pair identified: Juniper (103) + Bayberry (119)
-- Basis: "Native Western American (Navajo) tribes used Juniper along with Bayberry
--         root bark as a tea" — a named traditional pair attributed to Navajo tradition.
--
-- Existing pairs checked: Bearberry + Juniper (Priest & Priest) already exists;
-- Juniper + Bayberry not found in DB.

SET search_path TO herbal, public;

DO $$
DECLARE
  v_pair_id integer;
BEGIN
  -- Juniper (103) + Bayberry (119): LEAST=103, GREATEST=119
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(103, 119), GREATEST(103, 119),
    'BHC Apprenticeship class notes',
    'Traditional Navajo combination of Juniper and Bayberry root bark brewed together as a tea; recorded in BHC Class 26 in the context of urinary and general health support.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(103, 119) AND herb2_id = GREATEST(103, 119);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Traditional Navajo urinary and general health tea', 10),
    ('Urinary tract support', 20)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (103, 'Antimicrobial urinary antiseptic; used for bladder and kidney infections, edema from renal failure, gout, and amenorrhea', 10),
    (119, 'Astringent and antimicrobial; tones mucous membranes; traditionally used as a root bark tea', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);

END $$;
