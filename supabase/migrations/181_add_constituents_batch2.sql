-- Migration 181: Add general constituents to American Ginseng, Narrow-Leaf Echinacea,
-- Rhodiola, Pau D'arco, Olive, and Dan Shen. Also merges Orange (Citrus spp.)
-- stub into Sweet Orange (Citrus sinensis).

SET search_path TO herbal, public;

-- ============================================================
-- Block 1: Merge Orange stub (Citrus spp., id=2503)
--          into Sweet Orange (Citrus sinensis, id=748)
-- Actions: Organ Affinity - Digestive.
-- ============================================================
DO $$
BEGIN
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength, body_system_note)
  SELECT 748, primary_action_id, body_system_id, relative_strength, body_system_note
  FROM herbal.herb_primary_actions
  WHERE herb_id = 2503
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  DELETE FROM herbal.herb_primary_actions WHERE herb_id = 2503;
  DELETE FROM herbal.herbs WHERE id = 2503;

  RAISE NOTICE 'Merged Orange stub (Citrus spp., id=2503) into Sweet Orange (Citrus sinensis, id=748)';
END $$;

-- ============================================================
-- Block 2: American Ginseng (Panax quinquefolius)
-- Already has: triterpenoid saponins (generic)
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('ginsenoside Rb1', 'triterpenoid saponin',
    'Most abundant protopanaxadiol-type ginsenoside; central to immunomodulatory and adaptogenic activity.');
  PERFORM herbal.ensure_constituent('ginsenoside Re', 'triterpenoid saponin',
    'Most abundant protopanaxatriol-type ginsenoside in American ginseng; present at higher ratios than in Asian Panax species.');
  PERFORM herbal.ensure_constituent('ginsenoside Rg1', 'triterpenoid saponin',
    'Major protopanaxatriol ginsenoside; CNS-stimulant and neuroprotective properties.');
  PERFORM herbal.ensure_constituent('ginsenoside Rc', 'triterpenoid saponin',
    'Protopanaxadiol ginsenoside; contributes to anti-fatigue and immunomodulatory effects.');
  PERFORM herbal.ensure_constituent('ginsenoside Rb2', 'triterpenoid saponin',
    'Protopanaxadiol ginsenoside co-occurring with Rb1; anti-stress and adaptogenic activity.');
  PERFORM herbal.ensure_constituent('ginsenoside Rg3', 'triterpenoid saponin',
    'Minor protopanaxadiol ginsenoside; notable antitumor and neuroprotective activity; increases in red-processed root.');
  PERFORM herbal.ensure_constituent('pseudoginsenoside F11', 'triterpenoid saponin',
    'Ocotillol-type saponin characteristic of Panax quinquefolius; chemotaxonomic marker distinguishing American from Asian ginseng.');
  PERFORM herbal.ensure_constituent('ginsenoside Ro', 'triterpenoid saponin',
    'Oleanane-type ginsenoside; structurally distinct from the protopanaxadiol/triol series; helps differentiate American ginseng.');
  PERFORM herbal.ensure_constituent('quinquefolans', 'polysaccharide',
    'Acidic polysaccharides (A, B, C) with documented hypoglycemic activity; represent the non-saponin tonic fraction.');
  PERFORM herbal.ensure_constituent('panaxynol', 'polyacetylene',
    'Principal polyacetylene (= falcarinol); antimicrobial and cytotoxic activity; characteristic of Araliaceae family.');

  PERFORM herbal.link_constituent('Panax quinquefolius', 'ginsenoside Rb1',       'major',    0);
  PERFORM herbal.link_constituent('Panax quinquefolius', 'ginsenoside Re',        'major',    10);
  PERFORM herbal.link_constituent('Panax quinquefolius', 'ginsenoside Rg1',       'major',    20);
  PERFORM herbal.link_constituent('Panax quinquefolius', 'ginsenoside Rc',        'moderate', 30);
  PERFORM herbal.link_constituent('Panax quinquefolius', 'ginsenoside Rb2',       'moderate', 40);
  PERFORM herbal.link_constituent('Panax quinquefolius', 'ginsenoside Rg3',       'minor',    50);
  PERFORM herbal.link_constituent('Panax quinquefolius', 'pseudoginsenoside F11', 'minor',    60);
  PERFORM herbal.link_constituent('Panax quinquefolius', 'ginsenoside Ro',        'minor',    70);
  PERFORM herbal.link_constituent('Panax quinquefolius', 'quinquefolans',         'moderate', 80);
  PERFORM herbal.link_constituent('Panax quinquefolius', 'panaxynol',             'minor',    90);

  RAISE NOTICE 'Added constituents to American Ginseng (Panax quinquefolius)';
