-- Migration 380: Class 22 herb pairs
-- New pair: Peppermint + Chamomile for nausea in pregnancy
-- ("Peppermint — together with Chamomile - good combo" — Class 22 notes, Nausea and Vomiting section)
-- Skipped: Peony + Licorice (already in herb_pairs from prior BHC class notes)
-- Skipped: Plantain + Calendula + Marshmallow (three-herb formula)
-- Skipped: Wild Lettuce + Jamaican Dogwood + Corydalis (three-herb formula)
-- Skipped: Wood Betony + Calamus (personal blend reference, not explicit synergy teaching)
-- Skipped: Cramp Bark + Black Haw (interchangeable substitutes, not a synergistic pair)

SET search_path TO herbal, public;

DO $$
DECLARE
  v_pair_id INTEGER;
BEGIN
  -- Peppermint (id=55) + Chamomile (id=84)
  -- LEAST(55,84)=55, GREATEST(55,84)=84
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    55, 84,
    'BHC Apprenticeship class notes',
    'Peppermint and Chamomile are described as a ''good combo'' for nausea and vomiting in pregnancy. Peppermint addresses pain and gut spasm while Chamomile soothes and calms the digestive tract.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = 55 AND herb2_id = 84;

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Nausea and vomiting in pregnancy', 10),
    ('Morning sickness', 20),
    ('Digestive spasm with nausea', 30)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (55, 'Antispasmodic and carminative; addresses the pain and spasm component of nausea', 10),
    (84, 'Gentle anti-inflammatory and nervine; calms the digestive tract and reduces nausea-related anxiety', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);

  RAISE NOTICE 'Class 22 pairs: Peppermint + Chamomile inserted.';
END $$;
