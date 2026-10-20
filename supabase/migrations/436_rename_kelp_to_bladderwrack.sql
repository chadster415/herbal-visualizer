-- Kelp (id 118) is Fucus vesiculosus — the same species as Bladderwrack.
-- All existing snippets, constituent_profiles, and herb_constituents rows are
-- specifically about Fucus vesiculosus / Bladderwrack. Renaming the common_name
-- makes the entry botanically accurate and surfaces it when "Bladderwrack"
-- is referenced in class notes and formulas.
-- "Kelp" moves to synonyms so existing searches and notes still resolve.

UPDATE herbal.herbs
SET
  common_name = 'Bladderwrack',
  synonyms    = ARRAY['Kelp', 'Fucus', 'Rockweed', 'Sea Oak', 'Sea Kelp',
                      'Bladder Fucus', 'Black Tangle', 'Seawrack', 'Sea Wrack']
WHERE id = 118;

-- Align constituent_profiles common_name with the new primary name
UPDATE herbal.constituent_profiles
SET common_name = 'Bladderwrack'
WHERE herb_id = 118;
