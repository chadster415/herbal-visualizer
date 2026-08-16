-- Migration 183: Fix Usnea linking (migration 182 used wrong latin name),
-- then add general constituents to Coleus, Evening Primrose, Irish Moss,
-- Kelp, Shiitake, and Birch.

SET search_path TO herbal, public;

-- ============================================================
-- Block 1: Fix Usnea constituent links
-- Migration 182 created constituents via ensure_constituent but called
-- link_constituent with 'Usnea barbata', which does not exist in the DB.
-- The herb is stored as 'Usnea spp.' (id=112). Re-link everything here.
-- Already has: usnic acid (sort_order 10)
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.link_constituent('Usnea spp.', 'diffractaic acid',  'major',    20);
  PERFORM herbal.link_constituent('Usnea spp.', 'atranorin',         'major',    30);
  PERFORM herbal.link_constituent('Usnea spp.', 'beta-glucans',      'major',    40);
  PERFORM herbal.link_constituent('Usnea spp.', 'salazinic acid',    'moderate', 50);
  PERFORM herbal.link_constituent('Usnea spp.', 'norstictic acid',   'moderate', 60);
  PERFORM herbal.link_constituent('Usnea spp.', 'barbatic acid',     'moderate', 70);
  PERFORM herbal.link_constituent('Usnea spp.', 'protocetraric acid','moderate', 80);

  RAISE NOTICE 'Fixed Usnea constituent links (Usnea spp., id=112)';
END $$;

-- ============================================================
-- Block 2: Coleus (Coleus forskohlii)
-- Already has: diterpenoids (generic, major, sort_order 10)
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('forskolin', 'labdane diterpenoid',
    'Defining marker compound (= colforsin); directly activates adenylate cyclase at its catalytic C1 subunit, elevating intracellular cAMP independently of receptor stimulation. Basis for all major applications: glaucoma, asthma, heart failure, weight management. Extract standardized to 10–40% forskolin.');
  PERFORM herbal.ensure_constituent('1-deoxyforskolin', 'labdane diterpenoid',
    'Most abundant labdane analogue in the root, often exceeding forskolin itself by mass; lacks the C1 acetoxy group required for adenylate cyclase activation; used as a reference compound in HPLC profiling of authentic C. forskohlii.');
  PERFORM herbal.ensure_constituent('9-deoxyforskolin', 'labdane diterpenoid',
    'Major labdane analogue deoxy at C9; used alongside 1-deoxyforskolin as a chemotaxonomic marker for species authentication; minor pharmacological activity relative to forskolin.');
  PERFORM herbal.ensure_constituent('coleonol', 'labdane diterpenoid',
    'Structurally close forskolin analogue (historically synonymous in early literature); distinct stereochemical configuration; included in the minor diterpenoid fraction of standardized root extracts.');
  PERFORM herbal.ensure_constituent('1,9-dideoxyforskolin', 'labdane diterpenoid',
    'Deoxy at both C1 and C9; characteristic species marker used to confirm authentic plant material versus adulteration; inactive at adenylate cyclase.');

  PERFORM herbal.link_constituent('Coleus forskohlii', 'forskolin',           'primary',  0);
  PERFORM herbal.link_constituent('Coleus forskohlii', '1-deoxyforskolin',    'major',    20);
  PERFORM herbal.link_constituent('Coleus forskohlii', '9-deoxyforskolin',    'major',    30);
  PERFORM herbal.link_constituent('Coleus forskohlii', 'coleonol',            'moderate', 40);
  PERFORM herbal.link_constituent('Coleus forskohlii', '1,9-dideoxyforskolin','moderate', 50);
  PERFORM herbal.link_constituent('Coleus forskohlii', 'rosmarinic acid',     'moderate', 60);
  PERFORM herbal.link_constituent('Coleus forskohlii', 'luteolin',            'minor',    70);
  PERFORM herbal.link_constituent('Coleus forskohlii', 'apigenin',            'minor',    80);
  PERFORM herbal.link_constituent('Coleus forskohlii', 'beta-sitosterol',     'minor',    90);

  RAISE NOTICE 'Added constituents to Coleus (Coleus forskohlii)';
