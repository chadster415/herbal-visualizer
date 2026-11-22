-- Migration 474: Herbal Heart Health - Week 2 class note snippets
-- Class: Herbal Heart Health - Week 2 - Building a Resilient Heart
-- Source: Herbs with Rosalee / Herbal Heart Health / Week 2 - Building a Resilient Heart.md
--
-- Herbs (16): Skullcap (142), Blue Vervain (983), Chamomile (84), Lavender (82),
--   Passionflower (137), Valerian (145), Hops (129), Milky Oats (178), Ashwagandha (20),
--   Cordyceps (2634), Eleuthero (9), Schisandra (17), Echinacea angustifolia (221),
--   Calendula (70), Plantain (85), Garlic (21)
-- Supplements (5): Magnesium (21), Vitamin D (11), CoQ10 (32), Fish Oils Omega-3 (33),
--   Vitamin B Complex (49)
-- No new herbs to add (all present in DB).
-- No new ailment_search_terms needed (sleep support, oral health already exist).

SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM herbal.class_note_snippets
    WHERE class_name = 'Herbal Heart Health - Week 2 - Building a Resilient Heart'
  ) THEN
    RAISE NOTICE 'Week 2 snippets already loaded, skipping';
    RETURN;
  END IF;

  -- Herb snippets
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- -------------------------------------------------------------------------
  -- Section: Herbal Support for Sleep - Tension and Irritability
  -- -------------------------------------------------------------------------
  (142,
   'A classic nervine for restless, racing thoughts and muscle tension; best as a tincture; suited to the person too wired to wind down; small, frequent doses throughout the day are more effective than a single large dose at bedtime.',
   'Herbal Heart Health - Week 2 - Building a Resilient Heart', 'generated',
   'Herbal Support for Sleep - Tension and Irritability', 10,
   'Pattern 1 - Tension, Irritability, and an Overactive Mind

These herbs soften the edges without dulling the person. Small, frequent responsive doses work better than large infrequent ones - this is the tension pattern, not a sedation pattern.

Skullcap (Scutellaria lateriflora): classic nervine for restless, racing thoughts and muscle tension; best as tincture.
Blue Vervain (Verbena hastata): for the person wound tight with perfectionism and overwork; best as tincture.
Chamomile (Matricaria chamomilla): gentle, broadly calming, good for tension with a digestive component; works as tea or tincture.
Lavender (Lavandula spp.): aromatic nervine that softens tension without sedating; works as tea or tincture.
Passionflower (Passiflora incarnata): deeply effective for the overactive, circular mind; particularly suited to anxious rumination and intrusive thoughts that prevent sleep onset.

Dosing principle: small responsive doses throughout the day, not just at bedtime.'),

  (983,
   'For the person wound tight with perfectionism and overwork; best as a tincture; addresses the cardiovascular cost of chronic tension and overwork; well-matched to the Heat and Tension pattern of sleep disruption.',
   'Herbal Heart Health - Week 2 - Building a Resilient Heart', 'generated',
   'Herbal Support for Sleep - Tension and Irritability', 20,
   'Pattern 1 - Tension, Irritability, and an Overactive Mind

These herbs soften the edges without dulling the person. Small, frequent responsive doses work better than large infrequent ones - this is the tension pattern, not a sedation pattern.

Skullcap (Scutellaria lateriflora): classic nervine for restless, racing thoughts and muscle tension; best as tincture.
Blue Vervain (Verbena hastata): for the person wound tight with perfectionism and overwork; best as tincture.
Chamomile (Matricaria chamomilla): gentle, broadly calming, good for tension with a digestive component; works as tea or tincture.
Lavender (Lavandula spp.): aromatic nervine that softens tension without sedating; works as tea or tincture.
Passionflower (Passiflora incarnata): deeply effective for the overactive, circular mind; particularly suited to anxious rumination and intrusive thoughts that prevent sleep onset.

Dosing principle: small responsive doses throughout the day, not just at bedtime.'),

  (84,
   'Gently and broadly calming with a digestive component; well-suited when nervous tension accompanies digestive upset; works as tea or tincture; softer than Skullcap but widely accessible and pleasant for daily use.',
   'Herbal Heart Health - Week 2 - Building a Resilient Heart', 'generated',
   'Herbal Support for Sleep - Tension and Irritability', 30,
   'Pattern 1 - Tension, Irritability, and an Overactive Mind

These herbs soften the edges without dulling the person. Small, frequent responsive doses work better than large infrequent ones - this is the tension pattern, not a sedation pattern.

Skullcap (Scutellaria lateriflora): classic nervine for restless, racing thoughts and muscle tension; best as tincture.
Blue Vervain (Verbena hastata): for the person wound tight with perfectionism and overwork; best as tincture.
Chamomile (Matricaria chamomilla): gentle, broadly calming, good for tension with a digestive component; works as tea or tincture.
Lavender (Lavandula spp.): aromatic nervine that softens tension without sedating; works as tea or tincture.
Passionflower (Passiflora incarnata): deeply effective for the overactive, circular mind; particularly suited to anxious rumination and intrusive thoughts that prevent sleep onset.

Dosing principle: small responsive doses throughout the day, not just at bedtime.'),

  (82,
   'An aromatic nervine that softens nervous tension without sedating; works as tea or tincture; a gentler entry point for those who find stronger nervines too forceful; suited to the tension pattern of sleep disruption.',
   'Herbal Heart Health - Week 2 - Building a Resilient Heart', 'generated',
   'Herbal Support for Sleep - Tension and Irritability', 40,
   'Pattern 1 - Tension, Irritability, and an Overactive Mind

These herbs soften the edges without dulling the person. Small, frequent responsive doses work better than large infrequent ones - this is the tension pattern, not a sedation pattern.

Skullcap (Scutellaria lateriflora): classic nervine for restless, racing thoughts and muscle tension; best as tincture.
Blue Vervain (Verbena hastata): for the person wound tight with perfectionism and overwork; best as tincture.
Chamomile (Matricaria chamomilla): gentle, broadly calming, good for tension with a digestive component; works as tea or tincture.
Lavender (Lavandula spp.): aromatic nervine that softens tension without sedating; works as tea or tincture.
Passionflower (Passiflora incarnata): deeply effective for the overactive, circular mind; particularly suited to anxious rumination and intrusive thoughts that prevent sleep onset.

Dosing principle: small responsive doses throughout the day, not just at bedtime.'),

  (137,
   'Deeply effective for the overactive, circular mind; particularly well-suited to anxious rumination and intrusive thoughts that prevent sleep onset; one of the best herbs for the racing-mind pattern of insomnia.',
   'Herbal Heart Health - Week 2 - Building a Resilient Heart', 'generated',
   'Herbal Support for Sleep - Tension and Irritability', 50,
   'Pattern 1 - Tension, Irritability, and an Overactive Mind

These herbs soften the edges without dulling the person. Small, frequent responsive doses work better than large infrequent ones - this is the tension pattern, not a sedation pattern.

Skullcap (Scutellaria lateriflora): classic nervine for restless, racing thoughts and muscle tension; best as tincture.
Blue Vervain (Verbena hastata): for the person wound tight with perfectionism and overwork; best as tincture.
Chamomile (Matricaria chamomilla): gentle, broadly calming, good for tension with a digestive component; works as tea or tincture.
Lavender (Lavandula spp.): aromatic nervine that softens tension without sedating; works as tea or tincture.
Passionflower (Passiflora incarnata): deeply effective for the overactive, circular mind; particularly suited to anxious rumination and intrusive thoughts that prevent sleep onset.

Dosing principle: small responsive doses throughout the day, not just at bedtime.'),

  -- -------------------------------------------------------------------------
  -- Section: Herbal Support for Sleep - Difficulty Falling Asleep
  -- -------------------------------------------------------------------------
  (145,
   'Well-studied for difficulty falling asleep; taken 30-60 minutes before bed; often more effective after consistent use over several weeks; suited to the sleep-onset threshold pattern rather than the tension/irritability pattern.',
   'Herbal Heart Health - Week 2 - Building a Resilient Heart', 'generated',
   'Herbal Support for Sleep - Difficulty Falling Asleep', 60,
   'Pattern 2 - Difficulty Crossing the Threshold Into Sleep

Taken 30-60 minutes before bed to support the transition into sleep. Different from the tension pattern: this is specifically about the sleep-onset transition, not calming an overactive nervous system.

Valerian (Valeriana officinalis): well-studied for difficulty falling asleep; works best with consistent use over several weeks.
Hops (Humulus lupulus): a sedative herb suited to warm/tense types; often combined with Valerian; less appropriate for cold/depleted types.'),

  (129,
   'A sedative herb with particular affinity for sleep-onset difficulty; often combined with Valerian; best suited to people who run warm and tense; less appropriate for cold and depleted types due to its bitter, slightly depressant quality.',
   'Herbal Heart Health - Week 2 - Building a Resilient Heart', 'generated',
   'Herbal Support for Sleep - Difficulty Falling Asleep', 70,
   'Pattern 2 - Difficulty Crossing the Threshold Into Sleep

Taken 30-60 minutes before bed to support the transition into sleep. Different from the tension pattern: this is specifically about the sleep-onset transition, not calming an overactive nervous system.

Valerian (Valeriana officinalis): well-studied for difficulty falling asleep; works best with consistent use over several weeks.
Hops (Humulus lupulus): a sedative herb suited to warm/tense types; often combined with Valerian; less appropriate for cold/depleted types.'),

  -- -------------------------------------------------------------------------
  -- Section: Herbal Support for Sleep - Depletion and Unrestorative Sleep
  -- -------------------------------------------------------------------------
  (178,
   'A deeply nourishing nervine tonic for a depleted, frayed nervous system; best used over weeks to months as a restorative, not an acute sedative; a slow rebuilder of nervous system reserves suited to the depletion sleep pattern.',
   'Herbal Heart Health - Week 2 - Building a Resilient Heart', 'generated',
   'Herbal Support for Sleep - Depletion and Unrestorative Sleep', 80,
   'Pattern 3 - Depletion and Unrestorative Sleep

A deficiency pattern where sleep happens but does not restore. These nourishing tonic herbs are used over weeks to months, not acutely. The goal is rebuilding, not sedating.

Milky Oats (Avena sativa): deeply nourishing nervine tonic for a depleted, frayed nervous system; a slow rebuilder of nervous system reserves.
Ashwagandha (Withania somnifera): warming adaptogenic tonic for the depleted, exhausted person who cannot restore through sleep; supports cortisol regulation and nervous system resilience; somnifera means sleep-bearing.'),

  (20,
   'A warming adaptogenic tonic particularly suited to the depleted, exhausted person who cannot restore through sleep; supports cortisol regulation and nervous system resilience; the species epithet somnifera means sleep-bearing; used over weeks to months.',
   'Herbal Heart Health - Week 2 - Building a Resilient Heart', 'generated',
   'Herbal Support for Sleep - Depletion and Unrestorative Sleep', 90,
   'Pattern 3 - Depletion and Unrestorative Sleep

A deficiency pattern where sleep happens but does not restore. These nourishing tonic herbs are used over weeks to months, not acutely. The goal is rebuilding, not sedating.

Milky Oats (Avena sativa): deeply nourishing nervine tonic for a depleted, frayed nervous system; a slow rebuilder of nervous system reserves.
Ashwagandha (Withania somnifera): warming adaptogenic tonic for the depleted, exhausted person who cannot restore through sleep; supports cortisol regulation and nervous system resilience; somnifera means sleep-bearing.'),

  -- -------------------------------------------------------------------------
  -- Section: Herbal Support for Movement and Endurance
  -- -------------------------------------------------------------------------
  (2634,
   'A tonic mushroom traditionally used to support lung capacity, endurance, and cardiovascular stamina; well-researched for improving VO2 max and exercise performance; particularly useful when breathlessness or depletion limit the ability to exercise consistently.',
   'Herbal Heart Health - Week 2 - Building a Resilient Heart', 'generated',
   'Herbal Support for Movement and Endurance', 100,
   'Herbs can support the experience and sustainability of physical activity.

Cordyceps (Cordyceps militaris): tonic mushroom supporting lung capacity, endurance, and cardiovascular stamina; well-researched for VO2 max improvement; useful when breathlessness or depletion limit activity.
Eleuthero (Eleutherococcus senticosus): mild adaptogen for stamina and stress resilience without overstimulating.
Schisandra (Schisandra chinensis): five-flavor berry supporting liver, kidneys, heart, and nervous system simultaneously; traditionally used by Russian athletes for endurance.

Herbs for sleep, nerves, and inflammation also indirectly support movement by reducing its barriers: better sleep improves recovery, calmer nerves free energy for activity, reduced inflammation means less pain and stiffness.'),

  (9,
   'A mild adaptogen that supports stamina and stress resilience without overstimulating; suited to those who need sustained endurance support for movement and exercise; gentler than the ginsengs and appropriate for long-term use.',
   'Herbal Heart Health - Week 2 - Building a Resilient Heart', 'generated',
   'Herbal Support for Movement and Endurance', 110,
   'Herbs can support the experience and sustainability of physical activity.

Cordyceps (Cordyceps militaris): tonic mushroom supporting lung capacity, endurance, and cardiovascular stamina; well-researched for VO2 max improvement; useful when breathlessness or depletion limit activity.
Eleuthero (Eleutherococcus senticosus): mild adaptogen for stamina and stress resilience without overstimulating.
Schisandra (Schisandra chinensis): five-flavor berry supporting liver, kidneys, heart, and nervous system simultaneously; traditionally used by Russian athletes for endurance.

Herbs for sleep, nerves, and inflammation also indirectly support movement by reducing its barriers: better sleep improves recovery, calmer nerves free energy for activity, reduced inflammation means less pain and stiffness.'),

  (17,
   'A five-flavor berry supporting liver, kidneys, heart, and nervous system simultaneously - a true whole-body adaptogen; traditionally used by Russian athletes for endurance; also supports recovery and helps reduce the barriers to sustained movement.',
   'Herbal Heart Health - Week 2 - Building a Resilient Heart', 'generated',
   'Herbal Support for Movement and Endurance', 120,
   'Herbs can support the experience and sustainability of physical activity.

Cordyceps (Cordyceps militaris): tonic mushroom supporting lung capacity, endurance, and cardiovascular stamina; well-researched for VO2 max improvement; useful when breathlessness or depletion limit activity.
Eleuthero (Eleutherococcus senticosus): mild adaptogen for stamina and stress resilience without overstimulating.
Schisandra (Schisandra chinensis): five-flavor berry supporting liver, kidneys, heart, and nervous system simultaneously; traditionally used by Russian athletes for endurance.

Herbs for sleep, nerves, and inflammation also indirectly support movement by reducing its barriers: better sleep improves recovery, calmer nerves free energy for activity, reduced inflammation means less pain and stiffness.'),

  -- -------------------------------------------------------------------------
  -- Section: Herbal Support for Oral Health
  -- -------------------------------------------------------------------------
  (221,
   'Supports immune response and provides antimicrobial and anti-inflammatory action in the oral cavity; used as a mouth rinse or in oral care preparations to address the cardiovascular risk of periodontal bacteria entering the bloodstream.',
   'Herbal Heart Health - Week 2 - Building a Resilient Heart', 'generated',
   'Herbal Support for Oral Health', 130,
   'Periodontal disease is linked to arterial plaque and higher risk of major CVD events via two pathways: bacteremia and chronic systemic inflammation (AHA, Tran et al. 2026, Circulation 153(6)). Over 40% of US adults over 30 are affected.

Herbal oral rinses for cardiovascular-relevant gum health:
Echinacea (Echinacea angustifolia): supports immune response and antimicrobial action in the oral cavity; used as a mouth rinse.
Calendula (Calendula officinalis): anti-inflammatory, vulnerary, and gently antimicrobial; promotes healing of damaged gum tissue; tea rinse.
Plantain (Plantago spp.): anti-inflammatory, drawing, and vulnerary; classic wound-healing herb with strong affinity for inflamed mucous membranes; tea rinse or poultice for sore, inflamed gums and oral ulcers.

Clinical intake questions: Do they have bleeding gums? Chronic inflammation in the mouth? A history of gum disease? These are cardiovascular intake questions, not just oral hygiene questions.'),

  (70,
   'Anti-inflammatory, vulnerary, and gently antimicrobial; promotes healing of damaged gum tissue; used as a tea rinse or in gum preparations; well-suited to inflamed, bleeding gum tissue linked to cardiovascular risk via systemic inflammation.',
   'Herbal Heart Health - Week 2 - Building a Resilient Heart', 'generated',
   'Herbal Support for Oral Health', 140,
   'Periodontal disease is linked to arterial plaque and higher risk of major CVD events via two pathways: bacteremia and chronic systemic inflammation (AHA, Tran et al. 2026, Circulation 153(6)). Over 40% of US adults over 30 are affected.

Herbal oral rinses for cardiovascular-relevant gum health:
Echinacea (Echinacea angustifolia): supports immune response and antimicrobial action in the oral cavity; used as a mouth rinse.
Calendula (Calendula officinalis): anti-inflammatory, vulnerary, and gently antimicrobial; promotes healing of damaged gum tissue; tea rinse.
Plantain (Plantago spp.): anti-inflammatory, drawing, and vulnerary; classic wound-healing herb with strong affinity for inflamed mucous membranes; tea rinse or poultice for sore, inflamed gums and oral ulcers.

Clinical intake questions: Do they have bleeding gums? Chronic inflammation in the mouth? A history of gum disease? These are cardiovascular intake questions, not just oral hygiene questions.'),

  (85,
   'Anti-inflammatory, drawing, and vulnerary; a classic wound-healing herb with strong affinity for inflamed mucous membranes; used as a tea rinse or poultice; particularly useful for sore, inflamed gums and oral ulcers with cardiovascular implications.',
   'Herbal Heart Health - Week 2 - Building a Resilient Heart', 'generated',
   'Herbal Support for Oral Health', 150,
   'Periodontal disease is linked to arterial plaque and higher risk of major CVD events via two pathways: bacteremia and chronic systemic inflammation (AHA, Tran et al. 2026, Circulation 153(6)). Over 40% of US adults over 30 are affected.

Herbal oral rinses for cardiovascular-relevant gum health:
Echinacea (Echinacea angustifolia): supports immune response and antimicrobial action in the oral cavity; used as a mouth rinse.
Calendula (Calendula officinalis): anti-inflammatory, vulnerary, and gently antimicrobial; promotes healing of damaged gum tissue; tea rinse.
Plantain (Plantago spp.): anti-inflammatory, drawing, and vulnerary; classic wound-healing herb with strong affinity for inflamed mucous membranes; tea rinse or poultice for sore, inflamed gums and oral ulcers.

Clinical intake questions: Do they have bleeding gums? Chronic inflammation in the mouth? A history of gum disease? These are cardiovascular intake questions, not just oral hygiene questions.'),

  -- -------------------------------------------------------------------------
  -- Section: Food as Cardiovascular Medicine
  -- -------------------------------------------------------------------------
  (21,
   'Supports circulation, helps modulate lipid balance, and has anti-inflammatory effects; best eaten daily in real cooking rather than as a supplement - daily culinary use delivers consistent cardiovascular benefit without the concerns of high-dose supplementation.',
   'Herbal Heart Health - Week 2 - Building a Resilient Heart', 'generated',
   'Food as Cardiovascular Medicine', 160,
   'Heart-healthy eating is built on abundance and nourishment, not restriction. Heart-healthy foods tend to be the most flavorful.

Key cardiovascular foods: purple and blue fruits rich in anthocyanins (blueberries, blackberries, elderberries) reduce blood pressure and improve arterial flexibility; Garlic (Allium sativum) supports circulation, modulates lipid balance, and has anti-inflammatory effects - best eaten daily in real cooking; olive oil contains oleocanthal which acts similarly to ibuprofen at anti-inflammatory doses; leafy greens supply dietary nitrates for nitric oxide production and vascular relaxation; cacao flavanols support blood vessel function and circulation.');

  -- Supplement snippets
  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- -------------------------------------------------------------------------
  -- Section: Key Nutrients for Cardiovascular Health
  -- -------------------------------------------------------------------------
  (21,
   'Foundational cardiovascular nutrient supporting heart rhythm, vascular tone, and hundreds of enzymatic processes; deficiency signs include muscle tension, poor sleep, palpitations, and elevated blood pressure; prefer glycinate (sleep/calm/tension), malate (fatigue/recovery), or citrate (general) over magnesium oxide which is poorly absorbed.',
   'Herbal Heart Health - Week 2 - Building a Resilient Heart', 'generated',
   'Key Nutrients for Cardiovascular Health', 170,
   'Key nutrients commonly deficient with strong cardiovascular evidence:

Magnesium: foundational cardiovascular nutrient; supports heart rhythm, vascular tone, and hundreds of enzymatic processes; deficiency signs include muscle tension, poor sleep, palpitations, and elevated blood pressure. Forms: glycinate (sleep/calm/tension), malate (fatigue/muscle recovery), citrate (general). Avoid magnesium oxide - poorly absorbed.
Vitamin D: approximately 40% of Americans are deficient; linked to blood pressure regulation, inflammation, and vascular function. A meaningful difference exists between not deficient and actually replete.
CoQ10: critical for cellular energy production in high-demand tissues like the heart; depleted by aging and statin use.
Fish Oils (Omega-3s, EPA/DHA): help regulate inflammation and support healthy triglycerides; ALA from flax and chia converts poorly and is not a substitute for marine omega-3s.
B vitamins (B6, B12, folate): support methylation and homocysteine metabolism; elevated homocysteine is an independent cardiovascular risk factor; methylated forms preferred for MTHFR variants.'),

  (11,
   'Approximately 40% of Americans are deficient; linked to blood pressure regulation, inflammation, and vascular function; a meaningful difference exists between not deficient and actually replete - lab reference ranges mark the floor, not the optimal level for cardiovascular health.',
   'Herbal Heart Health - Week 2 - Building a Resilient Heart', 'generated',
   'Key Nutrients for Cardiovascular Health', 180,
   'Key nutrients commonly deficient with strong cardiovascular evidence:

Magnesium: foundational cardiovascular nutrient; supports heart rhythm, vascular tone, and hundreds of enzymatic processes; deficiency signs include muscle tension, poor sleep, palpitations, and elevated blood pressure. Forms: glycinate (sleep/calm/tension), malate (fatigue/muscle recovery), citrate (general). Avoid magnesium oxide - poorly absorbed.
Vitamin D: approximately 40% of Americans are deficient; linked to blood pressure regulation, inflammation, and vascular function. A meaningful difference exists between not deficient and actually replete.
CoQ10: critical for cellular energy production in high-demand tissues like the heart; depleted by aging and statin use.
Fish Oils (Omega-3s, EPA/DHA): help regulate inflammation and support healthy triglycerides; ALA from flax and chia converts poorly and is not a substitute for marine omega-3s.
B vitamins (B6, B12, folate): support methylation and homocysteine metabolism; elevated homocysteine is an independent cardiovascular risk factor; methylated forms preferred for MTHFR variants.'),

  (32,
   'Critical for cellular energy production in high-demand tissues like the heart; the heart has one of the highest CoQ10 concentrations in the body; depleted by both aging and statin use - statin users especially benefit from supplementation.',
   'Herbal Heart Health - Week 2 - Building a Resilient Heart', 'generated',
   'Key Nutrients for Cardiovascular Health', 190,
   'Key nutrients commonly deficient with strong cardiovascular evidence:

Magnesium: foundational cardiovascular nutrient; supports heart rhythm, vascular tone, and hundreds of enzymatic processes; deficiency signs include muscle tension, poor sleep, palpitations, and elevated blood pressure. Forms: glycinate (sleep/calm/tension), malate (fatigue/muscle recovery), citrate (general). Avoid magnesium oxide - poorly absorbed.
Vitamin D: approximately 40% of Americans are deficient; linked to blood pressure regulation, inflammation, and vascular function. A meaningful difference exists between not deficient and actually replete.
CoQ10: critical for cellular energy production in high-demand tissues like the heart; depleted by aging and statin use.
Fish Oils (Omega-3s, EPA/DHA): help regulate inflammation and support healthy triglycerides; ALA from flax and chia converts poorly and is not a substitute for marine omega-3s.
B vitamins (B6, B12, folate): support methylation and homocysteine metabolism; elevated homocysteine is an independent cardiovascular risk factor; methylated forms preferred for MTHFR variants.'),

  (33,
   'EPA and DHA from marine sources help regulate inflammation and support healthy triglycerides; ALA from flax and chia converts poorly and is not a substitute for marine omega-3s; relevant for the inflammatory cardiovascular terrain addressed throughout this course.',
   'Herbal Heart Health - Week 2 - Building a Resilient Heart', 'generated',
   'Key Nutrients for Cardiovascular Health', 200,
   'Key nutrients commonly deficient with strong cardiovascular evidence:

Magnesium: foundational cardiovascular nutrient; supports heart rhythm, vascular tone, and hundreds of enzymatic processes; deficiency signs include muscle tension, poor sleep, palpitations, and elevated blood pressure. Forms: glycinate (sleep/calm/tension), malate (fatigue/muscle recovery), citrate (general). Avoid magnesium oxide - poorly absorbed.
Vitamin D: approximately 40% of Americans are deficient; linked to blood pressure regulation, inflammation, and vascular function. A meaningful difference exists between not deficient and actually replete.
CoQ10: critical for cellular energy production in high-demand tissues like the heart; depleted by aging and statin use.
Fish Oils (Omega-3s, EPA/DHA): help regulate inflammation and support healthy triglycerides; ALA from flax and chia converts poorly and is not a substitute for marine omega-3s.
B vitamins (B6, B12, folate): support methylation and homocysteine metabolism; elevated homocysteine is an independent cardiovascular risk factor; methylated forms preferred for MTHFR variants.'),

  (49,
   'B6, B12, and folate support methylation and homocysteine metabolism; elevated homocysteine is an independent cardiovascular risk factor; methylated forms (methylfolate, methylcobalamin) are better absorbed by people with MTHFR variants.',
   'Herbal Heart Health - Week 2 - Building a Resilient Heart', 'generated',
   'Key Nutrients for Cardiovascular Health', 210,
   'Key nutrients commonly deficient with strong cardiovascular evidence:

Magnesium: foundational cardiovascular nutrient; supports heart rhythm, vascular tone, and hundreds of enzymatic processes; deficiency signs include muscle tension, poor sleep, palpitations, and elevated blood pressure. Forms: glycinate (sleep/calm/tension), malate (fatigue/muscle recovery), citrate (general). Avoid magnesium oxide - poorly absorbed.
Vitamin D: approximately 40% of Americans are deficient; linked to blood pressure regulation, inflammation, and vascular function. A meaningful difference exists between not deficient and actually replete.
CoQ10: critical for cellular energy production in high-demand tissues like the heart; depleted by aging and statin use.
Fish Oils (Omega-3s, EPA/DHA): help regulate inflammation and support healthy triglycerides; ALA from flax and chia converts poorly and is not a substitute for marine omega-3s.
B vitamins (B6, B12, folate): support methylation and homocysteine metabolism; elevated homocysteine is an independent cardiovascular risk factor; methylated forms preferred for MTHFR variants.');

END $$;

-- Keywords for herbs in Week 2 sections
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  -- Skullcap - sleep/tension pattern
  (142, 'sleep support',    'ailment'),
  (142, 'nervous tension',  'symptom'),
  (142, 'racing thoughts',  'symptom'),
  (142, 'insomnia',         'ailment'),
  -- Blue Vervain - sleep/tension pattern
  (983, 'sleep support',    'ailment'),
  (983, 'nervous tension',  'symptom'),
  (983, 'insomnia',         'ailment'),
  (983, 'overwork',         'general'),
  -- Chamomile - sleep/tension pattern
  (84,  'sleep support',    'ailment'),
  (84,  'nervous tension',  'symptom'),
  (84,  'insomnia',         'ailment'),
  (84,  'digestive relaxant','action'),
  -- Lavender - sleep/tension pattern
  (82,  'sleep support',    'ailment'),
  (82,  'nervous tension',  'symptom'),
  (82,  'insomnia',         'ailment'),
  (82,  'aromatic nervine', 'action'),
  -- Passionflower - sleep/tension pattern
  (137, 'sleep support',    'ailment'),
  (137, 'nervous tension',  'symptom'),
  (137, 'insomnia',         'ailment'),
  (137, 'anxious rumination','symptom'),
  (137, 'overactive mind',  'symptom'),
  -- Valerian - sleep onset
  (145, 'sleep onset',      'symptom'),
  (145, 'insomnia',         'ailment'),
  (145, 'sleep support',    'ailment'),
  -- Hops - sleep onset
  (129, 'sleep onset',      'symptom'),
  (129, 'insomnia',         'ailment'),
  (129, 'sleep support',    'ailment'),
  -- Milky Oats - depletion pattern
  (178, 'sleep support',    'ailment'),
  (178, 'nervous depletion','symptom'),
  (178, 'restorative',      'action'),
  (178, 'nourishing nervine','action'),
  -- Ashwagandha - depletion pattern
  (20,  'sleep support',    'ailment'),
  (20,  'nervous depletion','symptom'),
  (20,  'cortisol regulation','action'),
  (20,  'restorative',      'action'),
  -- Cordyceps - movement support
  (2634,'endurance',        'action'),
  (2634,'lung support',     'action'),
  (2634,'stamina',          'action'),
  (2634,'VO2 max',          'action'),
  (2634,'cardiovascular endurance','action'),
  -- Eleuthero - movement support
  (9,   'stamina',          'action'),
  (9,   'endurance',        'action'),
  (9,   'exercise support', 'action'),
  -- Schisandra - movement support
  (17,  'endurance',        'action'),
  (17,  'stamina',          'action'),
  (17,  'athletes',         'general'),
  (17,  'exercise support', 'action'),
  -- Echinacea - oral health
  (221, 'oral health',      'ailment'),
  (221, 'gum health',       'ailment'),
  (221, 'mouth rinse',      'action'),
  (221, 'periodontal disease','ailment'),
  -- Calendula - oral health
  (70,  'oral health',      'ailment'),
  (70,  'gum health',       'ailment'),
  (70,  'mouth rinse',      'action'),
  (70,  'periodontal disease','ailment'),
  -- Plantain - oral health
  (85,  'oral health',      'ailment'),
  (85,  'gum health',       'ailment'),
  (85,  'mouth rinse',      'action'),
  (85,  'periodontal disease','ailment'),
  -- Garlic - food as medicine
  (21,  'cardiovascular food','general'),
  (21,  'lipid support',    'action'),
  (21,  'circulation',      'action'),
  (21,  'anti-inflammatory','action')
ON CONFLICT DO NOTHING;
