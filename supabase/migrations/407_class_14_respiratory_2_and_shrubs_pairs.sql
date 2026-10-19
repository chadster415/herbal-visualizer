-- Migration 407: Class 14 herb pairs
-- Source: BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer.md
--
-- New pairs:
--   Ginger + Peppermint: explicitly listed together as antiemetics for influenza nausea
--   Hawthorn + Motherwort: explicitly listed together as cardiotonics in both Asthma and Emphysema sections

SET search_path TO herbal, public;

-- Pair 1: Ginger (124) + Peppermint (55) — herb1 = LEAST = 55, herb2 = GREATEST = 124
DO $$
DECLARE
  v_pair_id INTEGER;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(55, 124), GREATEST(55, 124),
    'BHC Apprenticeship class notes',
    'Classic antiemetic combination for nausea. Ginger settles the stomach and reduces nausea through direct action on the gut and CNS; Peppermint provides antispasmodic relief and cooling. Mentioned explicitly together for flu-related nausea.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET combined_summary = herbal.herb_pairs.combined_summary
                           || ' | BHC class notes: '
                           || EXCLUDED.combined_summary;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(55, 124) AND herb2_id = GREATEST(55, 124);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Influenza and viral illness nausea', 10),
    ('Motion sickness', 20),
    ('Pregnancy nausea', 30),
    ('Digestive upset', 40)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (124, 'Antiemetic, antiviral, diaphoretic; warms the stomach and promotes downward movement of nausea', 10),
    (55,  'Antispasmodic, cooling, carminative; relaxes stomach smooth muscle and eases nausea', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
END $$;

-- Pair 2: Hawthorn berry (73) + Motherwort (131) — herb1 = LEAST = 73, herb2 = GREATEST = 131
DO $$
DECLARE
  v_pair_id INTEGER;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(73, 131), GREATEST(73, 131),
    'BHC Apprenticeship class notes',
    'Classic cardiotonic pair for respiratory conditions affecting the heart. Mentioned explicitly together as cardiotonics in both asthma and emphysema. Hawthorn strengthens the heart muscle and improves circulation; Motherwort calms palpitations and nervous cardiac tension.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET combined_summary = herbal.herb_pairs.combined_summary
                           || ' | BHC class notes: '
                           || EXCLUDED.combined_summary;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(73, 131) AND herb2_id = GREATEST(73, 131);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Asthma with cardiac involvement', 10),
    ('Emphysema and COPD', 20),
    ('Cardiovascular stress from chronic respiratory illness', 30),
    ('Heart palpitations with anxiety', 40)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (73,  'Cardiotonic, anti-inflammatory; strengthens the heart and improves coronary circulation', 10),
    (131, 'Cardiotonic, nervine, antispasmodic; calms nervous palpitations and cardiac tension', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
END $$;