END $$;

-- ============================================================
-- Block 3: Evening Primrose (Oenothera biennis)
-- Already has: linoleic acid (omega-6 fatty acid, major, sort_order 0)
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('oleic acid', 'omega-9 fatty acid',
    'Second most abundant fatty acid in EPO seed oil (~6–11%); monounsaturated; contributes to oil stability and membrane fluidity; mild anti-inflammatory via competitive effects on arachidonic acid pathways.');
  PERFORM herbal.ensure_constituent('palmitic acid', 'saturated fatty acid',
    'Principal saturated fatty acid of EPO oil (~6–8%); structural membrane component; present as the saturated reference fraction in pharmacopoeial fatty acid profiling by GC.');
  PERFORM herbal.ensure_constituent('stearic acid', 'saturated fatty acid',
    'Minor saturated fatty acid (~1.5–2% of EPO oil); rapidly desaturated to oleic acid in vivo; required for full EPO fatty acid characterization and pharmacopoeial identity testing.');
  PERFORM herbal.ensure_constituent('oenothein B', 'macrocyclic ellagitannin',
    'Characteristic non-oil constituent of evening primrose seed; dimeric macrocyclic hydrolyzable tannin; immunomodulatory (macrophage activation), anti-aromatase (inhibits estrogen biosynthesis), and antioxidant. Biochemically distinguishes EPO from most other seed oils.');
  PERFORM herbal.ensure_constituent('gamma-tocopherol', 'tocopherol',
    'Predominant tocopherol in EPO (~400–700 mg/kg oil), with gamma exceeding alpha — an unusual ratio characteristic of EPO; gamma-tocopherol scavenges reactive nitrogen species more efficiently than alpha, providing superior anti-inflammatory and lipid-protecting activity.');
  PERFORM herbal.ensure_constituent('campesterol', 'phytosterol',
    'Second phytosterol of EPO seed alongside beta-sitosterol; part of the characteristic sterol fingerprint used in pharmacopoeial identity testing; minor anti-inflammatory and anti-proliferative activity.');

  PERFORM herbal.link_constituent('Oenothera biennis', 'gamma-linolenic acid', 'primary',  10);
  PERFORM herbal.link_constituent('Oenothera biennis', 'oleic acid',           'major',    20);
  PERFORM herbal.link_constituent('Oenothera biennis', 'palmitic acid',        'major',    30);
  PERFORM herbal.link_constituent('Oenothera biennis', 'stearic acid',         'moderate', 40);
  PERFORM herbal.link_constituent('Oenothera biennis', 'oenothein B',          'moderate', 50);
  PERFORM herbal.link_constituent('Oenothera biennis', 'gamma-tocopherol',     'moderate', 60);
  PERFORM herbal.link_constituent('Oenothera biennis', 'beta-sitosterol',      'moderate', 70);
  PERFORM herbal.link_constituent('Oenothera biennis', 'campesterol',          'minor',    80);

  RAISE NOTICE 'Added constituents to Evening Primrose (Oenothera biennis)';
END $$;

