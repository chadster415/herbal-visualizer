-- Migration 180: Deduplicate editorial_note values in constituent_profiles.
-- 7 herbs were found with two distinct editorial_note strings across their rows.
-- For each herb, standardize all rows to the note that appears most frequently
-- (majority vote; alphabetical tiebreak). No constituent data is altered.

SET search_path TO herbal, public;

DO $$
DECLARE
  v_updated INTEGER;
BEGIN
  WITH ranked_notes AS (
    SELECT
      herb_id,
      editorial_note,
      ROW_NUMBER() OVER (
        PARTITION BY herb_id
        ORDER BY COUNT(*) DESC, editorial_note
      ) AS rn
    FROM herbal.constituent_profiles
    WHERE editorial_note IS NOT NULL AND editorial_note != ''
    GROUP BY herb_id, editorial_note
  ),
  chosen AS (
    SELECT herb_id, editorial_note FROM ranked_notes WHERE rn = 1
  )
  UPDATE herbal.constituent_profiles cp
  SET editorial_note = c.editorial_note
  FROM chosen c
  WHERE cp.herb_id = c.herb_id
    AND cp.editorial_note IS DISTINCT FROM c.editorial_note;

  GET DIAGNOSTICS v_updated = ROW_COUNT;
  RAISE NOTICE 'Standardized editorial_note on % constituent_profiles rows', v_updated;
END $$;
