SET search_path TO herbal, public;

-- Populate search_keywords for all disorders.
-- Keywords cover: patient-described symptoms, alternative names, related conditions,
-- lay terms, affected body parts. Used by Fuse.js for client-side fuzzy search.

-- ── Digestive / GI ───────────────────────────────────────────────────────────

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'acid reflux','heartburn','regurgitation','stomach acid','esophagus burning',
  'acidic burps','sour taste throat','chest burn after eating','gastroesophageal',
  'hiatal hernia','upper digestive','acid in chest','sour stomach','reflux',
  'after meal burning','dyspepsia acid','stomach acid too much','esophageal reflux',
  'lower esophageal sphincter','burning throat','food coming back up','belching acid',
  'indigestion acid','gastric acid','night acid','lying down acid','erosive reflux'
] WHERE name = 'GERD';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'stomach ulcer','gastric ulcer','duodenal ulcer','H. pylori','stomach pain burning',
  'empty stomach pain','ulcer pain','stomach lining erosion','peptic ulcer disease',
  'burning stomach','gnawing stomach pain','upper abdominal pain','antacid',
  'acid ulcer','stomach hole','gut ulcer','nausea stomach','blood in stool ulcer',
  'black tarry stool','meal relieves pain','hunger pain','ulcer perforation',
  'helicobacter','stomach inflammation','PUD'
] WHERE name = 'Peptic Ulcers';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'stomach inflammation','stomach lining irritation','stomach pain','nausea stomach',
  'H. pylori gastritis','vomiting stomach','gastric inflammation','upper abdominal pain',
  'burning stomach','indigestion','stomach tenderness','gastric upset','stomach bug',
  'atrophic gastritis','chronic gastritis','acute gastritis','gastric mucosal',
  'stomach lining damage','dyspepsia','bloating stomach','loss of appetite',
  'stomach pain after eating','gastric lining','stomach irritation','gastric erosion'
] WHERE name = 'Gastritis';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'constipated','can''t poop','hard stools','infrequent bowel movements','straining toilet',
  'no bowel movement','slow digestion','sluggish bowel','dry hard stools','bloating constipation',
  'laxative','fiber deficiency','bowel irregularity','not going bathroom','toilet strain',
  'impaction','stool withholding','bowel sluggish','colon slow','abdominal bloating',
  'fecal impaction','chronic constipation','functional constipation','bowel movement pain',
  'pellet stools','rabbit droppings','full feeling bowel','transit time'
] WHERE name = 'Constipation';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'loose stools','watery stools','frequent bowel movements','stomach bug','gastroenteritis',
  'traveler''s diarrhea','food poisoning','urgent bowel','runny stools','liquid stool',
  'explosive bowel','gut infection','diarrhea cramping','dehydration diarrhea',
  'intestinal infection','gut bacteria imbalance','loose bowel','bowel urgency',
  'cramps diarrhea','stomach flu diarrhea','gut bug','IBS diarrhea','viral diarrhea',
  'bacterial diarrhea','watery stomach','frequent toilet trips','intestinal upset'
] WHERE name = 'Diarrhea';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'IBS','bowel spasm','alternating diarrhea constipation','functional bowel disorder',
  'gut pain','abdominal cramping bowel','nervous gut','sensitive colon','spastic colon',
  'bloating IBS','gas IBS','gut brain axis','functional gut','colicky pain',
  'stress bowel','anxiety gut','unpredictable bowel','bowel cramps','colon spasm',
  'gut sensitivity','food intolerance bowel','fiber sensitivity','mucus in stool',
  'abdominal discomfort','relief after bowel movement','cramping before stool'
] WHERE name = 'Irritable Bowel Syndrome';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'indigestion','upset stomach','stomach discomfort','bloating after eating','fullness',
  'digestive discomfort','gastric motility','non-ulcer dyspepsia','functional gut',
  'early satiety','nausea after eating','stomach heaviness','slow digestion',
  'belching','gas bloating','meal discomfort','postprandial discomfort','epigastric',
  'stomach fullness','digestive sluggish','dyspepsia','upper gut pain','stomach gurgling',
  'food sits heavy','digestive dysfunction','gastric discomfort'
] WHERE name = 'Functional Dyspepsia';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'colon inflammation','diverticula infection','left lower abdominal pain','bowel inflammation',
  'diverticular disease','colon pocket infection','gut abscess','bowel abscess',
  'sigmoid inflammation','colon pain','lower left pain','bowel infection','colon diverticula',
  'gut wall pouches','bowel wall pockets','abdominal tenderness','fever bowel',
  'colon perforation risk','antibiotics bowel','bowel stricture','diverticulosis flare',
  'colon spasm','left pelvic pain','digestive infection','bowel cramping left'
] WHERE name = 'Diverticulitis';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'piles','rectal bleeding','anal swelling','painful rectum','itchy anus',
  'varicose veins rectum','anal veins swollen','straining rectum','blood on toilet paper',
  'anal discomfort','hemorrhoid pain','prolapsed hemorrhoid','internal hemorrhoid',
  'external hemorrhoid','anal pressure','sitting pain','bowel movement bleeding',
  'rectal pressure','anal itching','anal burning','rectal varicose','anal fissure adjacent',
  'rectal pain','bright red blood stool','bowel strain'
] WHERE name = 'Hemorrhoids';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'stomach protrusion diaphragm','hiatal hernia','stomach slides chest','gastric hernia',
  'chest pain after eating','belching hernia','upper abdominal pressure','diaphragm hernia',
  'acid reflux hernia','heartburn hernia','esophageal hiatus','stomach slips up',
  'fullness after eating','regurgitation hernia','difficulty swallowing',
  'chest pressure eating','rolling hernia','para-esophageal','structural hernia upper gut'
] WHERE name = 'Hiatus Hernia';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'canker sores','mouth sores','oral ulcers','lip sores','tongue sores',
  'inside cheek sores','painful mouth','recurrent mouth ulcers','oral lesions',
  'stomatitis','white mouth sores','aphthae','painful eating','mouth wound',
  'mouth ulcer healing','recurrent aphthous','stress mouth sores','immune mouth',
  'oral mucosal ulcer','mouth lining break','eating painful mouth','talking painful',
  'biting cheek sores','round mouth ulcers'
] WHERE name = 'Aphthous Ulcers';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'gum disease','gingivitis','periodontitis','inflamed gums','bleeding gums',
  'gum recession','dental health','oral infection','tooth loss gums','gum pain',
  'gum pockets','plaque buildup','tartar gum','dental infection','gum swelling',
  'loose teeth gums','oral bacteria','mouth infection','gum disease advanced',
  'tooth root exposure','dental abscess','jaw bone loss','oral inflammation',
  'brushing bleeding','gum treatment'
] WHERE name = 'Periodontal Disease';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'jaundice','yellowing skin','yellow eyes','liver bile','bilirubin elevated',
  'liver problem','bile duct obstruction','hepatic jaundice','yellow discoloration',
  'icteric','scleral icterus','liver failure sign','bile backup',
  'dark urine jaundice','pale stools','itching jaundice','neonatal jaundice',
  'obstructive jaundice','hemolytic jaundice','post-hepatic','liver yellow',
  'bile salt accumulation','liver duct block'
] WHERE name = 'Jaundice';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'liver problems','hepatic disease','liver inflammation','elevated liver enzymes',
  'fatty liver','liver support','hepatoprotective','liver damage','liver dysfunction',
  'liver cirrhosis adjacent','liver fibrosis','NASH','non-alcoholic fatty liver',
  'liver toxic','hepatomegaly','enlarged liver','liver pain right side','liver failure',
  'liver detox','impaired liver function','ALT AST elevated','liver health'
] WHERE name = 'Liver Disease';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'liver virus','hepatitis A','hepatitis B','hepatitis C','viral liver inflammation',
  'jaundice virus','liver virus infection','contagious liver','acute hepatitis',
  'bloodborne hepatitis','sexually transmitted liver','hepatitis transmission',
  'liver enzyme spike','acute viral hepatitis','hepatitis symptoms','fatigue liver virus',
  'nausea liver','HCV HBV HAV','liver inflammation viral','yellow eyes virus'
] WHERE name = 'Viral Hepatitis';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'liver inflammation chronic','hepatitis B chronic','hepatitis C chronic',
  'liver disease ongoing','elevated liver enzymes chronic','liver fibrosis',
  'chronic liver inflammation','autoimmune hepatitis','persistent hepatitis',
  'liver damage slow','liver scarring early','viral liver chronic','HCV chronic',
  'HBV carrier','fatigue liver','liver enzyme chronic elevation','portal inflammation',
  'liver biopsy','fibrotic liver','liver failure risk chronic'
] WHERE name = 'Chronic Hepatitis';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'liver scarring','liver failure','end-stage liver disease','alcoholic liver disease',
  'portal hypertension','liver hardening','ascites','fluid abdomen','liver damage severe',
  'varices','liver toxin buildup','jaundice cirrhosis','liver fibrosis end stage',
  'encephalopathy liver','liver transplant','alcohol liver','spider angiomata',
  'palmar erythema','caput medusae','splenomegaly cirrhosis','liver failure chronic'
] WHERE name = 'Cirrhosis';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'gallbladder inflammation','gallbladder pain','right upper quadrant pain',
  'gallbladder attack','fatty food intolerance','biliary colic','nausea after eating fatty',
  'gallbladder disease','gallbladder tenderness','fever gallbladder','Murphy''s sign',
  'acute cholecystitis','chronic cholecystitis','gallbladder infection','right side pain',
  'shoulder pain gallbladder','bile duct','gallbladder surgery','cholecystectomy',
  'gallbladder removal','biliary inflammation','bile backup','gallbladder spasm'
] WHERE name = 'Cholecystitis';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'gallstones','bile stones','gallbladder stones','biliary stones','right side pain sudden',
  'gallstone attack','bile duct blockage','gallbladder sludge','fatty meal pain',
  'cholelithiasis','stone in gallbladder','nausea gallstone','biliary colic',
  'cholesterol stones','pigment stones','stone passing bile','jaundice stones',
  'radiating back pain gallstone','shoulder blade pain gallstone','silent gallstones',
  'gallstone removal','ERCP stones','bile composition','supersaturated bile'
] WHERE name = 'Cholelithiasis';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'IBD','inflammatory bowel disease','colon inflammation','bloody diarrhea','large intestine',
  'colitis flare','autoimmune bowel disease','rectal bleeding IBD','mucus stool IBD',
  'ulcerative proctitis','pancolitis','left-sided colitis','colon ulcers','bowel urgency IBD',
  'tenesmus','colon autoimmune','immunosuppressive bowel','biologic bowel',
  'colon lining breakdown','bowel inflammation chronic','rectal urgency','colitis remission',
  'colon cancer risk IBD','bloody stool chronic'
] WHERE name = 'Ulcerative Colitis';

