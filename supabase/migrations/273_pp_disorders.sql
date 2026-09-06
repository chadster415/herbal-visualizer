-- PP disorders: infer from herb_source_notes individual_indications text.
-- Creates new disorders where needed, then links herbs via disorder_specific_remedies
-- with source_id=1 (priest_priest). Safe to re-run (ON CONFLICT DO NOTHING).

SET search_path TO herbal, public;

-- ============================================================
-- 1. New disorders not previously in the DB
-- ============================================================
INSERT INTO herbal.disorders (name, body_system_id) VALUES
  ('Enuresis',           12),  -- Urinary
  ('Leucorrhoea',        24),  -- Reproductive - Female
  ('Urethritis',         12),  -- Urinary
  ('Neurasthenia',       15),  -- Nervous
  ('Chorea',             15),  -- Nervous
  ('Palpitations',        9),  -- Cardiovascular
  ('Sciatica',           14),  -- Musculoskeletal
  ('Neuralgia',          15),  -- Nervous
  ('Pleurisy',           18),  -- Respiratory - Lower
  ('Epistaxis',          21),  -- All
  ('Menorrhagia',        24),  -- Reproductive - Female
  ('Endometritis',       24),  -- Reproductive - Female
  ('Intestinal Parasites',11), -- Digestive
  ('Skin Eruptions',     16),  -- Skin
  ('Night Sweats',       21),  -- All
  ('Anaemia',            21),  -- All
  ('Ophthalmia',         21),  -- All
  ('Lumbago',            14),  -- Musculoskeletal
  ('Enlarged Thyroid',   33),  -- Endocrine
  ('Mastitis',           24),  -- Reproductive - Female
  ('Spermatorrhoea',     25),  -- Reproductive - Male
  ('Hysteria',           15),  -- Nervous
  ('Uterine Prolapse',   24),  -- Reproductive - Female
  ('Dysentery',          11),  -- Digestive
  ('Vertigo',            15)   -- Nervous
ON CONFLICT (name, body_system_id) DO NOTHING;

