SET search_path TO herbal, public;

-- Comprehensive taste inference for all herbs with taste IS NULL.
-- Follows migration 171 (which covered 17 herbs: 10 bitter, 5 pungent, 2 sweet).
-- This migration adds 100 more: 62 bitter, 31 pungent, 7 sweet.
-- REQUIRES migrations 170 (taste_inferred column) and 171 (already run).
--
-- Rules documented in docs/inferring-taste-from-constituents.md.
-- All herbs below were identified by systematic SQL scan across all 390 null-taste herbs.

-- ============================================================
-- TASTE: bitter
-- Rule: iridoid / secoiridoid / epoxide iridoid glycoside at major+ → bitter (High confidence)
-- Iridoid glycosides are the classic bitter principle of the gentian/iridoid-bearing herb families.
-- ============================================================

-- Balmony — aucubin (iridoid glycoside, major) + Catalpol (High/Marker in profiles)
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 171 AND taste IS NULL;

-- Blue Flag — Iridin (Iridoid glycoside, High/Marker in profiles); root is intensely bitter
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 31 AND taste IS NULL;

-- Bogbean — loganin (iridoid glycoside, major); multiple secoiridoids (High/Marker in profiles);
-- one of the most bitter herbs in the European pharmacopoeia
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 34 AND taste IS NULL;

-- Centaury — gentiopicroside + swertiamarin (secoiridoid glycoside, major); swertiamarin (High/Marker)
-- archetypal bitter tonic herb
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 159 AND taste IS NULL;

-- Chasteberry — aucubin + agnuside (iridoid glycoside, primary); known as bitter-aromatic
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 190 AND taste IS NULL;

-- Cleavers — asperuloside (iridoid glycoside, primary; High/Marker in profiles)
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 28 AND taste IS NULL;

-- Eyebright — aucubin (iridoid glycoside, major; High/Marker in profiles)
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 51 AND taste IS NULL;

-- Figwort — harpagoside (iridoid glycoside, major; High/Marker) + aucubin (Moderate/Major)
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 39 AND taste IS NULL;

-- Fringetree — iridoid glycosides (major); oleuropein + ligustroside (Secoiridoid glycoside, High/Marker)
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 24 AND taste IS NULL;

-- Hardy Rubber Tree (Eucommia) — aucubin (iridoid glycoside, major; High/Major in profiles)
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 10 AND taste IS NULL;

-- Kutki — iridoid glycosides (major); picroside I + II (High/Marker); kutkoside (High/Major)
-- Picrorrhiza kurroa is one of the bitterest Ayurvedic herbs
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 227 AND taste IS NULL;

-- Olive — oleuropein (Secoiridoid glycoside, High/Marker in profiles); intensely bitter
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 106 AND taste IS NULL;

-- Partridgeberry — asperuloside (iridoid glycoside, major; High/Marker in profiles)
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 188 AND taste IS NULL;

-- Plantain — catalpol + aucubin (iridoid glycoside, major; High/Marker in profiles)
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 85 AND taste IS NULL;

-- Black Root — leptandrin (Iridoid glycoside, High/Marker in profiles only)
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 175 AND taste IS NULL;

-- Silk Tassel (elliptica) — iridoid glycosides (major); garryoside A/B/C (High/Marker in profiles)
-- already has temperature_inferred = cooling from migration 158
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 2253 AND taste IS NULL;

-- Wood Betony — harpagide (iridoid glycoside, major); 8-O-Acetylharpagide (High/Major in profiles)
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 207 AND taste IS NULL;

-- ============================================================
-- TASTE: bitter
-- Rule: sesquiterpene lactone at major+ → bitter (High confidence)
-- Sesquiterpene lactones are the dominant bitter principles in the Asteraceae family.
-- ============================================================

-- Blessed Thistle — cnicin (sesquiterpene lactone, primary; High/Marker); archetypal bitter tonic
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 1124 AND taste IS NULL;

-- Chicory — lactucin + lactucopicrin (sesquiterpene lactone, major; High/Marker);
-- bitter signal overrides co-occurring inulin (polysaccharide) in taste perception
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 2227 AND taste IS NULL;

-- Feverfew — parthenolide (sesquiterpene lactone, primary; High/Marker); intensely bitter leaf
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 121 AND taste IS NULL;

-- Wild Lettuce — lactucin + lactucopicrin (sesquiterpene lactone, primary); lactucic acid (organic acid, major);
-- bitter signal from sesquiterpene lactones dominates over organic acid
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 130 AND taste IS NULL;

