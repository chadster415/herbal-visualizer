-- Migration 094: Move berry-specific constituents from Elder flower → berry
--
-- After migration 093 created the Elder berry entry, constituent data that was
-- stored under Elder (id 57, now flower) needs to be split.
--
-- constituent_profiles: already tagged plant_part = 'Berry' or 'Flower' — just re-point.
--   Berry (6 rows): Cyanidin, Cyanidin-3-glucoside, Cyanidin-3-sambubioside,
--                   Quercetin, Rutin, Chlorogenic acid
--   Flower (6 rows): Isoquercitrin, Quercetin, Rutin, Caffeic acid,
--                    Chlorogenic acid, Ursolic acid — stay on id 57
--
-- herb_constituents: mixed bag, split by botanical evidence:
--   → Berry: anthocyanins, cyanidin-3-glucoside ("Highest in berries"),
--            cyanidin-3-sambubioside, sambunigrin (cyanogenic glycoside of berries)
--   → Flower: mucilage ("Higher in flowers"), kaempferol, quercetin, rutin,
--             chlorogenic acid, tannins

SET search_path TO herbal, public;

DO $$
DECLARE
  v_flower_id INTEGER := 57;
  v_berry_id  INTEGER;
BEGIN

  SELECT id INTO v_berry_id FROM herbal.herbs
  WHERE latin_name = 'Sambucus nigra' AND plant_part = 'berry';

  IF v_berry_id IS NULL THEN
    RAISE EXCEPTION 'Elder berry entry not found — run migration 093 first';
  END IF;

  RAISE NOTICE 'Elder flower = %, berry = %', v_flower_id, v_berry_id;

  -- ── constituent_profiles ──────────────────────────────────────────────────
  -- Re-point Berry-tagged profiles to the berry herb
  UPDATE herbal.constituent_profiles
  SET herb_id = v_berry_id
  WHERE herb_id = v_flower_id AND plant_part = 'Berry';

  RAISE NOTICE 'Moved Berry constituent_profiles → berry';

  -- Flower-tagged profiles already on flower_id — no change needed

  -- ── herb_constituents ─────────────────────────────────────────────────────
  -- Move berry-specific constituents to berry herb
  UPDATE herbal.herb_constituents
  SET herb_id = v_berry_id
  WHERE herb_id = v_flower_id
    AND constituent_id IN (
      SELECT id FROM herbal.constituents
      WHERE name IN (
        'anthocyanins',
        'cyanidin-3-glucoside',
        'cyanidin-3-sambubioside',
        'sambunigrin'
      )
    );

  RAISE NOTICE 'Moved berry-specific herb_constituents → berry';

  -- Remaining on flower (id 57): mucilage, kaempferol, quercetin, rutin,
  -- chlorogenic acid, tannins

  RAISE NOTICE 'Done.';

END $$;