-- ── Immune / Infection ───────────────────────────────────────────────────────

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'bacterial infection','immune response','fighting infection','fever infection',
  'systemic infection','antimicrobial','antibiotic alternative','pathogen',
  'immune support','viral infection','wound infection','sepsis early',
  'infectious disease','lymph node swelling','body fighting bug','immune activation',
  'recurrent infection','immune deficiency','chronic infection','acute infection',
  'invasive bacteria','fever chills infection','body ache infection','immune herbs'
] WHERE name = 'Infection';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'post-antibiotic','gut restoration','probiotic support','gut flora restoration',
  'microbiome recovery','digestive recovery','bowel recovery','restore good bacteria',
  'candida overgrowth','gut healing','antibiotic aftermath','dysbiosis recovery',
  'beneficial bacteria','intestinal flora','diarrhea after antibiotics',
  'yeast overgrowth','digestive imbalance','gut recolonization','fermented food support',
  'leaky gut','intestinal healing','microbiota','lactobacillus restoration',
  'antibiotic diarrhea','gut rebuild'
] WHERE name = 'Antibiotic Recovery';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'autoimmune','immune system attacking self','inflammation autoimmune','chronic inflammation',
  'autoantibodies','immune dysregulation','systemic autoimmune','lupus adjacent',
  'MS adjacent','rheumatoid adjacent','inflammatory condition','immune modulation',
  'cytokine','T-cell dysregulation','genetic autoimmune','flare autoimmune',
  'anti-inflammatory support','autoimmune diet','inflammation chronic autoimmune',
  'immune tolerance','immune suppression support','inflammatory markers',
  'autoimmune fatigue','CRP elevated'
] WHERE name = 'Autoimmune Diseases';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'skin abscess','infected hair follicle','furuncle','carbuncle','pus pocket',
  'skin infection','bacterial skin','staphylococcus','painful lump skin',
  'draining abscess','hot tender lump','red swollen lump','boil pus',
  'recurrent boils','staph skin','MRSA adjacent','abscess drainage',
  'cellulitis adjacent','heat compress','impetigo adjacent','skin bacteria',
  'painful skin nodule','inflamed follicle','cluster boils'
] WHERE name = 'Boils';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'malignancy','tumor','neoplasm','abnormal cell growth','carcinoma','lymphoma',
  'leukemia','oncology support','anti-tumor','chemo support','cancer immune support',
  'oxidative stress','cancer herbs','anticancer','adjunct cancer care',
  'tumor reduction support','cancer fatigue','cachexia','cancer treatment support',
  'cellular proliferation','metastasis','cancer prevention','free radical',
  'apoptosis','immune cancer'
] WHERE name = 'Cancer';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'varicella','itchy spots','childhood illness','chickenpox','blister rash',
  'contagious rash','shingles virus','VZV','pox','fever rash itchy',
  'fluid-filled blisters','crusting rash','viral rash','fever childhood',
  'scratching rash','highly contagious rash','respiratory transmission',
  'chicken pox recovery','post-varicella','immune after pox','incubation rash'
] WHERE name = 'Chicken Pox';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'common cold','runny nose','sneezing','nasal congestion','sore throat cold',
  'rhinovirus','cold symptoms','upper respiratory infection','URI','head cold',
  'stuffy nose','watery eyes cold','mild fever cold','sneezing runny nose',
  'cold recovery','contagious cold','cold duration','cold prevention',
  'catching cold','cold virus','nasal drip','throat scratch','self-limiting viral'
] WHERE name = 'Colds';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'influenza','flu virus','influenza A','influenza B','body aches fever',
  'fatigue virus','flu symptoms','viral respiratory','seasonal flu',
  'myalgia fever','chills aches','sudden onset illness','prostration','bed rest flu',
  'flu shot','antiviral','influenza season','respiratory viral','high fever flu',
  'pandemic flu','muscle weakness flu','headache flu','appetite loss flu'
] WHERE name = 'Flu';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'influenza virus','flu virus acute','body aches','fever chills','fatigue flu',
  'seasonal influenza','respiratory flu','influenza treatment','flu care',
  'influenza symptoms','high fever','prostration flu','flu recovery start',
  'antiviral herbs','oseltamivir support','flu onset','sudden flu','aching flu'
] WHERE name = 'Influenza';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'recovery from flu','post-flu fatigue','rebuilding after illness','flu recovery',
  'convalescent support','strength after flu','weakness post-flu','lingering tiredness',
  'immune rebuild after flu','post-viral fatigue','debility after flu',
  'tonic after illness','convalescence','rebuilding strength','post-viral weakness'
] WHERE name = 'Influenza Convalescence';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'congestion','nasal congestion','stuffed nose','blocked nose','sinus congestion',
  'catarrh','mucus buildup','postnasal drip','head congestion','stuffy head',
  'mucus thick','blocked airways','nose blocked','head pressure congestion',
  'nasal obstruction','breathing through mouth','clogged nose','sinuses full',
  'mucus drainage','nasal blockage','phlegm throat','post-nasal','congested breathing'
] WHERE name = 'Congestion';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'swollen lymph nodes','lymphadenopathy','neck lumps','lymph swelling',
  'swollen neck glands','glandular swelling','immune lymph','tender lymph nodes',
  'cervical lymph nodes','armpit swelling','groin swelling','reactive lymph nodes',
  'lymph node infection','mononucleosis adjacent','infection lymph','flu lymph nodes',
  'sore swollen glands','immune activation lymph','lymphatic congestion'
] WHERE name = 'Swollen Glands';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'parotid gland swelling','salivary gland infection','viral parotitis','jaw swelling',
  'childhood viral illness','mumps virus','paramyxovirus','cheek swelling',
  'face swelling viral','contagious childhood','fever swelling jaw',
  'orchitis mumps','meningitis complication mumps','bilateral parotitis'
] WHERE name = 'Mumps';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'high temperature','pyrexia','elevated body temperature','fever management',
  'bring down fever','sweating fever','febrifuge','temperature reduction',
  'diaphoretic','chills fever','breaking a fever','febrile','fever in children',
  'thermometer high','antipyretic','cooling herbs','hot dry skin','rigors',
  'fever pattern','infectious fever','fever support','immune fever'
] WHERE name = 'Fevers';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'athlete''s foot','ringworm','candida skin','tinea','jock itch','skin fungus',
  'dermatophyte','yeast skin infection','nail fungus','intertrigo','tinea pedis',
  'tinea corporis','tinea cruris','tinea versicolor','onychomycosis','mold skin',
  'fungal rash','itchy fungal','scalp ringworm','tinea capitis','antifungal herbs',
  'weeping fungal','skin yeast','foot fungus'
] WHERE name = 'Fungal Skin Infections';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'UTI','urinary tract infection','bladder infection','kidney infection',
  'urethritis','pelvic infection','recurrent UTI','urinary bacteria',
  'burning urination','frequent urination','pelvic area infection',
  'genitourinary infection','painful urination','urinary culture','E. coli urinary',
  'urethral infection','vaginal area infection','lower urinary infection',
  'urinary herbs','cystitis adjacent','urinary antimicrobial'
] WHERE name = 'Genitourinary Tract Infections';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'postoperative recovery','surgery recovery','post-surgery healing','wound healing',
  'surgical convalescence','immune support surgery','recovery after operation',
  'tissue repair','post-op','healing after surgery','anesthesia recovery',
  'surgical wound','strength after operation','debility post-surgery',
  'hospital recovery','drain fluid surgery','post-surgical nutrition support'
] WHERE name = 'Postoperative Recovery';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'liver detox','toxic burden','detoxification','elimination pathways',
  'bowel sluggish','lymph stagnation','skin detox','poor elimination',
  'toxin buildup','environmental toxins','heavy metals','cleanse','depurative',
  'alterative herbs','blood cleansing','lymphatic herbs','detox protocol',
  'bowel elimination','kidney elimination','liver phase 1 2','drainage pathways',
  'constitutional elimination','toxemia','sluggish elimination'
] WHERE name = 'Elimination and Detox Issues';

