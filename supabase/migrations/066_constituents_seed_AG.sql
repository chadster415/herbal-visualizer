SET search_path TO herbal, public;

-- ═══════════════════════════════════════════════════════════════════════════════
-- Migration 066 — Constituent seed data, herbs A–G
-- Constituents are first inserted into herbal.constituents (normalized), then
-- linked to herbs via herbal.herb_constituents.
-- Menstruum rows are added via herbal.set_menstruum().
-- ═══════════════════════════════════════════════════════════════════════════════

-- ─── BLOCK 1: Insert all distinct constituents (A–G herbs) ───────────────────

DO $$ BEGIN

  -- Alkaloids
  PERFORM herbal.ensure_constituent('achilline',        'pyrrolidine alkaloid');
  PERFORM herbal.ensure_constituent('betonicine',       'pyrrolidine alkaloid');
  PERFORM herbal.ensure_constituent('berberine',        'isoquinoline alkaloid', 'Antimicrobial, anti-inflammatory; inhibits NF-κB');
  PERFORM herbal.ensure_constituent('berbamine',        'isoquinoline alkaloid');
  PERFORM herbal.ensure_constituent('canadine',         'isoquinoline alkaloid', 'Also called l-tetrahydroberberine; sedative');
  PERFORM herbal.ensure_constituent('columbamine',      'isoquinoline alkaloid');
  PERFORM herbal.ensure_constituent('coptisine',        'isoquinoline alkaloid');
  PERFORM herbal.ensure_constituent('jatrorrhizine',    'isoquinoline alkaloid');
  PERFORM herbal.ensure_constituent('palmatine',        'isoquinoline alkaloid');
  PERFORM herbal.ensure_constituent('stachydrine',      'pyrrolidine alkaloid', 'Uterotonic; found in motherwort and others');
  PERFORM herbal.ensure_constituent('trigonelline',     'pyridine alkaloid');
  PERFORM herbal.ensure_constituent('caffeine',         'purine alkaloid', 'CNS stimulant; inhibits adenosine receptors');
  PERFORM herbal.ensure_constituent('theobromine',      'purine alkaloid');
  PERFORM herbal.ensure_constituent('theophylline',     'purine alkaloid', 'Bronchodilator');
  PERFORM herbal.ensure_constituent('ephedrine',        'phenethylamine alkaloid', 'Sympathomimetic; bronchodilator');
  PERFORM herbal.ensure_constituent('pseudoephedrine',  'phenethylamine alkaloid');
  PERFORM herbal.ensure_constituent('lobeline',         'piperidine alkaloid', 'Nicotinic receptor partial agonist; respiratory stimulant');
  PERFORM herbal.ensure_constituent('lobelanine',       'piperidine alkaloid');
  PERFORM herbal.ensure_constituent('lobelanidine',     'piperidine alkaloid');
  PERFORM herbal.ensure_constituent('colchicine',       'tropolone alkaloid');
  PERFORM herbal.ensure_constituent('chelidonine',      'benzophenanthridine alkaloid');
  PERFORM herbal.ensure_constituent('sanguinarine',     'benzophenanthridine alkaloid', 'Antimicrobial; found in bloodroot');
  PERFORM herbal.ensure_constituent('chelerythrine',    'benzophenanthridine alkaloid');
  PERFORM herbal.ensure_constituent('allocryptopine',   'isoquinoline alkaloid');
  PERFORM herbal.ensure_constituent('protopine',        'isoquinoline alkaloid', 'Antispasmodic; found in California poppy');
  PERFORM herbal.ensure_constituent('eschscholtzine',   'isoquinoline alkaloid');
  PERFORM herbal.ensure_constituent('californidine',    'isoquinoline alkaloid');
  PERFORM herbal.ensure_constituent('caryachine',       'isoquinoline alkaloid');
  PERFORM herbal.ensure_constituent('gelsemicine',      'indole alkaloid', 'Toxic; found in yellow jasmine');
  PERFORM herbal.ensure_constituent('gelsemine',        'indole alkaloid');
  PERFORM herbal.ensure_constituent('coniine',          'piperidine alkaloid');
  PERFORM herbal.ensure_constituent('cytisine',         'quinolizidine alkaloid', 'Nicotinic receptor agonist; found in scotch broom');
  PERFORM herbal.ensure_constituent('sparteine',        'quinolizidine alkaloid', 'Antiarrhythmic; oxytocic');
  PERFORM herbal.ensure_constituent('lupanine',         'quinolizidine alkaloid');
  PERFORM herbal.ensure_constituent('anagyrine',        'quinolizidine alkaloid');
  PERFORM herbal.ensure_constituent('baptifoline',      'quinolizidine alkaloid');
  PERFORM herbal.ensure_constituent('swainsonine',      'indolizidine alkaloid');
  PERFORM herbal.ensure_constituent('leonurine',        'guanidine alkaloid', 'Uterotonic; found in motherwort');

  -- Flavonoids & polyphenols
  PERFORM herbal.ensure_constituent('apigenin',         'flavone', 'Anxiolytic, anti-inflammatory');
  PERFORM herbal.ensure_constituent('apigenin-7-glucoside', 'flavone glycoside');
  PERFORM herbal.ensure_constituent('luteolin',         'flavone', 'Anti-inflammatory; inhibits COX-2');
  PERFORM herbal.ensure_constituent('luteolin-7-glucoside', 'flavone glycoside');
  PERFORM herbal.ensure_constituent('quercetin',        'flavonol', 'Antioxidant, anti-inflammatory, antihistamine');
  PERFORM herbal.ensure_constituent('rutin',            'flavonol glycoside', 'Vascular tonic; stabilizes capillaries');
  PERFORM herbal.ensure_constituent('hyperoside',       'flavonol glycoside');
  PERFORM herbal.ensure_constituent('isoquercitrin',    'flavonol glycoside');
  PERFORM herbal.ensure_constituent('isorhamnetin',     'flavonol');
  PERFORM herbal.ensure_constituent('kaempferol',       'flavonol', 'Antioxidant; anti-inflammatory');
  PERFORM herbal.ensure_constituent('myricetin',        'flavonol');
  PERFORM herbal.ensure_constituent('naringenin',       'flavanone');
  PERFORM herbal.ensure_constituent('naringin',         'flavanone glycoside');
  PERFORM herbal.ensure_constituent('hesperidin',       'flavanone glycoside', 'Vascular protective; reduces capillary permeability');
  PERFORM herbal.ensure_constituent('hesperetin',       'flavanone');
  PERFORM herbal.ensure_constituent('eriodictyol',      'flavanone');
  PERFORM herbal.ensure_constituent('catechin',         'flavan-3-ol', 'Antioxidant; astringent');
  PERFORM herbal.ensure_constituent('epicatechin',      'flavan-3-ol');
  PERFORM herbal.ensure_constituent('epigallocatechin gallate', 'flavan-3-ol', 'Potent antioxidant');
  PERFORM herbal.ensure_constituent('vitexin',          'flavone C-glycoside', 'Antispasmodic; found in hawthorn and passionflower');
  PERFORM herbal.ensure_constituent('isovitexin',       'flavone C-glycoside');
  PERFORM herbal.ensure_constituent('vitexin-2''-rhamnoside', 'flavone C-glycoside');
  PERFORM herbal.ensure_constituent('orientin',         'flavone C-glycoside');
  PERFORM herbal.ensure_constituent('isoorientin',      'flavone C-glycoside');
  PERFORM herbal.ensure_constituent('chrysin',          'flavone', 'Anxiolytic; aromatase inhibitor');
  PERFORM herbal.ensure_constituent('amentoflavone',    'biflavonoid', 'Found in St. John''s Wort; antidepressant activity');
  PERFORM herbal.ensure_constituent('casticin',         'polymethoxyflavone', 'Found in chasteberry');
  PERFORM herbal.ensure_constituent('diosmin',          'flavone glycoside', 'Vascular protective');
  PERFORM herbal.ensure_constituent('linarin',          'flavone glycoside', 'Sedative; found in valerian and passionflower');
  PERFORM herbal.ensure_constituent('acacetin',         'flavone');
  PERFORM herbal.ensure_constituent('formononetin',     'isoflavone', 'Phytoestrogenic');
  PERFORM herbal.ensure_constituent('biochanin A',      'isoflavone', 'Phytoestrogenic; precursor to genistein');
  PERFORM herbal.ensure_constituent('daidzein',         'isoflavone', 'Phytoestrogenic');
  PERFORM herbal.ensure_constituent('genistein',        'isoflavone', 'Phytoestrogenic; inhibits tyrosine kinase');
  PERFORM herbal.ensure_constituent('calycosin',        'isoflavone');
  PERFORM herbal.ensure_constituent('glabridin',        'isoflavan', 'Potent anti-inflammatory from licorice');
  PERFORM herbal.ensure_constituent('isoliquiritigenin','chalcone', 'Antispasmodic; estrogenic');
  PERFORM herbal.ensure_constituent('liquiritigenin',   'flavanone', 'Estrogenic from licorice');
  PERFORM herbal.ensure_constituent('8-prenylnaringenin','prenylated flavanone', 'Most potent phytoestrogen known; found in hops');
  PERFORM herbal.ensure_constituent('isoxanthohumol',   'prenylated flavanone', 'Found in hops');
  PERFORM herbal.ensure_constituent('xanthohumol',      'prenylated chalcone', 'Anticancer; found in hops');
  PERFORM herbal.ensure_constituent('proanthocyanidins','condensed tannin', 'Vascular tonic; antioxidant');
  PERFORM herbal.ensure_constituent('anthocyanins',     'anthocyanin', 'Antioxidant; vascular protective');
  PERFORM herbal.ensure_constituent('cyanidin-3-glucoside',     'anthocyanin glycoside');
  PERFORM herbal.ensure_constituent('cyanidin-3-sambubioside',  'anthocyanin glycoside');
  PERFORM herbal.ensure_constituent('delphinidin glycosides',   'anthocyanin glycoside');

  -- Phenolic acids & derivatives
  PERFORM herbal.ensure_constituent('rosmarinic acid',  'hydroxycinnamic acid', 'Antioxidant, anti-inflammatory; inhibits complement');
  PERFORM herbal.ensure_constituent('caffeic acid',     'hydroxycinnamic acid', 'Antioxidant; antimicrobial');
  PERFORM herbal.ensure_constituent('chlorogenic acid', 'hydroxycinnamic acid', 'Antioxidant; hypoglycemic');
  PERFORM herbal.ensure_constituent('ferulic acid',     'hydroxycinnamic acid', 'Antioxidant; anti-inflammatory');
  PERFORM herbal.ensure_constituent('cichoric acid',    'dicaffeoylquinic acid', 'Immunomodulatory; found in echinacea');
  PERFORM herbal.ensure_constituent('echinacoside',     'caffeic acid glycoside', 'Antimicrobial; immunostimulant');
  PERFORM herbal.ensure_constituent('gallic acid',      'hydroxybenzoic acid', 'Astringent; antimicrobial');
  PERFORM herbal.ensure_constituent('ellagic acid',     'hydroxybenzoic acid', 'Antioxidant; anticancer');
  PERFORM herbal.ensure_constituent('salicin',          'phenolic glycoside', 'Pro-drug of salicylic acid; analgesic');
  PERFORM herbal.ensure_constituent('salicylic acid',   'hydroxybenzoic acid', 'Anti-inflammatory; analgesic');
  PERFORM herbal.ensure_constituent('populin',          'phenolic glycoside');
  PERFORM herbal.ensure_constituent('p-coumaric acid',  'hydroxycinnamic acid');

  -- Tannins
  PERFORM herbal.ensure_constituent('tannins',          'polyphenol', 'Astringent; protein-precipitating');
  PERFORM herbal.ensure_constituent('gallotannins',     'hydrolyzable tannin');
  PERFORM herbal.ensure_constituent('ellagitannins',    'hydrolyzable tannin');
  PERFORM herbal.ensure_constituent('geraniin',         'ellagitannin');

  -- Terpenoids & volatiles
  PERFORM herbal.ensure_constituent('linalool',         'monoterpene alcohol', 'Anxiolytic, sedative, antimicrobial');
  PERFORM herbal.ensure_constituent('linalyl acetate',  'monoterpene ester', 'Antispasmodic; found in lavender');
  PERFORM herbal.ensure_constituent('menthol',          'monoterpene alcohol', 'Cooling; analgesic; decongestant');
  PERFORM herbal.ensure_constituent('menthone',         'monoterpene ketone');
  PERFORM herbal.ensure_constituent('menthyl acetate',  'monoterpene ester');
  PERFORM herbal.ensure_constituent('menthofuran',      'monoterpene furan');
  PERFORM herbal.ensure_constituent('pulegone',         'monoterpene ketone', 'Toxic in large doses');
  PERFORM herbal.ensure_constituent('camphor',          'bicyclic monoterpene ketone', 'Stimulant; counterirritant; toxic in excess');
  PERFORM herbal.ensure_constituent('borneol',          'bicyclic monoterpene alcohol');
  PERFORM herbal.ensure_constituent('bornyl acetate',   'bicyclic monoterpene ester');
  PERFORM herbal.ensure_constituent('1,8-cineole',      'monoterpene oxide', 'Expectorant; antimicrobial; also called eucalyptol');
  PERFORM herbal.ensure_constituent('alpha-pinene',     'bicyclic monoterpene', 'Expectorant; antimicrobial');
  PERFORM herbal.ensure_constituent('beta-pinene',      'bicyclic monoterpene');
  PERFORM herbal.ensure_constituent('thymol',           'monoterpene phenol', 'Potent antimicrobial; antifungal');
  PERFORM herbal.ensure_constituent('carvacrol',        'monoterpene phenol', 'Antimicrobial; antifungal');
  PERFORM herbal.ensure_constituent('p-cymene',         'monoterpene');
  PERFORM herbal.ensure_constituent('terpinen-4-ol',    'monoterpene alcohol', 'Antimicrobial; found in lavender and tea tree');
  PERFORM herbal.ensure_constituent('gamma-terpinene',  'monoterpene');
  PERFORM herbal.ensure_constituent('limonene',         'monoterpene', 'Carminative; anticancer');
  PERFORM herbal.ensure_constituent('alpha-terpineol',  'monoterpene alcohol');
  PERFORM herbal.ensure_constituent('geraniol',         'monoterpene alcohol', 'Antimicrobial; insect repellent');
  PERFORM herbal.ensure_constituent('citral',           'monoterpene aldehyde', 'Antiviral; found in lemon balm');
  PERFORM herbal.ensure_constituent('citronellal',      'monoterpene aldehyde');
  PERFORM herbal.ensure_constituent('thujone',          'bicyclic monoterpene ketone', 'Convulsant in large doses; found in sage and wormwood');
  PERFORM herbal.ensure_constituent('sabinene',         'bicyclic monoterpene');
  PERFORM herbal.ensure_constituent('myrcene',          'monoterpene', 'Sedative; analgesic');
  PERFORM herbal.ensure_constituent('ocimene',          'monoterpene');
  PERFORM herbal.ensure_constituent('chamazulene',      'sesquiterpene', 'Potent anti-inflammatory; formed during steam distillation');
  PERFORM herbal.ensure_constituent('alpha-bisabolol',  'sesquiterpene alcohol', 'Anti-inflammatory; found in chamomile');
  PERFORM herbal.ensure_constituent('bisabolol oxide A','sesquiterpene oxide');
  PERFORM herbal.ensure_constituent('bisabolol oxide B','sesquiterpene oxide');
  PERFORM herbal.ensure_constituent('beta-caryophyllene','sesquiterpene', 'CB2 agonist; anti-inflammatory');
  PERFORM herbal.ensure_constituent('humulene',         'sesquiterpene', 'Anti-inflammatory; appetite suppressant');
  PERFORM herbal.ensure_constituent('zingiberene',      'sesquiterpene', 'Primary volatile in ginger');
  PERFORM herbal.ensure_constituent('ar-turmerone',     'sesquiterpene ketone', 'Found in turmeric; neuroprotective');
  PERFORM herbal.ensure_constituent('bisabolene',       'sesquiterpene');
  PERFORM herbal.ensure_constituent('azulene',          'sesquiterpene', 'Anti-inflammatory; blue color in chamomile oil');
  PERFORM herbal.ensure_constituent('pinocamphone',     'bicyclic monoterpene ketone', 'Found in hyssop');
  PERFORM herbal.ensure_constituent('isopinocamphone',  'bicyclic monoterpene ketone');
  PERFORM herbal.ensure_constituent('valeranol',        'sesquiterpene alcohol', 'Found in valerian');
  PERFORM herbal.ensure_constituent('artabsin',         'sesquiterpene lactone', 'Bitter; found in wormwood');
  PERFORM herbal.ensure_constituent('absinthin',        'sesquiterpene lactone', 'Intensely bitter dimeric guaianolide');
  PERFORM herbal.ensure_constituent('artemisinin',      'sesquiterpene lactone endoperoxide', 'Antimalarial');
  PERFORM herbal.ensure_constituent('parthenolide',     'sesquiterpene lactone', 'Anti-inflammatory; inhibits NF-κB; found in feverfew');
  PERFORM herbal.ensure_constituent('arctiopicrin',     'sesquiterpene lactone', 'Bitter; antibacterial; found in burdock');
  PERFORM herbal.ensure_constituent('lactucin',         'sesquiterpene lactone', 'Sedative, analgesic; found in wild lettuce');
  PERFORM herbal.ensure_constituent('lactucopicrin',    'sesquiterpene lactone', 'Bitter sedative; found in wild lettuce');
  PERFORM herbal.ensure_constituent('achillin',         'sesquiterpene lactone');
  PERFORM herbal.ensure_constituent('achillicin',       'sesquiterpene lactone');
  PERFORM herbal.ensure_constituent('taraxacin',        'sesquiterpene lactone', 'Bitter; found in dandelion');
  PERFORM herbal.ensure_constituent('taraxacerin',      'sesquiterpene lactone');
  PERFORM herbal.ensure_constituent('marrubiin',        'labdane diterpene', 'Expectorant; antiarrhythmic; found in horehound');
  PERFORM herbal.ensure_constituent('carnosic acid',    'diterpene phenol', 'Antioxidant; neuroprotective; found in rosemary/sage');
  PERFORM herbal.ensure_constituent('carnosol',         'diterpene phenol', 'Antioxidant; anticancer');
  PERFORM herbal.ensure_constituent('rosmanol',         'diterpene phenol');
  PERFORM herbal.ensure_constituent('ursolic acid',     'pentacyclic triterpenoid', 'Anti-inflammatory; anticancer; hepatoprotective');
  PERFORM herbal.ensure_constituent('oleanolic acid',   'pentacyclic triterpenoid', 'Hepatoprotective; anti-inflammatory');
  PERFORM herbal.ensure_constituent('taraxasterol',     'pentacyclic triterpenoid');
  PERFORM herbal.ensure_constituent('beta-sitosterol',  'phytosterol', '5-alpha-reductase inhibitor; anti-inflammatory');
  PERFORM herbal.ensure_constituent('stigmasterol',     'phytosterol');
  PERFORM herbal.ensure_constituent('glycyrrhizin',     'oleanane triterpenoid saponin', 'Anti-inflammatory; 50× sweeter than sucrose; inhibits 11β-HSD');
  PERFORM herbal.ensure_constituent('glycyrrhetic acid','triterpenoid aglycone', 'Active metabolite of glycyrrhizin');
  PERFORM herbal.ensure_constituent('diosgenin',        'steroidal saponin aglycone', 'Precursor to progesterone synthesis (in vitro); found in wild yam');
  PERFORM herbal.ensure_constituent('dioscin',          'steroidal saponin');
  PERFORM herbal.ensure_constituent('astragaloside IV', 'cycloastragenol saponin', 'Telomere-supporting; immunomodulatory');
  PERFORM herbal.ensure_constituent('cycloastragenol',  'triterpenoid', 'Aglycone of astragalosides; telomerase activator');
  PERFORM herbal.ensure_constituent('ginsenosides',     'dammarane triterpenoid saponins', 'Adaptogenic; found in Panax ginseng');
  PERFORM herbal.ensure_constituent('eleutherosides',   'phenylpropanoid & lignan glycosides', 'Adaptogenic; found in Siberian ginseng');
  PERFORM herbal.ensure_constituent('withanolides',     'steroidal lactone', 'Adaptogenic, anti-inflammatory, anticancer; found in ashwagandha');
  PERFORM herbal.ensure_constituent('withaferin A',     'steroidal lactone', 'Potent anti-inflammatory and anticancer withanolide');
  PERFORM herbal.ensure_constituent('withanosides',     'steroidal glycoside', 'Nootropic; found in ashwagandha');
  PERFORM herbal.ensure_constituent('schisandrin',      'lignan', 'Hepatoprotective; adaptogenic; found in schisandra');
  PERFORM herbal.ensure_constituent('schisandrin B',    'lignan');
  PERFORM herbal.ensure_constituent('gomisin A',        'lignan');

  -- Iridoids
  PERFORM herbal.ensure_constituent('aucubin',          'iridoid glycoside', 'Anti-inflammatory; hepatoprotective');
  PERFORM herbal.ensure_constituent('catalpol',         'iridoid glycoside');
  PERFORM herbal.ensure_constituent('agnuside',         'iridoid glycoside', 'Found in chasteberry');
  PERFORM herbal.ensure_constituent('asperuloside',     'iridoid glycoside', 'Found in cleavers');
  PERFORM herbal.ensure_constituent('harpagide',        'iridoid glycoside', 'Anti-inflammatory; found in devil''s claw');
  PERFORM herbal.ensure_constituent('harpagoside',      'iridoid glycoside', 'Anti-inflammatory; found in devil''s claw');
  PERFORM herbal.ensure_constituent('leonuride',        'iridoid glycoside', 'Found in motherwort');
  PERFORM herbal.ensure_constituent('valepotriates',    'epoxide iridoid', 'Sedative, antispasmodic; found in valerian root');
  PERFORM herbal.ensure_constituent('valtrate',         'epoxide iridoid');
  PERFORM herbal.ensure_constituent('didrovaltrate',    'epoxide iridoid');
  PERFORM herbal.ensure_constituent('loganin',          'iridoid glycoside');

  -- Naphthodianthrones & xanthones
  PERFORM herbal.ensure_constituent('hypericin',        'naphthodianthrone', 'Antidepressant; photosensitizing; found in St. John''s Wort');
  PERFORM herbal.ensure_constituent('pseudohypericin',  'naphthodianthrone');
  PERFORM herbal.ensure_constituent('hyperforin',       'acylphloroglucinol', 'Antidepressant; inhibits serotonin/dopamine/norepinephrine reuptake');
  PERFORM herbal.ensure_constituent('adhyperforin',     'acylphloroglucinol');

  -- Anthraquinones
  PERFORM herbal.ensure_constituent('emodin',           'anthraquinone', 'Cathartic; anti-inflammatory');
  PERFORM herbal.ensure_constituent('chrysophanol',     'anthraquinone');
  PERFORM herbal.ensure_constituent('physcion',         'anthraquinone');
  PERFORM herbal.ensure_constituent('aloe-emodin',      'anthraquinone');
  PERFORM herbal.ensure_constituent('barbaloin',        'anthraquinone glycoside', 'Cathartic; found in aloe');
  PERFORM herbal.ensure_constituent('sennosides',       'anthraquinone glycoside', 'Stimulant laxative');

  -- Phenylpropanoids
  PERFORM herbal.ensure_constituent('eugenol',          'phenylpropanoid', 'Analgesic; antimicrobial; found in clove');
  PERFORM herbal.ensure_constituent('methyleugenol',    'phenylpropanoid', 'Possible carcinogen');
  PERFORM herbal.ensure_constituent('anethole',         'phenylpropanoid', 'Estrogenic; carminative; found in anise and fennel');
  PERFORM herbal.ensure_constituent('apiole',           'phenylpropanoid', 'Uterotonic; found in parsley');
  PERFORM herbal.ensure_constituent('myristicin',       'phenylpropanoid', 'Psychoactive; found in parsley');
  PERFORM herbal.ensure_constituent('safrole',          'phenylpropanoid', 'Carcinogen; found in sassafras');
  PERFORM herbal.ensure_constituent('asarone',          'phenylpropanoid', 'Carcinogen in high doses');
  PERFORM herbal.ensure_constituent('trans-cinnamic acid','hydroxycinnamic acid');
  PERFORM herbal.ensure_constituent('methylchavicol',   'phenylpropanoid', 'Found in basil');

  -- Coumarins & furanocoumarins
  PERFORM herbal.ensure_constituent('herniarin',        'coumarin', 'Found in chamomile');
  PERFORM herbal.ensure_constituent('umbelliferone',    'coumarin');
  PERFORM herbal.ensure_constituent('scopoletin',       'coumarin', 'Anti-inflammatory; spasmolytic; found in cramp bark');
  PERFORM herbal.ensure_constituent('aesculetin',       'coumarin');
  PERFORM herbal.ensure_constituent('psoralen',         'furanocoumarin', 'Photosensitizing');
  PERFORM herbal.ensure_constituent('bergapten',        'furanocoumarin', 'Photosensitizing');
  PERFORM herbal.ensure_constituent('osthole',          'coumarin', 'Found in dong quai; antispasmodic');
  PERFORM herbal.ensure_constituent('imperatorin',      'furanocoumarin');
  PERFORM herbal.ensure_constituent('peucedanin',       'furanocoumarin');

  -- Polysaccharides & mucilages
  PERFORM herbal.ensure_constituent('inulin',           'fructo-oligosaccharide', 'Prebiotic; found in burdock, dandelion, elecampane');
  PERFORM herbal.ensure_constituent('mucilaginous polysaccharides','polysaccharide', 'Demulcent; soothing to mucous membranes');
  PERFORM herbal.ensure_constituent('arabinogalacturonan','acidic polysaccharide', 'Primary mucilage of marshmallow');
  PERFORM herbal.ensure_constituent('pectins',          'polysaccharide', 'Demulcent; binds toxins in GI tract');
  PERFORM herbal.ensure_constituent('beta-glucans',     'polysaccharide', 'Immunomodulatory; found in medicinal mushrooms');
  PERFORM herbal.ensure_constituent('astragalans',      'polysaccharide', 'Immunomodulatory; found in astragalus');
  PERFORM herbal.ensure_constituent('echinacea polysaccharides','polysaccharide', 'Immunostimulant; found in echinacea');
  PERFORM herbal.ensure_constituent('aloe polysaccharides','polysaccharide', 'Immunomodulatory; wound healing');
  PERFORM herbal.ensure_constituent('alginic acid',     'polysaccharide');
  PERFORM herbal.ensure_constituent('ulvan',            'sulfated polysaccharide');

  -- Glycosides (misc)
  PERFORM herbal.ensure_constituent('alliin',           'cysteine sulfoxide', 'Precursor to allicin; found in garlic');
  PERFORM herbal.ensure_constituent('allicin',          'organosulfur', 'Antimicrobial; cardiovascular; formed enzymatically from alliin');
  PERFORM herbal.ensure_constituent('ajoene',           'organosulfur', 'Antiplatelet; found in garlic');
  PERFORM herbal.ensure_constituent('diallyl disulfide','organosulfur', 'Antimicrobial; anticancer');
  PERFORM herbal.ensure_constituent('arbutin',          'hydroquinone glycoside', 'Urinary antiseptic; inhibits melanin synthesis');
  PERFORM herbal.ensure_constituent('amygdalin',        'cyanogenic glycoside');
  PERFORM herbal.ensure_constituent('prunasin',         'cyanogenic glycoside', 'Found in wild cherry; antitussive');
  PERFORM herbal.ensure_constituent('sinigrin',         'glucosinolate', 'Precursor to allyl isothiocyanate; found in mustard');
  PERFORM herbal.ensure_constituent('gluconasturtiin',  'glucosinolate');
  PERFORM herbal.ensure_constituent('allyl isothiocyanate','isothiocyanate', 'Rubefacient; antimicrobial; from mustard');
  PERFORM herbal.ensure_constituent('sambunigrin',      'cyanogenic glycoside', 'Toxic raw; destroyed by heat; found in elderberry');
  PERFORM herbal.ensure_constituent('cardiac glycosides','cardiac glycoside', 'Positive inotropic; found in lily of the valley, digitalis');
  PERFORM herbal.ensure_constituent('convallotoxin',    'cardiac glycoside', 'Found in lily of the valley');
  PERFORM herbal.ensure_constituent('convallatoxol',    'cardiac glycoside');
  PERFORM herbal.ensure_constituent('digitalinum verum','cardiac glycoside');

  -- Resins & balsams
  PERFORM herbal.ensure_constituent('resins',           'resin', 'Antimicrobial; expectorant; require high alcohol to extract');
  PERFORM herbal.ensure_constituent('boswellic acids',  'pentacyclic triterpenoid acid', 'Anti-inflammatory; inhibit 5-LOX');
  PERFORM herbal.ensure_constituent('guaiacol',         'phenol', 'Expectorant; found in guaiacum');
  PERFORM herbal.ensure_constituent('myrrhanols',       'triterpenoid', 'Anti-inflammatory; found in myrrh');
  PERFORM herbal.ensure_constituent('commiphoric acid', 'terpenoid acid', 'Found in myrrh');

  -- Allantoin & other
  PERFORM herbal.ensure_constituent('allantoin',        'purine derivative', 'Cell-proliferant; wound healing; found in comfrey and plantain');
  PERFORM herbal.ensure_constituent('silymarin',        'flavonolignan complex', 'Hepatoprotective; antioxidant; found in milk thistle');
  PERFORM herbal.ensure_constituent('silybin',          'flavonolignan', 'Most active component of silymarin');
  PERFORM herbal.ensure_constituent('silydianin',       'flavonolignan');
  PERFORM herbal.ensure_constituent('silychristin',     'flavonolignan');
  PERFORM herbal.ensure_constituent('curcumin',         'curcuminoid', 'Potent anti-inflammatory; inhibits NF-κB; hepatoprotective');
  PERFORM herbal.ensure_constituent('demethoxycurcumin','curcuminoid');
  PERFORM herbal.ensure_constituent('bisdemethoxycurcumin','curcuminoid');
  PERFORM herbal.ensure_constituent('gingerols',        'gingerol', 'Anti-nausea; anti-inflammatory; found in fresh ginger');
  PERFORM herbal.ensure_constituent('6-gingerol',       'gingerol', 'Primary active gingerol');
  PERFORM herbal.ensure_constituent('shogaols',         'dehydrated gingerol', 'More potent than gingerols; found in dried ginger');
  PERFORM herbal.ensure_constituent('zingerone',        'gingerol degradation product');
  PERFORM herbal.ensure_constituent('kavalactones',     'alpha-pyrone', 'Anxiolytic; muscle relaxant; found in kava');
  PERFORM herbal.ensure_constituent('kavain',           'alpha-pyrone', 'Primary kavalactone; anxiolytic');
  PERFORM herbal.ensure_constituent('dihydrokavain',    'alpha-pyrone');
  PERFORM herbal.ensure_constituent('methysticin',      'alpha-pyrone');
  PERFORM herbal.ensure_constituent('dihydromethysticin','alpha-pyrone', 'Sedative kavalactone');
  PERFORM herbal.ensure_constituent('yangonin',         'alpha-pyrone');
  PERFORM herbal.ensure_constituent('ginkgolides',      'diterpene trilactone', 'PAF antagonist; found in ginkgo');
  PERFORM herbal.ensure_constituent('ginkgolide A',     'diterpene trilactone');
  PERFORM herbal.ensure_constituent('ginkgolide B',     'diterpene trilactone', 'Most potent PAF antagonist');
  PERFORM herbal.ensure_constituent('bilobalide',       'sesquiterpene trilactone', 'Neuroprotective; found in ginkgo');
  PERFORM herbal.ensure_constituent('flavonol glycosides (ginkgo)','flavonol glycoside', 'Antioxidant; in ginkgo leaf extract');
  PERFORM herbal.ensure_constituent('valerenic acid',   'sesquiterpene acid', 'Anxiolytic; GABA-A modulator; found in valerian');
  PERFORM herbal.ensure_constituent('acetoxyvalerenic acid','sesquiterpene acid');
  PERFORM herbal.ensure_constituent('isovaleric acid',  'short-chain fatty acid', 'Characteristic odor; sedative in valerian');
  PERFORM herbal.ensure_constituent('GABA',             'amino acid neurotransmitter', 'Inhibitory neurotransmitter; found in valerian');
  PERFORM herbal.ensure_constituent('humulone',         'alpha acid', 'Bitter; antibacterial; found in hops');
  PERFORM herbal.ensure_constituent('lupulone',         'beta acid', 'Bitter; antibacterial; found in hops');
  PERFORM herbal.ensure_constituent('2-methyl-3-buten-2-ol','monoterpene alcohol', 'Major sedative from hops; breakdown product of humulone');
  PERFORM herbal.ensure_constituent('lignans',          'lignan', 'Phytoestrogenic; hepatoprotective; antioxidant');
  PERFORM herbal.ensure_constituent('Z-ligustilide',    'phthalide', 'Antispasmodic; found in dong quai and osha');
  PERFORM herbal.ensure_constituent('butylidenephthalide','phthalide', 'Antispasmodic; found in dong quai');
  PERFORM herbal.ensure_constituent('alkamides',        'isobutylamide', 'Immunomodulatory; tingling sensation; found in echinacea');
  PERFORM herbal.ensure_constituent('urtica dioica agglutinin','lectin', 'Immunomodulatory; anti-inflammatory; found in nettle root');
  PERFORM herbal.ensure_constituent('formic acid',      'organic acid', 'Stinging compound in nettle hairs');
  PERFORM herbal.ensure_constituent('histamine',        'biogenic amine', 'Stinging compound in nettle hairs');
  PERFORM herbal.ensure_constituent('serotonin',        'indoleamine', 'Stinging compound in nettle hairs');
  PERFORM herbal.ensure_constituent('pyrrolizidine alkaloids','pyrrolizidine alkaloid', 'Hepatotoxic in large doses; found in comfrey root');
  PERFORM herbal.ensure_constituent('symphytine',       'pyrrolizidine alkaloid', 'Hepatotoxic; found in comfrey');
  PERFORM herbal.ensure_constituent('echimidine',       'pyrrolizidine alkaloid');
  PERFORM herbal.ensure_constituent('ganoderic acids',  'triterpenoid', 'Hepatoprotective; immunomodulatory; found in reishi');
  PERFORM herbal.ensure_constituent('adenosine',        'nucleoside', 'Cardiovascular; found in reishi and astragalus');
  PERFORM herbal.ensure_constituent('harpagophytum procumbens triterpenoids','triterpenoid', 'Anti-inflammatory; found in devil''s claw');
  PERFORM herbal.ensure_constituent('actein',           'cycloartane triterpenoid glycoside', 'Found in black cohosh');
  PERFORM herbal.ensure_constituent('23-epi-26-deoxyactein','cycloartane triterpenoid glycoside', 'Primary active triterpene of black cohosh');
  PERFORM herbal.ensure_constituent('cimicifugoside',   'cycloartane triterpenoid glycoside');
  PERFORM herbal.ensure_constituent('fukinolic acid',   'caffeic acid ester', 'Found in black cohosh');
  PERFORM herbal.ensure_constituent('carotenoids',      'carotenoid', 'Antioxidant; pro-vitamin A');
  PERFORM herbal.ensure_constituent('beta-carotene',    'carotenoid');
  PERFORM herbal.ensure_constituent('lutein',           'xanthophyll carotenoid');
  PERFORM herbal.ensure_constituent('zeaxanthin',       'xanthophyll carotenoid');
  PERFORM herbal.ensure_constituent('mucilage',         'polysaccharide', 'General demulcent mucilage');
  PERFORM herbal.ensure_constituent('oxalates',         'organic acid', 'Astringent; found in yellow dock and sorrel');
  PERFORM herbal.ensure_constituent('silica',           'mineral', 'Connective tissue support; found in horsetail');
  PERFORM herbal.ensure_constituent('potassium',        'mineral', 'Diuretic effect via osmosis; found in dandelion leaf');
  PERFORM herbal.ensure_constituent('iron',             'mineral', 'Found in nettle leaf');
  PERFORM herbal.ensure_constituent('selenium',         'mineral');
  PERFORM herbal.ensure_constituent('baicalin',         'flavone glucuronide', 'Anti-inflammatory; anxiolytic; found in skullcap');
  PERFORM herbal.ensure_constituent('baicalein',        'flavone', 'Active aglycone of baicalin');
  PERFORM herbal.ensure_constituent('scutellarein',     'flavone', 'Found in skullcap');
  PERFORM herbal.ensure_constituent('wogonin',          'flavone', 'Anti-inflammatory; anxiolytic; found in skullcap');
  PERFORM herbal.ensure_constituent('elecampane camphor','sesquiterpene lactone');
  PERFORM herbal.ensure_constituent('alantolactone',    'sesquiterpene lactone', 'Antimicrobial; found in elecampane');
  PERFORM herbal.ensure_constituent('isoalantolactone', 'sesquiterpene lactone');
  PERFORM herbal.ensure_constituent('thiarubrine A',    'polyacetylene', 'Antifungal; found in echinacea root');
  PERFORM herbal.ensure_constituent('polyacetylenes',   'polyacetylene', 'Antimicrobial; immunostimulant');
  PERFORM herbal.ensure_constituent('phthalides',       'phthalide', 'Antispasmodic; sedative; in celery seed');
  PERFORM herbal.ensure_constituent('3-n-butylphthalide','phthalide', 'Antispasmodic; antihypertensive; found in celery seed');
  PERFORM herbal.ensure_constituent('sedanolide',       'phthalide', 'Found in celery seed');
  PERFORM herbal.ensure_constituent('steroidal saponins','saponin', 'Precursors to steroid hormones; expectorant');
  PERFORM herbal.ensure_constituent('triterpenoid saponins','saponin', 'Expectorant; adaptogenic');
  PERFORM herbal.ensure_constituent('glycoalkaloids',   'steroidal alkaloid glycoside');
  PERFORM herbal.ensure_constituent('hydrastine',       'isoquinoline alkaloid', 'Astringent; haemostatic; found in goldenseal');
  PERFORM herbal.ensure_constituent('meconine',         'isoquinoline alkaloid');
  PERFORM herbal.ensure_constituent('fatty acids',      'fatty acid', 'Nutritive; anti-inflammatory');
  PERFORM herbal.ensure_constituent('gamma-linolenic acid','omega-6 fatty acid', 'Anti-inflammatory; found in evening primrose');
  PERFORM herbal.ensure_constituent('linoleic acid',    'omega-6 fatty acid');
  PERFORM herbal.ensure_constituent('alpha-linolenic acid','omega-3 fatty acid');
  PERFORM herbal.ensure_constituent('phytosterols',     'phytosterol', 'Cholesterol-lowering; 5-alpha-reductase inhibition');
  PERFORM herbal.ensure_constituent('saw palmetto fatty acids','fatty acid', 'Inhibit 5-alpha-reductase; found in saw palmetto');
  PERFORM herbal.ensure_constituent('harmine',          'beta-carboline alkaloid', 'MAO-A inhibitor; found in passionflower trace');
  PERFORM herbal.ensure_constituent('harmane',          'beta-carboline alkaloid');
  PERFORM herbal.ensure_constituent('gossypol',         'polyphenol');
  PERFORM herbal.ensure_constituent('methylxanthines',  'purine alkaloid', 'CNS stimulants; collective term for caffeine/theobromine/theophylline');
  PERFORM herbal.ensure_constituent('piperine',         'piperidine alkaloid', 'Bioavailability enhancer; found in pepper');
  PERFORM herbal.ensure_constituent('aescin',           'triterpenoid saponin', 'Reduces capillary permeability; found in horse chestnut');
  PERFORM herbal.ensure_constituent('aesculin',         'coumarin glycoside', 'Found in horse chestnut');
  PERFORM herbal.ensure_constituent('fumaric acid',     'organic acid', 'Found in fumitory; inhibits DOPA decarboxylase');
  PERFORM herbal.ensure_constituent('fumarine',         'isoquinoline alkaloid', 'Found in fumitory');
  PERFORM herbal.ensure_constituent('protopine',        'isoquinoline alkaloid');
  PERFORM herbal.ensure_constituent('guggulsterones',   'steroidal ketone', 'Thyroid stimulating; hypolipidemic; found in guggul');
  PERFORM herbal.ensure_constituent('chlorogenic acid', 'hydroxycinnamic acid');

  RAISE NOTICE 'Block 1 complete: constituents inserted.';
