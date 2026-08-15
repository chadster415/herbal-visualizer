SET search_path TO herbal, public;

-- Create taste_energetic enum
DO $$ BEGIN
  CREATE TYPE herbal.taste_energetic AS ENUM ('sweet', 'bitter', 'pungent', 'salty', 'sour');
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- Add taste column (nullable — only herbs from the Flavor Wheel get a value)
ALTER TABLE herbal.herbs ADD COLUMN IF NOT EXISTS taste herbal.taste_energetic;

-- Assign tastes from the Taste of Herbs Flavor Wheel (Rosalee de la Forêt)
DO $$
BEGIN

  -- SWEET
  UPDATE herbal.herbs SET taste = 'sweet' WHERE latin_name IN (
    'Withania somnifera',       -- Ashwagandha
    'Panax quinquefolius',      -- American Ginseng
    'Panax ginseng',            -- Ginseng
    'Glycyrrhiza glabra',       -- Licorice
    'Astragalus membranaceus',  -- Astragalus
    'Astragalus mongholicus',   -- Astragalus (alt species)
    'Ulmus rubra',              -- Slippery Elm
    'Aloe vera'                 -- Aloe
  );
  UPDATE herbal.herbs SET taste = 'sweet' WHERE common_name ILIKE '%codonopsis%';
  RAISE NOTICE 'Sweet tastes assigned';

  -- BITTER
  UPDATE herbal.herbs SET taste = 'bitter' WHERE latin_name IN (
    'Taraxacum officinale',     -- Dandelion (root and leaf)
    'Gentiana lutea',           -- Gentian
    'Cynara scolymus',          -- Artichoke
    'Coffea arabica',           -- Coffee
    'Leonurus cardiaca',        -- Motherwort
    'Scutellaria lateriflora',  -- Skullcap
    'Eschscholzia californica', -- California Poppy
    'Achillea millefolium',     -- Yarrow
    'Eupatorium perfoliatum',   -- Boneset
    'Salix spp.',               -- Willow
    'Ceanothus americanus',     -- Red Root
    'Mahonia aquifolium',       -- Oregon Grape
    'Berberis aquifolium',      -- Oregon Grape (alt name)
    'Artemisia absinthium',     -- Wormwood
    'Rhamnus purshiana',        -- Cascara Sagrada
    'Rheum palmatum',           -- Rhubarb
    'Inula helenium',           -- Elecampane
    'Angelica archangelica'     -- Angelica
  );
  -- Vervain (multiple species in DB)
  UPDATE herbal.herbs SET taste = 'bitter' WHERE common_name ILIKE '%vervain%';
  -- Elderflower only (not the berry)
  UPDATE herbal.herbs SET taste = 'bitter' WHERE latin_name = 'Sambucus nigra' AND plant_part = 'flower';
  RAISE NOTICE 'Bitter tastes assigned';

  -- PUNGENT
  UPDATE herbal.herbs SET taste = 'pungent' WHERE latin_name IN (
    'Lobelia inflata',          -- Lobelia
    'Turnera diffusa',          -- Damiana
    'Elettaria cardamomum',     -- Cardamom
    'Foeniculum vulgare',       -- Fennel
    'Curcuma longa',            -- Turmeric
    'Acmella oleracea',         -- Spilanthes
    'Echinacea spp.',           -- Echinacea
    'Echinacea angustifolia',   -- Narrow-Leaf Echinacea
    'Arnica montana',           -- Arnica
    'Rosmarinus officinalis',   -- Rosemary (old latin name)
    'Salvia rosmarinus',        -- Rosemary (current latin name)
    'Thymus vulgaris',          -- Thyme
    'Origanum vulgare',         -- Oregano
    'Capsicum annuum',          -- Cayenne
    'Syzygium aromaticum',      -- Clove
    'Zingiber officinale',      -- Ginger
    'Armoracia rusticana',      -- Horseradish
    'Allium sativum',           -- Garlic
    'Piper nigrum'              -- Black Pepper
  );
  UPDATE herbal.herbs SET taste = 'pungent' WHERE common_name ILIKE '%lavender%';
  RAISE NOTICE 'Pungent tastes assigned';

  -- SALTY
  UPDATE herbal.herbs SET taste = 'salty' WHERE latin_name IN (
    'Stellaria media',          -- Chickweed
    'Urtica dioica',            -- Nettle (leaf and root)
    'Equisetum arvense',        -- Horsetail
    'Avena sativa',             -- Oat (all parts: milky oats, straw, colloidal)
    'Piper methysticum',        -- Kava
    'Fucus vesiculosus',        -- Kelp
    'Laminaria digitata',       -- Kelp (Laminaria)
    'Saccharina latissima'      -- Kelp (Saccharina)
  );
  -- Violet (all Viola species in DB, including Heartsease)
  UPDATE herbal.herbs SET taste = 'salty' WHERE latin_name ILIKE 'Viola%';
  RAISE NOTICE 'Salty tastes assigned';

  -- SOUR
  UPDATE herbal.herbs SET taste = 'sour' WHERE latin_name IN (
    'Citrus limon',             -- Lemon
    'Crataegus spp.',           -- Hawthorn (berry and leaf & flower)
    'Arctostaphylos uva-ursi',  -- Uva Ursi / Bearberry
    'Quercus spp.',             -- Oak Bark
    'Quercus alba',             -- White Oak Bark
    'Schisandra chinensis',     -- Schisandra (listed as Schizandra)
    'Myrica cerifera'           -- Bayberry
  );
  -- Elderberry (not flower)
  UPDATE herbal.herbs SET taste = 'sour' WHERE latin_name = 'Sambucus nigra' AND plant_part = 'berry';
  -- Rose hips
  UPDATE herbal.herbs SET taste = 'sour' WHERE latin_name = 'Rosa spp.' AND plant_part = 'hips';
  RAISE NOTICE 'Sour tastes assigned';

END $$;
