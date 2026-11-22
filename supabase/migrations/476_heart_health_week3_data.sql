-- Migration 476: Herbal Heart Health Week 3 class note snippets
-- Sources parsed:
--   Week 3 - Atherosclerosis and Cholesterol.md (slide-based notes)
--
-- Herb name normalizations:
--   Tienchi / San Qi (Panax notoginseng) -> Pseudoginseng Root / Notoginseng (id=1599)
--   Dang Gui (Angelica sinensis) -> Dong Quai (id=1009)
--   Myrrh (Commiphora myrrha) -> Myrrh (id=99, Commiphora molmol - synonym in DB)
--   Reishi -> Reishi Mushroom (id=11)
--   Kudzu/Ge Gen -> Kudzu Root (id=1547)
--   Rosemary (Salvia rosmarinus) -> Rosemary (id=109, Rosmarinus officinalis - synonym)
--
-- Skipped:
--   Oyster mushrooms (Pleurotus spp.) - food, not in DB
--   Tart cherry juice - Prunus cerasus not in DB (Wild Cherry Bark id=140 is different species)
--
-- New supplement added: Red Yeast Rice (Monascus purpureus)
--
-- Merge decisions:
--   'dyslipidemia' -> 'hyperlipidemia' (already in DB, same clinical concept)
--   'anti-platelet' (existing action keyword) used for antiplatelet aggregation effects
--   'blood stagnation' (existing action keyword) used for congealed heart blood pattern

SET search_path TO herbal, public;

-- Add Red Yeast Rice supplement if not present
INSERT INTO herbal.supplements (name, category)
SELECT 'Red Yeast Rice', 'Other'
WHERE NOT EXISTS (SELECT 1 FROM herbal.supplements WHERE name = 'Red Yeast Rice');

