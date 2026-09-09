DO $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN
        SELECT table_name, column_name
        FROM information_schema.columns
        WHERE table_schema = 'herbal'
          AND data_type IN ('text', 'character varying')
    LOOP
        EXECUTE format(
            'UPDATE herbal.%I SET %I = replace(%I, ''—'', '' - '') WHERE %I LIKE ''%%—%%''',
            r.table_name, r.column_name, r.column_name, r.column_name
        );
    END LOOP;
END $$;
