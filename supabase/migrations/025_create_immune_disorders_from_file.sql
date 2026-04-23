-- Create Immune System disorders from "Immune System 2.md"
-- This migration creates the disorder entries that will receive specific remedies

SET search_path TO herbal, public;

-- ============================================================================
-- CREATE IMMUNE SYSTEM DISORDERS
-- ============================================================================

DO $$
DECLARE
  v_immune_system_id INTEGER;
  v_disorder_id INTEGER;
  v_sort_order INTEGER := 100; -- Start after existing disorders
BEGIN
  SELECT id INTO v_immune_system_id FROM herbal.body_systems WHERE name = 'Immune';

  IF v_immune_system_id IS NULL THEN
    RAISE EXCEPTION 'Immune system not found';
  END IF;

  -- Ear Infections
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Ear Infections', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Sore Throat
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Sore Throat', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Congestion
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Congestion', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Swollen Glands
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Swollen Glands', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Mumps
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Mumps', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Flu
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Flu', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Colds
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Colds', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Cough (soothe)
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Cough (soothe)', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Cough (suppress)
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Cough (suppress)', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Laryngitis
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Laryngitis', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Acute Bronchitis
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Acute Bronchitis', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Pneumonia
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Pneumonia', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Colic/Gastritis
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Colic/Gastritis', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Constipation
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Constipation', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Diarrhea
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Diarrhea', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Nausea
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Nausea', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Fevers
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Fevers', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Chicken Pox
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Chicken Pox', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Restlessness
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Restlessness', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;

  RAISE NOTICE 'Immune system disorders created successfully';
END $$;

-- ============================================================================
-- SUMMARY
-- ============================================================================
-- This migration creates disorder entries for all conditions from "Immune System 2.md"
-- These disorders will be populated with specific remedies by migration 024
