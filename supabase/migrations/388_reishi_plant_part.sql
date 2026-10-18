-- Migration 388: Set plant_part = 'mushroom' for Reishi Mushroom (id=11)

SET search_path TO herbal, public;

UPDATE herbal.herbs SET plant_part = 'mushroom' WHERE id = 11;
