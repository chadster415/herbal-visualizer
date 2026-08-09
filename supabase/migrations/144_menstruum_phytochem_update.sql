SET search_path TO herbal, public;

-- ─── Menstruum update from BHC Class 52 Phytochemistry notes ──────────────────
--
-- Rules applied from class:
--   Mucilage        → cold water or glycerite (glycerin_pct=100); alcohol destroys them
--   Tannins         → add 5–10% glycerin (glycerin_pct=10) to prevent precipitation
--   Alkaloids       → min 45% ETOH + 5–10% vinegar (converts to water-soluble salts)
--   Volatile oils   → glycerite (glycerin_pct=100) preserves best; alcohol degrades over time
--   Resins          → high ETOH only (unchanged)
--   Glycerite       → glycerin_pct=100 (pure glycerin preparation)
--
-- Source: BHC Class 52 – Plant Constituents – Ashley, 2026-08-06

DO $$ BEGIN RAISE NOTICE '144: updating menstruum data from Class 52 phytochem notes...'; END $$;


-- ═══════════════════════════════════════════════════════════════════════════════
-- 1. MUCILAGE HERBS — update glycerin_pct to 100 (glycerite)
--    "ONLY soluble in cold water — insoluble in alcohol"
-- ═══════════════════════════════════════════════════════════════════════════════

DO $$
BEGIN
  PERFORM herbal.set_menstruum('Althaea officinalis',
    NULL, NULL, 100, NULL, TRUE,
    'cold water or glycerite',
    'Mucilaginous polysaccharides are destroyed by heat and precipitated by alcohol. Cold infusion or glycerite (glycerin_pct=100) preserves full mucilage content.');
END $$;

DO $$
BEGIN
  PERFORM herbal.set_menstruum('Ulmus rubra',
    NULL, NULL, 100, NULL, TRUE,
    'cold water or glycerite',
    'Primary arabinogalacturonan mucilage is destroyed by alcohol and heat; cold-water gruel or glycerite only. Denatured by boiling.');
END $$;

DO $$
BEGIN
  -- Mullein leaf: mucilage + saponins — direct SQL because plant_part='leaf' is in DB
  UPDATE herbal.herb_menstruum
  SET alcohol_pct_min = NULL,
      alcohol_pct_max = NULL,
      glycerin_pct    = 100,
      water_effective = TRUE,
      primary_label   = 'water or glycerite',
      notes           = 'Primary mucilaginous polysaccharides and saponins extract in water or glycerite; high alcohol precipitates mucilage.'
  WHERE herb_id = (
    SELECT id FROM herbal.herbs
    WHERE latin_name = 'Verbascum thapsus' AND plant_part = 'leaf'
  );

  IF NOT FOUND THEN
    INSERT INTO herbal.herb_menstruum
      (herb_id, alcohol_pct_min, alcohol_pct_max, glycerin_pct, vinegar_pct, water_effective, primary_label, notes, needs_review)
    SELECT id, NULL, NULL, 100, NULL, TRUE,
      'water or glycerite',
      'Primary mucilaginous polysaccharides and saponins extract in water or glycerite; high alcohol precipitates mucilage.',
      FALSE
    FROM herbal.herbs WHERE latin_name = 'Verbascum thapsus' AND plant_part = 'leaf';
  END IF;
END $$;

DO $$
BEGIN
  -- Comfrey root: cold water/glycerite to avoid extracting pyrrolizidine alkaloids
  -- (high ETOH would pull too many PAs from the root)
  UPDATE herbal.herb_menstruum
  SET glycerin_pct  = 100,
      primary_label = 'cold water or glycerite (topical / leaf preferred internally)',
      notes         = 'Allantoin and mucilage extract in cold water; glycerite also effective. Avoid high alcohol for root — extracts hepatotoxic pyrrolizidine alkaloids. Topical or leaf preparations preferred for internal use.'
  WHERE herb_id = (
    SELECT id FROM herbal.herbs
    WHERE latin_name = 'Symphytum officinale' AND plant_part = 'root'
  );
END $$;


-- ═══════════════════════════════════════════════════════════════════════════════
-- 2. VOLATILE OIL HERBS — glycerite (glycerin_pct=100) for long-term preservation
--    "Aromatic, volatile. Degrade in alcohol over time. Use glycerin to preserve."
-- ═══════════════════════════════════════════════════════════════════════════════

