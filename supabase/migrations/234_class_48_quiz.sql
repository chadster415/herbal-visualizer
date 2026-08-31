-- Migration 234: Class 48 — Immune System II and Percolation quiz questions
-- Source: supabase/migrations/230_class_48_immune_system_ii_percolation_data.sql
SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_quiz_questions
             WHERE class_name = 'BHC - Class 48 - Immune System II and Percolation') THEN
    RAISE NOTICE 'Class 48 quiz questions already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_quiz_questions
    (class_name, question_text, option_a, option_b, option_c, option_d,
     correct_option, explanation, snippet_text, section_header, sort_order)
  VALUES
    -- Q1  correct: a
    ('BHC - Class 48 - Immune System II and Percolation',
     'Which herbs are described as too fluffy to percolate and must use maceration instead?',
     'Mullein and Marshmallow', 'Echinacea and Astragalus', 'Cinnamon and Shepherd''s Purse', 'Vitex and Shatavari',
     'a',
     'The notes explicitly state that fluffy herbs like Mullein and Marshmallow won''t work with percolation — maceration must be used instead.',
     'fluffy herbs won''t work — mullein, marshmallow',
     'Percolation', 10),

    -- Q2  correct: b
    ('BHC - Class 48 - Immune System II and Percolation',
     'Ashwagandha is best administered in which form and medium according to these notes?',
     'As a cold infusion in water', 'As a fluid extract, ideally in milk', 'As a vinegar tincture taken before meals', 'As a glycerite diluted in juice',
     'b',
     'The notes state that Ashwagandha is best as a fluid extract, ideally administered in milk — 1/2 tsp powder or 15–30 drops.',
     'Ashwagandha is best as a fluid extract, ideally administered in milk — 1/2 tsp powder or 15–30 drops. Can cause irritability and aggravation in some people; if this occurs, switch to a different adaptogen.',
     'Administration / Formulation', 20),

    -- Q3  correct: c
    ('BHC - Class 48 - Immune System II and Percolation',
     'What effect does Cinnamon have on peristalsis, and what herb is suggested if warming digestive support is needed without this effect?',
     'Cinnamon speeds peristalsis; use Fennel instead', 'Cinnamon has no effect on peristalsis; use Cardamom instead', 'Cinnamon slows peristalsis; use Ginger instead', 'Cinnamon relaxes the pyloric sphincter; use Chamomile instead',
     'c',
     'The notes state that Cinnamon slows peristalsis and recommend using Ginger instead if warming digestive support is needed without slowing this effect.',
     'Cinnamon slows peristalsis — use Ginger instead if warming digestive support is needed without this slowing effect.',
     'Clinical Notes', 30),

    -- Q4  correct: d
    ('BHC - Class 48 - Immune System II and Percolation',
     'Shepherd''s Purse is described as a powerful acute bleeding remedy. Which statement about its clinical use is also noted?',
     'It is an excellent long-term constitutional tonic for chronic bleeding', 'It acts slowly and requires 2–4 weeks to take effect', 'It should not be combined with Yarrow due to excessive astringency', 'It is not a constitutional tonic and should be reserved for acute presentations',
     'd',
     'The notes are explicit that Shepherd''s Purse is a powerful acute bleeding remedy but is NOT a constitutional tonic — it should be reserved for acute bleeding presentations.',
     'Shepherd''s Purse is a powerful acute bleeding remedy — acts even to the point of clotting. It is not a constitutional tonic; reserve it for acute bleeding presentations.',
     'Clinical Notes', 40),

    -- Q5  correct: a
    ('BHC - Class 48 - Immune System II and Percolation',
     'What type of herbal extraction is percolation, and how long does it typically take?',
     'An alcohol extraction method completed in approximately 48 hours', 'A water extraction method taking 2 weeks', 'A glycerite method completed in 3 weeks', 'A vinegar extraction completed in 24 hours',
     'a',
     'The notes describe percolation as another alcohol extraction method that produces a tincture in approximately 48 hours.',
     'another alcohol extraction method; tincture in 48 hours, hands on',
     'Percolation', 50),

    -- Q6  correct: b
    ('BHC - Class 48 - Immune System II and Percolation',
     'Which type of herbs CANNOT be percolated?',
     'Dried aromatic herbs', 'Resinous herbs', 'Roots with high tannin content', 'Powdered barks',
     'b',
     'The notes specify that resinous herbs cannot be percolated, alongside fluffy herbs like mullein and marshmallow.',
     'can''t do resinous herbs',
     'Percolation', 60),

    -- Q7  correct: c
    ('BHC - Class 48 - Immune System II and Percolation',
     'In the folk method of alcohol extraction, what ratio and alcohol percentage are used for fresh herbs?',
     '1:5 with 95% alcohol', '1:3 with 50% alcohol', '1:2 with 95% or 75% alcohol', '1:10 with 40% alcohol',
     'c',
     'The notes specify: ratio method with fresh herbs uses 1:2 at 95% or 75% (lower water content plants use 75%).',
     'ratio method with fresh: 1:2, 95% or 75% (lower water plants = 75%)',
     'Percolation', 70),

    -- Q8  correct: d
    ('BHC - Class 48 - Immune System II and Percolation',
     'What ratio and minimum alcohol percentage are used in the ratio extraction method for dried herbs?',
     '1:2 with at least 50% alcohol', '1:3 with at least 45% alcohol', '1:10 with at least 25% alcohol', '1:5 with greater than 35% alcohol',
     'd',
     'The notes specify the ratio method with dried herbs uses 1:5 at greater than 35% alcohol.',
     'ratio method with dried: 1:5, >35%',
     'Percolation', 80),

    -- Q9  correct: a
    ('BHC - Class 48 - Immune System II and Percolation',
     'When extracting alkaloids from herbs, which menstruum is recommended?',
     'Vinegar', 'Glycerin', 'High-proof alcohol (95%)', 'Cold water',
     'a',
     'The notes specify that vinegar extraction is used for alkaloids.',
     'alkaloids: vinegar extraction',
     'Percolation', 90),

    -- Q10  correct: b
    ('BHC - Class 48 - Immune System II and Percolation',
     'In Lisa''s adaptogen-nervine tincture formula, which herb was originally included but switched out due to causing irritability?',
     'Milky Oats', 'Ashwagandha', 'Gotu Kola', 'Shatavari',
     'b',
     'The notes state the formula originally included Ashwagandha but it was switched out because it made the patient irritable and aggravated.',
     'started with Ashwagandha, but switched out because made irritable and aggravated',
     'Case Study Formula', 100),

    -- Q11  correct: c
    ('BHC - Class 48 - Immune System II and Percolation',
     'In Lisa''s adaptogen-nervine formula, what volume of Shatavari is included?',
     '20 mL', '40 mL', '60 mL', '80 mL',
     'c',
     'The notes specify Shatavari at 40–80 drops / 60 mL in the adaptogen-nervine formula.',
     'Shatavari 40-80 drops / 60ml',
     'Case Study Formula', 110),

    -- Q12  correct: d
    ('BHC - Class 48 - Immune System II and Percolation',
     'In Lisa''s adaptogen-nervine tincture formula, which herb is included at 15–30 drops / 20 mL?',
     'Shatavari', 'Milky Oats', 'Ashwagandha', 'Gotu Kola',
     'd',
     'The notes specify Gotu Kola at 15–30 drops / 20 mL in the adaptogen-nervine tincture formula.',
     'Gotu Kola 15-30 drops / 20ml',
     'Case Study Formula', 120),

    -- Q13  correct: a
    ('BHC - Class 48 - Immune System II and Percolation',
     'In Lisa''s reproductive tincture formula, what is the dosing instruction?',
     '2 dropper-fulls 3× per day', '1 dropper-full 4× per day', '3 droppers once daily at bedtime', '4 droppers 2× per day',
     'a',
     'The notes specify 2 dropper-fulls 3× per day for the reproductive tincture formula, totaling 120 mL.',
     'total 120ml — dosage: 2 droppers / 3x day',
     'Case Study Formula', 130),

    -- Q14  correct: b
    ('BHC - Class 48 - Immune System II and Percolation',
     'In Lisa''s reproductive formula, which herb is included at the highest drop count (55 drops / 30 mL)?',
     'Vitex', 'White Peony', 'Licorice', 'Yarrow',
     'b',
     'The notes list White Peony at 55 drops / 30 mL — the highest drop count in the reproductive formula — followed by Vitex and Yarrow at 30 drops each.',
     'White Peony - 55d / 30ml',
     'Case Study Formula', 140),

    -- Q15  correct: c
    ('BHC - Class 48 - Immune System II and Percolation',
     'Echinacea modulates immunity primarily through which class of constituents?',
     'Polysaccharides', 'Terpenoids', 'Glycoproteins', 'Alkaloids',
     'c',
     'The notes state that Echinacea modulates immunity primarily through glycoproteins, which stimulate immune cell activation.',
     'Echinacea modulates immunity primarily through glycoproteins, which stimulate immune cell activation.',
     'Immune Modulators', 150),

    -- Q16  correct: d
    ('BHC - Class 48 - Immune System II and Percolation',
     'Astragalus modulates immunity primarily through which constituent class?',
     'Glycoproteins', 'Phenols', 'Terpenoids', 'Polysaccharides',
     'd',
     'The notes state that Astragalus modulates immunity via polysaccharides — the primary constituent class responsible for its immune-tonic activity.',
     'Astragalus modulates immunity via polysaccharides — the primary constituent class responsible for its immune-tonic activity.',
     'Immune Modulators', 160),

    -- Q17  correct: a
    ('BHC - Class 48 - Immune System II and Percolation',
     'Which constituent class is responsible for the immune-modulating activity of Reishi, Gotu Kola, and Bacopa?',
     'Terpenoids', 'Saponins', 'Fatty acids', 'Alkaloids',
     'a',
     'The notes map terpenoids to immune-modulating activity in Reishi, Centella asiatica (Gotu Kola), and Bacopa.',
     'Terpenoids: reishi, Centella asiatica, bacopa',
     'Immune Modulators', 170),

    -- Q18  correct: b
    ('BHC - Class 48 - Immune System II and Percolation',
     'Which immune-modulating constituent class is associated with herbs like oregano, clove, thyme, and rosemary?',
     'Alkaloids', 'Phenols', 'Polysaccharides', 'Glycoproteins',
     'b',
     'The notes map phenols to immune-modulating activity in oregano, clove, thyme, and rosemary.',
     'Phenols: oregano, clove, thyme, rosemary',
     'Immune Modulators', 180),

    -- Q19  correct: c
    ('BHC - Class 48 - Immune System II and Percolation',
     'For herbs high in tannins or aromatics, what addition to the extraction menstruum is recommended?',
     'Vinegar', 'Extra water', 'Glycerin', 'High-proof grain alcohol',
     'c',
     'The notes recommend adding glycerin for herbs high in tannins or aromatics — Cinnamon is given as an example.',
     'high tannins or aromatics: add glycerin (e.g., cinnamon)',
     'Percolation', 190),

    -- Q20  correct: d
    ('BHC - Class 48 - Immune System II and Percolation',
     'For a mineral overnight infusion, what is the correct preparation instruction according to these notes?',
     'Use only cold water and do not apply heat at any stage', 'Place directly in the refrigerator without heating', 'Use a 1:5 alcohol maceration for 2 weeks', 'Start with heat, then let cool; contrast with cold infusion (mucopolysaccharides) which uses no heat',
     'd',
     'The notes state that a mineral overnight infusion needs to start with heat, contrasting with cold infusion (mucopolysaccharides) which uses no heat at all and is placed directly in the fridge.',
     'mineral overnight infusion needs to start with heat, cold infusion (mucopolysaccharides) = no heat to start, put in fridge overnight',
     'Percolation / Cold Infusion', 200),

    -- Q21  correct: a
    ('BHC - Class 48 - Immune System II and Percolation',
     'What clinical presentation makes Cinnamon specifically relevant in a reproductive formula?',
     'Heavy bleeding', 'Scanty menses', 'Delayed cycles', 'Pelvic congestion',
     'a',
     'The notes state that Cinnamon is indicated for heavy bleeding, making it clinically relevant in reproductive formulas for this specific presentation.',
     'Cinnamon is indicated for heavy bleeding, making it clinically relevant in reproductive formulas for this specific presentation.',
     'Clinical Notes', 210),

    -- Q22  correct: b
    ('BHC - Class 48 - Immune System II and Percolation',
     'Which two herbs are noted as providing immunity through glycoproteins alongside Echinacea?',
     'Astragalus and Thyme', 'Goji berries and Ginseng', 'Oregano and Clove', 'Wild Yam and Purslane',
     'b',
     'The notes list goji berries and ginseng (as well as Salvia miltiorrhiza) alongside Echinacea as glycoprotein-based immune modulators.',
     'Glycoproteins: echinacea, goji berries, Salvia miltiorrhiza, ginseng',
     'Immune Modulators', 220),

    -- Q23  correct: c
    ('BHC - Class 48 - Immune System II and Percolation',
     'Percolation is described as producing which quality difference compared to standard maceration?',
     'It is gentler and less astringent', 'It produces a less potent but more shelf-stable tincture', 'It produces what some consider a more potent extraction, using a little more alcohol', 'It is identical in potency but requires less alcohol',
     'c',
     'The notes describe percolation as producing what some say is a more potent extraction, though it requires a little more alcohol and has more front-end work.',
     'some say a more potent extraction; more frontend work though; use a little more alcohol',
     'Percolation', 230),

    -- Q24  correct: d
    ('BHC - Class 48 - Immune System II and Percolation',
     'Which herb combination makes up Lisa''s reproductive tincture alongside White Peony and Licorice?',
     'Shatavari and Gotu Kola', 'Milky Oats and Ashwagandha', 'Motherwort and Dong Quai', 'Vitex and Yarrow',
     'd',
     'The notes list the reproductive formula as Vitex 30d, White Peony 55d, Licorice 20d, and Yarrow 30d.',
     'In Lisa''s reproductive formula: Vitex 30 drops (30 mL), White Peony 55 drops (30 mL), Licorice 20 drops (25 mL), Yarrow 30 drops (35 mL). Dosing: 2 dropper-fulls 3× per day (total 120 mL).',
     'Case Study Formula', 240),

    -- Q25  correct: a
    ('BHC - Class 48 - Immune System II and Percolation',
     'Fatty acids are mapped to immune modulation from which group of foods/herbs in these notes?',
     'Purslane, flax, and hemp seeds', 'Garlic, onion, and leek', 'Echinacea, goji, and ginseng', 'Wild Yam and Reishi',
     'a',
     'The notes map fatty acids to immune-modulating activity in purslane, flax, and hemp seeds.',
     'Fatty acids: purslane, flax, hemp seeds',
     'Immune Modulators', 250),

    -- Q26  correct: b
    ('BHC - Class 48 - Immune System II and Percolation',
     'What is the suggested approach for using bitters described as more "joyful" in these notes?',
     'Take bitters as a quick medicinal spray for immediate parasympathetic shift', 'Try bitters as a "cocktail" before meals to shift into a parasympathetic state', 'Add bitters to water continuously throughout the day', 'Use bitters only after meals to support digestion',
     'b',
     'The notes suggest trying bitters as a "cocktail" to shift into a parasympathetic state rather than a quick medicinal spray — described as more joyful.',
     'can try bitters as a "cocktail" to shift into parasympathetic state rather than a quick medicinal spray, more joyful',
     'Clinical Notes', 260),

    -- Q27  correct: c
    ('BHC - Class 48 - Immune System II and Percolation',
     'For a patient who experiences irritability and aggravation on Ashwagandha, what clinical adjustment is indicated?',
     'Reduce the dose to 5 drops and monitor', 'Combine with Cinnamon to buffer the side effects', 'Switch to a different adaptogen such as Shatavari or Gotu Kola', 'Switch to a vinegar tincture formulation',
     'c',
     'The notes state that if Ashwagandha causes irritability and aggravation, the clinical response is to switch to a different adaptogen.',
     'Ashwagandha is best as a fluid extract, ideally administered in milk — 1/2 tsp powder or 15–30 drops. Can cause irritability and aggravation in some people; if this occurs, switch to a different adaptogen.',
     'Administration / Formulation', 270),

    -- Q28  correct: d
    ('BHC - Class 48 - Immune System II and Percolation',
     'Which constituent class is associated with Wild Yam as an immune modulator?',
     'Alkaloids', 'Polysaccharides', 'Terpenoids', 'Saponins',
     'd',
     'The notes map saponins specifically to Wild Yam in the immune modulator constituent mapping.',
     'Saponins: wild yam',
     'Immune Modulators', 280),

    -- Q29  correct: a
    ('BHC - Class 48 - Immune System II and Percolation',
     'In these notes, which herb in the adaptogen-nervine tincture is included at 25–50 drops / 40 mL?',
     'Milky Oats', 'Shatavari', 'Gotu Kola', 'Ashwagandha',
     'a',
     'The notes list Milky Oats at 25–50 drops / 40 mL in the adaptogen-nervine tincture formula.',
     'Milky Oats 25-50 drops / 40ml',
     'Case Study Formula', 290),

    -- Q30  correct: b
    ('BHC - Class 48 - Immune System II and Percolation',
     'According to these notes, can percolation be performed with fresh herbs?',
     'Yes, fresh herbs are preferred for percolation as they produce more potent extracts', 'No, percolation can only be performed with dried herbs', 'Yes, but they must be macerated first for 24 hours', 'No, percolation requires freeze-dried herbs only',
     'b',
     'The notes explicitly state that percolation can only be performed with dried herbs.',
     'can only percolate dried herbs',
     'Percolation', 300)
  ;
END $$;
