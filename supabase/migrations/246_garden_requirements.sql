SET search_path TO herbal, public;

-- ── 1. Create ENUM types ──────────────────────────────────────────────────────

DO $$ BEGIN
  CREATE TYPE herbal.sun_requirement AS ENUM (
    'full_sun',
    'full_sun_to_partial_shade',
    'partial_shade',
    'partial_shade_to_shade',
    'shade'
  );
  RAISE NOTICE 'Created sun_requirement enum';
EXCEPTION WHEN duplicate_object THEN
  RAISE NOTICE 'sun_requirement enum already exists';
END $$;

DO $$ BEGIN
  CREATE TYPE herbal.water_need AS ENUM (
    'dry',
    'dry_to_moderate',
    'moderate',
    'moderate_to_moist',
    'moist'
  );
  RAISE NOTICE 'Created water_need enum';
EXCEPTION WHEN duplicate_object THEN
  RAISE NOTICE 'water_need enum already exists';
END $$;

DO $$ BEGIN
  CREATE TYPE herbal.soil_fertility AS ENUM (
    'low',
    'low_to_moderate',
    'moderate',
    'moderate_to_rich',
    'rich'
  );
  RAISE NOTICE 'Created soil_fertility enum';
EXCEPTION WHEN duplicate_object THEN
  RAISE NOTICE 'soil_fertility enum already exists';
END $$;

-- ── 2. Add columns to herbs ───────────────────────────────────────────────────

DO $$ BEGIN
  ALTER TABLE herbal.herbs ADD COLUMN sun_requirement herbal.sun_requirement;
  RAISE NOTICE 'Added sun_requirement column';
EXCEPTION WHEN duplicate_column THEN
  RAISE NOTICE 'sun_requirement already exists';
END $$;

DO $$ BEGIN
  ALTER TABLE herbal.herbs ADD COLUMN water_need herbal.water_need;
  RAISE NOTICE 'Added water_need column';
EXCEPTION WHEN duplicate_column THEN
  RAISE NOTICE 'water_need already exists';
END $$;

DO $$ BEGIN
  ALTER TABLE herbal.herbs ADD COLUMN soil_fertility herbal.soil_fertility;
  RAISE NOTICE 'Added soil_fertility column';
EXCEPTION WHEN duplicate_column THEN
  RAISE NOTICE 'soil_fertility already exists';
END $$;

-- ── 3. Populate garden data from worksheet ────────────────────────────────────
-- Key:
--   Sun:   FS=full_sun  FS/PS=full_sun_to_partial_shade  PS=partial_shade
--          S/PS or PS/S or PS/SH = partial_shade_to_shade  S=shade
--   Water: Dry=dry  Dry/mod=dry_to_moderate  Mod=moderate
--          Mod/Moist=moderate_to_moist  Moist=moist  Low≈dry
--   Soil:  Low=low  Low/Mod=low_to_moderate  Average/Mod=moderate
--          Mod/Rich=moderate_to_rich  Rich=rich