END $$;

-- ============================================================
-- Block 3: Narrow-Leaf Echinacea (Echinacea angustifolia)
-- Already has: echinacoside
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('cynarin', 'hydroxycinnamic acid',
    '1,3-dicaffeoylquinic acid; key distinguishing marker of E. angustifolia root vs E. purpurea; caffeic acid ester.');
  PERFORM herbal.ensure_constituent('alkylamides', 'alkylamide',
    'Isobutylamide polyunsaturated fatty acids; primary immunostimulant fraction of E. angustifolia root; modulate CB2 and TNF-alpha.');
  PERFORM herbal.ensure_constituent('arabinogalactan', 'polysaccharide',
    'Immunostimulant polysaccharide; activates macrophages and complement system; contributes to innate immune activity.');
  PERFORM herbal.ensure_constituent('verbascoside', 'phenylethanoid glycoside',
    'Caffeic acid-phenethanol glycoside (= acteoside); antioxidant and anti-inflammatory; complements echinacoside in the phenolic fraction.');

  PERFORM herbal.link_constituent('Echinacea angustifolia', 'cynarin',        'major',    10);
  PERFORM herbal.link_constituent('Echinacea angustifolia', 'alkylamides',    'major',    20);
  PERFORM herbal.link_constituent('Echinacea angustifolia', 'arabinogalactan','moderate', 30);
  PERFORM herbal.link_constituent('Echinacea angustifolia', 'verbascoside',   'moderate', 40);
  PERFORM herbal.link_constituent('Echinacea angustifolia', 'chlorogenic acid','moderate',50);
  PERFORM herbal.link_constituent('Echinacea angustifolia', 'caffeic acid',   'minor',    60);

  RAISE NOTICE 'Added constituents to Narrow-Leaf Echinacea (Echinacea angustifolia)';
END $$;

-- ============================================================
-- Block 4: Rhodiola (Rhodiola rosea)
-- Already has: phenylpropanoids (generic)
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('salidroside', 'phenylpropanoid glycoside',
    'Primary marker compound (= rhodioloside); p-tyrosol glucoside; most studied for adaptogenic and neuroprotective activity.');
  PERFORM herbal.ensure_constituent('rosavin', 'phenylpropanoid glycoside',
    'Cinnamyl alcohol triglycoside; one of three signature rosavins used for quality standardization (≥0.8% per EP); unique to R. rosea among Rhodiola species.');
  PERFORM herbal.ensure_constituent('rosarin', 'phenylpropanoid glycoside',
    'Cinnamyl arabinoside; second of the rosavin triad; co-occurs with rosavin as a characteristic R. rosea marker.');
  PERFORM herbal.ensure_constituent('rosin', 'phenylpropanoid glycoside',
    'Cinnamyl glucoside; third of the rosavin triad; part of the species-authenticating phenylpropanoid fingerprint.');
  PERFORM herbal.ensure_constituent('tyrosol', 'phenylpropanoid',
    'Free aglycone form of salidroside; antioxidant and cardioprotective; present in both free and esterified forms.');
  PERFORM herbal.ensure_constituent('rhodionin', 'flavonoid glycoside',
    'Kaempferol-7-O-rhamnoside; characteristic flavonoid glycoside of the Rhodiola genus.');
  PERFORM herbal.ensure_constituent('herbacetin glycosides', 'flavonoid glycoside',
    '8-Hydroxyflavonol glycosides (rodiolin, rhodiosin, rhodalin) unique to Rhodiola; contribute to antioxidant and adaptogenic activity.');

  PERFORM herbal.link_constituent('Rhodiola rosea', 'salidroside',          'primary',  0);
  PERFORM herbal.link_constituent('Rhodiola rosea', 'rosavin',              'primary',  10);
  PERFORM herbal.link_constituent('Rhodiola rosea', 'rosarin',              'major',    20);
  PERFORM herbal.link_constituent('Rhodiola rosea', 'rosin',                'major',    30);
  PERFORM herbal.link_constituent('Rhodiola rosea', 'tyrosol',              'major',    40);
  PERFORM herbal.link_constituent('Rhodiola rosea', 'kaempferol',           'moderate', 50);
  PERFORM herbal.link_constituent('Rhodiola rosea', 'rhodionin',            'moderate', 60);
  PERFORM herbal.link_constituent('Rhodiola rosea', 'herbacetin glycosides','moderate', 70);
  PERFORM herbal.link_constituent('Rhodiola rosea', 'gallic acid',          'minor',    80);
  PERFORM herbal.link_constituent('Rhodiola rosea', 'proanthocyanidins',    'minor',    90);

  RAISE NOTICE 'Added constituents to Rhodiola (Rhodiola rosea)';
