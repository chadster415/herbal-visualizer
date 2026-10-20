-- Migration 430: Class 1 herb pairs — BHC Class 1 (Ashley / Claire)
-- Two pairs explicitly noted in the Bancroft Garden Walk:
--   1. Plantain + Calendula → gut health infusion (instructor explicitly stated)
--   2. California Poppy + Catnip → tincture for over-caffeination (instructor recommended together)

SET search_path TO herbal, public;

-- Pair 1: Calendula (id=70) + Plantain (id=85) → gut health infusion
DO $$
DECLARE
  v_pair_id INTEGER;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(70, 85), GREATEST(70, 85),
    'BHC Apprenticeship class notes',
    'Calendula and Plantain together as a gut health infusion; Plantain tonifies intestinal tissue and provides vulnerary healing while Calendula brings anti-inflammatory action to the gut lining.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET combined_summary = herbal.herb_pairs.combined_summary
                           || ' | BHC class notes: '
                           || EXCLUDED.combined_summary;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(70, 85) AND herb2_id = GREATEST(70, 85);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('GI inflammation',         10),
    ('gut health support',      20),
    ('intestinal healing',      30)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (70, 'Anti-inflammatory healing for the gut lining; soothes and repairs damaged intestinal tissue', 10),
    (85, 'Tonifies intestinal tissue; demulcent and vulnerary for chronic digestive issues and GI inflammation', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
END $$;

-- Pair 2: California Poppy (id=128) + Catnip (id=136) → tincture for over-caffeination
DO $$
DECLARE
  v_pair_id INTEGER;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(128, 136), GREATEST(128, 136),
    'BHC Apprenticeship class notes',
    'California Poppy and Catnip as a tincture for over-caffeination; California Poppy provides the primary nervine calming action while Catnip addresses the digestive tension and jitteriness from excess caffeine.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET combined_summary = herbal.herb_pairs.combined_summary
                           || ' | BHC class notes: '
                           || EXCLUDED.combined_summary;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(128, 136) AND herb2_id = GREATEST(128, 136);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('over-stimulation from caffeine', 10),
    ('anxiety',                        20),
    ('nervous system support',         30)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (128, 'Primary nervine/sedative; counters over-stimulation and the jitteriness of excess caffeine', 10),
    (136, 'Carminative nervine; relieves digestive tension caused by caffeine and supports the calming effect', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
END $$;
