-- Migration 319: Class 33 — Skin 1 and Food Sensitivities
--
-- Source file: BHC - Class 33 - Skin 1 and Food Sensitivities - Lisa Christine.md
-- (single personal notes file; note_type = 'personal' throughout)
--
-- Morning session (Lisa): wound care protocol with Curbside Care Clinic,
--   wound wash herbs, Chaparral and Myrrh profiles.
-- Afternoon session (Christine): food sensitivities, gut healing, digestive
--   fire, microbiome support, elimination/detox, nervous system regulation,
--   digestive tincture blend activity.
--
-- Herb normalisations applied:
--   Schisandra / Schizandra → Schizandra (Schisandra chinensis) id 17
--   OGR / Oregon Grape Root → Oregon Grape (Mahonia aquifolium) id 33
--   Tulsi → Holy Basil (Ocimum sanctum) id 13
--   SJW → St. John's Wort (Hypericum perforatum) id 81
--   Dandelion root → id 122; Dandelion leaf → id 1648
--
-- Andrographis paniculata added in migration 318 (not previously in DB).
--
-- Herbs skipped (not in herbal.herbs or herbal.supplements):
--   Cumin (Cuminum cyminum) — listed only as a warming spice with no clinical detail
--   Bentonite clay — mineral preparation, not a plant
--   Honey — food/wound preparation, not a plant
--   Kombu, aloe in wound wash ("no" note only — snippet created using existing Aloe id)
--
-- Supplements used (herbal.supplements):
--   Garlic  → supplement_id 38
--   Magnesium → supplement_id 21
--
-- New ailment keywords introduced: food sensitivities, abscess, gingivitis,
--   mouth ulcers, microbiome support, skin infection
-- Merged into existing: wound healing, leaky gut, liver support, gut inflammation,
--   digestive tonic, constipation, stress, anxiety, immune support, lymphatic support

SET search_path TO herbal, public;

-- ── Snippets ────────────────────────────────────────────────────────────────

