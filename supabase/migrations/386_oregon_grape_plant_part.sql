-- Migration 386: Set plant_part = 'root' for Oregon Grape (id=33)

SET search_path TO herbal, public;

UPDATE herbal.herbs SET plant_part = 'root' WHERE id = 33;