END $$;

-- ─── BLOCK 2: Achillea millefolium (yarrow) ──────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.ensure_constituent('achillin',        'sesquiterpene lactone');
  PERFORM herbal.ensure_constituent('achillicin',      'sesquiterpene lactone');
  PERFORM herbal.link_constituent('Achillea millefolium', 'chamazulene',      'major',    10);
  PERFORM herbal.link_constituent('Achillea millefolium', 'alpha-bisabolol',  'minor',    20);
  PERFORM herbal.link_constituent('Achillea millefolium', 'camphor',          'moderate', 30);
  PERFORM herbal.link_constituent('Achillea millefolium', 'borneol',          'minor',    40);
  PERFORM herbal.link_constituent('Achillea millefolium', '1,8-cineole',      'moderate', 50);
  PERFORM herbal.link_constituent('Achillea millefolium', 'thujone',          'minor',    60);
  PERFORM herbal.link_constituent('Achillea millefolium', 'achillin',         'major',    70);
  PERFORM herbal.link_constituent('Achillea millefolium', 'achillicin',       'moderate', 80);
  PERFORM herbal.link_constituent('Achillea millefolium', 'apigenin',         'major',    90);
  PERFORM herbal.link_constituent('Achillea millefolium', 'luteolin',         'moderate', 100);
  PERFORM herbal.link_constituent('Achillea millefolium', 'casticin',         'moderate', 110);
  PERFORM herbal.link_constituent('Achillea millefolium', 'rutin',            'moderate', 120);
  PERFORM herbal.link_constituent('Achillea millefolium', 'quercetin',        'moderate', 130);
  PERFORM herbal.link_constituent('Achillea millefolium', 'achilline',        'minor',    140);
  PERFORM herbal.link_constituent('Achillea millefolium', 'betonicine',       'minor',    150);
  PERFORM herbal.link_constituent('Achillea millefolium', 'tannins',          'moderate', 160);
  PERFORM herbal.link_constituent('Achillea millefolium', 'salicylic acid',   'minor',    170);
  PERFORM herbal.set_menstruum('Achillea millefolium', 25, 60, NULL, NULL, TRUE,
    '25–60% alcohol or water', 'Fresh plant tincture at 25%; dried herb needs 40–60%. Water extracts volatile oils via steam.');
  RAISE NOTICE 'Achillea millefolium done';
