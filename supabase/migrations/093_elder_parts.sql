-- Migration 093: Resolve Elder / Elderflower into flower and berry entries
--
-- Source file evidence (Immune System 2.md):
--   Every Elder reference in the file except one says "-- flowers" or "-- flower".
--   The Flu specific remedy lists "Elder" with no qualifier — consistent with elderberry
--   (antiviral, sambucol) rather than elderflower (diaphoretic). All other disorder
--   contexts (Fevers, Congestion, Acute Bronchitis, Swollen Glands, Sinusitis, Common Cold)
--   are unambiguously elderflower.
--
-- Elderflower (id 583, Sambucus spp.): redundant stub — 6 primary actions, no prescriptions,
--   no specific remedies, no disorder_action_herbs. All its actions are already on Elder (57).
--   Delete it.
--
-- Strategy:
--   1. Set plant_part = 'flower' on Elder (57) — all existing data is flower
--   2. Delete Elderflower (583) — herb_primary_actions CASCADE on delete
--   3. Create Elder (berry); seed Antiviral + Immunostimulant for Immune system
--   4. Move Flu specific remedy from flower → berry
--   5. Set monograph URL on berry (same document covers both parts)

SET search_path TO herbal, public;

DO $$
DECLARE
  v_flower_id INTEGER := 57;
  v_berry_id  INTEGER;
  v_immune_id INTEGER;
BEGIN

  SELECT id INTO v_immune_id FROM herbal.body_systems WHERE name = 'Immune';

  -- 1. Convert Elder (57) to flower
  UPDATE herbal.herbs
  SET plant_part = 'flower'
  WHERE id = v_flower_id AND latin_name = 'Sambucus nigra';

  RAISE NOTICE 'Elder (id 57) → Elder flower';

  -- 2. Delete Elderflower (583)
  --    herb_primary_actions cascades; constituent_profiles FK does not — delete manually first
  DELETE FROM herbal.constituent_profiles WHERE herb_id = 583;
  DELETE FROM herbal.herbs WHERE id = 583 AND latin_name = 'Sambucus spp.';

  RAISE NOTICE 'Deleted Elderflower stub (id 583)';

  -- 3. Create Elder berry entry
  v_berry_id := herbal.ensure_herb('Sambucus nigra', 'Elder', 'berry');

  UPDATE herbal.herbs
  SET temperature   = 'cooling',
      moisture      = 'neutral',
      tone          = 'neutral',
      monograph_url = (SELECT monograph_url FROM herbal.herbs WHERE id = v_flower_id)
  WHERE id = v_berry_id;

  RAISE NOTICE 'Created Elder berry (id %)', v_berry_id;

  -- 4. Seed berry actions: Antiviral and Immunostimulant for Immune system
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT v_berry_id, id, v_immune_id FROM herbal.primary_actions WHERE name = 'Antiviral'
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT v_berry_id, id, v_immune_id FROM herbal.primary_actions WHERE name = 'Immunostimulant'
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- 5. Move Flu specific remedy from flower → berry
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description)
  SELECT disorder_id, v_berry_id, description
  FROM herbal.disorder_specific_remedies
  WHERE herb_id = v_flower_id
    AND disorder_id = (
      SELECT id FROM herbal.disorders WHERE name = 'Flu'
    )
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  DELETE FROM herbal.disorder_specific_remedies
  WHERE herb_id = v_flower_id
    AND disorder_id = (SELECT id FROM herbal.disorders WHERE name = 'Flu');

  RAISE NOTICE 'Moved Flu specific remedy → berry (id %)', v_berry_id;

  RAISE NOTICE 'Done. Elder flower = 57, Elder berry = %', v_berry_id;

END $$;
