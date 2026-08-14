SET search_path TO herbal, public;

DO $$
BEGIN
  ALTER TABLE herbal.herbs DROP COLUMN IF EXISTS image_url;
  RAISE NOTICE 'Dropped image_url column from herbal.herbs';
END $$;
