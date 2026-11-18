-- herb_mental_pictures: mental picture / specific indications per herb
-- sourced from Tilgner's Heart of the Earth Materia Medica
-- keywords array drives synonyms + related terms for full-text search
-- search_vector is a generated tsvector over mental_picture + keywords

CREATE TABLE herbal.herb_mental_pictures (
  id           serial  PRIMARY KEY,
  herb_id      integer NOT NULL REFERENCES herbal.herbs(id) ON DELETE CASCADE,
  mental_picture text  NOT NULL,
  keywords     text[]  NOT NULL DEFAULT '{}',
  search_vector tsvector,
  created_at   timestamptz DEFAULT now()
);

CREATE OR REPLACE FUNCTION herbal.herb_mental_pictures_tsv()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
  NEW.search_vector := to_tsvector('english'::regconfig,
    coalesce(NEW.mental_picture, '') || ' ' || array_to_string(NEW.keywords, ' ')
  );
  RETURN NEW;
END;
$$;

CREATE TRIGGER herb_mental_pictures_tsv_trigger
  BEFORE INSERT OR UPDATE ON herbal.herb_mental_pictures
  FOR EACH ROW EXECUTE FUNCTION herbal.herb_mental_pictures_tsv();

CREATE UNIQUE INDEX herb_mental_pictures_herb_id_key
  ON herbal.herb_mental_pictures(herb_id);

CREATE INDEX herb_mental_pictures_search_idx
  ON herbal.herb_mental_pictures USING gin(search_vector);

ALTER TABLE herbal.herb_mental_pictures ENABLE ROW LEVEL SECURITY;

CREATE POLICY "public_read" ON herbal.herb_mental_pictures
  FOR SELECT TO anon, authenticated USING (true);

GRANT SELECT ON herbal.herb_mental_pictures TO anon, authenticated;

-- ============================================================
-- Data
-- ============================================================

INSERT INTO herbal.herb_mental_pictures (herb_id, mental_picture, keywords) VALUES

-- Arnica (114)
(114,
 'Arnica is specific for traumatic injury symptoms or similar conditions where there is bruising of tissues with blue and red coloration as seen in a new bruise. It is also specific for symptoms due to severe mental trauma.',
 ARRAY['bruise','bruising','contusion','ecchymosis','hematoma','trauma','injury','shock','physical trauma','mental shock','concussion','soreness','post-traumatic','accident','falls','sprains','strains','muscle soreness']),

-- Astragalus (225)
(225,
 'This herb is indicated to weakened individuals with night sweats, prolapsing organs, frequent infectious illnesses, poor digestion and nutritional status and a general lack of vitality.',
 ARRAY['weakness','fatigue','exhaustion','immune deficiency','night sweats','hyperhidrosis','nocturnal sweating','prolapse','frequent illness','recurring infection','poor digestion','low vitality','tonic','adaptogen','immunomodulator','qi deficiency','spleen qi deficiency','lung qi deficiency','low energy','debilitated']),

-- Bayberry (119)
(119,
 'The mental picture of this herb is one of moving from sleeplessness, despondency, irritability, or indifference.',
 ARRAY['insomnia','sleeplessness','despondency','depression','melancholy','irritability','indifference','apathy','listlessness','nervous','emotional flatness','poor sleep','restless','unable to sleep']),

-- Bee Balm / Monarda (2639)
(2639,
 'Monarda is indicated in infectious conditions of the lungs, digestive system and urinary tract. It is specific for chronic low-grade fevers with a rapid and flooding pulse.',
 ARRAY['infection','respiratory infection','lung infection','pulmonary infection','digestive infection','urinary infection','UTI','low-grade fever','subacute fever','persistent fever','rapid pulse','flooding pulse','antimicrobial','antifungal','Monarda','bergamot','bee balm','wild oregano']),

-- Trillium / Beth root (2626)
(2626,
 'This is an herb for cramping pelvic pains that feel like the hips and back are falling to pieces. The pains are better with pressure around the pelvis. It is indicated for tenacious mucus discharge or uterine hemorrhage with great faintness and dizziness. All conditions are associated with poor pelvic tone.',
 ARRAY['pelvic pain','cramping','uterine cramps','pelvic heaviness','uterine hemorrhage','uterine bleeding','mucus discharge','tenacious discharge','pelvic tone','uterine atony','falling apart feeling','faintness','dizziness','hip pain','low back pain','pressure relieves','beth root','trillium']),

-- Betony / Wood Betony (207)
(207,
 'Betony has an affinity for persons who are non-assertive, lack interest in the world and have a sense of not being grounded. An emphasis is on gastrointestinal irritability and a lack of cerebral circulation causing ischemia and pain.',
 ARRAY['grounding','ungrounded','non-assertive','passive','lacks confidence','GI irritability','irritable bowel','gastrointestinal','cerebral circulation','ischemia','headache','cerebral ischemia','weak boundaries','poor boundaries','disconnected','spaced out','wood betony','betony']),

-- Black Cohosh (25)
(25,
 'Consider black cohosh when there are spasms, achy pains, chilliness, fevers, nervous system irritation or excitement, depression of a deep, dark, brooding, withdrawn and heavy nature, incessant talking and neuralgia. It is specific for headaches in the late luteal phase associated with low estrogen levels. Many symptoms are worse in the morning, during menses and with cold applications. Symptoms are better with warmth and after eating. Black cohosh is indicated for traumas to the nervous system that create congestion and pain. These traumas can be physical such as in a car accident or they can be mental/emotional such as sexual abuse of children where there may or may not be physical trauma but there is almost always mental/emotional trauma.',
 ARRAY['neuralgia','nerve pain','spasm','dark depression','brooding','withdrawn','heavy','incessant talking','chilliness','low estrogen','luteal phase','menstrual headache','PMS','premenstrual','nervous irritation','sexual abuse','trauma','PTSD','worse in morning','worse with cold','worse during menstruation','nerve congestion','rheumatism','rheumatic','loquacious']),

-- Blue Cohosh (72)
(72,
 'The picture of blue cohosh is one of heavy, achy, spasmodic uterine pain with congestion and prolapsed, lax tissues, pain in the thighs and lower back, spasmodic muscular pains, rheumatic pains and a dull frontal headache with thirst.',
 ARRAY['uterine spasm','pelvic congestion','prolapse','lax tissues','atonic uterus','thigh pain','lower back pain','lumbar pain','spasmodic','rheumatic','frontal headache','dull headache','thirst','spasmodic uterine pain','difficult labor','stalled labor']),

-- Boneset (50)
(50,
 'Boneset is used for influenza and colds with night sweats, aching in both muscles and bones, fever and a full, large pulse. The tongue is coated white with a bitter taste. Tea form is optimal for colds and influenza.',
 ARRAY['influenza','flu','cold','fever','night sweats','aching bones','bone aches','muscle aches','myalgia','full pulse','white coated tongue','bitter taste','deep aching','influenza prophylaxis','chills','bone pain']),

-- Burdock (22)
(22,
 'It influences the skin, kidneys, liver, gall bladder, and mucous and serous membranes to induce removal of accumulated by-products of catabolism. Burdock helps cool off hot tempered, irritable people.',
 ARRAY['skin','liver','kidney','gallbladder','catabolism','detox','blood purifier','alterative','irritable','hot tempered','angry','acne','eczema','psoriasis','skin eruptions','metabolic waste','lymphatic','gout','uric acid']),

