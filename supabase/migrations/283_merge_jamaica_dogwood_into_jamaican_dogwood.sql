-- Migration 283: Merge Jamaica Dogwood (id=139, Piscidia erythrina) into
-- Jamaican Dogwood (id=2461, Piscidia piscipula) → retained as Piscidia spp.
--
-- P. erythrina is a legacy synonym for P. piscipula. Both refer to the same plant.
-- id=2461 has all 8 herb_pairs from Class 40 ingestion; id=139 has the older
-- primary_actions, constituents, and Class 57 snippet.  Keep id=2461, absorb 139.
--
-- Data decisions:
--   common_name : 'Jamaican Dogwood' (correct spelling, already on 2461)
--   latin_name  : 'piscidia spp.' (per user request; covers both erythrina/piscipula)
--   moisture    : 'drying' (from 139; more commonly cited in literature)
--   plant_part  : 'Root bark' (already reflected in all constituent_profiles)
--   menstruum   : widen min to 40% to encompass both source entries

SET search_path TO herbal, public;

DO $$
DECLARE
  v_note TEXT;
BEGIN

  -- ── 1. Snippet (Class 57 / Repro III) ────────────────────────────────────────
  UPDATE herbal.class_note_snippets SET herb_id = 2461 WHERE herb_id = 139;

  -- ── 2. Keywords: add dysmenorrhea + endometriosis; then remove 139 originals ──
  INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
    (2461, 'dysmenorrhea',  'ailment'),
    (2461, 'endometriosis', 'ailment')
  ON CONFLICT (herb_id, keyword) DO NOTHING;

  DELETE FROM herbal.herb_keywords WHERE herb_id = 139;

  -- ── 3. Primary actions: re-parent all 9 rows to 2461 ─────────────────────────
  --    No conflict: 2461 currently only has Organ Affinity (primary_action_id=1256)
  UPDATE herbal.herb_primary_actions SET herb_id = 2461 WHERE herb_id = 139;

  -- ── 4. Herb constituents: resolve overlaps, then re-parent unique rows ─────────
  -- Overlapping constituent_ids: 1109 piscidic acid, 1108 piscidin, 1110 rotenone, 795 tannins
  -- Update 2461's rows to the better (139's) concentration levels
  UPDATE herbal.herb_constituents SET concentration_level = 'major'    WHERE herb_id = 2461 AND constituent_id = 1109;
  UPDATE herbal.herb_constituents SET concentration_level = 'primary'  WHERE herb_id = 2461 AND constituent_id = 1108;
  UPDATE herbal.herb_constituents SET concentration_level = 'major'    WHERE herb_id = 2461 AND constituent_id = 1110;
  UPDATE herbal.herb_constituents SET concentration_level = 'moderate' WHERE herb_id = 2461 AND constituent_id = 795;

  -- Remove 139's now-superseded overlapping rows
  DELETE FROM herbal.herb_constituents
  WHERE herb_id = 139 AND constituent_id IN (1109, 1108, 1110, 795);

  -- Re-parent unique rows: biochanin A (768), formononetin (767)
  UPDATE herbal.herb_constituents SET herb_id = 2461
  WHERE herb_id = 139 AND constituent_id IN (768, 767);

  -- ── 5. Constituent profiles: add unique ones from 139 ─────────────────────────
  --    Skip Rotenone (already in 2461) and Piscidone (already in 2461, higher status)
  v_note := 'Piscidia piscipula is chemically distinguished by its rotenoids and related isoflavonoids, which account for its traditional use as an analgesic, sedative, and fish poison. Unlike most medicinal Fabaceae, Jamaican dogwood emphasizes rotenoid chemistry over triterpenoid saponins, giving it a distinctive pharmacological profile.';

  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (2461, 'Jamaican Dogwood', 'Piscidia spp.', 'Root bark',
     'Piscidin', 'Polyphenol', 'Isoflavonoid', 'High', 'Major',
     'Characteristic isoflavonoid associated with the bark''s traditional analgesic and antispasmodic activity.',
     v_note),
    (2461, 'Jamaican Dogwood', 'Piscidia spp.', 'Root bark',
     'Piscerythrol', 'Polyphenol', 'Isoflavonoid', 'Moderate', 'Major',
     'Characteristic rotenoid-related isoflavonoid complementing the bark''s distinctive chemistry.',
     v_note),
    (2461, 'Jamaican Dogwood', 'Piscidia spp.', 'Root bark',
     'Maackiain', 'Polyphenol', 'Pterocarpan', 'Moderate', 'Major',
     'Pterocarpan phytoalexin contributing antioxidant and antimicrobial activity.',
     v_note),
    (2461, 'Jamaican Dogwood', 'Piscidia spp.', 'Root bark',
     'Medicarpin', 'Polyphenol', 'Pterocarpan', 'Moderate', 'Present',
     'Characteristic pterocarpan contributing to the species'' legume phenolic profile.',
     v_note);

  -- ── 6. Update all 2461 constituent_profiles to canonical name/latin ───────────
  UPDATE herbal.constituent_profiles
  SET common_name = 'Jamaican Dogwood',
      latin_name  = 'Piscidia spp.'
  WHERE herb_id = 2461;

  -- ── 7. Menstruum: widen alcohol min to 40% (union of both source entries) ─────
  UPDATE herbal.herb_menstruum
  SET alcohol_pct_min = 40,
      notes = 'Rotenoids and isoflavonoids are moderately lipophilic; 40–65% alcohol needed for full extraction. Water decoction is less complete but captures the polar organic acid fraction (piscidic acid). Root bark is the medicinal part.'
  WHERE herb_id = 2461;

  -- ── 8. Update herb 2461 to merged canonical form ──────────────────────────────
  UPDATE herbal.herbs
  SET common_name = 'Jamaican Dogwood',
      latin_name  = 'piscidia spp.',
      plant_part  = 'Root bark',
      moisture    = 'drying'
  WHERE id = 2461;

  -- ── 9. Delete herb 139 and its remaining dependent rows ───────────────────────
  DELETE FROM herbal.constituent_profiles  WHERE herb_id = 139;
  -- herb_primary_actions, herb_constituents, class_note_snippets already re-parented above
  -- herb_keywords already deleted above
  DELETE FROM herbal.herbs WHERE id = 139;

  RAISE NOTICE 'Merge complete: Jamaica Dogwood (id=139) absorbed into Jamaican Dogwood (id=2461, now piscidia spp.)';
END $$;
