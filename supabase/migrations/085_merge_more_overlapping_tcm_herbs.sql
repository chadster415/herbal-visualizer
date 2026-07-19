SET search_path TO herbal, public;

-- Second batch of TCM herbs from migration 081 that duplicate existing Western herbs.
-- Same approach as migration 084: redirect dui_yao_pairs + dui_yao_herb_properties
-- references from TCM IDs → Western IDs, set pinyin_name, then delete TCM rows.
--
-- Note: Shu Di (Cooked Rehmannia, id=1614) is intentionally excluded — it participates
-- in pair 108 paired with Sheng Di (1608→223), so merging both to 223 would create
-- a self-referential (223,223) pair violating the UNIQUE constraint.
--
-- Mapping (TCM id → Western id):
--   1562 Huang Qi      → 225  Astragalus membranaceus
--   1563 Huang Qin     → 142  Scutellaria lateriflora
--   1610 Sheng Ma      →  25  Cimicifuga racemosa
--   1532 Dang Gui      → 1009 Angelica sinensis
--   1608 Sheng Di      → 223  Rehmannia glutinosa
--   1577 Ma Huang      → 448  Ephedra sinica
--   1578 Ma Huang Gen  → 448  Ephedra sinica
--   1519 Chai Hu       → 224  Bupleurum falcatum
--   1531 Dan Shen      → 956  Salvia miltiorrhiza
--   1618 Tao Ren       → 320  Prunus persica
--   1535 Ding Xiang    → 111  Syzygium aromaticum
--   1581 Mo Yao        →  99  Commiphora molmol
--   1634 Yi Mu Cao     → 131  Leonurus cardiaca
--   1617 Tan Xiang     → 413  Santalum album
--   1631 Xuan Fu Hua   →  54  Inula helenium
--   1632 Xuan Shen     →  39  Scrophularia nodosa
--   1645 Zi Hua Di Ding → 198 Viola odorata

DO $$
DECLARE
  tcm_ids  INTEGER[] := ARRAY[1562, 1563, 1610, 1532, 1608, 1577, 1578, 1519, 1531, 1618, 1535, 1581, 1634, 1617, 1631, 1632, 1645];
  west_ids INTEGER[] := ARRAY[ 225,  142,   25, 1009,  223,  448,  448,  224,  956,  320,  111,   99,  131,  413,   54,   39,  198];
  i INTEGER;
BEGIN
  FOR i IN 1..array_length(tcm_ids, 1) LOOP
    UPDATE herbal.dui_yao_pairs
       SET herb1_id = west_ids[i]
     WHERE herb1_id = tcm_ids[i];

    UPDATE herbal.dui_yao_pairs
       SET herb2_id = west_ids[i]
     WHERE herb2_id = tcm_ids[i];

    UPDATE herbal.dui_yao_herb_properties
       SET herb_id = west_ids[i]
     WHERE herb_id = tcm_ids[i];
  END LOOP;

  RAISE NOTICE 'dui_yao_pairs and dui_yao_herb_properties redirected.';
END $$;

-- Set pinyin_name on Western herbs
UPDATE herbal.herbs SET pinyin_name = 'Huang Qi'       WHERE id = 225;   -- Astragalus
UPDATE herbal.herbs SET pinyin_name = 'Huang Qin'      WHERE id = 142;   -- Skullcap (Baical)
UPDATE herbal.herbs SET pinyin_name = 'Sheng Ma'       WHERE id = 25;    -- Black Cohosh
UPDATE herbal.herbs SET pinyin_name = 'Dang Gui'       WHERE id = 1009;  -- Dong Quai
UPDATE herbal.herbs SET pinyin_name = 'Sheng Di'       WHERE id = 223;   -- Rehmannia (uncooked form)
UPDATE herbal.herbs SET pinyin_name = 'Ma Huang'       WHERE id = 448;   -- Ephedra
UPDATE herbal.herbs SET pinyin_name = 'Chai Hu'        WHERE id = 224;   -- Bupleurum
UPDATE herbal.herbs SET pinyin_name = 'Dan Shen'       WHERE id = 956;   -- Dan Shen / Red Sage
UPDATE herbal.herbs SET pinyin_name = 'Tao Ren'        WHERE id = 320;   -- Peach
UPDATE herbal.herbs SET pinyin_name = 'Ding Xiang'     WHERE id = 111;   -- Clove
UPDATE herbal.herbs SET pinyin_name = 'Mo Yao'         WHERE id = 99;    -- Myrrh
UPDATE herbal.herbs SET pinyin_name = 'Yi Mu Cao'      WHERE id = 131;   -- Motherwort
UPDATE herbal.herbs SET pinyin_name = 'Tan Xiang'      WHERE id = 413;   -- Sandalwood
UPDATE herbal.herbs SET pinyin_name = 'Xuan Fu Hua'    WHERE id = 54;    -- Elecampane
UPDATE herbal.herbs SET pinyin_name = 'Xuan Shen'      WHERE id = 39;    -- Figwort
UPDATE herbal.herbs SET pinyin_name = 'Zi Hua Di Ding' WHERE id = 198;   -- Violet

-- Delete orphaned TCM rows (Shu Di 1614 intentionally excluded — see header note)
DELETE FROM herbal.herbs WHERE id IN (1562, 1563, 1610, 1532, 1608, 1577, 1578, 1519, 1531, 1618, 1535, 1581, 1634, 1617, 1631, 1632, 1645);

DO $$ BEGIN
  RAISE NOTICE 'Migration 085 complete: 17 more TCM herbs merged into Western herb rows.';
END $$;
