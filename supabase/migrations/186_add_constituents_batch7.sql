-- Migration 186: Add general constituents to Benzoin, Devil's Club,
-- Pumpkin, Seneca Snakeroot, Yerba Santa, and Ylang Ylang.

SET search_path TO herbal, public;

-- ============================================================
-- Block 1: Benzoin (Styrax benzoin) — resin (Siam type)
-- Already has: resins (resin, major, sort_order 10)
-- trans-cinnamic acid already in DB
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('coniferyl benzoate', 'phenylpropanoid ester',
    'The dominant constituent of Siam benzoin resin (~50–60% dry weight); the defining ester formed from coniferyl alcohol + benzoic acid. Primary antiseptic, wound-healing, and topical anti-inflammatory compound; releases benzoic acid vapour on heating, providing expectorant activity. European Pharmacopoeia standardisation marker and the principal compound used to authenticate genuine Siam benzoin (S. benzoin) from Sumatra-type (S. paralleloneurum).');
  PERFORM herbal.ensure_constituent('benzoic acid', 'aromatic acid',
    'Free aromatic acid in benzoin resin (~7–10%); broad antimicrobial against bacteria and fungi (the basis for the BPC use as a topical preservative). Volatile on warming — the primary expectorant principle of compound benzoin tincture and Friar''s Balsam. Responsible for the characteristic sharp odour; conjugated to hippuric acid in vivo. Used as a QC marker and safety reference for high-dose preparations.');
  PERFORM herbal.ensure_constituent('coniferyl cinnamate', 'phenylpropanoid ester',
    'The cinnamate ester analogue of coniferyl benzoate (~3–8% of Siam benzoin); co-occurring secondary resin ester. Mild anti-inflammatory and skin-barrier-conditioning activity; a secondary authentication marker used alongside coniferyl benzoate to distinguish Siam from Sumatra benzoin, which has a higher cinnamate:benzoate ratio.');
  PERFORM herbal.ensure_constituent('siaresinotannol', 'resin alcohol',
    'The free phenylpropanoid resin alcohol backbone (dimer of coniferyl alcohol) from which the coniferyl ester series derives; present at minor-to-moderate concentrations. Antioxidant and mildly anti-inflammatory; contributes to the astringent wound-healing properties of benzoin resin; used in phytochemical fingerprinting of the resin fraction.');
  PERFORM herbal.ensure_constituent('vanillin', 'aromatic aldehyde',
    'Aromatic phenolic aldehyde (~0.5–1% of Siam benzoin); the characteristic olfactory marker distinguishing Siam benzoin (S. benzoin, vanillin-rich) from Sumatra benzoin (S. paralleloneurum/sumatranus, vanillin-absent). Mild antifungal and antioxidant; a GC/MS quality-control marker for species authentication; also used as a standard fragrance marker in perfumery QC.');

  PERFORM herbal.link_constituent('Styrax benzoin', 'coniferyl benzoate',  'primary',  0);
  PERFORM herbal.link_constituent('Styrax benzoin', 'benzoic acid',        'major',    20);
  PERFORM herbal.link_constituent('Styrax benzoin', 'trans-cinnamic acid', 'major',    30);
  PERFORM herbal.link_constituent('Styrax benzoin', 'coniferyl cinnamate', 'major',    40);
  PERFORM herbal.link_constituent('Styrax benzoin', 'siaresinotannol',     'moderate', 50);
  PERFORM herbal.link_constituent('Styrax benzoin', 'vanillin',            'minor',    60);

  RAISE NOTICE 'Added constituents to Benzoin (Styrax benzoin)';
END $$;

