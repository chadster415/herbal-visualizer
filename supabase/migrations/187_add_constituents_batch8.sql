-- Migration 187: Add general constituents to Guaiacum, Pasqueflower,
-- Ipecac, Lily of the Valley, Sarsaparilla, and Madder.

SET search_path TO herbal, public;

-- ============================================================
-- Block 1: Guaiacum (Guaiacum officinale) — heartwood/resin
-- Already has: ferulic acid (hydroxycinnamic acid, minor)
-- guaiacol already in DB
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('alpha-guaiaconic acid', 'lignan resin acid',
    'The dominant constituent of the ether-soluble guaiacum resin fraction; collectively with beta-guaiaconic acid it constitutes the 70%+ total resin acid content required by the British and European Pharmacopoeia. The primary anti-inflammatory and antirheumatic compound — inhibits COX and 5-LOX pathways; responsible for the characteristic blue-green colorimetric reaction of guaiacum resin (oxidised to guaiacum blue) used in quality-control assays. Primary standardisation marker.');
  PERFORM herbal.ensure_constituent('beta-guaiaconic acid', 'lignan resin acid',
    'Co-primary resin acid occurring alongside alpha-guaiaconic acid as the other dominant constituent of guaiacum resin; collectively the two acids make up ≥70% of the resin acid fraction per BP/EP specification. Pharmacologically equivalent to the alpha form — contributes equally to the anti-inflammatory, antirheumatic, and diuretic actions attributed to the resin. Co-standardisation marker.');
  PERFORM herbal.ensure_constituent('guaiaretic acid', 'lignan',
    'Dibenzylbutane-type lignan of guaiacum heartwood; structurally related to nordihydroguaiaretic acid (NDGA, from creosote bush). Inhibits 5-lipoxygenase and demonstrates anti-inflammatory activity in animal models; contributes to the herb''s established use in chronic rheumatic conditions. Represents a moderate proportion of the resin phenolic fraction alongside the guaiaconic acids.');

  PERFORM herbal.link_constituent('Guaiacum officinale', 'alpha-guaiaconic acid', 'primary',  0);
  PERFORM herbal.link_constituent('Guaiacum officinale', 'beta-guaiaconic acid',  'primary',  10);
  PERFORM herbal.link_constituent('Guaiacum officinale', 'guaiaretic acid',       'moderate', 20);
  PERFORM herbal.link_constituent('Guaiacum officinale', 'ferulic acid',          'minor',    30);
  PERFORM herbal.link_constituent('Guaiacum officinale', 'guaiacol',              'minor',    40);

  RAISE NOTICE 'Added constituents to Guaiacum (Guaiacum officinale)';
END $$;

