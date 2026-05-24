-- Migration 052: Create herbs that exist in BHC monographs but were missing
-- from herbal.herbs, and set their monograph URLs.
-- Also sets the monograph URL for Silk Tree (= Mimosa).

SET search_path TO herbal, public;

DO $$
DECLARE
  v_herb_id INTEGER;
BEGIN
  -- Lomatium (Immune system)
  v_herb_id := herbal.ensure_herb('Lomatium dissectum', 'Lomatium');
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1pA3hnhhOUywprp7evXU7RXPK3C7ajELflVib6mBPAjg/edit?usp=classroom_web&authuser=0' WHERE id = v_herb_id;

  -- Red Root (Immune system)
  v_herb_id := herbal.ensure_herb('Ceanothus americanus', 'Red Root');
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1J6XY7bGox2zH3xY1TBNAiF1hiiqxvPUYyfjBpxB36vU/edit?usp=classroom_web&authuser=0' WHERE id = v_herb_id;

  -- Prince Seng (Respiratory) — Pseudostellaria heterophylla, distinct from
  -- Codonopsis/Dang Shen already in the DB
  v_herb_id := herbal.ensure_herb('Pseudostellaria heterophylla', 'Prince Seng');
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1wp7J0Ad9bB7NextaixjiQgvE7t64-NS_AtHMYC73Jfo/edit?usp=classroom_web&authuser=0' WHERE id = v_herb_id;

  -- Blue Vervain (Nervous) — Verbena hastata, distinct from Vervain
  -- (Verbena officinalis) already in the DB
  v_herb_id := herbal.ensure_herb('Verbena hastata', 'Blue Vervain');
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1xPsYvGrH33JXLLSZlC0NuoKGi__JXR_EjUqFEymtBUw/edit?usp=classroom_web&authuser=0' WHERE id = v_herb_id;

  -- Silk Tree = Mimosa (Nervous) — already in DB as Silk Tree
  UPDATE herbal.herbs
    SET monograph_url = 'https://docs.google.com/document/d/1WEoMOIX3mD4Y3Kn0xd9uVYZ9LjFjw4YrB5KlZRD7rtY/edit?usp=classroom_web&authuser=0'
    WHERE common_name = 'Silk Tree';

  RAISE NOTICE 'Missing monograph herbs created and URLs set.';
END $$;
