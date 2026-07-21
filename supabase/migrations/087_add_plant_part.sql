-- Migration 087: Add plant_part column to herbs table
-- Allows distinct entries for different parts of the same plant
-- (e.g., Dandelion leaf vs Dandelion root), each with their own
-- energetics, actions, and monograph.

SET search_path TO herbal, public;

-- 1. Add the column (all existing rows get NULL = no specific part)
ALTER TABLE herbal.herbs ADD COLUMN IF NOT EXISTS plant_part TEXT;

-- 2. Drop the old single-column unique constraint
ALTER TABLE herbal.herbs DROP CONSTRAINT IF EXISTS herbs_latin_name_key;

-- 3. Replace with a composite unique constraint.
--    NULLS NOT DISTINCT means (Taraxacum officinale, NULL) still conflicts
--    with another (Taraxacum officinale, NULL), so existing herbs remain unique.
ALTER TABLE herbal.herbs ADD CONSTRAINT herbs_latin_name_plant_part_key
  UNIQUE NULLS NOT DISTINCT (latin_name, plant_part);

-- 4. Update the 2-arg ensure_herb() to use the new constraint
CREATE OR REPLACE FUNCTION herbal.ensure_herb(p_latin_name TEXT, p_common_name TEXT)
RETURNS INTEGER AS $$
DECLARE
  v_herb_id INTEGER;
BEGIN
  INSERT INTO herbal.herbs (latin_name, common_name, plant_part)
  VALUES (p_latin_name, initcap(p_common_name), NULL)
  ON CONFLICT ON CONSTRAINT herbs_latin_name_plant_part_key DO NOTHING
  RETURNING id INTO v_herb_id;

  IF v_herb_id IS NULL THEN
    SELECT id INTO v_herb_id FROM herbal.herbs
    WHERE latin_name = p_latin_name AND plant_part IS NULL;
  END IF;

  RETURN v_herb_id;
END;
$$ LANGUAGE plpgsql;

-- 5. New 3-arg overload for herbs with a specific plant part
CREATE OR REPLACE FUNCTION herbal.ensure_herb(p_latin_name TEXT, p_common_name TEXT, p_plant_part TEXT)
RETURNS INTEGER AS $$
DECLARE
  v_herb_id INTEGER;
BEGIN
  INSERT INTO herbal.herbs (latin_name, common_name, plant_part)
  VALUES (p_latin_name, initcap(p_common_name), p_plant_part)
  ON CONFLICT ON CONSTRAINT herbs_latin_name_plant_part_key DO NOTHING
  RETURNING id INTO v_herb_id;

  IF v_herb_id IS NULL THEN
    SELECT id INTO v_herb_id FROM herbal.herbs
    WHERE latin_name = p_latin_name AND plant_part = p_plant_part;
  END IF;

  RETURN v_herb_id;
END;
$$ LANGUAGE plpgsql;
