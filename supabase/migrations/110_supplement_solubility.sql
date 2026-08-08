-- Migration 110: Fill in solubility for supplements that were left NULL
SET search_path TO herbal, public;

DO $$ BEGIN RAISE NOTICE 'Updating supplement solubility...'; END $$;

-- Minerals (water-soluble — excreted in urine, don't require dietary fat)
UPDATE herbal.supplements SET solubility = 'water-soluble'
WHERE name IN ('Boron','Calcium','Chromium','Copper','Iodine','Iron','Lithium','Magnesium','Potassium','Selenium','Zinc');

-- Amino acids and amino acid derivatives
UPDATE herbal.supplements SET solubility = 'water-soluble'
WHERE name IN ('Methionine','L-Carnitine','L-Glutamine','L-Theanine','N-Acetyl-Cysteine (NAC)');

-- Other water-soluble supplements
UPDATE herbal.supplements SET solubility = 'water-soluble'
WHERE name IN ('5-HTP','Glucosamine Sulfate','Inositol','SAM-E','Proteolytic Enzymes');

-- Fat-soluble
UPDATE herbal.supplements SET solubility = 'fat-soluble'
WHERE name IN ('Fish Oils (Omega-3)');

-- Alpha Lipoic Acid is uniquely both water- and fat-soluble (key property for antioxidant function)
UPDATE herbal.supplements SET solubility = 'water & fat-soluble'
WHERE name = 'Alpha Lipoic Acid';

DO $$ BEGIN RAISE NOTICE 'Migration 110 complete.'; END $$;
