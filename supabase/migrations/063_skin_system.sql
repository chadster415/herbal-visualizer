-- Migration 063: Skin System
-- Body system: Skin
-- System notes, alteratives, topical herbs, 3 disorders (Eczema, Psoriasis, Acne)
-- with notes, actions indicated, specific remedies, and prescriptions.
--
-- Note: Source "Actions Supplied" sections included herbs mentioned only in
-- dosage instructions (Urtica dioica infusion, Allium sativum as dietary
-- supplement) rather than the tincture formula. Only formula herbs are entered
-- in prescription_herb_actions. MD has been corrected to match.

SET search_path TO herbal, public;


-- ============================================================
-- BLOCK 0: Ensure Skin body system exists
-- ============================================================
DO $$
BEGIN
  INSERT INTO herbal.body_systems (name)
    VALUES ('Skin')
    ON CONFLICT (name) DO NOTHING;
END $$;


-- ============================================================
-- BLOCK 1: Body System Notes (13 notes from # Notes section)
-- ============================================================
DO $$
DECLARE v_id INTEGER;
BEGIN
  SELECT id INTO v_id FROM herbal.body_systems WHERE name = 'Skin';
  INSERT INTO herbal.body_system_notes (body_system_id, note_text, sort_order) VALUES
    (v_id, 'The five sensations that arise from stimulation of skin nerves are touch, pain, heat, cold, and pressure.', 10),
    (v_id, 'In hairy skin, the nerve endings are simple, threadlike, naked terminals. In skin that is not hairy, there are several types of specialized nerve endings. Although they look the same, each nerve ending is capable of responding to only one of the five basic types of sensation.', 20),
    (v_id, 'Effective phytotherapeutic treatment of skin disease must be mediated through internal medication, not topical application.', 30),
    (v_id, 'Internal treatment of skin problems will often be relevant, but it may be appropriate to also apply herb externally for local effects.', 40),
    (v_id, 'Stellaria media (chickweed) is an extremely effective topical remedy for the relief of itching.', 50),
    (v_id, 'Baths, also known as balneotherapy, represent one of the most pleasant ways to apply medications to the skin.', 60),
    (v_id, 'Fomentations and Compresses — These methods facilitate the local application of liquid formulations. Infusions, decoctions, tinctures, and oils can all be applied in this way.', 70),
    (v_id, 'Poultices are similar to fomentations and compresses but instead incorporate the herb in some solid form.', 80),
    (v_id, 'Lotions are liquid formulations for carrying the herbs. They will usually have a cooling effect due to evaporation. They rarely need to be washed off, as part will be absorbed and the rest will evaporate.', 90),
    (v_id, 'Creams are suspensions of oil in water, and can be formulated to be either greasy or nongreasy. They are primarily emollient and protective. An advantage of creams is that they do not insulate the skin too much and thus will not cause a localized increase in skin temperature. Overheating can aggravate itching in many skin problems.', 100),
    (v_id, 'An ointment is a semisolid, lipid-based application. Like creams, ointments and salves are emollient and protective, but they remain on the skin longer. This tenacity will confer a local warming effect.', 110),
    (v_id, 'A paste is a mixture of powder in an ointment base. Pastes are indicated when the goal is to keep the effects of the herbs on the surface for extended periods of time. Their contents are not absorbed well, but do impact the skin surface. They are useful in conditions such as psoriasis, in which they facilitate the removal of scales.', 120),
    (v_id, 'Powders are dry, finely powdered herbs or minerals. Their primary benefit is that they take up moisture — for example, perspiration or exudates of eczema. They can also be antipruritic and antimicrobial. Examples include colloidal oatmeal, Lycopodium powder, and cornstarch.', 130)
  ON CONFLICT (body_system_id, sort_order) DO NOTHING;
  RAISE NOTICE 'Skin system notes inserted.';
END $$;


-- ============================================================
-- BLOCK 2: Alteratives for the Skin System (# Alteratives)
-- ============================================================
DO $$
DECLARE
  v_sys_id    INTEGER;
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Skin';

  v_action_id := herbal.ensure_action('Alterative');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Galium aparine',    'cleavers'),     v_action_id, v_sys_id),
    (herbal.ensure_herb('Trifolium pratense','red clover'),   v_action_id, v_sys_id),
    (herbal.ensure_herb('Urtica dioica',     'nettle'),       v_action_id, v_sys_id),
    (herbal.ensure_herb('Arctium lappa',     'burdock'),      v_action_id, v_sys_id),
    (herbal.ensure_herb('Mahonia aquifolium','Oregon grape'), v_action_id, v_sys_id),
    (herbal.ensure_herb('Rumex crispus',     'yellow dock'),  v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Skin alteratives inserted.';
END $$;


-- ============================================================
-- BLOCK 3: Herbs and Actions for Topical Use
-- ============================================================
DO $$
DECLARE
  v_sys_id    INTEGER;
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Skin';

  -- Antipruritic
  v_action_id := herbal.ensure_action('Antipruritic');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Calendula officinalis',   'calendula'),      v_action_id, v_sys_id),
    (herbal.ensure_herb('Hamamelis virginiana',    'witch hazel'),    v_action_id, v_sys_id),
    (herbal.ensure_herb('Hypericum perforatum',   'St. John''s wort'),v_action_id, v_sys_id),
    (herbal.ensure_herb('Stellaria media',         'chickweed'),      v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  -- Anti-inflammatory (topical)
  v_action_id := herbal.ensure_action('Anti-inflammatory');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Calendula officinalis', 'calendula'),       v_action_id, v_sys_id),
    (herbal.ensure_herb('Hypericum perforatum',  'St. John''s wort'),v_action_id, v_sys_id),
    (herbal.ensure_herb('Matricaria recutita',   'chamomile'),       v_action_id, v_sys_id),
    (herbal.ensure_herb('Plantago spp.',         'plantain'),        v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  -- Emollient (topical)
  v_action_id := herbal.ensure_action('Emollient');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Althaea officinalis',  'marshmallow'), v_action_id, v_sys_id),
    (herbal.ensure_herb('Malva sylvestris',     'mallow'),      v_action_id, v_sys_id),
    (herbal.ensure_herb('Symphytum officinale', 'comfrey'),     v_action_id, v_sys_id),
    (herbal.ensure_herb('Ulmus rubra',          'slippery elm'),v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  -- Astringent (topical)
  v_action_id := herbal.ensure_action('Astringent');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Achillea millefolium', 'yarrow'),     v_action_id, v_sys_id),
    (herbal.ensure_herb('Geranium maculatum',  'cranesbill'),  v_action_id, v_sys_id),
    (herbal.ensure_herb('Hamamelis virginiana','witch hazel'),  v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  -- Vulnerary (topical)
  v_action_id := herbal.ensure_action('Vulnerary');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Symphytum officinale', 'comfrey'), v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  -- Antimicrobial (topical)
  v_action_id := herbal.ensure_action('Antimicrobial');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Allium sativum',         'garlic'),    v_action_id, v_sys_id),
    (herbal.ensure_herb('Commiphora molmol',      'myrrh'),     v_action_id, v_sys_id),
    (herbal.ensure_herb('Hydrastis canadensis',   'goldenseal'),v_action_id, v_sys_id),
    (herbal.ensure_herb('Thymus vulgaris',        'thyme'),     v_action_id, v_sys_id),
    (herbal.ensure_herb('Eucalyptus globulus',    'eucalyptus'),v_action_id, v_sys_id),
    (herbal.ensure_herb('Melaleuca alternifolia', 'tea tree'),  v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Skin topical action herbs inserted.';
END $$;


-- ============================================================
-- BLOCK 4: Disorder — Eczema
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
  v_herb_id     INTEGER;
  v_ph_id       INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Skin';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Eczema', v_sys_id, 10)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Eczema' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'The terms eczema and dermatitis are the cause of much confusion. We use these terms synonymously to indicate superficial inflammation of the skin.', 10),
    (v_disorder_id, 'For the phytotherapist, however, the most important distinction is between cases with an internal or endogenous cause and those with a contact or exogenous cause.', 20),
    (v_disorder_id, 'A number of factors can aggravate eczema, although the specifics vary from person to person. Dietary factors are particularly important, especially in children. Milk and milk products are the most common triggers. Primary aggravating factors for eczema are: Stress, Mechanical irritation, Heat, Dietary.', 30)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Alterative'),
      'are the classic remedies for the treatment of eczema. How they work is unclear, but they can often be dramatically effective.', 10),
    (v_disorder_id, herbal.ensure_action('Antipruritic'),
      'remedies that reduce the sensation of itching, are indicated, not simply to make the patient feel better, but also to reduce physical trauma caused by scratching.', 20),
    (v_disorder_id, herbal.ensure_action('Anti-inflammatory'),
      'applied topically and taken internally speed the curative work of the alteratives, but do not replace them.', 30),
    (v_disorder_id, herbal.ensure_action('Lymphatic tonic'),
      'which may be considered a type of alterative, are especially helpful for eczema in children.', 40),
    (v_disorder_id, herbal.ensure_action('Nervine relaxant'),
      'help with the commonly associated problem of anxiety. They also often ease itching and even inflammation in the skin because of their relaxing effect on the peripheral nerves of the autonomic nervous system.', 50),
    (v_disorder_id, herbal.ensure_action('Diuretic'),
      'ensure adequate elimination through the kidneys. Diuretic alteratives are most relevant.', 60),
    (v_disorder_id, herbal.ensure_action('Hepatic'),
      'will contribute support for liver function and the digestive process. Hepatic alteratives are best here.', 70),
    (v_disorder_id, herbal.ensure_action('Vulnerary'),
      'support the healing of skin lesions when applied topically, but do not replace appropriate internal treatment.', 80),
    (v_disorder_id, herbal.ensure_action('Astringent'),
      'used topically, reduce any weeping or oozing of fluids.', 90),
    (v_disorder_id, herbal.ensure_action('Emollient'),
      'suitable for topical applications where soothing is needed. The demarcation among emollient, anti-inflammatory, and antipruritic herbs is rather meaningless here.', 100)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Fumaria officinalis', 'fumitory'),
      'For internal treatment, the leafy alteratives are often considered the closest to specifics for this often intransigent condition. These are also often diuretic and lymphatic remedies.', 10),
    (v_disorder_id, herbal.ensure_herb('Galium aparine', 'cleavers'),
      'For internal treatment, the leafy alteratives are often considered the closest to specifics for this often intransigent condition. These are also often diuretic and lymphatic remedies.', 20),
    (v_disorder_id, herbal.ensure_herb('Scrophularia nodosa', 'figwort'),
      'For internal treatment, the leafy alteratives are often considered the closest to specifics for this often intransigent condition. These are also often diuretic and lymphatic remedies.', 30),
    (v_disorder_id, herbal.ensure_herb('Trifolium pratense', 'red clover'),
      'For internal treatment, the leafy alteratives are often considered the closest to specifics for this often intransigent condition. These are also often diuretic and lymphatic remedies.', 40),
    (v_disorder_id, herbal.ensure_herb('Urtica dioica', 'nettle'),
      'For internal treatment, the leafy alteratives are often considered the closest to specifics for this often intransigent condition. These are also often diuretic and lymphatic remedies.', 50),
    (v_disorder_id, herbal.ensure_herb('Viola tricolor', 'heartsease'),
      'For internal treatment, the leafy alteratives are often considered the closest to specifics for this often intransigent condition. These are also often diuretic and lymphatic remedies.', 60),
    (v_disorder_id, herbal.ensure_herb('Arctium lappa', 'burdock'),
      'The rooty alteratives tend to be hepatic in nature. They can often be too strong for eczema, aggravating the problem instead of healing it. For intransigent cases unresponsive to the herbs already listed, stronger remedies are indicated.', 70),
    (v_disorder_id, herbal.ensure_herb('Hydrastis canadensis', 'goldenseal'),
      'The rooty alteratives tend to be hepatic in nature. They can often be too strong for eczema, aggravating the problem instead of healing it. For intransigent cases unresponsive to the herbs already listed, stronger remedies are indicated.', 80),
    (v_disorder_id, herbal.ensure_herb('Mahonia aquifolium', 'Oregon grape'),
      'The rooty alteratives tend to be hepatic in nature. They can often be too strong for eczema, aggravating the problem instead of healing it. For intransigent cases unresponsive to the herbs already listed, stronger remedies are indicated.', 90),
    (v_disorder_id, herbal.ensure_herb('Calendula officinalis', 'calendula'),
      'Relevant herbs for topical use abound. Always bear in mind that healing must be based upon internal medication, not salves. Select remedies according to the actions most appropriate for the individual''s specific symptoms.', 100),
    (v_disorder_id, herbal.ensure_herb('Plantago spp.', 'plantain'),
      'Relevant herbs for topical use abound. Select remedies according to the actions most appropriate for the individual''s specific symptoms.', 110),
    (v_disorder_id, herbal.ensure_herb('Stellaria media', 'chickweed'),
      'Relevant herbs for topical use abound. Select remedies according to the actions most appropriate for the individual''s specific symptoms.', 120)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription 1: Basic Eczema
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Eczema',
      'Up to 5 ml of tincture three times a day. In addition, the patient should drink an infusion of fresh Urtica dioica or Galium aparine two or three times a day.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Galium aparine', 'cleavers');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative'))       ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Lymphatic tonic'))  ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory'))ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))         ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hepatic'))          ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Urtica dioica', 'nettle');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative'))      ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Lymphatic tonic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))        ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Trifolium pratense', 'red clover');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative'))      ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant'))ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hepatic'))         ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 2: Persistent Eczema
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Persistent Eczema Unresponsive to Mild Alteratives',
      '2.5 ml of tincture three times a day; build up to 5 ml three times a day. In addition, the patient should drink an infusion of fresh or dried Urtica dioica two or three times a day. Care should be taken initially with Scrophularia nodosa, as it can produce the opposite of the desired result in some patients. If there is a flare-up of the skin eruption, cut down on the Scrophularia and try again. This is not a healing crisis!',
      20)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Galium aparine', 'cleavers');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative'))       ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Lymphatic tonic'))  ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory'))ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))         ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hepatic'))          ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Arctium lappa', 'burdock');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative'))ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))  ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hepatic'))   ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Scrophularia nodosa', 'figwort');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative')) ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 3: Atopic Eczema with Asthma
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Atopic Eczema Associated with Asthma',
      'Add 1 part Dyspnea Formula as well. Up to 5 ml of tincture three times a day. The relative proportion of alterative herbs to Dyspnea Formula will depend upon the patient''s specific needs. In addition, the patient should drink an infusion of fresh Urtica dioica or Galium aparine two or three times a day.',
      30)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Urtica dioica',     'nettle'),    '2 parts', 10),
      (v_rx_id, herbal.ensure_herb('Trifolium pratense','red clover'),'2 parts', 20);
  END IF;

  RAISE NOTICE 'Skin: Eczema disorder inserted.';