-- Cactus / Night-Blooming Cereus (2616)
(2616,
 'Indicated for conditions of dilation and atony from muscular laxity and has a special affinity for the heart.',
 ARRAY['heart','cardiac','dilation','atony','muscular laxity','heart weakness','palpitations','constriction','angina','valvular insufficiency','heart failure','cardiac tonic','night-blooming cereus','Selenicereus']),

-- Calendula (70)
(70,
 'Calendula is indicated when the individual feels worse in damp, heavy, cloudy weather. It is specific for wounds that will not heal and lymphatic congestion with a predilection for the chest, axilla and inguinal crease.',
 ARRAY['lymphatic','swollen lymph nodes','wounds','non-healing wounds','damp weather','worse in damp','chest lymph','axilla','groin','inguinal','lymph congestion','lymphadenitis','lymphedema','wounds healing','slow healing','vulnerary']),

-- Cayenne (47)
(47,
 'The mental picture of cayenne is cold, flabby, sluggish individuals, with jerking, aching muscles and stagnation in the cardiovascular system. There is exhausted vitality, especially exhaustion from mental work and poor living. The symptoms become better with heat and when eating, worse in open air and breeze.',
 ARRAY['cold constitution','cold person','sluggish','flabby','cardiovascular stagnation','exhausted vitality','mental exhaustion','worse in open air','better with heat','better when eating','peripheral circulation','cold extremities','poor circulation','stimulant']),

-- Thuja / Cedar Western (201)
(201,
 'The person is sensitive, has fixed ideas, insomnia, muscular twitching, weakness, lack of appetite and feels as if soul and body are separated. Symptoms are worse at night, with ingestion of fat and coffee and from cold damp air. There is a tendency to warty or other viral-related conditions. It is indicated for lymphatic congestion due to systemic infections. Moist skin eruptions and discharges are common. There is often a history of sexually transmitted diseases.',
 ARRAY['warts','HPV','viral warts','condyloma','STD','sexually transmitted','insomnia','fixed ideas','obsessive','soul-body separation','dissociation','muscular twitching','lymphatic congestion','skin eruptions','moist eruptions','gonorrhea history','worse at night','worse with fat','worse with coffee','cold damp','cedar','thuja','arbor vitae']),

-- Celandine (170)
(170,
 'The mental picture is one of general lethargy. There is a tendency towards anxiety, and ailments brought on or renewed by weather changes. It is specific for conditions of a bilious nature.',
 ARRAY['lethargy','fatigue','anxiety','weather changes','bilious','liver','jaundice','right-sided','right scapula','gallbladder','bile','constipation','skin yellow','nausea','greater celandine']),

-- Chamomile (84)
(84,
 'This nervine is specific for neural irritability in persons with a strong and active nervous system. Chamomile is superb at decreasing inflammatory states in the nervous system. Mental picture is restless, irritable, sensitive, complaining, wants to have their way, argumentative, acting like a baby and cannot be comforted. Pains are unbearable to them. They are hot, thirsty and numb. The pulse is tense and rapid. The tongue is coated whitish-yellow and they note a bitter taste. Discharges tend to be yellow. Symptoms are worse on the right side, with motion, touch, change of weather and in the early morning. They are better after dinner and with pressure.',
 ARRAY['irritable','restless','cannot be comforted','teething','colic','oversensitive','demanding','unbearable pain','hypersensitive to pain','angry','snappy','one cheek red','cross','children','infants','worse with touch','worse with motion','better with pressure','better after eating','right-sided','whiny','inconsolable']),

-- Cinnamon (167)
(167,
 'Cinnamon warms and strengthens organs of digestion. It is beneficial for persons with low vitality and a tendency toward influenza. It is also for symptoms of stress with a tendency to diarrhea and rheumatic pains.',
 ARRAY['cold constitution','low vitality','influenza tendency','stress','stress-induced diarrhea','rheumatic','warming','digestive weakness','convalescence','post-illness weakness']),

-- Cleavers (28)
(28,
 'Due to its vulnerary action, cleavers can be helpful on ulcerated surfaces and is specific for tumors and ulcers in the mouth and throat. It is also beneficial for swollen glands and cysts. Cleavers is useful for skin irritations with an affinity for flexor surfaces like the bend of the forearm, the axilla and the back of the knees.',
 ARRAY['lymphatic','swollen glands','lymphadenopathy','cysts','mouth ulcers','throat ulcers','skin irritation','eczema','flexor surfaces','elbow crease','axilla','back of knees','vulnerary','lymphatic tonic','lymph drainage']),

-- Cotton Root Bark (2635)
(2635,
 'Used for the woman who feels menstruation is about to start, but it does not. She may also have nervous chills.',
 ARRAY['amenorrhea','delayed menstruation','menstruation does not come','nervous chills','uterine stimulant','emmenagogue','impending menses','suppressed menses']),

-- Cramp Bark (93)
(93,
 'Cramp bark can be used for most spasmodic pains but is specific for spasmodic and congestive conditions of the female genitourinary tract. It is indicated when pelvic pains extend down the thighs and are accompanied by nausea. The spasms are usually worse lying on the affected side, in warm rooms and in the evening, and better in open air and from resting.',
 ARRAY['pelvic spasm','uterine cramp','menstrual cramp','dysmenorrhea','nausea with cramps','thigh pain radiating','spasmodic pain','genitourinary spasm','worse lying on affected side','worse in warm rooms','worse in evening','better in open air','better resting','antispasmodic']),

-- Dandelion root (122)
(122,
 'Dandelion is indicated for persons with a mapped tongue (a tongue with white coating that comes off in places leaving a red raw tongue in these areas), yellow tongue, white tongue, bitter taste in the mouth and pain in the sternocleidomastoid muscle. It is specific for low-grade internalized heat or infectious conditions, especially if related to allergies. Night sweats occur at the top of the head, heat without thirst. Edema or boggy mucous membranes may be present. There is often a history of chemical insult or other environmental assaults pointing to liver involvement. The person may feel angry, agitated, nervous and dull-minded. The individual''s symptoms are worse from resting, sitting and lying, and feel better from touch. Dandelion is supportive of the solar plexus and all manners of disease that arise in the 3rd chakra.',
 ARRAY['mapped tongue','geographic tongue','yellow tongue','bitter taste','sternocleidomastoid pain','liver','liver congestion','allergies','night sweats','heat without thirst','edema','boggy mucous membranes','chemical sensitivity','environmental illness','angry','agitated','dull-minded','worse resting','better with touch','solar plexus','third chakra','low-grade heat']),

-- Devil''s Club (591)
(591,
 'The mental picture includes worn out, timid individuals who lack mental and emotional strength and vitality. The individuals cannot adapt to stressful situations and feel oppressed and unable to stand up for themselves. This herb lends a sense of invigoration and strength on a physical, emotional, mental and spiritual level. This strong perennial warrior of a plant is quite impressive in person. She is a tribal warrior, living in a devil''s club community that is interconnected by their root/limbs. She has a coat of prickly armor to protect her. When you become her friend she will take you into her tribe and protect you as well. If you open to her, she will teach you to protect yourself. She is found deep in wooded areas near streams or other sources of water.',
 ARRAY['exhaustion','worn out','timid','oppressed','lack of confidence','weak boundaries','cannot adapt','stress','overwhelmed','strength','invigoration','spiritual protection','warrior','boundaries','empowerment','adrenal','blood sugar','hypoglycemia']),

