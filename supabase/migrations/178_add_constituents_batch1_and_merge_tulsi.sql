-- Migration 178: Add general constituents to Bacopa, Black Pepper, Jamaican Dogwood,
-- Self Heal, and Spikenard. Merge Tulsi (Ocimum tenuiflorum) stub into Holy Basil
-- (Ocimum sanctum) — same species, tenuiflorum is the accepted modern synonym — and
-- extend Holy Basil's constituent profile. Also merges 6 additional synonym/spp. stubs:
-- Chamomile, Peppermint, Oregon Grape, Linden, Witch Hazel, Wood Betony.

SET search_path TO herbal, public;

-- ============================================================
-- Block 1: Merge Tulsi (id=2367) into Holy Basil (id=13)
-- ============================================================
DO $$
BEGIN
  -- Move Tulsi's primary actions (Organ Affinity - Respiratory, Endocrine) to Holy Basil
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength, body_system_note)
  SELECT 13, primary_action_id, body_system_id, relative_strength, body_system_note
  FROM herbal.herb_primary_actions
  WHERE herb_id = 2367
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  DELETE FROM herbal.herb_primary_actions WHERE herb_id = 2367;
  DELETE FROM herbal.herbs WHERE id = 2367;

  RAISE NOTICE 'Merged Tulsi (Ocimum tenuiflorum, id=2367) into Holy Basil (Ocimum sanctum, id=13)';
END $$;

-- ============================================================
-- Block 2: Holy Basil additional constituents
-- (already has: apigenin, luteolin, rosmarinic acid, ursolic acid, eugenol)
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('ocimumosides', 'triterpenoid glycoside',
    'Adaptogenic triterpenoid glycosides specific to Ocimum tenuiflorum; stress-modulating activity underlying adaptogen classification.');
  PERFORM herbal.ensure_constituent('vicenin-2', 'flavone C-glycoside',
    'Di-C-glucoside of apigenin; antioxidant and anti-inflammatory; prominent in aqueous extracts.');

  PERFORM herbal.link_constituent('Ocimum sanctum', 'orientin',          'moderate', 10);
  PERFORM herbal.link_constituent('Ocimum sanctum', 'vicenin-2',         'moderate', 20);
  PERFORM herbal.link_constituent('Ocimum sanctum', 'beta-caryophyllene','moderate', 30);
  PERFORM herbal.link_constituent('Ocimum sanctum', 'ocimumosides',      'moderate', 40);
  PERFORM herbal.link_constituent('Ocimum sanctum', 'oleanolic acid',    'minor',    50);

  RAISE NOTICE 'Added constituents to Holy Basil (Ocimum sanctum)';
END $$;

-- ============================================================
-- Block 3: Bacopa (Bacopa monnieri)
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('bacoside A', 'triterpenoid saponin',
    'Primary nootropic marker compound; dammarane-type triterpenoid glycoside mixture; 2–5% in standardized extracts.');
  PERFORM herbal.ensure_constituent('bacoside B', 'triterpenoid saponin',
    'Co-primary saponin with bacoside A; together constitute the bacoside complex central to cognitive activity.');
  PERFORM herbal.ensure_constituent('brahmine', 'pyrrolidine alkaloid',
    'Minor pyrrolidine alkaloid contributing to CNS-modulating activity.');
  PERFORM herbal.ensure_constituent('stigmasterol', 'phytosterol',
    'Plant sterol with anti-inflammatory and membrane-stabilising properties.');

  PERFORM herbal.link_constituent('Bacopa monnieri', 'bacoside A',   'primary',  0);
  PERFORM herbal.link_constituent('Bacopa monnieri', 'bacoside B',   'major',    10);
  PERFORM herbal.link_constituent('Bacopa monnieri', 'apigenin',     'minor',    20);
  PERFORM herbal.link_constituent('Bacopa monnieri', 'luteolin',     'minor',    30);
  PERFORM herbal.link_constituent('Bacopa monnieri', 'quercetin',    'minor',    40);
  PERFORM herbal.link_constituent('Bacopa monnieri', 'brahmine',     'minor',    50);
  PERFORM herbal.link_constituent('Bacopa monnieri', 'stigmasterol', 'minor',    60);

  RAISE NOTICE 'Added constituents to Bacopa (Bacopa monnieri)';
