-- Migration 225: Class 52 — Nervous System III and Plant Chemistry
-- Files parsed:
--   BHC - Class 52 - Nervous System III and Plant Chemistry - Generated Notes.md (note_type='generated')
--   BHC - Class 52 - Nervous System III and Plant Chemistry - Ashley.md          (note_type='personal')
-- Herb normalisations:
--   Bladderwrack → Kelp (Fucus vesiculosus, id=118) — same species
--   Albizia / mimosa bark or flower → Silk Tree (Albizia julibrissin, id=2285)
--   Red Ginseng → Ginseng (Panax ginseng, id=14)
--   "ash" in Ashley's thyroid list → Ashwagandha (Withania somnifera, id=20)
-- Stubs added in migration 224 (run first):
--   Saffron (Crocus sativus), Guayusa (Ilex guayusa), Velvet Bean (Mucuna pruriens)
-- Skipped (no DB entry needed here):
--   Flower essences (Bleeding Heart FE, Self-Heal FE, Mullein FE) — not herb DB entries
--   Afternoon phytochemistry content — educational constituent science, not herb-ailment pairs
-- New ailment keywords: hypertension, hypothyroidism, seasonal affective disorder
-- New action keywords: GABA support, myelin support, nervine stimulant

SET search_path TO herbal, public;

-- ─────────────────────────────────────────────────────────────────────────────
-- Snippets
-- ─────────────────────────────────────────────────────────────────────────────
DO $$
DECLARE
  v_class        TEXT := 'BHC - Class 52 - Nervous System III and Plant Chemistry';

  -- Stub herb IDs (inserted by migration 224)
  v_saffron_id   INTEGER;
  v_guayusa_id   INTEGER;
  v_mucuna_id    INTEGER;

  -- Source blocks
  v_gen_neuro_block      TEXT;
  v_gen_depression_block TEXT;
  v_gen_spirit_block     TEXT;
  v_per_gaba_block       TEXT;
  v_per_depression_block TEXT;
  v_per_spirit_block     TEXT;
  v_per_differentials_block TEXT;
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets WHERE class_name = 'BHC - Class 52 - Nervous System III and Plant Chemistry') THEN
    RAISE NOTICE 'Class 52 snippets already loaded, skipping';
    RETURN;
  END IF;

  -- Resolve stub IDs
  SELECT id INTO v_saffron_id FROM herbal.herbs WHERE latin_name = 'Crocus sativus' LIMIT 1;
  SELECT id INTO v_guayusa_id FROM herbal.herbs WHERE latin_name = 'Ilex guayusa'  LIMIT 1;
  SELECT id INTO v_mucuna_id  FROM herbal.herbs WHERE latin_name = 'Mucuna pruriens' LIMIT 1;

  -- ── Source blocks ─────────────────────────────────────────────────────────

  v_gen_neuro_block := $blk$## Neurotransmitters

* Herbs promote balance, not specific increases/decreases
* **Milky oats**: supports myelin sheath

### Specific Neurotransmitters

* GABA — inhibitory, promotes relaxation; low levels: anxiety, insomnia, tension
  * **Valerian**, **lemon balm**, **passionflower** influence GABA
* Dopamine — motivation, pleasure, attention; low levels: low motivation, poor concentration
  * **Velvet bean**: boosts dopamine

## Nervine Types

- Nervine tonic, relaxants, stimulants — **Guayusa** as stimulant$blk$;

  v_gen_depression_block := $blk$## Depression

### GI-Based Depression

- Serotonin produced in GI tract — GI depression is moody and lethargic
- Herbs: **saffron**, **St. John's Wort**, **wormwood**

### Stagnant Depression

- Linked to traumatic events; trauma becomes the focus of existence
- Helpful herbs: Mimosa bark or flowers, **rose petals**, **lavender**, **rosemary**, **damiana**

### Thyroid-Related Depression

- Typically from hypothyroidism; symptoms: fatigue, poor memory, feeling cold
- Herbs: **bladderwrack**, **ashwagandha**, **bacopa**

### Seasonal Affective Disorder

- Linked to lack of sunlight; supplement vitamin D
- Light-bearing plants: **calendula**, **lemon balm**, **St. John's Wort**

### Other Depressions

