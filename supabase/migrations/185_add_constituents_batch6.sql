-- Migration 185: Add general constituents to Hydrangea, Kutki,
-- Lesser Periwinkle, Maral Root, Sandalwood, and Wild Carrot.

SET search_path TO herbal, public;

-- ============================================================
-- Block 1: Hydrangea (Hydrangea arborescens) — root
-- Already has: coumarins (coumarin, major)
-- umbelliferone, kaempferol, quercetin, triterpenoid saponins already in DB
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('skimmin', 'coumarin glycoside',
    'Umbelliferyl-beta-D-glucopyranoside; the 7-O-glucoside of umbelliferone and the predominant water-soluble coumarin form in Hydrangea root. Hydrolysed to umbelliferone (historically called hydrangin) in the gut; accounts for a substantial proportion of coumarin content in aqueous and hydroalcoholic extracts used clinically.');
  PERFORM herbal.ensure_constituent('hydrangeic acid', 'hydroxycinnamic acid',
    '3,4-Dimethoxycinnamic acid; a characteristic and relatively species-specific phenolic marker of H. arborescens root. Anti-inflammatory and antioxidant properties; used alongside umbelliferone/skimmin for species authentication and quality control.');
  PERFORM herbal.ensure_constituent('hydrangenol', 'dihydroisocoumarin',
    'Phyllodulcin-related dihydroisocoumarin lactone; anti-inflammatory activity; a chemotaxonomic marker for the Hydrangeaceae family not widely occurring in other urinary herbs. Contributes to the coumarin-class extractive fraction.');

  PERFORM herbal.link_constituent('Hydrangea arborescens', 'umbelliferone',       'primary',  0);
  PERFORM herbal.link_constituent('Hydrangea arborescens', 'skimmin',             'major',    10);
  PERFORM herbal.link_constituent('Hydrangea arborescens', 'kaempferol',          'moderate', 20);
  PERFORM herbal.link_constituent('Hydrangea arborescens', 'quercetin',           'moderate', 30);
  PERFORM herbal.link_constituent('Hydrangea arborescens', 'hydrangeic acid',     'moderate', 40);
  PERFORM herbal.link_constituent('Hydrangea arborescens', 'hydrangenol',         'moderate', 50);
  PERFORM herbal.link_constituent('Hydrangea arborescens', 'triterpenoid saponins','major',   60);

  RAISE NOTICE 'Added constituents to Hydrangea (Hydrangea arborescens)';
END $$;

