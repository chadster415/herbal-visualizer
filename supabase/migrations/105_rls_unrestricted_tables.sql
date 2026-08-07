SET search_path TO herbal, public;

-- Enable RLS on tables that were left UNRESTRICTED (RLS disabled) for consistency.
-- Data is non-sensitive public content; policies are fully permissive for anon reads.

DO $$
DECLARE
  t TEXT;
BEGIN
  FOREACH t IN ARRAY ARRAY['action_pattern', 'constituent_profiles']
  LOOP
    EXECUTE format('ALTER TABLE herbal.%I ENABLE ROW LEVEL SECURITY', t);

    IF NOT EXISTS (
      SELECT 1 FROM pg_policies
      WHERE schemaname = 'herbal' AND tablename = t AND policyname = 'anon_read'
    ) THEN
      EXECUTE format(
        'CREATE POLICY "anon_read" ON herbal.%I FOR SELECT USING (true)', t
      );
    END IF;

    IF NOT EXISTS (
      SELECT 1 FROM pg_policies
      WHERE schemaname = 'herbal' AND tablename = t AND policyname = 'service_write'
    ) THEN
      EXECUTE format(
        'CREATE POLICY "service_write" ON herbal.%I FOR ALL TO service_role USING (true) WITH CHECK (true)', t
      );
    END IF;

    RAISE NOTICE 'RLS enabled on herbal.%', t;
  END LOOP;
END $$;
