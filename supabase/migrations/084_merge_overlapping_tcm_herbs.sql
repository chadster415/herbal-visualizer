SET search_path TO herbal, public;

-- Ten TCM herbs inserted in migration 081 are the same plant as existing Western
-- herbs in the DB. They were entered as separate rows (different latin name systems:
-- TCM descriptive vs. Western binomial). This migration:
--   1. Redirects all dui_yao_pairs and dui_yao_herb_properties references
--      from the TCM herb ID → the matching Western herb ID.
--   2. Sets pinyin_name on each Western herb.
--   3. Deletes the now-orphaned TCM herb rows.
--
-- After this migration the Western herb detail page will show Dui Yao pairings.
-- No (herb1_id, herb2_id) uniqueness conflicts exist — verified before writing.
--
-- Mapping (TCM id → Western id):
--   1609 Sheng Jiang  → 124  Zingiber officinale
--   1545 Gan Jiang    → 124  Zingiber officinale
--   1551 Gui Zhi      → 167  Cinnamomum spp.
--   1596 Rou Gui      → 1083 Cinnamomum aromaticum
--   1544 Gan Cao      → 78   Glycyrrhiza glabra
--   1527 Da Huang     → 154  Rheum palmatum
--   1533 Dang Shen    → 271  Codonopsis tangshen
--   1622 Wu Wei Zi    → 17   Schisandra chinensis
--   1588 Pu Gong Ying → 122  Taraxacum officinale
--   1585 Nan Gua Zi   → 183  Cucurbita pepo

DO $$
DECLARE
  tcm_ids  INTEGER[] := ARRAY[1609, 1545, 1551, 1596, 1544, 1527, 1533, 1622, 1588, 1585];
  west_ids INTEGER[] := ARRAY[ 124,  124,  167, 1083,   78,  154,  271,   17,  122,  183];
  i INTEGER;
BEGIN
  FOR i IN 1..array_length(tcm_ids, 1) LOOP
    -- Redirect herb1_id references in pairs
    UPDATE herbal.dui_yao_pairs
       SET herb1_id = west_ids[i]
     WHERE herb1_id = tcm_ids[i];

    -- Redirect herb2_id references in pairs
    UPDATE herbal.dui_yao_pairs
       SET herb2_id = west_ids[i]
     WHERE herb2_id = tcm_ids[i];

    -- Redirect herb_id references in properties
    UPDATE herbal.dui_yao_herb_properties
       SET herb_id = west_ids[i]
     WHERE herb_id = tcm_ids[i];
  END LOOP;

  RAISE NOTICE 'dui_yao_pairs and dui_yao_herb_properties redirected.';
END $$;

-- Set pinyin_name on Western herbs
UPDATE herbal.herbs SET pinyin_name = 'Sheng Jiang / Gan Jiang' WHERE id = 124;  -- ginger (two TCM forms)
UPDATE herbal.herbs SET pinyin_name = 'Gui Zhi'  WHERE id = 167;   -- cinnamon spp. / twig
UPDATE herbal.herbs SET pinyin_name = 'Rou Gui'  WHERE id = 1083;  -- cinnamon bark
UPDATE herbal.herbs SET pinyin_name = 'Gan Cao'  WHERE id = 78;    -- licorice
UPDATE herbal.herbs SET pinyin_name = 'Da Huang' WHERE id = 154;   -- rhubarb
UPDATE herbal.herbs SET pinyin_name = 'Dang Shen' WHERE id = 271;  -- codonopsis
UPDATE herbal.herbs SET pinyin_name = 'Wu Wei Zi' WHERE id = 17;   -- schisandra
UPDATE herbal.herbs SET pinyin_name = 'Pu Gong Ying' WHERE id = 122; -- dandelion
UPDATE herbal.herbs SET pinyin_name = 'Nan Gua Zi'   WHERE id = 183; -- pumpkin

-- Delete the orphaned TCM herb rows (no FK references remain)
DELETE FROM herbal.herbs WHERE id IN (1609, 1545, 1551, 1596, 1544, 1527, 1533, 1622, 1588, 1585);

DO $$ BEGIN
  RAISE NOTICE 'Migration 084 complete: % TCM herbs merged into Western herb rows. Dui Yao pairings now appear on Western herb detail pages.',
    10;
END $$;
