-- Batch C: alkaloid herbs (26 herbs)
-- Sub-groups:
--   C1: basic nitrogen alkaloids (isoquinoline, indole, benzophenanthridine, quinolizidine)
--       → 40–65% alcohol + 5–10% vinegar
--   C2: pyrrolizidine / betaine-type pyrrolidine / mixed-profile alkaloids
--       → 25–65% alcohol, no vinegar
--   C3: purine alkaloids (water-soluble)
--       → 25–50% alcohol, water effective, no vinegar
-- Avena sativa straw (2287) and colloidal (2288) use direct INSERT — three rows share
-- the same latin_name so set_menstruum would be ambiguous.

SET search_path TO herbal, public;

DO $$
BEGIN

  -- ── C1: Basic nitrogen alkaloids — alcohol + vinegar ────────────────────────

  -- Caulophyllum thalictroides (Blue Cohosh):
  -- N-methylcytisine, anagyrine, baptifoline (quinolizidine alkaloids) + saponins
  PERFORM herbal.set_menstruum(
    'Caulophyllum thalictroides', 40, 60, NULL, 10, false,
    '40–60% alcohol + 5–10% vinegar',
    'N-Methylcytisine, anagyrine, and baptifoline (quinolizidine alkaloids) require moderate alcohol with 5–10% vinegar for alkaloid salt formation. Saponins also present. Potent uterotonic — contraindicated in pregnancy.',
    false
  );

  -- Tinospora cordifolia (Guduchi):
  -- Berberine, palmatine (isoquinoline alkaloids)
  PERFORM herbal.set_menstruum(
    'Tinospora cordifolia', 40, 60, NULL, 10, false,
    '40–60% alcohol + 5–10% vinegar',
    'Berberine and palmatine (isoquinoline alkaloids) require moderate alcohol with 5–10% vinegar for alkaloid salt formation.',
    false
  );

  -- Cephaelis ipecacuanha (Ipecac):
  -- Emetine, cephaeline (isoquinoline alkaloids) + gallotannin
  -- Tannins can precipitate alkaloids at higher concentrations — keep alcohol at 40–50%
  PERFORM herbal.set_menstruum(
    'Cephaelis ipecacuanha', 40, 55, NULL, 10, false,
    '40–55% alcohol + 5–10% vinegar',
    'Emetine and cephaeline (isoquinoline alkaloids) require moderate alcohol with 5–10% vinegar. Gallotannin can precipitate alkaloids at higher concentrations — keep alcohol at 40–55% to minimise this effect. Narrow emetic dose range; use with great caution.',
    false
  );

  -- Vinca minor (Lesser Periwinkle, aerial parts):
  -- Vincamine (monoterpene indole alkaloid) + flavonols
  PERFORM herbal.set_menstruum(
    'Vinca minor', 50, 65, NULL, 10, false,
    '50–65% alcohol + 5–10% vinegar',
    'Vincamine (monoterpene indole alkaloid) requires moderate-high alcohol with 5–10% vinegar for alkaloid salt extraction. Flavonols also present and partially water-extractable.',
    false
  );

  -- Zanthoxylum americanum (Prickly Ash):
  -- Chelerythrine, sanguinarine (benzophenanthridine alkaloids) + monoterpenes
  PERFORM herbal.set_menstruum(
    'Zanthoxylum americanum', 50, 65, NULL, 10, false,
    '50–65% alcohol + 5–10% vinegar',
    'Chelerythrine and sanguinarine (benzophenanthridine alkaloids) require moderate-high alcohol with 5–10% vinegar. Monoterpenes also present and need alcohol.',
    false
  );

  -- Papaver spp. (Poppy):
  -- Morphine, codeine, papaverine, noscapine (isoquinoline / phenanthrene alkaloids)
  PERFORM herbal.set_menstruum(
    'Papaver spp.', 40, 60, NULL, 10, false,
    '40–60% alcohol + 5–10% vinegar',
    'Morphine, codeine, papaverine, and noscapine (isoquinoline and phenanthrene alkaloids) require moderate alcohol with 5–10% vinegar for alkaloid salt extraction. Regulated in most jurisdictions for opiate alkaloid content; preparation restricted to licensed compounders.',
    false
  );

  -- Gelsemium sempervirens (Yellow Jasmine):
  -- Gelsemine, gelsemicine (indole alkaloids) — extremely narrow therapeutic index
  PERFORM herbal.set_menstruum(
    'Gelsemium sempervirens', 50, 65, NULL, 10, false,
    '50–65% alcohol + 5–10% vinegar',
    'Gelsemine and gelsemicine (indole alkaloids) require moderate-high alcohol with 5–10% vinegar. Extremely narrow therapeutic index — potentially fatal at small overdose. Professional use only.',
    false
  );

  -- Pausinystalia johimbe (Yohimbe, bark):
  -- Yohimbine, corynanthine (indole alkaloids) + polyphenols
  PERFORM herbal.set_menstruum(
    'Pausinystalia johimbe', 50, 65, NULL, 10, false,
    '50–65% alcohol + 5–10% vinegar',
    'Yohimbine and corynanthine (indole alkaloids) require moderate-high alcohol with 5–10% vinegar for alkaloid salt extraction. Polyphenols also present. Use with caution — narrow therapeutic window and cardiovascular effects.',
    false
  );

  -- ── C2: Pyrrolizidine / betaine-type / mixed alkaloids — no vinegar ──────────

  -- Piper nigrum (Black Pepper):
  -- Piperine is a piperidine AMIDE (not a basic amine) — vinegar not applicable
  -- Bicyclic monoterpenes and sesquiterpenes also need alcohol
  PERFORM herbal.set_menstruum(
    'Piper nigrum', 50, 70, NULL, NULL, false,
    '50–70% alcohol',
    'Piperine is a piperidine amide — not a basic amine — so vinegar confers no extraction benefit. Bicyclic monoterpenes and sesquiterpenes also need moderate-high alcohol. Water extraction is largely ineffective for piperine.',
    false
  );

  -- Marsdenia condurango (Condurango):
  -- Condurangoside pregnane glycosides + pregnane alkaloids + saponins
  PERFORM herbal.set_menstruum(
    'Marsdenia condurango', 40, 60, NULL, NULL, false,
    '40–60% alcohol',
    'Condurangoside pregnane glycosides and pregnane alkaloids extract in moderate alcohol; saponins also present. Water is largely ineffective for the glycoside fraction.',
    false
  );

  -- Daucus carota (Wild Carrot):
  -- Volatile oils (bicyclic monoterpene, monoterpene alcohol / ester, sesquiterpene alcohol)
  -- and polyacetylenes dominate; piperidine alkaloid is a minor constituent
  PERFORM herbal.set_menstruum(
    'Daucus carota', 50, 65, NULL, NULL, false,
    '50–65% alcohol',
    'Volatile oils (α-pinene, geraniol, linalool), polyacetylenes, and carotenoids dominate the extraction profile and require moderate-high alcohol. A minor piperidine alkaloid is also present but is not the primary therapeutic constituent.',
    false
  );

  -- Trigonella foenum-graecum (Fenugreek):
  -- Trigonelline (betaine-type pyridine alkaloid, water-soluble) + diosgenin (steroidal
  -- saponin aglycone) + flavone C-glycosides; seed decoction is traditional
  PERFORM herbal.set_menstruum(
    'Trigonella foenum-graecum', 40, 60, NULL, NULL, true,
    '40–60% alcohol or water infusion',
    'Trigonelline (betaine-type alkaloid) is highly water-soluble; seed decoction is traditional. Diosgenin (steroidal saponin aglycone) and other saponins require moderate alcohol for full extraction.',
    false
  );

  -- Galega officinalis (Goat's Rue):
  -- Galegine (isoamylene guanidine alkaloid, moderately water-soluble) + flavones,
  -- flavonols, hydroxycinnamic acids
  PERFORM herbal.set_menstruum(
    'Galega officinalis', 40, 60, NULL, NULL, true,
    '40–60% alcohol or water infusion',
    'Galegine (guanidine alkaloid) is moderately water-soluble; infusion extracts it adequately. Flavones and hydroxycinnamic acids also extract in water. Moderate alcohol provides fuller spectrum extraction.',
    false
  );

  -- Eupatorium purpureum (Gravel Root):
  -- Pyrrolizidine alkaloids + flavones, flavonols, hydroxycinnamic acids
  PERFORM herbal.set_menstruum(
    'Eupatorium purpureum', 40, 60, NULL, NULL, true,
    '40–60% alcohol or water infusion',
    'Pyrrolizidine alkaloids extract in moderate alcohol; flavones and hydroxycinnamic acids extract in both alcohol and water. Contains hepatotoxic pyrrolizidine alkaloids — use only under professional guidance; avoid in liver disease or pregnancy.',
    false
  );

  -- Senecio aureus (Life Root):
  -- Pyrrolizidine alkaloids (senecionine, seneciphylline) — rarely used clinically
  PERFORM herbal.set_menstruum(
    'Senecio aureus', 40, 60, NULL, NULL, false,
    '40–60% alcohol',
    'Pyrrolizidine alkaloids (senecionine, seneciphylline) extract in moderate alcohol. Rarely used in modern clinical practice due to hepatotoxic pyrrolizidine alkaloid content.',
    true
  );

  -- Symplocarpus foetidus (Skunk Cabbage):
  -- Piperidine alkaloid + flavonols, hydroxycinnamic acids
  PERFORM herbal.set_menstruum(
    'Symplocarpus foetidus', 40, 60, NULL, NULL, false,
    '40–60% alcohol',
    'The piperidine alkaloid and flavonols require moderate alcohol. Volatile irritant compounds responsible for the characteristic odour are also best preserved in alcohol.',
    false
  );

  -- Collinsonia canadensis (Stoneroot):
  -- Stachydrine-type betaine alkaloids (water-soluble) + monoterpenes
  -- + pentacyclic triterpenoids + hydroxycinnamic acids; monoterpenes drive alcohol choice
  PERFORM herbal.set_menstruum(
    'Collinsonia canadensis', 40, 60, NULL, NULL, false,
    '40–60% alcohol',
    'Monoterpenes and pentacyclic triterpenoids require moderate alcohol. Pyrrolidine alkaloids are betaine-type (stachydrine class, water-soluble) so vinegar is not needed; the overall volatile oil and triterpenoid profile drives the alcohol requirement.',
    false
  );

  -- Petasites palmatus (Western Coltsfoot):
  -- Pyrrolizidine alkaloids + sesquiterpenes
  PERFORM herbal.set_menstruum(
    'Petasites palmatus', 40, 60, NULL, NULL, false,
    '40–60% alcohol',
    'Pyrrolizidine alkaloids and sesquiterpenes require moderate alcohol. Contains hepatotoxic pyrrolizidine alkaloids — internal use is not recommended without professional oversight.',
    true
  );

  -- Stachys officinalis (Wood Betony):
  -- Stachydrine, betonicine (betaine-type pyrrolidine alkaloids, highly water-soluble)
  -- + iridoid glycosides; infusion is entirely adequate
  PERFORM herbal.set_menstruum(
    'Stachys officinalis', 25, 50, NULL, NULL, true,
    '25–50% alcohol or water infusion',
    'Stachydrine and betonicine (betaine-type alkaloids) are highly water-soluble; infusion is effective. Iridoid glycosides also extract in water. Moderate alcohol provides slightly fuller extraction of minor lipophilic constituents.',
    false
  );

  -- ── C3: Purine alkaloids — water-soluble, low alcohol or infusion ─────────────

  -- Coffea arabica (Coffee):
  -- Caffeine + trigonelline (both water-soluble) + chlorogenic acid (hydroxycinnamic acid)
  PERFORM herbal.set_menstruum(
    'Coffea arabica', 25, 50, NULL, NULL, true,
    '25–50% alcohol or water infusion',
    'Caffeine and trigonelline (betaine alkaloid) are highly water-soluble — coffee itself is a water infusion. Chlorogenic acid is also water-extractable. Moderate alcohol concentrates xanthines further.',
    false
  );

  -- Paullinia cupana (Guarana):
  -- Caffeine, theobromine (purine alkaloids) + catechins (flavan-3-ols)
  PERFORM herbal.set_menstruum(
    'Paullinia cupana', 25, 50, NULL, NULL, true,
    '25–50% alcohol or water infusion',
    'Caffeine and theobromine (purine alkaloids) are highly water-soluble; water infusion is effective. Catechins (flavan-3-ols) also extract in water or moderate alcohol.',
    false
  );

  -- Cola acuminata (Kola):
  -- Caffeine, theobromine + catechins
  PERFORM herbal.set_menstruum(
    'Cola acuminata', 25, 50, NULL, NULL, true,
    '25–50% alcohol or water infusion',
    'Caffeine and theobromine (purine alkaloids) are highly water-soluble. Catechins (flavan-3-ols) also extract in water or moderate alcohol. Traditional use is as decoction or infusion.',
    false
  );

  -- Cola vera (Kola Nut):
  -- Essentially the same profile as Cola acuminata
  PERFORM herbal.set_menstruum(
    'Cola vera', 25, 50, NULL, NULL, true,
    '25–50% alcohol or water infusion',
    'Caffeine and theobromine (purine alkaloids) are highly water-soluble. Catechins (flavan-3-ols) also extract in water or moderate alcohol. Extraction profile is essentially identical to Cola acuminata.',
    false
  );

  -- Camellia sinensis (Tea):
  -- Caffeine, theobromine (purine alkaloids)
  PERFORM herbal.set_menstruum(
    'Camellia sinensis', 25, 50, NULL, NULL, true,
    '25–50% alcohol or water infusion',
    'Caffeine and theobromine (purine alkaloids) are highly water-soluble; the traditional preparation is hot water infusion. Moderate alcohol can concentrate xanthine alkaloids slightly.',
    false
  );

  -- Ilex paraguayensis (Yerba Mate):
  -- Caffeine, theobromine + flavonol glycosides + chlorogenic acid (hydroxycinnamic acid)
  PERFORM herbal.set_menstruum(
    'Ilex paraguayensis', 25, 50, NULL, NULL, true,
    '25–50% alcohol or water infusion',
    'Caffeine and theobromine (purine alkaloids) are highly water-soluble; mate is traditionally prepared as a water infusion. Flavonol glycosides and chlorogenic acid also extract well in water.',
    false
  );

  RAISE NOTICE 'Batch C alkaloids (set_menstruum calls): 24 records inserted/updated.';
END $$;

-- ── C4: Avena sativa — direct INSERT by herb_id (3 rows share the same latin_name) ──

-- Avena sativa straw (herb_id 2287):
-- Gramine (indole alkaloid), avenine, avenacosides (saponins) need moderate alcohol;
-- polysaccharides (beta-glucan), silica, minerals extract in water
INSERT INTO herbal.herb_menstruum
  (herb_id, alcohol_pct_min, alcohol_pct_max, water_effective, primary_label, notes, needs_review)
VALUES (
  2287, 40, 60, true,
  '40–60% alcohol or water infusion',
  'Gramine (indole alkaloid), avenine, and avenacosides (saponins) extract in moderate alcohol; beta-glucan polysaccharides, silica, and minerals extract in water. Straw decoction is traditional for mineral and nutritive content; tincture concentrates the alkaloid and saponin fractions.',
  false
)
ON CONFLICT (herb_id) DO NOTHING;

-- Avena sativa colloidal (herb_id 2288):
-- Colloidal oatmeal is a topical suspension — not an internal tincture
-- Avenanthramides (hydroxycinnamic acid derivatives) and tocopherols
INSERT INTO herbal.herb_menstruum
  (herb_id, water_effective, primary_label, notes, needs_review)
VALUES (
  2288, true,
  'water suspension (topical)',
  'Colloidal oatmeal is a topical preparation; avenanthramides (hydroxycinnamic acid derivatives) and tocopherols are suspended in water for skin application. Not used as an internal tincture.',
  false
)
ON CONFLICT (herb_id) DO NOTHING;
