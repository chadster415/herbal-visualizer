-- Migration 188: Add general constituents to Zedoary, Rehmannia,
-- Squill, Condurango, Japanese Angelica Tree, and Wu Jia Pi.

SET search_path TO herbal, public;

-- ============================================================
-- Block 1: Zedoary (Curcuma zedoaria) — rhizome
-- Already has: curcumin (curcuminoid, minor)
-- camphor, demethoxycurcumin, bisdemethoxycurcumin already in DB
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('curzerenone', 'sesquiterpene ketone',
    'The primary essential oil constituent and defining sesquiterpene of Curcuma zedoaria rhizome (= neocurdione; 15–30% of EO depending on chemotype). The Chinese and European Pharmacopoeia primary identity and quality marker for zedoary, assayed by GC. Anti-tumour activity via NF-κB inhibition and apoptosis induction; antifungal, anti-inflammatory, and active against H. pylori in vitro. Central to the traditional use of zedoary for abdominal masses and qi/blood stagnation.');
  PERFORM herbal.ensure_constituent('zedoarone', 'sesquiterpene ketone',
    'Bicyclic guaiane-type sesquiterpene ketone characteristic of C. zedoaria EO (~5–15%); a secondary GC/MS fingerprint authentication marker distinguishing zedoary from related Curcuma species. Antifungal and anti-inflammatory in vitro; contributes alongside curzerenone to the EO''s inhibitory effects on food-spoilage organisms.');
  PERFORM herbal.ensure_constituent('germacrone', 'sesquiterpene ketone',
    '10-Membered germacrane-type sesquiterpene ketone (~5–12% of C. zedoaria EO); distributed across Curcuma species but elevated in zedoary relative to C. longa (turmeric), making it a positive identity marker in GC/MS differentiation between the two species. Oestrogenic activity, antifungal, and cytotoxic against multiple tumour cell lines in vitro.');
  PERFORM herbal.ensure_constituent('curcumenol', 'sesquiterpene alcohol',
    'Guaiane-type sesquiterpene alcohol (~3–8% of zedoary rhizome EO); co-occurs with the epimeric isocurcumenol. Anti-inflammatory via COX-2 and iNOS inhibition; hepatoprotective and cytotoxic in vitro. Contributes to the traditional use of zedoary in hepatic and digestive conditions; a quality marker distinguishing zedoary from turmeric in GC EO profiling.');
  PERFORM herbal.ensure_constituent('isofuranodiene', 'sesquiterpene',
    'Furanoid sesquiterpene of the germacrane series (~2–8% of C. zedoaria EO); characteristic of zedoary but largely absent from C. longa, serving as a discriminating EO fingerprint marker. Cytotoxic against leukaemia and colon carcinoma cell lines in vitro; anti-inflammatory via NF-κB inhibition. Part of the diagnostically important furanoid sesquiterpene cluster (with furanodiene) unique to zedoary.');
  PERFORM herbal.ensure_constituent('furanodiene', 'sesquiterpene',
    'Monocyclic furanoid sesquiterpene co-occurring with isofuranodiene in zedoary EO (~1–5%); anti-proliferative and cytotoxic against multiple cancer cell lines; inhibits tumour angiogenesis in some models. Contributes to the characteristic furanoid sesquiterpene cluster that differentiates C. zedoaria from C. longa in GC/MS EO fingerprint authentication.');
  PERFORM herbal.ensure_constituent('beta-sesquiphellandrene', 'sesquiterpene',
    'Monocyclic bisabolane-type sesquiterpene (~2–6% of zedoary EO); also found in ginger (Zingiber officinale). Anti-influenza virus activity in vitro (active against influenza A strains H2N2, H3N2); anti-inflammatory in cell-based assays. Contributes to the characteristic spicy-woody aroma of zedoary; a minor EO quality-control marker in GC fingerprint analysis.');
  PERFORM herbal.ensure_constituent('beta-elemene', 'sesquiterpene',
    'Germacrane-derived sesquiterpene (~1–5% of zedoary EO); widely investigated for anti-tumour properties and used clinically in China as an oncology adjunct ("elemene injection", derived from Curcuma wenyujin and related species). Inhibits tumour cell proliferation, enhances chemosensitivity, and triggers apoptosis via mitochondrial pathways. Pharmacological significance exceeds its quantitative level in the EO; among the most clinically researched sesquiterpenes in the Curcuma genus.');

  PERFORM herbal.link_constituent('Curcuma zedoaria', 'curzerenone',          'primary',  0);
  PERFORM herbal.link_constituent('Curcuma zedoaria', 'zedoarone',            'major',    10);
  PERFORM herbal.link_constituent('Curcuma zedoaria', 'germacrone',           'major',    20);
  PERFORM herbal.link_constituent('Curcuma zedoaria', 'curcumenol',           'moderate', 30);
  PERFORM herbal.link_constituent('Curcuma zedoaria', 'isofuranodiene',       'moderate', 40);
  PERFORM herbal.link_constituent('Curcuma zedoaria', 'furanodiene',          'moderate', 50);
  PERFORM herbal.link_constituent('Curcuma zedoaria', 'beta-sesquiphellandrene','moderate',60);
  PERFORM herbal.link_constituent('Curcuma zedoaria', 'beta-elemene',         'moderate', 70);
  PERFORM herbal.link_constituent('Curcuma zedoaria', 'curcumin',             'minor',    80);
  PERFORM herbal.link_constituent('Curcuma zedoaria', 'demethoxycurcumin',    'minor',    90);
  PERFORM herbal.link_constituent('Curcuma zedoaria', 'bisdemethoxycurcumin', 'minor',    100);
  PERFORM herbal.link_constituent('Curcuma zedoaria', 'camphor',              'minor',    110);

  RAISE NOTICE 'Added constituents to Zedoary (Curcuma zedoaria)';