-- Dong Quai (1009)
(1009,
 'Dong quai is beneficial for gynecological complaints with spasms and pain, chills, dryness of skin, constipation due to dryness and uterine or ovarian masses. It is also indicated for congestion in the pelvic region.',
 ARRAY['gynecological','uterine spasm','pelvic congestion','dryness','dry skin','constipation due to dryness','uterine masses','ovarian masses','fibroids','chills','blood deficiency','menstrual irregularity','blood nourishing','emmenagogue']),

-- Echinacea (26)
(26,
 'Echinacea is indicated for exhaustive states with chilliness, offensive discharges, lymphatic congestion with swollen glands, mental confusion, dull mind, dizziness and a tendency to skin eruptions and low grade continuous fevers, although they can be high grade fevers.',
 ARRAY['infection','immune support','lymphatic','chilliness','offensive discharges','swollen glands','mental confusion','dull mind','dizziness','skin eruptions','low-grade fever','persistent fever','sepsis tendency','blood poisoning','vitiated blood','Echinacea','purple coneflower']),

-- Elecampane (54)
(54,
 'This herb is specific for chronically sick, feeble individuals with digestive and respiratory weakness. Often thought of in the elderly or bedridden, especially when they have a viral or bacterial infection in the lungs or intestines. However, it can be of benefit to anyone who has a digestive or respiratory infection. Think of it when there is a persistent cough with mucus.',
 ARRAY['chronic illness','feeble','elderly','bedridden','respiratory weakness','lung weakness','digestive weakness','cough','persistent cough','mucus in lungs','lung infection','intestinal infection','convalescence','debilitated','phlegm','productive cough']),

-- Eyebright (51)
(51,
 'Eyebright has an affinity for the eyes and upper respiratory tract. It is used for conjunctivitis symptoms with yellow, thick exudate and swollen, red eyes that are encrusted in the morning. The specific indication is acrid, watery discharge from the eyes with a bland discharge from the nose.',
 ARRAY['conjunctivitis','eye infection','pink eye','watery eyes','crusty eyes','morning eye crusting','yellow eye discharge','thick exudate','nasal discharge','sinusitis','hay fever','allergic rhinitis','lacrimation','eyes','upper respiratory','Euphrasia']),

-- False Hellebore / Veratrum (2608)
(2608,
 'False hellebore is indicated in full-blooded, plethoric persons with great prostration. The tongue is coated white or yellow with a red streak down the middle. The pulse is full and bounding.',
 ARRAY['plethoric','full-blooded','hypertension','full bounding pulse','prostration','collapse','red streak on tongue','white coated tongue','yellow coated tongue','vomiting','nausea','Veratrum','false hellebore','heart rate slowing','hypotensive']),

-- False Unicorn (2617)
(2617,
 'Heaviness and congestion in the pelvis with the sensation that the pelvic organs are falling out. The patient feels lumbar pain down the thighs and the back of the legs, restlessness and general weakness. The patient often has a history of hemorrhoids, varicose veins of the legs and labial varicosities.',
 ARRAY['pelvic heaviness','prolapse','uterine prolapse','organs falling out','lumbar pain','thigh pain','leg pain','restlessness','weakness','hemorrhoids','varicose veins','labial varicosities','pelvic floor weakness','bearing down sensation','Chamaelirium']),

-- Fenugreek (91)
(91,
 'The specific indication for fenugreek is cold damp swelling and stagnation in the legs. It also disperses cold and alleviates pain.',
 ARRAY['cold damp','swelling','edema','leg swelling','stagnation','lymphatic stagnation','phlegm','disperses cold','cold constitution','joint pain','cold damp conditions']),

-- Feverfew (121)
(121,
 'It is specific for nervous afflictions or pains where the condition seems to be related to unequal circulation causing too little or too much blood in an area of the body. It will equalize the blood flow.',
 ARRAY['migraine','unequal circulation','circulatory headache','blood flow imbalance','vascular headache','nerve pain','peripheral vasodilation','platelet aggregation','uneven blood distribution','headache prevention']),

-- Figwort (39)
(39,
 'Figwort is indicated with enlarged glands anywhere in the body, congested intestines and liver, hemorrhoids, drowsiness, vertigo and mental sluggishness. It can be beneficial with scrofulous skin conditions. The symptoms are worse when lying on the right side.',
 ARRAY['enlarged glands','lymphadenopathy','liver congestion','intestinal congestion','hemorrhoids','drowsiness','vertigo','mental sluggishness','scrofula','skin eruptions','worse lying on right side','lymphatic','venous congestion']),

-- Fringetree (24)
(24,
 'Specific indications are dirty, sallow skin with expressionless eyes, hepatic tenderness, nausea and vomiting, jaundice with itching skin, thin light-colored stools or constipation with dry feces. It is to be considered with pain under the right scapula, general lethargy and ailments induced by changes of the weather.',
 ARRAY['jaundice','hepatic','liver tenderness','sallow skin','expressionless','nausea','vomiting','light colored stools','clay stools','right scapula pain','lethargy','weather changes','gallbladder','bile duct','bilious','Chionanthus']),

-- Garlic (21)
(21,
 'Garlic stimulates digestion and cardiovascular circulation. It is indicated for dyspepsia, hypertension, arthritic pain and individuals with catarrhal affections. The tongue is pale with red papillae.',
 ARRAY['dyspepsia','indigestion','hypertension','high blood pressure','arthritic','arthritis','catarrh','catarrhal','pale tongue','pale tongue with red papillae','cardiovascular','antimicrobial','infection','cold','atherosclerosis']),

-- Gentian (102)
(102,
 'Gentian is indicated with lazy digestion with gastric pain, along with a tendency toward depression and exhaustion. It may have a picture of vertigo that is worse with motion and better in open air. Patients doubt their ability to make decisions or make correct choices in their lives.',
 ARRAY['lazy digestion','slow digestion','gastric pain','depression','exhaustion','vertigo','indecision','doubt','worse with motion','better in open air','bitter tonic','digestive weakness','lack of confidence','gastric atony']),

-- Cranesbill / Geranium (52)
(52,
 'Geranium is indicated for relaxed, atonic mucous membranes where the lack of tone or ulceration allows unchecked hemorrhage or other loss of fluids.',
 ARRAY['hemorrhage','bleeding','atonic mucous membranes','loss of fluids','relaxed tissues','uterine bleeding','diarrhea','astringent','tannin','cranesbill','wild geranium']),

-- Ginger (124)
(124,
 'Ginger is indicated for cold and congestive conditions with digestive, genitourinary or respiratory debility.',
 ARRAY['cold constitution','congestive','digestive debility','genitourinary debility','respiratory debility','nausea','vomiting','cold extremities','cold stomach','poor circulation','warming','circulatory stimulant']),

-- Ginkgo (165)
(165,
 'Ginkgo is indicated when the individual has debilitated peripheral circulation. Ginkgo has an affinity for endothelial tissues.',
 ARRAY['peripheral circulation','poor circulation','endothelial','blood vessel','vascular','cerebrovascular','memory','cognitive decline','tinnitus','vertigo','intermittent claudication','Raynaud''s','platelet aggregation']),