-- ============================================================
-- Block 2: Kutki (Picrorrhiza kurroa) — rhizome
-- Already has: iridoid glycosides (iridoid glycoside, major)
-- beta-sitosterol already in DB
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('picroside I', 'iridoid glycoside',
    'Primary EMA marker compound; catalpol esterified at C-6 with a cinnamoyl group. Major hepatoprotective, anti-inflammatory, and immunostimulant compound; anti-cholestatic and antifibrotic in liver disease models. European Pharmacopoeia standardisation target (minimum 2% in quality preparations).');
  PERFORM herbal.ensure_constituent('picroside II', 'iridoid glycoside',
    'Also called minecoside; catalpol esterified at C-6 with a feruloyl group. Co-primary EMA marker; roughly equimolar with picroside I in native rhizome. Potent hepatoprotective and antioxidant (superior to silymarin on some radical-scavenging measures); anti-inflammatory via TNF-α, IL-6, and COX-2 inhibition.');
  PERFORM herbal.ensure_constituent('kutkin', 'iridoid glycoside mixture',
    'The picroside I + picroside II co-isolate (~1:1 ratio) originally extracted as the bitter principle of P. kurroa; the standardisation target in commercial quality monographs (≥4% kutkin in rhizome preparations). Included for extract-standardisation context; not a separate chemical entity from the individual picrosides.');
  PERFORM herbal.ensure_constituent('androsin', 'acetophenone glycoside',
    'Also called picein; p-hydroxyacetophenone-4-O-beta-D-glucopyranoside. Distinct from picroside II (a common misattribution). Potent mast cell stabiliser (inhibits antigen-induced histamine release); anti-asthmatic and immunomodulatory. An important secondary marker compound relevant to the herb''s respiratory and allergic indications.');
  PERFORM herbal.ensure_constituent('catalpol', 'iridoid glycoside',
    'The parent iridoid glycoside backbone from which picroside I and II are both esterified; present as free catalpol in the rhizome. Hepatoprotective, anti-inflammatory, and neuroprotective in its own right; contributes to the overall iridoid activity profile.');
  PERFORM herbal.ensure_constituent('apocynin', 'acetophenone',
    '4-Hydroxy-3-methoxyacetophenone (= acetovanillone); a selective NADPH oxidase inhibitor with well-characterised anti-inflammatory and antioxidant mechanisms. Anti-asthmatic activity complements the picrosides; also used as a pharmacological research tool compound.');
  PERFORM herbal.ensure_constituent('vanillic acid', 'hydroxybenzoic acid',
    'Simple phenolic acid present in P. kurroa rhizome; antioxidant and hepatoprotective; contributes to phenolic fingerprinting of the rhizome for quality control alongside the picrosides and androsin.');

  PERFORM herbal.link_constituent('Picrorrhiza kurroa', 'picroside I',    'primary',  0);
  PERFORM herbal.link_constituent('Picrorrhiza kurroa', 'picroside II',   'primary',  10);
  PERFORM herbal.link_constituent('Picrorrhiza kurroa', 'kutkin',         'major',    20);
  PERFORM herbal.link_constituent('Picrorrhiza kurroa', 'androsin',       'major',    30);
  PERFORM herbal.link_constituent('Picrorrhiza kurroa', 'catalpol',       'moderate', 40);
  PERFORM herbal.link_constituent('Picrorrhiza kurroa', 'apocynin',       'moderate', 50);
  PERFORM herbal.link_constituent('Picrorrhiza kurroa', 'beta-sitosterol','minor',    60);
  PERFORM herbal.link_constituent('Picrorrhiza kurroa', 'vanillic acid',  'minor',    70);

  RAISE NOTICE 'Added constituents to Kutki (Picrorrhiza kurroa)';
END $$;

-- ============================================================
-- Block 3: Lesser Periwinkle (Vinca minor) — aerial parts
-- Already has: alkaloids (alkaloid, major)
-- rutin, quercetin already in DB
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('vincamine', 'monoterpene indole alkaloid',
    'Primary marker alkaloid (~0.3–0.5% dry aerial parts); European Pharmacopoeia standardisation compound. Inhibits phosphodiesterase and blocks alpha-adrenoceptors, producing cerebral vasodilation and improved cerebral blood flow. Biosynthetic precursor to vinpocetine (the semi-synthetic pharmaceutical derivative).');
  PERFORM herbal.ensure_constituent('minovincine', 'monoterpene indole alkaloid',
    'Oxindole-type monoterpene indole alkaloid documented at moderate concentrations in V. minor aerial parts; contributes to the total cerebrovascular alkaloid pharmacology of the plant alongside vincamine.');
  PERFORM herbal.ensure_constituent('vincaminoreine', 'monoterpene indole alkaloid',
    'Minor V. minor-specific alkaloid; contributes to the characteristic alkaloid fingerprint distinguishing V. minor from V. major in botanical authentication and quality control.');

  PERFORM herbal.link_constituent('Vinca minor', 'vincamine',       'primary',  0);
  PERFORM herbal.link_constituent('Vinca minor', 'minovincine',     'moderate', 20);
  PERFORM herbal.link_constituent('Vinca minor', 'vincaminoreine',  'minor',    30);
  PERFORM herbal.link_constituent('Vinca minor', 'rutin',           'minor',    40);
  PERFORM herbal.link_constituent('Vinca minor', 'quercetin',       'minor',    50);

  RAISE NOTICE 'Added constituents to Lesser Periwinkle (Vinca minor)';
END $$;

