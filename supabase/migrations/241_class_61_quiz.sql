-- Migration 241: Class 61 — Repro IV Hormonal Matrix quiz questions
-- Source: supabase/migrations/215_class_61_repro_hormonal_data.sql
SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_quiz_questions
             WHERE class_name = 'BHC - Class 61 - Repro IV Hormonal Matrix') THEN
    RAISE NOTICE 'Class 61 quiz questions already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_quiz_questions
    (class_name, question_text, option_a, option_b, option_c, option_d,
     correct_option, explanation, snippet_text, section_header, sort_order)
  VALUES

    -- Q1
    ('BHC - Class 61 - Repro IV Hormonal Matrix',
     'According to the personal notes, why must Dong Quai be avoided when a patient has fibroids and heavy bleeding?',
     'Dong Quai is strongly anti-inflammatory and aggravates hormonal patterns', 'Dong Quai is a tissue builder and can aggravate heavy bleeding', 'Dong Quai inhibits progesterone and worsens fibroid growth', 'Dong Quai is hepatotoxic and impairs estrogen metabolism',
     'b',
     'The personal notes state clearly: "Anytime heavy bleeding, dong quai can aggravate — dong quai is a tissue builder."',
     'Anytime heavy bleeding, dong quai can aggravate — dong quai is a tissue builder',
     'Presentations', 10),

    -- Q2
    ('BHC - Class 61 - Repro IV Hormonal Matrix',
     'What is Vitex''s primary mechanism of action as described in the personal notes?',
     'Direct estrogen receptor agonist that reduces fibroid size', 'Dopamine agonist that allows the pituitary to release hormones; does not affect the uterus directly', 'Progesterone precursor that raises progesterone levels', 'Anti-inflammatory that reduces uterine congestion',
     'b',
     'The personal notes explain that Vitex is a dopamine agonist, which allows the pituitary to release hormones and doesn''t affect the uterus directly.',
     'Vitex — dopamine agonist; allows the pituitary to release hormones; doesn''t affect the uterus directly',
     'Presentations', 20),

    -- Q3
    ('BHC - Class 61 - Repro IV Hormonal Matrix',
     'Shepherd''s Purse is described as very effective for which condition, but with a specific caution about overuse?',
     'Vaginitis — can overly dry vaginal mucosa', 'Heavy bleeding — it can clot up the uterus and should only be used in very heavy situations', 'Fibroids — it can cause spasm if used too long', 'Hormonal imbalance — it can suppress the HPG axis',
     'b',
     'The personal notes state Shepherd''s Purse is "so effective it can clot up the uterus; only use in very heavy situations."',
     'Shepherd''s purse very effective for heavy bleeding — so effective it can clot up the uterus; only use in very heavy situations',
     'Presentations', 30),

    -- Q4
    ('BHC - Class 61 - Repro IV Hormonal Matrix',
     'What is White Peony''s primary described action in relation to fibroids?',
     'Uterine tonic that strengthens myometrium', 'Anti-fibrotic', 'Dopamine agonist supporting pituitary function', 'Astringent reducing heavy flow',
     'b',
     'The personal notes simply and directly state: "White peony — anti-fibrotic."',
     'White peony — anti-fibrotic',
     'Presentations', 40),

    -- Q5
    ('BHC - Class 61 - Repro IV Hormonal Matrix',
     'Black Cohosh is indicated for base of skull headaches, but what happens if the dose is too high?',
     'It causes uterine cramping and menorrhagia', 'It can cause the very headaches it is used to treat', 'It produces hypertension and visual disturbance', 'It suppresses ovulation',
     'b',
     'The personal notes note that Black Cohosh is "indicated for base of skull headaches, but can cause them if dose is too high."',
     'Black cohosh indicated for base of skull headaches, but can cause them if dose is too high',
     'Presentations', 50),

    -- Q6
    ('BHC - Class 61 - Repro IV Hormonal Matrix',
     'How does Milk Thistle support hormonal balance according to the personal notes?',
     'It is a phytoestrogen that directly replaces estrogen', 'It helps with elimination of all things, enabling hormones to be better processed and eliminated', 'It stimulates progesterone production in the corpus luteum', 'It inhibits aromatase to prevent excess estrogen',
     'b',
     'The personal notes describe Milk Thistle as helping "with elimination of all things, enabling hormones to be better processed and eliminated."',
     'Milk Thistle — helps with elimination of all things, enabling hormones to be better processed and eliminated',
     'Presentations', 60),

    -- Q7
    ('BHC - Class 61 - Repro IV Hormonal Matrix',
     'According to the personal notes, when do Ginsengs work best?',
     'When patients are depleted and need immediate energy', 'When people are already well-resourced', 'During the luteal phase of the menstrual cycle only', 'Alongside anti-inflammatory herbs to prevent overstimulation',
     'b',
     'The personal notes state that "Ginsengs work best when people are already well-resourced," echoing the generated notes caution about using Ginseng only when the nutritional foundation is already strong.',
     'Ginsengs work best when people are already well-resourced',
     'Presentations', 70),

    -- Q8
    ('BHC - Class 61 - Repro IV Hormonal Matrix',
     'What does the class recommend instead of oils for a vaginal wash, and what is the reason?',
     'Vinegar rinse; it restores acidic pH', 'Aloe as a carrier; oils can change the pH of mucous tissues so a wash or sitz bath is better', 'Witch hazel; it is astringent and antimicrobial', 'Saline solution; it is isotonic and non-irritating',
     'b',
     'The personal notes state that Aloe should be used as a carrier for vaginal washes because oils can change pH of mucous tissues, making a wash or sitz bath preferable.',
     'Aloe as a carrier for vaginal washes; oils can change pH of mucous tissues — wash or sitz bath is better',
     'Presentations', 80),

    -- Q9
    ('BHC - Class 61 - Repro IV Hormonal Matrix',
     'What is the patient formula dosage noted for the hormonal support tincture in the personal (Lisa) case?',
     '1 tsp 2×/day', '2 tsp 3×/day', '1 tbsp 2×/day', '5 ml 4×/day',
     'b',
     'The patient case personal notes specify "2 tsp 3x/day" as the dosage for the hormonal support formula.',
     'Patient formula (hormonal support — 2 tsp 3x/day): Licorice, White Peony, Red Clover, Vitex, Cinnamon',
     'Lisa (Patient Case)', 90),

    -- Q10
    ('BHC - Class 61 - Repro IV Hormonal Matrix',
     'Which five herbs make up the patient hormonal support tincture formula in the Lisa patient case?',
     'Vitex, Black Cohosh, Red Raspberry, Shatavari, Schisandra', 'Licorice, White Peony, Red Clover, Vitex, Cinnamon', 'Ashwagandha, Shatavari, Maca, Reishi, Licorice', 'Blue Cohosh, Periwinkle, Black Cohosh, Cleavers, Chamomile',
     'b',
     'The Lisa patient case lists Licorice, White Peony, Red Clover (Trifolium), Vitex, and Cinnamon as the five-herb hormonal support tincture.',
     'Patient formula (hormonal support — 2 tsp 3x/day): Licorice, White Peony, Red Clover (Trifolium), Vitex, Cinnamon',
     'Lisa (Patient Case)', 100),

    -- Q11
    ('BHC - Class 61 - Repro IV Hormonal Matrix',
     'What herbs make up the sitz bath in the Lisa patient case?',
     'Chamomile, lavender, rose petals, calendula', 'Calendula, elecampane, rose petals, yarrow', 'Uva ursi, catnip, chamomile, black cohosh', 'Horsetail, nettle, corn silk, lady''s mantle',
     'b',
     'The Lisa patient case specifies calendula, elecampane, rose petals, and yarrow as the sitz bath formula.',
     'Sitz bath (patient case): calendula, elecampane, rose petals, yarrow',
     'Lisa (Patient Case)', 110),

    -- Q12
    ('BHC - Class 61 - Repro IV Hormonal Matrix',
     'What daily food supplement is included in the Lisa patient protocol for hormonal support?',
     'Evening primrose oil 1 tsp daily', 'Flax seed 2 tbsp daily', 'Castor oil packs nightly', 'Vitamin D 2000 IU daily',
     'b',
     'The personal case notes include "Flax seed 2 tbsp daily" in the patient protocol for hormonal support.',
     'Flax seed 2 tbsp daily — in patient protocol for hormonal support',
     'Lisa (Patient Case)', 120),

    -- Q13
    ('BHC - Class 61 - Repro IV Hormonal Matrix',
     'According to the vaginitis notes, what preparation method is described for the turmeric, ginger, black pepper anti-inflammatory decoction?',
     'Cold infusion overnight, strain and apply topically', 'Simmer 10 minutes, steep 10 minutes, take twice daily', 'Boil 20 minutes, strain, drink once at night', 'Fresh juice blend, drink immediately',
     'b',
     'The vaginitis notes specify "simmer 10 min, steep 10 min, twice daily" for the turmeric, ginger, black pepper anti-inflammatory decoction.',
     'Turmeric, ginger, black pepper — anti-inflammatory, synergistic; simmer 10 min, steep 10 min, twice daily',
     'Vaginitis', 130),

    -- Q14
    ('BHC - Class 61 - Repro IV Hormonal Matrix',
     'Which topical preparation is described for reducing inflammation in vaginitis?',
     'Uva ursi poultice applied directly', 'Calendula and chamomile infused bath', 'Black cohosh tincture diluted in aloe', 'Milk thistle seed poultice',
     'b',
     'The vaginitis notes describe a calendula and chamomile infused bath to reduce inflammation.',
     'Calendula and chamomile — infused bath to reduce inflammation in vaginitis',
     'Vaginitis', 140),

    -- Q15
    ('BHC - Class 61 - Repro IV Hormonal Matrix',
     'What role does Milk Thistle play in the vaginitis treatment plan?',
     'Antimicrobial applied as a douche', 'Supports liver; helps metabolise estrogen', 'Anti-inflammatory in the infused bath', 'Uterine tonic taken as a tincture',
     'b',
     'The vaginitis notes state that Milk Thistle "supports liver, metabolizes estrogen; used in vaginitis treatment."',
     'Milk thistle — supports liver, metabolizes estrogen; used in vaginitis treatment',
     'Vaginitis', 150),

    -- Q16
    ('BHC - Class 61 - Repro IV Hormonal Matrix',
     'In a mineral formula containing cooling minerals, what herb does the class recommend adding to balance the cooling effect?',
     'Black cohosh', 'Yarrow', 'Chamomile', 'Lemon balm',
     'b',
     'The personal notes state: "In a mineral formula (with nettles) — minerals are cooling, so add some warming herbs, for example Yarrow."',
     'In a mineral formula (with nettles) — minerals are cooling, so add some warming herbs, for example Yarrow',
     'Presentations', 160),

    -- Q17
    ('BHC - Class 61 - Repro IV Hormonal Matrix',
     'What herbs make up the regenerative tea blend described in the generated notes for uterine and hormonal support?',
     'Chamomile, lemon balm, passionflower, skullcap, valerian, catnip, linden', 'Horsetail, corn silk, nettle, yarrow, lady''s mantle, hibiscus, red clover', 'Raspberry leaf, blue cohosh, periwinkle, cleavers, calendula, rose, plantain', 'Dandelion root, burdock, red clover, licorice, shatavari, astragalus, alfalfa',
     'b',
     'The regenerative tea blend is specified as horsetail, corn silk, nettle, yarrow, lady''s mantle, hibiscus, and red clover, to be taken as large daily infusions.',
     'Regenerative tea blend: horsetail, corn silk, nettle, yarrow, lady''s mantle, hibiscus, red clover — large daily infusions',
     'Regenerative Tea Blend', 170),

    -- Q18
    ('BHC - Class 61 - Repro IV Hormonal Matrix',
     'Which hormone and uterine support tincture combines Vitex, Schisandra, and Red Raspberry Leaf?',
     'The vaginitis tincture', 'The hormone and uterine support tincture', 'The fibroids and vaginitis tincture', 'The stress formula',
     'b',
     'The generated notes describe a hormone and uterine support tincture containing Vitex (hormone-balancing), Schisandra (hormone-balancing, astringent), and Red Raspberry Leaf (uterine tonic).',
     'Vitex — hormone-balancing; in tincture for hormone and uterine support',
     'Hormone and Uterine Support', 180),

    -- Q19
    ('BHC - Class 61 - Repro IV Hormonal Matrix',
     'The stress formula described in the traditional formulas section consists of which three herbs?',
     'Valerian, passionflower, and skullcap', 'Catnip, lemon balm, and chamomile', 'Linden, lavender, and motherwort', 'Ashwagandha, eleuthero, and rhodiola',
     'b',
     'The traditional formulas section lists the stress formula as catnip, lemon balm, and chamomile.',
     'Stress formula — catnip, lemon balm, chamomile',
     'Traditional Formulas', 190),

    -- Q20
    ('BHC - Class 61 - Repro IV Hormonal Matrix',
     'Which herb is recommended for lymphatic support as an addition to a uterine tonic formula?',
     'Red Clover', 'Cleavers', 'Yarrow', 'Lady''s Mantle',
     'b',
     'The traditional formulas section notes Cleavers for "lymphatic support; add to formula for balance."',
     'Cleavers — lymphatic support; add to formula for balance',
     'Traditional Formulas', 200),

    -- Q21
    ('BHC - Class 61 - Repro IV Hormonal Matrix',
     'What combination forms the traditional uterine tonic and astringent formula listed in the notes?',
     'Vitex, Schisandra, Red Raspberry Leaf', 'Blue Cohosh, Periwinkle, Black Cohosh', 'Nettle, Horsetail, Lady''s Mantle', 'Calendula, Chamomile, Rose',
     'b',
     'The traditional formulas section lists Blue Cohosh, Periwinkle, and Black Cohosh as the traditional uterine tonic/astringent combination.',
     'Blue cohosh, periwinkle, black cohosh — uterine tonic, astringents',
     'Traditional Formulas', 210),

    -- Q22
    ('BHC - Class 61 - Repro IV Hormonal Matrix',
     'What perineal wash combination is described in the additional herbs section?',
     'Uva ursi, chamomile, calendula, witch hazel', 'Calendula, plantain, rose, yarrow', 'Marshmallow, linden, chamomile, lavender', 'Horsetail, corn silk, nettle, hibiscus',
     'b',
     'The additional herbs and actions section describes a perineal wash made from calendula, plantain, rose, and yarrow.',
     'Perineal wash — calendula, plantain, rose, yarrow',
     'Additional Herbs and Actions', 220),

    -- Q23
    ('BHC - Class 61 - Repro IV Hormonal Matrix',
     'What action is Uva Ursi specifically noted for in the fibroids and vaginitis tincture?',
     'Uterine tonic and hormone balancing', 'Antimicrobial and anti-inflammatory', 'Dopamine agonist supporting the pituitary', 'Sedative and nervine',
     'b',
     'The fibroids and vaginitis section describes Uva Ursi as "antimicrobial, anti-inflammatory; in tincture for fibroids and vaginitis."',
     'Uva ursi — antimicrobial, anti-inflammatory; in tincture for fibroids and vaginitis',
     'Fibroids and Vaginitis', 230),

    -- Q24
    ('BHC - Class 61 - Repro IV Hormonal Matrix',
     'Catnip''s role in the fibroids and vaginitis tincture formula is described as which action?',
     'Anti-fibrotic', 'Sedative', 'Uterine tonic', 'Antimicrobial',
     'b',
     'The fibroids and vaginitis section describes Catnip as "sedative; in tincture formula for fibroids and vaginitis."',
     'Catnip — sedative; in tincture formula for fibroids and vaginitis',
     'Fibroids and Vaginitis', 240),

    -- Q25
    ('BHC - Class 61 - Repro IV Hormonal Matrix',
     'In the generated notes, Astragalus is recommended in what situation as a gentler alternative to Ginseng?',
     'When the patient has chronic inflammation', 'As a nourishing foundation when Ginseng would be premature', 'When the patient has vaginitis alongside hormonal imbalance', 'As an anti-inflammatory for fibroid management',
     'b',
     'The nervous system support notes describe Astragalus as "nourishing foundation when ginseng would be premature," implying it should be used to build patients up before they are ready for Ginseng.',
     'Astragalus as nourishing foundation when ginseng would be premature',
     'Nervous System Support', 250),

    -- Q26
    ('BHC - Class 61 - Repro IV Hormonal Matrix',
     'Dandelion leaf is described with which specific action in the dandelion and prebiotics section?',
     'Bitter tonic and hepatic', 'Diuretic; supports kidneys and flushes out microbes and proteins', 'Uterine tonic and astringent', 'Adaptogen for hormonal support',
     'b',
     'The dandelion and prebiotics section describes Dandelion Leaf as "diuretic, supports kidneys; flushes out microbes and proteins."',
     'Dandelion leaf — diuretic, supports kidneys; flushes out microbes and proteins',
     'Dandelion and Prebiotics', 260),

    -- Q27
    ('BHC - Class 61 - Repro IV Hormonal Matrix',
     'How does Dandelion Root differ from Dandelion Leaf in its described therapeutic use?',
     'Root is diuretic; leaf is hepatic', 'Root is more bitter-specific as a tea tonic; leaf is the diuretic for kidneys', 'Root is an adaptogen; leaf is a uterine tonic', 'Root is anti-inflammatory; leaf is an astringent',
     'b',
     'The notes describe Dandelion Root as "tea tonic, more bitter-specific" while Dandelion Leaf is described as "diuretic, supports kidneys."',
     'Dandelion root — tea tonic, more bitter-specific',
     'Dandelion and Prebiotics', 270),

    -- Q28
    ('BHC - Class 61 - Repro IV Hormonal Matrix',
     'What is the action attributed to Wild Yam in the anxiety support section?',
     'Sedative nervine reducing anxiety', 'Anti-spasmodic; promotes bile flow', 'Astringent for mucous membranes', 'Uterine tonic for heavy bleeding',
     'b',
     'The anxiety support section notes Wild Yam as "anti-spasmodic, promotes bile flow."',
     'Wild yam — anti-spasmodic, promotes bile flow',
     'Anxiety Support', 280),

    -- Q29
    ('BHC - Class 61 - Repro IV Hormonal Matrix',
     'Black Cohosh is described as helpful for which transitional hormonal phase in the generated notes?',
     'Menarche', 'Premenopause', 'Postmenopause', 'Perimenopause established phase',
     'b',
     'The fibroids and vaginitis section describes Black Cohosh as "helpful for premenopause; in tincture formula for fibroids and vaginitis."',
     'Black cohosh — helpful for premenopause; in tincture formula for fibroids and vaginitis',
     'Fibroids and Vaginitis', 290),

    -- Q30
    ('BHC - Class 61 - Repro IV Hormonal Matrix',
     'What is the role of Echinacea as mentioned in the immune and respiratory support section?',
     'Long-term immune adaptogen taken continuously', 'For onset of illness', 'Anti-inflammatory for reproductive system', 'Antimicrobial for vaginitis treatment',
     'b',
     'The immune and respiratory support section states simply "Echinacea for onset of illness," indicating it is indicated at the beginning of acute illness.',
     'Echinacea for onset of illness',
     'Immune and Respiratory Support', 300)

    ;
END $$;
