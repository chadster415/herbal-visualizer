SET search_path TO herbal, public;

ALTER TABLE herbal.herbs
  ADD COLUMN IF NOT EXISTS temperature_inferred BOOLEAN NOT NULL DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS moisture_inferred BOOLEAN NOT NULL DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS tone_inferred BOOLEAN NOT NULL DEFAULT FALSE;

DO $$ BEGIN
  RAISE NOTICE 'Added temperature_inferred, moisture_inferred, tone_inferred columns to herbal.herbs';
END $$;