-- ============================================================
-- Block 2: Pasqueflower (Pulsatilla vulgaris) — aerial parts
-- Already has: oleanolic acid (pentacyclic triterpenoid, moderate)
-- luteolin, rutin, kaempferol, beta-sitosterol, tannins already in DB
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('ranunculin', 'monoterpene lactone glycoside',
    'The primary pro-toxic glucoside present in fresh Pulsatilla tissue (up to 0.5–2% aerial parts); enzymatically hydrolysed to protoanemonin and glucose when cells are disrupted on cutting or crushing. Safety-critical: the ranunculin content determines the irritant potential of fresh herb preparations. Absent or greatly reduced in properly dried herb as it is converted to protoanemonin and then anemonin during processing. The key compound distinguishing safe dried Pulsatilla from hazardous fresh-plant preparations.');
  PERFORM herbal.ensure_constituent('protoanemonin', 'butenolide',
    'Highly reactive unsaturated lactone (vesicant) released enzymatically from ranunculin on cell damage; the primary toxin responsible for blistering and severe mucous membrane irritation from fresh Pulsatilla. Dimerizes spontaneously to the stable, less toxic anemonin on drying or heating. Safety flag: fresh or poorly dried preparations contraindicated internally — can cause renal and GI inflammation; even topical contact causes dermatitis. Not present at significant levels in correctly dried herb.');
  PERFORM herbal.ensure_constituent('anemonin', 'bicyclic dilactone',
    'The stable, pharmacologically active dimer of protoanemonin formed upon drying or mild heating; significantly less irritant than its precursor. Demonstrates antispasmodic, sedative, and analgesic properties in animal models — these are the therapeutic activities of correctly prepared dried Pulsatilla. Estimated 0.1–0.5% in dried herb; the therapeutically relevant form of the lactone fraction for internal use.');
  PERFORM herbal.ensure_constituent('hederagenin', 'pentacyclic triterpenoid sapogenin',
    'Oleanane-type triterpenoid sapogenin; the primary aglycone of the Pulsatilla saponin series (pulsatillosides). Cytotoxic, anti-inflammatory, and hepatoprotective in preclinical studies; the saponin glycosides built on hederagenin contribute to the herb''s antispasmodic and mild sedative profile. Requires ensure_constituent — hederagenin is distinct from oleanolic acid (already linked) by its 3β,23-diol functionality.');

  PERFORM herbal.link_constituent('Pulsatilla vulgaris', 'ranunculin',    'primary',  0);
  PERFORM herbal.link_constituent('Pulsatilla vulgaris', 'protoanemonin', 'primary',  10);
  PERFORM herbal.link_constituent('Pulsatilla vulgaris', 'anemonin',      'moderate', 20);
  PERFORM herbal.link_constituent('Pulsatilla vulgaris', 'hederagenin',   'moderate', 30);
  PERFORM herbal.link_constituent('Pulsatilla vulgaris', 'oleanolic acid','moderate', 40);
  PERFORM herbal.link_constituent('Pulsatilla vulgaris', 'luteolin',      'minor',    50);
  PERFORM herbal.link_constituent('Pulsatilla vulgaris', 'rutin',         'minor',    60);
  PERFORM herbal.link_constituent('Pulsatilla vulgaris', 'kaempferol',    'minor',    70);
  PERFORM herbal.link_constituent('Pulsatilla vulgaris', 'beta-sitosterol','minor',   80);
  PERFORM herbal.link_constituent('Pulsatilla vulgaris', 'tannins',       'minor',    90);

  RAISE NOTICE 'Added constituents to Pasqueflower (Pulsatilla vulgaris)';
END $$;

-- ============================================================
-- Block 3: Ipecac (Cephaelis ipecacuanha) — root/rhizome
-- Also known as Psychotria ipecacuanha (updated taxonomy)
-- Already has: alkaloids (alkaloid, major) — generic entry
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('emetine', 'isoquinoline alkaloid',
    'The primary alkaloid of Cephaelis ipecacuanha root (~1–2% dry weight); the British and European Pharmacopoeia standardisation marker (minimum total alkaloid content expressed as emetine). Potent emetic acting on both the chemoreceptor trigger zone (CTZ) and gastric mucosa; historically used as an expectorant (sub-emetic dose) and systemic amoebicidal agent (Entamoeba histolytica). Cardiotoxic at overdose — responsible for irreversible cardiomyopathy in ipecac syrup abuse (eating disorder cases); WHO/FDA restricted use.');
  PERFORM herbal.ensure_constituent('cephaeline', 'isoquinoline alkaloid',
    'O-Demethylemetine; the second principal alkaloid (~0.4–0.6%, approximately 30–50% of total alkaloid fraction); co-assayed with emetine in BP/EP HPLC quality-control methods. Equipotent with emetine as an emetic and anti-amoebic agent; studied for antiviral activity (including anti-SARS-CoV research). The two alkaloids are typically standardised together as "total ipecacuanha alkaloids".');
  PERFORM herbal.ensure_constituent('psychotrine', 'isoquinoline alkaloid',
    'Unsaturated (dehydro) analogue of cephaeline present at minor concentrations (~0.1–0.2%); the dehydrogenated form of the cephaeline skeleton. Weaker emetic activity than the saturated alkaloids; appears in EP/BP HPLC fingerprint chromatograms as an authentication and quality marker for genuine Cephaelis root vs adulterants.');
  PERFORM herbal.ensure_constituent('O-methylpsychotrine', 'isoquinoline alkaloid',
    'The O-methylated counterpart to psychotrine (i.e., the dehydro analogue of emetine); present at trace-to-minor concentrations. Contributes to the HPLC alkaloid fingerprint used for species authentication of Cephaelis ipecacuanha root; not pharmacologically significant in its own right at the concentrations present.');
  PERFORM herbal.ensure_constituent('emetamine', 'isoquinoline alkaloid',
    'N-Demethylated quaternary ipecac alkaloid; present at trace-to-minor concentrations in the root. An HPLC fingerprint marker used for species authentication alongside emetine and cephaeline; not a major contributor to the pharmacological activity profile but part of the characteristic alkaloid complex of the species.');
  PERFORM herbal.ensure_constituent('ipecacuanhic acid', 'gallotannin',
    'A characteristic tannin of Cephaelis ipecacuanha root (~1–2%); contributes to the astringent and gastric-irritant properties of the root, augmenting the emetic mechanism. Clinically significant for drug interaction: binds and inactivates emetine when activated charcoal is co-administered (important in overdose management — charcoal should be given after, not before, ipecac-induced emesis to avoid binding the active alkaloids).');

  PERFORM herbal.link_constituent('Cephaelis ipecacuanha', 'emetine',           'primary',  0);
  PERFORM herbal.link_constituent('Cephaelis ipecacuanha', 'cephaeline',        'major',    10);
  PERFORM herbal.link_constituent('Cephaelis ipecacuanha', 'psychotrine',       'minor',    20);
  PERFORM herbal.link_constituent('Cephaelis ipecacuanha', 'O-methylpsychotrine','minor',   30);
  PERFORM herbal.link_constituent('Cephaelis ipecacuanha', 'emetamine',         'minor',    40);
  PERFORM herbal.link_constituent('Cephaelis ipecacuanha', 'ipecacuanhic acid', 'moderate', 50);

  RAISE NOTICE 'Added constituents to Ipecac (Cephaelis ipecacuanha)';
