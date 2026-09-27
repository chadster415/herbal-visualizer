-- Milk Thistle (herb 206, Silybum marianum) had no plant_part set.
-- All constituent_profiles rows are tagged "Seed" and the medicine is exclusively from the seed.
UPDATE herbal.herbs SET plant_part = 'seed' WHERE id = 206;
