-- Migration 383: BHC Class 20 herb pairs
-- Source: BHC - Class 20 - Reproductive System 1 and Herbal First Aid - Lisa Rose.md
--
-- New pairs identified:
--   1. Usnea + Bearberry (Uva ursi) — explicitly noted together for UTIs
--   2. Comfrey + Helichrysum — "separate Comfrey + helichrysem salve for skin healing only"

SET search_path TO herbal, public;

-- ── PAIR 1: Usnea (112) + Bearberry (46) ──────────────────────────────────────
-- "Uva ursi, usnea together" for UTIs
DO $$
DECLARE
  v_pair_id integer;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(112, 46), GREATEST(112, 46),
    'BHC Apprenticeship class notes',
    'Usnea and Bearberry (Uva ursi) used together for urinary tract infections. Both are antimicrobial — Usnea for broad-spectrum action and Bearberry for urinary-specific antibacterial effect via arbutin.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(112, 46) AND herb2_id = GREATEST(112, 46);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Urinary tract infection', 10),
    ('Cystitis', 20),
    ('Bladder infection', 30)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (112, 'Broad-spectrum antimicrobial and antifungal; supports urinary tract integrity', 10),
    (46,  'Urinary-specific antimicrobial via arbutin; astringent and anti-inflammatory in the urinary tract', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
END $$;

-- ── PAIR 2: Comfrey root (89) + Helichrysum (831) ─────────────────────────────
-- "separate Comfrey + helichrysem salve for skin healing only (after the antimicrobial treatment)"
DO $$
DECLARE
  v_pair_id integer;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(89, 831), GREATEST(89, 831),
    'BHC Apprenticeship class notes',
    'Comfrey and Helichrysum combined in a salve for the final skin healing phase — used only after antimicrobial treatment is complete. Comfrey proliferates cell regeneration ("herbal stitches") while Helichrysum supports tissue repair and reduces scarring.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(89, 831) AND herb2_id = GREATEST(89, 831);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Wound healing — post-antimicrobial phase', 10),
    ('Skin repair and regeneration', 20),
    ('Cuts and scrapes (recovery phase)', 30)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (89,  'Cell proliferant — "herbal stitches"; promotes rapid tissue regeneration', 10),
    (831, 'Tissue repair and anti-inflammatory; supports skin healing and reduces scarring', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
END $$;