END $$;

-- ─── BLOCK 3: Aesculus hippocastanum (horse chestnut) ───────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Aesculus hippocastanum', 'aescin',          'primary', 10);
  PERFORM herbal.link_constituent('Aesculus hippocastanum', 'aesculin',        'major',   20);
  PERFORM herbal.link_constituent('Aesculus hippocastanum', 'proanthocyanidins','major',   30);
  PERFORM herbal.link_constituent('Aesculus hippocastanum', 'quercetin',       'moderate',40);
  PERFORM herbal.link_constituent('Aesculus hippocastanum', 'kaempferol',      'moderate',50);
  PERFORM herbal.link_constituent('Aesculus hippocastanum', 'rutin',           'moderate',60);
  PERFORM herbal.link_constituent('Aesculus hippocastanum', 'tannins',         'moderate',70);
  PERFORM herbal.set_menstruum('Aesculus hippocastanum', 40, 60, NULL, NULL, FALSE,
    '40–60% alcohol', 'Saponins and coumarins require moderate alcohol; bark tincture.');
  RAISE NOTICE 'Aesculus hippocastanum done';
END $$;

-- ─── BLOCK 4: Agrimonia eupatoria (agrimony) ─────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Agrimonia eupatoria', 'tannins',          'primary',  10);
  PERFORM herbal.link_constituent('Agrimonia eupatoria', 'quercetin',        'major',    20);
  PERFORM herbal.link_constituent('Agrimonia eupatoria', 'rutin',            'major',    30);
  PERFORM herbal.link_constituent('Agrimonia eupatoria', 'luteolin',         'moderate', 40);
  PERFORM herbal.link_constituent('Agrimonia eupatoria', 'apigenin',         'moderate', 50);
  PERFORM herbal.link_constituent('Agrimonia eupatoria', 'ursolic acid',     'moderate', 60);
  PERFORM herbal.link_constituent('Agrimonia eupatoria', 'catechin',         'moderate', 70);
  PERFORM herbal.link_constituent('Agrimonia eupatoria', 'ellagitannins',    'moderate', 80);
  PERFORM herbal.link_constituent('Agrimonia eupatoria', 'bitter glycosides','moderate', 90);
  PERFORM herbal.ensure_constituent('bitter glycosides', 'glycoside', 'General bitter glycosides');
  PERFORM herbal.link_constituent('Agrimonia eupatoria', 'bitter glycosides','moderate', 90);
  PERFORM herbal.set_menstruum('Agrimonia eupatoria', 25, 45, NULL, NULL, TRUE,
    '25–45% alcohol or water', 'Tannins and flavonoids extract well in water or low alcohol.');
  RAISE NOTICE 'Agrimonia eupatoria done';
