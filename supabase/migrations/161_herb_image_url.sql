SET search_path TO herbal, public;

DO $$
BEGIN
  ALTER TABLE herbal.herbs ADD COLUMN IF NOT EXISTS image_url TEXT;
  RAISE NOTICE 'Added image_url column to herbal.herbs';
END $$;
