-- Migration 377: RPC to return distinct quiz class names
-- Fixes silent 1000-row Supabase default limit truncating the class list query
-- in ClassQuizModal (1130+ rows of quiz questions, ordered desc, cuts off classes 23 & 24).

CREATE OR REPLACE FUNCTION herbal.get_quiz_class_names()
RETURNS TABLE(class_name text)
LANGUAGE sql
SECURITY DEFINER
STABLE
AS $$
  SELECT DISTINCT class_name
  FROM herbal.class_quiz_questions
  ORDER BY class_name DESC;
$$;

GRANT EXECUTE ON FUNCTION herbal.get_quiz_class_names() TO anon, authenticated;