END $$;

-- ============================================================
-- Block 2: Rehmannia (Rehmannia glutinosa) — root (sheng di huang)
-- Already has: catalpol (iridoid glycoside, major)
-- verbascoside, caffeic acid, chlorogenic acid, ferulic acid,
-- beta-sitosterol already in DB
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('rehmannioside A', 'iridoid glycoside',
    'The most abundant of the four rehmannioside iridoid glycosides characteristic of Rehmannia glutinosa root (~0.1–0.5% dry weight); co-occurring with catalpol as part of the defining iridoid cluster. Hepatoprotective, anti-inflammatory, and immunomodulatory in preclinical studies; included in Chinese Pharmacopoeia secondary HPLC marker analysis alongside catalpol. The full rehmannioside A–D series provides the characteristic iridoid fingerprint used to authenticate R. glutinosa against adulterants.');
  PERFORM herbal.ensure_constituent('rehmannioside B', 'iridoid glycoside',
    'Second of the four characteristic rehmannioside iridoid glycosides of Rehmannia root; distinguished from rehmannioside A by its sugar chain configuration at C-1. Anti-inflammatory and hepatoprotective in vitro; a secondary HPLC authentication marker. Iridoid levels in the rehmannioside series shift significantly between raw (sheng di huang) and processed (shu di huang) preparations, tracking the degree of steaming.');
  PERFORM herbal.ensure_constituent('rehmannioside C', 'iridoid glycoside',
    'Third of the four rehmannioside iridoid glycosides of Rehmannia; distinguished by its unique aglycone-sugar linkage from rehmanniosides A and B. Anti-inflammatory and mildly immunomodulatory; contributes to the complete iridoid fingerprint used in pharmacognostic comparison of raw vs. processed Rehmannia root preparations in Chinese Pharmacopoeia quality standards.');
  PERFORM herbal.ensure_constituent('rehmannioside D', 'iridoid glycoside',
    'Fourth of the four characteristic rehmannioside iridoid glycosides; typically the least abundant of the series in Rehmannia root. The complete rehmannioside A–D set provides the HPLC iridoid fingerprint that distinguishes genuine R. glutinosa from related species; collectively contributes anti-inflammatory and hepatoprotective activity alongside catalpol.');
  PERFORM herbal.ensure_constituent('stachyose', 'oligosaccharide',
    'A tetrasaccharide (Gal-Gal-Glc-Fru) present at approximately 1–4% dry weight in raw Rehmannia glutinosa root — quantitatively one of the most abundant soluble carbohydrate constituents. Significantly reduced by steaming (processing to shu di huang) as fermentable oligosaccharides are broken down; this change contributes to differences in GI tolerability between raw and prepared forms. Tracked as a processing authenticity marker in Chinese Pharmacopoeia quality control; the stachyose content is a key indicator distinguishing genuine raw root from adulterated or over-processed material.');
  PERFORM herbal.ensure_constituent('rehmaglutin A', 'dihydroisocoumarin',
    'A dihydroisocoumarin (benzopyranone lactone) specific to Rehmannia glutinosa root; one of four rehmaglutins that are the most taxonomically specific secondary metabolites of the genus. Distinct chemical class from the iridoid glycosides. Anti-inflammatory, antioxidant, and neuroprotective in vitro (promotes NGF-induced neurite outgrowth — the strongest neuroprotective activity of the series); a Rehmannia-specific HPLC authentication marker not found in commonly substituted herbal roots.');
  PERFORM herbal.ensure_constituent('rehmaglutin B', 'dihydroisocoumarin',
    'Second of the four Rehmannia-specific dihydroisocoumarin lactones; co-occurring with rehmaglutin A in the root. Anti-inflammatory and antioxidant in vitro; contributes to the neuroprotective activity of the isocoumarin fraction. Used as a secondary HPLC chemical marker for genus authentication alongside rehmaglutin A; the rehmaglutin series collectively distinguishes R. glutinosa from adulterants and related Orobanchaceae family members.');
  PERFORM herbal.ensure_constituent('jionoside A', 'phenylethanoid glycoside',
    'A phenylethanoid glycoside co-occurring with verbascoside (acteoside) as part of the characteristic phenylethanoid fraction of Rehmannia glutinosa root. Anti-inflammatory and antioxidant via free-radical scavenging and NF-κB inhibition; structurally distinguished from jionoside B by its sugar chain configuration. A secondary HPLC quality marker for authentication of R. glutinosa preparations alongside acteoside/verbascoside.');
  PERFORM herbal.ensure_constituent('jionoside B', 'phenylethanoid glycoside',
    'Second of the Rehmannia-specific jionosides; a phenylethanoid glycoside co-occurring with jionoside A and verbascoside in R. glutinosa root. Anti-inflammatory and antioxidant; distinguished from jionoside A by a different glycosylation pattern. Part of the complete phenylethanoid fingerprint for pharmacognostic authentication of the species.');

  PERFORM herbal.link_constituent('Rehmannia glutinosa', 'catalpol',        'primary',  0);
  PERFORM herbal.link_constituent('Rehmannia glutinosa', 'verbascoside',    'major',    5);
  PERFORM herbal.link_constituent('Rehmannia glutinosa', 'stachyose',       'major',    8);
  PERFORM herbal.link_constituent('Rehmannia glutinosa', 'rehmannioside A', 'moderate', 10);
  PERFORM herbal.link_constituent('Rehmannia glutinosa', 'rehmannioside B', 'minor',    20);
  PERFORM herbal.link_constituent('Rehmannia glutinosa', 'rehmannioside C', 'minor',    30);
  PERFORM herbal.link_constituent('Rehmannia glutinosa', 'rehmannioside D', 'minor',    40);
  PERFORM herbal.link_constituent('Rehmannia glutinosa', 'rehmaglutin A',   'minor',    50);
  PERFORM herbal.link_constituent('Rehmannia glutinosa', 'rehmaglutin B',   'minor',    60);
  PERFORM herbal.link_constituent('Rehmannia glutinosa', 'jionoside A',     'minor',    70);
  PERFORM herbal.link_constituent('Rehmannia glutinosa', 'jionoside B',     'minor',    80);
  PERFORM herbal.link_constituent('Rehmannia glutinosa', 'caffeic acid',    'minor',    90);
  PERFORM herbal.link_constituent('Rehmannia glutinosa', 'chlorogenic acid','minor',    100);
  PERFORM herbal.link_constituent('Rehmannia glutinosa', 'ferulic acid',    'minor',    110);
  PERFORM herbal.link_constituent('Rehmannia glutinosa', 'beta-sitosterol', 'minor',    120);

  RAISE NOTICE 'Added constituents to Rehmannia (Rehmannia glutinosa)';
