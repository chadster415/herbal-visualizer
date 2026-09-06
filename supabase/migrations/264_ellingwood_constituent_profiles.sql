-- Migration 264: Fix herb records from migration 262 and add constituent_profiles
-- for 12 of the 13 Ellingwood herbs (Turkey Corn omitted pending taxonomy confirmation).
--
-- Part 1: Four herb record corrections
--   • Turkey Corn: Corydalis formosa → Dicentra eximia (modern taxonomy for eclectic 'turkey corn')
--   • Strophanthus: Strophanthus kombé → Strophanthus kombe (remove accent)
--   • Sticta: Sticta pulmonaria → Lobaria pulmonaria (accepted name)
--   • Selenicereus grandiflorus: plant_part NULL → stem
--
-- Part 2: constituent_profiles (amber Marker cards) for 12 herbs
--   Source: ChatGPT species-specific literature review
--   Herbs covered: Aletris, Bryonia, Fireweed, Henbane, Calabar Bean,
--   Night-Blooming Cereus, False Unicorn, Sticta/Lobaria, Jalap,
--   Poison Hemlock, Strophanthus, Stramonium
--
-- Note: Sticta and Strophanthus blocks look up by the corrected latin_name;
--   Part 1 must complete before Part 2 runs (auto-commit between DO blocks).

SET search_path TO herbal, public;

-- ── Part 1: Herb record corrections ──────────────────────────────────────────

DO $$
BEGIN
  UPDATE herbal.herbs
  SET latin_name = 'Dicentra eximia',
      synonyms = ARRAY['Turkey corn', 'Fringed bleeding heart', 'Wild bleeding heart',
                       'Corydalis formosa', 'Turkey pea', 'Staggerweed', 'Squirrel corn']
  WHERE latin_name = 'Corydalis formosa';

  UPDATE herbal.herbs
  SET latin_name = 'Strophanthus kombe',
      synonyms = ARRAY['Kombé strophanthus', 'Kombé arrow poison', 'Kombe', 'Strophanthus kombé']
  WHERE latin_name = 'Strophanthus kombé';

  UPDATE herbal.herbs
  SET latin_name = 'Lobaria pulmonaria',
      synonyms = ARRAY['Lungwort lichen', 'Tree lungwort', 'Lobaria', 'Oak lungwort',
                       'Lungwort moss', 'Sticta pulmonaria']
  WHERE latin_name = 'Sticta pulmonaria';

  UPDATE herbal.herbs
  SET plant_part = 'stem'
  WHERE latin_name = 'Selenicereus grandiflorus';

  RAISE NOTICE 'Migration 264 Part 1: herb record corrections done.';
END $$;

-- ── 1. Aletris (Aletris farinosa, Root) ──────────────────────────────────────

DO $$
DECLARE
  v_herb INTEGER;
  v_note CONSTANT TEXT :=
    'Aletris farinosa was historically described largely in terms of steroidal saponins, but '
    'modern phytochemical investigation revealed an unusual cheilanthane sesterterpene family, '
    'including a major malonylated derivative, as more chemically distinctive. Diosgenin '
    'remains useful as a representative of the older documented steroidal fraction, but '
    'should not dominate the profile.';
BEGIN
  SELECT id INTO v_herb FROM herbal.herbs WHERE latin_name = 'Aletris farinosa';
  IF v_herb IS NULL THEN
    RAISE EXCEPTION 'Aletris farinosa not found — run migration 262 first';
  END IF;

  DELETE FROM herbal.constituent_profiles WHERE herb_id = v_herb;
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part,
     constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb, 'Aletris', 'Aletris farinosa', 'Root',
     '(3R)-Malonyl-(13S)-hydroxycheilanth-17-en-19-oic acid', 'Terpenoid', 'Sesterterpenoid',
     'High', 'Marker',
     'Unusual cheilanthane derivative reported as the major constituent of the root and highly characteristic of the species.',
     v_note),
    (v_herb, 'Aletris', 'Aletris farinosa', 'Root',
     'Diosgenin', 'Steroid', 'Steroidal sapogenin',
     'Moderate', 'Major',
     'Steroidal sapogenin historically isolated from the root and associated with its saponin fraction.',
     v_note);
  RAISE NOTICE 'Aletris (id %) constituent_profiles: done.', v_herb;
