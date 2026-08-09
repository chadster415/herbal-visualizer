SET search_path TO herbal, public;

-- Normalise all plant_part values to lowercase.

UPDATE herbal.herbs SET plant_part = LOWER(plant_part) WHERE plant_part IS NOT NULL AND plant_part != LOWER(plant_part);
