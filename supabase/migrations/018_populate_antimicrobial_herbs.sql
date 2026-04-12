-- Populate antimicrobial herbs for Digestive and Respiratory systems
-- From Immune System.md antimicrobial sections

SET search_path TO herbal, public;

-- ============================================================================
-- HELPER FUNCTIONS
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
-- ANTIMICROBIAL HERBS FOR DIGESTIVE SYSTEM
-- ============================================================================

DO $$
DECLARE
  v_herb_id INTEGER;
  v_action_id INTEGER;
  v_digestive_id INTEGER;
  v_respiratory_id INTEGER;
BEGIN
  -- Get or create the Antimicrobial action
  v_action_id := herbal.ensure_action('Antimicrobial');

  -- Get body system IDs
  SELECT id INTO v_digestive_id FROM herbal.body_systems WHERE name = 'Digestive';
  SELECT id INTO v_respiratory_id FROM herbal.body_systems WHERE name = 'Respiratory';

  -- ============================================================================
  -- DIGESTIVE ANTIMICROBIALS
  -- ============================================================================

  v_herb_id := herbal.ensure_herb('Allium sativum', 'garlic');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_digestive_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Artemisia absinthium', 'wormwood');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_digestive_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Capsicum annuum', 'cayenne');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_digestive_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Carum carvi', 'caraway');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_digestive_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Coriandrum sativum', 'coriander');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_digestive_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Gentiana lutea', 'gentian');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_digestive_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Hydrastis canadensis', 'goldenseal');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_digestive_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Rosmarinus officinalis', 'rosemary');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_digestive_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Syzygium aromaticum', 'clove');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_digestive_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Thymus vulgaris', 'thyme');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_digestive_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- ============================================================================
  -- RESPIRATORY ANTIMICROBIALS
  -- ============================================================================

  -- Allium sativum already created
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Allium sativum';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_respiratory_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Baptisia tinctoria', 'wild indigo');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_respiratory_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Commiphora molmol', 'myrrh');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_respiratory_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Echinacea spp.', 'echinacea');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_respiratory_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Eucalyptus spp.', 'eucalyptus');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_respiratory_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Hydrastis canadensis already created
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Hydrastis canadensis';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_respiratory_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Inula helenium already created as tonic
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Inula helenium';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_respiratory_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Ligusticum porteri', 'osha');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_respiratory_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Myroxylon balsamum var. pereirae', 'balsam of Peru');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_respiratory_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Pimpinella anisum', 'anise');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_respiratory_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Populus balsamifera var. balsamifera', 'balm of Gilead');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_respiratory_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Thymus vulgaris already created
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Thymus vulgaris';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_respiratory_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Usnea spp.', 'usnea');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_respiratory_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  RAISE NOTICE 'Antimicrobial herbs for Digestive and Respiratory systems populated successfully';
END $$;

-- Clean up helper functions
DROP FUNCTION IF EXISTS herbal.ensure_herb(TEXT, TEXT);
DROP FUNCTION IF EXISTS herbal.ensure_action(TEXT);
