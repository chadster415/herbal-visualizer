SET search_path TO herbal, public;

UPDATE herbal.herbs SET common_name = 'Nettle' WHERE common_name = 'Nettles';

DO $$ BEGIN
  RAISE NOTICE 'Renamed Nettles → Nettle (% rows)', (SELECT COUNT(*) FROM herbal.herbs WHERE common_name = 'Nettle' AND latin_name = 'Urtica dioica');
END $$;