-- ============================================================
-- TASTE: bitter
-- Rule: anthraquinone at moderate+ → bitter (High confidence)
-- Anthraquinone glycosides produce both cooling energetics and bitter taste.
-- ============================================================

-- Buckthorn — chrysophanol + emodin (anthraquinone, major); bitter purgative bark
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 204 AND taste IS NULL;

-- Madder — anthraquinones (anthraquinone, major; Quinone class in profiles);
-- already has temperature_inferred = cooling from migration 158
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 2237 AND taste IS NULL;

-- Senna — aloe-emodin (anthraquinone, moderate); bitter cathartic
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 216 AND taste IS NULL;

-- ============================================================
-- TASTE: bitter
-- Rule: flavan-3-ol (catechin) at major+ → bitter (High confidence)
-- Flavan-3-ols contribute bitter and astringent taste; already applied to Tea (149) in migration 171.
-- ============================================================

-- Black Catechu (Acacia catechu) — catechin (flavan-3-ol, major; High/Marker in profiles)
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 147 AND taste IS NULL;

-- ============================================================
-- TASTE: bitter
-- Rule: alkaloid at major+ → bitter (Moderate confidence)
-- Alkaloids are almost universally bitter; confidence is Moderate because the rule is broad.
-- ============================================================

-- Barberry — berberine (isoquinoline alkaloid, major); one of the most bitter alkaloids known
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 158 AND taste IS NULL;

-- Bloodroot — alkaloids (alkaloid, major); sanguinarine is intensely bitter
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 38 AND taste IS NULL;

-- Boldo — boldine (Aporphine alkaloid, High/Marker in profiles); alkaloids dominate over volatile co-signal
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 176 AND taste IS NULL;

-- Celandine — alkaloids (alkaloid, major); chelidonine + coptisine are isoquinoline alkaloids
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 170 AND taste IS NULL;

-- Corydalis — tetrahydropalmatine (High/Marker) + dehydrocorydaline (High/Major) in profiles;
-- protoberberine alkaloids with intense bitter taste
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 2228 AND taste IS NULL;

-- Cramp Bark — alkaloids (alkaloid, major) + scopoline (coumarin alkaloid, major)
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 93 AND taste IS NULL;

-- Fenugreek — alkaloids (alkaloid, major); trigonelline + steroidal saponins give bitter taste
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 91 AND taste IS NULL;

-- Fumitory — protopine (isoquinoline alkaloid, major); traditionally classified as "bitter tonic"
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 27 AND taste IS NULL;

-- Goat's Rue — galegine (Guanidine alkaloid, High/Marker in profiles); distinctly bitter
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 1122 AND taste IS NULL;

-- Goldenseal — berberine + hydrastine (isoquinoline alkaloid, primary); among the bitterest herbs
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 30 AND taste IS NULL;

-- Guarana — caffeine (purine alkaloid, major); strongly bitter
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 218 AND taste IS NULL;

-- Ipecac — alkaloids (alkaloid, major); emetine and cephaeline are intensely bitter
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 192 AND taste IS NULL;

-- Kola (Cola acuminata) — caffeine + theobromine (purine alkaloid, major); very bitter
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 150 AND taste IS NULL;

-- Kola Nut (Cola vera) — caffeine + theobromine (purine alkaloid, major)
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 615 AND taste IS NULL;

-- Lesser Periwinkle — alkaloids (alkaloid, major); vinca alkaloids are bitter
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 2250 AND taste IS NULL;

-- Life Root — pyrrolizidine alkaloids (alkaloid, major); bitter
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 1058 AND taste IS NULL;

-- Ma Huang — ephedrine + pseudoephedrine (phenethylamine alkaloid, major); bitter stimulant
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 448 AND taste IS NULL;

-- Mulberry Leaf — 1-deoxynojirimycin (Piperidine alkaloid, High/Marker in profiles); slightly bitter
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 2338 AND taste IS NULL;

-- Periwinkle (Vinca major) — vincamine (Monoterpene indole alkaloid, High/Marker in profiles)
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 157 AND taste IS NULL;

-- Peyote — mescaline (Phenethylamine alkaloid, High/Marker) + pellotine (High/Major in profiles)
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 2350 AND taste IS NULL;

-- Poppy — alkaloids (alkaloid, major); morphine/codeine are intensely bitter
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 340 AND taste IS NULL;

-- Prickly Ash — chelerythrine (benzophenanthridine alkaloid, major) + alkaloids (major);
-- tingling/numbing bitterness characteristic of Zanthoxylum
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 123 AND taste IS NULL;

