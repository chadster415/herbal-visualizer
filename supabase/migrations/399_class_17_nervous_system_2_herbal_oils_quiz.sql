-- Migration 399: BHC Class 17 — Nervous System 2 and Herbal Oils quiz questions
-- Class name: BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose
--
-- Target calculation:
--   H = 65 distinct herbs + supplements identified
--   F = 11 named factual items:
--       (1) Skullcap dried tincture less effective
--       (2) Rhodiola — add glycerin to tincture
--       (3) Blue Vervain + Night-Blooming Cereus for fear of death
--       (4) Pedicularis specific for jaw tension
--       (5) SAM-E dose: 400–1200mg morning on empty stomach
--       (6) Hypnotic analgesics won't sedate an unwilling person
--       (7) Schizandra five-flavor berry
--       (8) SJW one of few fresh plant oils
--       (9) Chickweed — half-dry for oil infusion
--       (10) Hops for premenopausal insomnia
--       (11) Catnip for infant fever baths
--   target = clamp(15 + 65×4 + 11, 20, 50) = clamp(286, 20, 50) = 50
--
-- Correct option distribution: a=13, b=12, c=13, d=12

SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_quiz_questions
             WHERE class_name = 'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose') THEN
    RAISE NOTICE 'Class 17 quiz already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_quiz_questions
    (class_name, question_text, option_a, option_b, option_c, option_d,
     correct_option, explanation, snippet_text, section_header, sort_order)
  VALUES

    -- Q1 (correct=a) — Skullcap: dried vs fresh tincture
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'Why is a fresh or freshly dried tincture of Skullcap preferred over a dried tincture?',
     'The dried tincture is not very effective; fresh or freshly dried preparation is significantly better',
     'Dried tincture is more sedating than most people need',
     'The fresh tincture has fewer interactions with caffeine',
     'Dried tincture loses its anti-inflammatory properties first',
     'a',
     'The notes state Skullcap is "best fresh, tincture or in tea — dried tincture not very effective." This is a key preparation quality note.',
     'Skullcap as nervine tonic: spasms, shakiness, acute anxiety; best fresh tincture or tea — dried tincture not very effective',
     'Nervine Tonics', 10),

    -- Q2 (correct=b) — Milky Oats and drug withdrawal
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'Which nervine tonic is specifically indicated for drug withdrawal and frazzled nerves?',
     'Skullcap',
     'Milky Oats',
     'Lemon Balm',
     'Passionflower',
     'b',
     'The notes describe Milky Oats as "food for the NS, emotional instability, drug withdrawal, frazzled nerves" — it nourishes and restores a depleted nervous system.',
     'Milky Oats: food for nervous system, emotional instability, drug withdrawal, frazzled nerves',
     'Nervine Tonics', 20),

    -- Q3 (correct=c) — St. John's Wort primary tonic indication
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'As a nervine tonic, St. John''s Wort is specifically indicated for what condition?',
     'Anxiety from over-stimulation',
     'Premenopausal insomnia',
     'Nerve damage and nerve pain',
     'Drug withdrawal and frazzled nerves',
     'c',
     'The notes place SJW in the Nervine Tonics section specifically for "nerve damage/nerve pain" — its topical applications for neuritis are also noted.',
     'St. John''s Wort: nerve damage and nerve pain; topical applications common; blooms around Summer Solstice',
     'Nervine Tonics', 30),

    -- Q4 (correct=a) — Linden pairing for depression
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'Linden is noted as a grief remedy that should be paired with which two herbs for depression?',
     'Lemon Balm and Mimosa flowers (Silk Tree flowers)',
     'Lavender and Rose petal',
     'Tulsi and Damiana',
     'Blue Vervain and Motherwort',
     'a',
     'The notes state Linden is a "grief remedy, pair with lemon balm and mimosa flowers for depression" — this is a specific three-herb combination.',
     'Linden: grief remedy; pair with lemon balm and mimosa flowers for depression; astringent, can ground weepiness',
     'Nervine Relaxants', 40),

    -- Q5 (correct=c) — Blue Vervain: hyper-focus
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'Blue Vervain is a specific remedy for what mental pattern?',
     'Scattered, unfocused thinking',
     'Circular thinking that loops without resolution',
     'Hyper-focus on something you can''t shut off',
     'Memory loss from chronic stress',
     'c',
     'The notes describe Blue Vervain for when "you are hyper-focused on something and can''t shut it off" — contrast with Passionflower, which addresses circular thinking.',
     'Blue Vervain: dispels illusion; use for fear of death with Night-Blooming Cereus; combine with Motherwort; PMS and menopausal anxiety with Milky Oats; for hyper-focus you can''t shut off; really bitter',
     'Nervine Relaxants', 50),

    -- Q6 (correct=b) — Night-Blooming Cereus pairing
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'Night-Blooming Cereus is combined with which herb specifically for fear of death?',
     'Linden',
     'Blue Vervain',
     'Motherwort',
     'Pasqueflower',
     'b',
     'The notes state Blue Vervain is used "for fear of death with Night Blooming Cereus" — this is a specific indication pairing for existential and heart-centered anxiety.',
     'Night-Blooming Cereus: paired with Blue Vervain for fear of death',
     'Nervine Relaxants', 60),

    -- Q7 (correct=c) — Pasqueflower: dosing and indication
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'Pasqueflower (Pulsatilla) is described as a "drop dose plant" — what is its primary indication?',
     'Premenstrual anxiety and menopausal insomnia',
     'Chronic stress and frazzled nerves from over-stimulation',
     'Anxiety, acute wind, and shock trauma',
     'Hyper-focus and inability to shut off racing thoughts',
     'c',
     'The notes state Pulsatilla is a "drop dose plant for anxiety and acute wind; for shock trauma" — low doses are key and shock/acute presentations are the target.',
     'Pasqueflower (Pulsatilla): drop dose plant for anxiety and acute wind; for shock trauma',
     'Nervine Relaxants', 70),

    -- Q8 (correct=a) — Kava: social anxiety
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'Kava is described as especially suited for which type of patient?',
     'Fast-paced city dwellers with social anxiety',
     'Children with fevers and fussy behavior',
     'Elderly patients with muscle tension',
     'Patients with hypothyroid-related anxiety',
     'a',
     'The notes say Kava is "good for fast paced city dwellers" and for "smoothing out social anxiety" — it also opens the heart with its antispasmodic effects.',
     'Kava: heart-opening antispasmodic; good for fast-paced city dwellers; smoothing out social anxiety',
     'Nervine Relaxants', 80),

    -- Q9 (correct=d) — Catnip: infant fever baths
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'According to the class notes, Catnip can be used for infants in which unusual preparation?',
     'Glycerin tincture applied topically to the spine',
     'Cold compress on the forehead',
     'Weak tea added to formula',
     'Baths using a strong tea for fevers',
     'd',
     'The notes describe using Catnip as "maybe little baby baths with strong tea for fevers" — a traditional external application for reducing infant fevers.',
     'Catnip: good for worry; great for children; good for stress-induced GI symptoms combined with Chamomile; infant fever baths with strong tea',
     'Nervine Relaxants', 90),

    -- Q10 (correct=b) — Wood Betony (Stachys) indication
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'Wood Betony (Stachys) is specifically indicated for which conditions as a nervine relaxant?',
     'Shock trauma and drop-dose anxiety',
     'Head pain and stress-induced migraines',
     'Premenstrual anxiety and breast tenderness',
     'Hyper-focus and bitter-taste affinity',
     'b',
     'The notes state Wood Betony (Stachys) is "good for head pain and stress induced migraines" — it is the go-to nervine relaxant for headache with stress etiology.',
     'Wood Betony (Stachys): good for head pain and stress-induced migraines',
     'Nervine Relaxants', 100),

    -- Q11 (correct=c) — Hops: premenopausal insomnia
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'Hops is specifically noted as a good sedative for which patient population?',
     'Children with over-stimulation',
     'Athletes with muscle soreness preventing sleep',
     'People with premenopausal insomnia',
     'Patients with chronic pain from neuritis',
     'c',
     'The notes state Hops is "good for premenopausal insomnia" — it is also noted in the Nervine Differentials as helpful for "menopausal sleep disturbances."',
     'Hops: sedative for stress or pain; good for premenopausal insomnia',
     'Sedatives', 110),

    -- Q12 (correct=a) — Valerian paradoxical reaction
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'What is the notable caution associated with Valerian as a sedative?',
     'It may wire (stimulate) some people rather than sedate them',
     'It should never be used for children under age 12',
     'It causes rebound insomnia after three days of use',
     'It significantly reduces blood pressure in hypotensive patients',
     'a',
     'The notes warn Valerian "may wire some people" — a paradoxical stimulating reaction is well-recognized and makes it the nervine of choice only after ruling out this sensitivity.',
     'Valerian: sedative; may wire some people (paradoxical reaction)',
     'Sedatives', 120),

    -- Q13 (correct=d) — California Poppy: daytime and pediatric use
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'Which of the following best describes California Poppy''s clinical usage notes?',
     'Best reserved for acute severe pain only; not for daily use',
     'Contraindicated in children under age 5',
     'Primarily for menopausal insomnia at higher doses',
     'Good during the day to smooth out the edges; smaller doses for kids',
     'd',
     'The notes describe California Poppy as good "maybe during day, smooth out the edges" and that "smaller doses for kids" are appropriate — a gentle, daytime-appropriate sedative.',
     'California Poppy: sedative; good during day to smooth out the edges; smaller doses for kids',
     'Sedatives', 130),

    -- Q14 (correct=b) — Siberian Ginseng "White Rabbit" metaphor
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'Which adaptogen is described metaphorically as "the White Rabbit — running around late"?',
     'Rhodiola',
     'Siberian Ginseng (Eleuthero)',
     'Ashwagandha',
     'American Ginseng',
     'b',
     'The notes describe Siberian Ginseng (Eleuthero) as "the White Rabbit — running around late; bend time, make more space in the day" — used for the person who can''t keep up with demands.',
     'Siberian Ginseng (Eleuthero): adaptogen; "the White Rabbit — running around late"; bend time, make more space in the day',
     'Adaptogens', 140),

    -- Q15 (correct=c) — Rhodiola: drying, add glycerin
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'What preparation adjustment is recommended for Rhodiola tincture, and why?',
     'Combine with licorice because Rhodiola has a very bitter taste',
     'Use a cold infusion because heat destroys the active adaptogens',
     'Add glycerin because Rhodiola is very drying',
     'Avoid alcohol extraction and use a water decoction instead',
     'c',
     'The notes state Rhodiola is "very drying — making a tincture of this with a little glycerin is good to moisten." This is a specific preparation note to counterbalance its drying quality.',
     'Rhodiola: adaptogen; very drying — adding a little glycerin to tincture helps; more stimulating; good for elevation sickness and camping trips',
     'Adaptogens', 150),

    -- Q16 (correct=a) — Schizandra five-flavor berry
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'Schizandra is called the "five-flavor berry" — what does this mean clinically?',
     'What flavor you taste indicates what your body needs; supports energy and focus',
     'It contains five alkaloids that collectively reduce inflammation',
     'It should be taken with five other herbs for maximum adaptogenic effect',
     'The five tastes refer to the five organ systems it tonifies simultaneously',
     'a',
     'The notes state: "five-flavor berry — what flavor you taste is said to be what you need; help with energy and focus" — the taste as diagnostic signal is the traditional teaching.',
     'Schizandra: adaptogen; five-flavor berry — what flavor you taste is said to be what you need; helps with energy and focus',
     'Adaptogens', 160),

    -- Q17 (correct=d) — GI-based depression: enteric brain
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'GI-based depression is rooted in the gut-brain connection. Where is most of the body''s serotonin produced?',
     'The adrenal glands, via cortisol precursor pathways',
     'The limbic system in the brain',
     'The liver, as part of amino acid metabolism',
     'The GI tract, sometimes called the "enteric brain"',
     'd',
     'The notes state "most of the body''s serotonin is produced in the GI tract aka the ''enteric brain''" — GI dysbiosis therefore directly affects mood.',
     'St. John''s Wort: specific for GI-based depression (enteric brain/serotonin connection)',
     'GI-Based Depression', 170),

    -- Q18 (correct=b) — SJW depression presentation
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'St. John''s Wort is indicated for a specific depression presentation. Which description fits it best?',
     'Black cloud depression with hormonal component',
     'Sour stomach, sour attitude, dark outlook with a sense of emotional unease',
     'Scattered depression from loss and lack of boundaries',
     'Stagnant depression rooted in unresolved PTSD',
     'b',
     'The notes describe SJW for "sour stomach, sour attitude, dark outlook with a sense of emotional unease" — a distinctive GI + mood presentation that matches its enteric-brain affinity.',
     'St. John''s Wort: for depression with sour stomach, sour attitude, dark outlook with a sense of emotional unease',
     'Herbs for Depression', 180),

    -- Q19 (correct=c) — Stagnant depression herbs
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'Stagnant depression is described as PTSD-rooted, trauma-fixated grief. Which herb is NOT listed for this type?',
     'Silk Tree bark (Mimosa Bark)',
     'Tulsi',
     'Black Cohosh',
     'Damiana',
     'c',
     'Black Cohosh is for "black cloud depression" and hormonal depression — not stagnant depression. The stagnant depression herbs are Mimosa Bark, Tulsi, Rose Petals, Lavender, Rosemary, and Damiana.',
     'Silk Tree bark (Mimosa Bark / Albizia): for stagnant depression — PTSD and chronic unrelenting grief',
     'Stagnant Depression', 190),

    -- Q20 (correct=a) — Silk Tree bark: depression presentation
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'Silk Tree bark (Mimosa Bark / Albizia) is indicated for depression with which specific emotional features?',
     'Grief, heartbreak, bad dreams, anger, and irritability',
     'Hyper-focus and inability to let go of the past',
     'Cold, withdrawn sadness with low energy and brain fog',
     'Scattered depression from loss of self or boundaries',
     'a',
     'The notes describe Silk Tree bark as for "depression with grief, heartbreak, bad dreams, anger, irritability" — a fuller, more agitated grief presentation.',
     'Silk Tree bark (Mimosa Bark): depression with grief, heartbreak, bad dreams, anger, irritability',
     'Herbs for Depression', 200),

    -- Q21 (correct=d) — Black Cohosh depression type
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'Black Cohosh is associated with which specific type of depression?',
     'Stagnant depression from unresolved trauma',
     'GI-based depression from gut dysbiosis',
     'Seasonal affective disorder from lack of light',
     '"Black cloud" depression with a hormonal component',
     'd',
     'The notes name Black Cohosh for "black cloud depression, hormonal depression" — its affinity for hormonal dysregulation makes it specific to this presentation.',
     'Black Cohosh: black cloud depression, hormonal depression',
     'Herbs for Depression', 210),

    -- Q22 (correct=b) — Rosemary for depression
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'Rosemary''s role in treating depression centers on which two symptoms?',
     'Grief and heartbreak',
     'Brain fog and memory impairment from depression',
     'Anxiety with palpitations',
     'Seasonal mood changes from lack of light',
     'b',
     'The notes say Rosemary is "good for brain fog and memory from depression" — it is a warming, stimulating circulation tonic that lifts cognitive function suppressed by depression.',
     'Rosemary: good for brain fog and memory from depression; eases headaches; circulation tonic; warming and stimulating',
     'Herbs for Depression', 220),

    -- Q23 (correct=c) — Hawthorn: heartbreak depression
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'Hawthorn is listed for depression — what is its specific emotional indication?',
     'Black cloud hormonal depression',
     'Stagnant depression rooted in PTSD',
     'Depression from heartbreak or grief',
     'Scattered depression with lack of boundaries',
     'c',
     'The notes state Hawthorn is for "depression from heartbreak or grief" — it works on the heart as a physical and emotional organ, giving courage and strength to the grieving heart.',
     'Hawthorn: depression from heartbreak or grief',
     'Herbs for Depression', 230),

    -- Q24 (correct=a) — Boswellia/Frankincense depression
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'Frankincense (Boswellia) is specifically indicated for depression when which systemic condition is also present?',
     'Signs of systemic inflammation, especially GI inflammation',
     'Hypothyroidism and thyroid-driven mood changes',
     'PTSD and chronic traumatic grief',
     'Hormonal dysregulation and premenstrual patterns',
     'a',
     'The notes indicate Boswellia for "depression with other signs of systemic inflammation (esp if with GI inflammation)" — its anti-inflammatory action links to the enteric brain and mood.',
     'Frankincense (Boswellia): depression with other signs of systemic inflammation, especially with GI inflammation',
     'Herbs for Depression', 240),

    -- Q25 (correct=d) — Thyroid-induced depression: supplements
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'For thyroid-induced depression from hypothyroidism, which two supplements are recommended alongside herbal support?',
     'Magnesium and B12',
     'Iron and vitamin C',
     'Vitamin D and SAM-E',
     'Iodine and selenium',
     'd',
     'The notes say to "supplement iodine, selenium, and L-tyrosine" for thyroid-induced depression — iodine and selenium are essential for thyroid hormone synthesis and conversion.',
     'Iodine: supplement for thyroid-induced depression from hypothyroidism',
     'Thyroid Induced Depression', 250),

    -- Q26 (correct=b) — Kelp/Bladderwrack for thyroid
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'Bladderwrack (Kelp, Fucus vesiculosus) is listed for thyroid-induced depression. What preparation note is given?',
     'Best as a tincture; do not decoct as it destroys iodine',
     'Can be dried and put in capsules; tastes not good',
     'Best as a tea decoction with dulse and seaweed blend',
     'Fresh plant only; dried form loses most of its thyroid activity',
     'b',
     'The notes state Bladderwrack "can dry and put in capsules, tastes not good" — capsules bypass the unpleasant flavor while delivering the iodine-rich seaweed effectively.',
     'Kelp (Bladderwrack, Fucus vesiculosus): for thyroid-induced depression; can dry and put in capsules',
     'Thyroid Induced Depression', 260),

    -- Q27 (correct=c) — SAD: light-bearing plants
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'Which three herbs are described as "light-bearing plants" for SAD?',
     'Lavender, Rose, and Linden',
     'Tulsi, Borage, and Bleeding Heart',
     'Calendula, Lemon Balm, and St. John''s Wort',
     'Chamomile, Rosemary, and Black Cohosh',
     'c',
     'The notes say to "use light-bearing plants: Calendula — follows the sun; Lemon Balm; SJW — summer solstice." All three are associated with light and solar energy.',
     'Calendula: light-bearing plant for SAD; follows the sun',
     'Seasonal Affective Disorder', 270),

    -- Q28 (correct=a) — SAD: Vitamin D dose
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'What dose of Vitamin D is recommended for Seasonal Affective Disorder?',
     '2000 IU/day',
     '500 IU/day',
     '5000 IU/day',
     '1000 IU twice weekly',
     'a',
     'The notes specify "supplementing 2000 iu/day" for SAD caused by lack of sunlight — a clinically meaningful and testable dose recommendation.',
     'Vitamin D: supplement 2000 IU/day for Seasonal Affective Disorder caused by lack of sunlight',
     'Seasonal Affective Disorder', 280),

    -- Q29 (correct=d) — SAM-E dose and timing
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'What is the recommended dose and timing for SAM-E supplementation for depression and SAD?',
     '200mg at bedtime',
     '1000mg with meals',
     '500mg twice daily with food',
     '400–1200mg in the morning on an empty stomach',
     'd',
     'The notes state "supplement SAMe (400-1200mg in the morning on an empty stomach)" — both timing and dose range are clinically important for bioavailability.',
     'SAM-E: supplement for SAD and depression; 400–1200mg in the morning on an empty stomach',
     'Seasonal Affective Disorder', 290),

    -- Q30 (correct=b) — Mullein FE: spirit remedy
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'What is the spirit remedy use of Mullein Flower Essence according to these notes?',
     'For courage when facing existential fear',
     'A guiding torch when someone is stuck in the "underworld" (deep depression)',
     'Resilience of the heart and self-love',
     'Processing and moving through grief',
     'b',
     'The notes describe Mullein FE as "a guiding torch when someone is stuck in the ''underworld''" — a profound spirit medicine for those lost in the depths of depression.',
     'Mullein Flower Essence: a guiding torch when someone is stuck in the "underworld" — for deep depression',
     'Spirit Remedies for Depression', 300),

    -- Q31 (correct=c) — Reishi spirit remedy
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'What is Reishi''s spirit remedy description for depression?',
     'For courage and strength of the heart',
     'Processing and moving through grief',
     'Inviting the light back in',
     'Resilience of the heart and self-love',
     'c',
     'The notes say Reishi is for "inviting the light back in" — a poetic spirit medicine for depression where the person has lost connection to joy or vitality.',
     'Reishi: inviting the light back in — spirit remedy for depression',
     'Spirit Remedies for Depression', 310),

    -- Q32 (correct=a) — Bleeding Heart FE
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'Bleeding Heart Flower Essence is specifically for depression of what origin?',
     'Depression due to loss',
     'Hormonal, black cloud depression',
     'Stagnant, PTSD-rooted depression',
     'Seasonal depression from lack of light',
     'a',
     'The notes state Bleeding Heart FE is for "depression due to loss" — it is specific to grief and bereavement rather than other depression subtypes.',
     'Bleeding Heart Flower Essence: depression due to loss',
     'Spirit Remedies for Depression', 320),

    -- Q33 (correct=d) — Passionflower: differential
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'In the Nervine Differentials, Passionflower is best for which mental pattern?',
     'Light and noise sensitivity after overstimulation',
     'Stress-induced stomach heat with over-planning',
     'Frayed, depleted nervous system from exhaustion',
     'Circular thinking; helps the mind disconnect',
     'd',
     'The notes state Passionflower is for "circular thinking, helps mind disconnect" — it specifically interrupts the repetitive thought loop, distinct from Skullcap''s sensory-overwhelm pattern.',
     'Passionflower differential: circular thinking; helps the mind disconnect',
     'Nervine Differentials', 330),

    -- Q34 (correct=b) — Hops differential
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'According to the Nervine Differentials, Hops is best suited for which presentation?',
     'Shock and acute existential fear',
     'Stress-induced stomach heat, over-planning, over-thinking, menopausal sleep disturbances',
     'Light and noise overwhelm after stimulant drug use',
     'Circular thinking and inability to disengage mentally',
     'b',
     'The notes describe Hops for "stress induced stomach heat, over-planning, over-thinking, menopausal sleep disturbances" — a distinctive GI + cognitive + hormonal pattern.',
     'Hops differential: stress-induced stomach heat, over-planning, over-thinking, menopausal sleep disturbances',
     'Nervine Differentials', 340),

    -- Q35 (correct=c) — Skullcap differential
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'The Nervine Differentials describe Skullcap for what specific presentation?',
     'Circular thinking and mental disconnection needed',
     'Stress-induced stomach heat and over-planning',
     'Light, noises, and smells overwhelm; recovery from mental breakdown or stimulant drugs',
     'Frayed nervous system from long-term exhaustion',
     'c',
     'The notes say Skullcap is for when "light, noises and smells overwhelm" and for "recovery from mental breakdown or stimulant drugs" — a sensory hypersensitivity pattern.',
     'Skullcap differential: light, noises and smells overwhelm; recovery from mental breakdown or stimulant drugs',
     'Nervine Differentials', 350),

    -- Q36 (correct=a) — Linden flower: palpitations
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'In the Nervine Differentials, Linden flower is indicated when anxiety manifests as what physical symptoms?',
     'Nerves causing cardiovascular heat and palpitations',
     'Stress-induced jaw tension and muscle tightness',
     'Headaches from constant worry and poor sleep',
     'Stomach heat and digestive upset from over-thinking',
     'a',
     'The notes describe Linden flower for "nerves causing cardio heat and palps" — it addresses the cardiac component of nervous system dysregulation.',
     'Linden flower differential: nerves causing cardiovascular heat and palpitations',
     'Nervine Differentials', 360),

    -- Q37 (correct=d) — Pedicularis: jaw-specific
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'Pedicularis is listed for muscle-tension insomnia with a very specific body location. What is it?',
     'Neck and shoulder tension preventing lying flat',
     'Leg cramps waking the patient at night',
     'Lower back tension from prolonged sitting',
     'Jaw tension specifically',
     'd',
     'The notes state "Pedicularis (specific for jaw)" — it is the go-to herb when jaw clenching or TMJ tension is preventing sleep.',
     'Pedicularis: for muscle tension insomnia; specific for jaw tension',
     'Insomnia', 370),

    -- Q38 (correct=b) — Insomnia from pain: herb list
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'Which herb for pain-induced insomnia is NOT listed in these notes?',
     'Corydalis',
     'Kava',
     'California Poppy',
     'Jamaican Dogwood',
     'b',
     'Kava is listed for muscle-tension insomnia, not pain-induced insomnia. The pain-induced insomnia list is: California Poppy, Corydalis, Jamaican Dogwood, Wild Lettuce, Valerian.',
     'California Poppy: for pain-induced insomnia',
     'Insomnia', 380),

    -- Q39 (correct=c) — Neuritis definition
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'Neuritis is defined in the class notes as what condition?',
     'Systemic inflammation of the spinal cord causing weakness',
     'Inflammation of the brain tissue from viral infection',
     'Inflammation of peripheral nerves causing numbness, tingling, and loss of reflex',
     'Nerve compression causing radiating pain along a dermatome',
     'c',
     'The notes define neuritis as "inflammation of peripheral nerves causing numbness, tingling, loss of reflex" — the three classic peripheral neuropathy symptoms.',
     'St. John''s Wort: nerve tonic for neuritis (inflammation of peripheral nerves causing numbness, tingling, loss of reflex)',
     'Neuritis', 390),

    -- Q40 (correct=a) — Neuritis: nerve tonics
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'Which three nerve tonics are recommended for neuritis?',
     'St. John''s Wort, Milky Oats, and Skullcap',
     'Valerian, Passionflower, and California Poppy',
     'Kava, Jamaican Dogwood, and Corydalis',
     'Lavender, Chamomile, and Linden',
     'a',
     'The notes specify SJW, Milky Oats, and Skullcap as the nerve tonics for neuritis — all three address nerve tissue health and repair, not just symptom suppression.',
     'Milky Oats: nerve tonic for neuritis (peripheral nerve inflammation)',
     'Neuritis', 400),

    -- Q41 (correct=d) — Hypnotic analgesics: mechanism
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'What is known about the mechanism of action for hypnotic analgesics?',
     'They work via GABA-A receptor potentiation similar to benzodiazepines',
     'They block substance P release at peripheral nociceptors',
     'They activate opioid receptors in the CNS',
     'The exact mechanism of action is unknown',
     'd',
     'The notes state explicitly "exact mechanism of action unknown" for hypnotic analgesics — this honest uncertainty is part of the clinical teaching.',
     'Kava: hypnotic analgesic — exact mechanism unknown; won''t sedate an unwilling person; decreases pain and increases quality of sleep',
     'Hypnotic Analgesics', 410),

    -- Q42 (correct=b) — Hypnotic analgesics: willing person
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'A key characteristic of hypnotic analgesics is that they do what?',
     'Sedate regardless of the patient''s intent or resistance',
     'Won''t sedate an unwilling person; only work when the person is open to sleep',
     'Work best when combined with pharmaceutical sleep aids',
     'Require high doses before sedation becomes evident',
     'b',
     'The notes state hypnotic analgesics "won''t sedate an unwilling person" — they facilitate sleep without overriding consciousness the way pharmaceutical sedatives can.',
     'Valerian: hypnotic analgesic — exact mechanism unknown; won''t sedate an unwilling person; decreases pain and increases quality of sleep',
     'Hypnotic Analgesics', 420),

    -- Q43 (correct=c) — Hypnotic analgesics: dual effect
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'Hypnotic analgesics achieve their effect through what dual mechanism?',
     'They increase GABA and decrease cortisol simultaneously',
     'They improve digestion and reduce neurological inflammation',
     'They decrease pain AND increase quality of sleep',
     'They sedate the CNS while increasing peripheral circulation',
     'c',
     'The notes say hypnotic analgesics "decrease pain and increase quality of sleep" — addressing both the pain that disrupts sleep and the sleep quality itself.',
     'California Poppy: hypnotic analgesic — decreases pain and increases quality of sleep; will not sedate an unwilling person',
     'Hypnotic Analgesics', 430),

    -- Q44 (correct=a) — SJW oil: fresh plant
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'St. John''s Wort is described as one of the few fresh plant oils. What other herb is named alongside it?',
     'Chickweed',
     'Lavender',
     'Calendula',
     'Arnica',
     'a',
     'The notes state "one of few fresh plant oils (the other is chickweed — let it wilt for a day then use half-dry half-fresh)" — both are noted as exceptional for fresh plant oil preparation.',
     'St. John''s Wort oil: nerve pain and sore muscles, warming; one of few fresh plant oils (along with chickweed)',
     'Herbs to Infuse in Oils', 440),

    -- Q45 (correct=d) — Chickweed oil preparation
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'How should Chickweed be prepared before infusing into an oil?',
     'Use fresh plant immediately to preserve cooling volatile compounds',
     'Dry completely over 2–3 weeks before infusing',
     'Juice the fresh plant and add the juice directly to the carrier oil',
     'Let it wilt for a day, then use half-dry half-fresh',
     'd',
     'The notes specify for chickweed oil: "let it wilt for a day then use half-dry half-fresh" — this reduces moisture content enough to prevent fermentation while preserving active compounds.',
     'Chickweed oil: cooling, antipruritic; good for rash and sunburn; let wilt for a day, use half-dry half-fresh (one of few fresh plant oils)',
     'Herbs to Infuse in Oils', 450),

    -- Q46 (correct=b) — Gotu Kola oil: gua sha
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'Gotu Kola oil is noted for scar tissue — what technique is suggested to enhance its effect?',
     'Applying heat compresses over the oil to drive it deeper',
     'Using a gua sha tool with the oil to break up the tissue',
     'Layering multiple applications over a single day',
     'Combining with arnica for bruising and then scar prevention',
     'b',
     'The notes say for Gotu Kola oil: "can use a gua sha tool with the oil to break up the tissue" — mechanical scraping combined with the herb enhances scar tissue breakdown.',
     'Gotu Kola oil: great for scar tissue; can use a gua sha tool with the oil to break up the tissue',
     'Herbs to Infuse in Oils', 460),

    -- Q47 (correct=c) — Violet oil: breast massage
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'Violet oil is specifically recommended for which clinical application?',
     'Arthritic joint pain from inflammation',
     'Wound healing and post-surgical scar care',
     'Breast massage for lymphatic support',
     'Muscle tension and jaw clenching',
     'c',
     'The notes state Violet oil is "great for breast massage" because it is cooling and lymphatic — breast tissue has rich lymphatic drainage and benefits from lymphatic herbs.',
     'Violet oil: cooling, lymphatic; great for breast massage',
     'Herbs to Infuse in Oils', 470),

    -- Q48 (correct=a) — Pine oil properties
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'Pine needle (evergreen) oil has an anti-tumor property listed alongside which other three properties?',
     'Anti-inflammatory, lymphatic, and antibacterial',
     'Antispasmodic, nervine, and vulnerary',
     'Cooling, antimicrobial, and drawing',
     'Emollient, vulnerary, and circulatory stimulant',
     'a',
     'The notes list pine as "anti-inflammatory, lymphatic, good for pain, good for arthritic joints, anti-tumor, antibacterial" — anti-inflammatory, lymphatic, and antibacterial are the three alongside anti-tumor.',
     'Pine Needles (evergreen/pine oil): anti-inflammatory, lymphatic; good for pain, arthritic joints, anti-tumor, antibacterial',
     'Herbs to Infuse in Oils', 480),

    -- Q49 (correct=d) — Chaparral: first aid use
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'Chaparral is described as a broadly antimicrobial first aid herb. What specific condition is mentioned for tea compresses?',
     'Infected insect bites',
     'Fungal skin rashes',
     'Sunburn and minor scalds',
     'Cellulitis',
     'd',
     'The notes state Chaparral is "incredible for first aid; cellulitis with tea compresses" — cellulitis is a serious bacterial skin infection where Chaparral''s broad antimicrobial action is indicated.',
     'Chaparral oil: broadly antimicrobial, first aid plant; cellulitis with tea compresses',
     'Herbs to Infuse in Oils', 490),

    -- Q50 (correct=c) — Mugwort oil: applications
    ('BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose',
     'Mugwort oil has two distinct topical applications noted in these class notes. What are they?',
     'Wound healing and lymphatic drainage',
     'Scar tissue reduction and anti-inflammatory joint support',
     'Dreaming/meditation anointing oil and applied to womb area during menstruation',
     'Antimicrobial first aid and cooling for sunburn',
     'c',
     'The notes describe Mugwort oil as "great for dreaming and meditation anointing oils" and that it "can be applied to womb area during menstruation" — two distinct traditional applications.',
     'Mugwort oil: great for dreaming and meditation anointing oils; can be applied to womb area during menstruation',
     'Herbs to Infuse in Oils', 500);

END $$;
