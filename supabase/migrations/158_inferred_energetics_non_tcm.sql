SET search_path TO herbal, public;

-- Inferred energetics for non-TCM herbs with all-neutral energetics.
-- Rules applied from docs/inferring-energetics-from-constituents.md.
-- REQUIRES migration 153 (temperature_inferred/moisture_inferred/tone_inferred columns).
-- Tone is never inferred — left untouched throughout.
--
-- 51 herbs had temperature=neutral, moisture=neutral, tone=neutral.
-- 20 receive inferred temperature, 13 receive inferred moisture.
-- 18 skipped (sparse data, contradictory signals, or no matching rule).

-- ============================================================
-- TEMPERATURE: warming
-- Rule: phenylpropanoid at moderate+ → warming (High confidence)
-- Rule: resins at moderate+ → warming (Moderate confidence)
-- ============================================================

-- Agastache — estragole (phenylpropene, Moderate) in constituent_profiles
UPDATE herbal.herbs SET temperature = 'warming', temperature_inferred = true
WHERE id = 2246;

-- Cinnamon Bark — trans-cinnamaldehyde (phenylpropanoid, Marker) + cinnamyl acetate (moderate)
UPDATE herbal.herbs SET temperature = 'warming', temperature_inferred = true
WHERE id = 1083;

-- Dong Quai — coniferyl ferulate (phenylpropanoid ester, Moderate) in constituent_profiles
UPDATE herbal.herbs SET temperature = 'warming', temperature_inferred = true
WHERE id = 1009;

-- Lomatium — resins (resin, major) in herb_constituents
UPDATE herbal.herbs SET temperature = 'warming', temperature_inferred = true
WHERE id = 980;

-- ============================================================
-- TEMPERATURE: cooling
-- Rules:
--   anthraquinones → cooling (Very High confidence)
--   iridoid/secoiridoid glycosides at major+ → cooling (High confidence)
--   polyphenol/tannin-dominant, no volatile terpenoids → cooling (Moderate)
--   flavonol-dominant, no volatile terpenoids → cooling (Moderate)
-- ============================================================

-- Bilberry — anthocyanins + flavonols (quercetin, myricetin), polyphenol-dominant, no terpenoids
UPDATE herbal.herbs SET temperature = 'cooling', temperature_inferred = true
WHERE id = 1160;

-- Blue Vervain — hastatoside (iridoid glycoside, major) + verbenin (iridoid, Major)
UPDATE herbal.herbs SET temperature = 'cooling', temperature_inferred = true
WHERE id = 983;

-- Chinese Skullcap — baicalin/baicalein/wogonin (flavones) dominant, polyphenol-dominant, no volatile terpenoids
UPDATE herbal.herbs SET temperature = 'cooling', temperature_inferred = true
WHERE id = 2274;

-- Cranberry — flavonol-dominant (quercetin, anthocyanins) + flavan-3-ol procyanidin A2 (Marker), no terpenoids
UPDATE herbal.herbs SET temperature = 'cooling', temperature_inferred = true
WHERE id = 1212;

-- Grape Seed — condensed tannin (procyanidin B1/B2, Marker) + flavan-3-ols, polyphenol-dominant, no terpenoids
UPDATE herbal.herbs SET temperature = 'cooling', temperature_inferred = true
WHERE id = 2230;

-- Heartsease — flavones + anthocyanins, polyphenol-dominant, no volatile terpenoids
UPDATE herbal.herbs SET temperature = 'cooling', temperature_inferred = true
WHERE id = 1240;

-- Japanese Honeysuckle — loganin (iridoid glycoside, moderate) + sweroside (secoiridoid, Major)
-- Borderline: rule requires major/primary for iridoids, compensated by secoiridoid at High
UPDATE herbal.herbs SET temperature = 'cooling', temperature_inferred = true
WHERE id = 2234;

