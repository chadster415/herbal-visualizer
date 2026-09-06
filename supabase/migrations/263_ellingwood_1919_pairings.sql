-- Migration 263: Herb pairs from Ellingwood's American Materia Medica (1919)
-- Source: Finley Ellingwood, American Materia Medica, Therapeutics and Pharmacognosy (1919),
--         Southwest School of Botanical Medicine plants-only edition.
-- Input file: ellingwood_explicit_herb_pairings.txt
-- Requires: migration 262 (13 missing herbs added)
--
-- 73 pairs from 73 data rows (all unique herb combinations).
-- 2 pairs already exist from Scudder (migration 257):
--   Belladonna + Aconite    — Ellingwood adds mastitis/congestive indications
--   Phytolacca + Aconite   — Ellingwood adds mastitis indication
-- For those 2, the herb_pairs INSERT is a no-op; Ellingwood indications are appended.
--
-- Herb ID constants (existing corpus as of migration 261):
--   148  Agrimony (Agrimonia eupatoria)
--   178  Oat milky oats (Avena sativa)
--  2600  Belladonna (Atropa belladonna, Leaf)
--  2598  Aconite (Aconitum napellus, Root)
--    36  Pasqueflower / Pulsatilla (Pulsatilla vulgaris)
--   645  Yellow Jasmine / Gelsemium (Gelsemium sempervirens)
--    93  Cramp Bark (Viburnum opulus)
--    25  Black Cohosh (Actaea racemosa)
--    72  Blue Cohosh (Caulophyllum thalictroides)
--  1058  Life Root (Senecio aureus)
--    47  Cayenne (Capsicum annuum)
--   175  Black Root / Leptandra (Leptandra virginica)
--   154  Rhubarb (Rheum palmatum)
--    55  Peppermint (Mentha piperita)
--   124  Ginger (Zingiber officinale)
--  2498  Black Pepper (Piper nigrum)
--    30  Goldenseal (Hydrastis canadensis)
--    26  Echinacea (Echinacea spp.)
--   158  Barberry (Berberis vulgaris)
--    41  Queen's Delight / Stillingia (Stillingia sylvatica)
--   132  Lobelia (Lobelia inflata)
--   137  Passionflower (Passiflora incarnata)
--   126  Sundew / Drosera (Drosera rotundifolia)
--   192  Ipecac (Cephaelis ipecacuanha)
--  2231  Grindelia (Grindelia squarrosa, flowering tops)
--   174  Butternut (Juglans cinerea)
--   122  Dandelion root (Taraxacum officinale)
--  2604  Nux Vomica (Strychnos nux-vomica, Seed)
--  2239  Pipsissewa (Chimaphila umbellata)
--    24  Fringetree (Chionanthus virginicus)
--   133  Bugleweed (Lycopus spp.)
--   188  Partridgeberry (Mitchella repens)
--   119  Bayberry (Myrica cerifera)
--    52  Cranesbill (Geranium maculatum)
--    67  Pleurisy Root (Asclepias tuberosa)
--    35  Poke Root (Phytolacca americana)
--  2605  Podophyllum (Podophyllum peltatum, Root)
--   182  Stoneroot (Collinsonia canadensis)
--    86  Aspen / Poplar (Populus tremuloides)
--  2606  Poison Ivy / Rhus tox (Toxicodendron radicans, Leaf)
--  2479  Spikenard (Aralia racemosa)

SET search_path TO herbal, public;

DO $$
DECLARE
  -- Existing herb IDs (hardcoded from DB state after migration 261)
  v_agrimony      CONSTANT INTEGER := 148;
  v_avena         CONSTANT INTEGER := 178;   -- milky oats
  v_belladonna    CONSTANT INTEGER := 2600;
  v_aconite       CONSTANT INTEGER := 2598;
  v_pulsatilla    CONSTANT INTEGER := 36;
  v_gelsemium     CONSTANT INTEGER := 645;
  v_cramp_bark    CONSTANT INTEGER := 93;
  v_black_coh     CONSTANT INTEGER := 25;
  v_blue_coh      CONSTANT INTEGER := 72;
  v_life_root     CONSTANT INTEGER := 1058;
  v_capsicum      CONSTANT INTEGER := 47;
  v_leptandra     CONSTANT INTEGER := 175;
  v_rhubarb       CONSTANT INTEGER := 154;
  v_peppermint    CONSTANT INTEGER := 55;
  v_ginger        CONSTANT INTEGER := 124;
  v_blackpepper   CONSTANT INTEGER := 2498;
  v_goldenseal    CONSTANT INTEGER := 30;
  v_echinacea     CONSTANT INTEGER := 26;
  v_barberry      CONSTANT INTEGER := 158;
  v_stillingia    CONSTANT INTEGER := 41;
  v_lobelia       CONSTANT INTEGER := 132;
  v_passionflower CONSTANT INTEGER := 137;
  v_sundew        CONSTANT INTEGER := 126;
  v_ipecac        CONSTANT INTEGER := 192;
  v_grindelia     CONSTANT INTEGER := 2231;
  v_butternut     CONSTANT INTEGER := 174;
  v_dandelion     CONSTANT INTEGER := 122;   -- root
  v_nux           CONSTANT INTEGER := 2604;
  v_pipsissewa    CONSTANT INTEGER := 2239;
  v_fringetree    CONSTANT INTEGER := 24;
  v_bugleweed     CONSTANT INTEGER := 133;
  v_mitchella     CONSTANT INTEGER := 188;
  v_bayberry      CONSTANT INTEGER := 119;
  v_cranesbill    CONSTANT INTEGER := 52;
  v_pleurisy_root CONSTANT INTEGER := 67;
  v_pokeroot      CONSTANT INTEGER := 35;
  v_podophyllum   CONSTANT INTEGER := 2605;
  v_stoneroot     CONSTANT INTEGER := 182;
  v_aspen         CONSTANT INTEGER := 86;
  v_rhus          CONSTANT INTEGER := 2606;
  v_spikenard     CONSTANT INTEGER := 2479;
  v_senna         CONSTANT INTEGER := 216;

  -- New herb IDs (from migration 262 — looked up by latin_name)
  v_aletris       INTEGER;
  v_bryonia       INTEGER;
  v_turkey_corn   INTEGER;
  v_epilobium     INTEGER;
  v_hyoscyamus    INTEGER;
  v_physostigma   INTEGER;
  v_cactus        INTEGER;
  v_false_unicorn INTEGER;
  v_sticta        INTEGER;
  v_jalap         INTEGER;
  v_conium        INTEGER;
  v_strophanthus  INTEGER;
  v_stramonium    INTEGER;

  v_src      CONSTANT TEXT := 'Ellingwood, American Materia Medica, Therapeutics and Pharmacognosy (1919)';
  v_pair_id  INTEGER;
