-- Migration 393: BHC Class 19 — Herb Pairs
-- Two explicit two-herb combinations from Black North American Herbalism class notes
--
-- Pair 1: Sage + Catnip — "To calm fussy (colic) baby"
-- Pair 2: Slippery Elm + Mullein — "Bitter/Digestive Support"

SET search_path TO herbal, public;

-- Pair 1: Sage (56) + Catnip (136) for infant colic
DO $$
DECLARE
  v_pair_id INTEGER;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(56, 136), GREATEST(56, 136),
    'BHC Apprenticeship class notes',
    'Traditional African American two-herb formula for calming a fussy colic baby; sage and catnip combined as a gentle infant remedy passed down through Black North American herbal tradition.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(56, 136) AND herb2_id = GREATEST(56, 136);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Colic in infants', 10),
    ('Infant fussiness and digestive distress', 20)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (56,  'Calming, antimicrobial, and antispasmodic; helps settle infant digestive discomfort and fussiness', 10),
    (136, 'Gentle carminative and nervine; soothes infant colic, relieves gas, and calms fussiness', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
END $$;

-- Pair 2: Mullein leaf (61) + Slippery Elm (92) for digestive support
DO $$
DECLARE
  v_pair_id INTEGER;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(61, 92), GREATEST(61, 92),
    'BHC Apprenticeship class notes',
    'Traditional African American two-herb formula for bitter and digestive support; mullein leaf and slippery elm used together — the bitter stimulates digestion while the demulcent soothes and coats the gut lining.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(61, 92) AND herb2_id = GREATEST(61, 92);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Digestive support', 10),
    ('Poor digestion and gut inflammation', 20)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (61, 'Bitter and expectorant; contributes digestive bitterness to stimulate bile flow and digestive secretions', 10),
    (92, 'Demulcent and mucilaginous; soothes and coats the digestive tract, counterbalancing the bitterness with gentle nourishment', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
END $$;
