-- Migration 308: Class 38 — AMAB Repro II Diseases and Perfumes (snippets, keywords, ailment terms)
--
-- Files parsed:
--   BHC - Class 38 - AMAB Repro II Diseases and Perfumes - Ashley and Lakenda.md (personal)
--   Transcript: IGNORED per playbook
--
-- Normalisations:
--   Fo Ti            → Polygonum multiflorum (added in migration 307)
--   Goji berry       → Wolfberry Fruit (Fructus Lycii Chinensis, id 1548)
--   Tribulus         → Caltrop Fruit / Puncturevine (Fructus Tribuli Terrestris, id 1507)
--   Collinsonia      → Stoneroot (Collinsonia canadensis, id 182)
--   Red ginseng      → Ginseng (Panax ginseng, id 14)
--   Schisandra       → Schizandra (Schisandra chinensis, id 17)
--   berberine - OGR  → Oregon Grape (Mahonia aquifolium, id 33)
--   Hawthorn         → Hawthorn berry (Crataegus spp., id 73)
--   Nettle root      → Nettle root (Urtica dioica, id 1649)
--
-- Skipped (not in DB):
--   Pine Pollen — no DB entry
--   Epimedium / Horny Goat Weed — no DB entry
--   White Sage (Salvia apiana) — no DB entry
--   Lavender Cotton (Santolina chamaecyparissus) — no DB entry
--   Wisteria — poisonous ornamental, no DB entry
--   Orange peel — no clear DB match (Neroli = flower, not peel)
--
-- Merge decisions (ailment keywords):
--   "infertility" → merged into existing 'fertility support'
--   "androgen modulation" → merged into existing 'hormonal support'
--   "wrinkles" → merged into existing 'skin conditions'
--   "poor circulation" → merged into existing 'circulation'
--
-- New ailment keywords introduced: sperm motility, hair loss, prostate health,
--   burns, osteoarthritis, photosensitivity
-- New action keywords: aphrodisiac, anti-aging, insect repellent

SET search_path TO herbal, public;

