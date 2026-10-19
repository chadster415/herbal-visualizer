-- Migration 409: Elecampane + Wild Cherry Bark herb pair
-- Source: BHC - Class 68 - Integumentary III, Musculo Case Study section
-- "Elecampane: targeting the lungs but not cough specifically. If cough is present, add Wild Cherry."
--
-- Elecampane (id=54), Wild Cherry Bark (id=140)
-- herb1_id = LEAST(54,140) = 54, herb2_id = GREATEST(54,140) = 140

SET search_path TO herbal, public;

DO $$
DECLARE
  v_pair_id INTEGER;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(54, 140), GREATEST(54, 140),
    'BHC Apprenticeship class notes',
    'Elecampane targets deep lung structures but not cough specifically. When cough is present alongside lung pathology, add Wild Cherry Bark. Elecampane addresses the underlying pulmonary condition while Wild Cherry addresses the cough reflex directly.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET combined_summary = herbal.herb_pairs.combined_summary
                           || ' | BHC class notes: '
                           || EXCLUDED.combined_summary;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(54, 140) AND herb2_id = GREATEST(54, 140);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Bronchitis with cough', 10),
    ('Emphysema with irritable cough', 20),
    ('Chronic lung disease with accompanying cough reflex', 30),
    ('Fibrocystic pulmonary disease', 40)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (54,  'Trophorestorer for deep lung structures; addresses fibrocystic/inflammatory pulmonary pathology but not cough itself', 10),
    (140, 'Antitussive, bronchodilator, antispasmodic; directly suppresses and relaxes the cough reflex', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
END $$;