-- ── Respiratory ───────────────────────────────────────────────────────────────

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'chest cough','airway inflammation','bronchial tubes','productive cough',
  'mucus cough','wet cough','chest cold','lower respiratory infection',
  'coughing with phlegm','viral bronchitis','bacterial bronchitis','chest tightness',
  'wheezing bronchitis','shortness of breath','respiratory virus','lung inflammation',
  'chest infection','bronchial infection','fever cough','acute airway',
  'cough green mucus','yellow phlegm','bronchial spasm'
] WHERE name = 'Acute Bronchitis';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'airway inflammation','chronic bronchitis','chest cough chronic','mucus production',
  'productive cough','respiratory infection','bronchial inflammation','coughing fits',
  'phlegm','COPD related','morning cough','smoker''s cough','daily cough',
  'chronic airway','bronchial mucus','persistent productive cough',
  'bronchial secretion','bronchial hypersecretion','winter cough','chronic chest'
] WHERE name = 'Bronchitis';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'persistent cough','COPD','smoker''s cough','chronic mucus production',
  'daily cough','morning cough','bronchial inflammation chronic',
  'productive cough chronic','chronic lower respiratory','cigarette cough',
  'occupational lung','dust lung','winter flare lung','FEV1','spirometry',
  'bronchial obstruction','airway remodeling','emphysema related','lung disease progressive'
] WHERE name = 'Chronic Bronchitis';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'breathing difficulty','wheezing','shortness of breath','bronchospasm',
  'reactive airways','allergic asthma','exercise asthma','chest tightness',
  'inhaler use','bronchodilation','airway inflammation','bronchoconstriction',
  'asthma attack','asthma triggers','allergen asthma','childhood asthma',
  'nocturnal asthma','occupational asthma','eosinophilic asthma','air hunger',
  'tight chest','labored breathing','peak flow','asthma herbs'
] WHERE name = 'Asthma';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'COPD','lung damage','air trapping','barrel chest','breathlessness',
  'reduced lung capacity','destroyed alveoli','smoker''s lung','emphysema COPD',
  'hyperinflation lung','pursed lip breathing','oxygen therapy','dyspnea exertion',
  'irreversible lung','bullae lung','lung tissue destruction','air hunger emphysema',
  'progressive breathing loss','accessory muscles breathing'
] WHERE name = 'Emphysema';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'lung infection','pneumonia symptoms','bacterial pneumonia','viral pneumonia',
  'lung consolidation','fever respiratory','breathing difficulty infection',
  'lobar pneumonia','chest x-ray infection','productive cough pneumonia',
  'coughing blood','pleuritic pain','pleural infection','hospitalization respiratory',
  'streptococcus pneumoniae','legionella','walking pneumonia','mycoplasma',
  'atypical pneumonia','lung abscess','oxygen pneumonia','fever chills cough'
] WHERE name = 'Pneumonia';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'whooping cough','paroxysmal cough','convulsive cough','100-day cough',
  'Bordetella pertussis','severe coughing fits','inspiratory whoop',
  'vomiting after cough','exhausting cough','child cough severe',
  'cough until vomit','cyanosis cough','vaccine-preventable cough',
  'pertussis adults','prolonged cough illness','cough paroxysm'
] WHERE name = 'Pertussis';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'recovery after bronchitis','convalescent bronchitis','lung healing',
  'rebuilding respiratory','post-illness recovery','post-bronchitis weakness',
  'lung tonic','airway healing','cough lingering','residual cough',
  'respiratory strength','rebuilding lung','lung restore','post-bronchial'
] WHERE name = 'Post-Bronchitis Recovery';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'cold virus','rhinovirus','sneezing running nose','nasal drip','head cold',
  'upper respiratory virus','self-limiting cold','cold duration','common cold virus',
  'congestion head cold','sore throat cold','mild fever cold','cold season',
  'cold herbs','immune support cold','prevent cold','cold treatment','cold relief'
] WHERE name = 'The Common Cold';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'cough general','respiratory cough','throat cough','bronchial cough',
  'dry cough','wet cough','phlegm','irritated airway cough','night cough',
  'persistent cough','cough reflex','cough herbs','tickling cough',
  'post-nasal drip cough','throat irritation cough'
] WHERE name = 'Cough';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'soothing cough','throat coat','cough relief','dry tickling cough',
  'irritated airway','calm cough reflex','demulcent cough','coat throat',
  'throat soothing','mucilage cough','soothe bronchial','throat tickle',
  'non-productive soothing','irritated mucosa cough','calm airway'
] WHERE name = 'Cough (soothe)';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'suppress cough reflex','stop coughing','antitussive','dry nonproductive cough',
  'cough suppressant','quiet cough','reduce cough reflex','cough control',
  'night cough suppress','sleep disrupting cough','irritating dry cough',
  'cough dampener','nervous cough','cough stop'
] WHERE name = 'Cough (suppress)';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'hoarse voice','lost voice','inflamed larynx','voice box irritation',
  'voice loss','throat inflammation larynx','croaky voice','aphonia',
  'singer''s throat','vocal cord inflammation','voice strain','laryngeal inflammation',
  'speaking pain','whispering only','voice hoarseness','dry larynx','laryngeal edema',
  'laryngeal infection','laryngitis acute','laryngitis chronic','voice rest'
] WHERE name = 'Laryngitis';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'pharyngitis','throat pain','throat infection','strep throat','scratchy throat',
  'inflamed throat','painful swallowing','tonsil adjacent sore','throat soreness',
  'raw throat','red throat','throat bacteria','throat virus','fever sore throat',
  'exudate throat','throat herbs','throat spray','gargle','throat coat',
  'swollen throat','throat burning','neck pain swallowing'
] WHERE name = 'Sore Throat';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'inflamed tonsils','tonsil infection','sore throat tonsils','strep tonsils',
  'swollen tonsils','tonsil pain','difficulty swallowing','tonsil stones',
  'tonsillitis acute','tonsillitis chronic','tonsil abscess','peritonsillar abscess',
  'tonsillectomy indication','recurring tonsils','tonsil fever','pus tonsils',
  'white patches throat','exudative tonsillitis'
] WHERE name = 'Tonsillitis';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'sinus infection','sinus inflammation','sinus pain','facial pressure',
  'blocked sinuses','sinus congestion','postnasal drip','chronic sinusitis',
  'sinus headache','maxillary sinus','frontal sinus','ethmoid sinus',
  'sinus pressure','yellow green nasal discharge','nasal polyps','sinus herbs',
  'sinus drainage','recurring sinusitis','acute sinusitis','facial tenderness',
  'sinus surgery indication','fungal sinusitis'
] WHERE name = 'Sinusitis';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'allergic rhinitis','seasonal allergies','pollen allergy','sneezing allergy',
  'watery eyes','allergic eyes','tree pollen','grass pollen','ragweed allergy',
  'histamine reaction','hay fever season','spring allergies','summer allergies',
  'allergic nose','runny nose allergies','antihistamine','itchy eyes','itchy nose',
  'allergic conjunctivitis','hypersensitivity pollen','allergy herbs','mast cell',
  'IgE allergy','inhaled allergen'
] WHERE name = 'Hay Fever';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'ear pain','earache','middle ear infection','outer ear infection',
  'swimmer''s ear','otitis externa','muffled hearing','ear pressure',
  'otitis media','ear fluid','ear drum','eardrum pain','ear infection child',
  'ear tube','discharge ear','ear fullness','hearing loss infection',
  'ear canal pain','ear herbs','ear drops','warm ear','recurrent ear infection'
] WHERE name = 'Ear Infections';