-- ============================================================
-- Block 2: Devil's Club (Oplopanax horridus) — root bark
-- Already has: polyacetylenes (polyacetylene, major, sort_order 10)
-- falcarinol, kaurenoic acid, oleanolic acid, beta-sitosterol already in DB
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('falcarindiol', 'polyacetylene',
    'C-17 polyacetylenic diol; among the dominant specific polyacetylenes of O. horridus root bark (alongside falcarinol). Antimicrobial, antifungal, cytotoxic, and immunomodulatory in vitro; contributes to the traditional anti-infective and adaptogenic use. A key quality marker distinguishing Devil''s Club from Araliaceae adulterants alongside the named oplopantriols.');
  PERFORM herbal.ensure_constituent('oplopantriol A', 'polyacetylene',
    'C-17 polyacetylenic triol uniquely characteristic of the Oplopanax genus; documented in systematic phytochemical surveys of O. horridus root bark. Antimicrobial and antifungal activity; used as a genus-specific botanical authentication marker to confirm genuine O. horridus identity.');
  PERFORM herbal.ensure_constituent('oplopantriol B', 'polyacetylene',
    'Epimeric C-17 polyacetylenic triol co-occurring with oplopantriol A in root bark; a second Oplopanax-specific authentication marker. Contributes to the overall polyacetylene antimicrobial activity profile; used alongside oplopantriol A in quality-control fingerprinting of Devil''s Club root preparations.');
  PERFORM herbal.ensure_constituent('oplopandiol', 'polyacetylene',
    'C-17 polyacetylenic diol specific to Oplopanax; documented as a minor constituent in root bark phytochemical surveys. Adds to the characteristic polyacetylene antimicrobial and cytotoxic fraction; contributes to botanical authentication and distinguishes the genus from related Araliaceae containing different polyacetylene profiles.');

  PERFORM herbal.link_constituent('Oplopanax horridus', 'falcarindiol',    'major',    0);
  PERFORM herbal.link_constituent('Oplopanax horridus', 'falcarinol',      'major',    20);
  PERFORM herbal.link_constituent('Oplopanax horridus', 'oplopantriol A',  'moderate', 30);
  PERFORM herbal.link_constituent('Oplopanax horridus', 'oplopantriol B',  'moderate', 40);
  PERFORM herbal.link_constituent('Oplopanax horridus', 'oplopandiol',     'moderate', 50);
  PERFORM herbal.link_constituent('Oplopanax horridus', 'kaurenoic acid',  'moderate', 60);
  PERFORM herbal.link_constituent('Oplopanax horridus', 'oleanolic acid',  'minor',    70);
  PERFORM herbal.link_constituent('Oplopanax horridus', 'beta-sitosterol', 'minor',    80);

  RAISE NOTICE 'Added constituents to Devil''s Club (Oplopanax horridus)';
END $$;

-- ============================================================
-- Block 3: Pumpkin (Cucurbita pepo) — seed
-- Already has: phytosterols (phytosterol, moderate)
-- linoleic acid, oleic acid, gamma-tocopherol, beta-sitosterol,
-- campesterol, palmitic acid, zinc already in DB
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('cucurbitin', 'non-protein amino acid',
    '(–)-3-Amino-3-carboxypyrrolidine; the defining antiparasitic amino acid specific to Cucurbita seeds (~0.1–0.4% in raw seed). The primary anthelmintic constituent responsible for the traditional and modern use for intestinal worm expulsion (tapeworms, roundworms); inhibits parasite muscle function without systemic toxicity in mammals. Standardisation target for pumpkin seed preparations used clinically for worm infestation and BPH.');
  PERFORM herbal.ensure_constituent('alpha-tocopherol', 'tocopherol',
    'Primary vitamin E isoform in pumpkin seed oil; potent lipid-soluble antioxidant protecting cell membranes from oxidative damage. Contributes to the oil''s cardiovascular and prostate-protective benefits alongside beta-sitosterol; co-occurring with gamma-tocopherol (which predominates). A key nutritional quality marker in seed oil standardisation.');

  PERFORM herbal.link_constituent('Cucurbita pepo', 'cucurbitin',      'primary',  0);
  PERFORM herbal.link_constituent('Cucurbita pepo', 'linoleic acid',   'major',    10);
  PERFORM herbal.link_constituent('Cucurbita pepo', 'oleic acid',      'major',    20);
  PERFORM herbal.link_constituent('Cucurbita pepo', 'gamma-tocopherol','moderate', 30);
  PERFORM herbal.link_constituent('Cucurbita pepo', 'alpha-tocopherol','moderate', 40);
  PERFORM herbal.link_constituent('Cucurbita pepo', 'beta-sitosterol', 'moderate', 50);
  PERFORM herbal.link_constituent('Cucurbita pepo', 'campesterol',     'minor',    60);
  PERFORM herbal.link_constituent('Cucurbita pepo', 'palmitic acid',   'minor',    70);
  PERFORM herbal.link_constituent('Cucurbita pepo', 'zinc',            'minor',    80);

  RAISE NOTICE 'Added constituents to Pumpkin (Cucurbita pepo)';
