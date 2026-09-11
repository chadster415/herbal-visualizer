-- Migration 300: Class 66 — Musculoskeletal III — Quiz Questions
-- 30 MCQ questions drawn from BHC - Class 66 - Musculoskeletal III notes.
-- Each question is anchored to a verbatim snippet from migration 299.

SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM herbal.class_quiz_questions
    WHERE class_name = 'BHC - Class 66 - Musculoskeletal III'
  ) THEN
    RAISE NOTICE 'Class 66 quiz questions already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_quiz_questions
    (class_name, question_text, option_a, option_b, option_c, option_d,
     correct_option, explanation, snippet_text, section_header, sort_order)
  VALUES

  -- Q1 (correct=a)
  ('BHC - Class 66 - Musculoskeletal III',
   'Which herb is described as a serotonin agonist that alters the body''s perception of pain in fibromyalgia?',
   'Black Cohosh', 'St. John''s Wort', 'Ashwagandha', 'Gotu Kola',
   'a',
   'Black Cohosh is specifically named as a serotonin agonist that works to alter the body''s perception of pain in fibromyalgia treatment.',
   'Support serotonin levels — Black Cohosh, serotonin agonist - alter body''s perception of pain',
   'Therapeutic Strategies', 10),

  -- Q2 (correct=b)
  ('BHC - Class 66 - Musculoskeletal III',
   'In the generated notes, which two herbs are paired for serotonin support in fibromyalgia?',
   'Ashwagandha and Astragalus', 'Black Cohosh and St. John''s Wort', 'Poke Root and Red Root', 'Calendula and Gotu Kola',
   'b',
   'The generated notes list Black Cohosh and St. John''s Wort together under serotonin support as part of the fibromyalgia therapeutic strategy.',
   'Serotonin support (e.g., Black cohosh, St. John''s wort)',
   'Therapeutic Strategy', 20),

  -- Q3 (correct=c)
  ('BHC - Class 66 - Musculoskeletal III',
   'Which three herbs form the antifibrotic trio listed in the personal notes'' Therapeutic Strategies?',
   'Hibiscus, Marshmallow, Gentian', 'Burdock, Yellow Dock, Red Root', 'Ashwagandha, Astragalus, White Peony', 'Poke Root, Ocotillo, Cleavers',
   'c',
   'Ashwagandha, Astragalus, and White Peony are listed together as the antifibrotic trio for fibromyalgia and fibrosis treatment.',
   'Antifibrotic — ashwagandha, astragalus, white peony',
   'Therapeutic Strategies', 30),

  -- Q4 (correct=d)
  ('BHC - Class 66 - Musculoskeletal III',
   'Which herb is specifically noted for helping the extracellular matrix (EM) with hyaluronic acid as tissue nourishment?',
   'Marshmallow', 'Gotu Kola', 'Calendula', 'Hibiscus',
   'd',
   'Hibiscus is specifically called out for helping the extracellular matrix with hyaluronic acid, supporting connective tissue hydration and integrity.',
   'Tissue nourishment — Hibiscus, in helping the EM with hyaluronic acid',
   'Therapeutic Strategies', 40),

  -- Q5 (correct=a)
  ('BHC - Class 66 - Musculoskeletal III',
   'What dosage consideration is explicitly noted for Poke Root when using it as a serious lymphatic in fibromyalgia?',
   'Low dose', 'High dose for acute cases', 'Standard tincture dose', 'Only used topically',
   'a',
   'The notes specify "low dose poke root" for serious lymphatic support, reflecting Poke Root''s potency and the need for caution in dosing.',
   'Circulation: Blood and Lymph — more serious lymphatics: low dose poke root',
   'Therapeutic Strategies', 50),

  -- Q6 (correct=b)
  ('BHC - Class 66 - Musculoskeletal III',
   'Which herb is recommended for gut health specifically because it helps the body metabolize fats?',
   'Gentian', 'Iris (Blue Flag)', 'Ginger', 'Marshmallow',
   'b',
   'Iris (Blue Flag, Iris versicolor) is noted in the personal notes as helping the body metabolize fats, making it a gut health herb in the fibromyalgia protocol.',
   'Gut health — iris, helps body metabolize fats',
   'Therapeutic Strategies', 60),

  -- Q7 (correct=c)
  ('BHC - Class 66 - Musculoskeletal III',
   'What is the therapeutic role of Baikal Skullcap in the fibrosis/fibromyalgia protocol?',
   'Anti-inflammatory', 'Antifibrotic', 'Promote apoptosis', 'Lymphatic stimulant',
   'c',
   'Baikal Skullcap (Scutellaria baicalensis) is listed specifically under "Promote apoptosis" in the therapeutic strategies for fibrosis.',
   'Promote apoptosis — Baikal skullcap',
   'Therapeutic Strategies', 70),

  -- Q8 (correct=d)
  ('BHC - Class 66 - Musculoskeletal III',
   'Which root (specifically the root, not the leaf) is listed alongside Baikal Skullcap for promoting apoptosis in fibrosis?',
   'Dandelion root', 'Burdock root', 'Yellow Dock', 'Nettle root',
   'd',
   'Nettle root (Urtica dioica root) is specifically named alongside Baikal Skullcap under "Promote apoptosis" in the therapeutic strategies for fibrosis.',
   'Promote apoptosis — Nettle root',
   'Therapeutic Strategies', 80),

  -- Q9 (correct=a)
  ('BHC - Class 66 - Musculoskeletal III',
   'Gotu Kola is described as providing what for autoimmune disease involving the extracellular matrix and fibromyalgia?',
   'Foundational tissue support', 'Lymphatic stimulation', 'Antifibrotic action', 'Serotonin modulation',
   'a',
   'The notes describe Gotu Kola as providing "foundational tissue support" in the cluster of herbs for autoimmune disease with ECM involvement and fibromyalgia.',
   'Autoimmune disease with ECM and Fibromyalgia — Gotu kola, foundational tissue support',
   'Therapeutic Strategies', 90),

  -- Q10 (correct=b)
  ('BHC - Class 66 - Musculoskeletal III',
   'Which two herbs are listed as phytoestrogen sources to encourage apoptosis in fibrosis?',
   'Chasteberry and Hops', 'Red Clover and Hops', 'Ashwagandha and Red Clover', 'Astragalus and Red Clover',
   'b',
   'Red Clover and Hops are both named as phytoestrogen sources to nourish beta-astradiols and encourage apoptosis in the fibrosis pathophysiology section.',
   'Phytoestrogen source to encourage apoptosis — red clover; for fibrosis/fibroblast accumulation',
   'Pathophysiology', 100),

  -- Q11 (correct=c)
  ('BHC - Class 66 - Musculoskeletal III',
   'Which supplements is the case study patient Mary (56, postmenopausal, bone density concern) currently taking?',
   'Vitamin D, Magnesium, and Fish Oil', 'Vitamin C, Calcium, and Iron', 'Lysine, Vitamin D, and Calcium', 'Zinc, B Complex, and Calcium',
   'c',
   'The case study notes that Mary is taking Lysine ("Lycine"), 2000 IU Vitamin D, and a Calcium supplement — consistent with her bone density and musculoskeletal concerns.',
   'Lycine, 2KIU D, and Calcium supplement — current supplements for case study patient (56, postmenopausal, bone density concern)',
   'Case Study', 110),

  -- Q12 (correct=d)
  ('BHC - Class 66 - Musculoskeletal III',
   'In the generated notes, which mineral is paired with Vitamin D for anti-inflammatory support in fibromyalgia?',
   'Calcium', 'Iron', 'Magnesium', 'Zinc',
   'd',
   'The generated notes list "Vitamin D and zinc for anti-inflammatory" as a key supplement strategy in the fibromyalgia therapeutic approach.',
   'Vitamin D and zinc for anti-inflammatory',
   'Therapeutic Strategy', 120),

  -- Q13 (correct=a)
  ('BHC - Class 66 - Musculoskeletal III',
   'Which herb is specifically recommended to be consumed in soups and wet foods for autoimmune/ECM/fibromyalgia support?',
   'Reishi', 'Calendula', 'Astragalus', 'Gotu Kola',
   'a',
   'Reishi is explicitly noted to be used "in soups and wet foods" — a practical preparation recommendation emphasizing staying nourished while receiving immune support.',
   'Autoimmune disease with ECM and Fibromyalgia — Reishi, in soups and wet foods; stay nourished',
   'Therapeutic Strategies', 130),

  -- Q14 (correct=b)
  ('BHC - Class 66 - Musculoskeletal III',
   'Which two herbs are listed for the elimination/drainage category in the fibromyalgia therapeutic strategies?',
   'Gentian and Iris', 'Burdock and Yellow Dock', 'Poke Root and Red Root', 'Hibiscus and Marshmallow',
   'b',
   'Burdock and Yellow Dock are listed together under "Elimination" as alterative herbs for clearing metabolic waste in the fibromyalgia protocol.',
   'Elimination — burdock, yellow dock',
   'Therapeutic Strategies', 140),

  -- Q15 (correct=c)
  ('BHC - Class 66 - Musculoskeletal III',
   'What therapeutic role does Marshmallow root serve in the fibromyalgia/fibrosis protocol?',
   'Antifibrotic', 'Lymphatic stimulant', 'Tissue nourishment', 'Serotonin modulation',
   'c',
   'Marshmallow root is listed under "Tissue nourishment" alongside Hibiscus — both provide demulcent and connective tissue nourishment support.',
   'Tissue nourishment — marshmallow root',
   'Therapeutic Strategies', 150),

  -- Q16 (correct=d)
  ('BHC - Class 66 - Musculoskeletal III',
   'For gentle lymphatic support (in contrast to serious lymphatics) in autoimmune/ECM/fibromyalgia, which two herbs are recommended?',
   'Red Root and Ocotillo', 'Poke Root and Ginger', 'Burdock and Yellow Dock', 'Cleavers and Violet',
   'd',
   'Cleavers and Violet are specifically described as "gentle" lymphatics in the autoimmune/ECM/fibromyalgia cluster — a milder approach than Poke Root, Red Root, or Ocotillo.',
   'Autoimmune disease with ECM and Fibromyalgia — lymphatics: gentle — cleavers, violet',
   'Therapeutic Strategies', 160),

  -- Q17 (correct=a)
  ('BHC - Class 66 - Musculoskeletal III',
   'In the generated notes'' Herbal Suggestions section, which two herbs are listed as anti-fibrotics?',
   'White Peony and Ashwagandha', 'Gotu Kola and Calendula', 'Reishi and Astragalus', 'Poke Root and Ocotillo',
   'a',
   'The generated notes list White Peony and Ashwagandha explicitly as anti-fibrotics in the Herbal Suggestions section of the Fibromyalgia therapeutic strategy.',
   'Anti-fibrotics: White peony, ashwagandha',
   'Herbal Suggestions', 170),

  -- Q18 (correct=b)
  ('BHC - Class 66 - Musculoskeletal III',
   'In the therapeutic strategies, which herb is used as a general circulatory stimulant alongside the more serious lymphatics (Poke Root, Red Root, Ocotillo)?',
   'Ocotillo', 'Ginger', 'Red Root', 'Burdock',
   'b',
   'Ginger is listed as "generally ginger" under Circulation/Blood and Lymph — positioned alongside the more potent lymphatics as a broadly applicable circulatory stimulant.',
   'Circulation: Blood and Lymph — generally ginger as circulatory stimulant',
   'Therapeutic Strategies', 180),

  -- Q19 (correct=c)
  ('BHC - Class 66 - Musculoskeletal III',
   'Which herb is used as a digestive bitter for gut health in the fibromyalgia/fibrosis protocol?',
   'Ginger', 'Marshmallow', 'Gentian', 'Iris',
   'c',
   'Gentian is listed under gut health as a digestive bitter, supporting the digestion and nutrient absorption impaired in fibromyalgia.',
   'Gut health — gentian',
   'Therapeutic Strategies', 190),

  -- Q20 (correct=d)
  ('BHC - Class 66 - Musculoskeletal III',
   'Calendula is included in the fibromyalgia protocol for which specific clinical context?',
   'Serotonin support', 'Gut health', 'Antifibrotic action', 'Autoimmune disease with ECM and fibromyalgia',
   'd',
   'Calendula is grouped with Gotu Kola, Reishi, Cleavers, Violet, and lower-dose Black Cohosh for the autoimmune disease/extracellular matrix/fibromyalgia cluster.',
   'Autoimmune disease with ECM and Fibromyalgia — Calendula',
   'Therapeutic Strategies', 200),

  -- Q21 (correct=a)
  ('BHC - Class 66 - Musculoskeletal III',
   'Which herb is listed alongside Poke Root, Ocotillo, and Ginger as a serious lymphatic for fibromyalgia circulation support?',
   'Red Root', 'Violet', 'Yellow Dock', 'Cleavers',
   'a',
   'Red Root is listed in the "more serious lymphatics" cluster alongside low dose Poke Root, Ocotillo, and Ginger for fibromyalgia circulatory and lymphatic support.',
   'Circulation: Blood and Lymph — more serious lymphatics: red root',
   'Therapeutic Strategies', 210),

  -- Q22 (correct=b)
  ('BHC - Class 66 - Musculoskeletal III',
   'Black Cohosh appears twice in the therapeutic strategies. In the autoimmune/ECM/fibromyalgia context, how is it described differently from its serotonin use?',
   'Higher dose for stronger effect', 'Lower dose', 'Combined with zinc', 'Only as a topical preparation',
   'b',
   'The notes specify "lower dose Black Cohosh" in the autoimmune/ECM cluster, distinguishing it from the full serotonin agonist use earlier in the protocol.',
   'Autoimmune disease with ECM and Fibromyalgia — lower dose Black Cohosh',
   'Therapeutic Strategies', 220),

  -- Q23 (correct=c)
  ('BHC - Class 66 - Musculoskeletal III',
   'What therapeutic role does Ocotillo serve in the fibromyalgia therapeutic strategies?',
   'Antifibrotic', 'Gut health aromatic', 'Serious lymphatic and circulation support', 'Elimination/alterative',
   'c',
   'Ocotillo is listed under the "more serious lymphatics" for Circulation: Blood and Lymph — it supports lymphatic flow as part of the fibromyalgia circulatory strategy.',
   'Circulation: Blood and Lymph — more serious lymphatics: ocotillo maybe',
   'Therapeutic Strategies', 230),

  -- Q24 (correct=d)
  ('BHC - Class 66 - Musculoskeletal III',
   'In Lisa''s personal notes under Pathophysiology, which three herbs are identified as antifibrotics?',
   'Reishi, Calendula, Gotu Kola', 'Burdock, Yellow Dock, Nettle Root', 'Cleavers, Violet, Poke Root', 'White Peony, Ashwagandha, Astragalus',
   'd',
   'White Peony, Ashwagandha, and Astragalus appear as the antifibrotic trio in both the Pathophysiology and Therapeutic Strategies sections of the personal notes.',
   'Antifibrotics — White Peony, Ashwagandha, Astragalus',
   'Pathophysiology', 240),

  -- Q25 (correct=a)
  ('BHC - Class 66 - Musculoskeletal III',
   'In the generated notes'' Herbal Suggestions, which two herbs are listed as gut health aromatics?',
   'Ginger and Iris', 'Iris and Marshmallow', 'Gentian and Ginger', 'Marshmallow and Gentian',
   'a',
   'The generated notes list "Aromatics like ginger, iris" under Gut health in the Herbal Suggestions section, both serving as carminative/digestive aromatics.',
   'Gut health: Aromatics like ginger, iris',
   'Herbal Suggestions', 250),

  -- Q26 (correct=b)
  ('BHC - Class 66 - Musculoskeletal III',
   'In the generated notes'' Herbal Suggestions, which herb is listed alongside Hibiscus for tissue nourishment?',
   'Gentian', 'Marshmallow root', 'Cleavers', 'Calendula',
   'b',
   'Hibiscus and Marshmallow root are paired together under Nourishment in the Herbal Suggestions section of the generated notes.',
   'Nourishment: Hibiscus, marshmallow root',
   'Herbal Suggestions', 260),

  -- Q27 (correct=c)
  ('BHC - Class 66 - Musculoskeletal III',
   'Hops is listed as a phytoestrogen source for apoptosis support in fibrosis. What additional therapeutic benefit is noted for Hops specifically?',
   'Anti-inflammatory', 'Antifibrotic', 'Sleep support', 'Pain relief',
   'c',
   'Hops is noted as a phytoestrogen source and also flagged specifically for sleep support — "hops - also supports sleep" — making it doubly useful in fibromyalgia where sleep disturbance is common.',
   'Hops - also supports sleep; phytoestrogen source for apoptosis support in fibrosis',
   'Pathophysiology', 270),

  -- Q28 (correct=d)
  ('BHC - Class 66 - Musculoskeletal III',
   'In the generated notes'' Herbal Suggestions, Ashwagandha is categorized under which therapeutic role?',
   'Gut health', 'Nourishment', 'Serotonin support', 'Anti-fibrotics',
   'd',
   'In the generated notes, Ashwagandha is listed under "Anti-fibrotics: White peony, ashwagandha" in the Herbal Suggestions section of the Fibromyalgia therapeutic strategy.',
   'Anti-fibrotics: White peony, ashwagandha',
   'Herbal Suggestions', 280),

  -- Q29 (correct=a)
  ('BHC - Class 66 - Musculoskeletal III',
   'White Peony appears in the fibromyalgia protocol primarily for which action?',
   'Antifibrotic', 'Serotonin support', 'Lymphatic drainage', 'Gut health',
   'a',
   'White Peony is consistently listed as an antifibrotic across both the Pathophysiology and Therapeutic Strategies sections — its primary role in this protocol is antifibrotic.',
   'Antifibrotic — ashwagandha, astragalus, white peony',
   'Therapeutic Strategies', 290),

  -- Q30 (correct=b)
  ('BHC - Class 66 - Musculoskeletal III',
   'In Lisa''s personal notes, Vitamin D is placed under which therapeutic category in the fibromyalgia strategies?',
   'Gut health', 'Tissue nourishment', 'Elimination', 'Serotonin support',
   'b',
   'Vitamin D ("Vit D") is listed under Tissue nourishment alongside Hibiscus, Marshmallow root, and oilination — supporting connective tissue and bone mineralization.',
   'Tissue nourishment — Vit D',
   'Therapeutic Strategies', 300);

END $$;