-- Ginseng Panax (14)
(14,
 'Ginseng is indicated for adrenal burnout with mental, nervous, emotional and physical exhaustion. The individual cannot adapt to stressful situations. Dry mucous membranes, hypotension and low blood sugar are often part of the symptoms.',
 ARRAY['adrenal burnout','exhaustion','cannot adapt','stress','adaptogen','hypotension','low blood pressure','low blood sugar','hypoglycemia','dry mucous membranes','nervous exhaustion','physical exhaustion','emotional exhaustion','qi deficiency','tonic']),

-- Goldenrod (58)
(58,
 'Goldenrod is indicated for mental weakness, physical exhaustion, chilliness alternating with heat, subacute nasopharyngeal catarrh and acute or subacute kidney infections or debilitated, chronically inflamed kidneys.',
 ARRAY['mental weakness','physical exhaustion','chilliness alternating with heat','nasopharyngeal catarrh','sinusitis','kidney infection','UTI','urinary tract infection','chronic kidney inflammation','kidney weakness','hay fever','allergic rhinitis','catarrhine']),

-- Goldenseal (30)
(30,
 'Goldenseal is indicated for relaxed, atonic mucous membranes with thick yellowish secretions. It is useful for debilitated individuals with poor digestion and constipation. The tongue is atonic, slightly pallid, enlarged, scalloped at the edges, with slight yellow coating, ulcerations and fissures. The person feels depressed and hypersensitive and may have a dull frontal headache or sinus headache. The symptoms are worse with heat of the sun, bright lights shining on the person, while stooping and with the sound of moving water.',
 ARRAY['atonic mucous membranes','thick yellow secretions','yellow discharge','constipation','debilitated','depression','hypersensitive','dull frontal headache','sinus headache','scalloped tongue','pale tongue','worse in sun','worse with bright light','worse stooping','worse with sound of water','digestive weakness','Hydrastis']),

-- Gotu Kola (2229)
(2229,
 'Gotu kola has a calming and supportive effect on the nervous system and calms the brain of mental chatter. It also supports connective tissue.',
 ARRAY['mental chatter','racing thoughts','nervous system','connective tissue','calming','anxiety','wound healing','skin repair','collagen','memory','cognitive','trophorestorative','adaptogen']),

-- Gravel Root (117)
(117,
 'Gravel root is indicated for irritable bladders, enlarged prostates and kidney afflictions related to high uric acid. It has specific indication for bone pains and deep dull pain in the kidneys with chills and pains running upward.',
 ARRAY['kidney stones','gravel','bladder irritability','prostate enlargement','BPH','uric acid','gout','kidney pain','deep dull kidney pain','chills','upward radiating pain','nephrolithiasis','urolithiasis','Joe pye weed']),

-- Guarana (218)
(218,
 'Headache with pallor, weak circulation, the pain aggravated by exertion; sick headache (migraine), with cerebral anemia; menstrual headache, with cerebral anemia; mental exhaustion or depression; headache from dissipation. Guarana is a remedy for the relief of nervous headache, or those forms following menstruation or drunkenness. The face is pale, the pulse feeble, the eyes dull and expressionless, and nausea is prominent. Every movement causes an aggravation of the pain, the patient is mentally weary, and cerebral anemia is always present.',
 ARRAY['migraine','sick headache','headache','cerebral anemia','menstrual headache','mental exhaustion','pallor','feeble pulse','dull eyes','nausea','worse with movement','hangover headache','post-menstrual headache','nervous headache','exertion headache']),

-- Gumweed / Grindelia (199)
(199,
 'Gumweed is specific for infectious respiratory conditions and asthma. The individuals stop breathing as they fall asleep and awaken with a start to gasp for breath. They cannot breathe while lying down.',
 ARRAY['asthma','respiratory','stop breathing during sleep','sleep apnea','orthopnea','cannot lie down','gasps for breath','awakens suddenly','infectious respiratory','bronchitis','Grindelia','rosinweed']),

-- Hawthorn (73)
(73,
 'Hawthorn is indicated for irritable, nervous heart conditions and heart ailments related to an emotional heartache or disconnection from spirit and in conjunction with weak or slow digestion. It helps open the heart to forgiveness of others or forgiveness of life events that may be keeping a person from healing. It is specific for all heart-related ailments. This herb is a source of nutrition and support for the heart.',
 ARRAY['heart','cardiac','nervous heart','irritable heart','emotional heartache','grief','forgiveness','disconnection','spiritual heart','weak digestion','heart failure','palpitations','arrhythmia','angina','atherosclerosis','hypertension','cardiac tonic','love','Crataegus']),

-- Hops (129)
(129,
 'Hops is indicated for an irritable digestive tract and nervous system. It is specific for nervousness with twitching or muscular irritability, indigestion and sleeplessness.',
 ARRAY['nervous system','digestive irritability','twitching','muscular irritability','indigestion','sleeplessness','insomnia','restlessness','nervous stomach','anxiety','IBS','irritable bowel']),

-- Horehound (160)
(160,
 'Horehound has an affinity for the respiratory tract and is indicated for congestion and copious discharges, especially if due to atonic mucous membranes.',
 ARRAY['respiratory','lung congestion','copious discharge','atonic mucous membranes','catarrh','expectorant','cough','bronchitis','mucus','phlegm','productive cough']),

-- Horse Chestnut (62)
(62,
 'Horse chestnut is specific for hemorrhoids due to portal vein obstruction and sharp shooting pains up the back. It is used for general congestion of tissues and atonic organs.',
 ARRAY['hemorrhoids','piles','portal hypertension','portal congestion','sharp shooting pain','back pain','venous congestion','varicose veins','venous insufficiency','edema','Aesculus']),

-- Horsetail (151)
(151,
 'Horsetail has specific indications for suppressed urination with blood, much mucus and severe pain at the close of urination. There is a constant feeling of fullness in the bladder not relieved by urinating. It benefits severely nervous individuals with a lack of confidence and a tendency towards chilliness. Problems are often associated with weakness of supportive structures, such as connective tissue. Pains are worse on right side, with movement, pressure or sitting. Pains are better in the afternoon and when lying down.',
 ARRAY['hematuria','blood in urine','painful urination','bladder fullness','incomplete emptying','UTI','urinary tract infection','chilliness','connective tissue weakness','right-sided pain','worse with movement','worse with pressure','better in afternoon','better lying down','silica','Equisetum','kidney stones']),

-- Hyssop (53)
(53,
 'Hyssop is indicated in infectious conditions of the lungs and digestive system. It is specific for chronic low-grade fevers with a rapid and flooding pulse. It is especially useful for children''s respiratory and digestive infections.',
 ARRAY['lung infection','digestive infection','low-grade fever','rapid pulse','flooding pulse','children''s illness','pediatric','respiratory infection','antimicrobial','expectorant','antiviral']),

-- Blue Flag / Iris (31)
(31,
 'Iris is specific for hepatic and splenic congestion due to venous or lymphatic stasis with soft, swollen nodes. People needing iris may have a red face that looks as if they were sunburnt. They may feel depressed due to feeling overly responsible for everything. Burning sensations anywhere between the mouth and the anus may be present. Symptoms are worse in the evening, at night and with rest. Symptoms are better with continual motion.',
 ARRAY['hepatic congestion','splenic congestion','venous stasis','lymphatic stasis','swollen nodes','red face','overly responsible','depression','burning sensations','worse in evening','worse at night','worse with rest','better with motion','portal congestion','left-sided','Blue Flag','Iris versicolor']),