END $$;

-- ============================================================
-- Block 4: Seneca Snakeroot (Polygala senega) — root
-- Already has: triterpenoid saponins (saponin, major)
-- methyl salicylate, sinapic acid already in DB
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('senegin II', 'oleanane triterpenoid saponin',
    'Primary bidesmosidic saponin of P. senega root (~5–10% dry weight); the European Pharmacopoeia standardisation marker (minimum 6% total saponins expressed as senegin II equivalents). Irritates GI mucosa to trigger the vagal reflex → bronchial secretion (classic reflex expectorant mechanism); expectorant, diaphoretic, and emetic at higher doses. The defining clinical compound of Seneca Snakeroot.');
  PERFORM herbal.ensure_constituent('senegin III', 'oleanane triterpenoid saponin',
    'Monodesmosidic senegin co-occurring with senegin II; intermediate polarity expectorant saponin. Contributes to the total expectorant and surface-active activity profile of the root; a secondary QC marker included in European Pharmacopoeia saponin assay alongside senegin II.');
  PERFORM herbal.ensure_constituent('senegin IV', 'oleanane triterpenoid saponin',
    'Bidesmosidic oleanane saponin; the least polar of the main senegins. Contributes to the total saponin fraction and included in the European Pharmacopoeia saponin assay; adds to the expectorant and surface-active activity spectrum of the root extract.');
  PERFORM herbal.ensure_constituent('presenegenin', 'oleanane triterpenoid sapogenin',
    'The characteristic aglycone (sapogenin) of the senegin series; structurally distinct from oleanolic acid due to a diol-modified ring system at C-20/C-21. The free sapogenin fraction is present in small amounts; confirms authentic root identity and distinguishes P. senega from Polygala species with different aglycone profiles.');
  PERFORM herbal.ensure_constituent('senegasaponin A', 'triterpenoid saponin',
    'Additional bidesmosidic triterpenoid saponin co-isolated with the senegins; contributes to the overall expectorant saponin profile of P. senega root. Pharmacologically active as a reflex expectorant in its own right; part of the total saponin fingerprint used for species authentication.');
  PERFORM herbal.ensure_constituent('senegasaponin B', 'triterpenoid saponin',
    'Co-occurring triterpenoid saponin of P. senega root; contributes to the full saponin fingerprint used for species authentication and quality grading. Adds surface-active and expectorant activity to the overall saponin fraction alongside senegin II and senegasaponin A.');
  PERFORM herbal.ensure_constituent('polygalacic acid', 'oleanane triterpenoid acid',
    'Free triterpenoid oleanane acid present alongside the saponin fraction (~0.5–1%); mild surfactant and anti-inflammatory via COX inhibition. Contributes to the phenolic extract fraction; used in phytochemical fingerprinting to authenticate P. senega root alongside the characteristic senegin saponins.');

  PERFORM herbal.link_constituent('Polygala senega', 'senegin II',           'primary',  0);
  PERFORM herbal.link_constituent('Polygala senega', 'senegin III',          'major',    10);
  PERFORM herbal.link_constituent('Polygala senega', 'senegin IV',           'major',    20);
  PERFORM herbal.link_constituent('Polygala senega', 'presenegenin',         'moderate', 30);
  PERFORM herbal.link_constituent('Polygala senega', 'senegasaponin A',      'moderate', 40);
  PERFORM herbal.link_constituent('Polygala senega', 'senegasaponin B',      'moderate', 50);
  PERFORM herbal.link_constituent('Polygala senega', 'polygalacic acid',     'moderate', 60);
  PERFORM herbal.link_constituent('Polygala senega', 'methyl salicylate',    'minor',    70);
  PERFORM herbal.link_constituent('Polygala senega', 'sinapic acid',         'minor',    80);

  RAISE NOTICE 'Added constituents to Seneca Snakeroot (Polygala senega)';