DO $$
DECLARE
  v_and_id INTEGER;

  -- source blocks (defined once, reused per section)
  sb_wound_care      TEXT;
  sb_wound_actions   TEXT;
  sb_wound_wash      TEXT;
  sb_chaparral       TEXT;
  sb_myrrh           TEXT;
  sb_food_sens       TEXT;
  sb_gut_lining      TEXT;
  sb_dig_fire        TEXT;
  sb_microbiome      TEXT;
  sb_elim_detox      TEXT;
  sb_nervous         TEXT;
  sb_tincture_blend  TEXT;

  v_class TEXT := 'BHC - Class 33 - Skin 1 and Food Sensitivities - Lisa Christine';
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets WHERE class_name = v_class) THEN
    RAISE NOTICE 'Class 33 snippets already loaded, skipping';
    RETURN;
  END IF;

  v_and_id := herbal.ensure_herb('Andrographis paniculata', 'Andrographis');

  -- ── Source blocks ──────────────────────────────────────────────────────────

  sb_wound_care := E'## Herbal Wound Care with Curbside Care Clinic\n'
    '- protocol\n'
    '    - 1.) medicated wet wipes\n'
    '        - solution of distilled water, add Tea tree and lavender, add 60cc syringe to the package\n'
    '        - covers gram negative and gram positive bacteria\n'
    '            - negative, tea tree: e coli\n'
    '            - positive, lavender: staph and MRSA (staph on steroids)\n'
    '            - sidesteps the antibiotic resistance issue\n'
    '    - 2.) wound wash — container, hose down the whole area with warm wound wash, multiple times\n'
    '    - 3.) Choose the primary topicals (tinctures)\n'
    '        - chapparral - sometimes standalone\n'
    '        - myrrh, possibly with: oregon grape root\n'
    '    - 4.) if open wound, apply honey gauze\n'
    '    - 5.) if closed wound, apply bentonite clay\n'
    '    - 6.) wrap it up! (Tegaderm, gauze layers, co-band, wound cozy)\n'
    '    - takeaway, maybe 1/2 bottle of chaparral\n'
    '- don''t want to introduce oils into open tissue, so no salves\n'
    '- salves shine with abrasions, though\n'
    '- if both open and closed, prioritize open state';

  sb_wound_actions := E'### Defining Herbal Actions for the Kit\n'
    '- Astringent — toning and tightening tissue; stimulates immune function\n'
    '- Vulnerary — heals wounds\n'
    '- Antimicrobial — not specific to gram positive or negative\n'
    '- 2 herbs could fit all 3 of these categories\n'
    '- Primary Topicals:\n'
    '    - Antimicrobials\n'
    '    - Antioxidants\n'
    '    - Immune Stimulant\n'
    '        - Myrrh\n'
    '        - OGR\n'
    '        - Chaparral';

  sb_wound_wash := E'### Wound Wash\n'
    '- how it helps: stimulating and warming the circulation\n'
    '- choosing herbs\n'
    '    - no comfrey ever — close up a wound and leave the bad underneath\n'
    '    - comfrey incredible for scrapes and abrasions, but not deep wounds\n'
    '    - aloe also a No, heals too fast\n'
    '- preparation of Wound Wash (contains all 3 actions)\n'
    '    - Astringent: Red Root leaf in this case, Yarrow\n'
    '    - Antimicrobial: Tea Tree, all culinary herbs (Rosemary, Thyme, Oregano), Yarrow\n'
    '    - Vulnerary: Yarrow, Plantain, Calendula, Lavender, Chamomile, Self Heal, Chickweed, St John''s Wort\n'
    '- steep 45 minutes to an hour, strain really well, put in thermos\n'
    '- in the field: prepped tea bags, for a compress (first aid kit)';

  sb_chaparral := E'### Chaparral (Creosote Bush, Larrea tridentata)\n'
    '- Leaves and Twigs (less so twigs — leaves have the sticky we want)\n'
    '- Fresh 1:2 80–95%\n'
    '- Dry 1:5 60%\n'
    '- Tacopa (hot springs town) — good harvest site';

  sb_myrrh := E'### Myrrh (Commiphora myrrha)\n'
    '- Elephant tree family\n'
    '- Resin 1:5 70%\n'
    '- effective against both gram positive and negative bacteria\n'
    '- antifungal\n'
    '- stim innate immune function uniquely\n'
    '    - cellulite tissue loses its elasticity, succumbs to fluids\n'
    '    - cover with myrrh to help stimulate immune function in the skin\n'
    '- stimulate leukocytes\n'
    '- mouth ulcers, dental issues, extractions\n'
    '- gingivitis\n'
    '- oleoresin — both water and alcohol soluble components';

  sb_food_sens := E'## An Herbal Approach to Food Sensitivities\n\n'
    'Schisandra — tasting — 5 flavor berry\n'
    '- move blood\n'
    '- liver-supporting\n'
    '- more gentle than others\n\n'
    '- comes up a lot in clinical settings\n'
    '- food a lot emotional, ancestral — must be sensitive\n'
    '- what foods can we add in, as opposed to what we need to remove';

  sb_gut_lining := E'### Heal the gut lining\n'
    '- the gut is a mucus membrane\n'
    '- use demulcents and vulneraries\n'
    '    - plantain, calendula (grind with the plantain), marshmallow EP, powdered,\n'
    '      heaping tablespoon mixed into applesauce\n'
    '        - pectin in applesauce helps the body absorb these things\n'
    '        - do before every meal, 15 mins — can help seal the tight junctions\n'
    '        - particularly before drinking coffee\n'
    '    - aloe can be supportive, esp for heartburn\n'
    '        - aloe juice, electrolytes, and a little lime\n'
    '    - cinnamon stick in cold water overnight — mild demulcent\n'
    '    - licorice root — DGL capsules, doesn''t cause the blood pressure response\n'
    '- easy to digest, protein-rich foods; stewed, cooked foods; warming spices';

  sb_dig_fire := E'### Rekindle the Digestive Fire\n'
    '- warm, well-spiced meals at regular intervals:\n'
    '    - ginger, turmeric, cinnamon, fennel, coriander, cumin, dandelion root,\n'
    '      artichoke leaf, orange peel\n'
    '- Agni — digestive fire that transforms food into energy\n'
    '- bitters before mealtime: dandelion root or leaf, artichoke leaf\n'
    '- carminatives to aid digestion\n'
    '- no water or liquid while eating\n'
    '- can become dependent on external digestive enzymes';

  sb_microbiome := E'### Improve Microbiome Diversity\n'
    '- high inulin containing plants\n'
    '- fresh sources of probiotics:\n'
    '    - fermented veggies, kefir and yogurt, fermented soy\n'
    '    - garlic and onion\n'
    '    - whole grains\n'
    '    - burdock/chicory/dandelion root\n'
    '- get to a consistent place where you are feeding the good stuff\n'
    '- probiotics: make sure diverse, not just milk protein';

  sb_elim_detox := E'### Support elimination and detox\n'
    '- hepatics:\n'
    '    - schisandra, milk thistle, nettle, red clover, cleavers, yellow dock\n'
    '- lymphatics; bitters; gentle laxatives\n'
    '- supplement with Magnesium citrate for constipation (before bed),\n'
    '  fiber and adequate hydration\n'
    '- psyllium husk, only if you drink a lot of water with it';

  sb_nervous := E'### Regulate the Nervous System\n'
    '- Nervines (a lot of bitter plants):\n'
    '    - Chamomile, Lemon Balm, Catnip, Passionflower, Skullcap, Blue Vervain\n'
    '- Adaptogens:\n'
    '    - Andrographis\n'
    '    - Tulsi (also a carminative)\n'
    '    - Shatavari (moistening)\n'
    '- (Both specific to constitution)';

  sb_tincture_blend := E'## Activity: Digestive Tincture Blend\n'
    '1.) Goals: intention, herbal actions, energetics\n'
    '2.) Herbs (3 herbs max)\n\n'
    'Herbs with energetics:\n'
    '- Licorice — moistening, relaxing\n'
    '- Plantain — cooling, moistening, relaxing\n'
    '- Milk Thistle — cooling, moistening\n'
    '- Shatavari — cooling, moistening, relaxing\n'
    '- Cinnamon — warming, drying, toning\n'
    '- Fennel — warming, drying, relaxing\n'
    '- Ginger — warming, drying, relaxing\n'
    '- Chamomile — warming, drying, relaxing; nervine\n'
    '- Orange Peel — warming, drying, relaxing\n'
    '- Artichoke — cooling, drying\n'
    '- Dandelion — cooling, drying\n'
    '- Gentian — cooling, drying\n'
    '- Burdock — cooling, drying\n'
    '- Lemon Balm — cooling, drying, relaxing; nervine\n'
    '- Yellow Dock — cooling, drying\n'
    '- Catnip — cooling, drying, relaxing; nervine\n\n'
    'Student formula (Lisa Christine): chamomile, artichoke, licorice';

  -- ── Herb snippets ──────────────────────────────────────────────────────────

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- Wound Care
  (302,
   'Protocol step 1 wet wipes: solution of distilled water, add tea tree and lavender — covers gram negative bacteria (tea tree: E. coli) and gram positive (lavender: staph and MRSA, sidesteps antibiotic resistance).',
   v_class, 'personal', 'Wound Care', 10, sb_wound_care),

  (82,
   'Protocol step 1 wet wipes: solution of distilled water, add tea tree and lavender — covers gram positive bacteria (lavender: staph and MRSA) and gram negative (tea tree: E. coli). Sidesteps antibiotic resistance issue.',
   v_class, 'personal', 'Wound Care', 20, sb_wound_care),

  (99,
   'Protocol step 3 primary topicals (tinctures): myrrh, possibly with oregon grape root.',
   v_class, 'personal', 'Wound Care', 30, sb_wound_care),

  (33,
   'Protocol step 3 primary topicals (tinctures): myrrh, possibly with oregon grape root.',
   v_class, 'personal', 'Wound Care', 40, sb_wound_care),

  (32,
   'Protocol step 3 primary topicals: chaparral — sometimes standalone. Takeaway, maybe 1/2 bottle of chaparral.',
   v_class, 'personal', 'Wound Care', 50, sb_wound_care),

  -- Wound Care Actions
  (99,
   'Primary Topicals for wound kit — Antimicrobials, Antioxidants, Immune Stimulant: Myrrh, OGR (Oregon Grape Root), Chaparral.',
   v_class, 'personal', 'Wound Care Actions', 60, sb_wound_actions),

  (33,
   'Primary Topicals for wound kit — Antimicrobials, Antioxidants, Immune Stimulant: Myrrh, OGR (Oregon Grape Root), Chaparral.',
   v_class, 'personal', 'Wound Care Actions', 70, sb_wound_actions),

  (32,
   'Primary Topicals for wound kit — Antimicrobials, Antioxidants, Immune Stimulant: Myrrh, OGR (Oregon Grape Root), Chaparral.',
   v_class, 'personal', 'Wound Care Actions', 80, sb_wound_actions),

  -- Wound Wash
  (89,
   'No comfrey ever for deep wounds — closes up the wound and leaves the bad underneath. Comfrey incredible for scrapes and abrasions, but not deep wounds.',
   v_class, 'personal', 'Wound Wash', 90, sb_wound_wash),

  (202,
   'Aloe is a No for wound wash — heals too fast (for deep wounds). Also avoid introducing oils into open tissue (no salves); salves do shine with abrasions.',
   v_class, 'personal', 'Wound Wash', 100, sb_wound_wash),

  (981,
   'Wound wash astringent herbs: Red Root leaf, Yarrow. Astringent = toning and tightening tissue, stimulates immune function.',
   v_class, 'personal', 'Wound Wash', 110, sb_wound_wash),

  (44,
   'Yarrow serves all three wound wash roles — Astringent (with Red Root leaf), Antimicrobial (with Tea Tree, Rosemary, Thyme, Oregano), and Vulnerary (with Plantain, Calendula, Lavender, Chamomile, Self Heal, Chickweed, SJW).',
   v_class, 'personal', 'Wound Wash', 120, sb_wound_wash),

  (302,
   'Wound wash antimicrobial herbs: Tea Tree, all culinary herbs (Rosemary, Thyme, Oregano), Yarrow. "Tea Tree trees — whole street in Berkeley."',
   v_class, 'personal', 'Wound Wash', 130, sb_wound_wash),

  (109,
   'Wound wash antimicrobial herbs: culinary herbs Rosemary, Thyme, Oregano; also Tea Tree and Yarrow.',
   v_class, 'personal', 'Wound Wash', 140, sb_wound_wash),

  (59,
   'Wound wash antimicrobial herbs: culinary herbs Rosemary, Thyme, Oregano; also Tea Tree and Yarrow.',
   v_class, 'personal', 'Wound Wash', 150, sb_wound_wash),

  (406,
   'Wound wash antimicrobial herbs: culinary herbs Rosemary, Thyme, Oregano; also Tea Tree and Yarrow.',
   v_class, 'personal', 'Wound Wash', 160, sb_wound_wash),

  (85,
   'Wound wash vulnerary herbs: Yarrow, Plantain, Calendula, Lavender, Chamomile, Self Heal, Chickweed, St John''s Wort. Steep 45 minutes to an hour, strain well, put in thermos.',
   v_class, 'personal', 'Wound Wash', 170, sb_wound_wash),

  (70,
   'Wound wash vulnerary herbs: Yarrow, Plantain, Calendula, Lavender, Chamomile, Self Heal, Chickweed, St John''s Wort. Steep 45 minutes to an hour, strain well, put in thermos.',
   v_class, 'personal', 'Wound Wash', 180, sb_wound_wash),

  (82,
   'Wound wash vulnerary herbs: Yarrow, Plantain, Calendula, Lavender, Chamomile, Self Heal, Chickweed, St John''s Wort.',
   v_class, 'personal', 'Wound Wash', 190, sb_wound_wash),

  (84,
   'Wound wash vulnerary herbs: Yarrow, Plantain, Calendula, Lavender, Chamomile, Self Heal, Chickweed, St John''s Wort.',
   v_class, 'personal', 'Wound Wash', 200, sb_wound_wash),

  (2437,
   'Wound wash vulnerary herbs: Yarrow, Plantain, Calendula, Lavender, Chamomile, Self Heal, Chickweed, St John''s Wort.',
   v_class, 'personal', 'Wound Wash', 210, sb_wound_wash),

  (88,
   'Wound wash vulnerary herbs: Yarrow, Plantain, Calendula, Lavender, Chamomile, Self Heal, Chickweed, St John''s Wort.',
   v_class, 'personal', 'Wound Wash', 220, sb_wound_wash),

  (81,
   'Wound wash vulnerary herbs: Yarrow, Plantain, Calendula, Lavender, Chamomile, Self Heal, Chickweed, St John''s Wort.',
   v_class, 'personal', 'Wound Wash', 230, sb_wound_wash),

  -- Chaparral profile
  (32,
   'Chaparral (Larrea tridentata, Creosote Bush): Leaves and Twigs (leaves have the sticky). Fresh 1:2 80–95%. Dry 1:5 60%.',
   v_class, 'personal', 'Chaparral', 240, sb_chaparral),

  -- Myrrh profile
  (99,
   'Myrrh (Commiphora myrrha): Resin 1:5 70%. Effective against gram positive and negative bacteria. Antifungal. Stimulates innate immune function uniquely; stimulates leukocytes. Indications: mouth ulcers, dental issues, extractions, gingivitis. Oleoresin — both water and alcohol soluble.',
   v_class, 'personal', 'Myrrh', 250, sb_myrrh),

  -- Food Sensitivities intro
  (17,
   'Schisandra — 5 flavor berry: moves blood, liver-supporting, more gentle than other liver herbs. Comes up frequently in food sensitivity clinical settings.',
   v_class, 'personal', 'Food Sensitivities', 260, sb_food_sens),

  -- Heal the Gut Lining
  (85,
   'Demulcents and vulneraries for gut lining repair: plantain, calendula (grind together), marshmallow EP powdered into applesauce before every meal. Pectin in applesauce aids absorption; helps seal the tight junctions; especially protective before coffee.',
   v_class, 'personal', 'Heal the Gut Lining', 270, sb_gut_lining),

  (70,
   'Demulcents and vulneraries for gut lining: plantain, calendula (grind with plantain), marshmallow EP into applesauce before meals — helps seal the tight junctions.',
   v_class, 'personal', 'Heal the Gut Lining', 280, sb_gut_lining),

  (45,
   'Marshmallow EP (powdered, heaping tablespoon into applesauce) before every meal — helps seal the tight junctions in the gut lining. Particularly before drinking coffee.',
   v_class, 'personal', 'Heal the Gut Lining', 290, sb_gut_lining),

  (202,
   'Aloe can be supportive for gut lining, especially for heartburn — aloe juice, electrolytes, and a little lime.',
   v_class, 'personal', 'Heal the Gut Lining', 300, sb_gut_lining),

  (167,
   'Cinnamon stick in cold water overnight — mild demulcent for gut lining.',
   v_class, 'personal', 'Heal the Gut Lining', 310, sb_gut_lining),

  (78,
   'Licorice root for gut lining repair — DGL capsules, doesn''t cause the blood pressure response.',
   v_class, 'personal', 'Heal the Gut Lining', 320, sb_gut_lining),

  -- Digestive Fire
  (124,
   'Warm, well-spiced meals to rekindle digestive fire: ginger, turmeric, cinnamon, fennel, coriander, cumin, dandelion root, artichoke leaf, orange peel. Agni — digestive fire transforms food into energy.',
   v_class, 'personal', 'Digestive Fire', 330, sb_dig_fire),

  (203,
   'Warm, well-spiced meals to rekindle digestive fire: ginger, turmeric, cinnamon, fennel, coriander, cumin, dandelion root, artichoke leaf, orange peel.',
   v_class, 'personal', 'Digestive Fire', 340, sb_dig_fire),

  (167,
   'Warming digestive herbs for rekindling digestive fire: ginger, turmeric, cinnamon, fennel, coriander, cumin, dandelion root, artichoke leaf, orange peel.',
   v_class, 'personal', 'Digestive Fire', 350, sb_dig_fire),

  (76,
   'Warming digestive herbs for rekindling digestive fire: ginger, turmeric, cinnamon, fennel, coriander, cumin, dandelion root, artichoke leaf, orange peel.',
   v_class, 'personal', 'Digestive Fire', 360, sb_dig_fire),

  (100,
   'Warming digestive herbs for rekindling digestive fire: ginger, turmeric, cinnamon, fennel, coriander, cumin, dandelion root, artichoke leaf, orange peel.',
   v_class, 'personal', 'Digestive Fire', 370, sb_dig_fire),

  (122,
   'Dandelion root listed among warming digestive bitters for rekindling digestive fire. Also noted specifically: "bitters before mealtime: dandelion root or leaf, artichoke leaf."',
   v_class, 'personal', 'Digestive Fire', 380, sb_dig_fire),

  (172,
   'Artichoke leaf listed among warming digestive herbs for rekindling digestive fire. Also noted specifically: "bitters before mealtime: dandelion root or leaf, artichoke leaf."',
   v_class, 'personal', 'Digestive Fire', 390, sb_dig_fire),

  (748,
   'Orange peel listed among warming digestive herbs for rekindling digestive fire: ginger, turmeric, cinnamon, fennel, coriander, cumin, dandelion root, artichoke leaf, orange peel.',
   v_class, 'personal', 'Digestive Fire', 400, sb_dig_fire),

  -- Microbiome Support
  (22,
   'Prebiotic inulin plants for microbiome diversity: burdock/chicory/dandelion root. High inulin content feeds beneficial gut flora.',
   v_class, 'personal', 'Microbiome Support', 420, sb_microbiome),

  (122,
   'Prebiotic inulin plants for microbiome diversity: burdock/chicory/dandelion root.',
   v_class, 'personal', 'Microbiome Support', 430, sb_microbiome),

  -- Elimination and Detox
  (17,
   'Hepatics for elimination and detox support: schisandra, milk thistle, nettle, red clover, cleavers, yellow dock.',
   v_class, 'personal', 'Elimination and Detox', 440, sb_elim_detox),

  (206,
   'Hepatics for elimination and detox support: schisandra, milk thistle, nettle, red clover, cleavers, yellow dock.',
   v_class, 'personal', 'Elimination and Detox', 450, sb_elim_detox),

  (43,
   'Hepatics for elimination and detox support: schisandra, milk thistle, nettle, red clover, cleavers, yellow dock.',
   v_class, 'personal', 'Elimination and Detox', 460, sb_elim_detox),

  (42,
   'Hepatics for elimination and detox support: schisandra, milk thistle, nettle, red clover, cleavers, yellow dock.',
   v_class, 'personal', 'Elimination and Detox', 470, sb_elim_detox),

  (28,
   'Hepatics and lymphatics for elimination and detox: cleavers listed among hepatics (schisandra, milk thistle, nettle, red clover, cleavers, yellow dock).',
   v_class, 'personal', 'Elimination and Detox', 480, sb_elim_detox),

  (37,
   'Hepatics for elimination and detox: yellow dock listed with schisandra, milk thistle, nettle, red clover, cleavers. Also: gentle laxative support.',
   v_class, 'personal', 'Elimination and Detox', 490, sb_elim_detox),

  (2240,
   'Psyllium husk for constipation and elimination support — only if drinking a lot of water with it.',
   v_class, 'personal', 'Elimination and Detox', 510, sb_elim_detox),

  -- Nervous System Support
  (84,
   'Nervines for nervous system support in food sensitivity context (a lot of bitter plants): Chamomile, Lemon Balm, Catnip, Passionflower, Skullcap, Blue Vervain. Adaptogens: Andrographis, Tulsi (also a carminative), Shatavari (moistening). Both specific to constitution.',
   v_class, 'personal', 'Nervous System Support', 520, sb_nervous),

  (134,
   'Nervines for nervous system support: Chamomile, Lemon Balm, Catnip, Passionflower, Skullcap, Blue Vervain. (Many are bitter plants.) Adaptogens: Andrographis, Tulsi (also a carminative), Shatavari (moistening).',
   v_class, 'personal', 'Nervous System Support', 530, sb_nervous),

  (136,
   'Nervines for nervous system support: Chamomile, Lemon Balm, Catnip, Passionflower, Skullcap, Blue Vervain. Both nervines and adaptogens specific to constitution.',
   v_class, 'personal', 'Nervous System Support', 540, sb_nervous),

  (137,
   'Nervines for nervous system support: Chamomile, Lemon Balm, Catnip, Passionflower, Skullcap, Blue Vervain.',
   v_class, 'personal', 'Nervous System Support', 550, sb_nervous),

  (142,
   'Nervines for nervous system support: Chamomile, Lemon Balm, Catnip, Passionflower, Skullcap, Blue Vervain.',
   v_class, 'personal', 'Nervous System Support', 560, sb_nervous),

  (983,
   'Nervines for nervous system support: Chamomile, Lemon Balm, Catnip, Passionflower, Skullcap, Blue Vervain.',
   v_class, 'personal', 'Nervous System Support', 570, sb_nervous),

  (13,
   'Holy Basil (Tulsi) listed as an adaptogen for nervous system support in food sensitivity context. Also noted as a carminative. Specific to constitution.',
   v_class, 'personal', 'Nervous System Support', 590, sb_nervous),

  (852,
   'Shatavari listed as an adaptogen for nervous system support in food sensitivity context — noted as moistening. Specific to constitution.',
   v_class, 'personal', 'Nervous System Support', 600, sb_nervous),

  -- Digestive Tincture Blend (energetics from activity)
  (78,
   'Digestive tincture blend activity: Licorice — moistening, relaxing.',
   v_class, 'personal', 'Digestive Tincture Blend', 610, sb_tincture_blend),

  (85,
   'Digestive tincture blend activity: Plantain — cooling, moistening, relaxing.',
   v_class, 'personal', 'Digestive Tincture Blend', 620, sb_tincture_blend),

  (206,
   'Digestive tincture blend activity: Milk Thistle — cooling, moistening.',
   v_class, 'personal', 'Digestive Tincture Blend', 630, sb_tincture_blend),

  (852,
   'Digestive tincture blend activity: Shatavari — cooling, moistening, relaxing.',
   v_class, 'personal', 'Digestive Tincture Blend', 640, sb_tincture_blend),

  (167,
   'Digestive tincture blend activity: Cinnamon — warming, drying, toning.',
   v_class, 'personal', 'Digestive Tincture Blend', 650, sb_tincture_blend),

  (76,
   'Digestive tincture blend activity: Fennel — warming, drying, relaxing.',
   v_class, 'personal', 'Digestive Tincture Blend', 660, sb_tincture_blend),

  (124,
   'Digestive tincture blend activity: Ginger — warming, drying, relaxing.',
   v_class, 'personal', 'Digestive Tincture Blend', 670, sb_tincture_blend),

  (84,
   'Digestive tincture blend activity: Chamomile — warming, drying, relaxing; nervine.',
   v_class, 'personal', 'Digestive Tincture Blend', 680, sb_tincture_blend),

  (748,
   'Digestive tincture blend activity: Orange Peel — warming, drying, relaxing.',
   v_class, 'personal', 'Digestive Tincture Blend', 690, sb_tincture_blend),

  (172,
   'Digestive tincture blend activity: Artichoke — cooling, drying.',
   v_class, 'personal', 'Digestive Tincture Blend', 700, sb_tincture_blend),

  (1648,
   'Digestive tincture blend activity: Dandelion (leaf) — cooling, drying.',
   v_class, 'personal', 'Digestive Tincture Blend', 710, sb_tincture_blend),

  (102,
   'Digestive tincture blend activity: Gentian — cooling, drying.',
   v_class, 'personal', 'Digestive Tincture Blend', 720, sb_tincture_blend),

  (22,
   'Digestive tincture blend activity: Burdock — cooling, drying.',
   v_class, 'personal', 'Digestive Tincture Blend', 730, sb_tincture_blend),

  (134,
   'Digestive tincture blend activity: Lemon Balm — cooling, drying, relaxing; nervine.',
   v_class, 'personal', 'Digestive Tincture Blend', 740, sb_tincture_blend),

  (37,
   'Digestive tincture blend activity: Yellow Dock — cooling, drying.',
   v_class, 'personal', 'Digestive Tincture Blend', 750, sb_tincture_blend),

  (136,
   'Digestive tincture blend activity: Catnip — cooling, drying, relaxing; nervine.',
   v_class, 'personal', 'Digestive Tincture Blend', 760, sb_tincture_blend);

  -- ── Supplement snippets ────────────────────────────────────────────────────

  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
  (38,
   'Fresh sources of probiotics and prebiotic inulin for microbiome diversity: garlic and onion, burdock/chicory/dandelion root, fermented veggies, kefir, fermented soy, whole grains.',
   v_class, 'personal', 'Microbiome Support', 410, sb_microbiome),

  (21,
   'Supplement with Magnesium citrate for constipation, before bed — with fiber and adequate hydration. "Magnesium Breakthrough" recommended brand.',
   v_class, 'personal', 'Elimination and Detox', 500, sb_elim_detox);

  -- ── Andrographis snippet (dynamic herb_id) ─────────────────────────────────

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
  (v_and_id,
   'Andrographis listed as an adaptogen for nervous system support in food sensitivity context. Nervines and adaptogens both noted as specific to constitution.',
   v_class, 'personal', 'Nervous System Support', 580, sb_nervous);

  RAISE NOTICE 'Class 33 snippets loaded (77 total).';
