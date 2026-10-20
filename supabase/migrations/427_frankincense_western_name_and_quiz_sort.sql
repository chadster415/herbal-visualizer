-- Migration 427: Two fixes
--
-- 1. Frankincense (id=1597) western name cleanup
--    - Update latin_name from 'Resina Olibani' (TCM Latinized form) to 'Boswellia sacra'
--    - Clear pinyin_name ('Ru Xiang') — now non-TCM since migration 424
--
-- 2. Fix quiz class list sort order
--    - Replace alphabetic ORDER BY class_name with numeric sort on the embedded class number
--    - Fixes: "Class 9" > "Class 73" alphabetically; correct order is 73 > 9 numerically

SET search_path TO herbal, public;

-- 1. Frankincense western name
UPDATE herbal.herbs
SET
  latin_name   = 'Boswellia sacra',
  pinyin_name  = 'Ru Xiang'
WHERE id = 1597;

-- 2. Quiz class list: numeric sort
CREATE OR REPLACE FUNCTION herbal.get_quiz_class_names()
RETURNS TABLE(class_name text)
LANGUAGE sql
SECURITY DEFINER
STABLE
AS $$
  SELECT class_name
  FROM (
    SELECT DISTINCT class_name,
      (regexp_match(class_name, 'Class (\d+)'))[1]::integer AS class_num
    FROM herbal.class_quiz_questions
  ) sub
  ORDER BY class_num DESC;
$$;