-- Juniper (103)
(103,
 'Juniper helps bring clarity in confusing situations and is specific for atonic conditions of the gastrointestinal, respiratory and urinary tract.',
 ARRAY['clarity','confusion','atonic GI','atonic respiratory','atonic urinary','digestive atony','urinary atony','stimulating','warming','antiseptic','diuretic','gin','Juniperus']),

-- Lady''s Mantle (1014)
(1014,
 'Lady''s mantle is indicated for excessive moisture and prolapsed and herniated organs. It is specific for strengthening hollow organs.',
 ARRAY['prolapse','uterine prolapse','hernia','excessive moisture','leukorrhea','profuse discharge','hollow organs','strengthening','astringent','uterine tonic','damp constitution','incontinence','Alchemilla']),

-- Lavender (82)
(82,
 'It is specific for headache, muscle spasms, convulsions, stammering and symptoms due to nervousness related to a lack of circulation to the brain.',
 ARRAY['headache','muscle spasm','convulsion','stammering','stuttering','cerebral circulation','nervous','anxiety','relaxing','nervous headache','poor brain circulation','antispasmodic','antiepileptic']),

-- Privet / Ligustrum (274)
(274,
 'Ligustrum is indicated with kidney weakness, weak back and knees, hearing loss, blurred vision, constipation and immunological disorders. It is a yin tonic in Chinese medicine. Ligustrum is used to strengthen the whole body.',
 ARRAY['kidney weakness','weak back','weak knees','hearing loss','tinnitus','blurred vision','constipation','immune deficiency','yin deficiency','kidney yin','tonic','Ligustrum lucidum','privet','Nu Zhen Zi']),

-- Lily of the Valley (163)
(163,
 'Lily of the valley is indicated for heart weakness with valvular insufficiency, edema, dyspnea and venous stasis with a rapid and feeble pulse. The thoughts are dulled and the tongue is broad and thick with a heavy dirty coating that feels sore and scalded. The individual feels better in open air and worse in a warm room.',
 ARRAY['heart failure','valvular insufficiency','edema','dyspnea','breathlessness','venous stasis','rapid pulse','feeble pulse','dull thinking','mental dullness','worse in warm room','better in open air','congestive heart failure','cardiac glycosides','Convallaria']),

-- Linden flower (90)
(90,
 'Linden flower is indicated for hypertension associated with arteriosclerosis. The individual is worse in the afternoon and evening, in a warm room and heat of a bed. They are better in a cool room and with motion.',
 ARRAY['hypertension','high blood pressure','arteriosclerosis','atherosclerosis','worse in afternoon','worse in evening','worse in warm room','better in cool room','better with motion','nervous hypertension','anxious hypertension','Tilia','linden','lime tree','antispasmodic']),

-- Lobelia (132)
(132,
 'Lobelia is for conditions of a spasmodic nature. It is specific for dyspnea that increases with exertion and is aggravated by exposure to cold. It is used for spasmodic coughs like croup, whooping cough, bronchial asthma, bronchitis and pleurisy. It is used externally as well as internally as an antispasmodic. Internally it is given in small frequent doses. Too large of a dose will initiate vomiting. Externally, it is used as a liniment over the chest for spasmodic conditions of the lungs.',
 ARRAY['asthma','dyspnea','breathlessness','exertion aggravates','cold aggravates','croup','whooping cough','pertussis','bronchitis','pleurisy','antispasmodic','relaxant','emetic','nausea','spasmodic cough','airway spasm']),

-- Sticta / Lungwort (2618)
(2618,
 'The individual has a sense of dullness, confusion and malaise, as if the beginning of a cold. There is a dull, heavy pressure in the forehead with catarrh and pain through the chest from the sternum to the spinal column. The cough is worse towards evening and when tired and general symptoms are worse with sudden temperature changes. There may be rheumatic pains with spasms.',
 ARRAY['dullness','confusion','malaise','beginning of cold','frontal pressure','catarrh','forehead pressure','chest pain','sternum pain','cough worse in evening','cough when tired','worse with temperature changes','rheumatic','spasms','influenza early stage','Sticta','lichen','Lobaria']),

-- Marshmallow (45)
(45,
 'It is specific for inflammatory conditions.',
 ARRAY['inflammation','soothing','mucilaginous','anti-inflammatory','urinary inflammation','respiratory inflammation','gastric inflammation','cystitis','gastritis','esophagitis','demulcent','Althaea']),

-- Meadowsweet (75)
(75,
 'Burning and inflammation is a prevalent part of symptomatology.',
 ARRAY['burning','inflammation','gastric ulcer','acid reflux','GERD','heartburn','fever','anti-inflammatory','salicylate','aspirin-like','analgesic','Filipendula','meadowsweet']),

-- Milk Thistle (206)
(206,
 'It is specific for congestion and inflammation of the liver, spleen and kidneys accompanied by hemorrhagic tendencies. There is a dull aching pain over the spleen, passing up to the left scapula and pain in the right side over the liver. It is indicated for weak and congested veins, pelvic congestion, prolapse of organs and blood stasis leading to hemorrhage. The individual displays pronounced debility.',
 ARRAY['liver','spleen','kidney','hepatic','hemorrhagic tendency','spleen pain','left scapula pain','liver pain','venous weakness','pelvic congestion','prolapse','blood stasis','debility','cirrhosis','hepatitis','liver damage','silymarin','Silybum']),

-- Mistletoe (211)
(211,
 'It is specific for agitated or spasmodic muscles. The symptoms are worse in the winter, in cold, stormy weather, in bed, with movement and lying on the left side.',
 ARRAY['muscle spasm','agitated muscles','worse in winter','worse in cold','worse in stormy weather','worse in bed','worse with movement','worse lying on left side','antispasmodic','hypertension','left-sided','Viscum album']),

-- Motherwort (131)
(131,
 'Motherwort is used for melancholy, restlessness and disturbed sleep from emotional or physical ailments of the heart. It strengthens the heart.',
 ARRAY['melancholy','melancholic','restlessness','disturbed sleep','insomnia','emotional heart','heart pain','heart grief','heart palpitations','anxiety','nervous heart','cardiac','uterine tonic','Leonurus']),

-- Mugwort (115)
(115,
 'In small doses, mugwort strengthens the digestive and nervous system. It is specific for coldness, stiffness and spasms.',
 ARRAY['coldness','cold constitution','stiffness','spasm','digestive weakness','nervous weakness','moxibustion','emmenagogue','delayed menstruation','cold damp','Artemisia']),

-- Mullein (61)
(61,
 'It is indicated for dry, harsh, hacking coughs, as well as coughs with congestion, weak lungs, kidneys and nervous system. Symptoms are worse with a change of temperature, talking, sneezing and from 9 a.m. to 4 p.m.',
 ARRAY['dry cough','hacking cough','harsh cough','productive cough','weak lungs','lung weakness','kidney weakness','nervous weakness','worse with temperature change','worse talking','worse sneezing','worse 9am-4pm','Verbascum','expectorant']),