END $$;

-- ============================================================
-- Block 4: Lily of the Valley (Convallaria majalis) — aerial parts
-- Already has: convallatoxol (cardiac glycoside, moderate)
-- chelidonic acid, quercetin, kaempferol already in DB
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('convallatoxin', 'cardenolide cardiac glycoside',
    'The primary and most potent cardiac glycoside of Convallaria majalis (~0.1–0.3% fresh aerial parts); strophanthidin 3-O-α-L-rhamnoside. The most rapidly acting cardenolide in the plant — inhibits Na⁺/K⁺-ATPase; positive inotropic, negative chronotropic. DISTINCT from convallatoxol (already in DB), which is the corresponding secondary alcohol (dihydro form). Narrow therapeutic index; the principal lethality toxin of the plant. European Pharmacopoeia references this as the primary biomarker for Convallaria preparations.');
  PERFORM herbal.ensure_constituent('convalloside', 'cardenolide cardiac glycoside',
    'Strophanthidin glucorhamnoside (3-O-rhamnosyl-glucoside); the second major cardiac glycoside of C. majalis (~0.05–0.2%). Slower onset than convallatoxin due to the additional sugar; hydrolysed in vivo to convallatoxin, making it a reservoir form of the primary glycoside. A Commission E QC marker alongside convallatoxin; contributes substantially to the herb''s total cardiac glycoside burden and its toxicity risk profile.');
  PERFORM herbal.ensure_constituent('lokunjoside', 'cardenolide cardiac glycoside',
    'A co-occurring cardenolide identified in phytochemical surveys of Convallaria majalis; structurally distinguished from convallatoxin by a different sugar sequence. Contributes to the total cardiac glycoside toxicity profile and is used as an authentication fingerprint marker in HPLC quality-control analysis of Convallaria preparations.');
  PERFORM herbal.ensure_constituent('convallarin', 'steroidal saponin',
    'A spirostanol-type steroidal saponin of C. majalis (~0.1–0.5%); the predominant saponin of the plant. Haemolytic, diuretic, and laxative; a gastro-intestinal irritant at higher doses. Chemotaxonomic marker for the Convallaria genus; contributes to the herb''s traditional use as a diuretic (alongside the cardiac glycosides) and is part of the documented toxicity profile for cases of accidental ingestion.');
  PERFORM herbal.ensure_constituent('convallamarin', 'steroidal saponin',
    'A co-occurring steroidal saponin of C. majalis with a different sugar chain than convallarin; contributes to the total saponin fraction. Haemolytic and diuretic activity analogous to convallarin; part of the complete phytochemical fingerprint for species authentication and toxicological assessment of Convallaria preparations.');
  PERFORM herbal.ensure_constituent('azetidine-2-carboxylic acid', 'non-protein amino acid',
    'A four-membered ring non-protein amino acid (~0.5% fresh plant); the highest natural plant concentration of this compound. Safety-critical: misincorporated into proteins in place of proline (due to structural similarity), causing severe protein misfolding; teratogenic in animal studies. One of the key reasons Convallaria majalis is contraindicated for internal use outside highly dilute homoeopathic preparations. Important for clinical toxicology counselling when plant misidentification occurs.');

  PERFORM herbal.link_constituent('Convallaria majalis', 'convallatoxin',           'primary',  0);
  PERFORM herbal.link_constituent('Convallaria majalis', 'convalloside',            'major',    10);
  PERFORM herbal.link_constituent('Convallaria majalis', 'lokunjoside',             'moderate', 20);
  PERFORM herbal.link_constituent('Convallaria majalis', 'convallarin',             'moderate', 30);
  PERFORM herbal.link_constituent('Convallaria majalis', 'convallamarin',           'moderate', 40);
  PERFORM herbal.link_constituent('Convallaria majalis', 'azetidine-2-carboxylic acid','moderate',50);
  PERFORM herbal.link_constituent('Convallaria majalis', 'chelidonic acid',         'minor',    60);
  PERFORM herbal.link_constituent('Convallaria majalis', 'quercetin',               'minor',    70);
  PERFORM herbal.link_constituent('Convallaria majalis', 'kaempferol',              'minor',    80);

  RAISE NOTICE 'Added constituents to Lily of the Valley (Convallaria majalis)';