-- ============================================================
-- Block 4: Irish Moss (Chondrus crispus)
-- Already has: polysaccharides (generic, major, sort_order 10)
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('kappa-carrageenan', 'sulfated polysaccharide',
    'The defining marker constituent of Irish moss; linear sulfated galactan (one sulfate per disaccharide); gels in the presence of potassium ions; immunostimulant, antiviral (blocks viral attachment to host cells), and anticoagulant activity; primary standardization target for commercial carrageenan extracts.');
  PERFORM herbal.ensure_constituent('lambda-carrageenan', 'sulfated polysaccharide',
    'Co-occurring carrageenan type with three sulfate groups per disaccharide; highest charge density of the carrageenan series; does not gel; potent anticoagulant and anti-inflammatory (COX inhibition); predominates in the gametophyte life-cycle phase.');
  PERFORM herbal.ensure_constituent('iota-carrageenan', 'sulfated polysaccharide',
    'Third carrageenan type; intermediate sulfation (two sulfates per disaccharide); forms elastic, calcium-dependent gels; antiviral activity; licensed as an over-the-counter nasal spray for rhinovirus and SARS-CoV-2 prevention.');
  PERFORM herbal.ensure_constituent('floridoside', 'glycoside',
    'Primary low-molecular-weight osmolyte of red algae; 2-O-(α-D-galactopyranosyl)-glycerol; one of the most concentrated small molecules in the Chondrus thallus; potent antioxidant and cytoprotective activity; accumulates under osmotic and thermal stress.');
  PERFORM herbal.ensure_constituent('phycoerythrin', 'phycobiliprotein',
    'Red photosynthetic antenna protein (R-phycoerythrin predominates in Chondrus); responsible for the thallus red pigmentation; potent antioxidant and fluorescent properties; anti-inflammatory and cytotoxic activity in vitro.');
  PERFORM herbal.ensure_constituent('phloroglucinol', 'phenolic',
    'Simple polyhydroxyphenol (1,3,5-trihydroxybenzene); antioxidant, antibacterial, and antispasmodic; the monomeric building block of condensed phlorotannin polymers in marine algae; present in the phenolic fraction of the thallus.');
  PERFORM herbal.ensure_constituent('fucosterol', 'phytosterol',
    'Primary sterol of brown and some red algae; 24-ethylidene cholesterol; anti-diabetic (alpha-glucosidase and PTP1B inhibition), anti-obesity, anti-inflammatory, and antioxidant; characteristic marker sterol of marine algae, distinguishing them from terrestrial plants.');

  PERFORM herbal.link_constituent('Chondrus crispus', 'kappa-carrageenan', 'primary',  0);
  PERFORM herbal.link_constituent('Chondrus crispus', 'lambda-carrageenan','primary',  20);
  PERFORM herbal.link_constituent('Chondrus crispus', 'iota-carrageenan',  'major',    30);
  PERFORM herbal.link_constituent('Chondrus crispus', 'floridoside',       'major',    40);
  PERFORM herbal.link_constituent('Chondrus crispus', 'phycoerythrin',     'major',    50);
  PERFORM herbal.link_constituent('Chondrus crispus', 'phloroglucinol',    'minor',    60);
  PERFORM herbal.link_constituent('Chondrus crispus', 'fucosterol',        'minor',    70);

  RAISE NOTICE 'Added constituents to Irish Moss (Chondrus crispus)';
END $$;