-- ── Cardiovascular ───────────────────────────────────────────────────────────

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'high blood pressure','elevated blood pressure','cardiovascular risk',
  'systolic diastolic','silent killer','blood pressure management',
  'antihypertensive','vascular tone','BP high','hypertensive',
  'resistant hypertension','blood pressure herbs','vasodilation',
  'sodium blood pressure','stress blood pressure','heart strain',
  'kidney hypertension','essential hypertension','secondary hypertension',
  'arterial pressure','blood pressure monitor','heart disease risk'
] WHERE name = 'Hypertension';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'chest pain','heart pain','cardiac pain','coronary artery','chest tightness',
  'chest pressure','heart disease pain','ischemic heart','oxygen to heart',
  'myocardial ischemia','exertional chest pain','stable angina','unstable angina',
  'heart attack warning','left arm pain','jaw pain chest','nitroglycerin',
  'coronary spasm','Prinzmetal angina','effort angina','walking chest pain',
  'heart squeezing','cardiac chest'
] WHERE name = 'Angina Pectoris';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'hardening of arteries','arterial stiffness','vascular disease','atherosclerosis',
  'plaque buildup arteries','cardiovascular disease','arterial plaque',
  'cholesterol deposits','vessel hardening','circulation problems',
  'coronary artery disease','arterial calcification','peripheral vascular',
  'carotid disease','aortic stiffness','vascular aging','atherogenic',
  'lipid plaque','foam cells','intimal thickening','endothelial dysfunction'
] WHERE name = 'Arteriosclerosis';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'CHF','heart failure','fluid retention','leg swelling','shortness of breath lying down',
  'cardiac edema','weak heart','reduced ejection fraction','dyspnea exertion',
  'orthopnea','nocturnal dyspnea','right heart failure','left heart failure',
  'heart pump failure','pulmonary edema','ankle swelling','fatigue heart failure',
  'breathlessness heart','cardiac output low','BNP elevated','diuretic heart'
] WHERE name = 'Congestive Heart Failure';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'high cholesterol','hypercholesterolemia','LDL cholesterol','HDL cholesterol',
  'triglycerides high','lipid profile','cardiovascular risk cholesterol',
  'arterial plaque cholesterol','dyslipidemia','cholesterol management',
  'statin alternative','dietary cholesterol','fat metabolism','oxidized LDL',
  'cholesterol herbs','omega-3','fiber cholesterol','bile acid sequestrant',
  'hyperlipidemia','total cholesterol'
] WHERE name = 'Elevated Cholesterol';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'PAD','poor leg circulation','leg pain walking','claudication','arterial blockage legs',
  'peripheral vascular disease','cold feet circulation','leg ischemia',
  'intermittent claudication','ankle brachial index','femoral artery','iliac artery',
  'arterial insufficiency legs','calf pain walking','rest pain feet',
  'critical limb ischemia','smoking peripheral artery','diabetes peripheral artery'
] WHERE name = 'Peripheral Arterial Occlusive Disease';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'bulging leg veins','vein swelling','venous insufficiency','leg veins varicose',
  'spider veins','venous pooling','vein health','chronic venous disease',
  'varicosity','aching legs veins','heavy legs','leg edema veins',
  'venous hypertension','venous ulcer','stasis dermatitis','leg cramping veins',
  'vein inflammation','superficial thrombophlebitis','vein support herbs',
  'compression stockings','vascular herbs'
] WHERE name = 'Varicose Veins';

