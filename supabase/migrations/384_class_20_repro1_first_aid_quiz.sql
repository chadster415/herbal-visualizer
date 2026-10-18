-- Migration 384: BHC Class 20 quiz — Reproductive System 1 and Herbal First Aid
--
-- H = 48 unique herbs/supplements identified
-- F = 10 named factual items (specific doses, safety thresholds, named protocols)
-- target = clamp(15 + 48×4 + 10×1, 20, 50) = clamp(217, 20, 50) = 50
--
-- Correct answer distribution: a=13, b=13, c=12, d=12

SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_quiz_questions
             WHERE class_name = 'BHC - Class 20 - Reproductive System 1 and Herbal First Aid') THEN
    RAISE NOTICE 'Class 20 quiz questions already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_quiz_questions
    (class_name, question_text, option_a, option_b, option_c, option_d,
     correct_option, explanation, snippet_text, section_header, sort_order)
  VALUES

    -- Q1 (c) ──────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'Which combination of actions is attributed to Cinnamon (Ceylon) in the reproductive system?',
     'Diuretic and nervine', 'Hormonal replacement and estrogen boost',
     'Hemostatic, tonifying, astringent, and warming to uterine circulation',
     'Antispasmodic and anti-inflammatory only',
     'c',
     'The notes describe Cinnamon as hemostatic (calms heavy bleeding), tonifying and astringent, and warming to the circulatory process in the uterus — a full reproductive tonic profile.',
     'Cinnamon as a reproductive tonic: adaptogenic for uterine tissues, nourishing and moistening, tonifying and astringent, hemostatic to calm heavy bleeding, warming to the circulatory process in the uterus.',
     'Cinnamon', 10),

    -- Q2 (b) ──────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'Which type of cinnamon should be avoided for long-term use due to high coumarin content?',
     'Ceylon cinnamon', 'Cassia (market cinnamon)',
     'Saigon cinnamon', 'White cinnamon',
     'b',
     'Cassia (Cinnamomum aromaticum) is the hard, common market cinnamon with high coumarin levels, making long-term use problematic especially for those with liver issues.',
     'Cassia cinnamon (Cinnamomum aromaticum) — the common market cinnamon, identifiable by its very hard bark. High coumarin levels mean avoid long-term use, especially for those with liver issues. Prefer Ceylon (Cinnamomum verum) for medicinal use.',
     'Cinnamon', 20),

    -- Q3 (a) ──────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'According to Ellingwood, what was Cinnamon specifically prescribed for?',
     'Post-partum depression and atonic conditions after delivery',
     'Amenorrhea and delayed menstruation',
     'Menopausal hot flashes and night sweats',
     'Premenstrual syndrome and mood swings',
     'a',
     'Ellingwood cites Cinnamon for "decoction for post-partum depression. Atonic conditions, for someone who has not given birth. General flaccid state after delivery."',
     'Cinnamon as a reproductive tonic: adaptogenic for uterine tissues, nourishing and moistening, tonifying and astringent, hemostatic to calm heavy bleeding, warming to the circulatory process in the uterus. Ceylon cinnamon (Cinn. verum) preferred for medicinal effects. Ellingwood: "decoction for post-partum depression. Atonic conditions, for someone who has not given birth. General flaccid state after delivery."',
     'Cinnamon', 30),

    -- Q4 (d) ──────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'For a patient with shorter than normal cycles, which herb is indicated for follicular support?',
     'Chasteberry', 'Raspberry leaf',
     'Yarrow', 'Dong Quai',
     'd',
     'Shorter cycles indicate the follicular phase needs support. Dong Quai is the herb called for — it stimulates nourishment to the reproductive tissue during the follicular phase.',
     'shorter cycle, or shorter in between cycles: follicular support / Dong Quai - herb called for',
     'Menstrual Cycle', 40),

    -- Q5 (b) ──────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'Vitex (Chasteberry) is indicated for which cycle pattern?',
     'Shorter cycles needing follicular support', 'Longer cycles or fewer cycles per year needing luteal support',
     'Cycles with heavy bleeding needing hemostatic support', 'Cycles with severe cramping needing antispasmodic support',
     'b',
     'Vitex is for luteal support when cycles are longer than normal or fewer per year (PCOS pattern). It nourishes the parasympathetic nervous system.',
     'Chasteberry (Vitex) for luteal support when cycles are longer than normal or fewer cycles per year (PCOS pattern). Use in weeks 3–4 of cycle for pregnancy attempts.',
     'Menstrual Cycle', 50),

    -- Q6 (a) ──────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'In a pregnancy-attempt protocol, which weeks does Dong Quai cover?',
     'Weeks 1–2 (follicular phase, after cycle starts)',
     'Weeks 3–4 (luteal phase)',
     'The full cycle continuously',
     'Only during the periovulatory window',
     'a',
     'The protocol: Dong Quai for first 2 weeks after cycle start, then Vitex for weeks 3–4. Dong Quai stimulates nourishment to reproductive tissue during the follicular phase.',
     'Dong Quai for first 2 weeks after cycle was judged to start, then Vitex for second 2 weeks / Dong Quai stimulates nourishment to the reproductive tissue',
     'Menstrual Cycle', 60),

    -- Q7 (c) ──────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'Why is tincture the preferred form for Vitex (Chasteberry) over tea?',
     'Tincture has better bioavailability for ovarian receptors',
     'Tea form is contraindicated with PCOS',
     'Vitex has very intense flavors that make it easier to tolerate as a tincture',
     'The active compounds are alcohol-soluble only',
     'c',
     '"Flavors very intense, so tincture gets it down quicker, rather than tea" — this is a practical compliance reason.',
     'Chasteberry (Vitex) for luteal support when cycles are longer than normal or fewer cycles per year (PCOS pattern). Use in weeks 3–4 of cycle for pregnancy attempts. "Vitex nourishes the Parasympathetic NS, relaxing." Tincture preferred due to intense flavor.',
     'Menstrual Cycle', 70),

    -- Q8 (d) ──────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'Motherwort is described as a "big bear hug" — what does it primarily address in the menstrual context?',
     'Heavy bleeding through hemostatic action', 'Hormonal imbalance through liver support',
     'Painful cramping through antispasmodic action', 'Heat, anger, and inflammation in relation to the menstrual cycle',
     'd',
     'Motherwort is used "in relation to the MC, heat, anger, inflammation" — the big bear hug quality speaks to its calming, encompassing effect on heat and nervous tension.',
     'Motherwort: supportive to circulatory, thyroid, and nervous system function. Use in relation to the menstrual cycle, heat, anger, and inflammation — described as a "big bear hug." Complex thyroid interactions covered next class.',
     'Menstrual Health', 80),

    -- Q9 (b) ──────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'What is the important qualification about Nettles'' protein content?',
     'The protein is heat-stable and available in any preparation',
     'Protein is only available if consumed as food; tincture and tea do not convey it',
     'Nettles must be juiced to extract the protein',
     'The protein is bound to oxalic acid and must be neutralized by cooking',
     'b',
     '"High in protein (only if consumed)" — meaning the protein content is only obtained when eating the plant as food, not through aqueous or alcoholic extracts.',
     'Nettles: high in protein (only if consumed), iron, vitamins and minerals. Support for anemia and heavy bleeding; hemostatic.',
     'Menstrual Health', 90),

    -- Q10 (a) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'What is the primary role of Dandelion Root in reproductive health?',
     'Liver support for hormone production and metabolism of excess hormones',
     'Direct uterine tonic to reduce heavy bleeding',
     'Adaptogen for HPA axis regulation',
     'Anti-inflammatory for endometriosis',
     'a',
     '"Dandelion Root — about the liver — the liver produces the hormones, and metabolizes and detoxes from excess hormones. Stacking symptoms indicates the liver to focus on first."',
     'Dandelion Root: about the liver — the liver produces hormones and metabolizes/detoxes excess hormones. Stacking reproductive symptoms indicates focusing on the liver first.',
     'Menstrual Health', 100),

    -- Q11 (c) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'Red Raspberry Leaf is used for fibroids causing heavy bleeding when what specific mechanism is at play?',
     'Excess estrogen thickening the uterine lining', 'Progesterone insufficiency preventing clotting',
     'Reduced uterine tonic contractions and capillaries that won''t close down',
     'Fibroid pressing on the cervical os causing incomplete evacuation',
     'c',
     'Raspberry leaf reduces tonic contractions of the uterus when fibroids have disrupted them, and acts hemostatic when "capillaries won''t close down."',
     'Red Raspberry Leaf: tonification, astringent, nutrient. For fibroids causing heavy bleeding — reduces tonic contractions of the uterus; hemostatic when capillaries won''t close down.',
     'Menstrual Health', 110),

    -- Q12 (d) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'When should the Yarrow/Nettles/Raspberry blend for heavy bleeding be started?',
     'On the first day of menstruation', 'During ovulation',
     'Continuously throughout the entire cycle', 'Two weeks prior to the expected start of menses',
     'd',
     '"For heavy bleeding as part of a blend with nettles and rasp, 2 weeks prior to menses, to nourish the uterine structures first — takes a few cycles."',
     'Yarrow: reproductive tonic — hemostatic, circulatory stimulant, to support repro function. For heavy bleeding: blend with nettles and raspberry 2 weeks prior to menses to nourish uterine structures first; takes a few cycles.',
     'Menstrual Health', 120),

    -- Q13 (b) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'If a patient presents with multiple stacking reproductive symptoms, which organ does the instructor recommend addressing first?',
     'Ovaries (regulate with Vitex)', 'Liver (support with Dandelion Root)',
     'Adrenals (support with adaptogens)', 'Uterus (tonify with Raspberry leaf)',
     'b',
     '"Stacking symptoms indicates the liver to focus on first" — the liver both produces and metabolizes hormones, making it the hub for hormonal imbalance.',
     'Dandelion Root: about the liver — the liver produces hormones and metabolizes/detoxes excess hormones. Stacking reproductive symptoms indicates focusing on the liver first.',
     'Menstrual Health', 130),

    -- Q14 (a) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'How is Ginger described as working in the reproductive context?',
     'Circulatory stimulant and heater that stirs the pot — addresses circulatory and digestive stagnation',
     'Cools excess heat and calms uterine inflammation', 'Nourishes the reproductive tissues through liver support',
     'Tonifies the uterus and reduces excessive bleeding',
     'a',
     '"Ginger — great circulatory stimulant and heater / circulatory, digestive stagnation, life stagnation → stirs the pot with heat."',
     'Ginger: great circulatory stimulant and heater for menstrual health. Addresses circulatory, digestive, and life stagnation — "stirs the pot with heat."',
     'Menstrual Health', 140),

    -- Q15 (c) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'Which herb is paired with Yarrow for bites, stings, and splinters?',
     'Calendula', 'Echinacea', 'Plantain', 'St. John''s Wort',
     'c',
     '"herbs: Yarrow, Plantain, Bentonite Clay" for bites, stings, and splinters. Both Yarrow and Plantain are anti-inflammatory, astringent, and antimicrobial.',
     'Plantain for bites, stings, and splinters: anti-inflammatory, astringent, antimicrobial. Preparations: salve, compress, tincture, or liniment.',
     'Bites, Stings, and Splinters', 150),

    -- Q16 (d) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'Which two plants are listed as interchangeable demulcents for burn treatment?',
     'Calendula and Comfrey', 'Yarrow and Lavender',
     'Lavender and St. John''s Wort', 'Aloe vera and Prickly Pear cactus',
     'd',
     '"Aloe vera or Prickly Pear cactus" — these two are presented as alternatives, both providing demulcent and emollient actions for burns.',
     'Aloe vera for burns: demulcent, emollient, anti-inflammatory. Can substitute Prickly Pear cactus.',
     'Burns', 160),

    -- Q17 (b) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'St. John''s Wort is included in the burns protocol primarily for which actions?',
     'Antiviral protection at the wound site', 'Anti-inflammatory and demulcent topical effect',
     'Styptic to control surface bleeding', 'Antimicrobial to prevent secondary infection',
     'b',
     'The burns section calls for AI (anti-inflammatory), demulcent, and emollient actions — St. John''s Wort is listed among the herbs providing these.',
     'St. John''s Wort for burns: anti-inflammatory, demulcent. Applied topically.',
     'Burns', 170),

    -- Q18 (a) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'Comfrey is described as "herbal stitches" because it does what?',
     'Proliferates cell regeneration', 'Forms a waterproof barrier over the wound',
     'Draws out foreign objects and infection', 'Kills bacteria through high tannin content',
     'a',
     '"comfrey (herbal stitches, proliferates cell regeneration)" — Comfrey''s allantoin promotes rapid cell proliferation for wound closure.',
     'Comfrey for cuts and open wounds — "herbal stitches, proliferates cell regeneration." Use a separate Comfrey + Helichrysum salve for skin healing only, after antimicrobial treatment is complete.',
     'Cuts and Wounds', 180),

    -- Q19 (c) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'Why should salves NOT be used on wounds that need to dry out?',
     'Salves introduce bacteria through the wax base', 'Salves dissolve clotting factors and worsen bleeding',
     'Salves keep wounds moist, impeding healing in wounds that need to dry',
     'Salves cause allergic contact dermatitis in open tissue',
     'c',
     '"You want some wounds to dry out - and salves keep them moist" — salves are better for minor superficial cuts and scrapes, not for wounds requiring desiccation.',
     'Preparations: tincture, poultice, compress, salves (better for minor cuts and scrapes. You want some wounds to dry out - and salves keep them moist)',
     'Cuts and Wounds', 190),

    -- Q20 (d) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'When should the Comfrey + Helichrysum salve be applied to a wound?',
     'Immediately after washing the wound', 'During active infection to slow bacterial spread',
     'Simultaneously with antimicrobial herbs', 'Only after the antimicrobial treatment phase is complete',
     'd',
     '"separate Comfrey + helichrysem salve for skin healing only (after the antimicrobial treatment)" — applying it too early could trap infection under the proliferating tissue.',
     'Helichrysum in a Comfrey + Helichrysum salve for skin healing only — used after the antimicrobial treatment phase is complete.',
     'Cuts and Wounds', 200),

    -- Q21 (b) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'Which herb is noted alongside Yarrow as a styptic for profuse bleeding from cuts?',
     'Plantain', 'Cayenne', 'Goldenseal', 'Comfrey',
     'b',
     '"bleeding profusely (yarrow, cayenne pepper)" — both Yarrow and Cayenne are named as styptics for actively bleeding wounds.',
     'Cayenne for profuse bleeding from cuts: styptic action — mentioned alongside yarrow for bleeding profusely.',
     'Cuts and Wounds', 210),

    -- Q22 (a) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'What mechanism is described for berberine-containing herbs like Oregon Grape Root in wound infections?',
     'Stop further decay of tissues and kill infection through berberine and astringent action',
     'Create a physical barrier that prevents new bacteria from entering',
     'Stimulate white blood cell recruitment to the wound site',
     'Neutralize endotoxins released by bacteria',
     'a',
     '"infections: herbs with berberines and astringent = stop further decay of tissues and zap infection."',
     'infections: herbs with berberines and astringent = stop further decay of tissues and zap infection',
     'Wound Infections', 220),

    -- Q23 (c) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'Which herb is specifically noted for healing infections inside a wound, such as an abscess?',
     'Yarrow', 'Oregon Grape Root', 'Goldenseal', 'Usnea',
     'c',
     '"abscess = goldenseal (can heal infections inside of a wound) and Oregon Grape Root" — Goldenseal is specifically noted for penetrating deep into wound tissue.',
     'Goldenseal for abscess: "can heal infections inside of a wound." Used with Oregon Grape Root. Berberine-rich antimicrobial.',
     'Wound Infections', 230),

    -- Q24 (d) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'What is the first step in removing a tick according to these notes?',
     'Apply Thuja EO directly to the tick', 'Pull the tick straight out with tweezers',
     'Cover with petroleum jelly and wait for it to release', 'Use a q-tip to massage around the tick to encourage it to let go; avoid squishing',
     'd',
     '"tick bites = avoid squishing it, use a q-tip to massage the area around the tick to encourage it to let go." Squishing can inject contents into the bite site.',
     'tick bites = avoid squishing it, use a q-tip to massage the area around the tick to encourage it to let go. Apply thuja EO (good to have in your kit - some say this can stop lyme)',
     'Wound Infections', 240),

    -- Q25 (b) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'Which herb is applied as an essential oil to a tick bite site to potentially prevent Lyme disease?',
     'Echinacea', 'Thuja', 'Andrographis', 'Astragalus',
     'b',
     '"Apply thuja EO (good to have in your kit - some say this can stop lyme)" — Thuja is the specific topical EO recommended for tick bite sites.',
     'Thuja EO for tick bites: apply to the tick site — "some say this can stop Lyme." Good to keep in first aid kit.',
     'Wound Infections', 250),

    -- Q26 (a) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'Which two herbs are recommended together for internal antimicrobial and immune support after a tick bite?',
     'Andrographis and Astragalus', 'Echinacea and Goldenseal',
     'Thuja and Oregon Grape Root', 'Yarrow and Astragalus',
     'a',
     '"andrographis/astragalus" — these two are listed together for post-tick-bite internal support: Andrographis for antimicrobial action and Astragalus for immune support.',
     'Andrographis for tick bites: antimicrobial/antiviral support after tick exposure, paired with Astragalus as immune support.',
     'Wound Infections', 260),

    -- Q27 (c) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'St. John''s Wort is listed in the pain section specifically for which type of pain?',
     'Musculoskeletal and joint pain', 'Menstrual cramping (antispasmodic)',
     'Nerve pain', 'Headache and migraine',
     'c',
     '"herbs: (internally) willow bark, SJW (nerve)" — SJW is parenthetically labeled as nerve-specific in the pain section.',
     'St. John''s Wort (SJW): specific for nerve pain, taken internally.',
     'Pain', 270),

    -- Q28 (d) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'Which two herbs are noted as a topical combination spray for neck pain?',
     'Willow and St. John''s Wort', 'Lavender and Yarrow',
     'Comfrey and Helichrysum', 'Hops and Teasel Root',
     'd',
     '"hops + teasel combo - spray for neck pain?" — these two are specifically noted as a spray combination for neck pain.',
     'Hops: noted in combination with Teasel as a spray for neck pain.',
     'Pain', 280),

    -- Q29 (b) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'Which herb is listed for acute digestive upset and diarrhea in the first aid section?',
     'Yarrow', 'Blackberry root/leaf', 'Ginger', 'Dandelion root',
     'b',
     '"blackberry root/leaf" is listed for digestive upset — its astringent tannins address diarrhea directly.',
     'Blackberry root/leaf for digestive upset: antidiarrheal, astringent. Used alongside charcoal for acute digestive complaints.',
     'Digestive Upset', 290),

    -- Q30 (a) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'What safety concern is specifically noted for Lobelia?',
     'Acrid and slightly toxic; causes vomiting at high doses',
     'Can raise blood pressure dangerously in acute asthma',
     'Contraindicated with other nervines due to synergistic toxicity',
     'Can cause respiratory depression at therapeutic doses',
     'a',
     '"Lobelia - acrid, slightly toxic. Can cause vomiting at high doses" — this dictates drop dose use.',
     'Lobelia for asthma and allergic reactions: acrid, slightly toxic. Can cause vomiting at high doses. Use as drop or low dose.',
     'Asthma and Allergic Reactions', 300),

    -- Q31 (c) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'Because Lobelia is slightly toxic, it falls into which dosing category defined in these notes?',
     'Plateau dose (maximal medicinal effect)', 'Loading dose (larger initial dose)',
     'Drop dose (5 drops — used for plants that are slightly toxic)',
     'Medium dose (1–2 ml)',
     'c',
     '"drop dose = plants that are slightly toxic (pulsatilla, lobelia)" — both Lobelia and Pulsatilla are explicitly named as drop-dose herbs.',
     'Lobelia for asthma and allergic reactions: acrid, slightly toxic. Can cause vomiting at high doses. Use as drop or low dose.',
     'Asthma and Allergic Reactions', 310),

    -- Q32 (d) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'Which two herbs are specifically labeled as decongestants for asthma and allergic reactions?',
     'Lobelia and Ma Huang', 'Echinacea and Astragalus',
     'Gumweed and Ma Huang', 'Yerba Santa and Gumweed',
     'd',
     '"Yerba santa, gumweed (decongestants)" — these two are explicitly labeled as decongestants, distinct from the bronchodilator role of Ma Huang.',
     'Yerba Santa: decongestant for asthma and allergic reactions.',
     'Asthma and Allergic Reactions', 320),

    -- Q33 (b) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'Which herb is described as "specific for shock" that can ground a person?',
     'Skullcap', 'Pasqueflower (Pulsatilla)', 'Kava', 'California Poppy',
     'b',
     '"Pulsatilla is specific for shock - 1-5 drops / can ground you" — Pulsatilla is explicitly named as the specific herb for acute shock.',
     'Pasqueflower (Pulsatilla) is specific for shock: use 1–5 drops, can ground the person. Drop dose — use very small amounts.',
     'Shock and Acute Anxiety', 330),

    -- Q34 (a) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'What is the dose for Pasqueflower (Pulsatilla) in a shock situation?',
     '1–5 drops (drop dose)', '1–2 ml (medium dose)',
     '2–5 ml (large dose)', '4 droppers full (high dose)',
     'a',
     '"Pulsatilla is specific for shock - 1-5 drops" — this is a drop dose because Pulsatilla is slightly toxic.',
     'Pasqueflower (Pulsatilla) is specific for shock: use 1–5 drops, can ground the person. Drop dose — use very small amounts.',
     'Shock and Acute Anxiety', 340),

    -- Q35 (c) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'What dose of Skullcap is recommended for acute shock, grief, and anxiety?',
     '5 drops (low dose)', '1–2 ml (medium dose)',
     '4 droppers full (high dose)', '1–5 drops (drop dose)',
     'c',
     '"high dose of skullcap (4 droppers full)" — unlike Pulsatilla, Skullcap is safe at high doses and can be used assertively for acute nervous system shock.',
     'Skullcap at high dose (4 droppers full) for shock, grief, and acute anxiety.',
     'Shock and Acute Anxiety', 350),

    -- Q36 (d) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'In what specific context is Kava used in herbal first aid according to these notes?',
     'For insomnia following traumatic events', 'As a nervine to reduce anxiety during recovery',
     'For grounding in emotional shock', 'For dissociation during active injury or procedures such as surgeries',
     'd',
     '"if you want to disassociate (active injury), Ghost Pipe can disassociate you / even Ghost Pipe + Kava (like for surgeries or procedures)" — Kava is specific to active-injury or procedural dissociation.',
     'Kava for dissociation during active injury or procedures (e.g., surgeries) — noted in combination with Ghost Pipe.',
     'Shock and Acute Anxiety', 360),

    -- Q37 (b) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'How should Corn Silk be specifically prepared for UTI treatment?',
     'As a hot decoction to extract polysaccharides', 'As a cold infusion (dried herb steeped in cold water)',
     'As a tincture in high-proof alcohol', 'As a powdered capsule',
     'b',
     '"dried corn silk cold infusion tea: make urethra slippery" — cold infusion is specifically called for, not a hot preparation.',
     'Corn Silk as a cold infusion (dried) for UTIs: "make urethra slippery." Prepared as a cold infusion, not hot tea.',
     'UTIs', 370),

    -- Q38 (a) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'What mechanism does Corn Silk use to help with UTIs?',
     'Makes the urethra slippery, facilitating mechanical flushing of bacteria',
     'Kills urinary bacteria through direct antimicrobial action',
     'Alkalinizes the urine to prevent bacterial adhesion',
     'Reduces bladder spasm through antispasmodic action',
     'a',
     '"dried corn silk cold infusion tea: make urethra slippery" — the mechanism is demulcent/lubricant rather than antimicrobial.',
     'Corn Silk as a cold infusion (dried) for UTIs: "make urethra slippery." Prepared as a cold infusion, not hot tea.',
     'UTIs', 380),

    -- Q39 (c) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'Which two herbs are specifically noted as a pair for UTI treatment in these notes?',
     'Corn Silk and Andrographis', 'Goldenseal and Oregon Grape Root',
     'Bearberry (Uva ursi) and Usnea', 'Echinacea and Corn Silk',
     'c',
     '"Uva ursi, usnea together" — these two are explicitly combined for UTI treatment, both providing antimicrobial action in the urinary tract.',
     'Usnea for UTIs: antimicrobial. Used together with Bearberry (Uva ursi).',
     'UTIs', 390),

    -- Q40 (d) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'What clinical criteria define menorrhagia (heavy bleeding) according to these notes?',
     'Any bleeding lasting more than 5 days', 'Losing more than 50 ml total per cycle',
     'More than 5 days OR soaking a regular pad in 3 hours',
     'More than 8 days long OR soaking a thick pad in 2 hours',
     'd',
     '"menorrhagia - more than 8 days long, or soaking a thick pad in 2 hours" — these are the clinical thresholds given.',
     'heavy or prolonged bleeding / menorrhagia - more than 8 days long, or soaking a thick pad in 2 hours',
     'Menstrual Cycle', 400),

    -- Q41 (b) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'For which body region is Ocotillo used as a specific lymphatic formula?',
     'Upper chest and axillary lymph nodes', 'Lower abdomen and extremities',
     'Kidneys and adrenal region', 'Pelvic lymph nodes only',
     'b',
     '"Ocotillo specific lymphatic formula for lower abdomen and extremities / maybe for sedentary indivs / encourage venous return."',
     'Ocotillo: specific lymphatic formula for the lower abdomen and extremities. For sedentary individuals; encourages venous return and poor leg circulation. Commit for 3–4 months to shift established body patterns.',
     'Menstrual Health', 410),

    -- Q42 (a) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'What minimum commitment time is recommended for Ocotillo when addressing venous return and leg circulation?',
     '3–4 months', '4–6 weeks', '6–8 weeks', '6 months or longer',
     'a',
     '"commit to it for 3-4 months / need to shift patterns the body has gotten into, give it new patterns."',
     'Ocotillo: specific lymphatic formula for the lower abdomen and extremities. For sedentary individuals; encourages venous return and poor leg circulation. Commit for 3–4 months to shift established body patterns.',
     'Menstrual Health', 420),

    -- Q43 (c) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'What organ system interaction with Motherwort is flagged as complex in these notes?',
     'Adrenal (HPA axis) interactions', 'Nervous system sedation synergy',
     'Thyroid interactions', 'Liver enzyme induction',
     'c',
     '"Motherwort / complex thyroid interactions (next class)" — the instructor specifically flags thyroid interactions as complex and defers them to the following class.',
     'Motherwort: supportive to circulatory, thyroid, and nervous system function. Use in relation to the menstrual cycle, heat, anger, and inflammation — described as a "big bear hug." Complex thyroid interactions covered next class.',
     'Menstrual Health', 430),

    -- Q44 (d) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'Which herb is specifically indicated for sedentary individuals with poor venous return to the lower abdomen and extremities?',
     'Yarrow', 'Ginger', 'Motherwort', 'Ocotillo',
     'd',
     '"Ocotillo specific lymphatic formula for lower abdomen and extremities / maybe for sedentary indivs / encourage venous return, for those with poor leg circulation."',
     'Ocotillo: specific lymphatic formula for the lower abdomen and extremities. For sedentary individuals; encourages venous return and poor leg circulation. Commit for 3–4 months to shift established body patterns.',
     'Menstrual Health', 440),

    -- Q45 (b) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'For a patient with shorter than normal cycles, what type of phase support is indicated?',
     'Luteal support (Chasteberry)', 'Follicular support (Dong Quai)',
     'Hemostatic support (Yarrow and Nettles)', 'Hepatic support (Dandelion Root)',
     'b',
     '"shorter cycle, or shorter in between cycles: follicular support / Dong Quai - herb called for."',
     'Dong Quai for follicular support when cycles are shorter than normal. For pregnancy attempts: use first 2 weeks after cycle start to stimulate nourishment to reproductive tissue.',
     'Menstrual Cycle', 450),

    -- Q46 (a) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'For abscess formation in a wound, which herb pairing is specifically indicated?',
     'Goldenseal and Oregon Grape Root', 'Echinacea and Garlic',
     'Chaparral and Usnea', 'Myrrh and Yarrow',
     'a',
     '"abscess = goldenseal (can heal infections inside of a wound) and Oregon Grape Root" — both are berberine-rich antimicrobials with Goldenseal specifically noted for internal wound infection.',
     'Goldenseal for abscess: "can heal infections inside of a wound." Used with Oregon Grape Root. Berberine-rich antimicrobial.',
     'Wound Infections', 460),

    -- Q47 (c) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'What does Dong Quai stimulate in the body for reproductive health?',
     'Progesterone-like hormonal activity', 'HPA axis calming via cortisol modulation',
     'Nourishment to the reproductive tissue', 'Cervical mucus production',
     'c',
     '"Dong Quai stimulates nourishment to the reproductive tissue" — its primary action is nutritive/trophorestorative to reproductive organs.',
     'Dong Quai for follicular support when cycles are shorter than normal. For pregnancy attempts: use first 2 weeks after cycle start to stimulate nourishment to reproductive tissue, then transition to Vitex for weeks 3–4. "Dong Quai stimulates nourishment to the reproductive tissue."',
     'Menstrual Cycle', 470),

    -- Q48 (d) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'When a patient is developing fewer menstrual cycles per year and a PCOS pattern, what type of support and which herb is indicated?',
     'Follicular support — Dong Quai', 'Hemostatic support — Yarrow and Nettles',
     'Liver support — Dandelion Root', 'Luteal support — Chasteberry (Vitex)',
     'd',
     '"longer cycle, or longer in between cycles: luteal support / Vitex - herb called for / you start to see fewer cycles per year / PCOS to watch out for."',
     'Chasteberry (Vitex) for luteal support when cycles are longer than normal or fewer cycles per year (PCOS pattern). Use in weeks 3–4 of cycle for pregnancy attempts.',
     'Menstrual Cycle', 480),

    -- Q49 (b) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'What are the three herbs in the classic blend for heavy bleeding used in the 2-week pre-menses protocol?',
     'Yarrow, Dandelion Root, and Cinnamon', 'Yarrow, Nettles, and Raspberry leaf',
     'Yarrow, Motherwort, and Raspberry leaf', 'Nettles, Cinnamon, and Raspberry leaf',
     'b',
     '"for heavy bleeding as part of a blend with nettles and rasp, 2 weeks prior to menses, to nourish the uterine structures first."',
     'Yarrow: reproductive tonic — hemostatic, circulatory stimulant, to support repro function. For heavy bleeding: blend with nettles and raspberry 2 weeks prior to menses to nourish uterine structures first; takes a few cycles.',
     'Menstrual Health', 490),

    -- Q50 (a) ─────────────────────────────────────────────────────────────────
    ('BHC - Class 20 - Reproductive System 1 and Herbal First Aid',
     'For wound infections requiring external treatment, which preparation form is preferred for tissue penetration?',
     'Tincture or liniment', 'Salve', 'Powder', 'Compress',
     'a',
     '"herbs: (externally as a tincture or liniment) chaparral, echinacea, garlic, myrrh, OGR, yarrow..." — tincture/liniment penetrates infected tissue more effectively than salves.',
     'Chaparral for infected wounds and animal bites: antimicrobial, anti-inflammatory. Applied externally as tincture or liniment.',
     'Wound Infections', 500);

END $$;