-- Myrrh (99)
(99,
 'It is indicated for weak, inefficient capillary circulation, cold skin, weak pulse with catarrh and putrid conditions.',
 ARRAY['capillary circulation','cold skin','weak pulse','catarrh','putrid','infection','sepsis','antiseptic','antimicrobial','wounds','ulcers','gum disease','oral infection','Commiphora']),

-- Oat milky (178)
(178,
 'It is indicated in nervous states with exhaustion, inability to concentrate, melancholy, diminished strength of limbs or numbness of limbs, occipital headache extending down the spine, as well as into the head.',
 ARRAY['nervous exhaustion','mental exhaustion','inability to concentrate','melancholy','weakness of limbs','numbness','occipital headache','headache extending to spine','trophorestorative','nerve tonic','burnout','adrenal fatigue','Avena sativa','milky oats']),

-- Oregon Grape / Barberry (33)
(33,
 'Oregon grape root should be considered when there is a picture of atonic mucous membranes and lack of strength and fatigue, especially when associated with digestive problems. The individual may have both nausea and hunger after eating. It is specific for low grade internalized heat or infectious conditions, headaches starting in the occiput and spreading over the right side of the head to the eyes, with bulging blood vessels in the temples and the tongue thickly coated with yellowish-brown coating.',
 ARRAY['atonic mucous membranes','fatigue','weakness','digestive problems','nausea after eating','hungry after eating','low-grade heat','liver','infectious','occipital headache','right-sided headache','temple pain','bulging temporal vessels','yellowish-brown tongue coating','berberine','Mahonia','Oregon grape']),

-- Osha (104)
(104,
 'It is indicated for a dull mind that is forgetful, sinuses full, head feels clogged with mucus and easily catches a cold or often has influenza symptoms.',
 ARRAY['forgetfulness','dull mind','sinus congestion','sinusitis','head congestion','mucus','frequent colds','influenza tendency','respiratory','antiviral','lung','Ligusticum','loveroot']),

-- Partridgeberry / Mitchella (188)
(188,
 'Partridge berry is indicated in generalized edema, mental dullness, backache, uterine congestion, dark, red, swollen cervix, dysmenorrhea and uterine bleeding with bright red blood.',
 ARRAY['edema','water retention','mental dullness','backache','uterine congestion','cervicitis','swollen cervix','dysmenorrhea','menstrual cramps','uterine bleeding','bright red blood','squaw vine','Mitchella repens']),

-- Passionflower (137)
(137,
 'It is indicated for conditions where there is restless agitation and exhaustion with muscular twitching or tendency towards spasms. The tongue is not coated.',
 ARRAY['restless agitation','exhaustion','muscular twitching','spasm tendency','clean tongue','uncoated tongue','insomnia','anxiety','nervous exhaustion','hypnotic','sedative','antispasmodic','Passiflora']),

-- Pennyroyal (135)
(135,
 'Specific indications for pennyroyal are thin white coating on the tongue, congested pelvic organs and bearing down pains which are worse with slight movement.',
 ARRAY['white tongue coating','pelvic congestion','bearing down pain','worse with slight movement','emmenagogue','delayed menstruation','pelvic heaviness','uterine congestion','Mentha pulegium','Hedeoma']),

-- Peppermint (55)
(55,
 'Peppermint is specific for spasmodic conditions of the respiratory, digestive and urinary tracts.',
 ARRAY['spasm','colic','IBS','irritable bowel','intestinal spasm','respiratory spasm','urinary spasm','gas','flatulence','nausea','indigestion','antispasmodic','carminative','Mentha piperita']),

-- Pipsissewa (2239)
(2239,
 'Pipsissewa is indicated for chronic genitourinary tract catarrh with lymphatic congestion. Symptoms are worse from damp weather, sitting on cold surfaces, and worse on the left side of the body.',
 ARRAY['genitourinary catarrh','chronic UTI','lymphatic congestion','worse in damp','worse sitting on cold','left-sided','urinary catarrh','prostatitis','Chimaphila','prince''s pine']),

-- Pleurisy Root (67)
(67,
 'Pleurisy root is indicated for hot, dry skin and difficult, painful breathing accompanying a fever and chest pains that are relieved by bending forward.',
 ARRAY['pleurisy','hot dry skin','difficult breathing','painful breathing','fever','chest pain','bending forward relieves','diaphoretic','expectorant','respiratory','Asclepias tuberosa','butterfly weed']),

-- Poke Root (35)
(35,
 'Poke is specific for a congested lymphatic system with hard, swollen lymph nodes. There is a tendency to be large, flabby, slow moving, tired and often have an indifference to life or social etiquette. If accompanied by a high fever, the glands may be swollen and painful and the skin may be dry with purple coloration in stagnant areas and a fast pulse. Poke has an affinity for red swollen inflamed tissue of the throat, mammary glands and testicles.',
 ARRAY['lymphatic','swollen lymph nodes','hard lymph nodes','slow moving','flabby','indifferent','high fever','purple skin coloration','fast pulse','throat infection','tonsillitis','mammary glands','breast lumps','mastitis','testicular swelling','Phytolacca']),

-- Prickly Ash (123)
(123,
 'Prickly ash is indicated in relaxed, feeble conditions found with atonic digestive states where it improves digestion and circulation. It is specific for neuralgic pains.',
 ARRAY['neuralgia','nerve pain','neuralgic','atonic digestion','feeble','relaxed tissues','poor digestion','poor circulation','Raynaud''s','toothache','trigeminal neuralgia','Zanthoxylum']),

-- Pasqueflower / Pulsatilla (36)
(36,
 'Often the person who responds to pulsatilla will have nervous conditions like fearfulness, general nervousness, feels dejected, emotional lability, and weeps easily. Often the person feels exhausted and perceives that they are not in control. They may have heart palpitations and insomnia. The individual is gentle, with a yielding disposition, and has changeable symptoms and moods. The body discharges are often yellow. The person needing pulsatilla can be comforted while the person needing chamomile cannot.',
 ARRAY['tearful','weepy','fearful','nervous','dejected','emotional lability','mood changes','yields easily','gentle disposition','palpitations','insomnia','yellow discharges','changeable symptoms','desires comfort','thirstless','cold better','warm worse','Pulsatilla']),

-- Queen''s Delight / Stillingia (41)
(41,
 'Queen''s root is indicated for chronic laryngeal irritation, chronic bronchitis, enlarged cervical lymphatic nodes and congested lymphatics in general. It is specific for red, glistening mucous membranes with scanty secretion. The tongue has a white or yellow coating. There is a feeling of gloom, foreboding and dull mindedness. Symptoms are worse in afternoons, damp air and with motion and better in the morning and dry air.',
 ARRAY['laryngeal irritation','laryngitis','chronic bronchitis','cervical lymph nodes','lymphatic congestion','red glistening mucous membranes','scanty secretion','gloom','foreboding','dull mind','worse in afternoon','worse in damp air','worse with motion','better in morning','better in dry air','Stillingia']),

