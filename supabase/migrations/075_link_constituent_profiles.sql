-- Migration 075: Link unlinked constituent profiles and resolve seed-created duplicates
-- Connects constituent_profiles rows to their correct herb_id entries.

SET search_path TO herbal, public;

-- ─────────────────────────────────────────────────────────────────────────────
-- PART A: NULL herb_id — profiles exist but were never linked (latin name mismatch at seed time)
-- ─────────────────────────────────────────────────────────────────────────────

-- Hawthorn: Crataegus monogyna profiles → Crataegus spp. (id 73)
UPDATE herbal.constituent_profiles SET herb_id = 73
  WHERE common_name = 'Hawthorn' AND herb_id IS NULL;

-- Linden: Tilia cordata profiles → Tilia platyphyllos (id 90)
UPDATE herbal.constituent_profiles SET herb_id = 90
  WHERE common_name = 'Linden' AND herb_id IS NULL;

-- Maral Root: Rhaponticum carthamoides profiles → Leuzea carthamoides (id 12)
UPDATE herbal.constituent_profiles SET herb_id = 12
  WHERE common_name = 'Maral Root' AND herb_id IS NULL;

-- Neroli: Citrus × aurantium var. amara profiles → Citrus aurantium (id 742)
UPDATE herbal.constituent_profiles SET herb_id = 742
  WHERE common_name = 'Neroli' AND herb_id IS NULL;

-- Poppy: Papaver somniferum profiles → Papaver spp. (id 340)
UPDATE herbal.constituent_profiles SET herb_id = 340
  WHERE common_name = 'Poppy' AND herb_id IS NULL;

-- Stonebreaker: Phyllanthus niruri profiles → Phyllanthus amarus (id 222)
UPDATE herbal.constituent_profiles SET herb_id = 222
  WHERE common_name = 'Stonebreaker' AND herb_id IS NULL;

-- Oak: Quercus robur profiles → Quercus spp. (id 153)
UPDATE herbal.constituent_profiles SET herb_id = 153
  WHERE common_name = 'Oak' AND herb_id IS NULL;

-- ─────────────────────────────────────────────────────────────────────────────
-- PART B: Cinnamon — profiles were linked to Cinnamon Bark (id 1083) instead of
-- Cinnamon (id 167). Cinnamon Bark is a separate herb entry; just re-link profiles.
-- ─────────────────────────────────────────────────────────────────────────────
UPDATE herbal.constituent_profiles SET herb_id = 167
  WHERE common_name = 'Cinnamon' AND herb_id = 1083;

-- ─────────────────────────────────────────────────────────────────────────────
-- PART C: Elderflower — profiles were linked to Elder (id 57) instead of
-- Elderflower (id 583). Re-link only; Elder stays untouched.
-- ─────────────────────────────────────────────────────────────────────────────
UPDATE herbal.constituent_profiles SET herb_id = 583
  WHERE common_name = 'Elderflower' AND herb_id = 57;

-- ─────────────────────────────────────────────────────────────────────────────
-- PART D: Gumweed — merge Grindelia spp. (id 657) into Gumweed/Grindelia camporum (id 199)
-- 657 has 1 primary action and constituent profiles linked to it
-- ─────────────────────────────────────────────────────────────────────────────
DO $$
DECLARE
  v_keep_id  INTEGER := 199; -- Gumweed, Grindelia camporum
  v_drop_id  INTEGER := 657; -- Grindelia spp.
BEGIN
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT v_keep_id, primary_action_id, body_system_id
  FROM herbal.herb_primary_actions WHERE herb_id = v_drop_id
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  UPDATE herbal.constituent_profiles SET herb_id = v_keep_id WHERE herb_id = v_drop_id;

  DELETE FROM herbal.herbs WHERE id = v_drop_id;

  RAISE NOTICE 'Gumweed: Grindelia spp. (657) merged into Grindelia camporum (199) and deleted.';
END $$;

-- ─────────────────────────────────────────────────────────────────────────────
-- PART E: Tea Tree — merge Melaleuca alternifolia (id 1442) into Melaleuca spp. (id 302)
-- 1442 has 1 primary action, 1 specific remedy, and constituent profiles
-- ─────────────────────────────────────────────────────────────────────────────
DO $$
DECLARE
  v_keep_id  INTEGER := 302;  -- Tea Tree, Melaleuca spp.
  v_drop_id  INTEGER := 1442; -- Melaleuca alternifolia
BEGIN
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT v_keep_id, primary_action_id, body_system_id
  FROM herbal.herb_primary_actions WHERE herb_id = v_drop_id
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description)
  SELECT disorder_id, v_keep_id, description
  FROM herbal.disorder_specific_remedies WHERE herb_id = v_drop_id
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  UPDATE herbal.constituent_profiles SET herb_id = v_keep_id WHERE herb_id = v_drop_id;

  DELETE FROM herbal.herbs WHERE id = v_drop_id;

  RAISE NOTICE 'Tea Tree: Melaleuca alternifolia (1442) merged into Melaleuca spp. (302) and deleted.';
END $$;