-- Madder — anthraquinones (alizarin, purpurin, rubiadin) at major; zero counter-examples in dataset
UPDATE herbal.herbs SET temperature = 'cooling', temperature_inferred = true
WHERE id = 2237;

-- Manzanita — flavonol-dominant (quercetin, arbutin/methylarbutin at major), no volatile terpenoids
UPDATE herbal.herbs SET temperature = 'cooling', temperature_inferred = true
WHERE id = 1253;

-- Mulberry Leaf — flavonol-dominant (rutin, isoquercitrin, quercetin at major/moderate), no terpenoids
UPDATE herbal.herbs SET temperature = 'cooling', temperature_inferred = true
WHERE id = 2338;

-- Ocotillo — flavonol-dominant (isorhamnetin, quercetin at moderate), no volatile terpenoids
UPDATE herbal.herbs SET temperature = 'cooling', temperature_inferred = true
WHERE id = 1248;

-- Ragwort — flavonol-dominant (quercetin, kaempferol, luteolin at moderate), no volatile terpenoids
UPDATE herbal.herbs SET temperature = 'cooling', temperature_inferred = true
WHERE id = 1855;

-- Red Root — polyphenol/tannin at moderate, no volatile terpenoids
UPDATE herbal.herbs SET temperature = 'cooling', temperature_inferred = true
WHERE id = 981;

-- Silk Tassel (elliptica) — garryoside A/B (iridoid glycosides, Marker) at major
UPDATE herbal.herbs SET temperature = 'cooling', temperature_inferred = true
WHERE id = 2253;

-- Sorrel — flavonol-dominant (kaempferol, quercetin, hyperoside at moderate), no volatile terpenoids
UPDATE herbal.herbs SET temperature = 'cooling', temperature_inferred = true
WHERE id = 1102;

-- Spinach — flavonol glycoside markers (spinacetin-3-gentiobioside, patuletin glycosides), no volatile terpenoids
UPDATE herbal.herbs SET temperature = 'cooling', temperature_inferred = true
WHERE id = 2352;

-- ============================================================
-- MOISTURE: moistening
-- Rules:
--   polysaccharide/mucilage at major/primary → moistening (High confidence)
--   saponins at major, no volatile terpenoids → moistening (Moderate)
--   phytosterol at moderate+, no volatile terpenoids → moistening (Moderate)
--   coumarin at moderate+, no volatile terpenoids → moistening (Moderate)
--   fatty acids (multiple, at major) → moistening (Low-Moderate)
-- ============================================================

-- Bupleurum chinense — triterpenoid saponins (major) + saikosaponins (Marker), no volatile terpenoids
UPDATE herbal.herbs SET moisture = 'moistening', moisture_inferred = true
WHERE id = 2247;

-- Chicory — inulin (polysaccharide/fructan, major in both tables; Marker in profiles)
UPDATE herbal.herbs SET moisture = 'moistening', moisture_inferred = true
WHERE id = 2227;

-- Chinese Skullcap — beta-sitosterol (phytosterol, moderate), no volatile terpenoids
UPDATE herbal.herbs SET moisture = 'moistening', moisture_inferred = true
WHERE id = 2274;

-- Evening Primrose — GLA + linoleic acid (fatty acids at major/High) + beta-sitosterol (moderate);
-- multiple moistening signals; no volatile terpenoids present
UPDATE herbal.herbs SET moisture = 'moistening', moisture_inferred = true
WHERE id = 1139;

-- Kelp (Laminaria) — alginic acid + fucoidan + laminarin (polysaccharides at major/Marker)
UPDATE herbal.herbs SET moisture = 'moistening', moisture_inferred = true
WHERE id = 2248;

-- Kelp (Saccharina) — alginic acid + fucoidan + laminarin (polysaccharides at major/Marker)
UPDATE herbal.herbs SET moisture = 'moistening', moisture_inferred = true
WHERE id = 2249;

