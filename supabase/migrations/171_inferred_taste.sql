SET search_path TO herbal, public;

-- Inferred taste for herbs with taste IS NULL.
-- Rules applied from docs/inferring-taste-from-constituents.md.
-- REQUIRES migration 170 (taste_inferred column).
-- Tone-equivalent note: taste inference uses the same constituent data as energetics inference.
--
-- 17 herbs receive inferred taste across this migration:
--   10 bitter, 5 pungent, 2 sweet
-- Herbs are left unchanged when signals conflict or data is sparse.

-- ============================================================
-- TASTE: bitter
-- Rules:
--   iridoid / secoiridoid / epoxide iridoid glycoside at major+ → bitter (High confidence)
--   sesquiterpene lactone at major+ → bitter (High confidence)
--   anthraquinone at any level → bitter (High confidence)
--   flavan-3-ol (catechin) at major+ → bitter (High confidence)
--   alpha/beta hop acid at major+ → bitter (High confidence)
--   acylphloroglucinol at major+ → bitter (High confidence)
--   alkaloid at major+, no volatile-oil counter-signal → bitter (Moderate confidence)
--   ellagitannin at major+, no dominant sweet signal → bitter (Moderate confidence)
-- ============================================================

-- Burdock — arctiopicrin (sesquiterpene lactone, major)
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true
WHERE id = 22;

-- Wild Indigo — baptifoline + cytisine (quinolizidine alkaloid, primary/major); alkaloid at primary
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true
WHERE id = 23;

-- Yellow Dock — emodin + chrysophanol (anthraquinone, primary); classic bitter anthraquinone
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true
WHERE id = 37;

-- Devil's Claw — harpagoside (iridoid glycoside, primary; Marker in profiles)
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true
WHERE id = 80;

-- St. John's Wort — hyperforin (acylphloroglucinol, primary); bitter resinous compound
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true
WHERE id = 81;

-- Hops — humulone/lupulone (alpha acid/beta acid, primary); alpha-bitter acids are the definitive bitter principle
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true
WHERE id = 129;

-- Valerian — valepotriates (epoxide iridoid, primary); valerenic acid (sesquiterpene acid, primary); famously bitter
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true
WHERE id = 145;

-- Agrimony — agrimoniin (ellagitannin, High Marker) + tannins (polyphenol, primary) + bitter glycosides
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true
WHERE id = 148;

-- Tea (Camellia sinensis) — EGCG + epicatechin gallate (flavan-3-ol, High Marker) + caffeine (purine alkaloid, High Marker)
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true
WHERE id = 149;

-- Raspberry leaf — sanguiin H-6 (ellagitannin, High Marker) + tannins (primary) + fragarine (alkaloid, major)
UPDATE herbal.herbs SET taste = 'bitter', taste_inferred = true
WHERE id = 155;

-- ============================================================
-- TASTE: pungent
-- Rules:
--   3+ distinct volatile monoterpene subcategories (any level) → pungent (High confidence)
--   phenylpropanoid at moderate+ → pungent (High confidence)
-- ============================================================

-- Hyssop — pinocamphone + isopinocamphone (bicyclic monoterpene ketone, primary), 1,8-cineole (oxide, major),
--           beta-pinene + limonene (monoterpene): 5 distinct volatile subcategories
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true
WHERE id = 53;

-- Peppermint — menthol (monoterpene alcohol, primary), menthone (ketone, primary),
--              menthyl acetate (ester, major), 1,8-cineole (oxide, moderate): 4 distinct subcategories
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true
WHERE id = 55;

-- Sage — thujone + camphor (bicyclic monoterpene ketone, major), 1,8-cineole (oxide, major),
--         borneol (bicyclic monoterpene alcohol, moderate): 3 distinct subcategories
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true
WHERE id = 56;

-- Juniper — alpha-terpinen-4-ol (monoterpene alcohol, primary), alpha-pinene + sabinene (bicyclic monoterpene, major),
--            myrcene + limonene (monoterpene, moderate): 3 distinct subcategories
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true
WHERE id = 103;

-- Lemon Balm — citral (monoterpene aldehyde, major; High Marker in profiles) + citronellal (major) +
--              linalool + geraniol (monoterpene alcohol, moderate): 3 distinct subcategories
UPDATE herbal.herbs SET taste = 'pungent', taste_inferred = true
WHERE id = 134;

-- ============================================================
-- TASTE: sweet
-- Rules:
--   polysaccharide / mucilage at major/primary, no dominant bitter signal → sweet (High confidence)
-- ============================================================

-- Marshmallow — mucilaginous polysaccharides (primary) + arabinogalacturonan (acidic polysaccharide, primary)
--               + pectins (polysaccharide, major); arabinogalactan (High Marker in profiles); archetypal sweet herb
UPDATE herbal.herbs SET taste = 'sweet', taste_inferred = true
WHERE id = 45;

-- Linden — mucilage (polysaccharide, primary) + arabinogalactan (Moderate Major in profiles);
--           volatile farnesol (sesquiterpene, not monoterpene) provides mild aromatic note but not pungent dominance
UPDATE herbal.herbs SET taste = 'sweet', taste_inferred = true
WHERE id = 90;

-- ============================================================
-- Skipped herbs (reason noted):
-- Chamomile         — matricin (sesquiterpene lactone → bitter) vs alpha-bisabolol/chamazulene (volatile → pungent); conflicting
-- Meadowsweet       — phenolic glycosides + tannins dominant; salicylate flavour ≠ cleanly bitter or sour; skip
-- Passionflower     — flavone C-glycoside dominant; alkaloids only at trace; no clear taste signal
-- Lemon Verbena     — already has drying inference; taste confirmed in later migration
-- St. John's Wort   — see bitter above (hyperforin)
-- Calendula         — triterpenoids + resin + saponins; mixed; no single dominant taste signal
-- Ginkgo            — diterpene trilactones (mildly bitter) vs flavonol glycosides dominant; borderline; skip
-- Cramp Bark        — coumarin + alkaloid + resin; mixed; skip
-- Comfrey           — pyrrolizidine alkaloids (minor only) vs mucilage; conflicting; skip
-- Horehound         — marrubiin (labdane diterpene, major) is distinctly bitter but category not in standard rules;
--                     include in a future migration once labdane diterpene rule is validated
-- ============================================================

DO $$ BEGIN
  RAISE NOTICE 'Inferred taste applied: 10 bitter, 5 pungent, 2 sweet';
END $$;
