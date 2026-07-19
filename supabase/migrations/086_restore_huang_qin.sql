SET search_path TO herbal, public;

-- Migration 085 merged Huang Qin (Scutellaria baicalensis, id=1563) into Western
-- Skullcap (Scutellaria lateriflora, id=142). These are distinct species with different
-- therapeutic profiles (anti-inflammatory/heat-clearing vs. nervine), so the merge
-- was incorrect. This migration reverses it:
--   1. Re-creates herb 1563 as a TCM-only entry
--   2. Redirects dui_yao_pairs and dui_yao_herb_properties back from 142 → 1563
--   3. Clears the incorrectly set pinyin_name from herb 142

-- Re-create Huang Qin with its original ID
INSERT INTO herbal.herbs (id, latin_name, common_name, pinyin_name, is_tcm, created_at)
VALUES (1563, 'Radix Scutellariae Baicalensis', 'Scutellaria / Skullcap Root', 'Huang Qin', TRUE, NOW())
ON CONFLICT (id) DO NOTHING;

-- Redirect pairs: herb 142 had 0 pairs before migration 085, so all current
-- pairs on 142 belong to Huang Qin
UPDATE herbal.dui_yao_pairs SET herb1_id = 1563 WHERE herb1_id = 142;
UPDATE herbal.dui_yao_pairs SET herb2_id = 1563 WHERE herb2_id = 142;

-- Redirect herb properties back
UPDATE herbal.dui_yao_herb_properties SET herb_id = 1563 WHERE herb_id = 142;

-- Remove the incorrectly applied pinyin_name from Scutellaria lateriflora
UPDATE herbal.herbs SET pinyin_name = NULL WHERE id = 142;

DO $$ BEGIN
  RAISE NOTICE 'Migration 086 complete: Huang Qin (id=1563) restored as TCM-only herb; Scutellaria lateriflora (id=142) pairs and pinyin_name corrected.';
END $$;