-- Herb snippets
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets
             WHERE class_name = 'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol') THEN
    RAISE NOTICE 'Week 3 snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- SECTION: Statin Support
  (206,
   'Milk thistle is recommended for liver protection when a client is on statin drugs. Statins carry documented adverse effects including fatty liver, myopathies, metabolic syndrome, and cognitive decline; milk thistle supports hepatoprotection and ongoing liver clearance during statin use.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Statin Support', 10,
   'Statins deplete CoQ10 (ubiquinone, a benzoquinone-terpene compound vital for mitochondrial function) - supplement to replenish; also recommend milk thistle for liver protection. Known adverse effects to monitor: myopathies (muscular aching/pain, sometimes persistent after stopping), fatty liver, metabolic syndrome, cognitive decline - all documented but not universal. Statins were first isolated from Aspergillus terreus; oyster mushrooms (Pleurotus spp.) have the highest levels of naturally occurring statins of any food.'),

  -- SECTION: Herbs for Atherosclerosis and Lipid Dysregulation
  (73,
   'Hawthorn (Crataegus spp.) anthocyanidin flavonoids reduce free radical damage and upregulate nitric oxide (NO) release, restoring and maintaining the suppleness of blood vessel walls - the antithesis of arteriosclerosis. Exerts: antioxidant, positive inotropic (strengthens heart muscle contraction), anti-inflammatory, antiplatelet aggregation, vasodilating, endothelial protective, anti-ischemic, antiarrhythmic, lipid-lowering, and blood pressure-lowering effects (Wang et al., Evid Based Complement Alternat Med, 2013). Energetically it clears heat from the heart-mind while being gently warming overall - in CVD, moving and unblocking stagnation matters more than simply cooling.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Herbs for Atherosclerosis and Lipid Dysregulation', 20,
   'Anthocyanidin flavonoids in hawthorn (Crataegus spp.) reduce free radical damage and upregulate nitric oxide (NO) release, optimizing its vasodilative impact on vascular endothelium tissue. Restores and maintains the suppleness of blood vessel walls - the antithesis of arteriosclerosis. Hawthorn is an example of energetic nuance: it clears heat from the heart-mind while being gently warming overall. In cardiovascular disease, moving and unblocking stagnation matters more than simply cooling; a warming blood-mover can still be appropriate even in hot presentations. Hawthorn extracts exert: antioxidant, positive inotropic, anti-inflammatory, antiplatelet aggregation, vasodilating, endothelial protective, anti-ischemic, antiarrhythmic, lipid-lowering, and blood pressure-lowering effects (Wang et al., Evid Based Complement Alternat Med, 2013). A gentle but comprehensive cardiovascular medicine - appears in every module of this course.'),

  (2616,
   'Night-blooming cactus (Selenicereus grandiflorus): highly regarded by eclectic physicians for yin-deficient heart presentations ("heart feeling vexed"). Especially indicated for palpitations, chest pressure, and states arising from fear or trauma; moistening and yin-nourishing. Will be revisited in Module 5 for heart rhythm regulation.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Herbs for Atherosclerosis and Lipid Dysregulation', 30,
   'Night-blooming cactus (Selenicereus grandiflorus): highly regarded by eclectic physicians of the 19th-early 20th century, particularly for yin-deficient heart presentations ("heart feeling vexed"). Especially indicated for palpitations, chest pressure, and states arising from fear or trauma; moistening and yin-nourishing; will be revisited in Module 5 for heart rhythm regulation.'),

  (158,
   'Barberry (Berberis vulgaris) is a berberine-rich herb that reduces atherosclerotic plaque: patients with atherosclerosis showed an average decrease of plaque score by 3.2% after oral berberine (0.5g twice daily) for 4 months (Ma et al., Signal Transduction, 2022). Much of berberine''s benefit comes from gut microbiome effects; whole-herb preparations are preferred over isolated berberine. Barberry and Oregon grape root are clinically interchangeable.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Herbs for Atherosclerosis and Lipid Dysregulation', 40,
   'Berberine-rich herbs (barberry, Oregon grape, coptis) reduce atherosclerotic plaque: "Patients with atherosclerosis exhibited the average decrease of plaque score by 3.2% after oral BBR (0.5g, bid) for 4 months" (Ma et al., Signal Transduction, 2022). Much of berberine''s benefit comes from its gut microbiome effects; whole-herb preparations are preferred over isolated berberine; barberry and Oregon grape root are interchangeable.'),

  (33,
   'Oregon grape (Mahonia aquifolium) is a berberine-rich herb that reduces atherosclerotic plaque (3.2% plaque reduction at 0.5g berberine bid x4 months, Ma 2022). Gut microbiome modulation is a key mechanism. Clinically interchangeable with barberry; whole-herb preparations preferred over isolated berberine.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Herbs for Atherosclerosis and Lipid Dysregulation', 50,
   'Berberine-rich herbs (barberry, Oregon grape, coptis) reduce atherosclerotic plaque: "Patients with atherosclerosis exhibited the average decrease of plaque score by 3.2% after oral BBR (0.5g, bid) for 4 months" (Ma et al., Signal Transduction, 2022). Much of berberine''s benefit comes from its gut microbiome effects; whole-herb preparations are preferred over isolated berberine; barberry and Oregon grape root are interchangeable.'),

  (1561,
   'Coptis rhizome is a berberine-rich herb used in Chinese medicine that reduces atherosclerotic plaque through berberine''s plaque-reducing and gut microbiome modulating effects. Whole-herb preparations preferred over isolated berberine.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Herbs for Atherosclerosis and Lipid Dysregulation', 60,
   'Berberine-rich herbs (barberry, Oregon grape, coptis) reduce atherosclerotic plaque: "Patients with atherosclerosis exhibited the average decrease of plaque score by 3.2% after oral BBR (0.5g, bid) for 4 months" (Ma et al., Signal Transduction, 2022). Much of berberine''s benefit comes from its gut microbiome effects; whole-herb preparations are preferred over isolated berberine.'),

  (172,
   'Artichoke leaf (Cynara scolymus): a powerful digestive bitter acting on liver clearance and lipid metabolism; particularly useful for dyslipidemia (dysregulated HDL/LDL ratio). ALE (artichoke leaf extract) increases HDL and decreases total cholesterol and LDL (Rondanelli et al., Int J Food Sci Nutr, 2013). Key advantage over statins: raises HDL, not just lowers LDL. Also addresses emotional components - frustration and anger associated with the liver can contribute to cardiovascular disease.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Herbs for Atherosclerosis and Lipid Dysregulation', 70,
   'Artichoke leaf (Cynara scolymus): a powerful digestive bitter acting on liver clearance and lipid metabolism; particularly useful for dyslipidemia (dysregulated HDL/LDL ratio). Also addresses emotional components - frustration and anger associated with the liver can contribute to cardiovascular disease. "ALE (artichoke leaf extract) could play a relevant role in the management of mild hypercholesterolaemia, favouring in particular the increase in HDL-C, besides decreasing total cholesterol and LDL-cholesterol" (Rondanelli et al., Int J Food Sci Nutr, 2013). Key advantage over statins: artichoke leaf improves the TC/HDL ratio by raising HDL, not just lowering LDL.'),

  -- SECTION: Blood-Moving Herbs for Ischemia and Stagnation
  (956,
   'Dan shen (Salvia miltiorrhiza): a blood-moving herb from Chinese medicine for congealed/stagnant heart blood, ischemia, and angina; also builds blood to some degree. Contraindicated when patient is on anticoagulant drugs; highly effective for ischemic states when not contraindicated.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Blood-Moving Herbs for Ischemia and Stagnation', 80,
   'Dan shen (Salvia miltiorrhiza): a blood-moving herb from Chinese medicine for congealed/stagnant heart blood, ischemia, and angina; also builds blood to some degree. Contraindicated when patient is on anticoagulant drugs; highly effective for ischemic states when not contraindicated. Ginkgo (Ginkgo biloba): moves blood and improves circulation; energetically not hot or pungent, making it appropriate when warming blood-movers are energetically incorrect. Caution with anticoagulant drugs; ginkgo tea is essentially ineffective - use tincture or standardized extract; also useful for some asthmatic presentations through PAF inhibition. Ginkgolides are PAF (platelet activating factor) inhibitors and bronchodilators: they reduce platelet aggregation AND help asthmatic states - a fascinatingly shared mechanism with cardiovascular disease. Tienchi/san qi (Panax notoginseng): a blood-regulating herb that both moves blood AND reduces bleeding - a bidirectional action shared by cinnamon. Reduces ischemia and improves circulation; use with caution on anticoagulants. Dang gui (Angelica sinensis) both moves blood and nourishes/builds blood - ideal for the "dry riverbed" pattern where blood deficiency underlies stagnation. Especially suited when someone is cold, anemic, and fatigued; caution with anticoagulant drugs. Cayenne (Capsicum annuum): pungent, blood-moving, circulatory-stimulating herb. "Capsaicin-containing chili supplementation regularly improved postprandial hyperglycemia and hyperinsulinemia as well as fasting lipid metabolic disorders" (Yuan et al., Clin Nutr, 2016).'),

  (165,
   'Ginkgo (Ginkgo biloba): moves blood and improves circulation; energetically not hot or pungent, making it appropriate when warming blood-movers are energetically incorrect for the patient. Caution with anticoagulant drugs; ginkgo tea is essentially ineffective - use tincture or standardized extract. Ginkgolides are PAF (platelet activating factor) inhibitors and bronchodilators: they reduce platelet aggregation AND help asthmatic states - a fascinatingly shared mechanism with cardiovascular disease.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Blood-Moving Herbs for Ischemia and Stagnation', 90,
   'Dan shen (Salvia miltiorrhiza): a blood-moving herb from Chinese medicine for congealed/stagnant heart blood, ischemia, and angina; also builds blood to some degree. Contraindicated when patient is on anticoagulant drugs; highly effective for ischemic states when not contraindicated. Ginkgo (Ginkgo biloba): moves blood and improves circulation; energetically not hot or pungent, making it appropriate when warming blood-movers are energetically incorrect. Caution with anticoagulant drugs; ginkgo tea is essentially ineffective - use tincture or standardized extract; also useful for some asthmatic presentations through PAF inhibition. Ginkgolides are PAF (platelet activating factor) inhibitors and bronchodilators: they reduce platelet aggregation AND help asthmatic states - a fascinatingly shared mechanism with cardiovascular disease.'),

  (1599,
   'Tienchi/san qi (Panax notoginseng): a blood-regulating herb in Chinese medicine that both moves blood AND reduces bleeding (stops heavy menstrual bleeding) - a bidirectional action shared by cinnamon. Reduces ischemia and improves circulation; use with caution on anticoagulants; also valuable for arthritis and gut health.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Blood-Moving Herbs for Ischemia and Stagnation', 100,
   'Tienchi/san qi (Panax notoginseng): a blood-regulating herb in Chinese medicine that both moves blood AND reduces bleeding (stops heavy menstrual bleeding) - a bidirectional action shared by cinnamon. Reduces ischemia and improves circulation; use with caution on anticoagulants; also valuable for arthritis and gut health.'),

  (1009,
   'Dang gui (Angelica sinensis) both moves blood (breaks up stagnation) and nourishes/builds blood - ideal for the "dry riverbed" pattern where blood deficiency underlies stagnation. Especially suited when someone is cold, anemic, and fatigued; caution with anticoagulant drugs as with other blood-moving herbs.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Blood-Moving Herbs for Ischemia and Stagnation', 110,
   'Dang gui (Angelica sinensis) both moves blood (breaks up stagnation) and nourishes/builds blood - ideal for the "dry riverbed" pattern where blood deficiency underlies stagnation. Especially suited when someone is cold, anemic, and fatigued; caution with anticoagulant drugs as with other blood-moving herbs.'),

  (47,
   'Cayenne (Capsicum annuum): pungent, blood-moving, circulatory-stimulating herb. "Capsaicin-containing chili supplementation regularly improved postprandial hyperglycemia and hyperinsulinemia as well as fasting lipid metabolic disorders" (Yuan et al., Clin Nutr, 2016). Cayenne addresses both metabolic disease (blood sugar) and lipid dysregulation - two deeply intertwined cardiovascular risk factors.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Blood-Moving Herbs for Ischemia and Stagnation', 120,
   'Cayenne (Capsicum annuum): pungent, blood-moving, circulatory-stimulating herb with well-established cardiovascular research. "Capsaicin-containing chili supplementation regularly improved postprandial hyperglycemia and hyperinsulinemia as well as fasting lipid metabolic disorders" (Yuan et al., Clin Nutr, 2016). Cayenne addresses both metabolic disease (blood sugar) and lipid dysregulation - two deeply intertwined cardiovascular risk factors.'),

  -- SECTION: Circulatory and Phlegm-Clearing Herbs
  (109,
   'Rosemary (Salvia rosmarinus): supports circulation particularly to the periphery and brain; indicated for phlegm-invading-heart-mind presentations with mental fog and poor peripheral circulation. Also supports the heart-mind aspect of cardiovascular health through its clearing and stimulating effects on cognition.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Circulatory and Phlegm-Clearing Herbs', 130,
   'Rosemary (Salvia rosmarinus): supports circulation particularly to the periphery and brain; indicated for phlegm-invading-heart-mind presentations with mental fog and poor peripheral circulation. Also supports the heart-mind aspect of cardiovascular health through its clearing and stimulating effects on cognition. Kudzu/ge gen (Pueraria lobata): reduces ischemia and related angina in traditional East Asian medicine; also used for gut health, wind disharmonies, and arthritic symptoms. Abundant in the southeastern USA; always advise unexplained chest pain be medically evaluated before treating herbally. Viburnum species (black haw - V. prunifolium; cramp bark - V. opulus/trilobum): antispasmodic herbs used as adjuncts in cardiovascular protocols to relax smooth muscle including vascular endothelium. Relaxed arterial walls are more supple, less prone to scarring and plaque accumulation; tip from David Hoffmann - these are not often thought of as heart herbs but are valuable adjuncts.'),

  (1547,
   'Kudzu/ge gen (Pueraria lobata): reduces ischemia and related angina in traditional East Asian medicine; also used for gut health, wind disharmonies, and arthritic symptoms. Abundant in the southeastern USA; always advise unexplained chest pain be medically evaluated before treating herbally.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Circulatory and Phlegm-Clearing Herbs', 140,
   'Kudzu/ge gen (Pueraria lobata): reduces ischemia and related angina in traditional East Asian medicine; also used for gut health, wind disharmonies, and arthritic symptoms. Abundant in the southeastern USA; always advise unexplained chest pain be medically evaluated before treating herbally.'),

  (94,
   'Black haw (Viburnum prunifolium): antispasmodic herb used as an adjunct in cardiovascular protocols to relax smooth muscle including vascular endothelium. Relaxed arterial walls are more supple, less prone to scarring and plaque accumulation. Tip from David Hoffmann - not often thought of as a heart herb but a valuable adjunct.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Circulatory and Phlegm-Clearing Herbs', 150,
   'Viburnum species (black haw - V. prunifolium; cramp bark - V. opulus/trilobum): antispasmodic herbs used as adjuncts in cardiovascular protocols to relax smooth muscle including vascular endothelium. Relaxed arterial walls are more supple, less prone to scarring and plaque accumulation; tip from David Hoffmann - these are not often thought of as heart herbs but are valuable adjuncts.'),

  (93,
   'Cramp bark (Viburnum opulus/trilobum): antispasmodic herb used as an adjunct in cardiovascular protocols to relax smooth muscle including vascular endothelium. Relaxed arterial walls are more supple, less prone to scarring and plaque accumulation. Tip from David Hoffmann - not often thought of as a heart herb but a valuable adjunct.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Circulatory and Phlegm-Clearing Herbs', 160,
   'Viburnum species (black haw - V. prunifolium; cramp bark - V. opulus/trilobum): antispasmodic herbs used as adjuncts in cardiovascular protocols to relax smooth muscle including vascular endothelium. Relaxed arterial walls are more supple, less prone to scarring and plaque accumulation; tip from David Hoffmann - these are not often thought of as heart herbs but are valuable adjuncts.'),

  -- SECTION: Hepatic Bitters for Lipid Metabolism
  (122,
   'Dandelion root (Taraxacum officinale): hepatic bitter supporting liver clearance and bile production - both key mechanisms in cholesterol regulation. The liver is the "mother" of the heart in Five Elements theory; liver clearance through bile production and glutathione synthesis is a key mechanism regulating cholesterol. Choose the root primarily for liver/cardiovascular applications; a core part of any liver-supportive cardiovascular protocol.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Hepatic Bitters for Lipid Metabolism', 170,
   'Dandelion root (Taraxacum officinale): hepatic bitter supporting liver clearance and bile production - both key mechanisms in cholesterol regulation. Choose the root primarily for liver/cardiovascular applications; a core part of any liver-supportive cardiovascular protocol. Gentian (Gentiana lutea): a powerful digestive bitter resonant with the heart in Chinese medicine - bitter is the flavor of the heart (fire element), and bitters clear heat from the fire. Choose gentian when heat-clearing is needed without yin nourishment; pairs with yin-nourishing herbs when deficiency underlies the fire. In Five Elements theory, the Liver (Wood) generates the Heart (Fire) - liver clearance through bile production and glutathione synthesis is a key mechanism regulating cholesterol.'),

  (102,
   'Gentian (Gentiana lutea): a powerful digestive bitter resonant with the heart in Chinese medicine - bitter is the flavor of the heart (fire element), and bitters clear heat from the fire. Choose gentian when heat-clearing is needed without yin nourishment; pairs with yin-nourishing herbs when deficiency underlies the fire.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Hepatic Bitters for Lipid Metabolism', 180,
   'Gentian (Gentiana lutea): a powerful digestive bitter resonant with the heart in Chinese medicine - bitter is the flavor of the heart (fire element), and bitters clear heat from the fire. Choose gentian when heat-clearing is needed without yin nourishment; pairs with yin-nourishing herbs when deficiency underlies the fire.'),

  -- SECTION: Cardiovascular Flavanols and Lipid-Modulating Herbs
  (2749,
   'Cacao (Theobroma cacao) is both a physical and shen medicine for the heart; rich in epicatechin flavanols that reduce platelet reactivity, improve vascular function, reduce inflammation, and lower blood pressure. Epicatechins reduce blood pressure, improve vascular function, reduce platelet reactivity, improve insulin sensitivity, and are anti-inflammatory (Corti et al., Circulation / AHA, 2009). Highest epicatechin food sources: chocolate (460-610 mg/kg), beans/legumes (350-550 mg/kg) - legumes are second only to chocolate and dramatically underappreciated.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Cardiovascular Flavanols and Lipid-Modulating Herbs', 190,
   'Cacao (Theobroma cacao) is both a physical and shen medicine for the heart; rich in epicatechin flavanols that reduce platelet reactivity, improve vascular function, reduce inflammation, and lower blood pressure. Beans/legumes are second highest in epicatechin content after chocolate - a dramatically underappreciated cardiovascular food. Epicatechins reduce blood pressure, improve vascular function, reduce platelet reactivity, improve insulin sensitivity, and are anti-inflammatory (Corti et al., Circulation / AHA, 2009). Highest epicatechin sources: chocolate (460-610 mg/kg), beans/legumes (350-550 mg/kg), apricots, cherries, peaches, blackberries, apples, green tea, black tea, red wine.'),

  (21,
   'Garlic (Allium sativum): well-established for cardiovascular health; decreases LDL while increasing HDL, improving the TC/HDL ratio more than statin-only LDL reduction would suggest. At culinary amounts there is no anticoagulant concern; at high supplemental doses exercise more caution.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Cardiovascular Flavanols and Lipid-Modulating Herbs', 200,
   'Garlic (Allium sativum): well-established for cardiovascular health; decreases LDL while increasing HDL, improving the TC/HDL ratio more than statin-only LDL reduction would suggest. At culinary amounts there is no anticoagulant concern; at high supplemental doses exercise more caution.'),

  (877,
   'Guggul (Commiphora mukul): Ayurvedic blood-cleansing resin; lowers LDL, VLDL, and triglycerides while significantly increasing HDL; also supports thyroid function - making it ideal for the common combination of elevated LDL plus hypothyroidism. "All treated groups had significant reduction in cholesterol, triglyceride, LDL and VLDL, and had significant increase in HDL in comparison to pre-treatment values" (Das et al., Journal of Dietary Supplements, 2016). Improves the full lipid picture - not just lowering LDL but raising HDL.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Cardiovascular Flavanols and Lipid-Modulating Herbs', 210,
   'Guggul (Commiphora mukul): Ayurvedic blood-cleansing resin; lowers LDL, VLDL, and triglycerides while significantly increasing HDL; also supports thyroid function - making it ideal for the common combination of elevated LDL plus hypothyroidism. Myrrh (Commiphora myrrha) is a milder substitute as guggul becomes harder to source sustainably. "All treated groups had significant reduction in cholesterol, triglyceride, LDL and VLDL, and had significant increase in HDL in comparison to pre-treatment values" (Das et al., Journal of Dietary Supplements, 2016).'),

  (99,
   'Myrrh (Commiphora myrrha/molmol): a milder substitute for guggul as guggul becomes harder to source sustainably. Similar blood-cleansing and lipid-modulating properties; can be used when guggul is unavailable.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Cardiovascular Flavanols and Lipid-Modulating Herbs', 220,
   'Myrrh (Commiphora myrrha) is a milder substitute as guggul becomes harder to source sustainably.'),

  -- SECTION: Nervines for Cardiovascular Health
  (131,
   'Motherwort (Leonurus cardiaca) clears heat and calms agitation; a nervine-cardiac herb for cardiovascular presentations with excess heat, palpitations, and tachycardia. Pairs well with linden for complementary actions - motherwort clears heat while linden nourishes yin; they complement rather than duplicate each other.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Nervines for Cardiovascular Health', 230,
   'Motherwort (Leonurus cardiaca) clears heat and calms agitation; Linden (Tilia spp.) is yin-nourishing, moistening, and comforting; Reishi (Ganoderma lucidum) is a comprehensive cardiovascular adaptogen. These can be combined: motherwort for heat-clearing, linden for yin nourishment - they complement rather than duplicate each other.'),

  (90,
   'Linden (Tilia spp.) is yin-nourishing, moistening, and comforting for cardiovascular presentations. Pairs with motherwort: motherwort clears heat while linden nourishes yin - they complement rather than duplicate each other.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Nervines for Cardiovascular Health', 240,
   'Motherwort (Leonurus cardiaca) clears heat and calms agitation; Linden (Tilia spp.) is yin-nourishing, moistening, and comforting; Reishi (Ganoderma lucidum) is a comprehensive cardiovascular adaptogen. These can be combined: motherwort for heat-clearing, linden for yin nourishment - they complement rather than duplicate each other.'),

  (11,
   'Reishi mushroom (Ganoderma lucidum) is a comprehensive cardiovascular adaptogen, appropriate for a wide range of heart health presentations. Combines well with motherwort and linden for multi-dimensional cardiovascular support.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Nervines for Cardiovascular Health', 250,
   'Motherwort (Leonurus cardiaca) clears heat and calms agitation; Linden (Tilia spp.) is yin-nourishing, moistening, and comforting; Reishi (Ganoderma lucidum) is a comprehensive cardiovascular adaptogen. These can be combined: motherwort for heat-clearing, linden for yin nourishment - they complement rather than duplicate each other.'),

  -- SECTION: Case: Hyperlipidemia, Atherosclerosis, and Gout
  (73,
   'Case (68yo cis-male, hyperlipidemia TC/HDL 6.8, triple bypass, gout): protocol included infusion of hawthorn, linden, motherwort, and dandelion root (2-3 cups daily). Outcomes after one year: TC/HDL ratio improved from 6.8 to 3.6 (HDL increased, LDL decreased), triglycerides reduced by half.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Case: Hyperlipidemia, Atherosclerosis, and Gout', 260,
   'Case: 68-year-old cis-male: hypertension, hyperlipidemia, triple bypass 3 years prior, hyperuricemia and gout; Labs: uric acid 9.0, TC 273, HDL 40, LDL 200, TG 161; TC/HDL ratio ~6.8. Medications: Atorvastatin, low-dose aspirin, metoprolol, amlodipine. Health goals: manage gout, go off statins, lose weight, address blood pressure, manage anger/frustration. Protocol: physical activity with PT; 4-7-8 breathing; infusion of hawthorn, linden, motherwort, and dandelion root (2-3 cups daily); Guggul capsules (Himalaya brand, 2 caps 2x/day); tincture: artichoke leaf (2), celery seed (1), pipsissewa (1) - 3 ml 3x/day; Red Yeast Rice 600 mg once/day; B complex (including niacinamide); milk thistle (while still on statins); CoQ10; increase omega-3 to 3000-4000 mg combined EPA/DHA per day; tart cherry juice 2 oz/day for uric acid. Outcomes after one year: TC/HDL ratio improved from 6.8 to 3.6; triglycerides reduced by half; gout flare-ups resolved; uric acid from 9.0 to 6.3; improved memory and cognitive function; joined gym, lost ~20 lbs; family reported him as more warm, affectionate, sentimental - attributed to Linden.'),

  (90,
   'Case: Linden (Tilia spp.) was part of the daily cardiovascular infusion (with hawthorn, motherwort, dandelion root; 2-3 cups daily). Family members reported the client as more warm, affectionate, and sentimental after one year - attributed to linden by the practitioner.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Case: Hyperlipidemia, Atherosclerosis, and Gout', 270,
   'Case outcomes after one year: TC/HDL ratio improved from 6.8 to 3.6; triglycerides reduced by half; gout flare-ups resolved; uric acid down from 9.0 to 6.3; stress test: all clear; improved memory and cognitive function; joined gym, lost ~20 lbs. Family members reported him as more warm, affectionate, and sentimental - attributed to Linden; blood pressure also improved (details in Module 4); outcomes required full commitment to lifestyle, not just herbs.'),

  (131,
   'Case: Motherwort (Leonurus cardiaca) was part of the daily cardiovascular infusion (with hawthorn, linden, dandelion root; 2-3 cups daily). The case protocol mapped the client''s anger/frustration goals directly to Liver Fire feeding Heart Fire - an energetically coherent choice for motherwort as a heat-clearing nervine-cardiac.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Case: Hyperlipidemia, Atherosclerosis, and Gout', 280,
   'Case: Health goals: manage gout, go off statins, lose weight, secondarily address blood pressure, manage anger and frustration better. Goals reflect both physical and emotional-energetic dimensions; the anger/frustration goal maps directly to Liver Fire feeding Heart Fire. Protocol: infusion of hawthorn, linden, motherwort, and dandelion root (2-3 cups daily).'),

  (122,
   'Case: Dandelion root (Taraxacum officinale) was included in the daily cardiovascular infusion (with hawthorn, linden, motherwort; 2-3 cups daily) for liver clearance and bile support as part of an integrated protocol for hyperlipidemia and atherosclerosis.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Case: Hyperlipidemia, Atherosclerosis, and Gout', 290,
   'Case: Protocol: infusion of hawthorn, linden, motherwort, and dandelion root (2-3 cups daily); Guggul capsules (Himalaya brand, 2 caps 2x/day); tincture: artichoke leaf (2), celery seed (1), pipsissewa (1) - 3 ml 3x/day.'),

  (877,
   'Case: Guggul (Himalaya brand, 2 caps 2x/day) was used in a protocol for 68-year-old with hyperlipidemia (TC/HDL 6.8), atherosclerosis, and gout. Outcome after one year: TC/HDL improved from 6.8 to 3.6, triglycerides reduced by half, gout flares resolved, uric acid from 9.0 to 6.3.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Case: Hyperlipidemia, Atherosclerosis, and Gout', 300,
   'Case: Protocol: Guggul capsules (Himalaya brand, 2 caps 2x/day); tincture: artichoke leaf (2), celery seed (1), pipsissewa (1) - 3 ml 3x/day; Red Yeast Rice 600 mg once/day; B complex (including niacinamide).'),

  (172,
   'Case: Artichoke leaf was included in the tincture formula (artichoke leaf 2 parts, celery seed 1 part, pipsissewa 1 part - 3 ml 3x/day) as the primary lipid-modulating and liver-supportive herb. Artichoke''s ability to raise HDL and clear the liver aligned with the case goals of improving TC/HDL ratio.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Case: Hyperlipidemia, Atherosclerosis, and Gout', 310,
   'Case: Tincture: artichoke leaf (2), celery seed (1), pipsissewa (1) - 3 ml 3x/day. Red Yeast Rice 600 mg once/day; B complex (including niacinamide); note: herbs that reduce blood pressure were introduced gradually due to blood pressure medications.'),

  (66,
   'Case: Celery seed (Apium graveolens) was included in the tincture formula (artichoke leaf 2, celery seed 1, pipsissewa 1 - 3 ml 3x/day) for a 68-year-old with hyperlipidemia, atherosclerosis, and gout. The diet protocol also emphasized increasing celery, celery seed, parsley, and cucumber for uric acid management.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Case: Hyperlipidemia, Atherosclerosis, and Gout', 320,
   'Case: Tincture: artichoke leaf (2), celery seed (1), pipsissewa (1) - 3 ml 3x/day. Diet: increase celery, celery seed, parsley, cucumber; avoid high-purine animal foods; avoid alcohol; stay well hydrated; increase bulk fiber.'),

  (2239,
   'Case: Pipsissewa (Chimaphila umbellata) was included in the tincture formula (artichoke leaf 2, celery seed 1, pipsissewa 1 - 3 ml 3x/day) as a renal/urinary supportive adjunct in this cardiovascular and gout protocol.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Case: Hyperlipidemia, Atherosclerosis, and Gout', 330,
   'Case: Tincture: artichoke leaf (2), celery seed (1), pipsissewa (1) - 3 ml 3x/day.'),

  (206,
   'Case: Milk thistle (Silybum marianum) was used while the client was still on Atorvastatin, for liver protection during statin use. Part of a comprehensive protocol for a 68-year-old with hyperlipidemia, atherosclerosis, and gout.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Case: Hyperlipidemia, Atherosclerosis, and Gout', 340,
   'Case continuation: tart cherry juice 2 oz/day (for uric acid clearance); milk thistle (while still on statins); CoQ10; increase omega-3 to 3000-4000 mg combined EPA/DHA per day. Diet: cacao, mushroom broths, flavonoid- and antioxidant-rich foods, PUFAs; avoid high-purine animal foods; increase celery, celery seed, parsley, cucumber; avoid alcohol; stay well hydrated; increase bulk fiber.');