DO $$
BEGIN
  -- Ashwagandha: Average, Dry–Mod, FS
  UPDATE herbal.herbs SET soil_fertility = 'moderate', water_need = 'dry_to_moderate', sun_requirement = 'full_sun'
  WHERE common_name ILIKE '%ashwagandha%';

  -- Burdock: Rich, Mod, FS/PS
  UPDATE herbal.herbs SET soil_fertility = 'rich', water_need = 'moderate', sun_requirement = 'full_sun_to_partial_shade'
  WHERE common_name ILIKE '%burdock%';

  -- Calendula: Average, Mod, FS
  UPDATE herbal.herbs SET soil_fertility = 'moderate', water_need = 'moderate', sun_requirement = 'full_sun'
  WHERE common_name ILIKE '%calendula%';

  -- Catnip: Mod/Rich, Mod, FS/PS
  UPDATE herbal.herbs SET soil_fertility = 'moderate_to_rich', water_need = 'moderate', sun_requirement = 'full_sun_to_partial_shade'
  WHERE common_name ILIKE '%catnip%';

  -- Chamomile: Mod, Mod, S/PS (shade to partial shade)
  UPDATE herbal.herbs SET soil_fertility = 'moderate', water_need = 'moderate', sun_requirement = 'partial_shade_to_shade'
  WHERE common_name ILIKE '%chamomile%';

  -- Dandelion: Mod, Mod, S/PS (both root and leaf)
  UPDATE herbal.herbs SET soil_fertility = 'moderate', water_need = 'moderate', sun_requirement = 'partial_shade_to_shade'
  WHERE common_name ILIKE '%dandelion%';

  -- Echinacea: Mod, Dry/Mod, FS (both species)
  UPDATE herbal.herbs SET soil_fertility = 'moderate', water_need = 'dry_to_moderate', sun_requirement = 'full_sun'
  WHERE common_name ILIKE '%echinacea%';

  -- Elecampane: Mod, Mod, FS
  UPDATE herbal.herbs SET soil_fertility = 'moderate', water_need = 'moderate', sun_requirement = 'full_sun'
  WHERE common_name ILIKE '%elecampane%';

  -- Garlic: Rich (+ spring feeding), Dry/Mod, FS
  UPDATE herbal.herbs SET soil_fertility = 'rich', water_need = 'dry_to_moderate', sun_requirement = 'full_sun'
  WHERE common_name ILIKE '%garlic%';

  -- Gotu Kola: Rich, Moist, PS/SH
  UPDATE herbal.herbs SET soil_fertility = 'rich', water_need = 'moist', sun_requirement = 'partial_shade_to_shade'
  WHERE common_name ILIKE '%gotu kola%';

  -- Grindelia: Low/Mod, Dry, FS
  UPDATE herbal.herbs SET soil_fertility = 'low_to_moderate', water_need = 'dry', sun_requirement = 'full_sun'
  WHERE common_name ILIKE '%grindelia%';

  -- Lemon Balm: Mod/Rich, Mod/Moist, PS
  UPDATE herbal.herbs SET soil_fertility = 'moderate_to_rich', water_need = 'moderate_to_moist', sun_requirement = 'partial_shade'
  WHERE common_name ILIKE '%lemon balm%';

  -- Mugwort: Moderate, Dry/Mod, S/PS
  UPDATE herbal.herbs SET soil_fertility = 'moderate', water_need = 'dry_to_moderate', sun_requirement = 'partial_shade_to_shade'
  WHERE common_name ILIKE '%mugwort%';

  -- Nettle: Rich, Moist, S/PS (leaf)
  UPDATE herbal.herbs SET soil_fertility = 'rich', water_need = 'moist', sun_requirement = 'partial_shade_to_shade'
  WHERE common_name ILIKE '%nettle%';

  -- California Poppy: Low/Mod, Dry, FS/PS
  UPDATE herbal.herbs SET soil_fertility = 'low_to_moderate', water_need = 'dry', sun_requirement = 'full_sun_to_partial_shade'
  WHERE latin_name ILIKE '%eschscholzia%'
     OR common_name ILIKE '%california poppy%';

  -- Red Clover: Moderate, Moderate, FS/PS
  UPDATE herbal.herbs SET soil_fertility = 'moderate', water_need = 'moderate', sun_requirement = 'full_sun_to_partial_shade'
  WHERE common_name ILIKE '%red clover%';

  -- Self-heal: Rich/Mod, Moist, PS/S
  UPDATE herbal.herbs SET soil_fertility = 'moderate_to_rich', water_need = 'moist', sun_requirement = 'partial_shade_to_shade'
  WHERE common_name ILIKE '%self-heal%'
     OR common_name ILIKE '%selfheal%'
     OR common_name ILIKE '%self heal%'
     OR latin_name ILIKE '%prunella%';

  -- Skullcap (American): Rich, Moist, PS
  UPDATE herbal.herbs SET soil_fertility = 'rich', water_need = 'moist', sun_requirement = 'partial_shade'
  WHERE common_name ILIKE '%skullcap%';

  -- Tulsi (temperate): Rich, Moderate, FS
  UPDATE herbal.herbs SET soil_fertility = 'rich', water_need = 'moderate', sun_requirement = 'full_sun'
  WHERE common_name ILIKE '%tulsi%';

  -- Violet: Rich, Moist, SH/PS
  UPDATE herbal.herbs SET soil_fertility = 'rich', water_need = 'moist', sun_requirement = 'partial_shade_to_shade'
  WHERE common_name ILIKE '%violet%';

  -- White Sage: Low/Mod, Dry, FS
  UPDATE herbal.herbs SET soil_fertility = 'low_to_moderate', water_need = 'dry', sun_requirement = 'full_sun'
  WHERE common_name ILIKE '%white sage%'
     OR latin_name ILIKE '%salvia apiana%';

  -- Yerba Santa: Low/Mod (well-draining), Low (≈dry), FS
  UPDATE herbal.herbs SET soil_fertility = 'low_to_moderate', water_need = 'dry', sun_requirement = 'full_sun'
  WHERE common_name ILIKE '%yerba santa%'
     OR latin_name ILIKE '%eriodictyon%';

  -- Yarrow: Low/Mod, Dry/Mod, FS/PS
  UPDATE herbal.herbs SET soil_fertility = 'low_to_moderate', water_need = 'dry_to_moderate', sun_requirement = 'full_sun_to_partial_shade'
  WHERE common_name ILIKE '%yarrow%';

  RAISE NOTICE 'Garden requirement data populated';
END $$;