DO $$
BEGIN
  -- Lavender: the class glycerite example; linalool/linalyl acetate degrade in alcohol
  PERFORM herbal.set_menstruum('Lavandula spp.',
    NULL, NULL, 100, NULL, FALSE,
    'glycerite (volatile oils degrade in alcohol)',
    'Linalool and linalyl acetate (primary volatile monoterpenes) degrade in alcohol over time. Glycerite (glycerin_pct=100) best preserves aromatic compounds for long-term use. Alcohol tincture at 60–80% is viable for immediate use but loses potency with storage.');
END $$;


-- ═══════════════════════════════════════════════════════════════════════════════
-- 3. TANNIC HERBS — add glycerin_pct=10 (5–10% glycerin prevents precipitation)
--    "add 5–10% glycerin to help tannins bind and prevent alkaloid precipitation"
--    Class explicitly listed: Agrimony, Cinnamon, Willow, Raspberry, Bayberry,
--    Uva ursi, Rose hips, Red root, Blackberry root, Black walnut
-- ═══════════════════════════════════════════════════════════════════════════════

-- Agrimony (primary tannins in constituent data + explicitly listed)
DO $$
BEGIN
  PERFORM herbal.set_menstruum('Agrimonia eupatoria',
    25, 45, 10, NULL, TRUE,
    '25–45% alcohol + glycerin or water',
    'Primary tannins (agrimoniin, ellagitannins, proanthocyanidins) and flavonoids. Add 5–10% glycerin to prevent tannin precipitation and maintain formula clarity. Water or low alcohol also effective for flavonoids.');
END $$;

-- Uva Ursi (primary tannins + explicitly listed)
DO $$
BEGIN
  PERFORM herbal.set_menstruum('Arctostaphylos uva-ursi',
    25, 60, 10, NULL, TRUE,
    '25–60% alcohol + glycerin or water',
    'Primary tannins (gallotannins, proanthocyanidins) alongside water-soluble arbutin. Add 5–10% glycerin to prevent tannin precipitation. Low alcohol or water decoction for arbutin.');
END $$;

-- Raspberry leaf (primary tannins + explicitly listed)
DO $$
BEGIN
  UPDATE herbal.herb_menstruum
  SET glycerin_pct  = 10,
      primary_label = '25–45% alcohol + glycerin or water',
      notes         = 'Primary ellagitannins and tannins, fragarine alkaloid, flavonoids. Add 5–10% glycerin to bind tannins. Traditional preparation as tea is effective and sufficient for most uses.'
  WHERE herb_id = (
    SELECT id FROM herbal.herbs
    WHERE latin_name = 'Rubus idaeus' AND plant_part = 'leaf'
  );
END $$;

-- Witch Hazel (primary hamamelitannin + ellagitannins — highly tannic)
DO $$
BEGIN
  PERFORM herbal.set_menstruum('Hamamelis virginiana',
    14, 15, 10, NULL, TRUE,
    'water distillate or 25–40% alcohol + glycerin',
    'Primary hamamelitannin, gallotannins, and ellagitannins. Commercial product is a water distillate (~14% alcohol). Bark tincture at 25–40% + 5–10% glycerin captures fuller tannin spectrum without precipitation.');
END $$;

-- Cinnamon (explicitly listed as tannic in class)
DO $$
BEGIN
  PERFORM herbal.set_menstruum('Cinnamomum spp.',
    40, 65, 10, NULL, FALSE,
    '40–65% alcohol + glycerin',
    'Cinnamaldehyde and volatile phenylpropanoids require moderate alcohol. Explicitly listed as tannic in class — add 5–10% glycerin. Bark tincture.');
END $$;

DO $$
BEGIN
  PERFORM herbal.set_menstruum('Cinnamomum aromaticum',
    40, 65, 10, NULL, FALSE,
    '40–65% alcohol + glycerin',
    'Cinnamaldehyde and trans-cinnamic acid require moderate alcohol. Tannin-bearing bark — add 5–10% glycerin. Bark tincture.');
END $$;

-- Willow (explicitly listed as tannic in class; salicin is water-soluble)
DO $$
BEGIN
  PERFORM herbal.set_menstruum('Salix spp.',
    25, 60, 10, NULL, TRUE,
    '25–60% alcohol + glycerin or water',
    'Salicin (phenolic glycoside, water-soluble) and catechins. Tannins present — explicitly listed in class. Add 5–10% glycerin. Bark decoction is traditional and effective.');
