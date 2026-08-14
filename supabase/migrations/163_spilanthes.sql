SET search_path TO herbal, public;

-- ── Block 1: Add herb ─────────────────────────────────────────────────────────

INSERT INTO herbal.herbs (common_name, latin_name, plant_part)
VALUES ('Spilanthes', 'Acmella oleracea', 'Aerial parts')
ON CONFLICT DO NOTHING;

DO $$ BEGIN RAISE NOTICE 'Block 1: herb inserted.'; END $$;

-- ── Block 2: Constituent profiles (user-provided) ─────────────────────────────
-- Source: user-supplied Herb Constituent Database data.
-- Class/Subclass follow that database's taxonomy (Lipid > Alkamide).
-- Editorial note placed on the Marker row per table convention.

DO $$
DECLARE v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Acmella oleracea';
  IF v_herb_id IS NULL THEN RAISE NOTICE 'Herb not found'; RETURN; END IF;

  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part,
     constituent, class, subclass, importance, status, notes, editorial_note)
  SELECT
    v_herb_id, 'Spilanthes', 'Acmella oleracea', 'Aerial parts',
    v.constituent, v.class, v.subclass, v.importance, v.status, v.notes, v.editorial_note
  FROM (VALUES
    ('Spilanthol',
     'Lipid', 'Alkamide', 'High', 'Marker',
     'Principal pungent alkamide responsible for the characteristic tingling, sialagogue, local analgesic, and anti-inflammatory activity.',
     'Acmella oleracea is chemically defined by its N-alkylamides, particularly spilanthol, which accounts for its distinctive tingling, numbing, sialagogue, analgesic, and anti-inflammatory actions. Although flavonoids and phenolic acids are also present, they are considerably less diagnostic, so this profile intentionally emphasizes the alkamide family that distinguishes Spilanthes pharmacologically and chemotaxonomically.'),
    ('N-Isobutyl-(2E,4Z,8Z,10E)-dodecatetraenamide',
     'Lipid', 'Alkamide', 'Moderate', 'Major',
     'Characteristic polyunsaturated alkamide complementing spilanthol within the species'' distinctive taste-active fraction.',
     NULL),
    ('(2E,7Z,9E)-N-Isobutylundeca-2,7,9-trienamide',
     'Lipid', 'Alkamide', 'Moderate', 'Major',
     'Characteristic unsaturated alkamide contributing to the pungent and saliva-stimulating sensory profile.',
     NULL),
    ('(2E)-N-Isobutylundeca-2-en-8,10-diynamide',
     'Lipid', 'Alkamide', 'Moderate', 'Major',
     'Acetylenic alkamide contributing to the characteristic bioactive N-alkylamide fraction.',
     NULL)
  ) AS v(constituent, class, subclass, importance, status, notes, editorial_note)
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.constituent_profiles
    WHERE herb_id = v_herb_id AND constituent = v.constituent
  );

  RAISE NOTICE 'Block 2: constituent_profiles inserted.';
END $$;

-- ── Block 3: General constituents (researched from literature) ────────────────
-- spilanthol is new to the DB; quercetin and kaempferol already exist.
-- Concentration mapping: Marker/High → primary; Major/Moderate → minor;
-- Reported flavonols → trace.

DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := (SELECT id FROM herbal.herbs WHERE latin_name = 'Acmella oleracea');
  v_c INTEGER;
BEGIN
  -- spilanthol: defining N-alkylamide marker; not yet in DB
  v_c := herbal.ensure_constituent(
    'spilanthol',
    'N-alkylamide',
    'Primary pungent alkamide of Acmella oleracea; TRP channel activator responsible for tingling sensation, local analgesia, sialagogue activity, and immunostimulant effects.'
  );
  INSERT INTO herbal.herb_constituents
    (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES
    (v_herb_id, v_c, 'primary',
     'Marker. Defines the characteristic tingling and pharmacological profile of Spilanthes.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- quercetin: flavonol reported in aerial tissues (consistent across studies)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'quercetin';
  INSERT INTO herbal.herb_constituents
    (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES
    (v_herb_id, v_c, 'minor', NULL, 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- kaempferol: flavonol reported but less consistently; flagged for review
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'kaempferol';
  INSERT INTO herbal.herb_constituents
    (herb_id, constituent_id, concentration_level, notes, needs_review, sort_order)
  VALUES
    (v_herb_id, v_c, 'trace', NULL, true, 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Block 3: herb_constituents inserted.';
END $$;

-- ── Block 4: Energetics — inference not applied ───────────────────────────────
-- Spilanthes is dominated by N-alkylamides (spilanthol class), a compound
-- group not yet covered by the inference rules in
-- docs/inferring-energetics-from-constituents.md. The pungent/tingling
-- character suggests warming, but no rule-based assignment can be made.
-- Minor quercetin/kaempferol flavonol presence would weakly suggest cooling
-- but they are not dominant. Leave temperature and moisture unset pending
-- source confirmation or a future N-alkylamide inference rule.
-- Tone is never inferred from constituents.

-- ── Block 5: Safety re-link (catches any profiles inserted before herb existed)

UPDATE herbal.constituent_profiles cp
SET herb_id = h.id
FROM herbal.herbs h
WHERE cp.latin_name = h.latin_name
  AND cp.herb_id IS NULL;

DO $$ BEGIN RAISE NOTICE 'Migration 163 (Spilanthes) complete.'; END $$;