-- ── Snippets ────────────────────────────────────────────────────────────────
DO $$
DECLARE
  v_fo_ti_id INTEGER;
  c_class    CONSTANT TEXT := 'BHC - Class 38 - AMAB Repro II Diseases and Perfumes';
  sb_herbal_actions         TEXT;
  sb_low_testosterone       TEXT;
  sb_infertility            TEXT;
  sb_bph                    TEXT;
  sb_erectile_dysfunction   TEXT;
  sb_unexpected_plants      TEXT;
  sb_plants_in_perfumery    TEXT;
  sb_scent_effects          TEXT;
  sb_hazardous_eos          TEXT;
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets WHERE class_name = 'BHC - Class 38 - AMAB Repro II Diseases and Perfumes') THEN
    RAISE NOTICE 'Class 38 snippets already loaded, skipping';
    RETURN;
  END IF;

  SELECT id INTO v_fo_ti_id FROM herbal.herbs WHERE latin_name = 'Polygonum multiflorum';
  IF v_fo_ti_id IS NULL THEN
    RAISE EXCEPTION 'Fo Ti not in DB — run migration 307 first';
  END IF;

  -- Source blocks (verbatim section text)
  sb_herbal_actions := E'- Circulatory Stimulants - blood flow improvement\n'
    '- Adaptogens - help rewrite the story\n'
    '    - a lot of adaptogens are also repro tonics\n'
    '        - ginsengs\n'
    '        - Fo Ti\n'
    '- Demulcents\n'
    '- Antiseptics if infections\n'
    '- Astringents\n'
    '    - if dribbling or holding urine\n'
    '- Nervines\n'
    '    - for the pleasure center part';

  sb_low_testosterone := E'- naturally declines with age\n'
    '- stress and sleep affect the level\n'
    '\n'
    '- herbs:\n'
    '    - Pine Pollen\n'
    '        - have to take a lot, like 15 capsules\n'
    '    - Sarsaparilla\n'
    '        - like to combine with Saw Palmetto\n'
    '    - Nettle root\n'
    '        - prostate health, helps modulate androgens (diff types of test.)\n'
    '        - can use the leaf as a nutritive at the same time\n'
    '        - seed too\n'
    '    - Tribulus \n'
    '        - traditional\n'
    '        - have to work with consistently to see the results\n'
    '        - support infertility - motility and sperm count\n'
    '    - Saw Palmetto\n'
    '        - anytime anyone has excess androgens\n'
    '            - certain balding patterns, etc';

  sb_infertility := E'- usually due to something with the sperm\n'
    '- sensitive to heat changes, etc\n'
    '- herbs:\n'
    '    - Schisandra - great as an adaptogen\n'
    '        - reduce stress, linked to infertility\n'
    '    - Goji berry\n'
    '        - support for Jing/life essence\n'
    '    - Ashwagandha\n'
    '        - increase the motility of sperm and reduce stress hormones\n'
    '    - circ herbs\n'
    '        - Hawthorn\n'
    '        - Ginkgo\n'
    '        - Ginger\n'
    '        - Collinsonia';

  sb_bph := E'- prostate swelling\n'
    '- noncancerous, but can mimic prostate cancer\n'
    '- influenced by DHT \n'
    '- can feel it by exam\n'
    '- freq night urination\n'
    '- herbs:\n'
    '    - Nettle root - tonic\n'
    '    - White sage\n'
    '    - Saw Palmetto - tonic\n'
    '    - EP in a classic combo from David Winston\n'
    '\n'
    '### Refer out if\n'
    '- Blood in urine\n'
    '- Acute urinary retention\n'
    '- Severe pelvic pain\n'
    '- Unexplained weight loss\n'
    '\n'
    '- Gaia herbs - Saw Palmetto - preventative 2 caps per day\n'
    '- Nettle root - 1-3 ml - 3x per day\n'
    '- min 6 months for preventative use';

  sb_erectile_dysfunction := E'- often first signs of Diabetes, Cardio disease\n'
    '- medications like SSRI can cause\n'
    '- anxiety meds like benzodiazapene\n'
    '- if able to in morning but not later, might be a NS thing in the moment\n'
    '\n'
    '- medications?\n'
    '    - use cardio tonics to support\n'
    '    - careful with CV disease\n'
    '- herbs:\n'
    '    - CV tonics\n'
    '        - hawthorn\n'
    '        - ginkgo\n'
    '            - tea has 0 benefit\n'
    '            - only alcohol based remedy\n'
    '        - red ginseng\n'
    '    - nervines\n'
    '    - aphrodisiac herbs\n'
    '        - damiana\n'
    '        - maca\n'
    '        - rose\n'
    '        - epimedium - horny goat weed\n'
    '    - hormone balancers\n'
    '        - inc testosterone - tribulus and pine pollen classic combo\n'
    '        - saw palmetto\n'
    '        - nettle root\n'
    '\n'
    '- alkaloidal plant -> 5-10% vinegar when tincturing\n'
    '    - passionflower\n'
    '    - motherwort\n'
    '    - valerian root\n'
    '    - california poppy\n'
    '    - lobelia\n'
    '    - berberine - OGR\n'
    '\n'
    '- glycerine 1:8 with a fluffy herb \n'
    '- 60% glycerine 40% water\n'
    '- 30 mins heated, then at room temp for a week\n'
    '- heat again before you strain\n'
    '\n'
    'All purpose bitter (EP)\n'
    'dandelion \n'
    'orange peel\n'
    'angelica\n'
    'artichoke\n'
    'plus fennel for bloating\n'
    '\n'
    '### Testosterone responsible for\n'
    '- muscle growth\n'
    '- dictate changes in growth in the body';

  sb_unexpected_plants := E'- Catnip - safe for animals and natural insect repellent (part of the mint family)\n'
    '- Wormwood - apply directly to the skin for osteoarthritis and pain management. ?? slides\n'
    '- Calendula - skin beneficial, deeply conditioning, moisturizing, reduces wrinkles\n'
    '- Coffee - anti-aging, tightens skin, brings blood to the skin, AI (both green and roasted coffee - green may help more with collagen production)\n'
    '    - Ethiopian coffee with jasmine\n'
    '- Lavender Cotton - reduces inflammation, kills bacteria, may be helpful topically for PMS';

  sb_plants_in_perfumery := E'- when searching:\n'
    '    - name of plant\n'
    '    - skin benefits\n'
    '    - safety\n'
    '- Daphne''s are poisonous, shouldn''t even be smelling\n'
    '- Basil\n'
    '    - ?? slides\n'
    '    - higher concentration of Estragole - linked to liver cancer and blood clotting\n'
    '    - Basil hydrosol known as a skin tonic and insect repellent\n'
    '- Wisteria\n'
    '    - smells delicious, but poison to humans and animals. Entire plant contains toxic chemicals, lectin and wisterin\n'
    '- Lily of the Valley\n'
    '    - Cardiac medicinal, like Foxglove. To use in perfumery is to risk stopping someone''s heart\n'
    '- indole = the smell of decay - synthetics have to add it to be realistic';

  sb_scent_effects := E'- limbic system\n'
    '- amygdala and hippocampus, regions assoc with emotion and memory\n'
    '- "Olfactory Power in Humans" study ACS Chem Neurosci, Nov 16, 2010\n'
    '- pupil dilation, blood pressure, muscle tension, skin temp, pulse rate, brain activity\n'
    '- Lavender hydrosol - for burns\n'
    '- smell training with EO\n'
    '- assoc with loss of sense of smell when older with Alzheimers and Parkinsons\n'
    '- sense of smell is one of the main things your brain uses to keep us safe\n'
    '- smells tell us whether someone is stressed or scared\n'
    '- Sandeep Robert Datta';

  sb_hazardous_eos := E'- Basil\n'
    '- Bergamot - photosensitivity\n'
    '- Cinnamon - Skin irritation\n'
    '- Clary Sage - increases effects of alcohol intoxication\n'
    '- Clove - skin irritant\n'
    '- Fennel - avoid if pregnant, can cause seizures\n'
    '- Frankincense - skin irritant\n'
    '- Hyssop - can cause seizures\n'
    '- Marjoram - avoid if pregnant\n'
    '- Mugwort - extreme caution - toxin, neuro-toxin - better to use wormwood\n'
    '- Pennyroyal - pulegone = toxic\n'
    '- Rue - mucus membrane irritant\n'
    '- Sage\n'
    '- Thyme';

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
  -- ── Herbal Actions ──
    (v_fo_ti_id,
     'Adaptogens - help rewrite the story — a lot of adaptogens are also repro tonics — Fo Ti',
     c_class, 'personal', 'Herbal Actions', 10, sb_herbal_actions),
    (14,
     'Adaptogens — a lot of adaptogens are also repro tonics — ginsengs',
     c_class, 'personal', 'Herbal Actions', 20, sb_herbal_actions),

  -- ── Low Testosterone ──
    (40,
     'Sarsaparilla — like to combine with Saw Palmetto [for low testosterone]',
     c_class, 'personal', 'Low Testosterone', 30, sb_low_testosterone),
    (1649,
     'Nettle root — prostate health, helps modulate androgens (diff types of test.) — can use the leaf as a nutritive at the same time — seed too',
     c_class, 'personal', 'Low Testosterone', 40, sb_low_testosterone),
    (1507,
     'Tribulus — traditional — have to work with consistently to see the results — support infertility - motility and sperm count',
     c_class, 'personal', 'Low Testosterone', 50, sb_low_testosterone),
    (186,
     'Saw Palmetto — anytime anyone has excess androgens — certain balding patterns, etc',
     c_class, 'personal', 'Low Testosterone', 60, sb_low_testosterone),

  -- ── Infertility ──
    (17,
     'Schisandra - great as an adaptogen — reduce stress, linked to infertility',
     c_class, 'personal', 'Infertility', 70, sb_infertility),
    (1548,
     'Goji berry — support for Jing/life essence',
     c_class, 'personal', 'Infertility', 80, sb_infertility),
    (20,
     'Ashwagandha — increase the motility of sperm and reduce stress hormones',
     c_class, 'personal', 'Infertility', 90, sb_infertility),
    (73,
     'circ herbs for infertility — Hawthorn',
     c_class, 'personal', 'Infertility', 100, sb_infertility),
    (165,
     'circ herbs for infertility — Ginkgo',
     c_class, 'personal', 'Infertility', 110, sb_infertility),
    (124,
     'circ herbs for infertility — Ginger',
     c_class, 'personal', 'Infertility', 120, sb_infertility),
    (182,
     'circ herbs for infertility — Collinsonia [circulatory herb for sperm health]',
     c_class, 'personal', 'Infertility', 130, sb_infertility),

  -- ── BPH ──
    (1649,
     'Nettle root - tonic [for BPH]. Dosage: 1-3 ml, 3x per day. Min 6 months for preventative use.',
     c_class, 'personal', 'BPH', 140, sb_bph),
    (186,
     'Saw Palmetto - tonic [for BPH]. Gaia herbs - Saw Palmetto - preventative 2 caps per day.',
     c_class, 'personal', 'BPH', 150, sb_bph),

  -- ── Erectile Dysfunction ──
    (73,
     'CV tonics for erectile dysfunction — hawthorn',
     c_class, 'personal', 'Erectile Dysfunction', 160, sb_erectile_dysfunction),
    (165,
     'CV tonics for erectile dysfunction — ginkgo — tea has 0 benefit — only alcohol based remedy',
     c_class, 'personal', 'Erectile Dysfunction', 170, sb_erectile_dysfunction),
    (14,
     'CV tonics for erectile dysfunction — red ginseng',
     c_class, 'personal', 'Erectile Dysfunction', 180, sb_erectile_dysfunction),
    (144,
     'Aphrodisiac herbs for erectile dysfunction — damiana',
     c_class, 'personal', 'Erectile Dysfunction', 190, sb_erectile_dysfunction),
    (851,
     'Aphrodisiac herbs for erectile dysfunction — maca',
     c_class, 'personal', 'Erectile Dysfunction', 200, sb_erectile_dysfunction),
    (850,
     'Aphrodisiac herbs for erectile dysfunction — rose',
     c_class, 'personal', 'Erectile Dysfunction', 210, sb_erectile_dysfunction),
    (186,
     'Hormone balancers for erectile dysfunction — saw palmetto',
     c_class, 'personal', 'Erectile Dysfunction', 220, sb_erectile_dysfunction),
    (1649,
     'Hormone balancers for erectile dysfunction — nettle root',
     c_class, 'personal', 'Erectile Dysfunction', 230, sb_erectile_dysfunction),
    (137,
     'Alkaloidal plant — needs 5-10% vinegar when tincturing — passionflower [for anxiety/nervine support in ED]',
     c_class, 'personal', 'Erectile Dysfunction', 240, sb_erectile_dysfunction),
    (131,
     'Alkaloidal plant — needs 5-10% vinegar when tincturing — motherwort [for nervine support in ED]',
     c_class, 'personal', 'Erectile Dysfunction', 250, sb_erectile_dysfunction),
    (145,
     'Alkaloidal plant — needs 5-10% vinegar when tincturing — valerian root',
     c_class, 'personal', 'Erectile Dysfunction', 260, sb_erectile_dysfunction),
    (128,
     'Alkaloidal plant — needs 5-10% vinegar when tincturing — california poppy',
     c_class, 'personal', 'Erectile Dysfunction', 270, sb_erectile_dysfunction),
    (132,
     'Alkaloidal plant — needs 5-10% vinegar when tincturing — lobelia',
     c_class, 'personal', 'Erectile Dysfunction', 280, sb_erectile_dysfunction),
    (33,
     'Alkaloidal plant — berberine — OGR (Oregon Grape Root) — needs 5-10% vinegar when tincturing',
     c_class, 'personal', 'Erectile Dysfunction', 290, sb_erectile_dysfunction),
    (122,
     'All purpose bitter (EP) — dandelion [listed as key bitter herb in EP all-purpose bitter formula]',
     c_class, 'personal', 'Erectile Dysfunction', 300, sb_erectile_dysfunction),
    (65,
     'All purpose bitter (EP) — angelica [in EP all-purpose bitter formula]',
     c_class, 'personal', 'Erectile Dysfunction', 310, sb_erectile_dysfunction),
    (172,
     'All purpose bitter (EP) — artichoke [in EP all-purpose bitter formula]',
     c_class, 'personal', 'Erectile Dysfunction', 320, sb_erectile_dysfunction),
    (76,
     'All purpose bitter (EP) — plus fennel for bloating [in EP all-purpose bitter formula]',
     c_class, 'personal', 'Erectile Dysfunction', 330, sb_erectile_dysfunction),

  -- ── Unexpected Helpful Plants ──
    (136,
     'Catnip - safe for animals and natural insect repellent (part of the mint family)',
     c_class, 'personal', 'Unexpected Helpful Plants', 340, sb_unexpected_plants),
    (97,
     'Wormwood - apply directly to the skin for osteoarthritis and pain management',
     c_class, 'personal', 'Unexpected Helpful Plants', 350, sb_unexpected_plants),
    (70,
     'Calendula - skin beneficial, deeply conditioning, moisturizing, reduces wrinkles',
     c_class, 'personal', 'Unexpected Helpful Plants', 360, sb_unexpected_plants),
    (217,
     'Coffee - anti-aging, tightens skin, brings blood to the skin, AI (both green and roasted coffee - green may help more with collagen production)',
     c_class, 'personal', 'Unexpected Helpful Plants', 370, sb_unexpected_plants),

  -- ── Plants in Perfumery ──
    (420,
     'Basil — higher concentration of Estragole - linked to liver cancer and blood clotting. Basil hydrosol known as a skin tonic and insect repellent.',
     c_class, 'personal', 'Plants in Perfumery', 380, sb_plants_in_perfumery),
    (163,
     'Lily of the Valley — Cardiac medicinal, like Foxglove. To use in perfumery is to risk stopping someone''s heart.',
     c_class, 'personal', 'Plants in Perfumery', 390, sb_plants_in_perfumery),

  -- ── Scent Effects ──
    (82,
     'Lavender hydrosol - for burns',
     c_class, 'personal', 'Scent Effects', 400, sb_scent_effects),

  -- ── Hazardous Essential Oils ──
    (407,
     'Bergamot - photosensitivity [hazardous EO/hydrosol warning]',
     c_class, 'personal', 'Hazardous Essential Oils', 410, sb_hazardous_eos),
    (167,
     'Cinnamon - Skin irritation [hazardous EO/hydrosol warning]',
     c_class, 'personal', 'Hazardous Essential Oils', 420, sb_hazardous_eos),
    (743,
     'Clary Sage - increases effects of alcohol intoxication [hazardous EO/hydrosol warning]',
     c_class, 'personal', 'Hazardous Essential Oils', 430, sb_hazardous_eos),
    (111,
     'Clove - skin irritant [hazardous EO/hydrosol warning]',
     c_class, 'personal', 'Hazardous Essential Oils', 440, sb_hazardous_eos),
    (76,
     'Fennel - avoid if pregnant, can cause seizures [hazardous EO/hydrosol warning]',
     c_class, 'personal', 'Hazardous Essential Oils', 450, sb_hazardous_eos),
    (53,
     'Hyssop - can cause seizures [hazardous EO/hydrosol warning]',
     c_class, 'personal', 'Hazardous Essential Oils', 460, sb_hazardous_eos),
    (107,
     'Marjoram - avoid if pregnant [hazardous EO/hydrosol warning]',
     c_class, 'personal', 'Hazardous Essential Oils', 470, sb_hazardous_eos),
    (115,
     'Mugwort - extreme caution - toxin, neuro-toxin - better to use wormwood [hazardous EO/hydrosol warning]',
     c_class, 'personal', 'Hazardous Essential Oils', 480, sb_hazardous_eos),
    (135,
     'Pennyroyal - pulegone = toxic [hazardous EO/hydrosol warning]',
     c_class, 'personal', 'Hazardous Essential Oils', 490, sb_hazardous_eos),
    (110,
     'Rue - mucus membrane irritant [hazardous EO/hydrosol warning]',
     c_class, 'personal', 'Hazardous Essential Oils', 500, sb_hazardous_eos);

  RAISE NOTICE 'Class 38 snippets inserted.';