END $$;


-- ============================================================
-- BLOCK 5: Disorder — Psoriasis
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
  v_herb_id     INTEGER;
  v_ph_id       INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Skin';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Psoriasis', v_sys_id, 20)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Psoriasis' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Psoriasis usually develops slowly, following a typical course of remission and recurrence. The characteristic psoriatic plaques, or lesions, are sharply demarcated, red and raised, covered with silvery scales, and bleed easily. These plaques do not usually itch, and will heal without leaving scar tissue or affecting hair growth. The nails may become pitted.', 10),
    (v_disorder_id, 'Common sites for psoriasis are: bony protuberances (knees, elbows, sacrum), scalp, external parts of ears, nails and eyebrows, back and buttocks, and skin folds such as the umbilicus.', 20),
    (v_disorder_id, 'In normal skin, it takes about 28 days for an epidermal cell to go from creation to shedding or scaling. Psoriatic cells complete this process in three or four days, or almost nine times faster than usual.', 30),
    (v_disorder_id, 'Much of psoriasis therapy is directed toward removing these plaques in a non-traumatic fashion and to easing any attendant discomfort.', 40),
    (v_disorder_id, 'The underlying cause of the rapid epithelial cell turnover characteristic of psoriasis is not known.', 50),
    (v_disorder_id, 'Flare-ups commonly accompany infections, especially infections of the upper respiratory tract.', 60),
    (v_disorder_id, 'In short, psoriasis represents a classic example of a condition for which a holistic perspective is essential.', 70),
    (v_disorder_id, 'There are probably no true specifics. This is to be expected in light of the multifactorial, systemic nature of psoriasis.', 80)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Alterative'),
      'are important, as they are for all internally generated skin problems. In practice, the rooty hepatic alteratives often are the best choice.', 10),
    (v_disorder_id, herbal.ensure_action('Anti-inflammatory'),
      'applied topically and taken internally, will speed the curative work of the alteratives, but not replace them. They are most helpful during flare-ups and exacerbations.', 20),
    (v_disorder_id, herbal.ensure_action('Lymphatic tonic'),
      'improve the health of the internal environment.', 30),
    (v_disorder_id, herbal.ensure_action('Nervine relaxant'),
      'ease the anxiety that often accompanies psoriasis. They will also soothe skin discomfort, including itching and even inflammation, due to their relaxing effects on the peripheral nerves of the autonomic nervous system.', 40),
    (v_disorder_id, herbal.ensure_action('Diuretic'),
      'ensure adequate elimination via the kidneys.', 50),
    (v_disorder_id, herbal.ensure_action('Hepatic'),
      'support liver function and the digestive process.', 60),
    (v_disorder_id, herbal.ensure_action('Vulnerary'),
      'support the healing of skin lesions when applied topically, but are not as effective here as one might hope. Remember, there is no wound to heal.', 70),
    (v_disorder_id, herbal.ensure_action('Astringent'),
      'used topically, may help in reducing redness, heat, and itching through local vasoconstrictor effects.', 80),
    (v_disorder_id, herbal.ensure_action('Emollient'),
      'assist in the process of scale removal.', 90),
    (v_disorder_id, herbal.ensure_action('Antipruritic'),
      'used topically may help, but itching is not a major factor in psoriasis.', 100),
    (v_disorder_id, herbal.ensure_action('Diaphoretic'),
      'have been suggested as a means of increasing circulation in the skin, thus promoting elimination and, in theory, general skin health. Diaphoretics may also aggravate psoriasis in some people.', 110)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Arctium lappa',      'burdock'),      'The woody, hepatic alteratives are the herbs that come closest to being specifics for psoriasis.', 10),
    (v_disorder_id, herbal.ensure_herb('Mahonia aquifolium', 'Oregon grape'), 'The woody, hepatic alteratives are the herbs that come closest to being specifics for psoriasis.', 20),
    (v_disorder_id, herbal.ensure_herb('Rumex crispus',      'yellow dock'),  'The woody, hepatic alteratives are the herbs that come closest to being specifics for psoriasis.', 30),
    (v_disorder_id, herbal.ensure_herb('Smilax spp.',        'sarsaparilla'), 'The woody, hepatic alteratives are the herbs that come closest to being specifics for psoriasis.', 40),
    (v_disorder_id, herbal.ensure_herb('Galium aparine',     'cleavers'),     'Any of the other alteratives may prove to be specific for a given individual.', 50),
    (v_disorder_id, herbal.ensure_herb('Larrea tridentata',  'chaparral'),    'Any of the other alteratives may prove to be specific for a given individual.', 60),
    (v_disorder_id, herbal.ensure_herb('Scrophularia nodosa','figwort'),      'Any of the other alteratives may prove to be specific for a given individual.', 70),
    (v_disorder_id, herbal.ensure_herb('Trifolium pratense', 'red clover'),   'Any of the other alteratives may prove to be specific for a given individual.', 80),
    (v_disorder_id, herbal.ensure_herb('Urtica dioica',      'nettle'),       'Any of the other alteratives may prove to be specific for a given individual.', 90),
    (v_disorder_id, herbal.ensure_herb('Viola tricolor',     'heartsease'),   'Any of the other alteratives may prove to be specific for a given individual.', 100),
    (v_disorder_id, herbal.ensure_herb('Calendula officinalis', 'calendula'), 'Choice of topical application will be governed to some extent by the personal preferences of the patient, so experimentation may be necessary.', 110),
    (v_disorder_id, herbal.ensure_herb('Plantago spp.',      'plantain'),     'Choice of topical application will be governed to some extent by the personal preferences of the patient, so experimentation may be necessary.', 120),
    (v_disorder_id, herbal.ensure_herb('Populus balsamifera var. balsamifera','balm of Gilead'), 'Choice of topical application will be governed to some extent by the personal preferences of the patient, so experimentation may be necessary.', 130),
    (v_disorder_id, herbal.ensure_herb('Stellaria media',    'chickweed'),    'Choice of topical application will be governed to some extent by the personal preferences of the patient, so experimentation may be necessary.', 140),
    (v_disorder_id, herbal.ensure_herb('Thuja occidentalis', 'thuja'),        'Choice of topical application will be governed to some extent by the personal preferences of the patient, so experimentation may be necessary.', 150)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription 1: Basic Psoriasis
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Psoriasis',
      'Up to 5 ml of tincture three times a day. In addition, the patient should drink an infusion of fresh Urtica dioica or Galium aparine two or three times a day.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Arctium lappa', 'burdock');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative'))ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))  ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hepatic'))   ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Rumex crispus', 'yellow dock');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative'))ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hepatic'))   ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Galium aparine', 'cleavers');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative'))       ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Lymphatic tonic'))  ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory'))ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))         ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hepatic'))          ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Scutellaria lateriflora', 'skullcap');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 2: Psoriasis with Anxiety and Tension
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Psoriasis with Anxiety and Tension',
      'Up to 5 ml of tincture three times a day. The patient should also drink an infusion of Matricaria recutita as desired.',
      20)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Arctium lappa', 'burdock');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative'))ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))  ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hepatic'))   ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Rumex crispus', 'yellow dock');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative'))ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hepatic'))   ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Galium aparine', 'cleavers');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative'))       ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Lymphatic tonic'))  ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory'))ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))         ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hepatic'))          ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Valeriana officinalis', 'valerian');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Verbena officinalis', 'vervain');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 50);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hepatic'))          ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 3: Intransigent Psoriasis (poke root — not for children)
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Intransigent, Unresponsive Psoriasis',
      '5 ml of tincture three times a day. In addition, the patient should drink an infusion of fresh Urtica dioica or Galium aparine two or three times a day. Care must be taken with this combination, and it is not advisable for children because of the inclusion of Phytolacca americana (poke root).',
      30)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Arctium lappa', 'burdock');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative'))ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))  ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hepatic'))   ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Rumex crispus', 'yellow dock');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative'))ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hepatic'))   ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Smilax spp.', 'sarsaparilla');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative'))ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hepatic'))   ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Phytolacca americana', 'poke root');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative'))      ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Lymphatic tonic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Valeriana officinalis', 'valerian');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 50);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 4: Psoriasis with Hypertension
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for a Patient with Psoriasis and Hypertension',
      '5 ml of tincture three times a day. The patient should also drink an infusion of Matricaria recutita, Tilia platyphyllos, or Trifolium pratense as desired. Allium sativum should be added to the diet or used as a dietary supplement: 1 clove of fresh garlic or 200 to 300 mg of standardized extract three times a day.',
      40)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Arctium lappa', 'burdock');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative'))ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))  ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hepatic'))   ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Rumex crispus', 'yellow dock');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative'))ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hepatic'))   ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Galium aparine', 'cleavers');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative'))       ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Lymphatic tonic'))  ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory'))ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))         ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hepatic'))          ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Valeriana officinalis', 'valerian');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Crataegus spp.', 'hawthorn');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 50);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hypotensive'))ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))   ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Tilia platyphyllos', 'linden');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 60);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hypotensive'))      ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))         ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Achillea millefolium', 'yarrow');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 70);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hypotensive'))ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))   ON CONFLICT DO NOTHING;
  END IF;

  RAISE NOTICE 'Skin: Psoriasis disorder inserted.';
