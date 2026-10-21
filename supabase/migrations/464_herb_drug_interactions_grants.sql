-- Migration 464: grant SELECT on herb_drug_interactions to anon and authenticated roles
-- RLS policy alone is insufficient; PostgREST requires an explicit GRANT as well.

GRANT SELECT ON herbal.herb_drug_interactions TO anon, authenticated;
