-- ============================================================
-- Link condition entries to plant profiles by name
-- ============================================================
UPDATE herbal.flower_essence_condition_entries e
SET plant_id = p.id
FROM herbal.flower_essence_plants p
WHERE e.plant_name = p.name
  AND e.plant_id IS NULL;
