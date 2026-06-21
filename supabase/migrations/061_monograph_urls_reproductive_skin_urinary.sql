-- Migration 061: Add monograph URLs for Reproductive, Skin/Musculoskeletal,
-- and Urinary herbs from BHC Apprenticeship class materials.
-- New herbs (not yet in DB): Ocotillo, Pine Pollen, Shatavari, Arnica,
-- Manzanita, Solomon's Seal.

SET search_path TO herbal, public;

DO $$
DECLARE
  v_herb_id INTEGER;
BEGIN

  -- ============================================================
  -- REPRODUCTIVE
  -- ============================================================

  UPDATE herbal.herbs
    SET monograph_url = 'https://docs.google.com/document/d/1AAcEtBF7qNH-NorywkqhL3lJ9_Dr_uNuXl32izZokfY/edit?tab=t.0'
    WHERE latin_name = 'Viburnum opulus';  -- cramp bark

  UPDATE herbal.herbs
    SET monograph_url = 'https://docs.google.com/document/d/1NXoivzHpA80OwgGcdaiz8TLdvC6zuqy0wNZzh0rMwUE/edit?tab=t.0'
    WHERE latin_name = 'Angelica sinensis';  -- dong quai

  -- Ocotillo — not previously in DB
  v_herb_id := herbal.ensure_herb('Fouquieria splendens', 'Ocotillo');
  UPDATE herbal.herbs
    SET monograph_url = 'https://docs.google.com/document/d/18R8y5TBb4_alh4oq8-dEWRC_GM5cL8dubeX7OZq8nHc/edit?tab=t.0'
    WHERE id = v_herb_id;

  UPDATE herbal.herbs
    SET monograph_url = 'https://docs.google.com/document/d/1dFgfoficerlmhv9JGjIMYoC7uIy8vmKuoRxW69JAtZ8/edit?tab=t.0'
    WHERE latin_name = 'Mitchella repens';  -- partridgeberry

  -- Pine Pollen — not previously in DB
  v_herb_id := herbal.ensure_herb('Pinus sylvestris', 'Pine Pollen');
  UPDATE herbal.herbs
    SET monograph_url = 'https://docs.google.com/document/d/1GzMTyXXp3LSfYplmSibNBBZtYtUHlYd1iFpSkrZvBE0/edit?tab=t.0'
    WHERE id = v_herb_id;

  -- Raspberry — common_name varies in DB ('raspberry leaf' / 'red raspberry');
  -- match by latin_name to be safe
  UPDATE herbal.herbs
    SET monograph_url = 'https://docs.google.com/document/d/1FohWPAJg-4QkK_uVD6eGG39RDQei_SIngAP3x2t7cIo/edit?tab=t.0'
    WHERE latin_name = 'Rubus idaeus';

  UPDATE herbal.herbs
    SET monograph_url = 'https://docs.google.com/document/d/1l_0y6A-XGGWWziKdjalnzpOJ0N-Y8jIB4E3xhl6auYM/edit?tab=t.0'
    WHERE latin_name = 'Salvia officinalis';  -- sage

  UPDATE herbal.herbs
    SET monograph_url = 'https://docs.google.com/document/d/1ugIPiF61HdjDirzF94V9lJRNqUxUGbDocpQO0ovyshA/edit?tab=t.0'
    WHERE latin_name = 'Serenoa repens';  -- saw palmetto

  -- Shatavari — not previously in DB
  v_herb_id := herbal.ensure_herb('Asparagus racemosus', 'Shatavari');
  UPDATE herbal.herbs
    SET monograph_url = 'https://docs.google.com/document/d/11Yugo0XIoOr032L5gK9qXlTHEzx3zcEF8ytTyRa07Gc/edit?tab=t.0'
    WHERE id = v_herb_id;

  UPDATE herbal.herbs
    SET monograph_url = 'https://docs.google.com/document/d/1SBKbF6kzlE10QobJyGV2uY2ZD-fpg9zjtMYkJCoCPMI/edit?tab=t.0'
    WHERE latin_name = 'Dioscorea villosa';  -- wild yam


  -- ============================================================
  -- SKIN AND MUSCULOSKELETAL
  -- ============================================================

  -- Arnica — not previously in DB
  v_herb_id := herbal.ensure_herb('Arnica montana', 'Arnica');
  UPDATE herbal.herbs
    SET monograph_url = 'https://docs.google.com/document/d/1OnUJ3TWmhAD5hxAUtXYhvAtztWrrL9_Tp_YNlxOw-18/edit?tab=t.0'
    WHERE id = v_herb_id;

  UPDATE herbal.herbs
    SET monograph_url = 'https://docs.google.com/document/d/1GRAldCdeuPAARgaU9hCP-Who3BO3Lqe2xu6LOKwhNss/edit?tab=t.0'
    WHERE latin_name = 'Calendula officinalis';  -- calendula

  UPDATE herbal.herbs
    SET monograph_url = 'https://docs.google.com/document/d/1ucGtHC4pDuldnvht2D_inPPs6MdxIdqOsWo84YE6WNA/edit?tab=t.0'
    WHERE latin_name = 'Larrea tridentata';  -- chaparral

  UPDATE herbal.herbs
    SET monograph_url = 'https://docs.google.com/document/d/1YpgcAP6j8Djc8lLuGPuGWV__CjyEdyqAdTJSBqElkpk/edit?tab=t.0'
    WHERE latin_name = 'Symphytum officinale';  -- comfrey

  -- Solomon's Seal — not previously in DB (distinct from False Solomon's Seal
  -- / Smilacina racemosa which is already in DB)
  v_herb_id := herbal.ensure_herb('Polygonatum biflorum', 'Solomon''s Seal');
  UPDATE herbal.herbs
    SET monograph_url = 'https://docs.google.com/document/d/1ysXLUPIpN04ef-orudMU9llllca7bYNVyw1Ue1wBRgk/edit?tab=t.0'
    WHERE id = v_herb_id;


  -- ============================================================
  -- URINARY
  -- ============================================================

  UPDATE herbal.herbs
    SET monograph_url = 'https://docs.google.com/document/d/1cSFJ36XpTuaXqgluAQBde9rvo4XbLM_11AyZVvDh__A/edit?tab=t.0'
    WHERE latin_name = 'Agrimonia eupatoria';  -- agrimony

  UPDATE herbal.herbs
    SET monograph_url = 'https://docs.google.com/document/d/1EX3J5MjiHrDSAvenmIfOmklE4O9DK-BNkjAk8HXYnnk/edit?tab=t.0'
    WHERE latin_name = 'Galium aparine';  -- cleavers

  UPDATE herbal.herbs
    SET monograph_url = 'https://docs.google.com/document/d/1v7upDA9aSShyMBbHP9w0sRg0wdUFgDEEsMCHAfopyN8/edit?tab=t.0'
    WHERE latin_name = 'Zea mays';  -- corn silk

  UPDATE herbal.herbs
    SET monograph_url = 'https://docs.google.com/document/d/1I2kd_372kZKUIo3QWgqrWPrwjdz0Svlyv9pu512gVXY/edit?tab=t.0'
    WHERE latin_name = 'Vaccinium macrocarpon';  -- cranberry

  -- Dandelion — replaces earlier URL from migration 050 (Digestive system)
  UPDATE herbal.herbs
    SET monograph_url = 'https://docs.google.com/document/d/1kuHDaicHrEx3WE5JsVgm0Nmrb5ld8DX2pnEFHbrZnRI/edit?tab=t.0'
    WHERE latin_name = 'Taraxacum officinale';

  UPDATE herbal.herbs
    SET monograph_url = 'https://docs.google.com/document/d/1TMVYtXeBP03otOI7d0--NmAFCyHvkDggiZ5aEbLCFlw/edit?tab=t.0'
    WHERE latin_name = 'Equisetum arvense';  -- horsetail

  UPDATE herbal.herbs
    SET monograph_url = 'https://docs.google.com/document/d/1bB3-uDAdgIAP4hTBmCQ6CBO16VtZ7nksdNDmOW6Vapc/edit?tab=t.0'
    WHERE latin_name = 'Juniperus communis';  -- juniper

  -- Manzanita — not previously in DB
  v_herb_id := herbal.ensure_herb('Arctostaphylos manzanita', 'Manzanita');
  UPDATE herbal.herbs
    SET monograph_url = 'https://docs.google.com/document/d/1Axj3gCJPlwQBA9qnYnxHe9k9Q10qWIirbZfbbz8BoVg/edit?tab=t.0'
    WHERE id = v_herb_id;

  UPDATE herbal.herbs
    SET monograph_url = 'https://docs.google.com/document/d/1kK2jup24D7dRb4J86Qn9igpoZMKYXKIjynvXZj1yqAc/edit?tab=t.0'
    WHERE latin_name = 'Urtica dioica';  -- nettle

  UPDATE herbal.herbs
    SET monograph_url = 'https://docs.google.com/document/d/1Pi14avxpxQL0ghD0deMazGMRH0Nxg6YEqJuQFDAIW7w/edit?tab=t.0'
    WHERE latin_name = 'Arctostaphylos uva-ursi';  -- uva ursi

  RAISE NOTICE 'Monograph URLs set for 25 Reproductive, Skin/Musculoskeletal, and Urinary herbs (6 new herbs created).';
END $$;