-- Red Clover (42)
(42,
 'It is indicated for debilitated individuals with spasmodic coughs, salivary gland congestion, pharyngeal inflammation and chronic skin eruptions. Red clover is specific for swollen hard nodes, especially for single nodes and a stiff neck with cramping in the sternocleidomastoid muscles that is relieved by heat and massage.',
 ARRAY['debilitated','spasmodic cough','salivary gland congestion','pharyngeal inflammation','skin eruptions','hard lymph nodes','single node','stiff neck','sternocleidomastoid','SCM cramping','relieved by heat','relieved by massage','isoflavones','Trifolium']),

-- Red Root (981)
(981,
 'It is indicated for stagnation of fluids, turbid lymph, mucus, swollen glands and poor nutrition to the tissues. Consider red root when the person is melancholic and the tongue is enlarged, swollen, with a dirty white or yellow coating.',
 ARRAY['fluid stagnation','turbid lymph','lymphatic stagnation','swollen glands','poor tissue nutrition','melancholic','enlarged tongue','swollen tongue','dirty white coating','yellow coating','spleen','liver','portal congestion','Ceanothus','New Jersey tea']),

-- Rhubarb (154)
(154,
 'Rhubarb is indicated for people who smell sour or have sour smelling feces. Symptoms are worse from uncovering the body, after eating and moving. The tongue is elongated and reddened at the tip and edges.',
 ARRAY['sour smell','sour feces','malodorous','worse uncovering','worse after eating','worse moving','elongated tongue','red tongue tip','red tongue edges','constipation','diarrhea','laxative','cathartic','Rheum']),

-- Rhodiola (16)
(16,
 'For people who show early aging and individuals who are exhausted, anxious, depressed and burnt out.',
 ARRAY['burnout','exhaustion','anxiety','depression','early aging','premature aging','adaptogen','stress','fatigue','mental fatigue','cognitive fatigue','antidepressant','anxiolytic','Rhodiola rosea']),

-- Rue (110)
(110,
 'Rue is indicated for sprains, especially flexor tendon sprains, deposits in joints, especially the wrist, bruised sensations, bruised bones and feeling of weakness and despair. It is beneficial for all injuries of the periosteum and cartilage. Symptoms are worse lying down and from cold and wet weather.',
 ARRAY['sprain','tendon sprain','flexor tendon','joint deposits','wrist pain','bruised sensation','bruised bones','periosteum injury','cartilage injury','weakness','despair','worse lying down','worse cold and wet','eye strain','Ruta graveolens']),

-- Sage (56)
(56,
 'For people with relaxed and poor circulation with excessive sweating.',
 ARRAY['excessive sweating','hyperhidrosis','night sweats','hot flashes','menopause sweating','poor circulation','relaxed constitution','astringent','antihidrotic','menopausal','Salvia officinalis']),

-- Saw Palmetto (186)
(186,
 'Saw palmetto is indicated for wasting of sexual organs, lack of sexual desire, and underdeveloped breasts in women.',
 ARRAY['wasting','sexual organ wasting','low libido','lack of sexual desire','underdeveloped breasts','reproductive tonic','BPH','prostate','anabolic','trophorestorative','Serenoa repens']),

-- Schisandra (17)
(17,
 'Schisandra is indicated for weak lungs, digestion, liver and immune system with night sweats, prolonged diarrhea, chronic coughs, amnesia and general overall weakness with inability to hold moisture in the body (ie: sweats, nocturnal emissions, morning diarrhea, and frequent urination). There is a lack of both physical and mental energy.',
 ARRAY['night sweats','diarrhea','chronic cough','amnesia','memory loss','weakness','inability to hold moisture','nocturnal emissions','frequent urination','lung weakness','liver weakness','immune deficiency','exhaustion','five flavors','Wu Wei Zi','Schisandra chinensis']),

-- Senna (216)
(216,
 'Senna is indicated for constipation with lack of muscular action, flatulence, colic and enlarged, tender liver.',
 ARRAY['constipation','atonic constipation','flatulence','gas','colic','enlarged liver','tender liver','laxative','cathartic','Senna alexandrina','Cassia']),

-- Shepherd''s Purse (71)
(71,
 'Shepherd''s purse is indicated for atony and prolapse of pelvic organs and passive bleeding.',
 ARRAY['prolapse','uterine prolapse','pelvic floor','passive bleeding','uterine atony','hemorrhage','postpartum bleeding','menorrhagia','hemostatic','astringent','Capsella bursa-pastoris']),

-- Siberian Ginseng (9)
(9,
 'Eleutherococcus is indicated for conditions resulting from stressful situations where the individual is unable to adapt. There is general fatigue, weakness, and decreased physical and mental capability with depressed mood and lack of concentration.',
 ARRAY['stress','cannot adapt','fatigue','weakness','burnout','adaptogen','low concentration','depressed mood','physical and mental exhaustion','immune support','Eleutherococcus senticosus','Siberian ginseng','eleuthero']),

-- Skullcap (142)
(142,
 'Skullcap is indicated when there is nervous fear, restless sleep, cardiac irritability and spasms. There may be inability to pay attention and a dull frontal headache or headache at the base of the brain. Symptoms are worse with noise, odors and light and better at night and with rest. This bitter plant is perfect for the person who has a nervous stomach and has digestive stagnation.',
 ARRAY['nervous fear','restless sleep','insomnia','cardiac irritability','spasms','inability to concentrate','attention deficit','dull frontal headache','occipital headache','worse with noise','worse with odors','worse with light','nervous stomach','digestive stagnation','anxiety','twitching','Scutellaria lateriflora']),

-- St. John''s Wort (81)
(81,
 'St. John''s wort is specific for injuries to the spinal cord and nerves, including nerve injuries to fingers and toes. It is to be considered with all chronic pain in conjunction with emotional and nervous exhaustion; physical and mental weakness or pain with a sharp shooting characteristic sensation, indicative of nerve pain.',
 ARRAY['nerve injury','spinal cord injury','neuropathy','shooting pain','sharp nerve pain','finger nerve injury','toe nerve injury','chronic pain','emotional exhaustion','nervous exhaustion','physical weakness','mental weakness','nerve damage','Hypericum perforatum','depression','antidepressant']),

-- Stinging Nettle leaf (43)
(43,
 'It is indicated for profuse discharges from mucous membranes, sensations of heat and itching. Nettle favors elimination of uric acid. Nettle benefits the spleen. Symptoms are worse from very cold air, water, cool moist air, touch and the symptoms return at the same time each year.',
 ARRAY['profuse discharge','mucous membrane discharge','heat sensation','itching','uric acid','gout','spleen','seasonal allergies','hay fever','allergic rhinitis','worse cold air','worse cool moist','worse touch','annual return of symptoms','urticaria','hives','Urtica dioica']),

-- Stone Root (182)
(182,
 'Stone root is indicated for portal congestion causing constipation, hemorrhoids and chronic nasal, gastric and pharyngeal catarrh. The individual may suffer from a dull frontal headache, yellow-coated tongue and itching anus. They may have a sense of constriction and weight, with heat in the rectum and dry feces if hemorrhoids are the problem. Symptoms are worse from the slightest emotion or excitement and from cold and better from heat.',
 ARRAY['portal congestion','constipation','hemorrhoids','nasal catarrh','gastric catarrh','pharyngeal catarrh','dull frontal headache','yellow tongue','itching anus','constriction','rectal heat','dry feces','worse with emotion','worse with excitement','worse cold','better heat','Collinsonia canadensis']),

