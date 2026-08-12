-- Convert images column from TEXT[] to JSONB to support structured image objects (url + caption).
-- PostgreSQL doesn't allow subqueries in ALTER COLUMN USING, so we use add/update/rename.

ALTER TABLE tracker.remedies
  ADD COLUMN images_jsonb JSONB NOT NULL DEFAULT '[]'::jsonb;

UPDATE tracker.remedies
SET images_jsonb = (
  SELECT COALESCE(
    jsonb_agg(
      CASE
        WHEN elem LIKE '{%' THEN elem::jsonb
        ELSE jsonb_build_object('url', elem)
      END
    ),
    '[]'::jsonb
  )
  FROM unnest(images) AS elem
);

ALTER TABLE tracker.remedies
  DROP COLUMN images;

ALTER TABLE tracker.remedies
  RENAME COLUMN images_jsonb TO images;
