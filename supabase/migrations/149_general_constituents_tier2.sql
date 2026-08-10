SET search_path TO herbal, public;

-- Migration 149: Adds new class-level constituent entries to herbal.constituents,
-- then links them (and existing class-level ones) to 44 herbs that have
-- constituent_profiles data but no matching shared constituents.

-- ============================================================
-- STEP 1 — Add new class-level constituents
-- ============================================================

DO $$
BEGIN
  PERFORM herbal.ensure_constituent(
    'iridoid glycosides', 'iridoid glycoside',
    'Cyclopentanoid monoterpene glycosides; characteristically bitter; anti-inflammatory and hepatoprotective properties.'
  );
  PERFORM herbal.ensure_constituent(
    'cardiac glycosides', 'cardiac glycoside',
    'Steroidal glycosides that increase cardiac contractility; found in Digitalis, Urginea, and Euonymus spp.'
  );
  PERFORM herbal.ensure_constituent(
    'phytosterols', 'phytosterol',
    'Plant sterols structurally similar to cholesterol; reduce cholesterol absorption; anti-inflammatory.'
  );
  PERFORM herbal.ensure_constituent(
    'anthraquinones', 'anthraquinone',
    'Quinone pigments with stimulant laxative and antimicrobial properties.'
  );
  PERFORM herbal.ensure_constituent(
    'lignans', 'lignan',
    'Phenylpropanoid dimers with antioxidant, phytoestrogenic, and adaptogenic properties.'
  );
  PERFORM herbal.ensure_constituent(
    'diterpenoids', 'diterpenoid',
    'C20 terpenoids with diverse biological activities including anti-inflammatory and adaptogenic effects.'
  );
  PERFORM herbal.ensure_constituent(
    'sesquiterpenes', 'sesquiterpene',
    'C15 terpenoids common in essential oils; anti-inflammatory and antimicrobial.'
  );
  PERFORM herbal.ensure_constituent(
    'anthocyanins', 'anthocyanin',
    'Water-soluble flavonoid pigments responsible for red/purple/blue colors; potent antioxidants.'
  );
  PERFORM herbal.ensure_constituent(
    'coumarins', 'coumarin',
    'Benzopyrone compounds with anticoagulant, antispasmodic, and anti-inflammatory properties.'
  );
  PERFORM herbal.ensure_constituent(
    'glucosinolates', 'glucosinolate',
    'Sulfur-containing glycosides yielding bioactive isothiocyanates on hydrolysis; found in Brassicaceae.'
  );
  PERFORM herbal.ensure_constituent(
    'phenylpropanoids', 'phenylpropanoid',
    'Aromatic compounds derived from phenylalanine; include rosavins, hydroxycinnamic acids, and aromatic esters.'
  );
  PERFORM herbal.ensure_constituent(
    'usnic acid', 'depsidone',
    'Lichen-specific depsidone with antimicrobial, antiviral, and anti-inflammatory activity.'
  );

  RAISE NOTICE 'Step 1 complete: 12 new class-level constituents ensured.';
END $$;

-- ============================================================
-- STEP 2 — Link constituents to herbs
-- ============================================================

-- American Ginseng
DO $$
BEGIN
  PERFORM herbal.link_constituent('Panax quinquefolius', 'triterpenoid saponins', 'major', 10);
  RAISE NOTICE 'American Ginseng constituents linked.';
END $$;

-- Asian Devil''s Club
DO $$
BEGIN
  PERFORM herbal.link_constituent('Oplopanax elatus', 'polyacetylenes', 'major', 10);
  RAISE NOTICE 'Asian Devil''s Club constituents linked.';
END $$;

-- Balsam Of Peru
DO $$
BEGIN
  PERFORM herbal.link_constituent('Myroxylon balsamum var. pereirae', 'resins',           'major',    10);
  PERFORM herbal.link_constituent('Myroxylon balsamum var. pereirae', 'phenylpropanoids', 'moderate', 20);
  RAISE NOTICE 'Balsam Of Peru constituents linked.';
END $$;

-- Benzoin
DO $$
BEGIN
  PERFORM herbal.link_constituent('Styrax benzoin', 'resins', 'major', 10);
  RAISE NOTICE 'Benzoin constituents linked.';
END $$;

-- Blue Cohosh
DO $$
BEGIN
  PERFORM herbal.link_constituent('Caulophyllum thalictroides', 'triterpenoid saponins', 'major',    10);
  PERFORM herbal.link_constituent('Caulophyllum thalictroides', 'alkaloids',             'moderate', 20);
  RAISE NOTICE 'Blue Cohosh constituents linked.';
END $$;

-- Blue Flag
DO $$
BEGIN
  PERFORM herbal.link_constituent('Iris versicolor', 'iridoid glycosides', 'moderate', 10);
  PERFORM herbal.link_constituent('Iris versicolor', 'flavonoids',         'minor',    20);
  RAISE NOTICE 'Blue Flag constituents linked.';
END $$;

-- Bupleurum
DO $$
BEGIN
  PERFORM herbal.link_constituent('Bupleurum chinense', 'triterpenoid saponins', 'major', 10);
  RAISE NOTICE 'Bupleurum constituents linked.';
