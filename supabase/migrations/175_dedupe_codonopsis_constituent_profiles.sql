-- Deduplicate constituent_profiles for Codonopsis pilosula (herb_id 2407).
-- Three import batches got merged together (IDs ~1258-1263, ~1308-1313, ~2002-2007).
-- Strategy: keep the most accurate row per constituent; keep one editorial note (1258).

SET search_path TO herbal, public;

DO $$
BEGIN
  -- Tangshenoside I: keep 2002 (Marker/Phenylpropanoid glycoside/High — most accurate classification)
  -- Clear its editorial note (which describes C. tangshen, a related species, not C. pilosula)
  UPDATE herbal.constituent_profiles SET editorial_note = NULL WHERE id = 2002;
  DELETE FROM herbal.constituent_profiles WHERE id IN (1260, 1311);

  -- Lobetyolin: keep 1258 (Marker status + best editorial note summarising C. pilosula chemistry)
  DELETE FROM herbal.constituent_profiles WHERE id IN (1308, 2003);

  -- Lobetyol: keep 1259 (all three are near-identical)
  DELETE FROM herbal.constituent_profiles WHERE id IN (1309, 2004);

  -- Codonopyrrolidium A: keep 1261 (2005 references C. tangshen, less appropriate for C. pilosula)
  DELETE FROM herbal.constituent_profiles WHERE id IN (1312, 2005);

  -- Codonopsis polysaccharide (CPP-1): keep 1263 (more specific note)
  DELETE FROM herbal.constituent_profiles WHERE id = 1313;

  -- Syringin: keep 1262 (more detailed note)
  DELETE FROM herbal.constituent_profiles WHERE id = 1310;

  -- Inulin (2006) and Codonopsis polysaccharides (2007) are unique — no action needed

  RAISE NOTICE 'Deduped Codonopsis constituent_profiles: reduced from 18 to 8 rows';
END $$;
