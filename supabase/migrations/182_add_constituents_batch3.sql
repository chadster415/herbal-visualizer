`-- Migration 182: Add general constituents to Gymnema, Shatavari, Khella,
-- Usnea, Yohimbe, and Poke Root.

SET search_path TO herbal, public;

-- ============================================================
-- Block 1: Gymnema (Gymnema sylvestre)
-- Already has: quercetin
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('gymnemic acid I', 'triterpenoid saponin',
    'Triterpene glycoside; primary anti-sweet compound; suppresses sweet taste perception by blocking lingual sweet receptors; also lowers blood glucose.');
  PERFORM herbal.ensure_constituent('gymnemic acid II', 'triterpenoid saponin',
    'Triterpene glycoside co-occurring with gymnemic acid I; contributes to anti-sweet and anti-diabetic activity.');
  PERFORM herbal.ensure_constituent('gymnemic acid III', 'triterpenoid saponin',
    'Third major gymnemic acid component; part of the standardized saponin fraction used in clinical studies.');
  PERFORM herbal.ensure_constituent('gymnemic acid IV', 'triterpenoid saponin',
    'Fourth major gymnemic acid; the four together constitute the primary gymnemic acid complex governing hypoglycemic and anti-sweet actions.');
  PERFORM herbal.ensure_constituent('gymnemagenin', 'triterpenoid sapogenin',
    'Aglycone of the gymnemic acids (= gymnemagenol); dammarane-type triterpene; released on hydrolysis of gymnemic acid glycosides.');
  PERFORM herbal.ensure_constituent('gymnemasaponin V', 'triterpenoid saponin',
    'Oleanane-type saponin distinct from the gymnemic acid series; contributes to the overall saponin profile of the leaf.');
  PERFORM herbal.ensure_constituent('gurmarin', 'polypeptide',
    'Small sweet-suppressing polypeptide (35 amino acids); blocks sweet-taste receptors in rodents; distinct mechanism from gymnemic acids.');

  PERFORM herbal.link_constituent('Gymnema sylvestre', 'gymnemic acid I',    'primary',  0);
  PERFORM herbal.link_constituent('Gymnema sylvestre', 'gymnemic acid II',   'primary',  10);
  PERFORM herbal.link_constituent('Gymnema sylvestre', 'gymnemic acid III',  'major',    20);
  PERFORM herbal.link_constituent('Gymnema sylvestre', 'gymnemic acid IV',   'major',    30);
  PERFORM herbal.link_constituent('Gymnema sylvestre', 'gymnemagenin',       'moderate', 40);
  PERFORM herbal.link_constituent('Gymnema sylvestre', 'gymnemasaponin V',   'moderate', 50);
  PERFORM herbal.link_constituent('Gymnema sylvestre', 'gurmarin',           'moderate', 60);
  PERFORM herbal.link_constituent('Gymnema sylvestre', 'luteolin',           'minor',    70);
  PERFORM herbal.link_constituent('Gymnema sylvestre', 'stigmasterol',       'minor',    80);

  RAISE NOTICE 'Added constituents to Gymnema (Gymnema sylvestre)';
END $$;

-- ============================================================
-- Block 2: Shatavari (Asparagus racemosus)
-- Already has: diosgenin
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('shatavarin I', 'steroidal saponin',
    'Primary marker saponin; spirostanol glycoside; governs female reproductive tonic and adaptogenic effects; used for extract standardization.');
  PERFORM herbal.ensure_constituent('shatavarin IV', 'steroidal saponin',
    'Co-primary saponin; most studied alongside shatavarin I for estrogenic, immunomodulatory, and galactagogue activity.');
  PERFORM herbal.ensure_constituent('shatavarin V', 'steroidal saponin',
    'Furostanol glycoside; precursor form of shatavarin saponins; co-occurs in root and rhizome extracts.');
  PERFORM herbal.ensure_constituent('asparanin A', 'steroidal saponin',
    'Spirostanol saponin; contributes to antioxidant and cytotoxic activity; part of the broader saponin complex.');
  PERFORM herbal.ensure_constituent('sarsasapogenin', 'steroidal sapogenin',
    'Primary sapogenin aglycone released from shatavarin saponins on hydrolysis; steroidal precursor for semi-synthetic hormone production.');
  PERFORM herbal.ensure_constituent('asparagus polysaccharides', 'polysaccharide',
    'Fructo-oligosaccharide and polysaccharide fraction; immunostimulant and prebiotic activity; contributes to adaptogenic tonic effects.');
  PERFORM herbal.ensure_constituent('racemosol', 'stilbenoid',
    'Dihydroxymethyl stilbene; antioxidant and anti-inflammatory; minor phenolic constituent unique to A. racemosus root.');

  PERFORM herbal.link_constituent('Asparagus racemosus', 'shatavarin I',             'primary',  0);
  PERFORM herbal.link_constituent('Asparagus racemosus', 'shatavarin IV',            'primary',  10);
  PERFORM herbal.link_constituent('Asparagus racemosus', 'shatavarin V',             'major',    20);
  PERFORM herbal.link_constituent('Asparagus racemosus', 'asparanin A',              'major',    30);
  PERFORM herbal.link_constituent('Asparagus racemosus', 'sarsasapogenin',           'moderate', 40);
  PERFORM herbal.link_constituent('Asparagus racemosus', 'asparagus polysaccharides','moderate', 50);
  PERFORM herbal.link_constituent('Asparagus racemosus', 'racemosol',                'minor',    60);
  PERFORM herbal.link_constituent('Asparagus racemosus', 'rutin',                    'minor',    70);

  RAISE NOTICE 'Added constituents to Shatavari (Asparagus racemosus)';
END $$;

-- ============================================================
-- Block 3: Khella (Ammi visnaga)
-- Already has: coumarins (generic)
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('khellin', 'furanochromone',
    'Primary marker compound; furocoumarin-like chromone; potent bronchospasmolytic and coronary vasodilator; structural precursor to cromolyn sodium and amiodarone.');
  PERFORM herbal.ensure_constituent('visnagin', 'furanochromone',
    'Second major furanochromone; co-occurs with khellin; antispasmodic and vasodilatory activity; antifungal properties.');
  PERFORM herbal.ensure_constituent('khellol', 'furanochromone',
    'Khellin metabolite; antispasmodic; present in the free and glycosylated form in fruit extracts.');
  PERFORM herbal.ensure_constituent('khellol glucoside', 'furanochromone glycoside',
    'Glycosylated form of khellol; more water-soluble than khellin; contributes to the overall furanochromone activity.');
  PERFORM herbal.ensure_constituent('visnadin', 'pyranochromone',
    'Pyranochromone with calcium channel antagonist activity; vasodilatory; structurally distinct from the furanochromone series.');
  PERFORM herbal.ensure_constituent('xanthotoxin', 'furanocoumarin',
    'Methoxsalen; furocoumarin constituent; phototoxic at high doses; minor component of Ammi visnaga; more characteristic of A. majus.');

  PERFORM herbal.link_constituent('Ammi visnaga', 'khellin',         'primary',  0);
  PERFORM herbal.link_constituent('Ammi visnaga', 'visnagin',        'primary',  10);
  PERFORM herbal.link_constituent('Ammi visnaga', 'khellol',         'major',    20);
  PERFORM herbal.link_constituent('Ammi visnaga', 'khellol glucoside','major',   30);
  PERFORM herbal.link_constituent('Ammi visnaga', 'visnadin',        'moderate', 40);
  PERFORM herbal.link_constituent('Ammi visnaga', 'gamma-terpinene', 'moderate', 50);
  PERFORM herbal.link_constituent('Ammi visnaga', 'linalool',        'moderate', 60);
  PERFORM herbal.link_constituent('Ammi visnaga', 'xanthotoxin',     'minor',    70);

  RAISE NOTICE 'Added constituents to Khella (Ammi visnaga)';
END $$;

-- ============================================================
-- Block 4: Usnea (Usnea barbata)
-- Already has: usnic acid
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('diffractaic acid', 'depside',
    'Aliphatic depside (= evernic acid ester analog); potent antibacterial activity; present in most Usnea species alongside usnic acid.');
  PERFORM herbal.ensure_constituent('atranorin', 'depside',
    'Ortho-depside; antimicrobial and anti-inflammatory; widely distributed across the Usnea genus; contributes to the lichen''s defensive chemistry.');
  PERFORM herbal.ensure_constituent('salazinic acid', 'depsidone',
    'Depsidone; characteristic of many Usnea species; antimicrobial and antitumor activity; used as chemotaxonomic marker.');
  PERFORM herbal.ensure_constituent('norstictic acid', 'depsidone',
    'Depsidone co-occurring with salazinic acid; antimicrobial; reacts with K (potassium hydroxide) to give characteristic lichen spot test yellow.');
  PERFORM herbal.ensure_constituent('barbatic acid', 'depside',
    'Para-depside; antiviral and antifungal activity; present in U. barbata and related species alongside diffractaic acid.');
  PERFORM herbal.ensure_constituent('protocetraric acid', 'depsidone',
    'Depsidone; anti-inflammatory and cytotoxic; characteristic of Usnea when norstictic acid is absent.');

  PERFORM herbal.link_constituent('Usnea barbata', 'diffractaic acid',  'major',    10);
  PERFORM herbal.link_constituent('Usnea barbata', 'atranorin',         'major',    20);
  PERFORM herbal.link_constituent('Usnea barbata', 'beta-glucans',      'major',    30);
  PERFORM herbal.link_constituent('Usnea barbata', 'salazinic acid',    'moderate', 40);
  PERFORM herbal.link_constituent('Usnea barbata', 'norstictic acid',   'moderate', 50);
  PERFORM herbal.link_constituent('Usnea barbata', 'barbatic acid',     'moderate', 60);
  PERFORM herbal.link_constituent('Usnea barbata', 'protocetraric acid','moderate', 70);

  RAISE NOTICE 'Added constituents to Usnea (Usnea barbata)';
END $$;

-- ============================================================
-- Block 5: Yohimbe (Pausinystalia johimbe)
-- Already has: alkaloids (generic)
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('yohimbine', 'indole alkaloid',
    'Primary marker alkaloid; selective alpha-2 adrenoceptor antagonist; 10–15% total alkaloid content in bark; aphrodisiac and lipolytic activity.');
  PERFORM herbal.ensure_constituent('corynanthine', 'indole alkaloid',
    'Second most abundant alkaloid; alpha-1 adrenoceptor antagonist (opposite selectivity to yohimbine); modulates overall adrenergic effect of bark.');
  PERFORM herbal.ensure_constituent('alpha-yohimbine', 'indole alkaloid',
    'Rauwolscine; stereoisomer of yohimbine; alpha-2 antagonist activity; contributes to the mixed alkaloid pharmacology of bark extracts.');
  PERFORM herbal.ensure_constituent('pseudoyohimbine', 'indole alkaloid',
    'Diastereomeric alkaloid co-occurring with yohimbine; mild adrenergic activity; part of the complex indole alkaloid profile.');
  PERFORM herbal.ensure_constituent('corynantheidine', 'indole alkaloid',
    'N-methyl indole alkaloid related to corynanthine; minor component; contributes to the overall adrenergic modulation of the extract.');
  PERFORM herbal.ensure_constituent('ajmalicine', 'indole alkaloid',
    'Raubasine; alpha-1 adrenoceptor antagonist; antihypertensive and cerebrovascular effects; minor component of yohimbe bark.');

  PERFORM herbal.link_constituent('Pausinystalia johimbe', 'yohimbine',         'primary',  0);
  PERFORM herbal.link_constituent('Pausinystalia johimbe', 'corynanthine',      'major',    10);
  PERFORM herbal.link_constituent('Pausinystalia johimbe', 'alpha-yohimbine',   'major',    20);
  PERFORM herbal.link_constituent('Pausinystalia johimbe', 'pseudoyohimbine',   'moderate', 30);
  PERFORM herbal.link_constituent('Pausinystalia johimbe', 'corynantheidine',   'moderate', 40);
  PERFORM herbal.link_constituent('Pausinystalia johimbe', 'ajmalicine',        'minor',    50);
  PERFORM herbal.link_constituent('Pausinystalia johimbe', 'tannins',           'minor',    60);

  RAISE NOTICE 'Added constituents to Yohimbe (Pausinystalia johimbe)';
END $$;

-- ============================================================
-- Block 6: Poke Root (Phytolacca americana)
-- Already has: oleanolic acid
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('phytolaccoside A', 'triterpenoid saponin',
    'Primary saponin of Phytolacca root; oleanane-type glycoside; antiviral, anti-inflammatory, and immunostimulant activity; major constituent of root extract.');
  PERFORM herbal.ensure_constituent('phytolaccoside B', 'triterpenoid saponin',
    'Second major saponin; esculentoside-type; contributes to the irritant and lymphagogue properties characteristic of poke root.');
  PERFORM herbal.ensure_constituent('phytolaccoside E', 'triterpenoid saponin',
    'Minor saponin glycoside; part of the complex saponin fraction that drives poke root''s lymphatic and anti-inflammatory actions.');
  PERFORM herbal.ensure_constituent('phytolaccagenin', 'triterpenoid sapogenin',
    'Primary aglycone of the phytolaccoside saponins; oleanolic acid derivative; released on hydrolysis; contributes to cytotoxic activity.');
  PERFORM herbal.ensure_constituent('pokeweed mitogen', 'lectin',
    'PWM; plant lectin and mitogen that stimulates lymphocyte proliferation; used as a research tool; contributes to immunostimulant effects at low doses and toxicity at high doses.');
  PERFORM herbal.ensure_constituent('phytolacca antiviral protein', 'ribosome-inactivating protein',
    'PAP; type I ribosome-inactivating protein; potent antiviral (investigational against HIV, herpes); the basis of poke root''s traditional use as an antiviral.');
  PERFORM herbal.ensure_constituent('betacyanins', 'betalain',
    'Red-purple nitrogen-containing pigments (betanin, phytolaccin); antioxidant; responsible for the deep red color of poke berries and stems.');

  PERFORM herbal.link_constituent('Phytolacca americana', 'phytolaccoside A',             'major',    10);
  PERFORM herbal.link_constituent('Phytolacca americana', 'phytolaccoside B',             'major',    20);
  PERFORM herbal.link_constituent('Phytolacca americana', 'phytolaccoside E',             'moderate', 30);
  PERFORM herbal.link_constituent('Phytolacca americana', 'phytolaccagenin',              'moderate', 40);
  PERFORM herbal.link_constituent('Phytolacca americana', 'pokeweed mitogen',             'moderate', 50);
  PERFORM herbal.link_constituent('Phytolacca americana', 'phytolacca antiviral protein', 'moderate', 60);
  PERFORM herbal.link_constituent('Phytolacca americana', 'betacyanins',                  'moderate', 70);

  RAISE NOTICE 'Added constituents to Poke Root (Phytolacca americana)';
END $$;
`