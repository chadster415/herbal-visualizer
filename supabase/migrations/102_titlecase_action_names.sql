-- Standardise all primary_action names to title case via initcap().
-- Only updates rows where the name already differs from its initcap form.

SET search_path TO herbal, public;

UPDATE herbal.primary_actions
SET name = initcap(name)
WHERE name <> initcap(name);

-- Verify
DO $$
DECLARE v_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO v_count
  FROM herbal.primary_actions
  WHERE name <> initcap(name);

  IF v_count > 0 THEN
    RAISE EXCEPTION 'Still % action(s) not in title case', v_count;
  END IF;

  RAISE NOTICE 'All % primary actions are now title case',
    (SELECT COUNT(*) FROM herbal.primary_actions);
END $$;