END $$;

-- Bayberry (explicitly listed as tannic in class)
DO $$
BEGIN
  PERFORM herbal.set_menstruum('Myrica cerifera',
    40, 60, 10, NULL, FALSE,
    '40–60% alcohol + glycerin',
    'Myricetin flavonol and gallic acid. Explicitly listed as tannic in class — add 5–10% glycerin. Root bark tincture.');
END $$;

-- Rose hips (explicitly listed as tannic in class; plant_part='hips')
DO $$
DECLARE v_id INTEGER;
BEGIN
  SELECT id INTO v_id FROM herbal.herbs
  WHERE latin_name = 'Rosa spp.' AND plant_part = 'hips';

  IF v_id IS NULL THEN
    RAISE NOTICE 'Rosa spp. hips not found — skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.herb_menstruum
    (herb_id, alcohol_pct_min, alcohol_pct_max, glycerin_pct, vinegar_pct, water_effective, primary_label, notes, needs_review)
  VALUES
    (v_id, 25, 50, 10, NULL, TRUE,
     '25–50% alcohol + glycerin or water',
     'Catechins, quercetin, and proanthocyanidins (condensed tannins). Explicitly listed as tannic in class — add 5–10% glycerin to prevent precipitation. Hip tea is traditional and also effective for vitamin C content.',
     FALSE)
  ON CONFLICT (herb_id) DO UPDATE SET
    alcohol_pct_min = 25, alcohol_pct_max = 50, glycerin_pct = 10,
    water_effective = TRUE,
    primary_label   = '25–50% alcohol + glycerin or water',
    notes           = 'Catechins, quercetin, and proanthocyanidins (condensed tannins). Explicitly listed as tannic in class — add 5–10% glycerin to prevent precipitation. Hip tea is traditional and also effective for vitamin C content.',
    needs_review    = FALSE;
END $$;

-- Red Root (explicitly listed as tannic; also has saponins which are water-soluble)
DO $$
BEGIN
  PERFORM herbal.set_menstruum('Ceanothus americanus',
    40, 60, 10, NULL, FALSE,
    '40–60% alcohol + glycerin',
    'Tannins (explicitly listed as tannic in class) and ceanothine alkaloids. Red root saponins partially water-soluble but tannins dominate the formulation concern. Add 5–10% glycerin. Root tincture.');
END $$;

-- Blackberry root (explicitly listed as tannic in class)
DO $$
BEGIN
  PERFORM herbal.set_menstruum('Rubus villosus',
    25, 50, 10, NULL, TRUE,
    '25–50% alcohol + glycerin or water',
    'Primary ellagitannins, gallic acid, and catechin. Explicitly listed as tannic in class — add 5–10% glycerin. Root bark decoction or low-alcohol tincture.');
END $$;

-- Black Walnut (explicitly listed as tannic in class)
DO $$
BEGIN
  PERFORM herbal.set_menstruum('Juglans nigra',
    40, 60, 10, NULL, FALSE,
    '40–60% alcohol + glycerin',
    'Ellagic acid, gallic acid, and juglone (naphthoquinone). Explicitly listed as tannic in class — add 5–10% glycerin. Green hull tincture preferred.');
END $$;

-- Lady's Mantle (primary ellagitannins — same tannin class as agrimony)
DO $$
BEGIN
  PERFORM herbal.set_menstruum('Alchemilla vulgaris',
    25, 45, 10, NULL, TRUE,
    '25–45% alcohol + glycerin or water',
    'Primary ellagitannins (agrimoniin, pedunculagin, tellimagrandin). Add 5–10% glycerin to prevent tannin precipitation. Flavonoid glycosides water-soluble; tea is traditional.');
END $$;

