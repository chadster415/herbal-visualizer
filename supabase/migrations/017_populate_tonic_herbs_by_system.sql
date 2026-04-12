-- Populate tonic herbs organized by body system
-- From Immune System.md "Tonic Herbs by system" section

SET search_path TO herbal, public;

-- ============================================================================
-- HELPER FUNCTION: Insert herb if not exists and return its ID
-- ============================================================================
CREATE OR REPLACE FUNCTION herbal.ensure_herb(p_latin_name TEXT, p_common_name TEXT)
RETURNS INTEGER AS $$
DECLARE
  v_herb_id INTEGER;
BEGIN
  INSERT INTO herbal.herbs (latin_name, common_name)
  VALUES (p_latin_name, p_common_name)
  ON CONFLICT (latin_name) DO NOTHING
  RETURNING id INTO v_herb_id;

  IF v_herb_id IS NULL THEN
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = p_latin_name;
  END IF;

  RETURN v_herb_id;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- HELPER FUNCTION: Insert action if not exists and return its ID
-- ============================================================================
CREATE OR REPLACE FUNCTION herbal.ensure_action(p_action_name TEXT)
RETURNS INTEGER AS $$
DECLARE
  v_action_id INTEGER;
BEGIN
  INSERT INTO herbal.primary_actions (name)
  VALUES (p_action_name)
  ON CONFLICT (name) DO NOTHING
  RETURNING id INTO v_action_id;

  IF v_action_id IS NULL THEN
    SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = p_action_name;
  END IF;

  RETURN v_action_id;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- TONIC HERBS BY SYSTEM
-- ============================================================================

DO $$
DECLARE
  v_herb_id INTEGER;
  v_action_id INTEGER;
  v_system_id INTEGER;
BEGIN
  -- Get or create the Tonic action
  v_action_id := herbal.ensure_action('Tonic');

  -- ============================================================================
  -- CARDIOVASCULAR TONICS
  -- ============================================================================
  SELECT id INTO v_system_id FROM herbal.body_systems WHERE name = 'Cardiovascular';

  v_herb_id := herbal.ensure_herb('Crataegus spp.', 'hawthorn');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Allium sativum', 'garlic');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Ginkgo biloba', 'ginkgo');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- ============================================================================
  -- RESPIRATORY TONICS
  -- ============================================================================
  SELECT id INTO v_system_id FROM herbal.body_systems WHERE name = 'Respiratory';

  v_herb_id := herbal.ensure_herb('Verbascum thapsus', 'mullein');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Inula helenium', 'elecampane');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- ============================================================================
  -- DIGESTIVE TONICS
  -- ============================================================================
  SELECT id INTO v_system_id FROM herbal.body_systems WHERE name = 'Digestive';

  v_herb_id := herbal.ensure_herb('Filipendula ulmaria', 'meadowsweet');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Gentiana lutea', 'gentian');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note)
  VALUES (v_herb_id, v_action_id, v_system_id, 'beneficial for the liver')
  ON CONFLICT (herb_id, primary_action_id, body_system_id)
  DO UPDATE SET body_system_note = EXCLUDED.body_system_note;

  v_herb_id := herbal.ensure_herb('Matricaria recutita', 'chamomile');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Silybum marianum', 'milk thistle');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note)
  VALUES (v_herb_id, v_action_id, v_system_id, 'beneficial for the liver')
  ON CONFLICT (herb_id, primary_action_id, body_system_id)
  DO UPDATE SET body_system_note = EXCLUDED.body_system_note;

  v_herb_id := herbal.ensure_herb('Taraxacum officinale', 'dandelion');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note)
  VALUES (v_herb_id, v_action_id, v_system_id, 'root is beneficial for the liver')
  ON CONFLICT (herb_id, primary_action_id, body_system_id)
  DO UPDATE SET body_system_note = EXCLUDED.body_system_note;

  -- ============================================================================
  -- URINARY TONICS
  -- ============================================================================
  SELECT id INTO v_system_id FROM herbal.body_systems WHERE name = 'Urinary';

  v_herb_id := herbal.ensure_herb('Arctostaphylos uva-ursi', 'bearberry');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Zea mays', 'corn silk');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- ============================================================================
  -- REPRODUCTIVE TONICS (WOMEN)
  -- ============================================================================
  SELECT id INTO v_system_id FROM herbal.body_systems WHERE name = 'Reproductive';

  v_herb_id := herbal.ensure_herb('Mitchella repens', 'partridge berry');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note)
  VALUES (v_herb_id, v_action_id, v_system_id, 'for women')
  ON CONFLICT (herb_id, primary_action_id, body_system_id)
  DO UPDATE SET body_system_note = EXCLUDED.body_system_note;

  v_herb_id := herbal.ensure_herb('Rubus idaeus', 'red raspberry');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note)
  VALUES (v_herb_id, v_action_id, v_system_id, 'for women')
  ON CONFLICT (herb_id, primary_action_id, body_system_id)
  DO UPDATE SET body_system_note = EXCLUDED.body_system_note;

  -- ============================================================================
  -- REPRODUCTIVE TONICS (MEN)
  -- ============================================================================
  v_herb_id := herbal.ensure_herb('Serenoa repens', 'saw palmetto');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note)
  VALUES (v_herb_id, v_action_id, v_system_id, 'for men')
  ON CONFLICT (herb_id, primary_action_id, body_system_id)
  DO UPDATE SET body_system_note = EXCLUDED.body_system_note;

  -- ============================================================================
  -- NERVOUS SYSTEM TONICS
  -- ============================================================================
  SELECT id INTO v_system_id FROM herbal.body_systems WHERE name = 'Nervous';

  v_herb_id := herbal.ensure_herb('Avena sativa', 'oat');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Scutellaria lateriflora', 'skullcap');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Hypericum perforatum', 'St. John''s wort');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- ============================================================================
  -- MUSCULOSKELETAL TONICS
  -- ============================================================================
  SELECT id INTO v_system_id FROM herbal.body_systems WHERE name = 'Musculoskeletal';

  v_herb_id := herbal.ensure_herb('Apium graveolens', 'celery');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Urtica dioica', 'nettle');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- ============================================================================
  -- SKIN TONICS
  -- ============================================================================
  SELECT id INTO v_system_id FROM herbal.body_systems WHERE name = 'Skin';

  v_herb_id := herbal.ensure_herb('Galium aparine', 'cleavers');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Urtica dioica already created above
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Urtica dioica';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Trifolium pratense', 'red clover');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  RAISE NOTICE 'Tonic herbs by system populated successfully';
END $$;

-- Clean up helper functions
DROP FUNCTION IF EXISTS herbal.ensure_herb(TEXT, TEXT);
DROP FUNCTION IF EXISTS herbal.ensure_action(TEXT);
