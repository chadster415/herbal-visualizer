-- Migration 191: Infer taste=bitter for cardiac glycoside-dominant herbs
-- Rule: cardenolide / bufadienolide cardiac glycoside at major or primary → bitter
-- Basis: TAS2R bitter taste receptor activation (mechanism-based, not dataset correlation)
-- Rule documented in docs/inferring-taste-from-constituents.md (added August 2026)
--
-- Herbs: Lily of the Valley, Wahoo, Squill

SET search_path TO herbal, public;

DO $$
BEGIN

-- Convallaria majalis (Lily of the Valley)
-- convallatoxin (cardenolide cardiac glycoside, primary), convalloside (major), lokunjoside (major)
UPDATE herbal.herbs
SET taste = 'bitter', taste_inferred = true
WHERE latin_name = 'Convallaria majalis';

-- Euonymus atropurpureus (Wahoo)
-- evobioside (cardenolide glycoside, primary), evonoside (major)
UPDATE herbal.herbs
SET taste = 'bitter', taste_inferred = true
WHERE latin_name = 'Euonymus atropurpureus';

-- Urginea maritima (Squill)
-- scillaren A (bufadienolide glycoside, primary), proscillardin A (major)
UPDATE herbal.herbs
SET taste = 'bitter', taste_inferred = true
WHERE latin_name = 'Urginea maritima';

RAISE NOTICE 'Migration 191 complete: 3 herbs assigned taste=bitter (cardiac glycoside rule)';

END $$;