-- Elder flower (moderate tannins + mucilage; update existing record to add glycerin)
DO $$
DECLARE v_id INTEGER;
BEGIN
  SELECT id INTO v_id FROM herbal.herbs
  WHERE latin_name = 'Sambucus nigra' AND plant_part = 'flower';

  IF v_id IS NULL THEN RAISE NOTICE 'Sambucus nigra flower not found'; RETURN; END IF;

  INSERT INTO herbal.herb_menstruum
    (herb_id, alcohol_pct_min, alcohol_pct_max, glycerin_pct, vinegar_pct, water_effective, primary_label, notes, needs_review)
  VALUES
    (v_id, 25, 60, 10, NULL, TRUE,
     '25–60% alcohol + glycerin, water, or glycerite',
     'Flavonoids and mucilage extract in water, glycerite, or moderate alcohol. Flower tannins — add 5–10% glycerin for stability. Flower glycerite is effective. Always heat berries to destroy sambunigrin.',
     FALSE)
  ON CONFLICT (herb_id) DO UPDATE SET
    glycerin_pct  = 10,
    primary_label = '25–60% alcohol + glycerin, water, or glycerite',
    notes         = 'Flavonoids and mucilage extract in water, glycerite, or moderate alcohol. Flower tannins — add 5–10% glycerin for stability. Flower glycerite is effective. Always heat berries to destroy sambunigrin.',
    needs_review  = FALSE;
END $$;


-- ═══════════════════════════════════════════════════════════════════════════════
-- 4. ALKALOID HERBS — add vinegar_pct=10 (min 45% ETOH)
--    "5–10% vinegar when making tinctures with alkaloid-containing plants —
--     vinegar acidifies water, converting alkaloids to alkaloid salts"
--    Class explicitly listed: California Poppy, Cayenne*, Oregon Grape, Silk Tassel,
--    Goldenseal, Yellow Pond Lily, Barberry, Corydalis, Motherwort, Blood Root,
--    Lobelia, Ephedra
--    (* Cayenne capsaicinoids are NOT true alkaloids — high ETOH already correct)
-- ═══════════════════════════════════════════════════════════════════════════════

-- California Poppy (isoquinoline alkaloids; explicitly listed)
DO $$
BEGIN
  PERFORM herbal.set_menstruum('Eschscholzia californica',
    45, 70, NULL, 10, FALSE,
    '45–70% alcohol + 5–10% vinegar (fresh plant)',
    'Isoquinoline alkaloids (californidine, eschscholtzine, protopine) require minimum 45% alcohol. Add 5–10% vinegar to convert alkaloids to water-soluble salts. Fresh whole plant tincture preferred; explicitly listed in class.');
END $$;

-- Goldenseal (isoquinoline alkaloids; explicitly listed)
DO $$
BEGIN
  PERFORM herbal.set_menstruum('Hydrastis canadensis',
    45, 60, NULL, 10, FALSE,
    '45–60% alcohol + 5–10% vinegar',
    'Primary isoquinoline alkaloids (berberine, hydrastine, canadine). Minimum 45% alcohol + 5–10% vinegar for optimal alkaloid salt extraction. Explicitly listed in class. Root tincture.');
END $$;

-- Oregon Grape (isoquinoline alkaloids; explicitly listed)
DO $$
BEGIN
  PERFORM herbal.set_menstruum('Mahonia aquifolium',
    45, 60, NULL, 10, FALSE,
    '45–60% alcohol + 5–10% vinegar',
    'Primary isoquinoline alkaloids (berberine, berbamine, oxyacanthine, palmatine). Minimum 45% alcohol + 5–10% vinegar. Root bark tincture. Explicitly listed in class.');
END $$;

-- Lobelia (piperidine alkaloids; explicitly listed)
DO $$
BEGIN
  PERFORM herbal.set_menstruum('Lobelia inflata',
    45, 70, NULL, 10, FALSE,
    '45–70% alcohol + 5–10% vinegar',
    'Primary piperidine alkaloids (lobeline, lobelanine, lobelanidine). Minimum 45% alcohol + 5–10% vinegar. Narrow therapeutic window — use with care. Explicitly listed in class.');
END $$;

-- Motherwort (guanidine + pyrrolidine alkaloids; explicitly listed)
DO $$
BEGIN
  PERFORM herbal.set_menstruum('Leonurus cardiaca',
    45, 60, NULL, 10, TRUE,
    '45–60% alcohol + 5–10% vinegar or water',
    'Leonurine (guanidine alkaloid) and stachydrine (pyrrolidine alkaloid) require minimum 45% alcohol + 5–10% vinegar. Water also extracts flavonoids and iridoid glycosides. Fresh plant tincture preferred. Explicitly listed in class.');
END $$;

