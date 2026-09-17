-- Migration 339: Class 68 - Herb data for 9 newly-inserted herbs
-- Covers: energetics, synonyms, contraindications, primary actions,
--         secondary actions, herb_constituents (general), and menstruum.
-- Constituent IDs verified against live DB before writing:
--   quercetin=741, chlorogenic acid=785, luteolin=739, caffeic acid=784, rutin=742,
--   kaempferol=746, tannins=795, apigenin=737, beta-sitosterol=857, rosmarinic acid=783,
--   gallic acid=789, ellagic acid=790, polyacetylenes=1008, limonene=817, berberine=701,
--   borneol=807, mucilage=994, alkaloids=1103, linalool=799, 1,8-cineole=809,
--   alpha-pinene=810, beta-pinene=811, myrcene=824, beta-caryophyllene=830,
--   citral=820, geraniol=819, thymol=812, carvacrol=813, p-cymene=814,
--   vitamin C=1046, gamma-terpinene=816, geranyl acetate=1382
-- New constituent created: azadirachtin (limonoid) — inserted by this migration.

SET search_path TO herbal, public;

-- ── 1. Lemongrass (Cymbopogon citratus) ─────────────────────────────────────
DO $$
DECLARE
  v_herb_id INTEGER;
  v_c       INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Cymbopogon citratus';
  IF v_herb_id IS NULL THEN RAISE NOTICE 'Herb not found: Cymbopogon citratus'; RETURN; END IF;

  UPDATE herbal.herbs SET
    temperature          = 'warming',  temperature_inferred = true,
    moisture             = 'drying',   moisture_inferred    = true,
    synonyms             = ARRAY['Fever Grass','Citronella Grass','Barbed Wire Grass',
                                  'West Indian Lemongrass','East Indian Lemongrass','Oil Grass']
  WHERE id = v_herb_id;

  -- Primary actions
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES
    (v_herb_id, 11, 11, 'Carminative; relieves gas, bloating, and digestive cramping through volatile oil action', 'strong'),
    (v_herb_id,  5, 17, 'Antimicrobial against bacteria and fungi; citral and geraniol drive the activity', 'moderate'),
    (v_herb_id,  4, 16, 'Anti-inflammatory action on skin; used topically for fungal skin conditions', 'moderate'),
    (v_herb_id, 29,  9, 'Mild peripheral circulatory stimulant; warming volatile oils promote blood flow', 'mild'),
    (v_herb_id, 1245, 16, 'Antifungal against dermatophytes and Candida; citral is the primary active', 'moderate'),
    (v_herb_id, 51, 17, 'Diaphoretic; used traditionally for fevers and colds to promote sweating', 'mild')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Secondary actions (body_system_id 21 = All)
  INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
  VALUES (v_herb_id, 59, 21), (v_herb_id, 38, 21)
  ON CONFLICT (herb_id, secondary_action_id, body_system_id) DO NOTHING;

  -- herb_constituents (general) — IDs from live DB
  -- citral: primary aromatic aldehyde; defines lemongrass scent and antibacterial/antifungal activity
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'citral';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major', 'Primary volatile oil; 65–85% of the essential oil fraction; antibacterial and antifungal driver', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'geraniol';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', 'Significant aromatic monoterpene alcohol; contributes to antimicrobial action', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'myrcene';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'limonene';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'beta-caryophyllene';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 50)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Menstruum
  PERFORM herbal.set_menstruum(
    'Cymbopogon citratus', 50::INTEGER, 70::INTEGER, NULL::INTEGER, NULL::INTEGER,
    true,
    '50–70% alcohol or water infusion',
    'Volatile oils (citral, geraniol, myrcene) require moderate-high alcohol; flavonoids are also water-soluble. Traditional use as infusion is therapeutically effective for digestive and fever indications.',
    false, false, false
  );

  RAISE NOTICE 'Lemongrass (Cymbopogon citratus): done.';
END $$;


