-- Migration 098: Rename respiratory body systems for consistent grouping
-- Respiratory         → Respiratory - Overall
-- Lower Respiratory   → Respiratory - Lower
-- Upper Respiratory   → Respiratory - Upper

SET search_path TO herbal, public;

DO $$
BEGIN
  UPDATE herbal.body_systems SET name = 'Respiratory - Lower'   WHERE name = 'Lower Respiratory';
  UPDATE herbal.body_systems SET name = 'Respiratory - Upper'   WHERE name = 'Upper Respiratory';

  RAISE NOTICE 'Respiratory body systems renamed.';
END $$;
