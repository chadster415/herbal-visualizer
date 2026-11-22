-- Migration 477: Herbal Heart Health Week 3 quiz questions
-- class_name: 'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol'
--
-- Target calculation:
--   H = 31 distinct herbs/supplements
--   F = 20 named factual items (specific studies, dosages, ranges, mechanisms)
--   target = clamp(15 + 31*4 + 20, 20, 50) = clamp(159, 20, 50) = 50 questions
--
-- Correct option distribution: a=13, b=12, c=12, d=13

SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_quiz_questions
             WHERE class_name = 'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol') THEN
    RAISE NOTICE 'Week 3 quiz questions already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_quiz_questions
    (class_name, question_text, option_a, option_b, option_c, option_d,
     correct_option, explanation, snippet_text, section_header, sort_order)
  VALUES

  -- Q1: Arteriosclerosis vs atherosclerosis
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'What is the key distinction between arteriosclerosis and atherosclerosis?',
   'Arteriosclerosis is a coronary-only condition; atherosclerosis affects peripheral arteries',
   'Arteriosclerosis is caused by bacterial infection; atherosclerosis is autoimmune',
   'Arteriosclerosis is reversible; atherosclerosis is permanent',
   'Arteriosclerosis refers to hardening of arteries broadly; atherosclerosis refers specifically to plaque buildup in coronary arteries causing ischemia',
   'd',
   'Arteriosclerosis is the broader term for arterial hardening; atherosclerosis is the specific process of plaque accumulation in coronary arteries that restricts blood flow and causes ischemia.',
   'Arteriosclerosis (hardening of arteries broadly) and atherosclerosis (plaque buildup in coronary arteries causing ischemia and risk of heart attack/stroke) are related but distinct terms.',
   'Herbs for Atherosclerosis and Lipid Dysregulation', 10),

  -- Q2: hs-CRP optimal range
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'According to these notes, what is the optimal hs-CRP level for cardiovascular health?',
   'Below 1 mg/L',
   'Below 3 mg/L',
   'Below 2 mg/L',
   'Below 6 mg/L',
   'a',
   'hs-CRP optimal is <1 mg/L; above 3 mg/L is abnormal; above 6 mg/L is highly abnormal. Elevated hs-CRP indicates chronic inflammation driving plaque formation and endothelial damage.',
   'hs-CRP is a marker of systemic inflammation with specific cardiovascular relevance; optimal is <1 mg/L; above 3 mg/L is abnormal; above 6 mg/L is highly abnormal.',
   'Herbs for Atherosclerosis and Lipid Dysregulation', 20),

  -- Q3: TC/HDL optimal ratio
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'What is the optimal TC/HDL ratio for cardiovascular risk reduction according to these notes?',
   'Under 3.0',
   'Under 4.5',
   'Under 5.0',
   'Under 2.0',
   'a',
   'TC/HDL should be under 3.0 (optimal); TG/HDL should be under 2.5. These ratios are far more meaningful than any single cholesterol number.',
   'Key ratios: TC/HDL should be under 3.0 (optimal); TG/HDL should be under 2.5 - these are far more meaningful than any single cholesterol number.',
   'Herbs for Atherosclerosis and Lipid Dysregulation', 30),

  -- Q4: Chromosome 9p21 diet study
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'The Chromosome 9p21 variant increases CVD risk by 30%. According to a 2011 PLOS study, what dietary intervention negates all of that increased genetic risk?',
   'Following a Mediterranean diet pattern overall',
   'Consuming omega-3 fatty acids daily',
   'Eating 3-6 servings of raw fruit and raw/cooked vegetables per day',
   'Eliminating refined carbohydrates',
   'c',
   'Eating 3-6 servings of raw fruit and raw/cooked vegetables per day negates all of the increased genetic risk from the 9p21 variant, demonstrating that epigenetic factors (lifestyle) are far more powerful than genetic predisposition in most cases.',
   'The Chromosome 9p21 variant increases CVD risk by 30%; two copies doubles risk - yet eating 3-6 servings of raw fruit and raw/cooked vegetables per day negates all of that increased genetic risk (PLOS, 2011).',
   'Herbs for Atherosclerosis and Lipid Dysregulation', 40),

  -- Q5: Statin mechanism
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'How do statin drugs primarily work?',
   'By directly binding LDL particles in the bloodstream and removing them',
   'By increasing bile acid excretion from the liver',
   'By inhibiting cholesterol absorption in the small intestine',
   'By semi-blocking cholesterol synthesis in the liver',
   'd',
   'Statins work primarily by semi-blocking cholesterol synthesis in the liver. They were first isolated from the fungus Aspergillus terreus and are naturally occurring compounds, not synthetic inventions.',
   'Statin drugs (Simvastatin, Pravastatin, etc.) work primarily by semi-blocking cholesterol synthesis in the liver; different statins have different adverse effect profiles.',
   'Statin Support', 50),

  -- Q6: CoQ10 depletion
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'Why is CoQ10 supplementation recommended for clients taking statin drugs?',
   'Statins deplete CoQ10, a benzoquinone-terpene compound vital for mitochondrial function',
   'CoQ10 enhances the cholesterol-lowering effect of statins',
   'CoQ10 prevents the liver toxicity that all statins cause',
   'Statins block CoQ10 receptors and supplementation bypasses this blockade',
   'a',
   'Statins deplete CoQ10 (ubiquinone, a benzoquinone-terpene compound vital for mitochondrial function). This is why myopathies, fatigue, and cognitive decline are known statin adverse effects.',
   'Statins deplete CoQ10 (ubiquinone, a benzoquinone-terpene compound vital for mitochondrial function) - supplement to replenish; also recommend milk thistle for liver protection.',
   'Statin Support', 60),

  -- Q7: Hawthorn mechanism
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'What is the primary mechanism by which hawthorn (Crataegus spp.) restores and maintains the suppleness of blood vessel walls?',
   'Anthocyanidin flavonoids reduce free radical damage and upregulate nitric oxide (NO) release',
   'Directly dissolving calcified plaques via chelation of calcium',
   'Inhibiting angiotensin-converting enzyme to prevent vasoconstriction',
   'Increasing fibrinogen clearance to reduce clot risk',
   'a',
   'Hawthorn''s anthocyanidin flavonoids reduce free radical damage and upregulate nitric oxide (NO) release, which optimizes vasodilative impact on vascular endothelium tissue - restoring the suppleness that is lost in arteriosclerosis.',
   'Anthocyanidin flavonoids in hawthorn (Crataegus spp.) reduce free radical damage and upregulate nitric oxide (NO) release, optimizing its vasodilative impact on vascular endothelium tissue. Restores and maintains the suppleness of blood vessel walls - the antithesis of arteriosclerosis.',
   'Herbs for Atherosclerosis and Lipid Dysregulation', 70),

  -- Q8: Hawthorn energetics
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'Which statement best describes the energetic nuance of hawthorn in cardiovascular presentations?',
   'It is strictly cooling and should not be used in cold presentations',
   'It is heating and pungent, appropriate only for cold, stagnant blood presentations',
   'It clears heat from the heart-mind while being gently warming overall, making it appropriate even in some hot presentations',
   'It is neutral energetically and can be used in any cardiovascular pattern',
   'c',
   'Hawthorn is an example of energetic nuance beyond simply "hot or cold": it clears heat from the heart-mind while being gently warming overall. In cardiovascular disease, moving and unblocking stagnation matters more than simply cooling, so a warming blood-mover can still be appropriate even in hot presentations.',
   'Hawthorn is an example of energetic nuance beyond "hot or cold": it clears heat from the heart-mind while being gently warming overall. In cardiovascular disease, moving and unblocking stagnation matters more than simply cooling.',
   'Herbs for Atherosclerosis and Lipid Dysregulation', 80),

  -- Q9: Berberine plaque study
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'According to Ma et al. (Signal Transduction, 2022), what percentage decrease in atherosclerotic plaque score was observed with oral berberine (0.5g twice daily) for 4 months?',
   '3.2%',
   '7.5%',
   '12%',
   '1.8%',
   'a',
   'Patients with atherosclerosis exhibited the average decrease of plaque score by 3.2% after oral berberine (0.5g, bid) for 4 months (Ma et al., Signal Transduction, 2022). Berberine-rich herbs include barberry, Oregon grape, and coptis.',
   '"Patients with atherosclerosis exhibited the average decrease of plaque score by 3.2% after oral BBR (0.5g, bid) for 4 months" (Ma et al., Signal Transduction, 2022).',
   'Herbs for Atherosclerosis and Lipid Dysregulation', 90),

  -- Q10: Berberine mechanism
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'According to these notes, much of berberine''s cardiovascular benefit comes from which mechanism?',
   'Direct inhibition of HMG-CoA reductase (same target as statins)',
   'Anti-inflammatory action on vascular endothelium',
   'Upregulation of LDL receptors in hepatocytes',
   'Gut microbiome effects',
   'd',
   'Much of berberine''s benefit comes from its gut microbiome effects. This is why whole-herb preparations (barberry, Oregon grape) are preferred over isolated berberine - the full plant matrix supports microbiome engagement.',
   'Much of berberine''s benefit comes from its gut microbiome effects; whole-herb preparations are preferred over isolated berberine.',
   'Herbs for Atherosclerosis and Lipid Dysregulation', 100),

  -- Q11: Artichoke vs statins
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'What is the key advantage of artichoke leaf extract over statins for lipid management?',
   'Artichoke leaf lowers LDL more effectively than any statin at equivalent doses',
   'Artichoke leaf improves the TC/HDL ratio by raising HDL, not just lowering LDL',
   'Artichoke leaf eliminates the need for lifestyle change, unlike statins',
   'Artichoke leaf also treats the underlying inflammation that statins cannot address',
   'b',
   'The key advantage of artichoke leaf extract is that it raises HDL (not just lowers LDL), thereby improving the TC/HDL ratio. This is distinct from statins which primarily lower LDL. The Rondanelli et al. 2013 study confirmed this effect.',
   'Key advantage over statins: artichoke leaf improves the TC/HDL ratio by raising HDL, not just lowering LDL.',
   'Herbs for Atherosclerosis and Lipid Dysregulation', 110),

  -- Q12: Night-Blooming Cereus indication
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'Night-blooming cactus (Selenicereus grandiflorus) is especially indicated for which pattern of heart disharmony?',
   'Yin-deficient heart presentations ("heart feeling vexed") arising from fear or trauma, with palpitations and chest pressure',
   'Deficient heart yang with cold limbs and congestive heart failure signs',
   'Phlegm invading the heart-mind with severe agitation and psychosis',
   'Stagnant heart blood with chest pain and purple tongue',
   'a',
   'Night-blooming cactus is specifically indicated for yin-deficient heart presentations ("heart feeling vexed"), particularly palpitations, chest pressure, and states arising from fear or trauma. It is moistening and yin-nourishing.',
   'Night-blooming cactus (Selenicereus grandiflorus): highly regarded by eclectic physicians of the 19th-early 20th century, particularly for yin-deficient heart presentations ("heart feeling vexed"). Especially indicated for palpitations, chest pressure, and states arising from fear or trauma; moistening and yin-nourishing.',
   'Herbs for Atherosclerosis and Lipid Dysregulation', 120),

  -- Q13: Dan Shen contraindication
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'What is the primary contraindication for dan shen (Salvia miltiorrhiza)?',
   'Concurrent use of anticoagulant drugs',
   'Patients with yin deficiency - it is too drying',
   'Hypothyroidism - it suppresses thyroid function',
   'Concurrent statin use - it amplifies liver toxicity',
   'a',
   'Dan shen is contraindicated when a patient is on anticoagulant drugs. As a blood-moving herb, it has additive anticoagulant effects and is not safe to combine with pharmaceutical anticoagulants.',
   'Dan shen (Salvia miltiorrhiza): a blood-moving herb from Chinese medicine for congealed/stagnant heart blood, ischemia, and angina; also builds blood to some degree. Contraindicated when patient is on anticoagulant drugs.',
   'Blood-Moving Herbs for Ischemia and Stagnation', 130),

  -- Q14: Ginkgo administration form
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'Which statement about ginkgo administration is emphasized in these notes?',
   'Ginkgo capsules are preferred over tincture for cardiovascular use',
   'Ginkgo is best combined with hawthorn to enhance nitric oxide release',
   'Ginkgo should be avoided in all blood-stagnation patterns due to anticoagulant risk',
   'Ginkgo tea is essentially ineffective - use tincture or standardized extract',
   'd',
   'Ginkgo tea is essentially ineffective - the active constituents (ginkgolides, flavonoids) require appropriate extraction with alcohol or standardized processing. Use tincture or standardized extract.',
   'Ginkgo (Ginkgo biloba): moves blood and improves circulation. Caution with anticoagulant drugs; ginkgo tea is essentially ineffective - use tincture or standardized extract.',
   'Blood-Moving Herbs for Ischemia and Stagnation', 140),

  -- Q15: Ginkgolides shared mechanism
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'What is the fascinatingly shared mechanism between ginkgo''s cardiovascular and respiratory effects?',
   'Ginkgolides are both ACE inhibitors and mast cell stabilizers',
   'Ginkgolides are PAF (platelet activating factor) inhibitors and bronchodilators, reducing platelet aggregation AND helping asthmatic states',
   'Ginkgo flavonoids both scavenge free radicals and dilate bronchial smooth muscle',
   'Ginkgo proanthocyanidins act on both the coagulation cascade and airway inflammation via the same NF-kB pathway',
   'b',
   'Ginkgolides are PAF (platelet activating factor) inhibitors and bronchodilators: the same compound reduces platelet aggregation (cardiovascular benefit) AND helps asthmatic states (respiratory benefit) - a shared mechanism that links cardiovascular and pulmonary inflammation.',
   'Ginkgolides are PAF (platelet activating factor) inhibitors and bronchodilators: they reduce platelet aggregation AND help asthmatic states - a fascinatingly shared mechanism with cardiovascular disease.',
   'Blood-Moving Herbs for Ischemia and Stagnation', 150),

  -- Q16: Tienchi bidirectional
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'Which of the following best describes the unique bidirectional action of tienchi/san qi (Panax notoginseng)?',
   'It both lowers LDL and raises HDL, improving the lipid ratio from both directions',
   'It both moves blood AND reduces bleeding - a bidirectional action shared by cinnamon',
   'It both clears heart heat and nourishes heart yin simultaneously',
   'It both stimulates circulation and reduces vascular spasm',
   'b',
   'Tienchi/san qi is described as a blood-regulating herb that both moves blood (reducing stagnation) AND reduces bleeding (stops heavy menstrual bleeding) - a bidirectional action. The notes specifically note this is shared by cinnamon.',
   'Tienchi/san qi (Panax notoginseng): a blood-regulating herb in Chinese medicine that both moves blood AND reduces bleeding (stops heavy menstrual bleeding) - a bidirectional action shared by cinnamon.',
   'Blood-Moving Herbs for Ischemia and Stagnation', 160),

  -- Q17: Dong Quai pattern
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'The "dry riverbed" pattern, for which dang gui (Angelica sinensis) is especially suited, refers to which clinical picture?',
   'Excess phlegm blocking the heart vessels with thick, sticky pulse',
   'Liver fire rising with red face, agitation, and high blood pressure',
   'Yang deficiency with cold extremities and congestive heart failure',
   'Blood deficiency underlying blood stagnation - cold, anemic, fatigued patient',
   'd',
   'The "dry riverbed" pattern describes blood deficiency underlying stagnation - insufficient blood to flow properly. Dang gui is ideal for this because it both moves blood (breaks stagnation) and nourishes/builds blood. The patient presenting cold, anemic, and fatigued fits this picture.',
   'Dang gui (Angelica sinensis) both moves blood (breaks up stagnation) and nourishes/builds blood - ideal for the "dry riverbed" pattern where blood deficiency underlies stagnation. Especially suited when someone is cold, anemic, and fatigued.',
   'Blood-Moving Herbs for Ischemia and Stagnation', 170),

  -- Q18: Cayenne research
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'According to Yuan et al. (Clin Nutr, 2016), what two cardiovascular risk factors did capsaicin supplementation improve?',
   'Elevated homocysteine and elevated fibrinogen',
   'Elevated hs-CRP and elevated Lipo(a)',
   'Elevated uric acid and elevated ApoB',
   'Postprandial hyperglycemia/hyperinsulinemia and fasting lipid metabolic disorders',
   'd',
   'Yuan et al. (2016) found that capsaicin-containing chili supplementation improved both postprandial hyperglycemia (blood sugar) and fasting lipid metabolic disorders - addressing two deeply intertwined cardiovascular risk factors.',
   '"Capsaicin-containing chili supplementation regularly improved postprandial hyperglycemia and hyperinsulinemia as well as fasting lipid metabolic disorders" (Yuan et al., Clin Nutr, 2016).',
   'Blood-Moving Herbs for Ischemia and Stagnation', 180),

  -- Q19: Viburnum adjunct tip
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'The use of Viburnum species (black haw, cramp bark) as cardiovascular adjuncts was attributed to which herbalist in these notes?',
   'Matthew Wood',
   'David Hoffmann',
   'Paul Bergner',
   'David Winston',
   'b',
   'The use of viburnum species as cardiovascular adjuncts comes from a tip attributed to David Hoffmann. These antispasmodic herbs relax smooth muscle including vascular endothelium, making arterial walls more supple and less prone to plaque accumulation.',
   'Viburnum species (black haw - V. prunifolium; cramp bark - V. opulus/trilobum): antispasmodic herbs used as adjuncts in cardiovascular protocols to relax smooth muscle including vascular endothelium. Relaxed arterial walls are more supple, less prone to scarring and plaque accumulation; tip from David Hoffmann.',
   'Circulatory and Phlegm-Clearing Herbs', 190),

  -- Q20: Rosemary indication
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'Which cardiovascular presentation does rosemary address according to these notes?',
   'Phlegm-invading-heart-mind presentations with mental fog and poor peripheral circulation',
   'Yin-deficient heart presentations with dry mouth, thirst, and disturbed dreams',
   'Congealed heart blood with angina and purple tongue',
   'Deficient heart yang with cold limbs and congestive signs',
   'a',
   'Rosemary supports circulation to the periphery and brain and is indicated specifically for phlegm-invading-heart-mind presentations with mental fog and poor peripheral circulation. It clears and stimulates cognition.',
   'Rosemary (Salvia rosmarinus): supports circulation particularly to the periphery and brain; indicated for phlegm-invading-heart-mind presentations with mental fog and poor peripheral circulation.',
   'Circulatory and Phlegm-Clearing Herbs', 200),

  -- Q21: Kudzu/Ge Gen indication
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'What is kudzu/ge gen (Pueraria lobata) traditionally used for in East Asian cardiovascular medicine?',
   'Clearing liver heat and resolving dampness in metabolic syndrome',
   'Nourishing heart yin and calming agitation after emotional trauma',
   'Reducing ischemia and related angina, as well as gut health and arthritic symptoms',
   'Lowering LDL cholesterol through bile acid excretion',
   'c',
   'Kudzu/ge gen reduces ischemia and related angina in traditional East Asian medicine; it also has applications for gut health, wind disharmonies, and arthritic symptoms. Unexplained chest pain should always be medically evaluated before treating herbally.',
   'Kudzu/ge gen (Pueraria lobata): reduces ischemia and related angina in traditional East Asian medicine; also used for gut health, wind disharmonies, and arthritic symptoms.',
   'Circulatory and Phlegm-Clearing Herbs', 210),

  -- Q22: Dandelion root vs leaf
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'When using dandelion for cardiovascular liver support, which part is primarily recommended?',
   'The leaf, for its diuretic and potassium-sparing effects',
   'The root, for its hepatic bitter action on liver clearance and bile production',
   'Either part is equally effective for cholesterol regulation',
   'The flower, for its anti-inflammatory flavonoids',
   'b',
   'The root is recommended primarily for liver and cardiovascular applications because of its hepatic bitter action supporting liver clearance and bile production - both key mechanisms in cholesterol regulation.',
   'Dandelion root (Taraxacum officinale): hepatic bitter supporting liver clearance and bile production - both key mechanisms in cholesterol regulation. Choose the root primarily for liver/cardiovascular applications.',
   'Hepatic Bitters for Lipid Metabolism', 220),

  -- Q23: Gentian - flavor of heart
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'According to Chinese five element theory as explained in these notes, why is gentian relevant for cardiovascular presentations?',
   'Gentian''s cold nature counters the excess heat that damages blood vessels',
   'Gentian is a qi tonic that strengthens the heart''s vital force',
   'Bitter is the flavor of the heart (fire element), and bitters clear heat from the fire',
   'Gentian moves blood stagnation through its pungent secondary action',
   'c',
   'In Chinese medicine, bitter is the flavor of the heart (fire element). Gentian is a powerful digestive bitter that is resonant with the heart - bitters clear heat from the fire. It is chosen when heat-clearing is needed without yin nourishment.',
   'Gentian (Gentiana lutea): a powerful digestive bitter resonant with the heart in Chinese medicine - bitter is the flavor of the heart (fire element), and bitters clear heat from the fire.',
   'Hepatic Bitters for Lipid Metabolism', 230),

  -- Q24: Cacao epicatechin content
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'According to Corti et al. (Circulation, 2009), which food group has the second highest epicatechin content after chocolate?',
   'Green tea and black tea',
   'Red wine and berries',
   'Apples and pears',
   'Beans and legumes',
   'd',
   'Highest epicatechin sources are chocolate (460-610 mg/kg), followed by beans/legumes (350-550 mg/kg). The notes emphasize that legumes are a dramatically underappreciated cardiovascular food - eat beans regularly as a cardiovascular medicine in food form.',
   'Highest epicatechin sources: chocolate (460-610 mg/kg), beans/legumes (350-550 mg/kg), apricots, cherries, peaches, blackberries, apples, green tea, black tea, red wine (Corti et al., Circulation, 2009).',
   'Cardiovascular Flavanols and Lipid-Modulating Herbs', 240),

  -- Q25: Cacao AHA endorsement
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'According to these notes, which organization published the evidence that epicatechins reduce blood pressure, improve vascular function, and are anti-inflammatory?',
   'The World Health Organization (WHO)',
   'National Institutes of Health (NIH)',
   'American Heart Association (AHA), in their journal Circulation',
   'European Society of Cardiology (ESC)',
   'c',
   'The AHA published this research in their journal Circulation (Corti et al., 2009) - this is mainstream cardiology endorsing epicatechin flavanols for cardiovascular health, not just alternative medicine.',
   'Epicatechins reduce blood pressure, improve vascular function, reduce platelet reactivity, improve insulin sensitivity, and are anti-inflammatory (Corti et al., Circulation / American Heart Association, 2009).',
   'Cardiovascular Flavanols and Lipid-Modulating Herbs', 250),

  -- Q26: Garlic anticoagulant concern
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'At what level of garlic consumption does anticoagulant concern arise according to these notes?',
   'Any amount of fresh garlic raises anticoagulant risk',
   'Concern arises at more than 2 cloves per day',
   'Concern arises at more than 1 clove per day cooked',
   'At high supplemental doses; at culinary amounts there is no anticoagulant concern',
   'd',
   'At culinary amounts there is no anticoagulant concern with garlic. It is only at high supplemental doses that more caution is warranted. This distinction matters for clinical guidance.',
   'Garlic (Allium sativum): well-established for cardiovascular health; decreases LDL while increasing HDL. At culinary amounts there is no anticoagulant concern; at high supplemental doses exercise more caution.',
   'Cardiovascular Flavanols and Lipid-Modulating Herbs', 260),

  -- Q27: Guggul + hypothyroidism
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'Why is guggul described as ideal for the common combination of elevated LDL plus hypothyroidism?',
   'Guggul directly stimulates T4 to T3 conversion, addressing both conditions simultaneously',
   'Guggul lowers LDL, VLDL, and triglycerides while increasing HDL and also supports thyroid function',
   'Guggul contains iodine that replenishes thyroid stores while its resins clear cholesterol',
   'Guggul is an adaptogen that normalizes both lipid metabolism and thyroid hormone levels',
   'b',
   'Guggul lowers LDL, VLDL, and triglycerides while significantly increasing HDL, and it also supports thyroid function. Hypothyroidism can cause elevated LDL (cholesterol cannot be converted to thyroid hormones), so addressing both together is clinically elegant.',
   'Guggul (Commiphora mukul): Ayurvedic blood-cleansing resin; lowers LDL, VLDL, and triglycerides while significantly increasing HDL; also supports thyroid function - making it ideal for the common combination of elevated LDL plus hypothyroidism.',
   'Cardiovascular Flavanols and Lipid-Modulating Herbs', 270),

  -- Q28: Myrrh as guggul substitute
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'When guggul is unavailable or hard to source sustainably, what herb is suggested as a substitute?',
   'Myrrh (Commiphora myrrha/molmol)',
   'Dan shen',
   'Artichoke leaf',
   'Barberry',
   'a',
   'Myrrh is described as a milder substitute for guggul as guggul becomes harder to source sustainably. Both are Commiphora resins with similar blood-cleansing and lipid-modulating properties.',
   'Myrrh (Commiphora myrrha) is a milder substitute as guggul becomes harder to source sustainably.',
   'Cardiovascular Flavanols and Lipid-Modulating Herbs', 280),

  -- Q29: Motherwort + Linden pair
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'How do motherwort and linden complement each other in cardiovascular protocols according to these notes?',
   'Motherwort lowers blood pressure while linden reduces triglycerides',
   'Motherwort nourishes yin while linden moves blood stagnation',
   'Motherwort stimulates heart muscle contraction while linden dilates blood vessels',
   'Motherwort clears heat while linden nourishes yin - they address the pattern from different directions',
   'd',
   'Motherwort clears heat and calms agitation; linden is yin-nourishing, moistening, and comforting. They complement rather than duplicate each other by addressing the cardiovascular presentation from different energetic angles.',
   'Motherwort (Leonurus cardiaca) clears heat and calms agitation; Linden (Tilia spp.) is yin-nourishing, moistening, and comforting. These can be combined: motherwort for heat-clearing, linden for yin nourishment - they complement rather than duplicate each other.',
   'Nervines for Cardiovascular Health', 290),

  -- Q30: Red Yeast Rice concern
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'What quality concern is highlighted for Red Yeast Rice in these notes?',
   'It frequently causes liver toxicity when sourced from China',
   'It may interact with thyroid medications if not properly processed',
   'Some batches have been spiked with pharmaceutical statin drugs, so careful sourcing is essential',
   'It must be refrigerated to remain active - most commercial products are inert',
   'c',
   'The notes specifically flag that some Red Yeast Rice batches were spiked with pharmaceutical statin drugs, making careful sourcing essential. It naturally contains low-level statins (monacolins), and adulteration blurs the line between natural and pharmaceutical.',
   'Red Yeast Rice (Monascus purpureus): traditional Chinese remedy that naturally contains low-level statins (monacolins); well-established for lowering LDL at typical doses (600 mg/day); may also deplete CoQ10. Source carefully to avoid adulterated batches (some were spiked with pharmaceutical statin drugs).',
   'Supplements for Lipid Dysregulation', 300),

  -- Q31: Red Yeast Rice dosage
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'What is the typical dose of Red Yeast Rice mentioned in these notes for LDL reduction?',
   '600 mg per day',
   '1200 mg twice daily',
   '300 mg three times daily',
   '1000 mg per day',
   'a',
   'Red Yeast Rice is well-established for lowering LDL at typical doses of 600 mg/day. This is also the dose used in the case study protocol.',
   'Red Yeast Rice (Monascus purpureus): traditional Chinese remedy that naturally contains low-level statins (monacolins); well-established for lowering LDL at typical doses (600 mg/day); may also deplete CoQ10.',
   'Supplements for Lipid Dysregulation', 310),

  -- Q32: PUFA mortality reduction
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'According to JAMA Internal Medicine (2016), what reduction in total mortality was associated with replacing 5% of energy from saturated fats with equivalent energy from PUFAs?',
   '12% reduction',
   '27% reduction',
   '41% reduction',
   '18% reduction',
   'b',
   '"Replacing 5% of energy from saturated fats with equivalent energy from PUFA was associated with estimated reductions in total mortality of 27%, and MUFA with 13%." (JAMA Intern Med, 2016).',
   '"Replacing 5% of energy from saturated fats with equivalent energy from PUFA and MUFA was associated with estimated reductions in total mortality of 27% and 13%, respectively" (JAMA Intern Med, 2016).',
   'Supplements for Lipid Dysregulation', 320),

  -- Q33: Homocysteine + MMA = B12 deficiency
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'According to Vashi et al. (PLoS One, 2016), what does it indicate when BOTH methylmalonic acid (MMA) AND homocysteine are elevated?',
   'Folate deficiency specifically',
   'B6 deficiency with impaired glutathione synthesis',
   'Kidney disease interfering with B vitamin metabolism',
   'B12 deficiency',
   'd',
   'Both elevated MMA and homocysteine = B12 deficiency. If homocysteine alone is elevated, it more likely indicates folate deficiency. The notes also note that normal or high serum B12 can still indicate B12-deficient state - MMA and homocysteine are superior functional indicators.',
   'Both elevated MMA and homocysteine = B12 deficiency; homocysteine elevated alone = likely folate deficiency - but deficiencies can co-occur, so use a B complex. "Normal or high serum B12 can sometimes be seen in a B12-deficient state" - MMA and homocysteine are superior functional indicators of B12 utilization at the cellular level (Vashi et al., PLoS One, 2016).',
   'Supplements for Lipid Dysregulation', 330),

  -- Q34: Homocysteine methylation pathway
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'Via which vitamin is homocysteine recycled to glutathione in the methylation cycle?',
   'Vitamin B12 (methylated)',
   'Folate',
   'Vitamin B6',
   'Niacin',
   'c',
   'Homocysteine is recycled back to methionine via methylated B12 (MTR/MTRR pathway), and to glutathione via B6. Inadequate B6 specifically impairs the conversion of homocysteine to glutathione - an important distinction when choosing which B vitamins to target.',
   'Homocysteine is a metabolic byproduct of the methylation cycle; it is recycled back to methionine via methylated B12 (MTR/MTRR pathway), and to glutathione via B6 - inadequate B vitamins cause homocysteine to accumulate.',
   'Supplements for Lipid Dysregulation', 340),

  -- Q35: Homocysteine optimal range
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'What is the optimal homocysteine level according to these notes?',
   'Below 10.0 micromoles/L',
   'Below 7.5 micromoles/L',
   'Below 15 micromoles/L (normal upper limit)',
   'Below 5.0 micromoles/L',
   'a',
   'Normal range for homocysteine is 4-15 micromoles/L, but optimal is <10.0. A client shown at 13.5 is technically normal but meaningfully elevated. The notes emphasize that trend over time matters more than any single value.',
   'Normal range: 4-15 micromoles/L; optimal: <10.0; client shown at 13.5 (technically normal but meaningfully elevated).',
   'Supplements for Lipid Dysregulation', 350),

  -- Q36: Five Elements liver-heart
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'In Five Element theory, the Liver (Wood) is called the "mother" of the Heart (Fire). What clinical implication does this carry for cardiovascular disease?',
   'Anger causes the liver to release inflammatory cytokines that directly damage cardiac muscle',
   'Treating the liver is contraindicated in heart disease as it draws qi away from the heart',
   'Heart disease frequently originates in liver function (lipid regulation) or kidney function (blood pressure)',
   'The liver and heart must always be treated together with the same herbs',
   'c',
   'In the Five Elements framework, the liver is the "mother" of the heart - heart disease largely originates in liver function (lipid regulation) or kidney function (blood pressure). This explains why liver-supportive herbs (dandelion root, artichoke, gentian) are foundational in cardiovascular protocols.',
   'In the Five Elements of Chinese medicine, the Liver (Wood) generates the Heart (Fire) - the liver is the "mother" of the heart; heart disease largely originates in liver function (lipid regulation) or kidney function (blood pressure).',
   'Hepatic Bitters for Lipid Metabolism', 360),

  -- Q37: Reishi characterization
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'How is reishi mushroom (Ganoderma lucidum) characterized in terms of its cardiovascular role?',
   'A specific anti-ischemic herb best suited for stagnant blood patterns',
   'A comprehensive cardiovascular adaptogen appropriate for a wide range of heart health presentations',
   'A yin-nourishing herb primarily for deficient heart blood and disturbed shen',
   'A lipid-lowering herb comparable to statins in clinical efficacy',
   'b',
   'Reishi is characterized as a "comprehensive cardiovascular adaptogen" - this broad framing means it can support many cardiovascular presentations rather than being specific to one pattern.',
   'Reishi (Ganoderma lucidum) is a comprehensive cardiovascular adaptogen. These can be combined: motherwort for heat-clearing, linden for yin nourishment - they complement rather than duplicate each other.',
   'Nervines for Cardiovascular Health', 370),

  -- Q38: Case: TC/HDL improvement
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'What was the TC/HDL ratio improvement in the case study after one year of the full protocol?',
   '8.1 to 5.4',
   '5.0 to 3.2',
   '6.8 to 3.6',
   '7.2 to 4.1',
   'c',
   'The TC/HDL ratio improved from 6.8 to 3.6 over one year, which represents a substantial improvement. The notes note that HDL increased AND LDL decreased - both directions improving the ratio.',
   'TC/HDL ratio improved from 6.8 to 3.6 (HDL increased, LDL decreased); triglycerides reduced by half; gout flare-ups resolved; uric acid down from 9.0 to 6.3.',
   'Case: Hyperlipidemia, Atherosclerosis, and Gout', 380),

  -- Q39: Case: uric acid improvement
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'In the case study, what was the uric acid level before and after treatment?',
   '9.0 down to 6.3 mg/dL',
   '11.2 down to 7.8 mg/dL',
   '8.5 down to 5.1 mg/dL',
   '10.0 down to 7.0 mg/dL',
   'a',
   'Uric acid improved from 9.0 to 6.3 mg/dL over one year. Normal range is 3.4-7.0 mg/dL, so the client moved from clearly elevated into the normal range. This was accompanied by resolution of gout flare-ups.',
   'TC/HDL ratio improved from 6.8 to 3.6 (HDL increased, LDL decreased); triglycerides reduced by half; gout flare-ups resolved; uric acid down from 9.0 to 6.3.',
   'Case: Hyperlipidemia, Atherosclerosis, and Gout', 390),

  -- Q40: Case: Linden outcome
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'In the case study, family members noted that the client became more warm, affectionate, and sentimental after one year. To which herb was this attributed by the practitioner?',
   'Motherwort',
   'Hawthorn',
   'Reishi',
   'Linden',
   'd',
   'Family members reported him as more warm, affectionate, and sentimental after one year - attributed to Linden. This illustrates linden''s yin-nourishing, comforting qualities operating at a shen (heart-mind) level beyond just physical cardiovascular metrics.',
   'Family members reported him as more warm, affectionate, and sentimental - attributed to Linden.',
   'Case: Hyperlipidemia, Atherosclerosis, and Gout', 400),

  -- Q41: Case: anger/frustration rationale
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'The case client''s goal of managing anger and frustration was directly linked by the practitioner to which Chinese medicine dynamic?',
   'Phlegm invading the heart-mind with emotional dampness',
   'Liver Fire feeding Heart Fire',
   'Kidney yang deficiency failing to warm the heart',
   'Spleen qi deficiency causing emotional turbulence',
   'b',
   'The anger/frustration goal maps directly to Liver Fire feeding Heart Fire - an energetically coherent rationale for including motherwort (heat-clearing) and other heart-calming herbs in the protocol.',
   'Goals reflect both physical and emotional-energetic dimensions; the anger/frustration goal maps directly to Liver Fire feeding Heart Fire.',
   'Case: Hyperlipidemia, Atherosclerosis, and Gout', 410),

  -- Q42: Case: tincture formula
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'What was the tincture formula used in the case protocol, and at what dose?',
   'Dan shen (2), hawthorn (1), motherwort (1) - 3 ml 3x/day',
   'Guggul (2), artichoke leaf (1), dandelion root (1) - 5 ml 2x/day',
   'Artichoke leaf (2), celery seed (1), pipsissewa (1) - 3 ml 3x/day',
   'Milk thistle (2), gentian (1), garlic (1) - 4 ml 2x/day',
   'c',
   'The tincture formula was artichoke leaf (2 parts), celery seed (1 part), pipsissewa (1 part) at 3 ml 3x/day. Artichoke leaf is the primary herb at double the proportion, targeting lipid metabolism and liver clearance.',
   'Tincture: artichoke leaf (2), celery seed (1), pipsissewa (1) - 3 ml 3x/day.',
   'Case: Hyperlipidemia, Atherosclerosis, and Gout', 420),

  -- Q43: Case: celery seed dietary advice
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'Beyond the tincture formula, the case dietary protocol recommended increasing which foods specifically for uric acid management?',
   'Celery, celery seed, parsley, and cucumber',
   'Blueberries, cherries, and tart fruit juices',
   'Flaxseed, chia, and other omega-3 rich seeds',
   'Cruciferous vegetables and bitter greens',
   'a',
   'The case protocol specifically advised increasing celery, celery seed, parsley, and cucumber for uric acid management. These foods support uric acid clearance through alkalizing and diuretic effects.',
   'Diet: increase celery, celery seed, parsley, cucumber; avoid high-purine animal foods; avoid alcohol; stay well hydrated; increase bulk fiber.',
   'Case: Hyperlipidemia, Atherosclerosis, and Gout', 430),

  -- Q44: Case: omega-3 dose
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'The case client was initially taking 240 EPA / 360 DHA per day. To what dose was this increased in the protocol, and why?',
   'To 1500 mg combined - the standard preventive cardiovascular dose',
   'To 2000 mg combined - maximum safe dose for a cardiac patient',
   'To 2500 mg - minimum therapeutic dose for triglyceride lowering',
   'To 3000-4000 mg combined EPA/DHA per day - the initial dose was described as sub-therapeutic',
   'd',
   'The initial omega-3 dose (240 EPA + 360 DHA = 600 mg combined) was explicitly noted as sub-therapeutic. The protocol increased it substantially to 3000-4000 mg combined EPA/DHA per day.',
   'Case: Supplements: Cod liver oil 240 EPA / 360 DHA per day - note: this omega-3 dose is sub-therapeutic; Rich increased it significantly in the protocol to 3000-4000 mg combined EPA/DHA per day.',
   'Case: Hyperlipidemia, Atherosclerosis, and Gout', 440),

  -- Q45: Statin cognitive decline
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'In the case study, what was the client''s response to attributed cognitive decline from statin use?',
   'He continued the statin but added CoQ10 and milk thistle to mitigate effects',
   'He stopped the statin two months after the initial intake after being informed by the practitioner',
   'He switched to Red Yeast Rice as a natural alternative after a physician recommendation',
   'He continued the statin but reduced the dose by half',
   'b',
   'The client attributed his cognitive decline to statin use and stopped taking the statin two months after their initial intake. The practitioner (Rich) provided information enabling the client to make an informed choice for his own body, but did not direct the decision.',
   'Client attributed his cognitive decline to statin use and stopped taking the statin two months after their initial intake - cognitive effects are a documented but under-discussed adverse effect in a subset of patients. Rich did not direct this decision.',
   'Case: Hyperlipidemia, Atherosclerosis, and Gout', 450),

  -- Q46: Liver role in cholesterol
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'According to these notes, approximately what percentage of blood cholesterol comes from diet vs liver synthesis?',
   'About 75% from diet, 25% synthesized by the liver',
   'About 50% from diet, 50% synthesized by the liver',
   'About 25% from diet; the vast majority is synthesized in the liver',
   'Nearly all cholesterol is dietary; the liver simply recycles it',
   'c',
   'Only ~25% of blood cholesterol comes from diet; the vast majority is synthesized in the liver. This is why dietary restriction alone is insufficient for many people, and why the cholesterol we produce internally is essential - we cannot live without it.',
   'Cholesterol is a fundamental steroidal molecule and precursor for all steroid hormones. Only ~25% of blood cholesterol comes from diet; the vast majority is synthesized in the liver - we cannot live without it.',
   'Herbs for Atherosclerosis and Lipid Dysregulation', 460),

  -- Q47: Artichoke emotional connection
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'Beyond its lipid-modulating effects, what emotional dimension does artichoke leaf address that is relevant to cardiovascular disease?',
   'Artichoke calms grief and sadness that damage the lungs and weaken the heart',
   'Artichoke addresses frustration and anger associated with the liver, which can contribute to cardiovascular disease',
   'Artichoke resolves fear and trauma that cause yin deficiency in the heart',
   'Artichoke clears the heaviness of worry that burdens the spleen-heart axis',
   'b',
   'Artichoke leaf addresses emotional components - frustration and anger associated with the liver can contribute to cardiovascular disease. The herb works on both the physical (lipid metabolism) and emotional-energetic levels.',
   'Artichoke leaf (Cynara scolymus): a powerful digestive bitter acting on liver clearance and lipid metabolism. Also addresses emotional components - frustration and anger associated with the liver can contribute to cardiovascular disease; artichoke leaf works on both levels.',
   'Herbs for Atherosclerosis and Lipid Dysregulation', 470),

  -- Q48: Black Haw vs Cramp Bark
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'What is the cardiovascular rationale for including antispasmodic herbs like black haw or cramp bark in a protocol?',
   'They directly lower LDL by increasing bile acid excretion',
   'They stimulate nitric oxide release to dilate coronary arteries',
   'They reduce blood viscosity, allowing easier cardiac pumping',
   'They relax smooth muscle including vascular endothelium, making arterial walls more supple and less prone to plaque accumulation',
   'd',
   'Black haw and cramp bark relax smooth muscle including vascular endothelium. Relaxed, supple arterial walls are less prone to scarring and plaque accumulation - this is their cardiovascular mechanism as adjuncts.',
   'Viburnum species (black haw - V. prunifolium; cramp bark - V. opulus/trilobum): antispasmodic herbs used as adjuncts in cardiovascular protocols to relax smooth muscle including vascular endothelium. Relaxed arterial walls are more supple, less prone to scarring and plaque accumulation.',
   'Circulatory and Phlegm-Clearing Herbs', 480),

  -- Q49: Guggul full lipid picture
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'According to Das et al. (Journal of Dietary Supplements, 2016), what comprehensive lipid changes were seen with guggul treatment?',
   'Significant reduction in LDL and total cholesterol only',
   'Significant reduction in cholesterol, triglyceride, LDL and VLDL, and significant increase in HDL',
   'Significant increase in HDL and reduction in Lipo(a), with neutral effects on LDL',
   'Reduction in LDL and increase in HDL, with no effect on triglycerides or VLDL',
   'b',
   '"All treated groups had significant reduction in cholesterol, triglyceride, LDL and VLDL, and had significant increase in HDL in comparison to pre-treatment values" (Das et al., 2016). Guggul improves the full lipid picture - not just lowering LDL but raising HDL and reducing triglycerides and VLDL.',
   '"All treated groups had significant reduction in cholesterol, triglyceride, LDL and VLDL, and had significant increase in HDL in comparison to pre-treatment values" (Das et al., Journal of Dietary Supplements, 2016).',
   'Cardiovascular Flavanols and Lipid-Modulating Herbs', 490),

  -- Q50: Phthalates CVD deaths
  ('Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol',
   'According to Trasande et al. (J. Endocrine Society, 2024), how many CVD deaths per year in the USA are estimated to be caused by phthalates?',
   'About 5,000 deaths/year',
   'About 20,000 deaths/year',
   'About 50,000 deaths/year',
   'About 100,000 deaths/year',
   'c',
   'Phthalates (industrial plasticizers) are estimated to cause up to 50,000 CVD deaths per year in the USA (Trasande et al., J. Endocrine Society, 2024). The notes frame this as a "drop in the plastic bucket" highlighting the cardiovascular cost of industrial chemical exposure.',
   'Phthalates (industrial plasticizers) are estimated to cause up to 50,000 CVD deaths per year in the USA (Trasande et al., J. Endocrine Society, 2024). Environmental toxins also contribute to type 2 diabetes, endocrine disruption, reproductive harm, and cancers.',
   'Herbs for Atherosclerosis and Lipid Dysregulation', 500);

END $$;
