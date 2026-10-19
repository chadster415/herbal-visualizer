-- Migration 418: BHC Class 7 – Digestion II and Nutrition I — Herb Pairs
--
-- Pairs from class notes:
--   1. Myrrh + Goldenseal — "classic Eclectic pair for digestion"
--      (pair already exists; update combined_summary with BHC context)
--   2. Corydalis + Dahhurian Angelica — "classic sacred pairing in TCM" for biliary/GI pain
--      (new pair)

SET search_path TO herbal, public;

-- =====================================================================
-- PAIR 1: Myrrh + Goldenseal (id=99 + id=30) — UPDATE EXISTING
-- =====================================================================
-- herb1_id = LEAST(99, 30) = 30 (Goldenseal)
-- herb2_id = GREATEST(99, 30) = 99 (Myrrh)

INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
VALUES (
  30, 99,
  'BHC Apprenticeship class notes',
  'Myrrh and Goldenseal were described as a classic Eclectic pair for digestion — used together for Cold Damp Diarrhea and digestive infections by 19th-century Eclectic physicians.'
)
ON CONFLICT (herb1_id, herb2_id) DO UPDATE
  SET combined_summary = herbal.herb_pairs.combined_summary
                         || ' | BHC class notes: '
                         || EXCLUDED.combined_summary;

-- =====================================================================
-- PAIR 2: Corydalis + Dahhurian Angelica — NEW
-- =====================================================================
DO $$
DECLARE
  v_corydalis_id  CONSTANT INTEGER := 2228;
  v_dahurica_id   INTEGER;
  v_pair_id       INTEGER;
BEGIN
  SELECT id INTO v_dahurica_id FROM herbal.herbs WHERE latin_name = 'Angelica dahurica';
  IF v_dahurica_id IS NULL THEN
    RAISE EXCEPTION 'Dahhurian Angelica not found — run migration 417 first';
  END IF;

  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(v_corydalis_id, v_dahurica_id),
    GREATEST(v_corydalis_id, v_dahurica_id),
    'BHC Apprenticeship class notes',
    'Corydalis (Yan Hu Suo) and Dahhurian Angelica (Bai Zhi) are described as a "classic sacred pairing" in TCM for biliary and GI spasmodic pain. Both are low-dose herbs; Corydalis especially is noted to cause drowsiness. Together they address sharp, cramping pain associated with gallstones or abdominal colic.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET combined_summary = herbal.herb_pairs.combined_summary
                           || ' | BHC class notes: '
                           || EXCLUDED.combined_summary;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_corydalis_id, v_dahurica_id)
    AND herb2_id = GREATEST(v_corydalis_id, v_dahurica_id);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Gallstone pain and biliary colic', 10),
    ('Sharp spasmodic abdominal pain', 20),
    ('GI cramping with spasm', 30)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_corydalis_id, 'Analgesic and antispasmodic; moves blood and qi; low-dose sedative for acute pain', 10),
    (v_dahurica_id,  'Disperses wind-cold; alleviates pain; especially for head and facial pain but used in TCM for abdominal cramping', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);

  RAISE NOTICE 'Corydalis + Dahhurian Angelica pair inserted.';
END $$;