-- Ragwort — jacobine + senecionine (Pyrrolizidine alkaloid, High/Marker in profiles);
-- already has temperature_inferred = cooling from migration 158
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 1855 AND taste IS NULL;

-- Rue — graveolinine + skimmianine (Furoquinoline alkaloid, High/Major in profiles); intensely bitter
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 110 AND taste IS NULL;

-- Scotch Broom — sparteine (quinolizidine alkaloid, primary) + cytisine + lupanine (major)
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 164 AND taste IS NULL;

-- Silk Tassel (fremontii) — garryine (Isoquinoline alkaloid, High/Marker in profiles)
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 853 AND taste IS NULL;

-- Skunk Cabbage — coniine (piperidine alkaloid, major); bitter
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 143 AND taste IS NULL;

-- Western Coltsfoot — pyrrolizidine alkaloids (alkaloid, major)
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 586 AND taste IS NULL;

-- Yellow Jasmine — gelsemine (indole alkaloid, major); toxic and intensely bitter
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 645 AND taste IS NULL;

-- Yerba Mate — caffeine + theobromine (purine alkaloid, major); bitter stimulant
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 617 AND taste IS NULL;

-- Yohimbe — alkaloids (alkaloid, major); yohimbine is bitter
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 2243 AND taste IS NULL;

-- ============================================================
-- TASTE: bitter
-- Rule: ellagitannin / condensed tannin at major+ → bitter (Moderate confidence)
-- High-molecular-weight tannins produce astringent-bitter taste; already applied to Agrimony (148)
-- and Raspberry (155) in migration 171.
-- ============================================================

-- Blackberry leaf — ellagitannins (hydrolyzable tannin, major); High/Marker in profiles
-- Note: this is Rubus villosus; the leaf is distinctly bitter-astringent (not the berry)
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 156 AND taste IS NULL;

-- Cranesbill — geraniin (ellagitannin, major; High/Marker in profiles); archetypal astringent herb
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 52 AND taste IS NULL;

-- Horse Chestnut — proanthocyanidins (condensed tannin, major); astringent-bitter
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 62 AND taste IS NULL;

-- White Pond Lily — ellagitannins (hydrolyzable tannin, major; High/Marker in profiles);
-- astringent-bitter root
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 2242 AND taste IS NULL;

-- Witch Hazel — hamamelitannin + gallotannins (hydrolyzable tannin, primary) + ellagitannins (major)
-- + proanthocyanidins (condensed tannin, major); intensely astringent-bitter
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 79 AND taste IS NULL;

-- ============================================================
-- TASTE: bitter
-- Rule: labdane diterpene (marrubiin) at major → bitter (High confidence, herb-specific)
-- Marrubiin is the established bitter principle of Marrubium and related Lamiaceae;
-- no general labdane diterpene rule exists — this is a named-compound exception.
-- ============================================================

-- Horehound — marrubiin (labdane diterpene, major); classic bitter tonic for respiratory/digestive use
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true WHERE id = 160 AND taste IS NULL;

-- ============================================================
-- TASTE: pungent
-- Rules:
--   3+ distinct volatile monoterpene/phenylpropanoid subcategories → pungent (High confidence)
--   phenylpropanoid at moderate+ → pungent (High confidence)
-- Already applied to Hyssop (53), Peppermint (55), Sage (56), Juniper (103), Lemon Balm (134)
-- in migration 171.
-- ============================================================

-- Agastache — monoterpene ketone + volatile esters in profiles (3 volatile subcategories);
-- anise-like pungent aroma; already has temperature_inferred = warming from migration 158
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true WHERE id = 2246 AND taste IS NULL;

-- Aniseed — trans-anethole (phenylpropanoid, dominant via profiles); 5 volatile profile subclasses
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true WHERE id = 108 AND taste IS NULL;

-- Asian Mint (Mentha arvensis) — 6 volatile subcategories; menthol-dominant, very pungent
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true WHERE id = 410 AND taste IS NULL;

-- Balsam of Peru — phenylpropanoids (moderate) + resin; 3 volatile subcategories
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true WHERE id = 105 AND taste IS NULL;

-- Basil — eugenol (phenylpropanoid, moderate) + 4 volatile subcategories
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true WHERE id = 420 AND taste IS NULL;

-- Bergamot — 5 volatile subcategories; characteristic pungent citrus-floral taste
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true WHERE id = 407 AND taste IS NULL;