END $$;

-- ── 2. Bryonia (Bryonia alba, Root) ──────────────────────────────────────────

DO $$
DECLARE
  v_herb INTEGER;
  v_note CONSTANT TEXT :=
    'Bryonia alba root is chemically defined by its cucurbitane-type triterpenes, particularly '
    'cucurbitacins B, E, I, and D. These intensely bitter compounds account for much of '
    'Bryonia''s drastic gastrointestinal and cytotoxic activity and provide a considerably '
    'stronger matching signal than ubiquitous flavonoids or phenolic acids.';
BEGIN
  SELECT id INTO v_herb FROM herbal.herbs WHERE latin_name = 'Bryonia alba';
  IF v_herb IS NULL THEN
    RAISE EXCEPTION 'Bryonia alba not found — run migration 262 first';
  END IF;

  DELETE FROM herbal.constituent_profiles WHERE herb_id = v_herb;
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part,
     constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb, 'Bryonia', 'Bryonia alba', 'Root',
     'Cucurbitacin B', 'Terpenoid', 'Cucurbitane triterpenoid',
     'High', 'Marker',
     'Highly characteristic bitter cucurbitacin contributing cytotoxic and strongly irritant activity.',
     v_note),
    (v_herb, 'Bryonia', 'Bryonia alba', 'Root',
     'Cucurbitacin E', 'Terpenoid', 'Cucurbitane triterpenoid',
     'High', 'Marker',
     'Major bitter tetracyclic triterpenoid characteristic of Bryonia root.',
     v_note),
    (v_herb, 'Bryonia', 'Bryonia alba', 'Root',
     'Cucurbitacin I', 'Terpenoid', 'Cucurbitane triterpenoid',
     'High', 'Major',
     'Characteristic cucurbitacin contributing to the root''s strongly bioactive triterpenoid fraction.',
     v_note),
    (v_herb, 'Bryonia', 'Bryonia alba', 'Root',
     'Cucurbitacin D', 'Terpenoid', 'Cucurbitane triterpenoid',
     'Moderate', 'Major',
     'Related bitter triterpenoid reinforcing the characteristic cucurbitacin profile.',
     v_note),
    (v_herb, 'Bryonia', 'Bryonia alba', 'Root',
     'Cucurbitacin J', 'Terpenoid', 'Cucurbitane triterpenoid',
     'Moderate', 'Present',
     'Additional species-confirmed cucurbitacin contributing chemical specificity.',
     v_note);
  RAISE NOTICE 'Bryonia (id %) constituent_profiles: done.', v_herb;
END $$;

-- ── 3. Fireweed (Epilobium angustifolium, Aerial parts) ───────────────────────

DO $$
DECLARE
  v_herb INTEGER;
  v_note CONSTANT TEXT :=
    'Epilobium angustifolium is strongly characterized by its oligomeric ellagitannins, '
    'particularly oenothein B, together with abundant flavonol glycosides. Oenothein B and '
    'quercetin-3-O-glucuronide are especially useful because both are chemically prominent '
    'and have been proposed as raw-material standardization markers.';
BEGIN
  SELECT id INTO v_herb FROM herbal.herbs WHERE latin_name = 'Epilobium angustifolium';
  IF v_herb IS NULL THEN
    RAISE EXCEPTION 'Epilobium angustifolium not found — run migration 262 first';
  END IF;

  DELETE FROM herbal.constituent_profiles WHERE herb_id = v_herb;
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part,
     constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb, 'Fireweed', 'Epilobium angustifolium', 'Aerial parts',
     'Oenothein B', 'Tannin', 'Ellagitannin',
     'High', 'Marker',
     'Dominant macrocyclic ellagitannin and major contributor to astringent, anti-inflammatory, and antioxidant activity.',
     v_note),
    (v_herb, 'Fireweed', 'Epilobium angustifolium', 'Aerial parts',
     'Quercetin-3-O-glucuronide', 'Flavonoid', 'Flavonol glycoside',
     'High', 'Marker',
     'Major flavonoid and recognized analytical marker for Fireweed raw material.',
     v_note),
    (v_herb, 'Fireweed', 'Epilobium angustifolium', 'Aerial parts',
     'Oenothein A', 'Tannin', 'Ellagitannin',
     'High', 'Major',
     'Oligomeric ellagitannin accompanying oenothein B in particularly high amounts in flowering portions.',
     v_note),
    (v_herb, 'Fireweed', 'Epilobium angustifolium', 'Aerial parts',
     'Tellimagrandin I', 'Tannin', 'Ellagitannin',
     'Moderate', 'Major',
     'Monomeric ellagitannin forming part of the characteristic oligomeric tannin chemistry.',
     v_note),
    (v_herb, 'Fireweed', 'Epilobium angustifolium', 'Aerial parts',
     'Ellagic acid', 'Polyphenol', 'Phenolic acid',
     'Moderate', 'Major',
     'Important ellagitannin-related phenolic contributing antioxidant and astringent activity.',
     v_note);
  RAISE NOTICE 'Fireweed (id %) constituent_profiles: done.', v_herb;
