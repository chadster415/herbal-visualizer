-- Migration 112: Solubility for supplements added in migration 111
SET search_path TO herbal, public;

-- Water-soluble: amino acids, minerals, probiotic, B-vitamin group, and garlic's active compounds
UPDATE herbal.supplements SET solubility = 'water-soluble'
WHERE name IN (
  'Garlic',
  'Brewer''s Yeast',
  'Lysine',
  'Lactobacillus acidophilus',
  'Choline',
  'Manganese',
  'Vitamin B Complex'
);

-- Fat-soluble: oils, carotenoids, and steroid hormones require dietary fat for absorption
UPDATE herbal.supplements SET solubility = 'fat-soluble'
WHERE name IN (
  'Beta-Carotene',
  'Evening Primrose Oil',
  'Flaxseed Oil',
  'DHEA',
  'Quercetin'
);

DO $$ BEGIN RAISE NOTICE 'Migration 112 complete: solubility set for 12 new supplements.'; END $$;
