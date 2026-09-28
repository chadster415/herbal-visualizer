-- Migration 356: Class 27 – Nutrition 2 and Herbal Energetics – Quiz Questions
--
-- Class name: BHC - Class 27 - Nutrition 2 and Herbal Energetics
--
-- Question count calculation:
--   H = ~90 distinct herbs + supplements identified (75 herbs + 15 supplements)
--   F = ~8 named factual items (Iron Tonic recipe, Herbal Broth recipe, Herbal Salt recipe,
--       Vitamin D 3000 IU/day, Shatavari = decoction not tincture, Yellow Dock constipation note,
--       Astragalus drives infection deeper, Schisandra cortisol)
--   target = clamp(15 + 90×4 + 8, 20, 50) = clamp(383, 20, 50) = 50
--   Rounded to nearest 5 = 50

SET search_path TO herbal, public;

DO $MIGRATION$
BEGIN
  IF EXISTS (
    SELECT 1 FROM herbal.class_quiz_questions
    WHERE class_name = 'BHC - Class 27 - Nutrition 2 and Herbal Energetics'
  ) THEN
    RAISE NOTICE 'Class 27 quiz questions already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_quiz_questions
    (class_name, question_text, option_a, option_b, option_c, option_d,
     correct_option, explanation, snippet_text, section_header, sort_order)
  VALUES

  -- Q1: Calendula in broths
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'Which herb added to broths is described as a "vulnerary, healing and stimulant for the immune function of all mucus membranes, lymph mover"?',
   'Nettle', 'Reishi', 'Calendula', 'Oregano',
   'c',
   'The notes specifically name calendula (Pot marigold) with all three actions: vulnerary, mucous membrane immune stimulant, and lymph mover.',
   'calendula - Pot marigold, put it in the pot! - vulnerary, healing and stimulant for the immune function of all mucus membranes, lymph mover',
   'Broths', 10),

  -- Q2: Antimicrobial broth herbs
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'Three herbs listed for broths are described simply as "antimicrobial." Which of the following is NOT one of them?',
   'Oregano', 'Thyme', 'Calendula', 'Rosemary',
   'c',
   'Calendula is described as vulnerary and a mucous membrane stimulant, not as antimicrobial. Oregano, thyme, and rosemary are the three antimicrobial broth herbs.',
   'oregano - antimicrobial / thyme - antimicrobial / rosemary - antimicrobial',
   'Broths', 20),

  -- Q3: Astragalus caution
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'What is the specific concern noted about Astragalus in acute conditions?',
   'It can cause liver toxicity if used too long',
   'It is so potent in moistening it can drive infection deeper into the tissues',
   'It thins the blood and should be avoided with fever',
   'It competes with antibiotics for receptor sites',
   'b',
   'The notes state Astragalus is "so potent in moistening, it can push the body to dampness; so if acute conditions, can drive the infection deeper into the tissues."',
   'Astragalus is so potent in moistening, it can push the body to dampness; so if acute conditions, can drive the infection deeper into the tissues',
   'General Recommendations', 30),

  -- Q4: Neti pot herbs
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'Which two herbs are recommended for use as the liquid in a neti pot for sinus infection?',
   'Elderflower and Oregano',
   'Rosemary and Thyme',
   'Calendula and Yerba Mansa',
   'Goldenseal and Echinacea',
   'c',
   'The notes specify: "Neti pot - add Calendula tea or Yerba Mansa tea as the liquid, if infection."',
   'Neti pot - add Calendula tea or Yerba Mansa tea as the liquid, if infection',
   'General Recommendations', 40),

  -- Q5: Alfalfa in salts
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'Why is alfalfa highlighted as especially useful in herbal salt blends?',
   'It is highly antimicrobial and preserves the blend',
   'It is a legume high in vitamins, good for estrogen pathways, and tastes like salt',
   'It is the strongest carminative of the salt herbs',
   'It provides the most Vitamin C of any herb in the blend',
   'b',
   'The notes describe alfalfa as "high vitamin, legume, so good for estrogen pathways, and tastes like salt."',
   'alfalfa - high vitamin, legume, so good for estrogen pathways, and tastes like salt',
   'Salts', 50),

  -- Q6: Fennel action
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'What primary action is attributed to fennel seeds in the salt blend context?',
   'Antimicrobial', 'Vulnerary', 'Carminative', 'Hemostatic',
   'c',
   'The notes describe fennel seeds as "excellent as a carminative."',
   'fennel seeds - excellent as a carminative',
   'Salts', 60),

  -- Q7: Iron Tonic - Yellow Dock
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'Why is Yellow Dock included in the Iron Tonic Syrup, and when can it be omitted?',
   'For its high iron content; omit if the patient has diarrhea',
   'As a liver bitter to aid absorption; omit if the patient is taking blood thinners',
   'For patients who tend toward constipation from iron; can omit if not constipated',
   'As the primary iron source; omit if already eating red meat',
   'c',
   'The notes state Yellow Dock "in there for people who tend toward constipation, can omit if not constipated."',
   'Yellow dock in there for people who tend toward constipation, can omit if not constipated',
   'Iron', 70),

  -- Q8: Iron Tonic - dosage / safety
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'What safety concern is raised about the Iron Tonic Syrup if dietary Vitamin C is insufficient?',
   'The molasses can ferment and cause GI upset',
   'The raspberry leaf can over-constrict the uterus',
   'Bioaccumulation of iron can occur if there is not enough Vitamin C in the diet',
   'Yellow dock''s oxalates can form kidney stones without adequate hydration',
   'c',
   'The notes warn: "careful of bioaccumulation of iron, can happen if not enough Vit C in diet."',
   'careful of bioaccumulation of iron, can happen if not enough Vit C in diet',
   'Iron', 80),

  -- Q9: Shatavari prep method
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'What is noted as the traditional preparation method for shatavari, distinguishing it from most Western tincture-based herbs?',
   'It must be prepared as a flower essence, not a tincture',
   'Traditionally a decoction, not a tincture',
   'It is only effective as a fresh juice, not dried',
   'It should be taken as a dry powder in warm milk',
   'b',
   'The notes state: "shatavari - traditionally a decoction, not a tincture."',
   'shatavari - traditionally a decoction, not a tincture',
   'Moistening Herbs', 90),

  -- Q10: Shepherd's Purse specificity
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'Among the constricting herbs listed, which is described as "specific for stopping bleeding"?',
   'Oak', 'Yarrow', 'Raspberry leaf', 'Shepherd''s purse',
   'd',
   'The notes specifically identify shepherd''s purse as "specific for stopping bleeding" among the constricting tannin herbs.',
   'shepherd''s purse - specific for stopping bleeding',
   'Constricting Herbs', 100),

  -- Q11: Raspberry leaf use pattern
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'How does the instructor recommend using raspberry leaf as a uterine tonic?',
   'Only during acute heavy bleeding episodes',
   'Starting two weeks before menstruation',
   'More helpful to take all cycle long rather than just acutely',
   'As a high-dose decoction for 3 days before menses',
   'c',
   'The notes say raspberry leaf is a "uterine tonic, maybe acutely, but more helpful to take all cycle long."',
   'raspberry leaf - uterine tonic, maybe acutely, but more helpful to take all cycle long',
   'Constricting Herbs', 110),

  -- Q12: Solomon's Seal specificity
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'What is the notable dual action of Solomon''s Seal described in the laxness section?',
   'It both stimulates and sedates the nervous system depending on dose',
   'It loosens what''s too tight and tightens what''s too loose, specific for musculoskeletal',
   'It tonifies the kidneys and relaxes the bladder simultaneously',
   'It acts as both a demulcent and an astringent for the GI tract',
   'b',
   'The notes state Solomon''s Seal "loosens what''s too tight and tightens what''s too loose - musculoskeletal."',
   'Solomon''s Seal - loosens what''s too tight and tightens what''s too loose - musculoskeletal',
   'Signs of Laxness', 120),

  -- Q13: Schizandra specificity
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'For what specific sign of laxness is Schizandra described as the targeted remedy?',
   'Chronic diarrhea', 'Excessive sweating', 'Excess discharges', 'Leaky bladder',
   'c',
   'The notes state: "Schizandra specific for excess discharges."',
   'Schizandra specific for excess discharges',
   'Signs of Laxness', 130),

  -- Q14: Cooling herbs - Blue Vervain
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'Blue vervain is described as cooling and belonging to which taste category, with what nervous system character?',
   'Sweet; calming and nourishing',
   'Bitter; NS-related, relaxing',
   'Pungent; stimulating and dispersing',
   'Salty; grounding and mineralizing',
   'b',
   'The notes place blue vervain in cooling herbs and describe it as "(all bitters except Orange peel and angelica) - NS related, relaxing."',
   'blue vervain - cooling; all bitters except Orange peel and angelica; NS related, relaxing; "type A people will die with a to do list"',
   'Cooling Herbs', 140),

  -- Q15: Peach leaf uses
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'Peach leaf is described as an underused cooling herb. Which combination of uses is specifically mentioned?',
   'UTI and kidney inflammation',
   'Anxiety and insomnia',
   'Nausea (internally), bee stings and bug bites (topically)',
   'Fever and hot flashes',
   'c',
   'The notes say peach leaf helps "for nausea, anything hot; topical for bee stings and bug bites."',
   'peach leaf - cooling, underused; helps for nausea, anything hot; topical for bee stings and bug bites',
   'Cooling Herbs', 150),

  -- Q16: Rhodiola pair note
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'Rhodiola is listed as a drying herb. What companion herb is suggested to counter its drying nature?',
   'Marshmallow', 'Violet', 'Shatavari', 'Mullein',
   'c',
   'The notes mention "Rhodiola - improves stamina, hormones (+ shatavari maybe to moisten)."',
   'rhodiola - drying herb; improves stamina, hormones (+ shatavari maybe to moisten)',
   'Drying Herbs', 160),

  -- Q17: Mugwort cold infusion
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'The instructor suggests making mugwort as a cold infusion. Which herbs are named as additions to balance its bitterness?',
   'Licorice, ginger, or fennel',
   'Marshmallow, chamomile, or lemon balm',
   'Rose hips, hibiscus, or hawthorn',
   'Skullcap, passionflower, or catnip',
   'b',
   'The notes say: "mugwort → bitter (try a cold infusion, fresh or dry, add marshmallow, chamomile or lemon balm)."',
   'mugwort → bitter; try a cold infusion, fresh or dry; add marshmallow, chamomile or lemon balm',
   'Bitter Herbs', 170),

  -- Q18: Why not dilute bitters in water
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'The instructor states it "doesn''t make sense to dilute bitters in water." What is the reason given?',
   'Bitter constituents are water-insoluble and won''t extract properly',
   'You need the bitter taste to activate bile; diluting defeats the purpose',
   'Bitters are too strong and cause vomiting if taken in water',
   'Water extractions remove the terpenes that give bitters their action',
   'b',
   'The notes state: "doesn''t make sense to dilute in water, because you need the bitter taste to activate bile, etc."',
   'doesn''t make sense to dilute in water, because you need the bitter taste to activate bile, etc',
   'Bitter Herbs', 180),

  -- Q19: Schisandra 5 flavors
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'Schisandra is called "the 5 flavor berry." Which pairing of properties is attributed to it in the notes?',
   'Diuretic and lymphatic; used for edema',
   'Liver protective like milk thistle; helps regulate cortisol; focus, clarity, confidence',
   'Hemostatic and uterine tonic; used for heavy bleeding',
   'Antimicrobial and anti-inflammatory; used for acute infections',
   'b',
   'The notes describe Schisandra as "liver protective like milk thistle; focus, clarity; zing and confidence; helps regulate cortisol; associated with longevity and beauty in TCM."',
   'Schisandra - the 5 flavor berry; liver protective like milk thistle; focus, clarity; zing and confidence; helps regulate cortisol; balances energy; associated with longevity and beauty in TCM',
   'Schisandra', 190),

  -- Q20: Salty herbs direction / action
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'The salty flavor is described as having a specific directional quality. What direction and organ system does it direct energy toward?',
   'Upward, toward the heart and lungs',
   'Outward, toward the skin and surface',
   'Downward, toward the kidneys',
   'Inward, toward the liver',
   'c',
   'The notes state salty herbs have a "downward direction; specific for directing energy to the kidney."',
   'downward direction; specific for directing energy to the kidney; balances fluids, restore electrolyte balances, nourishes kidney and bladder',
   'Salty Herbs', 200),

  -- Q21: Sour herbs primary properties
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'What are the key properties attributed to sour herbs in the flavors framework?',
   'Warming and dispersing; stimulate metabolism',
   'Cooling and astringing; tonify tissues, protect against oxidative stress, support the liver',
   'Moistening and nourishing; build tissues and fluids',
   'Drying and clearing; stimulate bile and digestion',
   'b',
   'The notes describe sour herbs as "cooling, astringing; tonify tissues, protect against oxidative stress, supports the liver."',
   'hibiscus → sour; cooling, astringing; antioxidant, tonic, hepatic; fruit acids, flavonoids, antioxidants',
   'Sour Herbs', 210),

  -- Q22: Sweet herbs constituents
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'The sweet flavor in herbs is associated with which primary constituents?',
   'Tannins and organic acids',
   'Volatile oils and resins',
   'Polysaccharides and saponins',
   'Alkaloids and flavonoids',
   'c',
   'The notes state sweet herbs contain "polysaccharides, saponins" and have nourishing, adaptogenic, immune-enhancing properties.',
   'astragalus → sweet; nourishes and builds tissues; polysaccharides, saponins; adaptogenic, immune enhancing',
   'Sweet Herbs', 220),

  -- Q23: Pungent herb constituents
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'Pungent herbs are described as "movers, potentiators." What are their primary constituents?',
   'Polysaccharides and beta-glucans',
   'Fruit acids and flavonoids',
   'Resins and monoterpenes',
   'Mucilage and demulcent polysaccharides',
   'c',
   'The notes state pungent herbs contain "resins, monoterpenes" and are circulatory and digestive stimulants.',
   'Pungent Herbs - constituents: resins, monoterpenes; properties: circ & digestive stimulant, diaphoretic',
   'Pungent Herbs', 230),

  -- Q24: Vitamin D specifics
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'What daily dose of Vitamin D is recommended in the notes, and what secondary benefit is noted when combined with Vitamin K?',
   '1000 IU/day; reduces inflammation',
   '2000 IU/day; supports progesterone production',
   '3000 IU/day; increases insulin sensitivity and supports blood sugar homeostasis',
   '5000 IU/day; improves thyroid function',
   'c',
   'The notes state "recommended dose 3000 IU/day" and that the Vit D + Vit K combo "can increase insulin sensitivity and so support blood sugar homeostasis."',
   'recommended dose 3000 IU/day; combo with Vit K can increase insulin sensitivity and so support blood sugar homeostasis',
   'Vitamin D', 240),

  -- Q25: Why not supplement Vitamin A directly
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'Why does the instructor recommend supplementing with Beta-carotene rather than Vitamin A directly?',
   'Vitamin A is not absorbed orally and must be given as an injection',
   'Vitamin A can bioaccumulate to toxic levels; Beta-carotene is the safer precursor',
   'Vitamin A destroys gut flora at supplemental doses',
   'Beta-carotene is cheaper and more widely available',
   'b',
   'The notes state: "don''t supplement with Vit A, but with Beta carotene, due to toxicity if buildup."',
   'don''t supplement with Vit A, but with Beta carotene, due to toxicity if buildup',
   'Vitamin A', 250),

  -- Q26: Folate (B9) cognitive link
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'Beyond its role in red blood cell production, B9 (Folate) low levels are associated with what additional concern, and through what mechanism?',
   'Poor immune function, through T-cell modulation',
   'Cognitive decline, through its role in methylation (liver detox pathway)',
   'Hormonal imbalance, through cholesterol synthesis',
   'Skin disorders, through collagen crosslinking',
   'b',
   'The notes state: "B9 = Folate - low levels associated with cognitive decline, related to role in methylation (liver detox pathway)."',
   'B9 = Folate: works with B12 to form red blood cells, needed for DNA production; low levels associated with cognitive decline, related to role in methylation (liver detox pathway)',
   'Vitamin B', 260),

  -- Q27: Selenium reproductive associations
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'Selenium is an antioxidant mineral associated with thyroid support. What two reproductive conditions is it also associated with?',
   'Endometriosis and infertility',
   'Fibroids and endometriosis',
   'PCOS and premenstrual syndrome',
   'Amenorrhea and PCOS',
   'b',
   'The notes state selenium is "assoc also with repro: fibroids and endomet; therapy as well for PCOS."',
   'Selenium: antioxidant; lean into for any thyroid disorders; assoc also with repro: fibroids and endomet; therapy as well for PCOS',
   'Selenium', 270),

  -- Q28: Zinc reproductive
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'Zinc is associated with poor immune function. What additional reproductive pattern should prompt consideration of Zinc?',
   'Low testosterone and erectile dysfunction',
   'PCOS and excess androgens',
   'Fibroids and endometriosis',
   'Postpartum depression and low milk supply',
   'c',
   'The notes state Zinc is "associated with fibroids and endometriosis as well; think of when someone with chronic low immunity or repro problems."',
   'Zinc: related to poor immune function; associated with fibroids and endometriosis; think of for chronic low immunity or repro problems',
   'Zinc', 280),

  -- Q29: Iron absorption
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'What nutrient must be present in sufficient amounts for iron to be properly absorbed, and what is the problem with the most common iron supplement?',
   'Magnesium; common iron supplements cause headaches',
   'Vitamin C; Ferrous Sulfate is extremely constipating',
   'Vitamin D; most iron supplements cause liver stress',
   'Folate; most iron supplements cause nausea',
   'b',
   'The notes state: "have to get enough Vitamin C to absorb; most common supplement for this extremely constipating - Ferrous Sulfate."',
   'Iron: have to get enough Vitamin C to absorb; most common supplement for this extremely constipating - Ferrous Sulfate',
   'Iron', 290),

  -- Q30: Herbal Broth - Astragalus contraindication follow-up
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'Astragalus is included in the Herbal Broth Recipe. Given the note about its moistening nature, when would you pause its use?',
   'When the patient has kidney stones',
   'In acute infections where driving dampness deeper could worsen the condition',
   'In patients with liver disease due to hepatotoxicity risk',
   'During pregnancy due to uterine stimulating effects',
   'b',
   'The notes warn Astragalus "can push the body to dampness; so if acute conditions, can drive the infection deeper into the tissues."',
   'Astragalus is so potent in moistening, it can push the body to dampness; so if acute conditions, can drive the infection deeper into the tissues',
   'General Recommendations', 300),

  -- Q31: Energetics framework - cold signs
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'In the Western herbalism energetics framework, which of the following is listed as a sign of a "cold" constitution needing warming herbs?',
   'Red pointed tongue, restlessness, excess thirst',
   'Congestion, phlegm, loose stools, nausea',
   'Pale or bluish tongue, cold hands/feet, fatigue, low BBT',
   'Dry eyes, brittle nails, stiff joints, pebbly stools',
   'c',
   'The notes list signs of cold including "pale or bluish tongue, cold hands/feet, slow moving, fatigue, low BBT - basal body temp."',
   'Signs of cold: pale or bluish tongue, cold hands/feet, slow moving, fatigue, low BBT - basal body temp',
   'Warming Herbs', 310),

  -- Q32: Drying vs moistening energetics
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'A patient presents with swollen lymph nodes, excess vaginal discharge, and sluggishness. According to the energetics framework, what tissue state do they primarily show?',
   'Cold and tense', 'Hot and constricted', 'Damp and lax', 'Dry and tonic',
   'c',
   'The notes list "swelling extremities, lymph, excess discharge, sluggishness" as signs of dampness, and "excess discharge, leaky bladder" as signs of laxness.',
   'Signs of dampness: swelling extremities, lymph; sluggishness; excess discharge / Signs of laxness: leaky bladder, excess discharge',
   'Signs of Laxness', 320),

  -- Q33: Constitutions can coexist
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'Can a patient have a general constitution that differs from their current acute presentation?',
   'No; the constitution determines all acute presentations',
   'Yes; you can be a hot damp person and present a dry and cold lung condition',
   'Only if they are using pharmaceuticals that alter their base constitution',
   'Only in elderly patients whose constitutions have shifted significantly',
   'b',
   'The notes state: "we can still have acute ailments that do not reflect our general constitution. You can be a hot damp person and present a dry and cold lung condition."',
   'we can still have acute ailments that do not reflect our general constitution; you can be a hot damp person and present a dry and cold lung condition',
   'Warming Herbs', 330),

  -- Q34: Nettle B vitamins
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'Nettle is noted as a source of several B vitamins. Which set of B vitamins is specifically listed for nettle?',
   'B1, B2, B6, B12', 'B1, B2, B3, B5, B6, B9', 'B2, B3, B5, B9, B12', 'B6, B9, B12',
   'b',
   'The notes list Nettle as containing B vitamins (1,2,3,5,6,9).',
   'Nettle contains B vitamins B1, B2, B3, B5, B6, B9',
   'Vitamin B', 340),

  -- Q35: Alfalfa B vitamins
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'Which herb is noted as containing all of the following B vitamins: B1, B2, B3, B5, B6, B9, and B12?',
   'Red Clover', 'Nettle', 'Alfalfa', 'Raspberry leaf',
   'c',
   'The notes list Alfalfa as containing B vitamins (1,2,3,5,6,9,12) — the most complete B-vitamin profile of the three herbs mentioned.',
   'Alfalfa contains B vitamins B1, B2, B3, B5, B6, B9, B12',
   'Vitamin B', 350),

  -- Q36: Vitamin C iron connection
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'Besides wound healing and skin health, what is the specific additional role of Vitamin C highlighted in the iron context?',
   'It prevents iron from oxidizing in the gut',
   'It helps the body absorb iron and is included in the Iron Tonic Syrup for this reason',
   'It chelates excess iron to prevent toxicity',
   'It stimulates erythropoietin to increase red blood cell production',
   'b',
   'The notes state Vitamin C "helps the body absorb iron" and the Iron Tonic "has enough Vit C to metabolize."',
   'Vitamin C: helps the body absorb iron; Iron Tonic has enough Vit C to metabolize',
   'Vitamin C', 360),

  -- Q37: Myrrh character
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'Myrrh is classified in the warming herbs as a resin. What combination of properties and dosing guideline is given?',
   'Cooling and diuretic; use as primary herb in formula',
   'Very heating and anti-inflammatory; joint pain; used in low part of a formula',
   'Drying and hemostatic; used topically only',
   'Moistening and adaptogenic; use as tonic in high doses',
   'b',
   'The notes describe myrrh as a "resin; very heating and AI (anti-inflammatory) - joint pain, low part of a formula, usually."',
   'myrrh - resin; very heating and anti-inflammatory; joint pain; used in low part of a formula',
   'Warming Herbs', 370),

  -- Q38: Silk tassel / relaxing herbs
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'What is the primary clinical purpose of relaxing herbs like Silk Tassel, Catnip, and Kava?',
   'They remove excess fluid and reduce congestion',
   'They tonify and tighten lax tissues to prevent secretion',
   'They relax muscle cramps and spasms, tension in the muscles, and promote flow and movement',
   'They stimulate metabolism and increase vitality in deficient patients',
   'c',
   'The notes state relaxing herbs "relax muscle cramps and spasms, tension in the muscles; promote flow and movement."',
   'Relaxing Herbs: relax muscle cramps and spasms, tension in the muscles; promote flow and movement',
   'Relaxing Herbs', 380),

  -- Q39: Plantain dual role
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'Plantain appears in both the Moistening Herbs and Constricting Herbs sections. What is its specific distinction in the Laxness section?',
   'It is specific for excess sweating',
   'It is the superstar for the GI in cases of laxness',
   'It is specific for chronic bladder infections',
   'It is used only topically for wound healing',
   'b',
   'The notes state: "Plantain - superstar for the GI" in the signs of laxness section.',
   'Plantain - superstar for the GI; specific for signs of laxness',
   'Signs of Laxness', 390),

  -- Q40: Bitter herbs mechanism
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'What are the therapeutic effects attributed to bitter herbs as a group?',
   'They moisten dry tissues and soothe inflammation',
   'They stimulate the immune system and increase white blood cell count',
   'They have a downward, grounding, drying, clearing action; stimulate bile and increase appetite',
   'They increase blood flow to the periphery and warm cold extremities',
   'c',
   'The notes state bitter herbs "have a downward, grounding, drying, and clearing action; stimulate bile, increase appetite and help with digestion, elimination."',
   'Bitter herbs: downward, grounding, drying, and clearing action; stimulate bile, increase appetite and help with digestion, elimination',
   'Bitter Herbs', 400),

  -- Q41: Vitamin E fat-soluble caution
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'Vitamin E is an antioxidant. What important clinical caution about it is noted?',
   'It interferes with Vitamin K and anticoagulant medications',
   'It is fat-soluble, so pay attention to how much you take in',
   'It should only be taken with food containing protein',
   'It becomes toxic if taken with iron supplements',
   'b',
   'The notes state Vitamin E is "fat soluble, so pay attention to how much you take in."',
   'Vitamin E: an antioxidant; helps the body form RBC; helps the body use Vit K; fat soluble, so pay attention to how much you take in',
   'Vitamin E', 410),

  -- Q42: Vitamin K roles
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'Vitamin K serves two primary roles mentioned in the notes. What are they?',
   'Antioxidant and wound healing',
   'Blood coagulation and bone health',
   'Red blood cell production and brain function',
   'Hormone production and immune modulation',
   'b',
   'The notes state Vitamin K is "needed for blood coagulation; important for bone health; synergistic with Vit D."',
   'Vitamin K: needed for blood coagulation; important for bone health; synergistic with Vit D',
   'Vitamin K', 420),

  -- Q43: Reishi in broths
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'What practical note is given about adding reishi to broths?',
   'Add at the beginning and simmer for 2 hours for maximum extraction',
   'Only add to cold-water preparations; heat destroys its polysaccharides',
   'Not always, tongue-depressor type, designed to be put in soups',
   'Use fresh reishi only; dried loses its immune properties',
   'c',
   'The notes describe reishi as "not always, tongue depressor type, designed to be put in soups."',
   'reishi - not always, tongue depressor type, designed to be put in soups',
   'Broths', 430),

  -- Q44: Hibiscus as sour herb
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'Hibiscus is the exemplar sour herb. Its constituents include fruit acids, flavonoids, and antioxidants. What primary actions follow from these constituents?',
   'Diaphoretic, circulatory stimulant, warming',
   'Antioxidant, tonic, hepatic; cooling and astringing',
   'Demulcent, vulnerary, moistening',
   'Bitter tonic, digestive stimulant, drying',
   'b',
   'The notes describe hibiscus as "AO, tonic, hepatic; cooling, astringing; fruit acids, flavanoids, antioxidants."',
   'hibiscus → sour; cooling, astringing; antioxidant, tonic, hepatic; fruit acids, flavanoids, antioxidants',
   'Sour Herbs', 440),

  -- Q45: Maca warming + libido
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'Maca is listed under warming herbs. What additional property is specifically noted?',
   'Antimicrobial for sinus conditions',
   'Liver protective and antioxidant',
   'Libido enhancer',
   'Specific for stopping heavy bleeding',
   'c',
   'The notes list maca as "warming herb, libido enhancer."',
   'maca - warming herb, libido enhancer',
   'Warming Herbs', 450),

  -- Q46: Nutmeg vitamin A
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'Which common kitchen spice is described as the richest source of Vitamin A / Beta carotene among spices?',
   'Coriander', 'Basil', 'Fenugreek', 'Nutmeg',
   'd',
   'The notes state "nutmeg - richest" in the context of spices highest in Vitamin A / Beta carotene.',
   'nutmeg - richest spice in Vitamin A / Beta carotene',
   'Vitamin A', 460),

  -- Q47: Pungent herbs as potentiators
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'Pungent herbs are described as "movers, potentiators." What does this mean clinically?',
   'They move lymph and potentiate immune function',
   'They stimulate digestion, circulation, and metabolism; increase bioavailability of other herbs',
   'They move stagnant qi and potentiate liver detox',
   'They move excess heat outward through diaphoresis',
   'b',
   'The notes state pungent herbs "stimulate digestion, circulation and metabolism; helps to disperse congestion and excess energy."',
   'Pungent Herbs: stimulate digestion, circulation and metabolism; movers, potentiators; circ & digestive stimulant, diaphoretic',
   'Pungent Herbs', 470),

  -- Q48: Constricting herbs mechanism
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'What constituent class is responsible for the constricting action of herbs like plantain, oak, rose, and yarrow?',
   'Alkaloids', 'Polysaccharides', 'Tannins', 'Monoterpenes',
   'c',
   'The notes list constricting herbs under "herbs: tannins" — the constituent class responsible for their astringent, tissue-toning action.',
   'Constricting herbs: increase tone and tension of lax muscles; for leaky tissues; herbs: tannins',
   'Constricting Herbs', 480),

  -- Q49: Salty herbs constituents
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'What mineral constituents account for the salty flavor and mineralizing action of herbs like alfalfa, nettle, and chickweed?',
   'Calcium, phosphorus, sulfur, chloride',
   'Silica, selenium, zinc, iodine',
   'Magnesium, potassium, sodium, calcium',
   'Iron, manganese, boron, chromium',
   'c',
   'The notes list salty herb constituents as "magnesium, potassium, sodium, calcium."',
   'Salty Herbs - constituents: magnesium, potassium, sodium, calcium; properties: nutritive, mineralizing, diuretic, lymphatic',
   'Salty Herbs', 490),

  -- Q50: Rehmannia character
  ('BHC - Class 27 - Nutrition 2 and Herbal Energetics',
   'How is Rehmannia described in the sweet herbs section?',
   'Warming and immune stimulating',
   'Grounding and calming',
   'Pungent and liver protective',
   'Drying and adaptogenic',
   'b',
   'The notes state: "Rehmania - grounding and calming" in the sweet herbs section.',
   'rehmannia - sweet herb; grounding and calming',
   'Sweet Herbs', 500);

END $MIGRATION$;
