-- Migration 359: Class 72 – Stroke (herb pairs)
-- Ginkgo + Bacopa: head oil massage pair for cognitive and brain health support in stroke recovery.
-- Source: BHC Class 72 personal notes (Shereel) — "oil with Bacopa and Ginkgo and massage the head"

SET search_path TO herbal, public;

DO $$
DECLARE
  v_pair_id INTEGER;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(165, 2381), GREATEST(165, 2381),
    'BHC Apprenticeship class notes',
    'Used together as a medicinal head oil to support cerebral circulation, memory, and cognitive function in stroke recovery. Ginkgo enhances blood flow to the brain while Bacopa supports neuroplasticity and reduces anxiety.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(165, 2381) AND herb2_id = GREATEST(165, 2381);

  IF v_pair_id IS NULL THEN
    RAISE NOTICE 'Ginkgo + Bacopa pair already exists, skipping indications/properties';
    RETURN;
  END IF;

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Stroke recovery and rehabilitation', 10),
    ('Cognitive decline and brain fog', 20),
    ('Memory support', 30),
    ('Anxiety associated with neurological conditions', 40)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (165, 'Enhances cerebral circulation and provides neuroprotective antioxidant activity', 10),
    (2381, 'Supports memory, reduces anxiety, and promotes neuroplasticity; used in Ayurvedic medicine for brain health', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);

END $$;