- Black cloud depression (menopausal): **black cohosh**
- Uplifting yet grounding: **tulsi** (BS dysregulation, brain fog, stomach; avoid in severe hypothyroidism)
- Blue Vervain: calms "choppy waters" of the mind; circular thinking, jaw/shoulder tension$blk$;

  v_gen_spirit_block := $blk$## Spiritual and Nervous System Support

- **Albizia** for joy and collective happiness
- **Hawthorn** for courage and heart strength
- **Linden** for processing grief, emotional movement
- Reishi: restores spirit, sparkle in the eyes
- Devil's Club: pattern interruption; regulates blood sugar, protective$blk$;

  v_per_gaba_block := $blk$## GABA
- primary "brake pedal"
- when GABA is low: anxiety, hypervigilance, racing thoughts, insomnia, muscle tension
- herbs:
    - passionflower
    - valerian root
    - lemon balm

## Dopamine
- low: low motivation, fatigue, difficulty initiating tasks, reduced pleasure, poor concentration
- herbs:
    - mucuna (velvet bean) - boosts dopamine
    - adequate sleep
    - recreational drugs can deplete dopamine and serotonin

## Nerve Impulses
- Milky Oats - fresh after harvesting
    - helps re-myelinate the nerve cells$blk$;

  v_per_depression_block := $blk$## GI Based Depression
- GI based depression is moody and lethargic
- herbs:
    - Saffron (tea, 2-3 sepals), SJW, Wormwood (if ready for that underworld energy), Lemon Balm, Chamomile and Catnip
    - saffron contraindicated with SSRIs (Serotonin syndrome possibility)

## Stagnant Depression
- chronic situational depression where a trauma has become the focus of someone's entire existence
- herbs:
    - mimosa bark (stronger, grounding) and / or flower (more uplifting) - 1/2 and 1/2
    - rose petals, lavender, rosemary, damiana

## Thyroid induced depression
- herbs specific for thyroid depression:
    - ash (ashwagandha), bacopa, bladderwrack, damiana and red ginseng

## Seasonal Affective Disorder
- use light bearing plants: Calendula, Lemon Balm and SJW

## Herbs for Depression
- black cohosh - black cloud depression (depression associated with menopause)
- tulsi - uplifting while also grounding; BS dysreg, brain fog and stomach stuff; avoid when hypothyroidism
- damiana - affects hormones - teaches us how to be embodied; tasty - bitter, digestion
- blue vervain - imagine your mind with choppy waters; mist comes in and now the waters are calm; disillusion, presenting in jaw tension$blk$;

  v_per_spirit_block := $blk$## Spirit Remedies
- Mullein FE - guiding torch when stuck in the "underworld"
- Albizia - tree of joy, utilize in all forms
- Hawthorn - for courage and strength of the heart
- Rose - resilience of the heart - self-love
- Linden - for processing and moving through grief, tree of joy and sorrow
- Devils Club - helps with addictive behavior; retracing a pattern over and over again
- Reishi - invite the light back in, restores the sparkle in the eyes$blk$;

  v_per_differentials_block := $blk$## Nervine Differentials
