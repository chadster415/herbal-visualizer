-- Fix Function Search Path Mutable warnings for herbal.* functions
-- Also removes unnecessary SECURITY DEFINER from get_ailment_keywords and
-- get_quiz_class_names (both target tables already have anon_read RLS policies)

CREATE OR REPLACE FUNCTION herbal.ensure_action(p_action_name text)
 RETURNS integer
 LANGUAGE plpgsql
 SET search_path = ''
AS $function$
DECLARE
  v_action_id INTEGER;
BEGIN
  INSERT INTO herbal.primary_actions (name)
  VALUES (p_action_name)
  ON CONFLICT (name) DO NOTHING
  RETURNING id INTO v_action_id;

  IF v_action_id IS NULL THEN
    SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = p_action_name;
  END IF;

  RETURN v_action_id;
END;
$function$;

CREATE OR REPLACE FUNCTION herbal.ensure_constituent(p_name text, p_category text, p_desc text DEFAULT NULL::text)
 RETURNS integer
 LANGUAGE plpgsql
 SET search_path = ''
AS $function$
DECLARE v_id INTEGER;
BEGIN
  INSERT INTO herbal.constituents (name, category, description)
  VALUES (p_name, p_category, p_desc)
  ON CONFLICT (name) DO UPDATE SET
    category    = EXCLUDED.category,
    description = COALESCE(EXCLUDED.description, herbal.constituents.description)
  RETURNING id INTO v_id;
  RETURN v_id;
END;
$function$;

CREATE OR REPLACE FUNCTION herbal.ensure_herb(p_latin_name text, p_common_name text)
 RETURNS integer
 LANGUAGE plpgsql
 SET search_path = ''
AS $function$
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
$function$;

CREATE OR REPLACE FUNCTION herbal.ensure_herb(p_latin_name text, p_common_name text, p_plant_part text)
 RETURNS integer
 LANGUAGE plpgsql
 SET search_path = ''
AS $function$
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
$function$;

CREATE OR REPLACE FUNCTION herbal.link_constituent(p_latin_name text, p_constituent_name text, p_level herbal.concentration_level DEFAULT 'moderate'::herbal.concentration_level, p_sort_order integer DEFAULT 0, p_notes text DEFAULT NULL::text, p_needs_review boolean DEFAULT false)
 RETURNS void
 LANGUAGE plpgsql
 SET search_path = ''
AS $function$
DECLARE
  v_herb_id INTEGER;
  v_con_id  INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = p_latin_name;
  IF v_herb_id IS NULL THEN
    RAISE NOTICE 'link_constituent: herb not found: %', p_latin_name;
    RETURN;
  END IF;
  SELECT id INTO v_con_id FROM herbal.constituents WHERE name = p_constituent_name;
  IF v_con_id IS NULL THEN
    RAISE NOTICE 'link_constituent: constituent not found: %', p_constituent_name;
    RETURN;
  END IF;
  INSERT INTO herbal.herb_constituents
    (herb_id, constituent_id, concentration_level, sort_order, notes, needs_review)
  VALUES
    (v_herb_id, v_con_id, p_level, p_sort_order, p_notes, p_needs_review)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;
END;
$function$;

CREATE OR REPLACE FUNCTION herbal.set_menstruum(p_latin_name text, p_alcohol_min integer DEFAULT NULL::integer, p_alcohol_max integer DEFAULT NULL::integer, p_glycerin_pct integer DEFAULT NULL::integer, p_vinegar_pct integer DEFAULT NULL::integer, p_water_effective boolean DEFAULT false, p_primary_label text DEFAULT NULL::text, p_notes text DEFAULT NULL::text, p_needs_review boolean DEFAULT false)
 RETURNS void
 LANGUAGE plpgsql
 SET search_path = ''
AS $function$
DECLARE v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = p_latin_name;
  IF v_herb_id IS NULL THEN
    RAISE NOTICE 'set_menstruum: herb not found: %', p_latin_name;
    RETURN;
  END IF;
  INSERT INTO herbal.herb_menstruum
    (herb_id, alcohol_pct_min, alcohol_pct_max, glycerin_pct, vinegar_pct,
     water_effective, primary_label, notes, needs_review)
  VALUES
    (v_herb_id, p_alcohol_min, p_alcohol_max, p_glycerin_pct, p_vinegar_pct,
     p_water_effective, COALESCE(p_primary_label, 'review needed'), p_notes, p_needs_review)
  ON CONFLICT (herb_id) DO UPDATE SET
    alcohol_pct_min = EXCLUDED.alcohol_pct_min,
    alcohol_pct_max = EXCLUDED.alcohol_pct_max,
    glycerin_pct    = EXCLUDED.glycerin_pct,
    vinegar_pct     = EXCLUDED.vinegar_pct,
    water_effective = EXCLUDED.water_effective,
    primary_label   = EXCLUDED.primary_label,
    notes           = EXCLUDED.notes,
    needs_review    = EXCLUDED.needs_review;
END;
$function$;

