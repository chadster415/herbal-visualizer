SET search_path TO herbal, public;

-- Reverts the wrong migration 145 (which added herb-specific marker compounds to
-- herb_constituents) and replaces them with correct shared/cross-referenced constituents.

-- ── Step 1: Remove all herb_constituents added by migration 145 ───────────────

DO $$
DECLARE
  v_herb_ids INTEGER[];
BEGIN
  SELECT ARRAY_AGG(id) INTO v_herb_ids
  FROM herbal.herbs
  WHERE latin_name IN (
    'Ceanothus americanus',
    'Corydalis yanhusuo',
    'Garrya elliptica',
    'Nymphaea odorata'
  );

  DELETE FROM herbal.herb_constituents
  WHERE herb_id = ANY(v_herb_ids)
    AND constituent_id IN (
      SELECT id FROM herbal.constituents WHERE LOWER(name) IN (
        'ceanothic acid', 'ceanothetric acid', '27-hydroxyceanothic acid',
        'maesopsin', 'maesopsin-6-o-glucoside',
        'tetrahydropalmatine', 'dehydrocorydaline', 'corydaline', 'glaucine',
        'garryoside a', 'garryoside b', 'garryoside c',
        'corilagin', 'tellimagrandin i', 'tellimagrandin ii',
        -- these shared ones were also wrongly linked by 145; remove and re-add correctly below
        'columbamine', 'berberine', 'ellagic acid', 'quercetin', 'kaempferol'
      )
    );

  RAISE NOTICE 'Removed wrong herb_constituents entries.';
END $$;

-- ── Step 2: Remove constituents that were newly created by migration 145 ──────
-- (shared ones — berberine, columbamine, ellagic acid, quercetin, kaempferol — pre-existed
--  and must NOT be deleted)

DO $$
BEGIN
  DELETE FROM herbal.constituents WHERE LOWER(name) IN (
    'ceanothic acid', 'ceanothetric acid', '27-hydroxyceanothic acid',
    'maesopsin', 'maesopsin-6-o-glucoside',
    'tetrahydropalmatine', 'dehydrocorydaline', 'corydaline', 'glaucine',
    'garryoside a', 'garryoside b', 'garryoside c',
    'corilagin', 'tellimagrandin i', 'tellimagrandin ii'
  );

  RAISE NOTICE 'Removed herb-specific constituents from constituents table.';
END $$;

-- ── Step 3: Add correct shared/cross-referenced constituents ─────────────────

-- Red Root — tannins documented in root/bark; historically used as styptic
DO $$
BEGIN
  PERFORM herbal.link_constituent('Ceanothus americanus', 'tannins', 'moderate', 10);
  RAISE NOTICE 'Red Root constituents linked.';
END $$;

-- Corydalis — berberine present at low–moderate level; shared with many herbs
DO $$
BEGIN
  PERFORM herbal.link_constituent('Corydalis yanhusuo', 'berberine', 'minor', 10);
  RAISE NOTICE 'Corydalis constituents linked.';
END $$;

-- Silk Tassel — garryosides are unique with no shared equivalent; none added
-- (menstruum section shows via UI fix regardless)

-- White Pond Lily — ellagitannins, ellagic acid, mucilage, quercetin, kaempferol
DO $$
BEGIN
  PERFORM herbal.link_constituent('Nymphaea odorata', 'ellagitannins', 'major',    10);
  PERFORM herbal.link_constituent('Nymphaea odorata', 'ellagic acid',  'major',    20);
  PERFORM herbal.link_constituent('Nymphaea odorata', 'mucilage',      'moderate', 30);
  PERFORM herbal.link_constituent('Nymphaea odorata', 'quercetin',     'minor',    40);
  PERFORM herbal.link_constituent('Nymphaea odorata', 'kaempferol',    'minor',    50);
  RAISE NOTICE 'White Pond Lily constituents linked.';
END $$;
