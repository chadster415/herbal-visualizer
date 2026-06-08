-- Migration 060: Add body_system_notes table and populate from system .md files.
-- Stores the top-level # Notes / ## Notes section from each system file,
-- which sits above any specific disorder and describes the system as a whole.

SET search_path TO herbal, public;

-- ============================================================
-- BLOCK 1: Create table
-- ============================================================
CREATE TABLE IF NOT EXISTS herbal.body_system_notes (
  id             SERIAL PRIMARY KEY,
  body_system_id INTEGER NOT NULL REFERENCES herbal.body_systems(id) ON DELETE CASCADE,
  note_text      TEXT NOT NULL,
  sort_order     INTEGER NOT NULL DEFAULT 0,
  UNIQUE (body_system_id, sort_order)
);

CREATE INDEX IF NOT EXISTS idx_body_system_notes_system
  ON herbal.body_system_notes(body_system_id);

GRANT ALL ON herbal.body_system_notes TO postgres, anon, authenticated, service_role;
GRANT ALL ON herbal.body_system_notes_id_seq TO postgres, anon, authenticated, service_role;

COMMENT ON TABLE herbal.body_system_notes IS
  'System-level introductory notes from BHC source files (the # Notes section above any specific disorder).';


-- ============================================================
-- BLOCK 2: Aging (9 notes)
-- ============================================================
DO $$
DECLARE v_id INTEGER;
BEGIN
  SELECT id INTO v_id FROM herbal.body_systems WHERE name = 'Aging';
  INSERT INTO herbal.body_system_notes (body_system_id, note_text, sort_order) VALUES
    (v_id, 'Theories have been proposed that suggest that aging is related to problems with stability of DNA over time, and with the transcription of information from the chromosomal DNA to RNA. In fact, there is a different theory for each phase of the process. For those who are interested, the most relevant ideas are known as the error theory, the redundant message theory, the transcription theory, and the programmed theory.', 10),
    (v_id, 'Free radicals are a normal but short-lived aspect of metabolism. The core problem is peroxidation of fats, which damages membranes in the body.', 20),
    (v_id, 'The question is whether free radical production is the fundamental cause of aging or simply an ancillary phenomenon that exacerbates age-related changes due to some other cause.', 30),
    (v_id, 'Age is not a disease. Death is not an evil to be avoided at all costs. Our culture has developed some distorted perceptions about old age, seeing it as the undesirable mirror image of youth. This blinkered perception ignores the incredible value of wisdom and experience. It denies our elders a voice and disregards the valuable contributions they have to offer.', 40),
    (v_id, 'Issues such as isolation and poverty that manifest in cardiovascular disease will not be helped by hawthorn.', 50),
    (v_id, 'Perhaps the most outstanding contribution that herbs can make to the health of elders is through system tonics, for the maintenance of wellness and the prevention of many problems associated with aging.', 60),
    (v_id, 'With very elderly people, it is not unusual for a medicine to have an effect that is opposite of what is expected.', 70),
    (v_id, 'Elders have special needs, and plants can address these needs. Whenever possible, the focus should be on tonics and normalizers.', 80),
    (v_id, 'A general rule of thumb is to use a lower dosage for elders than for younger adults. Such concerns do not arise if prescriptions emphasize tonics.', 90)
  ON CONFLICT (body_system_id, sort_order) DO NOTHING;
  RAISE NOTICE 'Aging system notes inserted.';
END $$;