BEGIN

  -- Resolve new herb IDs from migration 262
  SELECT id INTO v_aletris       FROM herbal.herbs WHERE latin_name = 'Aletris farinosa';
  SELECT id INTO v_bryonia       FROM herbal.herbs WHERE latin_name = 'Bryonia alba';
  SELECT id INTO v_turkey_corn   FROM herbal.herbs WHERE latin_name = 'Corydalis formosa';
  SELECT id INTO v_epilobium     FROM herbal.herbs WHERE latin_name = 'Epilobium angustifolium';
  SELECT id INTO v_hyoscyamus    FROM herbal.herbs WHERE latin_name = 'Hyoscyamus niger';
  SELECT id INTO v_physostigma   FROM herbal.herbs WHERE latin_name = 'Physostigma venenosum';
  SELECT id INTO v_cactus        FROM herbal.herbs WHERE latin_name = 'Selenicereus grandiflorus';
  SELECT id INTO v_false_unicorn FROM herbal.herbs WHERE latin_name = 'Chamaelirium luteum';
  SELECT id INTO v_sticta        FROM herbal.herbs WHERE latin_name = 'Sticta pulmonaria';
  SELECT id INTO v_jalap         FROM herbal.herbs WHERE latin_name = 'Ipomoea purga';
  SELECT id INTO v_conium        FROM herbal.herbs WHERE latin_name = 'Conium maculatum';
  SELECT id INTO v_strophanthus  FROM herbal.herbs WHERE latin_name = 'Strophanthus kombé';
  SELECT id INTO v_stramonium    FROM herbal.herbs WHERE latin_name = 'Datura stramonium';

  IF v_aletris IS NULL OR v_bryonia IS NULL OR v_turkey_corn IS NULL OR
     v_epilobium IS NULL OR v_hyoscyamus IS NULL OR v_physostigma IS NULL OR
     v_cactus IS NULL OR v_false_unicorn IS NULL OR v_sticta IS NULL OR
     v_jalap IS NULL OR v_conium IS NULL OR v_strophanthus IS NULL OR
     v_stramonium IS NULL THEN
    RAISE EXCEPTION 'One or more new herbs from migration 262 not found — run migration 262 first.';
  END IF;

  -- ── ALETRIS GROUP (5 pairs) ───────────────────────────────────────────────

  -- 1. Aletris + Blue Cohosh
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_aletris, v_blue_coh), GREATEST(v_aletris, v_blue_coh), v_src,
    'Ellingwood recommends alternating or combining Aletris with Blue cohosh for chlorosis, amenorrhea, dysmenorrhea, and uterine engorgement or prolapse. Aletris provides bitter tonic uterine support while Caulophyllum addresses spasmodic and obstructive uterine conditions. A complementary pairing for deficient and atonic female reproductive states.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_aletris, v_blue_coh) AND herb2_id = GREATEST(v_aletris, v_blue_coh);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Chlorosis, amenorrhea, dysmenorrhea, uterine engorgement or prolapse', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_aletris,   'Bitter uterine tonic; Ellingwood''s primary herb for debilitated and atonic uterine states', 10),
    (v_blue_coh,  'Antispasmodic and emmenagogue; addresses spasmodic, obstructive, and atonic uterine conditions', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 1: Aletris + Blue Cohosh (id=%)', v_pair_id;

  -- 2. Aletris + Black Cohosh
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_aletris, v_black_coh), GREATEST(v_aletris, v_black_coh), v_src,
    'Ellingwood recommends alternating or combining Aletris with Black cohosh for chlorosis, amenorrhea, dysmenorrhea, and uterine prolapse. A foundational pairing for chronic female reproductive deficiency states; Aletris provides bitter tonic support while Black cohosh contributes antispasmodic and hormonal-normalizing properties.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_aletris, v_black_coh) AND herb2_id = GREATEST(v_aletris, v_black_coh);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Chlorosis, amenorrhea, dysmenorrhea, uterine engorgement or prolapse', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_aletris,   'Bitter uterine tonic; addresses deficient and atonic uterine tone', 10),
    (v_black_coh, 'Antispasmodic and phytoestrogenic; Ellingwood pairs with Aletris across a broad range of chronic female reproductive deficiency states', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 2: Aletris + Black Cohosh (id=%)', v_pair_id;

  -- 3. Aletris + Life Root (Senecio aureus)
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_aletris, v_life_root), GREATEST(v_aletris, v_life_root), v_src,
    'Ellingwood recommends alternating or combining Aletris with Life Root (Senecio aureus) for chlorosis, amenorrhea, dysmenorrhea, and uterine engorgement. Both are eclectic uterine tonics with affinity for debilitated female reproductive states; the combination addresses a broad spectrum of pelvic insufficiency.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_aletris, v_life_root) AND herb2_id = GREATEST(v_aletris, v_life_root);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Chlorosis, amenorrhea, dysmenorrhea, uterine engorgement or prolapse', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_aletris,   'Bitter uterine tonic for deficient and atonic pelvic states', 10),
    (v_life_root, 'Stimulant uterine tonic and emmenagogue; Senecio aureus was Ellingwood''s specific for amenorrhea with debility', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 3: Aletris + Life Root (id=%)', v_pair_id;

  -- 4. Aletris + False Unicorn (Chamaelirium)
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_aletris, v_false_unicorn), GREATEST(v_aletris, v_false_unicorn), v_src,
    'Ellingwood recommends combining or alternating Aletris with False Unicorn (Chamaelirium luteum / Helonias) for chlorosis, amenorrhea, dysmenorrhea, and uterine prolapse. False Unicorn is the premier ovarian tonic in eclectic practice; its restorative action on the female reproductive system complements Aletris''s uterine tonic properties.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_aletris, v_false_unicorn) AND herb2_id = GREATEST(v_aletris, v_false_unicorn);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Chlorosis, amenorrhea, dysmenorrhea, uterine engorgement or prolapse', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_aletris,       'Bitter uterine tonic for atonic and deficient pelvic states', 10),
    (v_false_unicorn, 'Ovarian and uterine restorative; Ellingwood''s (Helonias) premier tonic for debilitated female reproductive function', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 4: Aletris + False Unicorn (id=%)', v_pair_id;

  -- 5. Aletris + Cramp Bark
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_aletris, v_cramp_bark), GREATEST(v_aletris, v_cramp_bark), v_src,
    'A correspondent quoted by Ellingwood frequently combined Aletris with Cramp bark for threatened abortion and uterine irritability. Cramp bark''s direct antispasmodic action on the uterine muscle provides relief of cramping while Aletris supports underlying uterine tone and nerve supply.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_aletris, v_cramp_bark) AND herb2_id = GREATEST(v_aletris, v_cramp_bark);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Threatened abortion and uterine irritability', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_aletris,    'Bitter uterine tonic; supports underlying uterine tone and nerve supply', 10),
    (v_cramp_bark, 'Antispasmodic on uterine muscle; Ellingwood correspondent combined with Aletris specifically for threatened miscarriage', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 5: Aletris + Cramp Bark (id=%)', v_pair_id;

  -- ── AGRIMONY GROUP (3 pairs) ──────────────────────────────────────────────

  -- 6. Agrimony + Black Cohosh
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_agrimony, v_black_coh), GREATEST(v_agrimony, v_black_coh), v_src,
    'Ellingwood notes he would combine Agrimony with Black cohosh for dysuria occurring alongside dysmenorrhea and pelvic nervous symptoms. Agrimony''s astringent urinary tonic action is supported by Black cohosh''s antispasmodic and pelvic-neural properties.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_agrimony, v_black_coh) AND herb2_id = GREATEST(v_agrimony, v_black_coh);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Dysuria with dysmenorrhea and pelvic nervous symptoms', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_agrimony,  'Astringent urinary and GI tonic; addresses irritable urinary mucous membranes', 10),
    (v_black_coh, 'Antispasmodic on pelvic musculature and nerves; extends Agrimony''s urinary action to the pelvic nerve complex', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 6: Agrimony + Black Cohosh (id=%)', v_pair_id;

  -- 7. Agrimony + Gelsemium
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_agrimony, v_gelsemium), GREATEST(v_agrimony, v_gelsemium), v_src,
    'Ellingwood notes he would combine Agrimony with Gelsemium for dysuria with dysmenorrhea and pelvic nervous symptoms. Gelsemium''s sedative and antispasmodic action on the pelvic nerves complements Agrimony''s astringent urinary tonic.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_agrimony, v_gelsemium) AND herb2_id = GREATEST(v_agrimony, v_gelsemium);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Dysuria with dysmenorrhea and pelvic nervous symptoms', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_agrimony,  'Astringent urinary tonic; addresses irritable urinary mucous membranes', 10),
    (v_gelsemium, 'Sedative and antispasmodic on the nervous system and smooth muscle; addresses the pelvic neural component of dysuria', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 7: Agrimony + Gelsemium (id=%)', v_pair_id;

  -- 8. Agrimony + Pulsatilla
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_agrimony, v_pulsatilla), GREATEST(v_agrimony, v_pulsatilla), v_src,
    'Ellingwood notes he would combine Agrimony with Pulsatilla for dysuria with dysmenorrhea and pelvic nervous symptoms. Pulsatilla''s affinity for the female pelvic organs and its sedative/antispasmodic properties complement Agrimony''s astringent urinary tonic action.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_agrimony, v_pulsatilla) AND herb2_id = GREATEST(v_agrimony, v_pulsatilla);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Dysuria with dysmenorrhea and pelvic nervous symptoms', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_agrimony,   'Astringent urinary and pelvic tonic', 10),
    (v_pulsatilla, 'Pelvic organ affinity; sedative and antispasmodic for the female reproductive and urinary tract', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 8: Agrimony + Pulsatilla (id=%)', v_pair_id;

  -- ── AVENA GROUP (1 pair) ──────────────────────────────────────────────────

  -- 9. Avena + Capsicum
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_avena, v_capsicum), GREATEST(v_avena, v_capsicum), v_src,
    'Ellingwood notes that Avena (oat, milky oats) is especially useful for nerve exhaustion and certain cases of paralysis when conjoined with Capsicum. Capsicum''s stimulant and peripheral circulation-promoting action supports Avena''s restorative effect on an exhausted or depressed nervous system.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_avena, v_capsicum) AND herb2_id = GREATEST(v_avena, v_capsicum);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Certain cases of paralysis and nervous exhaustion requiring stimulant support', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_avena,    'Nervine restorative; rebuilds exhausted nervous tissue over time', 10),
    (v_capsicum, 'Circulatory and peripheral nerve stimulant; provides the immediate stimulant support that activates Avena''s restorative action', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 9: Avena + Capsicum (id=%)', v_pair_id;

  -- ── BELLADONNA GROUP (2 pairs) ────────────────────────────────────────────
  -- Note: Belladonna + Aconite already exists from Scudder (migration 257).
  -- The INSERT is a no-op; only Ellingwood's additional indication is appended.

  -- 10. Belladonna + Aconite [pre-existing — add Ellingwood indication only]
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_belladonna, v_aconite), GREATEST(v_belladonna, v_aconite), v_src,
    'Ellingwood describes Belladonna combined with Aconite as a reliable combination for acute congestive and inflammatory states, including erysipelas.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_belladonna, v_aconite) AND herb2_id = GREATEST(v_belladonna, v_aconite);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Acute congestive and inflammatory states, including erysipelas', 60)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  RAISE NOTICE 'Pair 10: Belladonna + Aconite (existing pair, Ellingwood indication appended, id=%)', v_pair_id;

  -- 11. Belladonna + Rhus tox
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_belladonna, v_rhus), GREATEST(v_belladonna, v_rhus), v_src,
    'Ellingwood reports that Belladonna is alternated with Rhus toxicodendron (Poison ivy) in erysipelas with sluggish dark-red tissue involvement. Belladonna addresses the acute congestive and febrile component while Rhus tox acts on the darker, more venous tissue presentation.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_belladonna, v_rhus) AND herb2_id = GREATEST(v_belladonna, v_rhus);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Erysipelas with sluggish, dark-red tissue involvement', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_belladonna, 'Addresses the acute congestive and febrile component of erysipelas; bright-red tissue affinity', 10),
    (v_rhus,       'Acts on the darker, more sluggish and venous tissue presentation; Ellingwood alternates with Belladonna in erysipelas', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 11: Belladonna + Rhus tox (id=%)', v_pair_id;

  -- ── BRYONIA GROUP (1 pair) ────────────────────────────────────────────────

  -- 12. Bryonia + Sticta
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_bryonia, v_sticta), GREATEST(v_bryonia, v_sticta), v_src,
    'Ellingwood reports a case of pain under the right shoulder/right side increased by inspiration that was immediately relieved by the combination of Bryonia and Sticta (lung lichen). Bryonia''s fibrous-tissue and pleuritic affinity combines with Sticta''s specific respiratory mucous membrane action for pleuro-respiratory pain presentations.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_bryonia, v_sticta) AND herb2_id = GREATEST(v_bryonia, v_sticta);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Pleuritic pain under right shoulder or right side aggravated by inspiration', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_bryonia, 'Fibrous tissue and serous membrane affinity; classic for pleuritic and pleural-friction pain', 10),
    (v_sticta,  'Respiratory mucous membrane specific; Sticta pulmonaria (lung lichen) used in eclectic practice for dry irritative respiratory coughs and pleuritic states', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 12: Bryonia + Sticta (id=%)', v_pair_id;

  -- ── SENNA GROUP (7 pairs) ─────────────────────────────────────────────────

  -- 13. Senna + Ginger
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_senna, v_ginger), GREATEST(v_senna, v_ginger), v_src,
    'Ellingwood lists Ginger among Senna''s cooperatives for atonic constipation and inactive bowels. Ginger''s carminative and warming action reduces Senna''s griping tendency while adding stimulant circulatory support to an atonic lower GI.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_senna, v_ginger) AND herb2_id = GREATEST(v_senna, v_ginger);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Atonic constipation and inactive bowels', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_senna,  'Cathartic; primary purgative action on the lower bowel', 10),
    (v_ginger, 'Carminative and warming; reduces Senna''s griping tendency and adds stimulant circulatory support', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 13: Senna + Ginger (id=%)', v_pair_id;

  -- 14. Senna + Capsicum
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_senna, v_capsicum), GREATEST(v_senna, v_capsicum), v_src,
    'Ellingwood lists Capsicum among Senna''s cooperatives for atonic constipation and inactive bowels. Capsicum''s pungent stimulant action counters Senna''s tendency toward griping and adds peripheral circulatory and bowel-wall stimulation to the purgative effect.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_senna, v_capsicum) AND herb2_id = GREATEST(v_senna, v_capsicum);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Atonic constipation and inactive bowels', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_senna,   'Cathartic; primary purgative action on the lower bowel', 10),
    (v_capsicum, 'Pungent stimulant carminative; reduces Senna griping and activates peripheral bowel-wall circulation', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 14: Senna + Capsicum (id=%)', v_pair_id;

  -- 15. Senna + Black Pepper
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_senna, v_blackpepper), GREATEST(v_senna, v_blackpepper), v_src,
    'Ellingwood lists Black pepper among Senna''s cooperatives for atonic constipation and inactive bowels. Black pepper''s aromatic carminative and mild stimulant action reduces patient discomfort from Senna''s purgative effect in atonic bowel states.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_senna, v_blackpepper) AND herb2_id = GREATEST(v_senna, v_blackpepper);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Atonic constipation and inactive bowels', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_senna,      'Cathartic; primary purgative action', 10),
    (v_blackpepper, 'Aromatic carminative stimulant; reduces discomfort and adds mild stimulant correction to Senna''s bowel action', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 15: Senna + Black Pepper (id=%)', v_pair_id;

  -- 16. Senna + Leptandra
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_senna, v_leptandra), GREATEST(v_senna, v_leptandra), v_src,
    'Ellingwood explicitly describes Senna combined with Leptandra (Black Root) as acting more specifically on the liver than either herb alone. Leptandra''s cholagogue and hepatic tonic action extends Senna''s cathartic effect to a more targeted hepatic-cathartic preparation for bilious constipation.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_senna, v_leptandra) AND herb2_id = GREATEST(v_senna, v_leptandra);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Constipation requiring more specific action on the liver', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_senna,    'Cathartic; provides the purgative bowel action', 10),
    (v_leptandra, 'Cholagogue and hepatic tonic; focuses the combination more specifically on the liver', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 16: Senna + Leptandra (id=%)', v_pair_id;

  -- 17. Senna + Jalap
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_senna, v_jalap), GREATEST(v_senna, v_jalap), v_src,
    'Ellingwood explicitly notes the traditional antibilious physic combination of Senna and Jalap (Ipomoea purga). Both are purgatives of different chemical character whose combination was the classic eclectic preparation for bilious states, traditionally given with Ginger as corrective.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_senna, v_jalap) AND herb2_id = GREATEST(v_senna, v_jalap);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Traditional antibilious physic; bilious constipation', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_senna, 'Anthraquinone cathartic; provides the primary purgative drive', 10),
    (v_jalap,  'Resinous cathartic of different mechanism; traditional partner in the antibilious physic combination', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 17: Senna + Jalap (id=%)', v_pair_id;

  -- 18. Senna + Rhubarb
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_senna, v_rhubarb), GREATEST(v_senna, v_rhubarb), v_src,
    'Ellingwood explicitly describes Senna combined with Rhubarb as of improved value over either alone, providing a tonic, laxative, and carminative effect. Rhubarb adds its astringent tonic and mild bitter properties to Senna''s purely cathartic action, creating a more balanced preparation with intestinal tonic benefit.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_senna, v_rhubarb) AND herb2_id = GREATEST(v_senna, v_rhubarb);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Constipation requiring combined laxative, tonic, and carminative effect', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_senna,   'Cathartic; primary purgative action', 10),
    (v_rhubarb, 'Astringent tonic and mild bitter laxative; adds intestinal tonic and carminative properties to the preparation', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 18: Senna + Rhubarb (id=%)', v_pair_id;

  -- 19. Senna + Peppermint
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_senna, v_peppermint), GREATEST(v_senna, v_peppermint), v_src,
    'Ellingwood explicitly describes Senna combined with Peppermint as of improved value, providing a laxative and carminative preparation with better patient tolerance. Peppermint''s carminative action reduces Senna''s griping tendency while its aromatic oils correct the flavor and improve the overall preparation.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_senna, v_peppermint) AND herb2_id = GREATEST(v_senna, v_peppermint);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Constipation requiring laxative and carminative combination with improved tolerance', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_senna,      'Cathartic; primary purgative action', 10),
    (v_peppermint, 'Aromatic carminative; reduces cramping, improves flavor, and adds carminative correction to the cathartic preparation', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 19: Senna + Peppermint (id=%)', v_pair_id;

  -- ── COLLINSONIA GROUP (2 pairs) ───────────────────────────────────────────

  -- 20. Collinsonia + Goldenseal
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_stoneroot, v_goldenseal), GREATEST(v_stoneroot, v_goldenseal), v_src,
    'Ellingwood calls the Collinsonia-Goldenseal combination a pair of first importance and a superb general tonic for catarrhal gastritis with defective circulation and relaxed or debilitated states. Collinsonia tonifies the portal and rectal venous circulation while Goldenseal addresses the catarrhal mucous membrane component.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_stoneroot, v_goldenseal) AND herb2_id = GREATEST(v_stoneroot, v_goldenseal);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Catarrhal gastritis with defective portal circulation; relaxed or debilitated states', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_stoneroot,  'Portal and rectal venous tonic; addresses defective pelvic-portal circulation', 10),
    (v_goldenseal, 'Bitter tonic and astringent mucous membrane tonic; addresses the catarrhal gastric component', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 20: Collinsonia + Goldenseal (id=%)', v_pair_id;

  -- 21. Collinsonia + Aconite
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_stoneroot, v_aconite), GREATEST(v_stoneroot, v_aconite), v_src,
    'Ellingwood notes that Shoemaker obtained excellent results combining Collinsonia with Aconite for acute cystitis. Collinsonia''s specific action on the bladder mucous membrane and venous circulation is supported by Aconite''s acute anti-inflammatory and sedative properties.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_stoneroot, v_aconite) AND herb2_id = GREATEST(v_stoneroot, v_aconite);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Acute cystitis', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_stoneroot, 'Bladder mucous membrane and venous tonic; Collinsonia specific for urinary tract congestion', 10),
    (v_aconite,   'Acute anti-inflammatory and sedative; addresses the febrile and acute inflammatory component of cystitis', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 21: Collinsonia + Aconite (id=%)', v_pair_id;

  -- ── CORYDALIS (TURKEY CORN) GROUP (4 pairs) ───────────────────────────────

  -- 22. Corydalis (Turkey Corn) + Echinacea
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_turkey_corn, v_echinacea), GREATEST(v_turkey_corn, v_echinacea), v_src,
    'Ellingwood describes Corydalis (Turkey Corn) as operating in harmony with Echinacea for syphilis, scrofula, glandular derangement, and impaired nutrition. Corydalis provides alterative, analgesic, and antispasmodic properties while Echinacea contributes its broad anti-infective and lymphatic-stimulating action.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_turkey_corn, v_echinacea) AND herb2_id = GREATEST(v_turkey_corn, v_echinacea);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Syphilis, scrofula, glandular derangement, and impaired nutrition', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_turkey_corn, 'Alterative, analgesic, and antispasmodic; eclectic use for deep-seated chronic infections and glandular involvement', 10),
    (v_echinacea,   'Anti-infective and lymphatic stimulant; Ellingwood says Corydalis operates in harmony with Echinacea in this range of conditions', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 22: Corydalis + Echinacea (id=%)', v_pair_id;

  -- 23. Corydalis + Barberry
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_turkey_corn, v_barberry), GREATEST(v_turkey_corn, v_barberry), v_src,
    'Ellingwood notes Corydalis (Turkey Corn) acts well with Barberry in some cases of syphilis, scrofula, and glandular derangement. Barberry''s bitter hepatic and antimicrobial berberine-based action complements Corydalis''s alterative and analgesic properties for chronic deep-tissue infections.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_turkey_corn, v_barberry) AND herb2_id = GREATEST(v_turkey_corn, v_barberry);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Syphilis, scrofula, glandular derangement, and impaired nutrition', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_turkey_corn, 'Alterative and analgesic; addresses chronic glandular and infectious states', 10),
    (v_barberry,    'Bitter hepatic and antimicrobial; Ellingwood notes Corydalis acts well with Berberis in some of these cases', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 23: Corydalis + Barberry (id=%)', v_pair_id;

  -- 24. Corydalis + Goldenseal
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_turkey_corn, v_goldenseal), GREATEST(v_turkey_corn, v_goldenseal), v_src,
    'Ellingwood notes Corydalis (Turkey Corn) acts well with Goldenseal in some cases of syphilis, scrofula, and glandular derangement. Goldenseal''s antimicrobial and astringent mucous membrane tonic properties complement Corydalis''s alterative and analgesic action in chronic glandular states.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_turkey_corn, v_goldenseal) AND herb2_id = GREATEST(v_turkey_corn, v_goldenseal);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Syphilis, scrofula, glandular derangement, and impaired nutrition', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_turkey_corn, 'Alterative and analgesic; addresses chronic glandular and infectious states', 10),
    (v_goldenseal,  'Antimicrobial and mucous membrane tonic; Ellingwood notes Corydalis acts well with Hydrastis in some of these cases', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 24: Corydalis + Goldenseal (id=%)', v_pair_id;

  -- 25. Corydalis + Stillingia
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_turkey_corn, v_stillingia), GREATEST(v_turkey_corn, v_stillingia), v_src,
    'Ellingwood notes Corydalis (Turkey Corn) acts well with Stillingia (Queen''s Delight) in some cases of syphilis, scrofula, and glandular derangement. Stillingia''s powerful lymphatic and alterative action augments Corydalis''s milder alterative and analgesic properties for deep-seated chronic conditions.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_turkey_corn, v_stillingia) AND herb2_id = GREATEST(v_turkey_corn, v_stillingia);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Syphilis, scrofula, glandular derangement, and impaired nutrition', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_turkey_corn, 'Alterative and analgesic; addresses chronic glandular and infectious states', 10),
    (v_stillingia,  'Powerful lymphatic and alterative; Ellingwood notes Corydalis acts well with Stillingia in some of these cases', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 25: Corydalis + Stillingia (id=%)', v_pair_id;

  -- ── EPILOBIUM GROUP (1 pair) ──────────────────────────────────────────────

  -- 26. Epilobium + Butternut (Juglans cinerea)
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_epilobium, v_butternut), GREATEST(v_epilobium, v_butternut), v_src,
    'Ellingwood reports a physician who often gave Epilobium in conjunction with Juglans (Butternut) for chronic eczema, particularly persistent papular-to-squamous cases. Epilobium''s demulcent anti-inflammatory action on skin is complemented by Butternut''s alterative and hepatic laxative properties that address the systemic eliminative component of chronic skin disease.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_epilobium, v_butternut) AND herb2_id = GREATEST(v_epilobium, v_butternut);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Chronic eczema, especially persistent papular-to-squamous cases', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_epilobium, 'Demulcent and anti-inflammatory; specific affinity for skin mucous membrane states in eclectic practice', 10),
    (v_butternut, 'Alterative hepatic laxative; addresses the systemic eliminative and hepatic component of chronic skin conditions', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 26: Epilobium + Butternut (id=%)', v_pair_id;

  -- ── GELSEMIUM GROUP (4 pairs) ─────────────────────────────────────────────

  -- 27. Gelsemium + Black Cohosh
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_gelsemium, v_black_coh), GREATEST(v_gelsemium, v_black_coh), v_src,
    'Ellingwood calls Black cohosh an excellent agent to combine with Gelsemium, noting it promotes Gelsemium''s action in cases involving muscular participation, heart complaints, and irritable or inflammatory urinary tract conditions. The pairing broadens Gelsemium''s narrow motor-nerve action into the musculoskeletal and cardiac territory where Black cohosh excels.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_gelsemium, v_black_coh) AND herb2_id = GREATEST(v_gelsemium, v_black_coh);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Conditions with muscular involvement, heart trouble, or irritable/inflammatory urinary tract', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_gelsemium, 'Motor nerve sedative and antispasmodic; primary herb for spasmodic and febrile neural states', 10),
    (v_black_coh, 'Musculoskeletal antispasmodic and cardiac tonic; Ellingwood calls it an excellent combination partner that promotes Gelsemium''s action', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 27: Gelsemium + Black Cohosh (id=%)', v_pair_id;

  -- 28. Gelsemium + Lobelia
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_gelsemium, v_lobelia), GREATEST(v_gelsemium, v_lobelia), v_src,
    'Ellingwood notes Gelsemium and Lobelia act well together in selected cases of severe convulsive manifestations. Lobelia''s direct antispasmodic and vagal depressant action on the respiratory and systemic musculature complements Gelsemium''s motor-nerve sedative properties for severe spasmodic states.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_gelsemium, v_lobelia) AND herb2_id = GREATEST(v_gelsemium, v_lobelia);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Severe convulsive manifestations', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_gelsemium, 'Motor nerve sedative; depresses the motor nerve centers to reduce convulsive threshold', 10),
    (v_lobelia,   'Antispasmodic and vagal depressant; acts well with Gelsemium in selected severe convulsive cases', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 28: Gelsemium + Lobelia (id=%)', v_pair_id;

  -- 29. Gelsemium + Passionflower
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_gelsemium, v_passionflower), GREATEST(v_gelsemium, v_passionflower), v_src,
    'Ellingwood lists Passionflower among agents acting harmoniously with Gelsemium where sedative support is indicated. Passionflower''s anxiolytic and sleep-promoting nervine properties extend Gelsemium''s motor-nerve depressant action into the emotional and sleep disturbance territory.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_gelsemium, v_passionflower) AND herb2_id = GREATEST(v_gelsemium, v_passionflower);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Conditions calling for Gelsemium with added nervine sedative support', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_gelsemium,    'Motor nerve sedative; primary for spasmodic and febrile neural states', 10),
    (v_passionflower, 'Nervine sedative and anxiolytic; Ellingwood lists Passiflora as acting harmoniously with Gelsemium', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 29: Gelsemium + Passionflower (id=%)', v_pair_id;

  -- 30. Gelsemium + Conium
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_gelsemium, v_conium), GREATEST(v_gelsemium, v_conium), v_src,
    'Ellingwood lists Conium (Poison hemlock) among agents acting harmoniously with Gelsemium where sedative support is indicated. Both are powerful nervous system depressants used in eclectic practice with extreme care; the combination provides a broad range of sedative-antispasmodic effect.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_gelsemium, v_conium) AND herb2_id = GREATEST(v_gelsemium, v_conium);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Conditions calling for Gelsemium with added sedative support', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_gelsemium, 'Motor nerve sedative; primary for spasmodic and febrile neural states', 10),
    (v_conium,    'Peripheral motor nerve depressant; Ellingwood lists Conium as acting harmoniously with Gelsemium — both require cautious dosing', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 30: Gelsemium + Conium (id=%)', v_pair_id;

  -- ── GRINDELIA GROUP (4 pairs) ─────────────────────────────────────────────

  -- 31. Grindelia + Lobelia
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_grindelia, v_lobelia), GREATEST(v_grindelia, v_lobelia), v_src,
    'Ellingwood lists Lobelia among Grindelia''s cooperatives giving good results in asthmatic breathing and chronic respiratory conditions. Grindelia''s expectorant and antispasmodic bronchial action is extended and deepened by Lobelia''s direct bronchodilatory and vagal antispasmodic effect.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_grindelia, v_lobelia) AND herb2_id = GREATEST(v_grindelia, v_lobelia);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Asthmatic breathing and chronic respiratory conditions', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_grindelia, 'Expectorant and bronchial antispasmodic; specific for subacute and chronic respiratory catarrh and bronchospasm', 10),
    (v_lobelia,   'Bronchodilatory and antispasmodic; deepens Grindelia''s action on the bronchial musculature', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 31: Grindelia + Lobelia (id=%)', v_pair_id;

  -- 32. Grindelia + Stramonium
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_grindelia, v_stramonium), GREATEST(v_grindelia, v_stramonium), v_src,
    'Ellingwood lists Stramonium (Jimsonweed / Datura) among Grindelia''s cooperatives giving good results for asthmatic breathing and chronic respiratory conditions. Stramonium''s potent anticholinergic bronchodilatory action complements Grindelia''s expectorant and anti-inflammatory properties for resistant asthmatic presentations.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_grindelia, v_stramonium) AND herb2_id = GREATEST(v_grindelia, v_stramonium);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Asthmatic breathing and chronic respiratory conditions', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_grindelia,  'Expectorant and bronchial antispasmodic', 10),
    (v_stramonium, 'Anticholinergic bronchodilator; potent antispasmodic used cautiously in asthmatic states', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 32: Grindelia + Stramonium (id=%)', v_pair_id;

  -- 33. Grindelia + Drosera (Sundew)
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_grindelia, v_sundew), GREATEST(v_grindelia, v_sundew), v_src,
    'Ellingwood lists Drosera (Sundew) among Grindelia''s cooperatives giving good results for asthmatic breathing and chronic respiratory conditions. Drosera''s specific antitussive action on spasmodic and whooping coughs adds a cough-suppressing dimension to Grindelia''s expectorant bronchial-relaxant effect.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_grindelia, v_sundew) AND herb2_id = GREATEST(v_grindelia, v_sundew);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Asthmatic breathing and chronic respiratory conditions including spasmodic cough', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_grindelia, 'Expectorant and bronchial antispasmodic', 10),
    (v_sundew,    'Antitussive and antispasmodic; specific for spasmodic and whooping cough patterns', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 33: Grindelia + Drosera (id=%)', v_pair_id;

  -- 34. Grindelia + Ipecac
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_grindelia, v_ipecac), GREATEST(v_grindelia, v_ipecac), v_src,
    'Ellingwood lists Ipecac among Grindelia''s cooperatives giving good results for asthmatic breathing and chronic respiratory conditions. At sub-emetic doses Ipecac''s secretagogue action promotes bronchial mucous secretion, complementing Grindelia''s antispasmodic expectorant properties.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_grindelia, v_ipecac) AND herb2_id = GREATEST(v_grindelia, v_ipecac);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Asthmatic breathing and chronic respiratory conditions with mucous congestion', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_grindelia, 'Expectorant and bronchial antispasmodic', 10),
    (v_ipecac,    'Secretagogue expectorant; promotes bronchial mucous secretion at sub-emetic doses', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 34: Grindelia + Ipecac (id=%)', v_pair_id;

  -- ── HYOSCYAMUS GROUP (3 pairs) ────────────────────────────────────────────

  -- 35. Hyoscyamus + Gelsemium
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_hyoscyamus, v_gelsemium), GREATEST(v_hyoscyamus, v_gelsemium), v_src,
    'Ellingwood lists Gelsemium among agents that facilitate Hyoscyamus action in irritable, spasmodic, and manic states. Gelsemium''s motor-nerve depressant and sedative properties enhance Hyoscyamus''s antispasmodic anticholinergic action without adding narcotic risk.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_hyoscyamus, v_gelsemium) AND herb2_id = GREATEST(v_hyoscyamus, v_gelsemium);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Irritable, spasmodic, or manic states', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_hyoscyamus, 'Sedating anticholinergic antispasmodic; primary agent for manic and spasmodic nervous states', 10),
    (v_gelsemium,  'Motor nerve depressant and sedative; facilitates Hyoscyamus without adding narcotic properties', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 35: Hyoscyamus + Gelsemium (id=%)', v_pair_id;

  -- 36. Hyoscyamus + Stramonium
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_hyoscyamus, v_stramonium), GREATEST(v_hyoscyamus, v_stramonium), v_src,
    'Ellingwood lists Stramonium among agents that facilitate Hyoscyamus in irritable, spasmodic, and manic states. Both are solanaceous anticholinergics — Stramonium more stimulant and Hyoscyamus more sedating — allowing a broader range of sedative-antispasmodic effect through their combination.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_hyoscyamus, v_stramonium) AND herb2_id = GREATEST(v_hyoscyamus, v_stramonium);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Irritable, spasmodic, or manic states', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_hyoscyamus, 'Sedating anticholinergic antispasmodic; more sedating member of the solanaceous pair', 10),
    (v_stramonium, 'Stimulant anticholinergic bronchodilator; Ellingwood lists Stramonium as facilitating Hyoscyamus in manic and spasmodic states', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 36: Hyoscyamus + Stramonium (id=%)', v_pair_id;

  -- 37. Hyoscyamus + Passionflower
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_hyoscyamus, v_passionflower), GREATEST(v_hyoscyamus, v_passionflower), v_src,
    'Ellingwood lists Passionflower among agents that facilitate Hyoscyamus action in irritable, spasmodic, and manic states. Passionflower''s gentle nervine sedative properties support Hyoscyamus''s stronger anticholinergic action, potentially allowing lower and safer doses of the solanaceous herb.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_hyoscyamus, v_passionflower) AND herb2_id = GREATEST(v_hyoscyamus, v_passionflower);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Irritable, spasmodic, or manic states', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_hyoscyamus,   'Sedating anticholinergic antispasmodic', 10),
    (v_passionflower, 'Gentle nervine sedative and anxiolytic; facilitates Hyoscyamus and may allow reduced dosing of the more potent herb', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 37: Hyoscyamus + Passionflower (id=%)', v_pair_id;

  -- ── JUGLANS (BUTTERNUT) GROUP (6 pairs) ───────────────────────────────────

  -- 38. Juglans + Dandelion
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_butternut, v_dandelion), GREATEST(v_butternut, v_dandelion), v_src,
    'Ellingwood describes Butternut advantageously combined with Dandelion for pustular and eczematous skin disease associated with digestive dysfunction. Butternut''s laxative hepatic-alterative action combines with Dandelion''s hepatic-cholagogue and depurative properties to address the hepatic component of chronic skin conditions.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_butternut, v_dandelion) AND herb2_id = GREATEST(v_butternut, v_dandelion);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Pustular and eczematous skin disease associated with digestive dysfunction', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_butternut, 'Laxative and hepatic alterative; addresses the eliminative and hepatic component of skin disease', 10),
    (v_dandelion, 'Hepatic cholagogue and depurative; Ellingwood says these are advantageously combined for digestive-related skin conditions', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 38: Juglans + Dandelion (id=%)', v_pair_id;

  -- 39. Juglans + Hyoscyamus
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_butternut, v_hyoscyamus), GREATEST(v_butternut, v_hyoscyamus), v_src,
    'Ellingwood names Hyoscyamus among useful agents combined with Butternut for chronic constipation, dyspepsia, and atonic intestinal states. Hyoscyamus''s antispasmodic and muscular-relaxant action reduces griping from Butternut''s purgative effect while addressing the nervous component of atonic bowel.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_butternut, v_hyoscyamus) AND herb2_id = GREATEST(v_butternut, v_hyoscyamus);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Chronic constipation, dyspepsia, and atonic intestinal states', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_butternut,  'Hepatic laxative and alterative; mild purgative action on the bowel', 10),
    (v_hyoscyamus, 'Antispasmodic; reduces griping and addresses the nervous component of atonic constipation', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 39: Juglans + Hyoscyamus (id=%)', v_pair_id;

  -- 40. Juglans + Belladonna
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_butternut, v_belladonna), GREATEST(v_butternut, v_belladonna), v_src,
    'Ellingwood names Belladonna among useful agents combined with Butternut for chronic constipation, dyspepsia, and atonic intestinal states. Belladonna''s anticholinergic action addresses bowel spasm and nerve-mediated atony alongside Butternut''s hepatic laxative properties.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_butternut, v_belladonna) AND herb2_id = GREATEST(v_butternut, v_belladonna);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Chronic constipation, dyspepsia, and atonic intestinal states', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_butternut,  'Hepatic laxative and alterative; mild purgative action', 10),
    (v_belladonna, 'Anticholinergic antispasmodic; reduces bowel spasm and addresses nerve-mediated intestinal atony', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 40: Juglans + Belladonna (id=%)', v_pair_id;

  -- 41. Juglans + Nux Vomica
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_butternut, v_nux), GREATEST(v_butternut, v_nux), v_src,
    'Ellingwood names Nux vomica among useful agents combined with Butternut for chronic constipation, dyspepsia, and atonic intestinal states. Nux vomica''s specific stimulant action on spinal reflex and intestinal peristalsis complements Butternut''s hepatic laxative properties for debilitated digestive function.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_butternut, v_nux) AND herb2_id = GREATEST(v_butternut, v_nux);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Chronic constipation, dyspepsia, and atonic intestinal states', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_butternut, 'Hepatic laxative and alterative', 10),
    (v_nux,       'Spinal stimulant; activates intestinal peristalsis and addresses atonic constipation from below', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 41: Juglans + Nux Vomica (id=%)', v_pair_id;

  -- 42. Juglans + Leptandra
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_butternut, v_leptandra), GREATEST(v_butternut, v_leptandra), v_src,
    'Ellingwood names Leptandra (Black Root) among useful agents combined with Butternut for chronic constipation, dyspepsia, and atonic intestinal states. Leptandra''s specific cholagogue and hepatic tonic action extends Butternut''s mild laxative effect to include more targeted hepatic support.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_butternut, v_leptandra) AND herb2_id = GREATEST(v_butternut, v_leptandra);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Chronic constipation, dyspepsia, and atonic intestinal states', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_butternut, 'Hepatic laxative and alterative', 10),
    (v_leptandra, 'Cholagogue and hepatic tonic; adds targeted hepatic action to Butternut''s broader laxative-alterative effect', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 42: Juglans + Leptandra (id=%)', v_pair_id;

  -- 43. Juglans + Capsicum
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_butternut, v_capsicum), GREATEST(v_butternut, v_capsicum), v_src,
    'Ellingwood names Capsicum among useful agents combined with Butternut for chronic constipation, dyspepsia, and atonic intestinal states. Capsicum''s stimulant action on circulation and mucous membranes provides the warming activation that Butternut''s alterative laxative action benefits from in cold, atonic presentations.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_butternut, v_capsicum) AND herb2_id = GREATEST(v_butternut, v_capsicum);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Chronic constipation, dyspepsia, and atonic intestinal states with circulatory deficiency', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_butternut, 'Hepatic laxative and alterative', 10),
    (v_capsicum,  'Circulatory stimulant; provides warming activation for Butternut''s action in cold, atonic constitutions', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 43: Juglans + Capsicum (id=%)', v_pair_id;

  -- ── LYCOPUS (BUGLEWEED) GROUP (3 pairs) ───────────────────────────────────

  -- 44. Lycopus + Pipsissewa (Chimaphila)
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_bugleweed, v_pipsissewa), GREATEST(v_bugleweed, v_pipsissewa), v_src,
    'Ellingwood describes Lycopus alternated with Chimaphila (Pipsissewa) for hematuria associated with urinary calculi or bladder catarrh. Lycopus''s astringent action on renal and urinary hemorrhage alternates with Chimaphila''s specific resolvent and tonic action on the bladder and urinary mucous membranes.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_bugleweed, v_pipsissewa) AND herb2_id = GREATEST(v_bugleweed, v_pipsissewa);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Hematuria associated with urinary calculi or bladder catarrh', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_bugleweed,   'Astringent and hemostatic in urinary tract; addresses the hemorrhagic component', 10),
    (v_pipsissewa,  'Urinary resolvent and tonic; acts on bladder mucous membranes and calculous deposits', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 44: Lycopus + Pipsissewa (id=%)', v_pair_id;

  -- 45. Lycopus + Fringetree (Chionanthus)
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_bugleweed, v_fringetree), GREATEST(v_bugleweed, v_fringetree), v_src,
    'Ellingwood notes that Halbert and others combined Lycopus with Chionanthus (Fringetree) for diabetes in fleshy patients losing excess weight. Lycopus''s thyroid-moderating and metabolic-dampening properties are combined with Chionanthus''s hepatic and pancreatic supporting action.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_bugleweed, v_fringetree) AND herb2_id = GREATEST(v_bugleweed, v_fringetree);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Diabetes in fleshy patients losing excess weight', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_bugleweed,  'Thyroid moderating and metabolic-dampening; addresses excessive tissue wasting', 10),
    (v_fringetree, 'Hepatic and pancreatic tonic; Halbert and others combined these two for the diabetic presentation', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 45: Lycopus + Fringetree (id=%)', v_pair_id;

  -- 46. Lycopus + Belladonna
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_bugleweed, v_belladonna), GREATEST(v_bugleweed, v_belladonna), v_src,
    'Ellingwood names Belladonna as a possible addition to the Lycopus-Chionanthus combination for diabetes in fleshy patients. Belladonna may reduce secretory losses and address the autonomic component of the diabetic state alongside Lycopus''s metabolic-moderating effect.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_bugleweed, v_belladonna) AND herb2_id = GREATEST(v_bugleweed, v_belladonna);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Diabetes in fleshy patients losing excess weight (as part of Lycopus-Chionanthus combination)', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_bugleweed,  'Thyroid moderating and metabolic-dampening', 10),
    (v_belladonna, 'Anticholinergic; reduces secretory losses and addresses autonomic component; Ellingwood names it as a possible addition to the diabetic combination', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 46: Lycopus + Belladonna (id=%)', v_pair_id;

  -- ── MITCHELLA GROUP (6 pairs) ─────────────────────────────────────────────

  -- 47. Mitchella + Black Cohosh
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_mitchella, v_black_coh), GREATEST(v_mitchella, v_black_coh), v_src,
    'Ellingwood lists Black cohosh among Mitchella''s cooperatives, noting these herbs work harmoniously for pregnancy support and uterine/ovarian disorders. Mitchella''s gentle nutritive uterine tonic and partus preparator action is complemented by Black cohosh''s antispasmodic and hormonal-normalizing properties.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_mitchella, v_black_coh) AND herb2_id = GREATEST(v_mitchella, v_black_coh);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Pregnancy support and uterine/ovarian disorders', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_mitchella, 'Nutritive uterine tonic and partus preparator; gentle support for the pregnant and postpartum uterus', 10),
    (v_black_coh, 'Antispasmodic and phytoestrogenic; works harmoniously with Mitchella for uterine and hormonal conditions', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 47: Mitchella + Black Cohosh (id=%)', v_pair_id;

  -- 48. Mitchella + Pulsatilla
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_mitchella, v_pulsatilla), GREATEST(v_mitchella, v_pulsatilla), v_src,
    'Ellingwood lists Pulsatilla among Mitchella''s cooperatives for pregnancy support and uterine/ovarian disorders. Pulsatilla''s pelvic-organ affinity and sedative properties for emotional instability complement Mitchella''s nutritive uterine tonic and preparatory action.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_mitchella, v_pulsatilla) AND herb2_id = GREATEST(v_mitchella, v_pulsatilla);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Pregnancy support and uterine/ovarian disorders', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_mitchella, 'Nutritive uterine tonic and partus preparator', 10),
    (v_pulsatilla, 'Pelvic-organ affinity and nervous sedative; works harmoniously with Mitchella for reproductive and emotional complaints', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 48: Mitchella + Pulsatilla (id=%)', v_pair_id;

  -- 49. Mitchella + Aletris
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_mitchella, v_aletris), GREATEST(v_mitchella, v_aletris), v_src,
    'Ellingwood lists Aletris among Mitchella''s cooperatives for pregnancy support and uterine/ovarian disorders. Aletris''s bitter uterine tonic strengthens Mitchella''s nutritive and preparatory support, particularly in debilitated or atonic presentations during pregnancy.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_mitchella, v_aletris) AND herb2_id = GREATEST(v_mitchella, v_aletris);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Pregnancy support and uterine/ovarian disorders', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_mitchella, 'Nutritive uterine tonic and partus preparator', 10),
    (v_aletris,   'Bitter uterine tonic; reinforces Mitchella''s action in debilitated and atonic uterine states', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 49: Mitchella + Aletris (id=%)', v_pair_id;

  -- 50. Mitchella + False Unicorn (Chamaelirium / Helonias)
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_mitchella, v_false_unicorn), GREATEST(v_mitchella, v_false_unicorn), v_src,
    'Ellingwood lists False Unicorn (Helonias / Chamaelirium) among Mitchella''s cooperatives for pregnancy support and uterine/ovarian disorders. Chamaelirium''s ovarian tonic and uterine restorative properties complement Mitchella''s nutritive preparatory action on the uterus.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_mitchella, v_false_unicorn) AND herb2_id = GREATEST(v_mitchella, v_false_unicorn);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Pregnancy support and uterine/ovarian disorders', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_mitchella,     'Nutritive uterine tonic and partus preparator', 10),
    (v_false_unicorn, 'Ovarian tonic and uterine restorative; works harmoniously with Mitchella for reproductive organ support', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 50: Mitchella + False Unicorn (id=%)', v_pair_id;

  -- 51. Mitchella + Life Root (Senecio aureus)
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_mitchella, v_life_root), GREATEST(v_mitchella, v_life_root), v_src,
    'Ellingwood lists Senecio (Life Root) among Mitchella''s cooperatives for pregnancy support and uterine/ovarian disorders. Senecio''s stimulant emmenagogue and uterine tonic action complements Mitchella''s gentler nutritive and preparatory support for the uterus.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_mitchella, v_life_root) AND herb2_id = GREATEST(v_mitchella, v_life_root);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Pregnancy support and uterine/ovarian disorders', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_mitchella, 'Nutritive uterine tonic and partus preparator', 10),
    (v_life_root, 'Stimulant emmenagogue and uterine tonic; works harmoniously with Mitchella in uterine and ovarian conditions', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 51: Mitchella + Life Root (id=%)', v_pair_id;

  -- 52. Mitchella + Cramp Bark (Viburnum)
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_mitchella, v_cramp_bark), GREATEST(v_mitchella, v_cramp_bark), v_src,
    'Ellingwood lists Viburnum (Cramp Bark) among Mitchella''s cooperatives for pregnancy support and uterine/ovarian disorders. Viburnum''s antispasmodic action on the uterine muscle addresses irritable uterine states while Mitchella provides nutritive tonic and preparatory support for pregnancy.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_mitchella, v_cramp_bark) AND herb2_id = GREATEST(v_mitchella, v_cramp_bark);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Pregnancy support and uterine/ovarian disorders with spasmodic component', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_mitchella,  'Nutritive uterine tonic and partus preparator', 10),
    (v_cramp_bark, 'Uterine antispasmodic; addresses irritable and spasmodic uterine states alongside Mitchella''s nutritive support', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 52: Mitchella + Cramp Bark (id=%)', v_pair_id;

  -- ── MYRICA (BAYBERRY) GROUP (4 pairs) ─────────────────────────────────────

  -- 53. Myrica + Capsicum
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_bayberry, v_capsicum), GREATEST(v_bayberry, v_capsicum), v_src,
    'Ellingwood notes that adding Capsicum to Myrica (Bayberry) makes the stimulant and tonic properties of both more apparent. This combination was used for dysentery where astringent mucous membrane tonic action and stimulant circulatory support were both needed.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_bayberry, v_capsicum) AND herb2_id = GREATEST(v_bayberry, v_capsicum);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Dysentery requiring astringent tonic and stimulant circulatory support', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_bayberry,  'Astringent mucous membrane tonic and circulatory stimulant; primary bowel tonic in dysentery', 10),
    (v_capsicum,  'Pungent circulatory stimulant; makes Myrica''s stimulant and tonic properties more apparent in combination', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 53: Myrica + Capsicum (id=%)', v_pair_id;

  -- 54. Myrica + Cranesbill (Geranium)
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_bayberry, v_cranesbill), GREATEST(v_bayberry, v_cranesbill), v_src,
    'Ellingwood describes Myrica combined with Cranesbill (Geranium maculatum) as of superior benefit for ptyalism following mercury treatment. Both are astringents with specific action on the oral mucous membranes, and their combination was considered more effective than either alone for mercury-induced salivation.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_bayberry, v_cranesbill) AND herb2_id = GREATEST(v_bayberry, v_cranesbill);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Ptyalism (excessive salivation) following mercury treatment', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_bayberry,   'Astringent mucous membrane tonic; specific for oral and pharyngeal mucous surfaces', 10),
    (v_cranesbill, 'Astringent hemostatic; Ellingwood says the combination is of superior benefit for mercury-induced ptyalism', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 54: Myrica + Cranesbill (id=%)', v_pair_id;

  -- 55. Myrica + Pleurisy Root (Asclepias)
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_bayberry, v_pleurisy_root), GREATEST(v_bayberry, v_pleurisy_root), v_src,
    'Ellingwood states that combining Myrica (Bayberry) with Asclepias (Pleurisy Root) is of much value in recent severe colds. Myrica''s astringent mucous membrane tonic and circulatory stimulant action combines with Asclepias''s diaphoretic, expectorant, and anti-inflammatory properties for acute upper respiratory infections.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_bayberry, v_pleurisy_root) AND herb2_id = GREATEST(v_bayberry, v_pleurisy_root);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Recent severe colds and acute upper respiratory infections', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_bayberry,     'Astringent mucous membrane tonic and circulatory stimulant; tightens and tones respiratory mucosa', 10),
    (v_pleurisy_root, 'Diaphoretic, expectorant, and anti-inflammatory; Ellingwood says the combination is of much value for acute respiratory infection', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 55: Myrica + Pleurisy Root (id=%)', v_pair_id;

  -- 56. Myrica + Goldenseal (Hydrastis)
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_bayberry, v_goldenseal), GREATEST(v_bayberry, v_goldenseal), v_src,
    'Ellingwood explicitly recommends Myrica combined with Goldenseal in diluted solution for local application in chronic nasal catarrh. Both are astringent mucous membrane tonics with antimicrobial properties; the combination was used as a nasal wash or spray for chronic inflammatory sinus conditions.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_bayberry, v_goldenseal) AND herb2_id = GREATEST(v_bayberry, v_goldenseal);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Chronic nasal catarrh (local application)', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_bayberry,   'Astringent mucous membrane tonic; tones inflamed nasal mucosa', 10),
    (v_goldenseal, 'Antimicrobial and astringent; Ellingwood recommends the diluted combination for local nasal application in chronic catarrh', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 56: Myrica + Goldenseal (id=%)', v_pair_id;

  -- ── PHYSOSTIGMA GROUP (1 pair) ────────────────────────────────────────────

  -- 57. Physostigma + Echinacea
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_physostigma, v_echinacea), GREATEST(v_physostigma, v_echinacea), v_src,
    'Ellingwood states that Physostigma combined with Echinacea gives very good results in cerebro-spinal meningitis presenting with dullness or a tendency toward stupor. Physostigma''s cholinergic and cerebral-stimulant properties counter the stuporous tendency while Echinacea addresses the infectious and inflammatory component.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_physostigma, v_echinacea) AND herb2_id = GREATEST(v_physostigma, v_echinacea);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Cerebro-spinal meningitis with dullness or tendency toward stupor', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_physostigma, 'Cholinergic and cerebral stimulant; counters the stuporous and depressed tendency in meningitis', 10),
    (v_echinacea,   'Anti-infective and anti-inflammatory; Ellingwood says the combination gives very good results in meningitic states', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 57: Physostigma + Echinacea (id=%)', v_pair_id;

  -- ── PHYTOLACCA GROUP (4 pairs) ────────────────────────────────────────────
  -- Note: Phytolacca + Aconite already exists from Scudder (migration 257).
  -- The INSERT is a no-op; Ellingwood's mastitis indication is appended.

  -- 58. Phytolacca + Aconite [pre-existing — add Ellingwood indication only]
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_pokeroot, v_aconite), GREATEST(v_pokeroot, v_aconite), v_src,
    'Ellingwood explicitly conjoins Phytolacca with Aconite for acute mastitis, stating many cases need no other remedy.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_pokeroot, v_aconite) AND herb2_id = GREATEST(v_pokeroot, v_aconite);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Acute inflammation of the breast (mastitis) during or before lactation', 60)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  RAISE NOTICE 'Pair 58: Phytolacca + Aconite (existing pair, Ellingwood mastitis indication appended, id=%)', v_pair_id;

  -- 59. Phytolacca + Echinacea
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_pokeroot, v_echinacea), GREATEST(v_pokeroot, v_echinacea), v_src,
    'Ellingwood explicitly recommends Phytolacca combined with Echinacea for chronic skin infections and alterative states including varicose ulcers, psoriasis, abscesses, fissures, boils, and carbuncles. Both are lymphatic alteratives; their combination provides a broad-spectrum approach to chronic suppurative and skin conditions.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_pokeroot, v_echinacea) AND herb2_id = GREATEST(v_pokeroot, v_echinacea);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Varicose ulcers, psoriasis, abscesses, fissures, boils, carbuncles, and chronic skin infections', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_pokeroot,  'Lymphatic and glandular alterative; addresses deep-seated chronic suppurative states', 10),
    (v_echinacea, 'Anti-infective and lymphatic stimulant; named in the explicitly recommended combination for chronic skin infections', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 59: Phytolacca + Echinacea (id=%)', v_pair_id;

  -- 60. Phytolacca + Barberry
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_pokeroot, v_barberry), GREATEST(v_pokeroot, v_barberry), v_src,
    'Ellingwood explicitly recommends Phytolacca combined with Barberry (Berberis) for chronic skin infections and alterative states. Barberry''s antimicrobial and hepatic-activating properties combine with Phytolacca''s lymphatic and glandular alterative action for chronic suppurative and skin conditions.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_pokeroot, v_barberry) AND herb2_id = GREATEST(v_pokeroot, v_barberry);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Varicose ulcers, psoriasis, abscesses, fissures, boils, carbuncles, and chronic skin infections', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_pokeroot, 'Lymphatic and glandular alterative; addresses deep-seated chronic suppurative states', 10),
    (v_barberry,  'Antimicrobial and hepatic activating; named in Ellingwood''s recommended combination for chronic skin infections', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 60: Phytolacca + Barberry (id=%)', v_pair_id;

  -- 61. Phytolacca + Stillingia
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_pokeroot, v_stillingia), GREATEST(v_pokeroot, v_stillingia), v_src,
    'Ellingwood explicitly recommends Phytolacca combined with Stillingia (Queen''s Delight) for chronic skin infections and alterative states. Stillingia''s powerful lymphatic and alterative action augments Phytolacca''s glandular and lymphatic properties for deep chronic skin and systemic infections.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_pokeroot, v_stillingia) AND herb2_id = GREATEST(v_pokeroot, v_stillingia);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Varicose ulcers, psoriasis, abscesses, fissures, boils, carbuncles, and chronic skin infections', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_pokeroot,  'Lymphatic and glandular alterative', 10),
    (v_stillingia, 'Powerful lymphatic and alterative (Queen''s Delight); named in the explicitly recommended combination', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 61: Phytolacca + Stillingia (id=%)', v_pair_id;

  -- ── PODOPHYLLUM GROUP (4 pairs) ───────────────────────────────────────────

  -- 62. Podophyllum + Hyoscyamus
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_podophyllum, v_hyoscyamus), GREATEST(v_podophyllum, v_hyoscyamus), v_src,
    'Ellingwood explicitly recommends combining Hyoscyamus with Podophyllum when using the latter for its cathartic effect. Hyoscyamus''s antispasmodic action specifically counters the griping and cramping pains that Podophyllum''s purgative principle tends to produce.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_podophyllum, v_hyoscyamus) AND herb2_id = GREATEST(v_podophyllum, v_hyoscyamus);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('When Podophyllum is used for cathartic influence (to prevent griping)', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_podophyllum, 'Cathartic and hepatic stimulant; the primary purgative agent', 10),
    (v_hyoscyamus,  'Antispasmodic; reduces the intestinal griping and cramping caused by Podophyllum''s cathartic action', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 62: Podophyllum + Hyoscyamus (id=%)', v_pair_id;

  -- 63. Podophyllum + Belladonna
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_podophyllum, v_belladonna), GREATEST(v_podophyllum, v_belladonna), v_src,
    'Ellingwood explicitly recommends combining Belladonna with Podophyllum when using the latter for cathartic influence. Belladonna''s anticholinergic antispasmodic action reduces the intestinal cramping associated with Podophyllum''s active cathartic principle.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_podophyllum, v_belladonna) AND herb2_id = GREATEST(v_podophyllum, v_belladonna);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('When Podophyllum is used for cathartic influence (to prevent griping)', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_podophyllum, 'Cathartic and hepatic stimulant', 10),
    (v_belladonna,  'Anticholinergic antispasmodic; reduces intestinal cramping from Podophyllum''s cathartic principle', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 63: Podophyllum + Belladonna (id=%)', v_pair_id;

  -- 64. Podophyllum + Leptandra
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_podophyllum, v_leptandra), GREATEST(v_podophyllum, v_leptandra), v_src,
    'Ellingwood explicitly recommends Podophyllum combined with Leptandra (Black Root) for cathartic and hepatic purposes. Leptandra''s specific cholagogue and hepatic tonic action extends Podophyllum''s cathartic effect to more specifically address the liver, useful for hepatic congestion with constipation.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_podophyllum, v_leptandra) AND herb2_id = GREATEST(v_podophyllum, v_leptandra);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Cathartic and hepatic use; hepatic congestion with constipation', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_podophyllum, 'Cathartic and hepatic stimulant', 10),
    (v_leptandra,   'Cholagogue and hepatic tonic; focuses the combination on liver-mediated constipation and bilious congestion', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 64: Podophyllum + Leptandra (id=%)', v_pair_id;

  -- 65. Podophyllum + Stoneroot (Collinsonia)
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_podophyllum, v_stoneroot), GREATEST(v_podophyllum, v_stoneroot), v_src,
    'Ellingwood states that Podophyllum combined with Collinsonia (Stoneroot) has marked effects in deficient peristalsis and general abdominal plethora. Collinsonia''s specific action on the portal venous circulation complements Podophyllum''s cathartic and hepatic-stimulating properties for congested atonic lower GI states.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_podophyllum, v_stoneroot) AND herb2_id = GREATEST(v_podophyllum, v_stoneroot);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Deficient peristalsis and general abdominal plethora with portal congestion', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_podophyllum, 'Cathartic and hepatic stimulant; activates deficient peristalsis', 10),
    (v_stoneroot,   'Portal venous tonic; Ellingwood says the combination has marked effects in abdominal plethora with portal congestion', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 65: Podophyllum + Stoneroot (id=%)', v_pair_id;

  -- ── POPULUS (ASPEN) GROUP (1 pair) ────────────────────────────────────────

  -- 66. Populus + Goldenseal
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_aspen, v_goldenseal), GREATEST(v_aspen, v_goldenseal), v_src,
    'Ellingwood states that Populus (Aspen bark) is well given in conjunction with Goldenseal for swamp fever and irregularities of women, providing general tonic support. Goldenseal''s bitter tonic and antimicrobial mucous membrane properties complement Populus''s tonic and antiperiodic action.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_aspen, v_goldenseal) AND herb2_id = GREATEST(v_aspen, v_goldenseal);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Swamp fever and irregularities of women requiring general tonic support', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_aspen,      'Tonic and antiperiodic; Populus bark for periodic fevers and uterine irregularities', 10),
    (v_goldenseal, 'Bitter tonic and antimicrobial mucous membrane tonic; Ellingwood says it is well given in conjunction with Populus', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 66: Populus + Goldenseal (id=%)', v_pair_id;

  -- ── RHUS TOX GROUP (3 pairs) ──────────────────────────────────────────────

  -- 67. Rhus tox + Aconite
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_rhus, v_aconite), GREATEST(v_rhus, v_aconite), v_src,
    'Ellingwood describes Rhus toxicodendron alternated with Aconite in acute inflammatory rheumatism. Aconite addresses the febrile and acute inflammatory component while Rhus tox acts on the deeper musculo-rheumatic tissue; alternation allows both actions without combining two potent herbs simultaneously.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_rhus, v_aconite) AND herb2_id = GREATEST(v_rhus, v_aconite);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Acute inflammatory rheumatism with fever', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_rhus,    'Rheumatic tissue agent; addresses deeper musculo-rheumatic involvement and is alternated for the rheumatic phase', 10),
    (v_aconite, 'Acute anti-inflammatory and antipyretic; addresses the febrile phase and is alternated with Rhus tox', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 67: Rhus tox + Aconite (id=%)', v_pair_id;

  -- 68. Rhus tox + Black Cohosh
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_rhus, v_black_coh), GREATEST(v_rhus, v_black_coh), v_src,
    'Ellingwood explicitly recommends adding Black cohosh to Rhus tox treatment when deep muscular soreness accompanies acute inflammatory rheumatism. Black cohosh''s specific action on muscular inflammation and pain extends Rhus tox''s rheumatic action to the deep musculature.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_rhus, v_black_coh) AND herb2_id = GREATEST(v_rhus, v_black_coh);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Acute inflammatory rheumatism with deep muscular soreness', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_rhus,      'Rheumatic tissue agent; primary for rheumatic joint and tissue involvement', 10),
    (v_black_coh, 'Muscular anti-inflammatory and analgesic; explicitly added when deep muscular soreness is present', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 68: Rhus tox + Black Cohosh (id=%)', v_pair_id;

  -- 69. Rhus tox + Bryonia
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_rhus, v_bryonia), GREATEST(v_rhus, v_bryonia), v_src,
    'Ellingwood describes Rhus tox combined or alternated with Bryonia for capillary bronchitis with a persistent dry tickling cough. Bryonia''s affinity for serous membranes and dry stitching respiratory presentations complements Rhus tox''s action on the deeper respiratory tissue with its characteristic movement aggravation.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_rhus, v_bryonia) AND herb2_id = GREATEST(v_rhus, v_bryonia);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Capillary bronchitis with persistent dry tickling cough', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_rhus,    'Respiratory and rheumatic tissue agent; acts on deeper bronchial tissue', 10),
    (v_bryonia, 'Serous membrane and fibrous tissue affinity; specific for dry pleuritic and bronchitic cough aggravated by movement', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 69: Rhus tox + Bryonia (id=%)', v_pair_id;

  -- ── CACTUS (SELENICEREUS) GROUP (1 pair) ──────────────────────────────────

  -- 70. Cactus (Selenicereus) + Strophanthus
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_cactus, v_strophanthus), GREATEST(v_cactus, v_strophanthus), v_src,
    'Ellingwood reports that Dr. Carey combined Cactus (Selenicereus grandiflorus / Night-blooming cereus) with Strophanthus for imperfect circulation from cardiac insufficiency. Cactus''s specific tonic action on cardiac muscle and regulation of heart rhythm is combined with Strophanthus''s more powerful cardiac glycoside action on the myocardium.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_cactus, v_strophanthus) AND herb2_id = GREATEST(v_cactus, v_strophanthus);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Imperfect circulation from cardiac insufficiency', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_cactus,       'Cardiac muscle tonic and rhythm regulator; Night-blooming cereus used for functional cardiac insufficiency', 10),
    (v_strophanthus, 'Cardiac glycoside; potent myocardial tonic that Dr. Carey combined with Cactus for circulatory insufficiency', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 70: Cactus + Strophanthus (id=%)', v_pair_id;

  -- ── SENECIO (LIFE ROOT) GROUP (3 pairs) ───────────────────────────────────

  -- 71. Senecio (Life Root) + Cramp Bark (Viburnum)
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_life_root, v_cramp_bark), GREATEST(v_life_root, v_cramp_bark), v_src,
    'Ellingwood lists Viburnum (Cramp Bark) among Life Root''s harmonious cooperatives for female reproductive and pelvic disorders. Viburnum''s antispasmodic and uterine sedative action on threatened abortion and spasmodic uterine conditions is complemented by Senecio''s stimulant emmenagogue and uterine tonic effect.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_life_root, v_cramp_bark) AND herb2_id = GREATEST(v_life_root, v_cramp_bark);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Female reproductive and pelvic disorders', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_life_root,  'Stimulant emmenagogue and uterine tonic; Ellingwood''s specific for amenorrhea with debility', 10),
    (v_cramp_bark, 'Uterine antispasmodic; acts harmoniously with Senecio in reproductive and pelvic disorders', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 71: Senecio + Cramp Bark (id=%)', v_pair_id;

  -- 72. Senecio + False Unicorn (Chamaelirium / Helonias)
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_life_root, v_false_unicorn), GREATEST(v_life_root, v_false_unicorn), v_src,
    'Ellingwood lists False Unicorn (Helonias / Chamaelirium) among Life Root''s harmonious cooperatives for female reproductive and pelvic disorders. False Unicorn''s ovarian tonic and uterine restorative properties complement Senecio''s stimulant emmenagogue and pelvic-tonic action in chronic female deficiency states.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_life_root, v_false_unicorn) AND herb2_id = GREATEST(v_life_root, v_false_unicorn);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Female reproductive and pelvic disorders', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_life_root,     'Stimulant emmenagogue and uterine tonic', 10),
    (v_false_unicorn, 'Ovarian tonic and uterine restorative; works harmoniously with Senecio in chronic female deficiency states', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 72: Senecio + False Unicorn (id=%)', v_pair_id;

  -- 73. Senecio + Spikenard (Aralia racemosa)
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_life_root, v_spikenard), GREATEST(v_life_root, v_spikenard), v_src,
    'Ellingwood lists Aralia (Spikenard) among Life Root''s harmonious cooperatives for female reproductive and pelvic disorders. Spikenard''s expectorant, anti-inflammatory, and uterine-affinity properties complement Senecio''s stimulant emmenagogue action, particularly in women''s reproductive conditions accompanied by respiratory involvement.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_life_root, v_spikenard) AND herb2_id = GREATEST(v_life_root, v_spikenard);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Female reproductive and pelvic disorders', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id AND indication = t.ind);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_life_root, 'Stimulant emmenagogue and uterine tonic', 10),
    (v_spikenard, 'Expectorant and uterine affinity; Ellingwood lists Aralia as acting harmoniously with Senecio in reproductive and pelvic disorders', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id AND herb_id = t.hid AND property = t.prop);
  RAISE NOTICE 'Pair 73: Senecio + Spikenard (id=%)', v_pair_id;

  RAISE NOTICE 'Migration 263 complete — 73 Ellingwood herb pairs inserted.';
END $$;
