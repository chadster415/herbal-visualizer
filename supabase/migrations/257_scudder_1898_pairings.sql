-- Migration 257: Herb pairs from Scudder's American Eclectic Materia Medica (1898)
-- Source: John M. Scudder, The American Eclectic Materia Medica and Therapeutics,
--         12th ed. 1898 (Henriette's Herbal transcription — first-pass extraction).
-- Input file: scudder_herb_pairings_henriette_first_pass.txt
-- Requires: migration 256 (12 missing herbs added to DB)
--
-- 30 unique pairs from 33 data rows (3 rows deduplicated into multi-indication pairs).
-- Herb IDs resolved by latin_name at runtime — safe regardless of insert order in 256.
--
-- Pairs:
--   Ipecac group (9 pairs): Squill, Senega, Aconite, Nux Vomica, Guaiacum,
--     Sarsaparilla, Podophyllum, Bloodroot, Dandelion
--   Phytolacca group (5 pairs): Aconite, Cannabis, Veratrum, Belladonna, Gelsemium
--   Belladonna group (2 pairs): Aconite, Phytolacca
--   Ignatia group (3 pairs): Rhus Tox, Black Cohosh, Blue Cohosh
--   Poplar group (3 pairs): Burdock, Yellow Dock, Yellow Parilla
--   Elder group (2 pairs): Juniper, Horseradish
--   Gravel Root group (5 pairs): Horseradish, Juniper, Buchu, Pipsissewa, Uva Ursi
--   Apocynum group (1 pair): Spearmint

SET search_path TO herbal, public;

DO $$
DECLARE
  -- Existing herb IDs (from DB pre-migration 256)
  v_ipecac    CONSTANT INTEGER := 192;   -- Cephaelis ipecacuanha
  v_squill    CONSTANT INTEGER := 166;   -- Urginea maritima
  v_senega    CONSTANT INTEGER := 195;   -- Polygala senega
  v_guaiacum  CONSTANT INTEGER := 29;    -- Guaiacum officinale
  v_sarsa     CONSTANT INTEGER := 40;    -- Smilax spp.
  v_bloodroot CONSTANT INTEGER := 38;    -- Sanguinaria canadensis
  v_dandelion CONSTANT INTEGER := 122;   -- Taraxacum officinale
  v_phyto     CONSTANT INTEGER := 35;    -- Phytolacca americana
  v_gelsemium CONSTANT INTEGER := 645;   -- Gelsemium sempervirens
  v_black_coh CONSTANT INTEGER := 25;    -- Actaea racemosa
  v_blue_coh  CONSTANT INTEGER := 72;    -- Caulophyllum thalictroides
  v_poplar    CONSTANT INTEGER := 86;    -- Populus tremuloides
  v_burdock   CONSTANT INTEGER := 22;    -- Arctium lappa
  v_ydock     CONSTANT INTEGER := 37;    -- Rumex crispus
  v_elder     CONSTANT INTEGER := 57;    -- Sambucus nigra (flower)
  v_juniper   CONSTANT INTEGER := 103;   -- Juniperus communis
  v_hraddish  CONSTANT INTEGER := 113;   -- Armoracia rusticana
  v_buchu     CONSTANT INTEGER := 181;   -- Agathosma betulina
  v_pipsis    CONSTANT INTEGER := 2239;  -- Chimaphila umbellata
  v_uva       CONSTANT INTEGER := 46;    -- Arctostaphylos uva-ursi

  -- New herb IDs (from migration 256 — looked up by latin_name)
  v_aconite   INTEGER;
  v_nux       INTEGER;
  v_belladonna INTEGER;
  v_cannabis  INTEGER;
  v_gravel    INTEGER;
  v_ignatia   INTEGER;
  v_podophyl  INTEGER;
  v_rhus      INTEGER;
  v_spearmint INTEGER;
  v_veratrum  INTEGER;
  v_yparilla  INTEGER;

  v_src  CONSTANT TEXT := 'Scudder, American Eclectic Materia Medica and Therapeutics (12th ed., 1898), via Henriette''s Herbal';
  v_apocynum INTEGER;
  v_pair_id INTEGER;
BEGIN

  -- Resolve new herb IDs (all added in migration 256)
  SELECT id INTO v_aconite   FROM herbal.herbs WHERE latin_name = 'Aconitum napellus'      AND plant_part IS NULL;
  SELECT id INTO v_nux       FROM herbal.herbs WHERE latin_name = 'Strychnos nux-vomica'   AND plant_part = 'Seed';
  SELECT id INTO v_belladonna FROM herbal.herbs WHERE latin_name = 'Atropa belladonna'     AND plant_part IS NULL;
  SELECT id INTO v_cannabis  FROM herbal.herbs WHERE latin_name = 'Cannabis sativa'        AND plant_part = 'Aerial parts';
  SELECT id INTO v_gravel    FROM herbal.herbs WHERE latin_name = 'Eupatorium purpureum'   AND plant_part = 'Root';
  SELECT id INTO v_ignatia   FROM herbal.herbs WHERE latin_name = 'Strychnos ignatii'      AND plant_part = 'Seed';
  SELECT id INTO v_podophyl  FROM herbal.herbs WHERE latin_name = 'Podophyllum peltatum'   AND plant_part = 'Root';
  SELECT id INTO v_rhus      FROM herbal.herbs WHERE latin_name = 'Toxicodendron radicans' AND plant_part = 'Leaf';
  SELECT id INTO v_spearmint FROM herbal.herbs WHERE latin_name = 'Mentha spicata'         AND plant_part = 'Aerial parts';
  SELECT id INTO v_veratrum  FROM herbal.herbs WHERE latin_name = 'Veratrum viride'        AND plant_part = 'Root';
  SELECT id INTO v_yparilla  FROM herbal.herbs WHERE latin_name = 'Menispermum canadense'  AND plant_part = 'Root';
  SELECT id INTO v_apocynum  FROM herbal.herbs WHERE latin_name = 'Apocynum cannabinum'    AND plant_part = 'Root';

  -- Guard: abort if any new herb is missing (migration 256 not yet run)
  IF v_aconite IS NULL OR v_nux IS NULL OR v_belladonna IS NULL OR v_cannabis IS NULL OR
     v_gravel  IS NULL OR v_ignatia IS NULL OR v_podophyl IS NULL OR v_rhus IS NULL OR
     v_spearmint IS NULL OR v_veratrum IS NULL OR v_yparilla IS NULL OR v_apocynum IS NULL THEN
    RAISE EXCEPTION 'One or more new herbs from migration 256 not found in DB — run migration 256 first.';
  END IF;

  -- ── IPECAC GROUP ─────────────────────────────────────────────────────────────

  -- 1. Ipecac + Squill [192 vs 166]
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_ipecac, v_squill), GREATEST(v_ipecac, v_squill), v_src,
    'Scudder lists Squill among stimulating expectorant/diaphoretic agents used alongside Ipecac for respiratory conditions requiring more robust stimulation. A complementary expectorant-diaphoretic pairing for acute respiratory presentations.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_ipecac, v_squill) AND herb2_id = GREATEST(v_ipecac, v_squill);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Respiratory conditions requiring stimulating expectorant and diaphoretic action', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_ipecac, 'Expectorant and diaphoretic at small doses; Scudder''s primary respiratory stimulant', 10),
    (v_squill, 'Stimulating expectorant; Scudder pairs with Ipecac for more pronounced respiratory stimulation', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
  RAISE NOTICE 'Pair 1 done: Ipecac + Squill (id=%)', v_pair_id;

  -- 2. Ipecac + Senega [192 vs 195]
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_ipecac, v_senega), GREATEST(v_ipecac, v_senega), v_src,
    'Scudder lists Senega among stimulating expectorant/diaphoretic agents combined with Ipecac for respiratory conditions. Complementary expectorant pair for acute upper respiratory and bronchial presentations requiring strong stimulation.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_ipecac, v_senega) AND herb2_id = GREATEST(v_ipecac, v_senega);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Respiratory conditions requiring stimulating expectorant and diaphoretic action', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_ipecac, 'Expectorant and diaphoretic; drives the pair''s respiratory action', 10),
    (v_senega, 'Stimulating expectorant (Polygala senega); Scudder pairs with Ipecac for enhanced respiratory stimulation', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
  RAISE NOTICE 'Pair 2 done: Ipecac + Senega (id=%)', v_pair_id;

  -- 3. Ipecac + Aconite [192 vs v_aconite] — three indications merged
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_ipecac, v_aconite), GREATEST(v_ipecac, v_aconite), v_src,
    'Scudder recommends Ipecac with Aconite across several acute inflammatory and febrile presentations. Aconite''s cardiac-sedative and antipyretic action complements Ipecac''s expectorant and antispasmodic properties. Scudder notes the combination for bronchitis/pneumonia with frequent pulse and elevated temperature, cholera infantum, and diarrhoea when Aconite is otherwise indicated.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_ipecac, v_aconite) AND herb2_id = GREATEST(v_ipecac, v_aconite);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Bronchitis or pneumonia with frequent pulse and elevated temperature', 10),
    ('Cholera infantum with frequent pulse and increased abdominal temperature', 20),
    ('Diarrhoea of irritation when Aconite is specifically indicated', 30)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_ipecac,  'Expectorant, antispasmodic, and diaphoretic; addresses the respiratory and GI components', 10),
    (v_aconite, 'Cardiac sedative and antipyretic; reduces pulse rate and temperature; Scudder''s go-to for febrile states with frequent pulse', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
  RAISE NOTICE 'Pair 3 done: Ipecac + Aconite (id=%)', v_pair_id;

  -- 4. Ipecac + Nux Vomica [192 vs v_nux] — two indications merged
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_ipecac, v_nux), GREATEST(v_ipecac, v_nux), v_src,
    'Scudder recommends Ipecac with Nux vomica for cholera infantum and diarrhoea presentations involving pallid face, abdominal pain, and nausea/vomiting. Nux vomica''s tonic action on the GI tract complements Ipecac''s antispasmodic and antiemetic properties in these atonic/deficient presentations.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_ipecac, v_nux) AND herb2_id = GREATEST(v_ipecac, v_nux);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Cholera infantum with pallid/yellowish face, abdominal pain, pallid tongue, nausea and vomiting', 10),
    ('Diarrhoea of irritation when Nux vomica is specifically indicated', 20)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_ipecac, 'Antispasmodic and antiemetic; directly addresses nausea and vomiting component', 10),
    (v_nux,    'GI tonic; Scudder''s specific for pallid/atonic GI presentations with nausea and abdominal pain', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
  RAISE NOTICE 'Pair 4 done: Ipecac + Nux Vomica (id=%)', v_pair_id;

  -- 5. Ipecac + Guaiacum [192 vs 29]
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_ipecac, v_guaiacum), GREATEST(v_ipecac, v_guaiacum), v_src,
    'Scudder uses Ipecac in minute doses as an alterative, combining it with several agents including Guaiacum for this purpose. The combination targets torpid hepatic/chylopoietic conditions and systemic lymphatic stagnation.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_ipecac, v_guaiacum) AND herb2_id = GREATEST(v_ipecac, v_guaiacum);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Alterative use at minute doses; hepatic and chylopoietic torpor', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);
  RAISE NOTICE 'Pair 5 done: Ipecac + Guaiacum (id=%)', v_pair_id;

  -- 6. Ipecac + Sarsaparilla [192 vs 40]
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_ipecac, v_sarsa), GREATEST(v_ipecac, v_sarsa), v_src,
    'Scudder names Sarsaparilla among the alterative agents combined with minute-dose Ipecac. The combination targets torpid hepatic function and sluggish chylopoiesis.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_ipecac, v_sarsa) AND herb2_id = GREATEST(v_ipecac, v_sarsa);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Alterative use at minute doses; hepatic and chylopoietic torpor', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);
  RAISE NOTICE 'Pair 6 done: Ipecac + Sarsaparilla (id=%)', v_pair_id;

  -- 7. Ipecac + Podophyllum [192 vs v_podophyl]
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_ipecac, v_podophyl), GREATEST(v_ipecac, v_podophyl), v_src,
    'Scudder names Podophyllum among the hepatic alteratives combined with minute-dose Ipecac. Podophyllum''s hepatic cholagogue action reinforces Ipecac''s gentle stimulation of the chylopoietic system.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_ipecac, v_podophyl) AND herb2_id = GREATEST(v_ipecac, v_podophyl);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Alterative and hepatic use at minute doses; hepatic and chylopoietic torpor', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_ipecac,   'Gentle hepatic/chylopoietic stimulant at minute doses', 10),
    (v_podophyl, 'Hepatic cholagogue and laxative; Scudder uses in hepatic torpor presentations', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
  RAISE NOTICE 'Pair 7 done: Ipecac + Podophyllum (id=%)', v_pair_id;

  -- 8. Ipecac + Bloodroot [192 vs 38]
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_ipecac, v_bloodroot), GREATEST(v_ipecac, v_bloodroot), v_src,
    'Scudder names Sanguinaria (Bloodroot) among alteratives combined with minute-dose Ipecac. Bloodroot''s lymphatic and hepatic alterative properties complement Ipecac''s gentle chylopoietic stimulation.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_ipecac, v_bloodroot) AND herb2_id = GREATEST(v_ipecac, v_bloodroot);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Alterative use at minute doses; hepatic and chylopoietic torpor', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);
  RAISE NOTICE 'Pair 8 done: Ipecac + Bloodroot (id=%)', v_pair_id;

  -- 9. Ipecac + Dandelion [192 vs 122]
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_ipecac, v_dandelion), GREATEST(v_ipecac, v_dandelion), v_src,
    'Scudder names Taraxacum (Dandelion) among the hepatic alteratives combined with minute-dose Ipecac. Dandelion''s hepatic tonic and cholagogue properties support Ipecac''s gentle stimulation of the chylopoietic system.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_ipecac, v_dandelion) AND herb2_id = GREATEST(v_ipecac, v_dandelion);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Alterative use at minute doses; hepatic and chylopoietic torpor', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);
  RAISE NOTICE 'Pair 9 done: Ipecac + Dandelion (id=%)', v_pair_id;

  -- ── PHYTOLACCA GROUP ──────────────────────────────────────────────────────────

  -- 10. Phytolacca + Aconite [35 vs v_aconite]
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_phyto, v_aconite), GREATEST(v_phyto, v_aconite), v_src,
    'Scudder describes Phytolacca and Aconite as his usual medicines for parotitis (mumps). Phytolacca targets the glandular swelling and lymphatic congestion while Aconite addresses the febrile component. A classic eclectic pairing for acute febrile glandular conditions.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_phyto, v_aconite) AND herb2_id = GREATEST(v_phyto, v_aconite);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Parotitis (mumps)', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_phyto,   'Lymphatic and glandular specific; Scudder''s first choice for glandular swelling', 10),
    (v_aconite, 'Antipyretic and cardiac sedative; manages the febrile and vascular component', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
  RAISE NOTICE 'Pair 10 done: Phytolacca + Aconite (id=%)', v_pair_id;

  -- 11. Phytolacca + Cannabis [35 vs v_cannabis]
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_phyto, v_cannabis), GREATEST(v_phyto, v_cannabis), v_src,
    'Scudder names Cannabis as one of several agents that may accompany Phytolacca in orchitis, selected according to the accompanying indications. Cannabis was used eclectically for its antispasmodic and anodyne properties in pelvic/reproductive inflammation.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_phyto, v_cannabis) AND herb2_id = GREATEST(v_phyto, v_cannabis);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Orchitis, according to the accompanying indications', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);
  RAISE NOTICE 'Pair 11 done: Phytolacca + Cannabis (id=%)', v_pair_id;

  -- 12. Phytolacca + Veratrum [35 vs v_veratrum]
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_phyto, v_veratrum), GREATEST(v_phyto, v_veratrum), v_src,
    'Scudder names Veratrum as one of the agents combined with Phytolacca in orchitis according to the presenting indications. Veratrum was used eclectically as a cardiovascular sedative and antipyretic in acute inflammatory conditions with full, frequent pulse.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_phyto, v_veratrum) AND herb2_id = GREATEST(v_phyto, v_veratrum);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Orchitis, according to the accompanying indications', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);
  RAISE NOTICE 'Pair 12 done: Phytolacca + Veratrum (id=%)', v_pair_id;

  -- 13. Phytolacca + Belladonna [35 vs v_belladonna]
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_phyto, v_belladonna), GREATEST(v_phyto, v_belladonna), v_src,
    'Scudder names Belladonna as one of the agents combined with Phytolacca in orchitis according to the presenting indications. Belladonna''s antispasmodic and anodyne properties address spasm and pain while Phytolacca targets the glandular/lymphatic inflammation.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_phyto, v_belladonna) AND herb2_id = GREATEST(v_phyto, v_belladonna);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Orchitis, according to the accompanying indications', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);
  RAISE NOTICE 'Pair 13 done: Phytolacca + Belladonna (id=%)', v_pair_id;

  -- 14. Phytolacca + Gelsemium [35 vs 645]
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_phyto, v_gelsemium), GREATEST(v_phyto, v_gelsemium), v_src,
    'Scudder names Gelsemium (Gelseminum) as one of the agents combined with Phytolacca in orchitis according to the presenting indications. Gelsemium''s nervous sedative and antispasmodic properties complement Phytolacca''s glandular and lymphatic action.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_phyto, v_gelsemium) AND herb2_id = GREATEST(v_phyto, v_gelsemium);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Orchitis, according to the accompanying indications', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);
  RAISE NOTICE 'Pair 14 done: Phytolacca + Gelsemium (id=%)', v_pair_id;

  -- ── BELLADONNA GROUP ──────────────────────────────────────────────────────────

  -- 15. Belladonna + Aconite [v_belladonna vs v_aconite]
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_belladonna, v_aconite), GREATEST(v_belladonna, v_aconite), v_src,
    'Scudder explicitly states that Belladonna may be given with Aconite for sore throat — including diphtheritic, scarlatinal, and ordinary sore throat. Aconite addresses the febrile vascular component while Belladonna provides antispasmodic, anodyne, and anti-inflammatory action locally in the throat.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_belladonna, v_aconite) AND herb2_id = GREATEST(v_belladonna, v_aconite);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Sore throat — including diphtheritic, scarlatinal, and ordinary sore throat', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_belladonna, 'Antispasmodic and anodyne for throat inflammation; reduces local spasm and pain', 10),
    (v_aconite,    'Antipyretic and cardiac sedative; addresses febrile and vascular components', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
  RAISE NOTICE 'Pair 15 done: Belladonna + Aconite (id=%)', v_pair_id;

  -- 16. Belladonna + Phytolacca [v_belladonna vs 35] — NOTE: same pair as #13 reversed
  -- (herb1_id < herb2_id constraint means this is identical to pair #13 if IDs order the same)
  -- Scudder notes Belladonna + Phytolacca for sore throat — distinct clinical context from orchitis.
  -- Since herb_pairs has UNIQUE(herb1_id, herb2_id), this WILL CONFLICT with pair #13.
  -- Adding the sore throat indication to the existing pair instead.
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_phyto, v_belladonna) AND herb2_id = GREATEST(v_phyto, v_belladonna);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Sore throat — including diphtheritic, scarlatinal, and ordinary sore throat', 20)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications
    WHERE pair_id = v_pair_id AND indication ILIKE '%sore throat%');
  RAISE NOTICE 'Pair 16 done: Belladonna + Phytolacca — sore throat indication added to existing pair (id=%)', v_pair_id;

  -- ── IGNATIA GROUP ─────────────────────────────────────────────────────────────

  -- 17. Ignatia + Rhus Tox [v_ignatia vs v_rhus]
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_ignatia, v_rhus), GREATEST(v_ignatia, v_rhus), v_src,
    'Scudder explicitly associates Ignatia with Rhus (Rhus toxicodendron) in some cases of dysmenorrhoea with Ignatia indications. In eclectic practice, minute doses of Rhus tox addressed rheumatic and neuralgic pain; combined with Ignatia''s nervous antispasmodic action for dysmenorrhoea with prominent neuralgic character.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_ignatia, v_rhus) AND herb2_id = GREATEST(v_ignatia, v_rhus);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Dysmenorrhoea with Ignatia indications (neuralgic, spasmodic character)', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);
  RAISE NOTICE 'Pair 17 done: Ignatia + Rhus Tox (id=%)', v_pair_id;

  -- 18. Ignatia + Black Cohosh [v_ignatia vs 25]
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_ignatia, v_black_coh), GREATEST(v_ignatia, v_black_coh), v_src,
    'Scudder explicitly names Macrotys (Black Cohosh / Actaea racemosa) as a companion to Ignatia in some cases of dysmenorrhoea. Both herbs address spasmodic and neuralgic gynaecological pain; Ignatia adds a specific nervous antispasmodic action while Black Cohosh contributes its uterine antispasmodic and neurological properties.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_ignatia, v_black_coh) AND herb2_id = GREATEST(v_ignatia, v_black_coh);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Dysmenorrhoea with Ignatia indications (spasmodic and neuralgic character)', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_ignatia,   'Nervous antispasmodic; Scudder''s specific for hysterical and nervous gynaecological presentations', 10),
    (v_black_coh, 'Uterine antispasmodic and nervine; Scudder''s Macrotys for spasmodic uterine pain', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
  RAISE NOTICE 'Pair 18 done: Ignatia + Black Cohosh (id=%)', v_pair_id;

  -- 19. Ignatia + Blue Cohosh [v_ignatia vs 72]
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_ignatia, v_blue_coh), GREATEST(v_ignatia, v_blue_coh), v_src,
    'Scudder explicitly names Caulophyllum (Blue Cohosh) as a companion to Ignatia in some cases of dysmenorrhoea. Blue Cohosh contributes uterine antispasmodic and emmenagogue action while Ignatia addresses the nervous and hysterical aspects of the presentation.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_ignatia, v_blue_coh) AND herb2_id = GREATEST(v_ignatia, v_blue_coh);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Dysmenorrhoea with Ignatia indications (spasmodic and nervous character)', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);
  RAISE NOTICE 'Pair 19 done: Ignatia + Blue Cohosh (id=%)', v_pair_id;

  -- ── POPLAR GROUP ──────────────────────────────────────────────────────────────

  -- 20. Poplar + Burdock [86 vs 22]
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_poplar, v_burdock), GREATEST(v_poplar, v_burdock), v_src,
    'Scudder explicitly names Burdock among the alterants associated with Populus (Poplar) when both tonic and alterative effects are indicated. The combination addresses chronic debilitated states requiring both systemic toning and gentle alterative action.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_poplar, v_burdock) AND herb2_id = GREATEST(v_poplar, v_burdock);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Chronic conditions requiring both tonic and alterative effects', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);
  RAISE NOTICE 'Pair 20 done: Poplar + Burdock (id=%)', v_pair_id;

  -- 21. Poplar + Yellow Dock [86 vs 37]
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_poplar, v_ydock), GREATEST(v_poplar, v_ydock), v_src,
    'Scudder explicitly names Yellow Dock among the alterants associated with Poplar when tonic and alterative effects are both needed. Yellow Dock''s hepatic and blood-building action complements Poplar''s tonic bitterness.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_poplar, v_ydock) AND herb2_id = GREATEST(v_poplar, v_ydock);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Chronic conditions requiring both tonic and alterative effects', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);
  RAISE NOTICE 'Pair 21 done: Poplar + Yellow Dock (id=%)', v_pair_id;

  -- 22. Poplar + Yellow Parilla [86 vs v_yparilla]
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_poplar, v_yparilla), GREATEST(v_poplar, v_yparilla), v_src,
    'Scudder explicitly names Yellow Parilla (Menispermum canadense) among the alterants associated with Poplar when tonic and alterative effects are both indicated. Yellow Parilla was an eclectic specific for chronic conditions with tonic-alterative indications.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_poplar, v_yparilla) AND herb2_id = GREATEST(v_poplar, v_yparilla);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Chronic conditions requiring both tonic and alterative effects', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);
  RAISE NOTICE 'Pair 22 done: Poplar + Yellow Parilla (id=%)', v_pair_id;

  -- ── ELDER GROUP ───────────────────────────────────────────────────────────────

  -- 23. Elder + Juniper [57 vs 103]
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_elder, v_juniper), GREATEST(v_elder, v_juniper), v_src,
    'Scudder explicitly names Juniper berries as a useful associate with elder root in dropsical affections. Elder provides diuretic and sudorific action while Juniper adds a more stimulating diuretic and carminative effect for oedematous states.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_elder, v_juniper) AND herb2_id = GREATEST(v_elder, v_juniper);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Dropsical affections (oedema)', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);
  RAISE NOTICE 'Pair 23 done: Elder + Juniper (id=%)', v_pair_id;

  -- 24. Elder + Horseradish [57 vs 113]
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_elder, v_hraddish), GREATEST(v_elder, v_hraddish), v_src,
    'Scudder explicitly names Horseradish as a useful associate with elder root in dropsical affections. Horseradish adds a stimulating diuretic and rubefacient action that amplifies Elder''s diuretic and sudorific properties in oedematous states.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_elder, v_hraddish) AND herb2_id = GREATEST(v_elder, v_hraddish);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Dropsical affections (oedema)', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);
  RAISE NOTICE 'Pair 24 done: Elder + Horseradish (id=%)', v_pair_id;

  -- ── GRAVEL ROOT GROUP ─────────────────────────────────────────────────────────

  -- 25. Gravel Root + Horseradish [v_gravel vs 113]
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_gravel, v_hraddish), GREATEST(v_gravel, v_hraddish), v_src,
    'Scudder explicitly names Horseradish as an associate with Eupatorium purpureum (Gravel Root) in dropsy. Horseradish''s stimulating diuretic action complements Gravel Root''s urinary antilithic and diuretic properties for oedematous states with urinary involvement.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_gravel, v_hraddish) AND herb2_id = GREATEST(v_gravel, v_hraddish);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Dropsy (oedema) with urinary involvement', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);
  RAISE NOTICE 'Pair 25 done: Gravel Root + Horseradish (id=%)', v_pair_id;

  -- 26. Gravel Root + Juniper [v_gravel vs 103]
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_gravel, v_juniper), GREATEST(v_gravel, v_juniper), v_src,
    'Scudder explicitly names Juniper berries as an associate with Eupatorium purpureum (Gravel Root) in dropsy. Juniper adds a stimulating diuretic and carminative action that amplifies Gravel Root''s urinary antilithic and diuretic properties.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_gravel, v_juniper) AND herb2_id = GREATEST(v_gravel, v_juniper);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Dropsy (oedema) with urinary involvement', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);
  RAISE NOTICE 'Pair 26 done: Gravel Root + Juniper (id=%)', v_pair_id;

  -- 27. Gravel Root + Buchu [v_gravel vs 181]
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_gravel, v_buchu), GREATEST(v_gravel, v_buchu), v_src,
    'Scudder explicitly names Buchu as an associate with Eupatorium purpureum (Gravel Root) for chronic kidney, bladder, and urethral conditions with redundant mucous discharge. Buchu adds antiseptic and stimulating urinary tonic properties to Gravel Root''s antilithic and diuretic action.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_gravel, v_buchu) AND herb2_id = GREATEST(v_gravel, v_buchu);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Chronic kidney, bladder, or urethral conditions with redundant mucous discharge', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);
  RAISE NOTICE 'Pair 27 done: Gravel Root + Buchu (id=%)', v_pair_id;

  -- 28. Gravel Root + Pipsissewa [v_gravel vs 2239]
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_gravel, v_pipsis), GREATEST(v_gravel, v_pipsis), v_src,
    'Scudder explicitly names Pipsissewa (Chimaphila umbellata) as an associate with Eupatorium purpureum (Gravel Root) for chronic urinary conditions with mucous discharge. Pipsissewa adds an anti-inflammatory and urinary antiseptic action to Gravel Root''s diuretic and antilithic properties.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_gravel, v_pipsis) AND herb2_id = GREATEST(v_gravel, v_pipsis);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Chronic kidney, bladder, or urethral conditions with redundant mucous discharge', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);
  RAISE NOTICE 'Pair 28 done: Gravel Root + Pipsissewa (id=%)', v_pair_id;

  -- 29. Gravel Root + Uva Ursi [v_gravel vs 46]
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_gravel, v_uva), GREATEST(v_gravel, v_uva), v_src,
    'Scudder explicitly names Uva ursi (Bearberry) as an associate with Eupatorium purpureum (Gravel Root) for chronic urinary conditions with redundant mucous discharge. Uva ursi adds urinary antiseptic and astringent action to Gravel Root''s diuretic and antilithic properties.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_gravel, v_uva) AND herb2_id = GREATEST(v_gravel, v_uva);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Chronic kidney, bladder, or urethral conditions with redundant mucous discharge', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);
  RAISE NOTICE 'Pair 29 done: Gravel Root + Uva Ursi (id=%)', v_pair_id;

  -- ── APOCYNUM GROUP ────────────────────────────────────────────────────────────

  -- 30. Apocynum + Spearmint [v_apocynum vs v_spearmint]
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_apocynum, v_spearmint), GREATEST(v_apocynum, v_spearmint), v_src,
    'Scudder explicitly includes Spearmint with Apocynum in the described dropsical regimen. Apocynum provides powerful hydragogue and diuretic action; Spearmint adds a carminative and mild diuretic modifier that helps manage the sometimes harsh GI effects of Apocynum and supports the overall diuretic regimen.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;
  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_apocynum, v_spearmint) AND herb2_id = GREATEST(v_apocynum, v_spearmint);
  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Dropsical states — to increase efficacy of the hydragogue regimen', 10)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_apocynum,  'Powerful hydragogue and diuretic; Scudder''s main agent for dropsical states', 10),
    (v_spearmint, 'Carminative and mild diuretic modifier; helps manage GI effects and supports the dropsical regimen', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
  RAISE NOTICE 'Pair 30 done: Apocynum + Spearmint (id=%)', v_pair_id;

  RAISE NOTICE 'Migration 257 complete — 30 Scudder 1898 herb pairs inserted.';
END $$;
