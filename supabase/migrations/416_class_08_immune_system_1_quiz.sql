-- Migration 416: Class 8 — Immune System I quiz questions
-- Class: BHC - Class 8 - Immune System I
--
-- Target calculation:
--   H = 49 distinct herbs/supplements
--   F = 15 named factual items (dosing, species distinctions, preparation notes, specific mechanisms)
--   target = clamp(15 + 49×4 + 15×1, 20, 50) = clamp(226, 20, 50) = 50
--   Rounded: 50 (already at ceiling)
--
-- Correct option distribution: a=12, b=13, c=13, d=12

SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM herbal.class_quiz_questions
    WHERE class_name = 'BHC - Class 8 - Immune System I'
  ) THEN
    RAISE NOTICE 'Class 8 quiz questions already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_quiz_questions
    (class_name, question_text, option_a, option_b, option_c, option_d,
     correct_option, explanation, snippet_text, section_header, sort_order)
  VALUES

  -- 1 (b)
  ('BHC - Class 8 - Immune System I',
   'Which herb is noted for having a specific affinity for the Thymus gland?',
   'Calendula', 'Thyme', 'Echinacea', 'Astragalus',
   'b',
   'The notes explicitly state "Thyme actually has an affinity for the Thymus," connecting the herb''s traditional use to this immune organ.',
   'Thyme actually has an affinity for the Thymus.',
   'Organs of the Immune System', 10),

  -- 2 (a)
  ('BHC - Class 8 - Immune System I',
   'What does "immune amphoteric" mean in the context of these class notes?',
   'Balancing action — brings down excess and raises deficiency', 'Directly kills pathogens', 'Inhibits viral replication', 'Promotes sweating to support fever',
   'a',
   'The notes define amphoteric as "Balancing action — excess brings down, deficiency brings up," distinguishing this category from simple stimulants or antivirals.',
   'Amphoteric = Balancing action - excess brings down, deficiency brings up',
   'Immune Amphoterics', 20),

  -- 3 (c)
  ('BHC - Class 8 - Immune System I',
   'According to these notes, what is the correct dosing frequency for Echinacea when treating an acute illness?',
   '1 dropper once daily', '2 droppers twice daily', '2-3 droppers every 2-3 hours', '5 droppers at first sign of illness only',
   'c',
   'The notes caution that if Echinacea seems "not working" you may not be taking enough, and specify 2-3 droppers every 2-3 hours.',
   'Echinacea — need 2-3 droppers every 2-3 hours.',
   'Immunostimulants', 30),

  -- 4 (d)
  ('BHC - Class 8 - Immune System I',
   'Astragalus is specifically noted as NOT appropriate for which situation?',
   'Long-term tonic use', 'As a tea preparation', 'Combined with other TCM herbs', 'When sick (during acute illness)',
   'd',
   'The notes state Astragalus is "specific for chronic, but not for acute" — do not take when actively sick.',
   'Astragalus — don''t take when sick — specific for chronic, but not for acute.',
   'Immune Amphoterics', 40),

  -- 5 (b)
  ('BHC - Class 8 - Immune System I',
   'Which medicinal mushroom is specifically noted in these class notes for autoimmune conditions?',
   'Shiitake', 'Reishi', 'Lion''s Mane', 'Maitake',
   'b',
   'The notes state "Reishi good for autoimmune" within the Immune Amphoterics section.',
   'Medicinal Mushrooms — Reishi good for autoimmune.',
   'Immune Amphoterics', 50),

  -- 6 (c)
  ('BHC - Class 8 - Immune System I',
   'Schizandra is specifically noted for which respiratory condition in these class notes?',
   'COPD', 'Bronchitis', 'Allergic asthma', 'Tuberculosis',
   'c',
   'The notes state Schizandra is a TCM herb used specifically "for allergic asthma."',
   'Schisandra — TCM as well — use for allergic asthma.',
   'Immune Amphoterics', 60),

  -- 7 (a)
  ('BHC - Class 8 - Immune System I',
   'What safety consideration is noted for Licorice in the immune amphoterics section?',
   'Be careful with dosage and high blood pressure', 'Do not use with antibiotics', 'Avoid in autoimmune conditions', 'Do not take with adaptogens',
   'a',
   'The notes flag: "Licorice — just be careful with dosage and high BP."',
   'Licorice - just be careful with dosage and high BP.',
   'Immune Amphoterics', 70),

  -- 8 (d)
  ('BHC - Class 8 - Immune System I',
   'Ocotillo has a specific lymphatic affinity for which area of the body?',
   'Upper third (head and neck)', 'Thorax and chest', 'Abdominal organs', 'Lower body and pelvic floor',
   'd',
   'The notes describe Ocotillo as having "lower body affinity — pelvic floor lymphatic."',
   'Ocotillo - lower body affinity - pelvic floor lymphatic.',
   'Lymphatics', 80),

  -- 9 (b)
  ('BHC - Class 8 - Immune System I',
   'Figwort is noted as a lymphatic herb with what specific action?',
   'Whole-body fluid circulation', 'Dissolving hardened lymph nodes', 'Upper third lymphatic drainage', 'Antifungal for lymph-related infections',
   'b',
   'The notes state "Figwort — dissolve hardened nodes."',
   'Figwort - dissolve hardened nodes.',
   'Lymphatics', 90),

  -- 10 (c)
  ('BHC - Class 8 - Immune System I',
   'What dosing instruction is given for Poke Root in these class notes?',
   'Standard tincture dose (2-4ml)', 'High dose for acute lymphatic infections', 'Drop dose or low dose only', 'Decoction form exclusively',
   'c',
   'Poke Root is a potent herb; the notes specify "drop dose or low dose."',
   'Poke root - drop dose or low dose.',
   'Lymphatics', 100),

  -- 11 (d)
  ('BHC - Class 8 - Immune System I',
   'Red Root is described as a lymphatic herb with what lymphatic scope?',
   'Upper body only', 'Pelvic floor only', 'Skin-level lymphatics', 'Whole body',
   'd',
   'The notes state "Red root — whole body," distinguishing it from more regionally specific lymphatics.',
   'Red root - whole body.',
   'Lymphatics', 110),

  -- 12 (a)
  ('BHC - Class 8 - Immune System I',
   'What specific preparation method is noted for Cleavers in the lymphatics section?',
   'Blend and strain and freeze', 'Standard tincture in alcohol', 'Hot decoction', 'Dry and powder for capsules',
   'a',
   'The notes say Cleavers should be prepared fresh: "blend and strain and freeze," preserving its delicate constituents.',
   'Cleavers - herbalist badge - affinity for upper third - blend and strain and freeze.',
   'Lymphatics', 120),

  -- 13 (b)
  ('BHC - Class 8 - Immune System I',
   'Evening Primrose Oil is described as what type of immune modulator?',
   'Immunostimulant', 'Mast cell stabilizer', 'Lymphatic tonic', 'Antiviral agent',
   'b',
   'The notes place Evening Primrose Oil in the White Blood Cells section: "mast cell stabilizer," relevant to allergic reactions.',
   'Evening Primrose Oil - mast cell stabilizer.',
   'White Blood Cells', 130),

  -- 14 (c)
  ('BHC - Class 8 - Immune System I',
   'According to these notes, what does chronically elevated cortisol do to the immune system?',
   'Stimulates immune response', 'Has no direct immune effect', 'Downregulates the immune system', 'Only affects lymphatic function',
   'c',
   'The notes state that when cortisol is high for long times, it "downregulates the immune system."',
   'Cortisol released from the Adrenals to maintain fight or flight — when cortisol is high for long times: downregulates the immune system.',
   'What Affects the Immune System', 140),

  -- 15 (d)
  ('BHC - Class 8 - Immune System I',
   'Which three herbs are noted in this class for lowering cortisol?',
   'Chamomile, Elderberry, Garlic', 'Echinacea, Astragalus, Reishi', 'Calendula, Red Root, Figwort', 'Eleuthero, Tulsi, Ginseng',
   'd',
   'The notes list "Eleuthero, Tulsi, Ginseng — lower cortisol" under factors affecting the immune system.',
   'Eleuthero, Tulsi, Ginseng — lower cortisol.',
   'What Affects the Immune System', 150),

  -- 16 (a)
  ('BHC - Class 8 - Immune System I',
   'What is the primary action of a diaphoretic herb?',
   'Promote sweating to support the body''s natural fever response', 'Directly kill viral pathogens', 'Stimulate lymph node activity', 'Stabilize mast cells',
   'a',
   'The Diaphoretics section header reads "promote sweating" — the clinical goal is supporting fever, not suppressing it.',
   '#### Diaphoretics - promote sweating.',
   'Diaphoretics', 160),

  -- 17 (b)
  ('BHC - Class 8 - Immune System I',
   'Which species of Echinacea is noted as stronger in these class notes?',
   'Echinacea purpurea', 'Echinacea angustifolia', 'Echinacea pallida', 'All species are considered equivalent',
   'b',
   'The notes state "depending on species: Angustifolia is stronger than Purpurea."',
   'depending on species: Angustifolia is stronger than Purpurea.',
   'Immunostimulants', 170),

  -- 18 (c)
  ('BHC - Class 8 - Immune System I',
   'Garlic should be prepared how before ingestion to maximize its antiviral effect?',
   'Cooked thoroughly to remove toxins', 'Taken with a full meal', 'Allowed to oxidize for a minute', 'Macerated in alcohol first',
   'c',
   'The notes specify: "let it oxidize for a minute before ingestion" — this activates allicin.',
   'Garlic — let it oxidize for a minute before ingestion.',
   'Antivirals', 180),

  -- 19 (d)
  ('BHC - Class 8 - Immune System I',
   'What quality limitation is specifically noted about Eyebright in these class notes?',
   'Only effective as a tincture, not a tea', 'Must be combined with Goldenrod to be effective', 'Should not be used in children under 12', 'Really only works fresh',
   'd',
   'The notes state Eyebright "really only works fresh," which limits its practical availability.',
   'Eyebright — grows in UK — really only works fresh.',
   'Anticatarrhals', 190),

  -- 20 (a)
  ('BHC - Class 8 - Immune System I',
   'Goldenrod is described as a good local California substitute for which anticatarrhal herb?',
   'Eyebright', 'Goldenseal', 'Yerba Mansa', 'Isatis Root',
   'a',
   'The notes state "Goldenrod — good local substitute for Eyebright — California Goldenrod."',
   'Goldenrod — good local substitute for Eyebright — California Goldenrod.',
   'Anticatarrhals', 200),

  -- 21 (b)
  ('BHC - Class 8 - Immune System I',
   'Which four plants are specifically listed as berberine-containing antifungals in these notes?',
   'Garlic, Usnea, Spilanthes, Black Walnut', 'Goldenseal, Oregon Grape, Barberry, Chinese Coptis', 'Calendula, Figwort, Red Root, Violet', 'Echinacea, Astragalus, Cat''s Claw, Licorice',
   'b',
   'The notes list "Berberine containing plants — Goldenseal, Oregon Grape, Barberry, Chinese Coptis" as antifungal herbs.',
   'Berberine containing plants — Goldenseal, Oregon Grape, Barberry, Chinese Coptis.',
   'Antifungals', 210),

  -- 22 (c)
  ('BHC - Class 8 - Immune System I',
   'Elderberry appears in two immune herb categories in these notes. Which two?',
   'Lymphatic and antifungal', 'Anticatarrhal and adaptogen', 'Immunostimulant and antiviral', 'Diaphoretic and anticatarrhal',
   'c',
   'Elderberry is listed under both "Immunostimulants" and "Antivirals (Inhibit Viral Replication)" sections.',
   'Elderberry — immunostimulant. Elderberry — antiviral.',
   'Immunostimulants', 220),

  -- 23 (d)
  ('BHC - Class 8 - Immune System I',
   '"Bikhail Skullcap" mentioned in the antivirals section refers to which herb?',
   'American Skullcap (Scutellaria lateriflora)', 'California Skullcap', 'Silk Tassel', 'Chinese/Baical Skullcap (Scutellaria baicalensis)',
   'd',
   'The notes clarify it is "Chinese" and "diff than American Skullcap" — Bikhail = Baical = Scutellaria baicalensis.',
   'Bikhail Skullcap — Chinese — infections — diff than American Skullcap.',
   'Antivirals', 230),

  -- 24 (a)
  ('BHC - Class 8 - Immune System I',
   'Boneset appears in two immune herb categories in these notes. Which two?',
   'Immunostimulant and diaphoretic', 'Lymphatic and antifungal', 'Antiviral and anticatarrhal', 'Adaptogen and immunostimulant',
   'a',
   'Boneset is listed under both "Immunostimulants" and "Diaphoretics" sections.',
   'Boneset — immunostimulant. Boneset — diaphoretic; more East Coast herbalists.',
   'Immunostimulants', 240),

  -- 25 (b)
  ('BHC - Class 8 - Immune System I',
   'Goldenseal''s specific tissue affinity noted in these class notes is for:',
   'Lymphatic vessels', 'Mucous membranes', 'The thymus gland', 'Deep immune modulation',
   'b',
   'The notes state "Goldenseal — affinity for working with mucus membranes" in the Anticatarrhals section.',
   'Goldenseal — affinity for working with mucus membranes.',
   'Anticatarrhals', 250),

  -- 26 (c)
  ('BHC - Class 8 - Immune System I',
   'Nettle is specifically noted in the spring herbs section to support which condition?',
   'Liver congestion and bile insufficiency', 'Urinary tract infections', 'Seasonal allergy relief (reduces histamine response)', 'Antifungal infections',
   'c',
   'The notes describe Nettle as supporting "seasonal allergy relief (reduces histamine response)."',
   'Stinging nettle — supports seasonal allergy relief (reduces histamine response).',
   'Medicine of Spring', 260),

  -- 27 (d)
  ('BHC - Class 8 - Immune System I',
   'What constituent makes Horsetail specifically useful for bones, cartilage, hair, skin, nails, and mucous membranes?',
   'Berberine', 'Flavonoids', 'Tannins', 'High levels of silica',
   'd',
   'The notes state Horsetail''s "high level of silica" is why it supports "all the structures that use silica."',
   'Horsetail — due to its high level of silica it is used to support all the structures that use silica (bones, cartilage, hair, skin, nails, and mucous membranes).',
   'Medicine of Spring', 270),

  -- 28 (a)
  ('BHC - Class 8 - Immune System I',
   'Red Clover is noted for which health conditions in the spring herbs section?',
   'Blood cleansing, skin conditions (eczema), menopausal support', 'Fever, acute infection, immune stimulation', 'Lymphatic drainage and antifungal', 'Urinary support and diuresis',
   'a',
   'The notes describe Red Clover as used for "Blood-cleanse tradition, skin conditions (eczema), menopausal symptom support."',
   'Red clover (Trifolium pratense) — Blood-cleanse tradition, used for skin conditions (eczema), menopausal symptom support.',
   'Medicine of Spring', 280),

  -- 29 (b)
  ('BHC - Class 8 - Immune System I',
   'Dandelion is described in the spring herbs section as liver-supportive through what mechanism?',
   'Direct antimicrobial action against liver pathogens', 'Stimulating bile flow', 'Reducing liver inflammation', 'Draining lymphatic congestion around the liver',
   'b',
   'The notes describe Dandelion as "liver-supportive (stimulates bile)."',
   'Dandelion (Taraxacum officinale) — Bitter, diuretic, liver-supportive (stimulates bile), mild digestive tonic, nutritive.',
   'Medicine of Spring', 290),

  -- 30 (c)
  ('BHC - Class 8 - Immune System I',
   'Chickweed is primarily used for which applications in these class notes?',
   'Immune stimulation and antiviral support', 'Hormone regulation and menstrual irregularity', 'Topical skin irritations and soothing mucous membranes', 'Diuretic and kidney support',
   'c',
   'The notes describe Chickweed as "Cooling, demulcent, anti-inflammatory; used topically for minor skin irritations; internally soothing to mucous membranes."',
   'Chickweed (Stellaria media) — Cooling, demulcent, anti-inflammatory; used topically for minor skin irritations; internally it is soothing to mucous membranes.',
   'Medicine of Spring', 300),

  -- 31 (d)
  ('BHC - Class 8 - Immune System I',
   'Plantain is described as excellent for which topical applications?',
   'Burns and sunburn', 'Athlete''s foot and nail infections', 'Joint pain and arthritis', 'Insect bites, minor wounds, and skin inflammation',
   'd',
   'The notes specify Plantain is "excellent topically for insect bites, minor wounds, and skin inflammation."',
   'Plantain (Plantago major / lanceolata) — excellent topically for insect bites, minor wounds, and skin inflammation.',
   'Medicine of Spring', 310),

  -- 32 (a)
  ('BHC - Class 8 - Immune System I',
   'Cleavers is described in the spring herbs section with what primary set of actions?',
   'Lymphatic, diuretic, vulnerary, nutritive, anti-inflammatory', 'Antifungal, antimicrobial, diaphoretic', 'Adaptogen, immunostimulant, expectorant', 'Demulcent, astringent, anticatarrhal',
   'a',
   'The notes describe Cleavers as "Lymphatic, diuretic, vulnerary, nutritive, anti-inflammatory, mild astringent."',
   'Cleavers (Galium aparine) Lymphatic, diuretic, vulnerary, nutritive, anti-inflammatory, mild astringent.',
   'Medicine of Spring', 320),

  -- 33 (b)
  ('BHC - Class 8 - Immune System I',
   'Violet is described in the spring herbs section with what lymphatic and throat-soothing qualities?',
   'Diaphoretic and immunostimulant', 'Cooling, moistening, lymphatic, mild expectorant, demulcent, soothing for sore throats', 'Antifungal, anticatarrhal, astringent', 'Adaptogen, tonic, nervine',
   'b',
   'The notes describe Violet as "Cooling, moistening, lymphatic, mild expectorant, demulcent and soothing for sore throats."',
   'Violet (Viola spp.) — Cooling, moistening, lymphatic, mild expectorant, demulcent and soothing for sore throats.',
   'Medicine of Spring', 330),

  -- 34 (c)
  ('BHC - Class 8 - Immune System I',
   'Cat''s Claw is categorized in these class notes under which immune herb group?',
   'Diaphoretics', 'Antifungals', 'Immune Amphoterics (Deep Nourishers)', 'Anticatarrhals',
   'c',
   'Cat''s Claw appears in the Immune Amphoterics section alongside Astragalus, Ashwagandha, Ginsengs, Licorice, and Schisandra.',
   'Cat''s Claw — immune amphoteric (deep nourisher).',
   'Immune Amphoterics', 340),

  -- 35 (d)
  ('BHC - Class 8 - Immune System I',
   'Ashwagandha is categorized in these class notes as a(n):',
   'Diaphoretic', 'Antiviral', 'Anticatarrhal', 'Immune amphoteric (deep nourisher)',
   'd',
   'Ashwagandha appears in the Immune Amphoterics section: balancing action on immune function.',
   'Ashwagandha — immune amphoteric (deep nourisher).',
   'Immune Amphoterics', 350),

  -- 36 (a)
  ('BHC - Class 8 - Immune System I',
   'Japanese Honeysuckle is categorized as what type of immune herb in these notes?',
   'Antiviral', 'Lymphatic', 'Diaphoretic', 'Anticatarrhal',
   'a',
   'Japanese Honeysuckle is listed under "Antivirals (Inhibit Viral Replication)."',
   'Japanese Honeysuckle — antiviral (inhibits viral replication).',
   'Antivirals', 360),

  -- 37 (b)
  ('BHC - Class 8 - Immune System I',
   'Isatis Root is listed in these class notes as a:',
   'Lymphatic', 'Antiviral', 'Diaphoretic', 'Antifungal',
   'b',
   'Isatis Root appears in the Antivirals section: "inhibits viral replication."',
   'Isatis Root — antiviral (inhibits viral replication).',
   'Antivirals', 370),

  -- 38 (c)
  ('BHC - Class 8 - Immune System I',
   'Lomatium is categorized in these notes as a(n):',
   'Adaptogen', 'Immunostimulant', 'Antiviral', 'Anticatarrhal',
   'c',
   'Lomatium is in the Antivirals section: inhibits viral replication.',
   'Lomatium — antiviral (inhibits viral replication).',
   'Antivirals', 380),

  -- 39 (d)
  ('BHC - Class 8 - Immune System I',
   'Osha is listed under which immune herb category in these class notes?',
   'Lymphatic', 'Diaphoretic', 'Antifungal', 'Antiviral',
   'd',
   'Osha is in the Antivirals section: "Antivirals (Inhibit Viral Replication)."',
   'Osha — antiviral (inhibits viral replication).',
   'Antivirals', 390),

  -- 40 (a)
  ('BHC - Class 8 - Immune System I',
   'What is the clinical rationale for using diaphoretic herbs noted in these class notes?',
   'Support the body''s natural fever response by promoting sweating', 'Directly kill viruses at the cellular level', 'Reduce immune over-reactivity in autoimmune conditions', 'Stimulate lymph circulation toward the heart',
   'a',
   'Diaphoretics promote sweating, which supports the body''s natural fever — a key immune response. The notes say "support the immune system in its natural healing capacity."',
   '#### Diaphoretics - promote sweating — Yarrow, Catnip, Elderflower, Dried Ginger, Boneset.',
   'Diaphoretics', 400),

  -- 41 (b)
  ('BHC - Class 8 - Immune System I',
   'Catnip is listed in these class notes as a:',
   'Lymphatic', 'Diaphoretic', 'Antifungal', 'Anticatarrhal',
   'b',
   'Catnip is in the Diaphoretics section: promotes sweating to support fever.',
   'Catnip — diaphoretic (promotes sweating).',
   'Diaphoretics', 410),

  -- 42 (c)
  ('BHC - Class 8 - Immune System I',
   'Elder flower (Elderflower) is categorized in these class notes as a:',
   'Immunostimulant only', 'Antiviral only', 'Diaphoretic', 'Antifungal',
   'c',
   'Elderflower appears in the Diaphoretics section. (Note: Elderberry is the immunostimulant/antiviral; Elderflower is the diaphoretic.)',
   'Elderflower — diaphoretic (promotes sweating to support fever).',
   'Diaphoretics', 420),

  -- 43 (d)
  ('BHC - Class 8 - Immune System I',
   'Calendula appears in two immune herb categories in these notes. Which two?',
   'Diaphoretic and anticatarrhal', 'Antiviral and adaptogen', 'Immunostimulant and anticatarrhal', 'Lymphatic and antifungal',
   'd',
   'Calendula is listed in both the Lymphatics section ("gentle, whole body") and the Antifungals section.',
   'Calendula - gentle, whole body lymphatic. Calendula — antifungal.',
   'Lymphatics', 430),

  -- 44 (a)
  ('BHC - Class 8 - Immune System I',
   'Usnea is listed under which immune herb category?',
   'Antifungal', 'Lymphatic', 'Diaphoretic', 'Immunostimulant',
   'a',
   'Usnea appears in the Antifungals section.',
   'Usnea — antifungal.',
   'Antifungals', 440),

  -- 45 (b)
  ('BHC - Class 8 - Immune System I',
   'Spilanthes is categorized as a(n):',
   'Diaphoretic', 'Antifungal', 'Adaptogen', 'Anticatarrhal',
   'b',
   'Spilanthes is listed in the Antifungals section.',
   'Spilanthes — antifungal.',
   'Antifungals', 450),

  -- 46 (c)
  ('BHC - Class 8 - Immune System I',
   'Barberry is antifungal due to which constituent?',
   'Silica', 'Tannins', 'Berberine', 'Allicin',
   'c',
   'The notes group Barberry under "Berberine containing plants" as antifungals.',
   'Berberine containing plants — Goldenseal, Oregon Grape, Barberry, Chinese Coptis.',
   'Antifungals', 460),

  -- 47 (d)
  ('BHC - Class 8 - Immune System I',
   'Black Walnut is listed under which immune herb category?',
   'Lymphatic', 'Diaphoretic', 'Antiviral', 'Antifungal',
   'd',
   'Black Walnut appears in the Antifungals section.',
   'Black Walnut — antifungal.',
   'Antifungals', 470),

  -- 48 (a)
  ('BHC - Class 8 - Immune System I',
   'Oregon Grape is classified as what type of herb in these class notes?',
   'Antifungal (berberine-containing)', 'Adaptogen', 'Diaphoretic', 'Immunostimulant',
   'a',
   'Oregon Grape is in the "Berberine containing plants" group under Antifungals.',
   'Oregon Grape — antifungal; berberine-containing plant.',
   'Antifungals', 480),

  -- 49 (b)
  ('BHC - Class 8 - Immune System I',
   'Cardamom is listed in these class notes as a(n):',
   'Adaptogen', 'Antifungal', 'Anticatarrhal', 'Diaphoretic',
   'b',
   'Cardamom appears in the Antifungals section.',
   'Cardamom — antifungal.',
   'Antifungals', 490),

  -- 50 (c)
  ('BHC - Class 8 - Immune System I',
   'Fresh chamomile prepared as a cold infusion is noted in these class notes to be:',
   'More sedative than the dried infusion', 'Ineffective unless combined with other herbs', 'Less sedative than the dried infusion', 'Only appropriate as a succus preparation',
   'c',
   'The afternoon guest instructor notes: fresh chamomile cold infusion is "less sedative than dried infusion."',
   'Fresh chamomile quick cold infusion — less sedative than dried infusion.',
   'Rose Intro (Guest Instructor)', 500);

END $$;