-- Thyme (59)
(59,
 'Thyme is indicated for spasmodic conditions of the respiratory and urinary tract with infectious symptoms.',
 ARRAY['respiratory spasm','urinary spasm','infection','antimicrobial','antifungal','expectorant','antispasmodic','bronchitis','cough','UTI','urinary infection','thymol','Thymus vulgaris']),

-- Turmeric (203)
(203,
 'Turmeric is indicated for mental dullness or confusion, congestion in the pelvis, liver or gastrointestinal tract.',
 ARRAY['mental dullness','confusion','foggy brain','brain fog','pelvic congestion','liver congestion','GI congestion','digestive congestion','anti-inflammatory','curcumin','liver protective','Curcuma longa']),

-- Usnea (112)
(112,
 'Usnea is indicated for infectious conditions with fever.',
 ARRAY['infection','fever','antimicrobial','antibacterial','antifungal','respiratory infection','Streptococcus','Staphylococcus','lung infection','Usnea spp.','lichen','old man''s beard']),

-- Bearberry / Uva Ursi (46)
(46,
 'Uva ursi is indicated for atonic, chronic conditions and infectious conditions of the urinary tract.',
 ARRAY['UTI','urinary tract infection','cystitis','chronic urinary','atonic bladder','urinary antiseptic','arbutin','kidney infection','urolithiasis','Arctostaphylos uva-ursi','bearberry','kinnikinnick']),

-- Valerian (145)
(145,
 'Valerian is specific for support of atonic and functional nervous disorders and situations arising from cerebral vascular insufficiency. The individual may feel intoxicated, have a tendency to be weak, pale, have personality changes, be agitated, feel light, as if floating in air, oversensitive, and experience hallucinations at night. There may be symptoms of itching and muscle spasms at night and rheumatic pains in limbs with sciatica and jerking.',
 ARRAY['nervous disorders','atonic nervous system','cerebrovascular insufficiency','intoxicated feeling','weak','pale','personality changes','agitated','floating sensation','oversensitive','hallucinations at night','night itching','nocturnal muscle spasms','rheumatic pain','sciatica','jerking','insomnia','anxiety','Valeriana officinalis']),

-- Vervain (146)
(146,
 'Vervain is indicated for nervous symptoms due to mental or physical overexertion with spasms in general, especially in the neck and back due to overexertion. The individual is usually strong-willed.',
 ARRAY['overexertion','mental overexertion','physical overexertion','neck spasm','back spasm','strong-willed','perfectionist','overachiever','nervous exhaustion','tense','rigid','stiff neck','tension headache','Verbena officinalis']),

-- White Oak (2241)
(2241,
 'White oak bark is indicated in subacute and chronic conditions with exhaustion from disease, fevers, night sweats, ulcerations, relaxed and atonic tissues, prolapsed organs and putrid states. Specific symptoms are nervous and related problems and the person feels broken down but still manages to go on. The face is flushed and the eyes are puffy and have a yellow coloration under them. The tongue has a thick yellow coat, and they have terrible breath. There may be a bluish coloration to the tongue and lips. A swollen spleen and liver is common with edema of the lower extremities.',
 ARRAY['exhaustion from disease','chronic illness','night sweats','ulcerations','atonic tissues','prolapse','putrid','broken down','flushed face','puffy eyes','yellow around eyes','thick yellow tongue coating','terrible breath','bluish tongue','bluish lips','swollen spleen','liver swelling','lower extremity edema','Quercus alba']),

-- Wild Cherry Bark (140)
(140,
 'Wild cherry is indicated when there is need to nourish and tonify the digestive or respiratory system.',
 ARRAY['nourishing','tonifying','digestive tonic','respiratory tonic','cough suppressant','antitussive','astringent','relaxing','Prunus serotina','chokecherry']),

-- Wild Indigo (23)
(23,
 'Wild indigo is indicated when the pulse is intermittent, black or blue tongue, lack of blood flow to an area causing dusky colored tissues, ulcerations, putrid and offensive excretions, foul breath and muscle soreness. The individual may experience confusion, delirium, muttering, indifference to everything and sleep, even stuporous, melancholy. The mind may wander and it may be hard to think.',
 ARRAY['sepsis','blood poisoning','intermittent pulse','blue tongue','black tongue','dusky skin','cyanosis','ulcerations','putrid discharges','foul breath','muscle soreness','confusion','delirium','stupor','melancholy','wandering mind','mental confusion','infection','Baptisia tinctoria']),

-- Wild Yam (74)
(74,
 'Wild yam is indicated for spasmodic, shooting, aching or shifting pain. It is specific for pains due to excited nervous system and hip joint pain that keeps the individual awake at night. Symptoms are worse in the evening and night, lying down and bending double and better standing erect, with motion in open air and with pressure.',
 ARRAY['spasmodic pain','shooting pain','shifting pain','aching pain','hip joint pain','nerve excitation','night pain','keeps awake at night','worse evening','worse night','worse lying down','worse bending double','better standing erect','better with motion','better in open air','better with pressure','antispasmodic','Dioscorea villosa']),

-- Witch Hazel (79)
(79,
 'Witch hazel is indicated for venous congestion with hemorrhage, varicose veins and hemorrhoids with bruised soreness of the affected parts.',
 ARRAY['venous congestion','hemorrhage','varicose veins','hemorrhoids','bruised soreness','venous insufficiency','phlebitis','astringent','hemostatic','Hamamelis virginiana']),

-- Yarrow (44)
(44,
 'The individual feels restless, has vertigo when moving slowly and feels as if something is forgotten, the mind is dulled. The head seems congested. Yarrow is specific for fevers where the skin is hot, dry and the patient is restless and delirious. It is best for atonic and relaxed tissues where there is free discharge or massive bleeding of bright red blood, or diarrhea. The tongue is red, the complexion sanguine, the pulse is rapid and usually full.',
 ARRAY['restless','vertigo','forgetful','dull mind','congested head','fever','hot dry skin','delirium','free discharge','massive bleeding','bright red blood','diarrhea','red tongue','sanguine complexion','rapid pulse','full pulse','diaphoretic','hemostatic','Achillea millefolium']),

-- Yellow Dock (37)
(37,
 'Yellow dock is indicated for numerous and various pains that change locations and sensations, coughing due to tickling in the throat and a cough that is worse with cold air. The tongue is red, elongated, pointed, sore at the edges and there is a sensation of a hard pit in the stomach. Symptoms are worse in the evening, from inhaling cold air, in the left side of the chest and from uncovering.',
 ARRAY['wandering pain','shifting pain','tickling cough','cough worse cold air','red tongue','elongated tongue','pointed tongue','sore tongue edges','hard pit in stomach','epigastric fullness','worse in evening','worse with cold air','left-sided chest','worse uncovering','iron deficiency','alterative','Rumex crispus']),

-- Yerba Mansa (309)
(309,
 'Yerba mansa is indicated for catarrhal states.',
 ARRAY['catarrh','mucous membrane catarrh','sinus catarrh','respiratory catarrh','genitourinary catarrh','chronic catarrh','Anemopsis californica']),

-- Yerba Santa (590)
(590,
 'Yerba santa is indicated for respiratory and digestive weakness.',
 ARRAY['respiratory weakness','digestive weakness','expectorant','respiratory tonic','lung weakness','asthma','bronchitis','chronic respiratory','Eriodictyon californicum','holy herb']);
