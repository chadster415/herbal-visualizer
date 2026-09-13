-- Migration 321: Class 33 quiz — Skin 1 and Food Sensitivities (30 questions)
--
-- Correct option distribution: a=8, b=8, c=7, d=7

SET search_path TO herbal, public;

DO $$
DECLARE
  v_class TEXT := 'BHC - Class 33 - Skin 1 and Food Sensitivities - Lisa Christine';
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_quiz_questions WHERE class_name = v_class) THEN
    RAISE NOTICE 'Class 33 quiz already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_quiz_questions
    (class_name, question_text, option_a, option_b, option_c, option_d,
     correct_option, explanation, snippet_text, section_header, sort_order)
  VALUES

  -- Q1 (d)
  (v_class,
   'Which two herbs are added to distilled water for the wound care medicated wet wipes, covering both gram-positive and gram-negative bacteria?',
   'Yarrow and Lavender',
   'Calendula and Tea Tree',
   'Tea Tree and Oregano',
   'Tea Tree and Lavender',
   'd',
   'Tea Tree covers gram-negative bacteria (E. coli) and Lavender covers gram-positive bacteria (staph and MRSA), together providing broad-spectrum antimicrobial coverage that sidesteps antibiotic resistance.',
   'Protocol step 1 wet wipes: solution of distilled water, add tea tree and lavender — covers gram negative bacteria (tea tree: E. coli) and gram positive (lavender: staph and MRSA, sidesteps antibiotic resistance).',
   'Wound Care', 10),

  -- Q2 (a)
  (v_class,
   'Which bacterial category does Tea Tree specifically target in the wound care wet wipes protocol?',
   'Gram negative (E. coli)',
   'Gram positive (staph and MRSA)',
   'Both gram positive and negative equally',
   'Anaerobic bacteria',
   'a',
   'Tea Tree specifically covers gram-negative bacteria such as E. coli; Lavender handles gram-positive bacteria including staph and MRSA.',
   'covers gram negative bacteria (tea tree: E. coli) and gram positive (lavender: staph and MRSA)',
   'Wound Care', 20),

  -- Q3 (b)
  (v_class,
   'Which bacterial category does Lavender cover in the wound care protocol?',
   'Gram negative (E. coli)',
   'Gram positive (staph and MRSA)',
   'Anaerobic bacteria',
   'Gram negative and fungal',
   'b',
   'Lavender covers gram-positive bacteria including staph and MRSA (described as "staph on steroids"), while Tea Tree covers gram-negative bacteria.',
   'covers gram negative bacteria (tea tree: E. coli) and gram positive (lavender: staph and MRSA)',
   'Wound Care', 30),

  -- Q4 (a)
  (v_class,
   'Which wound care primary topical is described as "sometimes standalone"?',
   'Chaparral',
   'Myrrh',
   'Oregon Grape Root',
   'Tea Tree',
   'a',
   'Chaparral is noted as a primary topical that can sometimes be used standalone, and the curbside care clinic takeaway was about half a bottle of chaparral.',
   'Protocol step 3 primary topicals: chaparral — sometimes standalone. Takeaway, maybe 1/2 bottle of chaparral.',
   'Wound Care', 40),

  -- Q5 (d)
  (v_class,
   'What is the correct fresh tincture ratio and menstruum percentage for Chaparral?',
   '1:5 at 60%',
   '1:3 at 70%',
   '1:4 at 60%',
   '1:2 at 80–95%',
   'd',
   'Chaparral fresh preparation uses 1:2 at 80–95% alcohol to capture its resinous sticky constituents from the leaves; the dry preparation uses 1:5 at 60%.',
   'Chaparral (Larrea tridentata, Creosote Bush): Leaves and Twigs (leaves have the sticky). Fresh 1:2 80–95%. Dry 1:5 60%.',
   'Chaparral', 50),

  -- Q6 (a)
  (v_class,
   'What is the correct dry tincture ratio and menstruum for Chaparral?',
   '1:5 at 60%',
   '1:2 at 80–95%',
   '1:3 at 70%',
   '1:5 at 95%',
   'a',
   'Chaparral dry preparation uses 1:5 at 60%, while the fresh preparation uses 1:2 at 80–95% to capture the resinous leaf constituents.',
   'Chaparral (Larrea tridentata, Creosote Bush): Fresh 1:2 80–95%. Dry 1:5 60%.',
   'Chaparral', 60),

  -- Q7 (b)
  (v_class,
   'What is the tincture preparation ratio and menstruum for Myrrh resin?',
   '1:2 at 80–95%',
   '1:5 at 70%',
   '1:5 at 95%',
   '1:3 at 60%',
   'b',
   'Myrrh resin is prepared as 1:5 at 70% alcohol, which is appropriate for its oleoresin character — it contains both water and alcohol soluble components.',
   'Myrrh (Commiphora myrrha): Resin 1:5 70%. Effective against both gram positive and negative bacteria. Antifungal. Stimulates innate immune function uniquely; stimulates leukocytes.',
   'Myrrh', 70),

  -- Q8 (d)
  (v_class,
   'What does "oleoresin" mean for Myrrh''s clinical preparation?',
   'It is only alcohol soluble',
   'It is only water soluble',
   'It must be steam distilled before use',
   'It has both water and alcohol soluble components',
   'd',
   'Myrrh is an oleoresin, meaning it contains both water-soluble and alcohol-soluble components; a mid-range menstruum (70%) captures its full spectrum of constituents.',
   'Myrrh (Commiphora myrrha): oleoresin — both water and alcohol soluble components.',
   'Myrrh', 80),

  -- Q9 (b)
  (v_class,
   'Why is comfrey absolutely contraindicated for deep wound washing?',
   'Its high tannin content is toxic in wounds',
   'It closes up a wound and leaves the bad underneath',
   'It inhibits leukocyte activity',
   'It is too astringent and causes tissue damage',
   'b',
   'Comfrey''s powerful vulnerary action closes wounds so quickly that it can seal in infection or debris in deep wounds; it is excellent for surface abrasions but contraindicated for deep wounds.',
   'No comfrey ever for deep wounds — closes up the wound and leaves the bad underneath. Comfrey incredible for scrapes and abrasions, but not deep wounds.',
   'Wound Wash', 90),

  -- Q10 (a)
  (v_class,
   'Why is Aloe contraindicated in the wound wash for deep wounds?',
   'Heals too fast (closes wound before it can drain)',
   'Contains toxic components not safe for open wounds',
   'Too astringent, causes scarring',
   'Competes with the antimicrobial herbs',
   'a',
   'Like comfrey, aloe heals tissue too quickly for deep wounds — it would close the wound before adequate drainage and debridement occur; it is appropriate for gut lining and heartburn though.',
   'Aloe is a No for wound wash — heals too fast (for deep wounds).',
   'Wound Wash', 100),

  -- Q11 (b)
  (v_class,
   'Which herb uniquely serves all three wound wash roles — astringent, antimicrobial, AND vulnerary?',
   'Plantain',
   'Yarrow',
   'Calendula',
   'Red Root',
   'b',
   'Yarrow is the only herb listed in all three wound wash categories: astringent (with Red Root leaf), antimicrobial (with Tea Tree and culinary herbs), and vulnerary (with Plantain, Calendula, Lavender, Chamomile, Self Heal, Chickweed, SJW).',
   'Yarrow serves all three wound wash roles — Astringent (with Red Root leaf), Antimicrobial (with Tea Tree, Rosemary, Thyme, Oregano), and Vulnerary (with Plantain, Calendula, Lavender, Chamomile, Self Heal, Chickweed, SJW).',
   'Wound Wash', 110),

  -- Q12 (c)
  (v_class,
   'Red Root leaf is listed under which wound wash category?',
   'Vulnerary',
   'Antimicrobial',
   'Astringent',
   'Anti-inflammatory',
   'c',
   'Red Root leaf is specifically listed as an astringent herb in the wound wash preparation, alongside Yarrow in that category.',
   'Wound wash astringent herbs: Red Root leaf, Yarrow. Astringent = toning and tightening tissue, stimulates immune function.',
   'Wound Wash', 120),

  -- Q13 (c)
  (v_class,
   'Myrrh is specifically mentioned as an indication for which oral health conditions?',
   'Tooth decay and abscesses',
   'Oral thrush and angular cheilitis',
   'Mouth ulcers, dental issues, extractions, and gingivitis',
   'Dry mouth and tooth sensitivity',
   'c',
   'The notes list four specific oral indications for Myrrh: mouth ulcers, dental issues, extractions, and gingivitis.',
   'Myrrh (Commiphora myrrha): mouth ulcers, dental issues, extractions, gingivitis.',
   'Myrrh', 130),

  -- Q14 (b)
  (v_class,
   'What does Myrrh uniquely stimulate in wound healing and immunity?',
   'Fibroblast proliferation',
   'Innate immune function; stimulates leukocytes',
   'Collagen cross-linking',
   'Keratinocyte migration',
   'b',
   'Myrrh is noted for uniquely stimulating innate immune function and leukocyte activity — useful when cellulite tissue loses elasticity and succumbs to fluids, as it boosts immune response at the skin level.',
   'Myrrh (Commiphora myrrha): stim innate immune function uniquely; stimulates leukocytes.',
   'Myrrh', 140),

  -- Q15 (c)
  (v_class,
   'Which herb is noted in the food sensitivity context as "5 flavor berry, liver-supporting, more gentle than others"?',
   'Milk Thistle',
   'Yellow Dock',
   'Schizandra',
   'Burdock',
   'c',
   'Schizandra (the 5 flavor berry) is introduced at the start of the food sensitivities session as a gentle liver herb that moves blood, comes up frequently in clinical settings, and is more gentle than other liver herbs.',
   'Schisandra — 5 flavor berry: moves blood, liver-supporting, more gentle than other liver herbs. Comes up frequently in food sensitivity clinical settings.',
   'Food Sensitivities', 150),

  -- Q16 (b)
  (v_class,
   'For gut lining repair, plantain, calendula, and marshmallow EP are recommended mixed into what carrier, and why?',
   'Warm water',
   'Applesauce — pectin aids absorption',
   'Bone broth',
   'Aloe vera juice',
   'b',
   'Applesauce is recommended because its pectin helps the body absorb the demulcent herbs, enhancing their ability to seal the tight junctions of the gut lining. The mixture is taken 15 minutes before every meal.',
   'Demulcents and vulneraries: plantain, calendula (grind together), marshmallow EP powdered into applesauce before every meal. Pectin in applesauce aids absorption; helps seal the tight junctions.',
   'Heal the Gut Lining', 160),

  -- Q17 (a)
  (v_class,
   'Licorice root for gut lining repair is recommended in which specific form to avoid blood pressure effects?',
   'DGL capsules',
   'Standard root decoction',
   'Cold infusion',
   'Glycerite',
   'a',
   'DGL (deglycyrrhizinated licorice) removes the glycyrrhizin constituent responsible for blood pressure elevation, making it safe for gut lining repair without cardiovascular side effects.',
   'Licorice root for gut lining repair — DGL capsules, doesn''t cause the blood pressure response.',
   'Heal the Gut Lining', 170),

  -- Q18 (a)
  (v_class,
   'Which herbs are specifically listed as "bitters before mealtime" for rekindling digestive fire?',
   'Dandelion root or leaf, and Artichoke leaf',
   'Gentian and Yellow Dock',
   'Burdock and Chicory',
   'Schizandra and Milk Thistle',
   'a',
   'The notes specifically recommend dandelion root or leaf and artichoke leaf as bitters before mealtime to stimulate digestion and rekindle the Agni (digestive fire).',
   'bitters before mealtime: dandelion root or leaf, artichoke leaf',
   'Digestive Fire', 180),

  -- Q19 (d)
  (v_class,
   'What is "Agni" as described in the digestive fire section?',
   'A specific Ayurvedic herb formula for digestion',
   'An assessment tool for food sensitivity constitution',
   'The bitter principle in artichoke leaf',
   'The digestive fire that transforms food into energy',
   'd',
   'Agni is an Ayurvedic concept for the digestive fire that transforms food into energy; the class frames rekindling digestion through warm, well-spiced meals that support this vital function.',
   'Agni — digestive fire that transforms food into energy',
   'Digestive Fire', 190),

  -- Q20 (c)
  (v_class,
   'What are Cinnamon''s energetics in the digestive tincture blend activity?',
   'Cooling, drying, toning',
   'Warming, moistening, relaxing',
   'Warming, drying, toning',
   'Cooling, moistening, relaxing',
   'c',
   'Cinnamon is listed as warming, drying, and toning — the only herb in the activity explicitly noted as toning rather than relaxing, reflecting its astringent, tissue-firming character.',
   'Digestive tincture blend activity: Cinnamon — warming, drying, toning.',
   'Digestive Tincture Blend', 200),

  -- Q21 (a)
  (v_class,
   'What are Shatavari''s energetics in the digestive tincture blend activity?',
   'Cooling, moistening, relaxing',
   'Warming, drying, toning',
   'Warming, moistening, relaxing',
   'Cooling, drying, toning',
   'a',
   'Shatavari is listed as cooling, moistening, and relaxing — consistent with its Ayurvedic classification as a deeply moistening and tonifying adaptogen, appropriate for dry, depleted presentations.',
   'Digestive tincture blend activity: Shatavari — cooling, moistening, relaxing.',
   'Digestive Tincture Blend', 210),

  -- Q22 (b)
  (v_class,
   'Which herbs in the digestive tincture blend activity are specifically noted as nervines?',
   'Fennel, Ginger, Coriander',
   'Chamomile, Lemon Balm, Catnip',
   'Artichoke, Gentian, Yellow Dock',
   'Licorice, Marshmallow, Plantain',
   'b',
   'Chamomile, Lemon Balm, and Catnip are the three herbs explicitly marked as nervines in the digestive tincture blend activity list — notable because the nervous system connection is central to food sensitivity presentations.',
   'Digestive tincture blend activity: Chamomile — warming, drying, relaxing; nervine. Lemon Balm — cooling, drying, relaxing; nervine. Catnip — cooling, drying, relaxing; nervine.',
   'Digestive Tincture Blend', 220),

  -- Q23 (d)
  (v_class,
   'Which supplement is recommended for constipation (taken before bed) in the elimination and detox section?',
   'Zinc',
   'Vitamin C',
   'Psyllium',
   'Magnesium citrate',
   'd',
   'Magnesium citrate is specifically recommended for constipation, taken before bed alongside adequate fiber and hydration; "Magnesium Breakthrough" is cited as the best brand.',
   'Supplement with Magnesium citrate for constipation, before bed — with fiber and adequate hydration. "Magnesium Breakthrough" recommended brand.',
   'Elimination and Detox', 230),

  -- Q24 (d)
  (v_class,
   'What is the important clinical caveat when recommending psyllium husk?',
   'Must be taken with fat to absorb properly',
   'Only use the whole seed, not the husk',
   'Avoid in IBS with constipation predominance',
   'Only if drinking a lot of water with it',
   'd',
   'Psyllium husk must be taken with ample water; without sufficient hydration it can form a dry, obstructing mass in the intestines and worsen the constipation it is meant to treat.',
   'Psyllium husk for constipation and elimination support — only if drinking a lot of water with it.',
   'Elimination and Detox', 240),

  -- Q25 (a)
  (v_class,
   'The notes describe which herb category as "a lot of bitter plants" in the Regulate the Nervous System section?',
   'Nervines',
   'Adaptogens',
   'Hepatics',
   'Alteratives',
   'a',
   'The notes explicitly describe nervines as "a lot of bitter plants" — Chamomile, Lemon Balm, Catnip, Passionflower, Skullcap, and Blue Vervain — highlighting the bitter-nervine connection relevant in food sensitivity presentations.',
   'Nervines for nervous system support in food sensitivity context (a lot of bitter plants): Chamomile, Lemon Balm, Catnip, Passionflower, Skullcap, Blue Vervain.',
   'Nervous System Support', 250),

  -- Q26 (d)
  (v_class,
   'Holy Basil (Tulsi) is listed as an adaptogen but also noted for which additional action?',
   'Hepatic',
   'Nervine',
   'Sedative',
   'Carminative',
   'd',
   'Tulsi is listed among the adaptogens and specifically noted as "also a carminative" — making it doubly useful for food sensitivity presentations that involve both nervous system dysregulation and digestive distress.',
   'Holy Basil (Tulsi) listed as an adaptogen for nervous system support in food sensitivity context. Also noted as a carminative. Specific to constitution.',
   'Nervous System Support', 260),

  -- Q27 (c)
  (v_class,
   'Which prebiotic inulin-rich plants are specifically listed for improving microbiome diversity?',
   'Calendula, Chamomile, Lavender',
   'Schizandra, Milk Thistle, Nettle',
   'Burdock, chicory, dandelion root',
   'Cleavers, Red Clover, Yellow Dock',
   'c',
   'Burdock, chicory, and dandelion root are listed as high-inulin prebiotic plants; inulin feeds beneficial gut bacteria and is central to microbiome diversity support.',
   'Prebiotic inulin plants for microbiome diversity: burdock/chicory/dandelion root. High inulin content feeds beneficial gut flora.',
   'Microbiome Support', 270),

  -- Q28 (b)
  (v_class,
   'In the hepatics list for elimination and detox support, which herb is also primarily known for lymphatic support?',
   'Milk Thistle',
   'Cleavers',
   'Schizandra',
   'Red Clover',
   'b',
   'Cleavers (Galium aparine) is a primary lymphatic herb; its listing among the hepatics reflects its broad role in supporting elimination through both the liver and the lymphatic system.',
   'Hepatics and lymphatics for elimination and detox: cleavers listed among hepatics (schisandra, milk thistle, nettle, red clover, cleavers, yellow dock).',
   'Elimination and Detox', 280),

  -- Q29 (c)
  (v_class,
   'What are Chamomile''s energetics in the digestive tincture blend activity?',
   'Cooling, drying, relaxing; nervine',
   'Warming, moistening, relaxing; demulcent',
   'Warming, drying, relaxing; nervine',
   'Cooling, drying, toning',
   'c',
   'Chamomile is listed as warming, drying, and relaxing with a nervine quality — one of three herbs in the blend activity explicitly marked as nervines, reflecting its dual digestive and nervous system support role.',
   'Digestive tincture blend activity: Chamomile — warming, drying, relaxing; nervine.',
   'Digestive Tincture Blend', 290),

  -- Q30 (c)
  (v_class,
   'What are Lemon Balm''s energetics in the digestive tincture blend activity?',
   'Warming, drying, relaxing; nervine',
   'Cooling, moistening, relaxing',
   'Cooling, drying, relaxing; nervine',
   'Warming, moistening, toning',
   'c',
   'Lemon Balm is listed as cooling, drying, and relaxing with a nervine quality — contrasting with Chamomile which is warming and drying, making them complementary nervines for different constitutional presentations.',
   'Digestive tincture blend activity: Lemon Balm — cooling, drying, relaxing; nervine.',
   'Digestive Tincture Blend', 300);

  RAISE NOTICE 'Class 33 quiz loaded (30 questions).';
END $$;