END $$;

-- ============================================================
-- Block 4: Black Pepper (Piper nigrum)
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('chavicine', 'piperidine alkaloid',
    'Cis,cis-geometric isomer of piperine; contributes to pungency; typically 1–2% in fresh pepper.');

  PERFORM herbal.link_constituent('Piper nigrum', 'piperine',            'primary',  0);
  PERFORM herbal.link_constituent('Piper nigrum', 'chavicine',           'moderate', 10);
  PERFORM herbal.link_constituent('Piper nigrum', 'beta-caryophyllene',  'moderate', 20);
  PERFORM herbal.link_constituent('Piper nigrum', 'sabinene',            'moderate', 30);
  PERFORM herbal.link_constituent('Piper nigrum', 'limonene',            'minor',    40);

  RAISE NOTICE 'Added constituents to Black Pepper (Piper nigrum)';
END $$;

-- ============================================================
-- Block 5: Jamaican Dogwood (Piscidia piscipula)
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('jamaicin', 'isoflavanone',
    'Rotenoid isoflavanone characteristic of Piscidia bark; CNS-depressant and spasmolytic activity.');
  PERFORM herbal.ensure_constituent('milletone', 'isoflavanone',
    'Rotenoid isoflavanone contributing to sedative and analgesic profile of Jamaican dogwood bark.');
  PERFORM herbal.ensure_constituent('isomilletone', 'isoflavanone',
    'Structural isomer of milletone; pharmacologically active rotenoid in root bark.');
  PERFORM herbal.ensure_constituent('piscidin', 'isoflavone',
    'Isoflavone from Piscidia bark; contributes to spasmolytic activity.');

  PERFORM herbal.link_constituent('Piscidia piscipula', 'rotenone',       'moderate', 0);
  PERFORM herbal.link_constituent('Piscidia piscipula', 'piscidic acid',  'moderate', 10);
  PERFORM herbal.link_constituent('Piscidia piscipula', 'jamaicin',       'moderate', 20);
  PERFORM herbal.link_constituent('Piscidia piscipula', 'milletone',      'minor',    30);
  PERFORM herbal.link_constituent('Piscidia piscipula', 'isomilletone',   'minor',    40);
  PERFORM herbal.link_constituent('Piscidia piscipula', 'piscidin',       'minor',    50);
  PERFORM herbal.link_constituent('Piscidia piscipula', 'beta-sitosterol','minor',    60);
  PERFORM herbal.link_constituent('Piscidia piscipula', 'tannins',        'minor',    70);

  RAISE NOTICE 'Added constituents to Jamaican Dogwood (Piscidia piscipula)';
END $$;

-- ============================================================
-- Block 6: Self Heal (Prunella vulgaris)
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('prunellin', 'polysaccharide',
    'Sulfated polysaccharide unique to Prunella vulgaris; significant antiviral activity against HSV and HIV.');
  PERFORM herbal.ensure_constituent('hyperoside', 'flavonol glycoside',
    'Quercetin-3-galactoside; antioxidant flavonoid glycoside co-occurring with rutin.');

  PERFORM herbal.link_constituent('Prunella vulgaris', 'rosmarinic acid', 'primary',  0);
  PERFORM herbal.link_constituent('Prunella vulgaris', 'ursolic acid',    'major',    10);
  PERFORM herbal.link_constituent('Prunella vulgaris', 'oleanolic acid',  'moderate', 20);
  PERFORM herbal.link_constituent('Prunella vulgaris', 'caffeic acid',    'moderate', 30);
  PERFORM herbal.link_constituent('Prunella vulgaris', 'rutin',           'moderate', 40);
  PERFORM herbal.link_constituent('Prunella vulgaris', 'hyperoside',      'moderate', 50);
  PERFORM herbal.link_constituent('Prunella vulgaris', 'luteolin',        'moderate', 60);
  PERFORM herbal.link_constituent('Prunella vulgaris', 'prunellin',       'moderate', 70);
  PERFORM herbal.link_constituent('Prunella vulgaris', 'tannins',         'minor',    80);

  RAISE NOTICE 'Added constituents to Self Heal (Prunella vulgaris)';
