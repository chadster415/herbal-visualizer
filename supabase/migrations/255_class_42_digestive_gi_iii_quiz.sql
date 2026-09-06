-- Migration 255: BHC Class 42 quiz — Digestive System III and Medicine-Making Review
-- class_name: 'BHC - Class 42 - Digestive System III and Medicine-Making Review'
-- 30 questions; guard by class_name

SET search_path TO herbal, public;

DO $$
DECLARE
  v_class CONSTANT TEXT := 'BHC - Class 42 - Digestive System III and Medicine-Making Review';

  -- Snippet anchors (verbatim from migration 254)
  v_sn_cramp_bark_const TEXT;
  v_sn_cramp_bark_dia   TEXT;
  v_sn_wild_yam_const   TEXT;
  v_sn_rhubarb_yd       TEXT;
  v_sn_cascara_senna    TEXT;
  v_sn_psyllium_gen     TEXT;
  v_sn_psyllium_per     TEXT;
  v_sn_astringents_gen  TEXT;
  v_sn_antispasm_gen    TEXT;
  v_sn_antispasm_per    TEXT;
  v_sn_immune_gen       TEXT;
  v_sn_chronic_gen      TEXT;
  v_sn_eucalyptus       TEXT;
  v_sn_stomach_warm     TEXT;
  v_sn_slippery_trio    TEXT;
  v_sn_blue_vervain     TEXT;
  v_sn_ocotillo         TEXT;
  v_sn_blackberry       TEXT;
  v_sn_sjw              TEXT;

BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_quiz_questions WHERE class_name = v_class) THEN
    RAISE NOTICE 'Class 42 quiz already loaded, skipping';
    RETURN;
  END IF;

  -- ── Snippet anchors ──────────────────────────────────────────────────────────

  v_sn_cramp_bark_const :=
    'GI Musculature (tone): cramp bark, wild yam = smooth muscle relaxants for constipation.';

  v_sn_cramp_bark_dia :=
    'Wild yam or cramp bark for severe antispasmodic support in diarrhea.';

  v_sn_wild_yam_const := v_sn_cramp_bark_const;

  v_sn_rhubarb_yd :=
    'Rhubarb root and yellow dock root as gentle, bitter laxatives for constipation.';

  v_sn_cascara_senna :=
    'Cascara sagrada or senna as last resort, potent laxatives for constipation.';

  v_sn_psyllium_gen :=
    'Psyllium requires plenty of water — lack of water causes issues; can become reliant on psyllium; '
    'not intended for lifelong use — aim for natural peristaltic urge.';

  v_sn_psyllium_per :=
    'Psyllium ok to shift patterns, but not a permanent strategy.';

  v_sn_astringents_gen :=
    'Astringents for tonifying tissues in diarrhea — includes Fagaceae family, raspberry root, '
    'yarrow, meadowsweet.';

  v_sn_antispasm_gen :=
    'Antispasmodic herbs for spasmodic state in diarrhea — fennel, catnip, chamomile, cinnamon, '
    'peppermint, ginger.';

  v_sn_antispasm_per :=
    'Antispasmodics for diarrhea: Fennel, Catnip, Chamomile, Cinnamon, Peppermint, Ginger.';

  v_sn_immune_gen :=
    'Immune support for microbial causes of diarrhea — Echinacea, baptisia, grape root.';

  v_sn_chronic_gen :=
    'Chronic immune support for diarrhea — reishi, astragalus.';

  v_sn_eucalyptus :=
    'Eucalyptus supports pelvic circulation and lymphatic flow; recommended for buildup of waste '
    'in large intestine causing sluggish immunity and lymph congestion.';

  v_sn_stomach_warm :=
    'Start with the warming carminatives — ginger for digestive warming and stimulation.';

  v_sn_slippery_trio :=
    'Slippery elm (marsh root) + burdock root + rhubarb — demulcent, nourishing, alterative, '
    'fiber (good gut impacts).';

  v_sn_blue_vervain :=
    'Bitters are fundamentally cooling to the system — blue vervain, gentler than gentian.';

  v_sn_ocotillo :=
    'Immune stimulation for constipation: if there is a buildup of waste in the LI that can '
    'stimulate lymph congestion = ocotillo.';

  v_sn_blackberry :=
    'Slow peristalsis for diarrhea: blackberry root (alongside bananas and bread).';

  v_sn_sjw :=
    'Nervines for diarrhea: as long as not contraindicated — SJW (St. John''s Wort).';

  -- ── 30 Questions ─────────────────────────────────────────────────────────────

  INSERT INTO herbal.class_quiz_questions
    (class_name, question_text, option_a, option_b, option_c, option_d,
     correct_option, explanation, snippet_text, section_header, sort_order)
  VALUES

  -- Q1 (correct: b)
  (v_class,
   'Which two herbs are described as smooth muscle relaxants specifically indicated for constipation?',
   'Fennel and catnip',
   'Cramp bark and wild yam',
   'Rhubarb and yellow dock',
   'Cascara sagrada and senna',
   'b',
   'The notes explicitly name cramp bark and wild yam as smooth muscle relaxants under GI Musculature support for constipation; the other pairs are laxatives, not smooth muscle relaxants.',
   v_sn_cramp_bark_const,
   'Constipation', 10),

  -- Q2 (correct: d)
  (v_class,
   'Rhubarb root and yellow dock root are classified as what type of laxative in these class notes?',
   'Potent laxatives — last resort',
   'Osmotic laxatives',
   'Bulk-forming laxatives',
   'Gentle, bitter laxatives',
   'd',
   'The notes describe rhubarb root and yellow dock root as "gentle, bitter laxatives" — contrasting them with cascara sagrada and senna which are the potent, last-resort laxatives.',
   v_sn_rhubarb_yd,
   'Supporting Night Shift Workers', 20),

  -- Q3 (correct: a)
  (v_class,
   'Cascara sagrada and senna are described in the notes as which type of laxative?',
   'Last resort, potent laxatives',
   'Gentle, bitter laxatives',
   'Bulk-forming laxatives',
   'Osmotic laxatives',
   'a',
   'The notes say "Cascara sagrada or senna as last resort, potent laxatives" — these are the strong option, reserved after gentler approaches like rhubarb and yellow dock.',
   v_sn_cascara_senna,
   'Supporting Night Shift Workers', 30),

  -- Q4 (correct: c)
  (v_class,
   'What is the key caution about psyllium use described in the generated notes?',
   'Should not be taken with fat-soluble herbs',
   'Contraindicated in SIBO',
   'Requires plenty of water; not intended for lifelong use',
   'Should be rotated with senna monthly',
   'c',
   'The notes state psyllium requires plenty of water and is "not intended for lifelong use — aim for natural peristaltic urge," meaning it is a transitional tool, not a permanent strategy.',
   v_sn_psyllium_gen,
   'Psyllium Use', 40),

  -- Q5 (correct: b)
  (v_class,
   'The personal notes describe psyllium as useful for what specific purpose?',
   'Long-term bowel regulation',
   'Shifting constipation patterns, but not a permanent strategy',
   'Treating infectious diarrhea',
   'Replacing dietary fiber permanently',
   'b',
   'The personal notes say "psyllium ok to shift patterns, but not a permanent strategy" — it is a short-term bridge while addressing underlying causes.',
   v_sn_psyllium_per,
   'Constipation', 50),

  -- Q6 (correct: d)
  (v_class,
   'Which three astringent herbs are listed in the generated notes for slowing peristalsis in diarrhea?',
   'Chamomile, cinnamon, and ginger',
   'Echinacea, yarrow, and meadowsweet',
   'Cascara, rhubarb, and blackberry',
   'Raspberry root, yarrow, and meadowsweet',
   'd',
   'The generated notes name "Fagaceae family, raspberry root, yarrow, meadowsweet" as the astringents for tonifying tissues; the Fagaceae reference appears to be a note error (Rubus is Rosaceae).',
   v_sn_astringents_gen,
   'Diarrhea Causes and Management', 60),

  -- Q7 (correct: c)
  (v_class,
   'Which six antispasmodic herbs are listed in the generated notes for spasmodic diarrhea?',
   'Valerian, passionflower, cramp bark, blue vervain, catnip, lavender',
   'Rhubarb, yellow dock, cascara, senna, psyllium, slippery elm',
   'Fennel, catnip, chamomile, cinnamon, peppermint, ginger',
   'Echinacea, baptisia, Oregon grape, reishi, astragalus, yarrow',
   'c',
   'The notes specifically name fennel, catnip, chamomile, cinnamon, peppermint, and ginger as the antispasmodics for spasmodic diarrhea state.',
   v_sn_antispasm_gen,
   'Diarrhea Causes and Management', 70),

  -- Q8 (correct: a)
  (v_class,
   'For severe or acute antispasmodic support in diarrhea, the generated notes recommend which two herbs?',
   'Wild yam or cramp bark',
   'Fennel or peppermint',
   'Cascara sagrada or senna',
   'Yarrow or meadowsweet',
   'a',
   'The notes say "Wild yam or cramp bark for severe cases" when antispasmodic support is needed in diarrhea — these are the stronger smooth muscle relaxants in the antispasmodic category.',
   v_sn_cramp_bark_dia,
   'Diarrhea Causes and Management', 80),

  -- Q9 (correct: b)
  (v_class,
   'Which three herbs are listed for immune support for microbial causes of diarrhea?',
   'Reishi, astragalus, and chamomile',
   'Echinacea, baptisia, and Oregon grape root',
   'Yarrow, meadowsweet, and raspberry',
   'Cascara, senna, and yellow dock',
   'b',
   'The notes specify "Echinacea, baptisia, grape root" for immune support for microbial causes; reishi and astragalus are listed separately as chronic support.',
   v_sn_immune_gen,
   'Diarrhea Causes and Management', 90),

  -- Q10 (correct: d)
  (v_class,
   'For chronic immune support in diarrhea, which two herbs are specifically named?',
   'Echinacea and baptisia',
   'Yarrow and meadowsweet',
   'Cramp bark and wild yam',
   'Reishi and astragalus',
   'd',
   'The notes distinguish "Chronic support with reishi, astragalus" as a separate category from the acute immune support herbs (Echinacea, baptisia, grape root).',
   v_sn_chronic_gen,
   'Diarrhea Causes and Management', 100),

  -- Q11 (correct: c)
  (v_class,
   'What does Eucalyptus support according to the generated notes on the pelvic floor?',
   'Antispasmodic bowel relief',
   'Bile stimulation in the liver',
   'Pelvic circulation and lymphatic flow',
   'Immune defense against GI infection',
   'c',
   'The generated notes state "Eucalyptus supports pelvic circulation and lymphatic flow" — it is specifically used when buildup of waste in the large intestine causes sluggish immunity and lymph congestion.',
   v_sn_eucalyptus,
   'Pelvic Floor and Immune Stimulation', 110),

  -- Q12 (correct: b)
  (v_class,
   'What is the starting approach for digestive treatment described in the personal notes under the Stomach section?',
   'Start with bitter herbs to stimulate bile',
   'Start with the warming carminatives',
   'Start with potent laxatives to clear congestion',
   'Start with astringents to tone the mucosa',
   'b',
   'The personal notes say "start with the warming carminatives" as the first approach — ginger, cinnamon, cardamom, and marshmallow/slippery elm — before moving to bitters or laxatives.',
   v_sn_stomach_warm,
   'Stomach', 120),

  -- Q13 (correct: a)
  (v_class,
   'The personal notes describe a three-herb combination for demulcent, nourishing, alterative, and fiber support. Which combination is it?',
   'Slippery elm (marsh root) + burdock root + rhubarb',
   'Marshmallow root + yellow dock + cascara',
   'Slippery elm + senna + fennel',
   'Licorice root + burdock + psyllium',
   'a',
   'The notes say "slippery elm (marsh root) + burdock root + rhubarb — demulcent, nourishing, alterative, fiber (good gut impacts)" as the nourishing trio.',
   v_sn_slippery_trio,
   'Stomach', 130),

  -- Q14 (correct: d)
  (v_class,
   'Blue vervain is described in the personal notes as what type of herb and how does it compare to gentian?',
   'A warming carminative, stronger than gentian',
   'An astringent, more drying than gentian',
   'An adaptogen, similar in strength to gentian',
   'A bitter, gentler than gentian',
   'd',
   'The notes say "bitters are fundamentally cooling to the system — blue vervain, gentler than gentian" — positioning it as a milder bitter option when gentian would be too strong or cold.',
   v_sn_blue_vervain,
   'Stomach', 140),

  -- Q15 (correct: c)
  (v_class,
   'Ocotillo is specifically indicated in the personal notes for which constipation-related mechanism?',
   'As a potent laxative for acute constipation',
   'As a smooth muscle relaxant to relieve cramping',
   'To stimulate immunity when waste buildup causes lymph congestion',
   'As a bulk-forming fiber to promote peristalsis',
   'c',
   'The notes say "Immune stimulation — if there is a buildup of waste in the LI that can stimulate lymph congestion = ocotillo" — it addresses the immune/lymphatic consequence of constipation, not the constipation directly.',
   v_sn_ocotillo,
   'Constipation', 150),

  -- Q16 (correct: a)
  (v_class,
   'The personal notes describe blackberry root as useful for which function in diarrhea management?',
   'Slowing peristalsis',
   'Immune support against microbial infection',
   'Antispasmodic relief for cramping',
   'Astringent toning of the mucosa',
   'a',
   'The personal notes list "blackberry root" under "slow peristalsis" — alongside bananas and bread — making it a first-line herb for reducing rapid bowel transit in diarrhea.',
   v_sn_blackberry,
   'Diarrhea', 160),

  -- Q17 (correct: b)
  (v_class,
   'What specific caution is noted for St. John''s Wort as a nervine for diarrhea?',
   'Avoid in patients with SIBO',
   'Use only when not contraindicated',
   'Limit to three days of use',
   'Contraindicated with astringent herbs',
   'b',
   'The personal notes say "Nervines — as long as not contraindicated: SJW" — acknowledging that St. John''s Wort has known drug interactions and contraindications that must be screened before use.',
   v_sn_sjw,
   'Diarrhea', 170),

  -- Q18 (correct: c)
  (v_class,
   'According to the personal notes, which herb category is listed first in the constipation herb strategy (before bitters and laxatives)?',
   'Astringents',
   'Immune stimulants',
   'Carminatives (nourishing)',
   'Smooth muscle relaxants',
   'c',
   'The constipation herb list order in the personal notes is: carminatives (nourishing) → demulcents (moistening) → bitters → laxatives. Carminatives are the first, gentlest intervention.',
   v_sn_cramp_bark_const,
   'Constipation', 180),

  -- Q19 (correct: d)
  (v_class,
   'Which warming carminative trio is described in the personal notes as the "first" approach for cold GI presentation?',
   'Ginger, gentian, and fennel',
   'Rhubarb, burdock, and ginger',
   'Cinnamon, rhubarb, and meadowsweet',
   'Marsh cold infusion + cinnamon + cardamom',
   'd',
   'The personal notes say "marsh cold infusion + cinnamon + cardamom first" as the initial warming carminative approach — marsh root (slippery elm) is used as a cold infusion to preserve the mucilage.',
   v_sn_stomach_warm,
   'Stomach', 190),

  -- Q20 (correct: b)
  (v_class,
   'In the generated notes, what two categories of herbs are recommended as the starting herbal approach for constipation in night shift workers?',
   'Bitters and laxatives',
   'Demulcents and carminatives',
   'Astringents and nervines',
   'Immune stimulants and adaptogens',
   'b',
   'The generated notes say "Herbals starting with demulcents and carminatives — nourishing and moistening the tissues" before moving to gentle laxatives like rhubarb and yellow dock.',
   v_sn_rhubarb_yd,
   'Supporting Night Shift Workers', 200),

  -- Q21 (correct: a)
  (v_class,
   'The personal notes link disrupted circadian rhythm to which primary GI consequence?',
   'Disrupted bowel and constipation',
   'Elevated histamine and food sensitivity',
   'Reduced bile production',
   'SIBO through microbiome dysbiosis',
   'a',
   'The constipation notes state "lack of sleep can really impact digestion" — and the generated neurodigestive section makes the circadian rhythm/disrupted bowel connection explicit.',
   v_sn_cramp_bark_const,
   'Constipation', 210),

  -- Q22 (correct: c)
  (v_class,
   'Oregon Grape Root is listed in the generated notes for immune support in diarrhea under which name?',
   'Berberis root',
   'Barberry',
   'Grape root',
   'Mahonia',
   'c',
   'The generated notes name it "grape root" within "Echinacea, baptisia, grape root" for microbial diarrhea immune support — normalized to Oregon Grape (Mahonia aquifolium) in the migration.',
   v_sn_immune_gen,
   'Diarrhea Causes and Management', 220),

  -- Q23 (correct: b)
  (v_class,
   'Which herb family is named in the personal notes as astringents for diarrhea, alongside yarrow and meadowsweet?',
   'Asteraceae family',
   'Rubus family',
   'Lamiaceae family',
   'Apiaceae family',
   'b',
   'The personal notes list "Astringents: Rubus family, Yarrow, Meadowsweet" — the Rubus genus (blackberry, raspberry) provides astringent tannins for slowing rapid bowel transit.',
   v_sn_astringents_gen,
   'Diarrhea', 230),

  -- Q24 (correct: d)
  (v_class,
   'Slippery elm is referred to by what alternative name in the personal notes?',
   'Marsh flower',
   'Marsh herb',
   'Slick elm',
   'Marsh root',
   'd',
   'The personal notes parenthetically identify slippery elm as "marsh root" in the phrase "slippery elm (marsh root)" — distinguishing it from marsh mallow (Althaea officinalis).',
   v_sn_slippery_trio,
   'Stomach', 240),

  -- Q25 (correct: a)
  (v_class,
   'What three qualities does burdock root contribute in the demulcent constipation formula (slippery elm + burdock + rhubarb)?',
   'Nourishing, alterative, and fiber (gut microbiome support)',
   'Astringent, antimicrobial, and diuretic',
   'Warming, carminative, and cholagogue',
   'Adaptogenic, hepatoprotective, and anti-inflammatory',
   'a',
   'The notes say the trio is "demulcent, nourishing, alterative, fiber (good gut impacts)" — slippery elm provides demulcent, rhubarb the laxative bitter, and burdock the nourishing/alterative/fiber quality.',
   v_sn_slippery_trio,
   'Stomach', 250),

  -- Q26 (correct: c)
  (v_class,
   'The generated notes connect buildup of waste in the large intestine to which two systemic effects?',
   'Elevated histamine and food sensitivity',
   'Reduced bile and gallbladder congestion',
   'Sluggish immunity and lymph congestion',
   'Adrenal fatigue and hormone dysregulation',
   'c',
   'The generated notes say "Buildup of waste in large intestine leads to sluggish immunity" and the pelvic lymphatic section ties this to lymph congestion — both Eucalyptus and Ocotillo address this.',
   v_sn_eucalyptus,
   'Pelvic Floor and Immune Stimulation', 260),

  -- Q27 (correct: b)
  (v_class,
   'Which two herbs are noted as gentle laxatives that are also described as "bitter" in character?',
   'Cascara sagrada and senna',
   'Rhubarb root and yellow dock root',
   'Blue vervain and gentian',
   'Cramp bark and wild yam',
   'b',
   'The notes describe rhubarb and yellow dock as "gentle, bitter laxatives" — they stimulate bowel via bitter action, unlike cascara/senna which work through anthraquinone irritation.',
   v_sn_rhubarb_yd,
   'Supporting Night Shift Workers', 270),

  -- Q28 (correct: d)
  (v_class,
   'Which of the following is NOT listed as an antispasmodic for diarrhea in the personal notes?',
   'Catnip',
   'Chamomile',
   'Peppermint',
   'Yarrow',
   'd',
   'Yarrow is listed as an astringent, not an antispasmodic. The antispasmodics named are: Fennel, Catnip, Chamomile, Cinnamon, Peppermint, and Ginger.',
   v_sn_antispasm_per,
   'Diarrhea', 280),

  -- Q29 (correct: a)
  (v_class,
   'What is the primary clinical reason the notes give for starting constipation treatment with carminatives before moving to bitters or laxatives?',
   'Carminatives are nourishing and warming — appropriate for a cold, deficient GI presentation',
   'Carminatives prevent dependence on laxatives',
   'Carminatives increase bile production which drives peristalsis',
   'Carminatives reduce SIBO before laxatives are used',
   'a',
   'The personal notes pair "carminatives — nourishing" with the warming GI approach; starting warm and nourishing respects the cold-deficient state that commonly underlies constipation before introducing the cooling bitters.',
   v_sn_stomach_warm,
   'Stomach', 290),

  -- Q30 (correct: c)
  (v_class,
   'Which herb is specifically noted in the personal notes as the nervine for diarrhea, with a caveat about its use?',
   'Chamomile — avoid with bile disorders',
   'Catnip — avoid with renal disease',
   'St. John''s Wort — use only when not contraindicated',
   'Cramp bark — avoid with pregnancy',
   'c',
   'The personal notes list "Nervines — as long as not contraindicated: SJW" for diarrhea — St. John''s Wort is the specific nervine named, with the caveat reflecting its significant drug interaction profile.',
   v_sn_sjw,
   'Diarrhea', 300)

  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Class 42 quiz: 30 questions loaded.';
END $$;
