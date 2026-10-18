-- Migration 398: BHC Class 17 — Nervous System 2 and Herbal Oils — Herb Pairs
-- Class name: BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose
--
-- Pairs from class notes:
--   1. Blue Vervain (983) + Night-Blooming Cereus (2616)  — NEW
--      "use for fear of death with Night Blooming Cereus"
--
--   2. Catnip (136) + Chamomile (84)  — EXISTS (herb1=84, herb2=136); APPEND context
--      "good for stress induced GI symptoms combined with Chamomile"
--
--   3. Blue Vervain (983) + Motherwort (131)  — NEW
--      "combine with motherwort" for anxiety
--
--   4. Blue Vervain (983) + Milky Oats (178)  — NEW
--      "PMS and menopausal anxiety with Milky Oats"

SET search_path TO herbal, public;

-- ─── Pair 1: Blue Vervain (983) + Night-Blooming Cereus (2616) ────────────────
DO $$
DECLARE
  v_pair_id INTEGER;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(983, 2616), GREATEST(983, 2616),
    'BHC Apprenticeship class notes',
    'Combined for fear of death; Blue Vervain dispels illusion and grounds the spirit while Night-Blooming Cereus addresses existential fear and heart-centered anxiety.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET combined_summary = herbal.herb_pairs.combined_summary
                           || ' | BHC class notes: Combined for fear of death; Blue Vervain dispels illusion and grounds the spirit while Night-Blooming Cereus addresses existential fear and heart-centered anxiety.';

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(983, 2616) AND herb2_id = GREATEST(983, 2616);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Fear of death',         10),
    ('Existential anxiety',   20)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.herb_pair_indications
    WHERE pair_id = v_pair_id AND indication = t.ind
  );

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (983,  'Dispels illusion, grounds the spirit, bitter nervine relaxant', 10),
    (2616, 'Addresses existential fear, heart-centered anxiety', 20)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.herb_pair_herb_properties
    WHERE pair_id = v_pair_id AND herb_id = t.hid
  );
END $$;

-- ─── Pair 2: Catnip (136) + Chamomile (84) — EXISTS, append context ───────────
DO $$
DECLARE
  v_pair_id INTEGER;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(84, 136), GREATEST(84, 136),
    'BHC Apprenticeship class notes',
    'Catnip and Chamomile combined for stress-induced GI symptoms, especially in children.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET combined_summary = herbal.herb_pairs.combined_summary
                           || ' | BHC class notes: Catnip and Chamomile combined for stress-induced GI symptoms, especially in children.';

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(84, 136) AND herb2_id = GREATEST(84, 136);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Stress-induced GI symptoms',             10),
    ('Digestive upset in children from stress', 20)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.herb_pair_indications
    WHERE pair_id = v_pair_id AND indication = t.ind
  );

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (84,  'Gentle nervine and carminative; soothes stomach spasms and GI irritability from stress', 10),
    (136, 'Gentle nervine and carminative; relieves stress-induced GI symptoms; safe for children', 20)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.herb_pair_herb_properties
    WHERE pair_id = v_pair_id AND herb_id = t.hid
  );
END $$;

-- ─── Pair 3: Blue Vervain (983) + Motherwort (131) ────────────────────────────
DO $$
DECLARE
  v_pair_id INTEGER;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(131, 983), GREATEST(131, 983),
    'BHC Apprenticeship class notes',
    'Combined as nervine relaxants for anxiety; Blue Vervain addresses hyper-focus and illusion while Motherwort addresses heart stress and palpitations.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET combined_summary = herbal.herb_pairs.combined_summary
                           || ' | BHC class notes: Combined as nervine relaxants for anxiety; Blue Vervain addresses hyper-focus and illusion while Motherwort addresses heart stress and palpitations.';

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(131, 983) AND herb2_id = GREATEST(131, 983);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Anxiety with palpitations',    10),
    ('PMS and menopausal anxiety',   20)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.herb_pair_indications
    WHERE pair_id = v_pair_id AND indication = t.ind
  );

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (983, 'Bitter nervine; for hyper-focus, illusion, existential fear',              10),
    (131, 'Heart nervine; for frazzled state with tendency toward palpitations',      20)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.herb_pair_herb_properties
    WHERE pair_id = v_pair_id AND herb_id = t.hid
  );
END $$;

-- ─── Pair 4: Blue Vervain (983) + Milky Oats (178) ───────────────────────────
DO $$
DECLARE
  v_pair_id INTEGER;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(178, 983), GREATEST(178, 983),
    'BHC Apprenticeship class notes',
    'Combined for PMS and menopausal anxiety; Blue Vervain brings bitter nervine relaxation while Milky Oats nourishes the frayed nervous system.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET combined_summary = herbal.herb_pairs.combined_summary
                           || ' | BHC class notes: Combined for PMS and menopausal anxiety; Blue Vervain brings bitter nervine relaxation while Milky Oats nourishes the frayed nervous system.';

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(178, 983) AND herb2_id = GREATEST(178, 983);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('PMS anxiety',         10),
    ('Menopausal anxiety',  20)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.herb_pair_indications
    WHERE pair_id = v_pair_id AND indication = t.ind
  );

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (983, 'Bitter nervine relaxant, addresses hyper-focus and illusion',                              10),
    (178, 'Nourishes the nervous system, indicated for frazzled nerves and hormonal emotional instability', 20)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.herb_pair_herb_properties
    WHERE pair_id = v_pair_id AND herb_id = t.hid
  );
END $$;