-- ============================================================
-- Block 4: Maral Root (Leuzea carthamoides) — root/rhizome
-- Already has: chlorogenic acid (hydroxycinnamic acid, minor)
-- rutin, kaempferol already in DB
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('20-hydroxyecdysone', 'phytoecdysteroid',
    'The dominant ecdysteroid (~70–80% of total ecdysteroid fraction; up to 1.5% root dry weight). Anabolic activity via estrogen receptor beta (ERβ) without androgenic side effects; improves muscle protein synthesis and physical endurance. Primary standardisation marker for Leuzea/Rhaponticum root; proposed for WADA monitoring.');
  PERFORM herbal.ensure_constituent('turkesterone', 'phytoecdysteroid',
    'Second most abundant ecdysteroid; identical ERβ-mediated anabolic mechanism as 20-hydroxyecdysone. The most heavily studied ecdysteroid in contemporary sports supplementation and adaptogenic research; markedly increases muscle mass in rodent models.');
  PERFORM herbal.ensure_constituent('inokosterone', 'phytoecdysteroid',
    'Third-ranking ecdysteroid in L. carthamoides root; documented in systematic phytochemical surveys; contributes to the adaptogenic and tonic activity of the herb alongside the dominant ecdysteroids.');
  PERFORM herbal.ensure_constituent('polypodine B', 'phytoecdysteroid',
    'C-20 epimer of 20-hydroxyecdysone; a distinct compound (not a synonym) confirmed as a real minor-to-moderate constituent; contributes to the characteristic polyhydroxylated steroid profile of the genus.');
  PERFORM herbal.ensure_constituent('ajugasterone C', 'phytoecdysteroid',
    'Minor ecdysteroid confirmed in L. carthamoides root; adds breadth to the characteristic ecdysteroid fingerprint; contributes to the adaptogenic activity of the total ecdysteroid fraction.');
  PERFORM herbal.ensure_constituent('rhaponticin', 'stilbene glycoside',
    'Chemotaxonomic marker of the Leuzea/Rhaponticum genus; stilbene glucoside with antioxidant, anti-platelet, and anti-inflammatory activity. Distinguishes authentic Leuzea root from adulterants and contributes to the herb''s cardiovascular-protective profile.');

  PERFORM herbal.link_constituent('Leuzea carthamoides', '20-hydroxyecdysone', 'primary',  0);
  PERFORM herbal.link_constituent('Leuzea carthamoides', 'turkesterone',       'major',    10);
  PERFORM herbal.link_constituent('Leuzea carthamoides', 'inokosterone',       'major',    20);
  PERFORM herbal.link_constituent('Leuzea carthamoides', 'polypodine B',       'moderate', 30);
  PERFORM herbal.link_constituent('Leuzea carthamoides', 'ajugasterone C',     'moderate', 40);
  PERFORM herbal.link_constituent('Leuzea carthamoides', 'rhaponticin',        'moderate', 50);
  PERFORM herbal.link_constituent('Leuzea carthamoides', 'rutin',              'minor',    60);
  PERFORM herbal.link_constituent('Leuzea carthamoides', 'kaempferol',         'minor',    70);

  RAISE NOTICE 'Added constituents to Maral Root (Leuzea carthamoides)';
END $$;

-- ============================================================
-- Block 5: Sandalwood (Santalum album) — heartwood/essential oil
-- Already has: sesquiterpenes (sesquiterpene, major)
-- farnesol, bergapten, linalool already in DB
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('alpha-santalol', 'sesquiterpene alcohol',
    'Primary ISO 3518 standardisation marker (~45–55% of authentic EO; minimum 41% per standard). Anti-inflammatory via COX-2/5-LOX inhibition; broad antimicrobial and antifungal; anxiolytic in human clinical studies; antiproliferative via EGFR/tyrosine kinase inhibition. The defining quality compound of Santalum album oil.');
  PERFORM herbal.ensure_constituent('beta-santalol', 'sesquiterpene alcohol',
    'Co-primary ISO 3518 marker (~20–25% of EO; co-regulated with alpha-santalol). Urinary antiseptic (classic Ayurvedic and Western herbalism use for UTI), antimicrobial, anxiolytic. Pharmacologically additive and partially synergistic with alpha-santalol.');
  PERFORM herbal.ensure_constituent('alpha-santalene', 'sesquiterpene',
    'Tricyclic sesquiterpene (~5% of EO); biosynthetic precursor to alpha-santalol (oxidised by CYP76F). Mild antimicrobial; chemotaxonomic authentication marker to distinguish genuine S. album from substitutes such as S. spicatum.');
  PERFORM herbal.ensure_constituent('beta-santalene', 'sesquiterpene',
    'Tricyclic sesquiterpene (~3% of EO); biosynthetically paired with beta-santalol. Quality-control fragrance marker; elevated ratio relative to santalols is a diagnostic for adulterated or substitute oils.');
  PERFORM herbal.ensure_constituent('bergamotol', 'sesquiterpene alcohol',
    'Mix of cis-alpha- and cis-beta-bergamotol (~2–4% combined); anti-inflammatory, mild antimicrobial. Elevated in Australian sandalwood (S. spicatum) and adulterated oils — the bergamotol:santalol ratio is a key species authentication diagnostic for genuine S. album.');

  PERFORM herbal.link_constituent('Santalum album', 'alpha-santalol',  'primary',  0);
  PERFORM herbal.link_constituent('Santalum album', 'beta-santalol',   'primary',  20);
  PERFORM herbal.link_constituent('Santalum album', 'alpha-santalene', 'major',    30);
  PERFORM herbal.link_constituent('Santalum album', 'beta-santalene',  'major',    40);
  PERFORM herbal.link_constituent('Santalum album', 'bergamotol',      'moderate', 50);
  PERFORM herbal.link_constituent('Santalum album', 'farnesol',        'minor',    60);
  PERFORM herbal.link_constituent('Santalum album', 'bergapten',       'trace',    70);
  PERFORM herbal.link_constituent('Santalum album', 'linalool',        'trace',    80);

  RAISE NOTICE 'Added constituents to Sandalwood (Santalum album)';