-- Buchu — 3 volatile subcategories (monoterpene, monoterpene ketone + profiles); very pungent
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true WHERE id = 181 AND taste IS NULL;

-- Cinnamon — cinnamaldehyde (phenylpropanoid, major) + 3 volatile subcategories
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true WHERE id = 167 AND taste IS NULL;

-- Clary Sage — 5 volatile subcategories (monoterpene alcohol + ester dominant)
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true WHERE id = 743 AND taste IS NULL;

-- Coriander — 3 volatile subcategories (bicyclic monoterpene ketone, monoterpene alcohol)
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true WHERE id = 100 AND taste IS NULL;

-- Dill — 3 volatile subcategories; carvone-dominant pungent aromatic
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true WHERE id = 64 AND taste IS NULL;

-- Dwarf Pine (Pinus pumilio) — 4 volatile subcategories; pungent pine-resin taste
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true WHERE id = 412 AND taste IS NULL;

-- Eucalyptus — 4 volatile subcategories; 1,8-cineole dominant; intensely pungent
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true WHERE id = 101 AND taste IS NULL;

-- Guggul — resin + sesquiterpene volatile (3 subcategories); pungent resinous taste
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true WHERE id = 877 AND taste IS NULL;

-- Holy Basil (Ocimum sanctum) — eugenol (phenylpropanoid, major) + 3 volatile subcategories
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true WHERE id = 13 AND taste IS NULL;

-- Marjoram — 4 volatile subcategories; sabinene hydrate + terpinen-4-ol; classic pungent culinary herb
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true WHERE id = 107 AND taste IS NULL;

-- Mugwort — thujone + camphor (bicyclic monoterpene ketone, moderate) + 1,8-cineole (monoterpene oxide)
-- + sesquiterpene from profiles = 3 volatile subcategories; artabsin (sesquiterpene lactone) at moderate
-- only (does not meet major+ threshold for bitter rule); pungent signal dominates
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true WHERE id = 115 AND taste IS NULL;

-- Myrrh — resin + sesquiterpene volatile (3 subcategories); pungent-resinous taste
-- (bitter co-signal from furanoeudesma sesquiterpenes is subsumed by resinous pungency)
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true WHERE id = 99 AND taste IS NULL;

-- Neroli (Citrus aurantium blossom) — 6 volatile subcategories; intensely floral-pungent
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true WHERE id = 742 AND taste IS NULL;

-- Osha — 4 volatile subcategories + phenylpropanoid; phthalide-rich and pungent
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true WHERE id = 104 AND taste IS NULL;

-- Sassafras — safrole + methyleugenol (phenylpropanoid, major) + 5 volatile subcategories; very pungent
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true WHERE id = 313 AND taste IS NULL;

-- Scots Pine — alpha/beta-pinene + 5 volatile subcategories; resinous pungent
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true WHERE id = 469 AND taste IS NULL;

-- Southernwood (Artemisia abrotanum) — 4 volatile subcategories (bicyclic monoterpene alcohols/ketones)
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true WHERE id = 96 AND taste IS NULL;

-- Sweet Orange peel — 3 volatile subcategories (monoterpene + alcohol); limonene-dominant, pungent
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true WHERE id = 748 AND taste IS NULL;

-- Tansy — thujone-dominant; 3 volatile subcategories; intensely pungent-bitter; toxic
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true WHERE id = 161 AND taste IS NULL;

-- Tea Tree — 3 volatile subcategories; terpinen-4-ol dominant; very pungent
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true WHERE id = 302 AND taste IS NULL;

-- Thuja — 3 volatile subcategories (bicyclic monoterpene, bicyclic monoterpene alcohol);
-- thujone-dominant; intensely pungent
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true WHERE id = 201 AND taste IS NULL;

-- Tolu Balsam — phenylpropanoids (moderate) + resin; 4 volatile subcategories; balsamic-pungent
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true WHERE id = 194 AND taste IS NULL;

-- Wild Carrot (Daucus carota) — 4 volatile subcategories (bicyclic monoterpenes); aromatic-pungent seed
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true WHERE id = 125 AND taste IS NULL;

-- Yerba Mansa — anethole + methyleugenol + piperol A (phenylpropanoid, major) + 5 volatile subcategories
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true WHERE id = 309 AND taste IS NULL;

-- Ylang Ylang — 4 volatile subcategories (monoterpene alcohols + esters); intensely floral-pungent
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true WHERE id = 745 AND taste IS NULL;