END $$;

-- ─── BLOCK 5: Allium sativum (garlic) ────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Allium sativum', 'alliin',           'primary', 10);
  PERFORM herbal.link_constituent('Allium sativum', 'allicin',          'primary', 20, 'Formed when raw garlic is crushed; destroyed by heat');
  PERFORM herbal.link_constituent('Allium sativum', 'ajoene',           'major',   30);
  PERFORM herbal.link_constituent('Allium sativum', 'diallyl disulfide','major',   40);
  PERFORM herbal.link_constituent('Allium sativum', 'quercetin',        'moderate',50);
  PERFORM herbal.link_constituent('Allium sativum', 'beta-sitosterol',  'minor',   60);
  PERFORM herbal.link_constituent('Allium sativum', 'saponins',         'minor',   70);
  PERFORM herbal.ensure_constituent('saponins', 'saponin', 'General saponin glycosides');
  PERFORM herbal.link_constituent('Allium sativum', 'saponins',         'minor',   70);
  PERFORM herbal.set_menstruum('Allium sativum', 25, 50, NULL, NULL, TRUE,
    'water or 25–50% alcohol', 'Organosulfurs extract in water; alcohol stabilizes. Fresh plant preferred.');
  RAISE NOTICE 'Allium sativum done';
END $$;

