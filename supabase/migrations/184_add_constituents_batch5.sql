-- Migration 184: Add general constituents to Aniseed, Goat's Rue,
-- Iceland Moss, Indian Gooseberry, Psyllium, and Solomon's Seal.

SET search_path TO herbal, public;

-- ============================================================
-- Block 1: Aniseed (Pimpinella anisum)
-- Already has: limonene (monoterpene, minor, sort_order 0)
-- anethole already in DB — link only
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('fenchone', 'monoterpenoid ketone',
    'Minor ketone component (~1–3% of volatile oil); distinguishes genuine aniseed from star anise (Illicium verum) in adulteration testing; contributes a bitterish top-note to the aroma profile.');
  PERFORM herbal.ensure_constituent('estragole', 'phenylpropanoid',
    'Also called methyl chavicol; ~2–6% of aniseed volatile oil; a regulated genotoxic concern at high chronic doses per EMA assessment; serves as a safety and adulterant marker alongside anethole.');
  PERFORM herbal.ensure_constituent('pseudoisoeugenol II', 'phenylpropanoid',
    'Principal non-volatile phenylpropanoid of aniseed fruit; demonstrated spasmolytic activity on smooth muscle in vitro (comparable to papaverine); a non-volatile quality-control marker used in EMA/HMPC-referenced aniseed pharmacopoeial assessment.');
  PERFORM herbal.ensure_constituent('anisaldehyde', 'phenylpropanoid aldehyde',
    'Para-methoxybenzaldehyde; ~0.5–2% of volatile oil; antifungal and antimicrobial activity in vitro; GC marker for volatile oil quality control and detection of adulterated oils; contributes characteristic sweetness to the aroma.');
  PERFORM herbal.ensure_constituent('bergapten', 'furanocoumarin',
    'Photoactive furanocoumarin; safety-relevant as a potential photosensitizer and CYP1A2/CYP3A4 modulator; present at trace levels in aniseed; warrants consideration for high-dose preparations and drug interaction screening.');
  PERFORM herbal.ensure_constituent('umbelliferone', 'coumarin',
    '7-Hydroxycoumarin; characteristic coumarin of the Apiaceae family; antispasmodic, anti-inflammatory, and antifungal properties; contributes mild anticoagulant activity at higher doses.');
  PERFORM herbal.ensure_constituent('apiin', 'flavonoid glycoside',
    'Apigenin-7-O-apiosylglucoside; the predominant flavonoid glycoside of aniseed; contributes antioxidant and mild estrogenic activity; the characteristic Apiaceae flavone glycoside used in quality fingerprinting of the herb.');
  PERFORM herbal.ensure_constituent('isoquercitrin', 'flavonoid glycoside',
    'Quercetin-3-O-glucoside; reported in aniseed fruit; contributes to the overall flavonoid antioxidant profile and supports the anti-inflammatory activity relevant to aniseed''s traditional use in respiratory inflammation.');

  PERFORM herbal.link_constituent('Pimpinella anisum', 'anethole',           'primary',  0);
  PERFORM herbal.link_constituent('Pimpinella anisum', 'fenchone',           'minor',    10);
  PERFORM herbal.link_constituent('Pimpinella anisum', 'estragole',          'minor',    20);
  PERFORM herbal.link_constituent('Pimpinella anisum', 'pseudoisoeugenol II','minor',    30);
  PERFORM herbal.link_constituent('Pimpinella anisum', 'anisaldehyde',       'minor',    40);
  PERFORM herbal.link_constituent('Pimpinella anisum', 'bergapten',          'trace',    50);
  PERFORM herbal.link_constituent('Pimpinella anisum', 'umbelliferone',      'minor',    60);
  PERFORM herbal.link_constituent('Pimpinella anisum', 'apiin',              'moderate', 70);
  PERFORM herbal.link_constituent('Pimpinella anisum', 'isoquercitrin',      'minor',    80);

  RAISE NOTICE 'Added constituents to Aniseed (Pimpinella anisum)';
END $$;

