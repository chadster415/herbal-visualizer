-- Migration 327: Class 28 herb pairs
-- BHC - Class 28 - Urinary 2 and Herbs for Pets - Shereel and Cheryl
-- Pair: Plantain (85) + St. John's Wort (81) — explicit two-herb combination for post-dental wound care

SET search_path TO herbal, public;

DO $$
DECLARE
  v_pair_id INTEGER;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(81, 85), GREATEST(81, 85),
    'BHC Apprenticeship class notes',
    'Plantain and St. John''s Wort combined in gauze for post-dental wound care in pets; effective for gum irritation, mouth wounds, and tissue healing after dental procedures. Plantain clears damp heat and draws out foreign bodies while SJW provides anti-inflammatory and nerve-healing support to oral tissues.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(81, 85) AND herb2_id = GREATEST(81, 85);

  IF v_pair_id IS NULL THEN
    RAISE NOTICE 'Plantain/SJW pair not found after insert — skipping indications';
    RETURN;
  END IF;

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Post-dental wound healing in pets', 10),
    ('Gum irritation and oral mucosal healing', 20),
    ('Mouth wounds and cheek irritation', 30)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (85, 'Clears damp heat, draws out foreign bodies, and reduces tissue inflammation in oral mucosa', 10),
    (81, 'Anti-inflammatory and nervine action supports healing of gum tissue and oral nerves after dental trauma', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);

  RAISE NOTICE 'Plantain/SJW pair (id=%) loaded.', v_pair_id;
END $$;
