SET search_path TO herbal, public;

-- Consolidates duplicate primary actions that share the same meaning.
-- For each merge: reroutes all FK references, then deletes the redundant action.

-- Temporary helper (dropped at end of migration)
CREATE OR REPLACE FUNCTION herbal._merge_action(p_old INTEGER, p_new INTEGER) RETURNS VOID AS $$
BEGIN
  -- herb_primary_actions: (herb_id, primary_action_id, body_system_id) UNIQUE
  DELETE FROM herbal.herb_primary_actions a USING herbal.herb_primary_actions b
    WHERE a.primary_action_id = p_old AND b.primary_action_id = p_new
      AND a.herb_id = b.herb_id AND a.body_system_id = b.body_system_id;
  UPDATE herbal.herb_primary_actions SET primary_action_id = p_new WHERE primary_action_id = p_old;

  -- disorder_actions_indicated: (disorder_id, primary_action_id) UNIQUE
  DELETE FROM herbal.disorder_actions_indicated a USING herbal.disorder_actions_indicated b
    WHERE a.primary_action_id = p_old AND b.primary_action_id = p_new AND a.disorder_id = b.disorder_id;
  UPDATE herbal.disorder_actions_indicated SET primary_action_id = p_new WHERE primary_action_id = p_old;

  -- disorder_action_herbs: (disorder_id, herb_id, primary_action_id) UNIQUE
  DELETE FROM herbal.disorder_action_herbs a USING herbal.disorder_action_herbs b
    WHERE a.primary_action_id = p_old AND b.primary_action_id = p_new
      AND a.disorder_id = b.disorder_id AND a.herb_id = b.herb_id;
  UPDATE herbal.disorder_action_herbs SET primary_action_id = p_new WHERE primary_action_id = p_old;

  -- prescription_herb_actions: (prescription_herb_id, primary_action_id) UNIQUE
  DELETE FROM herbal.prescription_herb_actions a USING herbal.prescription_herb_actions b
    WHERE a.primary_action_id = p_old AND b.primary_action_id = p_new
      AND a.prescription_herb_id = b.prescription_herb_id;
  UPDATE herbal.prescription_herb_actions SET primary_action_id = p_new WHERE primary_action_id = p_old;

  -- action_pattern: canonical keeps its own entry; delete old
  DELETE FROM herbal.action_pattern WHERE primary_action_id = p_old;

  -- action_descriptions: canonical keeps its own; delete old
  DELETE FROM herbal.action_descriptions WHERE primary_action_id = p_old;

  -- Remove the duplicate action
  DELETE FROM herbal.primary_actions WHERE id = p_old;

  RAISE NOTICE 'Merged action id=% into id=%', p_old, p_new;
END;
$$ LANGUAGE plpgsql;


-- ── Block 1: Cardiovascular group → Cardiotonic (id=10) ─────────────────────
-- Cardioactive, Cardiovascular tonic, Vascular tonic, Vascular Tonic all share
-- the same description as Cardiotonic and mean the same thing.

DO $$ BEGIN
  PERFORM herbal._merge_action(388,  10);  -- Cardioactive → Cardiotonic
  PERFORM herbal._merge_action(1227, 10);  -- Cardiovascular tonic → Cardiotonic
  PERFORM herbal._merge_action(1223, 10);  -- Vascular tonic → Cardiotonic
  PERFORM herbal._merge_action(42,   10);  -- Vascular Tonic → Cardiotonic
  -- Cardiovascular System Tonic has no refs, safe to delete directly
  DELETE FROM herbal.primary_actions WHERE id = 1247;
  RAISE NOTICE 'Block 1: cardiovascular actions consolidated into Cardiotonic.';
END $$;


-- ── Block 2: Anti-inflammatory case fix → Anti-Inflammatory (id=4) ──────────

DO $$ BEGIN
  PERFORM herbal._merge_action(1180, 4);
  RAISE NOTICE 'Block 2: Anti-inflammatory merged into Anti-Inflammatory.';
END $$;


