-- Migration 259: Herb constituents for 11 Scudder-source herbs (IDs 2598–2609, excl. 2602)
-- Herb IDs from migration 256. Also corrects plant_part for:
--   Aconite (2598): NULL → Root    Belladonna (2600): NULL → Leaf
--
-- Gravel Root (2602) is intentionally omitted — root-specific constituent evidence
-- was not strong enough for a verified species-and-part profile.
--
-- Concentration level mapping from user-provided importance/status:
--   High + Marker   → primary
--   High + Major    → major
--   Moderate + Major → moderate
--   Low–Moderate or Moderate + Present → minor

SET search_path TO herbal, public;

-- ── Plant-part corrections ────────────────────────────────────────────────────
-- Note: migration 257 resolved these herbs with plant_part IS NULL.
-- After this migration those lookups would need updating, but 257 already ran.

DO $$
DECLARE
  v_rows INTEGER;
BEGIN
  UPDATE herbal.herbs SET plant_part = 'Root' WHERE id = 2598 AND plant_part IS NULL;
  GET DIAGNOSTICS v_rows = ROW_COUNT;
  IF v_rows = 0 THEN
    RAISE EXCEPTION 'Aconite (id 2598) plant_part update failed — already set or row missing.';
  END IF;

  UPDATE herbal.herbs SET plant_part = 'Leaf' WHERE id = 2600 AND plant_part IS NULL;
  GET DIAGNOSTICS v_rows = ROW_COUNT;
  IF v_rows = 0 THEN
    RAISE EXCEPTION 'Belladonna (id 2600) plant_part update failed — already set or row missing.';
  END IF;

  RAISE NOTICE 'Plant-part corrections: Aconite (2598) → Root, Belladonna (2600) → Leaf.';
END $$;

-- ── 2598 Aconite (Aconitum napellus, Root) ───────────────────────────────────

DO $$
DECLARE
  v_herb CONSTANT INTEGER := 2598;
  v_c INTEGER;
