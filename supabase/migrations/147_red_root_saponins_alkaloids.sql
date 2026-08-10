SET search_path TO herbal, public;

-- Red Root (Ceanothus americanus) has saponins and alkaloids (ceanothine alkaloids)
-- documented in the menstruum notes alongside tannins, but were missing from herb_constituents.

DO $$
BEGIN
  -- Saponins: partially water-soluble per menstruum notes; moderate presence
  PERFORM herbal.link_constituent('Ceanothus americanus', 'saponins',  'moderate', 20);
  -- Ceanothine alkaloids: present but secondary to the triterpenoid/tannin chemistry
  PERFORM herbal.link_constituent('Ceanothus americanus', 'alkaloids', 'minor',    30);

  RAISE NOTICE 'Red Root saponins and alkaloids linked.';
END $$;
