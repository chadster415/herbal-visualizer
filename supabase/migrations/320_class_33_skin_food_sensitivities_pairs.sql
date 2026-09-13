-- Migration 320: Herb pair — Tea Tree + Lavender (Class 33 Wound Care)
--
-- Instructor explicitly noted that Tea Tree covers gram-negative bacteria
-- (E. coli) and Lavender covers gram-positive bacteria (staph, MRSA),
-- and that together they "sidestep the antibiotic resistance issue."
-- This is a species-complementary antimicrobial pair endorsed as protocol.
--
-- herb1_id = LEAST(82, 302) = 82  (Lavender)
-- herb2_id = GREATEST(82, 302) = 302 (Tea Tree)

SET search_path TO herbal, public;

DO $$
DECLARE
  v_pair_id INTEGER;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    82, 302,
    'BHC Apprenticeship class notes',
    'Together, Lavender and Tea Tree provide complementary broad-spectrum antimicrobial coverage: Tea Tree targets gram-negative bacteria (E. coli) and Lavender targets gram-positive bacteria (staph, MRSA). Used together in the wound care wet wipe protocol, they sidestep antibiotic resistance by covering both bacterial categories simultaneously without relying on single-spectrum antibiotics.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id
  FROM herbal.herb_pairs
  WHERE herb1_id = 82 AND herb2_id = 302;

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Wound care and skin infection', 10),
    ('Gram-positive and gram-negative bacterial coverage', 20),
    ('Antibiotic-resistance-aware wound protocols', 30)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id
  );

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (82,  'Antimicrobial against gram-positive bacteria including staph and MRSA; vulnerary; used in wound wipe solution to reduce gram-positive microbial load', 10),
    (302, 'Antimicrobial against gram-negative bacteria including E. coli; broad-spectrum antiseptic; used in wound wipe solution to reduce gram-negative microbial load', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id
  );

  RAISE NOTICE 'Tea Tree + Lavender herb pair inserted (pair_id = %).', v_pair_id;
END $$;