END $$;

-- ============================================================
-- Block 5: Sarsaparilla (Smilax spp.) — root
-- Already has: diosgenin (steroidal saponin aglycone, moderate)
-- beta-sitosterol, stigmasterol, quercetin, kaempferol,
-- caffeic acid, ferulic acid already in DB
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('sarsaponin', 'spirostanol saponin',
    'The primary and most characteristic bidesmosidic spirostanol saponin of Smilax root (= parillin); reported at 1–3% dry root weight across multiple Smilax species (S. officinalis, S. regelii, S. ornata). Forms the basis of the herb''s historical use as a "blood purifier" and anti-inflammatory agent; demonstrates in vitro binding to circulating endotoxins and hepatoprotective activity in rodent models. The defining quality-control marker compound for authentic sarsaparilla root.');
  PERFORM herbal.ensure_constituent('smilasaponin', 'spirostanol saponin',
    'A second major bidesmosidic spirostanol saponin (= smilacin) co-occurring with sarsaponin in Smilax root; differs in its rhamnose-glucose (C-3) and glucose (C-26) sugar chain configuration. Contributes to the total saponin fraction along with sarsaponin; surfactant properties relevant to the herb''s traditional diaphoretic and expectorant actions. A secondary quality marker for species authentication alongside sarsaponin.');
  PERFORM herbal.ensure_constituent('smilagenin', 'spirostanol saponin aglycone',
    'A spirostanol sapogenin aglycone co-occurring with diosgenin in Smilax root; structurally distinguished from diosgenin by the absence of the 25(27)-double bond. Identified across multiple Smilax species; investigated as a precursor for corticosteroid and sex hormone synthesis and as a potential anabolic adaptogen compound. Contributes to the herb''s phytosteroid profile alongside diosgenin.');
  PERFORM herbal.ensure_constituent('astilbin', 'dihydroflavonol glycoside',
    '(+)-Taxifolin-3-O-α-L-rhamnopyranoside; a characteristic dihydroflavonol (flavanonol) glycoside of the Smilax genus; particularly abundant in S. glabra (Tu Fu Ling). Anti-inflammatory via NF-κB inhibition; immunomodulatory (inhibits T-cell proliferation); hepatoprotective and anti-hyperuricaemic in rodent models. Used as a QC marker to distinguish S. glabra from other Smilax species and adulterants in botanical authentication.');
  PERFORM herbal.ensure_constituent('sarsaparilloside', 'furostanol saponin',
    'A furostanol-type (open-ring E, bisdesmosidic) saponin of Smilax root; furostanol saponins are considered biosynthetic precursors to the spirostanol forms. Detected by HPLC in chromatographic analyses of multiple Smilax species; contributes to the overall saponin complexity and distinguishes authentic sarsaparilla preparations from partial extracts.');
  PERFORM herbal.ensure_constituent('daucosterol', 'phytosterol glycoside',
    'β-Sitosterol-3-O-β-D-glucopyranoside (= sitosterol glucoside); the glycosylated form of β-sitosterol co-isolated with the free aglycone in Smilax root. Anti-inflammatory and immunomodulatory activity documented in its own right; distinct from free β-sitosterol (already in DB) by its sugar-bearing form with different bioavailability and membrane activity. Detected alongside free sitosterol in fractionation studies of Smilax root.');

  PERFORM herbal.link_constituent('Smilax spp.', 'sarsaponin',    'primary',  0);
  PERFORM herbal.link_constituent('Smilax spp.', 'smilasaponin',  'major',    10);
  PERFORM herbal.link_constituent('Smilax spp.', 'smilagenin',    'moderate', 20);
  PERFORM herbal.link_constituent('Smilax spp.', 'astilbin',      'moderate', 30);
  PERFORM herbal.link_constituent('Smilax spp.', 'diosgenin',     'moderate', 40);
  PERFORM herbal.link_constituent('Smilax spp.', 'sarsaparilloside','minor',  50);
  PERFORM herbal.link_constituent('Smilax spp.', 'daucosterol',   'minor',    60);
  PERFORM herbal.link_constituent('Smilax spp.', 'beta-sitosterol','minor',   70);
  PERFORM herbal.link_constituent('Smilax spp.', 'stigmasterol',  'minor',    80);
  PERFORM herbal.link_constituent('Smilax spp.', 'quercetin',     'minor',    90);
  PERFORM herbal.link_constituent('Smilax spp.', 'kaempferol',    'minor',    100);
  PERFORM herbal.link_constituent('Smilax spp.', 'caffeic acid',  'minor',    110);
  PERFORM herbal.link_constituent('Smilax spp.', 'ferulic acid',  'minor',    120);

  RAISE NOTICE 'Added constituents to Sarsaparilla (Smilax spp.)';