-- ── 2. Sumac (Rhus glabra) ───────────────────────────────────────────────────
DO $$
DECLARE
  v_herb_id INTEGER;
  v_c       INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Rhus glabra';
  IF v_herb_id IS NULL THEN RAISE NOTICE 'Herb not found: Rhus glabra'; RETURN; END IF;

  UPDATE herbal.herbs SET
    temperature          = 'cooling',  temperature_inferred = true,
    moisture             = 'drying',   moisture_inferred    = true,
    synonyms             = ARRAY['Smooth Sumac','Scarlet Sumac','Red Sumac','Lemonade Berry',
                                  'Smooth Sumach','Vinegar Tree']
  WHERE id = v_herb_id;

  -- Primary actions
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES
    (v_herb_id,  8, 11, 'Strong astringent to the GI tract; reduces excessive secretions and loose stool', 'strong'),
    (v_herb_id,  8, 12, 'Astringent to the urinary tract; used for mucous discharges and urinary complaints', 'strong'),
    (v_herb_id,  5, 17, 'Antimicrobial; gallic acid and tannins inhibit microbial growth on mucous membranes', 'moderate'),
    (v_herb_id, 1158, 16, 'Styptic; arrests minor bleeding topically', 'strong'),
    (v_herb_id, 37, 21, 'Antioxidant; high ellagic acid and gallic acid content', 'moderate'),
    (v_herb_id, 14, 12, 'Mild diuretic action', 'mild')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Secondary actions
  INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
  VALUES (v_herb_id, 49, 21), (v_herb_id, 45, 21)
  ON CONFLICT (herb_id, secondary_action_id, body_system_id) DO NOTHING;

  -- herb_constituents — tannins are the defining feature (15–25% in bark and fruit)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'tannins';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'primary', 'Bark and fruit contain 15–25% tannins; primary therapeutic constituent driving astringent and hemostatic activity', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'gallic acid';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major', 'High gallic acid content from hydrolyzable tannins; major antioxidant contributor', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'ellagic acid';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', 'Released on hydrolysis of ellagitannins in the bark', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'quercetin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'kaempferol';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 50)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Menstruum — tannins precipitate in high alcohol; water decoction or low-alcohol is preferred
  PERFORM herbal.set_menstruum(
    'Rhus glabra', 25::INTEGER, 40::INTEGER, NULL::INTEGER, NULL::INTEGER,
    true,
    '25–40% alcohol or water decoction',
    'High tannin content precipitates in alcohol above 50%; water decoction or low-alcohol tincture (with 10% glycerin as per MM) extracts tannins effectively.',
    false, false, false
  );

  RAISE NOTICE 'Sumac (Rhus glabra): done.';
END $$;


