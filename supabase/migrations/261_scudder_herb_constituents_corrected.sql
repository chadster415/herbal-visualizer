-- Migration 261: Replace herb_constituents for 11 Scudder herbs with correctly-researched data.
-- Migration 259 incorrectly derived herb_constituents directly from the user-provided
-- constituent_profiles marker data. This migration deletes those rows and re-inserts
-- independently-researched general constituent data, adding:
--   Cannabis  (2601): myrcene, beta-caryophyllene, linalool, alpha-pinene (shared terpenes)
--   Belladonna(2600): scopoletin (coumarin linking to 9 corpus herbs)
--   Spearmint (2607): beta-caryophyllene (documented minor sesquiterpene in Mentha spicata)
--   Podophyllum(2605): quercetin, kaempferol (flavonols documented in the rhizome)
-- All other herbs retain the same compound set (their chemistry is dominated by
-- specialized alkaloids/glycosides with no meaningful broader corpus connections).

SET search_path TO herbal, public;

-- ── Delete migration 259's herb_constituents rows for all 11 herbs ────────────

DO $$
BEGIN
  DELETE FROM herbal.herb_constituents
  WHERE herb_id IN (2598,2599,2600,2601,2603,2604,2605,2606,2607,2608,2609);
  RAISE NOTICE 'Deleted migration 259 herb_constituents rows for 11 Scudder herbs.';
END $$;

-- ── 2598 Aconite (Aconitum napellus, Root) ───────────────────────────────────
-- Dominated by C19 diterpenoid alkaloids; no broadly-shared corpus connections.

DO $$
DECLARE
  v_herb CONSTANT INTEGER := 2598;
  v_c INTEGER;