-- Oat (straw) — scopoletin (coumarin, moderate) + saponins (moderate), no volatile terpenoids
UPDATE herbal.herbs SET moisture = 'moistening', moisture_inferred = true
WHERE id = 2287;

-- Oat (colloidal) — beta-glucan (polysaccharide, High/Major in constituent_profiles)
UPDATE herbal.herbs SET moisture = 'moistening', moisture_inferred = true
WHERE id = 2288;

-- White Mustard — beta-sitosterol (phytosterol, moderate), no volatile terpenoids
UPDATE herbal.herbs SET moisture = 'moistening', moisture_inferred = true
WHERE id = 1861;

-- ============================================================
-- MOISTURE: drying
-- Rules:
--   flavan-3-ols at moderate+ → drying (High confidence)
--   monoterpenes at moderate+ → drying (High confidence)
-- ============================================================

-- Cinnamon Bark — procyanidin B2 + C1 (flavan-3-ols, moderate) in both tables
UPDATE herbal.herbs SET moisture = 'drying', moisture_inferred = true
WHERE id = 1083;

-- Cranberry — procyanidin A2 (flavan-3-ol, Marker) at High; 0 moistening herbs share this pattern
UPDATE herbal.herbs SET moisture = 'drying', moisture_inferred = true
WHERE id = 1212;

-- Grape Seed — catechin + epicatechin (flavan-3-ols, moderate); procyanidin B1/B2 (Marker)
UPDATE herbal.herbs SET moisture = 'drying', moisture_inferred = true
WHERE id = 2230;

-- Lemon Verbena — limonene (moderate) + citral/geranial+neral (High/Major) — monoterpenes present
UPDATE herbal.herbs SET moisture = 'drying', moisture_inferred = true
WHERE id = 2235;

-- ============================================================
-- Skipped herbs (reason noted):
-- Asian Devil's Club    — only ubiquitous triterpenoids/phytosterols; sparse signal
-- Black Mustard         — glucosinolate-dominant; no rule for glucosinolates
-- Blessed Thistle       — sesquiterpene lactone + tannins + mucilage; conflicting signals
-- Bupleurum (temp)      — saponin-dominant; no temperature rule for saponins alone
-- Caper Spurge          — diterpenoid-dominant; no rule for diterpenoids
-- Cashew                — phenolic lipid-dominant; no rule
-- Coleus                — diterpenoid-dominant (forskolin); no rule
-- Corydalis             — protoberberine alkaloid-dominant; no rule
-- Goat's Rue            — guanidine alkaloid-dominant; no rule; sparse
-- Grindelia             — diterpenoid (grindelic acid); no resin constituent in herb_constituents
-- Lady's Mantle         — only 2 herb_constituents (below 3-constituent threshold)
-- Lesser Periwinkle     — monoterpene indole alkaloid-dominant; no rule
-- Life Root             — only 1 herb_constituent (pyrrolizidine alkaloid)
-- Lovage                — phthalide-dominant; phthalides not in rules (though empirically warming)
-- Parsley Piert         — only 2 herb_constituents (below threshold)
-- Peyote                — alkaloid-dominant; no rule
-- Prince Seng           — only 2 herb_constituents (below threshold)
-- Silk Tree             — triterpenoid saponin Marker in profiles but no saponin in herb_constituents
-- Solomon's Seal        — only 1 herb_constituent (diosgenin)
-- White Mustard (temp)  — glucosinolate-dominant; no rule for glucosinolates
-- White Peony           — iridoid glycoside (cooling) + phenylpropanoid (warming); conflicting signals
-- White Pond Lily       — noted in guide as genuinely contradictory; leave neutral
-- Yohimbe               — indole alkaloid-dominant; no rule
-- Zedoary               — sesquiterpenes in profiles only; herb_constituents too sparse
-- ============================================================

DO $$ BEGIN
  RAISE NOTICE 'Inferred energetics applied: 20 temperature updates, 13 moisture updates';
END $$;