END $$;

-- ── 4. Henbane (Hyoscyamus niger, Leaf) ───────────────────────────────────────

DO $$
DECLARE
  v_herb INTEGER;
  v_note CONSTANT TEXT :=
    'Hyoscyamus niger leaf is chemically dominated by the tropane alkaloids hyoscyamine and '
    'scopolamine. Their muscarinic-receptor antagonism accounts for the plant''s historical '
    'antispasmodic and sedative effects as well as its substantial toxicity, making additional '
    'minor constituents unnecessary for a representative matching profile.';
BEGIN
  SELECT id INTO v_herb FROM herbal.herbs WHERE latin_name = 'Hyoscyamus niger';
  IF v_herb IS NULL THEN
    RAISE EXCEPTION 'Hyoscyamus niger not found — run migration 262 first';
  END IF;

  DELETE FROM herbal.constituent_profiles WHERE herb_id = v_herb;
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part,
     constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb, 'Henbane', 'Hyoscyamus niger', 'Leaf',
     'L-Hyoscyamine', 'Alkaloid', 'Tropane alkaloid',
     'High', 'Marker',
     'Principal antimuscarinic tropane alkaloid responsible for much of Henbane''s pharmacological activity and toxicity.',
     v_note),
    (v_herb, 'Henbane', 'Hyoscyamus niger', 'Leaf',
     'Scopolamine', 'Alkaloid', 'Tropane alkaloid',
     'High', 'Marker',
     'Characteristic centrally active antimuscarinic alkaloid complementing hyoscyamine.',
     v_note);
  RAISE NOTICE 'Henbane (id %) constituent_profiles: done.', v_herb;
END $$;

-- ── 5. Calabar Bean (Physostigma venenosum, Seed) ─────────────────────────────

DO $$
DECLARE
  v_herb INTEGER;
  v_note CONSTANT TEXT :=
    'Physostigma venenosum seed is defined by a compact family of pyrroloindole alkaloids, '
    'overwhelmingly led by physostigmine. Its potent reversible acetylcholinesterase inhibition '
    'explains both the historical pharmacological significance of Calabar Bean and its '
    'potentially severe cholinergic toxicity.';
BEGIN
  SELECT id INTO v_herb FROM herbal.herbs WHERE latin_name = 'Physostigma venenosum';
  IF v_herb IS NULL THEN
    RAISE EXCEPTION 'Physostigma venenosum not found — run migration 262 first';
  END IF;

  DELETE FROM herbal.constituent_profiles WHERE herb_id = v_herb;
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part,
     constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb, 'Calabar Bean', 'Physostigma venenosum', 'Seed',
     'Physostigmine', 'Alkaloid', 'Pyrroloindole alkaloid',
     'High', 'Marker',
     'Dominant reversible acetylcholinesterase inhibitor responsible for the seed''s characteristic cholinergic activity.',
     v_note),
    (v_herb, 'Calabar Bean', 'Physostigma venenosum', 'Seed',
     'Eseramine', 'Alkaloid', 'Pyrroloindole alkaloid',
     'Moderate', 'Major',
     'Structurally related Calabar Bean alkaloid accompanying physostigmine.',
     v_note),
    (v_herb, 'Calabar Bean', 'Physostigma venenosum', 'Seed',
     'Geneserine', 'Alkaloid', 'Pyrroloindole alkaloid',
     'Moderate', 'Major',
     'Characteristic related alkaloid capable of interconversion with physostigmine N-oxide under acidic conditions.',
     v_note);
  RAISE NOTICE 'Calabar Bean (id %) constituent_profiles: done.', v_herb;