-- ============================================================
-- 2. disorder_specific_remedies from PP individual_indications
--    Joined against disorders by (name, body_system_id) so no
--    hardcoded IDs. ON CONFLICT skips if already linked.
-- ============================================================
INSERT INTO herbal.disorder_specific_remedies (herb_id, disorder_id, description, source_id)
SELECT v.herb_id, d.id, v.description, 1
FROM (VALUES
  -- Agrimony (148)
  (148,'Liver Disease',11,'General alimentary weakness, murmurs, hepatic atrophy.'),
  (148,'Enuresis',12,'Enuresis (atonic), relaxed bowel, leucorrhoea (relaxed states); urinary incontinence.'),
  (148,'Rheumatoid Arthritis',14,'Rheumatism and arthritis.'),
  -- Aspen (86)
  (86,'Functional Dyspepsia',11,'Dyspepsia, flatulence (debility).'),
  (86,'Uterine Prolapse',24,'Uterine, vaginal, and weakness.'),
  (86,'Dysentery',11,'Diarrhoea, dysentery (atonic).'),
  (86,'Cystitis',12,'Catarrh of the bladder.'),
  -- Balmony (171)
  (171,'Liver Disease',11,'Atonic conditions, malaise and debility, convalescence.'),
  (171,'Functional Dyspepsia',11,'Dyspepsia, mal-assimilation.'),
  (171,'Intestinal Parasites',11,'Round and thread worms.'),
  (171,'Ulcerative Colitis',11,'Colitis from hepatic dysfunction.'),
  (171,'Jaundice',11,'Chronic jaundice.'),
  -- Barberry (158)
  (158,'Jaundice',11,'Biliary catarrh with constipation and jaundice.'),
  (158,'Gastritis',11,'Gastritis, biliousness.'),
  (158,'Liver Disease',11,'Debility in convalescence.'),
  (158,'Aphthous Ulcers',11,'Ulcerative stomatitis.'),
  (158,'Eczema',16,'Eczema of the hands.'),
  -- Bayberry (119)
  (119,'Colds',17,'Colds and acute febrile reactions.'),
  (119,'Swollen Glands',17,'Scrofulous, tuberculous tendency.'),
  (119,'Bronchitis',18,'Pulmonary catarrh with cough.'),
  (119,'Hemorrhoids',11,'Haemorrhoids.'),
  (119,'Leucorrhoea',24,'Leucorrhoea, atonic mucosa.'),
  (119,'Gastritis',11,'Gastro-intestinal catarrh.'),
  (119,'Sinusitis',19,'Nasal polyp.'),
  -- Bearberry (46)
  (46,'Cystitis',12,'Chronic vesical irritation with pain and catarrhal discharge; cystitis, haematuria.'),
  (46,'Urethritis',12,'Chronic urethritis.'),
  (46,'Hematuria',12,'Cystitis, haematuria.'),
  (46,'Leucorrhoea',24,'Atonic leucorrhoea, profuse menstruation, uterine prolapse.'),
  (46,'Uterine Prolapse',24,'Rectal prolapse, vaginal laxity.'),
  -- Black Cohosh (25)
  (25,'Myalgia',14,'Muscular and crampy pains, general spasticity, flatulence.'),
  (25,'Pertussis',18,'Pertussis, asthma, chorea.'),
  (25,'Asthma',18,'Pertussis, asthma, chorea.'),
  (25,'Chorea',15,'Pertussis, asthma, chorea.'),
  (25,'Rheumatoid Arthritis',14,'Rheumatism, sciatica, neuralgia, rheumatoid arthritis.'),
  (25,'Sciatica',14,'Rheumatism, sciatica, neuralgia, rheumatoid arthritis.'),
  (25,'Neuralgia',15,'Rheumatism, sciatica, neuralgia, rheumatoid arthritis.'),
  (25,'Dysmenorrhea',24,'Atonic uterus, ovarian neuralgia, leucorrhoea, dysmenorrhoea.'),
  (25,'Leucorrhoea',24,'Atonic uterus, ovarian neuralgia, leucorrhoea, dysmenorrhoea.'),
  (25,'Tinnitus',15,'Tinnitis aurium.'),
  -- Black Haw (94)
  (94,'Uterine Prolapse',24,'Uterine prolapse, vaginal laxity.'),
  (94,'Amenorrhea',24,'Atonic amenorrhoea; passive/menopausal amenorrhoea.'),
  (94,'Pregnancy - First Trimester - Morning Sickness',24,'Morning sickness, false labour pains, threatened abortion.'),
  (94,'Pregnancy - First Trimester - Threatened Miscarriage',24,'Morning sickness, false labour pains, threatened abortion.'),
  (94,'Pregnancy - Postpartum - General',24,'Excessive lochial discharge.'),
  -- Black Root (175)
  (175,'Chronic Hepatitis',11,'Hepatitis, cholecystitis.'),
  (175,'Cholecystitis',11,'Hepatitis, cholecystitis.'),
  (175,'Liver Disease',11,'Chronic hepatic torpor.'),
  (175,'Jaundice',11,'Non-obstructive jaundice.'),
  (175,'Fevers',17,'Febrile states (to clear bowel).'),
  (175,'Hemorrhoids',11,'Rectal prolapse/haemorrhoids.'),
  (175,'Skin Eruptions',16,'Skin eruptions.'),
  -- Blue Cohosh (72)
  (72,'Endometritis',24,'Metritis, endometritis, dysmenorrhoea.'),
  (72,'Dysmenorrhea',24,'Metritis, endometritis, dysmenorrhoea.'),
  (72,'Urethritis',12,'Urethritis, vaginitis, thrush.'),
  (72,'Vaginitis',17,'Urethritis, vaginitis, thrush.'),
  (72,'Pregnancy - General Issues',24,'Restlessness during pregnancy.'),
  (72,'Menopausal Complaints',24,'Menopausal pains and dysmenorrhoea.'),
  (72,'Pregnancy - Postpartum - General',24,'Uterine sub-involution.'),
  -- Blue Flag (31)
  (31,'Liver Disease',11,'Chronic hepatic and rheumatic conditions, toxic sciatica.'),
  (31,'Rheumatoid Arthritis',14,'Chronic hepatic and rheumatic conditions, toxic sciatica.'),
  (31,'Sciatica',14,'Chronic hepatic and rheumatic conditions, toxic sciatica.'),
  (31,'Eczema',16,'Scrofulous skin conditions, herpes, eczema, psoriasis.'),
  (31,'Psoriasis',16,'Scrofulous skin conditions, herpes, eczema, psoriasis.'),
  (31,'Enlarged Thyroid',33,'Enlarged thyroid gland.'),
  (31,'Uterine Fibroids',24,'Uterine fibroids.'),
  -- Boneset (50)
  (50,'Influenza',19,'Influenza, colds and fevers with night sweats and aching bones.'),
  (50,'Night Sweats',21,'Influenza, colds and fevers with night sweats and aching bones.'),
  (50,'Bronchitis',18,'Pulmonary inflammation/catarrh with cough and chest soreness.'),
  (50,'Cough',18,'Pulmonary inflammation/catarrh with cough and chest soreness.'),
  (50,'Gastritis',11,'Post-influenzal gastric irritation with biliousness/constipation.'),
  (50,'Constipation',11,'Post-influenzal gastric irritation with biliousness/constipation.'),
  (50,'Skin Eruptions',16,'Skin diseases and eruptive fevers of hepatic origin.'),
  -- Buchu (181)
  (181,'Edema',12,'Dropsical conditions, gravel.'),
  (181,'Urinary Calculus',12,'Dropsical conditions, gravel.'),
  (181,'Cystitis',12,'Chronic atonic conditions of the urinary tract.'),
  (181,'Urethritis',12,'Mucopurulent discharge, gleet, cystitis, urethritis.'),
  -- Bugleweed (133)
  (133,'Chronic Bronchitis',18,'Phthisis with free expectoration.'),
  (133,'Epistaxis',21,'Passive haemorrhages: epistaxis, haemoptysis.'),
  (133,'Arteriosclerosis',9,'Chronic circulatory insufficiency.'),
  (133,'Hyperthyroidism',33,'Hyperthyroid conditions, nervous tachycardia and palpitation.'),
  (133,'Palpitations',9,'Hyperthyroid conditions, nervous tachycardia and palpitation.'),
  -- Burdock (22)
  (22,'Eczema',16,'Eczema, psoriasis, dermatitis.'),
  (22,'Psoriasis',16,'Eczema, psoriasis, dermatitis.'),
  (22,'Boils',17,'Boils, carbuncles, styes, sores.'),
  (22,'Rheumatoid Arthritis',14,'Rheumatism, gout and sciatica.'),
  (22,'Gout',14,'Rheumatism, gout and sciatica.'),
  (22,'Sciatica',14,'Rheumatism, gout and sciatica.'),
  (22,'Uterine Prolapse',24,'Vaginal tissue laxity.'),
  -- Butternut (174)
  (174,'Constipation',11,'Chronic constipation.'),
  (174,'Diarrhea',11,'Diarrhoea and dysentery.'),
  (174,'Dysentery',11,'Diarrhoea and dysentery.'),
  (174,'Skin Eruptions',16,'Skin eruptions from faulty elimination.'),
  (174,'Intestinal Parasites',11,'Pin/thread worms in children.'),
  -- Cascara Sagrada (205)
  (205,'Constipation',11,'Chronic constipation.'),
  (205,'Functional Dyspepsia',11,'Chronic dyspepsia with liver torpor.'),
  (205,'Jaundice',11,'Jaundice.'),
  -- Catnip (136)
  (136,'Fevers',17,'Childhood fevers.'),
  (136,'Functional Dyspepsia',11,'Flatulent colic, abdominal congestion, colonic pain and invagination.'),
  (136,'Restlessness',17,'Restlessness, nervous irritation.'),
  (136,'Amenorrhea',24,'Functional menstrual disturbances, amenorrhoea and dysmenorrhoea.'),
  (136,'Dysmenorrhea',24,'Functional menstrual disturbances, amenorrhoea and dysmenorrhoea.'),
  (136,'Hysteria',15,'Convulsions, hysteria, insomnia.'),
  (136,'Insomnia',15,'Convulsions, hysteria, insomnia.'),
  -- Cayenne (47)
  (47,'Colds',17,'Colds, chills, congestion — very sensitive to cold and damp.'),
  (47,'Peripheral Arterial Occlusive Disease',9,'Cold extremities with cyanosis.'),
  (47,'Rheumatoid Arthritis',14,'Rheumatism, lumbago, neuralgia.'),
  (47,'Lumbago',14,'Rheumatism, lumbago, neuralgia.'),
  (47,'Neuralgia',15,'Rheumatism, lumbago, neuralgia.'),
  (47,'Depression',15,'Nervous depression.'),
  (47,'Hysteria',15,'Delirium tremens.'),
  (47,'Endometritis',24,'Uterine and ovarian congestion.'),
  (47,'Myalgia',14,'Sprains, bruises, joint pains.'),
  -- Celandine (170)
  (170,'Chronic Hepatitis',11,'Hepatitis, jaundice, obstruction — from obstructive pathology.'),
  (170,'Jaundice',11,'Hepatitis, jaundice, obstruction — from obstructive pathology.'),
  (170,'Functional Dyspepsia',11,'Indigestion, spastic constipation.'),
  (170,'Constipation',11,'Indigestion, spastic constipation.'),
  (170,'Irritable Bowel Syndrome',11,'Intestinal putrefaction.'),
  (170,'Eczema',16,'Eczema and scrofulous diseases.'),
  (170,'Ophthalmia',21,'Ophthalmia, conjunctivitis.'),
  -- Chamomile (84)
  (84,'Functional Dyspepsia',11,'Flatulence, colic, abdominal distension and spasms.'),
  (84,'Premenstrual Syndrome',24,'Premenstrual irritability and spasmodic dysmenorrhoea.'),
  (84,'Dysmenorrhea',24,'Premenstrual irritability and spasmodic dysmenorrhoea.'),
  (84,'Chorea',15,'Infantile convulsions from colic, teething, earache, etc.'),
  -- Cleavers (28)
  (28,'Edema',12,'Dropsy, renal obstructions.'),
  (28,'Urinary Calculus',12,'Bladder stone, gravel, calculi.'),
  (28,'Dysuria',12,'Scalding micturition, dysuria, irritable bladder, cystitis.'),
  (28,'Cystitis',12,'Scalding micturition, dysuria, irritable bladder, cystitis.'),
  (28,'Enuresis',12,'Enuresis in children.'),
  (28,'Eczema',16,'Skin eruptions, eczema, psoriasis.'),
  (28,'Psoriasis',16,'Skin eruptions, eczema, psoriasis.'),
  -- Coltsfoot (60)
  (60,'Bronchitis',18,'Chronic pulmonary conditions.'),
  (60,'Emphysema',18,'Chronic emphysema and silicosis.'),
  (60,'Pertussis',18,'Pertussis, asthma.'),
  (60,'Asthma',18,'Pertussis, asthma.'),
  -- Comfrey (89)
  (89,'Cough',18,'Coughs and colds.'),
  (89,'Colds',17,'Coughs and colds.'),
  (89,'Peptic Ulcers',11,'Gastric and duodenal ulcer.'),
  (89,'Gastritis',11,'Gastro-intestinal inflammation.'),
  (89,'Skin Eruptions',16,'Chronic suppurative ulcerations.'),
  (89,'Myalgia',14,'Bruised and damaged joints and muscles, pulled tendons.'),
  (89,'Bursitis and Tendonitis',14,'Delayed union of fractures.'),
  (89,'Ophthalmia',21,'Traumatic injury to the eye.'),
  -- Corn Silk (95)
  (95,'Cystitis',12,'Renal/cystic inflammatory states.'),
  (95,'Enuresis',12,'Enuresis.'),
  (95,'Benign Prostatic Hypertrophy',25,'Enlarged prostate with retention or suppression of urine.'),
  -- Cramp Bark (93)
  (93,'Functional Dyspepsia',11,'Colicky pains and spasms of tubular organs: gastro-intestinal and genito-urinary.'),
  (93,'Amenorrhea',24,'Atonic conditions of pelvic organs: menses scanty and delayed.'),
  -- Cranesbill (52)
  (52,'Gastritis',11,'Catarrhal gastritis, summer diarrhoea, chronic dysentery.'),
  (52,'Diarrhea',11,'Catarrhal gastritis, summer diarrhoea, chronic dysentery.'),
  (52,'Dysentery',11,'Catarrhal gastritis, summer diarrhoea, chronic dysentery.'),
  (52,'Menorrhagia',24,'Menorrhagia, metrorrhagia, post-partum haemorrhage, leucorrhoea.'),
  (52,'Leucorrhoea',24,'Menorrhagia, metrorrhagia, post-partum haemorrhage, leucorrhoea.'),
  (52,'Pregnancy - Postpartum - General',24,'Post-partum haemorrhage.'),
  (52,'Aphthous Ulcers',11,'Bleeding wounds, teeth sockets.'),
  -- Damiana (144)
  (144,'Spermatorrhoea',25,'Frigidity, impotence, senile decline.'),
  (144,'Amenorrhea',24,'To establish normal menstruation at puberty.'),
  (144,'Acute Stress',15,'Anxiety neurosis.'),
  -- Elder (57)
  (57,'Colds',17,'Colds/fevers with dry, hot skin.'),
  (57,'Sinusitis',19,'Chronic nasal catarrh/sinusitis.'),
  (57,'Cough',18,'Dry coryza, spasmodic croup.'),
  (57,'Night Sweats',21,'Weakening night sweats.'),
  (57,'Eczema',16,'Skin eruptions from metabolic disturbance, eczema, dermatitis.'),
  (57,'Skin Eruptions',16,'Skin eruptions from metabolic disturbance.'),
  -- Elecampane (54)
  (54,'Bronchitis',18,'Bronchial and gastric catarrh.'),
  (54,'Chronic Bronchitis',18,'Chronic bronchitis, tuberculosis.'),
  (54,'Emphysema',18,'Pneumoconiosis, silicosis.'),
  (54,'Pertussis',18,'Pertussis. Emphysematous conditions.'),
  (54,'Cough',18,'Chronic cough in the elderly.'),
  -- Eyebright (51)
  (51,'Sinusitis',19,'Catarrhal blepharitis, rhinitis, sinusitis and conjunctivitis.'),
  (51,'Ophthalmia',21,'Catarrhal blepharitis, rhinitis, sinusitis and conjunctivitis.'),
  (51,'Hay Fever',19,'Hay fever, acute coryza, irritable sneezing and lachrymation.'),
  -- Figwort (39)
  (39,'Eczema',16,'Chronic skin diseases, eczema and psoriasis.'),
  (39,'Psoriasis',16,'Chronic skin diseases, eczema and psoriasis.'),
  (39,'Swollen Glands',17,'Mammary tumours and nodosities, enlarged glands.'),
  (39,'Hemorrhoids',11,'Haemorrhoids.'),
  -- Fringetree (24)
  (24,'Jaundice',11,'Duodenal catarrh, hepatic torpor, catarrhal jaundice, gallstones.'),
  (24,'Cholelithiasis',11,'Duodenal catarrh, hepatic torpor, catarrhal jaundice, gallstones.'),
  (24,'Diabetes Mellitus',33,'Alimentary glycosuria.'),
  (24,'Liver Disease',11,'Chronic disease of liver/spleen.'),
  -- Gentian (102)
  (102,'Liver Disease',11,'Languid conditions and general debility, anorexia, alimentary insufficiency.'),
  (102,'Jaundice',11,'Biliousness and jaundice.'),
  -- Ginger (124)
  (124,'Colds',17,'Colds and chills.'),
  (124,'Functional Dyspepsia',11,'Flatulence and internal congestion, painful alimentary spasms.'),
  (124,'Diarrhea',11,'Diarrhoea from over-relaxation.'),
  -- Goldenrod (58)
  (58,'Influenza',19,'Influenza, repeated colds.'),
  (58,'Colds',17,'Influenza, repeated colds.'),
  (58,'Amenorrhea',24,'Suppressed menstruation.'),
  (58,'Cough',18,'Pulmonary expectoration.'),
  (58,'Sinusitis',19,'Naso-pharyngeal catarrh with sneezing and excessive mucus.'),
  (58,'Hematuria',12,'Acute/chronic nephritis with albuminaemia/haematuria.'),
  -- Goldenseal (30)
  (30,'Gastritis',11,'Catarrhal conditions of mucous membranes — especially gastritis.'),
  (30,'Ophthalmia',21,'Conjunctivitis, keratitis, tonsillitis, pharyngitis, vaginitis, cervicitis.'),
  (30,'Tonsillitis',19,'Conjunctivitis, keratitis, tonsillitis, pharyngitis, vaginitis, cervicitis.'),
  (30,'Vaginitis',17,'Conjunctivitis, keratitis, tonsillitis, pharyngitis, vaginitis, cervicitis.'),
  -- Hawthorn (73)
  (73,'Arteriosclerosis',9,'Myocardial degeneration and/or coronary sclerosis in elderly.'),
  (73,'Hypertension',9,'Hypertension.'),
  (73,'Congestive Heart Failure',9,'Cardiac weakness after infections.'),
  (73,'Palpitations',9,'Tachycardia, extra-systoles.'),
  (73,'Angina Pectoris',9,'Angina, palpitation, vertigo.'),
  (73,'Vertigo',15,'Angina, palpitation, vertigo.'),
  -- Hops (129)
  (129,'Hysteria',15,'Hysteria, dysmenorrhoea.'),
  (129,'Dysmenorrhea',24,'Hysteria, dysmenorrhoea.'),
  (129,'Neurasthenia',15,'Nervous exhaustion.'),
  (129,'Neuralgia',15,'Facial and brachial neuralgia.'),
  -- Horehound (160)
  (160,'Colds',17,'Colds, bronchitis, catarrh.'),
  (160,'Bronchitis',18,'Colds, bronchitis, catarrh.'),
  (160,'Asthma',18,'Asthma, with moist expectoration, aphonia and dyspnoea.'),
  (160,'Functional Dyspepsia',11,'Catarrhal dyspepsia.'),
  -- Horsetail (151)
  (151,'Cystitis',12,'Acute cystitis with stricture and urethritis.'),
  (151,'Urethritis',12,'Acute cystitis with stricture and urethritis.'),
  (151,'Enuresis',12,'Enuresis/incontinence in children and the elderly.'),
  (151,'Hematuria',12,'Haematuria.'),
  (151,'Edema',12,'Oedematous catarrhal congestion of pelvic organs and tissues.'),
  (151,'Urinary Calculus',12,'Renal calculi. Dropsy. Metabolic oedema of legs.'),
  (151,'Benign Prostatic Hypertrophy',25,'Enlarged/inflamed prostate gland.'),
  -- Juniper (103)
  (103,'Edema',12,'Dropsy from renal suppression.'),
  (103,'Cystitis',12,'Cystic catarrh, renal congestion.'),
  (103,'Amenorrhea',24,'Atonic amenorrhoea, dysmenorrhoea from sluggish conditions.'),
  (103,'Dysmenorrhea',24,'Atonic amenorrhoea, dysmenorrhoea from sluggish conditions.'),
  (103,'Rheumatoid Arthritis',14,'Rheumatic pain in muscles and joints, gout, sciatica.'),
  (103,'Gout',14,'Rheumatic pain in muscles and joints, gout, sciatica.'),
  (103,'Sciatica',14,'Rheumatic pain in muscles and joints, gout, sciatica.'),
  -- Kelp (118)
  (118,'Hypothyroidism',33,'Hypothyroid obesity, myxoedema.'),
  (118,'Edema',12,'Plethoric dropsy (fluid imbalance).'),
  (118,'Rheumatoid Arthritis',14,'Rheumatism and arthritis.'),
  -- Kola (150)
  (150,'Neurasthenia',15,'Neurasthenic, melancholia.'),
  (150,'Neuralgia',15,'Chronic neuralgia.'),
  -- Life Root (1058)
  (1058,'Dysmenorrhea',24,'Dysmenorrhoea (anaemic/atonic).'),
  (1058,'Amenorrhea',24,'Menses retarded or suppressed; functional amenorrhoea (asthenic).'),
  (1058,'Menorrhagia',24,'Menses premature or too profuse.'),
  (1058,'Leucorrhoea',24,'Atonic leucorrhoea.'),
  (1058,'Endometritis',24,'Functional tubal dysfunctions.'),
  (1058,'Benign Prostatic Hypertrophy',25,'Prostatic enlargement (atonic).'),
  -- Lily Of The Valley (163)
  (163,'Congestive Heart Failure',9,'Acute heart failure with oedema.'),
  (163,'Edema',12,'Acute heart failure with oedema.'),
  (163,'Anaemia',21,'Dyspnoea, orthopnoea, anaemia.'),
  (163,'Angina Pectoris',9,'Cardiac asthma, anginal syndromes.'),
  -- Lobelia (132)
  (132,'Myalgia',14,'Dislocations, trauma, hernias.'),
  (132,'Pertussis',18,'Spasmodic and membranous croup, pertussis, bronchial asthma, bronchitis, pleurisy.'),
  (132,'Asthma',18,'Spasmodic and membranous croup, pertussis, bronchial asthma, bronchitis, pleurisy.'),
  (132,'Bronchitis',18,'Spasmodic and membranous croup, pertussis, bronchial asthma, bronchitis, pleurisy.'),
  (132,'Pleurisy',18,'Spasmodic and membranous croup, pertussis, bronchial asthma, bronchitis, pleurisy.'),
  (132,'Chronic Hepatitis',11,'Hepatitis, jaundice, nausea, vomiting.'),
  (132,'Jaundice',11,'Hepatitis, jaundice, nausea, vomiting.'),
  (132,'Nausea',17,'Hepatitis, jaundice, nausea, vomiting.'),
  (132,'Hysteria',15,'Convulsions.'),
  (132,'Hypertension',9,'High blood pressure, intestinal obstruction, neurasthenia.'),
  (132,'Neurasthenia',15,'High blood pressure, intestinal obstruction, neurasthenia.'),
  (132,'Boils',17,'Sprains, boils, swollen joints.'),
  -- Lungwort (200)
  (200,'Cough',18,'Coughs, colds, influenza.'),
  (200,'Colds',17,'Coughs, colds, influenza.'),
  (200,'Influenza',19,'Coughs, colds, influenza.'),
  (200,'Bronchitis',18,'Bronchial and catarrhal states.'),
  (200,'Sore Throat',17,'Inflammation of throat or lungs.'),
  -- Marshmallow (45)
  (45,'Bronchitis',18,'Acute respiratory disease.'),
  (45,'Peptic Ulcers',11,'Gastro-intestinal ulcer, cystitis, urethritis.'),
  (45,'Cystitis',12,'Gastro-intestinal ulcer, cystitis, urethritis.'),
  (45,'Urethritis',12,'Gastro-intestinal ulcer, cystitis, urethritis.'),
  (45,'Sore Throat',17,'Inflammation of mouth and throat.'),
  (45,'Hemorrhoids',11,'Inflamed haemorrhoids, ophthalmia.'),
  (45,'Ophthalmia',21,'Inflamed haemorrhoids, ophthalmia.'),
  (45,'Skin Eruptions',16,'Inflamed and gangrenous wounds.'),
  (45,'Boils',17,'Burns and scalds. Bedsores. Abscesses, boils, ulcers.'),
  -- Meadowsweet (75)
  (75,'Diarrhea',11,'Summer diarrhoea in children; diarrhoea, bowel disturbance.'),
  (75,'Gastritis',11,'Dyspepsia with hyperchlorydia.'),
  (75,'GERD',11,'Eructations, oesophageal burning.'),
  (75,'Fevers',17,'Febrile conditions with excessive heat.'),
  -- Mistletoe (211)
  (211,'Menorrhagia',24,'Metrorrhagia, post-partum haemorrhage, endometritis.'),
  (211,'Pregnancy - Postpartum - General',24,'Metrorrhagia, post-partum haemorrhage.'),
  (211,'Endometritis',24,'Metrorrhagia, post-partum haemorrhage, endometritis.'),
  (211,'Headache',15,'Congestive headache, hypertension and cardiac hypertrophy.'),
  (211,'Hypertension',9,'Congestive headache, hypertension and cardiac hypertrophy.'),
  (211,'Rheumatoid Arthritis',14,'Rheumatic and gouty syndromes, neuralgia and sciatica.'),
  (211,'Gout',14,'Rheumatic and gouty syndromes, neuralgia and sciatica.'),
  (211,'Neuralgia',15,'Rheumatic and gouty syndromes, neuralgia and sciatica.'),
  (211,'Sciatica',14,'Rheumatic and gouty syndromes, neuralgia and sciatica.'),
  -- Motherwort (131)
  (131,'Insomnia',15,'Anaemic nervousness and insomnia.'),
  (131,'Anaemia',21,'Anaemic nervousness and insomnia.'),
  (131,'Hysteria',15,'Chlorotic hysteria/palpitation.'),
  (131,'Palpitations',9,'Chlorotic hysteria/palpitation.'),
  (131,'Congestive Heart Failure',9,'Cardiac debility, tachycardia.'),
  (131,'Hyperthyroidism',33,'Hyperthyroid cardiac reactions.'),
  (131,'Premenstrual Syndrome',24,'Pre-menstrual tension, congestive amenorrhoea or dysmenorrhoea.'),
  (131,'Amenorrhea',24,'Pre-menstrual tension, congestive amenorrhoea or dysmenorrhoea.'),
  (131,'Dysmenorrhea',24,'Pre-menstrual tension, congestive amenorrhoea or dysmenorrhoea.'),
  -- Mullein (61)
  (61,'Cough',18,'Paroxysmal laryngeal cough.'),
  (61,'Chronic Bronchitis',18,'Irritable chronic bronchitis.'),
  (61,'Pleurisy',18,'Pleurisy with exudation.'),
  (61,'Hay Fever',19,'Hay fever, asthma.'),
  (61,'Asthma',18,'Hay fever, asthma.'),
  -- Narrow-Leaf Echinacea (221)
  (221,'Infection',17,'Septic infections, septicaemia.'),
  (221,'Boils',17,'Furunculosis, carbuncles.'),
  (221,'Tonsillitis',19,'Ulcerative pharyngitis, tonsillitis and stomatitis.'),
  (221,'Sore Throat',17,'Ulcerative pharyngitis, tonsillitis and stomatitis.'),
  (221,'Eczema',16,'Eczema from blood conditions.'),
  (221,'Peptic Ulcers',11,'Gastric and duodenal ulcers.'),
  (221,'Irritable Bowel Syndrome',11,'Enteritis.'),
  -- Oat (178)
  (178,'Dysmenorrhea',24,'Irritation and depression with dysmenorrhoea.'),
  (178,'Depression',15,'Irritation and depression with dysmenorrhoea.'),
  (178,'Hysteria',15,'Hysteria, insomnia.'),
  (178,'Insomnia',15,'Hysteria, insomnia.'),
  (178,'Neurasthenia',15,'Neurasthenia and neuroses.'),
  -- Oregon Grape (33)
  (33,'Gastritis',11,'Catarrhal disorders of stomach, intestines and urinary organs.'),
  (33,'Liver Disease',11,'Hepatic torpor, bilious headache.'),
  (33,'Headache',15,'Hepatic torpor, bilious headache.'),
  (33,'Eczema',16,'Eczema, herpes, psoriasis, acne, facial blotches and pimples.'),
  (33,'Psoriasis',16,'Eczema, herpes, psoriasis, acne, facial blotches and pimples.'),
  (33,'Acne',16,'Eczema, herpes, psoriasis, acne, facial blotches and pimples.'),
  -- Partridgeberry (188)
  (188,'Neurasthenia',15,'Neurasthenia, irritability.'),
  (188,'Endometritis',24,'Enlarged atonic uterus.'),
  (188,'Pregnancy - General Issues',24,'To facilitate parturition.'),
  (188,'Menorrhagia',24,'Uterine bleeding from weakness, post-partum haemorrhage.'),
  (188,'Pregnancy - Postpartum - General',24,'Uterine bleeding from weakness, post-partum haemorrhage.'),
  (188,'Spermatorrhoea',25,'Spermatorrhoea.'),
  (188,'Leucorrhoea',24,'Leucorrhoea.'),
  -- Pasqueflower (36)
  (36,'Neurasthenia',15,'Functional neuroses: heart and pelvic organs.'),
  (36,'Dysmenorrhea',24,'Vasomotor instability, dysmenorrhoea.'),
  (36,'Amenorrhea',24,'Amenorrhoea, leucorrhoea, menopausal flushes.'),
  (36,'Leucorrhoea',24,'Amenorrhoea, leucorrhoea, menopausal flushes.'),
  (36,'Menopausal Complaints',24,'Amenorrhoea, leucorrhoea, menopausal flushes.'),
  (36,'Neuralgia',15,'Neural irritation, head neuralgia.'),
  (36,'Ophthalmia',21,'Catarrhal ophthalmic.'),
  (36,'Ear Infections',17,'Catarrhal otitis.'),
  -- Passionflower (137)
  (137,'Hysteria',15,'Mild convulsive or tremulous states — unrest and agitation.'),
  (137,'Restlessness',17,'Restlessness and wakefulness in infants and the elderly.'),
  -- Pleurisy Root (67)
  (67,'Cough',18,'Catarrhal complaints from cold and damp: hard, dry cough.'),
  (67,'Bronchitis',18,'Bronchitis, pleurisy, peritonitis.'),
  (67,'Pleurisy',18,'Bronchitis, pleurisy, peritonitis.'),
  (67,'Pneumonia',17,'Pneumonia.'),
  (67,'Influenza',19,'Influenza.'),
  (67,'Rheumatoid Arthritis',14,'Intercostal rheumatism.'),
  (67,'Skin Eruptions',16,'Eruptive diseases.'),
  -- Poke Root (35)
  (35,'Rheumatoid Arthritis',14,'Chronic rheumatism and arthritis, neuralgia and lumbago.'),
  (35,'Neuralgia',15,'Chronic rheumatism and arthritis, neuralgia and lumbago.'),
  (35,'Lumbago',14,'Chronic rheumatism and arthritis, neuralgia and lumbago.'),
  (35,'Tonsillitis',19,'Tonsillitis and parotids.'),
  (35,'Mastitis',24,'Mastitis, mammary congestion.'),
  (35,'Endometritis',24,'Ovaritis, orchitis.'),
  (35,'Enlarged Thyroid',33,'Enlarged thyroid and lymphatics.'),
  (35,'Swollen Glands',17,'Enlarged thyroid and lymphatics.'),
  -- Prickly Ash (123)
  (123,'Rheumatoid Arthritis',14,'Chronic rheumatic conditions.'),
  (123,'Neurasthenia',15,'Neurasthenia — poor assimilation.'),
  (123,'Functional Dyspepsia',11,'Gastric distension, eructations and flatulence.'),
  (123,'Neuritis',15,'Loss of sensitivity in injured nerves.'),
  -- Raspberry (155)
  (155,'Dysentery',11,'Acute and chronic dysentery.'),
  (155,'Diarrhea',11,'Summer diarrhoea in children.'),
  (155,'Menorrhagia',24,'Uterine haemorrhage, menorrhagia.'),
  (155,'Leucorrhoea',24,'Leucorrhoea.'),
  (155,'Ophthalmia',21,'Ophthalmia.'),
  (155,'Sore Throat',17,'Sore throat and hoarseness.'),
  -- Red Clover (42)
  (42,'Swollen Glands',17,'Salivary gland congestion.'),
  (42,'Cough',18,'Spasmodic or croupy coughs.'),
  (42,'Pertussis',18,'Pertussis.'),
  (42,'Sore Throat',17,'Pharyngeal inflammation/infection.'),
  (42,'Skin Eruptions',16,'Chronic skin eruptions.'),
  -- Rhubarb (154)
  (154,'Constipation',11,'Full catharsis.'),
  (154,'Diarrhea',11,'Diarrhoea and dysentery, summer diarrhoea.'),
  (154,'Dysentery',11,'Diarrhoea and dysentery, summer diarrhoea.'),
  (154,'Functional Dyspepsia',11,'Functional dyspepsia.'),
  -- Rosemary (109)
  (109,'Functional Dyspepsia',11,'Atonic conditions of the stomach.'),
  (109,'Headache',15,'Gastric headache.'),
  (109,'Anaemia',21,'Adolescent hypotonia, asthenia with pallid complexion.'),
  (109,'Arteriosclerosis',9,'Circulatory weakness following stress or illness.'),
  -- Sage (56)
  (56,'Functional Dyspepsia',11,'Gastric debility and flatulence.'),
  (56,'Night Sweats',21,'Night sweats.'),
  (56,'Sore Throat',17,'Sore, ulcerated throat.'),
  -- Saw Palmetto (186)
  (186,'Uterine Prolapse',24,'Atony of pelvic organs.'),
  (186,'Spermatorrhoea',25,'Wasting of testes, impotence, undeveloped mammary glands.'),
  (186,'Enuresis',12,'Enuresis/incontinence in children and the elderly.'),
  -- Senna (216)
  (216,'Constipation',11,'To produce rapid catharsis.'),
  (216,'Tonsillitis',19,'Tonsillitis, diphtheria, eruptive diseases (from constipation).'),
  (216,'Skin Eruptions',16,'Tonsillitis, diphtheria, eruptive diseases (from constipation).'),
  (216,'Fevers',17,'Recurrent/intermittent fevers.'),
  (216,'Hemorrhoids',11,'Acute haemorrhoids: to ease liver and gall-bladder function.'),
  -- Skullcap (142)
  (142,'Neurasthenia',15,'Functional nervous exhaustion, postfebrile nervous weakness.'),
  (142,'Chorea',15,'Chorea, hysteria, agitation and epileptiform convulsions.'),
  (142,'Hysteria',15,'Chorea, hysteria, agitation and epileptiform convulsions.'),
  (142,'Insomnia',15,'Insomnia, nightmares, restless sleep.'),
  -- Slippery Elm (92)
  (92,'Peptic Ulcers',11,'Acute gastric and duodenal ulcer, gastritis, gastric weakness.'),
  (92,'Gastritis',11,'Acute gastric and duodenal ulcer, gastritis, gastric weakness.'),
  (92,'Diarrhea',11,'Diarrhoea, dysentery, enteritis.'),
  (92,'Dysentery',11,'Diarrhoea, dysentery, enteritis.'),
  (92,'Sore Throat',17,'Inflammation of mouth and throat. Vaginitis.'),
  (92,'Vaginitis',17,'Inflammation of mouth and throat. Vaginitis.'),
  (92,'Skin Eruptions',16,'Burns, scalds, abrasions.'),
  (92,'Hemorrhoids',11,'Haemorrhoids, orificial fissures. Varicose ulcers.'),
  (92,'Varicose Veins',9,'Haemorrhoids, orificial fissures. Varicose ulcers.'),
  (92,'Boils',17,'Abscesses, boils, carbuncles. Inflamed wounds and ulcers.'),
  (92,'Swollen Glands',17,'Swollen glands.'),
  -- St. John's Wort (81)
  (81,'Lumbago',14,'Painful injuries to sacral spine and coccyx. Traumatic shock.'),
  (81,'Hemorrhoids',11,'Haemorrhoids with pain bleeding.'),
  (81,'Neuralgia',15,'Facial neuralgia after dental extractions, toothache.'),
  -- Stoneroot (182)
  (182,'Diarrhea',11,'Gastro-enteritis with diarrhoea.'),
  (182,'Hemorrhoids',11,'Haemorrhoids.'),
  (182,'Laryngitis',19,'Laryngeal inflammation/catarrh.'),
  (182,'Influenza',19,'Influenza, acute/chronic pleural, colds and fevers.'),
  (182,'Colds',17,'Influenza, acute/chronic pleural, colds and fevers.'),
  (182,'Pleurisy',18,'Influenza, acute/chronic pleural, colds and fevers.'),
  (182,'Leucorrhoea',24,'Leucorrhoea.'),
  -- Valerian (145)
  (145,'Restlessness',17,'Nervous excitability.'),
  (145,'Insomnia',15,'Nervous insomnia.'),
  (145,'Palpitations',9,'Nervous palpitations.'),
  (145,'Functional Dyspepsia',11,'Flatulent colic, abdominal cramp, gastrodyna, diarrhoea.'),
  (145,'Diarrhea',11,'Flatulent colic, abdominal cramp, gastrodyna, diarrhoea.'),
  (145,'Menopausal Complaints',24,'Menopausal dysfunction, retarded and scanty menstruation.'),
  (145,'Amenorrhea',24,'Menopausal dysfunction, retarded and scanty menstruation.'),
  (145,'Chorea',15,'Nervousness of children, chorea.'),
  -- Vervain (146)
  (146,'Depression',15,'Nervous depression and weakness, convalescence and debility.'),
  (146,'Bronchitis',18,'Acute catarrhs of bronchitis and pertussis.'),
  (146,'Pertussis',18,'Acute catarrhs of bronchitis and pertussis.'),
  (146,'Amenorrhea',24,'Amenorrhoea, dysmenorrhoea and difficult menstruation.'),
  (146,'Dysmenorrhea',24,'Amenorrhoea, dysmenorrhoea and difficult menstruation.'),
  -- White Pond Lily (2242)
  (2242,'Leucorrhoea',24,'Arid leucorrhoea, ulceration of the cervix, vaginal laxity.'),
  (2242,'Uterine Prolapse',24,'Arid leucorrhoea, ulceration of the cervix, vaginal laxity.'),
  (2242,'Prostatitis',17,'Prostatitis.'),
  (2242,'Aphthous Ulcers',11,'Aphthous sore mouth.'),
  (2242,'Ophthalmia',21,'Purulent ophthalmia.'),
  (2242,'Diarrhea',11,'Diarrhoea, dysentery.'),
  (2242,'Dysentery',11,'Diarrhoea, dysentery.'),
  -- Wild Cherry Bark (140)
  (140,'Chronic Bronchitis',18,'Chronic bronchitis with debility.'),
  (140,'Functional Dyspepsia',11,'Catarrhal dyspepsia, weak digestion in the elderly.'),
  (140,'Diarrhea',11,'Chronic diarrhoea.'),
  (140,'Sore Throat',17,'Weak throat.'),
  (140,'Ophthalmia',21,'Ophthalmia.'),
  -- Wild Indigo (23)
  (23,'Ulcerative Colitis',11,'Ulcerative colitis, amoebic dysentery, intestinal toxaemia.'),
  (23,'Dysentery',11,'Ulcerative colitis, amoebic dysentery, intestinal toxaemia.'),
  (23,'Tonsillitis',19,'Tonsillitis and quinsy.'),
  (23,'Endometritis',24,'Erosion of cervix.'),
  (23,'Skin Eruptions',16,'Surface ulceration.'),
  -- Wild Yam (74)
  (74,'Functional Dyspepsia',11,'Bilious colic, flatulence, gastro-intestinal irritation.'),
  (74,'Neuralgia',15,'Neuralgic conditions.'),
  (74,'Dysmenorrhea',24,'Dysmenorrhoea, uterine pains.'),
  (74,'Pregnancy - General Issues',24,'Nervousness, restlessness and pains of pregnancy.'),
  -- Willow (87)
  (87,'Cystitis',12,'Cystitis, ovaritis, prostatitis.'),
  (87,'Prostatitis',17,'Cystitis, ovaritis, prostatitis.'),
  (87,'Endometritis',24,'Cystitis, ovaritis, prostatitis.'),
  (87,'Vaginitis',17,'Vaginitis, leucorrhoea.'),
  (87,'Leucorrhoea',24,'Vaginitis, leucorrhoea.'),
  (87,'Spermatorrhoea',25,'Spermatorrhoea.'),
  -- Witch Hazel (79)
  (79,'Diarrhea',11,'Diarrhoea and dysentery.'),
  (79,'Dysentery',11,'Diarrhoea and dysentery.'),
  (79,'Hemorrhoids',11,'Protruding, bleeding haemorrhoids.'),
  (79,'Pregnancy - Postpartum - General',24,'Vulval bruising after childbirth.'),
  (79,'Uterine Prolapse',24,'Vaginal laxity with tenderness.'),
  (79,'Sore Throat',17,'Inflamed sore throat.'),
  (79,'Varicose Veins',9,'Varicose veins.'),
  (79,'Ophthalmia',21,'Sore and bloodshot eyes.'),
  -- Wood Betony (207)
  (207,'Functional Dyspepsia',11,'Gastralgia, dyspepsia.'),
  (207,'Rheumatoid Arthritis',14,'Chronic rheumatism and sciatica.'),
  (207,'Sciatica',14,'Chronic rheumatism and sciatica.'),
  (207,'Headache',15,'Phrenitis, ischaemic headache.'),
  (207,'Hysteria',15,'Hysteria, pains in the head and face, neuralgia.'),
  (207,'Neuralgia',15,'Hysteria, pains in the head and face, neuralgia.'),
  (207,'Neurasthenia',15,'Lack of concentration, forgetful.'),
  -- Yarrow (44)
  (44,'Colds',17,'Acute stage of colds, influenza and respiratory catarrh.'),
  (44,'Influenza',19,'Acute stage of colds, influenza and respiratory catarrh.'),
  (44,'Diarrhea',11,'Chronic diarrhoea and dysentery.'),
  (44,'Dysentery',11,'Chronic diarrhoea and dysentery.'),
  (44,'Epistaxis',21,'Epistaxis, intestinal haemorrhage and bleeding haemorrhoids.'),
  (44,'Hemorrhoids',11,'Epistaxis, intestinal haemorrhage and bleeding haemorrhoids.'),
  (44,'Menorrhagia',24,'Uterine haemorrhage, profuse and protracted menstruation.'),
  (44,'Leucorrhoea',24,'Leucorrhoea, vaginal laxity.'),
  (44,'Uterine Prolapse',24,'Leucorrhoea, vaginal laxity.'),
  -- Yellow Dock (37)
  (37,'Anaemia',21,'Simple deficiency anaemia.'),
  (37,'Eczema',16,'Eczema, psoriasis, urticaria.'),
  (37,'Psoriasis',16,'Eczema, psoriasis, urticaria.'),
  (37,'Skin Eruptions',16,'Prurigo.'),
  (37,'Hemorrhoids',11,'Itching haemorrhoids.')
) AS v(herb_id, disorder_name, body_system_id, description)
JOIN herbal.disorders d ON d.name = v.disorder_name AND d.body_system_id = v.body_system_id
ON CONFLICT (herb_id, disorder_id, source_id) DO NOTHING;

-- Grant permissions on updated sequence (no new sequences needed)
GRANT SELECT ON herbal.disorders TO anon, authenticated;