-- ─── BLOCK 6: Althaea officinalis (marshmallow) ──────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Althaea officinalis', 'arabinogalacturonan',        'primary', 10, 'Root highest in mucilage');
  PERFORM herbal.link_constituent('Althaea officinalis', 'mucilaginous polysaccharides','primary', 20);
  PERFORM herbal.link_constituent('Althaea officinalis', 'pectins',                    'major',   30);
  PERFORM herbal.link_constituent('Althaea officinalis', 'quercetin',                  'moderate',40);
  PERFORM herbal.link_constituent('Althaea officinalis', 'kaempferol',                 'moderate',50);
  PERFORM herbal.link_constituent('Althaea officinalis', 'scopoletin',                 'minor',   60);
  PERFORM herbal.link_constituent('Althaea officinalis', 'tannins',                    'minor',   70);
  PERFORM herbal.set_menstruum('Althaea officinalis', NULL, NULL, 60, NULL, TRUE,
    'cold water or glycerin', 'Mucilages are destroyed by heat and precipitated by alcohol; cold infusion or glycerite best.');
  RAISE NOTICE 'Althaea officinalis done';
END $$;

-- ─── BLOCK 7: Arctium lappa (burdock) ────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Arctium lappa', 'inulin',           'primary', 10, 'Up to 45% in root');
  PERFORM herbal.link_constituent('Arctium lappa', 'arctiopicrin',     'major',   20);
  PERFORM herbal.link_constituent('Arctium lappa', 'polyacetylenes',   'moderate',30);
  PERFORM herbal.link_constituent('Arctium lappa', 'lignans',          'moderate',40);
  PERFORM herbal.link_constituent('Arctium lappa', 'caffeic acid',     'moderate',50);
  PERFORM herbal.link_constituent('Arctium lappa', 'chlorogenic acid', 'moderate',60);
  PERFORM herbal.link_constituent('Arctium lappa', 'quercetin',        'moderate',70);
  PERFORM herbal.link_constituent('Arctium lappa', 'tannins',          'moderate',80);
  PERFORM herbal.link_constituent('Arctium lappa', 'mucilage',         'moderate',90);
  PERFORM herbal.set_menstruum('Arctium lappa', 25, 60, NULL, NULL, TRUE,
    '25–60% alcohol or water', 'Inulin extracts in water; bitter sesquiterpenes need moderate alcohol.');
  RAISE NOTICE 'Arctium lappa done';
END $$;

-- ─── BLOCK 8: Arctostaphylos uva-ursi (bearberry / uva ursi) ─────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Arctostaphylos uva-ursi', 'arbutin',          'primary', 10, 'Urinary antiseptic prodrug of hydroquinone');
  PERFORM herbal.link_constituent('Arctostaphylos uva-ursi', 'methylarbutin',    'major',   20);
  PERFORM herbal.link_constituent('Arctostaphylos uva-ursi', 'tannins',          'primary', 30, 'Up to 40%');
  PERFORM herbal.link_constituent('Arctostaphylos uva-ursi', 'ursolic acid',     'major',   40);
  PERFORM herbal.link_constituent('Arctostaphylos uva-ursi', 'quercetin',        'moderate',50);
  PERFORM herbal.link_constituent('Arctostaphylos uva-ursi', 'hyperoside',       'moderate',60);
  PERFORM herbal.link_constituent('Arctostaphylos uva-ursi', 'isoquercitrin',    'moderate',70);
  PERFORM herbal.ensure_constituent('methylarbutin', 'hydroquinone glycoside', 'Found in uva ursi');
  PERFORM herbal.link_constituent('Arctostaphylos uva-ursi', 'methylarbutin',    'major',   20);
  PERFORM herbal.set_menstruum('Arctostaphylos uva-ursi', 25, 60, NULL, NULL, TRUE,
    '25–60% alcohol or water', 'Arbutin is water-soluble; tannins extract in water or low alcohol.');
  RAISE NOTICE 'Arctostaphylos uva-ursi done';
