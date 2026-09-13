-- Migration 309: Class 38 quiz questions — AMAB Repro II Diseases and Perfumes
--
-- Target: 50 questions
--   H = 42 distinct herbs/supplements identified
--   F = 10 named factual items (dosages, formulas, ratios, constituents)
--   formula: clamp(15 + 42×4 + 10×1, 20, 50) = clamp(193, 20, 50) = 50
--
-- Correct option distribution: a=12, b=12, c=13, d=13

SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_quiz_questions
             WHERE class_name = 'BHC - Class 38 - AMAB Repro II Diseases and Perfumes') THEN
    RAISE NOTICE 'Class 38 quiz already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_quiz_questions
    (class_name, question_text, option_a, option_b, option_c, option_d,
     correct_option, explanation, snippet_text, section_header, sort_order)
  VALUES

  -- Q1 (c)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'Which herb is specifically named alongside ginsengs as a reproductive adaptogen in the Herbal Actions overview of Class 38?',
   'Sarsaparilla', 'Tribulus', 'Fo Ti', 'Saw Palmetto', 'c',
   'Fo Ti is explicitly named alongside ginsengs under the adaptogen category as an herb that is also a reproductive tonic.',
   'Adaptogens - help rewrite the story — a lot of adaptogens are also repro tonics — Fo Ti',
   'Herbal Actions', 10),

  -- Q2 (a)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'In Class 38, Sarsaparilla is noted as best combined with which herb for low testosterone support?',
   'Saw Palmetto', 'Ginkgo', 'Nettle root', 'Ashwagandha', 'a',
   'The notes specifically state to "like to combine with Saw Palmetto" when using Sarsaparilla for low testosterone.',
   'Sarsaparilla — like to combine with Saw Palmetto [for low testosterone]',
   'Low Testosterone', 20),

  -- Q3 (c)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'In Class 38, Nettle root is described as helping to modulate which substances for AMAB reproductive health?',
   'Estrogen', 'Cortisol', 'Androgens', 'Dopamine', 'c',
   'Nettle root is described as modulating androgens (different types of testosterone) and supporting prostate health.',
   'Nettle root — prostate health, helps modulate androgens (diff types of test.) — can use the leaf as a nutritive at the same time — seed too',
   'Low Testosterone', 30),

  -- Q4 (b)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'Which herb is specifically described in Class 38 as needing consistent use over time before results are seen for testosterone support?',
   'Saw Palmetto', 'Tribulus', 'Sarsaparilla', 'Nettle root', 'b',
   'Tribulus is described as "traditional" and requiring consistent use to see results; it also supports infertility via motility and sperm count.',
   'Tribulus — traditional — have to work with consistently to see the results — support infertility - motility and sperm count',
   'Low Testosterone', 40),

  -- Q5 (c)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'What dosage and minimum duration is given for Nettle root in preventative BPH use in Class 38?',
   '2–5 ml twice daily, minimum 3 months',
   '0.5–1 ml four times daily, minimum 1 month',
   '1–3 ml three times per day, minimum 6 months',
   '3–5 ml once daily, minimum 12 months', 'c',
   'The notes give Nettle root at 1–3 ml, 3x per day, with a minimum of 6 months for preventative use.',
   'Nettle root - tonic [for BPH]. Dosage: 1-3 ml, 3x per day. Min 6 months for preventative use.',
   'BPH', 50),

  -- Q6 (b)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'What is the Gaia Herbs recommended preventative dose for Saw Palmetto in BPH according to Class 38?',
   '1 capsule per day', '2 capsules per day', '3 capsules per day', '4 capsules per day', 'b',
   'The notes reference Gaia Herbs Saw Palmetto at 2 caps per day as a preventative dose.',
   'Saw Palmetto - tonic [for BPH]. Gaia herbs - Saw Palmetto - preventative 2 caps per day.',
   'BPH', 60),

  -- Q7 (a)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'Which herb is described in Class 38 as supporting "Jing/life essence" in the context of male infertility?',
   'Goji berry', 'Ashwagandha', 'Schizandra', 'Tribulus', 'a',
   'Goji berry is specifically noted for supporting Jing/life essence in the infertility section.',
   'Goji berry — support for Jing/life essence',
   'Infertility', 70),

  -- Q8 (b)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'In Class 38, Ashwagandha is described as specifically increasing what for infertility support?',
   'Testosterone levels directly',
   'The motility of sperm and reducing stress hormones',
   'Libido and sexual drive',
   'Sperm morphology', 'b',
   'Ashwagandha is noted for increasing sperm motility and reducing stress hormones as its dual mechanism for infertility.',
   'Ashwagandha — increase the motility of sperm and reduce stress hormones',
   'Infertility', 80),

  -- Q9 (c)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'Schizandra is recommended for infertility support in Class 38 primarily due to what property?',
   'It directly stimulates testosterone synthesis',
   'It is a potent aphrodisiac',
   'It is a great adaptogen that reduces stress linked to infertility',
   'It improves sperm morphology and DNA integrity', 'c',
   'Schizandra is described as "great as an adaptogen" that reduces stress, which is linked to infertility.',
   'Schisandra - great as an adaptogen — reduce stress, linked to infertility',
   'Infertility', 90),

  -- Q10 (c)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'Which set of herbs is listed in Class 38 as circulatory herbs for infertility support?',
   'Rose, Damiana, Maca, Ginkgo',
   'Valerian, Hawthorn, Schizandra, Ginger',
   'Hawthorn, Ginkgo, Ginger, Collinsonia',
   'Nettle root, Ginkgo, Ginger, Ashwagandha', 'c',
   'The notes list Hawthorn, Ginkgo, Ginger, and Collinsonia as the circulatory herbs for infertility.',
   'circ herbs for infertility — Hawthorn',
   'Infertility', 100),

  -- Q11 (c)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'In Class 38, Hawthorn is listed as a CV tonic for which AMAB reproductive condition?',
   'BPH', 'Low testosterone', 'Erectile dysfunction', 'Infertility', 'c',
   'Hawthorn is listed under CV tonics in the erectile dysfunction section alongside Ginkgo and red ginseng.',
   'CV tonics for erectile dysfunction — hawthorn',
   'Erectile Dysfunction', 110),

  -- Q12 (c)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'For Ginkgo used in erectile dysfunction, which preparation form is described in Class 38 as having zero therapeutic benefit?',
   'Capsule', 'Glycerite', 'Tea', 'Standardized tincture', 'c',
   'The notes state "tea has 0 benefit" for Ginkgo — it must be prepared as an alcohol-based remedy to be effective.',
   'CV tonics for erectile dysfunction — ginkgo — tea has 0 benefit — only alcohol based remedy',
   'Erectile Dysfunction', 120),

  -- Q13 (a)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'Which group of herbs is categorized as aphrodisiacs for erectile dysfunction in Class 38?',
   'Damiana, Maca, Rose, Epimedium',
   'Hawthorn, Ginkgo, Red Ginseng',
   'Passionflower, Motherwort, Valerian',
   'Nettle root, Saw Palmetto, Tribulus', 'a',
   'Damiana, Maca, Rose, and Epimedium (horny goat weed) are all listed as aphrodisiac herbs for erectile dysfunction.',
   'Aphrodisiac herbs for erectile dysfunction — damiana',
   'Erectile Dysfunction', 130),

  -- Q14 (d)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'What percentage of vinegar is recommended in Class 38 when tincturing alkaloidal plants such as passionflower?',
   '1–2%', '15–20%', '25–30%', '5–10%', 'd',
   'Alkaloidal plants require 5–10% vinegar when tincturing; vinegar forms a salt with the alkaloids to improve extraction.',
   'Alkaloidal plant — needs 5-10% vinegar when tincturing — passionflower [for anxiety/nervine support in ED]',
   'Erectile Dysfunction', 140),

  -- Q15 (a)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'Which of the following is listed in Class 38 as an alkaloidal plant requiring vinegar addition when tincturing?',
   'Motherwort', 'Sarsaparilla', 'Goji berry', 'Ashwagandha', 'a',
   'Motherwort is listed as an alkaloidal plant requiring 5–10% vinegar when tincturing, alongside passionflower, valerian, California poppy, lobelia, and OGR.',
   'Alkaloidal plant — needs 5-10% vinegar when tincturing — motherwort [for nervine support in ED]',
   'Erectile Dysfunction', 150),

  -- Q16 (c)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'In the Herbal Actions overview of Class 38, which herb group is described as being both adaptogens AND reproductive tonics simultaneously?',
   'Demulcents', 'Astringents', 'Ginsengs (and Fo Ti)', 'Nervines', 'c',
   'The notes state "a lot of adaptogens are also repro tonics" with ginsengs and Fo Ti as the examples given.',
   'Adaptogens — a lot of adaptogens are also repro tonics — ginsengs',
   'Herbal Actions', 160),

  -- Q17 (c)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'In the EP all-purpose bitter formula described in Class 38, which herb is specifically added for bloating?',
   'Artichoke', 'Angelica', 'Fennel', 'Dandelion root', 'c',
   'Fennel is noted as the herb "plus fennel for bloating" added to the bitter formula of dandelion, orange peel, angelica, and artichoke.',
   'All purpose bitter (EP) — plus fennel for bloating [in EP all-purpose bitter formula]',
   'Erectile Dysfunction', 170),

  -- Q18 (b)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'Which of the following is NOT listed as an ingredient in the EP all-purpose bitter formula in Class 38?',
   'Dandelion', 'Elderberry', 'Artichoke', 'Angelica', 'b',
   'The EP bitter formula contains dandelion, orange peel, angelica, artichoke, and fennel — elderberry is not included.',
   'All purpose bitter (EP) — dandelion [listed as key bitter herb in EP all-purpose bitter formula]',
   'Erectile Dysfunction', 180),

  -- Q19 (c)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'In the Class 38 perfumery section, Catnip is highlighted for which unexpected property?',
   'Cardiovascular support', 'Hormone balancing', 'Natural insect repellent', 'Liver detoxification', 'c',
   'Catnip is noted as safe for animals and a natural insect repellent, being part of the mint family.',
   'Catnip - safe for animals and natural insect repellent (part of the mint family)',
   'Unexpected Helpful Plants', 190),

  -- Q20 (c)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'In Class 38, Wormwood is recommended for which topical application in the natural perfumery context?',
   'Burns and skin inflammation', 'Wound healing and antisepsis',
   'Osteoarthritis and pain management', 'Psoriasis and eczema', 'c',
   'Wormwood is described as applicable directly to the skin for osteoarthritis and pain management.',
   'Wormwood - apply directly to the skin for osteoarthritis and pain management',
   'Unexpected Helpful Plants', 200),

  -- Q21 (d)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'In the Class 38 perfumery section, Calendula is described as having which combination of skin benefits?',
   'Antibacterial and antifungal', 'Analgesic and anti-inflammatory',
   'Hepatoprotective and detoxifying',
   'Skin beneficial, deeply conditioning, moisturizing, reduces wrinkles', 'd',
   'Calendula is specifically described as skin beneficial, deeply conditioning, moisturizing, and reducing wrinkles.',
   'Calendula - skin beneficial, deeply conditioning, moisturizing, reduces wrinkles',
   'Unexpected Helpful Plants', 210),

  -- Q22 (d)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'In Class 38, Coffee is described as providing which skin benefit when applied topically?',
   'Reduces inflammation and redness',
   'Promotes wound healing',
   'Exfoliates and evens skin tone',
   'Anti-aging, tightens skin, brings blood to the skin, anti-inflammatory', 'd',
   'Coffee is described as anti-aging, tightening skin, bringing blood to the skin, and anti-inflammatory (AI).',
   'Coffee - anti-aging, tightens skin, brings blood to the skin, AI (both green and roasted coffee - green may help more with collagen production)',
   'Unexpected Helpful Plants', 220),

  -- Q23 (a)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'According to Class 38, which type of coffee may help more with collagen production?',
   'Green (unroasted) coffee', 'Dark roasted coffee', 'Espresso', 'Instant coffee', 'a',
   'The notes state that green (unroasted) coffee may help more with collagen production compared to roasted coffee.',
   'Coffee - anti-aging, tightens skin, brings blood to the skin, AI (both green and roasted coffee - green may help more with collagen production)',
   'Unexpected Helpful Plants', 230),

  -- Q24 (d)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'In Class 38, Basil is flagged as hazardous due to a higher concentration of which compound linked to liver cancer and blood clotting?',
   'Pulegone', 'Thujone', 'Camphor', 'Estragole', 'd',
   'Basil contains a higher concentration of Estragole, which is linked to liver cancer and blood clotting — making it hazardous in high-concentration preparations.',
   'Basil — higher concentration of Estragole - linked to liver cancer and blood clotting. Basil hydrosol known as a skin tonic and insect repellent.',
   'Plants in Perfumery', 240),

  -- Q25 (a)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'In Class 38, Lily of the Valley is compared to Foxglove as a perfumery hazard because using it could do what?',
   'Risk stopping someone''s heart', 'Cause neurological damage',
   'Trigger severe photosensitivity', 'Irritate mucous membranes severely', 'a',
   'Lily of the Valley is described as a cardiac medicinal like Foxglove; to use it in perfumery risks stopping someone''s heart.',
   'Lily of the Valley — Cardiac medicinal, like Foxglove. To use in perfumery is to risk stopping someone''s heart.',
   'Plants in Perfumery', 250),

  -- Q26 (d)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'In Class 38, Lavender hydrosol is specifically cited for which therapeutic application?',
   'Anxiety and nervousness', 'Insomnia', 'Wound infections', 'Burns', 'd',
   'Lavender hydrosol is listed for burns as one of its primary therapeutic applications discussed in the scent effects section.',
   'Lavender hydrosol - for burns',
   'Scent Effects', 260),

  -- Q27 (c)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'Which essential oil is flagged in Class 38 as causing photosensitivity?',
   'Clary Sage', 'Lavender', 'Bergamot', 'Hyssop', 'c',
   'Bergamot is listed among hazardous essential oils specifically for causing photosensitivity.',
   'Bergamot - photosensitivity [hazardous EO/hydrosol warning]',
   'Hazardous Essential Oils', 270),

  -- Q28 (c)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'In Class 38, Clary Sage is listed as a hazardous essential oil because it does what?',
   'Can cause seizures', 'Is a potent emmenagogue',
   'Increases the effects of alcohol intoxication', 'Causes severe skin irritation', 'c',
   'Clary Sage is flagged specifically for increasing the effects of alcohol intoxication.',
   'Clary Sage - increases effects of alcohol intoxication [hazardous EO/hydrosol warning]',
   'Hazardous Essential Oils', 280),

  -- Q29 (d)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'Which two essential oils are flagged in Class 38 as potentially causing seizures?',
   'Basil and Mugwort', 'Pennyroyal and Clove', 'Rue and Marjoram', 'Fennel and Hyssop', 'd',
   'Both Fennel and Hyssop are specifically flagged as capable of causing seizures in the hazardous essential oils section.',
   'Fennel - avoid if pregnant, can cause seizures [hazardous EO/hydrosol warning]',
   'Hazardous Essential Oils', 290),

  -- Q30 (b)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'In Class 38, which toxic compound in Pennyroyal makes it hazardous?',
   'Thujone', 'Pulegone', 'Camphor', 'Estragole', 'b',
   'Pennyroyal is flagged as toxic due to its pulegone content.',
   'Pennyroyal - pulegone = toxic [hazardous EO/hydrosol warning]',
   'Hazardous Essential Oils', 300),

  -- Q31 (b)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'In Class 38, Mugwort is described as a neurotoxin, with which herb recommended as the safer alternative?',
   'Sage', 'Wormwood', 'Thyme', 'Marjoram', 'b',
   'The notes flag Mugwort as extreme caution — a toxin and neuro-toxin — and recommend using Wormwood instead.',
   'Mugwort - extreme caution - toxin, neuro-toxin - better to use wormwood [hazardous EO/hydrosol warning]',
   'Hazardous Essential Oils', 310),

  -- Q32 (b)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'Rue is flagged in Class 38 for irritating which type of tissue?',
   'Liver parenchyma', 'Mucous membranes', 'Nerve endings', 'Intestinal epithelium', 'b',
   'Rue is listed as a mucus membrane irritant among hazardous essential oils and hydrosols.',
   'Rue - mucus membrane irritant [hazardous EO/hydrosol warning]',
   'Hazardous Essential Oils', 320),

  -- Q33 (d)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'Which herb in Class 38 appears in both the Infertility section as a circulatory herb AND the Erectile Dysfunction section as a CV tonic?',
   'Ginger', 'Ginkgo', 'Red Ginseng', 'Hawthorn', 'd',
   'Hawthorn is listed as a circulatory herb for infertility and again as a CV tonic under erectile dysfunction.',
   'circ herbs for infertility — Hawthorn',
   'Infertility', 330),

  -- Q34 (b)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'In Class 38, Lobelia is listed as an alkaloidal plant requiring what special treatment when tincturing?',
   'Cold percolation only', '5–10% vinegar addition', 'Hot water decoction only', 'CO2 extraction', 'b',
   'Lobelia is listed among the alkaloidal plants (alongside passionflower, motherwort, valerian, California poppy, and OGR) that require 5–10% vinegar when tincturing.',
   'Alkaloidal plant — needs 5-10% vinegar when tincturing — lobelia',
   'Erectile Dysfunction', 340),

  -- Q35 (b)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'In Class 38, Saw Palmetto is recommended for which pattern of hair loss related to excess androgens?',
   'Alopecia areata (autoimmune)', 'Androgenic alopecia (certain balding patterns)',
   'Telogen effluvium (stress-induced)', 'Traction alopecia', 'b',
   'Saw Palmetto is recommended "anytime anyone has excess androgens — certain balding patterns, etc," indicating androgenic alopecia.',
   'Saw Palmetto — anytime anyone has excess androgens — certain balding patterns, etc',
   'Low Testosterone', 350),

  -- Q36 (d)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'Which herb is identified in Class 38 as an alkaloidal plant due to its berberine content, noted by the abbreviation OGR?',
   'Lobelia', 'Valerian', 'Passionflower', 'Oregon Grape Root', 'd',
   'OGR stands for Oregon Grape Root; berberine is its defining alkaloid and the reason it requires vinegar when tincturing.',
   'Alkaloidal plant — berberine — OGR (Oregon Grape Root) — needs 5-10% vinegar when tincturing',
   'Erectile Dysfunction', 360),

  -- Q37 (a)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'In Class 38, Tribulus is described as supporting male infertility through which specific mechanism?',
   'Motility and sperm count', 'Reducing DHT levels',
   'Increasing testosterone synthesis', 'Lowering cortisol', 'a',
   'Tribulus is noted for supporting infertility specifically via motility and sperm count.',
   'Tribulus — traditional — have to work with consistently to see the results — support infertility - motility and sperm count',
   'Low Testosterone', 370),

  -- Q38 (a)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'In Class 38, Rose is categorized under which therapeutic grouping for erectile dysfunction?',
   'Aphrodisiac herbs', 'Hormone balancers', 'Circulatory stimulants', 'Nervines', 'a',
   'Rose is listed under "aphrodisiac herbs" alongside damiana, maca, and epimedium for erectile dysfunction.',
   'Aphrodisiac herbs for erectile dysfunction — rose',
   'Erectile Dysfunction', 380),

  -- Q39 (b)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'In Class 38, which herb is listed as a hormone balancer for erectile dysfunction alongside Saw Palmetto?',
   'Ginkgo', 'Nettle root', 'Damiana', 'Goji berry', 'b',
   'Nettle root is listed alongside Saw Palmetto under hormone balancers for erectile dysfunction.',
   'Hormone balancers for erectile dysfunction — nettle root',
   'Erectile Dysfunction', 390),

  -- Q40 (d)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'In Class 38, Artichoke is noted as part of which traditional formula?',
   'A warming circulatory blend', 'A lymphatic clearing protocol',
   'A hormone-balancing formula', 'The EP all-purpose bitter formula', 'd',
   'Artichoke is one of the key ingredients in the EP all-purpose bitter formula alongside dandelion, orange peel, angelica, and fennel.',
   'All purpose bitter (EP) — artichoke [in EP all-purpose bitter formula]',
   'Erectile Dysfunction', 400),

  -- Q41 (a)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'According to Class 38, what is the minimum duration of preventative herbal treatment for BPH before benefit is expected?',
   '6 months', '3 months', '12 months', '1 month', 'a',
   'The notes specify a minimum of 6 months for preventative use with Nettle root (1–3 ml, 3x/day).',
   'Nettle root - tonic [for BPH]. Dosage: 1-3 ml, 3x per day. Min 6 months for preventative use.',
   'BPH', 410),

  -- Q42 (b)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'In Class 38, which herb is described as a "tonic" for BPH with a preventative dose of 2 caps per day from Gaia Herbs?',
   'Collinsonia', 'Saw Palmetto', 'Schizandra', 'Ashwagandha', 'b',
   'Saw Palmetto is described as a tonic for BPH with a preventative dose of 2 caps/day from Gaia Herbs.',
   'Saw Palmetto - tonic [for BPH]. Gaia herbs - Saw Palmetto - preventative 2 caps per day.',
   'BPH', 420),

  -- Q43 (d)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'In Class 38, which herb is listed as a CV tonic for erectile dysfunction alongside Hawthorn and Ginkgo?',
   'Schizandra', 'Ashwagandha', 'Damiana', 'Red Ginseng', 'd',
   'Red ginseng is the third CV tonic listed for erectile dysfunction, alongside hawthorn and ginkgo.',
   'CV tonics for erectile dysfunction — red ginseng',
   'Erectile Dysfunction', 430),

  -- Q44 (a)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'According to Class 38, which additional parts of the Nettle plant can be used alongside the root for nutritive support?',
   'Leaf and seed', 'Flower and root bark', 'Rhizome and aerial parts', 'Bark and berry', 'a',
   'The notes state the leaf can be used as a nutritive at the same time as the root, and the seed is also mentioned.',
   'Nettle root — prostate health, helps modulate androgens (diff types of test.) — can use the leaf as a nutritive at the same time — seed too',
   'Low Testosterone', 440),

  -- Q45 (d)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'Cinnamon essential oil or hydrosol is flagged in Class 38 for causing what type of adverse reaction?',
   'Photosensitivity', 'Seizures', 'Mucous membrane irritation', 'Skin irritation', 'd',
   'Cinnamon is listed among hazardous EOs specifically for skin irritation.',
   'Cinnamon - Skin irritation [hazardous EO/hydrosol warning]',
   'Hazardous Essential Oils', 450),

  -- Q46 (b)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'In Class 38, which circulatory herb for infertility support is also known as Stoneroot (Collinsonia canadensis)?',
   'Hawthorn', 'Collinsonia', 'Ginkgo', 'Ginger', 'b',
   'Collinsonia (Stoneroot) is listed as one of the circulatory herbs for infertility support alongside Hawthorn, Ginkgo, and Ginger.',
   'circ herbs for infertility — Collinsonia [circulatory herb for sperm health]',
   'Infertility', 460),

  -- Q47 (a)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'In Class 38, Valerian root is listed as an alkaloidal plant alongside which other nervines requiring vinegar extraction?',
   'Passionflower, Motherwort, California Poppy, Lobelia, OGR',
   'Goji berry, Schizandra, Ashwagandha',
   'Hawthorn, Ginkgo, Red Ginseng',
   'Dandelion, Angelica, Artichoke, Fennel', 'a',
   'Valerian root is one of six alkaloidal herbs listed (passionflower, motherwort, valerian, California poppy, lobelia, OGR) requiring 5–10% vinegar.',
   'Alkaloidal plant — needs 5-10% vinegar when tincturing — valerian root',
   'Erectile Dysfunction', 470),

  -- Q48 (a)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'In Class 38, Clove essential oil is categorized as hazardous due to which property?',
   'Skin irritant', 'Neurotoxicity', 'Photosensitivity', 'Emmenagogue effect', 'a',
   'Clove is listed among hazardous EOs as a skin irritant.',
   'Clove - skin irritant [hazardous EO/hydrosol warning]',
   'Hazardous Essential Oils', 480),

  -- Q49 (d)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'In Class 38, Marjoram essential oil is flagged with which specific caution?',
   'Can cause seizures', 'Increases effects of alcohol', 'Causes photosensitivity', 'Avoid if pregnant', 'd',
   'Marjoram is listed as hazardous with the specific warning to avoid if pregnant.',
   'Marjoram - avoid if pregnant [hazardous EO/hydrosol warning]',
   'Hazardous Essential Oils', 490),

  -- Q50 (d)
  ('BHC - Class 38 - AMAB Repro II Diseases and Perfumes',
   'In Class 38, adaptogens are described as particularly suitable for AMAB reproductive conditions because they are also what?',
   'Antimicrobials', 'Circulatory stimulants', 'Hepatoprotective agents', 'Reproductive tonics', 'd',
   'The notes state "a lot of adaptogens are also repro tonics" — making them a doubly valuable category for AMAB reproductive health.',
   'Adaptogens - help rewrite the story — a lot of adaptogens are also repro tonics — Fo Ti',
   'Herbal Actions', 500);

  RAISE NOTICE 'Class 38 quiz inserted: 50 questions.';
END $$;
