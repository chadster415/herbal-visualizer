-- Migration 046: Fix Ashwagandha spelling and add herbs used in Energetics Quiz
SET search_path TO herbal, public;

-- Fix typo: "Ashwaganda" -> "Ashwagandha"
DO $$
BEGIN
  UPDATE herbal.herbs
  SET common_name = 'Ashwagandha'
  WHERE lower(common_name) = 'ashwaganda';
END $$;

-- Add herbs referenced in Energetics Quiz that are not yet in the DB
DO $$
BEGIN
  INSERT INTO herbal.herbs (latin_name, common_name)
  VALUES ('Rosa canina', 'Rosehips')
  ON CONFLICT (latin_name) DO NOTHING;

  INSERT INTO herbal.herbs (latin_name, common_name)
  VALUES ('Rosa gallica', 'Rose')
  ON CONFLICT (latin_name) DO NOTHING;

  INSERT INTO herbal.herbs (latin_name, common_name)
  VALUES ('Lepidium meyenii', 'Maca')
  ON CONFLICT (latin_name) DO NOTHING;

  INSERT INTO herbal.herbs (latin_name, common_name)
  VALUES ('Asparagus racemosus', 'Shatavari')
  ON CONFLICT (latin_name) DO NOTHING;

  INSERT INTO herbal.herbs (latin_name, common_name)
  VALUES ('Garrya fremontii', 'Silk Tassel')
  ON CONFLICT (latin_name) DO NOTHING;
END $$;
