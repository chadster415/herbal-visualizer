-- Migration 069: constituent_profiles table
-- Stores the full Herb Constituent Database CSV as a separate data source.
-- Used for Marker Constituents display and the Alternates similarity engine.
-- Intentionally kept separate from herb_constituents (which holds the existing
-- concentration-level data ingested in migrations 066–067).

SET search_path TO herbal, public;

CREATE TABLE IF NOT EXISTS herbal.constituent_profiles (
  id              SERIAL PRIMARY KEY,
  herb_id         INTEGER REFERENCES herbal.herbs(id),  -- NULL when CSV latin_name has no DB match
  common_name     TEXT NOT NULL,
  latin_name      TEXT NOT NULL,
  plant_part      TEXT,
  constituent     TEXT NOT NULL,
  class           TEXT,
  subclass        TEXT,
  importance      TEXT,  -- High | Moderate | Low | Low-Moderate
  status          TEXT,  -- Marker | Major | Present | Reported
  notes           TEXT,
  editorial_note  TEXT
);

CREATE INDEX IF NOT EXISTS idx_cp_herb_id  ON herbal.constituent_profiles(herb_id);
CREATE INDEX IF NOT EXISTS idx_cp_status   ON herbal.constituent_profiles(status);
CREATE INDEX IF NOT EXISTS idx_cp_latin    ON herbal.constituent_profiles(latin_name);

GRANT SELECT ON herbal.constituent_profiles TO anon, authenticated;

DO $$ BEGIN RAISE NOTICE 'Migration 069 complete: constituent_profiles table created'; END $$;