-- Wild Indigo (quinolizidine alkaloids)
DO $$
BEGIN
  PERFORM herbal.set_menstruum('Baptisia tinctoria',
    50, 70, NULL, 10, FALSE,
    '50–70% alcohol + 5–10% vinegar',
    'Quinolizidine alkaloids (baptifoline, cytisine, lupanine, anagyrine) require moderate-high alcohol + 5–10% vinegar. Low therapeutic index — use sparingly.');
END $$;

-- Scotch Broom (quinolizidine alkaloids)
DO $$
BEGIN
  PERFORM herbal.set_menstruum('Cytisus scoparius',
    45, 60, NULL, 10, FALSE,
    '45–60% alcohol + 5–10% vinegar',
    'Primary quinolizidine alkaloids (sparteine, cytisine, lupanine). Minimum 45% alcohol + 5–10% vinegar. Caution: narrow therapeutic index.');
END $$;

-- Barberry (isoquinoline alkaloids; explicitly listed)
DO $$
BEGIN
  PERFORM herbal.set_menstruum('Berberis vulgaris',
    45, 65, NULL, 10, FALSE,
    '45–65% alcohol + 5–10% vinegar',
    'Primary isoquinoline alkaloids (berberine, palmatine, jatrorrhizine, columbamine). Same alkaloid class as goldenseal and Oregon grape. Minimum 45% alcohol + 5–10% vinegar. Root bark tincture. Explicitly listed in class.');
END $$;

-- Silk Tassel bark — plant_part='bark', needs direct SQL
DO $$
DECLARE v_id INTEGER;
BEGIN
  SELECT id INTO v_id FROM herbal.herbs
  WHERE latin_name = 'Garrya elliptica' AND plant_part = 'bark';

  IF v_id IS NULL THEN RAISE NOTICE 'Garrya elliptica bark not found'; RETURN; END IF;

  INSERT INTO herbal.herb_menstruum
    (herb_id, alcohol_pct_min, alcohol_pct_max, glycerin_pct, vinegar_pct, water_effective, primary_label, notes, needs_review)
  VALUES
    (v_id, 45, 65, NULL, 10, FALSE,
     '45–65% alcohol + 5–10% vinegar',
     'Garryfoline and diterpene alkaloids. Minimum 45% alcohol + 5–10% vinegar. Bark tincture. Explicitly listed in class.',
     FALSE)
  ON CONFLICT (herb_id) DO UPDATE SET
    alcohol_pct_min = 45, alcohol_pct_max = 65, vinegar_pct = 10,
    water_effective = FALSE,
    primary_label   = '45–65% alcohol + 5–10% vinegar',
    notes           = 'Garryfoline and diterpene alkaloids. Minimum 45% alcohol + 5–10% vinegar. Bark tincture. Explicitly listed in class.',
    needs_review    = FALSE;
END $$;

-- Silk Tassel fremontii (no plant_part)
DO $$
BEGIN
  PERFORM herbal.set_menstruum('Garrya fremontii',
    45, 65, NULL, 10, FALSE,
    '45–65% alcohol + 5–10% vinegar',
    'Diterpene alkaloids (garryine, garryfoline class). Minimum 45% alcohol + 5–10% vinegar. Bark or leaf tincture. Explicitly listed in class.');
END $$;

-- Corydalis tuber — plant_part='tuber', needs direct SQL
DO $$
DECLARE v_id INTEGER;
BEGIN
  SELECT id INTO v_id FROM herbal.herbs
  WHERE latin_name = 'Corydalis yanhusuo' AND plant_part = 'tuber';

  IF v_id IS NULL THEN RAISE NOTICE 'Corydalis yanhusuo tuber not found'; RETURN; END IF;

  INSERT INTO herbal.herb_menstruum
    (herb_id, alcohol_pct_min, alcohol_pct_max, glycerin_pct, vinegar_pct, water_effective, primary_label, notes, needs_review)
  VALUES
    (v_id, 45, 65, NULL, 10, FALSE,
     '45–65% alcohol + 5–10% vinegar',
     'Isoquinoline alkaloids (dehydrocorydaline, corydaline, tetrahydropalmatine). Minimum 45% alcohol + 5–10% vinegar. Tuber tincture. Explicitly listed in class.',
     FALSE)
  ON CONFLICT (herb_id) DO UPDATE SET
    alcohol_pct_min = 45, alcohol_pct_max = 65, vinegar_pct = 10,
    water_effective = FALSE,
    primary_label   = '45–65% alcohol + 5–10% vinegar',
    notes           = 'Isoquinoline alkaloids (dehydrocorydaline, corydaline, tetrahydropalmatine). Minimum 45% alcohol + 5–10% vinegar. Tuber tincture. Explicitly listed in class.',
    needs_review    = FALSE;