END $$;

-- ============================================================
-- Block 3: Squill (Urginea maritima) — bulb
-- Also known as Drimia maritima
-- Already has: cardiac glycosides (cardiac glycoside, major) — generic
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('scillaren A', 'bufadienolide glycoside',
    'The principal cardiac glycoside of white squill (~0.15–0.3% dry bulb); a diglycoside comprising the bufadienolide aglycone scillarenin linked to rhamnose and glucose at C-3. The European Pharmacopoeia primary standardisation marker for Squill (Scillae bulbus) — the EP assays total oxalate-free bufadienolides expressed as scillaren A equivalents. Positive inotropic and negative chronotropic (digitalis-like) via Na⁺/K⁺-ATPase inhibition; narrow therapeutic index; historically used for congestive heart failure and as an expectorant in sub-therapeutic doses.');
  PERFORM herbal.ensure_constituent('proscillardin A', 'bufadienolide glycoside',
    'Scillarenin 3-O-α-L-rhamnoside; the immediate monoglycoside hydrolysis product of scillaren A, present at approximately 0.05–0.15% dry bulb. Pharmacologically active as a cardiac glycoside in its own right; positive inotropic activity with digitalis-like mechanism. Investigated clinically in Europe as a purified cardiac drug (trade name Talusin); an EP reference standard alongside scillaren A. Bioavailability differs from scillaren A due to the absent glucose unit.');
  PERFORM herbal.ensure_constituent('glucoscillaren A', 'bufadienolide glycoside',
    'A trisaccharide variant of scillaren A bearing an additional glucose moiety; a minor constituent of the squill bulb glycoside mixture. Contributes to the overall cardiac glycoside profile but is less pharmacologically prominent than scillaren A or proscillardin A and is not used as a standardisation marker; detected in HPLC analysis of squill bulb extracts.');
  PERFORM herbal.ensure_constituent('scillarenin', 'bufadienolide aglycone',
    'The steroidal bufadienolide aglycone (genin) common to scillaren A, proscillardin A, and related squill glycosides; present in small quantities by hydrolysis in the intact plant. Intrinsic cardiac glycoside activity but not the primary therapeutic entity; its characterisation is relevant to analytical fingerprinting of squill preparations and to understanding glycoside metabolism and bioactivation in vivo.');
  PERFORM herbal.ensure_constituent('scilliroside', 'bufadienolide glycoside',
    'A rodenticidal bufadienolide glycoside present predominantly in red squill (the red-pigmented variety of Urginea maritima) at concentrations up to ~0.8% dry weight; essentially absent in white squill. Chemically and pharmacologically distinct from the cardiotonic squill glycosides — responsible for the species-specific rodenticidal toxicity of red squill preparations (rats cannot vomit; emesis protects other species). Commercially exploited as a selective rodenticide. Concentration is a critical safety distinction between red and white squill commercial preparations.');
  PERFORM herbal.ensure_constituent('scillicyanoside', 'bufadienolide glycoside',
    'A minor bufadienolide glycoside identified in Urginea maritima bulbs; present at low concentrations and less pharmacologically characterised than the principal glycosides. Contributes to the full cardiac glycoside mixture of squill; detected in comprehensive HPLC characterisation studies of authentic bulb material; not used as a quality-control marker compound.');

  PERFORM herbal.link_constituent('Urginea maritima', 'scillaren A',      'primary',  0);
  PERFORM herbal.link_constituent('Urginea maritima', 'proscillardin A',  'major',    10);
  PERFORM herbal.link_constituent('Urginea maritima', 'glucoscillaren A', 'minor',    20);
  PERFORM herbal.link_constituent('Urginea maritima', 'scillarenin',      'minor',    30);
  PERFORM herbal.link_constituent('Urginea maritima', 'scilliroside',     'moderate', 40);
  PERFORM herbal.link_constituent('Urginea maritima', 'scillicyanoside',  'minor',    50);

  RAISE NOTICE 'Added constituents to Squill (Urginea maritima)';
