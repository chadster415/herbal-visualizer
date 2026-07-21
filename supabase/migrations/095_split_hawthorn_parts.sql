-- Migration 095: Split Hawthorn into berry and leaf & flower entries
--
-- Both parts are Cardiotonic/Hypotensive — same therapeutic direction, different
-- constituent profiles. Berry = anthocyanins, Procyanidin B2 (OPC standardised extracts).
-- Leaf & flower = Vitexin, Vitexin-2''-O-rhamnoside, Hyperoside (pharmacopoeial markers,
-- smooth muscle relaxant, coronary vasodilation).
--
-- Strategy:
--   • Convert existing id 73 → berry (holds all cardiovascular actions + 15 prescriptions)
--   • Create leaf & flower entry; seed same Cardiotonic + Hypotensive + Tonic actions
--   • Move Pregnancy Anemia specific remedy to leaf & flower
--     (description: "Leafy herb that can be added to salads... meaningful levels of iron")
--   • Move Pregnancy Threatened Miscarriage specific remedy to leaf & flower
--     (vitexin has smooth muscle relaxant properties relevant to uterine tension)
--   • Re-point constituent_profiles tagged 'Leaf & flower' to new entry
--   • herb_constituents have no part-specific notes — keep all on berry (cardiovascular base)
--   • Set monograph URL on leaf & flower (same document)

SET search_path TO herbal, public;

DO $$
DECLARE
  v_berry_id  INTEGER := 73;
  v_lf_id     INTEGER;  -- leaf & flower
BEGIN

  -- 1. Convert existing Hawthorn entry to berry
  UPDATE herbal.herbs
  SET plant_part = 'berry'
  WHERE id = v_berry_id AND latin_name = 'Crataegus spp.';

  RAISE NOTICE 'Hawthorn (id 73) → Hawthorn berry';

  -- 2. Create leaf & flower entry
  v_lf_id := herbal.ensure_herb('Crataegus spp.', 'Hawthorn', 'leaf & flower');

  UPDATE herbal.herbs
  SET temperature   = 'neutral',
      moisture      = 'neutral',
      tone          = 'toning',
      monograph_url = (SELECT monograph_url FROM herbal.herbs WHERE id = v_berry_id)
  WHERE id = v_lf_id;

  RAISE NOTICE 'Created Hawthorn leaf & flower (id %)', v_lf_id;

  -- 3. Seed leaf & flower with the same primary actions as berry
  --    Both parts share Cardiotonic, Hypotensive, Tonic, Anti-inflammatory
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, relative_strength, body_system_note)
  SELECT v_lf_id, hpa.primary_action_id, hpa.body_system_id,
         hpa.relative_strength, hpa.body_system_note
  FROM herbal.herb_primary_actions hpa
  WHERE hpa.herb_id = v_berry_id
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- 4. Move Pregnancy specific remedies to leaf & flower
  --    Anemia: "Leafy herb... meaningful levels of iron" — explicitly leaf
  --    Threatened Miscarriage: blank, but vitexin (leaf & flower) is the relevant constituent
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description)
  SELECT dsr.disorder_id, v_lf_id, dsr.description
  FROM herbal.disorder_specific_remedies dsr
  JOIN herbal.disorders d ON d.id = dsr.disorder_id
  JOIN herbal.body_systems bs ON bs.id = d.body_system_id
  WHERE dsr.herb_id = v_berry_id
    AND bs.name = 'Reproductive - Female'
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  DELETE FROM herbal.disorder_specific_remedies
  WHERE herb_id = v_berry_id
    AND disorder_id IN (
      SELECT d.id FROM herbal.disorders d
      JOIN herbal.body_systems bs ON bs.id = d.body_system_id
      WHERE bs.name = 'Reproductive - Female'
    );

  RAISE NOTICE 'Moved Reproductive-Female specific remedies → leaf & flower';

  -- 5. Re-point constituent_profiles tagged 'Leaf & flower' to new entry
  UPDATE herbal.constituent_profiles
  SET herb_id = v_lf_id
  WHERE herb_id = v_berry_id AND plant_part = 'Leaf & flower';

  RAISE NOTICE 'Moved Leaf & flower constituent_profiles → id %', v_lf_id;

  -- herb_constituents (proanthocyanidins, vitexin, hyperoside, etc.) have no part-specific
  -- notes — leave all on berry as the cardiovascular base herb

  RAISE NOTICE 'Done. Hawthorn berry = 73, Hawthorn leaf & flower = %', v_lf_id;

END $$;