BEGIN
  v_c := herbal.ensure_constituent('aconitine', 'diterpenoid alkaloid',
    'Principal C19 diterpenoid alkaloid of Aconitum napellus root; highly toxic sodium-channel activator responsible for characteristic cardiotoxic and neurotoxic effects.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary',
    'Marker. Principal highly toxic diterpenoid alkaloid responsible for much of aconite''s characteristic sodium-channel activity.', 0)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('mesaconitine', 'diterpenoid alkaloid',
    'Potent diester diterpenoid alkaloid of Aconitum species; contributes to characteristic neurotoxic and cardiotoxic activity alongside aconitine.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate',
    'Potent diester diterpenoid alkaloid contributing to the characteristic neurotoxic and cardiotoxic fraction.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('hypaconitine', 'diterpenoid alkaloid',
    'Related diester diterpenoid alkaloid of Aconitum species contributing to toxicity and pharmacological activity alongside aconitine and mesaconitine.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate',
    'Related diester diterpenoid alkaloid contributing to aconite toxicity and pharmacological activity.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('napelline', 'diterpenoid alkaloid',
    'Characteristic C19 diterpenoid alkaloid particularly associated with Aconitum napellus; contributes to the species-specific alkaloid profile.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate',
    'Characteristic Aconitum alkaloid particularly associated with A. napellus.', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Aconite (id 2598) constituents added.';
END $$;

-- ── 2599 Dogbane (Apocynum cannabinum, Root) ─────────────────────────────────

DO $$
DECLARE
  v_herb CONSTANT INTEGER := 2599;
  v_c INTEGER;
BEGIN
  v_c := herbal.ensure_constituent('cymarin', 'cardiac glycoside',
    'Principal cardenolide glycoside of Apocynum cannabinum root and rhizome; responsible for characteristic cardiotonic and toxic activity.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary',
    'Marker. Principal cardenolide glycoside responsible for the characteristic cardiotonic and toxic activity.', 0)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('apocannoside', 'cardiac glycoside',
    'Characteristic cardioactive glycoside of Apocynum cannabinum root and rhizome; reported alongside cymarin in pharmacognosy literature.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'major',
    'Characteristic cardioactive glycoside of the root and rhizome.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('cynocannoside', 'cardiac glycoside',
    'Species-associated cardiac glycoside of Apocynum cannabinum; complementary to the cymarin-dominated fraction.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate',
    'Species-associated cardiac glycoside complementing the cymarin-dominated fraction.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Dogbane (id 2599) constituents added.';
END $$;

-- ── 2600 Belladonna (Atropa belladonna, Leaf) ────────────────────────────────

DO $$
DECLARE
  v_herb CONSTANT INTEGER := 2600;
  v_c INTEGER;
BEGIN
  v_c := herbal.ensure_constituent('L-hyoscyamine', 'tropane alkaloid',
    'Principal naturally occurring tropane alkaloid of Atropa belladonna leaf; potent muscarinic-receptor antagonist. Atropine is its racemic form, arising during extraction rather than in the intact plant.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary',
    'Marker. Principal naturally occurring tropane alkaloid responsible for potent antimuscarinic activity.', 0)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('scopolamine', 'tropane alkaloid',
    'Characteristic epoxide-bearing tropane alkaloid found in Atropa and related Solanaceae; prominent central and peripheral antimuscarinic effects.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'major',
    'Characteristic antimuscarinic tropane alkaloid with prominent central and peripheral effects.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('anisodamine', 'tropane alkaloid',
    'Hydroxylated tropane alkaloid occurring within the hyoscyamine-to-scopolamine biosynthetic pathway in Atropa belladonna.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'minor',
    'Hydroxylated tropane alkaloid occurring within the hyoscyamine-to-scopolamine biosynthetic pathway.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Belladonna (id 2600) constituents added.';
END $$;

-- ── 2601 Cannabis (Cannabis sativa, Aerial parts) ────────────────────────────

DO $$
DECLARE
  v_herb CONSTANT INTEGER := 2601;
  v_c INTEGER;
BEGIN
  v_c := herbal.ensure_constituent('Δ9-tetrahydrocannabinolic acid (THCA)', 'cannabinoid',
    'Principal acidic phytocannabinoid precursor of psychoactive THC in THC-dominant Cannabis chemotypes; decarboxylates to THC on heating.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary',
    'Marker. Principal acidic cannabinoid precursor of psychoactive Δ9-THC in THC-dominant chemotypes.', 0)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('cannabidiolic acid (CBDA)', 'cannabinoid',
    'Principal acidic precursor of cannabidiol in CBD-dominant Cannabis chemotypes; decarboxylates to CBD.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary',
    'Marker. Principal acidic precursor of cannabidiol in CBD-dominant chemotypes.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('Δ9-tetrahydrocannabinol (THC)', 'cannabinoid',
    'Psychoactive cannabinoid formed principally by decarboxylation of THCA; acts via CB1 and CB2 receptors; primary driver of intoxicant effects.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary',
    'Marker. Psychoactive cannabinoid formed principally through decarboxylation of THCA.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('cannabidiol (CBD)', 'cannabinoid',
    'Major non-intoxicating phytocannabinoid with broad neuroactive, anti-inflammatory, and anticonvulsant pharmacology; formed by decarboxylation of CBDA.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary',
    'Marker. Major non-intoxicating cannabinoid with broad neuroactive and anti-inflammatory pharmacology.', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('cannabigerolic acid (CBGA)', 'cannabinoid',
    'Central biosynthetic precursor ("mother cannabinoid") from which the THCA, CBDA, and CBCA branches are derived.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate',
    'Central biosynthetic precursor from which several major cannabinoid families are formed.', 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('cannabichromenic acid (CBCA)', 'cannabinoid',
    'Characteristic acidic phytocannabinoid representing the CBC branch of cannabinoid biosynthesis; present in most Cannabis chemotypes.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate',
    'Characteristic acidic phytocannabinoid representing the CBC branch of cannabinoid biosynthesis.', 50)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Cannabis (id 2601) constituents added.';
END $$;

-- ── 2603 Ignatia (Strychnos ignatii, Seed) ───────────────────────────────────

DO $$
DECLARE
  v_herb CONSTANT INTEGER := 2603;
  v_c INTEGER;
BEGIN
  v_c := herbal.ensure_constituent('strychnine', 'Strychnos indole alkaloid',
    'Dominant highly toxic indole alkaloid of Strychnos species; potent competitive antagonist at glycine receptors producing characteristic CNS excitation and convulsions.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary',
    'Marker. Dominant highly toxic alkaloid and potent glycine-receptor antagonist responsible for characteristic CNS excitation.', 0)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('brucine', 'Strychnos indole alkaloid',
    'Major toxic indole alkaloid closely related to strychnine found in Strychnos species; contributes to characteristic pharmacological and toxicological activity.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'major',
    'Closely related toxic alkaloid accompanying strychnine in St. Ignatius bean.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('α-colubrine', 'Strychnos indole alkaloid',
    'Characteristic minor Strychnos alkaloid structurally related to strychnine; found in Strychnos ignatii and S. nux-vomica seeds.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate',
    'Characteristic minor Strychnos alkaloid complementing the dominant strychnine fraction.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('icajine', 'Strychnos indole alkaloid',
    'Characteristic structurally related alkaloid reported from Strychnos ignatii seed; contributes to the species-specific seed alkaloid profile.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate',
    'Characteristic structurally related alkaloid reported from St. Ignatius bean.', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('vomicine', 'Strychnos indole alkaloid',
    'Minor Strychnos alkaloid found in Strychnos ignatii and S. nux-vomica; structural variant within the strychnine alkaloid family.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'minor',
    'Minor Strychnos alkaloid contributing to the broader seed alkaloid profile.', 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Ignatia (id 2603) constituents added.';
END $$;

-- ── 2604 Nux Vomica (Strychnos nux-vomica, Seed) ─────────────────────────────
-- strychnine, brucine, α-colubrine, vomicine were ensure_constituent'd above;
-- ensure_constituent is idempotent so calling again just returns the existing ID.

DO $$
DECLARE
  v_herb CONSTANT INTEGER := 2604;
  v_c INTEGER;
BEGIN
  v_c := herbal.ensure_constituent('strychnine', 'Strychnos indole alkaloid',
    'Dominant highly toxic indole alkaloid of Strychnos species; potent competitive antagonist at glycine receptors producing characteristic CNS excitation and convulsions.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary',
    'Marker. Principal highly toxic CNS-stimulant alkaloid acting primarily through glycine-receptor antagonism.', 0)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('brucine', 'Strychnos indole alkaloid',
    'Major toxic indole alkaloid closely related to strychnine found in Strychnos species; contributes to characteristic pharmacological and toxicological activity.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary',
    'Marker. Major structurally related alkaloid contributing pharmacological activity and toxicity.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('vomicine', 'Strychnos indole alkaloid',
    'Minor Strychnos alkaloid found in Strychnos ignatii and S. nux-vomica; structural variant within the strychnine alkaloid family.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate',
    'Characteristic minor alkaloid contributing specificity to the Nux Vomica profile.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('α-colubrine', 'Strychnos indole alkaloid',
    'Characteristic minor Strychnos alkaloid structurally related to strychnine; found in Strychnos ignatii and S. nux-vomica seeds.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate',
    'Characteristic related seed alkaloid within the broader strychnine family.', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('loganic acid', 'iridoid glycoside',
    'Iridoid glycoside of Strychnos nux-vomica seed; used analytically alongside strychnine and brucine for pharmacognostical characterization.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate',
    'Important non-alkaloid constituent used analytically alongside strychnine and brucine for seed characterization.', 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('loganin', 'iridoid glycoside',
    'Iridoid glycoside biosynthetically related to the characteristic Strychnos alkaloid pathway; present in Strychnos nux-vomica seed.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'minor',
    'Iridoid glycoside related biosynthetically to the characteristic Strychnos alkaloid pathway.', 50)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Nux Vomica (id 2604) constituents added.';
END $$;

-- ── 2605 Podophyllum (Podophyllum peltatum, Root) ────────────────────────────

DO $$
DECLARE
  v_herb CONSTANT INTEGER := 2605;
  v_c INTEGER;
BEGIN
  v_c := herbal.ensure_constituent('α-peltatin', 'aryltetralin lignan',
    'Characteristic cytotoxic aryltetralin lignan of Podophyllum peltatum rhizome; major component of American podophyllum resin, particularly abundant during plant dormancy.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary',
    'Marker. Characteristic cytotoxic lignan and major component of American podophyllum rhizome during dormancy.', 0)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('β-peltatin', 'aryltetralin lignan',
    'Major characteristic cytotoxic aryltetralin lignan contributing to the strongly cytotoxic resin chemistry of Podophyllum peltatum.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary',
    'Marker. Major characteristic aryltetralin lignan contributing to the strongly cytotoxic resin chemistry.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('podophyllotoxin', 'aryltetralin lignan',
    'Potent antimitotic aryltetralin lignan of Podophyllum species; pharmacologically important precursor for semisynthetic anticancer drugs etoposide and teniposide.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary',
    'Marker. Potent antimitotic lignan and pharmacologically important precursor for semisynthetic anticancer drugs.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('desoxypodophyllotoxin', 'aryltetralin lignan',
    'Biosynthetically related aryltetralin lignan precursor within the podophyllotoxin pathway; found in Podophyllum and related species.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate',
    'Biosynthetically related lignan and precursor within the characteristic podophyllotoxin pathway.', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Podophyllum (id 2605) constituents added.';
END $$;

-- ── 2606 Poison Ivy (Toxicodendron radicans, Leaf) ───────────────────────────
-- Urushiol is a mixture; individual C15 alk(en)ylcatechols are entered separately.
-- Markers ordered by increasing unsaturation (15:1 → 15:3), then saturated 15:0.

DO $$
DECLARE
  v_herb CONSTANT INTEGER := 2606;
  v_c INTEGER;
BEGIN
  v_c := herbal.ensure_constituent('3-pentadecenylcatechol (15:1)', 'alkylcatechol',
    'Monounsaturated C15 alkylcatechol; principal component of the allergenic urushiol fraction in Toxicodendron radicans.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary',
    'Marker. Unsaturated C15 catechol contributing strongly to the characteristic allergenic fraction.', 0)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('3-pentadecadienylcatechol (15:2)', 'alkylcatechol',
    'Diunsaturated C15 catechol; urushiol congener associated with potent T-cell-mediated contact sensitization in Toxicodendron radicans.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary',
    'Marker. Polyunsaturated urushiol congener associated with potent contact sensitization.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('3-pentadecatrienylcatechol (15:3)', 'alkylcatechol',
    'Highly unsaturated C15 catechol; urushiol congener central to the characteristic allergenic chemistry of Toxicodendron radicans.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary',
    'Marker. Highly unsaturated urushiol congener central to the characteristic allergenic chemistry.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('3-pentadecylcatechol (15:0)', 'alkylcatechol',
    'Saturated C15 catechol member of the urushiol-related phenolic-lipid fraction in Toxicodendron species.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate',
    'Saturated C15 catechol member of the urushiol-related phenolic-lipid fraction.', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Poison Ivy (id 2606) constituents added.';
END $$;

-- ── 2607 Spearmint (Mentha spicata, Aerial parts) ────────────────────────────

DO $$
DECLARE
  v_herb CONSTANT INTEGER := 2607;
  v_c INTEGER;
BEGIN
  v_c := herbal.ensure_constituent('(R)-carvone', 'monoterpenoid',
    'Principal volatile monoterpenoid of classic spearmint chemotypes; R-enantiomer characteristic of Mentha spicata; responsible for distinctive spearmint aroma and antimicrobial activity.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary',
    'Marker. Principal characteristic volatile of classic spearmint chemotypes responsible for its distinctive aroma and much of its antimicrobial activity.', 0)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('limonene', 'monoterpenoid',
    'Common monoterpene hydrocarbon found in many aromatic plants; abundant secondary volatile in Mentha spicata aerial parts.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'major',
    'Major monoterpene accompanying carvone and contributing to the characteristic volatile profile.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('rosmarinic acid', 'depside',
    'Ester of caffeic acid and 3,4-dihydroxyphenyllactic acid; principal representative of the rosmarinic-acid-derived phenolic fraction abundant across Lamiaceae.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'major',
    'Principal representative of the abundant nonvolatile rosmarinic-acid-derived phenolic fraction.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('1,8-cineole', 'monoterpenoid',
    'Common monoterpenoid ether found across Lamiaceae and Myrtaceae; variable secondary volatile in spearmint chemotypes.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate',
    'Common secondary volatile whose abundance varies substantially among chemotypes.', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Spearmint (id 2607) constituents added.';
END $$;

-- ── 2608 Veratrum (Veratrum viride, Root) ────────────────────────────────────

DO $$
DECLARE
  v_herb CONSTANT INTEGER := 2608;
  v_c INTEGER;
BEGIN
  v_c := herbal.ensure_constituent('jervine', 'steroidal alkaloid',
    'Characteristic steroidal alkaloid of Veratrum species; potent teratogen in ruminants and hedgehog-pathway inhibitor; contributes to profound toxicological effects of the genus.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary',
    'Marker. Characteristic Veratrum alkaloid contributing to the profound toxicological and developmental effects of the genus.', 0)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('veratramine', 'steroidal alkaloid',
    'Characteristic steroidal alkaloid of Veratrum species contributing cardiovascular and neurotoxic activity.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'major',
    'Characteristic steroidal alkaloid contributing cardiovascular and neurotoxic activity.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('protoveratrine A', 'steroidal alkaloid',
    'Potent esterified steroidal alkaloid of Veratrum species; historically investigated as an antihypertensive; associated with severe hypotensive and cardiotoxic effects.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'major',
    'Potent esterified steroidal alkaloid associated with severe hypotensive and cardiotoxic effects.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('veratridine', 'steroidal alkaloid',
    'Sodium-channel-active steroidal alkaloid of Veratrum species; binds voltage-gated sodium channels and contributes to characteristic neurotoxicity.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate',
    'Sodium-channel-active steroidal alkaloid contributing characteristic neurotoxicity.', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('cevadine', 'steroidal alkaloid',
    'Related ester steroidal alkaloid contributing to the broader Veratrum toxicological alkaloid profile.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate',
    'Related ester alkaloid contributing to the broader Veratrum toxicological profile.', 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Veratrum (id 2608) constituents added.';
END $$;

-- ── 2609 Yellow Parilla (Menispermum canadense, Root) ────────────────────────

DO $$
DECLARE
  v_herb CONSTANT INTEGER := 2609;
  v_c INTEGER;
BEGIN
  v_c := herbal.ensure_constituent('dauricine', 'bisbenzylisoquinoline alkaloid',
    'Prominent bisbenzylisoquinoline alkaloid and one of the most characteristic constituents of Menispermum canadense root.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary',
    'Marker. Prominent bisbenzylisoquinoline alkaloid and one of the most characteristic constituents of Canadian moonseed root.', 0)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('acutumine', 'hasubanan alkaloid',
    'Structurally distinctive hasubanan-type alkaloid and characteristic constituent of Menispermum canadense root.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'primary',
    'Marker. Structurally distinctive alkaloid contributing strongly to the species-specific root profile.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('acutumidine', 'hasubanan alkaloid',
    'Closely related hasubanan alkaloid complementing acutumine in Menispermum canadense root.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate',
    'Closely related characteristic alkaloid complementing acutumine.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('daurinoline', 'bisbenzylisoquinoline alkaloid',
    'Bisbenzylisoquinoline alkaloid related to dauricine; reinforces the dauricine-type fraction in Menispermum canadense root.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate',
    'Related bisbenzylisoquinoline alkaloid reinforcing the dauricine-type fraction.', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('magnoflorine', 'aporphine alkaloid',
    'Quaternary aporphine alkaloid found in many Menispermaceae; represents a complementary structural family in the Menispermum canadense root alkaloid profile.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate',
    'Quaternary aporphine alkaloid representing a complementary structural family in the root.', 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('N′-desmethyldauricine', 'bisbenzylisoquinoline alkaloid',
    'Dauricine-related bisbenzylisoquinoline alkaloid contributing specificity to the characteristic alkaloid profile of Menispermum canadense root.');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb, v_c, 'moderate',
    'Dauricine-related alkaloid contributing specificity to the characteristic root alkaloid profile.', 50)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Yellow Parilla (id 2609) constituents added.';
END $$;

-- ── Summary ───────────────────────────────────────────────────────────────────
-- 11 herbs profiled; 38 constituents total (new subclasses: diterpenoid alkaloid,
-- tropane alkaloid, cannabinoid, Strychnos indole alkaloid, aryltetralin lignan,
-- alkylcatechol, steroidal alkaloid, bisbenzylisoquinoline alkaloid, hasubanan
-- alkaloid, aporphine alkaloid). Gravel Root (2602) held pending stronger
-- root-specific evidence.
