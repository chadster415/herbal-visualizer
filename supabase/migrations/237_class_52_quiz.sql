-- Migration 237: Class 52 — Nervous System III and Plant Chemistry quiz questions
-- Source: supabase/migrations/225_class_52_nervous_system_iii_data.sql
SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_quiz_questions
             WHERE class_name = 'BHC - Class 52 - Nervous System III and Plant Chemistry') THEN
    RAISE NOTICE 'Class 52 quiz questions already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_quiz_questions
    (class_name, question_text, option_a, option_b, option_c, option_d,
     correct_option, explanation, snippet_text, section_header, sort_order)
  VALUES

    -- Q1: Milky Oats myelin support
    ('BHC - Class 52 - Nervous System III and Plant Chemistry',
     'Which herb is noted for supporting the myelin sheath and helping re-myelinate nerve cells?',
     'Valerian',
     'Passionflower',
     'Milky Oats',
     'Skullcap',
     'c',
     'Milky Oats is specifically noted for supporting the myelin sheath — it should be used fresh after harvesting for best effect.',
     'Milky Oats — fresh herb; helps re-myelinate nerve cells; best used fresh after harvesting.',
     'Myelin Support', 10),

    -- Q2: GABA herbs
    ('BHC - Class 52 - Nervous System III and Plant Chemistry',
     'Which three herbs are noted as the primary GABA-influencing nervines in this class?',
     'Skullcap, Hops, Motherwort',
     'Valerian, Lemon Balm, Passionflower',
     'Chamomile, Catnip, Lavender',
     'Milky Oats, Blue Vervain, Linden',
     'b',
     'Valerian, Lemon Balm, and Passionflower are the three herbs identified as influencing GABA — the primary inhibitory "brake pedal" neurotransmitter.',
     'Passionflower — GABA support; primary "brake pedal"; for hypervigilance, racing thoughts, insomnia.',
     'GABA Support', 20),

    -- Q3: GABA low symptoms
    ('BHC - Class 52 - Nervous System III and Plant Chemistry',
     'When GABA levels are low, which constellation of symptoms typically presents?',
     'Low motivation, fatigue, reduced pleasure, poor concentration',
     'Moody, lethargic, GI upset, emotional flatness',
     'Anxiety, hypervigilance, racing thoughts, insomnia, muscle tension',
     'Circular thinking, jaw tension, disillusionment, choppy mental state',
     'c',
     'Low GABA manifests as anxiety, hypervigilance, racing thoughts, insomnia, and muscle tension — GABA is the primary inhibitory brake pedal of the nervous system.',
     'when GABA is low: anxiety, hypervigilance, racing thoughts, insomnia, muscle tension\n- herbs:\n    - passionflower\n    - valerian root\n    - lemon balm',
     'GABA Support', 30),

    -- Q4: Dopamine herb
    ('BHC - Class 52 - Nervous System III and Plant Chemistry',
     'Which herb is specifically noted for boosting dopamine and indicated for low motivation and reduced pleasure?',
     'Guayusa',
     'Bacopa',
     'Velvet Bean (Mucuna pruriens)',
     'Tulsi',
     'c',
     'Velvet Bean (Mucuna pruriens) is the herb noted for boosting dopamine, with indications including low motivation, fatigue, difficulty initiating tasks, and reduced pleasure.',
     'Velvet Bean (mucuna) — boosts dopamine; for low motivation, fatigue, difficulty initiating tasks, reduced pleasure.',
     'Dopamine Support', 40),

    -- Q5: Nervine stimulant
    ('BHC - Class 52 - Nervous System III and Plant Chemistry',
     'Which herb is given as an example of a nervine stimulant in this class?',
     'Valerian',
     'Guayusa',
     'Skullcap',
     'Linden',
     'b',
     'Guayusa (Ilex guayusa) is the example of a stimulant nervine — a caffeine-bearing plant used for energy and mental clarity.',
     'Guayusa — stimulant nervine; caffeine-bearing plant used for energy and mental clarity.',
     'Nervine Stimulants', 50),

    -- Q6: GI-based depression
    ('BHC - Class 52 - Nervous System III and Plant Chemistry',
     'What characterizes GI-based depression, and which herbs are indicated?',
     'Fatigue, feeling cold, poor memory; Bladderwrack, Ashwagandha, Bacopa',
     'Moody and lethargic; Saffron, St. John''s Wort, Wormwood',
     'Circular thinking, jaw tension; Passionflower, Blue Vervain, Valerian',
     'Depression from grief and trauma; Mimosa bark, Rose, Lavender',
     'b',
     'GI-based depression is characterized by moodiness and lethargy (serotonin is produced in the GI tract). Key herbs are Saffron, St. John''s Wort, and Wormwood.',
     'GI based depression is moody and lethargic\n- herbs:\n    - Saffron (tea, 2-3 sepals), SJW, Wormwood (if ready for that underworld energy), Lemon Balm, Chamomile and Catnip',
     'GI-Based Depression', 60),

    -- Q7: Saffron contraindication
    ('BHC - Class 52 - Nervous System III and Plant Chemistry',
     'What is the key contraindication when using Saffron for GI-based depression?',
     'Avoid with NSAIDs due to bleeding risk',
     'Avoid with hypothyroid patients due to cooling action',
     'Avoid with SSRIs due to serotonin syndrome risk',
     'Avoid in pregnancy due to emmenagogue effect',
     'c',
     'Saffron is contraindicated with SSRIs because of serotonin syndrome risk. It is used as a tea with 2–3 sepals.',
     'Saffron — GI-based depression; use as tea, 2–3 sepals; contraindicated with SSRIs (serotonin syndrome).',
     'GI-Based Depression', 70),

    -- Q8: Stagnant depression — Mimosa bark vs flower
    ('BHC - Class 52 - Nervous System III and Plant Chemistry',
     'For stagnant depression using Mimosa (Silk Tree / Albizia), how do the bark and flower differ in character?',
     'Bark is more uplifting; flower is stronger and grounding',
     'Bark is stronger and grounding; flower is more uplifting',
     'Bark is used for acute episodes; flower for chronic maintenance',
     'Both have the same action; only preparation method differs',
     'b',
     'Mimosa bark is stronger and grounding; the flower is more uplifting. The notes recommend using 1:1 bark:flower for stagnant depression.',
     'Mimosa / Silk Tree — stagnant depression; bark is stronger and grounding, flower is more uplifting; use 1:1 bark:flower.',
     'Stagnant Depression', 80),

    -- Q9: Stagnant depression — definition
    ('BHC - Class 52 - Nervous System III and Plant Chemistry',
     'How is stagnant depression defined in these notes?',
     'Depression linked to lack of sunlight and low Vitamin D',
     'Depression tied to an underactive thyroid causing fatigue and feeling cold',
     'Chronic situational depression where a trauma has become the focus of someone''s entire existence',
     'Depression with GI symptoms, moodiness, and lethargy',
     'c',
     'Stagnant depression is defined as chronic situational depression where a trauma has become the focus of someone''s entire existence. Herbs include Mimosa, Rose petals, Lavender, Rosemary, and Damiana.',
     'chronic situational depression where a trauma has become the focus of someone''s entire existence\n- herbs:\n    - mimosa bark (stronger, grounding) and / or flower (more uplifting) - 1/2 and 1/2',
     'Stagnant Depression', 90),

    -- Q10: Thyroid depression herbs
    ('BHC - Class 52 - Nervous System III and Plant Chemistry',
     'Which group of herbs is specifically indicated for thyroid-related depression from hypothyroidism?',
     'Black Cohosh, Tulsi, Blue Vervain, Damiana',
     'Ashwagandha, Bacopa, Bladderwrack, Damiana, Red Ginseng',
     'Valerian, Passionflower, Milky Oats, Lemon Balm',
     'Calendula, St. John''s Wort, Lemon Balm',
     'b',
     'Ashwagandha, Bacopa, Bladderwrack, Damiana, and Red Ginseng are the specific herbs for thyroid-induced depression — hypothyroidism presents as fatigue, poor memory, and feeling cold.',
     'Thyroid induced depression\n- herbs specific for thyroid depression:\n    - ash (ashwagandha), bacopa, bladderwrack, damiana and red ginseng',
     'Thyroid-Related Depression', 100),

    -- Q11: SAD — light-bearing plants
    ('BHC - Class 52 - Nervous System III and Plant Chemistry',
     'Which three herbs are described as "light-bearing plants" used for Seasonal Affective Disorder?',
     'Lavender, Rosemary, Damiana',
     'Albizia, Hawthorn, Reishi',
     'Calendula, Lemon Balm, St. John''s Wort',
     'Black Cohosh, Tulsi, Blue Vervain',
     'c',
     'Calendula, Lemon Balm, and St. John''s Wort are the light-bearing plants recommended for SAD, linked to lack of sunlight.',
     'use light bearing plants: Calendula, Lemon Balm and SJW',
     'Seasonal Affective Disorder', 110),

    -- Q12: Black Cohosh depression type
    ('BHC - Class 52 - Nervous System III and Plant Chemistry',
     'Which specific type of depression is Black Cohosh indicated for?',
     'GI-based depression with lethargy',
     'Stagnant depression from unresolved trauma',
     'Black cloud depression associated with menopause',
     'Seasonal affective disorder from lack of light',
     'c',
     'Black Cohosh is specifically indicated for "black cloud depression" — depression associated with menopause, when depression has a hormonal/menopausal root.',
     'Black Cohosh — black cloud depression; specifically for depression associated with menopause.',
     'Depression', 120),

    -- Q13: Tulsi caution
    ('BHC - Class 52 - Nervous System III and Plant Chemistry',
     'Tulsi is described as uplifting yet grounding for depression — what important caution is noted?',
     'Avoid with liver disease due to high essential oil content',
     'Avoid in severe hypothyroidism (cooling to thyroid)',
     'Avoid with SSRIs due to serotonin syndrome risk',
     'Avoid in bipolar disorder due to mania risk',
     'b',
     'Tulsi should be avoided in severe hypothyroidism because it is cooling to the thyroid — it is otherwise useful for depression with blood sugar dysregulation, brain fog, and stomach issues.',
     'Tulsi — uplifting while grounding; for depression with blood sugar dysregulation, brain fog and stomach stuff; avoid when hypothyroidism',
     'Depression', 130),

    -- Q14: Blue Vervain
    ('BHC - Class 52 - Nervous System III and Plant Chemistry',
     'Blue Vervain is described as calming the "choppy waters" of the mind — what clinical signs does it specifically address?',
     'Fatigue, poor memory, feeling cold',
     'Moody, lethargic, GI depression',
     'Disillusionment, circular thinking, jaw tension',
     'Hypervigilance, insomnia, muscle tension',
     'c',
     'Blue Vervain addresses disillusionment, presenting as circular thinking, jaw/shoulder tension — described as mist coming in over choppy mental waters.',
     'Blue Vervain — choppy waters of the mind made calm; disillusionment, circular thinking, jaw tension; cooling and misting.',
     'Depression', 140),

    -- Q15: Spirit remedies — Albizia
    ('BHC - Class 52 - Nervous System III and Plant Chemistry',
     'Albizia (Silk Tree) is described as the "tree of joy" — for what spirit-level purpose is it used?',
     'Processing grief and moving through loss',
     'Courage and strength of the heart',
     'Joy and collective happiness',
     'Inviting light back in and restoring sparkle',
     'c',
     'Albizia is the "tree of joy" — used as a spirit remedy for joy and collective happiness in all forms.',
     'Albizia — tree of joy; spirit remedy; utilize in all forms for collective happiness.',
     'Spirit Remedies', 150),

    -- Q16: Spirit remedies — Linden
    ('BHC - Class 52 - Nervous System III and Plant Chemistry',
     'Which spirit remedy is described as the "tree of joy and sorrow" used for processing grief?',
     'Rose',
     'Reishi',
     'Hawthorn',
     'Linden',
     'd',
     'Linden is described as the "tree of joy and sorrow" — a spirit remedy for processing and moving through grief.',
     'Linden — processing and moving through grief; tree of joy and sorrow; spirit remedy.',
     'Spirit Remedies', 160),

    -- Q17: Spirit remedies — Devil's Club
    ('BHC - Class 52 - Nervous System III and Plant Chemistry',
     'Devil''s Club is a spirit remedy — what is its primary spirit-level action?',
     'Restoring the sparkle in the eyes and inviting light back in',
     'Building courage and heart strength',
     'Helping with addictive behavior and pattern interruption',
     'Processing collective grief and group sorrow',
     'c',
     'Devil''s Club helps with addictive behavior and pattern interruption — for retracing destructive patterns over and over again.',
     'Devil''s Club — helps with addictive behavior and pattern interruption; spirit remedy for retracing destructive patterns.',
     'Spirit Remedies', 170),

    -- Q18: Linden and hypertension
    ('BHC - Class 52 - Nervous System III and Plant Chemistry',
     'Linden is indicated for which specific type of hypertension?',
     'Essential hypertension with cardiovascular involvement',
     'White coat hypertension (anxiety-driven BP elevation)',
     'Hypertension from thyroid overactivity',
     'Hypertension linked to adrenal exhaustion',
     'b',
     'Linden addresses white coat hypertension — anxiety-driven blood pressure elevation. It calms the nervous tension that drives elevated BP.',
     'Linden — white coat hypertension; calms anxiety-driven BP elevation.',
     'Hypertension', 180),

    -- Q19: Skullcap differential
    ('BHC - Class 52 - Nervous System III and Plant Chemistry',
     'According to the nervine differentials, Skullcap is specifically indicated when a patient presents with which symptom pattern?',
     'Fried and frazzled with heart palpitations and hormonal stress',
     'Over-planning, over-thinking, stress-induced stomach heat',
     'Overwhelm from sensory input — lights and noises feel overwhelming',
     'Circular thinking with a "radio playing in the head"',
     'c',
     'Skullcap is indicated for overwhelm from sensory input — when lights and noises feel overwhelming.',
     'Skullcap — nervine for overwhelm from sensory input; indicated when lights and noises feel overwhelming.',
     'Nervine Differentials', 190),

    -- Q20: Hops differential
    ('BHC - Class 52 - Nervous System III and Plant Chemistry',
     'In the nervine differentials, which herb is indicated for stress-induced stomach heat in the over-planner and over-thinker?',
     'Valerian',
     'Chamomile',
     'Lemon Balm',
     'Hops',
     'd',
     'Hops is indicated for stress-induced stomach heat — for the over-planner and over-thinker.',
     'Hops — stress induced stomach heat – over-planning over-thinking',
     'Nervine Differentials', 200),

    -- Q21: Valerian paradox
    ('BHC - Class 52 - Nervous System III and Plant Chemistry',
     'What is the important caution noted for Valerian in the nervine differentials?',
     'Contraindicated with SSRIs due to serotonin syndrome',
     'A paradoxical stimulant reaction is possible in some patients',
     'Must be avoided in pregnancy due to uterine stimulation',
     'Depletes B vitamins with long-term use',
     'b',
     'Valerian is described as a "knocker outer" (strong palliative sedative), but a paradoxical stimulant reaction is possible in some patients.',
     'Valerian — strong palliative sedative ("knocker outer"); caution: paradoxical stimulant reaction possible.',
     'Nervine Differentials', 210),

    -- Q22: Passionflower differential
    ('BHC - Class 52 - Nervous System III and Plant Chemistry',
     'Which nervine differential describes Passionflower''s specific mental pattern?',
     'Frayed nervous system from long-term exhaustion',
     'Constant worry leading to headaches and insomnia',
     'Circular thinking, helps mind disconnect (like a radio playing in your head)',
     'Overwhelm from external sensory stimuli',
     'c',
     'Passionflower is indicated for circular thinking and helps the mind disconnect — the classic image is a "radio playing in your head."',
     'Passionflower — circular thinking, helps mind disconnect (like a "radio playing in your head").',
     'Nervine Differentials', 220),

    -- Q23: Chamomile differential
    ('BHC - Class 52 - Nervous System III and Plant Chemistry',
     'Which nervine is described as being for "whiney babies of all ages" in the differentials?',
     'Catnip',
     'Chamomile',
     'Lemon Balm',
     'Lavender',
     'b',
     'Chamomile is described as for whiney "babies of all ages" — the irritable, fussy, over-reactive presentation.',
     'Chamomile — for whiney "babies of all ages"; irritable, fussy, over-reactive presentation.',
     'Nervine Differentials', 230),

    -- Q24: Lavender differential
    ('BHC - Class 52 - Nervous System III and Plant Chemistry',
     'Lavender is described as "a hug in a bottle" — what symptom complex is it indicated for in the differentials?',
     'Stress-induced stomach heat and over-thinking',
     'Headaches, anxiety, insomnia and depression from constant worry',
     'Fried and frazzled with tendency to palpitations',
     'Moody and lethargic with GI depression',
     'b',
     'Lavender is the "hug in a bottle" for headaches, anxiety, insomnia, and depression that comes from constant worry.',
     'Lavender — headaches, anxiety, insomnia and depression that comes from constant worry; "hug in a bottle".',
     'Nervine Differentials', 240),

    -- Q25: Motherwort differential
    ('BHC - Class 52 - Nervous System III and Plant Chemistry',
     'Motherwort''s nervine differential pattern is "fried and frazzled" — what additional characteristic distinguishes it?',
     'Stress-induced stomach heat and over-planning',
     'Frayed nervous system from long-term depletion',
     'Tendency to palpitations and heart stress with hormonal-induced stress',
     'Nerves causing cardiovascular heat without hormonal component',
     'c',
     'Motherwort is for the fried and frazzled patient with a tendency to palpitations, heart stress, and hormonal-induced stress.',
     'Motherwort - fried and frazzled with a tendency to palpitations and other heart stress – hormonal induced stress',
     'Nervine Differentials', 250),

    -- Q26: Linden Flower differential
    ('BHC - Class 52 - Nervous System III and Plant Chemistry',
     'Linden Flower in the nervine differentials is indicated when nerves cause which cardiovascular symptoms?',
     'Hypertension and arrhythmia',
     'Cardiovascular heat and palpitations',
     'Chest pain and shortness of breath',
     'Cold extremities and Raynaud''s phenomenon',
     'b',
     'Linden Flower is indicated when nerves cause cardiovascular heat and palpitations — as distinct from Motherwort which also has a hormonal component.',
     'Linden Flower – nerves causing cardio heat and palpitations',
     'Nervine Differentials', 260),

    -- Q27: Milky Oats differential
    ('BHC - Class 52 - Nervous System III and Plant Chemistry',
     'What is Milky Oats'' primary indication in the nervine differentials?',
     'Circular thinking and racing thoughts',
     'Frayed nervous systems — long-term nervous exhaustion and depletion',
     'Stress-induced stomach heat',
     'Sensory overwhelm from lights and noises',
     'b',
     'Milky Oats is for frayed nervous systems — long-term nervous exhaustion and depletion, not just acute stress.',
     'Milky Oats — frayed nervous systems; long-term nervous exhaustion and depletion.',
     'Nervine Differentials', 270),

    -- Q28: Lemon Balm differential
    ('BHC - Class 52 - Nervous System III and Plant Chemistry',
     'Lemon Balm in the differentials is described as uplifting but relaxing — what is its distinguishing patient type?',
     'The over-planner with stomach heat',
     'The person with constant worry causing headaches',
     'The person who can''t stop going; great for infection-induced stress',
     'The patient with disillusionment and jaw tension',
     'c',
     'Lemon Balm is for the person who can''t stop going — uplifting but relaxing, and particularly great for infection-induced stress.',
     'Lemon Balm – uplifting but relaxing - for the person who can''t stop going - great for infection induced stress',
     'Nervine Differentials', 280),

    -- Q29: Hawthorn spirit remedy
    ('BHC - Class 52 - Nervous System III and Plant Chemistry',
     'In the spirit remedies section, Hawthorn is used for what specific quality?',
     'Processing grief and moving through loss',
     'Pattern interruption for addictive behavior',
     'Restoring sparkle in the eyes',
     'Courage and strength of the heart',
     'd',
     'Hawthorn is the spirit remedy for courage and strength of the heart — building heart resilience at a spirit level.',
     'Hawthorn — courage and strength of the heart; spirit remedy.',
     'Spirit Remedies', 290),

    -- Q30: Reishi spirit remedy
    ('BHC - Class 52 - Nervous System III and Plant Chemistry',
     'In the spirit remedies, Reishi is described as "inviting the light back in" — what quality does it restore?',
     'The courage to face difficult emotions',
     'Joy and collective happiness',
     'The sparkle in the eyes',
     'Groundedness and connection to roots',
     'c',
     'Reishi as a spirit remedy "invites the light back in" and restores the sparkle in the eyes — a deep restorative quality among adaptogens.',
     'Reishi — invite the light back in; restores the sparkle in the eyes; spirit remedy.',
     'Spirit Remedies', 300)
    ;
END $$;
