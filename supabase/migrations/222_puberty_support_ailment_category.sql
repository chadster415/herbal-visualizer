-- Migration 222: Promote 'puberty support' keyword from category='general' to 'ailment'
-- so it appears in the Class Notes Inferred Ailments view.
-- Also adds ailment_search_terms synonyms so the search box can find it via
-- teen-related terms.

SET search_path TO herbal, public;

UPDATE herbal.herb_keywords
SET category = 'ailment'
WHERE keyword = 'puberty support'
  AND category = 'general';

INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('puberty support',
   ARRAY['teen', 'teens', 'adolescent', 'adolescence', 'puberty', 'menarche', 'teenage', 'young adult'])
ON CONFLICT (ailment_keyword) DO NOTHING;
