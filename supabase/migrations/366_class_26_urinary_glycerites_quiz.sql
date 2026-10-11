-- Migration 366: BHC Class 26 - Urinary I and Glycerites — Quiz Questions
-- Class name: BHC - Class 26 - Urinary I and Glycerites
--
-- Target question count calculation:
--   H = 30 distinct herbs/plants
--   F = 3 named factual items (Juniper tincture 1:5 75% alc 20-40 drops,
--       Juniper infusion 2-3oz 3x day, GFR <60 = stage 1 kidney disease)
--   target = clamp(15 + 30×4 + 3×1, 20, 50) = clamp(138, 20, 50) = 50
--   Rounded to nearest 5: 50 questions

SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_quiz_questions
             WHERE class_name = 'BHC - Class 26 - Urinary I and Glycerites') THEN
    RAISE NOTICE 'Class 26 quiz questions already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_quiz_questions
    (class_name, question_text, option_a, option_b, option_c, option_d,
     correct_option, explanation, snippet_text, section_header, sort_order)
  VALUES

  -- Q1
  ('BHC - Class 26 - Urinary I and Glycerites',
   'Which herb is listed as a urinary antiseptic that is also a diaphoretic and diuretic with anti-inflammatory action?',
   'Horsetail', 'Yarrow', 'Marshmallow', 'Usnea',
   'b',
   'Yarrow is described in the Top Herbs section as diaphoretic and diuretic with anti-inflammatory (AI) action for the urinary system, making it unique among the antiseptics listed.',
   'Yarrow — diaphoretic and diuretic; anti-inflammatory (AI) for the urinary system.',
   'Top Herbs', 10),

  -- Q2
  ('BHC - Class 26 - Urinary I and Glycerites',
   'What is the primary action of Bearberry (Uva ursi) in the urinary system, as noted in these class notes?',
   'Demulcent', 'Diuretic', 'Antispasmodic', 'Antiseptic',
   'd',
   'Bearberry (Uva ursi) is listed under the Antiseptics category — herbs that kill bacteria in the urinary tract.',
   'Bearberry (Uva ursi) — listed as a urinary antiseptic; kills bacteria in the urinary tract.',
   'Antiseptics', 20),

  -- Q3
  ('BHC - Class 26 - Urinary I and Glycerites',
   'Which herb is described as "best indicated for the bladder — UTI, cystitis" due to its cooling, bitter, and astringent properties?',
   'Aloe', 'Marshmallow', 'Corn Silk', 'Usnea',
   'a',
   'Aloe is specifically noted as cooling, bitter, and astringent, with the qualifier "best indicated for the bladder" — UTI and cystitis — distinguishing it from herbs that address the broader urinary tract.',
   'Aloe — cooling, bitter, astringent; best indicated for the bladder — UTI, cystitis.',
   'Top Herbs', 30),

  -- Q4
  ('BHC - Class 26 - Urinary I and Glycerites',
   'How does Dandelion root counteract sodium retention caused by hormones like Aldosterone, Estrogen, and Cortisol?',
   'By blocking angiotensin receptors', 'Through its potassium content displacing sodium', 'Via antimicrobial action on kidney tubules', 'Through demulcent action on the nephron',
   'b',
   'The notes state that Dandelion root reduces sodium via its potassium level — the classic potassium-sparing diuretic mechanism, in contrast to hormonal sodium retention.',
   'Dandelion root reduces sodium with their potassium level — useful when hormones like Aldosterone, Estrogen, and Cortisol encourage kidneys to retain sodium and water.',
   'Hormones', 40),

  -- Q5
  ('BHC - Class 26 - Urinary I and Glycerites',
   'Which herb is described as having "all the anti-s" — anti-inflammatory, antimicrobial, and antispasmodic — for the urinary system?',
   'Lavender', 'Yarrow', 'Goldenrod', 'Thyme',
   'a',
   'Lavender is noted in the Top Herbs section with the phrase "all the anti-s," indicating it covers anti-inflammatory, antimicrobial, and antispasmodic actions in the urinary context.',
   'Lavender — "all the anti-s": anti-inflammatory, antimicrobial, and antispasmodic properties for the urinary system.',
   'Top Herbs', 50),

  -- Q6
  ('BHC - Class 26 - Urinary I and Glycerites',
   'Goldenrod is noted for which combination of urinary actions in these class notes?',
   'Inflammation, chronic kidney disease, and antiseptic', 'Kidney stones, cystitis, and edema', 'Diuretic, demulcent, and nervine', 'Infection, antispasmodic, and tonic',
   'a',
   'The notes list three properties for Goldenrod: inflammation, chronic kidney disease, and antiseptic — a distinctive trio that covers both structural and infectious urinary conditions.',
   'Goldenrod — addresses inflammation and chronic kidney disease; acts as a urinary antiseptic.',
   'Top Herbs', 60),

  -- Q7
  ('BHC - Class 26 - Urinary I and Glycerites',
   'Which herb in the Urinary Formula glycerite is specifically noted for its role in red blood cell production beyond its diuretic action?',
   'Burdock', 'Dandelion leaf', 'Peppermint', 'Nettle',
   'd',
   'Nettle (Nettles) is described as necessary for red blood cell production, giving it an additional systemic role beyond its diuretic classification.',
   'Nettles — necessary for red blood cell production; diuretic for the urinary system.',
   'Top Herbs', 70),

  -- Q8
  ('BHC - Class 26 - Urinary I and Glycerites',
   'The Heart Formula glycerite is described as acting similarly to what class of pharmaceutical drug?',
   'Beta-blockers', 'Diuretics', 'ACE inhibitors', 'Calcium channel blockers',
   'c',
   'Hibiscus and Linden in the Heart Formula act on the angiotensin process, which is the same mechanism as ACE inhibitors — drugs that stop the angiotensin process to lower blood pressure.',
   'Hibiscus — part of the Heart Formula glycerite; acts like an ACE inhibitor by affecting the angiotensin process; used alongside Linden, Hawthorn leaf and flower, and Ginger for blood pressure support.',
   'Heart Formula', 80),

  -- Q9
  ('BHC - Class 26 - Urinary I and Glycerites',
   'Why should the Heart Formula glycerite NOT be taken at the same time as blood pressure pharmaceuticals?',
   'It reduces absorption of the drug', 'Blood pressure could go down too low', 'It increases liver clearance of the drug', 'It causes sodium retention',
   'b',
   'The notes explicitly warn: "don''t take at the same time as pharma — BP could go down too low." The herbs and the drug both lower blood pressure; combined timing risks excessive hypotension.',
   'Linden — part of the Heart Formula glycerite; helps the body restart natural blood pressure regulation after pharmaceutical medication wears off at midday. Do not take at the same time as BP pharmaceuticals — BP could go too low.',
   'Heart Formula', 90),

  -- Q10
  ('BHC - Class 26 - Urinary I and Glycerites',
   'In these notes, Skullcap is recommended as a nervine to address which underlying mechanism of kidney damage?',
   'Excess dietary oxalates', 'Bacterial colonization of the nephrons', 'Edema from renal failure', 'Chronic hypertensive state',
   'd',
   'The notes state: "the more you are in a hypertensive state, the more damage to the kidneys; have to then regulate the NS." Skullcap addresses this by calming the nervous system to reduce hypertension-mediated kidney damage.',
   'Skullcap as a nervine is useful for kidney health — the more one is in a hypertensive state, the more damage to the kidneys; regulating the nervous system helps protect kidney function.',
   'Juniper', 100),

  -- Q11
  ('BHC - Class 26 - Urinary I and Glycerites',
   'Gravel Root is described as the European analog to which food plant used for breaking down kidney stone oxalates?',
   'Watermelon seed', 'Red onion', 'Okra', 'Corn husk',
   'a',
   'The notes note "(also gravel root — European)" immediately after watermelon seed''s description for kidney stones, establishing Gravel Root as the European herbalist''s equivalent.',
   'Gravel Root — European analog to watermelon seed; used for breaking down oxalates in kidney stones.',
   'Top Herbs', 110),

  -- Q12
  ('BHC - Class 26 - Urinary I and Glycerites',
   'Which herb is listed as both a urinary diuretic AND specifically noted as a lymphatic herb for the urinary system?',
   'Horsetail', 'Cleavers', 'Nettle', 'Dandelion leaf',
   'b',
   'Cleavers appears in the Diuretics section and is additionally described as a lymphatic herb in the Top Herbs section — the only herb in these notes to explicitly carry both designations.',
   'Cleavers — lymphatic herb for the urinary system.',
   'Top Herbs', 120),

  -- Q13
  ('BHC - Class 26 - Urinary I and Glycerites',
   'What is the key distinction between Black Cohosh root and Black Cohosh leaf for urinary applications per these class notes?',
   'The leaf is more specific for bladder infections; the root is not', 'The root is preferred in Western herbalism; the leaf is more gentle', 'The leaf is antilithic; the root acts as a diuretic', 'They come from different botanical species',
   'b',
   'The notes record: "western — root / leaf more gentle," distinguishing the more common Western herbal practice (root) from the leaf preparation used when a gentler action is appropriate.',
   'Black Cohosh leaf — western herbalists typically use the root; the leaf is more gentle for urinary support.',
   'Top Herbs', 130),

  -- Q14
  ('BHC - Class 26 - Urinary I and Glycerites',
   'The Urinary System Support glycerite formula contains four herbs: Nettle, Burdock, Dandelion leaf, and one other. Which of the following is NOT in the formula?',
   'Burdock', 'Nettle', 'Dandelion leaf', 'Cleavers',
   'd',
   'The Urinary Formula glycerite contains Nettle, Burdock, Dandelion leaf, and Peppermint. Cleavers, while a urinary and lymphatic herb, is not listed in this specific formula.',
   'Nettle — part of the Urinary System Support glycerite with Burdock, Dandelion leaf, and Peppermint; purpose: move water and remove waste.',
   'Urinary Formula', 140),

  -- Q15
  ('BHC - Class 26 - Urinary I and Glycerites',
   'The Juniper tincture preparation described in these notes uses which part of the plant?',
   'Blue/Black Seed Cones (Berries)', 'Fresh green leaf tips', 'Root bark', 'Young branch tips',
   'a',
   'The notes specify: "Blue/Black Seed Cones (Berries) tincture 1:5 75% alcohol 20–40 drops" — the berries (mature seed cones) are the medicinal part used for the tincture preparation.',
   'Juniper (Juniperus communis) — Navajo tradition: used with Bayberry root bark as a tea; juniper berries used as a female contraceptive. Western European use: chronic bladder and kidney infections, atony for edema from renal failure, amenorrhea, gout, arthritis. Preparation: Blue/Black Seed Cones (Berries) tincture 1:5 75% alcohol 20–40 drops; infusion 2–3oz 3x day.',
   'Juniper', 150),

  -- Q16
  ('BHC - Class 26 - Urinary I and Glycerites',
   'What is the primary urinary action of Horsetail in these class notes?',
   'Diuretic', 'Antispasmodic', 'Antiseptic', 'Demulcent',
   'a',
   'Horsetail is listed under the Diuretics category — herbs that remove excess water and sodium from the body.',
   'Horsetail — listed as a urinary diuretic; removes excess water and sodium from the body.',
   'Diuretics', 160),

  -- Q17
  ('BHC - Class 26 - Urinary I and Glycerites',
   'Thuja occidentalis (White Cedar) is recorded in these notes for which urogenital indications?',
   'Kidney stone dissolution and gout relief', 'Swollen/inflamed urethra, weak urine stream, and frequent urge to urinate', 'Edema from renal failure and amenorrhea', 'Blood pressure regulation via angiotensin pathway',
   'b',
   'The notes list Thuja''s urogenital use as: "swollen & inflamed Urethra, weak urine stream; urge to urinate frequently; infection; STD (gonorrhea)." These are primarily urethral and lower urinary tract indications.',
   'Thuja occidentalis (White Cedar) — used by African Americans for asthma; Native Americans for fevers, coughs, headaches, swollen hands, and rheumatic problems. Skin: warts, oily/dry skin, eruptions, nail fungus, hemorrhoids. Urogenital: swollen/inflamed urethra, weak urine stream, frequent urge to urinate, infection, STD/gonorrhea.',
   'Juniper', 170),

  -- Q18
  ('BHC - Class 26 - Urinary I and Glycerites',
   'Which herb is described as "enzymatic" and helps break up fatty deposits in the urinary system?',
   'Sumac', 'Horsetail', 'Corn Silk', 'Usnea',
   'a',
   'Sumac is specifically described as "enzymatic" with the action of helping to break up fatty deposits — a mechanism distinct from the other urinary herbs listed.',
   'Sumac — enzymatic; helps to break up fatty deposits in the urinary system.',
   'Top Herbs', 180),

  -- Q19
  ('BHC - Class 26 - Urinary I and Glycerites',
   'What is the primary urinary indication for Marshmallow root in these class notes?',
   'Antiseptic', 'Antilithic', 'Diuretic', 'Demulcent',
   'd',
   'Marshmallow root is listed under Mucosal Tonics (demulcent) in the urinary actions section and confirmed in the Top Herbs section: "demulcent for the urinary system; helps the mucosal lining."',
   'Marshmallow root — demulcent for the urinary system; helps the mucosal lining and moves waste that is hot and sticky.',
   'Top Herbs', 190),

  -- Q20
  ('BHC - Class 26 - Urinary I and Glycerites',
   'According to the class notes, a GFR below 60 corresponds to what clinical classification?',
   'Stage 1 kidney disease', 'Stage 2 kidney disease', 'Urinary tract infection threshold', 'Nephrotic syndrome marker',
   'a',
   'The notes state: "GFR < 60 — stage 1 kidney disease; look at trends." The instructor emphasizes looking at trends over time rather than a single reading.',
   'Skullcap as a nervine is useful for kidney health — the more one is in a hypertensive state, the more damage to the kidneys; regulating the nervous system helps protect kidney function.',
   'Juniper', 200),

  -- Q21
  ('BHC - Class 26 - Urinary I and Glycerites',
   'Which herb is listed as a urinary antiseptic alongside Bearberry, Usnea, Lavender, and Yarrow?',
   'Thyme', 'Horsetail', 'Marshmallow', 'Burdock',
   'a',
   'Thyme is listed in the Antiseptics section alongside Bearberry (Uva ursi), Usnea, Juniper, Lavender, and Yarrow as herbs that kill bacteria in the urinary tract.',
   'Thyme — listed as a urinary antiseptic; kills bacteria in the urinary tract.',
   'Antiseptics', 210),

  -- Q22
  ('BHC - Class 26 - Urinary I and Glycerites',
   'When should Linden-based herbal support ideally be taken relative to blood pressure medication, per these class notes?',
   'At the same time to enhance the drug''s effect', 'At midday when the morning pharmaceutical is wearing off', 'Only at night before bed', 'First thing in the morning before medication',
   'b',
   'The notes explain the timing: after 3–4 hours, "maybe midday after taking drug in morning, pharma medicine wearing off, and Linden helps the body start the natural processes again." Taking it separately prevents the two acting simultaneously.',
   'Linden — part of the Heart Formula glycerite; helps the body restart natural blood pressure regulation after pharmaceutical medication wears off at midday. Do not take at the same time as BP pharmaceuticals — BP could go too low.',
   'Heart Formula', 220),

  -- Q23
  ('BHC - Class 26 - Urinary I and Glycerites',
   'Which herb in the urinary sedative category is described as the milder option, less potent than California Poppy?',
   'Skullcap', 'Kava', 'Chamomile', 'Lavender',
   'a',
   'The notes explicitly compare: "Skullcap — milder sedative" vs "California Poppy — stronger sedative," establishing a relative potency hierarchy for urinary nervous system support.',
   'Skullcap — milder sedative; supports the nervous system in the context of urinary and bladder health.',
   'Top Herbs', 230),

  -- Q24
  ('BHC - Class 26 - Urinary I and Glycerites',
   'In addition to general urinary health, what specific use of Juniper berries is recorded from Navajo tradition in these notes?',
   'Kidney stone dissolution tea', 'Wound healing wash', 'Anti-inflammatory decoction', 'Female contraceptive',
   'd',
   'The notes record: "juniper berries as a female contraceptive" — an ethnobotanical use attributed to the Navajo, separate from the Western European bladder and kidney indications.',
   'Juniper (Juniperus communis) — Navajo tradition: used with Bayberry root bark as a tea; juniper berries used as a female contraceptive. Western European use: chronic bladder and kidney infections, atony for edema from renal failure, amenorrhea, gout, arthritis.',
   'Juniper', 240),

  -- Q25
  ('BHC - Class 26 - Urinary I and Glycerites',
   'Which herb is described as providing "warming and metabolism support" for the urinary system in the Top Herbs section?',
   'Peppermint', 'Ginger', 'Lavender', 'Chamomile',
   'b',
   'Ginger is specifically described as "warming and metabolism" in the urinary context — a warming herb that contrasts with the cooling, demulcent approach of herbs like Marshmallow or Corn Silk.',
   'Ginger — warming and metabolism support for the urinary system.',
   'Top Herbs', 250),

  -- Q26
  ('BHC - Class 26 - Urinary I and Glycerites',
   'What does Dandelion leaf''s diuretic action primarily eliminate from the body, per these class notes?',
   'Bacteria and toxins', 'Fatty deposits and oxalates', 'Inflammatory mediators', 'Excess water and sodium',
   'd',
   'All the urinary diuretics in these notes are described as removing "excess water and also sodium." This aligns with the broader Hormones section discussion of sodium retention as the core urinary imbalance.',
   'Dandelion leaf — listed as a urinary diuretic; removes excess water and sodium from the body.',
   'Diuretics', 260),

  -- Q27
  ('BHC - Class 26 - Urinary I and Glycerites',
   'Which herb in the Heart Formula is specifically described as helping the body restart its natural blood pressure regulation after pharmaceutical medication wears off?',
   'Hibiscus', 'Ginger', 'Linden', 'Hawthorn',
   'c',
   'The notes describe Linden''s role precisely: after the drug''s angiotensin-blocking effect wears off at midday, Linden "helps the body start the natural processes again" — acting as a bridge during the pharmaceutical taper.',
   'Linden — part of the Heart Formula glycerite; helps the body restart natural blood pressure regulation after pharmaceutical medication wears off at midday.',
   'Heart Formula', 270),

  -- Q28
  ('BHC - Class 26 - Urinary I and Glycerites',
   'What urinary tract action category does Gravel Root primarily belong to in these class notes?',
   'Antilithic (antistone)', 'Antiseptic', 'Diaphoretic', 'Demulcent',
   'a',
   'Gravel Root is used for breaking down kidney stone oxalates — the definition of antilithic action (reducing stone formation or helping dissolve existing stones).',
   'Gravel Root — European analog to watermelon seed; used for breaking down oxalates in kidney stones.',
   'Top Herbs', 280),

  -- Q29
  ('BHC - Class 26 - Urinary I and Glycerites',
   'Corn Silk is indicated for which urinary concern in these class notes?',
   'Blood pressure regulation via the angiotensin pathway', 'Urinary tract infection via direct antiseptic action', 'Kidney pain and cooling inflammation', 'Kidney stone dissolution via antilithic action',
   'c',
   'The notes describe Corn (silk and husk) for "kidney pain and cooling inflammation" — a cooling, soothing indication distinct from the antiseptic or stone-dissolving herbs.',
   'Corn (silk and husk) — for kidney pain and cooling inflammation in the urinary tract.',
   'Top Herbs', 290),

  -- Q30
  ('BHC - Class 26 - Urinary I and Glycerites',
   'Which pair correctly identifies the relative sedative potency of two urinary herbs in these notes?',
   'California Poppy (milder), Kava (stronger)', 'Kava (milder), Skullcap (stronger)', 'Chamomile (milder), Skullcap (stronger)', 'Skullcap (milder), California Poppy (stronger)',
   'd',
   'The notes explicitly contrast: "Skullcap — milder sedative" and "California Poppy — stronger sedative," establishing California Poppy as the more potent of the two for urinary nervous system support.',
   'Skullcap — milder sedative; supports the nervous system in the context of urinary and bladder health.',
   'Top Herbs', 300),

  -- Q31
  ('BHC - Class 26 - Urinary I and Glycerites',
   'What is the scope of Juniper''s Western European urinary indications as recorded in these class notes?',
   'Only acute urinary tract infections', 'Only bladder-specific infections', 'Chronic bladder/kidney infections, edema, amenorrhea, gout, and arthritis', 'Kidney stones and bladder spasms only',
   'c',
   'Western European use of Juniper covers multiple systems: chronic bladder and kidney infections, edema from renal failure, amenorrhea, and musculoskeletal pain (gout, arthritis) — a broad restorative profile.',
   'Juniper (Juniperus communis) — ...Western European use: chronic bladder and kidney infections, atony for edema from renal failure, amenorrhea, gout, arthritis.',
   'Juniper', 310),

  -- Q32
  ('BHC - Class 26 - Urinary I and Glycerites',
   '`Awa (also known as Kava) is described with what primary actions relevant to the urinary system?',
   'Sedating and relaxing', 'Diuretic and antiseptic', 'Anti-inflammatory and antilithic', 'Demulcent and antispasmodic',
   'a',
   '`Awa / Kava is described as "sedating, relaxing" in the Top Herbs section — addressing urinary tension and nervous-system-driven bladder dysfunction rather than infection or stones.',
   '`Awa (also Kava) — sedating, relaxing; useful for bladder tension and urinary system support.',
   'Top Herbs', 320),

  -- Q33
  ('BHC - Class 26 - Urinary I and Glycerites',
   'Which of the following herbs is listed in the Diuretics category in these class notes?',
   'Usnea', 'Dandelion leaf', 'Chamomile', 'Thyme',
   'b',
   'Dandelion leaf is listed in the Diuretics section alongside Cleavers, Nettle, and Horsetail. Usnea and Thyme are antiseptics; Chamomile is listed in the Top Herbs section without a specific category.',
   'Dandelion leaf — listed as a urinary diuretic; removes excess water and sodium from the body.',
   'Diuretics', 330),

  -- Q34
  ('BHC - Class 26 - Urinary I and Glycerites',
   'Beyond its diuretic action, Nettles is specifically noted as necessary for which physiological function?',
   'Red blood cell production', 'Kidney filtration rate improvement', 'Breaking down kidney stones', 'Regulating sodium retention via potassium',
   'a',
   'The notes state: "Nettles — necessary for red blood cell production" — a nutritive action related to the kidneys'' role in producing erythropoietin, which stimulates red blood cell production.',
   'Nettles — necessary for red blood cell production; diuretic for the urinary system.',
   'Top Herbs', 340),

  -- Q35
  ('BHC - Class 26 - Urinary I and Glycerites',
   'Hawthorn leaf and flower is part of which formula in these class notes?',
   'The Urinary System Support glycerite', 'Both the urinary and heart formulas', 'Neither formula — it is listed in the Top Herbs section only', 'The Heart Formula glycerite',
   'd',
   'Hawthorn leaf and flower is listed exclusively in the Heart Formula glycerite alongside Hibiscus, Ginger, and Linden. It does not appear in the Urinary Formula.',
   'Hawthorn leaf and flower — part of the Heart Formula glycerite with Hibiscus, Linden, and Ginger for blood pressure support.',
   'Heart Formula', 350),

  -- Q36
  ('BHC - Class 26 - Urinary I and Glycerites',
   'In the class notes'' urinary action categories, which category does Usnea belong to?',
   'Diuretic', 'Demulcent', 'Mucosal Tonic', 'Antiseptic',
   'd',
   'Usnea is listed in the Antiseptics section — herbs that kill bacteria in the urinary tract. Its broad-spectrum antimicrobial action (including against resistant organisms) makes it a classic urinary antiseptic.',
   'Usnea — listed as a urinary antiseptic; kills bacteria in the urinary tract.',
   'Antiseptics', 360),

  -- Q37
  ('BHC - Class 26 - Urinary I and Glycerites',
   'What is the primary safety concern when combining herbal Heart Formula glycerites with pharmaceutical blood pressure medication?',
   'The herbs increase the drug''s side effects', 'Blood pressure may drop too low', 'Glycerin base interferes with medication absorption', 'The herbs slow the liver''s metabolism of the drug',
   'b',
   'The notes warn explicitly: "don''t take at the same time as pharma — BP could go down too low." Both mechanisms lower blood pressure; simultaneous use risks excessive hypotension.',
   'Linden — part of the Heart Formula glycerite; helps the body restart natural blood pressure regulation after pharmaceutical medication wears off at midday. Do not take at the same time as BP pharmaceuticals — BP could go too low.',
   'Heart Formula', 370),

  -- Q38
  ('BHC - Class 26 - Urinary I and Glycerites',
   'Thuja occidentalis (White Cedar) is recorded in these notes for which skin conditions?',
   'Eczema, psoriasis, and rosacea', 'Burns, stretch marks, and wounds', 'Warts, oily/dry skin, eruptions, nail fungus, and hemorrhoids', 'Acne, folliculitis, and boils',
   'c',
   'The notes list these specific Thuja skin uses: "warts, oily, dry skin, eruptions, nail fungus, hemorrhoids" — primarily surface and structural skin conditions rather than inflammatory dermatological diagnoses.',
   'Thuja occidentalis (White Cedar) — ...Skin: warts, oily/dry skin, eruptions, nail fungus, hemorrhoids.',
   'Juniper', 380),

  -- Q39
  ('BHC - Class 26 - Urinary I and Glycerites',
   'Willow bark''s inclusion in the urinary Top Herbs section is attributed to which therapeutic action?',
   'Antimicrobial', 'Diuretic', 'Analgesic (pain relief)', 'Anti-inflammatory',
   'c',
   'The notes list Willow bark with a single-word indication: "pain." This corresponds to its salicylate-based analgesic action, useful for urinary pain and discomfort.',
   'Willow bark — used for pain relief in the urinary system.',
   'Top Herbs', 390),

  -- Q40
  ('BHC - Class 26 - Urinary I and Glycerites',
   'What tincture preparation ratio is given for Juniper (Blue/Black Seed Cones) in these class notes?',
   '1:5 in 75% alcohol, 20–40 drops', '1:3 in 60% alcohol, 30–60 drops', '1:10 in 95% alcohol, 5–10 drops', 'Fresh plant 1:2 in 40% alcohol',
   'a',
   'The notes specify: "Blue/Black Seed Cones (Berries) tincture 1:5 75% alcohol 20-40 drops" — the 75% alcohol is notably high, appropriate for extracting the volatile oils in Juniper berries.',
   'Juniper (Juniperus communis) — ...Preparation: Blue/Black Seed Cones (Berries) tincture 1:5 75% alcohol 20–40 drops; infusion 2–3oz 3x day.',
   'Juniper', 400),

  -- Q41
  ('BHC - Class 26 - Urinary I and Glycerites',
   'What is the stated purpose of the Urinary System Support glycerite formula (Nettle, Burdock, Dandelion leaf, Peppermint)?',
   'Reduce bladder inflammation and kill bacteria', 'Relax bladder spasms and provide pain relief', 'Tonify kidney tissue and improve GFR', 'Move water and remove waste',
   'd',
   'The formula is introduced with its purpose: "move water and remove waste" — a tonic, draining approach rather than an anti-infective or antispasmodic one.',
   'Burdock — part of the Urinary System Support glycerite with Nettle, Dandelion leaf, and Peppermint; purpose: move water and remove waste.',
   'Urinary Formula', 410),

  -- Q42
  ('BHC - Class 26 - Urinary I and Glycerites',
   'Which urinary herb is specifically noted for addressing chronic kidney disease in addition to general inflammation?',
   'Yarrow', 'Goldenrod', 'Horsetail', 'Bearberry',
   'b',
   'Goldenrod is the only herb in the Top Herbs section where "chronic kidney disease" is listed as a specific indication alongside inflammation and antiseptic action.',
   'Goldenrod — addresses inflammation and chronic kidney disease; acts as a urinary antiseptic.',
   'Top Herbs', 420),

  -- Q43
  ('BHC - Class 26 - Urinary I and Glycerites',
   'In these class notes, which substance produced by the kidneys stimulates red blood cell production in bone marrow?',
   'Renin', 'Calcitriol', 'Erythropoietin', 'Aldosterone',
   'c',
   'The Hormones section notes: "Erythropoietin — stimulate production of red blood cells in order for the kidneys to get healthy blood quality." This is also why Nettle, which supports red blood cell production, is linked to kidney health.',
   'Dandelion root reduces sodium with their potassium level — useful when hormones like Aldosterone, Estrogen, and Cortisol encourage kidneys to retain sodium and water.',
   'Hormones', 430),

  -- Q44
  ('BHC - Class 26 - Urinary I and Glycerites',
   'Which herb provides warming support in the Heart Formula glycerite alongside the cardiovascular herbs Hibiscus, Linden, and Hawthorn?',
   'Yarrow', 'Ginger', 'Peppermint', 'Lavender',
   'b',
   'Ginger is listed in both the Urinary Top Herbs section (warming and metabolism) and the Heart Formula (as the warming component alongside the cardiovascular herbs). Peppermint is in the Urinary Formula, not the Heart Formula.',
   'Ginger — part of the Heart Formula glycerite with Hibiscus, Linden, and Hawthorn for blood pressure support.',
   'Heart Formula', 440),

  -- Q45
  ('BHC - Class 26 - Urinary I and Glycerites',
   'For urinary nervous system support, which herb is listed as the mildest option among Kava, Skullcap, and California Poppy?',
   'California Poppy', 'Kava', 'Skullcap', 'All are considered equally potent',
   'c',
   'The notes stratify three sedative options: Kava (sedating, relaxing), Skullcap ("milder sedative"), and California Poppy ("stronger sedative"). Skullcap is therefore the mildest of the three.',
   'Skullcap — milder sedative; supports the nervous system in the context of urinary and bladder health.',
   'Top Herbs', 450),

  -- Q46
  ('BHC - Class 26 - Urinary I and Glycerites',
   'What energetic and flavor qualities of Aloe make it specifically suited for bladder conditions in these notes?',
   'Warming, stimulating, and tonic', 'Cooling, bitter, and astringent', 'Demulcent, sweet, and nourishing', 'Diuretic and diaphoretic',
   'b',
   'The notes describe Aloe as "cooling, bitter, astringent" — qualities that address hot, inflammatory bladder conditions like UTI and cystitis. This energetic profile is distinct from warming herbs like Ginger.',
   'Aloe — cooling, bitter, astringent; best indicated for the bladder — UTI, cystitis.',
   'Top Herbs', 460),

  -- Q47
  ('BHC - Class 26 - Urinary I and Glycerites',
   'What is the Juniper infusion dose recorded in these class notes for Western European use?',
   '1 cup 2x day', 'Half cup 4x day', '2–3 oz 3x day', '4 oz once daily',
   'c',
   'The notes specify: "Infusion 2-3oz 3x day" — a small, frequent dose consistent with the aromatic and potentially irritating nature of Juniper.',
   'Juniper (Juniperus communis) — ...Preparation: Blue/Black Seed Cones (Berries) tincture 1:5 75% alcohol 20–40 drops; infusion 2–3oz 3x day.',
   'Juniper', 470),

  -- Q48
  ('BHC - Class 26 - Urinary I and Glycerites',
   'Which skin condition of the urogenital area is specifically mentioned in Thuja''s urogenital indications?',
   'Hemorrhoids', 'Warts', 'Psoriasis', 'Eczema',
   'a',
   'The notes include "hemorrhoids" in the Thuja skin list, and the urogenital section mentions "swollen & inflamed Urethra." Hemorrhoids bridge the skin/urogenital categories as a perianal condition.',
   'Thuja occidentalis (White Cedar) — ...Skin: warts, oily/dry skin, eruptions, nail fungus, hemorrhoids. Urogenital: swollen/inflamed urethra, weak urine stream, frequent urge to urinate, infection, STD/gonorrhea.',
   'Juniper', 480),

  -- Q49
  ('BHC - Class 26 - Urinary I and Glycerites',
   'Which herb''s inclusion in the Urinary Formula reflects its role as a cooling, aromatic complement to the more tonifying herbs Nettle, Burdock, and Dandelion leaf?',
   'Yarrow', 'Lavender', 'Peppermint', 'Chamomile',
   'c',
   'Peppermint is the fourth herb in the Urinary System Support glycerite alongside the three heavier tonics. Its cooling, aromatic quality complements the formula''s draining purpose without duplicating the other herbs'' actions.',
   'Peppermint — part of the Urinary System Support glycerite with Nettle, Burdock, and Dandelion leaf; purpose: move water and remove waste.',
   'Urinary Formula', 490),

  -- Q50
  ('BHC - Class 26 - Urinary I and Glycerites',
   'Which herb in the Heart Formula is specifically described as acting on the angiotensin process to lower blood pressure — similar to an ACE inhibitor?',
   'Linden', 'Hawthorn leaf and flower', 'Ginger', 'Hibiscus',
   'd',
   'The notes state that Hibiscus "acts like an ACE inhibitor by affecting the angiotensin process." Linden helps restart natural processes after the drug wears off, but it is Hibiscus that is compared to the ACE inhibitor mechanism.',
   'Hibiscus — part of the Heart Formula glycerite; acts like an ACE inhibitor by affecting the angiotensin process; used alongside Linden, Hawthorn leaf and flower, and Ginger for blood pressure support.',
   'Heart Formula', 500);

END $$;