END $$;

-- ── 6. Night-Blooming Cereus (Selenicereus grandiflorus, Stem) ────────────────

DO $$
DECLARE
  v_herb INTEGER;
  v_note CONSTANT TEXT :=
    'Selenicereus grandiflorus remains comparatively under-characterized, but available '
    'pharmacognostic sources support a combination of phenethylamine-related compounds and '
    'flavonol glycosides. Hordenine provides the strongest distinctive small-molecule signal; '
    'the modest profile reflects the limited modern species-specific evidence rather than an '
    'attempt to manufacture additional markers.';
BEGIN
  SELECT id INTO v_herb FROM herbal.herbs WHERE latin_name = 'Selenicereus grandiflorus';
  IF v_herb IS NULL THEN
    RAISE EXCEPTION 'Selenicereus grandiflorus not found — run migration 262 first';
  END IF;

  DELETE FROM herbal.constituent_profiles WHERE herb_id = v_herb;
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part,
     constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb, 'Night-Blooming Cereus', 'Selenicereus grandiflorus', 'Stem',
     'Hordenine', 'Alkaloid', 'Phenethylamine alkaloid',
     'High', 'Marker',
     'Characteristic phenethylamine derivative historically associated with the plant''s cardiovascular activity.',
     v_note),
    (v_herb, 'Night-Blooming Cereus', 'Selenicereus grandiflorus', 'Stem',
     'Tyramine', 'Nitrogenous compound', 'Phenethylamine derivative',
     'Moderate', 'Major',
     'Bioactive trace amine complementing the characteristic nitrogenous fraction.',
     v_note),
    (v_herb, 'Night-Blooming Cereus', 'Selenicereus grandiflorus', 'Stem',
     'Rutin', 'Flavonoid', 'Flavonol glycoside',
     'Moderate', 'Major',
     'Documented stem flavonoid contributing antioxidant activity.',
     v_note),
    (v_herb, 'Night-Blooming Cereus', 'Selenicereus grandiflorus', 'Stem',
     'Hyperoside', 'Flavonoid', 'Flavonol glycoside',
     'Moderate', 'Major',
     'Quercetin glycoside documented as a consistent constituent of the stem.',
     v_note);
  RAISE NOTICE 'Night-Blooming Cereus (id %) constituent_profiles: done.', v_herb;
END $$;

-- ── 7. False Unicorn (Chamaelirium luteum, Root) ──────────────────────────────

DO $$
DECLARE
  v_herb INTEGER;
  v_note CONSTANT TEXT :=
    'Chamaelirium luteum root is chemically defined by an unusually distinctive family of '
    'open-chain steroidal saponins, especially chamaelirosides A and B and their '
    'chiograsterol-derived aglycone. Modern structural work shows that this chemistry is '
    'far more species-specific than older generic descriptions of "steroidal saponins" implied.';
BEGIN
  SELECT id INTO v_herb FROM herbal.herbs WHERE latin_name = 'Chamaelirium luteum';
  IF v_herb IS NULL THEN
    RAISE EXCEPTION 'Chamaelirium luteum not found — run migration 262 first';
  END IF;

  DELETE FROM herbal.constituent_profiles WHERE herb_id = v_herb;
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part,
     constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb, 'False Unicorn', 'Chamaelirium luteum', 'Root',
     'Chamaeliroside A', 'Glycoside', 'Steroidal glycoside',
     'High', 'Marker',
     'Predominant species-characteristic open-chain steroidal saponin.',
     v_note),
    (v_herb, 'False Unicorn', 'Chamaelirium luteum', 'Root',
     'Chamaeliroside B', 'Glycoside', 'Steroidal glycoside',
     'High', 'Marker',
     'Predominant steroidal saponin based on the unusual chiograsterol skeleton.',
     v_note),
    (v_herb, 'False Unicorn', 'Chamaelirium luteum', 'Root',
     'Heloside A', 'Glycoside', 'Steroidal glycoside',
     'Moderate', 'Major',
     'Characteristic root saponin based on the helogenin aglycone.',
     v_note),
    (v_herb, 'False Unicorn', 'Chamaelirium luteum', 'Root',
     '6-Dehydrochamaeliroside A', 'Glycoside', 'Steroidal glycoside',
     'Moderate', 'Major',
     'Characteristic dehydro derivative within the chamaeliroside series.',
     v_note),
    (v_herb, 'False Unicorn', 'Chamaelirium luteum', 'Root',
     'Chamaeliroside E', 'Glycoside', 'Steroidal glycoside',
     'Moderate', 'Major',
     'Species-associated steroidal saponin extending the distinctive open-chain profile.',
     v_note),
    (v_herb, 'False Unicorn', 'Chamaelirium luteum', 'Root',
     '(23R,24S)-Chiograsterol B', 'Steroid', 'Steroidal sapogenin',
     'Moderate', 'Major',
     'Unusual aglycone underlying the predominant chamaelirosides A and B.',
     v_note);
  RAISE NOTICE 'False Unicorn (id %) constituent_profiles: done.', v_herb;
