-- Migration 240: Class 60 — AMAB Health and Lotions quiz questions
-- Source: supabase/migrations/218_class_60_amab_health_data.sql
SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_quiz_questions
             WHERE class_name = 'BHC - Class 60 - AMAB Health and Lotions') THEN
    RAISE NOTICE 'Class 60 quiz questions already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_quiz_questions
    (class_name, question_text, option_a, option_b, option_c, option_d,
     correct_option, explanation, snippet_text, section_header, sort_order)
  VALUES

    -- Q1
    ('BHC - Class 60 - AMAB Health and Lotions',
     'Which enzyme converts testosterone into DHT, a more active form that can drive prostate issues?',
     '5-beta reductase', '5-alpha reductase', 'Aromatase', 'CYP3A4',
     'b',
     'The notes describe 5-alpha reductase as the enzyme that converts testosterone into DHT, which cannot be converted back and which we want to down-regulate in hormone-sensitive tissues like the prostate.',
     'Saw palmetto, green tea, nettle root (super gentle), turmeric, reishi and Panax ginseng — down-regulate 5-alpha reductase',
     'Testosterone Regulation', 10),

    -- Q2
    ('BHC - Class 60 - AMAB Health and Lotions',
     'Which of the following herbs is described in the notes as "super gentle" when down-regulating 5-alpha reductase?',
     'Saw palmetto', 'Reishi mushroom', 'Nettle root', 'Panax ginseng',
     'c',
     'The personal notes specifically note that nettle root is "super gentle" among the 5-alpha reductase inhibiting herbs.',
     'Saw palmetto, green tea, nettle root (super gentle), turmeric, reishi and Panax ginseng — down-regulate 5-alpha reductase',
     'Testosterone Regulation', 20),

    -- Q3
    ('BHC - Class 60 - AMAB Health and Lotions',
     'What are the four herbs listed in the generated notes for down-regulating 5-alpha reductase?',
     'Ashwagandha, ginseng, maca, reishi', 'Saw palmetto, green tea, nettle root, turmeric root', 'Burdock, sarsaparilla, figwort, yellow dock', 'Agrimony, horsetail, corn silk, marshmallow',
     'b',
     'The generated notes list saw palmetto, green tea, nettle root, and turmeric root as the four herbs to down-regulate 5-alpha reductase.',
     'Herbs to down-regulate 5-alpha reductase — Saw palmetto',
     'Testosterone Regulation', 30),

    -- Q4
    ('BHC - Class 60 - AMAB Health and Lotions',
     'According to the notes, why does Ashwagandha help increase testosterone levels?',
     'It directly stimulates Leydig cells to produce testosterone', 'By reducing stress, less testosterone is converted to cortisol, so more remains available', 'It inhibits aromatase, preventing conversion to estrogen', 'It stimulates the pituitary to release LH',
     'b',
     'The hormonal cascade explanation given is that Ashwagandha helps with stress, and not converting testosterone to cortisol increases the amount of testosterone available.',
     'Ashwagandha — yang tonic in Ayurveda, helps with stress; reducing cortisol conversion increases testosterone',
     'Men''s Health', 40),

    -- Q5
    ('BHC - Class 60 - AMAB Health and Lotions',
     'What is Ashwagandha''s Ayurvedic classification as described in the class notes?',
     'Yin tonic for feminine energy', 'Yang tonic; strength of the horse', 'Pitta-balancing cooling herb', 'Kapha-stimulating expectorant',
     'b',
     'Ashwagandha is described as a yang tonic in Ayurveda, associated with masculine energy and called "strength of the horse."',
     'Ashwagandha — yang tonic in Ayurveda, helps with stress; reducing cortisol conversion increases testosterone',
     'Men''s Health', 50),

    -- Q6
    ('BHC - Class 60 - AMAB Health and Lotions',
     'Which alterative herbs are specifically named for clearing excess estrogen in the men''s health notes?',
     'Ashwagandha and maca', 'Burdock and sarsaparilla', 'Saw palmetto and nettle root', 'Reishi and Panax ginseng',
     'b',
     'The generated notes list Burdock and Sarsaparilla as the alterative herbs for clearing excess estrogen in a men''s health context.',
     'Alteratives to clear excess estrogen — Burdock and Sarsaparilla',
     'Men''s Health', 60),

    -- Q7
    ('BHC - Class 60 - AMAB Health and Lotions',
     'The personal notes list four alterative herbs for clearing excess androgens from the blood. Which herb completes this list alongside Burdock, Sarsaparilla, and Figwort?',
     'Dandelion root', 'Red Clover', 'Yellow Dock', 'Licorice',
     'c',
     'The personal notes list Burdock, Figwort, Sarsaparilla, and Yellow Dock as the four alteratives for clearing excess androgens circulating in the blood.',
     'Alteratives — clear excess androgens circulating in the blood — Burdock, Figwort, Sarsaparilla, Yellow Dock',
     'Alteratives', 70),

    -- Q8
    ('BHC - Class 60 - AMAB Health and Lotions',
     'In the BPH notes, what is the prostate compared to in terms of size, and what symptom pattern does enlargement cause?',
     'Pea-sized; causes hematuria and dysuria', 'Walnut-sized; inflammation narrows the urine passage causing dribbling, urgency, incomplete emptying', 'Grape-sized; causes urinary retention requiring catheterisation', 'Almond-sized; produces intermittent stream only',
     'b',
     'The notes liken the prostate to a walnut-sized organ, explaining that inflammation narrows the urine passage and causes dribbling, urgency, and incomplete emptying.',
     'Herbal support for BPH — Saw palmetto, nettle root, green tea; anti-inflammatory; Gaia Herbs formula suggested',
     'BPH', 80),

    -- Q9
    ('BHC - Class 60 - AMAB Health and Lotions',
     'Which commercial product is specifically mentioned in the notes as a suggested anti-inflammatory formula for BPH?',
     'Herb Pharm formula', 'Urban Moonshine formula', 'Gaia Herbs formula', 'Traditional Medicinals formula',
     'c',
     'The BPH section suggests "Gaia Herbs formula" as the product for the anti-inflammatory herbal support combination.',
     'Herbal support for BPH — Saw palmetto, nettle root, green tea; anti-inflammatory; Gaia Herbs formula suggested',
     'BPH', 90),

    -- Q10
    ('BHC - Class 60 - AMAB Health and Lotions',
     'What dietary factors are listed in the BPH notes as increasing prostate risk?',
     'High protein, low fibre, excess red meat', 'Processed foods: bread, sugar, alcohol, caffeine', 'Low fat intake and excess dairy', 'Excess antioxidant supplementation',
     'b',
     'The BPH section lists processed foods — specifically bread, sugar, alcohol, and caffeine — as dietary risk factors for prostate health.',
     'Herbal support for BPH — Saw palmetto, nettle root, green tea; anti-inflammatory; Gaia Herbs formula suggested',
     'BPH', 100),

    -- Q11
    ('BHC - Class 60 - AMAB Health and Lotions',
     'Why are pumpkin seeds highlighted in the BPH and men''s health notes?',
     'They are a rich source of zinc and support sperm health', 'They are a primary source of plant-based testosterone', 'They contain 5-alpha reductase inhibitors', 'They are an adaptogen that reduces cortisol',
     'a',
     'The notes state that pumpkin seeds are beneficial for sperm health due to their zinc content, and zinc is also depleted through semen expression.',
     'Pumpkin seeds beneficial for sperm health (zinc content); pumpkin seed oil in BPH herbal formula',
     'BPH', 110),

    -- Q12
    ('BHC - Class 60 - AMAB Health and Lotions',
     'According to the personal notes on zinc, what process depletes zinc levels in AMAB individuals?',
     'High-intensity exercise', 'Semen expression', 'Alcohol consumption', 'Chronic stress',
     'b',
     'The personal notes specifically state that zinc is depleted through semen expression, making replenishment via foods like pumpkin seeds and seaweed important.',
     'Zinc depleted through semen expression — pumpkin seeds as food source for replenishment',
     'Takeaway', 120),

    -- Q13
    ('BHC - Class 60 - AMAB Health and Lotions',
     'Which adaptogen is described as a "yang tonic for masculine energy" and is listed alongside Ginsengs and Maca in the adaptogens section?',
     'Reishi', 'Eleuthero', 'Ashwagandha', 'Rhodiola',
     'c',
     'The adaptogens section explicitly identifies Ashwagandha as the yang tonic for masculine energy, alongside ginsengs, horny goat weed, and maca.',
     'Adaptogens for sex hormone regulation — Ashwagandha (yang tonic for masculine energy), Ginsengs, Maca; cycle 1-3 months',
     'Adaptogens', 130),

    -- Q14
    ('BHC - Class 60 - AMAB Health and Lotions',
     'How long should adaptogens be cycled for sex hormone regulation according to the class notes?',
     '1 week on, 1 week off', '1–3 months, then switch', 'Continuous use with no cycling', '6 months, then discontinue',
     'b',
     'The adaptogens section states adaptogens should be cycled 1–3 months then switching, with the phrase "don''t adapt… change."',
     'Adaptogens for sex hormone regulation — Ashwagandha (yang tonic for masculine energy), Ginsengs, Maca; cycle 1-3 months',
     'Adaptogens', 140),

    -- Q15
    ('BHC - Class 60 - AMAB Health and Lotions',
     'Marshmallow root is listed in the anti-inflammatory support notes for which specific therapeutic purpose?',
     'Stimulating bile flow', 'Soothing the prostate and urinary tract', 'Down-regulating DHT production', 'Supporting testicular function',
     'b',
     'Marshmallow root is included in the anti-inflammatory diet and lifestyle recommendations for its soothing demulcent action for prostate and BPH support.',
     'Marshmallow root for soothing — anti-inflammatory diet and lifestyle for prostate health and BPH',
     'Anti-inflammatory Support', 150),

    -- Q16
    ('BHC - Class 60 - AMAB Health and Lotions',
     'In the anti-inflammatory support section, what dietary approach is recommended for prostate health?',
     'High-dose supplementation with isolated plant compounds', 'A whole-foods approach with turmeric, marshmallow root, probiotics, and antioxidant-rich foods', 'Elimination diet removing all nightshades', 'Ketogenic diet with herbal fat-soluble extracts',
     'b',
     'The anti-inflammatory section recommends a whole-foods approach including turmeric, marshmallow root for soothing, probiotics, and antioxidant-rich foods.',
     'Marshmallow root for soothing — anti-inflammatory diet and lifestyle for prostate health and BPH',
     'Anti-inflammatory Support', 160),

    -- Q17
    ('BHC - Class 60 - AMAB Health and Lotions',
     'Which two herbs are highlighted as antioxidants to reduce free radicals in the antioxidant support section?',
     'Burdock and figwort', 'Agrimony and horsetail', 'Green tea and turmeric', 'Saw palmetto and reishi',
     'c',
     'The antioxidant support notes identify green tea and turmeric as the herbal antioxidants to reduce free radicals and oxidation in the body.',
     'Antioxidants to reduce free radicals and oxidation in the body — green tea, turmeric',
     'Antioxidant Support', 170),

    -- Q18
    ('BHC - Class 60 - AMAB Health and Lotions',
     'Agrimony and horsetail are described in the notes as which type of herb for urinary and reproductive health?',
     'Adaptogens', 'Anti-inflammatories', 'Astringents', 'Alteratives',
     'c',
     'The astringents section lists agrimony and horsetail as astringent herbs that help with urinary and reproductive health.',
     'Astringent herbs for urinary and reproductive health — agrimony, horsetail',
     'Astringents', 180),

    -- Q19
    ('BHC - Class 60 - AMAB Health and Lotions',
     'What strategy is recommended for andropause to help produce testosterone naturally?',
     'Testosterone agonist herbs such as beer hops', 'Reduce stress, cycle adaptogens 1–3 months, use circulatory stimulants, milky oats and neurorestorative', 'High-dose pine pollen continuously', 'Hormonal replacement therapy with herbal support only',
     'b',
     'The andropause notes recommend reducing stress, cycling adaptogens 1–3 months, using circulatory stimulants, and milky oats/neurorestorative; and specifically advise avoiding testosterone agonists like beer.',
     'Milky oats and neurorestorative for andropause support; alongside stress reduction, adaptogens, and circulatory stimulants',
     'Andropause', 190),

    -- Q20
    ('BHC - Class 60 - AMAB Health and Lotions',
     'What substance is mentioned in the andropause notes as a testosterone agonist to avoid?',
     'Coffee', 'Beer', 'Sugar', 'Soy products',
     'b',
     'The andropause section explicitly advises avoiding "testosterone agonists: beer."',
     'Milky oats and neurorestorative for andropause support; alongside stress reduction, adaptogens, and circulatory stimulants',
     'Andropause', 200),

    -- Q21
    ('BHC - Class 60 - AMAB Health and Lotions',
     'What are the primary therapeutic actions listed for addressing erectile dysfunction?',
     'Hepatic, alterative, diuretic, laxative', 'Aphrodisiac, adaptogen, circulatory stimulant, nervine, nutritive/tonic, vasodilator', 'Anti-inflammatory, anti-oxidant, astringent, demulcent', 'Expectorant, antispasmodic, diaphoretic, immunomodulator',
     'b',
     'The erectile dysfunction section lists aphrodisiac, adaptogen, circulatory stimulant, nervine, nutritive/tonic, and vasodilator as the relevant therapeutic actions.',
     'Diet for erectile dysfunction — zinc from pumpkin seeds; avoid processed food, refined grains, alcohol, sugar, caffeine',
     'Erectile Dysfunction', 210),

    -- Q22
    ('BHC - Class 60 - AMAB Health and Lotions',
     'What lifestyle interventions are noted for erectile dysfunction alongside herbal treatment?',
     'Meditation, dietary change, sunbathing', 'Regular exercise, kegels, hot/cold showers', 'Fasting, cold plunge, sauna', 'Yoga, tai chi, aerobic exercise',
     'b',
     'The erectile dysfunction notes specify regular exercise, kegels, and hot/cold showers as the lifestyle interventions.',
     'Diet for erectile dysfunction — zinc from pumpkin seeds; avoid processed food, refined grains, alcohol, sugar, caffeine',
     'Erectile Dysfunction', 220),

    -- Q23
    ('BHC - Class 60 - AMAB Health and Lotions',
     'According to the notes, what is stated about the majority cause of erectile dysfunction?',
     'It is primarily a vascular issue requiring circulatory herbs', 'The majority may be emotional, psychological, or spiritual rather than physical', 'It is predominantly hormonal and responds to testosterone support', 'It is mainly a structural nerve issue requiring adaptogens',
     'b',
     'The erectile dysfunction note states "can be physical reasons; but majority may be emotional, psychological, spiritual," placing these causes as primary.',
     'Diet for erectile dysfunction — zinc from pumpkin seeds; avoid processed food, refined grains, alcohol, sugar, caffeine',
     'Erectile Dysfunction', 230),

    -- Q24
    ('BHC - Class 60 - AMAB Health and Lotions',
     'In the BPH client case study, what is one reason Milk Thistle is recommended in capsule form?',
     'Capsules are more concentrated for liver support', 'Ease of use for the client', 'Capsules avoid interaction with beta-blockers', 'The tincture form is contraindicated for BPH',
     'b',
     'The case study notes suggest milk thistle in capsule form specifically for ease of use, indicating client compliance considerations.',
     'Use milk thistle as liver support (capsule form) — in BPH client case study',
     'Case Study', 240),

    -- Q25
    ('BHC - Class 60 - AMAB Health and Lotions',
     'In the case study notes, why is Hawthorn considered inappropriate for the client?',
     'Hawthorn aggravates BPH symptoms', 'The client has a low heart rate and Hawthorn is contraindicated', 'Hawthorn interacts with beta-blockers the client is taking', 'Hawthorn is a testosterone agonist',
     'b',
     'The case study note states "Hawthorn not good for the low heart rate," indicating bradycardia as the contraindication.',
     'Case Study — Hawthorn not good for low heart rate (caution for patients with bradycardia)',
     'Case Study', 250),

    -- Q26
    ('BHC - Class 60 - AMAB Health and Lotions',
     'Corn Silk is included in the case study for which purpose?',
     'Anti-inflammatory support for the prostate', 'Electrolytes and urinary support', 'DHT inhibition', 'Adaptogenic hormone support',
     'b',
     'The case study note lists Corn Silk alongside electrolytes as a urinary support herb.',
     'Case Study — Corn Silk for electrolytes and urinary support',
     'Case Study', 260),

    -- Q27
    ('BHC - Class 60 - AMAB Health and Lotions',
     'What note accompanies Saw Palmetto in the men''s health anti-inflammatory context regarding its preparation?',
     'Best taken as a tea', 'Strong taste; better in capsule form', 'Must be combined with nettle root to be effective', 'Effective only as a standardised extract',
     'b',
     'The generated men''s health notes specifically state that Saw Palmetto has a strong taste and is better taken in capsule form.',
     'Important anti-inflammatory herbs for men''s health — Saw Palmetto; strong taste, better in capsule form',
     'Men''s Health', 270),

    -- Q28
    ('BHC - Class 60 - AMAB Health and Lotions',
     'What does the case study say to consider when making herbal recommendations?',
     'Only herb–drug interactions and contraindications', 'Cultural background and comfort', 'Lab values and imaging results', 'Practitioner preference and supply availability',
     'b',
     'The case study section notes to "consider cultural background and comfort in herbal recommendations," highlighting patient-centred practice.',
     'Adaptogens like Turmeric for support — in BPH client case study',
     'Case Study', 280),

    -- Q29
    ('BHC - Class 60 - AMAB Health and Lotions',
     'Which pair of herbs is listed together as anti-inflammatory herbs to reduce prostate inflammation in the personal notes?',
     'Turmeric and ashwagandha', 'Saw Palmetto and Nettle Root', 'Green tea and reishi', 'Burdock and figwort',
     'b',
     'The personal anti-inflammatory section lists Saw Palmetto, Nettle Root, Hydrangea root, and White sage for reducing prostate inflammation, with Saw Palmetto and Nettle Root being the DB-linked pair.',
     'Anti-inflammatory herbs to reduce prostate inflammation — Saw Palmetto, Nettle root',
     'Anti-Inflammatory', 290),

    -- Q30
    ('BHC - Class 60 - AMAB Health and Lotions',
     'How is caffeine reduction approached in the BPH dietary guidance?',
     'Eliminate immediately upon diagnosis', 'Reduce gradually in half-cup increments', 'Switch to decaffeinated equivalents only', 'Replace with adaptogen teas immediately',
     'b',
     'The BPH prostate health section specifically recommends reducing caffeine "gradually (half-cup increments)" rather than stopping abruptly.',
     'Herbal support for BPH — Saw palmetto, nettle root, green tea; anti-inflammatory; Gaia Herbs formula suggested',
     'BPH', 300)

    ;
END $$;
