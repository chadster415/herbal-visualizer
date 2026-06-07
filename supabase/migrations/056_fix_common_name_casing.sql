-- Migration 056: Fix common_name casing
-- Ensures herb common names are stored in title case (initcap).
-- Updates ensure_herb() to apply initcap() on insert, and back-fills
-- any existing lowercase entries.

SET search_path TO herbal, public;

-- Update ensure_herb to store common names in title case
CREATE OR REPLACE FUNCTION herbal.ensure_herb(p_latin_name TEXT, p_common_name TEXT)
RETURNS INTEGER AS $$
DECLARE
  v_herb_id INTEGER;
BEGIN
  INSERT INTO herbal.herbs (latin_name, common_name)
  VALUES (p_latin_name, initcap(p_common_name))
  ON CONFLICT (latin_name) DO NOTHING
  RETURNING id INTO v_herb_id;

  IF v_herb_id IS NULL THEN
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = p_latin_name;
  END IF;

  RETURN v_herb_id;
END;
$$ LANGUAGE plpgsql;

-- Back-fill existing rows where common_name differs from its initcap form
UPDATE herbal.herbs
SET common_name = initcap(common_name)
WHERE common_name != initcap(common_name);
