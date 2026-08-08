-- Migration 117: Move Laryngitis from Immune to Respiratory - Upper
--
-- Immune had a duplicate Laryngitis disorder (id=42) with only 2 specific
-- remedies (Cayenne, Myrrh). The canonical Laryngitis lives in
-- Respiratory - Upper (id=67) which already has notes, actions, and its own
-- specific remedies. This migration merges the two remedies in and deletes
-- the erroneous Immune disorder.

SET search_path TO herbal, public;

DO $$
DECLARE
  v_immune_disorder_id  INTEGER := 42;  -- Immune / Laryngitis
  v_resp_disorder_id    INTEGER := 67;  -- Respiratory - Upper / Laryngitis
BEGIN
  -- Verify both disorders still exist and are what we expect
  IF NOT EXISTS (
    SELECT 1 FROM herbal.disorders d
    JOIN herbal.body_systems bs ON bs.id = d.body_system_id
    WHERE d.id = v_immune_disorder_id AND d.name = 'Laryngitis' AND bs.name = 'Immune'
  ) THEN
    RAISE EXCEPTION 'Expected Immune Laryngitis (id=%) not found — aborting', v_immune_disorder_id;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM herbal.disorders d
    JOIN herbal.body_systems bs ON bs.id = d.body_system_id
    WHERE d.id = v_resp_disorder_id AND d.name = 'Laryngitis' AND bs.name = 'Respiratory - Upper'
  ) THEN
    RAISE EXCEPTION 'Expected Respiratory - Upper Laryngitis (id=%) not found — aborting', v_resp_disorder_id;
  END IF;

  -- Move specific remedies (Cayenne, Myrrh) into Respiratory - Upper Laryngitis
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  SELECT v_resp_disorder_id, herb_id, description, sort_order
  FROM herbal.disorder_specific_remedies
  WHERE disorder_id = v_immune_disorder_id
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  RAISE NOTICE 'Merged specific remedies from Immune Laryngitis into Respiratory - Upper Laryngitis';

  -- Delete the Immune Laryngitis specific remedies first (FK constraint)
  DELETE FROM herbal.disorder_specific_remedies WHERE disorder_id = v_immune_disorder_id;

  -- Delete the erroneous Immune Laryngitis disorder
  DELETE FROM herbal.disorders WHERE id = v_immune_disorder_id;

  RAISE NOTICE 'Deleted erroneous Immune Laryngitis disorder (id=%)', v_immune_disorder_id;
END $$;
