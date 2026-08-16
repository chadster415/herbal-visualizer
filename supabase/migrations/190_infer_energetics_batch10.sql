-- Migration 190: Infer energetics from constituents for batch 7–10 herbs
-- Rules from docs/inferring-energetics-from-constituents.md (August 2026 dataset)
-- Only herbs where a rule clearly fires and is_tcm = false are included.
-- All inferences marked with _inferred = true so UI renders them at reduced opacity.
--
-- 4 herbs receive new inferences:
--   Cananga odorata   — temperature: warming, moisture: drying
--   Eucommia ulmoides — temperature: cooling
--   Albizia julibrissin — moisture: moistening
--   Curcuma zedoaria  — moisture: drying
--
-- Herbs skipped (rule does not clearly fire or already has source data):
--   Acanthopanax, Aralia elata, Bupleurum, Convallaria, Cephaelis, Cucurbita,
--   Eriodictyon, Euonymus, Guaiacum, Laminaria, Marsdenia, Oplopanax,
--   Polygala, Pulsatilla, Rehmannia (TCM sweet conflict), Rubia, Saccharina,
--   Smilax, Styrax (explicitly skipped in doc), Urginea, Yucca

SET search_path TO herbal, public;

DO $$
BEGIN

-- ============================================================
-- Cananga odorata (Ylang Ylang)
-- Temperature: warming — HIGH CONFIDENCE
--   Rule: 3+ distinct volatile subcategories → warming (55.6% warming vs 33.9% cooling)
--   Fired by: monoterpene alcohol (linalool, major), sesquiterpene (germacrene D/beta-caryophyllene/
--             alpha-farnesene, primary/moderate), phenylpropanoid (eugenol, minor),
--             monoterpene ester (geranyl acetate, minor) = 4 subcategories
-- Moisture: drying — HIGH CONFIDENCE
--   Rule: monoterpene alcohol present → drying (0 moistening herbs contain monoterpene alcohols)
--   Fired by: linalool (monoterpene alcohol, major)
-- Combined pattern: volatile oil-rich profile → warming / drying
-- ============================================================
UPDATE herbal.herbs
SET temperature         = 'warming',
    temperature_inferred = true,
    moisture             = 'drying',
    moisture_inferred    = true
WHERE latin_name = 'Cananga odorata';

RAISE NOTICE 'Cananga odorata: temperature=warming, moisture=drying (both inferred from volatile oil profile)';


-- ============================================================
-- Eucommia ulmoides (Hardy Rubber Tree / Du Zhong)
-- Temperature: cooling — HIGH CONFIDENCE
--   Rule: iridoid or secoiridoid glycoside as major or primary constituent → cooling
--         (1 warming edge case vs 14+ cooling herbs; secoiridoids are the same bitter-cooling class)
--   Fired by: geniposidic acid (secoiridoid glycoside, primary — EP quality marker for Du Zhong),
--             aucubin (iridoid glycoside, major), geniposide (iridoid glycoside, moderate)
-- Moisture: no rule fires — no polysaccharides, no monoterpenes, no flavan-3-ols → keep neutral
-- ============================================================
UPDATE herbal.herbs
SET temperature         = 'cooling',
    temperature_inferred = true
WHERE latin_name = 'Eucommia ulmoides';

RAISE NOTICE 'Eucommia ulmoides: temperature=cooling (inferred from iridoid/secoiridoid glycosides at primary/major)';


-- ============================================================
-- Albizia julibrissin (Silk Tree / He Huan Pi)
-- Moisture: moistening — MODERATE CONFIDENCE
--   Rule: saponins at major/primary, no volatile terpenoids present → moistening
--         (14% moistening vs 4.1% drying for saponin-dominant herbs)
--   Fired by: julibroside J1 (oleanane triterpenoid saponin, major),
--             albiziasaponin A (oleanane triterpenoid saponin, moderate)
--   No volatile terpenoid categories present — counter-signal absent
-- Temperature: no rule fires — no iridoids, no volatile terpenoids, no anthraquinones → keep neutral
-- ============================================================
UPDATE herbal.herbs
SET moisture         = 'moistening',
    moisture_inferred = true
WHERE latin_name = 'Albizia julibrissin';

RAISE NOTICE 'Albizia julibrissin: moisture=moistening (moderate confidence — saponin-dominant, no volatile terpenoids)';


-- ============================================================
-- Curcuma zedoaria (Zedoary)
-- Moisture: drying — HIGH CONFIDENCE
--   Rule: bicyclic monoterpene ketone present → drying
--         (0 moistening herbs contain bicyclic monoterpene ketones; rule fires at any concentration)
--   Fired by: camphor (bicyclic monoterpene ketone, minor)
-- Temperature: insufficient volatile subcategory count (sesquiterpene + bicyclic monoterpene ketone
--   = 2 distinct subcategories; 3+ required). No other temperature rule fires. Keep neutral.
-- ============================================================
UPDATE herbal.herbs
SET moisture         = 'drying',
    moisture_inferred = true
WHERE latin_name = 'Curcuma zedoaria';

RAISE NOTICE 'Curcuma zedoaria: moisture=drying (inferred from camphor, bicyclic monoterpene ketone)';

RAISE NOTICE 'Migration 190 complete: 4 herbs updated (Cananga odorata, Eucommia ulmoides, Albizia julibrissin, Curcuma zedoaria)';

END $$;
