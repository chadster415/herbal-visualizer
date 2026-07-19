SET search_path TO herbal, public;

ALTER TABLE herbal.herbs ADD COLUMN IF NOT EXISTS pinyin_name TEXT;
ALTER TABLE herbal.herbs ADD COLUMN IF NOT EXISTS is_tcm BOOLEAN NOT NULL DEFAULT FALSE;

DO $$ BEGIN
  RAISE NOTICE 'Migration 079 complete: added pinyin_name and is_tcm to herbal.herbs';
END $$;
