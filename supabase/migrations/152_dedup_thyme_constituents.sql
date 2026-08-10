-- Migration 152: Remove duplicate herb_constituents for Thyme (herb id 59)
-- After merging Thymus spp. (2254) into Thymus vulgaris (59), both had separate
-- constituent entries with the same names but different IDs, causing visual duplicates.
-- Keep the lowest-id herb_constituent row per unique constituent name; delete the rest.

SET search_path TO herbal, public;

DO $$
DECLARE
  deleted_count INTEGER;
BEGIN
  DELETE FROM herbal.herb_constituents
  WHERE herb_id = 59
    AND id NOT IN (
      SELECT MIN(hc.id)
      FROM herbal.herb_constituents hc
      JOIN herbal.constituents c ON c.id = hc.constituent_id
      WHERE hc.herb_id = 59
      GROUP BY c.name
    );

  GET DIAGNOSTICS deleted_count = ROW_COUNT;
  RAISE NOTICE 'Removed % duplicate herb_constituent rows for Thyme (herb 59)', deleted_count;

  -- Deduplicate constituent_profiles for herb 59 (same constituent name, keep lowest id)
  DELETE FROM herbal.constituent_profiles
  WHERE herb_id = 59
    AND id NOT IN (
      SELECT MIN(id)
      FROM herbal.constituent_profiles
      WHERE herb_id = 59
      GROUP BY constituent
    );

  GET DIAGNOSTICS deleted_count = ROW_COUNT;
  RAISE NOTICE 'Removed % duplicate constituent_profile rows for Thyme (herb 59)', deleted_count;
END $$;