END $$;

-- ============================================================
-- Block 5: Yerba Santa (Eriodictyon californicum) — aerial parts
-- Already has: eriodictyol (flavanone, major, sort_order implied)
-- luteolin, chlorogenic acid, ursolic acid already in DB
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('homoeriodictyol', 'flavanone',
    '4''-Methoxyl analogue of eriodictyol; the co-primary flavanone of E. californicum alongside eriodictyol. Distinctive bitter-masking (sweetening) activity — the sodium salt (Siotapide) is FDA-GRAS approved as a natural bitterness masking agent. Anti-inflammatory via COX-2 inhibition; expectorant and bronchospasmolytic; distinguishes E. californicum from related species in authentication.');
  PERFORM herbal.ensure_constituent('chrysoeriol', 'flavone',
    '3''-Methoxy-luteolin; the predominant flavone aglycone of E. californicum aerial parts. Anti-inflammatory and antispasmodic; contributes to the herb''s traditional respiratory use. A chemotaxonomic marker that distinguishes E. californicum from other Eriodictyon species encountered in botanical trade and adulteration testing.');
  PERFORM herbal.ensure_constituent('pinocembrin', 'flavanone',
    '5,7-Dihydroxyflavanone; characteristic minor flavanone of Yerba Santa alongside eriodictyol and homoeriodictyol. Antimicrobial (antibacterial, antifungal) and neuroprotective; contributes to the herb''s use for upper respiratory infections; part of the flavanone fingerprint used for quality authentication.');
  PERFORM herbal.ensure_constituent('eriodictyol 3'',7-dimethyl ether', 'flavanone',
    'Also known as sakuranetin (5-hydroxy-4'',7-dimethoxyflavanone); O-methylated flavanone derivative found in E. californicum. Mild expectorant, antiallergic, and anti-inflammatory; the semi-polar methyl ether series gives Yerba Santa a characteristic range of flavanone polarity fractions with varying extractability and bioavailability across different menstrua.');

  PERFORM herbal.link_constituent('Eriodictyon californicum', 'homoeriodictyol',              'major',    10);
  PERFORM herbal.link_constituent('Eriodictyon californicum', 'chrysoeriol',                  'moderate', 20);
  PERFORM herbal.link_constituent('Eriodictyon californicum', 'pinocembrin',                  'moderate', 30);
  PERFORM herbal.link_constituent('Eriodictyon californicum', 'eriodictyol 3'',7-dimethyl ether', 'moderate', 40);
  PERFORM herbal.link_constituent('Eriodictyon californicum', 'luteolin',                     'minor',    50);
  PERFORM herbal.link_constituent('Eriodictyon californicum', 'chlorogenic acid',             'minor',    60);
  PERFORM herbal.link_constituent('Eriodictyon californicum', 'ursolic acid',                 'minor',    70);

  RAISE NOTICE 'Added constituents to Yerba Santa (Eriodictyon californicum)';
END $$;

