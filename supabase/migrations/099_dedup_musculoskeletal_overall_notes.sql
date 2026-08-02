-- Migration 099: Remove duplicate disorder_notes for all Musculoskeletal disorders.
-- All notes appear twice because migration 096 was re-run without a unique
-- constraint on (disorder_id, sort_order). Keep the lowest id per
-- (disorder_id, sort_order, note_text) group and delete the rest.

SET search_path TO herbal, public;

DO $$
DECLARE
  v_sys_id INTEGER;
  v_deleted INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Musculoskeletal';

  DELETE FROM herbal.disorder_notes
  WHERE disorder_id IN (
    SELECT id FROM herbal.disorders WHERE body_system_id = v_sys_id
  )
  AND id NOT IN (
    SELECT MIN(id)
    FROM herbal.disorder_notes
    WHERE disorder_id IN (
      SELECT id FROM herbal.disorders WHERE body_system_id = v_sys_id
    )
    GROUP BY disorder_id, sort_order, note_text
  );

  GET DIAGNOSTICS v_deleted = ROW_COUNT;
  RAISE NOTICE 'Musculoskeletal: % duplicate notes removed.', v_deleted;
END $$;
