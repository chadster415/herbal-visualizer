-- Add 15 herbs with their actions to both Upper and Lower Respiratory systems
-- Source: class materials listing herbs for both respiratory systems

SET search_path TO herbal, public;

-- Temporary helper: adds an action to an herb for both respiratory systems
CREATE OR REPLACE FUNCTION herbal.temp_add_resp_action(
  p_herb_id INTEGER,
  p_action_name TEXT,
  p_upper_id INTEGER,
  p_lower_id INTEGER
) RETURNS VOID AS $$
DECLARE
  v_action_id INTEGER;
BEGIN
  v_action_id := herbal.ensure_action(p_action_name);
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (p_herb_id, v_action_id, p_upper_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (p_herb_id, v_action_id, p_lower_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
END;
$$ LANGUAGE plpgsql;

DO $$
DECLARE
  v_upper_id INTEGER;
  v_lower_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_upper_id FROM herbal.body_systems WHERE name = 'Upper Respiratory';
  SELECT id INTO v_lower_id FROM herbal.body_systems WHERE name = 'Lower Respiratory';

  -- -------------------------------------------------------------------------
  -- California Spikenard (Aralia californica)
  -- -------------------------------------------------------------------------
  v_herb_id := herbal.ensure_herb('Aralia californica', 'California spikenard');
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Soothing', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Expectorant', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Tonic', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Antimicrobial', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Anti-inflammatory', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Adaptogen', v_upper_id, v_lower_id);
  RAISE NOTICE 'Added California Spikenard (Aralia californica)';

  -- -------------------------------------------------------------------------
  -- Catnip (Nepeta cataria)
  -- -------------------------------------------------------------------------
  v_herb_id := herbal.ensure_herb('Nepeta cataria', 'catnip');
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Carminative', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Antispasmodic', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Nervine Relaxant', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Diaphoretic', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Anticatarrhal', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Astringent', v_upper_id, v_lower_id);
  RAISE NOTICE 'Added Catnip (Nepeta cataria)';

  -- -------------------------------------------------------------------------
  -- Eyebright (Euphrasia officinalis)
  -- -------------------------------------------------------------------------
  v_herb_id := herbal.ensure_herb('Euphrasia officinalis', 'eyebright');
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Anticatarrhal', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Astringent', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Anti-inflammatory', v_upper_id, v_lower_id);
  RAISE NOTICE 'Added Eyebright (Euphrasia officinalis)';

  -- -------------------------------------------------------------------------
  -- Ginkgo (Ginkgo biloba)
  -- -------------------------------------------------------------------------
  v_herb_id := herbal.ensure_herb('Ginkgo biloba', 'ginkgo');
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Anti-inflammatory', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Circulatory Tonic', v_upper_id, v_lower_id);
  RAISE NOTICE 'Added Ginkgo (Ginkgo biloba)';

  -- -------------------------------------------------------------------------
  -- Elderflower (Sambucus spp.)
  -- -------------------------------------------------------------------------
  v_herb_id := herbal.ensure_herb('Sambucus spp.', 'elderflower');
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Anticatarrhal', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Diaphoretic', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Diuretic', v_upper_id, v_lower_id);
  RAISE NOTICE 'Added Elderflower (Sambucus spp.)';

  -- -------------------------------------------------------------------------
  -- Wild Cherry Bark (Prunus serotina)
  -- -------------------------------------------------------------------------
  v_herb_id := herbal.ensure_herb('Prunus serotina', 'wild cherry bark');
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Antitussive', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Expectorant', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Astringent', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Nervine Relaxant', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Bitter', v_upper_id, v_lower_id);
  RAISE NOTICE 'Added Wild Cherry Bark (Prunus serotina)';

  -- -------------------------------------------------------------------------
  -- Coltsfoot (Tussilago farfara)
  -- -------------------------------------------------------------------------
  v_herb_id := herbal.ensure_herb('Tussilago farfara', 'coltsfoot');
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Relaxing Expectorant', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Antitussive', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Demulcent', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Anticatarrhal', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Diuretic', v_upper_id, v_lower_id);
  RAISE NOTICE 'Added Coltsfoot (Tussilago farfara)';

  -- -------------------------------------------------------------------------
  -- Western Coltsfoot (Petasites palmatus)
  -- -------------------------------------------------------------------------
  v_herb_id := herbal.ensure_herb('Petasites palmatus', 'western coltsfoot');
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Relaxing Expectorant', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Antispasmodic', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Nervine Relaxant', v_upper_id, v_lower_id);
  RAISE NOTICE 'Added Western Coltsfoot (Petasites palmatus)';

  -- -------------------------------------------------------------------------
  -- Grindelia (Grindelia camporum)
  -- -------------------------------------------------------------------------
  v_herb_id := herbal.ensure_herb('Grindelia camporum', 'grindelia');
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Stimulating Expectorant', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Antispasmodic', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Anti-inflammatory', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Diuretic', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Hypotensive', v_upper_id, v_lower_id);
  RAISE NOTICE 'Added Grindelia (Grindelia camporum)';

  -- -------------------------------------------------------------------------
  -- Pleurisy Root (Asclepias tuberosa)
  -- -------------------------------------------------------------------------
  v_herb_id := herbal.ensure_herb('Asclepias tuberosa', 'pleurisy root');
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Bitter', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Diaphoretic', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Expectorant', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Pectoral Relaxant', v_upper_id, v_lower_id);
  RAISE NOTICE 'Added Pleurisy Root (Asclepias tuberosa)';

  -- -------------------------------------------------------------------------
  -- Horehound (Marrubium vulgare)
  -- -------------------------------------------------------------------------
  v_herb_id := herbal.ensure_herb('Marrubium vulgare', 'horehound');
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Stimulating Expectorant', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Anti-inflammatory', v_upper_id, v_lower_id);
  RAISE NOTICE 'Added Horehound (Marrubium vulgare)';

  -- -------------------------------------------------------------------------
  -- Yerba Santa (Eriodictyon californicum)
  -- -------------------------------------------------------------------------
  v_herb_id := herbal.ensure_herb('Eriodictyon californicum', 'yerba santa');
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Anticatarrhal', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Anti-inflammatory', v_upper_id, v_lower_id);
  RAISE NOTICE 'Added Yerba Santa (Eriodictyon californicum)';

  -- -------------------------------------------------------------------------
  -- Devil''s Club (Oplopanax horridus)
  -- -------------------------------------------------------------------------
  v_herb_id := herbal.ensure_herb('Oplopanax horridus', 'devil''s club');
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Stimulating Expectorant', v_upper_id, v_lower_id);
  RAISE NOTICE 'Added Devil''s Club (Oplopanax horridus)';

  -- -------------------------------------------------------------------------
  -- Thyme (Thymus vulgaris)
  -- -------------------------------------------------------------------------
  v_herb_id := herbal.ensure_herb('Thymus vulgaris', 'thyme');
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Carminative', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Expectorant', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Antimicrobial', v_upper_id, v_lower_id);
  RAISE NOTICE 'Added Thyme (Thymus vulgaris)';

  -- -------------------------------------------------------------------------
  -- False Solomon''s Seal (Smilacina racemosa)
  -- -------------------------------------------------------------------------
  v_herb_id := herbal.ensure_herb('Smilacina racemosa', 'false solomon''s seal');
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Relaxing Expectorant', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Anti-inflammatory', v_upper_id, v_lower_id);
  RAISE NOTICE 'Added False Solomon''s Seal (Smilacina racemosa)';

  RAISE NOTICE 'All 15 respiratory herbs added to both Upper and Lower Respiratory systems';
END $$;

-- Clean up temporary helper
DROP FUNCTION IF EXISTS herbal.temp_add_resp_action(INTEGER, TEXT, INTEGER, INTEGER);
