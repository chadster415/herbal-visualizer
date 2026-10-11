-- Migration 369: Class 25 herb pairs
-- Marshmallow + Cinnamon: explicitly noted as working together — cinnamon added to warm the cooling marshmallow
-- Skullcap + Catnip: explicitly paired for sleep glycerite in case study

SET search_path TO herbal, public;

-- Pair 1: Marshmallow (id=45) + Cinnamon (id=167)
DO $$
DECLARE
  v_pair_id INT;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(45, 167), GREATEST(45, 167),
    'BHC Apprenticeship class notes',
    'Cinnamon is added to Marshmallow to bring warmth and prevent the cooling, demulcent nature of Marshmallow from being too cold or stagnating. Classic pairing for perimenopause where moistening is needed without adding cold.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(45, 167) AND herb2_id = GREATEST(45, 167);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Perimenopause with dryness requiring demulcent support', 10),
    ('Mucous membrane dryness where warming is also needed', 20),
    ('Vaginal dryness with cold constitution', 30)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (45,  'Demulcent; moistens and soothes mucous membranes and dry tissues; cooling in nature', 10),
    (167, 'Warming carminative; adds heat to counterbalance the cooling action of Marshmallow; supports digestion and circulation', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
END $$;

-- Pair 2: Skullcap (id=142) + Catnip (id=136)
DO $$
DECLARE
  v_pair_id INT;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(136, 142), GREATEST(136, 142),
    'BHC Apprenticeship class notes',
    'Skullcap and Catnip are paired as a glycerite for sleep support, particularly in post-menopausal patients with restlessness and frequent waking. Both are nervines; skullcap provides deeper nervous system nourishment while catnip adds gentle sedative and antispasmodic support.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(136, 142) AND herb2_id = GREATEST(136, 142);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Sleep support in post-menopause with restlessness and frequent waking', 10),
    ('Nervous system support with difficulty staying asleep', 20),
    ('Menopausal insomnia with anxiety', 30)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (142, 'Nervine tonic; nourishes and tonifies the nervous system; addresses restlessness and anxiety underlying poor sleep', 10),
    (136, 'Nervine and mild sedative; antispasmodic; gentle enough for glycerite use; calms nervous excitability', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
END $$;