BEGIN
  v_c := herbal.ensure_constituent('aconitine', 'diterpenoid alkaloid',
    'Principal C19 diterpenoid alkaloid of Aconitum napellus root; highly toxic sodium-channel activator responsible for characteristic cardiotoxic and neurotoxic effects.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary', 'Marker. Principal highly toxic diterpenoid alkaloid responsible for much of aconite''s characteristic sodium-channel activity.', 0)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('mesaconitine', 'diterpenoid alkaloid',
    'Potent diester diterpenoid alkaloid of Aconitum species; contributes to characteristic neurotoxic and cardiotoxic activity alongside aconitine.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate', NULL, 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('hypaconitine', 'diterpenoid alkaloid',
    'Related diester diterpenoid alkaloid of Aconitum species contributing to toxicity and pharmacological activity alongside aconitine and mesaconitine.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate', NULL, 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('napelline', 'diterpenoid alkaloid',
    'Characteristic C19 diterpenoid alkaloid particularly associated with Aconitum napellus; contributes to the species-specific alkaloid profile.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate', NULL, 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Aconite (id 2598) herb_constituents: done.';
END $$;

-- ── 2599 Dogbane (Apocynum cannabinum, Root) ─────────────────────────────────
-- Dominated by cardenolide cardiac glycosides; no broadly-shared corpus connections.

DO $$
DECLARE
  v_herb CONSTANT INTEGER := 2599;
  v_c INTEGER;
BEGIN
  v_c := herbal.ensure_constituent('cymarin', 'cardiac glycoside',
    'Principal cardenolide glycoside of Apocynum cannabinum root and rhizome; responsible for characteristic cardiotonic and toxic activity.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary', 'Marker. Principal cardenolide glycoside responsible for the characteristic cardiotonic and toxic activity.', 0)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('apocannoside', 'cardiac glycoside',
    'Characteristic cardioactive glycoside of Apocynum cannabinum root and rhizome; reported alongside cymarin in pharmacognosy literature.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'major', NULL, 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('cynocannoside', 'cardiac glycoside',
    'Species-associated cardiac glycoside of Apocynum cannabinum; complementary to the cymarin-dominated fraction.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate', NULL, 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Dogbane (id 2599) herb_constituents: done.';
END $$;

-- ── 2600 Belladonna (Atropa belladonna, Leaf) ────────────────────────────────
-- Tropane alkaloids dominate; scopoletin (coumarin) links to 9 corpus herbs.

DO $$
DECLARE
  v_herb CONSTANT INTEGER := 2600;
  v_c INTEGER;
BEGIN
  v_c := herbal.ensure_constituent('L-hyoscyamine', 'tropane alkaloid',
    'Principal naturally occurring tropane alkaloid of Atropa belladonna leaf; potent muscarinic-receptor antagonist. Atropine is its racemic form, arising during extraction rather than in the intact plant.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary', 'Marker. Principal naturally occurring tropane alkaloid responsible for potent antimuscarinic activity.', 0)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('scopolamine', 'tropane alkaloid',
    'Characteristic epoxide-bearing tropane alkaloid found in Atropa and related Solanaceae; prominent central and peripheral antimuscarinic effects.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'major', NULL, 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('anisodamine', 'tropane alkaloid',
    'Hydroxylated tropane alkaloid occurring within the hyoscyamine-to-scopolamine biosynthetic pathway in Atropa belladonna.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'minor', NULL, 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Scopoletin links Belladonna to ashwagandha, cramp bark, oat, marshmallow,
  -- wild cherry bark, and 4 others in the corpus.
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'scopoletin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'minor', NULL, 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Belladonna (id 2600) herb_constituents: done.';
END $$;

-- ── 2601 Cannabis (Cannabis sativa, Aerial parts) ────────────────────────────
-- Cannabinoids are the chemically defining fraction; terpenes (myrcene,
-- beta-caryophyllene, linalool, alpha-pinene) create meaningful cross-herb links.

DO $$
DECLARE
  v_herb CONSTANT INTEGER := 2601;
  v_c INTEGER;
BEGIN
  v_c := herbal.ensure_constituent('Δ9-tetrahydrocannabinolic acid (THCA)', 'cannabinoid',
    'Principal acidic phytocannabinoid precursor of psychoactive THC in THC-dominant Cannabis chemotypes; decarboxylates to THC on heating.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary', 'Marker. Principal acidic cannabinoid precursor of psychoactive Δ9-THC in THC-dominant chemotypes.', 0)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('cannabidiolic acid (CBDA)', 'cannabinoid',
    'Principal acidic precursor of cannabidiol in CBD-dominant Cannabis chemotypes; decarboxylates to CBD.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary', 'Marker. Principal acidic precursor of cannabidiol in CBD-dominant chemotypes.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('Δ9-tetrahydrocannabinol (THC)', 'cannabinoid',
    'Psychoactive cannabinoid formed principally by decarboxylation of THCA; acts via CB1 and CB2 receptors; primary driver of intoxicant effects.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary', 'Marker. Psychoactive cannabinoid formed principally through decarboxylation of THCA.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('cannabidiol (CBD)', 'cannabinoid',
    'Major non-intoxicating phytocannabinoid with broad neuroactive, anti-inflammatory, and anticonvulsant pharmacology; formed by decarboxylation of CBDA.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary', 'Marker. Major non-intoxicating cannabinoid with broad neuroactive and anti-inflammatory pharmacology.', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Myrcene: often the most abundant terpene in cannabis; links to hops and juniper.
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'myrcene';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'major', 'Often the most abundant terpene fraction; contributes to sedative-adjacent effects.', 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Beta-caryophyllene: CB2 receptor agonist; links to black pepper, holy basil, ylang ylang.
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'beta-caryophyllene';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'major', 'CB2 receptor partial agonist; contributes anti-inflammatory activity independently of cannabinoid pathways.', 50)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('cannabigerolic acid (CBGA)', 'cannabinoid',
    'Central biosynthetic precursor ("mother cannabinoid") from which the THCA, CBDA, and CBCA branches are derived.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate', NULL, 60)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('cannabichromenic acid (CBCA)', 'cannabinoid',
    'Characteristic acidic phytocannabinoid representing the CBC branch of cannabinoid biosynthesis; present in most Cannabis chemotypes.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate', NULL, 70)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Linalool: links to lavender, cardamom, lemon balm, thyme, and 13 other corpus herbs.
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'linalool';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate', NULL, 80)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Alpha-pinene: links to rosemary, juniper, chasteberry, wild carrot.
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'alpha-pinene';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'minor', NULL, 90)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Cannabis (id 2601) herb_constituents: done.';
END $$;

-- ── 2603 Ignatia (Strychnos ignatii, Seed) ───────────────────────────────────
-- Strychnos alkaloids dominate; no broadly-shared corpus connections.

DO $$
DECLARE
  v_herb CONSTANT INTEGER := 2603;
  v_c INTEGER;
BEGIN
  v_c := herbal.ensure_constituent('strychnine', 'Strychnos indole alkaloid',
    'Dominant highly toxic indole alkaloid of Strychnos species; potent competitive antagonist at glycine receptors producing characteristic CNS excitation and convulsions.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary', 'Marker. Dominant highly toxic alkaloid and potent glycine-receptor antagonist responsible for characteristic CNS excitation.', 0)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('brucine', 'Strychnos indole alkaloid',
    'Major toxic indole alkaloid closely related to strychnine found in Strychnos species; contributes to characteristic pharmacological and toxicological activity.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'major', NULL, 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('α-colubrine', 'Strychnos indole alkaloid',
    'Characteristic minor Strychnos alkaloid structurally related to strychnine; found in Strychnos ignatii and S. nux-vomica seeds.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate', NULL, 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('icajine', 'Strychnos indole alkaloid',
    'Characteristic structurally related alkaloid reported from Strychnos ignatii seed; contributes to the species-specific seed alkaloid profile.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate', NULL, 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('vomicine', 'Strychnos indole alkaloid',
    'Minor Strychnos alkaloid found in Strychnos ignatii and S. nux-vomica; structural variant within the strychnine alkaloid family.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'minor', NULL, 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Ignatia (id 2603) herb_constituents: done.';
END $$;

-- ── 2604 Nux Vomica (Strychnos nux-vomica, Seed) ─────────────────────────────
-- Strychnos alkaloids dominate; loganin links to bogbean and Japanese honeysuckle.

DO $$
DECLARE
  v_herb CONSTANT INTEGER := 2604;
  v_c INTEGER;
BEGIN
  v_c := herbal.ensure_constituent('strychnine', 'Strychnos indole alkaloid',
    'Dominant highly toxic indole alkaloid of Strychnos species; potent competitive antagonist at glycine receptors producing characteristic CNS excitation and convulsions.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary', 'Marker. Principal highly toxic CNS-stimulant alkaloid acting primarily through glycine-receptor antagonism.', 0)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('brucine', 'Strychnos indole alkaloid',
    'Major toxic indole alkaloid closely related to strychnine found in Strychnos species; contributes to characteristic pharmacological and toxicological activity.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary', 'Marker. Major structurally related alkaloid contributing pharmacological activity and toxicity.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('vomicine', 'Strychnos indole alkaloid',
    'Minor Strychnos alkaloid found in Strychnos ignatii and S. nux-vomica; structural variant within the strychnine alkaloid family.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate', NULL, 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('α-colubrine', 'Strychnos indole alkaloid',
    'Characteristic minor Strychnos alkaloid structurally related to strychnine; found in Strychnos ignatii and S. nux-vomica seeds.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate', NULL, 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('loganic acid', 'iridoid glycoside',
    'Iridoid glycoside of Strychnos nux-vomica seed; used analytically alongside strychnine and brucine for pharmacognostical characterization.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate', NULL, 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Loganin: links to bogbean and Japanese honeysuckle in the corpus.
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'loganin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'minor', NULL, 50)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Nux Vomica (id 2604) herb_constituents: done.';
END $$;

-- ── 2605 Podophyllum (Podophyllum peltatum, Root) ────────────────────────────
-- Aryltetralin lignans define the herb; quercetin and kaempferol are documented
-- in the rhizome and link to 53–101 corpus herbs respectively.

DO $$
DECLARE
  v_herb CONSTANT INTEGER := 2605;
  v_c INTEGER;
BEGIN
  v_c := herbal.ensure_constituent('α-peltatin', 'aryltetralin lignan',
    'Characteristic cytotoxic aryltetralin lignan of Podophyllum peltatum rhizome; major component of American podophyllum resin, particularly abundant during plant dormancy.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary', 'Marker. Characteristic cytotoxic lignan and major component of American podophyllum rhizome during dormancy.', 0)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('β-peltatin', 'aryltetralin lignan',
    'Major characteristic cytotoxic aryltetralin lignan contributing to the strongly cytotoxic resin chemistry of Podophyllum peltatum.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary', 'Marker. Major characteristic aryltetralin lignan contributing to the strongly cytotoxic resin chemistry.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('podophyllotoxin', 'aryltetralin lignan',
    'Potent antimitotic aryltetralin lignan of Podophyllum species; pharmacologically important precursor for semisynthetic anticancer drugs etoposide and teniposide.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary', 'Marker. Potent antimitotic lignan and pharmacologically important precursor for semisynthetic anticancer drugs.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('desoxypodophyllotoxin', 'aryltetralin lignan',
    'Biosynthetically related aryltetralin lignan precursor within the podophyllotoxin pathway; found in Podophyllum and related species.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate', NULL, 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Quercetin and kaempferol: documented in Podophyllum rhizome; link to 101 and 53
  -- corpus herbs respectively.
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'quercetin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate', NULL, 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'kaempferol';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'minor', NULL, 50)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Podophyllum (id 2605) herb_constituents: done.';
END $$;

-- ── 2606 Poison Ivy (Toxicodendron radicans, Leaf) ───────────────────────────
-- Urushiol catechols dominate; no broadly-shared corpus connections.

DO $$
DECLARE
  v_herb CONSTANT INTEGER := 2606;
  v_c INTEGER;
BEGIN
  SELECT id INTO v_c FROM herbal.constituents WHERE name = '3-pentadecenylcatechol (15:1)';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary', 'Marker. Unsaturated C15 catechol contributing strongly to the characteristic allergenic fraction.', 0)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = '3-pentadecadienylcatechol (15:2)';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary', 'Marker. Polyunsaturated urushiol congener associated with potent contact sensitization.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = '3-pentadecatrienylcatechol (15:3)';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary', 'Marker. Highly unsaturated urushiol congener central to the characteristic allergenic chemistry.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = '3-pentadecylcatechol (15:0)';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate', NULL, 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Poison Ivy (id 2606) herb_constituents: done.';
END $$;

-- ── 2607 Spearmint (Mentha spicata, Aerial parts) ────────────────────────────
-- Carvone-dominated volatile fraction plus strong rosmarinic-acid phenolic fraction.
-- Beta-caryophyllene: documented minor sesquiterpene in Mentha spicata; links to
-- black pepper, holy basil, ylang ylang.

DO $$
DECLARE
  v_herb CONSTANT INTEGER := 2607;
  v_c INTEGER;
BEGIN
  SELECT id INTO v_c FROM herbal.constituents WHERE name = '(R)-carvone';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary', 'Marker. Principal characteristic volatile of classic spearmint chemotypes responsible for its distinctive aroma and much of its antimicrobial activity.', 0)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'limonene';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'major', NULL, 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'rosmarinic acid';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'major', NULL, 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = '1,8-cineole';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate', NULL, 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'beta-caryophyllene';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'minor', NULL, 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Spearmint (id 2607) herb_constituents: done.';
END $$;

-- ── 2608 Veratrum (Veratrum viride, Root) ────────────────────────────────────
-- Steroidal alkaloid complex dominates; no broadly-shared corpus connections.

DO $$
DECLARE
  v_herb CONSTANT INTEGER := 2608;
  v_c INTEGER;
BEGIN
  v_c := herbal.ensure_constituent('jervine', 'steroidal alkaloid',
    'Characteristic steroidal alkaloid of Veratrum species; potent teratogen in ruminants and hedgehog-pathway inhibitor; contributes to profound toxicological effects of the genus.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary', 'Marker. Characteristic Veratrum alkaloid contributing to the profound toxicological and developmental effects of the genus.', 0)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('veratramine', 'steroidal alkaloid',
    'Characteristic steroidal alkaloid of Veratrum species contributing cardiovascular and neurotoxic activity.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'major', NULL, 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('protoveratrine A', 'steroidal alkaloid',
    'Potent esterified steroidal alkaloid of Veratrum species; historically investigated as an antihypertensive; associated with severe hypotensive and cardiotoxic effects.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'major', NULL, 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('veratridine', 'steroidal alkaloid',
    'Sodium-channel-active steroidal alkaloid of Veratrum species; binds voltage-gated sodium channels and contributes to characteristic neurotoxicity.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate', NULL, 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('cevadine', 'steroidal alkaloid',
    'Related ester steroidal alkaloid contributing to the broader Veratrum toxicological alkaloid profile.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate', NULL, 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Veratrum (id 2608) herb_constituents: done.';
END $$;

-- ── 2609 Yellow Parilla (Menispermum canadense, Root) ────────────────────────
-- Isoquinoline alkaloid complex; no broadly-shared corpus connections beyond
-- magnoflorine (aporphine alkaloid, currently unique to this herb in the DB —
-- worth future cross-linking if goldenseal/barberry herb_constituents are updated).

DO $$
DECLARE
  v_herb CONSTANT INTEGER := 2609;
  v_c INTEGER;
BEGIN
  v_c := herbal.ensure_constituent('dauricine', 'bisbenzylisoquinoline alkaloid',
    'Prominent bisbenzylisoquinoline alkaloid and one of the most characteristic constituents of Menispermum canadense root.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary', 'Marker. Prominent bisbenzylisoquinoline alkaloid and one of the most characteristic constituents of Canadian moonseed root.', 0)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('acutumine', 'hasubanan alkaloid',
    'Structurally distinctive hasubanan-type alkaloid and characteristic constituent of Menispermum canadense root.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary', 'Marker. Structurally distinctive alkaloid contributing strongly to the species-specific root profile.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('acutumidine', 'hasubanan alkaloid',
    'Closely related hasubanan alkaloid complementing acutumine in Menispermum canadense root.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate', NULL, 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('daurinoline', 'bisbenzylisoquinoline alkaloid',
    'Bisbenzylisoquinoline alkaloid related to dauricine; reinforces the dauricine-type fraction in Menispermum canadense root.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate', NULL, 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('magnoflorine', 'aporphine alkaloid',
    'Quaternary aporphine alkaloid found in many Menispermaceae; represents a complementary structural family in the Menispermum canadense root alkaloid profile.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate', NULL, 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('N′-desmethyldauricine', 'bisbenzylisoquinoline alkaloid',
    'Dauricine-related bisbenzylisoquinoline alkaloid contributing specificity to the characteristic alkaloid profile of Menispermum canadense root.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate', NULL, 50)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Yellow Parilla (id 2609) herb_constituents: done.';
END $$;
