-- Migration 316: Add Madrone (Arbutus menziesii, bark + leaf) to herbs table and link to class 34 snippets
--
-- Madrone was skipped in migration 314 (class 34 data) because it was not yet in the DB.
-- Added here per Step 2b of parsing-class-notes.md playbook.
--
-- Medicinal profile — bark:
--   Plant part: bark (contains arbutin and tannins — same constituent family as Manzanita and Bearberry)
--   Primary actions: Astringent, Antimicrobial
--   Body systems: Skin, Urinary
--   Key uses: Topical astringent for contact dermatitis and poison oak (tincture sprayed on spot);
--             antimicrobial for urinary tract (arbutin converts to hydroquinone in alkaline urine,
--             same mechanism as Bearberry / Uva Ursi)
--   Contraindications: Avoid extended internal use due to hydroquinone content; avoid in kidney disease.
--   Traditional use: Pacific Coast indigenous peoples used bark decoctions for skin conditions, wounds,
--                    and as a tonic astringent.
--
-- Medicinal profile — leaf:
--   Plant part: leaf (similar constituent profile to bark; slightly lower tannin content)
--   Primary actions: Astringent, Antimicrobial, Diuretic
--   Body systems: Skin, Urinary
--   Key uses: Leaf tea or tincture used for urinary tract infections (arbutin mechanism, same as bark);
--             topical wash for skin irritations and wounds; traditional use for sore throats and coughs.

SET search_path TO herbal, public;

-- =====================================================================
-- STEP 1: Add herb row
-- =====================================================================
INSERT INTO herbal.herbs (common_name, latin_name, plant_part)
VALUES ('Madrone', 'Arbutus menziesii', 'bark')
ON CONFLICT DO NOTHING;

