SET search_path TO herbal, public;

-- Add updated_by to herb_monograph_links so admin edits are attributed
ALTER TABLE herbal.herb_monograph_links
  ADD COLUMN IF NOT EXISTS updated_by TEXT;
