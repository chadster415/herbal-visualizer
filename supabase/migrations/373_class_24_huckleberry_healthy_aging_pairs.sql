-- Migration 373: Class 24 — Herb pairs from Huckleberry Herb Walk and Healthy Aging
--
-- New pairs from class notes:
--   1. Echinacea + Myrrh: "stimulates immune function while addressing waste accumulation"
--      (explicitly named together with a joint function, Pancha Karma section)
--   2. Turmeric + Black Pepper: "Black Pepper does help it be more soluble in milk"
--      (piperine in Black Pepper enhances curcumin bioavailability; noted by instructor)

SET search_path TO herbal, public;

-- ── Pair 1: Echinacea (id=26) + Myrrh (id=99) ──────────────────────────────
-- LEAST(26,99)=26, GREATEST(26,99)=99

DO $$
DECLARE
  v_pair_id INTEGER;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(26, 99), GREATEST(26, 99),
    'BHC Apprenticeship class notes',
    'Echinacea and Myrrh are combined to simultaneously stimulate immune function and address waste accumulation. Echinacea activates the innate and adaptive immune response while Myrrh''s resinous antimicrobial and stimulating properties help clear stagnant waste from the tissues.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(26, 99) AND herb2_id = GREATEST(26, 99);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Immune support with concurrent waste accumulation', 10),
    ('Chronic low-grade infection in aging tissues', 20),
    ('Lymphatic and immune stimulation', 30)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (26, 'Activates innate and adaptive immune response; broad immune stimulant', 10),
    (99, 'Stimulates innate immune response; antimicrobial resin that clears waste accumulation from tissues', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
END $$;

-- ── Pair 2: Turmeric (id=203) + Black Pepper (id=2498) ──────────────────────
-- LEAST(203,2498)=203, GREATEST(203,2498)=2498

DO $$
DECLARE
  v_pair_id INTEGER;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(203, 2498), GREATEST(203, 2498),
    'BHC Apprenticeship class notes',
    'Black Pepper enhances the bioavailability of Turmeric''s curcuminoids in milk-based preparations. Piperine in Black Pepper inhibits rapid glucuronidation of curcumin, significantly increasing its absorption and systemic anti-inflammatory activity.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(203, 2498) AND herb2_id = GREATEST(203, 2498);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Systemic inflammation and chronic pain (golden milk or kitcheree)', 10),
    ('Liver support and hepatoprotection with enhanced curcumin delivery', 20),
    ('Healthy aging anti-inflammatory protocol', 30)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (203, 'Anti-inflammatory, hepatoprotective, antioxidant (suppresses Reactive Oxygen Species); active in golden milk or food preparations', 10),
    (2498, 'Piperine enhances curcumin solubility and bioavailability; helps Turmeric be more soluble in milk', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
END $$;