END $$;

-- ── Herb keywords ────────────────────────────────────────────────────────────

INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  -- Tea Tree
  (302, 'wound healing',    'ailment'),
  (302, 'antimicrobial',    'action'),
  (302, 'skin infection',   'ailment'),

  -- Lavender
  (82,  'wound healing',    'ailment'),
  (82,  'antimicrobial',    'action'),
  (82,  'vulnerary',        'action'),
  (82,  'skin infection',   'ailment'),

  -- Myrrh
  (99,  'wound healing',    'ailment'),
  (99,  'antimicrobial',    'action'),
  (99,  'immune support',   'ailment'),
  (99,  'gingivitis',       'ailment'),
  (99,  'mouth ulcers',     'ailment'),
  (99,  'abscess',          'ailment'),

  -- Oregon Grape
  (33,  'wound healing',    'ailment'),
  (33,  'antimicrobial',    'action'),
  (33,  'skin infection',   'ailment'),

  -- Chaparral
  (32,  'wound healing',    'ailment'),
  (32,  'antimicrobial',    'action'),
  (32,  'skin infection',   'ailment'),
  (32,  'abscess',          'ailment'),
  (32,  'skin conditions',  'ailment'),

  -- Comfrey root
  (89,  'wound healing',    'ailment'),
  (89,  'vulnerary',        'action'),

  -- Aloe
  (202, 'vulnerary',        'action'),
  (202, 'wound healing',    'ailment'),
  (202, 'gut inflammation', 'ailment'),

  -- Red Root
  (981, 'wound healing',    'ailment'),
  (981, 'astringent',       'action'),

  -- Yarrow
  (44,  'wound healing',    'ailment'),
  (44,  'astringent',       'action'),
  (44,  'antimicrobial',    'action'),
  (44,  'vulnerary',        'action'),
  (44,  'burns',            'ailment'),

  -- Rosemary
  (109, 'antimicrobial',    'action'),
  (109, 'wound healing',    'ailment'),

  -- Thyme
  (59,  'antimicrobial',    'action'),
  (59,  'wound healing',    'ailment'),

  -- Oregano
  (406, 'antimicrobial',    'action'),
  (406, 'wound healing',    'ailment'),

  -- Plantain
  (85,  'vulnerary',        'action'),
  (85,  'wound healing',    'ailment'),
  (85,  'leaky gut',        'ailment'),
  (85,  'gut inflammation', 'ailment'),
  (85,  'food sensitivities','ailment'),

  -- Calendula
  (70,  'vulnerary',        'action'),
  (70,  'wound healing',    'ailment'),
  (70,  'gut inflammation', 'ailment'),
  (70,  'food sensitivities','ailment'),

  -- Chamomile
  (84,  'vulnerary',        'action'),
  (84,  'wound healing',    'ailment'),
  (84,  'stress',           'ailment'),
  (84,  'anxiety',          'ailment'),
  (84,  'nervine',          'action'),
  (84,  'food sensitivities','ailment'),

  -- Self Heal
  (2437,'vulnerary',        'action'),
  (2437,'wound healing',    'ailment'),

  -- Chickweed
  (88,  'vulnerary',        'action'),
  (88,  'wound healing',    'ailment'),

  -- St. John's Wort
  (81,  'vulnerary',        'action'),
  (81,  'wound healing',    'ailment'),

  -- Schizandra
  (17,  'food sensitivities','ailment'),
  (17,  'liver support',    'ailment'),
  (17,  'leaky gut',        'ailment'),
  (17,  'alterative',       'action'),

  -- Marshmallow
  (45,  'leaky gut',        'ailment'),
  (45,  'gut inflammation', 'ailment'),
  (45,  'food sensitivities','ailment'),
  (45,  'demulcent',        'action'),

  -- Cinnamon
  (167, 'digestive tonic',  'ailment'),
  (167, 'gut inflammation', 'ailment'),
  (167, 'carminative',      'action'),

  -- Licorice
  (78,  'leaky gut',        'ailment'),
  (78,  'gut inflammation', 'ailment'),
  (78,  'demulcent',        'action'),
  (78,  'food sensitivities','ailment'),

  -- Ginger
  (124, 'digestive tonic',  'ailment'),
  (124, 'carminative',      'action'),
  (124, 'food sensitivities','ailment'),

  -- Turmeric
  (203, 'digestive tonic',  'ailment'),
  (203, 'anti-inflammatory','action'),

  -- Fennel
  (76,  'digestive tonic',  'ailment'),
  (76,  'carminative',      'action'),

  -- Coriander
  (100, 'digestive tonic',  'ailment'),
  (100, 'carminative',      'action'),

  -- Dandelion root
  (122, 'digestive tonic',  'ailment'),
  (122, 'digestive bitter', 'action'),
  (122, 'liver support',    'ailment'),
  (122, 'microbiome support','ailment'),

  -- Artichoke
  (172, 'digestive tonic',  'ailment'),
  (172, 'digestive bitter', 'action'),
  (172, 'liver support',    'ailment'),

  -- Sweet Orange (orange peel)
  (748, 'digestive tonic',  'ailment'),
  (748, 'carminative',      'action'),

  -- Burdock
  (22,  'microbiome support','ailment'),
  (22,  'digestive tonic',  'ailment'),
  (22,  'liver support',    'ailment'),

  -- Milk Thistle
  (206, 'liver support',    'ailment'),
  (206, 'hepatoprotective', 'action'),
  (206, 'leaky gut',        'ailment'),
  (206, 'food sensitivities','ailment'),

  -- Nettle (leaf)
  (43,  'liver support',    'ailment'),
  (43,  'nutritive',        'action'),

  -- Red Clover
  (42,  'liver support',    'ailment'),
  (42,  'alterative',       'action'),

  -- Cleavers
  (28,  'lymphatic support','ailment'),
  (28,  'alterative',       'action'),

  -- Yellow Dock
  (37,  'constipation',     'ailment'),
  (37,  'liver support',    'ailment'),
  (37,  'alterative',       'action'),
  (37,  'digestive bitter', 'action'),

  -- Psyllium
  (2240,'constipation',     'ailment'),
  (2240,'IBS',              'ailment'),

  -- Lemon Balm
  (134, 'stress',           'ailment'),
  (134, 'anxiety',          'ailment'),
  (134, 'nervine',          'action'),
  (134, 'carminative',      'action'),
  (134, 'food sensitivities','ailment'),

  -- Catnip
  (136, 'stress',           'ailment'),
  (136, 'anxiety',          'ailment'),
  (136, 'nervine',          'action'),

  -- Passionflower
  (137, 'stress',           'ailment'),
  (137, 'anxiety',          'ailment'),
  (137, 'nervine',          'action'),
  (137, 'sleep support',    'ailment'),

  -- Skullcap
  (142, 'stress',           'ailment'),
  (142, 'anxiety',          'ailment'),
  (142, 'nervine',          'action'),

  -- Blue Vervain
  (983, 'stress',           'ailment'),
  (983, 'anxiety',          'ailment'),
  (983, 'nervine',          'action'),

  -- Holy Basil (Tulsi)
  (13,  'stress',           'ailment'),
  (13,  'anxiety',          'ailment'),
  (13,  'adaptogen',        'action'),
  (13,  'carminative',      'action'),
  (13,  'food sensitivities','ailment'),

  -- Shatavari
  (852, 'stress',           'ailment'),
  (852, 'adaptogen',        'action'),
  (852, 'food sensitivities','ailment'),

  -- Gentian
  (102, 'digestive tonic',  'ailment'),
  (102, 'digestive bitter', 'action'),
  (102, 'bitter tonic',     'action'),

  -- Dandelion leaf
  (1648,'digestive tonic',  'ailment'),
  (1648,'digestive bitter', 'action')