END $$;

-- ============================================================
-- Block 4: Condurango (Marsdenia condurango) — bark
-- Also known as Gonolobus condurango
-- Already has: steroidal saponins (saponin, major) — generic
-- beta-sitosterol already in DB
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('condurangoglycoside A', 'pregnane glycoside',
    'The principal pregnanoglycoside of condurango bark and the primary quality-control standardisation marker; present at approximately 0.5–1.0% dry bark weight. Bitter stomachic activity — stimulates gastric secretion and appetite via the bitter taste receptor pathway; historically condurango was investigated as a cancer remedy, with this glycoside considered the primary cytotoxic agent in vitro studies. The reference compound in HPLC standardisation used by European herbal product manufacturers.');
  PERFORM herbal.ensure_constituent('condurangoglycoside B', 'pregnane glycoside',
    'A closely related pregnane glycoside co-occurring with condurangoglycoside A in condurango bark; sharing the general bitter stomachic and cytotoxic profile of the condurangoglycoside series. Identified in chromatographic fingerprinting of bark extracts at moderate concentrations; contributes to the total pregnanoglycoside activity but is not individually used as a standardisation marker.');
  PERFORM herbal.ensure_constituent('condurangoglycoside C', 'pregnane glycoside',
    'A further member of the pregnane glycoside series in condurango bark; structurally related to condurangoglycosides A and B, identified in phytochemical fractionation studies. Present at moderate-to-minor concentrations; contributes to the overall bitter stomachic activity alongside the other condurangoglycosides.');
  PERFORM herbal.ensure_constituent('condurangoglycoside D', 'pregnane glycoside',
    'A minor pregnane glycoside constituent of condurango bark identified in detailed phytochemical analyses; part of the complex glycoside mixture responsible for the collective bitter stomachic activity of the bark. Individual pharmacological characterisation is limited; contributes to the chromatographic fingerprint for species authentication.');
  PERFORM herbal.ensure_constituent('condurangoglycoside E', 'pregnane glycoside',
    'The least abundant of the named condurangoglycoside series identified in condurango bark extracts; minor concentration. Contributes to the bitter stomachic profile alongside the more abundant members of the series; detected in comprehensive chromatographic characterisation of authentic condurango bark material.');
  PERFORM herbal.ensure_constituent('condurangamine A', 'pregnane alkaloid',
    'A steroidal pregnane-type alkaloid from condurango bark; present at low but analytically detectable concentrations. Contributes to the overall pharmacological activity alongside the dominant glycoside fraction; alkaloids of the Marsdenia genus have been associated with antitumour and CNS-modulating activity in experimental studies.');
  PERFORM herbal.ensure_constituent('condurangamine B', 'pregnane alkaloid',
    'A closely related pregnane alkaloid co-occurring with condurangamine A in condurango bark at trace-to-minor concentrations; shares the structural features characteristic of the pregnane alkaloid series of Marsdenia species. Contributes to the alkaloid fraction of the bark at concentrations below those of the major condurangoglycosides.');

  PERFORM herbal.link_constituent('Marsdenia condurango', 'condurangoglycoside A', 'primary',  0);
  PERFORM herbal.link_constituent('Marsdenia condurango', 'condurangoglycoside B', 'major',    10);
  PERFORM herbal.link_constituent('Marsdenia condurango', 'condurangoglycoside C', 'moderate', 20);
  PERFORM herbal.link_constituent('Marsdenia condurango', 'condurangoglycoside D', 'minor',    30);
  PERFORM herbal.link_constituent('Marsdenia condurango', 'condurangoglycoside E', 'minor',    40);
  PERFORM herbal.link_constituent('Marsdenia condurango', 'condurangamine A',      'minor',    50);
  PERFORM herbal.link_constituent('Marsdenia condurango', 'condurangamine B',      'trace',    60);
  PERFORM herbal.link_constituent('Marsdenia condurango', 'beta-sitosterol',       'minor',    70);

  RAISE NOTICE 'Added constituents to Condurango (Marsdenia condurango)';