END $$;

-- Supplement snippets
DO $$
DECLARE
  v_ryr_id integer;
BEGIN
  SELECT id INTO v_ryr_id FROM herbal.supplements WHERE name = 'Red Yeast Rice';

  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets
             WHERE supplement_id = 32
               AND class_name = 'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol') THEN
    RAISE NOTICE 'Week 3 supplement snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- SECTION: Statin Support
  (32,
   'Statins deplete CoQ10 (ubiquinone, a benzoquinone-terpene compound vital for mitochondrial function) - supplement to replenish when client is on statins. Statin adverse effects to monitor include myopathies (sometimes persistent after stopping), fatty liver, metabolic syndrome, and cognitive decline - all documented but not universal.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Statin Support', 10,
   'Statins deplete CoQ10 (ubiquinone, a benzoquinone-terpene compound vital for mitochondrial function) - supplement to replenish; also recommend milk thistle for liver protection. Known adverse effects to monitor: myopathies (muscular aching/pain, sometimes persistent after stopping), fatty liver, metabolic syndrome, cognitive decline - all documented but not universal.'),

  -- SECTION: Supplements for Lipid Dysregulation
  (v_ryr_id,
   'Red Yeast Rice (Monascus purpureus): traditional Chinese remedy that naturally contains low-level statins (monacolins); well-established for lowering LDL at typical doses (600 mg/day); may also deplete CoQ10. Source carefully to avoid adulterated batches (some were spiked with pharmaceutical statin drugs); useful when a client needs to demonstrate meaningful results on a tight timeline.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Supplements for Lipid Dysregulation', 20,
   'Key supplements: Red Yeast Rice, CoQ10, Niacin in the form of niacinamide plus broader B complex, Omega-3 / fish or algae-based oils. These work synergistically with herbs and lifestyle interventions to address lipid dysregulation from multiple angles. Red Yeast Rice (Monascus purpureus): traditional Chinese remedy that naturally contains low-level statins (monacolins); well-established for lowering LDL at typical doses (600 mg/day); may also deplete CoQ10. Source carefully to avoid adulterated batches (some were spiked with pharmaceutical statin drugs); useful when client needs to demonstrate meaningful results on a tight timeline.'),

  (33,
   'Fish or algae-based omega-3 oils work synergistically with herbs and lifestyle interventions to address lipid dysregulation. Replacing 5% of energy from saturated fats with equivalent energy from PUFA and MUFA was associated with estimated reductions in total mortality of 27% and 13%, respectively (JAMA Intern Med, 2016).',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Supplements for Lipid Dysregulation', 30,
   '"Replacing 5% of energy from saturated fats with equivalent energy from PUFA and MUFA was associated with estimated reductions in total mortality of 27% and 13%, respectively" (JAMA Intern Med, 2016). Increase polyunsaturated fats (omega-3/6 rich foods) and reduce saturated/trans fats - one of the most impactful dietary changes for cardiovascular mortality.'),

  (49,
   'B complex (including niacinamide) is key for methylation support and homocysteine reduction: homocysteine is recycled to methionine via methylated B12 (MTR/MTRR pathway), and to glutathione via B6 - inadequate B vitamins cause homocysteine to accumulate. Elevated homocysteine is a Nobel Prize-recognized cardiovascular risk marker. Both elevated MMA and homocysteine = B12 deficiency; homocysteine elevated alone = likely folate deficiency. Normal or high serum B12 can still indicate B12-deficient state - MMA and homocysteine are superior functional indicators (Vashi et al., PLoS One, 2016).',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Supplements for Lipid Dysregulation', 40,
   'Homocysteine is a metabolic byproduct of the methylation cycle; it is recycled back to methionine via methylated B12 (MTR/MTRR pathway), and to glutathione via B6 - inadequate B vitamins cause homocysteine to accumulate. Elevated homocysteine is a Nobel Prize-recognized cardiovascular risk marker; it signals poor methylation, impaired liver clearance, and increased risk of heart attack and stroke. Both elevated MMA and homocysteine = B12 deficiency; homocysteine elevated alone = likely folate deficiency. "Normal or high serum B12 can sometimes be seen in a B12-deficient state" - MMA and homocysteine are superior functional indicators of B12 utilization at the cellular level (Vashi et al., PLoS One, 2016).'),

  -- SECTION: Case: Hyperlipidemia, Atherosclerosis, and Gout
  (32,
   'Case: CoQ10 was included in the protocol for a 68-year-old on Atorvastatin. Client attributed his cognitive decline to statin use and stopped the statin two months after initial intake; CoQ10 was part of addressing statin-related depletion. Cognitive function improved over one year.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Case: Hyperlipidemia, Atherosclerosis, and Gout', 50,
   'Case continuation: tart cherry juice 2 oz/day (for uric acid clearance); milk thistle (while still on statins); CoQ10; increase omega-3 to 3000-4000 mg combined EPA/DHA per day. Outcomes over one year: TC/HDL ratio improved from 6.8 to 3.6; triglycerides reduced by half; gout flare-ups resolved; uric acid down from 9.0 to 6.3; improved memory and cognitive function; joined gym, lost ~20 lbs.'),

  (v_ryr_id,
   'Case: Red Yeast Rice (600 mg once/day) was used for a 68-year-old with hyperlipidemia (TC/HDL 6.8) who wanted to come off statins. Part of a protocol that brought TC/HDL from 6.8 to 3.6 over one year. Note: Red Yeast Rice may also deplete CoQ10, so CoQ10 was co-prescribed.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Case: Hyperlipidemia, Atherosclerosis, and Gout', 60,
   'Case: Red Yeast Rice 600 mg once/day; B complex (including niacinamide); note: herbs that reduce blood pressure were introduced gradually due to blood pressure medications.'),

  (33,
   'Case: Omega-3 (fish oil) dose was increased to 3000-4000 mg combined EPA/DHA per day (from an initial sub-therapeutic dose of 240 EPA / 360 DHA per day) for a 68-year-old with hyperlipidemia and atherosclerosis. The original supplement dose was explicitly noted as sub-therapeutic.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Case: Hyperlipidemia, Atherosclerosis, and Gout', 70,
   'Case: Supplements: Vitamin D3 5000 IU/day, Cod liver oil 240 EPA / 360 DHA per day - note: this omega-3 dose is sub-therapeutic; Rich increased it significantly in the protocol to 3000-4000 mg combined EPA/DHA per day.'),

  (49,
   'Case: B complex (including niacinamide) was included in the protocol for a 68-year-old with hyperlipidemia, atherosclerosis, and gout. Niacinamide is a key form of niacin for lipid support; B complex also addresses methylation cycle support and homocysteine reduction as a cardiovascular risk factor.',
   'Herbal Heart Health - Week 3 - Atherosclerosis and Cholesterol', 'generated',
   'Case: Hyperlipidemia, Atherosclerosis, and Gout', 80,
   'Case: Red Yeast Rice 600 mg once/day; B complex (including niacinamide); note: herbs that reduce blood pressure were introduced gradually due to blood pressure medications.');

