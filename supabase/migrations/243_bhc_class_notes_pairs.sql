-- Migration 243: Herb pairs surfaced from BHC Apprenticeship class notes
-- Source: instructor recommendations and research citations across multiple classes
--
-- Pairs added:
--   1. Passionflower + Skullcap         (Class 57 — GABA synergy, instructor cites research)
--   2. Bacopa + Gotu Kola               (Class 57 — nootropic synergy, instructor recommendation)
--   3. White Peony + Licorice           (Class 57/61 — hormone modulation, researched synergy)
--   4. Elder flower + Elder berry       (Class 52 — immune synergy, same plant different parts)
--   5. Hawthorn berry + Hawthorn leaf & flower  (Class 52 — cardiovascular synergy, same plant)
--   6. Sarsaparilla + Saw Palmetto      (Class 38 — instructor preference for low testosterone)
--
-- Not added (herbs missing from DB):
--   - Tribulus + Pine Pollen (neither herb in DB; add when herbs are entered)
--
-- herb_pair_indications and herb_pair_herb_properties have no UNIQUE constraints,
-- so re-runnability is handled with WHERE NOT EXISTS guards.

SET search_path TO herbal, public;

DO $$
DECLARE
  v_pair_id INTEGER;
BEGIN

  -- ── 1. Passionflower (137) + Skullcap (142) ─────────────────────────────────
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(137, 142), GREATEST(137, 142),
    'BHC Apprenticeship class notes',
    'Both herbs promote GABA activity and support the nervous system. Passionflower is indicated for frustration and nighttime restlessness; Skullcap addresses racing thoughts. The instructor cites research supporting their synergistic effect together.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(137, 142) AND herb2_id = GREATEST(137, 142);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Anxiety and nervous system support', 10),
    ('Sleep and nighttime restlessness', 20),
    ('Racing thoughts', 30)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (137, 'Reduces frustration; promotes calm and nighttime rest', 10),
    (142, 'Addresses racing thoughts; GABA-promoting nervine trophorestorative', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);

  RAISE NOTICE 'Pair 1 done: Passionflower + Skullcap (id=%)', v_pair_id;

  -- ── 2. Gotu Kola (2229) + Bacopa (2381) ─────────────────────────────────────
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(2229, 2381), GREATEST(2229, 2381),
    'BHC Apprenticeship class notes',
    'Complementary nootropic pair: Bacopa provides anxiolytic and focus support while Gotu Kola calms neuroinflammation. Instructor explicitly recommends using them together for cognitive support, anxiety, and inflammatory conditions including musculoskeletal inflammation.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(2229, 2381) AND herb2_id = GREATEST(2229, 2381);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Cognitive support and focus', 10),
    ('Anxiety', 20),
    ('Neuroinflammation', 30),
    ('Musculoskeletal inflammation', 40)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (2381, 'Anxiolytic; supports focus and cognitive performance', 10),
    (2229, 'Calms neuroinflammation; useful for musculoskeletal conditions that are red, hot, and inflamed', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);

  RAISE NOTICE 'Pair 2 done: Gotu Kola + Bacopa (id=%)', v_pair_id;

  -- ── 3. Licorice (78) + White Peony (2238) ───────────────────────────────────
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(78, 2238), GREATEST(78, 2238),
    'BHC Apprenticeship class notes',
    'Both herbs are high in active flavones and have researched synergy for hormone modulation. The combination supports hyperestrogenism by improving the DHEA-to-cortisol ratio, which promotes progesterone production to balance estrogen. The instructor always uses them together and cites specific research on their combined action.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(78, 2238) AND herb2_id = GREATEST(78, 2238);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Hyperestrogenism', 10),
    ('Hormone modulation and balancing', 20),
    ('Fibroid support', 30),
    ('Progesterone support', 40)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (2238, 'High in active flavones; supports DHEA-to-cortisol ratio', 10),
    (78, 'High in active flavones; promotes hormone balance and progesterone production', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);

  RAISE NOTICE 'Pair 3 done: Licorice + White Peony (id=%)', v_pair_id;

  -- ── 4. Elder flower (57) + Elder berry (1651) ────────────────────────────────
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(57, 1651), GREATEST(57, 1651),
    'BHC Apprenticeship class notes',
    'Different parts of Sambucus nigra used together for enhanced immune support. The instructor notes a synergistic effect when the flower and berry are combined, and cites this as an example of potentiating synergy achieved by using different parts of the same plant.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(57, 1651) AND herb2_id = GREATEST(57, 1651);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Immune support', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  RAISE NOTICE 'Pair 4 done: Elder flower + Elder berry (id=%)', v_pair_id;

  -- ── 5. Hawthorn berry (73) + Hawthorn leaf & flower (1652) ──────────────────
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(73, 1652), GREATEST(73, 1652),
    'BHC Apprenticeship class notes',
    'Different parts of Crataegus spp. with complementary cardiovascular actions: the berry targets the vasculature while the leaf and flower act on the heart muscle. Together they provide potentiating synergy for comprehensive cardiovascular support. Cited as a classic example of combining different plant parts for additive effect.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(73, 1652) AND herb2_id = GREATEST(73, 1652);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Cardiovascular support', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (73, 'Targets and supports the vasculature', 10),
    (1652, 'Targets and strengthens the heart muscle', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);

  RAISE NOTICE 'Pair 5 done: Hawthorn berry + Hawthorn leaf & flower (id=%)', v_pair_id;

  -- ── 6. Sarsaparilla (40) + Saw Palmetto (186) ───────────────────────────────
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(40, 186), GREATEST(40, 186),
    'BHC Apprenticeship class notes',
    'Instructor-preferred combination for androgen modulation and low testosterone support in AMAB bodies.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(40, 186) AND herb2_id = GREATEST(40, 186);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Low testosterone', 10),
    ('Androgen modulation', 20)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  RAISE NOTICE 'Pair 6 done: Sarsaparilla + Saw Palmetto (id=%)', v_pair_id;

  RAISE NOTICE 'Migration 243 complete — 6 BHC class notes herb pairs inserted.';
END $$;