END $$;

-- ============================================================
-- Block 7: Spikenard (Aralia racemosa)
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('araloside B', 'triterpenoid saponin',
    'Oleanolic acid glycoside co-occurring with araloside A; part of the primary saponin fraction of Aralia root.');
  PERFORM herbal.ensure_constituent('continentalic acid', 'diterpene acid',
    'Characteristic resinous diterpene acid of Aralia racemosa root; contributes to stimulant and expectorant activity.');
  PERFORM herbal.ensure_constituent('kaurenoic acid', 'diterpene acid',
    'Kaurane-type diterpene present in Aralia root resin; anti-inflammatory activity.');

  PERFORM herbal.link_constituent('Aralia racemosa', 'araloside A',        'major',    0);
  PERFORM herbal.link_constituent('Aralia racemosa', 'araloside B',        'major',    10);
  PERFORM herbal.link_constituent('Aralia racemosa', 'oleanolic acid',     'moderate', 20);
  PERFORM herbal.link_constituent('Aralia racemosa', 'continentalic acid', 'moderate', 30);
  PERFORM herbal.link_constituent('Aralia racemosa', 'kaurenoic acid',     'moderate', 40);
  PERFORM herbal.link_constituent('Aralia racemosa', 'beta-sitosterol',    'moderate', 50);
  PERFORM herbal.link_constituent('Aralia racemosa', 'polyacetylenes',     'moderate', 60);
  PERFORM herbal.link_constituent('Aralia racemosa', 'caffeic acid',       'minor',    70);
  PERFORM herbal.link_constituent('Aralia racemosa', 'chlorogenic acid',   'minor',    80);

  RAISE NOTICE 'Added constituents to Spikenard (Aralia racemosa)';
END $$;

-- ============================================================
-- Block 8: Merge Chamomile stub (Matricaria chamomilla, id=2393)
--          into Chamomile (Matricaria recutita, id=84)
-- chamomilla is the currently accepted name; recutita is a synonym —
-- both refer to German chamomile. Actions: Organ Affinity - Skin.
-- ============================================================
DO $$
BEGIN
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength, body_system_note)
  SELECT 84, primary_action_id, body_system_id, relative_strength, body_system_note
  FROM herbal.herb_primary_actions
  WHERE herb_id = 2393
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  DELETE FROM herbal.herb_primary_actions WHERE herb_id = 2393;
  DELETE FROM herbal.herbs WHERE id = 2393;

  RAISE NOTICE 'Merged Chamomile stub (Matricaria chamomilla, id=2393) into Chamomile (Matricaria recutita, id=84)';
END $$;

-- ============================================================
-- Block 9: Merge Peppermint stub (Mentha x piperita, id=2410)
--          into Peppermint (Mentha piperita, id=55)
-- Same taxon; x piperita notation is the hybrid designation.
-- Actions: Organ Affinity - Digestive.
-- ============================================================
DO $$
BEGIN
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength, body_system_note)
  SELECT 55, primary_action_id, body_system_id, relative_strength, body_system_note
  FROM herbal.herb_primary_actions
  WHERE herb_id = 2410
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  DELETE FROM herbal.herb_primary_actions WHERE herb_id = 2410;
  DELETE FROM herbal.herbs WHERE id = 2410;

  RAISE NOTICE 'Merged Peppermint stub (Mentha x piperita, id=2410) into Peppermint (Mentha piperita, id=55)';
END $$;