-- ============================================================
-- Block 6: Ylang Ylang (Cananga odorata) — essential oil/flower
-- Already has: linalool (monoterpene alcohol, major)
-- beta-caryophyllene, eugenol, geranyl acetate already in DB
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('benzyl acetate', 'benzyl ester',
    'The dominant volatile compound of ylang ylang essential oil (~20–30%); the primary aroma constituent responsible for the characteristic sweet, floral-fruity top note. ISO 3063 primary standardisation marker — minimum thresholds distinguish "extra" quality from lower-grade oil fractions. Anxiolytic in human inhalation studies (reduces heart rate and blood pressure); the highest-concentration single compound in authentic ylang ylang oil.');
  PERFORM herbal.ensure_constituent('germacrene D', 'sesquiterpene hydrocarbon',
    'Major sesquiterpene (~10–20% of EO); the largest sesquiterpene fraction contributing to the deep, green-woody background of ylang ylang''s complex aroma profile. Anti-inflammatory via 5-lipoxygenase inhibition; antimicrobial; a key ISO 3063 sesquiterpene marker used to distinguish ylang ylang from closely related Cananga species and adulterated oils.');
  PERFORM herbal.ensure_constituent('benzyl benzoate', 'benzyl ester',
    'Classical pharmaceutical arachnicide and antifungal compound (~5–15% of ylang ylang EO); the primary active ingredient in historical scabicide preparations (Eurax, Ascabiol). One of the earliest pharmaceutical arthropodicides derived from a plant source. ISO 3063 secondary quality marker; distinguishes high-grade extra ylang from lower-grade fractions by ratio with benzyl acetate.');
  PERFORM herbal.ensure_constituent('methyl benzoate', 'methyl ester',
    'Methyl ester of benzoic acid (~5–10% of EO); antimicrobial and mild topical analgesic. Contributes a fresh, sweet ester note alongside benzyl acetate; an ISO 3063 secondary quality marker used to separate authentic "extra" grade ylang ylang from adulterated or fraction-blended oils. Elevated in some lower-grade fractions and substitutes.');
  PERFORM herbal.ensure_constituent('alpha-farnesene', 'sesquiterpene hydrocarbon',
    'Acyclic C-15 sesquiterpene (~2–5% of EO); anti-inflammatory and mild analgesic properties. Contributes to the lingering base note of the oil; a diagnostic GC marker for authentic Cananga odorata — elevated in adulterated or substitute oils. Part of the sesquiterpene fraction evaluated in ISO 3063 quality grading.');
  PERFORM herbal.ensure_constituent('benzyl alcohol', 'aromatic alcohol',
    'Aromatic primary alcohol (~1–3% of EO); mild antimicrobial, analgesic (topical local anaesthetic), and preservative activity. Contributes a soft floral note and is a volatile GC fingerprint marker in ylang ylang oil quality assessment per ISO 3063. Used as a fragrance and preservative in regulated cosmetic formulations.');

  PERFORM herbal.link_constituent('Cananga odorata', 'benzyl acetate',      'primary',  0);
  PERFORM herbal.link_constituent('Cananga odorata', 'germacrene D',        'primary',  10);
  PERFORM herbal.link_constituent('Cananga odorata', 'benzyl benzoate',     'major',    20);
  PERFORM herbal.link_constituent('Cananga odorata', 'methyl benzoate',     'major',    30);
  PERFORM herbal.link_constituent('Cananga odorata', 'linalool',            'major',    40);
  PERFORM herbal.link_constituent('Cananga odorata', 'beta-caryophyllene',  'moderate', 50);
  PERFORM herbal.link_constituent('Cananga odorata', 'eugenol',             'minor',    60);
  PERFORM herbal.link_constituent('Cananga odorata', 'geranyl acetate',     'minor',    70);
  PERFORM herbal.link_constituent('Cananga odorata', 'alpha-farnesene',     'minor',    80);
  PERFORM herbal.link_constituent('Cananga odorata', 'benzyl alcohol',      'minor',    90);

  RAISE NOTICE 'Added constituents to Ylang Ylang (Cananga odorata)';
END $$;