END $$;

-- ============================================================
-- Block 5: Pau D'arco (Tabebuia impetiginosa)
-- Already has: quercetin
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('lapachol', 'naphthoquinone',
    'Dominant bioactive quinone; 2–7% dry inner bark weight; antibacterial, antifungal, antiparasitic; first isolated 1882.');
  PERFORM herbal.ensure_constituent('beta-lapachone', 'naphthoquinone',
    'Formed from lapachol under acidic conditions; potent anticancer activity via NQO1-dependent mechanism; antiparasitic.');
  PERFORM herbal.ensure_constituent('alpha-lapachone', 'naphthoquinone',
    'Lapachol-derived isomer; antifungal and cytotoxic activity.');
  PERFORM herbal.ensure_constituent('xyloidone', 'naphthoquinone',
    'Dehydro-alpha-lapachone; antifungal; characteristic of Tabebuia inner bark.');

  PERFORM herbal.link_constituent('Tabebuia impetiginosa', 'lapachol',       'primary',  0);
  PERFORM herbal.link_constituent('Tabebuia impetiginosa', 'beta-lapachone', 'major',    10);
  PERFORM herbal.link_constituent('Tabebuia impetiginosa', 'alpha-lapachone','major',    20);
  PERFORM herbal.link_constituent('Tabebuia impetiginosa', 'xyloidone',      'moderate', 30);
  PERFORM herbal.link_constituent('Tabebuia impetiginosa', 'kaempferol',     'moderate', 40);
  PERFORM herbal.link_constituent('Tabebuia impetiginosa', 'luteolin',       'moderate', 50);
  PERFORM herbal.link_constituent('Tabebuia impetiginosa', 'catechin',       'moderate', 60);

  RAISE NOTICE 'Added constituents to Pau D''arco (Tabebuia impetiginosa)';
END $$;

-- ============================================================
-- Block 6: Olive (Olea europaea)
-- Already has: oleanolic acid
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('oleuropein', 'secoiridoid glycoside',
    'Defining marker compound of olive leaf; 1–14% dry weight; antihypertensive, antioxidant, antimicrobial, cardioprotective.');
  PERFORM herbal.ensure_constituent('hydroxytyrosol', 'phenolic alcohol',
    'Most potent antioxidant in the olive phenol fraction; formed from oleuropein hydrolysis; cardioprotective and neuroprotective.');
  PERFORM herbal.ensure_constituent('ligstroside', 'secoiridoid glycoside',
    'Secoiridoid glycoside co-occurring with oleuropein; also yields hydroxytyrosol and tyrosol on hydrolysis.');

  PERFORM herbal.link_constituent('Olea europaea', 'oleuropein',     'primary',  0);
  PERFORM herbal.link_constituent('Olea europaea', 'hydroxytyrosol', 'major',    10);
  PERFORM herbal.link_constituent('Olea europaea', 'tyrosol',        'moderate', 20);
  PERFORM herbal.link_constituent('Olea europaea', 'ligstroside',    'moderate', 30);
  PERFORM herbal.link_constituent('Olea europaea', 'luteolin',       'moderate', 40);
  PERFORM herbal.link_constituent('Olea europaea', 'rutin',          'minor',    50);
  PERFORM herbal.link_constituent('Olea europaea', 'caffeic acid',   'minor',    60);
  PERFORM herbal.link_constituent('Olea europaea', 'ursolic acid',   'minor',    70);

  RAISE NOTICE 'Added constituents to Olive (Olea europaea)';