- skullcap for overwhelming lights and noises
- Hops – stress induced stomach heat – over-planning over-thinking
- Valerian – a knocker outer - palliative sedative (be careful can have opposite reaction)
- Passion Flower – circular thinking, helps mind disconnect (radio playing in head)
- Chamomile – whiney "babies of all ages"
- Milky Oats — frayed nervous systems
- Lemon Balm – uplifting but relaxing - for the person who can't stop going - great for infection induced stress
- Lavender – headaches, anxiety, insomnia and depression that comes from constant worry – hug in a bottle
- Motherwort - fried and frazzled with a tendency to palpitations and other heart stress – hormonal induced stress
- Linden Flower – nerves causing cardio heat and palpitations$blk$;

  -- ── Generated snippets ────────────────────────────────────────────────────
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    -- Hypertension
    (90,
     'Linden — white coat hypertension (anxiety-induced high blood pressure); calms nervous tension that drives elevated BP.',
     v_class, 'generated', 'Hypertension', 10, v_gen_neuro_block),

    -- Myelin Support
    (178,
     'Milky Oats — supports the myelin sheath; used for nerve health and re-myelination.',
     v_class, 'generated', 'Myelin Support', 10, v_gen_neuro_block),

    -- GABA Support
    (145,
     'Valerian — influences GABA; promotes relaxation, reduces anxiety and insomnia.',
     v_class, 'generated', 'GABA Support', 10, v_gen_neuro_block),
    (134,
     'Lemon Balm — influences GABA pathways; promotes relaxation and nervous system calm.',
     v_class, 'generated', 'GABA Support', 20, v_gen_neuro_block),
    (137,
     'Passionflower — influences GABA; indicated for anxiety, insomnia, and circular thinking.',
     v_class, 'generated', 'GABA Support', 30, v_gen_neuro_block),

    -- Dopamine Support
    (v_mucuna_id,
     'Velvet Bean (Mucuna pruriens) — boosts dopamine; indicated for low motivation, poor concentration, reduced pleasure.',
     v_class, 'generated', 'Dopamine Support', 10, v_gen_neuro_block),

    -- Nervine Stimulants
    (v_guayusa_id,
     'Guayusa — stimulant nervine; caffeine-bearing plant used for energy and mental clarity.',
     v_class, 'generated', 'Nervine Stimulants', 10, v_gen_neuro_block),

    -- GI-Based Depression
    (81,
     'St. John''s Wort — GI-based depression; indicated when depression is linked to gut dysbiosis or poor serotonin production.',
     v_class, 'generated', 'GI-Based Depression', 10, v_gen_depression_block),
    (97,
     'Wormwood — GI-based depression; bitter digestive with underworld/shadow energy; use when patient is ready for deep work.',
     v_class, 'generated', 'GI-Based Depression', 20, v_gen_depression_block),
    (v_saffron_id,
     'Saffron — GI-based depression; use as tea (2–3 sepals); contraindicated with SSRIs due to serotonin syndrome risk.',
     v_class, 'generated', 'GI-Based Depression', 30, v_gen_depression_block),

    -- Stagnant Depression
    (2285,
     'Silk Tree / Albizia (mimosa bark or flowers) — stagnant depression where trauma has become the focus of existence; bark is stronger and grounding, flower is more uplifting.',
     v_class, 'generated', 'Stagnant Depression', 10, v_gen_depression_block),
    (850,
     'Rose petals — stagnant depression; supports emotional resilience, grief, and heart healing.',
     v_class, 'generated', 'Stagnant Depression', 20, v_gen_depression_block),
    (82,
     'Lavender — stagnant depression; calming, grief support, emotional anchor.',
     v_class, 'generated', 'Stagnant Depression', 30, v_gen_depression_block),
    (109,
     'Rosemary — stagnant depression; warming, moving, helps lift emotional stagnation.',
     v_class, 'generated', 'Stagnant Depression', 40, v_gen_depression_block),
    (144,
     'Damiana — stagnant depression; connects hormonal and mind-body; aids digestion and liver.',
     v_class, 'generated', 'Stagnant Depression', 50, v_gen_depression_block),

    -- Thyroid-Related Depression
    (118,
     'Kelp / Bladderwrack (Fucus vesiculosus) — thyroid-related depression from hypothyroidism; iodine-rich thyroid support.',
     v_class, 'generated', 'Thyroid-Related Depression', 10, v_gen_depression_block),
    (20,
     'Ashwagandha — thyroid-related depression; supports thyroid function and adaptogenic stress response.',
     v_class, 'generated', 'Thyroid-Related Depression', 20, v_gen_depression_block),
    (2381,
     'Bacopa — thyroid-related depression; nootropic, supports memory and mood linked to hypothyroidism.',
     v_class, 'generated', 'Thyroid-Related Depression', 30, v_gen_depression_block),

    -- Seasonal Affective Disorder
    (70,
     'Calendula — seasonal affective disorder; a light-bearing plant used to counter winter/light-deficiency depression.',
     v_class, 'generated', 'Seasonal Affective Disorder', 10, v_gen_depression_block),
    (134,
     'Lemon Balm — seasonal affective disorder; light-bearing plant, uplifting nervine for winter depression.',
     v_class, 'generated', 'Seasonal Affective Disorder', 20, v_gen_depression_block),
    (81,
     'St. John''s Wort — seasonal affective disorder; light-bearing plant par excellence for SAD.',
     v_class, 'generated', 'Seasonal Affective Disorder', 30, v_gen_depression_block),

    -- Spirit Remedies
    (2285,
     'Albizia / Silk Tree — spirit remedy for joy and collective happiness; use in all forms.',
     v_class, 'generated', 'Spirit Remedies', 10, v_gen_spirit_block),
    (73,
     'Hawthorn berry — spirit remedy for courage and heart strength; builds heart resilience.',
     v_class, 'generated', 'Spirit Remedies', 20, v_gen_spirit_block),
    (90,
     'Linden — spirit remedy for processing grief and emotional movement; supports emotional release.',
     v_class, 'generated', 'Spirit Remedies', 30, v_gen_spirit_block),
    (11,
     'Reishi Mushroom — spirit remedy; restores the sparkle in the eyes; strong effect among adaptogens.',
     v_class, 'generated', 'Spirit Remedies', 40, v_gen_spirit_block),
    (591,
     'Devil''s Club — spirit remedy for pattern interruption; regulates blood sugar; protective.',
     v_class, 'generated', 'Spirit Remedies', 50, v_gen_spirit_block),

    -- Depression (other types)
    (25,
     'Black Cohosh — black cloud depression associated with menopause; indicated when depression has a menopausal/hormonal root.',
     v_class, 'generated', 'Depression', 10, v_gen_depression_block),
    (13,
     'Tulsi (Holy Basil) — uplifting yet grounding; for depression with blood sugar dysregulation, brain fog, or stomach issues; avoid in severe hypothyroidism (cooling to thyroid).',
     v_class, 'generated', 'Depression', 20, v_gen_depression_block),
    (983,
     'Blue Vervain — calms the "choppy waters" of the mind; for circular thinking, delusions, jaw/shoulder tension; cooling, effective at higher doses.',
     v_class, 'generated', 'Depression', 30, v_gen_depression_block);

  -- ── Personal (Ashley) snippets ────────────────────────────────────────────
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    -- Hypertension
    (90,
     'Linden — white coat hypertension; calms anxiety-driven BP elevation.',
     v_class, 'personal', 'Hypertension', 10, v_per_gaba_block),

    -- Myelin Support
    (178,
     'Milky Oats — fresh herb; helps re-myelinate nerve cells; best used fresh after harvesting.',
     v_class, 'personal', 'Myelin Support', 10, v_per_gaba_block),

    -- GABA Support
    (137,
     'Passionflower — GABA support; primary "brake pedal"; for hypervigilance, racing thoughts, insomnia.',
     v_class, 'personal', 'GABA Support', 10, v_per_gaba_block),
    (145,
     'Valerian root — GABA support; calms neuronal firing, promotes sleep and relaxation.',
     v_class, 'personal', 'GABA Support', 20, v_per_gaba_block),
    (134,
     'Lemon Balm — GABA support; calming and relaxing nervine.',
     v_class, 'personal', 'GABA Support', 30, v_per_gaba_block),

    -- Dopamine Support
    (v_mucuna_id,
     'Velvet Bean (mucuna) — boosts dopamine; for low motivation, fatigue, difficulty initiating tasks, reduced pleasure.',
     v_class, 'personal', 'Dopamine Support', 10, v_per_gaba_block),

    -- GI-Based Depression
    (81,
     'St. John''s Wort (SJW) — GI-based depression; caution: serotonin syndrome risk when combined with SSRIs or ayahuasca.',
     v_class, 'personal', 'GI-Based Depression', 10, v_per_depression_block),
    (v_saffron_id,
     'Saffron — GI-based depression; use as tea, 2–3 sepals; contraindicated with SSRIs (serotonin syndrome).',
     v_class, 'personal', 'GI-Based Depression', 20, v_per_depression_block),
    (134,
     'Lemon Balm — GI-based depression; moody and lethargic presentation; uplifting nervine.',
     v_class, 'personal', 'GI-Based Depression', 30, v_per_depression_block),
    (84,
     'Chamomile — GI-based depression; indicated when depression has a GI/digestive component.',
     v_class, 'personal', 'GI-Based Depression', 40, v_per_depression_block),
    (136,
     'Catnip — GI-based depression; calming digestive nervine.',
     v_class, 'personal', 'GI-Based Depression', 50, v_per_depression_block),
    (97,
     'Wormwood — GI-based depression; "if ready for that underworld energy"; bitter digestive for stagnation.',
     v_class, 'personal', 'GI-Based Depression', 60, v_per_depression_block),

    -- Stagnant Depression
    (2285,
     'Mimosa / Silk Tree — stagnant depression; bark is stronger and grounding, flower is more uplifting; use 1:1 bark:flower.',
     v_class, 'personal', 'Stagnant Depression', 10, v_per_depression_block),
    (850,
     'Rose petals — stagnant depression; grief, heart loss, emotional processing.',
     v_class, 'personal', 'Stagnant Depression', 20, v_per_depression_block),
    (82,
     'Lavender — stagnant depression; grief and emotional anchor.',
     v_class, 'personal', 'Stagnant Depression', 30, v_per_depression_block),
    (109,
     'Rosemary — stagnant depression; warming, circulating, lifts stagnation.',
     v_class, 'personal', 'Stagnant Depression', 40, v_per_depression_block),
    (144,
     'Damiana — stagnant depression; hormonal, teaches embodiment; bitter and digestive.',
     v_class, 'personal', 'Stagnant Depression', 50, v_per_depression_block),

    -- Thyroid-Related Depression
    (20,
     'Ashwagandha ("ash") — thyroid-related depression; adaptogen that supports thyroid and HPA axis.',
     v_class, 'personal', 'Thyroid-Related Depression', 10, v_per_depression_block),
    (2381,
     'Bacopa — thyroid-related depression; nootropic, supports mood and memory affected by hypothyroidism.',
     v_class, 'personal', 'Thyroid-Related Depression', 20, v_per_depression_block),
    (118,
     'Bladderwrack / Kelp (Fucus vesiculosus) — thyroid-related depression; iodine-rich; supports underactive thyroid.',
     v_class, 'personal', 'Thyroid-Related Depression', 30, v_per_depression_block),
    (144,
     'Damiana — thyroid-related depression; hormonal support in thyroid protocol.',
     v_class, 'personal', 'Thyroid-Related Depression', 40, v_per_depression_block),
    (14,
     'Ginseng (red ginseng) — thyroid-related depression; adaptogen supporting thyroid and adrenal function.',
     v_class, 'personal', 'Thyroid-Related Depression', 50, v_per_depression_block),

    -- Seasonal Affective Disorder
    (70,
     'Calendula — seasonal affective disorder; light-bearing plant for winter/low-light depression.',
     v_class, 'personal', 'Seasonal Affective Disorder', 10, v_per_depression_block),
    (134,
     'Lemon Balm — seasonal affective disorder; light-bearing, uplifting nervine for SAD.',
     v_class, 'personal', 'Seasonal Affective Disorder', 20, v_per_depression_block),
    (81,
     'St. John''s Wort (SJW) — seasonal affective disorder; light-bearing plant; classic SAD herb.',
     v_class, 'personal', 'Seasonal Affective Disorder', 30, v_per_depression_block),

    -- Spirit Remedies
    (2285,
     'Albizia — tree of joy; spirit remedy; utilize in all forms for collective happiness.',
     v_class, 'personal', 'Spirit Remedies', 10, v_per_spirit_block),
    (73,
     'Hawthorn — courage and strength of the heart; spirit remedy.',
     v_class, 'personal', 'Spirit Remedies', 20, v_per_spirit_block),
    (90,
     'Linden — processing and moving through grief; tree of joy and sorrow; spirit remedy.',
     v_class, 'personal', 'Spirit Remedies', 30, v_per_spirit_block),
    (850,
     'Rose — resilience of the heart; self-love; spirit remedy.',
     v_class, 'personal', 'Spirit Remedies', 40, v_per_spirit_block),
    (591,
     'Devil''s Club — helps with addictive behavior and pattern interruption; spirit remedy for retracing destructive patterns.',
     v_class, 'personal', 'Spirit Remedies', 50, v_per_spirit_block),
    (11,
     'Reishi — invite the light back in; restores the sparkle in the eyes; spirit remedy.',
     v_class, 'personal', 'Spirit Remedies', 60, v_per_spirit_block),

    -- Depression (other types — personal)
    (25,
     'Black Cohosh — black cloud depression; specifically for depression associated with menopause.',
     v_class, 'personal', 'Depression', 10, v_per_depression_block),
    (13,
     'Tulsi — uplifting while grounding; for depression with blood sugar dysregulation, brain fog, stomach issues; avoid in hypothyroidism (cooling to thyroid).',
     v_class, 'personal', 'Depression', 20, v_per_depression_block),
    (144,
     'Damiana — teaches embodiment; hormonal connection to mood; bitter, digestive, liver support.',
     v_class, 'personal', 'Depression', 30, v_per_depression_block),
    (983,
     'Blue Vervain — choppy waters of the mind made calm; disillusionment, circular thinking, jaw tension; cooling and misting.',
     v_class, 'personal', 'Depression', 40, v_per_depression_block),

    -- Nervine Differentials (Ashley's key clinical differentials list)
    (142,
     'Skullcap — nervine for overwhelm from sensory input; indicated when lights and noises feel overwhelming.',
     v_class, 'personal', 'Nervine Differentials', 10, v_per_differentials_block),
    (129,
     'Hops — stress-induced stomach heat; for the over-planner and over-thinker.',
     v_class, 'personal', 'Nervine Differentials', 20, v_per_differentials_block),
    (145,
     'Valerian — strong palliative sedative ("knocker outer"); caution: paradoxical stimulant reaction possible.',
     v_class, 'personal', 'Nervine Differentials', 30, v_per_differentials_block),
    (137,
     'Passionflower — circular thinking, helps mind disconnect (like a "radio playing in your head").',
     v_class, 'personal', 'Nervine Differentials', 40, v_per_differentials_block),
    (84,
     'Chamomile — for whiney "babies of all ages"; irritable, fussy, over-reactive presentation.',
     v_class, 'personal', 'Nervine Differentials', 50, v_per_differentials_block),
    (178,
     'Milky Oats — frayed nervous systems; long-term nervous exhaustion and depletion.',
     v_class, 'personal', 'Nervine Differentials', 60, v_per_differentials_block),
    (134,
     'Lemon Balm — uplifting but relaxing; for the person who can''t stop going; great for infection-induced stress.',
     v_class, 'personal', 'Nervine Differentials', 70, v_per_differentials_block),
    (82,
     'Lavender — headaches, anxiety, insomnia and depression from constant worry; "hug in a bottle".',
     v_class, 'personal', 'Nervine Differentials', 80, v_per_differentials_block),
    (131,
     'Motherwort — fried and frazzled with tendency to palpitations and heart stress; hormonal-induced stress.',
     v_class, 'personal', 'Nervine Differentials', 90, v_per_differentials_block),
    (90,
     'Linden Flower — nerves causing cardiovascular heat and palpitations.',
     v_class, 'personal', 'Nervine Differentials', 100, v_per_differentials_block);

  RAISE NOTICE 'Class 52 snippets inserted';
END $$;

-- ─────────────────────────────────────────────────────────────────────────────
-- Keywords
-- ─────────────────────────────────────────────────────────────────────────────
DO $$
DECLARE
  v_saffron_id INTEGER;
  v_guayusa_id INTEGER;
  v_mucuna_id  INTEGER;
BEGIN
  SELECT id INTO v_saffron_id FROM herbal.herbs WHERE latin_name = 'Crocus sativus'  LIMIT 1;
  SELECT id INTO v_guayusa_id FROM herbal.herbs WHERE latin_name = 'Ilex guayusa'    LIMIT 1;
  SELECT id INTO v_mucuna_id  FROM herbal.herbs WHERE latin_name = 'Mucuna pruriens' LIMIT 1;

  INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
    -- Linden (90)
    (90,  'hypertension',              'ailment'),
    (90,  'depression',                'ailment'),
    (90,  'anxiety',                   'ailment'),
    (90,  'GABA support',              'action'),

    -- Milky Oats (178)
    (178, 'myelin support',            'action'),
    (178, 'nervous system support',    'action'),

    -- Valerian (145)
    (145, 'anxiety',                   'ailment'),
    (145, 'insomnia',                  'symptom'),
    (145, 'GABA support',              'action'),

    -- Lemon Balm (134)
    (134, 'anxiety',                   'ailment'),
    (134, 'depression',                'ailment'),
    (134, 'seasonal affective disorder', 'ailment'),
    (134, 'GABA support',              'action'),

    -- Passionflower (137)
    (137, 'anxiety',                   'ailment'),
    (137, 'insomnia',                  'symptom'),
    (137, 'GABA support',              'action'),

    -- Velvet Bean / Mucuna
    (v_mucuna_id, 'depression',        'ailment'),
    (v_mucuna_id, 'dopamine support',  'action'),

    -- Guayusa
    (v_guayusa_id, 'nervous system support', 'action'),
    (v_guayusa_id, 'nervine stimulant', 'action'),

    -- St. John's Wort (81) — depression + SAD (already has 'depression' from class 58)
    (81,  'seasonal affective disorder', 'ailment'),

    -- Wormwood (97)
    (97,  'depression',                'ailment'),

    -- Saffron
    (v_saffron_id, 'depression',       'ailment'),

    -- Silk Tree / Albizia (2285)
    (2285, 'depression',               'ailment'),

    -- Rose petal (850)
    (850, 'depression',                'ailment'),

    -- Lavender (82)
    (82,  'depression',                'ailment'),
    (82,  'anxiety',                   'ailment'),
    (82,  'insomnia',                  'symptom'),

    -- Rosemary (109)
    (109, 'depression',                'ailment'),

    -- Damiana (144)
    (144, 'depression',                'ailment'),
    (144, 'hypothyroidism',            'ailment'),
    (144, 'hormonal support',          'ailment'),

    -- Kelp / Bladderwrack (118)
    (118, 'hypothyroidism',            'ailment'),
    (118, 'depression',                'ailment'),

    -- Ashwagandha (20)
    (20,  'hypothyroidism',            'ailment'),
    (20,  'depression',                'ailment'),

    -- Bacopa (2381)
    (2381, 'hypothyroidism',           'ailment'),
    (2381, 'depression',               'ailment'),
    (2381, 'nootropic support',        'action'),

    -- Ginseng / Red Ginseng (14)
    (14,  'hypothyroidism',            'ailment'),

    -- Calendula (70)
    (70,  'seasonal affective disorder', 'ailment'),
    (70,  'depression',                'ailment'),

    -- Hawthorn berry (73)
    (73,  'anxiety',                   'ailment'),

    -- Reishi (11)
    (11,  'depression',                'ailment'),
    (11,  'stress',                    'ailment'),

    -- Black Cohosh (25)
    (25,  'depression',                'ailment'),
    (25,  'perimenopause',             'ailment'),

    -- Tulsi (13)
    (13,  'depression',                'ailment'),
    (13,  'blood sugar dysregulation', 'ailment'),
    (13,  'brain fog',                 'symptom'),

    -- Blue Vervain (983)
    (983, 'depression',                'ailment'),
    (983, 'anxiety',                   'ailment'),

    -- Devil's Club (591)
    (591, 'blood sugar dysregulation', 'ailment'),
    (591, 'stress',                    'ailment'),

    -- Skullcap (142)
    (142, 'anxiety',                   'ailment'),
    (142, 'stress',                    'ailment'),

    -- Hops (129)
    (129, 'anxiety',                   'ailment'),
    (129, 'stress',                    'ailment'),

    -- Motherwort (131)
    (131, 'anxiety',                   'ailment'),
    (131, 'hypertension',              'ailment'),

    -- Chamomile (84)
    (84,  'depression',                'ailment'),
    (84,  'anxiety',                   'ailment'),

    -- Catnip (136)
    (136, 'depression',                'ailment')

  ON CONFLICT (herb_id, keyword) DO NOTHING;

  RAISE NOTICE 'Class 52 keywords inserted';
END $$;

-- ─────────────────────────────────────────────────────────────────────────────
-- Ailment search synonyms (new ailment keywords only)
-- ─────────────────────────────────────────────────────────────────────────────
INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('hypertension',
   ARRAY['high blood pressure', 'elevated BP', 'HBP', 'white coat hypertension', 'hypertensive']),
  ('hypothyroidism',
   ARRAY['underactive thyroid', 'low thyroid', 'thyroid deficiency', 'Hashimoto', 'Hashimotos', 'hypothyroid', 'thyroid-related depression', 'subclinical hypothyroid']),
  ('seasonal affective disorder',
   ARRAY['SAD', 'winter depression', 'seasonal depression', 'winter blues', 'light deficiency depression', 'light deprivation depression'])
ON CONFLICT (ailment_keyword) DO NOTHING;