END $$;

-- ─── BLOCK 9: Artemisia absinthium (wormwood) ────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Artemisia absinthium', 'absinthin',     'primary', 10);
  PERFORM herbal.link_constituent('Artemisia absinthium', 'artabsin',      'primary', 20);
  PERFORM herbal.link_constituent('Artemisia absinthium', 'thujone',       'major',   30, 'Neurotoxic in large doses');
  PERFORM herbal.link_constituent('Artemisia absinthium', 'chamazulene',   'moderate',40);
  PERFORM herbal.link_constituent('Artemisia absinthium', 'azulene',       'minor',   50);
  PERFORM herbal.link_constituent('Artemisia absinthium', 'camphor',       'moderate',60);
  PERFORM herbal.link_constituent('Artemisia absinthium', 'quercetin',     'moderate',70);
  PERFORM herbal.link_constituent('Artemisia absinthium', 'rutin',         'moderate',80);
  PERFORM herbal.link_constituent('Artemisia absinthium', 'caffeic acid',  'moderate',90);
  PERFORM herbal.set_menstruum('Artemisia absinthium', 40, 70, NULL, NULL, FALSE,
    '40–70% alcohol', 'Bitter sesquiterpenes and volatile oils require moderate-high alcohol.');
  RAISE NOTICE 'Artemisia absinthium done';
END $$;

-- ─── BLOCK 10: Artemisia vulgaris (mugwort) ──────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Artemisia vulgaris', 'thujone',       'moderate',10);
  PERFORM herbal.link_constituent('Artemisia vulgaris', 'camphor',       'moderate',20);
  PERFORM herbal.link_constituent('Artemisia vulgaris', '1,8-cineole',   'moderate',30);
  PERFORM herbal.link_constituent('Artemisia vulgaris', 'artabsin',      'moderate',40);
  PERFORM herbal.link_constituent('Artemisia vulgaris', 'quercetin',     'moderate',50);
  PERFORM herbal.link_constituent('Artemisia vulgaris', 'rutin',         'moderate',60);
  PERFORM herbal.link_constituent('Artemisia vulgaris', 'caffeic acid',  'moderate',70);
  PERFORM herbal.set_menstruum('Artemisia vulgaris', 40, 65, NULL, NULL, FALSE,
    '40–65% alcohol', 'Similar profile to wormwood; bitter sesquiterpenes need moderate alcohol.');
  RAISE NOTICE 'Artemisia vulgaris done';
END $$;

-- ─── BLOCK 11: Astragalus membranaceus ───────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Astragalus membranaceus', 'astragalans',      'primary', 10);
  PERFORM herbal.link_constituent('Astragalus membranaceus', 'astragaloside IV', 'primary', 20);
  PERFORM herbal.link_constituent('Astragalus membranaceus', 'cycloastragenol',  'major',   30);
  PERFORM herbal.link_constituent('Astragalus membranaceus', 'calycosin',        'major',   40);
  PERFORM herbal.link_constituent('Astragalus membranaceus', 'formononetin',     'moderate',50);
  PERFORM herbal.link_constituent('Astragalus membranaceus', 'ononin',           'moderate',60);
  PERFORM herbal.link_constituent('Astragalus membranaceus', 'beta-sitosterol',  'moderate',70);
  PERFORM herbal.link_constituent('Astragalus membranaceus', 'adenosine',        'minor',   80);
  PERFORM herbal.ensure_constituent('ononin', 'isoflavone glycoside', 'Found in astragalus');
  PERFORM herbal.link_constituent('Astragalus membranaceus', 'ononin',           'moderate',60);
  PERFORM herbal.set_menstruum('Astragalus membranaceus', 25, 60, NULL, NULL, TRUE,
    '25–60% alcohol or water decoction', 'Polysaccharides extract in hot water; saponins in moderate alcohol. Traditional use is decoction.');
  RAISE NOTICE 'Astragalus membranaceus done';
END $$;

-- ─── BLOCK 12: Avena sativa (oats) ───────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Avena sativa', 'beta-glucans',     'primary', 10, 'Green oat milky stage highest');
  PERFORM herbal.link_constituent('Avena sativa', 'avenanthramides',  'major',   20);
  PERFORM herbal.link_constituent('Avena sativa', 'saponins',         'moderate',30);
  PERFORM herbal.link_constituent('Avena sativa', 'quercetin',        'moderate',40);
  PERFORM herbal.link_constituent('Avena sativa', 'rutin',            'moderate',50);
  PERFORM herbal.link_constituent('Avena sativa', 'fatty acids',      'moderate',60);
  PERFORM herbal.link_constituent('Avena sativa', 'silica',           'minor',   70);
  PERFORM herbal.ensure_constituent('avenanthramides', 'alkaloid amide', 'Antioxidant, anti-inflammatory; unique to oats');
  PERFORM herbal.link_constituent('Avena sativa', 'avenanthramides',  'major',   20);
  PERFORM herbal.set_menstruum('Avena sativa', 25, 60, NULL, NULL, TRUE,
    '25–60% alcohol (milky oats fresh)', 'Milky stage oats tincture in 25–60% alcohol; dried herb less active.');
  RAISE NOTICE 'Avena sativa done';
END $$;

-- ─── BLOCK 13: Baptisia tinctoria (wild indigo) ──────────────────────────────
DO $$ BEGIN
  PERFORM herbal.ensure_constituent('baptisin',    'isoflavone glycoside', 'Found in wild indigo');
  PERFORM herbal.ensure_constituent('baptifoline', 'quinolizidine alkaloid');
  PERFORM herbal.link_constituent('Baptisia tinctoria', 'baptifoline',  'primary', 10);
  PERFORM herbal.link_constituent('Baptisia tinctoria', 'anagyrine',    'major',   20);
  PERFORM herbal.link_constituent('Baptisia tinctoria', 'baptisin',     'major',   30);
  PERFORM herbal.link_constituent('Baptisia tinctoria', 'formononetin', 'moderate',40);
  PERFORM herbal.link_constituent('Baptisia tinctoria', 'biochanin A',  'moderate',50);
  PERFORM herbal.link_constituent('Baptisia tinctoria', 'polyacetylenes','moderate',60);
  PERFORM herbal.set_menstruum('Baptisia tinctoria', 50, 70, NULL, NULL, FALSE,
    '50–70% alcohol', 'Alkaloids and isoflavones require moderate-high alcohol. Use sparingly—low therapeutic index.');
  RAISE NOTICE 'Baptisia tinctoria done';
END $$;

-- ─── BLOCK 14: Calendula officinalis ─────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Calendula officinalis', 'oleanolic acid',    'primary', 10);
  PERFORM herbal.link_constituent('Calendula officinalis', 'ursolic acid',      'primary', 20);
  PERFORM herbal.link_constituent('Calendula officinalis', 'quercetin',         'major',   30);
  PERFORM herbal.link_constituent('Calendula officinalis', 'isorhamnetin',      'major',   40);
  PERFORM herbal.link_constituent('Calendula officinalis', 'hyperoside',        'major',   50);
  PERFORM herbal.link_constituent('Calendula officinalis', 'beta-carotene',     'major',   60);
  PERFORM herbal.link_constituent('Calendula officinalis', 'lutein',            'major',   70);
  PERFORM herbal.link_constituent('Calendula officinalis', 'zeaxanthin',        'moderate',80);
  PERFORM herbal.link_constituent('Calendula officinalis', 'mucilaginous polysaccharides','moderate',90);
  PERFORM herbal.link_constituent('Calendula officinalis', 'saponins',          'major',   100);
  PERFORM herbal.link_constituent('Calendula officinalis', 'resins',            'moderate',110);
  PERFORM herbal.link_constituent('Calendula officinalis', 'tannins',           'moderate',120);
  PERFORM herbal.set_menstruum('Calendula officinalis', 60, 90, NULL, NULL, FALSE,
    '60–90% alcohol', 'Resins and carotenoids require high alcohol. Infused oil captures carotenoids topically.');
  RAISE NOTICE 'Calendula officinalis done';
END $$;

-- ─── BLOCK 15: Capsicum annuum / spp. (cayenne) ──────────────────────────────
DO $$ BEGIN
  PERFORM herbal.ensure_constituent('capsaicin',       'capsaicinoid', 'TRPV1 agonist; analgesic via substance P depletion');
  PERFORM herbal.ensure_constituent('dihydrocapsaicin','capsaicinoid');
  PERFORM herbal.link_constituent('Capsicum annuum', 'capsaicin',        'primary', 10);
  PERFORM herbal.link_constituent('Capsicum annuum', 'dihydrocapsaicin', 'major',   20);
  PERFORM herbal.link_constituent('Capsicum annuum', 'quercetin',        'moderate',30);
  PERFORM herbal.link_constituent('Capsicum annuum', 'luteolin',         'moderate',40);
  PERFORM herbal.link_constituent('Capsicum annuum', 'beta-carotene',    'major',   50);
  PERFORM herbal.link_constituent('Capsicum annuum', 'vitamin C',        'major',   60);
  PERFORM herbal.ensure_constituent('vitamin C', 'ascorbic acid', 'Antioxidant; immune support');
  PERFORM herbal.link_constituent('Capsicum annuum', 'vitamin C',        'major',   60);
  PERFORM herbal.set_menstruum('Capsicum annuum', 60, 90, NULL, NULL, FALSE,
    '60–90% alcohol', 'Capsaicinoids are highly lipophilic; require high-% alcohol or oil.');
  RAISE NOTICE 'Capsicum annuum done';
END $$;

