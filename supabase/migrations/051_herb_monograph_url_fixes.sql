-- Migration 051: Fix monograph_url assignments where monograph file name
-- differed from the canonical common_name stored in herbal.herbs.
-- Migration 050 used the monograph spellings; this corrects the misses.

SET search_path TO herbal, public;

DO $$
BEGIN
  -- "Kava Kava" in monograph → "Kava" in DB
  UPDATE herbal.herbs
    SET monograph_url = 'https://docs.google.com/document/d/11MG8007dKtoeAsfF0xoLHSShBT_ILK_VvPbg-s87Oiw/edit?usp=classroom_web&authuser=0'
    WHERE common_name = 'Kava';

  -- "Saint John's Wort" in monograph → "St. John's Wort" in DB
  UPDATE herbal.herbs
    SET monograph_url = 'https://docs.google.com/document/d/1IzOLgKND0keNN_NigwgW8oii08xnsFW-Li8U5LEbTfY/edit?usp=classroom_web&authuser=0'
    WHERE common_name = 'St. John''s Wort';

  -- "Oregon Grape Root" in monograph → "Oregon Grape" in DB
  UPDATE herbal.herbs
    SET monograph_url = 'https://docs.google.com/document/d/11NLmT9cdT62wQOLuBr_831C9JnbtCfCKfhmNQyUsvso/edit?usp=classroom_web&authuser=0'
    WHERE common_name = 'Oregon Grape';

  -- "Reishi" in monograph → "Reishi Mushroom" in DB
  UPDATE herbal.herbs
    SET monograph_url = 'https://docs.google.com/document/d/16eOvbiMzzkvj6mpUTSS5D-CfvBF3E-szvs6pBm8y6C8/edit?usp=classroom_web&authuser=0'
    WHERE common_name = 'Reishi Mushroom';

  -- "Wild Cherry" in monograph → "Wild Cherry Bark" in DB
  UPDATE herbal.herbs
    SET monograph_url = 'https://docs.google.com/document/d/1xFESEIZvFY90Mw85Mv16C80J9q58LmAV9Rw7PZMfNH4/edit?usp=classroom_web&authuser=0'
    WHERE common_name = 'Wild Cherry Bark';

  -- "Tulsi" in monograph → "Holy Basil" in DB (same plant, Ocimum tenuiflorum)
  UPDATE herbal.herbs
    SET monograph_url = 'https://docs.google.com/document/d/1qCWjDgPuXsIpXDrL72I81M4pfkVH-kbOy0A_U7PGSB8/edit?usp=classroom_web&authuser=0'
    WHERE common_name = 'Holy Basil';

  -- "Wild Oats" in monograph → "Oat" in DB (Avena sativa)
  UPDATE herbal.herbs
    SET monograph_url = 'https://docs.google.com/document/d/1WR8Om_2UmtiiujOY5voJBiq9c-5_QGBMUMwORMtom7E/edit?usp=classroom_web&authuser=0'
    WHERE common_name = 'Oat';

  RAISE NOTICE 'Monograph URL fixes applied.';
END $$;