-- =====================================================================
-- STEP 2: Add body system actions (Skin)
-- =====================================================================
DO $$
DECLARE
  v_herb_id   INTEGER;
  v_sys_id    INTEGER;
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs
  WHERE latin_name = 'Arbutus menziesii' AND plant_part = 'bark';

  IF v_herb_id IS NULL THEN
    RAISE NOTICE 'Madrone not found — skipping actions';
    RETURN;
  END IF;

  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Skin';

  -- Astringent
  v_action_id := herbal.ensure_action('Astringent');
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES
    (v_herb_id, v_action_id, v_sys_id,
     'High tannin content dries out and inactivates contact irritants (poison oak, rashes); classic Pacific Coast topical tincture.',
     'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Antimicrobial
  v_action_id := herbal.ensure_action('Antimicrobial');
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES
    (v_herb_id, v_action_id, v_sys_id,
     'Arbutin (same constituent as Bearberry) provides antimicrobial activity topically.',
     'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  RAISE NOTICE 'Madrone herb_id=% actions loaded.', v_herb_id;
END $$;

-- =====================================================================
-- STEP 3: Class 34 snippet (Rashes and Itching section)
-- Slot at sort_order 265 — between Oak (260) and Manzanita (270)
-- =====================================================================
DO $$
DECLARE
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs
  WHERE latin_name = 'Arbutus menziesii' AND plant_part = 'bark';

  IF v_herb_id IS NULL THEN
    RAISE NOTICE 'Madrone not found — skipping class 34 snippet';
    RETURN;
  END IF;

  -- Guard: only insert if snippet not already present
  IF EXISTS (
    SELECT 1 FROM herbal.class_note_snippets
    WHERE herb_id = v_herb_id
      AND class_name = 'BHC - Class 34 - Skin 2 and AMAB Repro System'
  ) THEN
    RAISE NOTICE 'Madrone class 34 snippet already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (v_herb_id,
     'Madrone: astringent tincture sprayed on contact dermatitis / poison oak to dry out and inactivate the oils.',
     'BHC - Class 34 - Skin 2 and AMAB Repro System',
     'personal',
     'Rashes and Itching',
     265,
     'Rashes and Itching
- in response to allergens or irritants
- contact dermatitis — caused by external contact
    - any sudsing saponin will remove poison oak from the skin
    - in the moment, don''t touch anything else with that affected part
    - Oak, Madrone, Manzanita — astringency will dry out and inactivate the oils
        - tinctures: Manzanita, Madrone, Ceanothus — spray on the spot
- atopic dermatitis — happening inside the body
    - want to tonify and dry these pustules, so they don''t spread
- squamous layer can get deranged, leading to excessive loss of fluids
    - stay hydrated
    - tonify the tight junctions
- herbal actions: astringent, alterative, liver support, anti-inflammatory, antihistamine, anodyne, antioxidant');

  RAISE NOTICE 'Madrone class 34 snippet loaded (herb_id=%).', v_herb_id;
END $$;

-- =====================================================================
-- STEP 4: Keywords
-- =====================================================================
DO $$
DECLARE v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs
  WHERE latin_name = 'Arbutus menziesii' AND plant_part = 'bark';
  IF v_herb_id IS NULL THEN RETURN; END IF;

  INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
    (v_herb_id, 'rashes',            'ailment'),
    (v_herb_id, 'contact dermatitis','ailment'),
    (v_herb_id, 'skin conditions',   'ailment'),
    (v_herb_id, 'wound healing',     'ailment'),
    (v_herb_id, 'astringent',        'action'),
    (v_herb_id, 'antimicrobial',     'action')
  ON CONFLICT (herb_id, keyword) DO NOTHING;

  RAISE NOTICE 'Madrone bark keywords loaded.';
END $$;

-- =====================================================================
-- STEP 5: Add Madrone leaf herb row
-- =====================================================================
INSERT INTO herbal.herbs (common_name, latin_name, plant_part)
VALUES ('Madrone', 'Arbutus menziesii', 'leaf')
ON CONFLICT DO NOTHING;

-- =====================================================================
-- STEP 6: Madrone leaf — body system actions (Skin + Urinary)
-- =====================================================================
DO $$
DECLARE
  v_herb_id   INTEGER;
  v_sys_id    INTEGER;
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs
  WHERE latin_name = 'Arbutus menziesii' AND plant_part = 'leaf';

  IF v_herb_id IS NULL THEN
    RAISE NOTICE 'Madrone leaf not found — skipping actions';
    RETURN;
  END IF;

  -- Skin system
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Skin';

  v_action_id := herbal.ensure_action('Astringent');
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES
    (v_herb_id, v_action_id, v_sys_id,
     'Leaf tea or wash used topically for skin irritations and wound healing; similar tannin action to the bark.',
     'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Antimicrobial');
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES
    (v_herb_id, v_action_id, v_sys_id,
     'Arbutin content provides topical antimicrobial activity.',
     'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Urinary system
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Urinary';

  v_action_id := herbal.ensure_action('Antimicrobial');
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES
    (v_herb_id, v_action_id, v_sys_id,
     'Arbutin converts to hydroquinone in alkaline urine — same mechanism as Bearberry (Uva Ursi); used internally for UTI.',
     'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Diuretic');
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES
    (v_herb_id, v_action_id, v_sys_id,
     'Traditional use as a mild diuretic to support urinary tract flushing.',
     'mild')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  RAISE NOTICE 'Madrone leaf herb_id=% actions loaded.', v_herb_id;
END $$;

-- =====================================================================
-- STEP 7: Madrone leaf keywords
-- =====================================================================
DO $$
DECLARE v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs
  WHERE latin_name = 'Arbutus menziesii' AND plant_part = 'leaf';
  IF v_herb_id IS NULL THEN RETURN; END IF;

  INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
    (v_herb_id, 'urinary tract infection', 'ailment'),
    (v_herb_id, 'skin conditions',         'ailment'),
    (v_herb_id, 'wound healing',           'ailment'),
    (v_herb_id, 'astringent',              'action'),
    (v_herb_id, 'antimicrobial',           'action'),
    (v_herb_id, 'diuretic',               'action')
  ON CONFLICT (herb_id, keyword) DO NOTHING;

  RAISE NOTICE 'Madrone leaf keywords loaded.';
END $$;