END $$;

-- Bloodroot (benzophenanthridine + isoquinoline alkaloids; explicitly listed as "Blood Root")
DO $$
BEGIN
  PERFORM herbal.set_menstruum('Sanguinaria canadensis',
    50, 65, NULL, 10, FALSE,
    '50–65% alcohol + 5–10% vinegar',
    'Benzophenanthridine alkaloids (sanguinarine, chelerythrine) and isoquinoline alkaloids. Minimum 50% alcohol + 5–10% vinegar. Narrow therapeutic range — use with great care. Explicitly listed in class as Blood Root.');
END $$;

-- Ephedra / Ma Huang (phenethylamine alkaloids; explicitly listed)
DO $$
BEGIN
  PERFORM herbal.set_menstruum('Ephedra sinica',
    45, 65, NULL, 10, TRUE,
    '45–65% alcohol + 5–10% vinegar or water decoction',
    'Phenethylamine alkaloids (ephedrine, pseudoephedrine). Minimum 45% alcohol + 5–10% vinegar. Traditional water decoction also extracts alkaloids. Regulatory restrictions apply; explicit class mention.');
END $$;

-- White Pond Lily rhizome (class lists "Yellow Pond Lily"; closest in DB = Nymphaea odorata)
DO $$
DECLARE v_id INTEGER;
BEGIN
  SELECT id INTO v_id FROM herbal.herbs
  WHERE latin_name = 'Nymphaea odorata' AND plant_part = 'rhizome';

  IF v_id IS NULL THEN RAISE NOTICE 'Nymphaea odorata rhizome not found'; RETURN; END IF;

  INSERT INTO herbal.herb_menstruum
    (herb_id, alcohol_pct_min, alcohol_pct_max, glycerin_pct, vinegar_pct, water_effective, primary_label, notes, needs_review)
  VALUES
    (v_id, 40, 60, NULL, 10, FALSE,
     '40–60% alcohol + 5–10% vinegar',
     'Nymphaea alkaloids and nuphamine-type compounds. Add 5–10% vinegar for alkaloid salt extraction. Rhizome tincture. Class lists Yellow Pond Lily (Nuphar); Nymphaea odorata is the closest in this database.',
     FALSE)
  ON CONFLICT (herb_id) DO UPDATE SET
    alcohol_pct_min = 40, alcohol_pct_max = 60, vinegar_pct = 10,
    water_effective = FALSE,
    primary_label   = '40–60% alcohol + 5–10% vinegar',
    notes           = 'Nymphaea alkaloids and nuphamine-type compounds. Add 5–10% vinegar for alkaloid salt extraction. Rhizome tincture. Class lists Yellow Pond Lily (Nuphar); Nymphaea odorata is the closest in this database.',
    needs_review    = FALSE;
END $$;

-- Celandine (benzophenanthridine + isoquinoline alkaloids — same class as bloodroot/barberry)
DO $$
BEGIN
  PERFORM herbal.set_menstruum('Chelidonium majus',
    45, 65, NULL, 10, FALSE,
    '45–65% alcohol + 5–10% vinegar',
    'Benzophenanthridine alkaloids (chelerythrine, chelidonine, sanguinarine) and isoquinoline alkaloids (berberine, coptisine, protopine). Minimum 45% alcohol + 5–10% vinegar. Use with caution — hepatotoxic in excess.');
END $$;

-- Fumitory (protopine is an isoquinoline alkaloid)
DO $$
BEGIN
  PERFORM herbal.set_menstruum('Fumaria officinalis',
    40, 60, NULL, 10, FALSE,
    '40–60% alcohol + 5–10% vinegar',
    'Isoquinoline alkaloid protopine is primary active. Add 5–10% vinegar for alkaloid salt extraction.');
END $$;

DO $$ BEGIN RAISE NOTICE '144: menstruum update complete.'; END $$;
