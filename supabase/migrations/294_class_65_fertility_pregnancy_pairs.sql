-- Migration 294: Class 65 herb pairs — Fertility and Pregnancy
-- New pair: Dong Quai + Chasteberry (bi-weekly rotation protocol for hormone balance)
-- Checked existing: Wild Yam + Cramp Bark already exists (Priest & Priest, migration 276).
--   The threatened miscarriage formula (2p Cramp Bark : 1p Wild Yam) adds dosing context
--   but does not create a new pair.

SET search_path TO herbal, public;

DO $$
DECLARE
  v_pair_id INTEGER;
BEGIN
  -- Dong Quai (id=1009) + Chasteberry (id=190)
  -- LEAST(1009,190)=190, GREATEST=1009
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(1009, 190), GREATEST(1009, 190),
    'BHC Apprenticeship class notes',
    'Bi-weekly rotation protocol for hormone balance and fertility: Dong Quai in the follicular phase (anabolic, building, circulation stimulating) for 2 weeks, then Vitex/Chasteberry in the luteal phase (dopamine agonist targeting the pituitary, promotes sense of safety for ovulation, calms elevated prolactin) for 2 weeks. Rotating the two can be very effective for establishing regular cycles and supporting conception.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(1009, 190) AND herb2_id = GREATEST(1009, 190);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Fertility support and hormonal regulation — follicular/luteal phase cycling', 10),
    ('Hyperprolactinemia with anovulatory infertility', 20),
    ('PCOS with menstrual irregularity', 30)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (1009, 'Follicular phase — anabolic, building, and circulation stimulating; emmenagogue action to support ovum maturation', 10),
    (190,  'Luteal phase — dopamine agonist targeting the pituitary; promotes sense of safety for ovulation; calms elevated prolactin; supports progesterone production', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);

END $$;
