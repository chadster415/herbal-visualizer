-- Add **bold** markdown to key clinical indicators in each herb's mental_picture.
-- Renders as <strong> in the UI via inline markdown parsing.

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Arnica is specific for **traumatic injury** symptoms or similar conditions where there is **bruising of tissues** with blue and red coloration as seen in a new bruise. It is also specific for symptoms due to **severe mental trauma**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Arnica' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'This herb is indicated to weakened individuals with **night sweats**, **prolapsing organs**, **frequent infectious illnesses**, **poor digestion and nutritional status** and a **general lack of vitality**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Astragalus' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'The mental picture of this herb is one of moving from **sleeplessness**, **despondency**, **irritability**, or **indifference**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Bayberry' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Uva ursi is indicated for **atonic, chronic conditions** and **infectious conditions of the urinary tract**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Bearberry' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Monarda is indicated in **infectious conditions of the lungs, digestive system and urinary tract**. It is specific for **chronic low-grade fevers** with a **rapid and flooding pulse**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Bee Balm' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Consider black cohosh when there are **spasms, achy pains, chilliness, fevers**, **nervous system irritation or excitement**, **depression of a deep, dark, brooding, withdrawn and heavy nature**, **incessant talking** and **neuralgia**. It is specific for **headaches in the late luteal phase** associated with **low estrogen levels**. Many symptoms are worse in the morning, during menses and with cold applications. Symptoms are better with warmth and after eating. Black cohosh is indicated for **traumas to the nervous system** that create congestion and pain. These traumas can be physical such as in a car accident or they can be mental/emotional such as **sexual abuse** of children where there may or may not be physical trauma but there is almost always mental/emotional trauma.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Black Cohosh' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'The picture of blue cohosh is one of **heavy, achy, spasmodic uterine pain** with **congestion and prolapsed, lax tissues**, **pain in the thighs and lower back**, spasmodic muscular pains, rheumatic pains and a **dull frontal headache with thirst**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Blue Cohosh' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Iris is specific for **hepatic and splenic congestion** due to **venous or lymphatic stasis** with **soft, swollen nodes**. People needing iris may have a **red face** that looks as if they were sunburnt. They may feel **depressed due to feeling overly responsible** for everything. **Burning sensations anywhere between the mouth and the anus** may be present. Symptoms are **worse in the evening, at night and with rest**. Symptoms are **better with continual motion**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Blue Flag' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Boneset is used for **influenza and colds** with **night sweats**, **aching in both muscles and bones**, **fever** and a **full, large pulse**. The **tongue is coated white with a bitter taste**. Tea form is optimal for colds and influenza.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Boneset' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'It influences the skin, kidneys, liver, gall bladder, and mucous and serous membranes to induce removal of accumulated by-products of **catabolism**. Burdock helps cool off **hot tempered, irritable people**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Burdock' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Calendula is indicated when the individual feels **worse in damp, heavy, cloudy weather**. It is specific for **wounds that will not heal** and **lymphatic congestion** with a predilection for the **chest, axilla and inguinal crease**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Calendula' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'The mental picture of cayenne is **cold, flabby, sluggish individuals**, with **jerking, aching muscles** and **stagnation in the cardiovascular system**. There is **exhausted vitality**, especially exhaustion from mental work and poor living. The symptoms become **better with heat and when eating**, **worse in open air and breeze**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Cayenne' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'The mental picture is one of **general lethargy**. There is a tendency towards **anxiety**, and ailments brought on or renewed by **weather changes**. It is specific for conditions of a **bilious nature**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Celandine' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'This nervine is specific for **neural irritability** in persons with a strong and active nervous system. Chamomile is superb at decreasing inflammatory states in the nervous system. Mental picture is **restless, irritable, sensitive, complaining**, wants to have their way, argumentative, acting like a baby and **cannot be comforted**. **Pains are unbearable** to them. They are **hot, thirsty and numb**. The pulse is tense and rapid. The **tongue is coated whitish-yellow** and they note a bitter taste. Discharges tend to be yellow. Symptoms are **worse on the right side**, with motion, touch, change of weather and in the early morning. They are **better after dinner and with pressure**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Chamomile' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Cinnamon warms and strengthens organs of digestion. It is beneficial for persons with **low vitality** and a **tendency toward influenza**. It is also for symptoms of **stress with a tendency to diarrhea** and **rheumatic pains**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Cinnamon' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Due to its vulnerary action, cleavers can be helpful on **ulcerated surfaces** and is specific for **tumors and ulcers in the mouth and throat**. It is also beneficial for **swollen glands and cysts**. Cleavers is useful for **skin irritations with an affinity for flexor surfaces** like the bend of the forearm, the axilla and the back of the knees.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Cleavers' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Used for the woman who feels **menstruation is about to start, but it does not**. She may also have **nervous chills**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Cotton Root Bark' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Cramp bark can be used for most spasmodic pains but is specific for **spasmodic and congestive conditions of the female genitourinary tract**. It is indicated when **pelvic pains extend down the thighs** and are accompanied by **nausea**. The spasms are usually **worse lying on the affected side, in warm rooms and in the evening**, and **better in open air and from resting**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Cramp Bark' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Geranium is indicated for **relaxed, atonic mucous membranes** where the lack of tone or ulceration allows **unchecked hemorrhage or other loss of fluids**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Cranesbill' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Dandelion is indicated for persons with a **mapped tongue** (a tongue with white coating that comes off in places leaving a red raw tongue in these areas), **yellow tongue**, **white tongue**, **bitter taste in the mouth** and **pain in the sternocleidomastoid muscle**. It is specific for **low-grade internalized heat or infectious conditions**, especially if related to allergies. **Night sweats** occur at the top of the head, heat without thirst. **Edema or boggy mucous membranes** may be present. There is often a history of **chemical insult or other environmental assaults pointing to liver involvement**. The person may feel **angry, agitated, nervous and dull-minded**. The individual''s symptoms are worse from resting, sitting and lying, and feel better from touch. Dandelion is supportive of the solar plexus and all manners of disease that arise in the 3rd chakra.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Dandelion' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'The mental picture includes **worn out, timid individuals** who lack mental and emotional strength and vitality. The individuals **cannot adapt to stressful situations** and feel **oppressed and unable to stand up for themselves**. This herb lends a sense of **invigoration and strength** on a physical, emotional, mental and spiritual level. This strong perennial warrior of a plant is quite impressive in person. She is a tribal warrior, living in a devil''s club community that is interconnected by their root/limbs. She has a coat of prickly armor to protect her. When you become her friend she will take you into her tribe and protect you as well. If you open to her, she will teach you to protect yourself. She is found deep in wooded areas near streams or other sources of water.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Devil''s Club' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Dong quai is beneficial for **gynecological complaints** with **spasms and pain**, **chills**, **dryness of skin**, **constipation due to dryness** and **uterine or ovarian masses**. It is also indicated for **congestion in the pelvic region**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Dong Quai' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Echinacea is indicated for **exhaustive states with chilliness**, **offensive discharges**, **lymphatic congestion with swollen glands**, **mental confusion, dull mind, dizziness** and a tendency to **skin eruptions** and **low grade continuous fevers**, although they can be high grade fevers.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Echinacea' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'This herb is specific for **chronically sick, feeble individuals** with **digestive and respiratory weakness**. Often thought of in the **elderly or bedridden**, especially when they have a **viral or bacterial infection in the lungs or intestines**. However, it can be of benefit to anyone who has a digestive or respiratory infection. Think of it when there is a **persistent cough with mucus**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Elecampane' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Eyebright has an affinity for the eyes and upper respiratory tract. It is used for **conjunctivitis** symptoms with **yellow, thick exudate** and **swollen, red eyes that are encrusted in the morning**. The specific indication is **acrid, watery discharge from the eyes** with a **bland discharge from the nose**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Eyebright' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'**Heaviness and congestion in the pelvis** with the sensation that the **pelvic organs are falling out**. The patient feels **lumbar pain down the thighs** and the back of the legs, restlessness and general weakness. The patient often has a history of **hemorrhoids, varicose veins of the legs and labial varicosities**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'False Unicorn' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'The specific indication for fenugreek is **cold damp swelling and stagnation in the legs**. It also **disperses cold and alleviates pain**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Fenugreek' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'It is specific for nervous afflictions or pains where the condition seems to be related to **unequal circulation** causing too little or too much blood in an area of the body. It will **equalize the blood flow**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Feverfew' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Figwort is indicated with **enlarged glands** anywhere in the body, **congested intestines and liver**, **hemorrhoids**, **drowsiness, vertigo** and **mental sluggishness**. It can be beneficial with **scrofulous skin conditions**. The symptoms are **worse when lying on the right side**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Figwort' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Specific indications are **dirty, sallow skin** with **expressionless eyes**, **hepatic tenderness**, **nausea and vomiting**, **jaundice with itching skin**, **thin light-colored stools** or **constipation with dry feces**. It is to be considered with **pain under the right scapula**, **general lethargy** and ailments induced by changes of the weather.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Fringetree' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Garlic stimulates digestion and cardiovascular circulation. It is indicated for **dyspepsia**, **hypertension**, **arthritic pain** and individuals with **catarrhal affections**. The **tongue is pale with red papillae**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Garlic' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Gentian is indicated with **lazy digestion** with **gastric pain**, along with a tendency toward **depression and exhaustion**. It may have a picture of **vertigo that is worse with motion** and better in open air. Patients **doubt their ability to make decisions** or make correct choices in their lives.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Gentian' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Ginger is indicated for **cold and congestive conditions** with **digestive, genitourinary or respiratory debility**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Ginger' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Ginkgo is indicated when the individual has **debilitated peripheral circulation**. Ginkgo has an affinity for **endothelial tissues**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Ginkgo' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Ginseng is indicated for **adrenal burnout** with **mental, nervous, emotional and physical exhaustion**. The individual **cannot adapt to stressful situations**. **Dry mucous membranes**, **hypotension** and **low blood sugar** are often part of the symptoms.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Ginseng' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Goldenrod is indicated for **mental weakness**, **physical exhaustion**, **chilliness alternating with heat**, **subacute nasopharyngeal catarrh** and **acute or subacute kidney infections** or **debilitated, chronically inflamed kidneys**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Goldenrod' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Goldenseal is indicated for **relaxed, atonic mucous membranes** with **thick yellowish secretions**. It is useful for **debilitated individuals with poor digestion and constipation**. The tongue is **atonic, slightly pallid, enlarged, scalloped at the edges, with slight yellow coating, ulcerations and fissures**. The person feels **depressed and hypersensitive** and may have a **dull frontal headache or sinus headache**. The symptoms are **worse with heat of the sun, bright lights shining on the person, while stooping and with the sound of moving water**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Goldenseal' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Gotu kola has a calming and supportive effect on the nervous system and **calms the brain of mental chatter**. It also supports **connective tissue**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Gotu Kola' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Gravel root is indicated for **irritable bladders**, **enlarged prostates** and **kidney afflictions related to high uric acid**. It has specific indication for **bone pains** and **deep dull pain in the kidneys** with **chills and pains running upward**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Gravel Root' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'**Headache with pallor**, weak circulation, the pain aggravated by exertion; **sick headache (migraine)**, with **cerebral anemia**; **menstrual headache**, with cerebral anemia; **mental exhaustion or depression**; headache from dissipation. Guarana is a remedy for the relief of **nervous headache**, or those forms following menstruation or drunkenness. The **face is pale**, the **pulse feeble**, the **eyes dull and expressionless**, and **nausea is prominent**. **Every movement causes an aggravation** of the pain, the patient is mentally weary, and **cerebral anemia is always present**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Guarana' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Gumweed is specific for **infectious respiratory conditions and asthma**. The individuals **stop breathing as they fall asleep** and **awaken with a start to gasp for breath**. They **cannot breathe while lying down**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Gumweed' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Hawthorn is indicated for **irritable, nervous heart conditions** and heart ailments related to an **emotional heartache or disconnection from spirit** and in conjunction with **weak or slow digestion**. It helps open the **heart to forgiveness** of others or forgiveness of life events that may be keeping a person from healing. It is specific for **all heart-related ailments**. This herb is a source of nutrition and support for the heart.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Hawthorn' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Hops is indicated for an **irritable digestive tract and nervous system**. It is specific for **nervousness with twitching or muscular irritability**, **indigestion and sleeplessness**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Hops' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Horehound has an affinity for the respiratory tract and is indicated for **congestion and copious discharges**, especially if due to **atonic mucous membranes**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Horehound' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Horse chestnut is specific for **hemorrhoids due to portal vein obstruction** and **sharp shooting pains up the back**. It is used for **general congestion of tissues and atonic organs**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Horse Chestnut' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Horsetail has specific indications for **suppressed urination with blood**, **much mucus** and **severe pain at the close of urination**. There is a **constant feeling of fullness in the bladder not relieved by urinating**. It benefits severely **nervous individuals with a lack of confidence** and a **tendency towards chilliness**. Problems are often associated with **weakness of supportive structures**, such as connective tissue. Pains are **worse on right side, with movement, pressure or sitting**. Pains are **better in the afternoon and when lying down**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Horsetail' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Hyssop is indicated in **infectious conditions of the lungs and digestive system**. It is specific for **chronic low-grade fevers** with a **rapid and flooding pulse**. It is especially useful for **children''s respiratory and digestive infections**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Hyssop' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Juniper helps bring **clarity in confusing situations** and is specific for **atonic conditions of the gastrointestinal, respiratory and urinary tract**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Juniper' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Lady''s mantle is indicated for **excessive moisture** and **prolapsed and herniated organs**. It is specific for **strengthening hollow organs**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Lady''s Mantle' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'It is specific for **headache**, **muscle spasms**, **convulsions**, **stammering** and symptoms due to **nervousness related to a lack of circulation to the brain**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Lavender' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Lily of the valley is indicated for **heart weakness with valvular insufficiency**, **edema**, **dyspnea** and **venous stasis** with a **rapid and feeble pulse**. The thoughts are dulled and the **tongue is broad and thick with a heavy dirty coating** that feels sore and scalded. The individual feels **better in open air** and **worse in a warm room**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Lily Of The Valley' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Linden flower is indicated for **hypertension associated with arteriosclerosis**. The individual is **worse in the afternoon and evening, in a warm room and heat of a bed**. They are **better in a cool room and with motion**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Linden' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Lobelia is for conditions of a **spasmodic nature**. It is specific for **dyspnea that increases with exertion** and is **aggravated by exposure to cold**. It is used for spasmodic coughs like **croup, whooping cough, bronchial asthma, bronchitis and pleurisy**. It is used externally as well as internally as an antispasmodic. Internally it is given in small frequent doses. Too large of a dose will initiate vomiting. Externally, it is used as a liniment over the chest for spasmodic conditions of the lungs.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Lobelia' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'It is specific for **inflammatory conditions**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Marshmallow' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'**Burning and inflammation** is a prevalent part of symptomatology.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Meadowsweet' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'It is specific for **congestion and inflammation of the liver, spleen and kidneys** accompanied by **hemorrhagic tendencies**. There is a **dull aching pain over the spleen**, passing up to the **left scapula** and **pain in the right side over the liver**. It is indicated for **weak and congested veins**, **pelvic congestion**, **prolapse of organs** and **blood stasis leading to hemorrhage**. The individual displays **pronounced debility**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Milk Thistle' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'It is specific for **agitated or spasmodic muscles**. The symptoms are **worse in the winter, in cold, stormy weather, in bed, with movement and lying on the left side**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Mistletoe' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Motherwort is used for **melancholy**, **restlessness** and **disturbed sleep** from emotional or physical ailments of the heart. It **strengthens the heart**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Motherwort' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'In small doses, mugwort strengthens the digestive and nervous system. It is specific for **coldness, stiffness and spasms**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Mugwort' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'It is indicated for **dry, harsh, hacking coughs**, as well as **coughs with congestion**, **weak lungs, kidneys and nervous system**. Symptoms are **worse with a change of temperature, talking, sneezing and from 9 a.m. to 4 p.m.**'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Mullein' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'It is indicated for **weak, inefficient capillary circulation**, **cold skin**, **weak pulse** with **catarrh and putrid conditions**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Myrrh' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'It is indicated for **profuse discharges from mucous membranes**, sensations of **heat and itching**. Nettle favors **elimination of uric acid**. Nettle benefits the spleen. Symptoms are **worse from very cold air, water, cool moist air, touch** and the **symptoms return at the same time each year**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Nettle' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Indicated for conditions of **dilation and atony from muscular laxity** and has a **special affinity for the heart**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Night-Blooming Cereus' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'It is indicated in **nervous states with exhaustion**, **inability to concentrate**, **melancholy**, **diminished strength of limbs or numbness of limbs**, **occipital headache extending down the spine**, as well as into the head.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Oat' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Oregon grape root should be considered when there is a picture of **atonic mucous membranes** and **lack of strength and fatigue**, especially when associated with **digestive problems**. The individual may have both **nausea and hunger after eating**. It is specific for **low grade internalized heat or infectious conditions**, **headaches starting in the occiput** and spreading over the right side of the head to the eyes, with **bulging blood vessels in the temples** and the **tongue thickly coated with yellowish-brown coating**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Oregon Grape' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'It is indicated for a **dull mind that is forgetful**, **sinuses full**, **head feels clogged with mucus** and **easily catches a cold** or often has influenza symptoms.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Osha' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Partridge berry is indicated in **generalized edema**, **mental dullness**, **backache**, **uterine congestion**, **dark, red, swollen cervix**, **dysmenorrhea** and **uterine bleeding with bright red blood**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Partridgeberry' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Often the person who responds to pulsatilla will have **nervous conditions** like **fearfulness, general nervousness**, feels **dejected**, **emotional lability**, and **weeps easily**. Often the person feels **exhausted and perceives that they are not in control**. They may have **heart palpitations and insomnia**. The individual is **gentle, with a yielding disposition**, and has **changeable symptoms and moods**. The **body discharges are often yellow**. The person needing pulsatilla **can be comforted** while the person needing chamomile cannot.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Pasqueflower' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'It is indicated for conditions where there is **restless agitation and exhaustion** with **muscular twitching or tendency towards spasms**. The **tongue is not coated**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Passionflower' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Specific indications for pennyroyal are **thin white coating on the tongue**, **congested pelvic organs** and **bearing down pains which are worse with slight movement**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Pennyroyal' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Peppermint is specific for **spasmodic conditions of the respiratory, digestive and urinary tracts**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Peppermint' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Pipsissewa is indicated for **chronic genitourinary tract catarrh** with **lymphatic congestion**. Symptoms are **worse from damp weather, sitting on cold surfaces, and worse on the left side of the body**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Pipsissewa' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Pleurisy root is indicated for **hot, dry skin** and **difficult, painful breathing** accompanying a **fever** and **chest pains that are relieved by bending forward**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Pleurisy Root' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Poke is specific for a **congested lymphatic system with hard, swollen lymph nodes**. There is a tendency to be **large, flabby, slow moving, tired** and often have an **indifference to life or social etiquette**. If accompanied by a **high fever**, the glands may be swollen and painful and the skin may be dry with **purple coloration in stagnant areas** and a fast pulse. Poke has an affinity for **red swollen inflamed tissue of the throat, mammary glands and testicles**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Poke Root' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Prickly ash is indicated in **relaxed, feeble conditions** found with **atonic digestive states** where it improves digestion and circulation. It is specific for **neuralgic pains**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Prickly Ash' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Ligustrum is indicated with **kidney weakness**, **weak back and knees**, **hearing loss**, **blurred vision**, **constipation** and **immunological disorders**. It is a **yin tonic** in Chinese medicine. Ligustrum is used to strengthen the whole body.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Privet' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Queen''s root is indicated for **chronic laryngeal irritation**, **chronic bronchitis**, **enlarged cervical lymphatic nodes** and **congested lymphatics** in general. It is specific for **red, glistening mucous membranes with scanty secretion**. The **tongue has a white or yellow coating**. There is a **feeling of gloom, foreboding and dull mindedness**. Symptoms are **worse in afternoons, damp air and with motion** and **better in the morning and dry air**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Queen''s Delight' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'It is indicated for debilitated individuals with **spasmodic coughs**, **salivary gland congestion**, **pharyngeal inflammation** and **chronic skin eruptions**. Red clover is specific for **swollen hard nodes, especially for single nodes** and a **stiff neck with cramping in the sternocleidomastoid muscles** that is relieved by heat and massage.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Red Clover' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'It is indicated for **stagnation of fluids, turbid lymph, mucus, swollen glands** and **poor nutrition to the tissues**. Consider red root when the person is **melancholic** and the **tongue is enlarged, swollen, with a dirty white or yellow coating**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Red Root' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'For people who show **early aging** and individuals who are **exhausted, anxious, depressed and burnt out**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Rhodiola' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Rhubarb is indicated for people who **smell sour or have sour smelling feces**. Symptoms are worse from uncovering the body, after eating and moving. The **tongue is elongated and reddened at the tip and edges**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Rhubarb' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Rue is indicated for **sprains, especially flexor tendon sprains**, **deposits in joints, especially the wrist**, **bruised sensations, bruised bones** and **feeling of weakness and despair**. It is beneficial for **all injuries of the periosteum and cartilage**. Symptoms are **worse lying down and from cold and wet weather**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Rue' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'For people with **relaxed and poor circulation** with **excessive sweating**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Sage' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Saw palmetto is indicated for **wasting of sexual organs**, **lack of sexual desire**, and **underdeveloped breasts** in women.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Saw Palmetto' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Schisandra is indicated for **weak lungs, digestion, liver and immune system** with **night sweats**, **prolonged diarrhea**, **chronic coughs**, **amnesia** and **general overall weakness with inability to hold moisture** in the body (ie: sweats, nocturnal emissions, morning diarrhea, and frequent urination). There is a **lack of both physical and mental energy**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Schizandra' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Senna is indicated for **constipation with lack of muscular action**, **flatulence, colic** and **enlarged, tender liver**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Senna' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Shepherd''s purse is indicated for **atony and prolapse of pelvic organs** and **passive bleeding**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Shepherd''s Purse' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Eleutherococcus is indicated for conditions resulting from **stressful situations where the individual is unable to adapt**. There is **general fatigue, weakness**, and **decreased physical and mental capability** with **depressed mood** and **lack of concentration**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Siberian Ginseng' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Skullcap is indicated when there is **nervous fear**, **restless sleep**, **cardiac irritability and spasms**. There may be **inability to pay attention** and a **dull frontal headache** or headache at the base of the brain. Symptoms are **worse with noise, odors and light** and **better at night and with rest**. This bitter plant is perfect for the person who has a **nervous stomach** and has **digestive stagnation**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Skullcap' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'St. John''s wort is specific for **injuries to the spinal cord and nerves**, including **nerve injuries to fingers and toes**. It is to be considered with **all chronic pain** in conjunction with **emotional and nervous exhaustion**; physical and mental weakness or pain with a **sharp shooting characteristic sensation, indicative of nerve pain**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'St. John''s Wort' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'The individual has a sense of **dullness, confusion and malaise**, as if the **beginning of a cold**. There is a **dull, heavy pressure in the forehead** with **catarrh and pain through the chest from the sternum to the spinal column**. The **cough is worse towards evening and when tired** and general symptoms are **worse with sudden temperature changes**. There may be **rheumatic pains with spasms**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Sticta' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Stone root is indicated for **portal congestion** causing **constipation, hemorrhoids** and **chronic nasal, gastric and pharyngeal catarrh**. The individual may suffer from a **dull frontal headache**, **yellow-coated tongue** and **itching anus**. They may have a sense of **constriction and weight, with heat in the rectum** and dry feces if hemorrhoids are the problem. Symptoms are **worse from the slightest emotion or excitement and from cold** and **better from heat**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Stoneroot' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'The person is **sensitive, has fixed ideas**, **insomnia**, **muscular twitching**, weakness, lack of appetite and **feels as if soul and body are separated**. Symptoms are **worse at night, with ingestion of fat and coffee and from cold damp air**. There is a tendency to **warty or other viral-related conditions**. It is indicated for **lymphatic congestion due to systemic infections**. **Moist skin eruptions and discharges** are common. There is often a history of **sexually transmitted diseases**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Thuja' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Thyme is indicated for **spasmodic conditions of the respiratory and urinary tract** with **infectious symptoms**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Thyme' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'This is an herb for **cramping pelvic pains that feel like the hips and back are falling to pieces**. The pains are **better with pressure around the pelvis**. It is indicated for **tenacious mucus discharge or uterine hemorrhage** with **great faintness and dizziness**. All conditions are associated with **poor pelvic tone**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Trillium' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Turmeric is indicated for **mental dullness or confusion**, **congestion in the pelvis, liver or gastrointestinal tract**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Turmeric' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Usnea is indicated for **infectious conditions with fever**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Usnea' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Valerian is specific for support of **atonic and functional nervous disorders** and situations arising from **cerebral vascular insufficiency**. The individual may **feel intoxicated**, have a tendency to be weak, pale, have **personality changes**, be agitated, feel light, as if **floating in air**, **oversensitive**, and experience **hallucinations at night**. There may be symptoms of **itching and muscle spasms at night** and **rheumatic pains in limbs with sciatica and jerking**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Valerian' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'False hellebore is indicated in **full-blooded, plethoric persons** with **great prostration**. The **tongue is coated white or yellow with a red streak down the middle**. The **pulse is full and bounding**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Veratrum' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Vervain is indicated for **nervous symptoms due to mental or physical overexertion** with **spasms in general, especially in the neck and back** due to overexertion. The individual is usually **strong-willed**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Vervain' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'White oak bark is indicated in subacute and chronic conditions with **exhaustion from disease**, **fevers**, **night sweats**, **ulcerations**, **relaxed and atonic tissues**, **prolapsed organs** and **putrid states**. Specific symptoms are nervous and related problems and the person feels **broken down but still manages to go on**. The **face is flushed** and the **eyes are puffy and have a yellow coloration** under them. The **tongue has a thick yellow coat**, and they have **terrible breath**. There may be a **bluish coloration to the tongue and lips**. A **swollen spleen and liver** is common with **edema of the lower extremities**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'White Oak' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Wild cherry is indicated when there is need to **nourish and tonify the digestive or respiratory system**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Wild Cherry Bark' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Wild indigo is indicated when the **pulse is intermittent**, **black or blue tongue**, **lack of blood flow to an area causing dusky colored tissues**, **ulcerations**, **putrid and offensive excretions**, **foul breath** and **muscle soreness**. The individual may experience **confusion, delirium, muttering, indifference to everything** and sleep, even **stuporous, melancholy**. The mind may wander and it may be hard to think.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Wild Indigo' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Wild yam is indicated for **spasmodic, shooting, aching or shifting pain**. It is specific for **pains due to excited nervous system** and **hip joint pain that keeps the individual awake at night**. Symptoms are **worse in the evening and night, lying down and bending double** and **better standing erect, with motion in open air and with pressure**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Wild Yam' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Witch hazel is indicated for **venous congestion with hemorrhage**, **varicose veins and hemorrhoids** with **bruised soreness of the affected parts**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Witch Hazel' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Betony has an affinity for persons who are **non-assertive**, **lack interest in the world** and have a sense of **not being grounded**. An emphasis is on **gastrointestinal irritability** and a **lack of cerebral circulation causing ischemia and pain**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Wood Betony' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'The individual feels **restless**, has **vertigo when moving slowly** and feels as if something is forgotten, **the mind is dulled**. The head seems **congested**. Yarrow is specific for **fevers where the skin is hot, dry** and the patient is **restless and delirious**. It is best for **atonic and relaxed tissues** where there is **free discharge or massive bleeding of bright red blood**, or **diarrhea**. The **tongue is red**, the complexion sanguine, the **pulse is rapid** and usually full.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Yarrow' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Yellow dock is indicated for **numerous and various pains that change locations and sensations**, **coughing due to tickling in the throat** and a **cough that is worse with cold air**. The **tongue is red, elongated, pointed, sore at the edges** and there is a **sensation of a hard pit in the stomach**. Symptoms are **worse in the evening, from inhaling cold air, in the left side of the chest and from uncovering**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Yellow Dock' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Yerba mansa is indicated for **catarrhal states**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Yerba Mansa' LIMIT 1);

UPDATE herbal.herb_mental_pictures SET mental_picture =
'Yerba santa is indicated for **respiratory and digestive weakness**.'
WHERE herb_id = (SELECT id FROM herbal.herbs WHERE common_name = 'Yerba Santa' LIMIT 1);
