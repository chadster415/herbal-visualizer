-- DEPRECATED: This migration was run out of order before the disorders were created
-- The correct version is in migration 026
-- This file is kept as a placeholder to maintain migration numbering

SET search_path TO herbal, public;

-- No-op migration
DO $$
BEGIN
  RAISE NOTICE 'Migration 024 deprecated - see migration 026 for the correct version';
END $$;