-- ── Nervous System ───────────────────────────────────────────────────────────

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'sleep problems','trouble sleeping','can''t sleep','sleep disorder','sleeplessness',
  'nighttime waking','poor sleep quality','sleep onset','lying awake','sleep deprivation',
  'insomnia chronic','insomnia herbs','sedative','hypnotic herbs','racing mind sleep',
  'anxiety sleep','stress sleep','cortisol sleep','melatonin','circadian rhythm',
  'sleep hygiene','waking 3am','light sleep','restless sleep','hyperarousal sleep'
] WHERE name = 'Insomnia';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'low mood','sadness','melancholy','hopelessness','fatigue depression',
  'anhedonia','mental health low','emotional support','mood disorder',
  'seasonal affective','serotonin low','major depression','depressive symptoms',
  'crying depression','isolation depression','motivation loss','pleasure loss',
  'antidepressant herbs','adaptogen mood','nervous system depression',
  'grief','postpartum depression adjacent','depression herbs','mood lift'
] WHERE name = 'Depression';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'sudden anxiety','stress response','fight or flight','adrenaline surge','panic',
  'acute anxiety','nervous tension','overwhelm','crisis stress','shock response',
  'adrenal response','hyperarousal','acute distress','nervous system overload',
  'acute panic','sudden nervous','shock herbs','acute nervine'
] WHERE name = 'Acute Stress';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'chronic stress','long-term stress','stress management','adrenal fatigue',
  'burnout','nervous exhaustion','adaptogen','HPA axis','cortisol chronic',
  'constant worry','chronic tension','overwhelm chronic','life stress',
  'work stress','ongoing anxiety','stress herbs','adrenal support',
  'resilience herbs','stress adaptation','allostatic load','burnout herbs'
] WHERE name = 'Ongoing Stress';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'eating disorder','food restriction','extreme dieting','body image','self-starvation',
  'restrictive eating','underweight','weight phobia','disordered eating',
  'malnourishment','low BMI','appetite loss eating disorder','not eating',
  'weight loss obsession','fear of food','anorectic','nutritional deficiency',
  'electrolyte imbalance eating','bone loss eating disorder'
] WHERE name = 'Anorexia Nervosa';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'head pain','tension headache','sinus headache','throbbing head','pressure headache',
  'headache relief','cephalgia','cervicogenic headache','cluster headache',
  'frontal headache','occipital headache','headache herbs','stress headache',
  'dehydration headache','hormonal headache','eye strain headache'
] WHERE name = 'Headache';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'severe headache','migraine attack','throbbing one side','nausea headache',
  'light sensitivity','sound sensitivity','aura','visual disturbance headache',
  'vascular headache','migraine prevention','migraine herbs','prodrome migraine',
  'photophobia','phonophobia','migraine triggers','menstrual migraine',
  'abdominal migraine','hemiplegic migraine','migraine nausea vomiting'
] WHERE name = 'Migraine';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'ringing in ears','ear ringing','buzzing ears','ear noise','phantom sound',
  'hearing noise','inner ear noise','auditory tinnitus','tinnitus relief',
  'pulsatile tinnitus','chronic ringing','hearing loss related','tinnitus herbs',
  'noise exposure','cochlear damage','sensorineural tinnitus','stress tinnitus'
] WHERE name = 'Tinnitus';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'car sickness','travel nausea','seasickness','vertigo travel','nausea movement',
  'vestibular nausea','inner ear motion','vomiting travel','boat sick',
  'plane nausea','motion vomit','antiemetic motion','ginger motion','dizziness travel'
] WHERE name = 'Motion Sickness';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'nerve inflammation','nerve pain','neuropathy','inflamed nerve','burning nerve pain',
  'tingling nerve','peripheral neuritis','numbness nerve','nerve hypersensitivity',
  'sciatica adjacent','neuralgia','nervous inflammation','demyelination adjacent',
  'nerve damage pain','electric shock pain','nerve trophic'
] WHERE name = 'Neuritis';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'anxious restlessness','nervous restlessness','can''t sit still','agitation',
  'nervousness','fidgety','inner restlessness','nervous energy','hyperactivity nervous',
  'motor restlessness','sleep restlessness','nighttime restlessness',
  'nervine herbs','anxious movement','restless nervous system'
] WHERE name = 'Restlessness';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'benzo withdrawal','tranquilizer withdrawal','anxiety medication withdrawal',
  'GABA receptor','valium withdrawal','xanax withdrawal','diazepam withdrawal',
  'lorazepam withdrawal','nervous system calming','drug withdrawal support',
  'anxiety rebound','physical dependence','benzodiazepine taper',
  'withdrawal anxiety','seizure risk withdrawal','nervous system herbs withdrawal'
] WHERE name = 'Withdrawal from Benzodiazepines';

