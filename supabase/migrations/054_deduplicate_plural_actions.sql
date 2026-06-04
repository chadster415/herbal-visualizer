-- Merge plural primary_action names into their singular canonical forms.
-- Uses names (not IDs) so this is safe to run on any environment regardless
-- of ID differences. If a plural form doesn't exist, the block is a no-op.

DO $$
DECLARE
  -- Each pair: [plural to remove, singular to keep]
  pairs TEXT[][] := ARRAY[
    ARRAY['Adaptogens',  'Adaptogen'],
    ARRAY['Alteratives', 'Alterative']
  ];
  plural_name  TEXT;
  canon_name   TEXT;
  dup_id       INT;
  canon_id     INT;
  pair         TEXT[];
BEGIN
  FOREACH pair SLICE 1 IN ARRAY pairs LOOP
    plural_name := pair[1];
    canon_name  := pair[2];

    SELECT id INTO dup_id   FROM herbal.primary_actions WHERE name = plural_name;
    SELECT id INTO canon_id FROM herbal.primary_actions WHERE name = canon_name;

    IF dup_id IS NULL THEN
      RAISE NOTICE 'Skipping %: not found', plural_name;
      CONTINUE;
    END IF;
    IF canon_id IS NULL THEN
      RAISE NOTICE 'Skipping %: canonical % not found', plural_name, canon_name;
      CONTINUE;
    END IF;

    -- herb_primary_actions: unique (herb_id, primary_action_id, body_system_id)
    DELETE FROM herbal.herb_primary_actions dup
    WHERE dup.primary_action_id = dup_id
      AND EXISTS (
        SELECT 1 FROM herbal.herb_primary_actions canon
        WHERE canon.herb_id             = dup.herb_id
          AND canon.primary_action_id   = canon_id
          AND canon.body_system_id      = dup.body_system_id
      );
    UPDATE herbal.herb_primary_actions
      SET primary_action_id = canon_id
      WHERE primary_action_id = dup_id;

    -- action_descriptions
    UPDATE herbal.action_descriptions
      SET primary_action_id = canon_id
      WHERE primary_action_id = dup_id;

    -- disorder_action_herbs: unique (disorder_id, herb_id, primary_action_id)
    DELETE FROM herbal.disorder_action_herbs dup
    WHERE dup.primary_action_id = dup_id
      AND EXISTS (
        SELECT 1 FROM herbal.disorder_action_herbs canon
        WHERE canon.disorder_id         = dup.disorder_id
          AND canon.herb_id             = dup.herb_id
          AND canon.primary_action_id   = canon_id
      );
    UPDATE herbal.disorder_action_herbs
      SET primary_action_id = canon_id
      WHERE primary_action_id = dup_id;

    -- disorder_actions_indicated: unique (disorder_id, primary_action_id)
    DELETE FROM herbal.disorder_actions_indicated dup
    WHERE dup.primary_action_id = dup_id
      AND EXISTS (
        SELECT 1 FROM herbal.disorder_actions_indicated canon
        WHERE canon.disorder_id         = dup.disorder_id
          AND canon.primary_action_id   = canon_id
      );
    UPDATE herbal.disorder_actions_indicated
      SET primary_action_id = canon_id
      WHERE primary_action_id = dup_id;

    -- prescription_herb_actions: unique (prescription_herb_id, primary_action_id)
    DELETE FROM herbal.prescription_herb_actions dup
    WHERE dup.primary_action_id = dup_id
      AND EXISTS (
        SELECT 1 FROM herbal.prescription_herb_actions canon
        WHERE canon.prescription_herb_id = dup.prescription_herb_id
          AND canon.primary_action_id    = canon_id
      );
    UPDATE herbal.prescription_herb_actions
      SET primary_action_id = canon_id
      WHERE primary_action_id = dup_id;

    DELETE FROM herbal.primary_actions WHERE id = dup_id;

    RAISE NOTICE 'Merged "%" (id %) into "%" (id %)', plural_name, dup_id, canon_name, canon_id;
  END LOOP;
END $$;
