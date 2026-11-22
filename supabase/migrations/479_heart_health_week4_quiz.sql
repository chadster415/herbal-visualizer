-- Migration 479: Herbal Heart Health - Week 4 - Hypertension and Hypotension - Quiz
-- class_name: 'Herbal Heart Health - Week 4 - Hypertension and Hypotension'
--
-- H = 38 distinct herbs/supplements
-- F = 8 named factual items (Mistletoe clinical study, Cochrane/Rauwolfia, Hawthorn-Hibiscus tea recipe,
--     Cardio Calmpound dose, HTN 180 Px formula composition/dose, Gaia formula composition,
--     case study dose adjustment, WHO 1.4B statistic)
-- Target = clamp(15 + 38*4 + 8, 20, 50) = clamp(175, 20, 50) = 50 questions
--
-- Correct option distribution: a=13, b=12, c=12, d=13

SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM herbal.class_quiz_questions
    WHERE class_name = 'Herbal Heart Health - Week 4 - Hypertension and Hypotension'
  ) THEN
    RAISE NOTICE 'Week 4 quiz already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_quiz_questions
    (class_name, question_text, option_a, option_b, option_c, option_d,
     correct_option, explanation, snippet_text, section_header, sort_order)
  VALUES

  -- Q1 (correct=a)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'What makes Dandelion leaf a preferred diuretic choice for hypertension compared to some pharmaceutical diuretics?',
   'It preserves potassium while releasing excess fluid — potassium-sparing action',
   'It is the strongest diuretic in the herbal materia medica',
   'It directly lowers adrenal hormone production',
   'It works through the same mechanism as ACE inhibitors',
   'a',
   'Dandelion leaf is specifically described as potassium-sparing, distinguishing it from pharmaceutical diuretics that deplete potassium alongside fluid.',
   'Dandelion leaf (Taraxacum officinale) is a potassium-sparing diuretic — helps release excess fluid without depleting potassium, unlike some pharmaceutical diuretics. Useful when fluid retention is contributing to elevated blood pressure.',
   'Herbs for Hypertension - Diuretics and Therapeutic Foods', 10),

  -- Q2 (correct=b)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'Celery seed supports healthy blood pressure primarily through which mechanism?',
   'Direct relaxation of arterial smooth muscle',
   'Mild diuretic action via renal and bladder alternative effects on fluid and kidney function',
   'ACE inhibitor analog activity',
   'Blocking adrenergic receptors in the cardiovascular system',
   'b',
   'Celery seed acts as a renal and bladder alternative with mild diuretic properties, supporting blood pressure through its effect on fluid and kidney function rather than direct vascular action.',
   'Celery seed (Apium graveolens) has mild diuretic properties and acts as a renal and bladder alternative, supporting healthy blood pressure through its effect on fluid and kidney function. A useful addition both as a culinary herb and in herbal formulas targeting hypertension with fluid retention.',
   'Herbs for Hypertension - Diuretics and Therapeutic Foods', 20),

  -- Q3 (correct=c)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'Why are garlic''s cardiovascular benefits described as "heat-stable," and what implication does this have for therapeutic use?',
   'Heat activates garlic''s sulfur compounds, making cooked garlic more potent than raw',
   'All of garlic''s therapeutic constituents survive cooking equally well',
   'Cardiovascular compounds survive cooking, unlike its immune-active constituents which require raw garlic — cooked garlic is effective for blood pressure',
   'Cooked garlic contains more allicin than raw, which is the primary cardiovascular compound',
   'c',
   'The notes specifically distinguish heat-stable cardiovascular benefits (cooked garlic works) from immune-active constituents that require raw garlic — an important practical point for prescribing garlic for hypertension.',
   'Garlic (Allium sativum) is powerful kitchen medicine for blood pressure — affordable, accessible, and therapeutically effective; cardiovascular benefits are heat-stable (cooked garlic works), unlike its immune-active constituents (which require raw garlic). Never overlook garlic; supplements are acceptable but whole garlic added generously to food is the ideal form.',
   'Herbs for Hypertension - Diuretics and Therapeutic Foods', 30),

  -- Q4 (correct=d)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'Hibiscus (Hibiscus sabdariffa) is best suited for which pattern of hypertension?',
   'Cold, depleted constitutional types with underlying yin deficiency',
   'Kidney Deficiency with dizziness, fatigue, and fear',
   'Damp Stagnation with edema, heaviness, and foggy-headedness',
   'Hot, fiery, anger-driven or heat-excess patterns of hypertension',
   'd',
   'Hibiscus is sour and cooling, clearing trapped heat — it is specifically suited to hot, fiery, anger-driven or heat-excess patterns, not cold or deficiency patterns.',
   'Hibiscus is sour and cooling, clearing trapped heat — well-established clinically for reducing elevated blood pressure; pairs beautifully with hawthorn in tea. Best suited for the hot, fiery, anger-driven or heat-excess patterns of hypertension.',
   'Hawthorn and Hibiscus for Hypertension', 40),

  -- Q5 (correct=a)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'What energetic paradox makes Hawthorn useful for certain hypertensive patients?',
   'It is warming overall but clears heat from the Heart — useful for people who are cold but have trapped heart heat driving BP up',
   'It is cooling overall but warms the Heart when it detects deficiency',
   'It raises blood pressure in the morning and lowers it at night through circadian modulation',
   'It is both a vasodilator and a vasoconstrictor depending on dose',
   'a',
   'The paradox is that hawthorn''s overall warming nature combined with its ability to clear heart heat makes it useful for patients who are constitutionally cold but have trapped heat — not everyone''s medicine but always worth trying.',
   'Hawthorn is warming overall but clears heat from the Heart — a useful energetic paradox for people who are cold but have trapped heat driving their BP up; sour and sweet in flavor. Rich in flavonoids that nourish endothelial suppleness over the long term; especially helpful when hypertension has an emotional/stress component.',
   'Hawthorn and Hibiscus for Hypertension', 50),

  -- Q6 (correct=b)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'In Liver Yang Rising hypertension, why is heat clearing alone an insufficient treatment strategy?',
   'The liver requires bile-moving herbs before liver heat can be safely cleared',
   'The underlying cause is yin deficiency ("empty heat" or "false heat") — nourishing yin is essential, not just clearing heat',
   'The adrenal glands must be supported before liver heat can be effectively addressed',
   'Heat-clearing herbs are too cooling for most Western constitutions and cause secondary deficiency',
   'b',
   'Liver Yang Rising is "false heat" or "empty heat" — the water element is weak and cannot cool the fire. Nourishing yin must accompany heat clearing, or the treatment addresses symptoms while the root cause continues.',
   'Mulberry bark (Morus alba) clears heat without depleting yin — a key advantage for the already-depleted Liver Yang Rising pattern, where nourishing yin is as important as clearing heat. Indicated when irritability, dizziness, and headache arise from underlying yin deficiency ("false heat" or "empty heat").',
   'Liver Yang Rising', 60),

  -- Q7 (correct=c)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'Which herb clears heat without depleting yin, making it specifically advantageous for the Liver Yang Rising pattern?',
   'Baikal skullcap (Scutellaria baicalensis)',
   'Self-Heal (Prunella vulgaris)',
   'Mulberry bark (Morus alba)',
   'Hibiscus (Hibiscus sabdariffa)',
   'c',
   'Mulberry bark''s key advantage is that it clears heat without depleting yin — particularly important in Liver Yang Rising where yin is already deficient. Baikal skullcap clears Liver Fire (a more excess pattern) and is strongly cooling. Self-Heal addresses anger/irritability but needs yin-nourishing companions.',
   'Mulberry bark (Morus alba) clears heat without depleting yin — a key advantage for the already-depleted Liver Yang Rising pattern, where nourishing yin is as important as clearing heat. Indicated when irritability, dizziness, and headache arise from underlying yin deficiency ("false heat" or "empty heat").',
   'Liver Yang Rising', 70),

  -- Q8 (correct=d)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'What clinical caution must be observed when using Valerian for Liver Yang Rising or tension-driven hypertension?',
   'It significantly raises blood pressure in cold constitutional types',
   'It may cause renal damage with long-term use in hypertensive patients',
   'It should not be combined with any other hypotensive herb due to additive effects',
   'Its effects are variable — sometimes stimulating rather than sedating; introduce slowly and assess each person''s response',
   'd',
   'Valerian can be profound medicine for the right person, but its unpredictable nature requires slow introduction. Some individuals find it stimulating rather than calming — the opposite of what''s needed in hypertension.',
   'Valerian (Valeriana officinalis) can be profound medicine for Liver Yang Rising hypertension when it is the right fit; however, its effects are variable — sometimes stimulating rather than sedating. Introduce slowly and attend carefully to the individual''s response.',
   'Liver Yang Rising', 80),

  -- Q9 (correct=a)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'How is Linden''s therapeutic action in Liver Yang Rising described, and what makes it appropriate when the person is depleted?',
   'It brings the nourishing rain to put out the fire rather than just cooling — moistening and yin-nourishing',
   'It directly clears liver fire with strong bitter action, more aggressively than Chrysanthemum',
   'It sedates the nervous system to reduce stress-driven hypertension without affecting yin',
   'It tonifies kidney yang to support the failing water element in Liver Yang Rising',
   'a',
   'The image of "nourishing rain" captures why Linden is especially suited to depleted patients: it doesn''t just cool, it nourishes. This distinguishes it from more aggressively heat-clearing herbs that could further deplete yin.',
   'Linden (Tilia spp.) is moistening, yin-nourishing, and sweet — brings the nourishing rain to put out the fire rather than just cooling; ideal companion when the person is depleted. Rich uses linden as a primary herb for some clients with hypertension; works best as a tea; gentle enough to enjoy daily.',
   'Liver Yang Rising', 90),

  -- Q10 (correct=b)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'What fundamentally distinguishes Liver Fire from Liver Yang Rising as TCM patterns in hypertension?',
   'Liver Fire involves fear; Liver Yang Rising involves anger as the primary emotional driver',
   'Liver Fire is a more severe true excess condition requiring more aggressive cooling; Liver Yang Rising involves an underlying yin deficiency',
   'Liver Yang Rising involves kidney depletion; Liver Fire does not involve kidney pathology',
   'Liver Fire is a deficiency pattern; Liver Yang Rising is a pure excess pattern',
   'b',
   'Liver Yang Rising is "false heat" from yin deficiency — it has a deficiency root. Liver Fire is a true excess condition, hotter and more severe, requiring more overtly bitter, cooling herbs without the same concern about depleting yin.',
   'Baikal skullcap (Scutellaria baicalensis) — Huang Qin in Chinese medicine — clears Liver Fire with strongly cooling and bitter energy. Distinct from North American skullcap (Scutellaria lateriflora), which is a nervine used very differently. Specifically indicated for the Liver Fire pattern: red tongue with red sides and yellow coating, rapid wiry pulse.',
   'Liver Fire', 100),

  -- Q11 (correct=c)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'Which tongue and pulse presentation confirms the Liver Fire pattern of hypertension?',
   'Pale, swollen tongue with toothmarks; slippery pulse',
   'Dry, cracked red tongue; floating pulse',
   'Red tongue with red sides and yellow coating; rapid wiry pulse',
   'Purplish tongue; knotted/choppy pulse',
   'c',
   'The Liver Fire presentation is specifically a red tongue with red sides (indicating liver heat) and yellow coating (indicating heat), paired with a rapid wiry pulse. The other options describe Damp Stagnation (a), Liver Yang Rising (b), and Blood Stasis (d).',
   'Baikal skullcap (Scutellaria baicalensis) — Huang Qin in Chinese medicine — clears Liver Fire with strongly cooling and bitter energy. Distinct from North American skullcap (Scutellaria lateriflora), which is a nervine used very differently. Specifically indicated for the Liver Fire pattern: red tongue with red sides and yellow coating, rapid wiry pulse.',
   'Liver Fire', 110),

  -- Q12 (correct=d)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'In the Blood Stasis/Congealed Heart Blood pattern of hypertension, what is the primary therapeutic goal?',
   'Nourishing yin to cool the rising yang fire',
   'Clearing phlegm-damp from the spleen to reduce fluid-driven pressure',
   'Tonifying kidney essence to anchor the floating blood',
   'Moving the blood to relieve the obstruction that creates upstream pressure',
   'd',
   'The blood stasis model is a dam obstructing blood flow — increased pressure upstream results from the obstruction. Moving the blood to remove the dam is the core treatment strategy, distinct from pattern approaches focused on cooling, tonifying, or clearing dampness.',
   'Dang Gui (Angelica sinensis) moves the blood and can lower BP in the Blood Stasis/Congealed Heart Blood pattern of hypertension (stabbing headache, chest pain/angina, purplish tongue, knotted/choppy pulse). CAUTION: Avoid all blood-moving herbs with anticoagulant drugs (warfarin, aspirin therapy, etc.).',
   'Blood Stasis', 120),

  -- Q13 (correct=a)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'Which tongue finding is characteristic of Blood Stasis hypertension?',
   'Purplish tongue',
   'Red tongue with yellow coating',
   'Pale, swollen tongue with toothmarks',
   'Dry, cracked red tongue',
   'a',
   'Purplish tongue indicates blood stasis and poor circulation. The other options represent Liver Fire (b), Damp Stagnation (c), and Liver Yang Rising (d) — pattern differentiation through tongue observation is central to TCM hypertension assessment.',
   'Dang Gui (Angelica sinensis) moves the blood and can lower BP in the Blood Stasis/Congealed Heart Blood pattern of hypertension (stabbing headache, chest pain/angina, purplish tongue, knotted/choppy pulse). CAUTION: Avoid all blood-moving herbs with anticoagulant drugs (warfarin, aspirin therapy, etc.).',
   'Blood Stasis', 130),

  -- Q14 (correct=b)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'Why must all blood-moving herbs be avoided with anticoagulant drugs?',
   'Blood-moving herbs reduce the effectiveness of warfarin by competing for binding sites',
   'Combining blood-moving herbs with warfarin or aspirin therapy can cause excessive blood thinning',
   'Blood-moving herbs raise blood pressure when combined with anticoagulant medications',
   'Blood-moving herbs cause liver toxicity when combined with aspirin therapy',
   'b',
   'The concern is additive anticoagulant effect — blood-moving herbs that have anti-platelet or anticoagulant properties amplify the effect of pharmaceutical anticoagulants, increasing bleeding risk.',
   'Dang Gui (Angelica sinensis) moves the blood and can lower BP in the Blood Stasis/Congealed Heart Blood pattern of hypertension (stabbing headache, chest pain/angina, purplish tongue, knotted/choppy pulse). CAUTION: Avoid all blood-moving herbs with anticoagulant drugs (warfarin, aspirin therapy, etc.).',
   'Blood Stasis', 140),

  -- Q15 (correct=c)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'What additional caution applies specifically to Ginkgo when used in blood pressure treatment?',
   'Ginkgo raises blood pressure in Liver Fire patterns due to its warming action',
   'Ginkgo must not be combined with Dang Gui due to synergistic toxicity',
   'Ginkgo has been seen to lower already-low blood pressure in some people — monitor carefully',
   'Ginkgo is contraindicated in all patterns of hypertension except Blood Stasis',
   'c',
   'Beyond the standard blood-moving herb anticoagulant caution, Ginkgo has a unique additional concern: it can lower BP to hypotensive levels in some individuals, requiring careful BP monitoring.',
   'Ginkgo (Ginkgo biloba) moves the blood and can lower BP in Blood Stasis hypertension. Important caution: Ginkgo has been seen to lower already-low BP in some people — monitor carefully. Avoid with anticoagulant drugs (warfarin, aspirin therapy).',
   'Blood Stasis', 150),

  -- Q16 (correct=d)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'Which group of herbs is specifically indicated for the Kidney Deficiency pattern of hypertension?',
   'Baikal skullcap, Chrysanthemum, Mulberry bark, Hibiscus',
   'Motherwort, Wood Betony, Black Haw, Cramp Bark',
   'Poria, Elecampane, Schisandra, Dandelion leaf',
   'Cordyceps, Goji, Schisandra, Milky Oats',
   'd',
   'The Kidney Deficiency herbs are tonifying and gently warming, nourishing the deep essence — Cordyceps, Goji, Schisandra, and Milky Oats. The other groups address Liver Fire (a), tension (b), and Damp Stagnation (c).',
   'Cordyceps is tonifying and gently warming for the Kidney Deficiency pattern in hypertension, nourishing the deep essence. Signs of Kidney Deficiency driving hypertension: dizziness, fatigue, fear; differentiate between Kidney Yin and Yang depletion (both can be depleted simultaneously).',
   'Kidney Deficiency', 160),

  -- Q17 (correct=a)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'What pulse presentation is associated with the Damp Stagnation pattern of hypertension?',
   'Slippery pulse',
   'Rapid and wiry pulse',
   'Knotted/choppy pulse',
   'Floating pulse',
   'a',
   'Slippery pulse reflects the fluid and phlegm-damp accumulation characteristic of Damp Stagnation. Rapid wiry = Liver Fire; knotted/choppy = Blood Stasis; floating = Liver Yang Rising.',
   'Poria (Wolfporia extensa) supports spleen/earth function and fluid regulation in the Damp Stagnation pattern of hypertension. This pattern presents with heaviness, nausea, bloating, edema, foggy-headedness, pale swollen tongue with toothmarks, slippery pulse. Approach: warming and moving, not cooling.',
   'Damp Stagnation', 170),

  -- Q18 (correct=b)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'What is the distinctive mechanism that makes Rauwolfia different from most other hypotensive herbs?',
   'It directly dilates blood vessels by blocking calcium channels, similar to pharmaceutical CCBs',
   'It influences neurotransmitters that reduce sympathetic nervous system tone',
   'It inhibits the renin-angiotensin system in the kidneys',
   'It has strong potassium-sparing diuretic action comparable to spironolactone',
   'b',
   'Rauwolfia''s reserpine acts on neurotransmitter pathways to reduce SNS tone — a unique mechanism that makes it effective when pattern-matched herbs haven''t been sufficient and that parallels how some pharmaceutical antihypertensives work.',
   'Rauwolfia (Rauvolfia serpentina) is bitter, cooling, and calming — works via a different mechanism than other hypotensive herbs, influencing neurotransmitters that reduce sympathetic nervous system tone. Cochrane review: reserpine (its active alkaloid) reduces systolic BP to roughly the same degree as other first-line antihypertensive drugs (Shamon & Perez, Cochrane 2016).',
   'Olive Leaf, Mistletoe, and Rauwolfia for Hypertension', 180),

  -- Q19 (correct=c)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'Olive leaf is specifically noted as well suited when hypertension is accompanied by what other condition?',
   'Kidney Deficiency with fatigue and fear',
   'Liver Fire with red tongue and rapid wiry pulse',
   'Atherosclerosis',
   'Damp Stagnation with edema and slippery pulse',
   'c',
   'Olive leaf has significant scientific support for reducing blood pressure, and this evidence is specifically strong when atherosclerosis co-exists — making it a good fit for the cardiovascular disease patient who also has hypertension.',
   'Olive leaf (Olea europaea) is bitter, cooling, and drying with significant science behind it for reducing blood pressure, especially when atherosclerosis is also present. The leaf is the medicinal part — distinct from the nutritious olive fruit and oil. Pairs well with herbs addressing accompanying heart disease.',
   'Olive Leaf, Mistletoe, and Rauwolfia for Hypertension', 190),

  -- Q20 (correct=d)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'What energetic quality makes Chrysanthemum Flower particularly advantageous for Liver Yang Rising compared to other heat-clearing herbs?',
   'It is warming and drying, addressing the cold damp underlying the pattern',
   'It is aggressively cooling and drying, clearing heat more forcefully',
   'It is astringent, anchoring the floating yang energy downward',
   'It is moistening, cooling, sweet and bitter — clears heat without depleting yin, unlike purely drying cold herbs',
   'd',
   'The key advantage is that Chrysanthemum clears heat while also moistening — it does not deplete yin, unlike purely drying cold herbs that might further exhaust the already-depleted yin in Liver Yang Rising.',
   'Chrysanthemum flower is moistening, cooling, sweet and bitter — clears Liver Yang and heat from frustration/anger without depleting yin (key advantage over purely drying cold herbs). Widely consumed as everyday tea in Asia; clinically useful for pulling liver yang energy downward when there is heat, irritability, and rising blood pressure.',
   'Liver Yang Rising', 200),

  -- Q21 (correct=a)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'What were the specific blood pressure results of the Mistletoe (Viscum album) clinical study after 12 weeks?',
   'Systolic dropped from 155.8 to 141.5 mmHg (-14 points, p<0.0001); diastolic from 84.4 to 79.5 mmHg (-5 points, p=0.00177)',
   'Systolic dropped from 165 to 148 mmHg; diastolic remained unchanged',
   'Systolic dropped 8 points; insufficient evidence for clinical significance',
   'Systolic dropped from 148 to 130 mmHg; diastolic from 95 to 80 mmHg',
   'a',
   'The 14-point systolic drop is clinically meaningful and highly statistically significant (p<0.0001). This can move someone from Stage 2 hypertension into a significantly safer range from a single herb — important evidence for Mistletoe''s clinical use.',
   'Mistletoe (Viscum album) is cooling, neutral, and bitter — helpful for Liver Fire and Liver Yang Rising patterns of hypertension; best combined with yin-nourishing herbs when yin depletion is present. Clinical study: after 12 weeks, systolic dropped from 155.8 to 141.5 mmHg (-14 points, p<0.0001); diastolic from 84.4 to 79.5 mmHg (-5 points, p=0.00177) (Poruthukaren et al., JACAM 2014).',
   'Olive Leaf, Mistletoe, and Rauwolfia for Hypertension', 210),

  -- Q22 (correct=b)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'What did the Cochrane review conclude about reserpine from Rauwolfia for blood pressure?',
   'It is significantly more effective than first-line antihypertensive drugs but with a higher side effect burden',
   'It is effective in reducing systolic blood pressure to roughly the same degree as other first-line antihypertensive drugs',
   'It is inferior to first-line drugs but useful when pharmaceutical side effects are intolerable',
   'The evidence is insufficient to make a clinical recommendation',
   'b',
   'The Cochrane finding is clinically important: reserpine performs comparably to other first-line antihypertensives. This validates Rauwolfia as a serious clinical option, not just a traditional remedy.',
   'Rauwolfia (Rauvolfia serpentina) is bitter, cooling, and calming — works via a different mechanism than other hypotensive herbs, influencing neurotransmitters that reduce sympathetic nervous system tone. Cochrane review: reserpine (its active alkaloid) reduces systolic BP to roughly the same degree as other first-line antihypertensive drugs (Shamon & Perez, Cochrane 2016).',
   'Olive Leaf, Mistletoe, and Rauwolfia for Hypertension', 220),

  -- Q23 (correct=c)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'Which herbs are in David Winston''s Cardio Calmpound tincture?',
   'Hawthorn, Hibiscus, Motherwort, Rauwolfia, Passionflower',
   'Linden, Olive leaf, Mistletoe, Valerian, Cramp Bark',
   'Hawthorn, Linden, Motherwort, Olive leaf, Mistletoe',
   'Hawthorn, Dan Shen, Mistletoe, Motherwort, California Poppy',
   'c',
   'Cardio Calmpound combines heat-clearing (Mistletoe, Olive leaf), yin-nourishing (Linden), tension-relieving (Motherwort), and endothelial-supporting (Hawthorn) herbs. Rich uses it as a starting formula at 60 drops 2-3x/day.',
   'Hawthorn leaf, flower, and berry (Crataegus spp.) is a core ingredient in Rich''s clinical formulas for hypertension: Cardio Calmpound (Herbalists & Alchemists, 60 drops 2-3x/day — a good starting formula combining heat-clearing, yin-nourishing, tension-relieving, and endothelial-supporting herbs) and HTN 180 Px (100mg per capsule).',
   'Clinical Formulas for Hypertension', 230),

  -- Q24 (correct=d)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'What is the starting dose for HTN 180 Px formula, and what is the likely key differentiating ingredient?',
   '2 capsules twice daily; key ingredient is Olive leaf',
   '1 capsule 3x/day; key ingredient is Passionflower for nervous system calming',
   '60 drops 2-3x/day; key ingredient is Dan Shen for blood stasis',
   '1 capsule 3x/day; key ingredient is Rauwolfia targeting neurotransmitter/SNS pathways',
   'd',
   'HTN 180 Px is Rich''s go-to when other approaches haven''t worked. The Rauwolfia''s neurotransmitter/SNS mechanism is the differentiating factor compared to pattern-matched herbs. Starting dose: 1 capsule 3x/day.',
   'Passionflower (Passiflora incarnata) is an ingredient in Restorative Formulations HTN 180 Px (100mg per capsule), Rich''s go-to formula when other hypertension approaches have not been sufficient. Start at 1 capsule 3x/day; reduces to 2 capsules/day if BP comes down too far.',
   'Clinical Formulas for Hypertension', 240),

  -- Q25 (correct=a)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'Why is whole licorice (Glycyrrhiza glabra) contraindicated in hypertension?',
   'Glycyrrhizin influences cortisol and aldosterone, causing sodium and fluid retention that raises blood pressure',
   'It stimulates the adrenal medulla, increasing epinephrine and norepinephrine output',
   'It directly activates adrenergic receptors in the heart, increasing cardiac output',
   'It contains vasoconstrictive alkaloids structurally similar to ephedrine',
   'a',
   'The glycyrrhizin mechanism is specific: it acts on cortisol/aldosterone pathways to cause sodium retention — the same mechanism that can raise BP in hypertension becomes beneficial in hypotension (see Q28).',
   'Whole licorice (Glycyrrhiza glabra) is CONTRAINDICATED in hypertension — glycyrrhizin influences cortisol and aldosterone, causing sodium and fluid retention that can raise BP. Avoid in anyone prone to high blood pressure. DGL (deglycyrrhizinated licorice) removes the glycyrrhizin and is safe for gut issues in hypertensive patients, but loses the adaptogenic/adrenal support properties of whole licorice.',
   'Safety - Herbs to Avoid in Hypertension', 250),

  -- Q26 (correct=b)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'What is the key distinction between DGL and whole licorice for a hypertensive patient who also has gut issues?',
   'DGL is more effective at raising blood pressure but safer for the gut',
   'DGL removes glycyrrhizin and is safe for gut issues, but loses the adaptogenic/adrenal support properties of whole licorice',
   'DGL retains all adaptogenic benefits while eliminating the digestive side effects',
   'DGL can be used to treat both hypertension and hypotension safely',
   'b',
   'DGL offers a clinically useful tradeoff: safe for gut issues in hypertensive patients, but the removal of glycyrrhizin also removes the adaptogenic properties that make whole licorice therapeutically unique.',
   'Whole licorice (Glycyrrhiza glabra) is CONTRAINDICATED in hypertension — glycyrrhizin influences cortisol and aldosterone, causing sodium and fluid retention that can raise BP. Avoid in anyone prone to high blood pressure. DGL (deglycyrrhizinated licorice) removes the glycyrrhizin and is safe for gut issues in hypertensive patients, but loses the adaptogenic/adrenal support properties of whole licorice.',
   'Safety - Herbs to Avoid in Hypertension', 260),

  -- Q27 (correct=c)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'Which herbs are specifically listed as ones to avoid in hypertensive clients because they can raise blood pressure?',
   'Motherwort and Wood Betony',
   'Valerian and Linden',
   'Ginseng and Rhodiola',
   'Mistletoe and Olive leaf',
   'c',
   'Ginseng and Rhodiola are described as "overly stimulating" herbs that can raise blood pressure in some people. This is an important safety consideration when clients are taking adaptogens for other reasons alongside hypertension treatment.',
   'Ginseng (Panax ginseng) is an overly stimulating herb that can raise blood pressure in some people and should be avoided in hypertensive clients unless carefully monitored. Even herbs that only mildly affect blood pressure in most people may have a stronger impact in some individuals.',
   'Safety - Herbs to Avoid in Hypertension', 270),

  -- Q28 (correct=d)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'Which herb has an opposite application in hypotension versus hypertension?',
   'Rauwolfia is vasodilatory in hypertension but vasoconstrictive in hypotension',
   'Hibiscus raises blood pressure in cold constitutions but lowers it in hot constitutions',
   'Ginkgo is used for high blood pressure but avoided in low blood pressure in all cases',
   'Licorice is contraindicated in hypertension but helpful in hypotension',
   'd',
   'The same glycyrrhizin mechanism that makes licorice dangerous in hypertension (sodium/fluid retention raising BP) becomes therapeutic in hypotension. This is a clinically elegant example of an herb used for opposite conditions through the same mechanism.',
   'Licorice (Glycyrrhiza glabra) can actually HELP in hypotension — the same cortisol/aldosterone mechanism that raises BP in hypertensive patients becomes beneficial for raising low blood pressure. Also: hydrate with mineral-rich sea salts and electrolytes.',
   'Hypotension Treatment', 280),

  -- Q29 (correct=a)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'Baikal skullcap (Scutellaria baicalensis) must be distinguished from which herb that serves a very different function?',
   'North American skullcap (Scutellaria lateriflora), which is a nervine used very differently from the Liver Fire herb',
   'Chinese skullcap (Scutellaria chinensis), which is used for kidney support',
   'Himalayan skullcap (Scutellaria indica), which is used for sleep support',
   'Yellow skullcap (Scutellaria integrifolia), which is used for pain management',
   'a',
   'Baikal skullcap is a Liver Fire herb — strongly cooling, bitter, specifically for the heat-excess pattern. North American skullcap is a nervine with relaxing properties used for anxiety, nervous system support, and tension. Confusing the two would lead to significantly wrong prescribing.',
   'Baikal skullcap (Scutellaria baicalensis) — Huang Qin in Chinese medicine — clears Liver Fire with strongly cooling and bitter energy. Distinct from North American skullcap (Scutellaria lateriflora), which is a nervine used very differently. Specifically indicated for the Liver Fire pattern: red tongue with red sides and yellow coating, rapid wiry pulse.',
   'Liver Fire', 290),

  -- Q30 (correct=b)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'Which ingredient in the Gaia Vascular Endothelial Complex is noted specifically for its Oleuropein content?',
   'Pomegranate fruit extract 350mg',
   'Olive leaf extract 185mg (Oleuropein 70mg)',
   'Grape seed extract from the Harmonizing Blend',
   'Holy Basil from the Harmonizing Blend',
   'b',
   'Oleuropein is the key active compound in Olive leaf with established blood pressure research. The formula specifies 185mg Olive leaf with 70mg Oleuropein — a clinically meaningful standardization.',
   'Grape seed extract is part of the Harmonizing Blend (100mg) in Gaia Herbs PRO Vascular Endothelial Complex for blood pressure support, combined with Hibiscus and Holy Basil. This formula also contains Pomegranate 350mg and Olive leaf 185mg (Oleuropein 70mg).',
   'Clinical Formulas for Hypertension', 300),

  -- Q31 (correct=c)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'Which pattern signs distinguish Kidney Deficiency hypertension from Liver Yang Rising?',
   'Anger, irritability, and floating pulse',
   'Stabbing headache, purplish tongue, and knotted pulse',
   'Dizziness, fatigue, and fear',
   'Heaviness, edema, foggy-headedness, and slippery pulse',
   'c',
   'Kidney Deficiency manifests as dizziness, fatigue, and fear (the kidney''s associated emotion in Five Elements). It may overlap with Liver Yang Rising (which also has yin deficiency) but the fatigue and fear are distinctive. Option d is Damp Stagnation, b is Blood Stasis.',
   'Cordyceps is tonifying and gently warming for the Kidney Deficiency pattern in hypertension, nourishing the deep essence. Signs of Kidney Deficiency driving hypertension: dizziness, fatigue, fear; differentiate between Kidney Yin and Yang depletion (both can be depleted simultaneously).',
   'Kidney Deficiency', 310),

  -- Q32 (correct=d)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'Why does Poria appear in both the diuretics section and the Damp Stagnation treatment of hypertension?',
   'Different Poria species are used for each indication — cocos for diuresis, extensa for damp stagnation',
   'Low doses act as a diuretic; high doses address damp stagnation through a different mechanism',
   'Poria in the diuretics section is the fruiting body; in damp stagnation it is the sclerotium',
   'The same spleen/earth fluid-regulating action addresses both fluid retention in general and the Damp Stagnation pattern specifically',
   'd',
   'Poria''s core action is supporting spleen/earth function and fluid regulation — this single mechanism is what makes it useful both as a mild diuretic in general hypertension and as a primary herb for the Damp Stagnation pattern.',
   'Poria (Wolfporia extensa) supports spleen/earth function and fluid regulation in the Damp Stagnation pattern of hypertension. This pattern presents with heaviness, nausea, bloating, edema, foggy-headedness, pale swollen tongue with toothmarks, slippery pulse. Approach: warming and moving, not cooling.',
   'Damp Stagnation', 320),

  -- Q33 (correct=a)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'What is California Poppy''s primary role in Rich''s clinical practice?',
   'Sleep quality — his most-used herb for sleep, used in the evenings or for middle-of-night waking',
   'Liver Fire hypertension with anger and intense heat signs',
   'Blood Stasis with purplish tongue and stabbing headache',
   'Daytime nervous system support building over weeks for SNS regulation',
   'a',
   'California Poppy is specifically identified as Rich''s most-used sleep herb. Option d describes Ashwagandha''s role, which complements California Poppy in the case study.',
   'California Poppy (Eschscholzia californica) is Rich''s most-used herb for sleep quality — used in the evenings or for middle-of-night waking. Added to this case study client''s protocol after initial hypertension treatment wasn''t sufficient; combined with ashwagandha (daytime) and HTN 180 Px. Result: BP came down to healthy ranges (107/66, 115/73, etc.).',
   'Case Study - Sleep and Nervous System Support', 330),

  -- Q34 (correct=b)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'How does Ashwagandha complement California Poppy in the case study sleep support strategy?',
   'Ashwagandha provides direct sedation while California Poppy improves sleep architecture',
   'Ashwagandha addresses daytime SNS tone building over weeks; California Poppy addresses sleep directly in the evenings',
   'Ashwagandha blocks cortisol spikes while California Poppy activates GABA receptors at night',
   'Ashwagandha is used in the evenings for relaxation; California Poppy is used in the morning to prevent anticipatory anxiety',
   'b',
   'The strategy pairs a slow-building daytime tonic (Ashwagandha for ANS/SNS regulation over weeks) with an evening sleep herb (California Poppy for immediate sleep quality). Both acting together address root and branch of the sleep-hypertension connection.',
   'Ashwagandha (Withania somnifera) was used throughout the day in this case study for autonomic nervous system (ANS) health, with effects building over weeks. Ashwagandha addresses daytime SNS tone to support better sleep overall, complementing California Poppy''s direct sleep action in the evenings.',
   'Case Study - Sleep and Nervous System Support', 340),

  -- Q35 (correct=c)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'Why was the case study client''s initial herbal protocol considered insufficient?',
   'The herbs caused unacceptable side effects including elevated liver enzymes',
   'The herbs interfered with his statin medication requiring discontinuation',
   'Initial outcomes were not impressive enough for a client who needed to effectively replace Olmesartan',
   'The herbs worsened his blood stasis pattern and increased tongue purpleness',
   'c',
   'The clinical bar was high: the client had tried Olmesartan (an angiotensin II receptor blocker) and couldn''t tolerate its side effects. The herbs needed to be effective enough to do that job without the intolerable side effects.',
   'California Poppy (Eschscholzia californica) is Rich''s most-used herb for sleep quality — used in the evenings or for middle-of-night waking. Added to this case study client''s protocol after initial hypertension treatment wasn''t sufficient; combined with ashwagandha (daytime) and HTN 180 Px. Result: BP came down to healthy ranges (107/66, 115/73, etc.).',
   'Case Study - Sleep and Nervous System Support', 350),

  -- Q36 (correct=d)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'What evidence confirmed that the herbs were doing the therapeutic work in the long-term case study outcome?',
   'His cholesterol levels normalized in parallel with BP improvement while taking the formula',
   'His physician confirmed the herbs were as effective as Olmesartan in a comparison period',
   'His sleep quality scores improved on a validated assessment tool during the herbal protocol',
   'When he neglected taking his herbs, his BP went back up — confirming the herbs were the active agent',
   'd',
   'This is a natural N-of-1 experiment: the herbs were doing the work because BP rose when they were stopped and fell when they were resumed. This also supports the long-term self-managed dosing strategy.',
   'California Poppy (Eschscholzia californica) is Rich''s most-used herb for sleep quality — used in the evenings or for middle-of-night waking. Added to this case study client''s protocol after initial hypertension treatment wasn''t sufficient; combined with ashwagandha (daytime) and HTN 180 Px. Result: BP came down to healthy ranges (107/66, 115/73, etc.).',
   'Case Study - Sleep and Nervous System Support', 360),

  -- Q37 (correct=a)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'Which Five Elements relationship explains how both Kidney and Liver patterns drive hypertension?',
   'Weak Kidneys (water) fail to regulate Heart (fire); Liver (wood) in excess fuels the Heart fire — both patterns raise BP',
   'Excess Kidney energy (water) floods the Heart and raises blood pressure through fluid overload',
   'Heart (fire) overheats the Liver (wood), which then depletes Kidney (water) in a vicious cycle',
   'Liver (wood) produces too much heat; Kidneys (water) cannot absorb the excess heat fast enough',
   'a',
   'The key mechanism: Kidneys (water) normally regulate Heart (fire) in the ke (control) cycle. When Kidneys are weak, they fail to control Heart fire, raising BP. Simultaneously, excess Liver (wood) feeds Heart fire (wood feeds fire in the sheng/generation cycle), making BP worse.',
   'Linden (Tilia spp.) is moistening, yin-nourishing, and sweet — brings the nourishing rain to put out the fire rather than just cooling; ideal companion when the person is depleted. Rich uses linden as a primary herb for some clients with hypertension; works best as a tea; gentle enough to enjoy daily.',
   'Liver Yang Rising', 370),

  -- Q38 (correct=b)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'Motherwort, Wood Betony, and Valerian are grouped together because they all address which driver of hypertension?',
   'Liver Fire with excess anger and heat that requires aggressive cooling',
   'Tension-driven hypertension when emotional distress physically manifests as tension in the body',
   'Damp Stagnation with spleen deficiency and fluid accumulation',
   'Kidney Deficiency with constitutional weakness and deep fatigue',
   'b',
   'The clinical question that guides this group is "How does your emotional distress manifest in your body, and where does it feel like tension?" This is a distinct assessment approach from TCM pattern identification.',
   'Motherwort (Leonurus cardiaca) addresses tension-driven hypertension, especially when emotional distress physically manifests as tension in the body. Key clinical question: "How does your emotional distress manifest in your body, and where does it feel like tension?"',
   'Tension-Driven Hypertension', 380),

  -- Q39 (correct=c)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'Black Haw and Cramp Bark address hypertension through which mechanism?',
   'Clearing heat and nourishing yin for the Liver Yang Rising pattern',
   'Tonifying kidney essence to anchor the rising yang and stabilize BP',
   'Relaxing tension in blood vessels and smooth muscle throughout the body, including vascular walls',
   'Moving blood to relieve the obstruction-driven pressure of Blood Stasis',
   'c',
   'Black Haw and Cramp Bark are vascular antispasmodics — they specifically address tension in vascular smooth muscle as a driver of elevated blood pressure, independent of emotional or TCM pattern considerations.',
   'Black Haw (Viburnum prunifolium) relaxes and relieves tension in blood vessels and smooth muscle throughout the body, including vascular walls. Useful when tension is a primary driver of elevated blood pressure, independent of emotional pattern.',
   'Tension-Driven Hypertension', 390),

  -- Q40 (correct=d)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'Mistletoe is described as helpful for which TCM hypertension patterns?',
   'Damp Stagnation and Kidney Deficiency',
   'Blood Stasis and Kidney Deficiency',
   'Damp Stagnation and Blood Stasis',
   'Liver Fire and Liver Yang Rising',
   'd',
   'Mistletoe''s cooling, bitter nature makes it appropriate for the heat patterns — Liver Fire (true excess heat) and Liver Yang Rising (false heat from yin deficiency). It needs yin-nourishing companions in the latter case. It is not indicated for cold/damp or deficiency patterns.',
   'Mistletoe (Viscum album) is cooling, neutral, and bitter — helpful for Liver Fire and Liver Yang Rising patterns of hypertension; best combined with yin-nourishing herbs when yin depletion is present. Clinical study: after 12 weeks, systolic dropped from 155.8 to 141.5 mmHg (-14 points, p<0.0001); diastolic from 84.4 to 79.5 mmHg (-5 points, p=0.00177) (Poruthukaren et al., JACAM 2014).',
   'Olive Leaf, Mistletoe, and Rauwolfia for Hypertension', 400),

  -- Q41 (correct=a)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'What is the clinical significance of Poria''s "earth-element/spleen focus" in its diuretic action?',
   'It addresses fluid regulation through spleen/earth function rather than purely renal mechanisms — appropriate when spleen-earth disharmony drives fluid retention',
   'It prevents potassium loss from diuresis, unlike pharmaceutical diuretics',
   'It is more potent than Dandelion leaf for all types of hypertension-related edema',
   'It prevents the sodium and fluid retention associated with licorice use',
   'a',
   'Poria''s mechanism is specifically through the spleen/earth element — it is not primarily a kidney-acting diuretic like Dandelion leaf. This distinction matters for TCM-informed prescribing: use Poria when the earth element is the focus; Dandelion leaf when kidney/fluid is the primary driver.',
   'Poria (Wolfporia cocos) supports fluid regulation with an earth-element/spleen focus. Used as a mild diuretic for hypertension when spleen-earth disharmony drives fluid retention.',
   'Herbs for Hypertension - Diuretics and Therapeutic Foods', 410),

  -- Q42 (correct=b)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'What three herbs make up the "Harmonizing Blend" in the Gaia Herbs PRO Vascular Endothelial Complex?',
   'Hawthorn, Linden, and Motherwort',
   'Hibiscus, Holy Basil, and Grape seed extract',
   'Mistletoe, Olive leaf, and Passionflower',
   'Rauwolfia, Motherwort, and Passionflower',
   'b',
   'The Harmonizing Blend is 100mg of Hibiscus, Holy Basil, and Grape seed extract combined, sitting alongside the main BP ingredients Pomegranate 350mg and Olive leaf 185mg. This formula is noted as useful for clients who prefer capsules.',
   'Grape seed extract is part of the Harmonizing Blend (100mg) in Gaia Herbs PRO Vascular Endothelial Complex for blood pressure support, combined with Hibiscus and Holy Basil. This formula also contains Pomegranate 350mg and Olive leaf 185mg (Oleuropein 70mg).',
   'Clinical Formulas for Hypertension', 420),

  -- Q43 (correct=c)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'What side effect required dose reduction in the case study, and how was it managed?',
   'Elevated BP spikes from too-rapid dose increase; dose was split across more daily administrations',
   'Nausea and GI upset from the tincture alcohol; herbs were switched to encapsulated extracts',
   'Dizziness, lightheadedness, and orthostatic hypotension; HTN 180 reduced to 2 capsules/day, tincture to 40 drops (2ml) 3x/day',
   'Excessive fatigue and brain fog; ashwagandha was discontinued and California Poppy was reduced',
   'c',
   'Success brought its own problem: the herbs worked so well that BP fell too far, causing orthostatic hypotension. The solution was dose reduction rather than discontinuation, with minerals/electrolytes added to support vascular tone.',
   'Ashwagandha (Withania somnifera) was used throughout the day in this case study for autonomic nervous system (ANS) health, with effects building over weeks. Ashwagandha addresses daytime SNS tone to support better sleep overall, complementing California Poppy''s direct sleep action in the evenings.',
   'Case Study - Sleep and Nervous System Support', 430),

  -- Q44 (correct=d)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'What is Horse Chestnut''s specific role in hypotension treatment?',
   'As a potent vasodilator to redistribute blood volume toward the periphery',
   'To tonify kidney yang and address the underlying blood deficiency driving hypotension',
   'As a diuretic to manage fluid shifts associated with postural hypotension',
   'To promote vascular integrity alongside mineral-rich hydration and flavonoid-rich foods',
   'd',
   'Horse Chestnut supports vascular tone and integrity — appropriate for hypotension where vascular weakness or insufficiency is a factor. It works alongside electrolyte and mineral support, not as a vasodilator.',
   'Horse Chestnut (Aesculus hippocastanum) promotes vascular integrity and is recommended for hypotension treatment alongside mineral-rich hydration and flavonoid-rich foods.',
   'Hypotension Treatment', 440),

  -- Q45 (correct=a)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'What important caveat applies to circulatory herbs when treating hypotension?',
   'Some circulatory herbs (like Ginkgo) can lower BP further in some people — promote circulation with caution',
   'All circulatory herbs are contraindicated in hypotension as they may cause vasodilation',
   'Circulatory herbs must always be combined with pharmaceutical vasoconstrictors to be safe',
   'Circulatory herbs cause dangerous electrolyte imbalances in hypotensive patients',
   'a',
   'Ginkgo is specifically named as a circulatory herb that can further lower already-low BP. Rosemary, by contrast, is noted as often helpful. The principle is individualized assessment, not blanket avoidance.',
   'Rosemary (Rosmarinus officinalis) is often helpful for circulation in hypotension. Note: promote circulation with caution — some circulatory herbs (like Ginkgo) can lower BP further in some people. Rosemary is a generally safe first choice for hypotension.',
   'Hypotension Treatment', 450),

  -- Q46 (correct=b)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'Self-Heal is said to need "yin-nourishing companions" when used for Liver Yang Rising. Why?',
   'Self-Heal strongly tonifies kidney yin and needs liver-heat herbs to prevent excess cooling',
   'Self-Heal is excellent for the anger/irritability surface presentation but needs companions to address the underlying yin deficiency',
   'Self-Heal clears damp stagnation but causes dryness that must be counteracted by yin-nourishing herbs',
   'Self-Heal moves blood and needs yin support to prevent the qi deficiency that follows blood movement',
   'b',
   'Self-Heal addresses the branch (anger/irritability) in Liver Yang Rising but not the root (yin deficiency). Without yin-nourishing companions, the treatment clears the false heat without addressing why the fire keeps rising.',
   'Self-Heal (Prunella vulgaris) is excellent for anger and irritability in the Liver Yang Rising pattern of hypertension, but needs yin-nourishing companions to address the underlying yin deficiency driving the false heat.',
   'Liver Yang Rising', 460),

  -- Q47 (correct=c)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'What type of headache is characteristic of Blood Stasis hypertension?',
   'Throbbing temporal headache with nausea',
   'Base-of-skull headache with tight neck muscles',
   'Stabbing or constant headache',
   'Frontal headache with eye strain and light sensitivity',
   'c',
   'The stabbing or constant quality of the headache reflects the nature of blood obstruction — it is not the pulsing or tight pattern of other headache types. This is a useful differentiating diagnostic feature alongside the purplish tongue and knotted/choppy pulse.',
   'Dang Gui (Angelica sinensis) moves the blood and can lower BP in the Blood Stasis/Congealed Heart Blood pattern of hypertension (stabbing headache, chest pain/angina, purplish tongue, knotted/choppy pulse). CAUTION: Avoid all blood-moving herbs with anticoagulant drugs (warfarin, aspirin therapy, etc.).',
   'Blood Stasis', 470),

  -- Q48 (correct=d)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'Which Blood Stasis sign specifically warrants medical evaluation beyond herbal care?',
   'Purplish tongue',
   'Knotted or choppy pulse',
   'Stabbing or constant headache',
   'Chest pain/angina',
   'd',
   'Chest pain can indicate myocardial ischemia or other serious cardiac events requiring immediate medical evaluation. While the other signs are diagnostic of Blood Stasis, chest pain specifically crosses the threshold into medical emergency territory.',
   'Dang Gui (Angelica sinensis) moves the blood and can lower BP in the Blood Stasis/Congealed Heart Blood pattern of hypertension (stabbing headache, chest pain/angina, purplish tongue, knotted/choppy pulse). CAUTION: Avoid all blood-moving herbs with anticoagulant drugs (warfarin, aspirin therapy, etc.).',
   'Blood Stasis', 480),

  -- Q49 (correct=a)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'What are Elecampane''s energetic qualities that make it appropriate for Damp Stagnation hypertension?',
   'Warming and aromatic — moves damp stagnation; addresses the underlying disharmony, not blood pressure directly',
   'Cooling and bitter — clears heat from the spleen and dries dampness aggressively',
   'Yin-nourishing and moistening — tonifies spleen yin to prevent further damp accumulation',
   'Drying and astringent — reduces phlegm accumulation in the digestive system',
   'a',
   'Damp Stagnation calls for warming, moving herbs — not cooling. Elecampane''s warming and aromatic qualities make it suited to move the stagnation. The goal is addressing the underlying pattern, not directly lowering blood pressure.',
   'Elecampane (Inula helenium) is warming and aromatic, moving damp stagnation in the Damp Stagnation pattern of hypertension. These herbs address the underlying disharmony, not blood pressure directly.',
   'Damp Stagnation', 490),

  -- Q50 (correct=d)
  ('Herbal Heart Health - Week 4 - Hypertension and Hypotension',
   'What long-term management strategy did the case study client adopt for herb-responsive hypertension?',
   'Fixed-dose protocol strictly maintained; never self-adjust without consulting the herbalist',
   'Gradually reduced herbs over time, eventually discontinuing them as BP normalized',
   'Switched to pharmaceutical management after confirming herbs were effective',
   'Self-managed dosing based on symptoms and home BP monitoring',
   'd',
   'Self-managed dosing is presented as a reasonable long-term strategy for herb-responsive hypertension — the patient learns to adjust doses based on how they feel and what their monitor shows. This was validated when the herbs-off period confirmed the herbs were doing the work.',
   'California Poppy (Eschscholzia californica) is Rich''s most-used herb for sleep quality — used in the evenings or for middle-of-night waking. Added to this case study client''s protocol after initial hypertension treatment wasn''t sufficient; combined with ashwagandha (daytime) and HTN 180 Px. Result: BP came down to healthy ranges (107/66, 115/73, etc.).',
   'Case Study - Sleep and Nervous System Support', 500);

END $$;
