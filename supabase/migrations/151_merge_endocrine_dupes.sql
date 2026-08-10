-- Migration 151: Merge duplicate herbs created by endocrine system migration
-- Canonical (keep) → Duplicate (remove):
--   133 Lycopus spp. (bugleweed)       ← 2326 Lycopus virginicus
--   14  Panax ginseng (ginseng)        ← 2310 Panax spp.
--   142 Scutellaria lateriflora        ← 2329 Scutellaria spp.
--   59  Thymus vulgaris (thyme)        ← 2254 Thymus spp. (leaf)

SET search_path TO herbal, public;

DO $$
BEGIN

  -- ============================================================
  -- MERGE 1: Lycopus virginicus (2326) → Lycopus spp. (133)
  -- 2326 only appears in disorder_specific_remedies (1 row, no conflict)
  -- ============================================================
  UPDATE herbal.disorder_specific_remedies SET herb_id = 133 WHERE herb_id = 2326;
  DELETE FROM herbal.herbs WHERE id = 2326;
  RAISE NOTICE 'Merged Lycopus virginicus (2326) into Lycopus spp. (133)';


  -- ============================================================
  -- MERGE 2: Panax spp. (2310) → Panax ginseng (14)
  -- ============================================================

  -- disorder_action_herbs: drop conflicts, migrate rest
  DELETE FROM herbal.disorder_action_herbs
    WHERE herb_id = 2310
      AND (disorder_id, primary_action_id) IN (
        SELECT disorder_id, primary_action_id FROM herbal.disorder_action_herbs WHERE herb_id = 14
      );
  UPDATE herbal.disorder_action_herbs SET herb_id = 14 WHERE herb_id = 2310;

  -- disorder_specific_remedies: drop conflicts, migrate rest
  DELETE FROM herbal.disorder_specific_remedies
    WHERE herb_id = 2310
      AND disorder_id IN (
        SELECT disorder_id FROM herbal.disorder_specific_remedies WHERE herb_id = 14
      );
  UPDATE herbal.disorder_specific_remedies SET herb_id = 14 WHERE herb_id = 2310;

  -- herb_primary_actions: drop conflicts, migrate rest
  DELETE FROM herbal.herb_primary_actions
    WHERE herb_id = 2310
      AND (primary_action_id, body_system_id) IN (
        SELECT primary_action_id, body_system_id FROM herbal.herb_primary_actions WHERE herb_id = 14
      );
  UPDATE herbal.herb_primary_actions SET herb_id = 14 WHERE herb_id = 2310;

  DELETE FROM herbal.herbs WHERE id = 2310;
  RAISE NOTICE 'Merged Panax spp. (2310) into Panax ginseng (14)';


  -- ============================================================
  -- MERGE 3: Scutellaria spp. (2329) → Scutellaria lateriflora (142)
  -- ============================================================

  -- herb_primary_actions: drop conflicts, migrate rest
  DELETE FROM herbal.herb_primary_actions
    WHERE herb_id = 2329
      AND (primary_action_id, body_system_id) IN (
        SELECT primary_action_id, body_system_id FROM herbal.herb_primary_actions WHERE herb_id = 142
      );
  UPDATE herbal.herb_primary_actions SET herb_id = 142 WHERE herb_id = 2329;

  -- prescription_herbs: no unique constraint on (prescription_id, herb_id), safe to update
  UPDATE herbal.prescription_herbs SET herb_id = 142 WHERE herb_id = 2329;

  DELETE FROM herbal.herbs WHERE id = 2329;
  RAISE NOTICE 'Merged Scutellaria spp. (2329) into Scutellaria lateriflora (142)';


  -- ============================================================
  -- MERGE 4: Thymus spp. leaf (2254) → Thymus vulgaris (59)
  -- 2254 only has herb_constituents rows (5), no action/disorder data
  -- ============================================================

  -- herb_constituents: drop conflicts, migrate rest
  DELETE FROM herbal.herb_constituents
    WHERE herb_id = 2254
      AND constituent_id IN (
        SELECT constituent_id FROM herbal.herb_constituents WHERE herb_id = 59
      );
  UPDATE herbal.herb_constituents SET herb_id = 59 WHERE herb_id = 2254;

  UPDATE herbal.constituent_profiles SET herb_id = 59 WHERE herb_id = 2254;
  DELETE FROM herbal.herbs WHERE id = 2254;
  UPDATE herbal.herbs SET plant_part = 'leaf' WHERE id = 59;
  RAISE NOTICE 'Merged Thymus spp. leaf (2254) into Thymus vulgaris (59); set plant_part = leaf';

END $$;
