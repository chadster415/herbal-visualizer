-- Populate Immune System Specific Remedies
-- Based on "Immune System 2.md" - adds specific remedy herbs with their notes
-- This is the correct version that runs AFTER the disorders are created in migration 025

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

-- ============================================================================
-- EAR INFECTIONS
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Ear Infections';

  IF v_disorder_id IS NULL THEN
    RAISE NOTICE 'Disorder "Ear Infections" not found, skipping';
  ELSE
    -- Echinacea spp.
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 1)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Yerba Mansa
    v_herb_id := herbal.ensure_herb('Anemopsis californica', 'yerba mansa');
    INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, v_herb_id, '', 2)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

    -- Mullein
    v_herb_id := herbal.ensure_herb('Verbascum thapsus', 'mullein');
    INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, v_herb_id, 'external, flower oil', 3)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

    RAISE NOTICE 'Specific remedies added for Ear Infections';
  END IF;
END $$;

-- ============================================================================
-- SORE THROAT
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Sore Throat';

  IF v_disorder_id IS NULL THEN
    RAISE NOTICE 'Disorder "Sore Throat" not found, skipping';
  ELSE
    -- Echinacea
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 1)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Licorice
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Glycyrrhiza glabra';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 2)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Garlic
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Allium sativum';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 3)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Ceanothus (Red Root)
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Ceanothus americanus';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 4)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Sage
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Salvia officinalis';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, 'essential oil, gargle', 5)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    RAISE NOTICE 'Specific remedies added for Sore Throat';
  END IF;
END $$;

-- ============================================================================
-- CONGESTION
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Congestion';

  IF v_disorder_id IS NULL THEN
    RAISE NOTICE 'Disorder "Congestion" not found, skipping';
  ELSE
    -- Elder
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Sambucus nigra';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, 'flowers', 1)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Peppermint (first instance)
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Mentha piperita';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 2)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Yerba Mansa
    v_herb_id := herbal.ensure_herb('Anemopsis californica', 'yerba mansa');
    INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, v_herb_id, '', 3)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

    -- Lavender
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Lavandula angustifolia';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, 'inhalant, EO', 4)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Eucalyptus
    v_herb_id := herbal.ensure_herb('Eucalyptus globulus', 'eucalyptus');
    INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, v_herb_id, 'inhalant', 5)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

    -- Peppermint (inhalant - already added above, update description)
    -- Note: Can't add duplicate, already exists

    -- Thyme
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Thymus vulgaris';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, 'inhalant', 6)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    RAISE NOTICE 'Specific remedies added for Congestion';
  END IF;
END $$;

-- ============================================================================
-- SWOLLEN GLANDS
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Swollen Glands';

  IF v_disorder_id IS NULL THEN
    RAISE NOTICE 'Disorder "Swollen Glands" not found, skipping';
  ELSE
    -- Cleavers
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Galium aparine';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 1)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Elder
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Sambucus nigra';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, 'flowers', 2)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Sassafras
    v_herb_id := herbal.ensure_herb('Sassafras albidum', 'sassafras');
    INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, v_herb_id, '', 3)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

    -- Echinacea
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 4)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Red root (Ceanothus)
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Ceanothus americanus';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 5)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Poke
    v_herb_id := herbal.ensure_herb('Phytolacca americana', 'poke');
    INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, v_herb_id, 'root', 6)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

    RAISE NOTICE 'Specific remedies added for Swollen Glands';
  END IF;
END $$;

-- ============================================================================
-- MUMPS
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Mumps';

  IF v_disorder_id IS NULL THEN
    RAISE NOTICE 'Disorder "Mumps" not found, skipping';
  ELSE
    -- Echinacea
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 1)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Cleavers
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Galium aparine';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 2)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Goldenseal
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Hydrastis canadensis';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 3)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Garlic
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Allium sativum';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 4)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Myrrh
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Commiphora molmol';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 5)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    RAISE NOTICE 'Specific remedies added for Mumps';
  END IF;
END $$;