END $$;

-- ── 8. Sticta (Lobaria pulmonaria, Thallus) ───────────────────────────────────

DO $$
DECLARE
  v_herb INTEGER;
  v_note CONSTANT TEXT :=
    'Lobaria pulmonaria is unusually well characterized by a stictic-acid depsidone '
    'chemosyndrome, dominated by stictic acid with substantial constictic and norstictic acids. '
    'These specialized lichen metabolites provide a highly distinctive chemical fingerprint '
    'and are far more useful for matching than the accompanying sugar alcohols or carotenoids.';
BEGIN
  SELECT id INTO v_herb FROM herbal.herbs WHERE latin_name = 'Lobaria pulmonaria';
  IF v_herb IS NULL THEN
    RAISE EXCEPTION 'Lobaria pulmonaria not found — run migrations 262 and 264 Part 1 first';
  END IF;

  DELETE FROM herbal.constituent_profiles WHERE herb_id = v_herb;
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part,
     constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb, 'Sticta', 'Lobaria pulmonaria', 'Thallus',
     'Stictic acid', 'Depsidone', 'Depsidone',
     'High', 'Marker',
     'Dominant characteristic lichen acid and principal component of the stictic-acid chemosyndrome.',
     v_note),
    (v_herb, 'Sticta', 'Lobaria pulmonaria', 'Thallus',
     'Constictic acid', 'Depsidone', 'Depsidone',
     'High', 'Major',
     'Second major depsidone accompanying stictic acid.',
     v_note),
    (v_herb, 'Sticta', 'Lobaria pulmonaria', 'Thallus',
     'Norstictic acid', 'Depsidone', 'Depsidone',
     'High', 'Major',
     'Major lichen depsidone contributing to the characteristic chemical fingerprint.',
     v_note),
    (v_herb, 'Sticta', 'Lobaria pulmonaria', 'Thallus',
     'Desmethylstictic acid', 'Depsidone', 'Depsidone',
     'Moderate', 'Major',
     'Closely related stictic-acid derivative documented in the thallus.',
     v_note),
    (v_herb, 'Sticta', 'Lobaria pulmonaria', 'Thallus',
     'Gyrophoric acid', 'Polyphenol', 'Depside',
     'Moderate', 'Present',
     'Complementary lichen depside occurring alongside the dominant depsidone fraction.',
     v_note);
  RAISE NOTICE 'Sticta/Lobaria (id %) constituent_profiles: done.', v_herb;
END $$;

-- ── 9. Jalap (Ipomoea purga, Root) ────────────────────────────────────────────

DO $$
DECLARE
  v_herb INTEGER;
  v_note CONSTANT TEXT :=
    'Ipomoea purga root is defined by its unusual resin glycosides and glycosidic acids, '
    'the structural basis of Jalap''s drastic purgative activity. Generic historical terms '
    'such as "jalapin" and "convolvulin" are intentionally excluded because they describe '
    'complex fractions rather than chemically discrete constituents.';
