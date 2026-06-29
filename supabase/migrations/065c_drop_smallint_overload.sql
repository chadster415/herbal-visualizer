SET search_path TO herbal, public;

-- Migration 065b used CREATE OR REPLACE with INTEGER params, which created a
-- second overload instead of replacing the original SMALLINT version.
-- PostgreSQL error 42725 ("function is not unique") fires when NULLs are
-- passed because it can't pick between the two signatures.
-- This migration drops the stale SMALLINT overload.

DROP FUNCTION IF EXISTS herbal.set_menstruum(
  TEXT, SMALLINT, SMALLINT, SMALLINT, SMALLINT, BOOLEAN, TEXT, TEXT, BOOLEAN
);

DO $$ BEGIN RAISE NOTICE 'Migration 065c complete: stale SMALLINT overload of set_menstruum dropped.'; END $$;