-- ============================================================
-- Block 2: Goat's Rue (Galega officinalis)
-- Already has: kaempferol (flavonol, moderate, sort_order implied)
-- quercetin, rutin, luteolin, chlorogenic acid, beta-sitosterol already in DB
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('galegine', 'guanidine alkaloid',
    'Defining alkaloid of G. officinalis (isoprenyl guanidine); directly inspired the synthesis of metformin, the world''s most prescribed antidiabetic drug. Lowers blood glucose via AMPK activation and inhibition of hepatic glucose production; responsible for historical livestock poisoning and the primary safety concern of the plant.');
  PERFORM herbal.ensure_constituent('4-hydroxygalegine', 'guanidine alkaloid',
    'Hydroxylated analogue co-occurring with galegine in aerial parts; contributes to the overall guanidine alkaloid burden; less potent than galegine but relevant for total alkaloid content assay and toxicological profiling.');

  PERFORM herbal.link_constituent('Galega officinalis', 'galegine',       'major',    0);
  PERFORM herbal.link_constituent('Galega officinalis', '4-hydroxygalegine','minor',  10);
  PERFORM herbal.link_constituent('Galega officinalis', 'quercetin',      'moderate', 20);
  PERFORM herbal.link_constituent('Galega officinalis', 'rutin',          'major',    30);
  PERFORM herbal.link_constituent('Galega officinalis', 'luteolin',       'minor',    40);
  PERFORM herbal.link_constituent('Galega officinalis', 'chlorogenic acid','minor',   60);
  PERFORM herbal.link_constituent('Galega officinalis', 'beta-sitosterol', 'minor',   70);

  RAISE NOTICE 'Added constituents to Goat''s Rue (Galega officinalis)';
END $$;

-- ============================================================
-- Block 3: Iceland Moss (Cetraria islandica)
-- Already has: polysaccharides (generic, major, sort_order 10)
-- usnic acid and protocetraric acid already in DB (created in mig 182/183)
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('lichenin', 'beta-glucan polysaccharide',
    'Mixed-linkage (1→3)/(1→4)-beta-D-glucan; 40–50% dry weight — the dominant constituent of the thallus. The defining demulcent compound: forms protective mucilaginous gel on respiratory and GI mucosa. European Pharmacopoeia identity marker and primary standardization target for Cetraria preparations.');
  PERFORM herbal.ensure_constituent('isolichenin', 'alpha-glucan polysaccharide',
    'Mixed-linkage (1→3)/(1→4)-alpha-D-glucan; 10–20% dry weight; immunostimulant via macrophage activation. Together with lichenin the two glucans authenticate genuine C. islandica; structurally distinct from lichenin by anomeric configuration.');
  PERFORM herbal.ensure_constituent('fumarprotocetraric acid', 'depsidone',
    'Dominant depsidone of the thallus (1–3% dry weight); primary antibacterial compound active against Gram-positive bacteria and acid-fast organisms including Mycobacterium; bitter taste receptor agonist contributing to the orexigenic effect; anti-inflammatory. Key standardization compound alongside lichenin.');
  PERFORM herbal.ensure_constituent('cetraric acid', 'depside',
    'Key ortho-depside bitter principle (0.5–2% dry weight); orexigenic/appetite-stimulating; antimicrobial against Staphylococcus and M. tuberculosis; anti-inflammatory via COX inhibition. The characteristic Cetraria chemotaxonomic marker giving the genus its name.');
  PERFORM herbal.ensure_constituent('protolichesterinic acid', 'lactone fatty acid',
    'Unique aliphatic alpha-methylene-gamma-butyrolactone (1–2%); potent 5-lipoxygenase inhibitor providing an anti-inflammatory mechanism distinct from the depsidones; antitumor and antiviral (HIV-1) activity in vitro. A pharmacologically distinctive minor constituent of the lichen.');

  PERFORM herbal.link_constituent('Cetraria islandica', 'lichenin',               'primary',  0);
  PERFORM herbal.link_constituent('Cetraria islandica', 'isolichenin',            'major',    20);
  PERFORM herbal.link_constituent('Cetraria islandica', 'fumarprotocetraric acid','major',    30);
  PERFORM herbal.link_constituent('Cetraria islandica', 'cetraric acid',          'major',    40);
  PERFORM herbal.link_constituent('Cetraria islandica', 'protolichesterinic acid','moderate', 50);
  PERFORM herbal.link_constituent('Cetraria islandica', 'usnic acid',             'moderate', 60);
  PERFORM herbal.link_constituent('Cetraria islandica', 'protocetraric acid',     'moderate', 70);

  RAISE NOTICE 'Added constituents to Iceland Moss (Cetraria islandica)';