END $$;

-- Caper Spurge
DO $$
BEGIN
  PERFORM herbal.link_constituent('Euphorbia lathyris', 'diterpenoids', 'major', 10);
  RAISE NOTICE 'Caper Spurge constituents linked.';
END $$;

-- Coleus
DO $$
BEGIN
  PERFORM herbal.link_constituent('Coleus forskohlii', 'diterpenoids', 'major', 10);
  RAISE NOTICE 'Coleus constituents linked.';
END $$;

-- Condurango
DO $$
BEGIN
  PERFORM herbal.link_constituent('Marsdenia condurango', 'steroidal saponins', 'major', 10);
  RAISE NOTICE 'Condurango constituents linked.';
END $$;

-- Dang Shen
DO $$
BEGIN
  PERFORM herbal.link_constituent('Codonoposis pilosula', 'polyacetylenes', 'major', 10);
  PERFORM herbal.link_constituent('Codonoposis pilosula', 'polysaccharides', 'major', 20);
  RAISE NOTICE 'Dang Shen constituents linked.';
END $$;

-- Devil''s Club
DO $$
BEGIN
  PERFORM herbal.link_constituent('Oplopanax horridus', 'polyacetylenes', 'major', 10);
  RAISE NOTICE 'Devil''s Club constituents linked.';
END $$;

-- Flax
DO $$
BEGIN
  PERFORM herbal.link_constituent('Linum usitatissimum', 'lignans',         'major',    10);
  PERFORM herbal.link_constituent('Linum usitatissimum', 'polysaccharides', 'moderate', 20);
  RAISE NOTICE 'Flax constituents linked.';
END $$;

-- Fringetree
DO $$
BEGIN
  PERFORM herbal.link_constituent('Chionanthus virginicus', 'iridoid glycosides', 'major',    10);
  PERFORM herbal.link_constituent('Chionanthus virginicus', 'lignans',            'moderate', 20);
  RAISE NOTICE 'Fringetree constituents linked.';
END $$;

-- Guggul
DO $$
BEGIN
  PERFORM herbal.link_constituent('Commiphora mukul', 'resins',        'major', 10);
  PERFORM herbal.link_constituent('Commiphora mukul', 'phytosterols',  'minor', 20);
  PERFORM herbal.link_constituent('Commiphora mukul', 'sesquiterpenes','minor', 30);
  RAISE NOTICE 'Guggul constituents linked.';
END $$;

-- Gumweed
DO $$
BEGIN
  PERFORM herbal.link_constituent('Grindelia camporum', 'resins',       'major',    10);
  PERFORM herbal.link_constituent('Grindelia camporum', 'diterpenoids', 'moderate', 20);
  RAISE NOTICE 'Gumweed constituents linked.';
END $$;

-- Heartsease
DO $$
BEGIN
  PERFORM herbal.link_constituent('Viola tricolor', 'anthocyanins', 'major',    10);
  PERFORM herbal.link_constituent('Viola tricolor', 'flavonoids',   'moderate', 20);
  RAISE NOTICE 'Heartsease constituents linked.';
END $$;

-- Helichrysum
DO $$
BEGIN
  PERFORM herbal.link_constituent('Helichrysum italicum', 'flavonoids',    'major',    10);
  PERFORM herbal.link_constituent('Helichrysum italicum', 'sesquiterpenes','moderate', 20);
  RAISE NOTICE 'Helichrysum constituents linked.';
END $$;

-- Hydrangea
DO $$
BEGIN
  PERFORM herbal.link_constituent('Hydrangea arborescens', 'coumarins', 'major', 10);
  RAISE NOTICE 'Hydrangea constituents linked.';
END $$;

-- Iceland Moss
DO $$
BEGIN
  PERFORM herbal.link_constituent('Cetraria islandica', 'polysaccharides', 'major', 10);
  RAISE NOTICE 'Iceland Moss constituents linked.';
END $$;

-- Indian Gooseberry
DO $$
BEGIN
  PERFORM herbal.link_constituent('Phyllanthus emblica', 'ellagitannins', 'major', 10);
  RAISE NOTICE 'Indian Gooseberry constituents linked.';
END $$;

-- Ipecac
DO $$
BEGIN
  PERFORM herbal.link_constituent('Cephaelis ipecacuanha', 'alkaloids', 'major', 10);
  RAISE NOTICE 'Ipecac constituents linked.';
END $$;

-- Irish Moss
DO $$
BEGIN
  PERFORM herbal.link_constituent('Chondrus crispus', 'polysaccharides', 'major', 10);
  RAISE NOTICE 'Irish Moss constituents linked.';
END $$;

-- Khella
DO $$
BEGIN
  PERFORM herbal.link_constituent('Ammi visnaga', 'coumarins', 'major', 10);
  RAISE NOTICE 'Khella constituents linked.';
END $$;

-- Kutki
DO $$
BEGIN
  PERFORM herbal.link_constituent('Picrorrhiza kurroa', 'iridoid glycosides', 'major', 10);
  RAISE NOTICE 'Kutki constituents linked.';