-- ============================================================================
-- FLU
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Flu';

  IF v_disorder_id IS NULL THEN
    RAISE NOTICE 'Disorder "Flu" not found, skipping';
  ELSE
    -- Peppermint
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Mentha piperita';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 1)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Echinacea
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 2)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Elder
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Sambucus nigra';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 3)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Valerian
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Valeriana officinalis';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 4)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    RAISE NOTICE 'Specific remedies added for Flu';
  END IF;
END $$;

-- ============================================================================
-- COLDS
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Colds';

  IF v_disorder_id IS NULL THEN
    RAISE NOTICE 'Disorder "Colds" not found, skipping';
  ELSE
    -- Echinacea
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 1)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Cleavers
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Galium aparine';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 2)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Garlic
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Allium sativum';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 3)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Peppermint
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Mentha piperita';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 4)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Yarrow
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Achillea millefolium';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 5)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    RAISE NOTICE 'Specific remedies added for Colds';
  END IF;
END $$;

-- ============================================================================
-- COUGH (SOOTHE)
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Cough (soothe)';

  IF v_disorder_id IS NULL THEN
    RAISE NOTICE 'Disorder "Cough (soothe)" not found, skipping';
  ELSE
    -- Garlic
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Allium sativum';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 1)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Licorice
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Glycyrrhiza glabra';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 2)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Cleavers
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Galium aparine';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 3)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Echinacea
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 4)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    RAISE NOTICE 'Specific remedies added for Cough (soothe)';
  END IF;
END $$;

-- ============================================================================
-- COUGH (SUPPRESS)
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Cough (suppress)';

  IF v_disorder_id IS NULL THEN
    RAISE NOTICE 'Disorder "Cough (suppress)" not found, skipping';
  ELSE
    -- Wild cherry
    v_herb_id := herbal.ensure_herb('Prunus serotina', 'wild cherry');
    INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, v_herb_id, 'bark', 1)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

    -- Licorice
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Glycyrrhiza glabra';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 2)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Peppermint
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Mentha piperita';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 3)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    RAISE NOTICE 'Specific remedies added for Cough (suppress)';
  END IF;
END $$;

-- ============================================================================
-- LARYNGITIS
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Laryngitis';

  IF v_disorder_id IS NULL THEN
    RAISE NOTICE 'Disorder "Laryngitis" not found, skipping';
  ELSE
    -- Myrrh
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Commiphora molmol';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 1)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Cayenne
    v_herb_id := herbal.ensure_herb('Capsicum annuum', 'cayenne');
    INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, v_herb_id, 'gargle', 2)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

    RAISE NOTICE 'Specific remedies added for Laryngitis';
  END IF;
END $$;

-- ============================================================================
-- ACUTE BRONCHITIS
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Acute Bronchitis';

  IF v_disorder_id IS NULL THEN
    RAISE NOTICE 'Disorder "Acute Bronchitis" not found, skipping';
  ELSE
    -- Echinacea
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 1)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Elecampane
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Inula helenium';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 2)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Licorice
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Glycyrrhiza glabra';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 3)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Elder
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Sambucus nigra';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, 'flower', 4)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Ginger
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Zingiber officinale';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, 'compress', 5)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    RAISE NOTICE 'Specific remedies added for Acute Bronchitis';
  END IF;
END $$;

-- ============================================================================
-- PNEUMONIA
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Pneumonia';

  IF v_disorder_id IS NULL THEN
    RAISE NOTICE 'Disorder "Pneumonia" not found, skipping';
  ELSE
    -- Garlic
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Allium sativum';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 1)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Elecampane
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Inula helenium';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 2)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Yarrow
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Achillea millefolium';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 3)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Licorice
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Glycyrrhiza glabra';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 4)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Valerian
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Valeriana officinalis';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 5)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Echinacea
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 6)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    RAISE NOTICE 'Specific remedies added for Pneumonia';
  END IF;
END $$;

-- ============================================================================
-- COLIC/GASTRITIS
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Colic/Gastritis';

  IF v_disorder_id IS NULL THEN
    RAISE NOTICE 'Disorder "Colic/Gastritis" not found, skipping';
  ELSE
    -- Slippery elm
    v_herb_id := herbal.ensure_herb('Ulmus rubra', 'slippery elm');
    INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, v_herb_id, 'as a gruel', 1)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

    -- Ginger
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Zingiber officinale';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 2)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Catnip
    v_herb_id := herbal.ensure_herb('Nepeta cataria', 'catnip');
    INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, v_herb_id, '', 3)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

    RAISE NOTICE 'Specific remedies added for Colic/Gastritis';
  END IF;
