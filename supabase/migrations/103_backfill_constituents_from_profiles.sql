SET search_path TO herbal, public;

-- Backfill herb_constituents from constituent_profiles.
--
-- For each (herb_id, constituent) pair in constituent_profiles that has a
-- matching row in herbal.constituents, insert a herb_constituents row if one
-- does not already exist. Existing manually-curated rows are never overwritten
-- (ON CONFLICT DO NOTHING).
--
-- Importance → concentration_level mapping:
--   Reported (any importance)          → trace
--   Present + Low or Low-Moderate      → minor
--   Present + Moderate                 → moderate
--   Major or Marker + Moderate         → moderate
--   Major or Marker + High             → major
--
-- When multiple constituent_profiles rows exist for the same (herb_id, constituent)
-- (e.g. different plant parts), we pick the highest-priority one using:
--   status rank:     Marker=4, Major=3, Present=2, Reported=1
--   importance rank: High=3, Moderate=2, Low-Moderate=1, Low=0

DO $$
DECLARE
  v_inserted INTEGER := 0;
  v_skipped  INTEGER := 0;
BEGIN
  WITH ranked_profiles AS (
    -- Rank duplicate (herb_id, constituent) pairs, pick the best one
    SELECT DISTINCT ON (cp.herb_id, c.id)
      cp.herb_id,
      c.id AS constituent_id,
      cp.status,
      cp.importance,
      CASE
        WHEN cp.status = 'Reported'                                       THEN 'trace'
        WHEN cp.importance IN ('Low', 'Low-Moderate', 'Low–Moderate')    THEN 'minor'
        WHEN cp.importance = 'Moderate'                                   THEN 'moderate'
        WHEN cp.importance = 'High'                                       THEN 'major'
        ELSE 'moderate'
      END::herbal.concentration_level AS concentration_level
    FROM herbal.constituent_profiles cp
    JOIN herbal.constituents c ON LOWER(c.name) = LOWER(cp.constituent)
    WHERE cp.herb_id IS NOT NULL
    ORDER BY
      cp.herb_id,
      c.id,
      -- status rank descending
      CASE cp.status
        WHEN 'Marker'   THEN 4
        WHEN 'Major'    THEN 3
        WHEN 'Present'  THEN 2
        WHEN 'Reported' THEN 1
        ELSE 0
      END DESC,
      -- importance rank descending
      CASE cp.importance
        WHEN 'High'         THEN 3
        WHEN 'Moderate'     THEN 2
        WHEN 'Low-Moderate' THEN 1
        WHEN 'Low–Moderate' THEN 1
        WHEN 'Low'          THEN 0
        ELSE 0
      END DESC
  ),
  inserted AS (
    INSERT INTO herbal.herb_constituents
      (herb_id, constituent_id, concentration_level, sort_order, needs_review)
    SELECT
      rp.herb_id,
      rp.constituent_id,
      rp.concentration_level,
      0,     -- sort_order: 0 so manually curated rows with explicit order sort first
      TRUE   -- needs_review: flag all auto-backfilled rows for future audit
    FROM ranked_profiles rp
    ON CONFLICT (herb_id, constituent_id) DO NOTHING
    RETURNING 1
  )
  SELECT COUNT(*) INTO v_inserted FROM inserted;

  -- Count how many were skipped (already existed)
  SELECT COUNT(*) INTO v_skipped
  FROM herbal.constituent_profiles cp
  JOIN herbal.constituents c ON LOWER(c.name) = LOWER(cp.constituent)
  JOIN herbal.herb_constituents hc ON hc.herb_id = cp.herb_id AND hc.constituent_id = c.id
  WHERE cp.herb_id IS NOT NULL;

  RAISE NOTICE 'Backfill complete: % new herb_constituent links inserted, % already existed (skipped)',
    v_inserted, v_skipped;
END $$;
