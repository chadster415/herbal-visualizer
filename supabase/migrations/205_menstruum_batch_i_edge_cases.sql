-- Batch I: edge cases — food herbs, fixed-oil herbs, controlled substances,
-- and herbs contraindicated for internal use (7 herbs)
-- All via direct INSERT; 3 flagged needs_review=true (Caper Spurge, Peyote, Ragwort).
-- Non-tincture herbs receive NULL alcohol columns and a descriptive primary_label.

SET search_path TO herbal, public;

-- Caper Spurge seed (Euphorbia lathyris, herb_id 2251):
-- Ingenane/tigliane diterpenoid esters (phorbol-type — potent irritants / toxins),
-- fixed oils — HIGHLY TOXIC; flagged for review
INSERT INTO herbal.herb_menstruum
  (herb_id, alcohol_pct_min, alcohol_pct_max, water_effective, primary_label, notes, needs_review)
VALUES (
  2251, 60, 80, false,
  '60–80% alcohol (research only — not clinical use)',
  'Seed contains ingenane/tigliane diterpenoid esters (phorbol-type irritants) requiring high alcohol for extraction; fixed oils are not captured in tinctures. HIGHLY TOXIC — causes severe GI and mucosal irritation; associated with co-carcinogenic activity. Internal use is not appropriate in standard herbal practice. Flagged for review.',
  true
)
ON CONFLICT (herb_id) DO NOTHING;

-- Evening Primrose (Oenothera biennis, herb_id 1139):
-- GLA (gamma-linolenic acid) — fixed fatty acid oil; not a tincture herb
INSERT INTO herbal.herb_menstruum
  (herb_id, water_effective, primary_label, notes, needs_review)
VALUES (
  1139, false,
  'seed oil only — not a tincture herb',
  'Medicinal value lies entirely in the seed fixed oil (8–10% GLA — gamma-linolenic acid), which is not extractable in water or alcohol tinctures. Commercially available as a cold-pressed seed oil in capsules. No meaningful tincture preparation exists.',
  false
)
ON CONFLICT (herb_id) DO NOTHING;

-- Maca (Lepidium meyenii, herb_id 851):
-- Glucosinolates (glucotropaeolin), macamides (fatty acid amides), alkaloids (macaenes)
-- Typically used as food/powder; tinctures are possible but uncommon
INSERT INTO herbal.herb_menstruum
  (herb_id, alcohol_pct_min, alcohol_pct_max, water_effective, primary_label, notes, needs_review)
VALUES (
  851, 25, 40, true,
  '25–40% alcohol or powder (preferred form)',
  'Glucosinolates and macamides (fatty acid amides) are extractable in water and 25–40% alcohol; powdered root (traditionally sun-dried) is the standard preparation and preferred over tincture. Tinctures are commercially available but standardised powder extracts and whole root are more consistent. Root is the medicinal part.',
  false
)
ON CONFLICT (herb_id) DO NOTHING;

-- Peyote (Lophophora williamsii, herb_id 2350):
-- Mescaline (phenethylamine alkaloid) and related phenethylamines — controlled substance;
-- DB captures only phytosterols, not mescaline alkaloids
INSERT INTO herbal.herb_menstruum
  (herb_id, water_effective, primary_label, notes, needs_review)
VALUES (
  2350, true,
  'controlled substance — needs review',
  'Primary actives are mescaline and related phenethylamine alkaloids (Schedule I controlled substance in the US; regulated in most jurisdictions); the DB herb record captures only phytosterols. Alkaloids would extract in water and 25–60% alcohol. Not appropriate for clinical herbal practice; traditional sacramental use only in specific legal/cultural contexts. Flagged for review.',
  true
)
ON CONFLICT (herb_id) DO NOTHING;

-- Pumpkin (Cucurbita pepo, herb_id 183):
-- Phytosterols (beta-sitosterol), fatty acids (seed oil), cucurbitacins —
-- seed oil is the medicinal form; not a tincture herb
INSERT INTO herbal.herb_menstruum
  (herb_id, water_effective, primary_label, notes, needs_review)
VALUES (
  183, false,
  'seed oil / whole seed — not a tincture herb',
  'Medicinal use centres on the seed: phytosterols (beta-sitosterol) and unsaturated fatty acids are not meaningfully extracted in water or alcohol tinctures. Cold-pressed seed oil or whole seeds are the standard preparations for BPH and urinary indications.',
  false
)
ON CONFLICT (herb_id) DO NOTHING;

-- Ragwort (Senecio jacobaea, herb_id 1855):
-- Pyrrolizidine alkaloids (PAs: senecionine, retrorsine, jacobine) — hepatotoxic;
-- DB does not capture PAs in herb_constituents — flagged for review
INSERT INTO herbal.herb_menstruum
  (herb_id, water_effective, primary_label, notes, needs_review)
VALUES (
  1855, true,
  'not for internal use — PA hepatotoxicity',
  'Very high in pyrrolizidine alkaloids (PAs: senecionine, retrorsine, jacobine) which are not captured in the herb_constituents DB. PAs are water-soluble and extract in both water and alcohol. CONTRAINDICATED internally — PAs cause cumulative hepatotoxicity and veno-occlusive disease; no safe internal dose in standard herbal practice. External use only (topical, traditional); avoid entirely in pregnancy. Flagged for review.',
  true
)
ON CONFLICT (herb_id) DO NOTHING;

-- Spinach (Spinacia oleracea, herb_id 2352):
-- Food herb; oxalates, nitrates, flavonoids, vitamins — not a tincture herb
INSERT INTO herbal.herb_menstruum
  (herb_id, water_effective, primary_label, notes, needs_review)
VALUES (
  2352, true,
  'food herb — not a tincture preparation',
  'Primarily a food herb; flavonoids and minerals are water-extractable but therapeutic use is as whole food or juice, not tincture. No established tincture preparation in the Western herbal tradition.',
  false
)
ON CONFLICT (herb_id) DO NOTHING;