-- ============================================================
-- Block 10: Merge Oregon Grape stub (Berberis aquifolium, id=2446)
--           into Oregon Grape (Mahonia aquifolium, id=33)
-- Berberis aquifolium is the currently accepted name; Mahonia aquifolium
-- is a synonym. Actions: Organ Affinity - Skin, Respiratory.
-- ============================================================
DO $$
BEGIN
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength, body_system_note)
  SELECT 33, primary_action_id, body_system_id, relative_strength, body_system_note
  FROM herbal.herb_primary_actions
  WHERE herb_id = 2446
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  DELETE FROM herbal.herb_primary_actions WHERE herb_id = 2446;
  DELETE FROM herbal.herbs WHERE id = 2446;

  RAISE NOTICE 'Merged Oregon Grape stub (Berberis aquifolium, id=2446) into Oregon Grape (Mahonia aquifolium, id=33)';
END $$;

-- ============================================================
-- Block 11: Merge Linden stub (Tilia spp., id=2403)
--           into Linden (Tilia platyphyllos, id=90)
-- Actions: Organ Affinity - Nervous, Cardiovascular.
-- ============================================================
DO $$
BEGIN
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength, body_system_note)
  SELECT 90, primary_action_id, body_system_id, relative_strength, body_system_note
  FROM herbal.herb_primary_actions
  WHERE herb_id = 2403
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  DELETE FROM herbal.herb_primary_actions WHERE herb_id = 2403;
  DELETE FROM herbal.herbs WHERE id = 2403;

  RAISE NOTICE 'Merged Linden stub (Tilia spp., id=2403) into Linden (Tilia platyphyllos, id=90)';
END $$;

-- ============================================================
-- Block 12: Merge Witch Hazel stub (Hamamelis spp., id=2543)
--           into Witch Hazel (Hamamelis virginiana, id=79)
-- Actions: Organ Affinity - Cardiovascular.
-- ============================================================
DO $$
BEGIN
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength, body_system_note)
  SELECT 79, primary_action_id, body_system_id, relative_strength, body_system_note
  FROM herbal.herb_primary_actions
  WHERE herb_id = 2543
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  DELETE FROM herbal.herb_primary_actions WHERE herb_id = 2543;
  DELETE FROM herbal.herbs WHERE id = 2543;

  RAISE NOTICE 'Merged Witch Hazel stub (Hamamelis spp., id=2543) into Witch Hazel (Hamamelis virginiana, id=79)';
END $$;

-- ============================================================
-- Block 13: Merge Wood Betony stub (Betonica officinalis, id=2385)
--           into Wood Betony (Stachys officinalis, id=207)
-- Betonica officinalis is a synonym for Stachys officinalis.
-- Actions: Organ Affinity - Nervous, Digestive.
-- ============================================================
DO $$
BEGIN
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength, body_system_note)
  SELECT 207, primary_action_id, body_system_id, relative_strength, body_system_note
  FROM herbal.herb_primary_actions
  WHERE herb_id = 2385
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  DELETE FROM herbal.herb_primary_actions WHERE herb_id = 2385;
  DELETE FROM herbal.herbs WHERE id = 2385;

  RAISE NOTICE 'Merged Wood Betony stub (Betonica officinalis, id=2385) into Wood Betony (Stachys officinalis, id=207)';
END $$;

-- ============================================================
-- Block 14: Merge Rosemary stub (Salvia rosmarinus, id=2384)
--           into Rosemary (Rosmarinus officinalis, id=109)
-- Salvia rosmarinus is the currently accepted name; Rosmarinus officinalis
-- is the long-standing synonym still widely used. Actions: Organ Affinity - Nervous, Skin.
-- ============================================================
DO $$
BEGIN
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength, body_system_note)
  SELECT 109, primary_action_id, body_system_id, relative_strength, body_system_note
  FROM herbal.herb_primary_actions
  WHERE herb_id = 2384
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  DELETE FROM herbal.herb_primary_actions WHERE herb_id = 2384;
  DELETE FROM herbal.herbs WHERE id = 2384;

  RAISE NOTICE 'Merged Rosemary stub (Salvia rosmarinus, id=2384) into Rosemary (Rosmarinus officinalis, id=109)';
END $$;