-- ─── BLOCK 16: Cimicifuga racemosa (black cohosh) ────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Cimicifuga racemosa', '23-epi-26-deoxyactein', 'primary', 10);
  PERFORM herbal.link_constituent('Cimicifuga racemosa', 'actein',           'primary', 20);
  PERFORM herbal.link_constituent('Cimicifuga racemosa', 'cimicifugoside',   'major',   30);
  PERFORM herbal.link_constituent('Cimicifuga racemosa', 'fukinolic acid',   'major',   40);
  PERFORM herbal.link_constituent('Cimicifuga racemosa', 'cimifugin',        'moderate',50);
  PERFORM herbal.link_constituent('Cimicifuga racemosa', 'caffeic acid',     'moderate',60);
  PERFORM herbal.link_constituent('Cimicifuga racemosa', 'salicylic acid',   'minor',   70);
  PERFORM herbal.link_constituent('Cimicifuga racemosa', 'formononetin',     'trace',   80, 'Disputed; may not be present in meaningful quantity');
  PERFORM herbal.ensure_constituent('cimifugin', 'chromone', 'Antispasmodic; found in black cohosh');
  PERFORM herbal.link_constituent('Cimicifuga racemosa', 'cimifugin',        'moderate',50);
  PERFORM herbal.set_menstruum('Cimicifuga racemosa', 40, 60, NULL, NULL, FALSE,
    '40–60% alcohol', 'Triterpene glycosides require moderate alcohol; root tincture standard preparation.');
  RAISE NOTICE 'Cimicifuga racemosa done';
END $$;

-- ─── BLOCK 17: Cinnamomum verum / aromaticum (cinnamon) ──────────────────────
DO $$ BEGIN
  PERFORM herbal.ensure_constituent('cinnamaldehyde',   'phenylpropanoid', 'Antimicrobial; hypoglycemic; primary volatile of cinnamon');
  PERFORM herbal.ensure_constituent('cinnamyl acetate', 'phenylpropanoid ester');
  PERFORM herbal.link_constituent('Cinnamomum verum', 'cinnamaldehyde',   'primary', 10);
  PERFORM herbal.link_constituent('Cinnamomum verum', 'eugenol',          'major',   20, 'Higher in Ceylon cinnamon leaf');
  PERFORM herbal.link_constituent('Cinnamomum verum', 'cinnamyl acetate', 'moderate',30);
  PERFORM herbal.link_constituent('Cinnamomum verum', 'trans-cinnamic acid','major', 40);
  PERFORM herbal.link_constituent('Cinnamomum verum', 'proanthocyanidins', 'major',   50);
  PERFORM herbal.link_constituent('Cinnamomum verum', 'tannins',          'moderate',60);
  PERFORM herbal.set_menstruum('Cinnamomum verum', 40, 70, NULL, NULL, TRUE,
    '40–70% alcohol or water', 'Volatile phenols extract in moderate alcohol; tannins and water-soluble polyphenols in water/tea.');
  RAISE NOTICE 'Cinnamomum verum done';
END $$;

-- ─── BLOCK 18: Cnicus benedictus (blessed thistle) ───────────────────────────
DO $$ BEGIN
  PERFORM herbal.ensure_constituent('cnicin', 'sesquiterpene lactone', 'Intensely bitter; antibacterial; found in blessed thistle');
  PERFORM herbal.link_constituent('Cnicus benedictus', 'cnicin',         'primary', 10);
  PERFORM herbal.link_constituent('Cnicus benedictus', 'luteolin',       'moderate',20);
  PERFORM herbal.link_constituent('Cnicus benedictus', 'apigenin',       'moderate',30);
  PERFORM herbal.link_constituent('Cnicus benedictus', 'tannins',        'moderate',40);
  PERFORM herbal.link_constituent('Cnicus benedictus', 'mucilage',       'minor',   50);
  PERFORM herbal.set_menstruum('Cnicus benedictus', 25, 60, NULL, NULL, TRUE,
    '25–60% alcohol or water', 'Bitter lactone extracts readily in moderate alcohol; water infusion also effective.');
  RAISE NOTICE 'Cnicus benedictus done';
END $$;

-- ─── BLOCK 19: Commiphora molmol (myrrh) ─────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Commiphora molmol', 'resins',          'primary', 10, '~60% of dry weight');
  PERFORM herbal.link_constituent('Commiphora molmol', 'myrrhanols',      'major',   20);
  PERFORM herbal.link_constituent('Commiphora molmol', 'commiphoric acid','major',   30);
  PERFORM herbal.link_constituent('Commiphora molmol', 'furanosesquiterpenes','major',40);
  PERFORM herbal.link_constituent('Commiphora molmol', 'mucilage',        'moderate',50);
  PERFORM herbal.ensure_constituent('furanosesquiterpenes','sesquiterpene', 'Antimicrobial; found in myrrh');
  PERFORM herbal.link_constituent('Commiphora molmol', 'furanosesquiterpenes','major',40);
  PERFORM herbal.set_menstruum('Commiphora molmol', 90, 95, NULL, NULL, FALSE,
    '90–95% alcohol', 'Resins require very high alcohol or are used as oleo-gum-resin. Water will not dissolve resins.');
  RAISE NOTICE 'Commiphora molmol done';
END $$;

-- ─── BLOCK 20: Crataegus spp. (hawthorn) ─────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Crataegus spp.', 'proanthocyanidins',       'primary', 10, 'Oligomeric proanthocyanidins; key cardiotonics');
  PERFORM herbal.link_constituent('Crataegus spp.', 'vitexin',                 'primary', 20);
  PERFORM herbal.link_constituent('Crataegus spp.', 'vitexin-2''-rhamnoside',  'primary', 30);
  PERFORM herbal.link_constituent('Crataegus spp.', 'hyperoside',              'major',   40);
  PERFORM herbal.link_constituent('Crataegus spp.', 'quercetin',               'major',   50);
  PERFORM herbal.link_constituent('Crataegus spp.', 'rutin',                   'moderate',60);
  PERFORM herbal.link_constituent('Crataegus spp.', 'epicatechin',             'major',   70);
  PERFORM herbal.link_constituent('Crataegus spp.', 'chlorogenic acid',        'moderate',80);
  PERFORM herbal.link_constituent('Crataegus spp.', 'caffeic acid',            'moderate',90);
  PERFORM herbal.set_menstruum('Crataegus spp.', 40, 60, NULL, NULL, TRUE,
    '40–60% alcohol or water', 'Flavonoids and OPCs extract in moderate alcohol; berry tea also effective.');
  RAISE NOTICE 'Crataegus spp. done';
END $$;

-- ─── BLOCK 21: Curcuma longa (turmeric) ──────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Curcuma longa', 'curcumin',              'primary', 10, '~3% of dry rhizome');
  PERFORM herbal.link_constituent('Curcuma longa', 'demethoxycurcumin',     'major',   20);
  PERFORM herbal.link_constituent('Curcuma longa', 'bisdemethoxycurcumin',  'moderate',30);
  PERFORM herbal.link_constituent('Curcuma longa', 'ar-turmerone',          'major',   40);
  PERFORM herbal.link_constituent('Curcuma longa', 'zingiberene',           'moderate',50);
  PERFORM herbal.link_constituent('Curcuma longa', 'bisabolene',            'moderate',60);
  PERFORM herbal.link_constituent('Curcuma longa', 'caffeic acid',          'minor',   70);
  PERFORM herbal.set_menstruum('Curcuma longa', 60, 75, NULL, NULL, FALSE,
    '60–75% alcohol', 'Curcuminoids are poorly water-soluble; require moderate-high alcohol or fat/oil. Black pepper (piperine) enhances bioavailability.');
  RAISE NOTICE 'Curcuma longa done';
END $$;

-- ─── BLOCK 22: Cytisus scoparius (scotch broom) ──────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Cytisus scoparius', 'sparteine',   'primary', 10);
  PERFORM herbal.link_constituent('Cytisus scoparius', 'cytisine',    'major',   20);
  PERFORM herbal.link_constituent('Cytisus scoparius', 'lupanine',    'major',   30);
  PERFORM herbal.link_constituent('Cytisus scoparius', 'anagyrine',   'moderate',40);
  PERFORM herbal.link_constituent('Cytisus scoparius', 'isoflavones', 'moderate',50);
  PERFORM herbal.link_constituent('Cytisus scoparius', 'caffeic acid','moderate',60);
  PERFORM herbal.ensure_constituent('isoflavones', 'isoflavone', 'General isoflavone class');
  PERFORM herbal.link_constituent('Cytisus scoparius', 'isoflavones', 'moderate',50);
  PERFORM herbal.set_menstruum('Cytisus scoparius', 40, 60, NULL, NULL, FALSE,
    '40–60% alcohol', 'Quinolizidine alkaloids require moderate alcohol. Caution: narrow therapeutic index.');
  RAISE NOTICE 'Cytisus scoparius done';
END $$;

-- ─── BLOCK 23: Echinacea spp. ────────────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Echinacea spp.', 'alkamides',               'primary', 10, 'Responsible for tingling sensation; immunomodulatory');
  PERFORM herbal.link_constituent('Echinacea spp.', 'cichoric acid',           'primary', 20, 'Highest in E. purpurea');
  PERFORM herbal.link_constituent('Echinacea spp.', 'echinacoside',            'primary', 30, 'Highest in E. angustifolia and E. pallida');
  PERFORM herbal.link_constituent('Echinacea spp.', 'echinacea polysaccharides','major',  40);
  PERFORM herbal.link_constituent('Echinacea spp.', 'chlorogenic acid',        'moderate',50);
  PERFORM herbal.link_constituent('Echinacea spp.', 'caffeic acid',            'moderate',60);
  PERFORM herbal.link_constituent('Echinacea spp.', 'polyacetylenes',          'moderate',70);
  PERFORM herbal.link_constituent('Echinacea spp.', 'thiarubrine A',           'moderate',80);
  PERFORM herbal.set_menstruum('Echinacea spp.', 60, 70, NULL, NULL, FALSE,
    '60–70% alcohol (fresh root)', 'Alkamides require 60–70% alcohol; caffeic acid derivatives also extract. Polysaccharides lost in high alcohol—use separately as water extract if desired.');
  RAISE NOTICE 'Echinacea spp. done';
END $$;

-- ─── BLOCK 24: Eleutherococcus senticosus (Siberian ginseng) ─────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Eleutherococcus senticosus', 'eleutherosides',   'primary', 10);
  PERFORM herbal.link_constituent('Eleutherococcus senticosus', 'lignans',          'major',   20);
  PERFORM herbal.link_constituent('Eleutherococcus senticosus', 'polysaccharides',  'major',   30);
  PERFORM herbal.link_constituent('Eleutherococcus senticosus', 'triterpenoid saponins','moderate',40);
  PERFORM herbal.link_constituent('Eleutherococcus senticosus', 'caffeic acid',     'moderate',50);
  PERFORM herbal.ensure_constituent('polysaccharides', 'polysaccharide', 'Immunomodulatory polysaccharides');
  PERFORM herbal.link_constituent('Eleutherococcus senticosus', 'polysaccharides',  'major',   30);
  PERFORM herbal.set_menstruum('Eleutherococcus senticosus', 30, 60, NULL, NULL, TRUE,
    '30–60% alcohol or water decoction', 'Eleutherosides extract in moderate alcohol; polysaccharides in water decoction.');
  RAISE NOTICE 'Eleutherococcus senticosus done';