-- ============================================================
-- BLOCK 3: Cardiovascular (15 notes)
-- ============================================================
DO $$
DECLARE v_id INTEGER;
BEGIN
  SELECT id INTO v_id FROM herbal.body_systems WHERE name = 'Cardiovascular';
  INSERT INTO herbal.body_system_notes (body_system_id, note_text, sort_order) VALUES
    (v_id, 'Plants containing cardiac glycosides are used throughout the world to treat heart failure and certain cases of cardiac arrhythmia.', 10),
    (v_id, 'The real value of these herbs lies in their ability to increase the efficiency of the heart without increasing the heart muscle''s need for oxygen.', 20),
    (v_id, 'Half of the annual mortality in America results from heart and blood vessel diseases.', 30),
    (v_id, 'Herbal tonics can contribute by offering real possibilities for the practice of preventive medicine.', 40),
    (v_id, 'An increasing amount of research is investigating the cardiovascular effects of plant constituents. As fascinating as this is, the benefits of such research accrue to the pharmaceutical industry, as the information is rarely about the plant from which the constituent has been extracted. It would prove almost impossible to develop herbal approaches to treatment if natural product research was the sole source of information.', 50),
    (v_id, 'Cardioactive herbs owe their effects on the heart to highly active substances, such as cardiac glycosides, and thus have both the strengths and the drawbacks of these powerful constituents. Cardiotonics have a beneficial action on the heart and blood vessels, but do not contain cardiac glycosides.', 60),
    (v_id, 'Blood vessel or vascular tonics are often rich in constituents called flavonoids. These remarkable herbs include Crataegus spp., Allium sativum, Tilia platyphyllos, and Ginkgo biloba.', 70),
    (v_id, 'In addition to the heart tonics, a number of other herbal actions can be helpful. Especially important are the relaxing herbs, such as Leonurus cardiaca (motherwort), Scutellaria lateriflora (skullcap), and Valeriana officinalis (valerian). Circulatory stimulants, such as Capsicum annuum (cayenne), Zingiber officinale (ginger), and Zanthoxylum americanum (prickly ash), increase blood flow, supporting oxygenation of tissue and the elimination of waste. This makes them important in circulatory problems.', 80),
    (v_id, 'The major risk factors for cardiovascular disease that can be altered are cigarette smoking, high blood pressure, high cholesterol, obesity, and physical inactivity.', 90),
    (v_id, 'The more risk factors a person has, the more likely he or she is to develop cardiovascular disease.', 100),
    (v_id, 'The development of heart disease is definitely linked with excess dietary fat, elevated blood cholesterol levels, high blood pressure, smoking, obesity, short stature, and physical inactivity.', 110),
    (v_id, 'High blood cholesterol is another very important risk factor for coronary heart disease that may be amenable to change. Some cholesterol is obtained from the diet (about 2%) and the rest is manufactured by the liver.', 120),
    (v_id, 'The basic dietary rules for lowering cholesterol and maintaining heart health are simple: Avoid saturated fats and dietary cholesterol. Experts recommend a diet that derives not more than 30% of daily calories from fat, some say 20%.', 130),
    (v_id, 'The severity of heart disease correlates with the severity of CoQ10 deficiency.', 140),
    (v_id, 'High blood levels of homocysteine may increase the chances of developing heart disease, stroke, and circulation problems. Elevated levels are believed to damage arteries, predispose the blood to easy clotting, and reduce the flexibility of blood vessels.', 150)
  ON CONFLICT (body_system_id, sort_order) DO NOTHING;
  RAISE NOTICE 'Cardiovascular system notes inserted.';
END $$;


-- ============================================================
-- BLOCK 4: Nervous (13 notes)
-- ============================================================
DO $$
DECLARE v_id INTEGER;
BEGIN
  SELECT id INTO v_id FROM herbal.body_systems WHERE name = 'Nervous';
  INSERT INTO herbal.body_system_notes (body_system_id, note_text, sort_order) VALUES
    (v_id, 'The complexities of the mind-body interface, so challenging to doctors concerned with psychosomatic medicine, become an aid to remedy selection for the herbalist.', 10),
    (v_id, 'All of the many herbal nervines have an impact on both somatic symptoms and the mind.', 20),
    (v_id, 'Therefore, if there is disease on the psychological level, it will be reflected on the physiological level, and vice versa.', 30),
    (v_id, 'THE NERVOUS SYSTEM AND HERBAL REMEDIES: Herbs can benefit the nervous system in a number of ways, in addition to the rather simplistic effects of stimulation and relaxation.', 40),
    (v_id, 'Today, Western herbalism commonly recognizes three major categories of herbs that act on the nervous system, collectively called nervines. These are nervine tonics, nervine relaxants, and nervine stimulants. Other important categories of nervines include hypnotics, analgesics, antispasmodics, antidepressants, and adaptogens.', 50),
    (v_id, 'ANXIETY AS A RESPONSE TO STRESS: For some people, anxiety takes the form of recurrent attacks, which begin with a sudden, intense apprehension, often combined with a feeling of impending doom and sometimes with feelings of unreality. An anticipatory fear of loss of control often develops, so that the person may become afraid, for example, of being left alone in public places.', 60),
    (v_id, 'When people are seen as whole beings, not simply as "bodies with minds on top," it should come as no surprise to find a deep association between psychology and physiology.', 70),
    (v_id, 'In reality, a human is a single whole being that cannot be separated into parts like mind and body.', 80),
    (v_id, 'Relaxation is a skill that must be relearned and practiced.', 90),
    (v_id, 'Physiological findings indicated that nature settings produced significant recovery from stress in only four to six minutes.', 100),
    (v_id, 'THE ROLE OF ADAPTOGENS: Even if we have found a remedy that seems to offer an increased resistance to toxic drugs, it is always preferable to remove the toxic chemical.', 110),
    (v_id, 'Adaptogens reinforce the nonspecific power of the body''s resistance against stressors, increase its general capacity to withstand stressful situations, and hence guard against disease caused by overstressing the organism.', 120),
    (v_id, 'If periods of stress in a person''s life can be predicted, nervine relaxants can be used regularly as gentle, soothing remedies.', 130)
  ON CONFLICT (body_system_id, sort_order) DO NOTHING;
  RAISE NOTICE 'Nervous system notes inserted.';
