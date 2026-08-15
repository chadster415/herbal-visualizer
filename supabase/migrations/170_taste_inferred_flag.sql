SET search_path TO herbal, public;

-- Add taste_inferred flag to herbs, mirroring temperature_inferred / moisture_inferred.
-- REQUIRES migration 167 (taste column).

ALTER TABLE herbal.herbs
  ADD COLUMN IF NOT EXISTS taste_inferred BOOLEAN NOT NULL DEFAULT FALSE;

DO $$ BEGIN
  RAISE NOTICE 'Added taste_inferred column to herbs table';
END $$;