END $$;

-- ============================================================
-- Block 6: Wild Carrot (Daucus carota)
-- Already has: sabinene (bicyclic monoterpene, moderate)
-- beta-carotene, luteolin, quercetin, kaempferol, alpha-pinene, linalool already in DB
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('carotol', 'sesquiterpene alcohol',
    'The defining GC/pharmacopoeial marker of D. carota seed essential oil (~30–80% by chemotype); responsible for the characteristic earthy-carrot odour. Antimicrobial, antifungal, hepatoprotective (rodent models), and diuretic activity. Primary quality-control compound for carrot seed oil authentication.');
  PERFORM herbal.ensure_constituent('geranyl acetate', 'monoterpene ester',
    'Monoterpene alcohol ester (~5–10% of seed EO); antifungal (Candida, dermatophytes), carminative, and mild antispasmodic. Sweet floral-rosy fragrance modifier used alongside carotol for seed oil authentication and quality fingerprinting.');
  PERFORM herbal.ensure_constituent('daucine', 'piperidine alkaloid',
    'The characteristic alkaloid of D. carota seed (~0.1–0.3%); responsible for the traditional emmenagogue and abortifacient use of carrot seed. Uterotonic in vitro — the primary pharmacological basis for contraindication in pregnancy. An important safety constituent for clinical counselling.');
  PERFORM herbal.ensure_constituent('falcarinol', 'polyacetylene',
    'C-17 polyacetylenic alcohol; characteristic of the Apiaceae family. Antimicrobial, antifungal, and cytotoxic in vitro; a documented contact allergen causing occupational dermatitis in food handlers. Safety-relevant in concentrated extracts; the Apiaceae-family polyacetylene marker (also called carotatoxin in some Daucus literature).');

  PERFORM herbal.link_constituent('Daucus carota', 'carotol',       'primary',  0);
  PERFORM herbal.link_constituent('Daucus carota', 'beta-carotene', 'major',    10);
  PERFORM herbal.link_constituent('Daucus carota', 'geranyl acetate','moderate',20);
  PERFORM herbal.link_constituent('Daucus carota', 'daucine',       'minor',    30);
  PERFORM herbal.link_constituent('Daucus carota', 'falcarinol',    'minor',    40);
  PERFORM herbal.link_constituent('Daucus carota', 'luteolin',      'minor',    50);
  PERFORM herbal.link_constituent('Daucus carota', 'quercetin',     'minor',    60);
  PERFORM herbal.link_constituent('Daucus carota', 'kaempferol',    'minor',    70);
  PERFORM herbal.link_constituent('Daucus carota', 'alpha-pinene',  'minor',    80);
  PERFORM herbal.link_constituent('Daucus carota', 'linalool',      'trace',    90);

  RAISE NOTICE 'Added constituents to Wild Carrot (Daucus carota)';
END $$;
