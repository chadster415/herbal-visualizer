-- Migration 108: Add contraindications_source column so each herb can cite its source.
-- Backfills all existing contraindications rows (from migration 107) as 'Tilgner'.

SET search_path TO herbal, public;

ALTER TABLE herbal.herbs ADD COLUMN IF NOT EXISTS contraindications_source TEXT;

-- All contraindications entered so far are from Tilgner's Herbal Medicine From the Heart of the Earth
UPDATE herbal.herbs
SET contraindications_source = 'Tilgner'
WHERE contraindications IS NOT NULL
  AND contraindications_source IS NULL;
