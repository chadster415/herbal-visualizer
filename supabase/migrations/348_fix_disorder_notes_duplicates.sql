SET search_path TO herbal, public;

-- Remove duplicate disorder_notes rows from Musculoskeletal case study
-- (migration 346 ran twice; ON CONFLICT DO NOTHING had nothing to conflict on)
-- Keep the lower id (first insert) for each (disorder_id, sort_order) pair.
DELETE FROM herbal.disorder_notes
WHERE id IN (
  SELECT MAX(id)
  FROM herbal.disorder_notes
  GROUP BY disorder_id, sort_order
  HAVING COUNT(*) > 1
);

-- Add unique constraint so future migrations are idempotent on this table.
ALTER TABLE herbal.disorder_notes
  ADD CONSTRAINT disorder_notes_disorder_sort_unique
  UNIQUE (disorder_id, sort_order);