END $$;


-- ============================================================
-- BLOCK 5: Lower Respiratory + Upper Respiratory (33 notes each)
-- Notes from "The Lower Respiratory System" file cover both systems.
-- ============================================================
DO $$
DECLARE
  v_lower_id INTEGER;
  v_upper_id INTEGER;
  notes TEXT[] := ARRAY[
    'The lungs sit within the thoracic cage, where they stretch from the trachea (commonly called the windpipe) to below the heart.',
    'About 10% of the lung is solid tissue and the rest is filled with air and blood.',
    'The lungs'' main function is to rapidly exchange oxygen from inhaled air with carbon dioxide from the blood',
    'The two main bronchi extend from the trachea into each lung, where they divide into smaller bronchi, and then a great number of smaller bronchioles. The bronchioles divide into a network of about 3 million alveolar ducts containing alveoli, commonly called air sacs.',
    'Specific nerve sites located in the brain and the neck, called respi vatory centers, coordinate the performance of the ventila-tory apparatus. The respiratory centers respond to changes in oxygen, carbon dioxide, and acid levels in the blood.',
    'Gas exchange between inhaled air and blood takes place in the alveoli. A very thin membrane separates the blood from the air in the alveoli and allows oxygen and nitrogen to diffuse into the blood. This barrier is 50 times thinner than a sheet of tissue paper, but a large surface area (80 square meters, or about as large as a tennis court) is available for gas exchange. In the resting state, it takes just about a minute for the total blood volume of the body to pass through the lungs. It takes a red cell a fraction of a second to pass through the capillary network. Gas exchange occurs almost instantaneously during this short time period',
    'We are not only what we eat, but also what we breathe.',
    'Many pathological tissue changes can be prevented if the environmental milieu of the cells is constantly rich in oxygen.',
    'Air pollution in the country may be caused by dust from tractors plowing fields, trucks and cars driving on dirt or gravel roads, and rock quarries, as well as by smoke from wood and crop fires.',
    'Ground-level ozone is created when engine and fuel gases that have already been released into the air interact in the presence of sunlight.',
    'Ozone irritates the respiratory tract and eyes, and exposure to high levels results in chest tightness, coughing, and wheezing.',
    'For every eight smokers, one nonsmoker dies from the effects of secondhand smoke.',
    'Smoking is responsible for 32% of deaths due to cancer.',
    'Smoking causes nearly 90% of all lung and throat cancers.',
    'Alcohol is also a risk factor for some cancers, and the combination of alcohol and smoking greatly increases cancer risk.',
    'Smoking decreases the strength of the sphincter muscle between the throat and stomach, which allows stomach contents to reflux, or flow backward, into the esophagus.',
    'Smoking seems to affect the liver, too, by changing the way it handles drugs and alcohol.',
    'Peptic ulcer disease is more likely to occur in smokers than in nonsmokers, and ulcers heal less readily and are more likely to recur in smokers.',
    'Smoking has a direct effect on the growth of the fetus.',
    'Natural menopause occurs earlier in smokers than in nonsmokers by one to two years.',
    'Cigarettes and oral contraceptives are a dangerous combination that increases the risk of heart attacks, strokes, and other vascular complications.',
    'A decrease of blood flow in the small vessels of the skin that may damage skin components, leading to skin wrinkling and an appearance of premature aging.',
    'The respiratory zone, the actual site of gas exchange, is composed of the respiratory bronchioles, alveolar ducts, and alveoli. The conducting zone, sometimes called the dead air space, includes all other respiratory passageways, which serve as fairly rigid conduits to allow air to reach the gas exchange sites. The conducting zone organs also purify, humidify, and warm the incoming air.',
    'The lower respiratory system consists of the respiratory zone, the alveoli, and respiratory bronchioles. The air-conducting bronchi and trachea are anatomically part of this system. The upper respiratory system consists of the conducting zone, made up of the nose, sinuses, pharynx, and larynx.',
    'Expectorants are herbs that facilitate or accelerate the removal of bronchial secretions from the bronchi and trachea.',
    'Stimulating Expectorants: For any given stimulating expectorant, either or both of the following mechanisms may be at play. Irritation of the bronchioles stimulates the expulsion of any material present. Liquefaction of viscid sputum encourages clearing by coughing.',
    'The particular form of stimulation offered by this group of expectorants makes them relevant for productive coughs, in which sputum should be removed from the airways.',
    'Relaxing expectorants may also act by reflex, but here the herbs work to soothe bronchial spasm and loosen mucous secretions.',
    'They facilitate the production of a less viscous mucous secretion, which helps lift up stickier material from below. This makes relaxing expectorants useful for dry, irritating coughs. You will notice that this action is similar in some respects to that of demulcents, and both actions owe a lot to their content of mucilage and occasionally volatile oils.',
    'Herbs known as pulmonaries, or amphoteric expectorants, have a beneficial effect upon both lung tissue and function.',
    'We can generalize here that Inula has stimulant expectorant effects and Verbascum is more of a relaxing expectorant. Tussilago is the best of the three for children.',
    'To avoid any potential toxicity problems, leaf and flower formulations of Tussilago should not be taken for more than one consecutive month, and root products should not be used internally.',
    'Dyspnea, defined as an unpleasant sensation of difficulty in breathing.'
  ];
  i INTEGER;
