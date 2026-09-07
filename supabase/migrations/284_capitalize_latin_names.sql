-- Migration 284: Capitalize first letter of latin_name in herbal.herbs
-- Affects 3 recently added herbs (migrations 278–283 used all-lowercase).
-- Standard taxonomic convention: genus is always capitalized.

SET search_path TO herbal, public;

UPDATE herbal.herbs
SET latin_name = upper(left(latin_name, 1)) || substring(latin_name, 2)
WHERE latin_name ~ '^[a-z]';