-- ── Reproductive ─────────────────────────────────────────────────────────────

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'PMS','premenstrual','before period bloating','mood before period',
  'breast tenderness period','cramps before period','PMDD','irritability period',
  'premenstrual tension','emotional period','water retention period',
  'period mood swings','pre-period symptoms','cycle herbs','hormonal PMS',
  'luteal phase','progesterone PMS','period anxiety','period anger'
] WHERE name = 'Premenstrual Syndrome';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'painful periods','menstrual cramps','period pain','uterine cramping',
  'menstrual pain','pelvic pain periods','severe cramps','menstrual discomfort',
  'primary dysmenorrhea','secondary dysmenorrhea','crampy periods',
  'incapacitating cramps','period herbs','anti-spasmodic period',
  'prostaglandin period pain','uterine spasm','lower back pain period'
] WHERE name = 'Dysmenorrhea';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'missed periods','absent menstruation','no period','stopped periods',
  'late period extended','missing menstrual cycle','irregular periods',
  'hormonal imbalance periods','hypothalamic amenorrhea','ovulation issues',
  'estrogen FSH LH','menstrual suppression','athletic amenorrhea',
  'stress no period','weight loss no period','PCOS amenorrhea','post-pill amenorrhea',
  'primary amenorrhea','secondary amenorrhea','anovulation','period stopped'
] WHERE name = 'Amenorrhea';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'menopause symptoms','hot flashes','night sweats','hormonal shift',
  'perimenopause','mood swings menopause','vaginal dryness','sleep disturbance menopause',
  'estrogen decline','FSH elevated','menopause herbs','phytoestrogen',
  'hot flash herbs','menopausal transition','post-menopause','climacteric',
  'bone loss menopause','heart risk menopause','memory menopause','brain fog menopause'
] WHERE name = 'Menopausal Complaints';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'uterine tissue outside uterus','painful periods severe','pelvic pain chronic',
  'infertility related','deep pain intercourse','dyspareunia','chocolate cyst',
  'ovarian endometrioma','pelvic adhesions','endometriosis herbs',
  'retrograde menstruation','immune endometriosis','estrogen driven endometriosis',
  'laparoscopy','endometriosis staging','bowel endometriosis','bladder endometriosis'
] WHERE name = 'Endometriosis';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'fibroid tumors','uterine growths','heavy periods','pelvic pressure',
  'benign uterine tumors','menorrhagia','submucosal fibroids','intramural fibroids',
  'subserosal fibroids','enlarged uterus','period flooding','period clots',
  'fibroid pain','fibroid bleeding','fibroid shrink','estrogen fibroid',
  'uterine bulk','uterine massage','fibroid herbs'
] WHERE name = 'Uterine Fibroids';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'fibrocystic breast','lumpy breasts','breast cysts','breast tenderness',
  'cyclic breast pain','mastodynia','fibrocystic changes','breast lumps cyclic',
  'breast swelling period','breast nodularity','breast density','estrogen breast',
  'caffeine breast cysts','iodine breast','breast herbs','cyclic mastalgia'
] WHERE name = 'Fibrocystic Breast Disease';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'vaginal inflammation','vaginal infection','vaginal discharge','bacterial vaginosis',
  'yeast vaginitis','candida vaginal','vaginal itching','vaginal pH',
  'BV','vaginal odor','cottage cheese discharge','vaginal burning',
  'vaginal dryness infection','recurrent vaginitis','Trichomonas','vaginal ecology',
  'probiotic vaginal','vaginal flora','vulvovaginitis'
] WHERE name = 'Vaginitis';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'enlarged prostate','BPH','frequent urination men','weak urine stream',
  'prostate enlargement','nocturia men','urinary hesitancy men',
  'incomplete bladder emptying','prostate issues','lower urinary tract symptoms',
  'dribbling urine','slow urine flow','prostate herbs','saw palmetto',
  'prostate health','urinary obstruction men','alpha blocker prostate',
  'PSA','prostate check'
] WHERE name = 'Benign Prostatic Hypertrophy';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'prostate inflammation','prostate pain','pelvic pain men','urinary symptoms prostate',
  'bacterial prostatitis','chronic pelvic pain syndrome men','CPPS',
  'prostatitis acute','prostatitis chronic','perineal pain','testicular pain prostatitis',
  'painful ejaculation','prostate bacteria','prostate antibiotics','prostate massage',
  'prostatitis herbs','pelvic floor dysfunction men'
] WHERE name = 'Prostatitis';

