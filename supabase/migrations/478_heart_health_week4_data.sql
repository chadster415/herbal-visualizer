-- Migration 478: Herbal Heart Health - Week 4 - Hypertension and Hypotension - Data
-- Source: ~/Obsidian/Obsidian Vault/Classes/Herbs with Rosalee/Herbal Heart Health/Week 4 - Hypertension and Hypotension.md
-- Presenter: Richard Mandelbaum RH
-- class_name: 'Herbal Heart Health - Week 4 - Hypertension and Hypotension'
--
-- Herb normalizations applied:
-- "Baikal skullcap / Huang Qin (Scutellaria baicalensis)" -> Chinese Skullcap (id=2274)
-- "Dang gui" -> Dong Quai (id=1009, Angelica sinensis)
-- "Goji (Lycium chinense)" -> Wolfberry Fruit (id=1548, Fructus Lycii Chinensis) - fruit for kidney deficiency
-- "Poria (Wolfporia cocos / Wolfporia extensa)" -> Poria / Hoelen (id=1541, Sclerotium Poriae Cocos)
-- "Mulberry bark (Morus alba)" -> Mulberry Root Bark (id=1600, Cortex Radicis Mori Albi)
-- "Crampbark" -> Cramp Bark (id=93)
-- "California poppy" -> California Poppy (id=128)
-- "Schisandra" -> Schizandra (id=17)
-- "Rauwolfia (Rauvolfia serpentina / vomitoria)" -> Rauwolfia (id=2758)
-- "Milky Oats" -> Oat / Milky Oats (id=178, Avena sativa milky oats)
--
-- Skipped:
-- Pomegranate fruit: DB only has Pomegranate root bark (id=2753, plant_part=''Root bark'');
--   cardiovascular fruit/juice use does not apply to that entry
-- Green tea (Camellia sinensis): not in DB; only briefly mentioned as mild diuretic
--
-- New ailment keywords: liver yang rising, liver fire, damp stagnation, blood stasis
-- New action keywords: yin-nourishing, blood moving, heat clearing
-- Merged: "kidney yin/yang deficiency" -> existing ''kidney support'';
--   "vascular tension" -> existing ''vascular health''

SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM herbal.class_note_snippets
    WHERE class_name = 'Herbal Heart Health - Week 4 - Hypertension and Hypotension'
  ) THEN
    RAISE NOTICE 'Week 4 snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- === HERBS FOR HYPERTENSION: DIURETICS AND THERAPEUTIC FOODS ===
  (1648,
   'Dandelion leaf (Taraxacum officinale) is a potassium-sparing diuretic — helps release excess fluid without depleting potassium, unlike some pharmaceutical diuretics. Useful when fluid retention is contributing to elevated blood pressure.',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Herbs for Hypertension - Diuretics and Therapeutic Foods', 10,
   '# Herbal Spotlight: Diuretics for Hypertension
- Dandelion leaf (Taraxacum officinale) is a potassium-sparing diuretic — helps release excess fluid without depleting potassium (unlike some pharmaceutical diuretics)
- Poria (Wolfporia cocos) supports fluid regulation with an earth-element/spleen focus; Green tea is a milder diuretic whose effect varies considerably person to person

# Pomegranate for Blood Pressure
- Pomegranate is well-established for maintaining healthy blood pressure and reducing elevated BP; eating the whole fruit is preferable, or small amounts of juice (1-2 oz/day) to avoid excess sugar
- Available in supplements and herbal formulas for those who prefer that form

# Garlic as Cardiovascular Kitchen Medicine
- Garlic (Allium sativum) is powerful kitchen medicine for blood pressure — affordable, accessible, and therapeutically effective; cardiovascular benefits are heat-stable (cooked garlic works), unlike its immune-active constituents (which require raw garlic)
- Never overlook garlic; supplements are acceptable but whole garlic added generously to food is the ideal form

# Celery Seed as a Hypotensive Therapeutic Food
- Celery seed (Apium graveolens) has mild diuretic properties and acts as a renal and bladder alternative, supporting healthy blood pressure through its effect on fluid and kidney function
- A useful addition both as a culinary herb and in herbal formulas targeting hypertension with fluid retention'),

  (1541,
   'Poria (Wolfporia cocos) supports fluid regulation with an earth-element/spleen focus. Used as a mild diuretic for hypertension when spleen-earth disharmony drives fluid retention.',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Herbs for Hypertension - Diuretics and Therapeutic Foods', 20,
   '# Herbal Spotlight: Diuretics for Hypertension
- Dandelion leaf (Taraxacum officinale) is a potassium-sparing diuretic — helps release excess fluid without depleting potassium (unlike some pharmaceutical diuretics)
- Poria (Wolfporia cocos) supports fluid regulation with an earth-element/spleen focus; Green tea is a milder diuretic whose effect varies considerably person to person

# Pomegranate for Blood Pressure
- Pomegranate is well-established for maintaining healthy blood pressure and reducing elevated BP; eating the whole fruit is preferable, or small amounts of juice (1-2 oz/day) to avoid excess sugar
- Available in supplements and herbal formulas for those who prefer that form

# Garlic as Cardiovascular Kitchen Medicine
- Garlic (Allium sativum) is powerful kitchen medicine for blood pressure — affordable, accessible, and therapeutically effective; cardiovascular benefits are heat-stable (cooked garlic works), unlike its immune-active constituents (which require raw garlic)
- Never overlook garlic; supplements are acceptable but whole garlic added generously to food is the ideal form

# Celery Seed as a Hypotensive Therapeutic Food
- Celery seed (Apium graveolens) has mild diuretic properties and acts as a renal and bladder alternative, supporting healthy blood pressure through its effect on fluid and kidney function
- A useful addition both as a culinary herb and in herbal formulas targeting hypertension with fluid retention'),

  (21,
   'Garlic (Allium sativum) is powerful kitchen medicine for blood pressure — affordable, accessible, and therapeutically effective. Cardiovascular benefits are heat-stable (cooked garlic works), unlike its immune-active constituents which require raw garlic. Supplements are acceptable but whole garlic added generously to food is the ideal form.',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Herbs for Hypertension - Diuretics and Therapeutic Foods', 30,
   '# Garlic as Cardiovascular Kitchen Medicine
- Garlic (Allium sativum) is powerful kitchen medicine for blood pressure — affordable, accessible, and therapeutically effective; cardiovascular benefits are heat-stable (cooked garlic works), unlike its immune-active constituents (which require raw garlic)
- Never overlook garlic; supplements are acceptable but whole garlic added generously to food is the ideal form'),

  (66,
   'Celery seed (Apium graveolens) has mild diuretic properties and acts as a renal and bladder alternative, supporting healthy blood pressure through its effect on fluid and kidney function. A useful addition both as a culinary herb and in herbal formulas targeting hypertension with fluid retention.',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Herbs for Hypertension - Diuretics and Therapeutic Foods', 40,
   '# Celery Seed as a Hypotensive Therapeutic Food
- Celery seed (Apium graveolens) has mild diuretic properties and acts as a renal and bladder alternative, supporting healthy blood pressure through its effect on fluid and kidney function
- A useful addition both as a culinary herb and in herbal formulas targeting hypertension with fluid retention'),

  -- === HAWTHORN AND HIBISCUS FOR HYPERTENSION ===
  (73,
   'Hawthorn (Crataegus spp.) is warming overall but clears heat from the Heart — a useful energetic paradox for people who are cold but have trapped heat driving their BP up. Rich in flavonoids that nourish endothelial suppleness over the long term; especially helpful when hypertension has an emotional/stress component. Tea recipe: 2 heaping tablespoons each of powdered hawthorn and hibiscus, 1 quart boiling water, steep 1 hour, drink throughout the day.',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Hawthorn and Hibiscus for Hypertension', 50,
   '# Hawthorn (Crataegus spp.) - Warming but Clears Heart Heat
- Hawthorn is warming overall but clears heat from the Heart — a useful energetic paradox for people who are cold but have trapped heat driving their BP up; sour and sweet in flavor
- Rich in flavonoids that nourish endothelial suppleness over the long term; especially helpful when hypertension has an emotional/stress component; not everybody''s medicine but always worth trying

# Hibiscus (Hibiscus sabdariffa) - Sour, Cooling, Clears Trapped Heat
- Hibiscus is sour and cooling, clearing trapped heat — well-established clinically for reducing elevated blood pressure; pairs beautifully with hawthorn in tea
- Best suited for the hot, fiery, anger-driven or heat-excess patterns of hypertension

# Hawthorn-Hibiscus Tea Recipe
- Recipe: 2 heaping tablespoons each of powdered hawthorn and hibiscus; pour 1 quart boiling water over herbs, steep 1 hour, strain, drink throughout the day
- Use heaping tablespoons for therapeutically effective strength; use more herb (not less) if working with unpowdered herb'),

  (2233,
   'Hibiscus (Hibiscus sabdariffa) is sour and cooling, clearing trapped heat — well-established clinically for reducing elevated blood pressure; pairs beautifully with hawthorn in tea. Best suited for hot, fiery, anger-driven or heat-excess patterns of hypertension. Classic pairing with hawthorn: 2 heaping tablespoons each, 1 quart boiling water, steep 1 hour.',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Hawthorn and Hibiscus for Hypertension', 60,
   '# Hawthorn (Crataegus spp.) - Warming but Clears Heart Heat
- Hawthorn is warming overall but clears heat from the Heart — a useful energetic paradox for people who are cold but have trapped heat driving their BP up; sour and sweet in flavor
- Rich in flavonoids that nourish endothelial suppleness over the long term; especially helpful when hypertension has an emotional/stress component; not everybody''s medicine but always worth trying

# Hibiscus (Hibiscus sabdariffa) - Sour, Cooling, Clears Trapped Heat
- Hibiscus is sour and cooling, clearing trapped heat — well-established clinically for reducing elevated blood pressure; pairs beautifully with hawthorn in tea
- Best suited for the hot, fiery, anger-driven or heat-excess patterns of hypertension

# Hawthorn-Hibiscus Tea Recipe
- Recipe: 2 heaping tablespoons each of powdered hawthorn and hibiscus; pour 1 quart boiling water over herbs, steep 1 hour, strain, drink throughout the day
- Use heaping tablespoons for therapeutically effective strength; use more herb (not less) if working with unpowdered herb'),

  -- === LIVER YANG RISING ===
  (1600,
   'Mulberry bark (Morus alba) clears heat without depleting yin — a key advantage for the already-depleted Liver Yang Rising pattern, where nourishing yin is as important as clearing heat. Indicated when irritability, dizziness, and headache arise from underlying yin deficiency ("false heat" or "empty heat").',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Liver Yang Rising', 70,
   '# Liver Yang Rising - Pattern Signs
- Signs: irritability, frustration, anger, dizziness, headache with underlying yin deficiency; tongue dry, red, cracked, sometimes quivering; pulse floating
- This is "false heat" or "empty heat" — the water element is weak and cannot cool the fire; nourishing yin is essential, not just clearing heat

# Herbs for Liver Yang Rising: Mulberry Bark, Self-Heal, Valerian
- Mulberry bark (Morus alba) clears heat without depleting yin — a key advantage for the already-depleted Liver Yang Rising pattern; Self-Heal (Prunella vulgaris) is excellent for anger/irritability but needs yin-nourishing companions
- Valerian (Valeriana officinalis) can be profound medicine for this pattern when it''s the right fit; introduce slowly as effects are variable (sometimes stimulating rather than sedating)

# Linden (Tilia spp.) - Moistening, Yin-Nourishing
- Linden (Tilia spp.) is moistening, yin-nourishing, and sweet — brings the nourishing rain to put out the fire rather than just cooling; ideal companion when the person is depleted
- Rich uses linden as a primary herb for some clients with hypertension; works best as a tea; gentle enough to enjoy daily

# Chrysanthemum Flower - Cooling and Moistening Without Depleting Yin
- Chrysanthemum flower is moistening, cooling, sweet and bitter — clears Liver Yang and heat from frustration/anger without depleting yin (key advantage over purely drying cold herbs)
- Widely consumed as a pleasant everyday tea in Asia; clinically useful for pulling liver yang energy downward when there''s heat, irritability, and rising blood pressure'),

  (2437,
   'Self-Heal (Prunella vulgaris) is excellent for anger and irritability in the Liver Yang Rising pattern of hypertension, but needs yin-nourishing companions to address the underlying yin deficiency driving the false heat.',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Liver Yang Rising', 80,
   '# Herbs for Liver Yang Rising: Mulberry Bark, Self-Heal, Valerian
- Mulberry bark (Morus alba) clears heat without depleting yin — a key advantage for the already-depleted Liver Yang Rising pattern; Self-Heal (Prunella vulgaris) is excellent for anger/irritability but needs yin-nourishing companions
- Valerian (Valeriana officinalis) can be profound medicine for this pattern when it''s the right fit; introduce slowly as effects are variable (sometimes stimulating rather than sedating)'),

  (145,
   'Valerian (Valeriana officinalis) can be profound medicine for Liver Yang Rising hypertension when it is the right fit; however, its effects are variable — sometimes stimulating rather than sedating. Introduce slowly and attend carefully to the individual''s response.',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Liver Yang Rising', 90,
   '# Herbs for Liver Yang Rising: Mulberry Bark, Self-Heal, Valerian
- Mulberry bark (Morus alba) clears heat without depleting yin — a key advantage for the already-depleted Liver Yang Rising pattern; Self-Heal (Prunella vulgaris) is excellent for anger/irritability but needs yin-nourishing companions
- Valerian (Valeriana officinalis) can be profound medicine for this pattern when it''s the right fit; introduce slowly as effects are variable (sometimes stimulating rather than sedating)'),

  (90,
   'Linden (Tilia spp.) is moistening, yin-nourishing, and sweet — brings the nourishing rain to put out the fire rather than just cooling. Ideal companion when the hypertensive person is depleted; Rich uses linden as a primary herb for some clients with hypertension. Works best as a tea; gentle enough to enjoy daily.',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Liver Yang Rising', 100,
   '# Linden (Tilia spp.) - Moistening, Yin-Nourishing
- Linden (Tilia spp.) is moistening, yin-nourishing, and sweet — brings the nourishing rain to put out the fire rather than just cooling; ideal companion when the person is depleted
- Rich uses linden as a primary herb for some clients with hypertension; works best as a tea; gentle enough to enjoy daily'),

  (1572,
   'Chrysanthemum flower is moistening, cooling, sweet and bitter — clears Liver Yang and heat from frustration/anger without depleting yin (key advantage over purely drying cold herbs). Widely consumed as everyday tea in Asia; clinically useful for pulling liver yang energy downward when there is heat, irritability, and rising blood pressure.',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Liver Yang Rising', 110,
   '# Chrysanthemum Flower - Cooling and Moistening Without Depleting Yin
- Chrysanthemum flower is moistening, cooling, sweet and bitter — clears Liver Yang and heat from frustration/anger without depleting yin (key advantage over purely drying cold herbs)
- Widely consumed as a pleasant everyday tea in Asia; clinically useful for pulling liver yang energy downward when there''s heat, irritability, and rising blood pressure'),

  -- === LIVER FIRE ===
  (2274,
   'Baikal skullcap (Scutellaria baicalensis) — Huang Qin in Chinese medicine — clears Liver Fire with strongly cooling and bitter energy. Distinct from North American skullcap (Scutellaria lateriflora), which is a nervine used very differently. Specifically indicated for the Liver Fire pattern: red tongue with red sides and yellow coating, rapid wiry pulse.',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Liver Fire', 120,
   '# Liver Fire - Pattern Signs
- Liver Fire is more severe and pronounced than Liver Yang Rising — a true excess condition; anger, irritability; tongue red with red sides and yellow coating; rapid, wiry pulse
- Treatment approach: more overtly bitter, cooling herbs; avoid spicy foods; can look similar to Liver Yang Rising but is a hotter, more excess state requiring more aggressive cooling

# Baikal Skullcap (Scutellaria baicalensis) for Liver Fire
- Baikal skullcap (Scutellaria baicalensis) — Huang Qin in Chinese medicine — clears Liver Fire; strongly cooling and bitter; distinct from North American skullcap (Scutellaria lateriflora), which is a nervine used very differently
- Specifically indicated for the Liver Fire pattern with red tongue, yellow coating, and rapid wiry pulse'),

  -- === TENSION-DRIVEN HYPERTENSION ===
  (131,
   'Motherwort (Leonurus cardiaca) addresses tension-driven hypertension, especially when emotional distress physically manifests as tension in the body. Key clinical question: "How does your emotional distress manifest in your body, and where does it feel like tension?"',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Tension-Driven Hypertension', 130,
   '# Relax and Relieve Tension: Motherwort, Wood Betony, Valerian
- Motherwort (Leonurus cardiaca), Wood Betony (Stachys officinalis), and Valerian (Valeriana officinalis) address tension-driven hypertension — especially when distress physically manifests as tension in the body
- Key clinical question: "How does your emotional distress manifest in your body, and where does it feel like tension?"

# Relax and Relieve Tension: Black Haw and Crampbark
- Black Haw (Viburnum prunifolium) and Crampbark (Viburnum spp.) relax and relieve tension in blood vessels and smooth muscle throughout the body, including vascular walls
- Useful when tension is a primary driver of elevated blood pressure, independent of emotional pattern'),

  (207,
   'Wood Betony (Stachys officinalis) addresses tension-driven hypertension, especially when emotional distress manifests as physical tension in the body.',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Tension-Driven Hypertension', 140,
   '# Relax and Relieve Tension: Motherwort, Wood Betony, Valerian
- Motherwort (Leonurus cardiaca), Wood Betony (Stachys officinalis), and Valerian (Valeriana officinalis) address tension-driven hypertension — especially when distress physically manifests as tension in the body
- Key clinical question: "How does your emotional distress manifest in your body, and where does it feel like tension?"'),

  (145,
   'Valerian (Valeriana officinalis) addresses tension-driven hypertension when distress manifests as physical tension in the body. As with Liver Yang Rising, introduce slowly — effects can be variable and sometimes stimulating rather than sedating.',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Tension-Driven Hypertension', 150,
   '# Relax and Relieve Tension: Motherwort, Wood Betony, Valerian
- Motherwort (Leonurus cardiaca), Wood Betony (Stachys officinalis), and Valerian (Valeriana officinalis) address tension-driven hypertension — especially when distress physically manifests as tension in the body
- Key clinical question: "How does your emotional distress manifest in your body, and where does it feel like tension?"'),

  (94,
   'Black Haw (Viburnum prunifolium) relaxes and relieves tension in blood vessels and smooth muscle throughout the body, including vascular walls. Useful when tension is a primary driver of elevated blood pressure, independent of emotional pattern.',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Tension-Driven Hypertension', 160,
   '# Relax and Relieve Tension: Black Haw and Crampbark
- Black Haw (Viburnum prunifolium) and Crampbark (Viburnum spp.) relax and relieve tension in blood vessels and smooth muscle throughout the body, including vascular walls
- Useful when tension is a primary driver of elevated blood pressure, independent of emotional pattern'),

  (93,
   'Cramp Bark (Viburnum spp.) relaxes and relieves tension in blood vessels and smooth muscle throughout the body, including vascular walls. Useful when tension is a primary driver of elevated blood pressure, independent of emotional pattern.',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Tension-Driven Hypertension', 170,
   '# Relax and Relieve Tension: Black Haw and Crampbark
- Black Haw (Viburnum prunifolium) and Crampbark (Viburnum spp.) relax and relieve tension in blood vessels and smooth muscle throughout the body, including vascular walls
- Useful when tension is a primary driver of elevated blood pressure, independent of emotional pattern'),

  -- === DAMP STAGNATION ===
  (1541,
   'Poria (Wolfporia extensa) supports spleen/earth function and fluid regulation in the Damp Stagnation pattern of hypertension. This pattern presents with heaviness, nausea, bloating, edema, foggy-headedness, pale swollen tongue with toothmarks, slippery pulse. Approach: warming and moving, not cooling.',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Damp Stagnation', 180,
   '# Damp Stagnation - Pattern Signs
- A Spleen (Earth element) disharmony: worry, feeling ungrounded; heaviness, nausea, bloating, edema, foggy-headedness; pale, swollen, damp tongue with toothmarks; slippery pulse
- Avoid greasy and overly cold foods; focus on warming, pungent foods and herbs; this is not a fiery or dry pattern — approach is warming and moving, not cooling

# Herbs for Damp Stagnation: Poria, Elecampane, Schisandra
- Poria (Wolfporia extensa) supports spleen/earth function and fluid regulation; Elecampane (Inula helenium) is warming and aromatic, moves damp stagnation
- Schisandra (Schisandra chinensis) is adaptogenic and supports both constitution and organ function; these address the underlying disharmony, not blood pressure directly'),

  (54,
   'Elecampane (Inula helenium) is warming and aromatic, moving damp stagnation in the Damp Stagnation pattern of hypertension. These herbs address the underlying disharmony, not blood pressure directly.',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Damp Stagnation', 190,
   '# Herbs for Damp Stagnation: Poria, Elecampane, Schisandra
- Poria (Wolfporia extensa) supports spleen/earth function and fluid regulation; Elecampane (Inula helenium) is warming and aromatic, moves damp stagnation
- Schisandra (Schisandra chinensis) is adaptogenic and supports both constitution and organ function; these address the underlying disharmony, not blood pressure directly'),

  (17,
   'Schisandra (Schisandra chinensis) is adaptogenic and supports both constitution and organ function in the Damp Stagnation pattern of hypertension. These herbs address the underlying disharmony, not blood pressure directly.',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Damp Stagnation', 200,
   '# Herbs for Damp Stagnation: Poria, Elecampane, Schisandra
- Poria (Wolfporia extensa) supports spleen/earth function and fluid regulation; Elecampane (Inula helenium) is warming and aromatic, moves damp stagnation
- Schisandra (Schisandra chinensis) is adaptogenic and supports both constitution and organ function; these address the underlying disharmony, not blood pressure directly'),

  -- === BLOOD STASIS ===
  (1009,
   'Dang Gui (Angelica sinensis) moves the blood and can lower BP in the Blood Stasis/Congealed Heart Blood pattern of hypertension (stabbing headache, chest pain/angina, purplish tongue, knotted/choppy pulse). CAUTION: Avoid all blood-moving herbs with anticoagulant drugs (warfarin, aspirin therapy, etc.).',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Blood Stasis', 210,
   '# Congealed Heart Blood / Blood Stasis
- Stagnation that acts like a dam obstructing the flow of blood; biomedically associated with atherosclerosis and ischemic conditions
- Increased pressure upstream results from the obstruction — moving the blood is the primary therapeutic goal

# Blood Stasis - Pattern Signs
- Signs: stabbing or constant headache, chest pain/angina, purplish tongue, knotted/choppy/wiry pulse; look for atherosclerosis or more systemic heart disease; avoid heavy, greasy foods
- Moving the blood is essential — both with herbs and physical movement (exercise); chest pain warrants medical evaluation

# Blood Moving Herbs: Dang Gui, Ginkgo, Dan Shen
- Dang gui (Angelica sinensis), Ginkgo (Ginkgo biloba), and Dan shen (Salvia miltiorrhiza) move the blood and can lower BP in the right person; Ginkgo has even been seen to lower already-low BP in some people, so monitor carefully
- Avoid all blood-moving herbs with anticoagulant drugs (warfarin, aspirin therapy, etc.)'),

  (165,
   'Ginkgo (Ginkgo biloba) moves the blood and can lower BP in Blood Stasis hypertension. Important caution: Ginkgo has been seen to lower already-low BP in some people — monitor carefully. Avoid with anticoagulant drugs (warfarin, aspirin therapy).',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Blood Stasis', 220,
   '# Blood Moving Herbs: Dang Gui, Ginkgo, Dan Shen
- Dang gui (Angelica sinensis), Ginkgo (Ginkgo biloba), and Dan shen (Salvia miltiorrhiza) move the blood and can lower BP in the right person; Ginkgo has even been seen to lower already-low BP in some people, so monitor carefully
- Avoid all blood-moving herbs with anticoagulant drugs (warfarin, aspirin therapy, etc.)'),

  (956,
   'Dan Shen (Salvia miltiorrhiza) moves the blood and can lower BP in Blood Stasis hypertension. CAUTION: Avoid with anticoagulant drugs (warfarin, aspirin therapy, etc.).',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Blood Stasis', 230,
   '# Blood Moving Herbs: Dang Gui, Ginkgo, Dan Shen
- Dang gui (Angelica sinensis), Ginkgo (Ginkgo biloba), and Dan shen (Salvia miltiorrhiza) move the blood and can lower BP in the right person; Ginkgo has even been seen to lower already-low BP in some people, so monitor carefully
- Avoid all blood-moving herbs with anticoagulant drugs (warfarin, aspirin therapy, etc.)'),

  -- === KIDNEY DEFICIENCY ===
  (2634,
   'Cordyceps is tonifying and gently warming for the Kidney Deficiency pattern in hypertension, nourishing the deep essence. Signs of Kidney Deficiency driving hypertension: dizziness, fatigue, fear; differentiate between Kidney Yin and Yang depletion (both can be depleted simultaneously).',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Kidney Deficiency', 240,
   '# Kidney Depletion - Pattern Signs and Herbs
- Signs: dizziness, fatigue, fear; differentiate between Kidney Yin and Yang depletion (both can be depleted simultaneously); gentle movement and gently warming foods are appropriate
- Key herbs: Cordyceps, Goji (Lycium chinense), Schisandra (Schisandra chinensis), Milky Oats — tonifying, gently warming, nourishing the deep essence'),

  (1548,
   'Wolfberry/Goji (Lycium chinense) is tonifying and gently warming, nourishing the deep kidney essence in the Kidney Deficiency pattern of hypertension. Used alongside Cordyceps, Schisandra, and Milky Oats.',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Kidney Deficiency', 250,
   '# Kidney Depletion - Pattern Signs and Herbs
- Signs: dizziness, fatigue, fear; differentiate between Kidney Yin and Yang depletion (both can be depleted simultaneously); gentle movement and gently warming foods are appropriate
- Key herbs: Cordyceps, Goji (Lycium chinense), Schisandra (Schisandra chinensis), Milky Oats — tonifying, gently warming, nourishing the deep essence'),

  (17,
   'Schisandra (Schisandra chinensis) is tonifying and nourishes the deep kidney essence in the Kidney Deficiency pattern of hypertension, alongside Cordyceps, Goji, and Milky Oats.',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Kidney Deficiency', 260,
   '# Kidney Depletion - Pattern Signs and Herbs
- Signs: dizziness, fatigue, fear; differentiate between Kidney Yin and Yang depletion (both can be depleted simultaneously); gentle movement and gently warming foods are appropriate
- Key herbs: Cordyceps, Goji (Lycium chinense), Schisandra (Schisandra chinensis), Milky Oats — tonifying, gently warming, nourishing the deep essence'),

  (178,
   'Milky Oats (Avena sativa) are tonifying and nourishing for the Kidney Deficiency pattern in hypertension, supporting the deep essence alongside Cordyceps, Goji, and Schisandra.',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Kidney Deficiency', 270,
   '# Kidney Depletion - Pattern Signs and Herbs
- Signs: dizziness, fatigue, fear; differentiate between Kidney Yin and Yang depletion (both can be depleted simultaneously); gentle movement and gently warming foods are appropriate
- Key herbs: Cordyceps, Goji (Lycium chinense), Schisandra (Schisandra chinensis), Milky Oats — tonifying, gently warming, nourishing the deep essence'),

  -- === OLIVE LEAF, MISTLETOE, AND RAUWOLFIA FOR HYPERTENSION ===
  (106,
   'Olive leaf (Olea europaea) is bitter, cooling, and drying with significant science behind it for reducing blood pressure, especially when atherosclerosis is also present. The leaf is the medicinal part — distinct from the nutritious olive fruit and oil. Pairs well with herbs addressing accompanying heart disease.',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Olive Leaf, Mistletoe, and Rauwolfia for Hypertension', 280,
   '# Olive Leaf (Olea europaea) - Bitter, Cooling, Drying
- Olive leaf (Olea europaea) is bitter, cooling, and drying with significant science behind it for reducing blood pressure, especially when atherosclerosis is also present
- Distinct from the nutritious olive fruit and oil — the leaf is the medicinal part; pairs well with herbs addressing accompanying heart disease

# Mistletoe (Viscum album) - Cooling, Clearing Liver Fire
- Mistletoe (Viscum album) is cooling, neutral, and bitter — helpful for Liver Fire and Liver Yang Rising patterns; best combined with yin-nourishing herbs when yin depletion is present
- Well-studied for hypertension; a single-herb pilot study showed meaningful systolic/diastolic reduction after 12 weeks

# Mistletoe Clinical Study - Blood Pressure Reduction at 12 Weeks
- After 12 weeks of Viscum album: systolic dropped from 155.8 to 141.5 mmHg (-14 points, p<0.0001); diastolic from 84.4 to 79.5 mmHg (-5 points, p=0.00177)
- A drop of ~14 systolic points from a single herb is clinically meaningful — can bring someone from Stage 2 into a significantly safer range (Poruthukaren et al., JACAM 2014)

# Rauwolfia (Rauvolfia serpentina) - Bitter, Cooling, Calming
- Rauwolfia (Rauvolfia serpentina) is bitter, cooling, and calming — used traditionally in South Asia, Eastern Asia, and parts of Africa; its alkaloid reserpine has had pharmaceutical applications as a hypotensive drug
- Works via a different mechanism than other hypotensive herbs — influences neurotransmitters that reduce sympathetic nervous system tone; consider when other herbs haven''t been sufficient

# Reserpine from Rauwolfia: Comparable to First-Line Antihypertensive Drugs
- Cochrane review: reserpine (the active alkaloid in Rauwolfia) is effective in reducing systolic blood pressure roughly to the same degree as other first-line antihypertensive drugs (Shamon & Perez, Cochrane Database 2016)
- Rauwolfia is an herb to consider when hypertension isn''t responding to other strategies; use the whole herb or extracts, not just isolated reserpine'),

  (211,
   'Mistletoe (Viscum album) is cooling, neutral, and bitter — helpful for Liver Fire and Liver Yang Rising patterns of hypertension; best combined with yin-nourishing herbs when yin depletion is present. Clinical study: after 12 weeks, systolic dropped from 155.8 to 141.5 mmHg (-14 points, p<0.0001); diastolic from 84.4 to 79.5 mmHg (-5 points, p=0.00177) (Poruthukaren et al., JACAM 2014). A 14-point systolic drop from a single herb is clinically meaningful.',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Olive Leaf, Mistletoe, and Rauwolfia for Hypertension', 290,
   '# Mistletoe (Viscum album) - Cooling, Clearing Liver Fire
- Mistletoe (Viscum album) is cooling, neutral, and bitter — helpful for Liver Fire and Liver Yang Rising patterns; best combined with yin-nourishing herbs when yin depletion is present
- Well-studied for hypertension; a single-herb pilot study showed meaningful systolic/diastolic reduction after 12 weeks

# Mistletoe Clinical Study - Blood Pressure Reduction at 12 Weeks
- After 12 weeks of Viscum album: systolic dropped from 155.8 to 141.5 mmHg (-14 points, p<0.0001); diastolic from 84.4 to 79.5 mmHg (-5 points, p=0.00177)
- A drop of ~14 systolic points from a single herb is clinically meaningful — can bring someone from Stage 2 into a significantly safer range (Poruthukaren et al., JACAM 2014)'),

  (2758,
   'Rauwolfia (Rauvolfia serpentina) is bitter, cooling, and calming — works via a different mechanism than other hypotensive herbs, influencing neurotransmitters that reduce sympathetic nervous system tone. Cochrane review: reserpine (its active alkaloid) reduces systolic BP to roughly the same degree as other first-line antihypertensive drugs (Shamon & Perez, Cochrane 2016). Consider when other herbal approaches have not been sufficient; use the whole herb or extracts, not just isolated reserpine.',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Olive Leaf, Mistletoe, and Rauwolfia for Hypertension', 300,
   '# Rauwolfia (Rauvolfia serpentina) - Bitter, Cooling, Calming
- Rauwolfia (Rauvolfia serpentina) is bitter, cooling, and calming — used traditionally in South Asia, Eastern Asia, and parts of Africa; its alkaloid reserpine has had pharmaceutical applications as a hypotensive drug
- Works via a different mechanism than other hypotensive herbs — influences neurotransmitters that reduce sympathetic nervous system tone; consider when other herbs haven''t been sufficient

# Reserpine from Rauwolfia: Comparable to First-Line Antihypertensive Drugs
- Cochrane review: reserpine (the active alkaloid in Rauwolfia) is effective in reducing systolic blood pressure roughly to the same degree as other first-line antihypertensive drugs (Shamon & Perez, Cochrane Database 2016)
- Rauwolfia is an herb to consider when hypertension isn''t responding to other strategies; use the whole herb or extracts, not just isolated reserpine'),

  -- === CLINICAL FORMULAS FOR HYPERTENSION ===
  (1652,
   'Hawthorn leaf, flower, and berry (Crataegus spp.) is a core ingredient in Rich''s clinical formulas for hypertension: Cardio Calmpound (Herbalists & Alchemists, 60 drops 2-3x/day — a good starting formula combining heat-clearing, yin-nourishing, tension-relieving, and endothelial-supporting herbs) and HTN 180 Px (100mg per capsule).',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Clinical Formulas for Hypertension', 310,
   '# Formula 1: David Winston''s Cardio Calmpound (Herbalists & Alchemists)
- Cardio Calmpound tincture: Hawthorn berry/flower/leaf (Crataegus spp.), Linden flower and leaf (Tilia spp.), Motherwort flowering tops (Leonurus cardiaca), Olive leaf (Olea europaea), European Mistletoe (Viscum album)
- A good starting formula for many hypertension patterns — combines heat-clearing, yin-nourishing, tension-relieving, and endothelial-supporting herbs; Rich often starts here (60 drops 2-3x/day)

# Formula 3: Restorative Formulations HTN 180 Px (with Rauwolfia)
- HTN 180 Px capsules: Rauwolfia (Rauvolfia vomitoria) 150mg, Motherwort (Leonurus cardiaca) 145mg, Hawthorn leaf and flower (Crataegus spp.) 100mg, Vitexins 1.25mg, Passionflower (Passiflora incarnata) 100mg, European Mistletoe (Viscum album) 50mg
- Rich often sees results with this formula when other approaches haven''t been sufficient; the Rauwolfia targeting neurotransmitter/SNS pathways is likely the key differentiating factor; start at 1 capsule 3x/day'),

  (137,
   'Passionflower (Passiflora incarnata) is an ingredient in Restorative Formulations HTN 180 Px (100mg per capsule), Rich''s go-to formula when other hypertension approaches have not been sufficient. Start at 1 capsule 3x/day; reduces to 2 capsules/day if BP comes down too far.',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Clinical Formulas for Hypertension', 320,
   '# Formula 3: Restorative Formulations HTN 180 Px (with Rauwolfia)
- HTN 180 Px capsules: Rauwolfia (Rauvolfia vomitoria) 150mg, Motherwort (Leonurus cardiaca) 145mg, Hawthorn leaf and flower (Crataegus spp.) 100mg, Vitexins 1.25mg, Passionflower (Passiflora incarnata) 100mg, European Mistletoe (Viscum album) 50mg
- Rich often sees results with this formula when other approaches haven''t been sufficient; the Rauwolfia targeting neurotransmitter/SNS pathways is likely the key differentiating factor; start at 1 capsule 3x/day'),

  (13,
   'Holy Basil (Ocimum sanctum) is part of the Harmonizing Blend (100mg) in Gaia Herbs PRO Vascular Endothelial Complex, combined with Hibiscus and Grape seed extract. This formula (also containing Pomegranate 350mg and Olive leaf 185mg) is useful for clients who prefer capsules over teas or tinctures.',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Clinical Formulas for Hypertension', 330,
   '# Formula 2: Gaia Herbs PRO Vascular Endothelial Complex
- Contains: Pomegranate fruit extract 350mg, Olive leaf extract 185mg (Oleuropein 70mg), Harmonizing Blend 100mg (Hibiscus, Holy Basil, Grape seed extract)
- Combines pomegranate and olive leaf (both with strong BP evidence) with hibiscus and adaptogens in capsule form — useful for clients who prefer capsules over teas or tinctures'),

  (2230,
   'Grape seed extract is part of the Harmonizing Blend (100mg) in Gaia Herbs PRO Vascular Endothelial Complex for blood pressure support, combined with Hibiscus and Holy Basil. This formula also contains Pomegranate 350mg and Olive leaf 185mg (Oleuropein 70mg).',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Clinical Formulas for Hypertension', 340,
   '# Formula 2: Gaia Herbs PRO Vascular Endothelial Complex
- Contains: Pomegranate fruit extract 350mg, Olive leaf extract 185mg (Oleuropein 70mg), Harmonizing Blend 100mg (Hibiscus, Holy Basil, Grape seed extract)
- Combines pomegranate and olive leaf (both with strong BP evidence) with hibiscus and adaptogens in capsule form — useful for clients who prefer capsules over teas or tinctures'),

  -- === SAFETY - HERBS TO AVOID IN HYPERTENSION ===
  (78,
   'Whole licorice (Glycyrrhiza glabra) is CONTRAINDICATED in hypertension — glycyrrhizin influences cortisol and aldosterone, causing sodium and fluid retention that can raise BP. Avoid in anyone prone to high blood pressure. DGL (deglycyrrhizinated licorice) removes the glycyrrhizin and is safe for gut issues in hypertensive patients, but loses the adaptogenic/adrenal support properties of whole licorice.',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Safety - Herbs to Avoid in Hypertension', 350,
   '# Safety Continued: Herbs to Avoid and Individual Variation
- Avoid overly stimulating herbs that can raise blood pressure in some people: ginseng, Rhodiola; avoid licorice unless very experienced (can cause sodium retention and fluid retention raising BP)
- Even herbs that only mildly reduce blood pressure in most people may have a stronger impact in some individuals — always attend to the individual''s response

# A Note on Whole Licorice and DGL
- Whole licorice (Glycyrrhiza glabra) is contraindicated in hypertension — glycyrrhizin influences cortisol and aldosterone, causing sodium and fluid retention that can raise BP; avoid in anyone prone to high blood pressure
- DGL (deglycyrrhizinated licorice) removes the glycyrrhizin and is safe for gut issues in hypertensive patients, but loses the adaptogenic/adrenal support properties of whole licorice'),

  (14,
   'Ginseng (Panax ginseng) is an overly stimulating herb that can raise blood pressure in some people and should be avoided in hypertensive clients unless carefully monitored. Even herbs that only mildly affect blood pressure in most people may have a stronger impact in some individuals.',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Safety - Herbs to Avoid in Hypertension', 360,
   '# Safety Continued: Herbs to Avoid and Individual Variation
- Avoid overly stimulating herbs that can raise blood pressure in some people: ginseng, Rhodiola; avoid licorice unless very experienced (can cause sodium retention and fluid retention raising BP)
- Even herbs that only mildly reduce blood pressure in most people may have a stronger impact in some individuals — always attend to the individual''s response'),

  (16,
   'Rhodiola (Rhodiola rosea) is an overly stimulating herb that can raise blood pressure in some people and should be avoided in hypertensive clients. Attend carefully to the individual''s response even with herbs generally considered hypotensive.',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Safety - Herbs to Avoid in Hypertension', 370,
   '# Safety Continued: Herbs to Avoid and Individual Variation
- Avoid overly stimulating herbs that can raise blood pressure in some people: ginseng, Rhodiola; avoid licorice unless very experienced (can cause sodium retention and fluid retention raising BP)
- Even herbs that only mildly reduce blood pressure in most people may have a stronger impact in some individuals — always attend to the individual''s response'),

  -- === HYPOTENSION TREATMENT ===
  (78,
   'Licorice (Glycyrrhiza glabra) can actually HELP in hypotension — the same cortisol/aldosterone mechanism that raises BP in hypertensive patients becomes beneficial for raising low blood pressure. Also: hydrate with mineral-rich sea salts and electrolytes.',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Hypotension Treatment', 380,
   '# What to Do for Hypotension
- Licorice can actually help in hypotension (the opposite of hypertension); hydrate with mineral-rich sea salts and electrolytes; promote vascular integrity with horse chestnut (Aesculus hippocastanum) and flavonoid-rich foods
- Promote circulation with caution — some circulatory herbs (like Ginkgo) can lower BP further in some people; Rosemary (Rosmarinus officinalis) is often helpful'),

  (62,
   'Horse Chestnut (Aesculus hippocastanum) promotes vascular integrity and is recommended for hypotension treatment alongside mineral-rich hydration and flavonoid-rich foods.',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Hypotension Treatment', 390,
   '# What to Do for Hypotension
- Licorice can actually help in hypotension (the opposite of hypertension); hydrate with mineral-rich sea salts and electrolytes; promote vascular integrity with horse chestnut (Aesculus hippocastanum) and flavonoid-rich foods
- Promote circulation with caution — some circulatory herbs (like Ginkgo) can lower BP further in some people; Rosemary (Rosmarinus officinalis) is often helpful'),

  (109,
   'Rosemary (Rosmarinus officinalis) is often helpful for circulation in hypotension. Note: promote circulation with caution — some circulatory herbs (like Ginkgo) can lower BP further in some people. Rosemary is a generally safe first choice for hypotension.',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Hypotension Treatment', 400,
   '# What to Do for Hypotension
- Licorice can actually help in hypotension (the opposite of hypertension); hydrate with mineral-rich sea salts and electrolytes; promote vascular integrity with horse chestnut (Aesculus hippocastanum) and flavonoid-rich foods
- Promote circulation with caution — some circulatory herbs (like Ginkgo) can lower BP further in some people; Rosemary (Rosmarinus officinalis) is often helpful'),

  -- === CASE STUDY - SLEEP AND NERVOUS SYSTEM SUPPORT ===
  (128,
   'California Poppy (Eschscholzia californica) is Rich''s most-used herb for sleep quality — used in the evenings or for middle-of-night waking. Added to this case study client''s protocol after initial hypertension treatment wasn''t sufficient; combined with ashwagandha (daytime) and HTN 180 Px. Result: BP came down to healthy ranges (107/66, 115/73, etc.).',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Case Study - Sleep and Nervous System Support', 410,
   '# Case Study - Adding HTN 180 and Sleep Support
- Added HTN 180 Px formula at 1 capsule 3x/day; enhanced sleep support with ashwagandha throughout the day (for autonomic nervous system health, builds over weeks) and California poppy (Eschscholzia californica) in the evenings
- California poppy is Rich''s most-used herb for sleep quality — used in the evenings or for middle-of-night waking; ashwagandha addresses daytime SNS tone to support better sleep overall

# Case Study - Further Outcomes and Dosage Adjustment
- Success! BP came down to healthy ranges (107/66, 115/73, etc.) but client began feeling dizzy and lightheaded too frequently, especially orthostatic; reduced HTN 180 to 2 capsules/day and tincture to 40 drops (2ml) 3x/day
- Also advised: take herbs with meals; focus on hydration with mineral-rich sea salts and electrolytes to prevent orthostatic hypotension side effect

# Case Study - Long-Term Outcome: Herbs Are Doing the Work
- When the client neglected taking his herbs, his BP went back up — confirming the herbs were doing the work; over time he learned to self-adjust dosages based on how he felt and monitoring his BP
- Self-managed dosing based on symptoms and home BP monitoring is a reasonable long-term strategy for herb-responsive hypertension'),

  (20,
   'Ashwagandha (Withania somnifera) was used throughout the day in this case study for autonomic nervous system (ANS) health, with effects building over weeks. Ashwagandha addresses daytime SNS tone to support better sleep overall, complementing California Poppy''s direct sleep action in the evenings.',
   'Herbal Heart Health - Week 4 - Hypertension and Hypotension', 'generated',
   'Case Study - Sleep and Nervous System Support', 420,
   '# Case Study - Adding HTN 180 and Sleep Support
- Added HTN 180 Px formula at 1 capsule 3x/day; enhanced sleep support with ashwagandha throughout the day (for autonomic nervous system health, builds over weeks) and California poppy (Eschscholzia californica) in the evenings
- California poppy is Rich''s most-used herb for sleep quality — used in the evenings or for middle-of-night waking; ashwagandha addresses daytime SNS tone to support better sleep overall');

END $$;

-- === HERB KEYWORDS ===

-- Diuretics and therapeutic foods
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1648, 'hypertension',   'ailment'),
  (1648, 'edema',          'ailment'),
  (1648, 'diuretic',       'action'),
  (1648, 'hypotensive',    'action'),
  (1541, 'hypertension',   'ailment'),
  (1541, 'edema',          'ailment'),
  (1541, 'damp stagnation','ailment'),
  (1541, 'diuretic',       'action'),
  (21,   'hypertension',   'ailment'),
  (66,   'hypertension',   'ailment'),
  (66,   'edema',          'ailment'),
  (66,   'diuretic',       'action'),
  (66,   'hypotensive',    'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Hawthorn and Hibiscus
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (73,   'hypertension',   'ailment'),
  (73,   'heat clearing',  'action'),
  (2233, 'hypertension',   'ailment'),
  (2233, 'liver fire',     'ailment'),
  (2233, 'liver yang rising','ailment'),
  (2233, 'heat clearing',  'action'),
  (2233, 'hypotensive',    'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Liver Yang Rising herbs
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1600, 'liver yang rising','ailment'),
  (1600, 'hypertension',   'ailment'),
  (1600, 'yin deficiency', 'ailment'),
  (1600, 'heat clearing',  'action'),
  (1600, 'yin-nourishing', 'action'),
  (2437, 'liver yang rising','ailment'),
  (2437, 'liver fire',     'ailment'),
  (2437, 'hypertension',   'ailment'),
  (145,  'hypertension',   'ailment'),
  (145,  'liver yang rising','ailment'),
  (90,   'hypertension',   'ailment'),
  (90,   'liver yang rising','ailment'),
  (90,   'yin-nourishing', 'action'),
  (1572, 'liver yang rising','ailment'),
  (1572, 'liver fire',     'ailment'),
  (1572, 'hypertension',   'ailment'),
  (1572, 'heat clearing',  'action'),
  (1572, 'yin-nourishing', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Liver Fire
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2274, 'liver fire',     'ailment'),
  (2274, 'liver yang rising','ailment'),
  (2274, 'hypertension',   'ailment'),
  (2274, 'heat clearing',  'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Tension-driven hypertension
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (131,  'hypertension',         'ailment'),
  (131,  'stress',               'ailment'),
  (207,  'hypertension',         'ailment'),
  (207,  'stress',               'ailment'),
  (207,  'nervine',              'action'),
  (94,   'hypertension',         'ailment'),
  (94,   'vascular health',      'ailment'),
  (94,   'smooth muscle relaxant','action'),
  (93,   'hypertension',         'ailment'),
  (93,   'vascular health',      'ailment'),
  (93,   'smooth muscle relaxant','action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Damp Stagnation
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (54,   'damp stagnation', 'ailment'),
  (54,   'hypertension',    'ailment'),
  (17,   'damp stagnation', 'ailment'),
  (17,   'hypertension',    'ailment'),
  (17,   'kidney support',  'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Blood Stasis
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1009, 'blood stasis',   'ailment'),
  (1009, 'hypertension',   'ailment'),
  (1009, 'blood moving',   'action'),
  (165,  'blood stasis',   'ailment'),
  (165,  'hypertension',   'ailment'),
  (165,  'blood moving',   'action'),
  (956,  'blood stasis',   'ailment'),
  (956,  'hypertension',   'ailment'),
  (956,  'blood moving',   'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Kidney Deficiency
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2634, 'kidney support', 'ailment'),
  (2634, 'hypertension',   'ailment'),
  (1548, 'kidney support', 'ailment'),
  (1548, 'hypertension',   'ailment'),
  (1548, 'blood deficiency','ailment'),
  (178,  'kidney support', 'ailment'),
  (178,  'hypertension',   'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Olive Leaf, Mistletoe, Rauwolfia
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (106,  'hypertension',       'ailment'),
  (106,  'atherosclerosis',    'ailment'),
  (106,  'cardiovascular disease','ailment'),
  (106,  'hypotensive',        'action'),
  (211,  'hypertension',       'ailment'),
  (211,  'liver fire',         'ailment'),
  (211,  'liver yang rising',  'ailment'),
  (211,  'hypotensive',        'action'),
  (211,  'heat clearing',      'action'),
  (2758, 'hypertension',       'ailment'),
  (2758, 'hypotensive',        'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Clinical formula herbs (new IDs not covered above)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1652, 'hypertension',       'ailment'),
  (1652, 'cardiovascular disease','ailment'),
  (1652, 'endothelial protective','action'),
  (137,  'hypertension',       'ailment'),
  (137,  'sleep support',      'ailment'),
  (13,   'hypertension',       'ailment'),
  (13,   'vascular health',    'ailment'),
  (13,   'adaptogen',          'action'),
  (2230, 'hypertension',       'ailment'),
  (2230, 'vascular health',    'ailment'),
  (2230, 'cardiovascular disease','ailment'),
  (2230, 'antioxidant',        'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Safety
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (78,   'hypertension',  'ailment'),
  (78,   'hypotension',   'ailment'),
  (14,   'hypertension',  'ailment'),
  (16,   'hypertension',  'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Hypotension treatment
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (62,   'hypotension',   'ailment'),
  (62,   'vascular health','ailment'),
  (62,   'venous tonic',  'action'),
  (109,  'hypotension',   'ailment'),
  (109,  'circulation',   'ailment'),
  (109,  'circulatory stimulant','action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Case study
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (128,  'sleep support', 'ailment'),
  (128,  'hypertension',  'ailment'),
  (20,   'hypertension',  'ailment'),
  (20,   'sleep support', 'ailment'),
  (20,   'stress',        'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- === AILMENT SEARCH TERMS (new keywords only) ===
INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('liver yang rising',
   ARRAY['liver yang hyperactivity', 'ascending liver yang', 'liver yang ascendant', 'empty heat', 'false heat from yin deficiency', 'liver yang uprising']),
  ('liver fire',
   ARRAY['gan huo', 'liver fire flaring', 'liver fire blazing', 'liver heat excess', 'liver fire excess']),
  ('damp stagnation',
   ARRAY['damp obstruction', 'spleen dampness', 'earth element imbalance', 'phlegm-damp', 'dampness accumulation', 'spleen qi deficiency with dampness']),
  ('blood stasis',
   ARRAY['blood stagnation', 'congealed blood', 'blood obstruction', 'stagnant blood', 'static blood', 'congealed heart blood'])
ON CONFLICT (ailment_keyword) DO NOTHING;
