-- Migration 404: Class 15 — Herbs for Children (herb pairs)
-- Two new pairs from BHC Class 15 notes:
--   1. Echinacea + Elder berry — "nice to mix EP with elderberry" at first sign of cold/flu
--   2. Garlic + Mullein (flower) — garlic mullein flower oil for congestion-type earaches

SET search_path TO herbal, public;

-- ─── Pair 1: Echinacea (id=26) + Elder berry (id=1651) ───────────────────────

DO $$
DECLARE
  v_pair_id INTEGER;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(26, 1651), GREATEST(26, 1651),
    'BHC Apprenticeship class notes',
    'Echinacea and Elder berry are recommended together at the first sign of cold or flu in children: Echinacea jump-starts the immune system with frequent, higher-than-normal doses, while Elder berry provides antiviral support to disarm viruses at onset.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET combined_summary = herbal.herb_pairs.combined_summary
                           || ' | BHC class notes: '
                           || EXCLUDED.combined_summary;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(26, 1651) AND herb2_id = GREATEST(26, 1651);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('First sign of cold or flu in children', 10),
    ('Immune support and antiviral prevention at illness onset', 20)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (26,   'Jump-starts the immune system; best at frequent, higher-than-normal doses at onset', 10),
    (1651, 'Antiviral; can disarm a virus and is best used at the onset of sickness', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
END $$;

-- ─── Pair 2: Garlic (id=21) + Mullein (id=61) ────────────────────────────────

DO $$
DECLARE
  v_pair_id INTEGER;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(21, 61), GREATEST(21, 61),
    'BHC Apprenticeship class notes',
    'Garlic and Mullein flower oil is a traditional combination for congestion-type earaches in children: applied as a warm oil into the ear canal. Mullein flower tincture also serves as an anodyne for ear pain.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET combined_summary = herbal.herb_pairs.combined_summary
                           || ' | BHC class notes: '
                           || EXCLUDED.combined_summary;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(21, 61) AND herb2_id = GREATEST(21, 61);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Earache from congestion in children', 10),
    ('Ear pain relief (anodyne)', 20)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (21, 'Antimicrobial; infused in oil for topical ear treatment', 10),
    (61, 'Flower oil soothes and loosens congestion in the ear; tincture acts as an anodyne for ear pain', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
END $$;
