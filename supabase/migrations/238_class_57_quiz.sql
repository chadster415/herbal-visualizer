-- Migration 238: Class 57 — Repro III quiz questions
-- Source: supabase/migrations/221_class_57_repro_iii_data.sql
SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_quiz_questions
             WHERE class_name = 'BHC - Class 57 - Repro III') THEN
    RAISE NOTICE 'Class 57 quiz questions already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_quiz_questions
    (class_name, question_text, option_a, option_b, option_c, option_d,
     correct_option, explanation, snippet_text, section_header, sort_order)
  VALUES

    -- Q1: Marshmallow infusion
    ('BHC - Class 57 - Repro III',
     'What is the recommended preparation method for Marshmallow root to maximize its mucopolysaccharide content?',
     'Hot decoction for 20 minutes',
     'Cold or room temperature infusion',
     'Extended hot infusion for 4 hours',
     'Fresh tincture in glycerin',
     'b',
     'Michael Moore recommends cold or room temperature infusion for Marshmallow root — cold water produces rich mucopolysaccharide content. Marshmallow has a short shelf life due to its starches and sugars.',
     'Marshmallow root cold infusion: produces rich mucopolysaccharide; short shelf life due to starches and sugars; high desert dehydration remedy.',
     'Marshmallow Root', 10),

    -- Q2: Adolescent herbs — Lemon Balm
    ('BHC - Class 57 - Repro III',
     'Why is Lemon Balm particularly useful for teenagers during puberty?',
     'It promotes estrogen production and initiates menarche',
     'It contains calcium and magnesium, supports secondary ossification, and is specific for restlessness and insomnia',
     'It is high in silica, supporting hair, nails, and bones',
     'It is hemostatic and reduces heavy menstrual flow',
     'b',
     'Lemon Balm is rich in calcium and magnesium (supporting secondary ossification/bone development), and is specific for restlessness, insomnia, and menarche support in teens.',
     'Melissa (Lemon Balm) — mood and cognitive function; calcium and Mg for secondary ossification; specific for restlessness, insomnia; menarche support.',
     'Adolescent Support', 20),

    -- Q3: Adolescent herbs — Nettles nutrients
    ('BHC - Class 57 - Repro III',
     'Nettles is described as 30% protein with a rich nutrient profile — which nutrients does it provide for menstruating teens?',
     'Vitamin C, B12, calcium, magnesium, iron',
     'Vitamin A, C, D, E, K, B-complex, Mg, Ca, Selenium, Zn, Fe',
     'Vitamin D, E, K, potassium, silica, boron',
     'Vitamin A, C, E, calcium, iron, potassium',
     'b',
     'Nettles provides an extensive nutrient profile: Vitamins A, C, D, E, K, B-complex, magnesium, calcium, selenium, zinc, and iron — and is hemostatic, useful for heavy menstrual flow.',
     'Urtica spp (Nettles) — infusion and food; 30% protein; Vit A,C,D,E,K,B-complex, Mg, Ca, Se, Zn, Fe; hemostatic; reduces heavy menstrual flow.',
     'Adolescent Support', 30),

    -- Q4: Milky Oats vs Oat Straw distinction
    ('BHC - Class 57 - Repro III',
     'What distinguishes Milky Oats from Oat Straw for nervous system support?',
     'Milky Oats is for initial nerve building; Oat Straw for nerve degradation',
     'Milky Oats supports hair and nails; Oat Straw supports myelin',
     'Milky Oats is better for nerve degradation (e.g. MS), not initial building; Oat Straw is nutritive and high in silica',
     'They are interchangeable; only preparation method differs',
     'c',
     'Milky Oats is better for nerve degradation (such as MS) rather than initial nerve building. Oat Straw is nutritive and high in silica for hair, nails, and bones.',
     'Milky Oats — better for nerve degradation (e.g. MS) rather than initial nerve building.',
     'Adolescent Support', 40),

    -- Q5: Amenorrhea — energetics
    ('BHC - Class 57 - Repro III',
     'Amenorrhea is described as a cold atonic condition — what type of herbs are indicated?',
     'Cooling, astringent, and anti-inflammatory herbs',
     'Demulcent, moistening herbs to nourish the uterus',
     'Warming, stimulant, and tonifying herbs',
     'Bitter, hepatic herbs to regulate hormone clearance',
     'c',
     'Amenorrhea is a cold atonic condition requiring warming, stimulant, and tonifying herbs — checking for stress, body fat, HPA axis, and thyroid issues first.',
     'A cold atonic condition requiring warming, stimulant, and tonifying herbs',
     'Amenorrhea', 50),

    -- Q6: Vitex for amenorrhea — biphasic protocol
    ('BHC - Class 57 - Repro III',
     'What is the bi-phasic cycle protocol using Vitex and Dong Quai for amenorrhea?',
     'Vitex for the first 2 weeks, then Dong Quai for 2 weeks',
     'Vitex and Dong Quai together for 4 weeks continuously',
     'Dong Quai for 2 weeks then Vitex for 2 weeks',
     'Vitex for 3 weeks, then a 1-week break with Dong Quai',
     'c',
     'The bi-phasic protocol for establishing a cycle in amenorrhea is Dong Quai for 2 weeks followed by Vitex for 2 weeks — or Vitex alone to get the cycle going.',
     'Vitex — promote hormone regulation; 30–60 drops 1× morning; bi-phasic cycle: Dong Quai 2 weeks then Vitex 2 weeks.',
     'Amenorrhea', 60),

    -- Q7: Cinnamon for amenorrhea
    ('BHC - Class 57 - Repro III',
     'What is Cinnamon''s dual role in treating amenorrhea?',
     'Reduces uterine inflammation and soothes cramping',
     'Improves pelvic circulation and uterine tone',
     'Regulates progesterone and reduces estrogen dominance',
     'Stimulates hypothalamic-pituitary-ovarian axis',
     'b',
     'Cinnamon improves pelvic circulation and uterine tone for amenorrhea. The standard infusion dose is 2–4 oz or tincture 20–50 drops up to 4x/day.',
     'Cinnamon — pelvic circulation and uterine tone; standard infusion or tincture 20–50 drops to 4×/day.',
     'Amenorrhea', 70),

    -- Q8: Cramp Bark primary action
    ('BHC - Class 57 - Repro III',
     'What is Cramp Bark''s (Viburnum) primary action in dysmenorrhea and amenorrhea?',
     'Analgesic / anodyne for pain relief',
     'Sedative for emotional component of cramping',
     'Hormone regulator to normalize cycle',
     'Smooth muscle antispasmodic / pelvic tension relief',
     'd',
     'Cramp Bark is a smooth muscle antispasmodic — used for uterine pain relief in both amenorrhea (pelvic tension) and spasmodic dysmenorrhea.',
     'Cramp Bark (Viburnum) — relieve pelvic tension; cold infusion or decoction 3–4 oz to 4×/day; tincture 30–90 drops.',
     'Amenorrhea', 80),

    -- Q9: Black Cohosh dysmenorrhea role
    ('BHC - Class 57 - Repro III',
     'Which action does Black Cohosh provide in the dysmenorrhea formula?',
     'Antispasmodic for uterine muscle',
     'Anodyne / analgesic for pain',
     'Sedative for anxiety component',
     'Hemostatic to control bleeding',
     'b',
     'Black Cohosh is the anodyne (analgesic) in the dysmenorrhea formula — tincture 10–25 drops or capsules #00, 1–2, both up to 3x/day.',
     'Black Cohosh — anodyne for dysmenorrhea; tincture 10–25 drops; capsules #00 1–2 to 3×/day.',
     'Dysmenorrhea', 90),

    -- Q10: Calcium and dysmenorrhea
    ('BHC - Class 57 - Repro III',
     'Which calcium-rich herb is noted for modulating pain perception in dysmenorrhea?',
     'Raspberry Leaf',
     'Nettles',
     'Lemon Balm',
     'Red Clover',
     'c',
     'Lemon Balm is noted as calcium-rich — calcium modulates pain perception, and deficiency is linked to more painful menstrual cycles.',
     'Lemon Balm — calcium-rich; calcium deficiency → more painful cycles; modulates pain perception in dysmenorrhea.',
     'Dysmenorrhea', 100),

    -- Q11: Vitex for menorrhagia
    ('BHC - Class 57 - Repro III',
     'What is Vitex''s role in menorrhagia (heavy bleeding)?',
     'It directly reduces blood flow as a hemostatic',
     'It confirms and supports ovulation as a hormone regulator',
     'It tonifies uterine muscle to prevent heavy flow',
     'It reduces estrogen dominance via liver support',
     'b',
     'Vitex''s role in menorrhagia is as a hormone regulator — specifically to confirm and support ovulation. Dose: 30–60 drops once in the morning.',
     'Vitex — hormone regulator for menorrhagia; 30–60 drops once in morning.',
     'Menorrhagia', 110),

    -- Q12: Yarrow and Nettles for menorrhagia
    ('BHC - Class 57 - Repro III',
     'What is the pairing of Yarrow and Nettles used to address in menorrhagia?',
     'Uterine spasm and pelvic tension',
     'Anemia and nutrient replenishment',
     'Reducing blood flow and providing nourishment',
     'Hormone regulation and cycle establishment',
     'c',
     'Yarrow (hemostatic) and Nettles (hemostatic + nourishment) are paired to reduce blood flow while also providing nutritional support in menorrhagia.',
     'Yarrow — hemostatic; reduce blood flow for menorrhagia; Achillea; tincture 10–40 drops; infusion 2–4 oz.',
     'Menorrhagia', 120),

    -- Q13: Cinnamon emergency use
    ('BHC - Class 57 - Repro III',
     'How is Cinnamon used in a menorrhagia emergency to reduce flow quickly?',
     '10 drops tincture every 15 minutes',
     'Strong decoction or 1 drop essential oil under the tongue',
     'Cold infusion of bark, 4 oz every hour',
     'Capsules #00, 2–3 caps every 4 hours',
     'b',
     'In a menorrhagia emergency, Cinnamon is used as a strong decoction or 1 drop of essential oil under the tongue to reduce flow quickly.',
     'Cinnamon — reduce flow in the moment; strong decoction; 1 drop EO under tongue in emergency.',
     'Menorrhagia', 130),

    -- Q14: Fibroids — herbs list
    ('BHC - Class 57 - Repro III',
     'Which group of herbs is listed in the notes as helpful for fibroids?',
     'Raspberry Leaf, Nettles, Cramp Bark, Motherwort, Angelica',
     'Yarrow, Black Cohosh, Licorice, White Peony, Cinnamon, Vitex, Red Clover',
     'Ginger, Dong Quai, Gotu Kola, Fenugreek, Bitter Melon',
     'Skullcap, California Poppy, Passionflower, Ashwagandha, Bacopa',
     'b',
     'The fibroids herb list includes Yarrow, Black Cohosh, Licorice, White Peony, Cinnamon, Vitex, and Red Clover — addressing excess estrogen, nutritional deficiencies, and blood stasis.',
     'Helpful herbs:\n\t\t* **Yarrow**, **Black cohosh**, **Licorice**, **White peony**, **Cinnamon**, **Vitex**, **Red clover**',
     'Fibroids', 140),

    -- Q15: Red Clover for fibroids
    ('BHC - Class 57 - Repro III',
     'What is Red Clover''s specific role in a fibroids formula?',
     'Directly shrinks fibroid tissue via anti-inflammatory action',
     'Blood mover for stasis, isoflavones, and enhancing progesterone',
     'Reduces estrogen dominance by competing with estrogen receptors',
     'Provides hemostatic action to reduce associated heavy bleeding',
     'b',
     'Red Clover is a blood mover for stasis, contains isoflavones, and enhances progesterone — important in the fibroids formula.',
     'Red Clover — blood mover for stasis; isoflavones; enhance progesterone for fibroids.',
     'Fibroids', 150),

    -- Q16: Fibroids methylation herbs
    ('BHC - Class 57 - Repro III',
     'Which three herbs containing rosmarinic acid are noted for supporting methylation and estrogen metabolism in fibroids?',
     'Yarrow, Calendula, Chamomile',
     'Rosemary, Tulsi, Lemon Balm',
     'Ashwagandha, Bacopa, Gotu Kola',
     'Lavender, Damiana, Rose Petals',
     'b',
     'Rosemary, Tulsi, and Lemon Balm all contain rosmarinic acid and support methylation and estrogen metabolism in fibroid self-care.',
     'methylation, Rosmarinic acid → Rosemary, Tulsi, Lemon Balm',
     'Fibroids', 160),

    -- Q17: Endometriosis — Gotu Kola
    ('BHC - Class 57 - Repro III',
     'Why is Gotu Kola added to an endometriosis formula?',
     'It reduces pelvic inflammatory heat',
     'It provides anodyne pain relief',
     'It supports extracellular matrix and scar tissue',
     'It moves blood stasis and promotes circulation',
     'c',
     'Gotu Kola is added to endometriosis formulas for extracellular matrix support and scar tissue management — endometriosis involves scar tissue causing damage.',
     'Gotu Kola — extracellular matrix support for endometriosis; scar tissue.',
     'Endometriosis', 170),

    -- Q18: Endometriosis — cooling vs warming
    ('BHC - Class 57 - Repro III',
     'In an endometriosis formula, why is Turmeric used in place of Cinnamon?',
     'Turmeric is a stronger hemostatic than Cinnamon',
     'Turmeric is cooling to the inflammation whereas Cinnamon is warming',
     'Turmeric regulates estrogen while Cinnamon does not',
     'Turmeric dissolves scar tissue while Cinnamon does not',
     'b',
     'Endometriosis is a hot inflammatory condition — Turmeric is cooling inflammation while Cinnamon is warming, making the substitution appropriate.',
     'Cooling inflammation with **turmeric** in place of **cinnamon**\n* Add **Gotu kola** for scar tissue support',
     'Endometriosis', 180),

    -- Q19: Endometriosis pain herbs
    ('BHC - Class 57 - Repro III',
     'Which five herbs are listed as pain-relieving herbs for endometriosis?',
     'Cramp Bark, Black Cohosh, Motherwort, Lemon Balm, Vitex',
     'Ginger root, Jamaica Dogwood, Cramp Bark, Devil''s Claw, Turmeric',
     'Yarrow, Nettles, Raspberry Leaf, Cinnamon, Red Clover',
     'Angelica, Passionflower, Skullcap, California Poppy, Valerian',
     'b',
     'The endometriosis pain-relief formula includes Ginger root, Jamaica Dogwood, Cramp Bark, Devil''s Claw, and Turmeric as anti-inflammatory pain relievers.',
     'Pain relieving herbs:\n\t\t* **Ginger root**, **Dogwood**, **Cramp bark**, **Devil''s claw**, **Turmeric**',
     'Endometriosis', 190),

    -- Q20: PCOS formula — Temple of Devotion
    ('BHC - Class 57 - Repro III',
     'The "Temple of Devotion" PCOS formula includes which herb for liver and energy support?',
     'Bacopa',
     'Dong Quai',
     'Schizandra',
     'Bitter Melon',
     'c',
     'Schizandra is the herb for liver and energy in the "Temple of Devotion" PCOS formula — a custom formula also including Bacopa, Fenugreek, Bitter Melon, and Dong Quai.',
     'Schizandra — "Temple of Devotion" PCOS formula; liver and energy.',
     'PCOS and Blood Sugar', 200),

    -- Q21: PCOS formula — blood sugar herbs
    ('BHC - Class 57 - Repro III',
     'Which two herbs in the "Temple of Devotion" PCOS formula specifically address blood sugar regulation?',
     'Schizandra and Bacopa',
     'Dong Quai and Linden',
     'Fenugreek and Bitter Melon',
     'Hawthorn berry and Tulsi',
     'c',
     'Fenugreek and Bitter Melon are the blood sugar herbs in the PCOS formula — PCOS is closely linked to blood sugar dysregulation and HPA/hormonal cascade.',
     'Fenugreek — "Temple of Devotion" PCOS formula; blood sugar regulation.',
     'PCOS and Blood Sugar', 210),

    -- Q22: Dong Quai — stagnation
    ('BHC - Class 57 - Repro III',
     'What is Dong Quai''s primary role in hormonal support formulas?',
     'Hormone regulation through hypothalamic-pituitary axis support',
     'Moving through periods of stagnation and blood movement',
     'Cooling inflammatory heat in the pelvis',
     'Nootropic support for memory and focus',
     'b',
     'Dong Quai moves through periods of stagnation — it is used for hormonal support and blood movement in formulas for PCOS, amenorrhea, and the bi-phasic cycle protocol.',
     'Dong Quai — moves through periods of stagnation; hormonal support.',
     'Nervous System and Hormonal Support', 220),

    -- Q23: Anxiety/sleep formula
    ('BHC - Class 57 - Repro III',
     'Which four herbs make up the anxiety and sleep formula for releasing tension in the stress and burnout section?',
     'Valerian, Milky Oats, Ashwagandha, Tulsi',
     'Skullcap, Chamomile, Motherwort, Linden',
     'California Poppy, Passionflower, Skullcap, Lemon Balm',
     'Passionflower, Lemon Balm, Lavender, Chamomile',
     'c',
     'The anxiety and sleep formula for stress and burnout consists of California Poppy, Passionflower, Skullcap, and Lemon Balm — focused on releasing tension and anxiety.',
     'Anxiety and sleep formula:\n\t\t- **California poppy**, **passionflower**, **skullcap**, **lemon balm**\n\t\t- Focus on releasing tension and anxiety',
     'Stress and Burnout', 230),

    -- Q24: Constitutional support tincture
    ('BHC - Class 57 - Repro III',
     'Which herbs make up the constitutional support tincture for blood sugar dysregulation in the stress/burnout section?',
     'Valerian, Chamomile, Fennel, Catnip, Nettle',
     'Ashwagandha, Milky Oats, Gotu Kola, Bacopa, Tulsi',
     'Dong Quai, Schizandra, Bacopa, Fenugreek, Bitter Melon',
     'California Poppy, Passionflower, Skullcap, Lemon Balm',
     'b',
     'The constitutional support tincture includes Ashwagandha, Milky Oats, Gotu Kola, Bacopa, and Tulsi — addressing blood sugar dysregulation and HPA axis support.',
     'Constitutional support tincture:\n\t\t- **Ashwagandha**, **milky oats**, **gotu kola**, **bacopa**, **Tulsi**\n\t\t- Address blood sugar dysregulation',
     'Stress and Burnout', 240),

    -- Q25: ADHD herbs
    ('BHC - Class 57 - Repro III',
     'Which herbs are specifically noted for ADHD symptoms and cognitive support in this class?',
     'Cramp Bark, Black Cohosh, Motherwort, Yarrow',
     'Schizandra, Bacopa, Ginkgo, Tulsi',
     'California Poppy, Passionflower, Skullcap, Valerian',
     'Vitex, Dong Quai, Red Clover, White Peony',
     'b',
     'Schizandra, Bacopa, Ginkgo, and Tulsi are the primary ADHD and cognitive support herbs. White Peony root is also included for mood and hormonal support in ADHD.',
     'Schisandra, Bacopa for ADHD symptoms\n- Ginkgo, Tulsi for focus',
     'ADHD', 250),

    -- Q26: Skullcap for decision-making
    ('BHC - Class 57 - Repro III',
     'In the nervine and adaptogen section, Skullcap is indicated for which specific presentation?',
     'Mental scatter and exhaustion from overwork',
     'Negative self-talk and emotional depletion',
     'Decision-making paralysis; nervine trophorestorative',
     'Diarrhea and digestive stagnation',
     'c',
     'Skullcap is indicated for decision-making paralysis as a nervine trophorestorative — restoring the capacity for clear decision-making.',
     'Skullcap — decision-making paralysis; nervine trophorestorative.',
     'Nervine and Adaptogen Support', 260),

    -- Q27: Motherwort nervine use
    ('BHC - Class 57 - Repro III',
     'According to the nervine and adaptogen section, Motherwort as a bitter is used for which emotional pattern?',
     'Decision-making paralysis',
     'Negative self-talk',
     'Mental scatter and exhaustion',
     'Circular thinking and anxiety',
     'b',
     'Motherwort is used as a bitter for negative self-talk and emotional depletion in the nervine and adaptogen context.',
     'Motherwort — bitter; for negative self-talk; emotional depletion.',
     'Nervine and Adaptogen Support', 270),

    -- Q28: Panax Ginseng caution
    ('BHC - Class 57 - Repro III',
     'What caution is noted about Panax Ginseng when used for brain fog?',
     'It can cause hypoglycemia if used with insulin',
     'It may be too stimulating',
     'It depletes B vitamins with long-term use',
     'It is contraindicated with hormonal conditions',
     'b',
     'Panax Ginseng is noted for brain fog support but possibly too stimulating — this is an important clinical consideration when formulating for anxious or overstimulated patients.',
     'Panax Ginseng — brain fog; possibly too stimulating.',
     'Nervine and Adaptogen Support', 280),

    -- Q29: Chamomile preparation and sedation
    ('BHC - Class 57 - Repro III',
     'How does Chamomile''s preparation temperature affect its sedative strength?',
     'Cold infusion is more sedative; hot infusion is stimulating',
     'Hot infusion is more sedative; cold infusion is less sleepy',
     'Both preparations have the same sedative effect',
     'Decoction is required for any sedative effect',
     'b',
     'Chamomile''s hot infusion is more sedative; cold infusion is less sleepy. This should be considered when choosing preparation based on a patient''s sleep patterns.',
     'Chamomile — hot infusion more sedative; cold infusion less sleepy; consider preparation method with sleep patterns.',
     'Intentional Herbalism', 290),

    -- Q30: Ginkgo — best form
    ('BHC - Class 57 - Repro III',
     'In what form is Ginkgo noted as providing its best nootropic effects?',
     'Fresh tincture in 65% alcohol',
     'Cold infusion of dried leaves',
     'Standardized extract',
     'Strong decoction of bark',
     'c',
     'Ginkgo is noted as best used as a standardized extract for nootropic effects — it is recommended alongside Ashwagandha, Vitamin D, and Schizandra for daily support.',
     'Ginkgo — nootropic effects; best as standardized extract.',
     'Nootropic Support', 300)
    ;
END $$;