END $$;

-- ============================================================
-- Block 5: Japanese Angelica Tree (Aralia elata) — root/stem bark
-- Already has: oleanolic acid (pentacyclic triterpenoid, moderate)
-- araloside A, araloside B, ursolic acid, hederagenin, kaurenoic acid,
-- caffeic acid, chlorogenic acid, beta-sitosterol already in DB
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('elatoside E', 'oleanane triterpenoid saponin',
    'The principal and most studied saponin of Aralia elata root bark (~0.2–0.5% dry weight); a bidesmosidic oleanane saponin with oleanolic acid aglycone and sugar chains at C-3 and C-28. Hepatoprotective, anti-inflammatory, and adaptogenic in rodent models; anti-hyperglycaemic activity linked to enhanced insulin receptor signalling. The defining pharmacological marker constituent of A. elata and the primary compound used to authenticate this species against related Aralia spp. in HPLC quality-control fingerprinting.');
  PERFORM herbal.ensure_constituent('elatoside G', 'oleanane triterpenoid saponin',
    'A co-occurring bidesmosidic oleanane saponin of Aralia elata root bark, structurally related to elatoside E but with a modified C-3 oligosaccharide chain. Reported at moderate concentrations alongside elatoside E; anti-inflammatory and hepatoprotective activity in preclinical studies. A secondary authentication marker for A. elata in combination with elatoside E in HPLC fingerprint analysis.');
  PERFORM herbal.ensure_constituent('araloside C', 'oleanane triterpenoid saponin',
    'An oleanolic acid-based triterpenoid saponin documented in Aralia elata root bark alongside the elatasides; structurally related to araloside A and B (already in DB) but with a distinct C-3 sugar chain configuration. Reported at moderate concentrations; anti-inflammatory and hepatoprotective. Confirmed in phytochemical surveys of A. elata root bark alongside elatoside E.');
  PERFORM herbal.ensure_constituent('chiisanogenin', 'pentacyclic triterpenoid sapogenin',
    'The 16α-hydroxy derivative of oleanolic acid; a characteristic sapogenin aglycone isolated from Aralia elata root bark by acid hydrolysis of the native glycoside fraction (primarily as the aglycone of chiisanoside and related glycosides). Reported in A. elata and the related Aralia cordata and Eleutherococcus species; contributes to the sapogenin pool alongside oleanolic acid and hederagenin. A chemotaxonomic marker within the Araliaceae family.');

  PERFORM herbal.link_constituent('Aralia elata', 'elatoside E',     'primary',  0);
  PERFORM herbal.link_constituent('Aralia elata', 'elatoside G',     'major',    10);
  PERFORM herbal.link_constituent('Aralia elata', 'araloside C',     'moderate', 20);
  PERFORM herbal.link_constituent('Aralia elata', 'chiisanogenin',   'moderate', 30);
  PERFORM herbal.link_constituent('Aralia elata', 'araloside A',     'major',    40);
  PERFORM herbal.link_constituent('Aralia elata', 'araloside B',     'major',    50);
  PERFORM herbal.link_constituent('Aralia elata', 'oleanolic acid',  'moderate', 60);
  PERFORM herbal.link_constituent('Aralia elata', 'ursolic acid',    'minor',    70);
  PERFORM herbal.link_constituent('Aralia elata', 'hederagenin',     'minor',    80);
  PERFORM herbal.link_constituent('Aralia elata', 'kaurenoic acid',  'minor',    90);
  PERFORM herbal.link_constituent('Aralia elata', 'caffeic acid',    'minor',    100);
  PERFORM herbal.link_constituent('Aralia elata', 'chlorogenic acid','minor',    110);
  PERFORM herbal.link_constituent('Aralia elata', 'beta-sitosterol', 'minor',    120);

  RAISE NOTICE 'Added constituents to Japanese Angelica Tree (Aralia elata)';