BEGIN
  SELECT id INTO v_herb FROM herbal.herbs WHERE latin_name = 'Ipomoea purga';
  IF v_herb IS NULL THEN
    RAISE EXCEPTION 'Ipomoea purga not found — run migration 262 first';
  END IF;

  DELETE FROM herbal.constituent_profiles WHERE herb_id = v_herb;
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part,
     constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb, 'Jalap', 'Ipomoea purga', 'Root',
     'Jalapinoside', 'Glycoside', 'Resin glycoside',
     'High', 'Marker',
     'Species-confirmed macrocyclic bisdesmoside representing the characteristic purgative resin-glycoside fraction.',
     v_note),
    (v_herb, 'Jalap', 'Ipomoea purga', 'Root',
     'Jalapinoside B', 'Glycoside', 'Resin glycoside',
     'High', 'Marker',
     'Complex macrocyclic bisdesmoside isolated directly from authentic Jalap root.',
     v_note),
    (v_herb, 'Jalap', 'Ipomoea purga', 'Root',
     'Purgic acid A', 'Glycoside', 'Glycosidic acid',
     'High', 'Marker',
     'Characteristic convolvulinic-acid hexasaccharide used in authentication of genuine Jalap root.',
     v_note),
    (v_herb, 'Jalap', 'Ipomoea purga', 'Root',
     'Purgic acid B', 'Glycoside', 'Glycosidic acid',
     'High', 'Marker',
     'Jalapinolic-acid hexasaccharide characteristic of authentic Jalap resin chemistry.',
     v_note),
    (v_herb, 'Jalap', 'Ipomoea purga', 'Root',
     'Purgic acid C', 'Glycoside', 'Glycosidic acid',
     'Moderate', 'Major',
     'Species-specific ipurolic-acid glycoside associated with the root resin-glycoside complex.',
     v_note);
  RAISE NOTICE 'Jalap (id %) constituent_profiles: done.', v_herb;
END $$;

-- ── 10. Poison Hemlock (Conium maculatum, Fruit) ──────────────────────────────

DO $$
DECLARE
  v_herb INTEGER;
  v_note CONSTANT TEXT :=
    'Conium maculatum is chemically defined almost completely by simple piperidine alkaloids, '
    'particularly γ-coniceine and coniine. γ-Coniceine is the biosynthetic precursor of the '
    'other principal alkaloids, while plant age and environment strongly affect their relative '
    'concentrations; the family nevertheless provides an exceptionally distinctive '
    'toxicological profile.';
BEGIN
  SELECT id INTO v_herb FROM herbal.herbs WHERE latin_name = 'Conium maculatum';
  IF v_herb IS NULL THEN
    RAISE EXCEPTION 'Conium maculatum not found — run migration 262 first';
  END IF;

  DELETE FROM herbal.constituent_profiles WHERE herb_id = v_herb;
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part,
     constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb, 'Poison Hemlock', 'Conium maculatum', 'Fruit',
     'γ-Coniceine', 'Alkaloid', 'Piperidine alkaloid',
     'High', 'Marker',
     'Biosynthetic parent and one of the two dominant toxic alkaloids of Poison Hemlock.',
     v_note),
    (v_herb, 'Poison Hemlock', 'Conium maculatum', 'Fruit',
     'Coniine', 'Alkaloid', 'Piperidine alkaloid',
     'High', 'Marker',
     'Principal mature piperidine alkaloid responsible for characteristic neuromuscular toxicity.',
     v_note),
    (v_herb, 'Poison Hemlock', 'Conium maculatum', 'Fruit',
     'N-Methylconiine', 'Alkaloid', 'Piperidine alkaloid',
     'Moderate', 'Major',
     'Characteristic methylated coniine derivative contributing to the toxic alkaloid fraction.',
     v_note),
    (v_herb, 'Poison Hemlock', 'Conium maculatum', 'Fruit',
     'Conhydrine', 'Alkaloid', 'Piperidine alkaloid',
     'Moderate', 'Major',
     'Hydroxylated piperidine alkaloid characteristic of the species.',
     v_note),
    (v_herb, 'Poison Hemlock', 'Conium maculatum', 'Fruit',
     'Pseudoconhydrine', 'Alkaloid', 'Piperidine alkaloid',
     'Low–Moderate', 'Present',
     'Minor related alkaloid complementing the coniine family.',
     v_note);
  RAISE NOTICE 'Poison Hemlock (id %) constituent_profiles: done.', v_herb;
END $$;

-- ── 11. Strophanthus (Strophanthus kombe, Seed) ───────────────────────────────