-- ── 3. Neem (Azadirachta indica) ─────────────────────────────────────────────
DO $$
DECLARE
  v_herb_id INTEGER;
  v_c       INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Azadirachta indica';
  IF v_herb_id IS NULL THEN RAISE NOTICE 'Herb not found: Azadirachta indica'; RETURN; END IF;

  UPDATE herbal.herbs SET
    temperature          = 'cooling',  temperature_inferred = false,
    moisture             = 'drying',   moisture_inferred    = false,
    contraindications    = 'Contraindicated in young children, elderly, and debilitated individuals. For internal use, short-term only. Not for use during pregnancy or lactation.',
    contraindications_source = 'Easley''s Dispensatory',
    synonyms             = ARRAY['Margosa','Indian Lilac','Nimtree','Nim','Nimba','Neem tree']
  WHERE id = v_herb_id;

  -- Primary actions
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES
    (v_herb_id,  5, 17, 'Broad-spectrum antimicrobial; limonoids (esp. azadirachtin) inhibit bacteria, viruses, and fungi', 'strong'),
    (v_herb_id, 1245, 16, 'Antifungal; effective topically for dermatophytes and Candida', 'strong'),
    (v_herb_id,  4, 16, 'Anti-inflammatory action on skin; reduces inflammatory cytokine activity', 'moderate'),
    (v_herb_id,  2, 16, 'Alterative for skin conditions; blood purifying action with chronic skin complaints', 'moderate'),
    (v_herb_id,  9, 11, 'Bitter digestive tonic; stimulates bile flow and digestive secretions', 'moderate'),
    (v_herb_id, 1242, 17, 'Anthelmintic; azadirachtin disrupts insect and parasite hormonal cycles', 'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Secondary actions
  INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
  VALUES (v_herb_id, 36, 21), (v_herb_id, 45, 21)
  ON CONFLICT (herb_id, secondary_action_id, body_system_id) DO NOTHING;

  -- herb_constituents — create azadirachtin (primary limonoid, not in DB yet)
  v_c := herbal.ensure_constituent(
    'azadirachtin',
    'limonoid',
    'Primary bitter limonoid of Azadirachta indica; disrupts insect growth hormone signaling (insecticidal) and exhibits broad antimicrobial and antifeedant activity.'
  );
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major', 'Defining limonoid; highest in seeds but present in leaves; primary bioactive responsible for neem''s antiparasitic and antimicrobial effects', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'quercetin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'beta-sitosterol';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'tannins';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Menstruum — limonoids are lipophilic; moderate alcohol best
  PERFORM herbal.set_menstruum(
    'Azadirachta indica', 40::INTEGER, 60::INTEGER, NULL::INTEGER, NULL::INTEGER,
    false,
    '40–60% alcohol',
    'Bitter limonoids (azadirachtin) and terpenoids extract best in moderate alcohol. Water extraction is used traditionally but lower-potency for antimicrobial applications.',
    false, false, true
  );

  RAISE NOTICE 'Neem (Azadirachta indica): done.';
END $$;


-- ── 4. Bee Balm (Monarda fistulosa) ─────────────────────────────────────────
DO $$
DECLARE
  v_herb_id INTEGER;
  v_c       INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Monarda fistulosa';
  IF v_herb_id IS NULL THEN RAISE NOTICE 'Herb not found: Monarda fistulosa'; RETURN; END IF;

  UPDATE herbal.herbs SET
    temperature          = 'warming',  temperature_inferred = true,
    moisture             = 'drying',   moisture_inferred    = true,
    synonyms             = ARRAY['Wild Bergamot','Oswego Tea','Horsemint','Wild Oregano',
                                  'Purple Bee Balm']
  WHERE id = v_herb_id;

  -- Primary actions
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES
    (v_herb_id,  5, 17, 'Strong antimicrobial; thymol and carvacrol are among the most potent botanical antiseptics', 'strong'),
    (v_herb_id, 11, 11, 'Carminative; relieves gas and digestive spasm through volatile oil action', 'strong'),
    (v_herb_id, 51, 17, 'Diaphoretic; promotes sweating for fevers and early stage colds', 'moderate'),
    (v_herb_id, 1245, 17, 'Antifungal; thymol effectively inhibits dermatophytes and Candida', 'moderate'),
    (v_herb_id,  7, 11, 'Antispasmodic for digestive tract', 'mild')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Secondary actions
  INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
  VALUES (v_herb_id, 36, 21), (v_herb_id, 59, 21)
  ON CONFLICT (herb_id, secondary_action_id, body_system_id) DO NOTHING;

  -- herb_constituents — thymol and carvacrol are dominant in M. fistulosa
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'thymol';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major', 'Dominant monoterpene phenol (often 30–60% of essential oil); primary antiseptic and antifungal active', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'carvacrol';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major', 'Co-dominant with thymol in many M. fistulosa chemotypes; potent antimicrobial', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'rosmarinic acid';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', 'Significant in aerial parts; anti-inflammatory and antioxidant', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'luteolin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'apigenin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 50)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'beta-caryophyllene';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 60)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Menstruum
  PERFORM herbal.set_menstruum(
    'Monarda fistulosa', 50::INTEGER, 70::INTEGER, NULL::INTEGER, NULL::INTEGER,
    true,
    '50–70% alcohol or water infusion',
    'Volatile oils (thymol, carvacrol) require moderate-high alcohol. Rosmarinic acid and flavonoids also extract in water; traditional use as infusion (Oswego tea) is valid for digestive and fever indications.',
    false, false, false
  );

  RAISE NOTICE 'Bee Balm (Monarda fistulosa): done.';
END $$;


-- ── 5. Bidens (Bidens spp.) ──────────────────────────────────────────────────
DO $$
DECLARE
  v_herb_id INTEGER;
  v_c       INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Bidens spp.';
  IF v_herb_id IS NULL THEN RAISE NOTICE 'Herb not found: Bidens spp.'; RETURN; END IF;

  UPDATE herbal.herbs SET
    temperature          = 'cooling',  temperature_inferred = true,
    moisture             = 'drying',   moisture_inferred    = true,
    synonyms             = ARRAY['Spanish Needles','Beggar''s Ticks','Bur Marigold','Tickseed',
                                  'Te de Coral','Shepherd''s Needles','Cobbler''s Pegs']
  WHERE id = v_herb_id;

  -- Primary actions
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES
    (v_herb_id,  5, 17, 'Strong broad-spectrum antimicrobial; polyacetylenes (esp. phenylheptatriyne) effective against drug-resistant organisms', 'strong'),
    (v_herb_id, 40, 17, 'Immunostimulant; stimulates innate immune response, macrophage activation', 'strong'),
    (v_herb_id,  4, 17, 'Anti-inflammatory; luteolin and caffeic acid modulate inflammatory cascade', 'moderate'),
    (v_herb_id, 55, 17, 'Lymphatic tonic; promotes lymphatic drainage and resolution of swollen lymph nodes', 'moderate'),
    (v_herb_id, 1245, 17, 'Antifungal; polyacetylenes active against Candida and dermatophytes', 'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Secondary actions
  INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
  VALUES (v_herb_id, 49, 21), (v_herb_id, 41, 21)
  ON CONFLICT (herb_id, secondary_action_id, body_system_id) DO NOTHING;

  -- herb_constituents — polyacetylenes are the defining class of bioactives
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'polyacetylenes';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major', 'Key antimicrobial class; phenylheptatriyne (PHT) is the defining polyacetylene — degrades quickly after harvest, making fresh plant tincture essential', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'luteolin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', 'Anti-inflammatory flavone; abundant in aerial parts', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'quercetin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', NULL, 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'caffeic acid';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', NULL, 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'chlorogenic acid';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 50)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Menstruum — fresh plant critical for preserving polyacetylenes
  PERFORM herbal.set_menstruum(
    'Bidens spp.', 40::INTEGER, 60::INTEGER, NULL::INTEGER, NULL::INTEGER,
    false,
    '40–60% alcohol (fresh plant preferred)',
    'Polyacetylenes degrade rapidly after harvest; fresh plant tincture (1:2, 50%) strongly preferred. Dried herb tincture (1:5, 50%) is second choice. Water alone is insufficient for polyacetylenes.',
    false, false, false
  );

  RAISE NOTICE 'Bidens (Bidens spp.): done.';
END $$;


-- ── 6. Jojoba (Simmondsia chinensis) ────────────────────────────────────────
DO $$
DECLARE
  v_herb_id INTEGER;
  v_c       INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Simmondsia chinensis';
  IF v_herb_id IS NULL THEN RAISE NOTICE 'Herb not found: Simmondsia chinensis'; RETURN; END IF;

  UPDATE herbal.herbs SET
    -- Temperature not set (no confirmed source; leaf tannins suggest cooling but the
    -- oil is thermally neutral — leaving unset to avoid misleading inference)
    moisture             = 'drying',   moisture_inferred    = true,
    synonyms             = ARRAY['Deer Nut','Pig Nut','Wild Hazel','Goatnut','Coffee Berry',
                                  'Hohoba']
  WHERE id = v_herb_id;

  -- Primary actions
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES
    (v_herb_id, 44, 16, 'Emollient fixed oil; the primary topical preparation; mimics sebum composition', 'strong'),
    (v_herb_id,  8, 16, 'Astringent leaf preparation; used as wash for oily skin and minor wounds', 'moderate'),
    (v_herb_id,  4, 16, 'Anti-inflammatory topical action; reduces erythema and itching', 'moderate'),
    (v_herb_id, 28, 16, 'Vulnerary; supports epithelial repair topically', 'mild')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Secondary actions
  INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
  VALUES (v_herb_id, 36, 21)
  ON CONFLICT (herb_id, secondary_action_id, body_system_id) DO NOTHING;

  -- herb_constituents — leaf: tannins, luteolin, quercetin
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'tannins';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', 'Tannins present in leaves; responsible for the astringent action of leaf infusions and washes', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'luteolin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'quercetin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Menstruum — primarily used as a fixed oil (topical); leaves as water infusion
  PERFORM herbal.set_menstruum(
    'Simmondsia chinensis', NULL::INTEGER, NULL::INTEGER, NULL::INTEGER, NULL::INTEGER,
    true,
    'water infusion (leaves) or fixed oil (topical)',
    'Leaves prepared as standard infusion for topical wash or internal use. Seed oil (liquid wax ester) used topically as emollient carrier and skin moisturizer.',
    false, false, true
  );

  RAISE NOTICE 'Jojoba (Simmondsia chinensis): done.';
END $$;


-- ── 7. Agarita (Berberis trifoliolata) ──────────────────────────────────────
DO $$
DECLARE
  v_herb_id INTEGER;
  v_c       INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Berberis trifoliolata';
  IF v_herb_id IS NULL THEN RAISE NOTICE 'Herb not found: Berberis trifoliolata'; RETURN; END IF;

  UPDATE herbal.herbs SET
    temperature          = 'cooling',  temperature_inferred = true,
    moisture             = 'drying',   moisture_inferred    = true,
    synonyms             = ARRAY['Agarito','Texas Barberry','Algerita','Laredo Mahonia',
                                  'Trifoliate Barberry','Holy Barberry','Agrito']
  WHERE id = v_herb_id;

  -- Primary actions
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES
    (v_herb_id,  5, 17, 'Antimicrobial; berberine inhibits a wide range of bacteria, protozoa, and fungi', 'strong'),
    (v_herb_id,  9, 11, 'Bitter tonic; stimulates digestive secretions through berberine action on bile and gastric acid', 'strong'),
    (v_herb_id, 12, 11, 'Cholagogue; berberine stimulates bile production and gallbladder contraction', 'strong'),
    (v_herb_id, 19, 11, 'Hepatic; supports liver function; related to cholagogue action', 'moderate'),
    (v_herb_id,  2, 17, 'Alterative; supports elimination of metabolic waste', 'moderate'),
    (v_herb_id,  4, 11, 'Anti-inflammatory in the gut; reduces mucosal inflammation', 'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Secondary actions
  INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
  VALUES (v_herb_id, 36, 21), (v_herb_id, 42, 21)
  ON CONFLICT (herb_id, secondary_action_id, body_system_id) DO NOTHING;

  -- herb_constituents — berberine is the defining isoquinoline alkaloid
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'berberine';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major', 'Characteristic isoquinoline alkaloid of all Berberis species; primary driver of antimicrobial, bitter tonic, and cholagogue activity', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'tannins';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', 'Condensed tannins in root bark; contribute to astringent action', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'alkaloids';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', 'Broader alkaloid class; includes berberine-type isoquinolines and protoberberines', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Menstruum — isoquinoline alkaloids require acidic conditions (vinegar) for salt formation
  PERFORM herbal.set_menstruum(
    'Berberis trifoliolata', 40::INTEGER, 60::INTEGER, NULL::INTEGER, 10::INTEGER,
    true,
    '40–60% alcohol + 5–10% vinegar',
    'Berberine and related isoquinoline alkaloids form water-soluble salts in acidic conditions. Adding 5–10% vinegar to the menstruum improves extraction. Water decoction is also effective for berberine (water-soluble salt).',
    false, false, false
  );

  RAISE NOTICE 'Agarita (Berberis trifoliolata): done.';
END $$;


-- ── 8. Pine Needles (Pinus spp.) ─────────────────────────────────────────────
DO $$
DECLARE
  v_herb_id INTEGER;
  v_c       INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Pinus spp.';
  IF v_herb_id IS NULL THEN RAISE NOTICE 'Herb not found: Pinus spp.'; RETURN; END IF;

  UPDATE herbal.herbs SET
    temperature          = 'warming',  temperature_inferred = false,
    moisture             = 'drying',   moisture_inferred    = false,
    synonyms             = ARRAY['Ponderosa Pine','Western Yellow Pine','Bull Pine',
                                  'Blackjack Pine','Pine','White Pine']
  WHERE id = v_herb_id;

  -- Primary actions
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES
    (v_herb_id, 53, 19, 'Expectorant; monoterpenes (alpha-pinene, limonene) stimulate respiratory secretion and clearance', 'moderate'),
    (v_herb_id,  5, 19, 'Antimicrobial/antiseptic for upper respiratory tract; alpha-pinene inhibits bacterial and fungal growth', 'moderate'),
    (v_herb_id, 37, 17, 'Antioxidant; notably high vitamin C content in fresh needles; monoterpenes also contribute', 'moderate'),
    (v_herb_id,  4, 14, 'Anti-inflammatory; used in wound wash and topically for musculoskeletal inflammation', 'mild'),
    (v_herb_id, 1162, 17, 'Nutritive; fresh pine needles are exceptionally high in vitamin C compared to most botanicals', 'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Secondary actions
  INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
  VALUES (v_herb_id, 48, 21), (v_herb_id, 42, 21), (v_herb_id, 61, 21)
  ON CONFLICT (herb_id, secondary_action_id, body_system_id) DO NOTHING;

  -- herb_constituents — alpha-pinene and beta-pinene are defining
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'alpha-pinene';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major', 'Defining monoterpene of pine; primary expectorant and antiseptic volatile; responsible for the characteristic fresh pine scent', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'beta-pinene';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major', 'Co-dominant with alpha-pinene in pine needle essential oil; expectorant and antimicrobial', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'limonene';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', NULL, 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'vitamin C';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', 'Fresh pine needles contain ~5× more vitamin C per gram than citrus; largely lost on prolonged drying', 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'myrcene';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 50)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'beta-caryophyllene';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 60)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Menstruum
  PERFORM herbal.set_menstruum(
    'Pinus spp.', 50::INTEGER, 70::INTEGER, NULL::INTEGER, NULL::INTEGER,
    true,
    '50–70% alcohol or water infusion',
    'Monoterpenes (alpha-pinene, beta-pinene) extract in moderate-high alcohol. Vitamin C and flavonoids are water-soluble; traditional use as needles infusion is therapeutically valid. Short infusion preferred to minimize terpene oxidation.',
    false, false, false
  );

  RAISE NOTICE 'Pine Needles (Pinus spp.): done.';
END $$;


-- ── 9. Maravilla (Mirabilis multiflorum) ─────────────────────────────────────
DO $$
DECLARE
  v_herb_id INTEGER;
  v_c       INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Mirabilis multiflorum';
  IF v_herb_id IS NULL THEN RAISE NOTICE 'Herb not found: Mirabilis multiflorum'; RETURN; END IF;

  UPDATE herbal.herbs SET
    temperature          = 'cooling',  temperature_inferred = true,
    moisture             = 'drying',   moisture_inferred    = true,
    synonyms             = ARRAY['Wild Four-O''Clock','Colorado Four-O''Clock',
                                  'Showy Four-O''Clock','Desert Maravilla']
  WHERE id = v_herb_id;

  -- Primary actions
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES
    (v_herb_id, 1245, 16, 'Antifungal; traditional use for tinea, ringworm, and skin fungal infections', 'strong'),
    (v_herb_id,  5, 17, 'Antimicrobial; rotenoid alkaloids exhibit broad antimicrobial activity', 'moderate'),
    (v_herb_id,  6, 14, 'Antirheumatic; used in SW traditional medicine for joint pain and arthritis', 'moderate'),
    (v_herb_id,  4, 14, 'Anti-inflammatory; flavonoids reduce inflammatory mediators in musculoskeletal tissue', 'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Secondary actions
  INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
  VALUES (v_herb_id, 49, 21)
  ON CONFLICT (herb_id, secondary_action_id, body_system_id) DO NOTHING;

  -- herb_constituents — sparse data; alkaloids are the primary bioactives
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'alkaloids';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', 'Rotenoid-type alkaloids including boeravinones; antifungal and antimicrobial activity in SW traditional medicine', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'quercetin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'kaempferol';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Menstruum — fresh root tincture preferred (per MM); alkaloids and flavonoids
  PERFORM herbal.set_menstruum(
    'Mirabilis multiflorum', 40::INTEGER, 60::INTEGER, NULL::INTEGER, NULL::INTEGER,
    false,
    '40–60% alcohol (fresh root preferred)',
    'MM indicates fresh root tincture (1:2); alkaloids and flavonoids extract best in moderate alcohol. Limited published data — needs_review applies.',
    true, false, false
  );

  RAISE NOTICE 'Maravilla (Mirabilis multiflorum): done.';
END $$;
