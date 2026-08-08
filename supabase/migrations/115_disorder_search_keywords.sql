SET search_path TO herbal, public;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'herbal'
      AND table_name   = 'disorders'
      AND column_name  = 'search_keywords'
  ) THEN
    ALTER TABLE herbal.disorders
      ADD COLUMN search_keywords text[] NOT NULL DEFAULT '{}';
    RAISE NOTICE 'Added search_keywords column to herbal.disorders';
  ELSE
    RAISE NOTICE 'search_keywords column already exists — skipping';
  END IF;
END $$;
