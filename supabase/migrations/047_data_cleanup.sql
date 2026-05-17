-- Migration 047: Herb data cleanup — renames, title case, merge duplicates
SET search_path TO herbal, public;

-- Step 1: Specific renames before title casing
UPDATE herbal.herbs SET common_name = 'Rhodiola'
  WHERE lower(common_name) = 'roseroot stonecrop';

UPDATE herbal.herbs SET common_name = 'Violet'
  WHERE lower(common_name) = 'sweet violet';

-- Step 2: Apply title case to all common_names.
-- initcap() capitalizes after any non-alpha char including apostrophes ("shepherd'S purse"),
-- so we follow it with a fix for possessive 'S -> 's.
UPDATE herbal.herbs
SET common_name = replace(initcap(common_name), '''S', '''s')
WHERE common_name IS NOT NULL;

-- Step 3: Merge duplicate common_names.
-- For each duplicate, keep the row with the lowest id (winner) and re-point all
-- referencing rows from the loser id to the winner id, then delete the loser.
DO $$
DECLARE
  v_winner_id  INTEGER;
  v_loser_id   INTEGER;
  v_name       TEXT;
BEGIN
  FOR v_name, v_winner_id, v_loser_id IN
    WITH ranked AS (
      SELECT
        id,
        common_name,
        MIN(id) OVER (PARTITION BY common_name) AS winner_id,
        ROW_NUMBER() OVER (PARTITION BY common_name ORDER BY id) AS rn
      FROM herbal.herbs
    )
    SELECT common_name, winner_id, id
    FROM ranked
    WHERE rn > 1
    ORDER BY common_name
  LOOP
    -- herb_primary_actions: UNIQUE (herb_id, primary_action_id, body_system_id)
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
      SELECT v_winner_id, primary_action_id, body_system_id, body_system_note, relative_strength
      FROM herbal.herb_primary_actions
      WHERE herb_id = v_loser_id
    ON CONFLICT DO NOTHING;
    DELETE FROM herbal.herb_primary_actions WHERE herb_id = v_loser_id;

    -- herb_secondary_actions: UNIQUE (herb_id, secondary_action_id) — body_system_id is NOT NULL
    INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
      SELECT v_winner_id, secondary_action_id, body_system_id
      FROM herbal.herb_secondary_actions
      WHERE herb_id = v_loser_id
    ON CONFLICT DO NOTHING;
    DELETE FROM herbal.herb_secondary_actions WHERE herb_id = v_loser_id;

    -- disorder_action_herbs: UNIQUE (disorder_id, herb_id, primary_action_id)
    INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, note, sort_order)
      SELECT disorder_id, v_winner_id, primary_action_id, note, sort_order
      FROM herbal.disorder_action_herbs
      WHERE herb_id = v_loser_id
    ON CONFLICT DO NOTHING;
    DELETE FROM herbal.disorder_action_herbs WHERE herb_id = v_loser_id;

    -- disorder_specific_remedies: UNIQUE (disorder_id, herb_id) — description is NOT NULL
    INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      SELECT disorder_id, v_winner_id, COALESCE(description, ''), sort_order
      FROM herbal.disorder_specific_remedies
      WHERE herb_id = v_loser_id
    ON CONFLICT DO NOTHING;
    DELETE FROM herbal.disorder_specific_remedies WHERE herb_id = v_loser_id;

    -- prescription_herbs: update directly (herb unlikely to appear twice in same prescription)
    UPDATE herbal.prescription_herbs
    SET herb_id = v_winner_id
    WHERE herb_id = v_loser_id;

    -- Remove the duplicate
    DELETE FROM herbal.herbs WHERE id = v_loser_id;

  END LOOP;
END $$;