-- ─────────────────────────────────────────────────────────────────────────────
-- PART F: Wood Betony — merge Stachys betonica (id 892) into Stachys officinalis (id 207)
-- 892 has 1 specific remedy; constituent profiles already correctly on 207
-- ─────────────────────────────────────────────────────────────────────────────
DO $$
DECLARE
  v_keep_id  INTEGER := 207; -- Wood Betony, Stachys officinalis (has profiles + actions)
  v_drop_id  INTEGER := 892; -- Stachys betonica
BEGIN
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT v_keep_id, primary_action_id, body_system_id
  FROM herbal.herb_primary_actions WHERE herb_id = v_drop_id
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description)
  SELECT disorder_id, v_keep_id, description
  FROM herbal.disorder_specific_remedies WHERE herb_id = v_drop_id
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  DELETE FROM herbal.herbs WHERE id = v_drop_id;

  RAISE NOTICE 'Wood Betony: Stachys betonica (892) merged into Stachys officinalis (207) and deleted.';
END $$;

-- ─────────────────────────────────────────────────────────────────────────────
-- PART G: Plantain — merge Plantago spp. (id 1428) into Plantago major (id 85)
-- 1428 has 1 primary action and 2 specific remedies; constituent profiles already on 85
-- ─────────────────────────────────────────────────────────────────────────────
DO $$
DECLARE
  v_keep_id  INTEGER := 85;   -- Plantain, Plantago major (has profiles + actions)
  v_drop_id  INTEGER := 1428; -- Plantago spp.
BEGIN
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT v_keep_id, primary_action_id, body_system_id
  FROM herbal.herb_primary_actions WHERE herb_id = v_drop_id
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description)
  SELECT disorder_id, v_keep_id, description
  FROM herbal.disorder_specific_remedies WHERE herb_id = v_drop_id
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  DELETE FROM herbal.herbs WHERE id = v_drop_id;

  RAISE NOTICE 'Plantain: Plantago spp. (1428) merged into Plantago major (85) and deleted.';
END $$;

-- ─────────────────────────────────────────────────────────────────────────────
-- PART H: Motherwort — add Marker constituents and editorial note
-- herb_id 131, Leonurus cardiaca
-- Stachydrine upgraded Major → Marker; Leonurine added as new Marker row
-- ─────────────────────────────────────────────────────────────────────────────
DO $$
DECLARE
  v_herb_id  INTEGER := 131;
  v_note     TEXT := 'Motherwort is chemically defined by its alkaloid fraction, particularly leonurine and stachydrine, which account for much of its traditional cardiotonic, uterine tonic, and nervine activity. The inclusion of characteristic phenylethanoid glycosides preserves the complementary antioxidant fraction while maintaining emphasis on the alkaloid chemistry that distinguishes the genus Leonurus.';
BEGIN
  -- Upgrade Stachydrine from Major to Marker
  UPDATE herbal.constituent_profiles
    SET status = 'Marker', importance = 'High'
    WHERE herb_id = v_herb_id AND constituent = 'Stachydrine';

  -- Add Leonurine as a new Marker row (the genus-defining alkaloid)
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes)
  VALUES
    (v_herb_id, 'Motherwort', 'Leonurus cardiaca', 'Aerial parts', 'Leonurine',
     'Alkaloid', 'Guanidine alkaloid', 'High', 'Marker',
     'Chemotaxonomically defining alkaloid of the genus; contributes cardiotonic and uterine tonic activity.')
  ON CONFLICT DO NOTHING;

  -- Apply editorial note to all rows
  UPDATE herbal.constituent_profiles SET editorial_note = v_note
    WHERE herb_id = v_herb_id AND (editorial_note IS NULL OR editorial_note = '');

  RAISE NOTICE 'Motherwort: Stachydrine upgraded to Marker, Leonurine added, editorial note applied.';
END $$;

-- ─────────────────────────────────────────────────────────────────────────────
-- PART I: Solomon's Seal — upgrade Diosgenin to Marker and add editorial note
-- herb_id 1252, Polygonatum biflorum
-- ─────────────────────────────────────────────────────────────────────────────
DO $$
DECLARE
  v_herb_id  INTEGER := 1252;
  v_note     TEXT := 'Solomon''s Seal is chemically defined by its steroidal saponins, particularly diosgenin-based compounds, which account for much of its traditional musculoskeletal, connective tissue, and restorative activity. The characteristic storage polysaccharides contribute demulcent and immunomodulatory properties, while the dominant steroidal chemistry distinguishes the rhizome and underlies its reputation as a tissue trophorestorative.';
BEGIN
  -- Upgrade Diosgenin from Major to Marker
  UPDATE herbal.constituent_profiles
    SET status = 'Marker'
    WHERE herb_id = v_herb_id AND constituent = 'Diosgenin';

  -- Apply editorial note to all rows
  UPDATE herbal.constituent_profiles SET editorial_note = v_note
    WHERE herb_id = v_herb_id AND (editorial_note IS NULL OR editorial_note = '');

  RAISE NOTICE 'Solomon''s Seal: Diosgenin upgraded to Marker, editorial note applied.';
END $$;