END $$;

-- ============================================================
-- Block 6: Wu Jia Pi (Acanthopanax sessiliflorum) — root bark
-- Already has: lignans (lignan, major) — generic
-- beta-sitosterol, oleanolic acid, ursolic acid, caffeic acid,
-- quercetin, kaempferol, tannins already in DB
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('eleutheroside B', 'phenylpropanoid glucoside',
    '4-[(1E)-3-Hydroxyprop-1-en-1-yl]-2-methoxyphenyl β-D-glucopyranoside; identical to syringin (the chemical name) — "eleutheroside B" is the pharmacopoeia designation coined by Brekhman. Present in Acanthopanax sessiliflorum root bark at approximately 0.1–0.4% dry weight, shared across the Araliaceae family including Eleutherococcus senticosus. The primary EP/BP HPLC quality-control marker for Eleutherococcus radix; adaptogenic, neuroprotective, and anti-fatigue in multiple preclinical models. Its presence in A. sessiliflorum confirms shared adaptogenic pharmacology with related Acanthopanax species.');
  PERFORM herbal.ensure_constituent('eleutheroside E', 'furofuran lignan diglucoside',
    '(+)-Syringaresinol-4,4′-di-O-β-D-glucopyranoside; also designated acanthoside D — the same compound under two naming conventions. The principal lignan glucoside of Acanthopanax sessiliflorum root bark and characteristic of the entire Acanthopanax/Eleutherococcus genus. Immunomodulatory, adaptogenic, anti-stress, and neuroprotective; upregulates NK cell activity and modulates glucocorticoid response in rodent stress models. A secondary EP QC marker alongside eleutheroside B; a primary authenticity marker for Acanthopanax root preparations distinguishing them from adulterants.');
  PERFORM herbal.ensure_constituent('isofraxidin', 'prenylated coumarin',
    '6-Methoxy-7-hydroxy-8-(3-methylbut-2-enyloxy)coumarin; the most characteristic coumarin marker of the Acanthopanax/Eleutherococcus genus (~0.05–0.15% in A. sessiliflorum root bark). Used as a species-authentication HPLC marker to distinguish genuine Wu Jia Pi from adulterants and substitutes — especially Periploca sepium (North China Wu Jia Pi), which lacks isofraxidin. Anti-inflammatory via NF-κB inhibition; hepatoprotective and antioxidant in rodent models.');
  PERFORM herbal.ensure_constituent('sesamin', 'furofuran lignan',
    '(+)-(3R,4R)-Furofuran lignan with two methylenedioxyphenyl groups; a "free" (aglycone, non-glycosylated) lignan co-occurring with the lignan glucosides in Acanthopanax sessiliflorum root bark. Anti-inflammatory via 5-lipoxygenase inhibition; antioxidant, hepatoprotective, and cholesterol-modulating activity. Structurally distinguished from eleutheroside E by the absence of glucose chains and methylenedioxy (rather than methoxy) phenyl substitution; contributes to the free lignan fraction alongside syringaresinol.');
  PERFORM herbal.ensure_constituent('chiisanoside', 'oleanane triterpenoid saponin',
    'A bidesmosidic oleanane saponin with chiisanogenin (16α-hydroxy-oleanolic acid) as the aglycone; one of the most characteristic triterpenoid saponins of the Acanthopanax genus, first isolated from Acanthopanax chiisanensis. Anti-inflammatory, anti-allergic, and hepatoprotective in preclinical studies; a chemotaxonomic marker for Acanthopanax sensu stricto within the Araliaceae family. Distinguishes Wu Jia Pi from Siberian Ginseng (E. senticosus) which has a different saponin profile.');

  PERFORM herbal.link_constituent('Acanthopanax sessiliflorum', 'eleutheroside E', 'primary',  0);
  PERFORM herbal.link_constituent('Acanthopanax sessiliflorum', 'eleutheroside B', 'major',    10);
  PERFORM herbal.link_constituent('Acanthopanax sessiliflorum', 'isofraxidin',     'moderate', 20);
  PERFORM herbal.link_constituent('Acanthopanax sessiliflorum', 'sesamin',         'moderate', 30);
  PERFORM herbal.link_constituent('Acanthopanax sessiliflorum', 'chiisanoside',    'moderate', 40);
  PERFORM herbal.link_constituent('Acanthopanax sessiliflorum', 'beta-sitosterol', 'minor',    60);
  PERFORM herbal.link_constituent('Acanthopanax sessiliflorum', 'oleanolic acid',  'minor',    70);
  PERFORM herbal.link_constituent('Acanthopanax sessiliflorum', 'ursolic acid',    'minor',    80);
  PERFORM herbal.link_constituent('Acanthopanax sessiliflorum', 'caffeic acid',    'minor',    90);
  PERFORM herbal.link_constituent('Acanthopanax sessiliflorum', 'quercetin',       'minor',    100);
  PERFORM herbal.link_constituent('Acanthopanax sessiliflorum', 'kaempferol',      'minor',    110);
  PERFORM herbal.link_constituent('Acanthopanax sessiliflorum', 'tannins',         'minor',    120);

  RAISE NOTICE 'Added constituents to Wu Jia Pi (Acanthopanax sessiliflorum)';
END $$;