DO $$
DECLARE
  v_herb INTEGER;
  v_note CONSTANT TEXT :=
    'Strophanthus kombe seed is overwhelmingly defined by strophanthidin-based cardenolide '
    'glycosides, especially K-strophanthoside, K-strophanthin-β, and cymarin. The unusually '
    'concentrated cardiac-glycoside fraction accounts for both its historical cardiotonic '
    'importance and narrow therapeutic margin.';
BEGIN
  SELECT id INTO v_herb FROM herbal.herbs WHERE latin_name = 'Strophanthus kombe';
  IF v_herb IS NULL THEN
    RAISE EXCEPTION 'Strophanthus kombe not found — run migrations 262 and 264 Part 1 first';
  END IF;

  DELETE FROM herbal.constituent_profiles WHERE herb_id = v_herb;
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part,
     constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb, 'Strophanthus', 'Strophanthus kombe', 'Seed',
     'K-Strophanthoside', 'Steroid', 'Cardiac glycoside',
     'High', 'Marker',
     'Major seed cardenolide glycoside and principal component of the traditional strophanthin-K mixture.',
     v_note),
    (v_herb, 'Strophanthus', 'Strophanthus kombe', 'Seed',
     'K-Strophanthin-β', 'Steroid', 'Cardiac glycoside',
     'High', 'Marker',
     'Characteristic strophanthidin glycoside central to the strongly cardiotonic seed fraction.',
     v_note),
    (v_herb, 'Strophanthus', 'Strophanthus kombe', 'Seed',
     'Cymarin', 'Steroid', 'Cardiac glycoside',
     'High', 'Major',
     'Potent species-characteristic cardenolide glycoside containing strophanthidin.',
     v_note),
    (v_herb, 'Strophanthus', 'Strophanthus kombe', 'Seed',
     'Erysimoside', 'Steroid', 'Cardiac glycoside',
     'Moderate', 'Major',
     'Strophanthidin-based glycoside contributing to the complex cardenolide profile.',
     v_note),
    (v_herb, 'Strophanthus', 'Strophanthus kombe', 'Seed',
     'Helveticoside', 'Steroid', 'Cardiac glycoside',
     'Moderate', 'Major',
     'Characteristic cardiac glycoside documented in K-strophanthin preparations.',
     v_note),
    (v_herb, 'Strophanthus', 'Strophanthus kombe', 'Seed',
     'Strophanthidin', 'Steroid', 'Cardenolide aglycone',
     'Moderate', 'Major',
     'Central aglycone underlying many of the characteristic seed cardiac glycosides.',
     v_note);
  RAISE NOTICE 'Strophanthus (id %) constituent_profiles: done.', v_herb;
END $$;

-- ── 12. Stramonium (Datura stramonium, Leaf) ──────────────────────────────────

DO $$
DECLARE
  v_herb INTEGER;
  v_note CONSTANT TEXT :=
    'Datura stramonium leaf is chemically defined by the tropane alkaloids hyoscyamine and '
    'scopolamine. Their proportions vary substantially with organ and developmental stage, '
    'but together they account for the plant''s characteristic antimuscarinic, hallucinogenic, '
    'and highly toxic pharmacology; additional generic metabolites add little value to the '
    'matching profile.';
BEGIN
  SELECT id INTO v_herb FROM herbal.herbs WHERE latin_name = 'Datura stramonium';
  IF v_herb IS NULL THEN
    RAISE EXCEPTION 'Datura stramonium not found — run migration 262 first';
  END IF;

  DELETE FROM herbal.constituent_profiles WHERE herb_id = v_herb;
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part,
     constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb, 'Stramonium', 'Datura stramonium', 'Leaf',
     'L-Hyoscyamine', 'Alkaloid', 'Tropane alkaloid',
     'High', 'Marker',
     'Principal native tropane alkaloid responsible for strong peripheral and central antimuscarinic activity.',
     v_note),
    (v_herb, 'Stramonium', 'Datura stramonium', 'Leaf',
     'Scopolamine', 'Alkaloid', 'Tropane alkaloid',
     'High', 'Marker',
     'Major characteristic tropane alkaloid contributing central anticholinergic and hallucinogenic toxicity.',
     v_note);
  RAISE NOTICE 'Stramonium (id %) constituent_profiles: done.', v_herb;
END $$;