-- ============================================================
-- Block 5: Kelp / Bladderwrack (Fucus vesiculosus)
-- Already has: alginic acid (polysaccharide, major, sort_order 0)
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('fucoidan', 'sulfated polysaccharide',
    'The defining marker compound of Fucus and most Fucaceae; sulfated L-fucose polymer (4–20% dry weight, varies seasonally); antiviral (blocks viral entry via heparan sulfate mimicry), anticoagulant, antitumour (P-selectin inhibition, NK cell activation), anti-inflammatory, and antiangiogenic; primary standardization target.');
  PERFORM herbal.ensure_constituent('iodine', 'mineral',
    'Highest iodine content of any commonly used herbal medicine (100–1000 µg/g dry weight; varies widely by habitat and season); the basis of Fucus use for thyroid hypofunction, goitre, and obesity linked to hypothyroidism; key safety concern at high doses (thyroid suppression, iodism); WHO essential micronutrient.');
  PERFORM herbal.ensure_constituent('phlorotannins', 'phlorotannin',
    'Characteristic brown algal polyphenols (eckol, fucofuroeckol, dieckol, and phloroglucinol oligomers; 1–10% dry weight); potent antioxidant, anti-diabetic (alpha-glucosidase inhibition), antiviral (neuraminidase inhibition), anti-inflammatory (COX-2/iNOS), and anti-obesity; one of the defining marker classes of the Fucaceae.');
  PERFORM herbal.ensure_constituent('fucoxanthin', 'carotenoid',
    'Dominant carotenoid in brown algae (0.1–0.9% dry weight); anti-obesity (stimulates thermogenesis via UCP1 upregulation in white adipose tissue), anti-diabetic (GLUT4 upregulation), antioxidant, anti-inflammatory, hepatoprotective, and anti-cancer; extensively studied marine carotenoid.');
  PERFORM herbal.ensure_constituent('laminarin', 'polysaccharide',
    'Linear beta-(1→3)-D-glucan with beta-(1→6) branch points (2–12% dry weight); the characteristic beta-glucan of brown algae; immunostimulant (macrophage and NK cell activation via Dectin-1), prebiotic, and antitumour activity.');
  PERFORM herbal.ensure_constituent('mannitol', 'sugar alcohol',
    'Major photosynthate and primary osmolyte of bladderwrack (5–20% dry weight — one of the highest-concentration constituents by mass); antioxidant; osmotic properties; the dominant carbon storage compound and key contributor to the alga''s salty-sweet taste.');

  PERFORM herbal.link_constituent('Fucus vesiculosus', 'fucoidan',     'primary',  10);
  PERFORM herbal.link_constituent('Fucus vesiculosus', 'iodine',       'primary',  20);
  PERFORM herbal.link_constituent('Fucus vesiculosus', 'phlorotannins','major',    30);
  PERFORM herbal.link_constituent('Fucus vesiculosus', 'fucoxanthin',  'major',    40);
  PERFORM herbal.link_constituent('Fucus vesiculosus', 'laminarin',    'major',    50);
  PERFORM herbal.link_constituent('Fucus vesiculosus', 'mannitol',     'major',    60);
  PERFORM herbal.link_constituent('Fucus vesiculosus', 'fucosterol',   'moderate', 70);

  RAISE NOTICE 'Added constituents to Kelp/Bladderwrack (Fucus vesiculosus)';
END $$;

-- ============================================================
-- Block 6: Shiitake (Lentinus edodes)
-- Already has: ergosterol (phytosterol, moderate, sort_order 0)
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('lentinan', 'beta-glucan polysaccharide',
    'The defining immunomodulatory marker of shiitake; beta-1,3/1,6-glucan that activates T-cells, macrophages, and NK cells via Dectin-1 and TLR signaling. Used clinically in Japan as an injectable adjuvant in gastric cancer therapy; primary standardization target of medicinal mushroom extracts.');
  PERFORM herbal.ensure_constituent('eritadenine', 'purine derivative',
    'Also called lentinacin; 2(R),3(R)-dihydroxy-4-(9-adenyl)butanoic acid; potent cholesterol-lowering activity via inhibition of S-adenosylhomocysteine hydrolase. A characteristic cardiovascular marker compound unique to Lentinula edodes.');
  PERFORM herbal.ensure_constituent('lenthionine', 'organosulfur compound',
    'Principal volatile responsible for shiitake''s characteristic aroma; cyclic polysulfide generated from lentinic acid by enzymatic action during drying or cooking. Documented antimicrobial activity and inhibition of platelet aggregation.');
  PERFORM herbal.ensure_constituent('ergothioneine', 'sulfur-containing amino acid',
    'Thiohistidine betaine; a potent antioxidant present at notably high concentrations in shiitake compared to other foods. Humans cannot synthesize it and acquire it primarily via dietary mushroom consumption; cytoprotective against oxidative and nitrosative stress.');
  PERFORM herbal.ensure_constituent('lentinic acid', 'organosulfur amino acid',
    'Gamma-glutamyl cysteine sulfoxide; the biosynthetic precursor to lenthionine, present at significant concentrations in fresh shiitake fruiting body. Cleaved by gamma-glutamyltranspeptidase during drying to yield the bioactive polysulfide.');
  PERFORM herbal.ensure_constituent('purine nucleotides', 'purine nucleotide',
    'Adenosine 5''-monophosphate (AMP) and guanosine 5''-monophosphate (GMP) occur in notable amounts in shiitake; responsible for characteristic umami flavor; mild vasodilatory and platelet-inhibiting properties.');

  PERFORM herbal.link_constituent('Lentinus edodes', 'lentinan',          'primary',  10);
  PERFORM herbal.link_constituent('Lentinus edodes', 'eritadenine',       'major',    20);
  PERFORM herbal.link_constituent('Lentinus edodes', 'beta-glucans',      'major',    30);
  PERFORM herbal.link_constituent('Lentinus edodes', 'lenthionine',       'moderate', 40);
  PERFORM herbal.link_constituent('Lentinus edodes', 'ergothioneine',     'moderate', 50);
  PERFORM herbal.link_constituent('Lentinus edodes', 'lentinic acid',     'moderate', 60);
  PERFORM herbal.link_constituent('Lentinus edodes', 'linoleic acid',     'moderate', 70);
  PERFORM herbal.link_constituent('Lentinus edodes', 'purine nucleotides','minor',    80);

  RAISE NOTICE 'Added constituents to Shiitake (Lentinus edodes)';