END $$;

-- Lesser Periwinkle
DO $$
BEGIN
  PERFORM herbal.link_constituent('Vinca minor', 'alkaloids', 'major', 10);
  RAISE NOTICE 'Lesser Periwinkle constituents linked.';
END $$;

-- Life Root
DO $$
BEGIN
  PERFORM herbal.link_constituent('Senecio aureus', 'pyrrolizidine alkaloids', 'major', 10);
  RAISE NOTICE 'Life Root constituents linked.';
END $$;

-- Maca
DO $$
BEGIN
  PERFORM herbal.link_constituent('Lepidium meyenii', 'glucosinolates', 'major', 10);
  PERFORM herbal.link_constituent('Lepidium meyenii', 'phytosterols',   'minor', 20);
  RAISE NOTICE 'Maca constituents linked.';
END $$;

-- Madder
DO $$
BEGIN
  PERFORM herbal.link_constituent('Rubia tinctorum', 'anthraquinones', 'major', 10);
  RAISE NOTICE 'Madder constituents linked.';
END $$;

-- Poppy
DO $$
BEGIN
  PERFORM herbal.link_constituent('Papaver spp.', 'alkaloids', 'major', 10);
  RAISE NOTICE 'Poppy constituents linked.';
END $$;

-- Pumpkin
DO $$
BEGIN
  PERFORM herbal.link_constituent('Cucurbita pepo', 'phytosterols', 'moderate', 10);
  RAISE NOTICE 'Pumpkin constituents linked.';
END $$;

-- Rhodiola
DO $$
BEGIN
  PERFORM herbal.link_constituent('Rhodiola rosea', 'phenylpropanoids', 'major', 10);
  RAISE NOTICE 'Rhodiola constituents linked.';
END $$;

-- Sandalwood
DO $$
BEGIN
  PERFORM herbal.link_constituent('Santalum album', 'sesquiterpenes', 'major', 10);
  RAISE NOTICE 'Sandalwood constituents linked.';
END $$;

-- Seneca Snakeroot
DO $$
BEGIN
  PERFORM herbal.link_constituent('Polygala senega', 'triterpenoid saponins', 'major', 10);
  RAISE NOTICE 'Seneca Snakeroot constituents linked.';
END $$;

-- Silk Tassel
DO $$
BEGIN
  PERFORM herbal.link_constituent('Garrya elliptica', 'iridoid glycosides', 'major', 10);
  RAISE NOTICE 'Silk Tassel constituents linked.';
END $$;

-- Squill
DO $$
BEGIN
  PERFORM herbal.link_constituent('Urginea maritima', 'cardiac glycosides', 'major', 10);
  RAISE NOTICE 'Squill constituents linked.';
END $$;

-- Tolu Balsam
DO $$
BEGIN
  PERFORM herbal.link_constituent('Myroxylon balsamum var. balsamum', 'resins',           'major',    10);
  PERFORM herbal.link_constituent('Myroxylon balsamum var. balsamum', 'phenylpropanoids', 'moderate', 20);
  RAISE NOTICE 'Tolu Balsam constituents linked.';
END $$;

-- Usnea
DO $$
BEGIN
  PERFORM herbal.link_constituent('Usnea spp.', 'usnic acid', 'major', 10);
  RAISE NOTICE 'Usnea constituents linked.';
END $$;

-- Wahoo
DO $$
BEGIN
  PERFORM herbal.link_constituent('Euonymus atropurpureus', 'cardiac glycosides', 'major', 10);
  RAISE NOTICE 'Wahoo constituents linked.';
END $$;

-- Western Coltsfoot
DO $$
BEGIN
  PERFORM herbal.link_constituent('Petasites palmatus', 'pyrrolizidine alkaloids', 'major', 10);
  PERFORM herbal.link_constituent('Petasites palmatus', 'sesquiterpenes',          'minor', 20);
  RAISE NOTICE 'Western Coltsfoot constituents linked.';
END $$;

-- White Peony
DO $$
BEGIN
  PERFORM herbal.link_constituent('Paeonia lactiflora', 'iridoid glycosides', 'moderate', 10);
  PERFORM herbal.link_constituent('Paeonia lactiflora', 'phenylpropanoids',   'minor',    20);
  RAISE NOTICE 'White Peony constituents linked.';
END $$;

-- Wu Jia Pi
DO $$
BEGIN
  PERFORM herbal.link_constituent('Acanthopanax sessiliflorum', 'lignans', 'major', 10);
  RAISE NOTICE 'Wu Jia Pi constituents linked.';
END $$;

-- Yohimbe
DO $$
BEGIN
  PERFORM herbal.link_constituent('Pausinystalia johimbe', 'alkaloids', 'major', 10);
  RAISE NOTICE 'Yohimbe constituents linked.';
END $$;

-- Yucca
DO $$
BEGIN
  PERFORM herbal.link_constituent('Yucca spp.', 'steroidal saponins', 'major', 10);
  RAISE NOTICE 'Yucca constituents linked.';
END $$;