END $$;

-- ============================================================
-- Block 6: Madder (Rubia tinctorum) — root
-- Already has: anthraquinones (anthraquinone, major) — generic entry
-- ============================================================
DO $$
BEGIN
  PERFORM herbal.ensure_constituent('alizarin', 'anthraquinone',
    '1,2-Dihydroxyanthraquinone; the primary anthraquinone aglycone and characteristic red pigment of Rubia tinctorum root (~0.1–0.4% dry weight). Occurs predominantly as its glycoside ruberythric acid in fresh material; released by hydrolysis during processing. The historic textile dye compound and European Pharmacopoeia colorimetric reference standard for the species. In vitro COX-2 inhibitory anti-inflammatory properties; genotoxic potential at high doses in animal studies; the principal authentication marker for genuine madder root.');
  PERFORM herbal.ensure_constituent('ruberythric acid', 'anthraquinone glycoside',
    'Alizarin-2-β-primeveroside; the predominant naturally occurring glycoside form of alizarin in intact Rubia tinctorum root (0.5–1.0% dry weight) and the quantitatively dominant anthraquinone-related compound of the fresh drug. Hydrolysis (enzymatic or acid) yields alizarin and the disaccharide primeverose (glucose + xylose). The major storage and transport form of the alizarin moiety in the living plant; primary target for HPLC quality-control assay of whole madder root.');
  PERFORM herbal.ensure_constituent('purpurin', 'anthraquinone',
    '1,2,4-Trihydroxyanthraquinone; the second major anthraquinone colorant of Rubia tinctorum root (~0.05–0.2% dry weight), co-occurring with alizarin. Demonstrates calcium-binding properties (chelates Ca²⁺ via the 1,2-diol system) and has been investigated for anti-urolithiatic activity. Genotoxic in bacterial mutagenicity assays (though secondary in concern to lucidin); contributes to the orange-red hue of madder dyeing alongside alizarin.');
  PERFORM herbal.ensure_constituent('lucidin', 'anthraquinone',
    '1-Hydroxy-2-(hydroxymethyl)anthraquinone. GENOTOXIN — SAFETY CRITICAL: lucidin is a potent direct-acting mutagen (positive Ames test, TA98 and TA100 without metabolic activation) and forms DNA adducts in mammalian cells. The European Food Safety Authority (EFSA 2005 Opinion) and German Commission E concluded that Rubia tinctorum preparations cannot be considered safe for internal use due to lucidin''s genotoxic mutagenicity; the herb carries a negative Commission E monograph. Present at trace-to-minor concentrations but genotoxic potency at low concentrations precludes establishing a safe threshold. Contraindicated in pregnancy; whole root not recommended for internal therapeutic use.');
  PERFORM herbal.ensure_constituent('lucidin primeveroside', 'anthraquinone glycoside',
    'The glycoside storage form of lucidin in Rubia tinctorum root (lucidin + primeverose); the predominant form in crude root before processing. Also itself genotoxic in some assay systems — co-listed with lucidin in the EFSA 2005 safety opinion as a genotoxic concern. Hydrolysis releases free lucidin; its presence in extracts is the key reason commercial madder preparations require lucidin removal or whole-root use is contraindicated.');
  PERFORM herbal.ensure_constituent('munjistin', 'anthraquinone',
    '2-Carboxy-1-hydroxyanthraquinone (carboxylic acid derivative of hydroxyanthraquinone); named from Rubia munjista (Indian madder) but documented in R. tinctorum root. Lower dyeing capacity than alizarin or purpurin; contributes to the orange-red anthraquinone aglycone fraction. Limited pharmacological data; serves as a chemotaxonomic marker within the Rubiaceae family.');
  PERFORM herbal.ensure_constituent('pseudopurpurin', 'anthraquinone',
    '1,2,4-Trihydroxyanthraquinone-3-carboxylic acid; distinguished from purpurin by an additional carboxyl group at C-3. A naturally occurring constituent that may partially decarboxylate to purpurin on drying or prolonged storage — the balance of pseudopurpurin to purpurin is used as a freshness indicator for dried madder root. Contributes to the anthraquinone aglycone profile alongside alizarin and purpurin.');
  PERFORM herbal.ensure_constituent('xanthopurpurin', 'anthraquinone',
    '1,3-Dihydroxyanthraquinone; a positional isomer of alizarin (C-1/C-3 versus C-1/C-2 hydroxyls) documented in Rubia tinctorum root by HPLC analysis. A minor contributor to the anthraquinone fraction; distinguished from alizarin by UV-Vis and mass spectrometry. Limited pharmacological characterisation compared to alizarin and purpurin; serves as an anthraquinone fingerprint marker in quality-control profiling of madder root.');
  PERFORM herbal.ensure_constituent('galiosin', 'anthraquinone',
    '1-Methoxy-2-hydroxyanthraquinone (alizarin-1-methyl ether); a methoxylated alizarin derivative documented in Rubia tinctorum root and related Rubiaceae genera (Galium). Present at trace concentrations; contributes to the anthraquinone complexity and serves as a chemotaxonomic marker for the Rubiaceae family. Pharmacological data limited; minimal direct therapeutic significance at the concentrations present.');

  PERFORM herbal.link_constituent('Rubia tinctorum', 'alizarin',             'primary',  0);
  PERFORM herbal.link_constituent('Rubia tinctorum', 'ruberythric acid',     'primary',  10);
  PERFORM herbal.link_constituent('Rubia tinctorum', 'purpurin',             'major',    20);
  PERFORM herbal.link_constituent('Rubia tinctorum', 'lucidin',              'minor',    30);
  PERFORM herbal.link_constituent('Rubia tinctorum', 'lucidin primeveroside','minor',    40);
  PERFORM herbal.link_constituent('Rubia tinctorum', 'munjistin',            'minor',    50);
  PERFORM herbal.link_constituent('Rubia tinctorum', 'pseudopurpurin',       'minor',    60);
  PERFORM herbal.link_constituent('Rubia tinctorum', 'xanthopurpurin',       'minor',    70);
  PERFORM herbal.link_constituent('Rubia tinctorum', 'galiosin',             'trace',    80);

  RAISE NOTICE 'Added constituents to Madder (Rubia tinctorum)';
END $$;