END $$;

-- ============================================================
-- Block 4: Indian Gooseberry / Amla (Phyllanthus emblica)
-- Already has: ellagitannins (generic, major, sort_order 10)
-- gallic acid, ellagic acid, vitamin C, quercetin, kaempferol, rutin already in DB
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('emblicanin A', 'hydrolyzable tannin',
    'Pedunculagin-based ellagitannin unique to P. emblica (~1–2% dry weight); the primary species-specific marker compound. Antioxidant activity comparable to vitamin C; hepatoprotective and cardioprotective. Primary standardization target for authenticated amla extracts.');
  PERFORM herbal.ensure_constituent('emblicanin B', 'hydrolyzable tannin',
    'Partner to emblicanin A with an additional galloyl group; also unique to P. emblica; equipotent antioxidant. Together the two emblicanins define the amla tannin fingerprint for species authentication and quality control.');
  PERFORM herbal.ensure_constituent('punicalin', 'hydrolyzable tannin',
    'Major co-ellagitannin of amla fruit; 4,6-linked glucose core with ellagic and gallic acid moieties; antioxidant, anti-inflammatory (NF-κB inhibition), antiviral, and antitumor activity.');
  PERFORM herbal.ensure_constituent('pedunculagin', 'hydrolyzable tannin',
    'Bis-HHDP-glucose ellagitannin; biosynthetic precursor-type in the amla tannin series; antioxidant and immunomodulatory; contributes to the broad radical-scavenging capacity of the whole fruit.');
  PERFORM herbal.ensure_constituent('phyllemblin', 'phenolic acid derivative',
    'Methyl ester derivative of an ellagic acid scaffold; characteristic small-molecule P. emblica marker; cytotoxic and antimicrobial activity; further distinguishes the amla chemical fingerprint from other Phyllanthus species.');

  PERFORM herbal.link_constituent('Phyllanthus emblica', 'emblicanin A',   'primary',  0);
  PERFORM herbal.link_constituent('Phyllanthus emblica', 'emblicanin B',   'primary',  20);
  PERFORM herbal.link_constituent('Phyllanthus emblica', 'punicalin',      'major',    30);
  PERFORM herbal.link_constituent('Phyllanthus emblica', 'pedunculagin',   'major',    40);
  PERFORM herbal.link_constituent('Phyllanthus emblica', 'gallic acid',    'major',    50);
  PERFORM herbal.link_constituent('Phyllanthus emblica', 'ellagic acid',   'major',    60);
  PERFORM herbal.link_constituent('Phyllanthus emblica', 'phyllemblin',    'moderate', 70);
  PERFORM herbal.link_constituent('Phyllanthus emblica', 'vitamin C',      'moderate', 80);
  PERFORM herbal.link_constituent('Phyllanthus emblica', 'quercetin',      'minor',    90);
  PERFORM herbal.link_constituent('Phyllanthus emblica', 'kaempferol',     'minor',    100);
  PERFORM herbal.link_constituent('Phyllanthus emblica', 'rutin',          'minor',    110);

  RAISE NOTICE 'Added constituents to Indian Gooseberry / Amla (Phyllanthus emblica)';
END $$;