END $$;

-- ─── BLOCK 25: Equisetum arvense (horsetail) ─────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Equisetum arvense', 'silica',          'primary', 10, '5–7% of dry weight as silicic acid');
  PERFORM herbal.link_constituent('Equisetum arvense', 'saponins',        'major',   20);
  PERFORM herbal.link_constituent('Equisetum arvense', 'kaempferol',      'major',   30);
  PERFORM herbal.link_constituent('Equisetum arvense', 'quercetin',       'major',   40);
  PERFORM herbal.link_constituent('Equisetum arvense', 'luteolin',        'moderate',50);
  PERFORM herbal.link_constituent('Equisetum arvense', 'caffeic acid',    'moderate',60);
  PERFORM herbal.link_constituent('Equisetum arvense', 'phenolic acids',  'moderate',70);
  PERFORM herbal.ensure_constituent('phenolic acids', 'phenolic acid', 'General phenolic acids class');
  PERFORM herbal.link_constituent('Equisetum arvense', 'phenolic acids',  'moderate',70);
  PERFORM herbal.set_menstruum('Equisetum arvense', 25, 40, NULL, NULL, TRUE,
    '25–40% alcohol or water', 'Silicic acid is water-soluble; low alcohol tincture or decoction preferred.');
  RAISE NOTICE 'Equisetum arvense done';
END $$;

-- ─── BLOCK 26: Eschscholzia californica (California poppy) ───────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Eschscholzia californica', 'californidine',  'primary', 10);
  PERFORM herbal.link_constituent('Eschscholzia californica', 'eschscholtzine', 'primary', 20);
  PERFORM herbal.link_constituent('Eschscholzia californica', 'protopine',      'major',   30);
  PERFORM herbal.link_constituent('Eschscholzia californica', 'allocryptopine', 'major',   40);
  PERFORM herbal.link_constituent('Eschscholzia californica', 'caryachine',     'moderate',50);
  PERFORM herbal.link_constituent('Eschscholzia californica', 'apigenin',       'moderate',60);
  PERFORM herbal.link_constituent('Eschscholzia californica', 'luteolin',       'moderate',70);
  PERFORM herbal.link_constituent('Eschscholzia californica', 'carotenoids',    'major',   80, 'Responsible for orange color');
  PERFORM herbal.set_menstruum('Eschscholzia californica', 40, 70, NULL, NULL, FALSE,
    '40–70% alcohol (fresh plant)', 'Isoquinoline alkaloids require moderate-high alcohol. Fresh plant preferred; whole plant tincture.');
  RAISE NOTICE 'Eschscholzia californica done';
END $$;

-- ─── BLOCK 27: Filipendula ulmaria (meadowsweet) ─────────────────────────────
DO $$ BEGIN
  PERFORM herbal.ensure_constituent('salicin',             'phenolic glycoside');
  PERFORM herbal.ensure_constituent('spiraein',            'phenolic glycoside', 'Hydrolyzed to salicylaldehyde; found in meadowsweet');
  PERFORM herbal.ensure_constituent('gaultherin',          'phenolic glycoside', 'Found in meadowsweet flowers');
  PERFORM herbal.link_constituent('Filipendula ulmaria', 'salicin',         'primary', 10);
  PERFORM herbal.link_constituent('Filipendula ulmaria', 'spiraein',        'primary', 20);
  PERFORM herbal.link_constituent('Filipendula ulmaria', 'gaultherin',      'major',   30);
  PERFORM herbal.link_constituent('Filipendula ulmaria', 'quercetin',       'major',   40);
  PERFORM herbal.link_constituent('Filipendula ulmaria', 'rutin',           'major',   50);
  PERFORM herbal.link_constituent('Filipendula ulmaria', 'hyperoside',      'moderate',60);
  PERFORM herbal.link_constituent('Filipendula ulmaria', 'tannins',         'major',   70);
  PERFORM herbal.link_constituent('Filipendula ulmaria', 'mucilage',        'moderate',80);
  PERFORM herbal.set_menstruum('Filipendula ulmaria', 25, 45, NULL, NULL, TRUE,
    '25–45% alcohol or water', 'Salicylate glycosides and flavonoids extract in water or low alcohol; gentle preparation preserves volatile components.');
  RAISE NOTICE 'Filipendula ulmaria done';
END $$;

-- ─── BLOCK 28: Galium aparine (cleavers) ─────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Galium aparine', 'asperuloside',   'primary', 10);
  PERFORM herbal.link_constituent('Galium aparine', 'tannins',        'major',   20);
  PERFORM herbal.link_constituent('Galium aparine', 'caffeic acid',   'moderate',30);
  PERFORM herbal.link_constituent('Galium aparine', 'gallic acid',    'moderate',40);
  PERFORM herbal.link_constituent('Galium aparine', 'luteolin',       'moderate',50);
  PERFORM herbal.link_constituent('Galium aparine', 'quercetin',      'moderate',60);
  PERFORM herbal.link_constituent('Galium aparine', 'citric acid',    'moderate',70);
  PERFORM herbal.ensure_constituent('citric acid', 'organic acid', 'Found in cleavers; mildly diuretic');
  PERFORM herbal.link_constituent('Galium aparine', 'citric acid',    'moderate',70);
  PERFORM herbal.set_menstruum('Galium aparine', NULL, NULL, NULL, NULL, TRUE,
    'cold water (fresh plant juice)', 'Fresh plant juice or cold infusion best; iridoid glycosides degrade with heat and high alcohol.');
  RAISE NOTICE 'Galium aparine done';
END $$;

-- ─── BLOCK 29: Ganoderma lucidum (reishi) ────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Ganoderma lucidum', 'beta-glucans',   'primary', 10);
  PERFORM herbal.link_constituent('Ganoderma lucidum', 'ganoderic acids', 'primary', 20);
  PERFORM herbal.link_constituent('Ganoderma lucidum', 'adenosine',      'major',   30);
  PERFORM herbal.link_constituent('Ganoderma lucidum', 'lignans',        'moderate',40);
  PERFORM herbal.link_constituent('Ganoderma lucidum', 'ergosterol',     'moderate',50);
  PERFORM herbal.ensure_constituent('ergosterol', 'phytosterol', 'Pro-vitamin D; found in fungi');
  PERFORM herbal.link_constituent('Ganoderma lucidum', 'ergosterol',     'moderate',50);
  PERFORM herbal.set_menstruum('Ganoderma lucidum', 25, 40, NULL, NULL, TRUE,
    'dual extraction: water + 25–40% alcohol', 'Beta-glucans require hot water decoction; triterpenoids require alcohol. Dual extraction recommended for full spectrum.');
  RAISE NOTICE 'Ganoderma lucidum done';
END $$;

-- ─── BLOCK 30: Gentiana lutea / spp. (gentian) ───────────────────────────────
DO $$ BEGIN
  PERFORM herbal.ensure_constituent('gentiopicroside',  'secoiridoid glycoside', 'Intensely bitter; hepatoprotective; found in gentian');
  PERFORM herbal.ensure_constituent('swertiamarin',     'secoiridoid glycoside', 'Bitter; found in gentian');
  PERFORM herbal.ensure_constituent('amarogentin',      'secoiridoid glycoside', 'One of the most bitter natural compounds known');
  PERFORM herbal.link_constituent('Gentiana lutea', 'gentiopicroside', 'primary', 10);
  PERFORM herbal.link_constituent('Gentiana lutea', 'amarogentin',     'primary', 20);
  PERFORM herbal.link_constituent('Gentiana lutea', 'swertiamarin',    'major',   30);
  PERFORM herbal.link_constituent('Gentiana lutea', 'quercetin',       'moderate',40);
  PERFORM herbal.link_constituent('Gentiana lutea', 'isovitexin',      'moderate',50);
  PERFORM herbal.link_constituent('Gentiana lutea', 'tannins',         'minor',   60);
  PERFORM herbal.set_menstruum('Gentiana lutea', 25, 60, NULL, NULL, TRUE,
    '25–60% alcohol or water', 'Bitter secoiridoids are highly water-soluble; low-alcohol tincture or decoction. Bitter threshold: 1:20,000 dilution.');
  RAISE NOTICE 'Gentiana lutea done';
END $$;

-- ─── BLOCK 31: Glycyrrhiza glabra (licorice) ─────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Glycyrrhiza glabra', 'glycyrrhizin',      'primary', 10, '4–20% of dry root');
  PERFORM herbal.link_constituent('Glycyrrhiza glabra', 'glycyrrhetic acid', 'major',   20);
  PERFORM herbal.link_constituent('Glycyrrhiza glabra', 'glabridin',         'major',   30);
  PERFORM herbal.link_constituent('Glycyrrhiza glabra', 'liquiritigenin',    'major',   40);
  PERFORM herbal.link_constituent('Glycyrrhiza glabra', 'isoliquiritigenin', 'major',   50);
  PERFORM herbal.link_constituent('Glycyrrhiza glabra', 'formononetin',      'moderate',60);
  PERFORM herbal.link_constituent('Glycyrrhiza glabra', 'quercetin',         'moderate',70);
  PERFORM herbal.link_constituent('Glycyrrhiza glabra', 'rutin',             'moderate',80);
  PERFORM herbal.link_constituent('Glycyrrhiza glabra', 'mucilaginous polysaccharides','major',90);
  PERFORM herbal.link_constituent('Glycyrrhiza glabra', 'triterpenoid saponins',       'major',100);
  PERFORM herbal.set_menstruum('Glycyrrhiza glabra', 25, 50, NULL, NULL, TRUE,
    '25–50% alcohol or water', 'Glycyrrhizin is water-soluble; moderate alcohol captures flavonoids and glycyrrhizin. Decoction traditional.');
  RAISE NOTICE 'Glycyrrhiza glabra done';
END $$;