-- ============================================================
-- TASTE: sweet
-- Rule: polysaccharide / mucilage at major/primary, no dominant bitter signal → sweet (High confidence)
-- Already applied to Marshmallow (45) and Linden (90) in migration 171.
-- ============================================================

-- Coltsfoot — mucilage (polysaccharide, major; High/Marker in profiles); demulcent sweet taste
UPDATE herbal.herbs SET taste = 'sweet', taste_inferred = true WHERE id = 60 AND taste IS NULL;

-- Comfrey root — mucilaginous polysaccharides (polysaccharide, primary); sweet mucilaginous taste
-- overrides co-occurring pyrrolizidine alkaloids which are pharmacologically active but not taste-dominant
UPDATE herbal.herbs SET taste = 'sweet', taste_inferred = true WHERE id = 89 AND taste IS NULL;

-- Comfrey leaf — mucilaginous polysaccharides (polysaccharide, primary)
UPDATE herbal.herbs SET taste = 'sweet', taste_inferred = true WHERE id = 1650 AND taste IS NULL;

-- Couch Grass — mucilaginous polysaccharides (polysaccharide, primary); triticin (High/Marker);
-- bland-sweet demulcent root
UPDATE herbal.herbs SET taste = 'sweet', taste_inferred = true WHERE id = 179 AND taste IS NULL;

-- Dang Shen (Codonopsis pilosula) — polysaccharides (major); traditional TCM taste: sweet;
-- Codonopsis polysaccharide (CPP-1) High/Major in profiles
UPDATE herbal.herbs SET taste = 'sweet', taste_inferred = true WHERE id = 7 AND taste IS NULL;

-- Iceland Moss — polysaccharides (major); lichenin + isolichenin (High/Marker in profiles);
-- mucilaginous demulcent taste; bitter cetaric acid absent from DB constituent data
UPDATE herbal.herbs SET taste = 'sweet', taste_inferred = true WHERE id = 48 AND taste IS NULL;

-- Mullein leaf — mucilaginous polysaccharides (polysaccharide, primary);
-- aucubin (iridoid glycoside, major) fires bitter rule but sweet is the dominant taste perception
-- — mullein is universally described as "sweet, mucilaginous" in materia medica
UPDATE herbal.herbs SET taste = 'sweet', taste_inferred = true WHERE id = 61 AND taste IS NULL;

-- ============================================================
-- Skipped herbs (reason noted):
-- Chamomile         — matricin (sesquiterpene lactone, High/Major in profiles → bitter) conflicts with
--                     3 volatile sesquiterpene categories (primary/major → pungent); genuinely both
-- Mugwort           — artabsin at moderate only (does NOT meet major+ sesquiterpene lactone threshold);
--                     pungent signal wins (see above); included as pungent
-- Chamomile (Anthe) — no DB entry checked
-- Reishi Mushroom   — beta-glucans (polysaccharide, primary → sweet) vs ganoderic acids (triterpenoid,
--                     primary); ganoderic acids are bitter triterpenes but no triterpenoid-bitter rule
--                     is established; skip pending rule validation
-- Siberian Ginseng  — eleutherosides (phenylpropanoid & lignan glycosides category, primary): mixed
--                     lignan/phenylpropanoid class does not cleanly match phenylpropanoid taste rule; skip
-- Ireland Moss      — polysaccharides at major but oceanic/bland taste does not fit "sweet"; skip
-- Indian Gooseberry — ellagitannins (High/Marker → bitter) AND expected high organic acid content
--                     (Amla is primarily sour in traditional classification); conflicting; skip
-- Stoneroot         — alkaloids (major → bitter) + 3 volatile subcategories (→ pungent); conflicting
-- Boldo (pungent)   — 3 volatile subcategories but alkaloid bitter signal (boldine, High/Marker) is
--                     pharmacologically primary; assigned bitter above
-- Lemon Verbena     — taste already set in future migration
-- Privet            — secoiridoid bitter signals vs complex TCM taste classification; skip
-- Rehmannia         — catalpol (iridoid, major → bitter) conflicts with TCM taste: sweet (Shu Di Huang)
-- Japanese Honeysuckle — iridoid glycosides but TCM taste: sweet (Jin Yin Hua); skip
-- Benzoin           — resin subclass in profiles (3 volatile) but sweet-balsamic character ≠ pungent; skip
-- ============================================================

DO $$ BEGIN
  RAISE NOTICE 'Inferred taste applied (migration 172): 62 bitter, 31 pungent, 7 sweet = 100 herbs total';
END $$;
