SET search_path TO herbal, public;

-- Tables created in migration 065 (constituents, herb_constituents, herb_menstruum)
-- are missing GRANT SELECT for the anon/authenticated roles.
-- RLS policies are not enough on their own — the underlying table privilege must
-- also be granted. Older tables had this from Supabase's default schema setup;
-- new tables do not inherit it automatically.

GRANT SELECT ON herbal.constituents      TO anon, authenticated;
GRANT SELECT ON herbal.herb_constituents TO anon, authenticated;
GRANT SELECT ON herbal.herb_menstruum    TO anon, authenticated;

DO $$ BEGIN RAISE NOTICE 'Migration 068 complete: SELECT granted on constituent tables to anon/authenticated.'; END $$;
