SET search_path TO herbal, public;

-- Add temperature field to supplements for energetic exceptions
-- By default, minerals are cooling; this column captures explicit overrides.
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'herbal' AND table_name = 'supplements' AND column_name = 'temperature'
  ) THEN
    ALTER TABLE herbal.supplements ADD COLUMN temperature TEXT DEFAULT NULL;
    RAISE NOTICE 'Added temperature column to supplements';
  ELSE
    RAISE NOTICE 'temperature column already exists';
  END IF;
END $$;

-- Iron is warming, not cooling (exception to the general mineral rule)
DO $$
BEGIN
  UPDATE herbal.supplements SET temperature = 'warming' WHERE name = 'Iron';
  RAISE NOTICE 'Set Iron temperature to warming';
END $$;
