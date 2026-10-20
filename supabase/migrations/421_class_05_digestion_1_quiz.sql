-- Migration 421: Class 5 - Digestion I — quiz questions
-- H = 57 distinct herbs/supplements, F = 12 named factual items
-- target = 15 + 57×4 + 12×1 = 255 → clamped to 50
-- Correct option distribution: a=14, b=14, c=11, d=11

SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_quiz_questions
             WHERE class_name = 'BHC - Class 5 - Digestion I') THEN
    RAISE NOTICE 'Class 5 quiz questions already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_quiz_questions
    (class_name, question_text, option_a, option_b, option_c, option_d,
     correct_option, explanation, snippet_text, section_header, sort_order)
  VALUES

  -- Q1
  ('BHC - Class 5 - Digestion I',
   'Which herb is specifically called the "superstar of the GI system" in these notes?',
   'Chamomile', 'Fennel', 'Yarrow', 'Lavender',
   'a',
   'Chamomile is explicitly called "superstar of the GI system" and listed as antispasmodic. Chamomile, Lavender, and Yarrow are named together as 3 general GI superstars, but Chamomile receives the individual title.',
   'Chamomile called "superstar of the GI system" — antispasmodic for cramping. Chamomile, Lavender, and Yarrow are 3 general GI superstars.',
   'GI Antispasmodics', 10),

  -- Q2
  ('BHC - Class 5 - Digestion I',
   'Yarrow is listed in multiple GI action categories. Which combination of actions does the class attribute to Yarrow?',
   'Demulcent, nutritive, adaptogen',
   'Nervine, carminative, diaphoretic',
   'Astringent, slightly bitter, antimicrobial, and carminative',
   'Antispasmodic, alterative, hepatic',
   'c',
   'Yarrow appears in GI Astringents (astringent, slightly bitter, antimicrobial) and the Bitters Tasting (MEDIUM bitter; strong volatile oil — both bitter and carminative). No other class lists all four of these in a single herb.',
   'GI astringent for diarrhea; also slightly bitter and antimicrobial.',
   'GI Astringents', 20),

  -- Q3
  ('BHC - Class 5 - Digestion I',
   'What percentage of the body''s serotonin is produced in the gut, according to these notes?',
   '50%', '90%', '70%', '80%',
   'b',
   'The notes state "90% of body serotonin produced in the gut" as a key reason the gut-brain axis has such profound effects on mood and nervous system function.',
   'Digestive System/Nervine plants are helpful for gut-brain axis conditions. Chamomile tincture or glycerite — volatile oils are extracted well in both. High dose is 1 tsp at trigger time for almost immediate relief of enteric nervous system triggers.',
   'Gut-Brain Axis', 30),

  -- Q4
  ('BHC - Class 5 - Digestion I',
   'Blackberry Root is specifically highlighted for which acute situation?',
   'Leaky gut and food sensitivities',
   'Indigestion and constipation',
   'Acute diarrhea and food poisoning in the field',
   'Stomach cramping and bloating',
   'c',
   'Blackberry Root is called the best astringent for acute diarrhea and food poisoning — especially "in the woods." It is used temporarily for the acute phase, then the practitioner transitions to elimination herbs.',
   'Blackberry Root — best GI astringent for acute diarrhea and food poisoning; use temporarily for the acute phase, then transition to elimination herbs.',
   'GI Astringents', 40),

  -- Q5
  ('BHC - Class 5 - Digestion I',
   'How is Artichoke leaf''s effect on peristalsis described in the small intestine?',
   'Consistently speeds up peristalsis regardless of baseline',
   'Amphoteric — slows or speeds up as needed, with no unintended side effects elsewhere',
   'Stimulates peristalsis only in the large intestine',
   'Slows peristalsis to reduce cramping',
   'b',
   'Artichoke leaf is amphoteric for peristalsis — it regulates in whichever direction is needed — and crucially has no unintended side effects elsewhere in the GI tract.',
   'Artichoke leaf regulates peristalsis in the small intestine with no unintended side effects elsewhere; amphoteric — slows down or speeds up as needed.',
   'Peristalsis', 50),

  -- Q6
  ('BHC - Class 5 - Digestion I',
   'When working with GI demulcent herbs, which menstruum is recommended over alcohol?',
   'Standard 60% ethanol tincture',
   'Decoction only — water extraction preferred',
   'Glycerites, honeys, or vinegars',
   'Acetum (vinegar) tincture only',
   'c',
   'Alcohol can be irritating to the digestive system, so for GI demulcents the notes specify glycerites, honeys, or vinegars as preferred menstrum.',
   'GI demulcent — soothes and protects mucous membranes in the digestive tract. When working with the digestive system, alcohol can be irritating; prefer glycerites, honeys, or vinegars.',
   'GI Demulcents', 60),

  -- Q7
  ('BHC - Class 5 - Digestion I',
   'Which GI alterative herb is specifically indicated for leaky gut and food allergies?',
   'Turmeric', 'Burdock', 'Sarsaparilla', 'Red Clover',
   'c',
   'Sarsaparilla is the only alterative in these notes called out specifically for leaky gut and food allergies. The others are listed as general GI alteratives without this specific indication.',
   'GI alterative; specifically indicated for leaky gut and food allergies.',
   'GI Alteratives', 70),

  -- Q8
  ('BHC - Class 5 - Digestion I',
   'What bitterness level was assigned to Burdock in the class bitters tasting?',
   'LEAST bitter', 'MEDIUM bitter', 'MOST bitter', 'Not included in tasting',
   'a',
   'Burdock was rated LEAST bitter in the tasting. The notes also note its high inulin content, making it a prebiotic that feeds gut bacteria.',
   'Bitters tasting: Burdock — LEAST bitter. High in inulin, a fiber that feeds gut bacteria (prebiotic).',
   'Bitters Tasting', 80),

  -- Q9
  ('BHC - Class 5 - Digestion I',
   'Burdock''s high inulin content gives it what specific benefit for digestive health?',
   'It feeds gut bacteria, making it a prebiotic',
   'It acts as a direct antibiotic against gut pathogens',
   'It stimulates bile production in the liver',
   'It provides demulcent protection to the gut lining',
   'a',
   'Inulin is a prebiotic fiber — it feeds beneficial gut bacteria rather than acting directly on pathogens. This distinguishes it from antimicrobials and makes it specifically a microbiome-supportive action.',
   'Bitters tasting: Burdock — LEAST bitter. High in inulin, a fiber that feeds gut bacteria (prebiotic).',
   'Bitters Tasting', 90),

  -- Q10
  ('BHC - Class 5 - Digestion I',
   'What extraction method is emphasized for GI nutritive herbs like Nettle and Horsetail, and why?',
   'Oil extraction — captures fat-soluble minerals',
   'Water or vinegar over long periods — alcohol doesn''t extract minerals well',
   'Acetum only — vinegar specifically activates minerals',
   'Spagyric only — standard water extraction is insufficient',
   'b',
   'The notes explicitly state that nutritive herbs should be extracted in water or vinegar over long periods because alcohol doesn''t extract minerals. A spagyric process can reincorporate those minerals back into a tincture form.',
   'GI nutritive; best extracted in water or vinegar over long periods. Spagyric process reincorporates minerals otherwise lost in alcohol extraction.',
   'GI Nutritives', 100),

  -- Q11
  ('BHC - Class 5 - Digestion I',
   'Oregon Grape Root''s notable color and primary active constituent noted in the bitters tasting are:',
   'Bright yellow; Berberine — anti-fungal, antimicrobial, blood sugar regulation',
   'Red; anthocyanins — antioxidant, cardiovascular',
   'Green; chlorophyll — detoxifying, alkalizing',
   'Brown; tannins — astringent, tissue toning',
   'a',
   'Oregon Grape Root is distinctively bright yellow due to Berberine. The notes specifically call out Berberine''s anti-fungal, antimicrobial, and blood sugar regulation properties observed during the tasting.',
   'Bitters tasting: Oregon Grape Root — MEDIUM bitter. Bright yellow — contains Berberine; anti-fungal, antimicrobial, blood sugar regulation.',
   'Bitters Tasting', 110),

  -- Q12
  ('BHC - Class 5 - Digestion I',
   'Reishi mushroom''s adaptogen classification is best described as:',
   'Warming adaptogen for cold constitutions and low vitality',
   'Calming adaptogen especially for burnout and "tired but wired" states',
   'Stimulating adaptogen for fatigue and brain fog',
   'Neutral adaptogen for general stress management',
   'b',
   'The notes specifically describe Reishi as a calming adaptogen, with the phrase "tired but wired" describing burnout and nervous exhaustion — the core indication for Reishi over other adaptogens.',
   'Calming adaptogen especially for burnout and nervous exhaustion ("tired but wired"). Modulates the immune system. Helpful for insomnia and nightmares long-term (shen disturbance in TCM). Balances blood sugar and androgen hormones.',
   'Reishi', 120),

  -- Q13
  ('BHC - Class 5 - Digestion I',
   'What is the critical safety instruction given for Astragalus regarding infection timing?',
   'Do not combine with pharmaceutical antibiotics',
   'Do not take during active infection — it pushes the bug deeper; use Andrographis instead',
   'Do not use for more than 3 months continuously',
   'Do not use if fever is above 101°F',
   'b',
   'This is a key clinical safety point: Astragalus is immuno-building and should only be taken daily when OUT of infection. Taking it during active infection is contraindicated because it can push the pathogen deeper. Andrographis is recommended for active infection instead.',
   'Immuno-modulating. Deeply restorative and building after prolonged high-stress. Safety note: do NOT take during active infection — pushes the bug deeper. Only take daily when out of infection; use Andrographis for active infection instead.',
   'Astragalus', 130),

  -- Q14
  ('BHC - Class 5 - Digestion I',
   'In the bitters tasting, Andrographis was described as:',
   'MEDIUM bitter, "queen of bitters" — best for women''s GI issues',
   'LEAST bitter, useful for sensitive patients',
   'MOST bitter, called the "king of bitters"',
   'MEDIUM bitter, best reserved for active infection',
   'c',
   'Andrographis was tasted as MOST bitter — rated alongside Gentian and Wormwood — and specifically called the "king of bitters." Its use for active infection (vs Astragalus) is also noted in the Astragalus section.',
   'Bitters tasting: Andrographis — MOST bitter. Called the "king of bitters." Also recommended for active infection (vs Astragalus which should not be taken during active infection).',
   'Bitters Tasting', 140),

  -- Q15
  ('BHC - Class 5 - Digestion I',
   'Schizandra''s hepatic property specifically addresses which condition?',
   'Autoimmune liver inflammation',
   'Stimulating bile flow for fat digestion',
   'Restoring the liver after alcohol damage',
   'Clearing liver qi stagnation',
   'c',
   'Schizandra''s hepatic action is specifically described as liver protective and regenerative, with the concrete example of restoring the liver after alcohol damage — making it clinically specific, not just a general liver tonic.',
   'Called the "5 flavor berry" (sour, sweet, bitter + more). Mildly stimulating adaptogen — mind-pumping, enhances focus and cognitive function. Hepatic: liver protective and regenerative, restores liver after alcohol damage. Lung tonic.',
   'Schizandra Berries', 150),

  -- Q16
  ('BHC - Class 5 - Digestion I',
   'Blue Vervain''s bitters tasting description focused on what part of the body and what effect?',
   'Lower third of the body — relaxes intestinal cramping',
   'Upper third of the body — releases tension, calms thoughts like water surface',
   'The heart and vasculature — grief and emotional release',
   'The kidneys and adrenals — adrenal fatigue support',
   'b',
   'Blue Vervain was described as working on the upper third of the body, releasing tension, and calming thoughts "like water surface" — this is a distinctive energetic description that helps differentiate it from other bitters.',
   'Bitters tasting: Blue Vervain — MEDIUM bitter. Works on the upper third of the body; releases tension; calms thoughts like water surface.',
   'Bitters Tasting', 160),

  -- Q17
  ('BHC - Class 5 - Digestion I',
   'According to the notes, how long may a full leaky gut reset and healing take?',
   '~6 months', '2–4 weeks', '1–2 months', '12 months or more',
   'a',
   'The notes explicitly state "full reset and healing may take ~6 months." This sets realistic expectations for clients and underscores why consistent long-term herbal support is needed for leaky gut.',
   'Demulcent for leaky gut — soothes and protects gut mucosal lining. Listed alongside flax seeds for gut healing. Full reset and healing may take ~6 months.',
   'Leaky Gut', 170),

  -- Q18
  ('BHC - Class 5 - Digestion I',
   'If a patient becomes nauseous after taking bitter herbs, what is the recommended clinical response?',
   'Reduce the dose of bitters by half and continue',
   'Switch to a cooler bitter such as Gentian',
   'Give a carminative herb: Ginger, Lemon Balm, or Catnip',
   'Discontinue bitters entirely and use demulcents',
   'c',
   'The notes explicitly state: if nauseous from bitters, use carminatives — specifically Ginger, Lemon Balm, and Catnip are listed as the carminatives to reach for.',
   'If nauseous from bitters, use carminatives: Ginger, Lemon Balm, or Catnip.',
   'Bitters Tasting', 180),

  -- Q19
  ('BHC - Class 5 - Digestion I',
   'Gentian was noted as the main bittering ingredient in which two well-known alcoholic beverages?',
   'Gin and vermouth',
   'Campari and Aperol',
   'Absinthe and pastis',
   'Chartreuse and Benedictine',
   'b',
   'Gentian is the bitter backbone of Campari and Aperol — both aperitif-style drinks. The notes also flag that Gentian is now overharvested, making it an important sustainability consideration.',
   'Bitters tasting: Gentian — MOST bitter. Main ingredient in Campari and Aperol; now overharvested; cooling bitter.',
   'Bitters Tasting', 190),

  -- Q20
  ('BHC - Class 5 - Digestion I',
   'For which type of plant component is standard decoction NOT recommended (unless the pot is covered)?',
   'Volatile oils — they evaporate with prolonged heat unless the pot is covered',
   'Mucilage — damaged by heat',
   'Resins — don''t extract well in water regardless',
   'Tannins — become too astringent when decocted',
   'a',
   'Volatile oils like those in Ginger, Fennel, and Cardamom are volatile by nature — open-pot decoction drives them off. Covering the pot retains them. Mucilage and resins have different limitations.',
   'Volatile oils in Ginger, Fennel, and Cardamom are not ideal for standard decoction — cover the pot to retain volatile oils.',
   'Decoction Preparation', 200),

  -- Q21
  ('BHC - Class 5 - Digestion I',
   'Rose Hips have a notable benefit for physically active people. What is it?',
   'Increases muscle mass through hormonal support',
   'Powerful clearer of lactic acid — use as strong decoction or tincture',
   'Increases oxygenation during exercise',
   'Reduces cortisol post-workout',
   'b',
   'Rose Hips are specifically described as a "powerful clearer of lactic acid" — making them a practical recommendation for gym-goers and athletes. The strong decoction or tincture is the suggested form.',
   'Anti-inflammatory (cooling), very high in Vit C, antioxidant. Astringent + demulcent to the digestive system (similar to Plantain). Pleasure medicine — shifts mood for a few seconds. Powerful clearer of lactic acid — good for gym-goers; use as strong decoction or tincture. Dose: 1/2–6 droppers full (very safe). Deseed before use.',
   'Rose Hips', 210),

  -- Q22
  ('BHC - Class 5 - Digestion I',
   'Rose Hips are described as having which combined actions on the digestive system?',
   'Bitter and carminative',
   'Alterative and nutritive',
   'Antispasmodic and anti-inflammatory',
   'Astringent and demulcent',
   'd',
   'Rose Hips are specifically described as "Astringent + Demulcent to the digestive system, similar to Plantain in this way." This dual action — toning tissue while also soothing — is what makes them useful for gut conditions.',
   'Anti-inflammatory (cooling), very high in Vit C, antioxidant. Astringent + demulcent to the digestive system (similar to Plantain). Pleasure medicine — shifts mood for a few seconds.',
   'Rose Hips', 220),

  -- Q23
  ('BHC - Class 5 - Digestion I',
   'Shatavari is described as the "feminine version" of which other herb?',
   'Eleuthero (Siberian Ginseng)', 'Reishi', 'Ashwagandha', 'Astragalus',
   'c',
   'Shatavari is explicitly compared to Ashwagandha — Ashwagandha is described as the strengthening yang herb, while Shatavari is the nourishing yin counterpart. Both are adaptogens but with different energetic qualities.',
   'Described as the feminine counterpart to Ashwagandha. Nourishing, very yin, restorative calming adaptogen. Deeply moistening. Reproductive and fertility tonic, hormone balancing. Traditional preparations combine with fat.',
   'Shatavari', 230),

  -- Q24
  ('BHC - Class 5 - Digestion I',
   'Chamomile tincture used for gut-brain axis triggers should be dosed at what amount?',
   '10–15 drops', '1/2 teaspoon', '1 tablespoon',
   '1 teaspoon',
   'd',
   'The notes specify "high dose is 1 tsp at trigger time" for almost immediate relief — this is notably higher than typical tincture doses, making it clinically distinct and worth remembering.',
   'Digestive System/Nervine plants are helpful for gut-brain axis conditions. Chamomile tincture or glycerite — volatile oils are extracted well in both. High dose is 1 tsp at trigger time for almost immediate relief of enteric nervous system triggers.',
   'Gut-Brain Axis', 240),

  -- Q25
  ('BHC - Class 5 - Digestion I',
   'Elecampane''s inulin content provides what clinical benefit beyond its respiratory uses?',
   'Prebiotic digestive support — feeds beneficial gut bacteria',
   'Direct antimicrobial action in the gut',
   'Soothes mucous membranes (demulcent)',
   'Stimulates bile production for fat digestion',
   'a',
   'Elecampane is full of inulin, making it a prebiotic — it feeds beneficial gut bacteria. This makes it uniquely dual-purpose: a respiratory herb that also supports the microbiome, similar to Burdock.',
   'Soothes coughs; anti-microbial. Warming and drying for damp or cold respiratory conditions. Full of inulin — prebiotic digestive support. Bitter. Amphoteric for lung energetics (damp/dry). Gentle expectorant.',
   'Elecampane Root', 250),

  -- Q26
  ('BHC - Class 5 - Digestion I',
   'Which bitter herb tasted in class is specifically described as antiparasitic?',
   'Wormwood', 'Gentian', 'Blue Vervain', 'Andrographis',
   'a',
   'Wormwood is the herb specifically noted as antiparasitic in the bitters tasting. Andrographis is for active infection; Gentian and Blue Vervain are not noted for antiparasitic action.',
   'Bitters tasting: Wormwood — MOST bitter. Antiparasitic.',
   'Bitters Tasting', 260),

  -- Q27
  ('BHC - Class 5 - Digestion I',
   'Which GI astringent is highlighted specifically as a great gut healing tea for ongoing leaky gut repair (not just acute diarrhea)?',
   'Yarrow', 'Calendula', 'Cinnamon', 'Plantain',
   'd',
   'Plantain is the astringent specifically called out as a "great gut healing tea, leaky gut" — making it suited for longer-term gut lining repair. Blackberry Root is for acute diarrhea; Yarrow and Calendula are not given this specific leaky gut note.',
   'GI astringent that tones and tightens tissue; indicated for diarrhea. Specifically noted as a great gut healing tea for leaky gut.',
   'GI Astringents', 270),

  -- Q28
  ('BHC - Class 5 - Digestion I',
   'Mugwort''s dual GI actions observed in the bitters tasting are:',
   'Both carminative and bitter',
   'Both nervine and astringent',
   'Both demulcent and anti-inflammatory',
   'Both alterative and antispasmodic',
   'a',
   'Mugwort was explicitly noted in the bitters tasting as being "both carminative and bitter" — it straddles two GI action categories, making it useful for conditions involving both bitterness (digestive secretion) and carminative (gas) relief.',
   'Bitters tasting: Mugwort — MEDIUM bitter. Both carminative and bitter.',
   'Bitters Tasting', 280),

  -- Q29
  ('BHC - Class 5 - Digestion I',
   'What is the standard herb-to-water ratio taught for making a decoction?',
   '1 oz herb to 16 oz water',
   '1 oz herb to 64 oz water',
   '2 oz herb to 32 oz water',
   '1 oz herb to 32 oz water',
   'd',
   'The standard decoction ratio taught is 1 oz herb to 32 oz water. General dosage is 8 oz 3x per day — meaning a batch covers about one day of treatment.',
   'Digestion decoction recipe (to 32 oz water): 14g Fennel, 28g Yellow Dock, 28g Elecampane.',
   'Decoction Recipes', 290),

  -- Q30
  ('BHC - Class 5 - Digestion I',
   'Which three herbs make up the "Immune" decoction recipe taught in class?',
   'Elderberries, Astragalus, Ginger',
   'Fennel, Yellow Dock, Elecampane',
   'Hawthorn berries, Rose Hips, Cinnamon',
   'Nettle, Horsetail, Oat Straw',
   'a',
   'The three decoction recipes are: Digestion (Fennel, Yellow Dock, Elecampane), Heart (Hawthorn, Rose Hips, Cinnamon), and Immune (Elderberries, Astragalus, Ginger). The Immune recipe pairs an antiviral berry with an immuno-modulating tonic and a warming anti-viral.',
   'Immune decoction recipe (to 32 oz water): 28g Elderberries, 28g Astragalus, 14g Ginger.',
   'Decoction Recipes', 300),

  -- Q31
  ('BHC - Class 5 - Digestion I',
   'Which three herbs make up the "Heart" decoction recipe?',
   'Elderberries, Astragalus, Ginger',
   'Hawthorn berries, Rose Hips, Cinnamon',
   'Fennel, Yellow Dock, Elecampane',
   'Chamomile, Linden, Marshmallow',
   'b',
   'The Heart recipe combines Hawthorn (CV tonic), Rose Hips (anti-inflammatory, antioxidant), and Cinnamon (astringent, circulatory support) — all focused on cardiovascular and circulatory health.',
   'Heart decoction recipe (to 32 oz water): 28g Hawthorn berries, 28g Rose Hips, 14g Cinnamon.',
   'Decoction Recipes', 310),

  -- Q32
  ('BHC - Class 5 - Digestion I',
   'Which three herbs make up the "Digestion" decoction recipe?',
   'Chamomile, Fennel, Ginger',
   'Elecampane, Burdock, Dandelion Root',
   'Dandelion Root, Artichoke, Licorice',
   'Fennel, Yellow Dock, Elecampane',
   'd',
   'The Digestion recipe combines Fennel (carminative), Yellow Dock (bitter, aperient, iron-rich), and Elecampane (bitter, prebiotic inulin, antimicrobial) — all supporting different aspects of digestive function.',
   'Digestion decoction recipe (to 32 oz water): 14g Fennel, 28g Yellow Dock, 28g Elecampane.',
   'Decoction Recipes', 320),

  -- Q33
  ('BHC - Class 5 - Digestion I',
   'Hawthorn berry''s primary system classification and emotional indication are:',
   'Respiratory system support; fear support',
   'Cardiovascular tonic; grief support and matters of the heart',
   'Digestive tonic; anger processing',
   'Immune modulator; courage support',
   'b',
   'Hawthorn is a classic cardiovascular tonic (vasculature, blood pressure, arrhythmia, atherosclerosis) with the emotional signature of grief and "matters of the heart." This dual physical/emotional indication is characteristic of the herb.',
   'CV tonic: strengthens vasculature, lowers blood pressure, helpful for arrhythmia and atherosclerosis. Grief support and matters of the heart.',
   'Hawthorn Berries', 330),

  -- Q34
  ('BHC - Class 5 - Digestion I',
   'What is the essential preparation instruction for Elder berries?',
   'Use only fresh berries for maximum antiviral potency',
   'Ferment before using to release active constituents',
   'Always dry berries before using',
   'Freeze first to break down cell walls',
   'c',
   'The notes explicitly state "always dry berries before using" — fresh elderberries contain sambunigrin and can cause nausea. Drying or cooking eliminates this concern.',
   'Antiviral: inhibits spread of many viral infections including flu. Alterative: supports body''s natural detox and elimination. Always dry berries before using.',
   'Elderberries', 340),

  -- Q35
  ('BHC - Class 5 - Digestion I',
   'Reishi''s effect on insomnia and nightmares is linked to which TCM concept?',
   'Kidney yin deficiency',
   'Liver qi stagnation',
   'Shen disturbance',
   'Heart blood deficiency',
   'c',
   'The notes specifically name "shen disturbance in TCM" as the pattern Reishi addresses for insomnia and nightmares. Shen relates to consciousness, spirit, and mental-emotional wellbeing housed in the heart.',
   'Calming adaptogen especially for burnout and nervous exhaustion ("tired but wired"). Modulates the immune system. Helpful for insomnia and nightmares long-term (shen disturbance in TCM). Balances blood sugar and androgen hormones.',
   'Reishi', 350),

  -- Q36
  ('BHC - Class 5 - Digestion I',
   'What specific preparation of Ginger is recommended for nausea in these notes?',
   'Strong decoction', 'Tincture', 'Capsule', 'Glycerite',
   'd',
   'The notes specifically name "Ginger glycerite for nausea" — the glycerite form is preferred because it is less irritating than alcohol and extraction is gentler, appropriate for an already-upset stomach.',
   'Powerful anti-inflammatory and anti-viral (especially when fresh). Emmenagogue — stimulates delayed menstruation and eases cramps. Carminative — wonderful for nausea and bloating. Diaphoretic — strong ginger decoction added to bath to sweat out illness. Ginger glycerite specifically recommended for nausea.',
   'Ginger', 360),

  -- Q37
  ('BHC - Class 5 - Digestion I',
   'Bitter herbs are described as stimulating which three digestive secretions?',
   'Mucus, saliva, and gastric acid',
   'Bile, mucus, and digestive enzymes',
   'Saliva, mucus, and pepsin',
   'HCL, pancreatic juices, and bile',
   'd',
   'The notes are specific: bitters stimulate HCL (in the stomach), pancreatic juices (in the pancreas), and bile (in the liver/gallbladder). This triple action on all three digestive secretion sites is the core mechanism of bitter herbs.',
   'Warming bitter herb for GI support — stimulates digestive secretions including HCL, pancreatic juices, and bile.',
   'GI Bitters', 370),

  -- Q38
  ('BHC - Class 5 - Digestion I',
   'Wild Yam''s specific GI antispasmodic indication is:',
   'Diarrhea and loose stool',
   'Acid reflux and esophageal spasm',
   'Stomach cramping specifically',
   'Gas and intestinal bloating',
   'c',
   'Wild Yam is specifically noted as "good for stomach cramping" — it is placed in the antispasmodic category with this specific indication, distinguishing it from broader antispasmodics like Cramp Bark.',
   'GI antispasmodic; specifically good for stomach cramping.',
   'GI Antispasmodics', 380),

  -- Q39
  ('BHC - Class 5 - Digestion I',
   'Elecampane''s energetic qualities for respiratory use are described as:',
   'Warming and drying — for damp or cold respiratory conditions',
   'Cooling and moistening — for dry or hot lung conditions',
   'Neutral — amphoteric for any respiratory pattern',
   'Cooling and drying — for damp, hot respiratory conditions',
   'a',
   'Elecampane is warming and drying — making it specifically indicated for "damp" or cold respiratory conditions. The notes also call it amphoteric for lung energetics, meaning it won''t push in the wrong direction regardless of the pattern.',
   'Soothes coughs; anti-microbial. Warming and drying for damp or cold respiratory conditions. Full of inulin — prebiotic digestive support. Bitter. Amphoteric for lung energetics (damp/dry). Gentle expectorant.',
   'Elecampane Root', 390),

  -- Q40
  ('BHC - Class 5 - Digestion I',
   'What is the notable preparation instruction for traditional Shatavari preparations?',
   'Prepare as a cold infusion to preserve yin-nourishing properties',
   'Traditional preparations combine with fat for proper absorption',
   'Use only as a decoction — tinctures are not appropriate',
   'Combine with alcohol for full extraction of reproductive tonics',
   'b',
   'Shatavari is a deeply moistening yin herb and its traditional preparations combine it with fat — likely reflecting its fat-soluble constituents and Ayurvedic ghee-based preparations. This distinguishes it from standard water or alcohol extractions.',
   'Described as the feminine counterpart to Ashwagandha. Nourishing, very yin, restorative calming adaptogen. Deeply moistening. Reproductive and fertility tonic, hormone balancing. Traditional preparations combine with fat.',
   'Shatavari', 400),

  -- Q41
  ('BHC - Class 5 - Digestion I',
   'In leaky gut, what happens to the immune system as food particles continuously leak through the gut lining?',
   'Immune cells concentrate around the GI tract and keep triggering — the whole body inflames and it never turns off',
   'The immune system produces antibodies that gradually neutralize leaking food particles',
   'The immune system reduces its activity to avoid further tissue damage',
   'Immune cytokines directly promote repair of the tight junctions',
   'a',
   'The notes describe a self-perpetuating inflammatory cycle: leaking particles trigger the immune system, which stays inflamed indefinitely because particles continue leaking. This is why leaky gut drives systemic inflammation and why healing takes ~6 months.',
   'Demulcent for leaky gut — soothes and protects gut mucosal lining. Listed alongside flax seeds for gut healing. Full reset and healing may take ~6 months.',
   'Leaky Gut', 410),

  -- Q42
  ('BHC - Class 5 - Digestion I',
   'What does the spagyric process accomplish for nutritive herbs that standard tincturing cannot?',
   'It extracts volatile oils that water alone misses',
   'It reincorporates minerals back into the formula — giving you minerals in tincture form',
   'It activates constituents through fermentation',
   'It concentrates tannins for better astringent action',
   'b',
   'Alcohol doesn''t extract minerals well, so standard tincturing of nutritive herbs loses the mineral content. The spagyric process calcines the herb and reincorporates those minerals back into the liquid — allowing mineral delivery in tincture form.',
   'GI nutritive; best extracted in water or vinegar over long periods. Spagyric process reincorporates minerals otherwise lost in alcohol extraction.',
   'GI Nutritives', 420),

  -- Q43
  ('BHC - Class 5 - Digestion I',
   'What is the specific note about Hibiscus and decoction?',
   'Hibiscus IS good in decoction if you are not after the mucilage',
   'Hibiscus should never be decocted as heat destroys all its medicine',
   'Hibiscus requires a short decoction (under 5 minutes) to preserve constituents',
   'Hibiscus is best combined with Marshmallow in decoction for synergy',
   'a',
   'This is a nuanced distinction: Hibiscus mucilage is heat-sensitive (like Marshmallow and Slippery Elm), but unlike those herbs, Hibiscus has other medicinal constituents that ARE well-extracted by decoction — so it is still appropriate to decoct if mucilage is not your goal.',
   'Hibiscus mucilage is damaged by heat; however, Hibiscus IS good in decoction if you are not after the mucilage.',
   'Decoction Preparation', 430),

  -- Q44
  ('BHC - Class 5 - Digestion I',
   'Which statement about Chamomile''s volatile oil extraction is correct?',
   'Poor — volatile oils are lost and cold maceration is required',
   'Moderate — alcohol only partially extracts them',
   'Best only in cold water infusion',
   'Good — volatile oils are extracted well in both tincture and glycerite',
   'd',
   'The notes specify that volatile oils are extracted well in both glycerite and tincture — this is specifically why Chamomile glycerite or tincture (not just tea) is recommended for gut-brain axis triggers.',
   'Digestive System/Nervine plants are helpful for gut-brain axis conditions. Chamomile tincture or glycerite — volatile oils are extracted well in both. High dose is 1 tsp at trigger time for almost immediate relief of enteric nervous system triggers.',
   'Gut-Brain Axis', 440),

  -- Q45
  ('BHC - Class 5 - Digestion I',
   'Yarrow''s GI astringent role is paired with which other two actions in these notes?',
   'Demulcent and carminative',
   'Adaptogen and anti-inflammatory',
   'Nutritive and nervine',
   'Slightly bitter and antimicrobial',
   'd',
   'Yarrow is listed in the astringents section with the notes "also slightly bitter, good, and antimicrobial" — giving it a three-action profile (astringent, bitter, antimicrobial) that makes it broadly useful in GI conditions.',
   'GI astringent for diarrhea; also slightly bitter and antimicrobial.',
   'GI Astringents', 450),

  -- Q46
  ('BHC - Class 5 - Digestion I',
   'How is Cat''s Claw described relative to other GI anti-inflammatories in this class?',
   'The mildest option, suited for sensitive GI systems',
   'Powerful for GI conditions',
   'Best reserved for chronic autoimmune GI conditions only',
   'Most appropriate for upper GI issues',
   'b',
   'Cat''s Claw is specifically called out as "powerful for GI" in the anti-inflammatory list — a direct qualitative comparison that sets it apart from the other herbs listed (Meadowsweet, Chamomile, Kudzu Root, Licorice).',
   'GI anti-inflammatory — described as powerful for GI conditions.',
   'GI Anti-Inflammatories', 460),

  -- Q47
  ('BHC - Class 5 - Digestion I',
   'Ginger''s diaphoretic use is described as:',
   'Taking Ginger tincture orally at high dose to induce sweating',
   'Pouring strong Ginger decoction into a bath to sweat out illness',
   'Applying a Ginger poultice to the chest and back',
   'Ginger steam inhalation to open respiratory passages',
   'b',
   'The notes describe a specific hydrotherapy application: make a strong Ginger decoction and pour it into the bath — the diaphoretic action helps sweat out the pathogen. The promise is "you won''t get sick."',
   'Powerful anti-inflammatory and anti-viral (especially when fresh). Emmenagogue — stimulates delayed menstruation and eases cramps. Carminative — wonderful for nausea and bloating. Diaphoretic — strong ginger decoction added to bath to sweat out illness. Ginger glycerite specifically recommended for nausea.',
   'Ginger', 470),

  -- Q48
  ('BHC - Class 5 - Digestion I',
   'The Enteric Nervous System''s "memory" has what clinical implication?',
   'Gut bacteria can learn to digest new foods over time',
   'The gut immune system stores pathogen memories like lymph nodes',
   'Peristalsis rhythms can be trained through dietary consistency',
   'Shocking events cause triggers to form in the enteric NS; nervine herbs can tell it we are safe',
   'd',
   'The ENS memory concept explains trauma-related gut symptoms: a shocking event creates a trigger pattern. Nervine herbs like Chamomile can signal to the enteric nervous system that the threat has passed, offering relief.',
   'Digestive System/Nervine plants are helpful for gut-brain axis conditions. Chamomile tincture or glycerite — volatile oils are extracted well in both. High dose is 1 tsp at trigger time for almost immediate relief of enteric nervous system triggers.',
   'Gut-Brain Axis', 480),

  -- Q49
  ('BHC - Class 5 - Digestion I',
   'When using Blackberry Root for acute diarrhea or food poisoning, what is the recommended follow-up approach?',
   'Continue Blackberry Root long-term to maintain gut tone',
   'Follow immediately with demulcents to soothe the gut lining',
   'Add bitters to strengthen overall digestive function',
   'Use Blackberry Root temporarily for the acute phase, then transition to elimination herbs',
   'd',
   'Blackberry Root is positioned as an acute-phase herb — it stops the diarrhea quickly. Once the acute phase resolves, the clinical shift is to elimination herbs (to support healthy elimination patterns). It is not a long-term tonic.',
   'Blackberry Root — best GI astringent for acute diarrhea and food poisoning; use temporarily for the acute phase, then transition to elimination herbs.',
   'GI Astringents', 490),

  -- Q50
  ('BHC - Class 5 - Digestion I',
   'Which herb from the decoctions section serves the dual role of respiratory expectorant AND prebiotic digestive support (via inulin)?',
   'Elecampane', 'Astragalus', 'Schizandra', 'Reishi',
   'a',
   'Elecampane is unique in being both a lung herb (soothes coughs, gentle expectorant, antimicrobial, warming/drying for damp respiratory conditions) AND rich in inulin — the prebiotic fiber that feeds beneficial gut bacteria. This dual function distinguishes it from the other adaptogens and tonics listed.',
   'Soothes coughs; anti-microbial. Warming and drying for damp or cold respiratory conditions. Full of inulin — prebiotic digestive support. Bitter. Amphoteric for lung energetics (damp/dry). Gentle expectorant.',
   'Elecampane Root', 500);

END $$;
