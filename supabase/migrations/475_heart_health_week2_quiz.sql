-- Migration 475: Herbal Heart Health - Week 2 quiz questions
-- Class: Herbal Heart Health - Week 2 - Building a Resilient Heart
--
-- Target calculation:
--   H (distinct herbs + supplements) = 21
--   F (named factual items: specific stats, named studies, clinical protocols) = 15
--   target = clamp(15 + 21*4 + 15, 20, 50) = clamp(114, 20, 50) = 50 questions
--
-- Correct option distribution: a=13, b=12, c=12, d=13

SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM herbal.class_quiz_questions
    WHERE class_name = 'Herbal Heart Health - Week 2 - Building a Resilient Heart'
  ) THEN
    RAISE NOTICE 'Week 2 quiz questions already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_quiz_questions
    (class_name, question_text, option_a, option_b, option_c, option_d,
     correct_option, explanation, snippet_text, section_header, sort_order)
  VALUES

  -- Q1 correct=a
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'Mills et al. 2015 studied gratitude in asymptomatic heart failure patients. What physiological effects were associated with higher gratitude?',
   'Better mood, better sleep, less fatigue, and lower inflammatory markers',
   'Lower blood pressure and improved cardiac output',
   'Reduced cortisol levels and improved heart rate variability',
   'Better sleep quality and reduced anxiety scores only',
   'a',
   'Mills et al. 2015 (*Spiritual Clin Pract*) found that gratitude was associated with better mood, better sleep, less fatigue, AND lower inflammatory markers - making these physiological effects, not just psychological ones. The other options describe partial findings from other studies or invented data.',
   'Mills et al., 2015 (*Spiritual Clin Pract*): "The people with more gratitude had better mood, better sleep, less fatigue, and lower levels of inflammatory markers linked to heart health."',
   'Gratitude and Heart Health Research', 10),

  -- Q2 correct=b
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'Redwine et al. 2016 (*Psychosomatic Medicine*) studied gratitude journaling in heart failure patients. What were the two key outcomes in the gratitude group?',
   'Lower cortisol and improved sleep quality',
   'Lower inflammatory markers and higher heart rate variability',
   'Reduced blood pressure and better mood',
   'Improved cardiac ejection fraction and reduced arrhythmia risk',
   'b',
   'Redwine et al. 2016 found that the gratitude group had lower inflammatory markers AND higher heart rate variability - two physiologically distinct outcomes. HRV is a direct cardiovascular marker; the inflammatory marker reduction is a systemic one. Neither BP nor ejection fraction was the finding.',
   '"At the end, the gratitude group had lower levels of inflammatory markers and higher heart rate variability." (Redwine LS et al., 2016, *Psychosomatic Medicine*)',
   'Gratitude and Heart Health Research', 20),

  -- Q3 correct=c
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'The class introduces the "peaks and valleys" model of stress. What is identified as the herbalist''s primary leverage point?',
   'Eliminating the stress peaks entirely through adaptogenic support',
   'Ensuring peaks never exceed a moderate height through daily herbs',
   'Protecting and deepening the valleys so the nervous system actually recovers between stressors',
   'Using relaxant nervines to blunt the physiological stress response during each peak',
   'c',
   'The model explicitly states that chronic cardiovascular damage comes not from stress itself but from peaks that never return to baseline. The herbalist''s leverage is the valley - protecting and deepening recovery, not eliminating stress. Adaptogens and nervines support this but the target is recovery, not peak suppression.',
   '"We can''t always control our external world. But we can support those valleys."',
   'Nervous System and Stress Recovery', 30),

  -- Q4 correct=d
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'What is the physiological mechanism by which a slow breath with an extended exhale supports the cardiovascular system?',
   'Increases sympathetic tone temporarily to clear accumulated lactic acid',
   'Stimulates the HPA axis to reset cortisol diurnal rhythms',
   'Increases heart rate briefly to improve cardiac output and circulation',
   'Activates the vagus nerve and shifts sympathovagal balance toward vagal activity, directly reducing blood pressure',
   'd',
   'The extended exhale activates the vagus nerve and shifts sympathovagal balance toward vagal activity - this is the physiological mechanism named in the class. This is why diaphragmatic breathing is an effective, non-pharmacological approach to hypertension and cardiovascular stress. It does NOT raise heart rate or stimulate the HPA axis.',
   '"Slow breathing, especially a longer exhale, signals your nervous system that you''re safe and can come down."',
   'Breath as Cardiovascular Medicine', 40),

  -- Q5 correct=a
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'Yau and Loke 2021 (*Complement Ther Med*) conducted a meta-analysis on diaphragmatic breathing. What was the specific protocol that decreased systolic and diastolic blood pressure?',
   '10 minutes twice daily at fewer than 10 breaths per minute for 4 weeks',
   '20 minutes once daily slow breathing for 8 weeks',
   '5 minutes of slow breathing before each meal for 6 weeks',
   '15 minutes of deep breathing three times weekly for 12 weeks',
   'a',
   'Yau and Loke 2021 found that diaphragmatic breathing at fewer than 10 breaths per minute for 10 minutes twice daily for 4 weeks decreased both systolic and diastolic blood pressure. The specific protocol - duration, frequency, breath rate, and timeframe - matters for clinical application.',
   'Yau KKY, Loke AYN, 2021 (*Complement Ther Med*): diaphragmatic breathing at <10 breaths/min for 10 min twice daily for 4 weeks decreased systolic and diastolic BP.',
   'Breath as Cardiovascular Medicine', 50),

  -- Q6 correct=b
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'Laborde et al. 2019 studied slow-paced breathing before bed for 30 days. What were the two cardiovascular-relevant outcomes compared to the social media control group?',
   'Slower resting heart rate and improved lipid profile',
   'Improved subjective sleep quality and improved overnight cardiac vagal activity',
   'Reduced systolic blood pressure and lower morning cortisol',
   'Better HRV and reduced inflammatory markers',
   'b',
   'Laborde 2019 found that 30 days of slow-paced breathing before bed improved both sleep quality AND overnight cardiac vagal activity compared to a social media control group. This makes it a low-cost intervention addressing both sleep and cardiovascular function simultaneously.',
   'Laborde S et al., 2019: 30-day slow-paced breathing improved subjective sleep quality and overnight cardiac vagal activity vs. social media control.',
   'Breath as Cardiovascular Medicine', 60),

  -- Q7 correct=c
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'The American Heart Association''s Scientific Statement on meditation (Levine et al. 2017, *Circulation*) reached what specific conclusion?',
   'Meditation is equivalent to pharmacological intervention for mild hypertension',
   'Meditation reduces LDL cholesterol and triglycerides in long-term practitioners',
   'Meditation may be considered as an adjunct to guideline-directed cardiovascular risk reduction',
   'Meditation is contraindicated for patients with arrhythmia or uncontrolled hypertension',
   'c',
   'The AHA concluded that "meditation may be considered as an adjunct to guideline-directed cardiovascular risk reduction" - a significant formal endorsement from mainstream cardiology. It is an adjunct, not a replacement, and the statement does not claim equivalence with pharmaceuticals or restrict it from any cardiac conditions.',
   'Levine GN et al., 2017 (*Circulation*): "meditation may be considered as an adjunct to guideline-directed cardiovascular risk reduction"',
   'Meditation and the Heart', 70),

  -- Q8 correct=d
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'Schneider et al. 2012 (*Circulation*) conducted an RCT of transcendental meditation for cardiovascular outcomes. What was the study population?',
   'Elderly women with hypertension and metabolic syndrome',
   'Middle-aged men recovering from myocardial infarction',
   'High-stress executives with borderline cardiovascular risk markers',
   'Black patients with coronary heart disease',
   'd',
   'Schneider 2012 studied Black patients with coronary heart disease and found that TM significantly reduced risk for mortality, myocardial infarction, and stroke, associated with lower blood pressure and psychosocial stress. The study population is clinically important: a high-risk group with existing coronary disease.',
   'Schneider RH et al., 2012 (*Circulation*): RCT of transcendental meditation in Black patients with coronary heart disease - significantly reduced mortality, MI, and stroke risk.',
   'Meditation and the Heart', 80),

  -- Q9 correct=a
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'What hs-CRP level is associated with lower cardiovascular risk, according to the class notes?',
   'Under 1 mg/L',
   '1-3 mg/L',
   '3-5 mg/L',
   'Under 2 mg/L',
   'a',
   'The three hs-CRP risk ranges are: under 1 mg/L = lower risk; 1-3 mg/L = average risk; above 3 mg/L = higher risk. Option D (under 2) is not a recognized range. Knowing these ranges is clinically useful for interpreting lab work in cardiovascular clients.',
   'hs-CRP risk ranges: under 1 mg/L = lower risk; 1-3 mg/L = average risk; above 3 mg/L = higher risk.',
   'Meditation and the Heart', 90),

  -- Q10 correct=b
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'The class identifies three mechanisms by which breath and meditation produce cardiovascular benefit. What are they?',
   'Breath regulation, emotional processing, and sleep enhancement',
   'Attention, Regulation, and Body Awareness',
   'Cortisol reduction, HRV improvement, and NF-kB suppression',
   'Focus, Relaxation, and Neuroplasticity',
   'b',
   'The three mechanisms named in the class are Attention (the capacity to notice), Regulation (working with responses rather than suppressing them), and Body Awareness (earlier recognition of stress responses). Together, these shift the relationship someone has with their own body. Options A, C, and D are either outcomes of these mechanisms or invented.',
   '"These three things together shift the relationship someone has with their own body." - Attention, Regulation, and Body Awareness.',
   'Meditation and the Heart', 100),

  -- Q11 correct=c
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'What are "non-dippers" and why are they clinically significant?',
   'People whose blood pressure rises during sleep due to obstructive sleep apnea',
   'People who sleep fewer than 6 hours per night consistently over years',
   'People whose blood pressure does not fall during sleep, associated with significantly elevated cardiovascular risk',
   'People who do not enter deep sleep stages and miss the inflammation modulatory work of sleep',
   'c',
   'Non-dippers are specifically people whose blood pressure does not fall during sleep (healthy sleepers see a 10-20% drop). Non-dippers have significantly elevated cardiovascular risk. This is distinct from sleep apnea (B), sleep duration (B), or sleep stage deprivation (D) - though these can contribute.',
   'Non-dippers (those whose BP doesn''t fall during sleep) have significantly elevated cardiovascular risk.',
   'Sleep and Cardiovascular Health', 110),

  -- Q12 correct=d
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'What is the recommended preparation and dosing approach for Skullcap (*Scutellaria lateriflora*) in the tension/irritability sleep pattern?',
   'As a tea steeped for 20 minutes to extract the full range of nervine constituents',
   'As a standardized capsule taken once daily at a fixed time for consistent effect',
   'As a glycerite for people who cannot tolerate alcohol tinctures',
   'As a tincture in small, frequent responsive doses throughout the day rather than a single large dose at bedtime',
   'd',
   'The class specifically notes that Skullcap is best as a tincture and that small, frequent responsive doses work better than large infrequent ones for the tension pattern. The goal is modulating nervous system activation throughout the day, not sedation at night. Capsules and glycerites are not mentioned.',
   'Skullcap (*Scutellaria lateriflora*): a classic nervine for restless, racing thoughts and muscle tension; better as TINCTURE; small, responsive doses.',
   'Herbal Support for Sleep - Tension and Irritability', 120),

  -- Q13 correct=a
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'What is the key constitutional picture for Blue Vervain (*Verbena hastata*) in the sleep context?',
   'The person wound tight with perfectionism and overwork, held together by sheer willpower',
   'The cold, depleted person who can no longer push through - all reserves spent',
   'The restless, pale, anxious person who startles easily and cannot anchor',
   'The hot, tense person with a racing heart and elevated blood pressure',
   'a',
   'Blue Vervain''s constitutional picture is specifically the person wound tight with perfectionism and overwork - held together by willpower. This is a Heat and Tension pattern with a strong behavioral signature. Option B describes Eeyore (Cold and Deficiency), Option C describes Blood Deficiency (Piglet), Option D is a generic Heat/Tension picture without the behavioral specificity of Blue Vervain.',
   'Blue Vervain (*Verbena hastata*): for the person wound tight with perfectionism and overwork; better as TINCTURE.',
   'Herbal Support for Sleep - Tension and Irritability', 130),

  -- Q14 correct=b
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'What distinguishes Chamomile (*Matricaria chamomilla*) from Skullcap and Passionflower in the tension/irritability sleep pattern?',
   'It is specifically suited to deep nervous exhaustion in a depleted, pale person',
   'It is gently and broadly calming with a digestive component - suited when tension accompanies digestive upset',
   'It is best for the specific pattern of anxious rumination and circular thinking at night',
   'It is most effective as a tincture well before bedtime for the full heat/tension pattern',
   'b',
   'Chamomile is distinguished by its digestive component - it is broadly calming AND specifically helpful when nervous tension accompanies digestive symptoms. Skullcap is better for racing thoughts and muscle tension; Passionflower is better for anxious rumination. Chamomile is not specifically for depletion (option A) or for rumination only (option C).',
   'Chamomile (*Matricaria chamomilla*): gentle, broadly calming, good for tension with a digestive component; better as TEA or TINCTURE.',
   'Herbal Support for Sleep - Tension and Irritability', 140),

  -- Q15 correct=c
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'What quality specifically distinguishes Lavender (*Lavandula spp.*) from other herbs in the tension/irritability sleep pattern?',
   'It provides the strongest sedative effect of the tension pattern herbs',
   'It is specifically suited to sleep-onset difficulty after the nervous system has softened',
   'It is an aromatic nervine that softens nervous tension without sedating',
   'It is particularly effective for anxious rumination and circular thoughts at night',
   'c',
   'Lavender is specifically described as an aromatic nervine that softens tension WITHOUT sedating - this is its defining quality in this context. It is gentler than Skullcap and not primarily for rumination (Passionflower) or sleep onset (Valerian/Hops). Its aromatic nature is a key feature.',
   'Lavender (*Lavandula spp.*): aromatic nervine that softens tension without sedating; better as TEA or TINCTURE.',
   'Herbal Support for Sleep - Tension and Irritability', 150),

  -- Q16 correct=d
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'Passionflower (*Passiflora incarnata*) is described as particularly well-suited to what specific pattern of sleep disruption?',
   'Cold and depleted people who cannot access restorative sleep',
   'Sleep-onset difficulty with a hot, tense constitutional picture',
   'Broad nervous tension with digestive involvement',
   'Anxious rumination and intrusive circular thoughts that prevent sleep onset',
   'd',
   'Passionflower is specifically described as "particularly well suited to anxious rumination and intrusive thoughts that prevent sleep onset" - the circular mind that cannot stop. This distinguishes it from Lavender (broad aromatic tension) and Skullcap (muscle tension and racing thoughts without the rumination specificity). It is not for the depleted or cold person.',
   'Passionflower (*Passiflora incarnata*): a beautiful, deeply effective nervine for the overactive, circular mind; particularly well suited to anxious rumination and intrusive thoughts.',
   'Herbal Support for Sleep - Tension and Irritability', 160),

  -- Q17 correct=a
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'How and when should Valerian (*Valeriana officinalis*) be taken for the sleep-onset pattern, and what is a key factor in its effectiveness?',
   'Taken 30-60 minutes before bed; often more effective after consistent use over several weeks',
   'Taken immediately at bedtime for maximum effect; works best in combination with Hops only',
   'Taken in small doses throughout the day to build a background level, not at bedtime',
   'Best taken in the morning to establish a sleep rhythm for the following night',
   'a',
   'Valerian is taken 30-60 minutes before bed and is often more effective after consistent use over several weeks - an important clinical point that sets realistic expectations. It is not a one-dose sedative. Option B (immediately at bedtime) misses the 30-60 minute window. Options C and D are incorrect.',
   'Valerian (*Valeriana officinalis*): supports the transition into sleep; works best taken 30-60 minutes before bed; often more effective after consistent use over several weeks.',
   'Herbal Support for Sleep - Difficulty Falling Asleep', 170),

  -- Q18 correct=b
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'Hops (*Humulus lupulus*) is described as less appropriate for which constitutional type, and why?',
   'Hot, tense individuals because it exacerbates the heat component of their pattern',
   'Cold and depleted types because of its bitter, slightly depressant quality',
   'People taking any pharmaceutical medications due to CYP450 enzyme interactions',
   'People with elevated blood pressure as it may paradoxically increase vascular tone',
   'b',
   'The notes specifically state that Hops is "less suited to those who are cold and depleted" because of its bitter, slightly depressant quality. It is actually well-suited to warm/tense types. The class does not mention CYP450 interactions or blood pressure concerns for Hops in this context.',
   'Hops (*Humulus lupulus*): a sedative herb with particular affinity for sleep-onset difficulty; often combined with Valerian; best suited to people who run warm and tense, less suited to those who are cold and depleted.',
   'Herbal Support for Sleep - Difficulty Falling Asleep', 180),

  -- Q19 correct=c
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'How is Milky Oats (*Avena sativa*) intended to be used for the depletion sleep pattern, and what does this imply for expectations?',
   'As an acute sedative taken in a large dose at the onset of insomnia symptoms',
   'In smaller responsive doses throughout the day for the tension/irritability pattern',
   'Over weeks to months as a slow restorative - a rebuilder of nervous system reserves, not a quick sedative',
   'Taken 30-60 minutes before bed as a sleep-onset aid for threshold-crossing difficulty',
   'c',
   'Milky Oats is explicitly described as a "nourishing tonic used over weeks to months, not acute sedatives." This sets the clinical expectation: patients should not expect rapid sedative effect. It rebuilds depleted nervous system reserves over time. It is for the depletion pattern, not tension or threshold-crossing.',
   'Milky oats (*Avena sativa*): a deeply nourishing nervine tonic for a depleted, frayed nervous system; best used over weeks to months as a restorative; not a quick sedative but a slow rebuilder of nervous system reserves.',
   'Herbal Support for Sleep - Depletion and Unrestorative Sleep', 190),

  -- Q20 correct=d
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'The Latin species epithet of Ashwagandha (*Withania somnifera*) is noted in the class. What does "somnifera" mean?',
   'Strengthening',
   'Adaptogenic',
   'Calming',
   'Sleep-bearing',
   'd',
   'Somnifera means "sleep-bearing" - directly linking the Latin name to Ashwagandha''s role in the depletion sleep pattern. This is a memorable clinical anchor. The other options are properties of Ashwagandha but not the meaning of the Latin epithet.',
   'Ashwagandha (*Withania somnifera*): a warming adaptogenic tonic particularly well suited to the depleted, exhausted person who can''t restore through sleep; the species epithet *somnifera* means "sleep-bearing."',
   'Herbal Support for Sleep - Depletion and Unrestorative Sleep', 200),

  -- Q21 correct=a
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'Which of the three sleep patterns calls for nourishing tonic herbs used over weeks to months, rather than sedating or threshold-crossing herbs?',
   'Depletion and unrestorative sleep - sleep happens but does not restore',
   'Tension and irritability with an overactive, racing mind',
   'Difficulty crossing the threshold from wakefulness into sleep',
   'Any sleep pattern where pharmaceutical sleep aids have already been tried and failed',
   'a',
   'The depletion pattern calls for nourishing tonics (Milky Oats, Ashwagandha) used over time. This is a deficiency pattern, not an excess pattern. Pattern 1 (tension) needs relaxant nervines in responsive doses; Pattern 2 (threshold) needs sedative herbs before bed. The question of prior pharmaceutical use does not determine pattern selection.',
   'Pattern 3 - Depletion and Unrestorative Sleep: A deficiency pattern rather than an excess pattern; calls for nourishing, tonic herbs rather than sedating ones. Used over weeks to months.',
   'Herbal Support for Sleep - Depletion and Unrestorative Sleep', 210),

  -- Q22 correct=b
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'Cordyceps (*Cordyceps militaris*) is described as particularly useful in what specific clinical situation?',
   'As a broad tonic for general fatigue without a specific exercise application',
   'When breathlessness or depletion limit the ability to exercise consistently',
   'Specifically for the tension and irritability sleep pattern when other nervines are not tolerated',
   'As a primary adaptogen for cortisol regulation and HPA axis support in overstressed individuals',
   'b',
   'Cordyceps is specifically noted as "particularly useful for people who feel breathless or depleted during activity" - it bridges lung and cardiovascular endurance for the person whose movement is limited not by motivation but by breathlessness or insufficient vitality. Option C and D are not Cordyceps'' indications in the class.',
   'Cordyceps (*Cordyceps militaris*): a tonic mushroom traditionally used to support the lungs, improve stamina, and restore vitality; particularly useful for people who feel breathless or depleted during activity.',
   'Herbal Support for Movement and Endurance', 220),

  -- Q23 correct=c
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'How is Eleuthero (*Eleutherococcus senticosus*) characterized compared to stronger adaptogens in the class?',
   'Eleuthero is specifically warming, where Asian Ginseng is cooling and moistening',
   'Eleuthero has stronger cortisol-modulating effects than the ginsengs',
   'Eleuthero is mild, supporting stamina and stress resilience without overstimulating',
   'Eleuthero is specifically for the depleted, cold person while Asian Ginseng is broadly applicable',
   'c',
   'Eleuthero is described as a "mild adaptogen that supports stamina and stress resilience without overstimulating" - this is its clinical signature. It is gentler than the ginsengs. Option A reverses the warming/cooling profile (Asian Ginseng is warming; Eleuthero is milder). Option B is not supported. Option D misassigns the Cold and Deficiency match.',
   'Eleuthero (*Eleutherococcus senticosus*): mild adaptogen for stamina and stress resilience without overstimulating.',
   'Herbal Support for Movement and Endurance', 230),

  -- Q24 correct=d
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'What makes Schisandra (*Schisandra chinensis*) a "true whole-body adaptogen" according to the class?',
   'Its strong cortisol-modulating effects make it the most potent adaptogen for HPA axis support',
   'It primarily supports liver function, with secondary effects that cascade through other systems',
   'It is used specifically for sleep onset in the depletion pattern alongside Milky Oats',
   'It simultaneously supports the liver, kidneys, heart, and nervous system as a five-flavor berry',
   'd',
   'Schisandra is a "true whole-body adaptogen" because it supports liver, kidneys, heart, and nervous system simultaneously - its breadth is its defining characteristic. Option A overstates its cortisol focus. Option B incorrectly prioritizes only the liver. Option C gives it an incorrect primary indication.',
   'Schisandra (*Schisandra chinensis*): a five-flavor berry that supports liver, kidneys, heart, and nervous system simultaneously - a true whole-body adaptogen; traditionally used by Russian athletes for endurance.',
   'Herbal Support for Movement and Endurance', 240),

  -- Q25 correct=a
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'How is Zone 2 training defined in the class?',
   'Moderate-intensity aerobic exercise you can sustain for extended periods while still holding a conversation',
   'High-intensity interval training alternating between maximal effort and full rest',
   'The training zone where heart rate reaches 80-90% of maximum',
   'Resistance training at 60-70% of one-rep maximum for cardiovascular conditioning',
   'a',
   'Zone 2 is defined as moderate-intensity aerobic exercise that you can sustain while holding a conversation - this conversational test is the accessible clinical marker. It is NOT high-intensity (option B), does NOT approach maximum heart rate (option C), and is NOT resistance training (option D).',
   'Zone 2 training (moderate intensity, sustainable, can hold a conversation): builds mitochondrial density, enhances fat burning, improves insulin sensitivity.',
   'Movement and Cardiovascular Health', 250),

  -- Q26 correct=b
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'Nemoto et al. 2007 (*Mayo Clin Proc*) compared interval walking training (IWT) to moderate-intensity continuous walking. What did IWT improve more?',
   'Heart rate variability and sleep quality in elderly adults',
   'Thigh muscle strength, peak aerobic capacity, and resting systolic blood pressure',
   'Insulin sensitivity without additional cardiovascular benefit over continuous walking',
   'Cardiac output at maximal exertion but not at rest',
   'b',
   'Nemoto 2007 found IWT increased thigh muscle strength, peak aerobic capacity, AND reduced resting systolic BP more than moderate-intensity continuous walking. This triple benefit - muscle, aerobic capacity, and blood pressure - is why IWT is highlighted as clinically meaningful for older and deconditioned individuals.',
   'Nemoto K et al., 2007 (*Mayo Clin Proc*, 82(7):803-811): high-intensity interval walking training increased thigh muscle strength, peak aerobic capacity, and reduced resting systolic blood pressure more than moderate-intensity continuous walking.',
   'Movement and Cardiovascular Health', 260),

  -- Q27 correct=c
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'What percentage of men aged 18 and older met the federal guideline for strength training in 2020?',
   '54.8%',
   '18.3%',
   '35.2%',
   '31.0%',
   'c',
   'Only 35.2% of men aged 18+ met the federal guideline for muscle-strengthening activity (2+ days per week) in 2020. This means roughly 7 out of 10 adults are not strength training regularly. Among women it was even lower at 26.9%. Strength training is especially needed in older adults who are doing it least.',
   'In 2020, only 35.2% of men and 26.9% of women met the federal guideline for muscle-strengthening activity (2+ days/week).',
   'Movement and Cardiovascular Health', 270),

  -- Q28 correct=d
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'What did the 20-year Finnish study find about regular sauna use?',
   'Sauna use twice weekly for 10 years showed modest cardiovascular protection but no mortality benefit',
   'Sauna use showed cardiovascular benefit only when combined with regular aerobic exercise',
   'Sauna use improved HRV but showed no mortality benefit in the 20-year follow-up',
   'Using a sauna 4-7 times per week dramatically lowered cardiovascular death risk',
   'd',
   'The 20-year Finnish study found a dose-dependent relationship: using a sauna 4-7 times per week dramatically lowered cardiovascular death risk. The study noted that the cardiovascular demand of a sauna session is comparable to moderate exercise, making it a clinically useful tool for people who cannot exercise due to injury or disability.',
   'A 20-year Finnish study found that using a sauna four to seven times a week dramatically lowered cardiovascular death risk.',
   'Movement and Cardiovascular Health', 280),

  -- Q29 correct=a
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'What two properties make Echinacea (*Echinacea angustifolia*) suited to supporting cardiovascular-relevant oral health?',
   'Immune support and antimicrobial action in the oral cavity',
   'Vulnerary healing of gum tissue and reduction of systemic inflammation',
   'Drawing properties for periodontal bacteria and affinity for inflamed mucous membranes',
   'Anti-inflammatory action on blood vessel walls and bile acid stimulation',
   'a',
   'Echinacea is described as supporting immune response and providing antimicrobial and anti-inflammatory action in the oral cavity - two properties directly relevant to the periodontal disease mechanism (bacteremia and systemic inflammation). The vulnerary and drawing properties described in options B and C belong to Calendula and Plantain respectively.',
   'Echinacea (*E. angustifolia*) for immune and antimicrobial support; Calendula (*Calendula officinalis*) for inflammation and tissue healing; Plantain (*Plantago spp.*) for sore, inflamed gums and oral ulcers.',
   'Herbal Support for Oral Health', 290),

  -- Q30 correct=b
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'What three properties describe Calendula (*Calendula officinalis*) in the oral health context?',
   'Immune-stimulating, astringent, and cooling',
   'Anti-inflammatory, vulnerary, and gently antimicrobial',
   'Drawing, anti-inflammatory, and specifically suited to oral ulcers',
   'Antimicrobial, diuretic, and tonifying to the gum tissue',
   'b',
   'Calendula is described as anti-inflammatory, vulnerary (wound-healing), and gently antimicrobial - three distinct properties that make it suited to inflamed, damaged gum tissue. The drawing property and oral ulcer specificity in option C belong to Plantain. Option A and D contain incorrect properties.',
   'Calendula (*Calendula officinalis*): anti-inflammatory, vulnerary, and gently antimicrobial; well suited to inflamed, bleeding gum tissue; promotes healing of damaged gum tissue.',
   'Herbal Support for Oral Health', 300),

  -- Q31 correct=c
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'What specific property distinguishes Plantain (*Plantago spp.*) in the oral health context from Echinacea and Calendula?',
   'It provides the strongest antimicrobial action of the three oral health herbs',
   'It specifically promotes rapid healing of bleeding gums through its vulnerary action',
   'It has a drawing quality and strong affinity for inflamed mucous membranes, specifically suited to sore, inflamed gums and oral ulcers',
   'It reduces systemic inflammation by inhibiting prostaglandin synthesis throughout the body',
   'c',
   'Plantain is specifically described as anti-inflammatory, drawing, and vulnerary with "strong affinity for mucous membranes" - and noted as "particularly useful for sore, inflamed gums and oral ulcers." The drawing quality is the distinguishing feature. Calendula also has vulnerary action (option B overlap) but Plantain''s drawing quality and mucous membrane affinity set it apart.',
   'Plantain (*Plantago spp.*): anti-inflammatory, drawing, and vulnerary; a classic wound-healing herb with strong affinity for mucous membranes; particularly useful for sore, inflamed gums and oral ulcers.',
   'Herbal Support for Oral Health', 310),

  -- Q32 correct=d
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'The American Heart Association identifies two specific pathways through which periodontal disease causes cardiovascular disease. What are they?',
   'Plaque buildup in the mouth and reduced saliva production creating systemic immune suppression',
   'Elevated oral cortisol and increased sympathetic nervous system activation',
   'Bacterial toxin production and direct enamel erosion leading to nutrient deficiency',
   'Bacteremia (bacteria entering the bloodstream) and chronic systemic inflammation',
   'd',
   'The AHA identifies exactly two pathways: bacteremia (periodontal bacteria entering the bloodstream and triggering systemic inflammatory responses) and chronic systemic inflammation (the inflamed mouth contributing to the same inflammatory environment that drives cardiovascular disease). These are the mechanistic pathways, not correlational associations.',
   'Tran AH et al., 2026 (*Circulation*, 153(6)): identifies bacteremia and chronic systemic inflammation as the two primary pathways from periodontal disease to cardiovascular disease.',
   'Oral Health and Cardiovascular Risk', 320),

  -- Q33 correct=a
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'What is the prevalence of periodontal disease in US adults, according to the AHA source cited in the class?',
   'Over 40% of US adults over 30 are affected by periodontal disease',
   'Approximately 15% of US adults have clinically significant periodontal disease',
   'About 25% of adults over 50 develop some degree of periodontal disease',
   'Nearly 60% of Americans over 65 have gum disease severe enough to affect systemic health',
   'a',
   'Over 40% of US adults over 30 have periodontal disease - making it an extremely common, largely undertreated cardiovascular risk factor. This prevalence is what makes asking about gum health in every cardiovascular intake clinically warranted: most clients over 30 are at meaningful risk.',
   'Periodontal disease affects over 40% of US adults over 30 - a major undertreated cardiovascular risk factor.',
   'Oral Health and Cardiovascular Risk', 330),

  -- Q34 correct=b
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'Why does the class recommend eating Garlic (*Allium sativum*) daily in real cooking rather than as a supplement?',
   'Supplements allow for standardized allicin dosing that cooking cannot reliably deliver',
   'Daily culinary use delivers consistent cardiovascular benefit without the concerns of high-dose supplementation',
   'Cooking activates garlic''s allicin in a form that is better absorbed than raw supplements',
   'Supplements and culinary garlic are equivalent when matched for allicin content',
   'b',
   'The class frames Garlic as a food, not a supplement: daily use in real cooking delivers consistent cardiovascular benefit without the concerns of high-dose supplementation. This is the abundance-over-restriction framing applied to cardiovascular foods. The class does not say supplements are equivalent - it prefers the food form.',
   'Garlic (*Allium sativum*): supports circulation, helps modulate lipid balance, anti-inflammatory; best eaten daily in real cooking.',
   'Food as Cardiovascular Medicine', 340),

  -- Q35 correct=c
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'What is the specific mechanism described for olive oil''s anti-inflammatory cardiovascular benefit?',
   'Oleuropein blocks LDL oxidation directly in the arterial wall',
   'Polyphenols in olive oil activate AMPK pathways to reduce NF-kB activity',
   'Oleocanthal acts similarly to ibuprofen at anti-inflammatory doses',
   'Oleic acid reduces LDL cholesterol by inhibiting HMG-CoA reductase',
   'c',
   'The class specifically names oleocanthal as the compound in olive oil that acts similarly to ibuprofen at anti-inflammatory doses - a memorable, specific mechanism connecting olive oil to the inflammatory cardiovascular terrain. Options A, B, and D describe plausible but unmentioned or incorrect mechanisms.',
   'Olive oil: oleocanthal acts similarly to ibuprofen at anti-inflammatory doses; associated with fewer cardiovascular events.',
   'Food as Cardiovascular Medicine', 350),

  -- Q36 correct=d
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'What is the specific cardiovascular mechanism by which leafy greens support vascular health?',
   'Folate in leafy greens reduces homocysteine levels and cardiovascular risk',
   'Magnesium in leafy greens supports heart rhythm and vascular tone',
   'Phytosterols in greens directly compete with cholesterol absorption in the gut',
   'Dietary nitrates in leafy greens support nitric oxide production and vascular relaxation',
   'd',
   'Leafy greens are specifically highlighted for their dietary nitrates, which support nitric oxide production and vascular relaxation - a direct vascular mechanism. While folate and magnesium are found in greens and have cardiovascular relevance, the class specifically names dietary nitrates as the mechanism in this context.',
   'Leafy greens: rich in dietary nitrates, support nitric oxide production, help relax blood vessels, and support healthy blood pressure.',
   'Food as Cardiovascular Medicine', 360),

  -- Q37 correct=a
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'Which magnesium form is specifically recommended for the sleep, calm, and muscle tension pattern, and why?',
   'Magnesium glycinate - the glycine component has its own calming and sleep-supporting effects',
   'Magnesium malate - malate is involved in the Krebs cycle supporting energy for overnight repair',
   'Magnesium citrate - the most broadly absorbed form without a specific pattern focus',
   'Magnesium oxide - the most available form with the longest history of clinical use',
   'a',
   'Magnesium glycinate is specifically suited to sleep/calm/tension because the glycine component has its own calming and sleep-supporting effects. Malate is for fatigue and muscle recovery. Citrate is the general-purpose form. Oxide is specifically listed as a form to AVOID due to poor absorption.',
   'Magnesium glycinate: well absorbed, gentle on the stomach, supports calm and relaxation, helps with sleep and muscle tension.',
   'Key Nutrients for Cardiovascular Health', 370),

  -- Q38 correct=b
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'What important clinical distinction does the class make about Vitamin D levels?',
   'The main concern with Vitamin D is toxicity at doses above 2000 IU daily',
   'A meaningful difference exists between "not deficient" and "actually replete" - lab reference ranges mark the floor, not the optimal level',
   'Vitamin D3 is superior to D2 only for bone health but equivalent for cardiovascular benefit',
   'Vitamin D should always be tested before supplementing due to its narrow therapeutic window',
   'b',
   'The class specifically makes this distinction: "not deficient" (within lab reference range) is not the same as "actually replete." Reference ranges mark the bottom floor of normal, not the optimal level for cardiovascular health. This is a clinically important reframe for interpreting lab work. The other options are not stated in the class.',
   '"There''s a meaningful difference between ''not deficient'' and ''actually replete''"',
   'Key Nutrients for Cardiovascular Health', 380),

  -- Q39 correct=c
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'Why are statin users especially noted as benefiting from CoQ10 supplementation?',
   'Statins increase the metabolic demand on cardiac tissue, increasing CoQ10 requirements',
   'Statin users tend to have more advanced cardiovascular disease requiring more CoQ10 support',
   'Statin use depletes CoQ10 by blocking the same biosynthesis pathway that produces cholesterol',
   'CoQ10 counters the inflammatory side effects of statin medications',
   'c',
   'Statins block HMG-CoA reductase, the same pathway used to synthesize both cholesterol AND CoQ10. This means statin use depletes CoQ10, which is critical for cardiac energy metabolism. Statin users therefore especially benefit from supplementation. This is a specific, mechanistically grounded clinical application.',
   'CoQ10 (Coenzyme Q10): critical for cellular energy production; depleted by aging and statin use.',
   'Key Nutrients for Cardiovascular Health', 390),

  -- Q40 correct=d
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'What problem does the class identify with using ALA (alpha-linolenic acid) from flax and chia as an omega-3 source?',
   'ALA from plant sources is primarily stored as adipose tissue rather than used for cellular function',
   'ALA raises triglycerides more than EPA/DHA due to its longer carbon chain structure',
   'ALA interacts more significantly with anticoagulants than marine omega-3s',
   'ALA converts poorly to EPA and DHA in the body and is not a substitute for marine omega-3s',
   'd',
   'The class explicitly states that "ALA from flax/chia converts poorly and is not a substitute for marine omega-3s." The conversion of plant-based ALA to the cardiovascular-relevant EPA and DHA is inefficient in humans. This is an important clinical point for vegetarian and vegan clients who may rely on flax and chia believing they are getting adequate omega-3s.',
   'Omega-3 fatty acids: EPA and DHA from fish oil are the best-studied forms; ALA from flax/chia converts poorly and is not a substitute for marine omega-3s.',
   'Key Nutrients for Cardiovascular Health', 400),

  -- Q41 correct=a
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'Why are methylated forms of B vitamins recommended for people with MTHFR variants?',
   'People with MTHFR variants have impaired conversion from unmethylated forms, so methylfolate and methylcobalamin are directly usable',
   'MTHFR variants increase B vitamin excretion, requiring higher doses in methylated form',
   'The MTHFR variant primarily affects B6 metabolism rather than B12 and folate',
   'Unmethylated B vitamins are hepatotoxic for people with MTHFR variants at standard doses',
   'a',
   'People with MTHFR gene variants have impaired ability to convert standard (unmethylated) B vitamins to their active forms. Methylfolate and methylcobalamin are already in the active, usable form - they bypass the impaired conversion step. Option C incorrectly identifies B6 as the primary concern. Options B and D are not stated in the class.',
   'B vitamins: methylated forms (methylfolate, methylcobalamin) are better absorbed by people with MTHFR variants.',
   'Key Nutrients for Cardiovascular Health', 410),

  -- Q42 correct=b
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'How does insulin resistance contribute to cardiovascular disease according to the class?',
   'Insulin resistance increases LDL particle size without directly affecting inflammatory markers',
   'Insulin resistance drives NF-kB activation, elevated CRP, and endothelial dysfunction',
   'Insulin resistance causes cardiovascular risk primarily through its effect on triglyceride levels alone',
   'The cardiovascular effects of insulin resistance are entirely mediated through elevated blood pressure',
   'b',
   'The notes explicitly state that insulin resistance drives NF-kB activation, elevated CRP, and endothelial dysfunction - three distinct cardiovascular mechanisms. This is consistent with the class''s inflammatory framing of cardiovascular disease. Options C and D each capture only one pathway. Option A is incorrect (insulin resistance typically increases small dense LDL, not particle size).',
   '"Insulin resistance drives inflammation." - associated with elevated CRP, NF-kB activation, and endothelial dysfunction.',
   'Metabolic Health and Heart Disease', 420),

  -- Q43 correct=c
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'What statistic did Julianne Holt-Lunstad (Brigham Young University) use to quantify the cardiovascular risk of loneliness?',
   'Loneliness is equivalent to being physically inactive in terms of cardiovascular mortality',
   'Social isolation is associated with 50% increased risk of dementia but limited direct cardiovascular effect',
   'Health risk associated with loneliness is comparable to smoking 15 cigarettes per day',
   'Loneliness increases cardiovascular risk primarily through elevated cortisol during working hours',
   'c',
   'Holt-Lunstad found that the health risk associated with loneliness is comparable to smoking 15 cigarettes per day - one of the most striking statistics in cardiovascular research and a clinically useful way to communicate the importance of social connection. This is not an approximate comparison; it reflects mortality data.',
   '"Health Risk associated with loneliness is comparable to smoking fifteen cigarettes a day." (Julianne Holt-Lunstad, Brigham Young University)',
   'Joy, Social Connection, and Time in Nature', 430),

  -- Q44 correct=d
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'What are phytoncides, and what measurable cardiovascular-relevant effect do they have?',
   'Chemical signals released by trees to warn nearby plants, with incidental calming effects in humans',
   'Compounds that reduce cortisol through the olfactory system by triggering the relaxation response',
   'Anti-inflammatory terpenes that reduce CRP after 2 hours of forest exposure',
   'Volatile organic compounds released by trees that increase NK cell activity and affect autonomic function',
   'd',
   'Phytoncides are volatile organic compounds released by trees (especially conifers) that have measurable immune effects (increasing NK cell activity) and affect autonomic function - one mechanism explaining the cardiovascular benefits of forest time. They are not primarily anti-inflammatory terpenes (option C) or solely olfactory cortisol reducers (option B).',
   'Phytoncides (volatile compounds from trees, especially conifers): increase NK cell activity and affect autonomic function - one mechanism for the cardiovascular benefits of forest time.',
   'Joy, Social Connection, and Time in Nature', 440),

  -- Q45 correct=a
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'The class introduces a clinical reframe for the cardiovascular intake. What question replaces "What is this person doing to protect their heart?"',
   '"What brings this person genuine joy?"',
   '"What is limiting this person''s ability to change?"',
   '"What is the most accessible entry point for this person?"',
   '"What is the person''s relationship with their own heart?"',
   'a',
   'The class explicitly crosses out "What is this person doing to protect their heart?" and replaces it with "What brings this person genuine joy?" - a reframe from risk-reduction to meaning and aliveness. Option C is the herbalist''s synthesis question but is distinct from this specific clinical reframe about joy. Options B and D are not stated in the class.',
   '"What is this person doing to protect their heart?" crossed out, replaced with "What brings this person genuine joy?"',
   'Joy, Social Connection, and Time in Nature', 450),

  -- Q46 correct=d
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'How does the class frame the relationship between nervine herbs and lifestyle practices like breath and meditation?',
   'Herbs replace lifestyle practices for clients who cannot sustain behavior change on their own',
   'Herbs should be introduced before lifestyle practices to lower activation enough to begin',
   'Herbs work independently of lifestyle change because they address the same physiological pathways',
   'Herbs work best as partners to the practices - temporary scaffolds that support breath, sleep hygiene, and lifestyle change, not substitutes for them',
   'd',
   'The class explicitly states that "Herbs work best here as partners to the practices" - not replacements but scaffolds that lower nervous system activation enough for other practices to take hold. Option B gets the sequencing partially right but overstates the independence of herbs. Options A and C directly contradict the class framing.',
   '"Herbs work best here as partners to the practices" - not replacements for breath, meditation, and sleep hygiene.',
   'Herbal Support for Sleep - Tension and Irritability', 460),

  -- Q47 correct=c
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'What happens to blood pressure during sleep in healthy individuals, and what is the cardiovascular significance?',
   'Blood pressure rises during sleep to support the cellular repair and restoration work happening at night',
   'Blood pressure remains stable during sleep as the cardiovascular system maintains homeostasis',
   'Blood pressure drops 10-20% during sleep in healthy individuals - a critical period of cardiovascular recovery',
   'Blood pressure fluctuates unpredictably during sleep in a pattern that reflects overall cardiovascular health',
   'c',
   'Blood pressure drops 10-20% in healthy sleepers - a critical period of cardiovascular recovery. People whose BP does not drop (non-dippers) have significantly higher cardiovascular risk. This makes sleep an active cardiovascular intervention, not a passive state. Option A (BP rises) is the opposite of what happens.',
   'During sleep, blood pressure drops typically by 10 to 20 percent in healthy individuals - a critical period of cardiovascular recovery.',
   'Sleep and Cardiovascular Health', 470),

  -- Q48 correct=d
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'Rosalee shares her own CRP data as a personal example. What was the trajectory of her CRP levels?',
   'From approximately 1.5 mg/L (average risk) in 2019 down to 0.8 mg/L (lower risk) by 2025',
   'From approximately 6.2 mg/L (higher risk) down to 2.4 mg/L (average risk)',
   'From approximately 3.1 mg/L (borderline higher risk) down to 1.0 mg/L (lower risk)',
   'From approximately 4.7 mg/L (higher risk) from 2019 through mid-2025, then dropping dramatically to approximately 1.5 mg/L (average/lower risk)',
   'd',
   'Rosalee''s CRP was approximately 4.7 mg/L (higher risk range: >3 mg/L) from 2019 through mid-2025, then dropped dramatically to approximately 1.5 mg/L (average/lower risk) - a meaningful shift across risk categories. This personal example illustrates that lifestyle and herbal interventions can produce measurable changes in inflammatory markers.',
   'Rosalee shares her own CRP data: levels were ~4.7 mg/L (higher risk) from 2019 through mid-2025, then dropped dramatically to ~1.5 mg/L (average/lower risk).',
   'Meditation and the Heart', 480),

  -- Q49 correct=a
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'Black and Slavich 2016 (*Ann N Y Acad Sci*) studied mindfulness meditation and cardiovascular-relevant markers. What three findings were reported?',
   'Reduced NF-kB transcription activity and CRP levels, improved CD4+ T cell count, and increased telomerase activity',
   'Reduced inflammatory markers but no effect on immune function or biological aging markers',
   'Decreased cortisol and blood pressure but no effect on genetic aging markers',
   'Improved CRP levels only in people with existing cardiovascular disease',
   'a',
   'Black and Slavich 2016 found three distinct findings: reduced NF-kB transcription activity AND CRP levels (inflammation), improved CD4+ T cell count (immune function), and increased telomerase activity (slower biological aging). These reflect reduced inflammation, better immunity, and slower aging - all cardiovascular-relevant. Options B, C, and D capture partial or incorrect findings.',
   'Black DS, Slavich GM, 2016 (*Ann N Y Acad Sci*): mindfulness meditation associated with reduced NF-kB transcription activity and CRP levels, improved CD4+T cell count, and increased telomerase activity.',
   'Meditation and the Heart', 490),

  -- Q50 correct=b
  ('Herbal Heart Health - Week 2 - Building a Resilient Heart',
   'What is the closing statement of Module 2, summarizing the module''s core message?',
   '"The herbalist''s most important tool is their materia medica - choose the right herb for the right pattern."',
   '"Small choices become lasting rhythms through consistent acts of attention over time."',
   '"Heart health is primarily determined by genetics, with lifestyle and herbs playing a supporting role."',
   '"The goal of herbal cardiovascular medicine is to reduce medication dependence over time."',
   'b',
   'The module''s closing statement is "Small choices become lasting rhythms through consistent acts of attention over time." This captures the entire module''s framing: heart resilience is not built in a single session or supplement but in the accumulated texture of daily attentive living. Options A, C, and D are either partially true or directly contradict the class framing.',
   '"Small choices become lasting rhythms through consistent acts of attention over time." - the module''s closing statement.',
   'Joy, Social Connection, and Time in Nature', 500);

END $$;