END $$;

-- ============================================================================
-- CONSTIPATION
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Constipation';

  IF v_disorder_id IS NULL THEN
    RAISE NOTICE 'Disorder "Constipation" not found, skipping';
  ELSE
    -- Licorice
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Glycyrrhiza glabra';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 1)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    RAISE NOTICE 'Specific remedies added for Constipation';
  END IF;
END $$;

-- ============================================================================
-- DIARRHEA
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Diarrhea';

  IF v_disorder_id IS NULL THEN
    RAISE NOTICE 'Disorder "Diarrhea" not found, skipping';
  ELSE
    -- Licorice
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Glycyrrhiza glabra';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 1)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    RAISE NOTICE 'Specific remedies added for Diarrhea';
  END IF;
END $$;

-- ============================================================================
-- NAUSEA
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Nausea';

  IF v_disorder_id IS NULL THEN
    RAISE NOTICE 'Disorder "Nausea" not found, skipping';
  ELSE
    -- Peppermint
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Mentha piperita';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 1)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Ginger
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Zingiber officinale';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 2)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Angelica
    v_herb_id := herbal.ensure_herb('Angelica archangelica', 'angelica');
    INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, v_herb_id, '', 3)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

    -- Marshmallow
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Althaea officinalis';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 4)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Chamomile
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Matricaria chamomilla';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 5)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Peach
    v_herb_id := herbal.ensure_herb('Prunus persica', 'peach');
    INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, v_herb_id, 'leaf', 6)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

    RAISE NOTICE 'Specific remedies added for Nausea';
  END IF;
END $$;

-- ============================================================================
-- FEVERS
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Fevers';

  IF v_disorder_id IS NULL THEN
    RAISE NOTICE 'Disorder "Fevers" not found, skipping';
  ELSE
    -- Elder
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Sambucus nigra';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, 'flowers', 1)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Peppermint
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Mentha piperita';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 2)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Yarrow
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Achillea millefolium';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 3)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Catnip (first instance)
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Nepeta cataria';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 4)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Echinacea
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 5)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Catnip (external - already added above, can't add duplicate)
    -- Note: The note "external, as a bath or with ACV" can't be added without duplicating

    RAISE NOTICE 'Specific remedies added for Fevers';
  END IF;
END $$;

-- ============================================================================
-- CHICKEN POX
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Chicken Pox';

  IF v_disorder_id IS NULL THEN
    RAISE NOTICE 'Disorder "Chicken Pox" not found, skipping';
  ELSE
    -- Oats
    v_herb_id := herbal.ensure_herb('Avena sativa', 'oats');
    INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, v_herb_id, '', 1)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

    -- Echinacea
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 2)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Chickweed
    v_herb_id := herbal.ensure_herb('Stellaria media', 'chickweed');
    INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, v_herb_id, 'external, as a wash', 3)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

    RAISE NOTICE 'Specific remedies added for Chicken Pox';
  END IF;
END $$;

-- ============================================================================
-- RESTLESSNESS
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Restlessness';

  IF v_disorder_id IS NULL THEN
    RAISE NOTICE 'Disorder "Restlessness" not found, skipping';
  ELSE
    -- Chamomile
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Matricaria chamomilla';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 1)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Catnip
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Nepeta cataria';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 2)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- California Poppy
    v_herb_id := herbal.ensure_herb('Eschscholzia californica', 'california poppy');
    INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, v_herb_id, '', 3)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

    -- Lavender
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Lavandula angustifolia';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, 'EO, external', 4)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    RAISE NOTICE 'Specific remedies added for Restlessness';
  END IF;
END $$;

-- ============================================================================
-- CLEANUP
-- ============================================================================
DROP FUNCTION IF EXISTS herbal.ensure_herb(TEXT, TEXT);

-- ============================================================================
-- SUMMARY
-- ============================================================================
-- This migration adds specific remedy herbs for immune system disorders
-- Each herb has its associated notes (if any) stored in the description field
-- The data comes from "Immune System 2.md"