-- ============================================================
-- Block 5: Psyllium (Plantago ovata) — seed husk
-- Already has: aucubin (iridoid glycoside, minor)
-- verbascoside already in DB
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('arabinoxylan', 'polysaccharide',
    'The defining constituent of psyllium husk (isabgol); a highly branched (1→4)-beta-D-xylan with arabinose side chains. Responsible for characteristic gel-forming and swelling behaviour per Ph. Eur. swelling factor test. Basis for FDA-approved cardiovascular health claims; reduces LDL-cholesterol and slows postprandial glucose absorption. Primary standardization compound.');
  PERFORM herbal.ensure_constituent('psyllium seed protein', 'plant protein',
    '14 kDa albumin-type glycoprotein fraction; the allergenic constituent responsible for IgE-mediated occupational asthma and anaphylaxis reported in healthcare workers handling psyllium powder. Clinically important for allergy risk counselling and contraindication screening; recognised in pharmacopoeial monographs.');
  PERFORM herbal.ensure_constituent('plantamajoside', 'phenylethanoid glycoside',
    'Characteristic caffeic acid ester phenylethanoid glycoside of Plantago species; anti-inflammatory, antioxidant, and mild analgesic activity in preclinical studies; present at low but detectable levels in the seed and husk.');

  PERFORM herbal.link_constituent('Plantago ovata', 'arabinoxylan',       'primary',  0);
  PERFORM herbal.link_constituent('Plantago ovata', 'psyllium seed protein','minor',  30);
  PERFORM herbal.link_constituent('Plantago ovata', 'plantamajoside',     'minor',    50);
  PERFORM herbal.link_constituent('Plantago ovata', 'verbascoside',       'minor',    60);

  RAISE NOTICE 'Added constituents to Psyllium (Plantago ovata)';
END $$;

-- ============================================================
-- Block 6: Solomon's Seal (Polygonatum biflorum)
-- Already has: diosgenin (steroidal saponin aglycone, major)
-- allantoin already in DB
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('Polygonatum fructans', 'fructooligosaccharide polysaccharide',
    'Inulin-type fructooligosaccharide polysaccharides characteristic of Polygonatum rhizomes; prebiotic, immunomodulatory (macrophage activation), and hypoglycaemic activity in vivo; increasingly recognised alongside saponins as a primary bioactive fraction of the genus.');
  PERFORM herbal.ensure_constituent('polygonatin', 'steroidal saponin',
    'Principal spirostanol saponin of P. biflorum; built on the diosgenin aglycone; adaptogenic, anti-inflammatory, and blood-glucose-modulating activity in preclinical models. A key marker compound for Polygonatum quality assessment.');
  PERFORM herbal.ensure_constituent('sibiricoside A', 'steroidal saponin',
    'Furostanol saponin (biosynthetic precursor form of spirostanol saponins); co-occurring with polygonatin in the rhizome; immunomodulatory and anti-fatigue properties in rodent studies; characteristic of the Polygonatum genus rhizome.');
  PERFORM herbal.ensure_constituent('Polygonatum biflorum agglutinin', 'lectin',
    'PBA; mannose-binding lectin isolated from P. biflorum rhizomes; immunomodulatory, antiviral (HIV reverse transcriptase inhibition), and mitogenic activity in vitro. Lectins are heat-labile and may be partially inactivated in processed preparations; contribute to the adaptogenic properties of the rhizome.');
  PERFORM herbal.ensure_constituent('homoisoflavonoids', 'homoisoflavonoid',
    'Characteristic 3-benzylchroman-4-one type flavonoids (e.g., 5,7-dihydroxy-3-(4-hydroxybenzyl)-6-methylchroman-4-one) found in Polygonatum species; anti-inflammatory and antiproliferative activity; chemotaxonomic markers for the Polygonatum genus not widely found in other herb families.');

  PERFORM herbal.link_constituent('Polygonatum biflorum', 'Polygonatum fructans',        'primary',  0);
  PERFORM herbal.link_constituent('Polygonatum biflorum', 'polygonatin',                 'major',    10);
  PERFORM herbal.link_constituent('Polygonatum biflorum', 'sibiricoside A',              'moderate', 20);
  PERFORM herbal.link_constituent('Polygonatum biflorum', 'allantoin',                   'moderate', 30);
  PERFORM herbal.link_constituent('Polygonatum biflorum', 'Polygonatum biflorum agglutinin','moderate',40);
  PERFORM herbal.link_constituent('Polygonatum biflorum', 'homoisoflavonoids',           'minor',    60);

  RAISE NOTICE 'Added constituents to Solomon''s Seal (Polygonatum biflorum)';
END $$;
