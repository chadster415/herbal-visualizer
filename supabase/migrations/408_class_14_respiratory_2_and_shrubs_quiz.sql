-- Migration 408: Class 14 quiz questions
-- Class: BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer
--
-- Target calculation:
--   H = 72 distinct herbs/supplements identified
--   F = 5 named factual items (Deep Lung Formula, garlic 5-7 cloves, mustard poultice,
--       lavender salt water gargle, "don't suppress productive cough")
--   raw = 15 + 72×4 + 5×1 = 15 + 288 + 5 = 308 → clamped to 50

SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_quiz_questions
             WHERE class_name = 'BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer') THEN
    RAISE NOTICE 'Class 14 quiz questions already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_quiz_questions
    (class_name, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, snippet_text, section_header, sort_order)
  VALUES

  -- Q1
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Which part of Mullein is used for lung conditions?',
   'Leaf', 'Root', 'Stem', 'Flowers',
   'a',
   'Mullein leaf is the part indicated for lung/respiratory use. The root is for prostate, the stem for back pain, and the flowers for ear infection oil.',
   'Mullein offers different medicines from each part: root → prostate; stem → back pain, disk disorders; leaf → lung; flowers → oil infusion for ear infection (+ garlic).',
   'Slides', 10),

  -- Q2
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Which part of Mullein is specifically indicated for prostate issues?',
   'Flowers', 'Root', 'Leaf', 'Stem',
   'b',
   'The root of Mullein is noted for prostate support. Each part of the plant has a distinct therapeutic target.',
   'Mullein offers different medicines from each part: root → prostate; stem → back pain, disk disorders; leaf → lung; flowers → oil infusion for ear infection (+ garlic).',
   'Slides', 20),

  -- Q3
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Mullein flower oil infusion (combined with garlic) is used for which condition?',
   'Asthma', 'Bronchitis', 'Ear infection', 'Prostate',
   'c',
   'Mullein flower oil infused with garlic is a classic preparation for ear infections, combining Mullein''s anti-inflammatory action with garlic''s antimicrobial properties.',
   'Mullein offers different medicines from each part: root → prostate; stem → back pain, disk disorders; leaf → lung; flowers → oil infusion for ear infection (+ garlic).',
   'Slides', 30),

  -- Q4
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Which herb is specifically noted to "thin mucus" in bronchitis?',
   'Usnea', 'Elecampane', 'Thyme', 'Ginger',
   'd',
   'Ginger is explicitly noted as the herb that thins mucus in the bronchitis section.',
   'Ginger: herb for bronchitis (thins mucus).',
   'Bronchitis', 40),

  -- Q5
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Which herbal action should be added to a bronchitis formula when the condition is accompanied by fever?',
   'Diaphoretic', 'Cardiotonic', 'Demulcent', 'Adaptogen',
   'a',
   'The notes specify diaphoretic as an indicated action specifically when bronchitis is accompanied by fever.',
   'Usnea: herb for bronchitis. Actions indicated: antimicrobial, antispasmodic, expectorant, anti-inflammatory, anti-catarrhal, diaphoretic (if fever).',
   'Bronchitis', 50),

  -- Q6
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'For bronchitis inhalations, Rosemary and Oregano are suggested as alternatives because they have which quality?',
   'They are strongly antimicrobial when taken internally',
   'They contain volatile oils and have scent',
   'They are demulcent and soothe the bronchial lining',
   'They are lymphatic and reduce glandular swelling',
   'b',
   'The notes say "use what you have — things that have scent, volatile oils." The aromatic volatile-oil content is what makes them useful as inhalation herbs.',
   'Rosemary: potential inhalation herb for bronchitis ("use what you have" — volatile oil plants with scent).',
   'Bronchitis', 60),

  -- Q7
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Which of the following herbs does NOT belong to the Deep Lung Formula?',
   'Elecampane', 'Yerba Mansa', 'Echinacea', 'Osha',
   'c',
   'The Deep Lung Formula contains elecampane, angelica, yerba santa, yarrow, hawthorn, mullein, yerba mansa, garlic, and osha. Echinacea is not in this formula.',
   'Elecampane: herb for bronchitis. In the Deep Lung Formula (elecampane, angelica, yerba santa, yarrow, hawthorn, mullein, yerba mansa, garlic, osha).',
   'Bronchitis', 70),

  -- Q8
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Which of the following herbs IS included in the Deep Lung Formula?',
   'Lobelia', 'Licorice', 'Echinacea', 'Angelica',
   'd',
   'Angelica is one of nine herbs in the Deep Lung Formula. Lobelia, Licorice, and Echinacea are not in it.',
   'Angelica: in the Deep Lung Formula for bronchitis (elecampane, angelica, yerba santa, yarrow, hawthorn, mullein, yerba mansa, garlic, osha).',
   'Bronchitis', 80),

  -- Q9
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'California Spikenard (Aralia) for bronchitis has actions including all of the following EXCEPT:',
   'Cardiotonic', 'Antimicrobial', 'Antispasmodic', 'Expectorant',
   'a',
   'The actions listed for Aralia in bronchitis are antimicrobial, antispasmodic, expectorant, anti-inflammatory, anti-catarrhal, and diaphoretic. Cardiotonic is not among them.',
   'Aralia (California Spikenard): herb for bronchitis. Actions indicated: antimicrobial, antispasmodic, expectorant, anti-inflammatory, anti-catarrhal, diaphoretic.',
   'Bronchitis', 90),

  -- Q10
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Which set of actions best describes Usnea''s role in bronchitis?',
   'Demulcent, nervine, cardiotonic',
   'Antimicrobial, antispasmodic, expectorant, anti-catarrhal',
   'Pulmonary tonic, lymphatic, adaptogen',
   'Diuretic, astringent, bitter',
   'b',
   'Usnea''s indicated actions for bronchitis include antimicrobial, antispasmodic, expectorant, anti-inflammatory, anti-catarrhal, and diaphoretic.',
   'Usnea: herb for bronchitis. Actions indicated: antimicrobial, antispasmodic, expectorant, anti-inflammatory, anti-catarrhal, diaphoretic (if fever).',
   'Bronchitis', 100),

  -- Q11
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'What is the general guidance about managing pneumonia with herbal medicine?',
   'Herbs are first-line; escalate to antibiotics only if no improvement in 72 hours',
   'Herbs can safely replace antibiotics for bacterial pneumonia',
   'Defer to Western Medicine; herbs are for when access is unavailable',
   'Use immunostimulants to prevent the need for antibiotics',
   'c',
   'The notes explicitly state "as a general rule, let Western Medicine treat (can be dangerous)" — herbs are described for when Western Medicine is not accessible.',
   'Garlic for pneumonia when Western Medicine unavailable: 5–7 cloves a day raw, swallowed in honey as small pill-sized pieces without chewing.',
   'Pneumonia', 110),

  -- Q12
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'How should garlic be prepared and used for pneumonia when Western Medicine is unavailable?',
   'As a decoction taken three times daily',
   'Applied as a chest compress overnight',
   'Crushed and inhaled as steam',
   '5–7 raw cloves daily, swallowed in honey as small pieces without chewing',
   'd',
   'The notes specify 5–7 raw cloves, taken as small pill-sized pieces in honey — not chewed — to manage the digestive intensity.',
   'Garlic for pneumonia when Western Medicine unavailable: 5–7 cloves a day raw, swallowed in honey as small pill-sized pieces without chewing.',
   'Pneumonia', 120),

  -- Q13
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'What are the ingredients of a mustard poultice for pneumonia?',
   'Mustard powder, flour, and water',
   'Mustard seeds, vinegar, and honey',
   'Dried mustard, olive oil, and clay',
   'Mustard powder, cayenne, and ginger',
   'a',
   'The mustard poultice for pneumonia is made with mustard powder, flour, and water, applied to the chest.',
   'Mustard poultice on chest for pneumonia: mustard powder, flour and water.',
   'Pneumonia', 130),

  -- Q14
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Besides garlic, which herb is specifically named for pneumonia treatment in these notes?',
   'Usnea', 'Elecampane', 'Mullein', 'Lobelia',
   'b',
   'Elecampane is the second herb named for pneumonia alongside garlic in the notes.',
   'Elecampane: herb for pneumonia.',
   'Pneumonia', 140),

  -- Q15
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Which three herbs are listed as anti-inflammatory for asthma?',
   'Mullein, Marshmallow, Irish Moss',
   'Lobelia, Osha, Pine',
   'Licorice, Hawthorn, Hyssop',
   'Skullcap, Motherwort, California Poppy',
   'c',
   'Licorice, Hawthorn, and Hyssop are the three anti-inflammatory herbs for asthma listed in the notes.',
   'Licorice for asthma: anti-inflammatory and antispasmodic.',
   'Asthma', 150),

  -- Q16
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Wild Cherry Bark is notable in asthma for covering which combination of three actions?',
   'Demulcent, expectorant, nervine',
   'Anti-inflammatory, cardiotonic, diaphoretic',
   'Anticatarrhal, antimicrobial, adaptogen',
   'Antitussive, bronchodilator, and antispasmodic',
   'd',
   'Wild Cherry Bark uniquely covers antitussive, bronchodilator, and antispasmodic — three distinct respiratory actions in one herb.',
   'Wild Cherry Bark for asthma: antitussive, bronchodilator, and antispasmodic.',
   'Asthma', 160),

  -- Q17
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Mullein serves which set of three roles in asthma?',
   'Demulcent, relaxing expectorant, and pulmonary tonic',
   'Anti-inflammatory, antispasmodic, bronchodilator',
   'Cardiotonic, nervine, anticatarrhal',
   'Antimicrobial, diaphoretic, lymphatic',
   'a',
   'Mullein covers demulcent, relaxing expectorant, and pulmonary tonic in asthma — making it one of the most broadly useful herbs in the formula.',
   'Mullein for asthma: demulcent, relaxing expectorant, and pulmonary tonic.',
   'Asthma', 170),

  -- Q18
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'What is Lobelia''s primary action in asthma treatment?',
   'Demulcent', 'Bronchodilator', 'Nervine', 'Cardiotonic',
   'b',
   'Lobelia is listed specifically as a bronchodilator for asthma, helping to open the airways.',
   'Lobelia for asthma: bronchodilator.',
   'Asthma', 180),

  -- Q19
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Which set of herbs serves as pulmonary tonics for asthma?',
   'Goldenrod, Eyebright, Goldenseal',
   'Garlic, Elecampane, Usnea',
   'Mullein, Irish Moss, Prince Seng, Schizandra',
   'Passionflower, Valerian, Hops, Kava',
   'c',
   'Mullein, Irish Moss, Prince Seng, and Schizandra are the four pulmonary tonics for asthma listed in these notes.',
   'Schizandra for asthma: pulmonary tonic.',
   'Asthma', 190),

  -- Q20
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Yerba Mansa and Goldenseal address which aspect of asthma?',
   'Pulmonary tonic', 'Bronchodilation', 'Nervous system tension', 'Anticatarrhal',
   'd',
   'Both Yerba Mansa and Goldenseal are listed as anticatarrhal herbs in the asthma section, addressing excess mucus.',
   'Yerba Mansa for asthma: anticatarrhal.',
   'Asthma', 200),

  -- Q21
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Hawthorn and Motherwort are listed as which type of herb in both asthma and emphysema?',
   'Cardiotonic', 'Pulmonary tonic', 'Demulcent', 'Expectorant',
   'a',
   'Hawthorn and Motherwort are explicitly paired as cardiotonics in both the asthma and emphysema sections.',
   'Hawthorn for asthma: anti-inflammatory and cardiotonic.',
   'Asthma', 210),

  -- Q22
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Which three herbs serve as nervines in asthma?',
   'Licorice, Wild Cherry Bark, Hyssop',
   'Motherwort, Skullcap, California Poppy',
   'Yerba Mansa, Goldenseal, Boneset',
   'Elecampane, Osha, Pine',
   'b',
   'Motherwort, Skullcap, and California Poppy are the three nervines listed for asthma.',
   'Skullcap for asthma: nervine.',
   'Asthma', 220),

  -- Q23
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Which herbs serve as pulmonary tonics in emphysema?',
   'Garlic, Goldenseal, Usnea',
   'Yarrow, Elderflower, Catnip',
   'Mullein, Prince Seng, Lobelia',
   'Valerian, Hops, Wild Lettuce',
   'c',
   'Mullein, Prince Seng, and Lobelia are the three pulmonary tonics for emphysema listed in these notes.',
   'Mullein for emphysema (COPD): pulmonary tonic and demulcent. "No miracle cure, but with consistent use there will be some improvement."',
   'Emphysema', 230),

  -- Q24
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'What do the class notes say about the expected outcome of consistent herbal treatment for emphysema?',
   'Full reversal of damage is possible with six months of treatment',
   'Herbs are ineffective — refer to Western Medicine exclusively',
   'Short-term symptom relief only; no long-term benefit',
   '"No miracle cure, but with consistent use there will be some improvement"',
   'd',
   'The notes are candid: emphysema cannot be cured, but consistent herbal use will yield some improvement — setting realistic patient expectations.',
   'Mullein for emphysema (COPD): pulmonary tonic and demulcent. "No miracle cure, but with consistent use there will be some improvement."',
   'Emphysema', 240),

  -- Q25
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Grindelia is used in emphysema primarily as what?',
   'Expectorant', 'Pulmonary tonic', 'Nervine', 'Cardiotonic',
   'a',
   'Grindelia is listed as an expectorant in the emphysema herbal support section.',
   'Grindelia for emphysema: expectorant.',
   'Emphysema', 250),

  -- Q26
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Which antispasmodic listed for emphysema is notable as a powerful bronchodilator?',
   'Licorice', 'Ephedra (Ma Huang)', 'Wild Cherry Bark', 'Lobelia',
   'b',
   'Ephedra (Ma Huang) is listed as an antispasmodic/bronchodilator for emphysema. It is notably potent and used cautiously.',
   'Ephedra (Ma Huang) for emphysema: antispasmodic/bronchodilator.',
   'Emphysema', 260),

  -- Q27
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Emphysema is described in the notes as a type of which condition?',
   'Asthma', 'Bronchitis', 'COPD', 'Hay fever',
   'c',
   'The notes identify emphysema as a type of COPD — "umbrella term for making breathing difficult."',
   'Mullein for emphysema (COPD): pulmonary tonic and demulcent. "No miracle cure, but with consistent use there will be some improvement."',
   'Emphysema', 270),

  -- Q28
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Which three herbs are listed as anticatarrhals for hay fever?',
   'Nettle, Echinacea, Chrysanthemum',
   'Marshmallow, Linden, Slippery Elm',
   'Yarrow, Elderflower, Catnip',
   'Goldenrod, Eyebright, Goldenseal',
   'd',
   'Goldenrod, Eyebright, and Goldenseal are the three anticatarrhal herbs for hay fever.',
   'Goldenrod for hay fever (allergic rhinitis): anticatarrhal.',
   'Hay Fever', 280),

  -- Q29
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Nettle (used fresh) for hay fever functions as what type of herb?',
   'Antiallergenic', 'Anticatarrhal', 'Immunostimulant', 'Demulcent',
   'a',
   'Fresh nettle is specifically listed as antiallergenic for hay fever — the fresh plant has different activity than dried.',
   'Nettle (fresh) for hay fever: antiallergenic.',
   'Hay Fever', 290),

  -- Q30
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Chrysanthemum Flower (a TCM herb) is indicated for which specific hay fever symptom, and how is it applied?',
   'Sneezing — taken as a capsule',
   'Itchy eyes — prepared as tea used as an eye wash',
   'Post-nasal drip — used as a steam inhalation',
   'Wheezing — used as a bronchodilator',
   'b',
   'Chrysanthemum tea as an eye wash is a TCM application specifically for itchy eyes in hay fever.',
   'Chrysanthemum Flower (TCM) for hay fever: itchy eyes; prepared as tea used as an eye wash.',
   'Hay Fever', 300),

  -- Q31
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Which herbs serve as demulcents for sore throat in the common cold?',
   'Garlic, Thyme, Sage',
   'Echinacea, Elderberry, Lemon Balm',
   'Marshmallow, Linden, Slippery Elm',
   'Red Root, Cleavers, Poke Root',
   'c',
   'Marshmallow, Linden, and Slippery Elm are the three demulcents for sore throat in the common cold — all mucilaginous herbs.',
   'Marshmallow for common cold sore throat: demulcent.',
   'Common Cold', 310),

  -- Q32
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Which herb is specifically noted for use as a salt water gargle for sore throat?',
   'Garlic', 'Thyme', 'Sage', 'Lavender',
   'd',
   'The notes specifically mention a lavender salt water gargle as an antimicrobial sore throat treatment.',
   'Lavender for common cold sore throat: antimicrobial; lavender salt water gargle.',
   'Common Cold', 320),

  -- Q33
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'How does Echinacea exert its antiviral effect in the common cold, per these notes?',
   'By interfering with the virus''s ability to bind to cells',
   'By stimulating fever to eliminate the pathogen',
   'By thinning mucus to flush the virus out',
   'By directly lysing the viral capsid',
   'a',
   'The notes describe Echinacea''s antiviral mechanism as interfering with the virus''s ability to bind to cells.',
   'Echinacea for common cold: antiviral — interferes with virus ability to bind to cells.',
   'Common Cold', 330),

  -- Q34
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Which three herbs serve as lymphatics in common cold treatment?',
   'Marshmallow, Linden, Slippery Elm',
   'Red Root, Cleavers, Poke Root',
   'Garlic, Thyme, Lavender',
   'Echinacea, Elderberry, Lemon Balm',
   'b',
   'Red Root, Cleavers, and Poke Root are the three lymphatic herbs for common cold, supporting lymphatic drainage.',
   'Red Root for common cold: lymphatic support.',
   'Common Cold', 340),

  -- Q35
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'What is the critical safety consideration when using Poke Root as a lymphatic for colds?',
   'Should not be combined with immune tonics',
   'Only effective during the first 48 hours of illness',
   'Use in small doses only',
   'Must be combined with Cleavers for safe use',
   'c',
   'Poke Root is noted for lymphatic support in small doses only — it is toxic in larger amounts.',
   'Poke Root for common cold: lymphatic support — use in small doses only.',
   'Common Cold', 350),

  -- Q36
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Which herb serves as an immune tonic alongside Siberian Ginseng and Astragalus for the common cold?',
   'Echinacea', 'Elderberry', 'Boneset', 'Rhodiola',
   'd',
   'Rhodiola is listed alongside Siberian Ginseng (Eleuthero) and Astragalus as immune tonics for the common cold.',
   'Rhodiola for common cold: immune tonic.',
   'Common Cold', 360),

  -- Q37
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Which four herbs are listed as diaphoretics for influenza fever?',
   'Yarrow, Elderflower, Catnip, Ginger',
   'Passionflower, Valerian, Hops, Kava',
   'Echinacea, Andrographis, Boneset, Licorice',
   'Cleavers, Red Root, Astragalus, Maitake',
   'a',
   'Yarrow, Elderflower, Catnip, and Ginger are the four diaphoretic herbs for influenza fever.',
   'Yarrow for influenza: diaphoretic for fever; also astringent for flu-related diarrhea.',
   'Influenza Virus', 370),

  -- Q38
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Which herb combination is explicitly listed as antiemetic for influenza nausea?',
   'Catnip and Yarrow',
   'Ginger and Peppermint',
   'Licorice and Osha',
   'Passionflower and Valerian',
   'b',
   'Ginger and Peppermint are explicitly paired as antiemetics for flu nausea in these notes.',
   'Peppermint for influenza nausea: antiemetic (with ginger).',
   'Influenza Virus', 380),

  -- Q39
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'The class notes treat flu aches and pains with sedatives and anodynes, noting body aches "edge off." Which herbs are listed?',
   'Boneset, Andrographis, Echinacea',
   'Yarrow, Blackberry root, Willow',
   'Passionflower, Valerian, Hops, Kava, Wild Lettuce',
   'Reishi, Maitake, Astragalus',
   'c',
   'Passionflower, Valerian, Hops, Kava, and Wild Lettuce are all listed as sedatives/anodynes for flu aches — "all pretty sedative and antispasmodic."',
   'Passionflower for influenza aches and pains: sedative/anodyne — body aches edge off from the flu.',
   'Influenza Virus', 390),

  -- Q40
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Which herbs are astringents for flu-related diarrhea?',
   'Ginger, Peppermint, Catnip',
   'Echinacea, Elder, Andrographis',
   'Lobelia, Osha, Mullein',
   'Blackberry root, Yarrow, Willow',
   'd',
   'Blackberry root, Yarrow, and Willow are the three astringent herbs for diarrhea during influenza.',
   'Blackberry root for influenza diarrhea: astringent.',
   'Influenza Virus', 400),

  -- Q41
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Chinese Skullcap''s role in influenza overall immune support is as a what?',
   'Antiviral', 'Diaphoretic', 'Adaptogen', 'Demulcent',
   'a',
   'Chinese Skullcap is listed in the antiviral category for influenza overall immune support.',
   'Chinese Skullcap for influenza: antiviral in overall immune support.',
   'Influenza Virus', 410),

  -- Q42
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'When should adaptogen/immune tonics (Reishi, Astragalus, Maitake, Eleuthero) be used during influenza?',
   'At the first sign of symptoms to prevent progression',
   'After the acute phase of the flu resolves',
   'During the peak fever stage for maximum effect',
   'Simultaneously with antivirals throughout the illness',
   'b',
   'The notes explicitly say "wait until after the acute part of the flu" before using immune tonics/adaptogens.',
   'Reishi Mushroom for influenza immune support: adaptogen/immune tonic — use after the acute phase of the flu resolves.',
   'Influenza Virus', 420),

  -- Q43
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'What dual role does Andrographis serve in influenza treatment?',
   'Diaphoretic and demulcent',
   'Cardiotonic and nervine',
   'Antiviral and immunostimulant',
   'Expectorant and lymphatic',
   'c',
   'Andrographis appears in both the antiviral and immunostimulant categories for influenza, giving it a dual role in immune support.',
   'Andrographis for influenza: antiviral and immunostimulant.',
   'Influenza Virus', 430),

  -- Q44
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Which herb pairing is explicitly listed as cardiotonics in both the asthma and emphysema sections?',
   'Lobelia and Osha',
   'Echinacea and Andrographis',
   'Licorice and Wild Cherry Bark',
   'Hawthorn and Motherwort',
   'd',
   'Hawthorn and Motherwort are paired as cardiotonics in both asthma and emphysema — the heart is often stressed by chronic respiratory conditions.',
   'Hawthorn for emphysema: cardiotonic (with motherwort).',
   'Emphysema', 440),

  -- Q45
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'For runny/stuffy nose in a common cold, which herb serves as an anticatarrhal alongside Yerba Mansa?',
   'Boneset', 'Elderberry', 'Astragalus', 'Poke Root',
   'a',
   'Boneset and Yerba Mansa are the two anticatarrhal herbs for runny/stuffy nose in the common cold.',
   'Boneset for common cold runny/stuffy nose: anticatarrhal.',
   'Common Cold', 450),

  -- Q46
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'What is the unifying therapeutic action of all herbs in Four Thieves Vinegar?',
   'Adaptogenic', 'Antimicrobial', 'Diaphoretic', 'Nervine',
   'b',
   'The notes state that all herbs in Four Thieves Vinegar — Rosemary, Sage, Wormwood, Mint, Lavender, Garlic, Thyme, and Cloves — are "all antimicrobial."',
   'Rosemary in Four Thieves Vinegar: antimicrobial — used historically for plague protection.',
   'Infused Vinegars', 460),

  -- Q47
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Rosemary vinegar is recommended as a hair rinse for which purpose?',
   'Treating dandruff',
   'Conditioning all hair types',
   'Dark hair and hair growth',
   'Darkening grey hair',
   'c',
   'Rosemary vinegar hair rinse is specifically for dark hair and hair growth, while sage is for darkening grey hair.',
   'Rosemary vinegar hair rinse: for dark hair and hair growth.',
   'Cosmetic Use of Infused Vinegars', 470),

  -- Q48
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Which herb vinegar rinse is indicated for darkening grey hair?',
   'Rosemary', 'Calendula', 'Nettle', 'Sage',
   'd',
   'Sage vinegar rinse is indicated for darkening grey hair, while rosemary is for dark hair and hair growth.',
   'Sage vinegar hair rinse: for darkening grey hair.',
   'Cosmetic Use of Infused Vinegars', 480),

  -- Q49
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'In the oxymel classification, which type contains Mugwort and Angelica?',
   'Digestive (bitter) oxymel',
   'Nutritive oxymel',
   'Antimicrobial oxymel',
   'Pulmonary oxymel',
   'a',
   'Mugwort and Angelica are listed as bitter digestive herbs in the digestive oxymel category.',
   'Mugwort in digestive oxymel: bitter herb.',
   'Oxymels', 490),

  -- Q50
  ('BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer',
   'Fire Cider is described in the class notes as what?',
   'A poultice for pneumonia',
   'A famous cold and flu remedy made with herbal-infused vinegar',
   'An eye wash for hay fever',
   'A hair tonic for scalp conditions',
   'b',
   'Fire Cider is introduced as "a famous cold and flu remedy" containing garlic, ginger, cayenne, horseradish, vinegar, honey, and other herbs.',
   'Garlic in Four Thieves Vinegar and Fire Cider: antimicrobial; Fire Cider is a famous cold and flu remedy.',
   'Infused Vinegars', 500);

END $$;