-- ── Pregnancy ────────────────────────────────────────────────────────────────

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'pregnancy support','prenatal herbs','pregnancy wellness','pregnant woman herbs',
  'safe pregnancy herbs','pregnancy nutrition','pregnancy complaints general',
  'gestational health','pregnancy tonic','pregnancy herbal support'
] WHERE name = 'Pregnancy - General Issues';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'morning sickness','nausea pregnancy','vomiting pregnancy','first trimester nausea',
  'hyperemesis adjacent','pregnancy nausea','nausea vomiting pregnancy',
  'pregnancy sickness','pregnancy queasiness','food aversions',
  'smell sensitivity pregnancy','ginger pregnancy nausea'
] WHERE name = 'Pregnancy - First Trimester - Morning Sickness';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'threatened miscarriage','spotting early pregnancy','bleeding early pregnancy',
  'pregnancy loss prevention','uterine cramping pregnancy','early pregnancy bleeding',
  'miscarriage risk','pregnancy spotting first trimester','pregnancy support early'
] WHERE name = 'Pregnancy - First Trimester - Threatened Miscarriage';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'pregnancy anemia','iron deficiency pregnancy','low iron pregnant','fatigue pregnancy',
  'pale pregnant','hemoglobin low pregnancy','folate pregnancy','B12 pregnancy',
  'prenatal iron','anemia first trimester'
] WHERE name = 'Pregnancy - First Trimester - Anemia';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'constipation pregnancy','bowel sluggish pregnant','hard stools pregnancy',
  'first trimester constipation','prenatal constipation','fiber pregnancy',
  'iron supplement constipation','pregnancy bowel'
] WHERE name = 'Pregnancy - First Trimester - Constipation';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'dizziness pregnancy','lightheaded pregnant','vertigo pregnancy',
  'low blood pressure pregnancy','blood sugar dizziness pregnancy',
  'pregnancy fainting','standing up dizzy pregnant'
] WHERE name = 'Pregnancy - First Trimester - Dizziness';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'headache pregnancy','migraine pregnant','tension headache pregnant',
  'first trimester headache','pregnancy head pain','headache relief pregnant'
] WHERE name = 'Pregnancy - First Trimester - Headache';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'heartburn pregnancy','acid reflux pregnant','GERD pregnancy',
  'indigestion pregnant','burning throat pregnant','stomach acid pregnancy'
] WHERE name = 'Pregnancy - First Trimester - Heartburn';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'hemorrhoids pregnancy','rectal pain pregnant','piles pregnancy',
  'anal swelling pregnancy','straining pregnant','constipation hemorrhoids pregnancy'
] WHERE name = 'Pregnancy - First Trimester - Hemorrhoids';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'bleeding gums pregnancy','gingivitis pregnancy','gum swelling pregnant',
  'pregnancy gingivitis','oral health pregnancy','gum bleeding pregnant'
] WHERE name = 'Pregnancy - First Trimester - Bleeding Gums';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'pregnancy second trimester','third trimester support','pregnancy general second third',
  'mid-late pregnancy herbs','prenatal second trimester','pregnancy wellbeing'
] WHERE name = 'Pregnancy - Second and Third Trimester - General';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'pregnancy stretch marks','skin stretching pregnancy','prevent stretch marks',
  'belly skin pregnancy','pregnancy skin care','stretch mark oil pregnancy'
] WHERE name = 'Pregnancy - Second and Third Trimester - Stretch Marks';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'backache pregnancy','lower back pain pregnant','pregnancy back support',
  'lumbar pain pregnant','sacral pain pregnancy','posture pregnancy back'
] WHERE name = 'Pregnancy - Second and Third Trimester - Backache';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'high blood pressure pregnancy','gestational hypertension','preeclampsia adjacent',
  'pregnancy BP high','blood pressure third trimester','pregnancy cardiovascular'
] WHERE name = 'Pregnancy - Second and Third Trimester - Hypertension';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'postpartum general','after birth support','new mother herbs','post-delivery',
  'postpartum recovery','postnatal herbs','after childbirth','recovery birth'
] WHERE name = 'Pregnancy - Postpartum - General';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'postpartum depression','baby blues','after birth mood','new mother depression',
  'postnatal depression','mood after delivery','emotional postpartum',
  'postpartum anxiety','maternal mental health'
] WHERE name = 'Pregnancy - Postpartum - Depression';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'after pains','uterine contractions postpartum','uterine cramps after birth',
  'uterus contracting','breastfeeding cramps','involution uterus pain',
  'postpartum uterine pain'
] WHERE name = 'Pregnancy - Postpartum - After Pains or Recurrent Uterine Contractions';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'stimulate milk production','increase breast milk','lactation herbs',
  'galactagogue','low milk supply','breastfeeding support','milk production',
  'nursing herbs','boost milk supply','postpartum lactation'
] WHERE name = 'Pregnancy - Postpartum - Stimulating Lactation';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'mastitis','breast infection breastfeeding','inflamed breast','nursing mastitis',
  'painful breast breastfeeding','blocked milk duct','breast abscess',
  'engorgement infection','lactation mastitis'
] WHERE name = 'Pregnancy - Postpartum - Mastitis';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'perineal tears','episiotomy healing','vaginal tear healing','perineal pain',
  'postpartum wound healing','perineal recovery','birth trauma healing',
  'suture healing postpartum'
] WHERE name = 'Pregnancy - Postpartum - Perineal Tears or Extensive Episiotomy';

-- ── Musculoskeletal ───────────────────────────────────────────────────────────

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'joint degeneration','worn cartilage','joint pain','degenerative joint disease',
  'arthritis pain','stiff joints','bone on bone','OA','joint wear and tear',
  'joint space narrowing','knee arthritis','hip arthritis','hand arthritis',
  'morning stiffness OA','joint pain elderly','cartilage loss',
  'osteophytes','bone spurs','weight bearing joint pain','joint inflammation OA'
] WHERE name = 'Osteoarthritis';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'autoimmune arthritis','joint inflammation autoimmune','RA','symmetrical joint pain',
  'morning stiffness RA','inflamed joints','swollen knuckles','rheumatoid factor',
  'anti-CCP','joint destruction','synovial inflammation','wrists hands feet RA',
  'rheumatoid nodules','fatigue RA','systemic autoimmune joint',
  'DMARDs','biologic RA','joint erosion','RA flare'
] WHERE name = 'Rheumatoid Arthritis';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'muscle pain','muscle ache','muscle soreness','body ache','myofascial pain',
  'muscle inflammation','sore muscles','muscle fatigue','generalized muscle pain',
  'fibromyalgia adjacent','overuse muscle','exercise soreness','delayed onset',
  'muscle tenderness','aching muscles','diffuse muscle pain'
] WHERE name = 'Myalgia';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'uric acid high','painful joint gout','big toe pain','podagra',
  'hyperuricemia','crystal deposits joint','acute gout attack','joint crystals',
  'purine metabolism','gout attack','sudden joint swelling','red hot joint',
  'gout prevention','gout diet','alcohol gout','cherry gout','gout herbs',
  'tophi','chronic gout','kidney stones gout'
] WHERE name = 'Gout';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'bone loss','low bone density','brittle bones','fracture risk',
  'calcium deficiency bones','bone thinning','postmenopausal bone loss',
  'osteoporosis herbs','bone density test','DEXA scan','hip fracture risk',
  'spine compression fracture','bone resorption','vitamin D bones',
  'calcium magnesium bones','weight bearing exercise bones','estrogen bone'
] WHERE name = 'Osteoporosis';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'joint inflammation','tendon pain','bursa inflammation','elbow pain',
  'shoulder pain','knee pain','repetitive strain','overuse injury',
  'tennis elbow','golfer''s elbow','rotator cuff','joint sac inflammation',
  'tendon injury','tendinopathy','subacromial','prepatellar bursitis',
  'trochanteric bursitis','occupational overuse','repetitive motion injury'
] WHERE name = 'Bursitis and Tendonitis';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'RLS','leg discomfort night','urge to move legs','creeping sensation legs',
  'sleep leg movement','periodic limb movement','leg restlessness',
  'iron deficiency legs','dopamine legs','nighttime leg crawling',
  'can''t keep legs still','sleep disturbance legs','leg sensations',
  'wiggling legs sleep','restless leg syndrome herbs'
] WHERE name = 'Restless Legs Syndrome';