END $$;

-- ============================================================
-- Block 7: Birch (Betula spp.)
-- Already has: catechin (flavan-3-ol, minor, sort_order 0)
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('betulin', 'lupane triterpenoid',
    'Defining marker compound of birch bark (15–30% outer bark dry weight); the most abundant triterpenoid in the plant kingdom; biosynthetic precursor to betulinic acid. Antiproliferative, antiviral (HIV-1 entry inhibition), and anti-inflammatory activities. The primary standardization compound for birch bark preparations.');
  PERFORM herbal.ensure_constituent('betulinic acid', 'lupane triterpenoid',
    'Oxidation product of betulin with potent selective apoptotic activity in melanoma and other tumor cell lines via the mitochondrial pathway. Also antiviral (HIV, HSV), anti-inflammatory, antiplasmodial, and anti-HIV-1 integrase activity; extensively studied pentacyclic triterpenoid.');
  PERFORM herbal.ensure_constituent('lupeol', 'lupane triterpenoid',
    'Co-occurring lupane triterpenoid in birch bark; anti-inflammatory via NF-κB and COX-2 inhibition, antinociceptive, antiarthritic, and hepatoprotective. Present alongside betulin as the third major lupane compound in the bark.');
  PERFORM herbal.ensure_constituent('methyl salicylate', 'phenolic ester',
    'Characteristic volatile of birch bark and twigs; topical anti-inflammatory and analgesic via COX inhibition; the birch-bark aroma compound; contributes to the traditional use of birch in topical joint and muscle formulations.');

  PERFORM herbal.link_constituent('Betula spp.', 'betulin',           'primary',  10);
  PERFORM herbal.link_constituent('Betula spp.', 'betulinic acid',    'major',    20);
  PERFORM herbal.link_constituent('Betula spp.', 'lupeol',            'moderate', 30);
  PERFORM herbal.link_constituent('Betula spp.', 'oleanolic acid',    'moderate', 40);
  PERFORM herbal.link_constituent('Betula spp.', 'hyperoside',        'moderate', 50);
  PERFORM herbal.link_constituent('Betula spp.', 'quercetin',         'moderate', 60);
  PERFORM herbal.link_constituent('Betula spp.', 'chlorogenic acid',  'moderate', 70);
  PERFORM herbal.link_constituent('Betula spp.', 'rutin',             'minor',    80);
  PERFORM herbal.link_constituent('Betula spp.', 'methyl salicylate', 'minor',    90);
  PERFORM herbal.link_constituent('Betula spp.', 'caffeic acid',      'minor',    100);

  RAISE NOTICE 'Added constituents to Birch (Betula spp.)';
END $$;