-- ── Block 3: Nervine group ───────────────────────────────────────────────────
-- "Nervine" was used with the Nervine Relaxant description throughout the DB.
-- Consolidate all three relaxant variants into Nervine Relaxant (id=23).

DO $$ BEGIN
  PERFORM herbal._merge_action(26,   23);  -- Nervine → Nervine Relaxant
  PERFORM herbal._merge_action(1226, 23);  -- Nervine relaxant → Nervine Relaxant
  PERFORM herbal._merge_action(1225, 22);  -- Nervine tonic → Nervine Tonic
  RAISE NOTICE 'Block 3: nervine variants consolidated.';
END $$;


-- ── Block 4: Lymphatic → Lymphatic Tonic (id=55) ────────────────────────────

DO $$ BEGIN
  PERFORM herbal._merge_action(27, 55);
  RAISE NOTICE 'Block 4: Lymphatic merged into Lymphatic Tonic.';
END $$;


-- ── Block 5: Bitter tonic (case) → Bitter Tonic (id=914) ────────────────────

DO $$ BEGIN
  PERFORM herbal._merge_action(1239, 914);
  RAISE NOTICE 'Block 5: Bitter tonic merged into Bitter Tonic.';
END $$;


-- ── Block 6: Circulatory Tonic → Circulatory Stimulant (id=29) ──────────────
-- Both had the same description; Circulatory Stimulant has 6× more data.

DO $$ BEGIN
  PERFORM herbal._merge_action(197, 29);
  RAISE NOTICE 'Block 6: Circulatory Tonic merged into Circulatory Stimulant.';
END $$;


-- ── Block 7: Hormonal Regulator → Hormonal Normalizer (id=510) ──────────────

DO $$ BEGIN
  PERFORM herbal._merge_action(1161, 510);
  RAISE NOTICE 'Block 7: Hormonal Regulator merged into Hormonal Normalizer.';
END $$;


-- ── Block 8: Immune group ────────────────────────────────────────────────────

DO $$ BEGIN
  PERFORM herbal._merge_action(25,   47);  -- Immune Support → Immunomodulator
  PERFORM herbal._merge_action(1186, 47);  -- Immune Modulator → Immunomodulator
  PERFORM herbal._merge_action(1252, 40);  -- Immune Stimulant → Immunostimulant
  -- Immune System Tonic has no refs, delete directly
  DELETE FROM herbal.primary_actions WHERE id = 1253;
  RAISE NOTICE 'Block 8: immune actions consolidated.';
END $$;


-- ── Block 9: Eliminative Support → Detoxifying (id=39) ──────────────────────

DO $$ BEGIN
  PERFORM herbal._merge_action(32, 39);
  RAISE NOTICE 'Block 9: Eliminative Support merged into Detoxifying.';
END $$;


-- ── Block 10: Digestive Support → Digestive Tonic (id=1248) ─────────────────
-- Digestive Support had a deficiency action_pattern entry; carry it to Digestive Tonic first.

DO $$ BEGIN
  INSERT INTO herbal.action_pattern (primary_action_id, pattern)
  VALUES (1248, 'deficiency')
  ON CONFLICT DO NOTHING;

  PERFORM herbal._merge_action(169, 1248);
  RAISE NOTICE 'Block 10: Digestive Support merged into Digestive Tonic.';
END $$;


-- ── Block 11: Remove zero-ref, redundant actions ─────────────────────────────

DO $$ BEGIN
  -- Respiratory System Tonic: redundant with Pulmonary Tonic, no data
  DELETE FROM herbal.primary_actions WHERE id = 1258;
  -- Hormonal Tonic: redundant with Hormonal Normalizer, no data
  DELETE FROM herbal.primary_actions WHERE id = 1250;
  RAISE NOTICE 'Block 11: zero-ref redundant actions removed.';
END $$;


-- Drop the temporary helper
DROP FUNCTION IF EXISTS herbal._merge_action(INTEGER, INTEGER);

DO $$ BEGIN RAISE NOTICE 'Migration 166 (action cleanup) complete.'; END $$;
