-- Migration 390: Fix missing primary actions identified by Final Exam gap analysis
--
-- Source: BHC Final Exam herb tables (all gaps verified against live DB).
--
--   California Poppy (128) — "Analgesic, Hypnotic, Sedative, Nervine Relaxant, Antispasmodic"
--                             DB was missing Analgesic and Sedative
--   Kava (138)             — "Analgesic, Antispasmodic, Hypnotic, Nervine Relaxant"
--                             DB was missing Analgesic
--   Black Walnut (288)     — "Antifungal, Anthelmintic, Antimicrobial"
--                             DB had only Antifungal (added migration 389); missing Anthelmintic + Antimicrobial
--   Clove (111)            — "Anthelmintic, Antimicrobial (mild)"
--                             DB had only Antimicrobial; missing Anthelmintic
--   Wormwood (97)          — "Anthelmintic, Antimicrobial, Carminative, Antirheumatic, Emmenagogue"
--                             DB had all except Anthelmintic
--
-- Action IDs (verified): Analgesic=167, Antimicrobial=5, Anthelmintic=1242, Sedative=1259
-- Body systems: Nervous=15, Digestive=11, Immune=17

SET search_path TO herbal, public;

DO $$
BEGIN

  -- California Poppy (id=128) — Analgesic
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (128, 167, 15, 'Analgesic; isoquinoline alkaloids dampen pain signaling; complements sedative and antispasmodic actions', 'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- California Poppy (id=128) — Sedative
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (128, 1259, 15, 'Sedative; eschscholzine and related alkaloids produce CNS calming without narcotic addiction risk', 'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Kava (id=138) — Analgesic
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (138, 167, 15, 'Analgesic; kavalactones reduce pain perception through GABA modulation and sodium channel blockade', 'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Black Walnut (id=288) — Anthelmintic
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (288, 1242, 11, 'Anthelmintic; juglone disrupts metabolic processes in intestinal parasites', 'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Black Walnut (id=288) — Antimicrobial
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (288, 5, 17, 'Antimicrobial; juglone and tannins active against bacteria and fungi', 'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Clove (id=111) — Anthelmintic
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (111, 1242, 11, 'Anthelmintic; eugenol disrupts parasite neuromuscular function', 'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Wormwood (id=97) — Anthelmintic
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (97, 1242, 11, 'Anthelmintic; absinthin and artabsin disrupt intestinal parasites; classic parasite protocol with Black Walnut and Clove', 'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  RAISE NOTICE 'Migration 390 done — 7 actions added across California Poppy, Kava, Black Walnut, Clove, Wormwood';

END $$;
