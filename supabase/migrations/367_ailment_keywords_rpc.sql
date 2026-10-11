-- Migration 367: RPC to aggregate ailment keywords server-side
-- Fixes silent 1000-row Supabase limit truncating herb_keywords queries.
-- Returns one row per distinct keyword (currently ~172) with herb/supplement
-- id arrays, instead of one row per herb+keyword pair (currently 1604).

CREATE OR REPLACE FUNCTION herbal.get_ailment_keywords()
RETURNS TABLE(keyword text, herb_ids int[], supplement_ids int[])
LANGUAGE sql
SECURITY DEFINER
STABLE
AS $$
  SELECT
    keyword,
    array_agg(herb_id ORDER BY herb_id)        FILTER (WHERE herb_id IS NOT NULL)        AS herb_ids,
    array_agg(supplement_id ORDER BY supplement_id) FILTER (WHERE supplement_id IS NOT NULL) AS supplement_ids
  FROM herbal.herb_keywords
  WHERE category = 'ailment'
  GROUP BY keyword
  ORDER BY keyword;
$$;

GRANT EXECUTE ON FUNCTION herbal.get_ailment_keywords() TO anon, authenticated;
