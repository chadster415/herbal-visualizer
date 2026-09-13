-- Migration 315: Class 34 – Skin 2 and AMAB Repro System quiz (30 questions)
-- Correct option distribution: a=7, b=7, c=8, d=8

SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_quiz_questions
             WHERE class_name = 'BHC - Class 34 - Skin 2 and AMAB Repro System') THEN
    RAISE NOTICE 'Class 34 quiz already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_quiz_questions
    (class_name, question_text, option_a, option_b, option_c, option_d,
     correct_option, explanation, snippet_text, section_header, sort_order)
  VALUES

  -- Q1 (correct=a)
  ('BHC - Class 34 - Skin 2 and AMAB Repro System',
   'Which three herbal actions are listed for wound wash herbs in class 34?',
   'Astringent, Antimicrobial, Vulnerary',
   'Alterative, Lymphagogue, Anti-inflammatory',
   'Emollient, Demulcent, Nervine',
   'Antifungal, Astringent, Adaptogen',
   'a',
   'The notes explicitly label the wound wash herbs (Rosemary, Lavender, Calendula, Chamomile, Rose petals, Sage) with the trio: Astringent, Antimicrobial, Vulnerary.',
   'Rosemary: wound wash herb — Astringent, Antimicrobial, Vulnerary.',
   'Wound Care', 10),

  -- Q2 (correct=b)
  ('BHC - Class 34 - Skin 2 and AMAB Repro System',
   'Which skin alterative herb is specifically noted as being prebiotic at the root?',
   'Yellow Dock',
   'Burdock',
   'Sarsaparilla',
   'Oregon Grape Root',
   'b',
   'The notes state "Burdock — Internally — Blood and Kidneys, root is prebiotic" under the Alteratives for Skin Conditions list.',
   'Burdock: alterative for skin conditions — used Internally for Blood and Kidneys; root is prebiotic.',
   'Alteratives for Skin', 20),

  -- Q3 (correct=a)
  ('BHC - Class 34 - Skin 2 and AMAB Repro System',
   'Fringetree is used as a skin alterative targeting which organ?',
   'Gallbladder',
   'Kidneys',
   'Lymph',
   'Liver',
   'a',
   'The notes list Fringetree as an alterative used "Internally — gallbladder" in the Alteratives for Skin Conditions section.',
   'Fringetree: alterative for skin conditions — used Internally for the gallbladder.',
   'Alteratives for Skin', 30),

  -- Q4 (correct=a)
  ('BHC - Class 34 - Skin 2 and AMAB Repro System',
   'Figwort targets which organ as a skin alterative?',
   'Kidneys',
   'Gallbladder',
   'Liver',
   'Blood',
   'a',
   'The notes list Figwort as an alterative used "Internally — kidneys" in the Alteratives for Skin Conditions section.',
   'Figwort: alterative for skin conditions — used Internally for kidneys.',
   'Alteratives for Skin', 40),

  -- Q5 (correct=b)
  ('BHC - Class 34 - Skin 2 and AMAB Repro System',
   'Plantain is specifically recommended for which condition in these notes (not clay)?',
   'Chronic eczema',
   'Bee stings',
   'Acne',
   'Boils',
   'b',
   'The notes state "Bee sting = Plantain, not necessarily clay" — distinguishing it from the clay strategy used for infected wounds.',
   'Plantain: specific for bee stings (not clay).',
   'Wound Care', 50),

  -- Q6 (correct=b)
  ('BHC - Class 34 - Skin 2 and AMAB Repro System',
   'Which three herbs are named in these notes for hormone balancing (calming androgens) in acne?',
   'Burdock, Cleavers, Red Clover',
   'Vitex, Saw Palmetto, Nettle root',
   'Oregon Grape Root, Yellow Dock, Sarsaparilla',
   'Calendula, Hibiscus, Gotu Kola',
   'b',
   'The acne section lists the hormone-balancing strategy as "calm the androgens in the body" with three herbs: Vitex, Saw Palmetto, and Nettle root.',
   'Chasteberry (Vitex): hormone balancing for acne — calms circulating androgens.',
   'Acne', 60),

  -- Q7 (correct=b)
  ('BHC - Class 34 - Skin 2 and AMAB Repro System',
   'What is Calendula specifically noted for in the Acne section?',
   'Antimicrobial action',
   'Vulnerary to reduce scar tissue',
   'Hormone balancing',
   'Lymphagogue',
   'b',
   'The notes state: "vulnerary — to reduce scar tissue — specifically Calendula" as one of the herbal actions for acne.',
   'Calendula: vulnerary for acne — specifically indicated to reduce scar tissue.',
   'Acne', 70),

  -- Q8 (correct=b)
  ('BHC - Class 34 - Skin 2 and AMAB Repro System',
   'What is the dose for Saw Palmetto as a dry tincture according to class 34?',
   '1:5 60%, 15–30 drops 2x/day',
   '1:5 80%, 30–90 drops up to 3x/day',
   '1:3 80%, 60 drops 2x/day',
   '1:2 60%, 30–45 drops 3x/day',
   'b',
   'The Saw Palmetto section gives: Parts used — berries; Fresh 1:2; Dry 1:5 80%; Dose: 30-90 drops up to 3x/day.',
   'Saw Palmetto (Serenoa repens): Fresh 1:2, Dry 1:5 80%, Dose: 30–90 drops up to 3x/day.',
   'Saw Palmetto', 80),

  -- Q9 (correct=b)
  ('BHC - Class 34 - Skin 2 and AMAB Repro System',
   'What is the dosing instruction for the Dermatitis formula (EP) during the acute phase?',
   '30–60 drops, 2x/day',
   '1–2 tsp, 3–4x/day',
   '2–3 tsp, 2x/day',
   '1 tbsp, 4x/day',
   'b',
   'The notes give "1–2 tsp, 3–4x/day, during the acute phase" for the Calendula/Licorice/Dong Quai/Gotu Kola Dermatitis formula.',
   'Calendula: in Dermatitis formula — eliminates waste, slows histamine response, reduces mast cell activation. Dose: 1–2 tsp, 3–4x/day during acute phase.',
   'Dermatitis', 90),

  -- Q10 (correct=b)
  ('BHC - Class 34 - Skin 2 and AMAB Repro System',
   'How is Poke Root used in the boils tincture protocol?',
   'As the primary herb at a full standard dose',
   '2 drops added to 3 dropperfuls of the antimicrobial tincture',
   'As a topical poultice only',
   'In a strong decoction taken 4x/day',
   'b',
   'The notes specify "add 2 drops of Poke to maybe 3 dropperfuls of the above tincture" — a small dose alongside the main antimicrobials.',
   'Poke Root: added in small doses (2 drops per 3 dropperfuls of tincture) for internal treatment of boils alongside antimicrobials.',
   'Boils', 100),

  -- Q11 (correct=d)
  ('BHC - Class 34 - Skin 2 and AMAB Repro System',
   'Which Jing tonic is noted for restoring Jing and potentially reversing graying hair?',
   'Ashwagandha',
   'Prepared Rehmannia',
   'Schizandra',
   'Fo Ti',
   'd',
   'The Jing section states "Fo Ti → restores Jing? reverses graying hair, looks like a mandrake."',
   'Fo Ti (Polygonum multiflorum, root): TCM Jing tonic — restores Jing; said to reverse graying hair.',
   'Jing and Vitality', 110),

  -- Q12 (correct=c)
  ('BHC - Class 34 - Skin 2 and AMAB Repro System',
   'Which four herbs make up the Dermatitis formula (EP)?',
   'Burdock, Red Clover, Nettle, Alfalfa',
   'Oregon Grape Root, Yellow Dock, Echinacea, Cleavers',
   'Calendula, Licorice, Dong Quai, Gotu Kola',
   'Rosemary, Lavender, Sage, Chamomile',
   'c',
   'The Dermatitis formula (EP) lists exactly these four: Calendula, Licorice, Dong Quai, and Gotu Kola. Red Clover, Nettles, Lemon Balm, and Alfalfa are listed as supportive alteratives alongside the formula, not in it.',
   'Calendula: in Dermatitis formula — eliminates waste, slows histamine response, reduces mast cell activation. Dose: 1–2 tsp, 3–4x/day during acute phase.',
   'Dermatitis', 120),

  -- Q13 (correct=c)
  ('BHC - Class 34 - Skin 2 and AMAB Repro System',
   'For which skin condition is Licorice noted as effective as a "solid extract" that can turn around emerging lesions?',
   'Psoriasis',
   'Acne',
   'Herpes (viral skin eruptions)',
   'Eczema',
   'c',
   'The notes state "viral skin eruptions: herpes — solid extract turns emerging herpes sores around" under the Licorice section.',
   'Licorice: anti-inflammatory; indicated for allergic and atopic tendencies, food-triggered skin eruptions, hives in stress or heat, chronic eczema, autoimmune psoriasis, slow healing wounds, viral skin eruptions including herpes (solid extract turns emerging herpes sores around).',
   'Licorice', 130),

  -- Q14 (correct=c)
  ('BHC - Class 34 - Skin 2 and AMAB Repro System',
   'What does Hibiscus stimulate in skin tissue according to class 34?',
   'Testosterone metabolism',
   'Lymph drainage around the dermis',
   'Reepithelization in wounds and hyaluronan production',
   'Astringency to tonify tight junctions',
   'c',
   'The notes describe Hibiscus as stimulating "reepithelization in wounds — knit tissues" and "hyaluronan production — skin to hold hydration."',
   'Hibiscus: stimulates reepithelization in wounds — knits tissues; good for acne in skin wash; stimulates hyaluronan production to help skin hold hydration.',
   'Hibiscus', 140),

  -- Q15 (correct=c)
  ('BHC - Class 34 - Skin 2 and AMAB Repro System',
   'What are the three herbal actions listed for boils in these notes?',
   'Alterative, astringent, vulnerary',
   'Anti-inflammatory, diuretic, alterative',
   'Alterative, antimicrobial, lymphagogue',
   'Antimicrobial, nervine, adaptogen',
   'c',
   'The boils section lists: "herbal actions: alterative, antimicrobial, lymphagogue."',
   '- herbal actions: alterative, antimicrobial, lymphagogue
- antimicrobials: Echinacea (Internally and topically), Oregon Grape Root (Internally and topically), Yarrow (Internally and topically)',
   'Boils', 150),

  -- Q16 (correct=d)
  ('BHC - Class 34 - Skin 2 and AMAB Repro System',
   'Prepared Rehmannia tincture is indicated for which purpose, and how does it differ from unprepared Rehmannia?',
   'Premature ejaculation; unprepared is for kidney support',
   'Heat in the Blood; unprepared is for grounding',
   'Contact dermatitis; unprepared is for chronic eczema',
   'Grounding, kidneys, balancing blood sugar; unprepared is for Heat in the Blood',
   'd',
   'The notes state: "Prepared Rehmannia tincture → grounding, kidneys, balance blood sugar. Unprepared is for Heat in the Blood, diff application."',
   'Prepared Rehmannia Root: TCM Jing tonic — grounding, supports kidneys, balances blood sugar. (Unprepared Rehmannia is for Heat in the Blood — different application.)',
   'Jing and Vitality', 160),

  -- Q17 (correct=c)
  ('BHC - Class 34 - Skin 2 and AMAB Repro System',
   'Which Jing tonic is described as "astringent to the Jing" and specific for premature ejaculation and night sweats?',
   'Ashwagandha',
   'Fo Ti',
   'Schizandra',
   'Siberian Ginseng',
   'c',
   'The notes describe "Leaky Jing Gate" as "Schizandra = astringent to the Jing — premature ejaculation, night sweats."',
   'Schizandra: TCM Jing tonic — ''astringent to the Jing''; specific for premature ejaculation and night sweats (''Leaky Jing Gate'').',
   'Jing and Vitality', 170),

  -- Q18 (correct=c)
  ('BHC - Class 34 - Skin 2 and AMAB Repro System',
   'What does Kava offer in the AMAB reproductive support tincture blend?',
   'Grounding and embodiment',
   'Antifungal and antimicrobial tingling',
   'Antispasmodic, opening the heart, mild numbing',
   'Moistening to the tissues, over time',
   'c',
   'The notes list Kava as "Antispasmodic, opening the heart, little numbing, but not as much as Spilanthes" in the AMAB tincture options.',
   'Kava: tincture option for AMAB reproductive support — antispasmodic, opening the heart, mild numbing.',
   'AMAB Reproductive Support', 180),

  -- Q19 (correct=c)
  ('BHC - Class 34 - Skin 2 and AMAB Repro System',
   'Which two herbs are specifically named for prostate support (lymph drainage) in the anatomy section?',
   'Saw Palmetto and Nettle root',
   'Horsetail and Red Clover',
   'Damiana and Ginger',
   'Ashwagandha and Siberian Ginseng',
   'c',
   'The Prostate section lists: "Herbs: Damiana, Ginger" for lymph stimulation and support around the prostate.',
   'Damiana: indicated for prostate support — relaxing to tissues, grounding, addresses lymph drainage around the prostate.',
   'Prostate', 190),

  -- Q20 (correct=d)
  ('BHC - Class 34 - Skin 2 and AMAB Repro System',
   'According to the notes, what is the underlying driver of acne at the sebaceous gland level?',
   'Excess cortisol triggering sebum overproduction',
   'Low estrogen allowing androgen dominance',
   'Poor liver function alone',
   'Hormonal response to circulating androgens causing hypersensitivity of the sebaceous glands',
   'd',
   'The acne section opens: "hypersensitivity of the sebaceous glands, often hormonal response to circulating androgens — sebaceous sweat glands become vulnerable to the resident microbes on the skin."',
   '- hypersensitivity of the sebaceous glands, often hormonal response to circulating androgens
- sebaceous sweat glands become vulnerable to the resident microbes on the skin',
   'Acne', 200),

  -- Q21 (correct=d)
  ('BHC - Class 34 - Skin 2 and AMAB Repro System',
   'What is Red Root (Ceanothus) used for in the Rashes and Itching section?',
   'Anti-inflammatory for atopic dermatitis',
   'Wound wash',
   'Liver support for rash recovery',
   'Astringent tincture sprayed on contact dermatitis / poison oak to dry and inactivate the oils',
   'd',
   'The notes list Ceanothus alongside Manzanita and Madrone as astringent tinctures sprayed on the spot for contact dermatitis and poison oak.',
   'Red Root (Ceanothus): astringent tincture sprayed on contact dermatitis / poison oak to dry out and inactivate the oils.',
   'Rashes and Itching', 210),

  -- Q22 (correct=d)
  ('BHC - Class 34 - Skin 2 and AMAB Repro System',
   'Which herb is indicated for urinary incontinence caused by a swollen prostate pressing on the urethra?',
   'Damiana',
   'Ginger',
   'Schizandra',
   'Horsetail',
   'd',
   'The second Prostate section states: "when swollen, can push on urethra, always need to go, or incomplete going, or incontinence (horsetail)."',
   'Horsetail: indicated for urinary incontinence caused by swollen prostate pressing on the urethra.',
   'Prostate', 220),

  -- Q23 (correct=d)
  ('BHC - Class 34 - Skin 2 and AMAB Repro System',
   'Which three herbs are listed as antimicrobials for boils used both Internally and Topically?',
   'Poke Root, Burdock, Red Clover',
   'Yellow Dock, Sarsaparilla, Oregon Grape Root',
   'Calendula, Lavender, Rosemary',
   'Echinacea, Oregon Grape Root, Yarrow',
   'd',
   'The boils section lists "Echinacea (Internally and topically), Oregon Grape Root (Internally and topically), Yarrow (Internally and topically)" as the antimicrobials.',
   'Echinacea: antimicrobial for boils — used Internally and Topically; think blood and lymph circulation.',
   'Boils', 230),

  -- Q24 (correct=d)
  ('BHC - Class 34 - Skin 2 and AMAB Repro System',
   'What does Shatavari offer in the AMAB reproductive tincture blend?',
   'Antifungal and antimicrobial',
   'Circulatory stimulation and warming',
   'Antispasmodic, opening the heart',
   'Moistening to the tissues, over time',
   'd',
   'The tincture options list Shatavari as "moistening to the tissues, over time" for AMAB reproductive support.',
   'Shatavari: tincture option for AMAB reproductive support — moistening to the tissues, over time.',
   'AMAB Reproductive Support', 240),

  -- Q25 (correct=d)
  ('BHC - Class 34 - Skin 2 and AMAB Repro System',
   'What is Dong Quai specifically described as being "specific for" in skin conditions?',
   'Reducing scar tissue',
   'Astringency for rashes',
   'Hormone balancing in acne',
   'Allergies expressed through the skin / chronic dermatitis',
   'd',
   'The Dong Quai section states: "used internally to reduce allergic tendencies, particularly chronic dermatitis" and "specific for allergies expressed through the skin."',
   'Dong Quai (Angelica sinensis, root): used internally to reduce allergic tendencies, particularly chronic dermatitis; induces photosensitivity which can support and nourish psoriasis; specific for allergies expressed through the skin.',
   'Dong Quai', 250),

  -- Q26 (correct=a)
  ('BHC - Class 34 - Skin 2 and AMAB Repro System',
   'What happens if you oversimmer flax seed decoction, and what is the correct preparation?',
   'It turns into solid mucilage; simmer 5–10 minutes stirring constantly, then strain loosely',
   'It loses all medicinal value; steep in cold water instead',
   'It becomes too bitter; simmer only 2 minutes',
   'Nothing changes; simmer time is not important',
   'a',
   'The notes warn "Don''t oversimmer, it will turn into a solid mucil snot — Simmer 5-10 mins, stirring constantly — Strain, little bit loose in the mesh binding."',
   'Flax seeds: mucilaginous when exposed to water and heat; decoct 5–10 mins stirring constantly; strain loosely. Shelf life 3–4 days in fridge.',
   'AMAB Reproductive Support', 260),

  -- Q27 (correct=a)
  ('BHC - Class 34 - Skin 2 and AMAB Repro System',
   'What two benefits does Calendula provide at the skin layer level, according to its standalone clinical section?',
   'Supports collagen synthesis below the dermis and improves the protective squamous barrier',
   'Calms circulating androgens and reduces sebum',
   'Stimulates lymph drainage and reduces mast cell activation',
   'Induces photosensitivity and supports hyaluronan production',
   'a',
   'The Calendula section states: "supports collagen synthesis, right below the dermis" and "improves the protective squamous barrier."',
   'Calendula: supports collagen synthesis below the dermis; improves the protective squamous barrier; use topically and internally; good as an eye wash.',
   'Calendula', 270),

  -- Q28 (correct=c)
  ('BHC - Class 34 - Skin 2 and AMAB Repro System',
   'What is Spilanthes noted for in the AMAB reproductive support tincture blend?',
   'Grounding and embodiment',
   'Antispasmodic, opening the heart',
   'Tingling sensation, antifungal and antimicrobial',
   'Moistening to the tissues',
   'c',
   'The tincture options list Spilanthes as "tingling, antifungal and antimicrobial" for AMAB reproductive support.',
   'Spilanthes: tincture option for AMAB reproductive support — tingling, antifungal and antimicrobial.',
   'AMAB Reproductive Support', 280),

  -- Q29 (correct=a)
  ('BHC - Class 34 - Skin 2 and AMAB Repro System',
   'What is Oregon Grape Root''s role as a skin alterative?',
   'Topical and Internally — liver, gut, and blood',
   'Internally only — gallbladder support',
   'Topical only — lymph drainage',
   'Internally — kidneys and blood',
   'a',
   'The notes list Oregon Grape Root as "Topical and Internally — liver, gut, blood" in the Alteratives for Skin Conditions section.',
   'Oregon Grape Root: alterative for skin conditions — Topical and Internally — liver, gut, blood.',
   'Alteratives for Skin', 290),

  -- Q30 (correct=a)
  ('BHC - Class 34 - Skin 2 and AMAB Repro System',
   'What does Rosemary provide in the AMAB reproductive support tincture blend?',
   'Circulatory stimulation, for AM use',
   'Grounding and embodiment',
   'Antifungal and antimicrobial',
   'Moistening to the tissues',
   'a',
   'The tincture options note Rosemary as "cir stim, AM" — circulatory stimulant, for morning use.',
   'Rosemary: tincture option for AMAB reproductive support — circulatory stimulant, for AM use.',
   'AMAB Reproductive Support', 300);

  RAISE NOTICE 'Class 34 quiz loaded.';
END $$;
