-- Backfill the generic 'alkaloids' constituent entry for herbs that have specific
-- alkaloid-category constituents but no generic 'alkaloids' entry.
-- Concentration level is set to the highest level of any specific alkaloid on that herb.

INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes)
SELECT
  hc.herb_id,
  (SELECT id FROM herbal.constituents WHERE name = 'alkaloids') AS constituent_id,
  -- highest level among their specific alkaloids (enum ordering: trace < minor < moderate < major < primary)
  (
    SELECT hc2.concentration_level
    FROM herbal.herb_constituents hc2
    JOIN herbal.constituents c2 ON c2.id = hc2.constituent_id
    WHERE hc2.herb_id = hc.herb_id
      AND lower(c2.category) LIKE '%alkaloid%'
    ORDER BY hc2.concentration_level DESC
    LIMIT 1
  ) AS concentration_level,
  'Backfilled from specific alkaloid constituent entries' AS notes
FROM herbal.herb_constituents hc
JOIN herbal.constituents c ON c.id = hc.constituent_id
WHERE lower(c.category) LIKE '%alkaloid%'
  -- exclude herbs that already have the generic 'alkaloids' entry
  AND hc.herb_id NOT IN (
    SELECT hc2.herb_id
    FROM herbal.herb_constituents hc2
    JOIN herbal.constituents c2 ON c2.id = hc2.constituent_id
    WHERE c2.name = 'alkaloids'
  )
GROUP BY hc.herb_id
ON CONFLICT (herb_id, constituent_id) DO NOTHING;
