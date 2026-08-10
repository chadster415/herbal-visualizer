SET search_path TO herbal, public;

-- Add missing constituents and link them for the 4 herbs that have menstruum data
-- but were missing herb_constituents entries (causing their menstruum to be hidden in the UI):
-- Red Root, Corydalis, Silk Tassel (elliptica), White Pond Lily.
--
-- Status → concentration_level mapping (same as migration 103):
--   Marker / Major + High         → major
--   Major / Present + Moderate    → moderate
--   Present + Low–Moderate        → minor
--   Reported (any)                → trace

-- ── Red Root (Ceanothus americanus) ──────────────────────────────────────────

DO $$
BEGIN
  -- Add ceanothane triterpenoids (unique to Ceanothus spp.)
  PERFORM herbal.ensure_constituent(
    'ceanothic acid',
    'pentacyclic triterpenoid',
    'Characteristic ceanothane triterpenoid defining Red Root chemistry; antimicrobial activity against oral pathogens.'
  );
  PERFORM herbal.ensure_constituent(
    'ceanothetric acid',
    'pentacyclic triterpenoid',
    'Characteristic ceanothane triterpenoid; documented antimicrobial activity against oral pathogens.'
  );
  PERFORM herbal.ensure_constituent(
    '27-hydroxyceanothic acid',
    'pentacyclic triterpenoid',
    'Oxygenated ceanothane-type triterpenoid; supports the diagnostic triterpenoid profile of Red Root.'
  );
  PERFORM herbal.ensure_constituent(
    'maesopsin',
    'flavanonol',
    'Species-documented flavanonol providing a minor supporting phenolic fraction in Ceanothus americanus.'
  );
  PERFORM herbal.ensure_constituent(
    'maesopsin-6-O-glucoside',
    'flavanonol glycoside',
    'Glycosylated flavanonol reported from Ceanothus americanus; secondary to the defining triterpenoids.'
  );

  -- Link: Marker/High → major
  PERFORM herbal.link_constituent('Ceanothus americanus', 'ceanothic acid',        'major',    10);
  PERFORM herbal.link_constituent('Ceanothus americanus', 'ceanothetric acid',     'major',    20);
  -- Major/Moderate → moderate
  PERFORM herbal.link_constituent('Ceanothus americanus', '27-hydroxyceanothic acid', 'moderate', 30);
  -- Present/Low–Moderate → minor
  PERFORM herbal.link_constituent('Ceanothus americanus', 'maesopsin',             'minor',    40);
  -- Reported → trace
  PERFORM herbal.link_constituent('Ceanothus americanus', 'maesopsin-6-O-glucoside', 'trace',  50);

  RAISE NOTICE 'Red Root constituents linked.';
END $$;

-- ── Corydalis (Corydalis yanhusuo) ───────────────────────────────────────────

DO $$
BEGIN
  PERFORM herbal.ensure_constituent(
    'tetrahydropalmatine',
    'isoquinoline alkaloid',
    'Primary active alkaloid of Corydalis yanhusuo; analgesic and sedative via dopamine D1/D2 antagonism and GABA agonism.'
  );
  PERFORM herbal.ensure_constituent(
    'dehydrocorydaline',
    'isoquinoline alkaloid',
    'Protoberberine alkaloid contributing analgesic and anti-inflammatory activity in Corydalis.'
  );
  PERFORM herbal.ensure_constituent(
    'corydaline',
    'isoquinoline alkaloid',
    'Protoberberine alkaloid with sedative and analgesic properties.'
  );
  PERFORM herbal.ensure_constituent(
    'glaucine',
    'isoquinoline alkaloid',
    'Aporphine alkaloid with antitussive, bronchodilatory, and anti-inflammatory effects.'
  );

  -- Marker/High → major
  PERFORM herbal.link_constituent('Corydalis yanhusuo', 'tetrahydropalmatine', 'major',    10);
  -- Major/High → major
  PERFORM herbal.link_constituent('Corydalis yanhusuo', 'dehydrocorydaline',   'major',    20);
  -- Major/Moderate → moderate
  PERFORM herbal.link_constituent('Corydalis yanhusuo', 'corydaline',          'moderate', 30);
  -- Present/Moderate → moderate
  PERFORM herbal.link_constituent('Corydalis yanhusuo', 'glaucine',            'moderate', 40);
  PERFORM herbal.link_constituent('Corydalis yanhusuo', 'columbamine',         'moderate', 50);
  -- Present/Low–Moderate → minor
  PERFORM herbal.link_constituent('Corydalis yanhusuo', 'berberine',           'minor',    60);

  RAISE NOTICE 'Corydalis constituents linked.';
END $$;

-- ── Silk Tassel / Garrya elliptica ───────────────────────────────────────────

DO $$
BEGIN
  PERFORM herbal.ensure_constituent(
    'garryoside A',
    'iridoid glycoside',
    'Primary iridoid glycoside marker of Garrya elliptica; contributes antispasmodic activity.'
  );
  PERFORM herbal.ensure_constituent(
    'garryoside B',
    'iridoid glycoside',
    'Iridoid glycoside contributing antispasmodic activity in Garrya elliptica.'
  );
  PERFORM herbal.ensure_constituent(
    'garryoside C',
    'iridoid glycoside',
    'Secondary iridoid glycoside of Garrya elliptica.'
  );

  -- Marker/High → major
  PERFORM herbal.link_constituent('Garrya elliptica', 'garryoside A', 'major',    10);
  -- Major/High → major
  PERFORM herbal.link_constituent('Garrya elliptica', 'garryoside B', 'major',    20);
  -- Major/Moderate → moderate
  PERFORM herbal.link_constituent('Garrya elliptica', 'garryoside C', 'moderate', 30);

  RAISE NOTICE 'Silk Tassel constituents linked.';
END $$;

-- ── White Pond Lily (Nymphaea odorata) ───────────────────────────────────────

DO $$
BEGIN
  PERFORM herbal.ensure_constituent(
    'corilagin',
    'ellagitannin',
    'Hydrolyzable ellagitannin marker of Nymphaea odorata; antimicrobial and antiviral activity.'
  );
  PERFORM herbal.ensure_constituent(
    'tellimagrandin I',
    'ellagitannin',
    'Ellagitannin with astringent and antimicrobial properties.'
  );
  PERFORM herbal.ensure_constituent(
    'tellimagrandin II',
    'ellagitannin',
    'Hydrolyzable ellagitannin contributing astringent activity.'
  );

  -- Marker/High → major
  PERFORM herbal.link_constituent('Nymphaea odorata', 'corilagin',        'major',    10);
  -- Major/High → major
  PERFORM herbal.link_constituent('Nymphaea odorata', 'ellagic acid',     'major',    20);
  -- Major/Moderate → moderate
  PERFORM herbal.link_constituent('Nymphaea odorata', 'tellimagrandin I',  'moderate', 30);
  -- Present/Moderate → moderate
  PERFORM herbal.link_constituent('Nymphaea odorata', 'tellimagrandin II', 'moderate', 40);
  -- Present/Low–Moderate → minor
  PERFORM herbal.link_constituent('Nymphaea odorata', 'quercetin',        'minor',    50);
  PERFORM herbal.link_constituent('Nymphaea odorata', 'kaempferol',       'minor',    60);

  RAISE NOTICE 'White Pond Lily constituents linked.';
END $$;