BEGIN
  SELECT id INTO v_lower_id FROM herbal.body_systems WHERE name = 'Lower Respiratory';
  SELECT id INTO v_upper_id FROM herbal.body_systems WHERE name = 'Upper Respiratory';

  FOR i IN 1..array_length(notes, 1) LOOP
    INSERT INTO herbal.body_system_notes (body_system_id, note_text, sort_order)
      VALUES (v_lower_id, notes[i], i * 10)
      ON CONFLICT (body_system_id, sort_order) DO NOTHING;
    INSERT INTO herbal.body_system_notes (body_system_id, note_text, sort_order)
      VALUES (v_upper_id, notes[i], i * 10)
      ON CONFLICT (body_system_id, sort_order) DO NOTHING;
  END LOOP;

  RAISE NOTICE 'Lower/Upper Respiratory system notes inserted.';
END $$;


-- ============================================================
-- BLOCK 6: Reproductive - Female (7 notes)
-- ============================================================
DO $$
DECLARE v_id INTEGER;
BEGIN
  SELECT id INTO v_id FROM herbal.body_systems WHERE name = 'Reproductive - Female';
  INSERT INTO herbal.body_system_notes (body_system_id, note_text, sort_order) VALUES
    (v_id, 'Remember that all bitters will have an emmenagogue effect in the strict sense of the word - that is, they will help improve menstrual function and flow.', 10),
    (v_id, 'Uterine Tonics - These plants have a toning, strengthening, nourishing effect on both the tissue and the function of the female reproductive system.', 20),
    (v_id, 'Of the emmenagogues listed previously, some work through bitter stimulation and others through localized irritation. Herbs that also nourish the system to some degree include Achillea millefolium (yarrow), Artemisia vulgaris (mugwort), and Mitchella repens (partridgeberry).', 30),
    (v_id, 'Hormonal Normalizers - A number of plants have a direct impact upon levels of hormones in the body. The herbalist tends to refer to them in terms of hormonal modulators or normalizers.', 40),
    (v_id, 'Uterine Astringents - An abundance of herbs reduce blood loss from the uterus, whether due to excessively heavy periods (menorrhagia), bleeding between periods (metrorrhagia), or organic disease, such as fibroids.', 50),
    (v_id, 'Uterine Demulcents - There is no way that mucopolysaccharides find their way to the uterus from the digestive process; nonetheless, there is no question that these remedies soothe inflamed tissue.', 60),
    (v_id, 'Nervines and Antispasmodics - By using the appropriate nervine or antispasmodic, much can be achieved in terms of correcting functional tone.', 70)
  ON CONFLICT (body_system_id, sort_order) DO NOTHING;
  RAISE NOTICE 'Reproductive - Female system notes inserted.';
END $$;


-- Summary
SELECT bs.name, COUNT(n.id) AS note_count
FROM herbal.body_system_notes n
JOIN herbal.body_systems bs ON bs.id = n.body_system_id
GROUP BY bs.name
ORDER BY bs.name;