ON CONFLICT (herb_id, keyword) DO NOTHING;

-- ── Supplement keywords ───────────────────────────────────────────────────────

INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
  (38,  'microbiome support','ailment'),
  (38,  'food sensitivities','ailment'),
  (21,  'constipation',     'ailment')
ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;

-- ── Andrographis keywords (dynamic id) ────────────────────────────────────────

DO $$
DECLARE
  v_and_id INTEGER;
BEGIN
  v_and_id := herbal.ensure_herb('Andrographis paniculata', 'Andrographis');
  INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
    (v_and_id, 'food sensitivities',    'ailment'),
    (v_and_id, 'adaptogen',             'action'),
    (v_and_id, 'nervous system support','action')
  ON CONFLICT (herb_id, keyword) DO NOTHING;
END $$;

-- ── Ailment search terms (new keywords introduced by this class) ───────────────

INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('food sensitivities',
   ARRAY['food intolerance', 'food allergy', 'food reactivity', 'dietary sensitivity',
         'gluten sensitivity', 'dietary intolerance']),
  ('abscess',
   ARRAY['boil', 'skin abscess', 'pustule', 'festering wound', 'infected abscess']),
  ('gingivitis',
   ARRAY['gum disease', 'gum inflammation', 'periodontal disease', 'gum infection',
         'bleeding gums']),
  ('mouth ulcers',
   ARRAY['canker sores', 'oral ulcers', 'aphthous ulcers', 'mouth sores',
         'aphthous stomatitis']),
  ('microbiome support',
   ARRAY['gut flora', 'gut bacteria', 'intestinal flora', 'dysbiosis',
         'probiotic support', 'prebiotic support']),
  ('skin infection',
   ARRAY['infected wound', 'bacterial skin infection', 'wound infection', 'cellulitis',
         'skin bacteria'])
ON CONFLICT (ailment_keyword) DO NOTHING;