END $$;

-- ── Keywords ────────────────────────────────────────────────────────────────
-- Fo Ti (herb_id resolved via subquery)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category)
SELECT id, kw, cat FROM herbal.herbs, (VALUES
  ('Polygonum multiflorum', 'low testosterone',       'ailment'),
  ('Polygonum multiflorum', 'reproductive support',   'ailment'),
  ('Polygonum multiflorum', 'anti-aging',             'action'),
  ('Polygonum multiflorum', 'hyperlipidemia',         'ailment'),
  ('Polygonum multiflorum', 'blood sugar dysregulation', 'ailment')
) AS t(ln, kw, cat)
WHERE herbal.herbs.latin_name = t.ln
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Ginseng
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (14, 'reproductive support', 'ailment'),
  (14, 'erectile dysfunction',  'ailment'),
  (14, 'energy support',        'ailment'),
  (14, 'stress',                'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Sarsaparilla
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (40, 'low testosterone',   'ailment'),
  (40, 'reproductive support', 'ailment'),
  (40, 'hormonal support',   'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Nettle root
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1649, 'low testosterone',   'ailment'),
  (1649, 'prostate health',    'ailment'),
  (1649, 'BPH',               'ailment'),
  (1649, 'hormonal support',  'ailment'),
  (1649, 'erectile dysfunction', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Tribulus (Caltrop Fruit)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1507, 'low testosterone',   'ailment'),
  (1507, 'sperm motility',     'ailment'),
  (1507, 'fertility support',  'ailment'),
  (1507, 'reproductive support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Saw Palmetto
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (186, 'low testosterone',   'ailment'),
  (186, 'prostate health',    'ailment'),
  (186, 'BPH',               'ailment'),
  (186, 'hair loss',         'ailment'),
  (186, 'hormonal support',  'ailment'),
  (186, 'erectile dysfunction', 'ailment'),
  (186, 'andropause',        'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Schizandra
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (17, 'fertility support',  'ailment'),
  (17, 'sperm motility',    'ailment'),
  (17, 'stress',            'ailment'),
  (17, 'reproductive support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Wolfberry / Goji (Wolfberry Fruit, id 1548)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1548, 'fertility support',  'ailment'),
  (1548, 'reproductive support', 'ailment'),
  (1548, 'energy support',    'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Ashwagandha
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (20, 'sperm motility',    'ailment'),
  (20, 'fertility support', 'ailment'),
  (20, 'stress',            'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Hawthorn berry
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (73, 'fertility support',      'ailment'),
  (73, 'erectile dysfunction',   'ailment'),
  (73, 'cardiovascular disease', 'ailment'),
  (73, 'circulation',            'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Ginkgo
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (165, 'fertility support',     'ailment'),
  (165, 'erectile dysfunction',  'ailment'),
  (165, 'cardiovascular disease', 'ailment'),
  (165, 'circulation',           'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Ginger
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (124, 'fertility support', 'ailment'),
  (124, 'circulation',       'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Stoneroot / Collinsonia
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (182, 'fertility support', 'ailment'),
  (182, 'circulation',       'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Damiana
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (144, 'erectile dysfunction', 'ailment'),
  (144, 'aphrodisiac',         'action'),
  (144, 'reproductive support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Maca
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (851, 'erectile dysfunction', 'ailment'),
  (851, 'aphrodisiac',         'action'),
  (851, 'hormonal support',    'ailment'),
  (851, 'reproductive support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Rose petal
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (850, 'erectile dysfunction', 'ailment'),
  (850, 'aphrodisiac',         'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Passionflower
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (137, 'anxiety',       'ailment'),
  (137, 'sleep support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Motherwort
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (131, 'anxiety', 'ailment'),
  (131, 'stress',  'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Valerian
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (145, 'anxiety',       'ailment'),
  (145, 'sleep support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- California Poppy
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (128, 'anxiety',       'ailment'),
  (128, 'sleep support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Lobelia
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (132, 'anxiety', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Oregon Grape
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (33, 'digestive tonic', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Dandelion root
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (122, 'digestive tonic', 'ailment'),
  (122, 'liver support',   'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Angelica
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (65, 'digestive tonic', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Artichoke
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (172, 'digestive tonic', 'ailment'),
  (172, 'liver support',   'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Fennel
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (76, 'digestive tonic', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Catnip
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (136, 'insect repellent', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Wormwood
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (97, 'osteoarthritis', 'ailment'),
  (97, 'chronic pain',   'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Calendula
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (70, 'skin conditions', 'ailment'),
  (70, 'anti-aging',      'action'),
  (70, 'wound healing',   'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Coffee
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (217, 'skin conditions', 'ailment'),
  (217, 'anti-aging',      'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Basil
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (420, 'skin conditions', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Lily of the Valley
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (163, 'cardiovascular disease', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Lavender
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (82, 'burns', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Bergamot
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (407, 'photosensitivity', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Cinnamon
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (167, 'skin conditions', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Clove
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (111, 'skin conditions', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Mugwort — no new keywords (safety note only)
-- Pennyroyal — no new keywords (toxicity warning only)
-- Clary Sage — no clinical indication keywords
-- Hyssop — no new keywords (seizure warning only)
-- Marjoram — no new keywords (pregnancy warning only)
-- Rue — no new keywords (irritant warning only)

-- ── Ailment search terms (new keywords only) ────────────────────────────────
INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('sperm motility',
   ARRAY['low sperm motility', 'asthenospermia', 'sperm quality', 'male fertility', 'oligospermia', 'poor sperm motility']),
  ('hair loss',
   ARRAY['alopecia', 'androgenic alopecia', 'male pattern baldness', 'hair thinning', 'balding', 'DHT-related hair loss']),
  ('prostate health',
   ARRAY['prostate support', 'prostate wellness', 'prostate prevention', 'enlarged prostate prevention', 'AMAB prostate']),
  ('burns',
   ARRAY['burn treatment', 'thermal burns', 'skin burns', 'burn healing', 'first degree burns', 'minor burns']),
  ('osteoarthritis',
   ARRAY['OA', 'degenerative joint disease', 'wear and tear arthritis', 'joint degeneration', 'articular degeneration']),
  ('photosensitivity',
   ARRAY['sun sensitivity', 'phototoxicity', 'light sensitivity', 'photodermatitis', 'increased UV sensitivity'])
ON CONFLICT (ailment_keyword) DO NOTHING;

