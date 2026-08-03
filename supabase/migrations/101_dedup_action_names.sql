-- Deduplicate primary_actions that differ only by capitalisation.
-- Keeper → Duplicate pairs (all older/lower IDs are kept):
--   22 "Nervine Tonic"         ← 576 "Nervine tonic"
--   23 "Nervine Relaxant"      ← 524 "Nervine relaxant"
--   25 "Immune Support"        ← 596 "Immune support"
--   29 "Circulatory Stimulant" ← 915 "Circulatory stimulant"
--
-- For each junction table we:
--   1. DELETE rows whose (keeper already exists for the same key) to avoid UNIQUE conflicts
--   2. UPDATE remaining dupe rows to point at the keeper
-- Then delete the duplicate primary_action rows.

SET search_path TO herbal, public;

DO $$
DECLARE
  pairs CONSTANT INTEGER[][] := ARRAY[
    ARRAY[22, 576],   -- Nervine Tonic
    ARRAY[23, 524],   -- Nervine Relaxant
    ARRAY[25, 596],   -- Immune Support
    ARRAY[29, 915]    -- Circulatory Stimulant
  ];
  v_pair   INTEGER[];
  v_keeper INTEGER;
  v_dupe   INTEGER;
BEGIN
  FOREACH v_pair SLICE 1 IN ARRAY pairs LOOP
    v_keeper := v_pair[1];
    v_dupe   := v_pair[2];
    RAISE NOTICE 'Merging action id=% into id=%', v_dupe, v_keeper;

    -- herb_primary_actions  UNIQUE(herb_id, primary_action_id, body_system_id)
    DELETE FROM herbal.herb_primary_actions
    WHERE primary_action_id = v_dupe
      AND (herb_id, body_system_id) IN (
        SELECT herb_id, body_system_id
        FROM herbal.herb_primary_actions
        WHERE primary_action_id = v_keeper
      );
    UPDATE herbal.herb_primary_actions
    SET primary_action_id = v_keeper
    WHERE primary_action_id = v_dupe;

    -- disorder_actions_indicated  UNIQUE(disorder_id, primary_action_id)
    DELETE FROM herbal.disorder_actions_indicated
    WHERE primary_action_id = v_dupe
      AND disorder_id IN (
        SELECT disorder_id
        FROM herbal.disorder_actions_indicated
        WHERE primary_action_id = v_keeper
      );
    UPDATE herbal.disorder_actions_indicated
    SET primary_action_id = v_keeper
    WHERE primary_action_id = v_dupe;

    -- disorder_action_herbs  UNIQUE(disorder_id, herb_id, primary_action_id)
    DELETE FROM herbal.disorder_action_herbs
    WHERE primary_action_id = v_dupe
      AND (disorder_id, herb_id) IN (
        SELECT disorder_id, herb_id
        FROM herbal.disorder_action_herbs
        WHERE primary_action_id = v_keeper
      );
    UPDATE herbal.disorder_action_herbs
    SET primary_action_id = v_keeper
    WHERE primary_action_id = v_dupe;

    -- prescription_herb_actions  UNIQUE(prescription_herb_id, primary_action_id)
    DELETE FROM herbal.prescription_herb_actions
    WHERE primary_action_id = v_dupe
      AND prescription_herb_id IN (
        SELECT prescription_herb_id
        FROM herbal.prescription_herb_actions
        WHERE primary_action_id = v_keeper
      );
    UPDATE herbal.prescription_herb_actions
    SET primary_action_id = v_keeper
    WHERE primary_action_id = v_dupe;

    -- action_pattern  (primary_action_id is likely unique — delete dupe if keeper row exists)
    DELETE FROM herbal.action_pattern
    WHERE primary_action_id = v_dupe
      AND EXISTS (
        SELECT 1 FROM herbal.action_pattern WHERE primary_action_id = v_keeper
      );
    UPDATE herbal.action_pattern
    SET primary_action_id = v_keeper
    WHERE primary_action_id = v_dupe;

    -- action_descriptions  (no dupe rows found, but handle defensively)
    DELETE FROM herbal.action_descriptions
    WHERE primary_action_id = v_dupe
      AND EXISTS (
        SELECT 1 FROM herbal.action_descriptions WHERE primary_action_id = v_keeper
      );
    UPDATE herbal.action_descriptions
    SET primary_action_id = v_keeper
    WHERE primary_action_id = v_dupe;

    -- Remove the now-orphaned duplicate action
    DELETE FROM herbal.primary_actions WHERE id = v_dupe;

    RAISE NOTICE 'Done merging id=%', v_dupe;
  END LOOP;
END $$;

-- Verify: no more case duplicates should exist
DO $$
DECLARE
  v_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO v_count
  FROM (
    SELECT LOWER(name)
    FROM herbal.primary_actions
    GROUP BY LOWER(name)
    HAVING COUNT(*) > 1
  ) x;

  IF v_count > 0 THEN
    RAISE EXCEPTION 'Case duplicates still present after dedup — investigation needed';
  END IF;

  RAISE NOTICE 'Verification passed: no case-duplicate primary_actions remain';
END $$;