END $$;

-- ============================================================
-- Block 7: Dan Shen (Salvia miltiorrhiza)
-- Already has: rosmarinic acid
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('tanshinone IIA', 'diterpenoid quinone',
    'Dominant tanshinone and primary cardiovascular marker; abietane diterpenoid; anti-platelet, cardioprotective, anti-inflammatory.');
  PERFORM herbal.ensure_constituent('salvianolic acid B', 'caffeic acid oligomer',
    'Most abundant water-soluble active; depside formed from three caffeic acid units; potent antioxidant and cardioprotective.');
  PERFORM herbal.ensure_constituent('cryptotanshinone', 'diterpenoid quinone',
    'Second major tanshinone; contributes to antibacterial, anti-inflammatory, and antitumor activity of the root.');
  PERFORM herbal.ensure_constituent('tanshinone I', 'diterpenoid quinone',
    'Third major tanshinone; co-occurs with tanshinone IIA and cryptotanshinone in the lipophilic fraction.');
  PERFORM herbal.ensure_constituent('danshensu', 'phenolic acid',
    '3,4-Dihydroxyphenyllactic acid; first isolated water-soluble active; inhibits platelet aggregation and improves microcirculation.');
  PERFORM herbal.ensure_constituent('salvianolic acid A', 'caffeic acid oligomer',
    'Potent antioxidant depside; present in hydrophilic extracts alongside salvianolic acid B; hepatoprotective.');
  PERFORM herbal.ensure_constituent('miltirone', 'diterpenoid quinone',
    'Furanoid diterpene related to tanshinones; anti-inflammatory and neuroprotective.');
  PERFORM herbal.ensure_constituent('lithospermic acid B', 'caffeic acid oligomer',
    'Magnesium lithospermate B; strong antioxidant and anti-fibrotic activity; nephroprotective and cardioprotective.');
  PERFORM herbal.ensure_constituent('protocatechuic aldehyde', 'phenolic aldehyde',
    '3,4-Dihydroxybenzaldehyde; cardiovascular-protective simple phenolic; contributes to blood-moving activity.');

  PERFORM herbal.link_constituent('Salvia miltiorrhiza', 'tanshinone IIA',         'primary',  0);
  PERFORM herbal.link_constituent('Salvia miltiorrhiza', 'salvianolic acid B',     'primary',  10);
  PERFORM herbal.link_constituent('Salvia miltiorrhiza', 'cryptotanshinone',       'major',    20);
  PERFORM herbal.link_constituent('Salvia miltiorrhiza', 'tanshinone I',           'major',    30);
  PERFORM herbal.link_constituent('Salvia miltiorrhiza', 'danshensu',              'major',    40);
  PERFORM herbal.link_constituent('Salvia miltiorrhiza', 'salvianolic acid A',     'moderate', 50);
  PERFORM herbal.link_constituent('Salvia miltiorrhiza', 'miltirone',              'moderate', 60);
  PERFORM herbal.link_constituent('Salvia miltiorrhiza', 'lithospermic acid B',    'moderate', 70);
  PERFORM herbal.link_constituent('Salvia miltiorrhiza', 'protocatechuic aldehyde','minor',    80);

  RAISE NOTICE 'Added constituents to Dan Shen (Salvia miltiorrhiza)';
END $$;