CREATE OR REPLACE FUNCTION herbal.set_menstruum(p_latin_name text, p_alcohol_min integer DEFAULT NULL::integer, p_alcohol_max integer DEFAULT NULL::integer, p_glycerin_pct integer DEFAULT NULL::integer, p_vinegar_pct integer DEFAULT NULL::integer, p_water_effective boolean DEFAULT false, p_primary_label text DEFAULT NULL::text, p_notes text DEFAULT NULL::text, p_needs_review boolean DEFAULT false, p_powder_effective boolean DEFAULT false)
 RETURNS void
 LANGUAGE plpgsql
 SET search_path = ''
AS $function$
DECLARE v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = p_latin_name;
  IF v_herb_id IS NULL THEN
    RAISE NOTICE 'set_menstruum: herb not found: %', p_latin_name;
    RETURN;
  END IF;
  INSERT INTO herbal.herb_menstruum
    (herb_id, alcohol_pct_min, alcohol_pct_max, glycerin_pct, vinegar_pct,
     water_effective, primary_label, notes, needs_review, powder_effective)
  VALUES
    (v_herb_id, p_alcohol_min, p_alcohol_max, p_glycerin_pct, p_vinegar_pct,
     p_water_effective, COALESCE(p_primary_label, 'review needed'), p_notes, p_needs_review, p_powder_effective)
  ON CONFLICT (herb_id) DO UPDATE SET
    alcohol_pct_min   = EXCLUDED.alcohol_pct_min,
    alcohol_pct_max   = EXCLUDED.alcohol_pct_max,
    glycerin_pct      = EXCLUDED.glycerin_pct,
    vinegar_pct       = EXCLUDED.vinegar_pct,
    water_effective   = EXCLUDED.water_effective,
    primary_label     = EXCLUDED.primary_label,
    notes             = EXCLUDED.notes,
    needs_review      = EXCLUDED.needs_review,
    powder_effective  = EXCLUDED.powder_effective;
END;
$function$;

CREATE OR REPLACE FUNCTION herbal.set_menstruum(p_latin_name text, p_alcohol_min integer DEFAULT NULL::integer, p_alcohol_max integer DEFAULT NULL::integer, p_glycerin_pct integer DEFAULT NULL::integer, p_vinegar_pct integer DEFAULT NULL::integer, p_water_effective boolean DEFAULT false, p_primary_label text DEFAULT NULL::text, p_notes text DEFAULT NULL::text, p_needs_review boolean DEFAULT false, p_powder_effective boolean DEFAULT false, p_oil_effective boolean DEFAULT false)
 RETURNS void
 LANGUAGE plpgsql
 SET search_path = ''
AS $function$
DECLARE v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = p_latin_name;
  IF v_herb_id IS NULL THEN
    RAISE NOTICE 'set_menstruum: herb not found: %', p_latin_name;
    RETURN;
  END IF;
  INSERT INTO herbal.herb_menstruum
    (herb_id, alcohol_pct_min, alcohol_pct_max, glycerin_pct, vinegar_pct,
     water_effective, primary_label, notes, needs_review, powder_effective, oil_effective)
  VALUES
    (v_herb_id, p_alcohol_min, p_alcohol_max, p_glycerin_pct, p_vinegar_pct,
     p_water_effective, COALESCE(p_primary_label, 'review needed'), p_notes, p_needs_review,
     p_powder_effective, p_oil_effective)
  ON CONFLICT (herb_id) DO UPDATE SET
    alcohol_pct_min   = EXCLUDED.alcohol_pct_min,
    alcohol_pct_max   = EXCLUDED.alcohol_pct_max,
    glycerin_pct      = EXCLUDED.glycerin_pct,
    vinegar_pct       = EXCLUDED.vinegar_pct,
    water_effective   = EXCLUDED.water_effective,
    primary_label     = EXCLUDED.primary_label,
    notes             = EXCLUDED.notes,
    needs_review      = EXCLUDED.needs_review,
    powder_effective  = EXCLUDED.powder_effective,
    oil_effective     = EXCLUDED.oil_effective;
END;
$function$;

-- Remove SECURITY DEFINER from these two functions: both target tables
-- (herb_keywords, class_quiz_questions) already have anon_read RLS policies,
-- so SECURITY DEFINER is not needed and just widens the attack surface.
CREATE OR REPLACE FUNCTION herbal.get_ailment_keywords()
 RETURNS TABLE(keyword text, herb_ids integer[], supplement_ids integer[])
 LANGUAGE sql
 STABLE
 SET search_path = ''
AS $function$
  SELECT
    keyword,
    array_agg(herb_id ORDER BY herb_id)        FILTER (WHERE herb_id IS NOT NULL)        AS herb_ids,
    array_agg(supplement_id ORDER BY supplement_id) FILTER (WHERE supplement_id IS NOT NULL) AS supplement_ids
  FROM herbal.herb_keywords
  WHERE category = 'ailment'
  GROUP BY keyword
  ORDER BY keyword;
$function$;

CREATE OR REPLACE FUNCTION herbal.get_quiz_class_names()
 RETURNS TABLE(class_name text)
 LANGUAGE sql
 STABLE
 SET search_path = ''
AS $function$
  SELECT class_name
  FROM (
    SELECT DISTINCT class_name,
      (regexp_match(class_name, 'Class (\d+)'))[1]::integer AS class_num
    FROM herbal.class_quiz_questions
  ) sub
  ORDER BY class_num DESC;
$function$;
