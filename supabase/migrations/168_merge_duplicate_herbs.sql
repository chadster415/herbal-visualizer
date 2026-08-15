SET search_path TO herbal, public;

-- Merge duplicate herbs (same plant, different taxonomy/nomenclature).
-- Pattern: transfer primary_actions from secondary → primary, then delete secondary.
-- Pairs that are intentional plant-part splits (Dandelion, Elder, Hawthorn, Nettle,
-- Oat, Rose, Comfrey) are left untouched.
-- Pairs with distinct species (Astragalus membranaceus/mongholicus,
-- Codonopsis tangshen/pilosula) are also left untouched.

DO $$
DECLARE
  pairs CONSTANT INT[][] := ARRAY[
    -- [secondary_id, primary_id]  -- reason
    ARRAY[2453,  25],   -- Black Cohosh: Actaea racemosa = Cimicifuga racemosa (reclassified)
    ARRAY[2393,  84],   -- Chamomile: Matricaria chamomilla = M. recutita (synonym)
    ARRAY[2521, 877],   -- Guggul: Commiphora guggul = C. mukul (synonym)
    ARRAY[2446,  33],   -- Oregon Grape: Berberis aquifolium = Mahonia aquifolium (reclassified)
    ARRAY[2410,  55],   -- Peppermint: Mentha x piperita = M. piperita (same cultivar)
    ARRAY[2384, 109],   -- Rosemary: Salvia rosmarinus = Rosmarinus officinalis (reclassified)
    ARRAY[2430, 226],   -- Shiitake: Lentinula edodes = Lentinus edodes (reclassified)
    ARRAY[2385, 207],   -- Wood Betony: Betonica officinalis = Stachys officinalis (reclassified)
    ARRAY[2420,  58],   -- Goldenrod: Solidago spp. → Solidago virgaurea (all data on virgaurea)
    ARRAY[2403,  90],   -- Linden: Tilia spp. → Tilia platyphyllos (all data on platyphyllos)
    ARRAY[2449,  85],   -- Plantain: Plantago spp. → Plantago major (all data on major)
    ARRAY[2431, 146],   -- Vervain: Verbena spp. → Verbena officinalis (all data on officinalis)
    ARRAY[2391, 198],   -- Violet: Viola spp. → Viola odorata (transfer 3 unique actions)
    ARRAY[2543,  79]    -- Witch Hazel: Hamamelis spp. → Hamamelis virginiana (all data on virginiana)
  ];
  sec_id INT;
  pri_id INT;
  i INT;
BEGIN
  FOR i IN 1..array_length(pairs, 1) LOOP
    sec_id := pairs[i][1];
    pri_id := pairs[i][2];

    -- herb_primary_actions: drop conflicts, reparent the rest
    DELETE FROM herbal.herb_primary_actions
    WHERE herb_id = sec_id
      AND (primary_action_id, body_system_id) IN (
        SELECT primary_action_id, body_system_id
        FROM herbal.herb_primary_actions
        WHERE herb_id = pri_id
      );
    UPDATE herbal.herb_primary_actions SET herb_id = pri_id WHERE herb_id = sec_id;

    -- herb_secondary_actions
    DELETE FROM herbal.herb_secondary_actions
    WHERE herb_id = sec_id
      AND (secondary_action_id, body_system_id) IN (
        SELECT secondary_action_id, body_system_id
        FROM herbal.herb_secondary_actions
        WHERE herb_id = pri_id
      );
    UPDATE herbal.herb_secondary_actions SET herb_id = pri_id WHERE herb_id = sec_id;

    -- herb_constituents
    DELETE FROM herbal.herb_constituents
    WHERE herb_id = sec_id
      AND constituent_id IN (
        SELECT constituent_id FROM herbal.herb_constituents WHERE herb_id = pri_id
      );
    UPDATE herbal.herb_constituents SET herb_id = pri_id WHERE herb_id = sec_id;

    -- disorder_action_herbs
    DELETE FROM herbal.disorder_action_herbs
    WHERE herb_id = sec_id
      AND (disorder_id, primary_action_id) IN (
        SELECT disorder_id, primary_action_id FROM herbal.disorder_action_herbs WHERE herb_id = pri_id
      );
    UPDATE herbal.disorder_action_herbs SET herb_id = pri_id WHERE herb_id = sec_id;

    -- disorder_specific_remedies
    DELETE FROM herbal.disorder_specific_remedies
    WHERE herb_id = sec_id
      AND disorder_id IN (
        SELECT disorder_id FROM herbal.disorder_specific_remedies WHERE herb_id = pri_id
      );
    UPDATE herbal.disorder_specific_remedies SET herb_id = pri_id WHERE herb_id = sec_id;

    -- prescription_herbs (no unique constraint on herb_id alone, so just reparent)
    UPDATE herbal.prescription_herbs SET herb_id = pri_id WHERE herb_id = sec_id;

    -- aging_herbs
    DELETE FROM herbal.aging_herbs WHERE herb_id = sec_id
      AND pri_id IN (SELECT herb_id FROM herbal.aging_herbs);
    UPDATE herbal.aging_herbs SET herb_id = pri_id WHERE herb_id = sec_id;

    -- constituent_profiles
    UPDATE herbal.constituent_profiles SET herb_id = pri_id WHERE herb_id = sec_id;

    -- herb_menstruum (only one row per herb)
    -- only move if primary doesn't already have one
    UPDATE herbal.herb_menstruum SET herb_id = pri_id
    WHERE herb_id = sec_id
      AND pri_id NOT IN (SELECT herb_id FROM herbal.herb_menstruum);

    -- Now safe to delete the secondary herb
    DELETE FROM herbal.herbs WHERE id = sec_id;

    RAISE NOTICE 'Merged herb % into %', sec_id, pri_id;
  END LOOP;
END $$;