END $$;


-- ============================================================
-- BLOCK 6: Disorder — Acne
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
  v_herb_id     INTEGER;
  v_ph_id       INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Skin';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Acne', v_sys_id, 30)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Acne' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Acne involves the sebaceous glands in the skin, which secrete lubrication (sebum) for the hair follicles (pilosebaceous follicles) and surrounding skin. These are located in greatest concentrations on the face, back, shoulders, and chest.', 10),
    (v_disorder_id, 'Statistics suggest that the strongest single factor in the development of acne is family history.', 20),
    (v_disorder_id, 'Stimulation of the sebaceous glands seems to occur with the production of androgens (the masculinizing hormone found in both sexes) at puberty.', 30),
    (v_disorder_id, 'Although it is popularly thought that diet is a major factor in acne, there is no clear scientific evidence to support this.', 40),
    (v_disorder_id, 'Treatment: Toning work can be focused through the use of hepatic alteratives.', 50),
    (v_disorder_id, 'Personal hygiene is important, but an obsession with washing can aggravate the problem.', 60),
    (v_disorder_id, 'Do not squeeze pimples or blackheads, as squeezing the skin makes the acne worse. Keep the hair off the face, and wash the hair daily.', 70),
    (v_disorder_id, 'Traditionally, there are no definite specifics here, other than hepatic alteratives.', 80)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Alterative'),
      'are the core of any treatment. Hepatic alteratives are especially helpful.', 10),
    (v_disorder_id, herbal.ensure_action('Hormonal normalizer'),
      'are indicated because of the androgen involvement. However, impacting these hormones in an appropriate way is not always a straightforward matter.', 20),
    (v_disorder_id, herbal.ensure_action('Antimicrobial'),
      'help the body deal with secondary infection. They may be used both internally and topically.', 30),
    (v_disorder_id, herbal.ensure_action('Lymphatic tonic'),
      'support lymphatic drainage from the skin and underlying tissues.', 40),
    (v_disorder_id, herbal.ensure_action('Hepatic'),
      'are vital, partly for the generalized benefit imparted by their liver-toning effects, but also because they have a specific role in detoxification.', 50),
    (v_disorder_id, herbal.ensure_action('Diuretic'),
      'important in ensuring adequate elimination through the kidneys.', 60),
    (v_disorder_id, herbal.ensure_action('Anti-inflammatory'),
      'can be helpful when used topically within the context of daily hygiene.', 70),
    (v_disorder_id, herbal.ensure_action('Astringent'),
      'used topically, help in cleansing and avoiding secondary infection.', 80)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Melaleuca alternifolia', 'tea tree'),
      'Tea tree oil has specifically relevant properties. It has been shown to possess significant antimicrobial properties. Organisms inhibited include Candida albicans, Escherichia coli, Staphylococcus aureus, Staphylococcus epidermidis, and Propionibacterium acnes. For acne, tea tree oil applied topically in a 5% to 15% dilution three or four times daily is recommended.', 10),
    (v_disorder_id, herbal.ensure_herb('Vitex agnus-castus', 'chasteberry'),
      'Keep in mind that there is no specific herb that normalizes levels of androgens. Occasionally, however, Vitex can have a beneficial effect in adolescent girls.', 20)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Acne',
      'Up to 5 ml of tincture three times a day. The patient should also drink an infusion of Urtica dioica two or three times a day. In addition, apply Calendula officinalis topically as a wash, in the form of an infusion mixed with distilled Hamamelis virginiana (witch hazel).',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Iris versicolor', 'blue flag');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative'))      ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hepatic'))         ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Lymphatic tonic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Arctium lappa', 'burdock');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative'))ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hepatic'))   ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))  ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Echinacea spp.', 'echinacea');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antimicrobial'))   ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Lymphatic tonic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Galium aparine', 'cleavers');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative'))       ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Lymphatic tonic'))  ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))         ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory'))ON CONFLICT DO NOTHING;
  END IF;

  RAISE NOTICE 'Skin: Acne disorder inserted.';
END $$;


-- ============================================================
-- BLOCK 7: Sync — push prescription herb actions into herb_primary_actions
-- ============================================================
DO $$
DECLARE
  v_sys_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Skin';

  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT DISTINCT ph.herb_id, pha.primary_action_id, v_sys_id
  FROM herbal.prescription_herb_actions pha
  JOIN herbal.prescription_herbs ph ON ph.id = pha.prescription_herb_id
  JOIN herbal.disorder_prescriptions dp ON dp.id = ph.prescription_id
  JOIN herbal.disorders d ON d.id = dp.disorder_id
  WHERE d.body_system_id = v_sys_id
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  RAISE NOTICE 'Skin: herb_primary_actions synced from prescription data.';
END $$;