END $$;

-- Herb keywords
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  -- Milk Thistle: statin/liver keywords
  (206, 'statin support',           'general'),
  (206, 'fatty liver disease',       'ailment'),
  (206, 'liver congestion',          'ailment'),
  (206, 'hepatoprotective',          'action'),

  -- Hawthorn berry: cardiovascular
  (73,  'atherosclerosis',           'ailment'),
  (73,  'cardiovascular disease',    'ailment'),
  (73,  'hypertension',              'ailment'),
  (73,  'angina',                    'ailment'),
  (73,  'ischemia',                  'ailment'),
  (73,  'hyperlipidemia',            'ailment'),
  (73,  'antioxidant',               'action'),
  (73,  'cardiotonic',               'action'),
  (73,  'vasodilator',               'action'),
  (73,  'anti-platelet',             'action'),
  (73,  'anti-inflammatory',         'action'),
  (73,  'antilipidemic',             'action'),
  (73,  'positive inotropic',        'action'),
  (73,  'endothelial protective',    'action'),

  -- Night-Blooming Cereus: yin deficiency, palpitations
  (2616,'palpitations',              'ailment'),
  (2616,'cardiovascular disease',    'ailment'),
  (2616,'yin deficiency',            'ailment'),
  (2616,'PTSD',                      'ailment'),
  (2616,'nervine-cardiac',           'action'),
  (2616,'nourishing nervine',        'action'),

  -- Barberry: berberine / atherosclerosis
  (158, 'atherosclerosis',           'ailment'),
  (158, 'hyperlipidemia',            'ailment'),
  (158, 'cardiovascular disease',    'ailment'),
  (158, 'antilipidemic',             'action'),
  (158, 'antimicrobial',             'action'),

  -- Oregon Grape: berberine / atherosclerosis
  (33,  'atherosclerosis',           'ailment'),
  (33,  'hyperlipidemia',            'ailment'),
  (33,  'cardiovascular disease',    'ailment'),
  (33,  'antilipidemic',             'action'),

  -- Coptis: berberine / atherosclerosis
  (1561,'atherosclerosis',           'ailment'),
  (1561,'hyperlipidemia',            'ailment'),
  (1561,'cardiovascular disease',    'ailment'),
  (1561,'antilipidemic',             'action'),
  (1561,'antimicrobial',             'action'),

  -- Artichoke Leaf: lipids, liver
  (172, 'hyperlipidemia',            'ailment'),
  (172, 'liver support',             'ailment'),
  (172, 'cardiovascular disease',    'ailment'),
  (172, 'liver qi stagnation',       'ailment'),
  (172, 'digestive bitter',          'action'),
  (172, 'hepatic',                   'action'),
  (172, 'hepatoprotective',          'action'),
  (172, 'antilipidemic',             'action'),
  (172, 'cholagogue',                'action'),

  -- Dan Shen: blood moving, ischemia
  (956, 'ischemia',                  'ailment'),
  (956, 'angina',                    'ailment'),
  (956, 'cardiovascular disease',    'ailment'),
  (956, 'poor circulation',          'ailment'),
  (956, 'blood deficiency',          'ailment'),
  (956, 'circulation',               'action'),
  (956, 'circulatory tonic',         'action'),
  (956, 'anti-platelet',             'action'),
  (956, 'blood stagnation',          'action'),

  -- Ginkgo: circulation, PAF
  (165, 'ischemia',                  'ailment'),
  (165, 'poor circulation',          'ailment'),
  (165, 'cardiovascular disease',    'ailment'),
  (165, 'cognitive support',         'ailment'),
  (165, 'asthma',                    'ailment'),
  (165, 'anti-platelet',             'action'),
  (165, 'antioxidant',               'action'),
  (165, 'vasodilator',               'action'),
  (165, 'bronchodilator',            'action'),
  (165, 'neuroprotective',           'action'),

  -- Pseudoginseng Root / Tienchi: bidirectional blood
  (1599,'ischemia',                  'ailment'),
  (1599,'angina',                    'ailment'),
  (1599,'heavy bleeding',            'ailment'),
  (1599,'arthritis',                 'ailment'),
  (1599,'cardiovascular disease',    'ailment'),
  (1599,'hemostatic',                'action'),
  (1599,'circulation',               'action'),
  (1599,'circulatory tonic',         'action'),

  -- Dong Quai: blood building
  (1009,'blood deficiency',          'ailment'),
  (1009,'anemia',                    'ailment'),
  (1009,'poor circulation',          'ailment'),
  (1009,'cardiovascular disease',    'ailment'),
  (1009,'blood building',            'action'),
  (1009,'blood tonic',               'action'),
  (1009,'circulation',               'action'),

  -- Cayenne: circulation, blood sugar
  (47,  'poor circulation',          'ailment'),
  (47,  'cardiovascular disease',    'ailment'),
  (47,  'blood sugar dysregulation', 'ailment'),
  (47,  'hyperlipidemia',            'ailment'),
  (47,  'circulatory stimulant',     'action'),
  (47,  'rubefacient',               'action'),

  -- Rosemary: circulation, cognition
  (109, 'poor circulation',          'ailment'),
  (109, 'brain fog',                 'ailment'),
  (109, 'cardiovascular disease',    'ailment'),
  (109, 'cognitive support',         'ailment'),
  (109, 'circulatory stimulant',     'action'),
  (109, 'nootropic',                 'action'),

  -- Kudzu Root: ischemia, angina
  (1547,'ischemia',                  'ailment'),
  (1547,'angina',                    'ailment'),
  (1547,'arthritis',                 'ailment'),
  (1547,'cardiovascular disease',    'ailment'),
  (1547,'circulation',               'action'),

  -- Black Haw: vascular antispasmodic
  (94,  'cardiovascular disease',    'ailment'),
  (94,  'vascular health',           'ailment'),
  (94,  'muscle spasms',             'ailment'),
  (94,  'antispasmodic',             'action'),
  (94,  'smooth muscle relaxant',    'action'),

  -- Cramp Bark: vascular antispasmodic
  (93,  'cardiovascular disease',    'ailment'),
  (93,  'vascular health',           'ailment'),
  (93,  'muscle spasms',             'ailment'),
  (93,  'antispasmodic',             'action'),
  (93,  'smooth muscle relaxant',    'action'),

  -- Dandelion Root: liver, lipids
  (122, 'hyperlipidemia',            'ailment'),
  (122, 'liver support',             'ailment'),
  (122, 'bile flow',                 'ailment'),
  (122, 'cardiovascular disease',    'ailment'),
  (122, 'hepatic',                   'action'),
  (122, 'digestive bitter',          'action'),
  (122, 'cholagogue',                'action'),
  (122, 'diuretic',                  'action'),

  -- Gentian: liver/heart bitter
  (102, 'cardiovascular disease',    'ailment'),
  (102, 'liver qi stagnation',       'ailment'),
  (102, 'digestive health',          'ailment'),
  (102, 'bitter tonic',              'action'),
  (102, 'digestive bitter',          'action'),
  (102, 'hepatic',                   'action'),

  -- Cacao: flavanols, CV
  (2749,'cardiovascular disease',    'ailment'),
  (2749,'hypertension',              'ailment'),
  (2749,'hyperlipidemia',            'ailment'),
  (2749,'inflammation',              'ailment'),
  (2749,'shen disturbance',          'ailment'),
  (2749,'anti-platelet',             'action'),
  (2749,'antioxidant',               'action'),
  (2749,'anti-inflammatory',         'action'),
  (2749,'endothelial protective',    'action'),

  -- Garlic: lipids, CV
  (21,  'hyperlipidemia',            'ailment'),
  (21,  'cardiovascular disease',    'ailment'),
  (21,  'hypertension',              'ailment'),
  (21,  'antilipidemic',             'action'),
  (21,  'anti-platelet',             'action'),
  (21,  'antimicrobial',             'action'),

  -- Guggul: lipids, thyroid
  (877, 'hyperlipidemia',            'ailment'),
  (877, 'cardiovascular disease',    'ailment'),
  (877, 'hypothyroidism',            'ailment'),
  (877, 'gout',                      'ailment'),
  (877, 'antilipidemic',             'action'),
  (877, 'thyroid tonic',             'action'),
  (877, 'alterative',                'action'),

  -- Myrrh: lipid/blood cleansing
  (99,  'hyperlipidemia',            'ailment'),
  (99,  'cardiovascular disease',    'ailment'),
  (99,  'antilipidemic',             'action'),
  (99,  'alterative',                'action'),

  -- Motherwort: nervine-cardiac, palpitations
  (131, 'cardiovascular disease',    'ailment'),
  (131, 'palpitations',              'ailment'),
  (131, 'hypertension',              'ailment'),
  (131, 'tachycardia',               'ailment'),
  (131, 'nervine-cardiac',           'action'),
  (131, 'cardiotonic',               'action'),
  (131, 'hypotensive',               'action'),

  -- Linden: yin nourishing, CV nervine
  (90,  'cardiovascular disease',    'ailment'),
  (90,  'hypertension',              'ailment'),
  (90,  'anxiety',                   'ailment'),
  (90,  'yin deficiency',            'ailment'),
  (90,  'nervine',                   'action'),
  (90,  'hypotensive',               'action'),
  (90,  'demulcent',                 'action'),

  -- Reishi Mushroom: adaptogen, CV
  (11,  'cardiovascular disease',    'ailment'),
  (11,  'immune support',            'ailment'),
  (11,  'stress',                    'ailment'),
  (11,  'fatigue',                   'ailment'),
  (11,  'adaptogen',                 'action'),
  (11,  'cardiotonic',               'action'),
  (11,  'immunomodulator',           'action'),

  -- Celery Seed: gout, uric acid, CV
  (66,  'gout',                      'ailment'),
  (66,  'cardiovascular disease',    'ailment'),
  (66,  'hypertension',              'ailment'),
  (66,  'kidney support',            'ailment'),
  (66,  'diuretic',                  'action'),

  -- Pipsissewa: gout, urinary, renal
  (2239,'gout',                      'ailment'),
  (2239,'kidney support',            'ailment'),
  (2239,'urinary tract infection',   'ailment'),
  (2239,'diuretic',                  'action'),
  (2239,'antimicrobial',             'action')

ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Supplement keywords
INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
  -- CoQ10: statin support, mitochondrial, cardiovascular
  (32, 'statin support',          'general'),
  (32, 'cardiovascular disease',  'ailment'),
  (32, 'fatigue',                 'ailment'),
  (32, 'energy support',          'ailment'),

  -- Fish Oils Omega-3: cardiovascular
  (33, 'atherosclerosis',         'ailment'),
  (33, 'hyperlipidemia',          'ailment'),
  (33, 'cardiovascular disease',  'ailment'),
  (33, 'inflammation',            'ailment'),

  -- Vitamin B Complex: homocysteine, methylation
  (49, 'homocysteine elevation',  'ailment'),
  (49, 'cardiovascular disease',  'ailment'),
  (49, 'methylation support',     'action')

ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;

-- Red Yeast Rice supplement keywords (ID resolved dynamically)
DO $$
DECLARE
  v_ryr_id integer;
BEGIN
  SELECT id INTO v_ryr_id FROM herbal.supplements WHERE name = 'Red Yeast Rice';
  INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
    (v_ryr_id, 'hyperlipidemia',       'ailment'),
    (v_ryr_id, 'cardiovascular disease','ailment'),
    (v_ryr_id, 'statin support',       'general')
  ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;
END $$;

-- New ailment search terms
INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('ischemia',
   ARRAY['cardiac ischemia', 'myocardial ischemia', 'coronary ischemia', 'reduced blood flow to heart', 'oxygen deprivation heart']),
  ('homocysteine elevation',
   ARRAY['elevated homocysteine', 'hyperhomocysteinemia', 'methylation dysfunction', 'high homocysteine', 'homocysteine cardiovascular risk']),
  ('yin deficiency',
   ARRAY['heart yin deficiency', 'yin depletion', 'heart feeling vexed', 'deficient heart yin', 'yin vacuity'])
ON CONFLICT (ailment_keyword) DO NOTHING;