-- ── Urinary ───────────────────────────────────────────────────────────────────

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'bladder infection','UTI women','urinary tract infection','burning urination women',
  'frequent urination women','painful urination','urinary burning',
  'bladder inflammation','E. coli bladder','dysuria','cystitis herbs',
  'recurrent bladder infection','honeymoon cystitis','urinary herbs',
  'bladder pain','urinary frequency','urinary urgency','pelvic pain women UTI'
] WHERE name = 'Cystitis';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'painful urination','burning urination','urethral pain','urinary pain',
  'difficulty urinating','urination discomfort','dysuria','urethral burning',
  'urinary discomfort','painful bladder','irritated urethra'
] WHERE name = 'Dysuria';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'frequent urination','urinary frequency','overactive bladder','urge to urinate',
  'nocturia','going to bathroom often','irritable bladder','bladder frequency',
  'urge incontinence adjacent','urinary urgency','can''t hold bladder',
  'frequent trips bathroom','night urination'
] WHERE name = 'Frequency';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'blood in urine','pink urine','red urine','urinary bleeding','kidney stone blood',
  'bladder blood','gross hematuria','microscopic hematuria','blood urine cause',
  'urinary tract blood','kidney blood','bladder cancer screen','cystitis blood urine'
] WHERE name = 'Hematuria';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'kidney stones','bladder stones','urinary stones','renal calculi','nephrolithiasis',
  'stone passage','stone pain','flank pain stones','ureter stone','calcium oxalate stone',
  'uric acid stone','struvite stone','stone prevention','kidney stone herbs',
  'hydration kidney stones','stone colic','urinary obstruction stones','lithotripsy'
] WHERE name = 'Urinary Calculus';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'kidney edema','tissue swelling','fluid retention','puffy legs','swollen ankles',
  'lymphedema','dependent edema','ankle swelling','leg pitting edema',
  'water retention body','pitting edema','protein low edema','diuretic herbs',
  'edema management','urinary edema','kidney edema','heart edema adjacent'
] WHERE name = 'Edema';

-- ── Skin ─────────────────────────────────────────────────────────────────────

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'pimples','zits','blackheads','whiteheads','skin breakouts','clogged pores',
  'oily skin','pustules','comedones','sebaceous gland acne','teenage skin',
  'adult acne','hormonal acne','facial blemishes','acne cysts','acne scarring',
  'skin bacteria propionibacterium','spots blemishes','bacne','chest acne',
  'follicular acne','acne vulgaris','sebum overproduction','acne herbs'
] WHERE name = 'Acne';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'atopic dermatitis','itchy skin rash','skin rash','dry flaky skin','allergic skin',
  'skin inflammation eczema','contact dermatitis','weeping skin','skin barrier broken',
  'itching eczema','eczema flare','childhood eczema','steroid eczema',
  'eczema herbs','skin microbiome','food allergy eczema','environmental eczema',
  'lichenification','eczema itch scratch cycle','nummular eczema','dyshidrotic eczema'
] WHERE name = 'Eczema';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'scaly skin patches','psoriatic plaques','autoimmune skin','psoriasis',
  'itchy scaly patches','red skin patches','skin cell overproduction','silvery scales',
  'plaque psoriasis','guttate psoriasis','scalp psoriasis','nail psoriasis',
  'psoriatic arthritis','inverse psoriasis','immune skin psoriasis',
  'inflammation psoriasis','psoriasis herbs','TNF psoriasis','stress psoriasis'
] WHERE name = 'Psoriasis';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'herpes zoster','viral nerve rash','painful blisters','post-herpetic neuralgia',
  'VZV reactivation','nerve pain rash','burning nerve blisters shingles',
  'dermatomal rash','unilateral rash','shingles pain','shingles vaccine',
  'immune reactivation','antiviral shingles','band of blisters','shingles elderly'
] WHERE name = 'Shingles';

-- ── Aging ─────────────────────────────────────────────────────────────────────

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'nausea queasy','upset stomach','sick to stomach','vomiting urge',
  'stomach nausea','antiemetic','nausea relief','nausea herbs','ginger nausea',
  'queasiness','stomach turning','gagging nausea','feel like vomiting',
  'nausea cause unknown','chronic nausea'
] WHERE name = 'Nausea';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'stomach cramps','abdominal pain gas','infant colic','stomach spasm',
  'digestive cramping','abdominal cramping','wind','bloating pain',
  'colic pain baby','gut cramps','intestinal spasm','griping pain',
  'abdominal gas pain','crampy abdomen','colicky pain'
] WHERE name = 'Colic/Gastritis';

-- ── System-level / catch-all entries ─────────────────────────────────────────

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'heart disease','blood vessel problems','circulation health','vascular health',
  'cardiac health','cardiovascular herbs','heart herbs','circulatory system',
  'vascular support','heart tonic'
] WHERE name = 'Cardiovascular System Issues';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'digestive problems','gut issues','gastrointestinal health','stomach problems',
  'bowel problems','digestive herbs','gut support','intestinal health',
  'GI tract','digestive tonic','gut function'
] WHERE name = 'Digestive System Issues';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'muscle and joint problems','musculoskeletal pain','movement issues',
  'bone muscle health','joint health','musculoskeletal herbs',
  'body mechanics','structural support','locomotor system'
] WHERE name = 'Musculoskeletal System Issues';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'nervous system problems','neurological health','nerve health herbs',
  'brain health','mental health herbs','nerve support','neurotrophic',
  'nervous system tonic','cognitive support','stress nervous system'
] WHERE name = 'Nervous System Issues';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'reproductive health','fertility support','hormonal balance','reproductive organ health',
  'menstrual health','reproductive herbs','hormone herbs','reproductive tonic',
  'fertility herbs','uterine tonic'
] WHERE name = 'Reproductive System Issues';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'breathing problems','lung health','respiratory health','airway issues',
  'lung herbs','respiratory tonic','breathing support','pulmonary health',
  'respiratory herbs','lung support'
] WHERE name = 'Respiratory System Issues';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'skin problems','dermatological health','skin health','skin conditions',
  'skin herbs','dermatology herbs','skin healing','skin tonic',
  'complexion','skin barrier health'
] WHERE name = 'Skin Issues';

UPDATE herbal.disorders SET search_keywords = ARRAY[
  'urinary problems','kidney health','bladder health','urinary tract health',
  'kidney herbs','bladder herbs','urinary tonic','renal health',
  'diuretic herbs','kidney support'
] WHERE name = 'Urinary System Issues';

-- General 'Overall' entries (immune, respiratory, musculoskeletal catch-all)
UPDATE herbal.disorders SET search_keywords = ARRAY[
  'general support','overall health','whole system','tonic','general herbs',
  'systemic support','whole body','comprehensive support'
] WHERE name = 'Overall';

-- All sentinel (global secondary actions — not a real disorder)
UPDATE herbal.disorders SET search_keywords = ARRAY[]::text[] WHERE name = 'All';
