-- Add source attribution column to recipes

ALTER TABLE herbal.recipes ADD COLUMN source TEXT;

UPDATE herbal.recipes
  SET source = 'Healing Herbal Teas by Sarah Farr'
  WHERE name IN ('Dream', 'Respite Nervine Tea', 'Glow: Beauty Tea', 'Digestive Tonic');
