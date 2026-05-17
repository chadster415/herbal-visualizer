-- Create a dedicated schema for herbal medicine data
CREATE SCHEMA IF NOT EXISTS herbal;

-- Set search path to use the herbal schema
SET search_path TO herbal, public;

-- Create herbs table
CREATE TABLE herbal.herbs (
  id SERIAL PRIMARY KEY,
  latin_name TEXT NOT NULL UNIQUE,
  common_name TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create primary actions table
CREATE TABLE herbal.primary_actions (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  description TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create secondary actions table
CREATE TABLE herbal.secondary_actions (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create body systems table
CREATE TABLE herbal.body_systems (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create relative strength enum in the herbal schema
CREATE TYPE herbal.strength_level AS ENUM ('mild', 'strong', 'very_strong');

-- Junction table: herbs to primary actions with body system and strength
CREATE TABLE herbal.herb_primary_actions (
  id SERIAL PRIMARY KEY,
  herb_id INTEGER REFERENCES herbal.herbs(id) ON DELETE CASCADE,
  primary_action_id INTEGER REFERENCES herbal.primary_actions(id) ON DELETE CASCADE,
  body_system_id INTEGER REFERENCES herbal.body_systems(id) ON DELETE CASCADE,
  body_system_note TEXT,
  relative_strength herbal.strength_level,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(herb_id, primary_action_id, body_system_id)
);

-- Junction table: herbs to secondary actions
CREATE TABLE herbal.herb_secondary_actions (
  id SERIAL PRIMARY KEY,
  herb_id INTEGER REFERENCES herbal.herbs(id) ON DELETE CASCADE,
  secondary_action_id INTEGER REFERENCES herbal.secondary_actions(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(herb_id, secondary_action_id)
);

-- Create indexes for better query performance
CREATE INDEX idx_herb_primary_actions_herb ON herbal.herb_primary_actions(herb_id);
CREATE INDEX idx_herb_primary_actions_action ON herbal.herb_primary_actions(primary_action_id);
CREATE INDEX idx_herb_primary_actions_system ON herbal.herb_primary_actions(body_system_id);
CREATE INDEX idx_herb_secondary_actions_herb ON herbal.herb_secondary_actions(herb_id);
CREATE INDEX idx_herb_secondary_actions_action ON herbal.herb_secondary_actions(secondary_action_id);
CREATE INDEX idx_herbs_latin_name ON herbal.herbs(latin_name);
CREATE INDEX idx_herbs_common_name ON herbal.herbs(common_name);

-- Grant permissions (adjust if you have specific roles)
GRANT USAGE ON SCHEMA herbal TO postgres, anon, authenticated, service_role;
GRANT ALL ON ALL TABLES IN SCHEMA herbal TO postgres, anon, authenticated, service_role;
GRANT ALL ON ALL SEQUENCES IN SCHEMA herbal TO postgres, anon, authenticated, service_role;

-- Insert body systems
INSERT INTO herbal.body_systems (name) VALUES 
  ('Cardiovascular'),
  ('Respiratory'),
  ('Digestive'),
  ('Urinary'),
  ('Reproductive'),
  ('Musculoskeletal'),
  ('Nervous'),
  ('Skin');

COMMENT ON SCHEMA herbal IS 'Schema for herbal medicine visualization data';
COMMENT ON TABLE herbal.herbs IS 'Medicinal herbs with Latin and common names';
COMMENT ON TABLE herbal.primary_actions IS 'Primary herbal action categories (Alteratives, Adaptogens, etc.)';
COMMENT ON TABLE herbal.body_systems IS 'Body systems affected by herbs';
COMMENT ON COLUMN herbal.herb_primary_actions.relative_strength IS 'Strength rating: mild, strong, or very_strong';
-- Set schema
SET search_path TO herbal, public;

-- Insert herbs into herbal schema
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (1, 'Acanthopanax sessiliflorum', 'wu jia pi') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (2, 'Albizzia julibrissin', 'silk tree') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (3, 'Aralia elata', 'Japanese angelica tree') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (4, 'A. manshurica', 'Manchurian aralia') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (5, 'Aralia schmidtii', 'Sakhalin spikenard') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (6, 'Cicer arietinum', 'chickpea') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (7, 'Codonoposis pilosula', 'dang shen') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (8, 'Echinopanax elatus', 'Asian devil’s club') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (9, 'Eleutherococcus senticosus', 'Siberian ginseng') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (10, 'Eucommia ulmoides', 'hardy rubber tree') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (11, 'Ganoderma lucidum', 'reishi mushroom') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (12, 'Hoppea dichotoma Leuzea carthamoides', 'maral root') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (13, 'Ocimum sanctum', 'holy basil') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (14, 'Panax ginseng', 'Korean ginseng') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (15, 'Panax quinquefolius', 'American ginseng') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (16, 'Rhodiola rosea', 'roseroot stonecrop') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (17, 'Schisandra chinensis', 'schizandra') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (18, 'Tinospora cordifolia', 'guduchi') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (19, 'Trichopus zeylanicus', 'arogyappacha') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (20, 'Withania somnifera', 'ashwaganda') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (21, 'Allium sativum', 'garlic') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (22, 'Arctium lappa', 'burdock') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (23, 'Baptisia tinctoria', 'wild indigo') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (24, 'Chionanthus virginicus', 'fringetree') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (25, 'Cimicifuga racemosa', 'black cohosh') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (26, 'Echinacea spp.', 'echinacea') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (27, 'Fumaria officinalis', 'fumitory') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (28, 'Galium aparine', 'cleavers') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (29, 'Guaiacum officinale', 'guaiacum') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (30, 'Hydrastis canadensis', 'goldenseal') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (31, 'Iris versicolor', 'blue flag') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (32, 'Larrea tridentata', 'chaparral') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (33, 'Mahonia aquifolium', 'Oregon grape') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (34, 'Menyanthes trifoliata', 'bogbean') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (35, 'Phytolacca americana', 'poke') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (36, 'Pulsatilla vulgaris', 'pasqueflower') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (37, 'Rumex crispus', 'yellow dock') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (38, 'Sanguinaria canadensis', 'bloodroot') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (39, 'Scrophularia nodosa', 'figwort') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (40, 'Smilax spp.', 'sarsaparilla') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (41, 'Stillingia sylvatica', 'queen’s delight') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (42, 'Trifolium pratense', 'red clover') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (43, 'Urtica dioica', 'nettles') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (44, 'Achillea millefolium', 'yarrow') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (45, 'Althaea officinalis', 'marshmallow') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (46, 'Arctostaphylos uva-ursi', 'bearberry') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (47, 'Capsicum annuum', 'cayenne') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (48, 'Cetraria islandica', 'Iceland moss') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (49, 'Chondrus crispus', 'Irish moss') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (50, 'Eupatorium perfoliatum', 'boneset') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (51, 'Euphrasia spp.', 'eyebright') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (52, 'Geranium maculatum', 'cranesbill') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (53, 'Hyssopus officinalis', 'hyssop') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (54, 'Inula helenium', 'elecampane') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (55, 'Mentha piperita', 'peppermint') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (56, 'Salvia officinalis', 'sage') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (57, 'Sambucus nigra', 'elder') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (58, 'Solidago virgaurea', 'goldenrod') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (59, 'Thymus vulgaris', 'thyme') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (60, 'Tussilago farfara', 'coltsfoot') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (61, 'Verbascum thapsus', 'mullein') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (62, 'Aesculus hippocastanum', 'horse chestnut') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (63, 'Alchemilla arvensis', 'lady’s mantle') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (64, 'Anethum graveolens', 'dill') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (65, 'Angelica archangelica', 'angelica') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (66, 'Apium graveolens', 'celery seed') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (67, 'Asclepias tuberosa', 'pleurisy root') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (68, 'Betula spp.', 'birch') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (69, 'Borago officinalis', 'borage') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (70, 'Calendula officinalis', 'calendula') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (71, 'Capsella bursa-pastoris', 'shepherd’s purse') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (72, 'Caulophyllum thalictroides', 'blue cohosh') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (73, 'Crataegus spp.', 'hawthorn') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (74, 'Dioscorea villosa', 'wild yam') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (75, 'Filipendula ulmaria', 'meadowsweet') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (76, 'Foeniculum vulgare', 'fennel') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (77, 'Gaultheria procumbens', 'wintergreen') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (78, 'Glycyrrhiza glabra', 'licorice') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (79, 'Hamamelis virginiana', 'witch hazel') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (80, 'Harpagophytum procumbens', 'devil’s claw') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (81, 'Hypericum perforatum', 'St. John’s wort') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (82, 'Lavandula spp.', 'lavender') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (83, 'Malva sylvestris', 'mallow') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (84, 'Matricaria recutita', 'chamomile') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (85, 'Plantago major', 'plantain') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (86, 'Populus tremuloides', 'aspen') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (87, 'Salix spp.', 'willow') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (88, 'Stellaria media', 'chickweed') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (89, 'Symphytum officinale', 'comfrey') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (90, 'Tilia platyphyllos', 'linden') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (91, 'Trigonella foenum-graecum', 'fenugreek') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (92, 'Ulmus rubra', 'slippery elm') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (93, 'Viburnum opulus', 'cramp bark') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (94, 'Viburnum prunifolium', 'black haw') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (95, 'Zea mays', 'corn silk') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (96, 'Artemisia abrotanum', 'southernwood') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (97, 'A. absinthium', 'wormwood') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (98, 'Carum carvi', 'caraway') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (99, 'Commiphora molmol', 'myrrh') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (100, 'Coriandrum sativum', 'coriander') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (101, 'Eucalyptus spp.', 'eucalyptus') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (102, 'Gentiana lutea', 'gentian') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (103, 'Juniperus communis', 'juniper') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (104, 'Ligusticum porteri', 'osha') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (105, 'Myroxylon balsamum var. pereirae', 'balsam of Peru') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (106, 'Olea europaea', 'olive') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (107, 'Origanum majorana', 'marjoram') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (108, 'Pimpinella anisum', 'aniseed') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (109, 'Rosmarinus officinalis', 'rosemary') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (110, 'Ruta graveolens', 'rue') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (111, 'Syzygium aromaticum', 'clove') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (112, 'Usnea spp.', 'usnea') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (113, 'Armoracia rusticana', 'horseradish') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (114, 'Arnica montana', 'arnica') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (115, 'Artemisia absinthium', 'wormwood') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (116, 'Artemisia vulgaris', 'mugwort') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (117, 'Brassica spp.', 'mustard') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (118, 'E. purpureum', 'gravel root') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (119, 'Fucus vesiculosus', 'kelp') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (120, 'Myrica cerifera', 'bayberry') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (121, 'Petroselinum crispum', 'parsley') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (122, 'Tanacetum parthenium', 'feverfew') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (123, 'Taraxacum officinale', 'dandelion') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (124, 'Zanthoxylum americanum', 'prickly ash') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (125, 'Zingiber officinale', 'ginger') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (126, 'Daucus carota', 'wild carrot') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (127, 'Drosera rotundifolia', 'sundew') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (128, 'Elettaria cardamomum', 'cardamom') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (129, 'Eschscholzia californica', 'California poppy') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (130, 'Humulus lupulus', 'hops') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (131, 'Lactuca virosa', 'wild lettuce') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (132, 'Leonurus cardiaca', 'motherwort') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (133, 'Lobelia inflata', 'lobelia') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (134, 'Lycopus spp.', 'bugleweed') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (135, 'Melissa officinalis', 'lemon balm') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (136, 'M. pulegium', 'pennyroyal') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (137, 'Nepeta cataria', 'catnip') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (138, 'Passiflora incarnata', 'passionflower') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (139, 'Piper methysticum', 'kava kava') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (140, 'Piscidia erythrina', 'Jamaica dogwood') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (141, 'Prunus serotina', 'wild cherry bark') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (142, 'Salvia officinalis var. rubia', 'red sage') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (143, 'Scutellaria lateriflora', 'skullcap') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (144, 'Symplocarpus foetidus', 'skunk cabbage') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (145, 'Turnera diffusa', 'damiana') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (146, 'Valeriana officinalis', 'valerian') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (147, 'Verbena officinalis', 'vervain') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (148, 'V . prunifolium', 'black haw') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (149, 'Acacia catechu', 'black catechu') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (150, 'Agrimonia eupatoria', 'agrimony') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (151, 'Camellia sinensis', 'tea') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (152, 'Cola acuminata', 'kola') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (153, 'Equisetum arvense', 'horsetail') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (154, 'Polygonum bistorta', 'bistort') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (155, 'Quercus spp.', 'oak') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (156, 'Rheum palmatum', 'rhubarb') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (157, 'Rubus idaeus', 'raspberry') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (158, 'R. villosus', 'blackberry') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (159, 'Vinca major', 'periwinkle') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (160, 'A. vulgaris', 'mugwort') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (161, 'Berberis vulgaris', 'barberry') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (162, 'Centaurium erythraea', 'centaury') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (163, 'Marrubium vulgare', 'horehound') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (164, 'Tanacetum vulgare', 'tansy') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (165, 'Coleus forskohlii', 'coleus') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (166, 'Convallaria majalis', 'lily of the valley') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (167, 'Cytisus scoparius', 'Scotch broom') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (168, 'Ginkgo biloba', 'ginkgo') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (169, 'Urginea maritima', 'squill') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (170, 'Cinnamomum spp.', 'cinnamon') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (171, 'Eucalyptus globulus', 'eucalyptus') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (172, 'Thymus spp.', 'thyme') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (173, 'Chelidonium majus', 'celandine') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (174, 'Chelone glabra', 'balmony') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (175, 'Cynara scolymus', 'artichoke') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (176, 'Euonymus atropurpureus', 'wahoo') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (177, 'Juglans cinerea', 'butternut') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (178, 'Leptandra virginica', 'black root') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (179, 'Peumus boldus', 'boldo') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (180, 'Taraxacum officinale root', 'dandelion') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (181, 'Avena sativa', 'oat') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (182, 'Elymus repens', 'couch grass') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (183, 'Linum usitatissimum', 'flax') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (184, 'Agathosma betulina', 'buchu') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (185, 'Collinsonia canadensis', 'stoneroot') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (186, 'Cucurbita pepo', 'pumpkin') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (187, 'Eryngium maritimum', 'sea holly') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (188, 'E.purpureum', 'gravel root') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (189, 'Parietaria judaica', 'pellitory of the wall') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (190, 'Serenoa repens', 'saw palmetto') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (191, 'Marsdenia condurango', 'condurango') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (192, 'Mitchella repens', 'partridgeberry') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (193, 'T. vulgare', 'tansy') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (194, 'Tropaeolum majus', 'nasturtium') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (195, 'Vitex agnus-castus', 'chasteberry') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (196, 'Bellis perennis', 'English daisy') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (197, 'Cephaelis ipecacuanha', 'ipecac') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (198, 'Hieracium pilosella', 'mouse ear') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (199, 'Myroxylon balsamum var. balsamum', 'Tolu balsam') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (200, 'Polygala senega', 'Seneca snakeroot') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (201, 'Populus candicans', 'balm of Gilead') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (202, 'Primula veris', 'cowslip') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (203, 'Viola odorata', 'sweet violet') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (204, 'Grindelia camporum', 'gumweed') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (205, 'Pulmonaria officinalis', 'lungwort') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (206, 'Thuja occidentalis', 'thuja') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (207, 'Aloe vera', 'aloe') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (208, 'Curcuma longa', 'turmeric') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (209, 'Rhamnus cathartica', 'buckthorn') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (210, 'R. purshiana', 'cascara sagrada') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (211, 'Silybum marianum', 'milk thistle') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (212, 'Stachys officinalis', 'wood betony') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (213, 'Allium cepa', 'onion') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (214, 'A.sativum', 'garlic') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (215, 'Fagopyrum esculentum', 'buckwheat') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (216, 'Viscum album', 'mistletoe') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (217, 'Panax spp.', 'ginseng') ON CONFLICT (latin_name) DO NOTHING;
INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (218, 'Senna alexandrina', 'senna') ON CONFLICT (latin_name) DO NOTHING;

-- Insert primary actions
INSERT INTO herbal.primary_actions (id, name) VALUES (1, 'Adaptogens') ON CONFLICT (name) DO NOTHING;
INSERT INTO herbal.primary_actions (id, name) VALUES (2, 'Alteratives') ON CONFLICT (name) DO NOTHING;
INSERT INTO herbal.primary_actions (id, name) VALUES (3, 'Anticatarrhal') ON CONFLICT (name) DO NOTHING;
INSERT INTO herbal.primary_actions (id, name) VALUES (4, 'Anti-inflammatory') ON CONFLICT (name) DO NOTHING;
INSERT INTO herbal.primary_actions (id, name) VALUES (5, 'Antimicrobial') ON CONFLICT (name) DO NOTHING;
INSERT INTO herbal.primary_actions (id, name) VALUES (6, 'Antirheumatic') ON CONFLICT (name) DO NOTHING;
INSERT INTO herbal.primary_actions (id, name) VALUES (7, 'Antispasmodic') ON CONFLICT (name) DO NOTHING;
INSERT INTO herbal.primary_actions (id, name) VALUES (8, 'Astringent') ON CONFLICT (name) DO NOTHING;
INSERT INTO herbal.primary_actions (id, name) VALUES (9, 'Bitter') ON CONFLICT (name) DO NOTHING;
INSERT INTO herbal.primary_actions (id, name) VALUES (10, 'Cardiac Remedies') ON CONFLICT (name) DO NOTHING;
INSERT INTO herbal.primary_actions (id, name) VALUES (11, 'Carminative') ON CONFLICT (name) DO NOTHING;
INSERT INTO herbal.primary_actions (id, name) VALUES (12, 'Cholagogue') ON CONFLICT (name) DO NOTHING;
INSERT INTO herbal.primary_actions (id, name) VALUES (13, 'Demulcent') ON CONFLICT (name) DO NOTHING;
INSERT INTO herbal.primary_actions (id, name) VALUES (14, 'Diuretic') ON CONFLICT (name) DO NOTHING;
INSERT INTO herbal.primary_actions (id, name) VALUES (15, 'Emmenagogue') ON CONFLICT (name) DO NOTHING;
INSERT INTO herbal.primary_actions (id, name) VALUES (16, 'Expectorant') ON CONFLICT (name) DO NOTHING;
INSERT INTO herbal.primary_actions (id, name) VALUES (17, 'Hepatic') ON CONFLICT (name) DO NOTHING;
INSERT INTO herbal.primary_actions (id, name) VALUES (18, 'Hypnotic') ON CONFLICT (name) DO NOTHING;
INSERT INTO herbal.primary_actions (id, name) VALUES (19, 'Hypotensive') ON CONFLICT (name) DO NOTHING;
INSERT INTO herbal.primary_actions (id, name) VALUES (20, 'Nervine') ON CONFLICT (name) DO NOTHING;
INSERT INTO herbal.primary_actions (id, name) VALUES (21, 'Stimulant') ON CONFLICT (name) DO NOTHING;

-- Body systems are already inserted in the schema migration
-- If you need to re-insert them:
-- DELETE FROM herbal.body_systems;
-- INSERT INTO herbal.body_systems (id, name) VALUES (1, 'Cardiovascular');
-- INSERT INTO herbal.body_systems (id, name) VALUES (2, 'Respiratory');
-- INSERT INTO herbal.body_systems (id, name) VALUES (3, 'Digestive');
-- INSERT INTO herbal.body_systems (id, name) VALUES (4, 'Urinary');
-- INSERT INTO herbal.body_systems (id, name) VALUES (5, 'Reproductive');
-- INSERT INTO herbal.body_systems (id, name) VALUES (6, 'Musculoskeletal');
-- INSERT INTO herbal.body_systems (id, name) VALUES (7, 'Nervous');
-- INSERT INTO herbal.body_systems (id, name) VALUES (8, 'Skin');
-- Set schema
SET search_path TO herbal, public;

-- ============================================
-- ALTERATIVES - Herb to Action to Body System Relationships
-- ============================================

-- Cardiovascular System Alteratives
INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
SELECT h.id, pa.id, bs.id, 'mild'::herbal.strength_level
FROM herbal.herbs h
CROSS JOIN herbal.primary_actions pa
CROSS JOIN herbal.body_systems bs
WHERE pa.name = 'Alteratives' AND bs.name = 'Cardiovascular'
AND h.latin_name IN ('Galium aparine', 'Phytolacca americana', 'Echinacea spp.', 'Scrophularia nodosa', 'Allium sativum');

-- Respiratory System Alteratives
INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
SELECT h.id, pa.id, bs.id, 'mild'::herbal.strength_level
FROM herbal.herbs h
CROSS JOIN herbal.primary_actions pa
CROSS JOIN herbal.body_systems bs
WHERE pa.name = 'Alteratives' AND bs.name = 'Respiratory'
AND h.latin_name IN ('Allium sativum', 'Hydrastis canadensis', 'Sanguinaria canadensis', 'Baptisia tinctoria', 'Echinacea spp.');

-- Digestive System Alteratives
INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
SELECT h.id, pa.id, bs.id, 
  CASE 
    WHEN h.latin_name IN ('Arctium lappa', 'Hydrastis canadensis', 'Rumex crispus', 'Smilax spp.', 'Urtica dioica') THEN 'strong'::herbal.strength_level
    WHEN h.latin_name IN ('Iris versicolor') THEN 'very_strong'::herbal.strength_level
    ELSE 'mild'::herbal.strength_level
  END
FROM herbal.herbs h
CROSS JOIN herbal.primary_actions pa
CROSS JOIN herbal.body_systems bs
WHERE pa.name = 'Alteratives' AND bs.name = 'Digestive'
AND h.latin_name IN ('Allium sativum', 'Arctium lappa', 'Chionanthus virginicus', 'Hydrastis canadensis', 'Iris versicolor', 'Menyanthes trifoliata', 'Rumex crispus', 'Smilax spp.', 'Urtica dioica');

-- Urinary System Alteratives
INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
SELECT h.id, pa.id, bs.id, 'strong'::herbal.strength_level
FROM herbal.herbs h
CROSS JOIN herbal.primary_actions pa
CROSS JOIN herbal.body_systems bs
WHERE pa.name = 'Alteratives' AND bs.name = 'Urinary'
AND h.latin_name IN ('Galium aparine', 'Urtica dioica');

-- Reproductive System Alteratives
INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
SELECT h.id, pa.id, bs.id, 'mild'::herbal.strength_level
FROM herbal.herbs h
CROSS JOIN herbal.primary_actions pa
CROSS JOIN herbal.body_systems bs
WHERE pa.name = 'Alteratives' AND bs.name = 'Reproductive'
AND h.latin_name IN ('Cimicifuga racemosa', 'Hydrastis canadensis');

-- Musculoskeletal System Alteratives
INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
SELECT h.id, pa.id, bs.id, 'strong'::herbal.strength_level
FROM herbal.herbs h
CROSS JOIN herbal.primary_actions pa
CROSS JOIN herbal.body_systems bs
WHERE pa.name = 'Alteratives' AND bs.name = 'Musculoskeletal'
AND h.latin_name IN ('Cimicifuga racemosa', 'Menyanthes trifoliata', 'Arctium lappa');

-- Nervous System Alteratives
INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
SELECT h.id, pa.id, bs.id, 'mild'::herbal.strength_level
FROM herbal.herbs h
CROSS JOIN herbal.primary_actions pa
CROSS JOIN herbal.body_systems bs
WHERE pa.name = 'Alteratives' AND bs.name = 'Nervous'
AND h.latin_name IN ('Pulsatilla vulgaris', 'Trifolium pratense');

-- Skin System Alteratives
INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
SELECT h.id, pa.id, bs.id,
  CASE 
    WHEN h.latin_name IN ('Arctium lappa', 'Fumaria officinalis', 'Galium aparine', 'Hydrastis canadensis', 'Rumex crispus', 'Scrophularia nodosa', 'Smilax spp.', 'Trifolium pratense', 'Urtica dioica') THEN 'strong'::herbal.strength_level
    ELSE 'mild'::herbal.strength_level
  END
FROM herbal.herbs h
CROSS JOIN herbal.primary_actions pa
CROSS JOIN herbal.body_systems bs
WHERE pa.name = 'Alteratives' AND bs.name = 'Skin'
AND h.latin_name IN ('Arctium lappa', 'Mahonia aquifolium', 'Fumaria officinalis', 'Galium aparine', 'Echinacea spp.', 'Scrophularia nodosa', 'Smilax spp.', 'Rumex crispus', 'Trifolium pratense');

-- ============================================
-- SECONDARY ACTIONS for Alteratives
-- ============================================

-- Anticatarrhal
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT h.id, sa.id
FROM herbal.herbs h
CROSS JOIN herbal.secondary_actions sa
WHERE sa.name = 'Anticatarrhal'
AND h.latin_name IN ('Allium sativum', 'Baptisia tinctoria', 'Echinacea spp.', 'Hydrastis canadensis', 'Phytolacca americana', 'Urtica dioica')
ON CONFLICT DO NOTHING;

-- Anti-inflammatory
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT h.id, sa.id
FROM herbal.herbs h
CROSS JOIN herbal.secondary_actions sa
WHERE sa.name = 'Anti-inflammatory'
AND h.latin_name IN ('Galium aparine', 'Guaiacum officinale', 'Hydrastis canadensis', 'Iris versicolor', 'Menyanthes trifoliata', 'Smilax spp.')
ON CONFLICT DO NOTHING;

-- Antimicrobial
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT h.id, sa.id
FROM herbal.herbs h
CROSS JOIN herbal.secondary_actions sa
WHERE sa.name = 'Antimicrobial'
AND h.latin_name IN ('Allium sativum', 'Baptisia tinctoria', 'Echinacea spp.', 'Hydrastis canadensis', 'Larrea tridentata', 'Phytolacca americana', 'Pulsatilla vulgaris', 'Sanguinaria canadensis')
ON CONFLICT DO NOTHING;

-- Antispasmodic
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT h.id, sa.id
FROM herbal.herbs h
CROSS JOIN herbal.secondary_actions sa
WHERE sa.name = 'Antispasmodic'
AND h.latin_name IN ('Allium sativum', 'Cimicifuga racemosa', 'Pulsatilla vulgaris', 'Sanguinaria canadensis', 'Trifolium pratense')
ON CONFLICT DO NOTHING;

-- Astringent
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT h.id, sa.id
FROM herbal.herbs h
CROSS JOIN herbal.secondary_actions sa
WHERE sa.name = 'Astringent'
AND h.latin_name IN ('Hydrastis canadensis', 'Urtica dioica')
ON CONFLICT DO NOTHING;

-- Bitter
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT h.id, sa.id
FROM herbal.herbs h
CROSS JOIN herbal.secondary_actions sa
WHERE sa.name = 'Bitter'
AND h.latin_name IN ('Arctium lappa', 'Hydrastis canadensis', 'Menyanthes trifoliata')
ON CONFLICT DO NOTHING;

-- Diaphoretic
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT h.id, sa.id
FROM herbal.herbs h
CROSS JOIN herbal.secondary_actions sa
WHERE sa.name = 'Diaphoretic'
AND h.latin_name IN ('Allium sativum', 'Guaiacum officinale', 'Stillingia sylvatica', 'Smilax spp.')
ON CONFLICT DO NOTHING;

-- Diuretic
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT h.id, sa.id
FROM herbal.herbs h
CROSS JOIN herbal.secondary_actions sa
WHERE sa.name = 'Diuretic'
AND h.latin_name IN ('Arctium lappa', 'Galium aparine', 'Guaiacum officinale', 'Iris versicolor', 'Menyanthes trifoliata', 'Smilax spp.', 'Urtica dioica')
ON CONFLICT DO NOTHING;

-- Emmenagogue
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT h.id, sa.id
FROM herbal.herbs h
CROSS JOIN herbal.secondary_actions sa
WHERE sa.name = 'Emmenagogue'
AND h.latin_name IN ('Cimicifuga racemosa')
ON CONFLICT DO NOTHING;

-- Expectorant
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT h.id, sa.id
FROM herbal.herbs h
CROSS JOIN herbal.secondary_actions sa
WHERE sa.name = 'Expectorant'
AND h.latin_name IN ('Sanguinaria canadensis', 'Trifolium pratense', 'Verbascum thapsus')
ON CONFLICT DO NOTHING;

-- Hepatic
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT h.id, sa.id
FROM herbal.herbs h
CROSS JOIN herbal.secondary_actions sa
WHERE sa.name = 'Hepatic'
AND h.latin_name IN ('Allium sativum', 'Arctium lappa', 'Chionanthus virginicus', 'Hydrastis canadensis', 'Iris versicolor', 'Mahonia aquifolium', 'Menyanthes trifoliata', 'Phytolacca americana', 'Rumex crispus')
ON CONFLICT DO NOTHING;

-- Hypotensive
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT h.id, sa.id
FROM herbal.herbs h
CROSS JOIN herbal.secondary_actions sa
WHERE sa.name = 'Hypotensive'
AND h.latin_name IN ('Allium sativum', 'Cimicifuga racemosa', 'Urtica dioica')
ON CONFLICT DO NOTHING;

-- Nervine
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT h.id, sa.id
FROM herbal.herbs h
CROSS JOIN herbal.secondary_actions sa
WHERE sa.name = 'Nervine'
AND h.latin_name IN ('Cimicifuga racemosa', 'Pulsatilla vulgaris', 'Trifolium pratense')
ON CONFLICT DO NOTHING;

-- Vulnerary
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT h.id, sa.id
FROM herbal.herbs h
CROSS JOIN herbal.secondary_actions sa
WHERE sa.name = 'Vulnerary'
AND h.latin_name IN ('Galium aparine', 'Hydrastis canadensis')
ON CONFLICT DO NOTHING;

-- Insert all secondary actions first
INSERT INTO herbal.secondary_actions (name) VALUES
  ('Anticatarrhal'),
  ('Anti-inflammatory'),
  ('Antimicrobial'),
  ('Antispasmodic'),
  ('Astringent'),
  ('Bitter'),
  ('Carminative'),
  ('Demulcent'),
  ('Diaphoretic'),
  ('Diuretic'),
  ('Emmenagogue'),
  ('Expectorant'),
  ('Hepatic'),
  ('Hypotensive'),
  ('Nervine'),
  ('Vulnerary')
ON CONFLICT (name) DO NOTHING;

-- Set schema
SET search_path TO herbal, public;

-- ============================================
-- INSERT SECONDARY ACTIONS FIRST
-- ============================================
INSERT INTO herbal.secondary_actions (name) VALUES
  ('Anticatarrhal'),
  ('Anti-inflammatory'),
  ('Antimicrobial'),
  ('Antispasmodic'),
  ('Astringent'),
  ('Bitter'),
  ('Carminative'),
  ('Demulcent'),
  ('Diaphoretic'),
  ('Diuretic'),
  ('Emmenagogue'),
  ('Expectorant'),
  ('Hepatic'),
  ('Hypotensive'),
  ('Nervine'),
  ('Stimulant'),
  ('Tonic'),
  ('Vulnerary')
ON CONFLICT (name) DO NOTHING;

-- ============================================
-- EXAMPLE RELATIONSHIPS - Alteratives
-- Based on your text file
-- ============================================

-- Garlic (Allium sativum) - Alterative for Multiple Systems
INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength, body_system_note)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Allium sativum'),
  (SELECT id FROM herbal.primary_actions WHERE name = 'Alteratives'),
  (SELECT id FROM herbal.body_systems WHERE name = 'Cardiovascular'),
  'mild'::herbal.strength_level,
  'The hypocholesteremic and hypotensive actions are well known'
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Allium sativum')
ON CONFLICT DO NOTHING;

INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Allium sativum'),
  (SELECT id FROM herbal.primary_actions WHERE name = 'Alteratives'),
  (SELECT id FROM herbal.body_systems WHERE name = 'Respiratory'),
  'mild'::herbal.strength_level
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Allium sativum')
ON CONFLICT DO NOTHING;

INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Allium sativum'),
  (SELECT id FROM herbal.primary_actions WHERE name = 'Alteratives'),
  (SELECT id FROM herbal.body_systems WHERE name = 'Digestive'),
  'mild'::herbal.strength_level
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Allium sativum')
ON CONFLICT DO NOTHING;

-- Burdock (Arctium lappa) - Strong Alterative
INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Arctium lappa'),
  (SELECT id FROM herbal.primary_actions WHERE name = 'Alteratives'),
  (SELECT id FROM herbal.body_systems WHERE name = 'Digestive'),
  'strong'::herbal.strength_level
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Arctium lappa')
ON CONFLICT DO NOTHING;

INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Arctium lappa'),
  (SELECT id FROM herbal.primary_actions WHERE name = 'Alteratives'),
  (SELECT id FROM herbal.body_systems WHERE name = 'Musculoskeletal'),
  'strong'::herbal.strength_level
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Arctium lappa')
ON CONFLICT DO NOTHING;

INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Arctium lappa'),
  (SELECT id FROM herbal.primary_actions WHERE name = 'Alteratives'),
  (SELECT id FROM herbal.body_systems WHERE name = 'Skin'),
  'strong'::herbal.strength_level
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Arctium lappa')
ON CONFLICT DO NOTHING;

-- Echinacea - Mild Alterative
INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.'),
  (SELECT id FROM herbal.primary_actions WHERE name = 'Alteratives'),
  (SELECT id FROM herbal.body_systems WHERE name = 'Cardiovascular'),
  'mild'::herbal.strength_level
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Echinacea spp.')
ON CONFLICT DO NOTHING;

INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.'),
  (SELECT id FROM herbal.primary_actions WHERE name = 'Alteratives'),
  (SELECT id FROM herbal.body_systems WHERE name = 'Respiratory'),
  'mild'::herbal.strength_level
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Echinacea spp.')
ON CONFLICT DO NOTHING;

INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.'),
  (SELECT id FROM herbal.primary_actions WHERE name = 'Alteratives'),
  (SELECT id FROM herbal.body_systems WHERE name = 'Skin'),
  'mild'::herbal.strength_level
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Echinacea spp.')
ON CONFLICT DO NOTHING;

-- ============================================
-- SECONDARY ACTIONS FOR SAMPLE HERBS
-- ============================================

-- Garlic secondary actions
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Allium sativum'),
  (SELECT id FROM herbal.secondary_actions WHERE name = 'Anticatarrhal')
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Allium sativum')
ON CONFLICT DO NOTHING;

INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Allium sativum'),
  (SELECT id FROM herbal.secondary_actions WHERE name = 'Antimicrobial')
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Allium sativum')
ON CONFLICT DO NOTHING;

INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Allium sativum'),
  (SELECT id FROM herbal.secondary_actions WHERE name = 'Antispasmodic')
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Allium sativum')
ON CONFLICT DO NOTHING;

INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Allium sativum'),
  (SELECT id FROM herbal.secondary_actions WHERE name = 'Diaphoretic')
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Allium sativum')
ON CONFLICT DO NOTHING;

INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Allium sativum'),
  (SELECT id FROM herbal.secondary_actions WHERE name = 'Hepatic')
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Allium sativum')
ON CONFLICT DO NOTHING;

INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Allium sativum'),
  (SELECT id FROM herbal.secondary_actions WHERE name = 'Hypotensive')
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Allium sativum')
ON CONFLICT DO NOTHING;

-- Burdock secondary actions
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Arctium lappa'),
  (SELECT id FROM herbal.secondary_actions WHERE name = 'Bitter')
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Arctium lappa')
ON CONFLICT DO NOTHING;

INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Arctium lappa'),
  (SELECT id FROM herbal.secondary_actions WHERE name = 'Diuretic')
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Arctium lappa')
ON CONFLICT DO NOTHING;

INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Arctium lappa'),
  (SELECT id FROM herbal.secondary_actions WHERE name = 'Hepatic')
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Arctium lappa')
ON CONFLICT DO NOTHING;

-- Echinacea secondary actions
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.'),
  (SELECT id FROM herbal.secondary_actions WHERE name = 'Anticatarrhal')
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Echinacea spp.')
ON CONFLICT DO NOTHING;

INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.'),
  (SELECT id FROM herbal.secondary_actions WHERE name = 'Antimicrobial')
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Echinacea spp.')
ON CONFLICT DO NOTHING;

-- Make body_system_id nullable to allow herbs without specific body system affinities
ALTER TABLE herbal.herb_primary_actions
ALTER COLUMN body_system_id DROP NOT NULL;

-- Update the unique constraint to handle NULL values properly
-- Drop the existing constraint
ALTER TABLE herbal.herb_primary_actions
DROP CONSTRAINT IF EXISTS herb_primary_actions_herb_id_primary_action_id_body_system__key;

-- Add it back (PostgreSQL handles NULL values in unique constraints properly)
ALTER TABLE herbal.herb_primary_actions
ADD CONSTRAINT herb_primary_actions_herb_id_primary_action_id_body_system__key
UNIQUE (herb_id, primary_action_id, body_system_id);

COMMENT ON COLUMN herbal.herb_primary_actions.body_system_id IS 'Body system affected (NULL if no specific body system affinity)';
-- Create action descriptions table to store bullet points for each primary action
CREATE TABLE herbal.action_descriptions (
  id SERIAL PRIMARY KEY,
  primary_action_id INTEGER REFERENCES herbal.primary_actions(id) ON DELETE CASCADE,
  description TEXT NOT NULL,
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create index for better query performance
CREATE INDEX idx_action_descriptions_action ON herbal.action_descriptions(primary_action_id);

-- Grant permissions
GRANT ALL ON herbal.action_descriptions TO postgres, anon, authenticated, service_role;
GRANT ALL ON SEQUENCE herbal.action_descriptions_id_seq TO postgres, anon, authenticated, service_role;

COMMENT ON TABLE herbal.action_descriptions IS 'Descriptive bullet points for primary actions';
COMMENT ON COLUMN herbal.action_descriptions.sort_order IS 'Order in which descriptions should be displayed';
-- This migration has been superseded by migration 008 (full data snapshot)
-- Migration 008 contains all action descriptions along with all other data
-- This file is kept for migration history but does nothing

SELECT 1; -- No-op statement to keep migration valid
-- Data Snapshot: Complete database state
-- This migration contains a full dump of all data including:
-- - All herbs, primary actions, secondary actions, body systems
-- - All herb-primary action relationships with body systems and strengths
-- - All herb-secondary action relationships
-- - All action descriptions (bullet points for each primary action)
--
-- Running 'supabase db reset' will restore the database to this exact state.
-- This snapshot was created after running the ingestion script and adding action descriptions.

-- Clear all existing data in the correct order (respecting foreign key constraints)
SET search_path TO herbal, public;

DELETE FROM herbal.action_descriptions;
DELETE FROM herbal.herb_secondary_actions;
DELETE FROM herbal.herb_primary_actions;
DELETE FROM herbal.secondary_actions;
DELETE FROM herbal.herbs;
DELETE FROM herbal.primary_actions;
DELETE FROM herbal.body_systems;

SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- \restrict HpaiwY8Yszu6KUg42qKJGrWw1I58Lut0jmsVHHyCtzyDi9LO5YfoY4HteSXq58L

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: primary_actions; Type: TABLE DATA; Schema: herbal; Owner: postgres
--

INSERT INTO "herbal"."primary_actions" ("id", "name", "description", "created_at") VALUES
	(1, 'Adaptogens', NULL, '2026-03-22 21:15:28.838092+00'),
	(2, 'Alteratives', NULL, '2026-03-22 21:15:28.838092+00'),
	(3, 'Anticatarrhal', NULL, '2026-03-22 21:15:28.838092+00'),
	(4, 'Anti-inflammatory', NULL, '2026-03-22 21:15:28.838092+00'),
	(5, 'Antimicrobial', NULL, '2026-03-22 21:15:28.838092+00'),
	(6, 'Antirheumatic', NULL, '2026-03-22 21:15:28.838092+00'),
	(7, 'Antispasmodic', NULL, '2026-03-22 21:15:28.838092+00'),
	(8, 'Astringent', NULL, '2026-03-22 21:15:28.838092+00'),
	(9, 'Bitter', NULL, '2026-03-22 21:15:28.838092+00'),
	(10, 'Cardiotonic', NULL, '2026-03-22 21:15:28.838092+00'),
	(11, 'Carminative', NULL, '2026-03-22 21:15:28.838092+00'),
	(12, 'Cholagogue', NULL, '2026-03-22 21:15:28.838092+00'),
	(13, 'Demulcent', NULL, '2026-03-22 21:15:28.838092+00'),
	(14, 'Diuretic', NULL, '2026-03-22 21:15:28.838092+00'),
	(15, 'Emmenagogue', NULL, '2026-03-22 21:15:28.838092+00'),
	(16, 'Stimulating Expectorant', NULL, '2026-03-22 21:15:28.838092+00'),
	(17, 'Relaxing Expectorant', NULL, '2026-03-22 21:15:28.838092+00'),
	(18, 'Amphoteric Expectorant', NULL, '2026-03-22 21:15:28.838092+00'),
	(19, 'Hepatic', NULL, '2026-03-22 21:15:28.838092+00'),
	(20, 'Hypnotic', NULL, '2026-03-22 21:15:28.838092+00'),
	(21, 'Hypotensive', NULL, '2026-03-22 21:15:28.838092+00'),
	(22, 'Nervine Tonics', NULL, '2026-03-22 21:15:28.838092+00'),
	(23, 'Nervine Relaxants', NULL, '2026-03-22 21:15:28.838092+00'),
	(24, 'Nervine Stimulant', NULL, '2026-03-22 21:15:28.838092+00');


--
-- Data for Name: action_descriptions; Type: TABLE DATA; Schema: herbal; Owner: postgres
--

INSERT INTO "herbal"."action_descriptions" ("id", "primary_action_id", "description", "sort_order", "created_at") VALUES
	(226, 5, 'a sage-y smell usually indicates this action', 3, '2026-03-22 21:31:43.736795+00'),
	(199, 1, 'Helps the body adapt to stress', 1, '2026-03-22 21:31:43.736795+00'),
	(200, 1, 'virtually non-toxic at high doses', 2, '2026-03-22 21:31:43.736795+00'),
	(201, 1, 'non-specific action throughout the body', 3, '2026-03-22 21:31:43.736795+00'),
	(202, 1, 'H-P-A axis = Hypothalamic Pituitary Adrenal - communication system involved in the stress response', 4, '2026-03-22 21:31:43.736795+00'),
	(203, 1, 'adaptogens help regulate this hormonal cascade', 5, '2026-03-22 21:31:43.736795+00'),
	(204, 1, 'non-specific state of resistance to stress: environmental, psych or physio', 6, '2026-03-22 21:31:43.736795+00'),
	(205, 1, 'helping the body adapt to and defend against the effects of environmental stress.', 7, '2026-03-22 21:31:43.736795+00'),
	(206, 1, 'The general aims of treatment with this action are to reduce stress reactions during the alarm phase of the stress response and to prevent or at least delay the state of exhaustion,', 8, '2026-03-22 21:31:43.736795+00'),
	(207, 1, 'smooth out the associated highs and lows. This conserves energy in the alarm phase for use in the resistance phase.', 9, '2026-03-22 21:31:43.736795+00'),
	(208, 2, 'alter the body from unhealthy to healthy via the body channels of elimination', 1, '2026-03-22 21:31:43.736795+00'),
	(209, 2, 'bowel, kidney, skin, liver', 2, '2026-03-22 21:31:43.736795+00'),
	(210, 2, 'aid in detoxification', 3, '2026-03-22 21:31:43.736795+00'),
	(211, 2, 'used to be called "blood cleanser"', 4, '2026-03-22 21:31:43.736795+00'),
	(212, 2, 'gradually restore proper function to the body and increase overall health and vitality.', 5, '2026-03-22 21:31:43.736795+00'),
	(213, 2, 'seem to alter the body''s metabolic processes to improve tissues'' ability to deal with a range of body functions, from nutrition to elimination.', 6, '2026-03-22 21:31:43.736795+00'),
	(214, 2, 'should be considered first for cases of chronic inflammatory and degenerative diseases', 7, '2026-03-22 21:31:43.736795+00'),
	(215, 2, 'Skin is the body system for which these are often used', 8, '2026-03-22 21:31:43.736795+00'),
	(216, 4, 'reduces inflammation from sprains, strains, headaches, wounds or chronic internal conditions', 1, '2026-03-22 21:31:43.736795+00'),
	(217, 4, 'promote healthy inflammation, regulate it to turn on and turn off', 2, '2026-03-22 21:31:43.736795+00'),
	(218, 4, 'work well with musculoskeletal discomfort', 3, '2026-03-22 21:31:43.736795+00'),
	(219, 4, 'help the body combat inflammation', 4, '2026-03-22 21:31:43.736795+00'),
	(220, 3, 'thin the mucus secretions and reduce congestion', 1, '2026-03-22 21:31:43.736795+00'),
	(221, 3, 'can be used for lungs, although aren''t as effective in loosening deep-seated mucus as the more stimulating expectorant', 2, '2026-03-22 21:31:43.736795+00'),
	(222, 3, 'help the body remove excess mucus, whether in the sinuses or in other parts of the body. They are used mainly for ear, nose, and throat infections,', 3, '2026-03-22 21:31:43.736795+00'),
	(223, 3, 'Some of this action remedies work by producing a less viscous mucus secretion that is easier for the body to remove. Others reduce mucus secretion directly.', 4, '2026-03-22 21:31:43.736795+00'),
	(224, 5, 'disinfectants, used both internally and externally to prevent or cure infections', 1, '2026-03-22 21:31:43.736795+00'),
	(225, 5, 'a lot of cooking herbs - sage, oregano', 2, '2026-03-22 21:31:43.736795+00'),
	(227, 5, 'usually can be used both topically and internally', 4, '2026-03-22 21:31:43.736795+00'),
	(228, 5, 'help the body destroy or resist pathogenic microorganisms in some way', 5, '2026-03-22 21:31:43.736795+00'),
	(229, 5, 'we are talking about plants that support the immune process, augmenting the integrity of the individual''s own defense system', 6, '2026-03-22 21:31:43.736795+00'),
	(230, 7, 'special kind of muscle relaxants', 1, '2026-03-22 21:31:43.736795+00'),
	(231, 7, 'help ease spasms and cramps and also very helpful in gently relaxing body extremities', 2, '2026-03-22 21:31:43.736795+00'),
	(232, 7, 'useful for variety of conditions: anxiety, nervousness, to hypertension, cold hands and feet', 3, '2026-03-22 21:31:43.736795+00'),
	(233, 7, 'prevent or ease spasms or cramps in the muscles. They thus reduce muscular tension in the body,', 4, '2026-03-22 21:31:43.736795+00'),
	(234, 7, 'facilitate physical relaxation of muscles without necessarily causing a sedative effect.', 5, '2026-03-22 21:31:43.736795+00'),
	(235, 7, 'the action that affects the peripheral nerves and the muscle tissue - may have an indirect relaxing action on the whole system.', 6, '2026-03-22 21:31:43.736795+00'),
	(236, 8, 'tone and tighten tissues', 1, '2026-03-22 21:31:43.736795+00'),
	(237, 8, 'tannin rich herbs', 2, '2026-03-22 21:31:43.736795+00'),
	(238, 8, 'pulling or drawing effect', 3, '2026-03-22 21:31:43.736795+00'),
	(239, 8, 'drying', 4, '2026-03-22 21:31:43.736795+00'),
	(240, 8, 'most barks have this property', 5, '2026-03-22 21:31:43.736795+00'),
	(241, 8, 'tightening of the tissue', 6, '2026-03-22 21:31:43.736795+00'),
	(242, 8, 'sometimes called styptics when applied externally to stop bleeding, or anti-hemorrhagics when used for internal bleeding.', 7, '2026-03-22 21:31:43.736795+00'),
	(243, 8, 'produce a kind of temporary leather coat on the surface of tissue.', 8, '2026-03-22 21:31:43.736795+00'),
	(244, 8, 'Reduce irritation on the surface of tissues through a sort of numbing action', 9, '2026-03-22 21:31:43.736795+00'),
	(245, 8, 'Reduce surface inflammation', 10, '2026-03-22 21:31:43.736795+00'),
	(246, 8, 'Create a barrier against infection, great help with wounds and burns', 11, '2026-03-22 21:31:43.736795+00'),
	(247, 8, 'of great importance in round healing and conditions affecting the digestive system.', 12, '2026-03-22 21:31:43.736795+00'),
	(248, 9, 'Stimulate appetite.', 1, '2026-03-22 21:31:43.736795+00'),
	(249, 9, 'Stimulate release of digestive juices from the pancreas, duodenum, and and liver', 2, '2026-03-22 21:31:43.736795+00'),
	(250, 9, 'Aid the liver in detoxification work and increase the flow of bile', 3, '2026-03-22 21:31:43.736795+00'),
	(251, 9, 'Help regulate secretion of pancreatic hormones that regulate blood sugar, insulin, and glucagon', 4, '2026-03-22 21:31:43.736795+00'),
	(252, 9, 'Help the gut wall repair damage by stimulating self-repair mechanisms.', 5, '2026-03-22 21:31:43.736795+00'),
	(253, 10, 'special affinity for the heart, regulating its beat, moderating hypertension, and usually tone the heart', 1, '2026-03-22 21:31:43.736795+00'),
	(254, 10, 'general category for herbal remedies that have some kind of action on the heart.', 2, '2026-03-22 21:31:43.736795+00'),
	(255, 11, 'clear "wind" and gas/bloating in the body', 1, '2026-03-22 21:31:43.736795+00'),
	(256, 11, 'move energy in the body downward if scattered thoughts as well!', 2, '2026-03-22 21:31:43.736795+00'),
	(257, 11, 'rich in volatile oils', 3, '2026-03-22 21:31:43.736795+00'),
	(258, 11, 'ease discomfort caused by flatulence.', 4, '2026-03-22 21:31:43.736795+00'),
	(259, 12, 'greek meaning bile, and as such has a cleaning and stimulating effect on the liver and gallbladder, allowing from the release of more bile', 1, '2026-03-22 21:31:43.736795+00'),
	(260, 12, 'helpful in aiding digestion, esp in the lower intestinal tract', 2, '2026-03-22 21:31:43.736795+00'),
	(261, 12, 'have the specific effect of stimulating the flow of bile from the liver.', 3, '2026-03-22 21:31:43.736795+00'),
	(262, 12, 'quite specific in that they act on the liver.', 4, '2026-03-22 21:31:43.736795+00'),
	(263, 12, 'indicated for disorders caused by insufficient or congested bile, such as intractable biliary constipation, jaundice, and mild hepatitis.', 5, '2026-03-22 21:31:43.736795+00'),
	(264, 12, 'contraindicated for painful gallstones, Increased contractile activity could further constrict the bile duct, leading to incredibly intense', 6, '2026-03-22 21:31:43.736795+00'),
	(265, 12, 'Because they help with assimilation, these have an enlivening "side effect" in the nervous system. These remedies may actively ease debility and', 7, '2026-03-22 21:31:43.736795+00'),
	(266, 13, 'soothing herbs rich in mucilage', 1, '2026-03-22 21:31:43.736795+00'),
	(267, 13, 'helps to heal mucosal barrier', 2, '2026-03-22 21:31:43.736795+00'),
	(268, 13, 'indication for gastric irritation, ulcers', 3, '2026-03-22 21:31:43.736795+00'),
	(269, 13, 'if someone is already damp, contraindication for this', 4, '2026-03-22 21:31:43.736795+00'),
	(270, 13, 'herbs with this action often have an apparently anti-inflammatory effect, but this is related to their ability to soothe inflamed surfaces, not to reductions in the cellular inflammatory response.', 5, '2026-03-22 21:31:43.736795+00'),
	(271, 13, 'rich in mucilage and can soothe and protect irritated or inflamed internal tissue. When used topically on the skin, these are called emollients.', 6, '2026-03-22 21:31:43.736795+00'),
	(272, 13, 'become slimy and gummy when they come in contact with water:', 7, '2026-03-22 21:31:43.736795+00'),
	(273, 13, 'Reduce irritation down the whole length of the bowel.', 8, '2026-03-22 21:31:43.736795+00'),
	(274, 13, 'Lessen the sensitivity of the digestive system to gastric acids and to digestive bitters', 9, '2026-03-22 21:31:43.736795+00'),
	(275, 14, 'gently promote elimination of water through the kidneys, as urine', 1, '2026-03-22 21:31:43.736795+00'),
	(276, 14, 'help the body rid itself of exces fluids by increasing the kidneys'' rate of urine production.', 2, '2026-03-22 21:31:43.736795+00'),
	(277, 14, 'Causes more blood to pass through the kidneys, which produces more urine', 3, '2026-03-22 21:31:43.736795+00'),
	(278, 14, 'Because of their cleansing actions, many of these help with problems of muscles and bones', 4, '2026-03-22 21:31:43.736795+00'),
	(279, 15, 'promote menstruation usually by slightly irritating the uterine lining', 1, '2026-03-22 21:31:43.736795+00'),
	(280, 15, 'severely contraindicated during pregnancy', 2, '2026-03-22 21:31:43.736795+00'),
	(281, 15, 'remedies that stimulate menstrual flow and activity', 3, '2026-03-22 21:31:43.736795+00'),
	(282, 19, 'herbal remedies that aid the work of the liver in a range of ways.', 1, '2026-03-22 21:31:43.736795+00'),
	(283, 19, 'Bitters and cholagogues all act as this action, but so do a whole array of other remedies that do not have those specific actions.', 2, '2026-03-22 21:31:43.736795+00'),
	(284, 20, 'trance-inducing, a little more than simple sedatives', 1, '2026-03-22 21:31:43.736795+00'),
	(285, 20, 'can be very relaxing , useful in sleep conditions, headaches, tension, and for addiction recovery', 2, '2026-03-22 21:31:43.736795+00'),
	(286, 20, 'don''t used with sedative medication already', 3, '2026-03-22 21:31:43.736795+00'),
	(287, 20, 'most are also hypotensives - lower blood pressure', 4, '2026-03-22 21:31:43.736795+00'),
	(288, 20, 'nervine remedies that help induce a deep and healing state of sleep.', 5, '2026-03-22 21:31:43.736795+00'),
	(289, 20, 'should always be used within the context of a holistic approach to sleep problems', 6, '2026-03-22 21:31:43.736795+00'),
	(290, 21, 'lower blood pressure by acting either on the heart, arteries, capillaries, or the water balance in the body', 1, '2026-03-22 21:31:43.736795+00'),
	(291, 21, 'use semi-preventatively, when the blood pressure starts to creep up, not in acute conditions', 2, '2026-03-22 21:31:43.736795+00'),
	(292, 21, 'reduce elevated blood pressure, tending to normalize both systolic and diastolic pressure.', 3, '2026-03-22 21:31:43.736795+00'),
	(293, 23, 'most important in times of stress and confusion, as they can alleviate many of the accompanying symptoms.', 1, '2026-03-22 21:31:43.736795+00'),
	(294, 23, 'the best remedies for the "inflamed state of mind"', 2, '2026-03-22 21:31:43.736795+00'),
	(295, 24, 'an action that quickens and enlivens the physiological activity of the body.', 1, '2026-03-22 21:31:43.736795+00'),
	(296, 17, 'seem also to act by reflex, but here the reflex action works to soothe bronchial spasm and loosen mucus secretions.', 1, '2026-03-22 21:31:43.736795+00'),
	(297, 17, 'help to produce a thinner mucus that is easier to expel, allowing the more viscous mucus to move and thus be eliminated.', 2, '2026-03-22 21:31:43.736795+00'),
	(298, 17, 'useful for dry, irritating coughs.', 3, '2026-03-22 21:31:43.736795+00'),
	(299, 17, 'This action is similar in some respects to that of demulcents, and both actions owe much to their content of mucilage and, occasionally, volatile oils.', 4, '2026-03-22 21:31:43.736795+00'),
	(300, 16, 'Irritate the bronchioles to stimulate expulsion of any material present', 1, '2026-03-22 21:31:43.736795+00'),
	(301, 16, 'Liquefy viscid sputum so that it can be cleared by coughing.', 2, '2026-03-22 21:31:43.736795+00');


--
-- Data for Name: body_systems; Type: TABLE DATA; Schema: herbal; Owner: postgres
--

INSERT INTO "herbal"."body_systems" ("id", "name", "created_at") VALUES
	(9, 'Cardiovascular', '2026-03-22 21:15:28.830018+00'),
	(10, 'Respiratory', '2026-03-22 21:15:28.830018+00'),
	(11, 'Digestive', '2026-03-22 21:15:28.830018+00'),
	(12, 'Urinary', '2026-03-22 21:15:28.830018+00'),
	(13, 'Reproductive', '2026-03-22 21:15:28.830018+00'),
	(14, 'Musculoskeletal', '2026-03-22 21:15:28.830018+00'),
	(15, 'Nervous', '2026-03-22 21:15:28.830018+00'),
	(16, 'Skin', '2026-03-22 21:15:28.830018+00');


--
-- Data for Name: herbs; Type: TABLE DATA; Schema: herbal; Owner: postgres
--

INSERT INTO "herbal"."herbs" ("id", "latin_name", "common_name", "created_at") VALUES
	(1, 'Acanthopanax sessiliflorum', 'Wu Jia Pi', '2026-03-22 21:15:28.845147+00'),
	(2, 'Albizzia julibrissin', 'Silk Tree', '2026-03-22 21:15:28.845147+00'),
	(3, 'Aralia elata', 'Japanese Angelica Tree', '2026-03-22 21:15:28.845147+00'),
	(4, 'Aralia manshurica', 'Manchurian Aralia', '2026-03-22 21:15:28.845147+00'),
	(5, 'Aralia schmidtii', 'Sakhalin Spikenard', '2026-03-22 21:15:28.845147+00'),
	(6, 'Cicer arietinum', 'Chickpea', '2026-03-22 21:15:28.845147+00'),
	(7, 'Codonoposis pilosula', 'Dang Shen', '2026-03-22 21:15:28.845147+00'),
	(8, 'Echinopanax elatus', 'Asian Devil’s Club', '2026-03-22 21:15:28.845147+00'),
	(9, 'Eleutherococcus senticosus', 'Siberian Ginseng', '2026-03-22 21:15:28.845147+00'),
	(10, 'Eucommia ulmoides', 'Hardy Rubber Tree', '2026-03-22 21:15:28.845147+00'),
	(11, 'Ganoderma lucidum', 'Reishi Mushroom', '2026-03-22 21:15:28.845147+00'),
	(12, 'Hoppea dichotoma Leuzea carthamoides', 'Maral Root', '2026-03-22 21:15:28.845147+00'),
	(13, 'Ocimum sanctum', 'Holy Basil', '2026-03-22 21:15:28.845147+00'),
	(14, 'Panax ginseng', 'Korean Ginseng', '2026-03-22 21:15:28.845147+00'),
	(15, 'Panax quinquefolius', 'American Ginseng', '2026-03-22 21:15:28.845147+00'),
	(16, 'Rhodiola rosea', 'Roseroot Stonecrop', '2026-03-22 21:15:28.845147+00'),
	(17, 'Schisandra chinensis', 'Schizandra', '2026-03-22 21:15:28.845147+00'),
	(18, 'Tinospora cordifolia', 'Guduchi', '2026-03-22 21:15:28.845147+00'),
	(19, 'Trichopus zeylanicus', 'Arogyappacha', '2026-03-22 21:15:28.845147+00'),
	(20, 'Withania somnifera', 'Ashwaganda', '2026-03-22 21:15:28.845147+00'),
	(21, 'Allium sativum', 'Garlic', '2026-03-22 21:15:28.845147+00'),
	(22, 'Arctium lappa', 'Burdock', '2026-03-22 21:15:28.845147+00'),
	(23, 'Baptisia tinctoria', 'Wild Indigo', '2026-03-22 21:15:28.845147+00'),
	(24, 'Chionanthus virginicus', 'Fringetree', '2026-03-22 21:15:28.845147+00'),
	(25, 'Cimicifuga racemosa', 'Black Cohosh', '2026-03-22 21:15:28.845147+00'),
	(26, 'Echinacea spp.', 'Echinacea', '2026-03-22 21:15:28.845147+00'),
	(27, 'Fumaria officinalis', 'Fumitory', '2026-03-22 21:15:28.845147+00'),
	(28, 'Galium aparine', 'Cleavers', '2026-03-22 21:15:28.845147+00'),
	(29, 'Guaiacum officinale', 'Guaiacum', '2026-03-22 21:15:28.845147+00'),
	(30, 'Hydrastis canadensis', 'Goldenseal', '2026-03-22 21:15:28.845147+00'),
	(31, 'Iris versicolor', 'Blue Flag', '2026-03-22 21:15:28.845147+00'),
	(32, 'Larrea tridentata', 'Chaparral', '2026-03-22 21:15:28.845147+00'),
	(33, 'Mahonia aquifolium', 'Oregon Grape', '2026-03-22 21:15:28.845147+00'),
	(34, 'Menyanthes trifoliata', 'Bogbean', '2026-03-22 21:15:28.845147+00'),
	(35, 'Phytolacca americana', 'Poke', '2026-03-22 21:15:28.845147+00'),
	(36, 'Pulsatilla vulgaris', 'Pasqueflower', '2026-03-22 21:15:28.845147+00'),
	(37, 'Rumex crispus', 'Yellow Dock', '2026-03-22 21:15:28.845147+00'),
	(38, 'Sanguinaria canadensis', 'Bloodroot', '2026-03-22 21:15:28.845147+00'),
	(39, 'Scrophularia nodosa', 'Figwort', '2026-03-22 21:15:28.845147+00'),
	(40, 'Smilax spp.', 'Sarsaparilla', '2026-03-22 21:15:28.845147+00'),
	(41, 'Stillingia sylvatica', 'Queen’s Delight', '2026-03-22 21:15:28.845147+00'),
	(42, 'Trifolium pratense', 'Red Clover', '2026-03-22 21:15:28.845147+00'),
	(43, 'Urtica dioica', 'Nettles', '2026-03-22 21:15:28.845147+00'),
	(44, 'Achillea millefolium', 'Yarrow', '2026-03-22 21:15:28.845147+00'),
	(45, 'Althaea officinalis', 'Marshmallow', '2026-03-22 21:15:28.845147+00'),
	(46, 'Arctostaphylos uva-ursi', 'Bearberry', '2026-03-22 21:15:28.845147+00'),
	(47, 'Capsicum annuum', 'Cayenne', '2026-03-22 21:15:28.845147+00'),
	(48, 'Cetraria islandica', 'Iceland Moss', '2026-03-22 21:15:28.845147+00'),
	(49, 'Chondrus crispus', 'Irish Moss', '2026-03-22 21:15:28.845147+00'),
	(50, 'Eupatorium perfoliatum', 'Boneset', '2026-03-22 21:15:28.845147+00'),
	(51, 'Euphrasia spp.', 'Eyebright', '2026-03-22 21:15:28.845147+00'),
	(52, 'Geranium maculatum', 'Cranesbill', '2026-03-22 21:15:28.845147+00'),
	(53, 'Hyssopus officinalis', 'Hyssop', '2026-03-22 21:15:28.845147+00'),
	(54, 'Inula helenium', 'Elecampane', '2026-03-22 21:15:28.845147+00'),
	(55, 'Mentha piperita', 'Peppermint', '2026-03-22 21:15:28.845147+00'),
	(56, 'Salvia officinalis', 'Sage', '2026-03-22 21:15:28.845147+00'),
	(57, 'Sambucus nigra', 'Elder', '2026-03-22 21:15:28.845147+00'),
	(58, 'Solidago virgaurea', 'Goldenrod', '2026-03-22 21:15:28.845147+00'),
	(59, 'Thymus vulgaris', 'Thyme', '2026-03-22 21:15:28.845147+00'),
	(60, 'Tussilago farfara', 'Coltsfoot', '2026-03-22 21:15:28.845147+00'),
	(61, 'Verbascum thapsus', 'Mullein', '2026-03-22 21:15:28.845147+00'),
	(62, 'Aesculus hippocastanum', 'Horse Chestnut', '2026-03-22 21:15:28.845147+00'),
	(63, 'Alchemilla arvensis', 'Lady’s Mantle', '2026-03-22 21:15:28.845147+00'),
	(64, 'Anethum graveolens', 'Dill', '2026-03-22 21:15:28.845147+00'),
	(65, 'Angelica archangelica', 'Angelica', '2026-03-22 21:15:28.845147+00'),
	(66, 'Apium graveolens', 'Celery Seed', '2026-03-22 21:15:28.845147+00'),
	(67, 'Asclepias tuberosa', 'Pleurisy Root', '2026-03-22 21:15:28.845147+00'),
	(68, 'Betula spp.', 'Birch', '2026-03-22 21:15:28.845147+00'),
	(69, 'Borago officinalis', 'Borage', '2026-03-22 21:15:28.845147+00'),
	(70, 'Calendula officinalis', 'Calendula', '2026-03-22 21:15:28.845147+00'),
	(71, 'Capsella bursa-pastoris', 'Shepherd’s Purse', '2026-03-22 21:15:28.845147+00'),
	(72, 'Caulophyllum thalictroides', 'Blue Cohosh', '2026-03-22 21:15:28.845147+00'),
	(73, 'Crataegus spp.', 'Hawthorn', '2026-03-22 21:15:28.845147+00'),
	(74, 'Dioscorea villosa', 'Wild Yam', '2026-03-22 21:15:28.845147+00'),
	(75, 'Filipendula ulmaria', 'Meadowsweet', '2026-03-22 21:15:28.845147+00'),
	(76, 'Foeniculum vulgare', 'Fennel', '2026-03-22 21:15:28.845147+00'),
	(77, 'Gaultheria procumbens', 'Wintergreen', '2026-03-22 21:15:28.845147+00'),
	(78, 'Glycyrrhiza glabra', 'Licorice', '2026-03-22 21:15:28.845147+00'),
	(79, 'Hamamelis virginiana', 'Witch Hazel', '2026-03-22 21:15:28.845147+00'),
	(80, 'Harpagophytum procumbens', 'Devil’s Claw', '2026-03-22 21:15:28.845147+00'),
	(81, 'Hypericum perforatum', 'St. John’s Wort', '2026-03-22 21:15:28.845147+00'),
	(82, 'Lavandula spp.', 'Lavender', '2026-03-22 21:15:28.845147+00'),
	(83, 'Malva sylvestris', 'Mallow', '2026-03-22 21:15:28.845147+00'),
	(84, 'Matricaria recutita', 'Chamomile', '2026-03-22 21:15:28.845147+00'),
	(85, 'Plantago major', 'Plantain', '2026-03-22 21:15:28.845147+00'),
	(86, 'Populus tremuloides', 'Aspen', '2026-03-22 21:15:28.845147+00'),
	(87, 'Salix spp.', 'Willow', '2026-03-22 21:15:28.845147+00'),
	(88, 'Stellaria media', 'Chickweed', '2026-03-22 21:15:28.845147+00'),
	(89, 'Symphytum officinale', 'Comfrey', '2026-03-22 21:15:28.845147+00'),
	(90, 'Tilia platyphyllos', 'Linden', '2026-03-22 21:15:28.845147+00'),
	(91, 'Trigonella foenum-graecum', 'Fenugreek', '2026-03-22 21:15:28.845147+00'),
	(92, 'Ulmus rubra', 'Slippery Elm', '2026-03-22 21:15:28.845147+00'),
	(93, 'Viburnum opulus', 'Cramp Bark', '2026-03-22 21:15:28.845147+00'),
	(94, 'Viburnum prunifolium', 'Black Haw', '2026-03-22 21:15:28.845147+00'),
	(95, 'Zea mays', 'Corn Silk', '2026-03-22 21:15:28.845147+00'),
	(96, 'Artemisia abrotanum', 'Southernwood', '2026-03-22 21:15:28.845147+00'),
	(97, 'Artemisia absinthium', 'Wormwood', '2026-03-22 21:15:28.845147+00'),
	(98, 'Carum carvi', 'Caraway', '2026-03-22 21:15:28.845147+00'),
	(99, 'Commiphora molmol', 'Myrrh', '2026-03-22 21:15:28.845147+00'),
	(100, 'Coriandrum sativum', 'Coriander', '2026-03-22 21:15:28.845147+00'),
	(101, 'Eucalyptus spp.', 'Eucalyptus', '2026-03-22 21:15:28.845147+00'),
	(102, 'Gentiana lutea', 'Gentian', '2026-03-22 21:15:28.845147+00'),
	(103, 'Juniperus communis', 'Juniper', '2026-03-22 21:15:28.845147+00'),
	(104, 'Ligusticum porteri', 'Osha', '2026-03-22 21:15:28.845147+00'),
	(105, 'Myroxylon balsamum var. pereirae', 'Balsam Of Peru', '2026-03-22 21:15:28.845147+00'),
	(106, 'Olea europaea', 'Olive', '2026-03-22 21:15:28.845147+00'),
	(107, 'Origanum majorana', 'Marjoram', '2026-03-22 21:15:28.845147+00'),
	(108, 'Pimpinella anisum', 'Aniseed', '2026-03-22 21:15:28.845147+00'),
	(109, 'Rosmarinus officinalis', 'Rosemary', '2026-03-22 21:15:28.845147+00'),
	(110, 'Ruta graveolens', 'Rue', '2026-03-22 21:15:28.845147+00'),
	(111, 'Syzygium aromaticum', 'Clove', '2026-03-22 21:15:28.845147+00'),
	(112, 'Usnea spp.', 'Usnea', '2026-03-22 21:15:28.845147+00'),
	(113, 'Armoracia rusticana', 'Horseradish', '2026-03-22 21:15:28.845147+00'),
	(114, 'Arnica montana', 'Arnica', '2026-03-22 21:15:28.845147+00'),
	(115, 'Artemisia vulgaris', 'Mugwort', '2026-03-22 21:15:28.845147+00'),
	(116, 'Brassica spp.', 'Mustard', '2026-03-22 21:15:28.845147+00'),
	(117, 'Eupatorium purpureum', 'Gravel Root', '2026-03-22 21:15:28.845147+00'),
	(118, 'Fucus vesiculosus', 'Kelp', '2026-03-22 21:15:28.845147+00'),
	(119, 'Myrica cerifera', 'Bayberry', '2026-03-22 21:15:28.845147+00'),
	(120, 'Petroselinum crispum', 'Parsley', '2026-03-22 21:15:28.845147+00'),
	(121, 'Tanacetum parthenium', 'Feverfew', '2026-03-22 21:15:28.845147+00'),
	(122, 'Taraxacum officinale', 'Dandelion', '2026-03-22 21:15:28.845147+00'),
	(123, 'Zanthoxylum americanum', 'Prickly Ash', '2026-03-22 21:15:28.845147+00'),
	(124, 'Zingiber officinale', 'Ginger', '2026-03-22 21:15:28.845147+00'),
	(125, 'Daucus carota', 'Wild Carrot', '2026-03-22 21:15:28.845147+00'),
	(126, 'Drosera rotundifolia', 'Sundew', '2026-03-22 21:15:28.845147+00'),
	(127, 'Elettaria cardamomum', 'Cardamom', '2026-03-22 21:15:28.845147+00'),
	(128, 'Eschscholzia californica', 'California Poppy', '2026-03-22 21:15:28.845147+00'),
	(129, 'Humulus lupulus', 'Hops', '2026-03-22 21:15:28.845147+00'),
	(130, 'Lactuca virosa', 'Wild Lettuce', '2026-03-22 21:15:28.845147+00'),
	(131, 'Leonurus cardiaca', 'Motherwort', '2026-03-22 21:15:28.845147+00'),
	(132, 'Lobelia inflata', 'Lobelia', '2026-03-22 21:15:28.845147+00'),
	(133, 'Lycopus spp.', 'Bugleweed', '2026-03-22 21:15:28.845147+00'),
	(134, 'Melissa officinalis', 'Lemon Balm', '2026-03-22 21:15:28.845147+00'),
	(135, 'Mentha pulegium', 'Pennyroyal', '2026-03-22 21:15:28.845147+00'),
	(136, 'Nepeta cataria', 'Catnip', '2026-03-22 21:15:28.845147+00'),
	(137, 'Passiflora incarnata', 'Passionflower', '2026-03-22 21:15:28.845147+00'),
	(138, 'Piper methysticum', 'Kava', '2026-03-22 21:15:28.845147+00'),
	(139, 'Piscidia erythrina', 'Jamaica Dogwood', '2026-03-22 21:15:28.845147+00'),
	(140, 'Prunus serotina', 'Wild Cherry Bark', '2026-03-22 21:15:28.845147+00'),
	(141, 'Salvia officinalis var. rubia', 'Red Sage', '2026-03-22 21:15:28.845147+00'),
	(142, 'Scutellaria lateriflora', 'Skullcap', '2026-03-22 21:15:28.845147+00'),
	(143, 'Symplocarpus foetidus', 'Skunk Cabbage', '2026-03-22 21:15:28.845147+00'),
	(144, 'Turnera diffusa', 'Damiana', '2026-03-22 21:15:28.845147+00'),
	(145, 'Valeriana officinalis', 'Valerian', '2026-03-22 21:15:28.845147+00'),
	(146, 'Verbena officinalis', 'Vervain', '2026-03-22 21:15:28.845147+00'),
	(147, 'Acacia catechu', 'Black Catechu', '2026-03-22 21:15:28.845147+00'),
	(148, 'Agrimonia eupatoria', 'Agrimony', '2026-03-22 21:15:28.845147+00'),
	(149, 'Camellia sinensis', 'Tea', '2026-03-22 21:15:28.845147+00'),
	(150, 'Cola acuminata', 'Kola', '2026-03-22 21:15:28.845147+00'),
	(151, 'Equisetum arvense', 'Horsetail', '2026-03-22 21:15:28.845147+00'),
	(152, 'Polygonum bistorta', 'Bistort', '2026-03-22 21:15:28.845147+00'),
	(153, 'Quercus spp.', 'Oak', '2026-03-22 21:15:28.845147+00'),
	(154, 'Rheum palmatum', 'Rhubarb', '2026-03-22 21:15:28.845147+00'),
	(155, 'Rubus idaeus', 'Raspberry', '2026-03-22 21:15:28.845147+00'),
	(156, 'Rubus villosus', 'Blackberry', '2026-03-22 21:15:28.845147+00'),
	(157, 'Vinca major', 'Periwinkle', '2026-03-22 21:15:28.845147+00'),
	(158, 'Berberis vulgaris', 'Barberry', '2026-03-22 21:15:28.845147+00'),
	(159, 'Centaurium erythraea', 'Centaury', '2026-03-22 21:15:28.845147+00'),
	(160, 'Marrubium vulgare', 'Horehound', '2026-03-22 21:15:28.845147+00'),
	(161, 'Tanacetum vulgare', 'Tansy', '2026-03-22 21:15:28.845147+00'),
	(162, 'Coleus forskohlii', 'Coleus', '2026-03-22 21:15:28.845147+00'),
	(163, 'Convallaria majalis', 'Lily Of The Valley', '2026-03-22 21:15:28.845147+00'),
	(164, 'Cytisus scoparius', 'Scotch Broom', '2026-03-22 21:15:28.845147+00'),
	(165, 'Ginkgo biloba', 'Ginkgo', '2026-03-22 21:15:28.845147+00'),
	(166, 'Urginea maritima', 'Squill', '2026-03-22 21:15:28.845147+00'),
	(167, 'Cinnamomum spp.', 'Cinnamon', '2026-03-22 21:15:28.845147+00'),
	(168, 'Eucalyptus globulus', 'Eucalyptus', '2026-03-22 21:15:28.845147+00'),
	(169, 'Thymus spp.', 'Thyme', '2026-03-22 21:15:28.845147+00'),
	(170, 'Chelidonium majus', 'Celandine', '2026-03-22 21:15:28.845147+00'),
	(171, 'Chelone glabra', 'Balmony', '2026-03-22 21:15:28.845147+00'),
	(172, 'Cynara scolymus', 'Artichoke', '2026-03-22 21:15:28.845147+00'),
	(173, 'Euonymus atropurpureus', 'Wahoo', '2026-03-22 21:15:28.845147+00'),
	(174, 'Juglans cinerea', 'Butternut', '2026-03-22 21:15:28.845147+00'),
	(175, 'Leptandra virginica', 'Black Root', '2026-03-22 21:15:28.845147+00'),
	(176, 'Peumus boldus', 'Boldo', '2026-03-22 21:15:28.845147+00'),
	(177, 'Taraxacum officinale root', 'Dandelion', '2026-03-22 21:15:28.845147+00'),
	(178, 'Avena sativa', 'Oat', '2026-03-22 21:15:28.845147+00'),
	(179, 'Elymus repens', 'Couch Grass', '2026-03-22 21:15:28.845147+00'),
	(180, 'Linum usitatissimum', 'Flax', '2026-03-22 21:15:28.845147+00'),
	(181, 'Agathosma betulina', 'Buchu', '2026-03-22 21:15:28.845147+00'),
	(182, 'Collinsonia canadensis', 'Stoneroot', '2026-03-22 21:15:28.845147+00'),
	(183, 'Cucurbita pepo', 'Pumpkin', '2026-03-22 21:15:28.845147+00'),
	(184, 'Eryngium maritimum', 'Sea Holly', '2026-03-22 21:15:28.845147+00'),
	(185, 'Parietaria judaica', 'Pellitory Of The Wall', '2026-03-22 21:15:28.845147+00'),
	(186, 'Serenoa repens', 'Saw Palmetto', '2026-03-22 21:15:28.845147+00'),
	(187, 'Marsdenia condurango', 'Condurango', '2026-03-22 21:15:28.845147+00'),
	(188, 'Mitchella repens', 'Partridgeberry', '2026-03-22 21:15:28.845147+00'),
	(189, 'Tropaeolum majus', 'Nasturtium', '2026-03-22 21:15:28.845147+00'),
	(190, 'Vitex agnus-castus', 'Chasteberry', '2026-03-22 21:15:28.845147+00'),
	(191, 'Bellis perennis', 'English Daisy', '2026-03-22 21:15:28.845147+00'),
	(192, 'Cephaelis ipecacuanha', 'Ipecac', '2026-03-22 21:15:28.845147+00'),
	(193, 'Hieracium pilosella', 'Mouse Ear', '2026-03-22 21:15:28.845147+00'),
	(194, 'Myroxylon balsamum var. balsamum', 'Tolu Balsam', '2026-03-22 21:15:28.845147+00'),
	(195, 'Polygala senega', 'Seneca Snakeroot', '2026-03-22 21:15:28.845147+00'),
	(196, 'Populus candicans', 'Balm Of Gilead', '2026-03-22 21:15:28.845147+00'),
	(197, 'Primula veris', 'Cowslip', '2026-03-22 21:15:28.845147+00'),
	(198, 'Viola odorata', 'Sweet Violet', '2026-03-22 21:15:28.845147+00'),
	(199, 'Grindelia camporum', 'Gumweed', '2026-03-22 21:15:28.845147+00'),
	(200, 'Pulmonaria officinalis', 'Lungwort', '2026-03-22 21:15:28.845147+00'),
	(201, 'Thuja occidentalis', 'Thuja', '2026-03-22 21:15:28.845147+00'),
	(202, 'Aloe vera', 'Aloe', '2026-03-22 21:15:28.845147+00'),
	(203, 'Curcuma longa', 'Turmeric', '2026-03-22 21:15:28.845147+00'),
	(204, 'Rhamnus cathartica', 'Buckthorn', '2026-03-22 21:15:28.845147+00'),
	(205, 'Rhamnus purshiana', 'Cascara Sagrada', '2026-03-22 21:15:28.845147+00'),
	(206, 'Silybum marianum', 'Milk Thistle', '2026-03-22 21:15:28.845147+00'),
	(207, 'Stachys officinalis', 'Wood Betony', '2026-03-22 21:15:28.845147+00'),
	(208, 'Allium cepa', 'Onion', '2026-03-22 21:15:28.845147+00'),
	(209, 'A.sativum', 'Garlic', '2026-03-22 21:15:28.845147+00'),
	(210, 'Fagopyrum esculentum', 'Buckwheat', '2026-03-22 21:15:28.845147+00'),
	(211, 'Viscum album', 'Mistletoe', '2026-03-22 21:15:28.845147+00'),
	(212, 'Ballota nigra', 'Black Horehound', '2026-03-22 21:15:28.845147+00'),
	(213, 'Chamaemelum nobile', 'Roman Chamomile', '2026-03-22 21:15:28.845147+00'),
	(214, 'Stachys betonica', 'Wood Betony', '2026-03-22 21:15:28.845147+00'),
	(215, 'Panax spp.', 'Ginseng', '2026-03-22 21:15:28.845147+00'),
	(216, 'Senna alexandrina', 'Senna', '2026-03-22 21:15:28.845147+00'),
	(217, 'Coffea arabica', 'Coffee', '2026-03-22 21:15:28.845147+00'),
	(218, 'Paullinia cupana', 'Guarana', '2026-03-22 21:15:28.845147+00');


--
-- Data for Name: herb_primary_actions; Type: TABLE DATA; Schema: herbal; Owner: postgres
--

INSERT INTO "herbal"."herb_primary_actions" ("id", "herb_id", "primary_action_id", "body_system_id", "body_system_note", "relative_strength", "created_at") VALUES
	(47, 1, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.860367+00'),
	(48, 2, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.864506+00'),
	(49, 3, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.8667+00'),
	(50, 4, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.869125+00'),
	(51, 5, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.870665+00'),
	(52, 6, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.872882+00'),
	(53, 7, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.874695+00'),
	(54, 8, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.876419+00'),
	(55, 9, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.877971+00'),
	(56, 10, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.879809+00'),
	(57, 11, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.881635+00'),
	(58, 12, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.900256+00'),
	(59, 13, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.903098+00'),
	(60, 14, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.904748+00'),
	(61, 15, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.906662+00'),
	(62, 16, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.908764+00'),
	(63, 17, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.910856+00'),
	(64, 18, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.913147+00'),
	(65, 19, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.915547+00'),
	(66, 20, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.917424+00'),
	(67, 21, 2, 9, 'The hypocholesteremic and hypotensive actions are well known', 'mild', '2026-03-22 21:15:28.918937+00'),
	(68, 21, 2, 10, 'The main alteratives that also possess beneficial properties for the lungs and respiratory system as a whole', 'mild', '2026-03-22 21:15:28.921029+00'),
	(69, 21, 2, 11, 'All of the alteratives that work on the liver, pancreas, and other digestive system organs are of great importance in herbal medicine', 'mild', '2026-03-22 21:15:28.922858+00'),
	(70, 22, 2, 11, 'All of the alteratives that work on the liver, pancreas, and other digestive system organs are of great importance in herbal medicine', 'strong', '2026-03-22 21:15:28.924826+00'),
	(71, 22, 2, 14, 'Many alteratives are important here', 'strong', '2026-03-22 21:15:28.928079+00'),
	(72, 22, 2, 16, 'The list of alteratives for the skin could include all of the herbs listed here, plus many more. This is the system for which alteratives are most often used. It is important to remember that in holistic herbalism, aiding and supporting the whole body in its return to health is always more important than applying specific remedies', 'strong', '2026-03-22 21:15:28.930067+00'),
	(73, 23, 2, 10, 'The main alteratives that also possess beneficial properties for the lungs and respiratory system as a whole', 'mild', '2026-03-22 21:15:28.932671+00'),
	(74, 24, 2, 11, 'All of the alteratives that work on the liver, pancreas, and other digestive system organs are of great importance in herbal medicine', 'mild', '2026-03-22 21:15:28.934721+00'),
	(75, 25, 2, 13, 'Here, the general alteratives are always of value', 'mild', '2026-03-22 21:15:28.936598+00'),
	(76, 25, 2, 14, 'Many alteratives are important here', 'mild', '2026-03-22 21:15:28.937801+00'),
	(77, 26, 2, 9, 'In general, alterative activity is not specifically indicated for this system. However, by nature, alteratives will aid circulation by helping the whole body work at its peak. Alteratives to support the lymphatic aspects of circulation', 'mild', '2026-03-22 21:15:28.939082+00'),
	(78, 26, 2, 10, 'The main alteratives that also possess beneficial properties for the lungs and respiratory system as a whole', 'mild', '2026-03-22 21:15:28.940283+00'),
	(79, 26, 2, 16, 'The list of alteratives for the skin could include all of the herbs listed here, plus many more. This is the system for which alteratives are most often used. It is important to remember that in holistic herbalism, aiding and supporting the whole body in its return to health is always more important than applying specific remedies', 'mild', '2026-03-22 21:15:28.941691+00'),
	(80, 27, 2, 16, 'The list of alteratives for the skin could include all of the herbs listed here, plus many more. This is the system for which alteratives are most often used. It is important to remember that in holistic herbalism, aiding and supporting the whole body in its return to health is always more important than applying specific remedies', 'strong', '2026-03-22 21:15:28.943168+00'),
	(81, 28, 2, 9, 'In general, alterative activity is not specifically indicated for this system. However, by nature, alteratives will aid circulation by helping the whole body work at its peak. Alteratives to support the lymphatic aspects of circulation', 'strong', '2026-03-22 21:15:28.944308+00'),
	(82, 28, 2, 12, 'Some of the herbs described as diuretics could be characterized as urinary system alteratives', 'strong', '2026-03-22 21:15:28.945413+00'),
	(83, 28, 2, 16, 'The list of alteratives for the skin could include all of the herbs listed here, plus many more. This is the system for which alteratives are most often used. It is important to remember that in holistic herbalism, aiding and supporting the whole body in its return to health is always more important than applying specific remedies', 'strong', '2026-03-22 21:15:28.946544+00'),
	(84, 29, 2, NULL, NULL, 'strong', '2026-03-22 21:15:28.947709+00'),
	(85, 30, 2, 10, 'The main alteratives that also possess beneficial properties for the lungs and respiratory system as a whole', 'strong', '2026-03-22 21:15:28.949028+00'),
	(86, 30, 2, 11, 'All of the alteratives that work on the liver, pancreas, and other digestive system organs are of great importance in herbal medicine', 'strong', '2026-03-22 21:15:28.950192+00'),
	(87, 30, 2, 13, 'Here, the general alteratives are always of value', 'strong', '2026-03-22 21:15:28.951741+00'),
	(88, 31, 2, 11, 'All of the alteratives that work on the liver, pancreas, and other digestive system organs are of great importance in herbal medicine', 'very_strong', '2026-03-22 21:15:28.95297+00'),
	(89, 32, 2, NULL, NULL, 'very_strong', '2026-03-22 21:15:28.954093+00'),
	(126, 49, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:29.007816+00'),
	(257, 113, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.19752+00'),
	(90, 33, 2, 16, 'The list of alteratives for the skin could include all of the herbs listed here, plus many more. This is the system for which alteratives are most often used. It is important to remember that in holistic herbalism, aiding and supporting the whole body in its return to health is always more important than applying specific remedies', 'mild', '2026-03-22 21:15:28.955221+00'),
	(91, 34, 2, 11, 'All of the alteratives that work on the liver, pancreas, and other digestive system organs are of great importance in herbal medicine', 'mild', '2026-03-22 21:15:28.956865+00'),
	(92, 34, 2, 14, 'Many alteratives are important here', 'mild', '2026-03-22 21:15:28.958018+00'),
	(93, 35, 2, 9, 'In general, alterative activity is not specifically indicated for this system. However, by nature, alteratives will aid circulation by helping the whole body work at its peak. Alteratives to support the lymphatic aspects of circulation', 'very_strong', '2026-03-22 21:15:28.959159+00'),
	(94, 36, 2, 15, 'By helping the body to be healthy and whole, all alteratives aid the strained nervous system, but this is especially helpful as an alterative with nervine actions', 'mild', '2026-03-22 21:15:28.960447+00'),
	(95, 37, 2, 11, 'All of the alteratives that work on the liver, pancreas, and other digestive system organs are of great importance in herbal medicine', 'strong', '2026-03-22 21:15:28.961598+00'),
	(96, 37, 2, 16, 'The list of alteratives for the skin could include all of the herbs listed here, plus many more. This is the system for which alteratives are most often used. It is important to remember that in holistic herbalism, aiding and supporting the whole body in its return to health is always more important than applying specific remedies', 'strong', '2026-03-22 21:15:28.962943+00'),
	(97, 38, 2, 10, 'The main alteratives that also possess beneficial properties for the lungs and respiratory system as a whole', 'very_strong', '2026-03-22 21:15:28.963953+00'),
	(98, 39, 2, 9, 'useful in chronic eczema, also has positive inotropic actions', 'strong', '2026-03-22 21:15:28.965008+00'),
	(99, 39, 2, 16, 'The list of alteratives for the skin could include all of the herbs listed here, plus many more. This is the system for which alteratives are most often used. It is important to remember that in holistic herbalism, aiding and supporting the whole body in its return to health is always more important than applying specific remedies', 'strong', '2026-03-22 21:15:28.966074+00'),
	(100, 40, 2, 11, 'All of the alteratives that work on the liver, pancreas, and other digestive system organs are of great importance in herbal medicine', 'strong', '2026-03-22 21:15:28.967073+00'),
	(101, 40, 2, 16, 'The list of alteratives for the skin could include all of the herbs listed here, plus many more. This is the system for which alteratives are most often used. It is important to remember that in holistic herbalism, aiding and supporting the whole body in its return to health is always more important than applying specific remedies', 'strong', '2026-03-22 21:15:28.968503+00'),
	(102, 41, 2, NULL, NULL, 'very_strong', '2026-03-22 21:15:28.969541+00'),
	(103, 42, 2, 15, 'By helping the body to be healthy and whole, all alteratives aid the strained nervous system, but this is especially helpful as an alterative with nervine actions', 'strong', '2026-03-22 21:15:28.970603+00'),
	(104, 42, 2, 16, 'The list of alteratives for the skin could include all of the herbs listed here, plus many more. This is the system for which alteratives are most often used. It is important to remember that in holistic herbalism, aiding and supporting the whole body in its return to health is always more important than applying specific remedies', 'strong', '2026-03-22 21:15:28.972026+00'),
	(105, 43, 2, 11, 'All of the alteratives that work on the liver, pancreas, and other digestive system organs are of great importance in herbal medicine', 'strong', '2026-03-22 21:15:28.973292+00'),
	(106, 43, 2, 12, 'Some of the herbs described as diuretics could be characterized as urinary system alteratives', 'strong', '2026-03-22 21:15:28.974732+00'),
	(107, 44, 3, 9, 'Anticatarrhal action is not directly relevant to the cardiovascular system. However, it could be said that anticatarrhal remedies help the system by contributing to general detoxification and elimination', NULL, '2026-03-22 21:15:28.976266+00'),
	(108, 44, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:28.977744+00'),
	(109, 44, 3, 13, 'While the herbs listed below may all play a role in the holistic treatment of an individual with reproductive system issues, none of them is a primary remedy for male or female problems, this would be the first supportive remedies to consider', NULL, '2026-03-22 21:15:28.979452+00'),
	(110, 21, 3, 9, 'Anticatarrhal action is not directly relevant to the cardiovascular system. However, it could be said that anticatarrhal remedies help the system by contributing to general detoxification and elimination', NULL, '2026-03-22 21:15:28.980845+00'),
	(111, 21, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:28.98224+00'),
	(112, 21, 3, 11, 'Anticatarrhals that have bitter, demulcent, carminative, hepatic, or astringent properties make useful therapeutic contributions to digestive problems', NULL, '2026-03-22 21:15:28.983471+00'),
	(113, 21, 3, 16, 'Anticatarrhals may be indirectly indicated for the treatment of a range of skin problems because they support the body’s cleansing processes', NULL, '2026-03-22 21:15:28.985451+00'),
	(114, 45, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:28.987434+00'),
	(115, 45, 3, 11, 'Anticatarrhals that have bitter, demulcent, carminative, hepatic, or astringent properties make useful therapeutic contributions to digestive problems', NULL, '2026-03-22 21:15:28.98896+00'),
	(116, 46, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:28.990977+00'),
	(117, 46, 3, 12, 'In addition to their anticatarrhal properties', NULL, '2026-03-22 21:15:28.993363+00'),
	(118, 46, 3, 13, 'While the herbs listed below may all play a role in the holistic treatment of an individual with reproductive system issues, none of them is a primary remedy for male or female problems, this would be the first supportive remedies to consider', NULL, '2026-03-22 21:15:28.995361+00'),
	(119, 23, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:28.997055+00'),
	(120, 23, 3, 16, 'Anticatarrhals may be indirectly indicated for the treatment of a range of skin problems because they support the body’s cleansing processes', NULL, '2026-03-22 21:15:28.998456+00'),
	(121, 47, 3, 9, 'Anticatarrhal action is not directly relevant to the cardiovascular system. However, it could be said that anticatarrhal remedies help the system by contributing to general detoxification and elimination', NULL, '2026-03-22 21:15:29.000208+00'),
	(122, 47, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:29.002531+00'),
	(123, 47, 3, 11, 'Anticatarrhals that have bitter, demulcent, carminative, hepatic, or astringent properties make useful therapeutic contributions to digestive problems', NULL, '2026-03-22 21:15:29.004104+00'),
	(124, 48, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:29.005399+00'),
	(125, 48, 3, 11, 'Anticatarrhals that have bitter, demulcent, carminative, hepatic, or astringent properties make useful therapeutic contributions to digestive problems', NULL, '2026-03-22 21:15:29.006687+00'),
	(127, 49, 3, 11, 'Anticatarrhals that have bitter, demulcent, carminative, hepatic, or astringent properties make useful therapeutic contributions to digestive problems', NULL, '2026-03-22 21:15:29.008974+00'),
	(128, 26, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:29.010639+00'),
	(129, 26, 3, 16, 'Anticatarrhals may be indirectly indicated for the treatment of a range of skin problems because they support the body’s cleansing processes', NULL, '2026-03-22 21:15:29.015538+00'),
	(130, 50, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:29.017363+00'),
	(131, 50, 3, 11, 'Anticatarrhals that have bitter, demulcent, carminative, hepatic, or astringent properties make useful therapeutic contributions to digestive problems', NULL, '2026-03-22 21:15:29.019108+00'),
	(132, 51, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:29.02082+00'),
	(133, 52, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:29.022388+00'),
	(134, 52, 3, 11, 'Anticatarrhals that have bitter, demulcent, carminative, hepatic, or astringent properties make useful therapeutic contributions to digestive problems', NULL, '2026-03-22 21:15:29.023785+00'),
	(135, 52, 3, 13, 'While the herbs listed below may all play a role in the holistic treatment of an individual with reproductive system issues, none of them is a primary remedy for male or female problems, this would be the first supportive remedies to consider', NULL, '2026-03-22 21:15:29.024917+00'),
	(136, 30, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:29.026073+00'),
	(137, 30, 3, 11, 'Anticatarrhals that have bitter, demulcent, carminative, hepatic, or astringent properties make useful therapeutic contributions to digestive problems', NULL, '2026-03-22 21:15:29.027758+00'),
	(138, 30, 3, 13, 'While the herbs listed below may all play a role in the holistic treatment of an individual with reproductive system issues, none of them is a primary remedy for male or female problems, this would be the first supportive remedies to consider', NULL, '2026-03-22 21:15:29.029486+00'),
	(139, 30, 3, 16, 'Anticatarrhals may be indirectly indicated for the treatment of a range of skin problems because they support the body’s cleansing processes', NULL, '2026-03-22 21:15:29.030747+00'),
	(140, 53, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:29.032163+00'),
	(141, 54, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:29.033392+00'),
	(142, 55, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:29.035013+00'),
	(143, 55, 3, 11, 'Anticatarrhals that have bitter, demulcent, carminative, hepatic, or astringent properties make useful therapeutic contributions to digestive problems', NULL, '2026-03-22 21:15:29.036125+00'),
	(144, 56, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:29.0374+00'),
	(145, 56, 3, 11, 'Anticatarrhals that have bitter, demulcent, carminative, hepatic, or astringent properties make useful therapeutic contributions to digestive problems', NULL, '2026-03-22 21:15:29.038828+00'),
	(146, 57, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:29.040289+00'),
	(147, 57, 3, 16, 'Anticatarrhals may be indirectly indicated for the treatment of a range of skin problems because they support the body’s cleansing processes', NULL, '2026-03-22 21:15:29.041571+00'),
	(148, 58, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:29.045083+00'),
	(149, 58, 3, 12, 'In addition to their anticatarrhal properties', NULL, '2026-03-22 21:15:29.048165+00'),
	(150, 59, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:29.053038+00'),
	(151, 59, 3, 11, 'Anticatarrhals that have bitter, demulcent, carminative, hepatic, or astringent properties make useful therapeutic contributions to digestive problems', NULL, '2026-03-22 21:15:29.055983+00'),
	(152, 60, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:29.057827+00'),
	(153, 61, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:29.059374+00'),
	(154, 44, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.060695+00'),
	(155, 62, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.062208+00'),
	(156, 63, 4, 13, 'Many tonics and other specific reproductive remedies will often have anti-inflammatory actions', NULL, '2026-03-22 21:15:29.063465+00'),
	(157, 45, 4, 11, 'Demulcent remedies rich in mucilage, can have the localized effect of reducing inflammation through contact soothing', NULL, '2026-03-22 21:15:29.064655+00'),
	(158, 64, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.065846+00'),
	(159, 65, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.066948+00'),
	(160, 66, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.068003+00'),
	(161, 67, 4, 10, 'For the lower respiratory system, consider', NULL, '2026-03-22 21:15:29.068991+00'),
	(162, 68, 4, 14, 'For hardworking and abused muscles and bones, salicylate-containing remedies come into their own', NULL, '2026-03-22 21:15:29.070004+00'),
	(163, 69, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.070962+00'),
	(164, 70, 4, 16, 'Numerous remedies reduce inflammation on the skin', NULL, '2026-03-22 21:15:29.072132+00'),
	(165, 71, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.073234+00'),
	(166, 72, 4, 13, 'Many tonics and other specific reproductive remedies will often have anti-inflammatory actions', NULL, '2026-03-22 21:15:29.074733+00'),
	(167, 48, 4, 10, 'For the lower respiratory system, consider', NULL, '2026-03-22 21:15:29.075725+00'),
	(168, 49, 4, 10, 'For the lower respiratory system, consider', NULL, '2026-03-22 21:15:29.076908+00'),
	(169, 25, 4, 14, NULL, NULL, '2026-03-22 21:15:29.077925+00'),
	(170, 73, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.079153+00'),
	(171, 74, 4, 11, 'As herbal remedies go directly to the digestive system, they are particularly useful in inflammatory conditions that affect it, from stomach ulcers to colitis and hemorrhoids', NULL, '2026-03-22 21:15:29.080311+00'),
	(172, 74, 4, 14, NULL, NULL, '2026-03-22 21:15:29.081934+00'),
	(173, 75, 4, 14, 'For hardworking and abused muscles and bones, salicylate-containing remedies come into their own,', NULL, '2026-03-22 21:15:29.08319+00'),
	(174, 76, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.084372+00'),
	(175, 28, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.08544+00'),
	(176, 77, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.086435+00'),
	(177, 52, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.087363+00'),
	(178, 78, 4, 10, 'For the lower respiratory system, consider', NULL, '2026-03-22 21:15:29.088347+00'),
	(179, 78, 4, 11, 'As herbal remedies go directly to the digestive system, they are particularly useful in inflammatory conditions that affect it, from stomach ulcers to colitis and hemorrhoids', NULL, '2026-03-22 21:15:29.089417+00'),
	(180, 29, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.090449+00'),
	(181, 79, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.091427+00'),
	(182, 80, 4, 14, NULL, NULL, '2026-03-22 21:15:29.092302+00'),
	(253, 65, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.189647+00'),
	(254, 66, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.192559+00'),
	(255, 22, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.194462+00'),
	(256, 46, 6, NULL, NULL, 'mild', '2026-03-22 21:15:29.196003+00'),
	(183, 30, 4, 11, 'As herbal remedies go directly to the digestive system, they are particularly useful in inflammatory conditions that affect it, from stomach ulcers to colitis and hemorrhoids', NULL, '2026-03-22 21:15:29.09325+00'),
	(184, 30, 4, 16, 'Numerous remedies reduce inflammation on the skin', NULL, '2026-03-22 21:15:29.094651+00'),
	(185, 81, 4, 15, 'While the nervous system often feels as if it needs anti-inflammatories, the best remedies for the “inflamed state of mind” are the relaxing nervines. The only direct anti-inflammatory for nervous system tissue is this, which helps speed the recovery of damaged nerves.', NULL, '2026-03-22 21:15:29.096744+00'),
	(186, 81, 4, 16, 'Numerous remedies reduce inflammation on the skin', NULL, '2026-03-22 21:15:29.098488+00'),
	(187, 53, 4, 10, 'For the lower respiratory system, consider', NULL, '2026-03-22 21:15:29.099495+00'),
	(188, 82, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.100599+00'),
	(189, 83, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.101593+00'),
	(190, 84, 4, 11, 'As herbal remedies go directly to the digestive system, they are particularly useful in inflammatory conditions that affect it, from stomach ulcers to colitis and hemorrhoids', NULL, '2026-03-22 21:15:29.102659+00'),
	(191, 55, 4, 11, 'As herbal remedies go directly to the digestive system, they are particularly useful in inflammatory conditions that affect it, from stomach ulcers to colitis and hemorrhoids', NULL, '2026-03-22 21:15:29.1039+00'),
	(192, 34, 4, 14, NULL, NULL, '2026-03-22 21:15:29.104938+00'),
	(193, 85, 4, 16, 'Numerous remedies reduce inflammation on the skin', NULL, '2026-03-22 21:15:29.105943+00'),
	(194, 86, 4, 14, 'For hardworking and abused muscles and bones, salicylate-containing remedies come into their own,', NULL, '2026-03-22 21:15:29.106977+00'),
	(195, 87, 4, 14, 'For hardworking and abused muscles and bones, salicylate-containing remedies come into their own', NULL, '2026-03-22 21:15:29.10788+00'),
	(196, 56, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.108854+00'),
	(197, 57, 4, 10, 'For the upper respiratory system, consider', NULL, '2026-03-22 21:15:29.109784+00'),
	(198, 58, 4, 10, 'For the upper respiratory system, consider', NULL, '2026-03-22 21:15:29.110935+00'),
	(199, 58, 4, 12, 'A number of herbs soothe the tissue of the urinary tract directly as their anti-inflammatory constituents pass through the kidneys and bladder. Plants that soothe the tissue and fight infection will also have an anti-inflammatory action', NULL, '2026-03-22 21:15:29.111797+00'),
	(200, 88, 4, 16, 'Numerous remedies reduce inflammation on the skin', NULL, '2026-03-22 21:15:29.112856+00'),
	(201, 89, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.113949+00'),
	(202, 90, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.115089+00'),
	(203, 91, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.11612+00'),
	(204, 60, 4, 10, 'For the lower respiratory system, consider', NULL, '2026-03-22 21:15:29.117083+00'),
	(205, 92, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.118107+00'),
	(206, 61, 4, 10, 'For the lower respiratory system, consider', NULL, '2026-03-22 21:15:29.119096+00'),
	(207, 93, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.120073+00'),
	(208, 94, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.121258+00'),
	(209, 95, 4, 12, 'A number of herbs soothe the tissue of the urinary tract directly as their anti-inflammatory constituents pass through the kidneys and bladder. Plants that soothe the tissue and fight infection will also have an anti-inflammatory action', NULL, '2026-03-22 21:15:29.122296+00'),
	(210, 44, 5, 9, 'mong antimicrobial herbs, Allium sativum and Achillea millefolium have a reputation as tonics for this system.', NULL, '2026-03-22 21:15:29.123232+00'),
	(211, 44, 5, 12, 'Be aware that if there is any suggestion of kidney disease, some of the urinary antimicrobial remedies can be too strong', NULL, '2026-03-22 21:15:29.124332+00'),
	(212, 21, 5, 9, 'among antimicrobial herbs, Allium sativum and Achillea millefolium have a reputation as tonics for this system. Allium sativum is especially appropriate because of its broad value for the cardiovascular system in general.', NULL, '2026-03-22 21:15:29.125387+00'),
	(213, 21, 5, 11, 'Many volatile oil–containing herbs and some digestive bitters have an antimicrobial effect in the intestines.', NULL, '2026-03-22 21:15:29.126407+00'),
	(214, 21, 5, 13, 'as well as urinary antimicrobials', NULL, '2026-03-22 21:15:29.127742+00'),
	(215, 21, 5, 16, 'Many antimicrobial herbs can be used on the skin. A wash of this can be most effective', NULL, '2026-03-22 21:15:29.129193+00'),
	(216, 46, 5, 12, 'Be aware that if there is any suggestion of kidney disease, some of the urinary antimicrobial remedies can be too strong', NULL, '2026-03-22 21:15:29.130145+00'),
	(217, 96, 5, 13, 'as well as urinary antimicrobials', NULL, '2026-03-22 21:15:29.131126+00'),
	(218, 97, 5, 11, 'Many volatile oil–containing herbs and some digestive bitters have an antimicrobial effect in the intestines', NULL, '2026-03-22 21:15:29.132317+00'),
	(219, 23, 5, 10, NULL, NULL, '2026-03-22 21:15:29.133502+00'),
	(220, 23, 5, 14, 'provides a good basis for treatment', NULL, '2026-03-22 21:15:29.134542+00'),
	(221, 70, 5, 11, 'Many volatile oil–containing herbs and some digestive bitters have an antimicrobial effect in the intestines', 'mild', '2026-03-22 21:15:29.135511+00'),
	(222, 47, 5, NULL, NULL, NULL, '2026-03-22 21:15:29.136459+00'),
	(223, 98, 5, NULL, NULL, 'mild', '2026-03-22 21:15:29.137431+00'),
	(224, 99, 5, 10, NULL, NULL, '2026-03-22 21:15:29.13846+00'),
	(225, 99, 5, 11, 'Many volatile oil–containing herbs and some digestive bitters have an antimicrobial effect in the intestines', NULL, '2026-03-22 21:15:29.139457+00'),
	(226, 99, 5, 16, 'is one of the strongest external remedies', NULL, '2026-03-22 21:15:29.140455+00'),
	(227, 100, 5, NULL, NULL, 'mild', '2026-03-22 21:15:29.141573+00'),
	(228, 26, 5, 10, NULL, NULL, '2026-03-22 21:15:29.142572+00'),
	(229, 26, 5, 11, 'Many volatile oil–containing herbs and some digestive bitters have an antimicrobial effect in the intestines.', NULL, '2026-03-22 21:15:29.143566+00'),
	(230, 26, 5, 13, 'as well as urinary antimicrobials', NULL, '2026-03-22 21:15:29.144535+00'),
	(231, 26, 5, 14, 'provides a good basis for treatment', NULL, '2026-03-22 21:15:29.145518+00'),
	(232, 101, 5, 12, 'Be aware that if there is any suggestion of kidney disease, some of the urinary antimicrobial remedies can be too strong', NULL, '2026-03-22 21:15:29.146496+00'),
	(233, 102, 5, 11, 'Many volatile oil–containing herbs and some digestive bitters have an antimicrobial effect in the intestines', 'mild', '2026-03-22 21:15:29.147832+00'),
	(234, 30, 5, 11, 'Many volatile oil–containing herbs and some digestive bitters have an antimicrobial effect in the intestines', NULL, '2026-03-22 21:15:29.148825+00'),
	(235, 81, 5, 15, 'in combination with nervines and other antimicrobial herbs, will help with the intransigent infections that can affect the nervous system', NULL, '2026-03-22 21:15:29.149833+00'),
	(236, 54, 5, 10, NULL, NULL, '2026-03-22 21:15:29.153633+00'),
	(237, 103, 5, 12, 'Be aware that if there is any suggestion of kidney disease, some of the urinary antimicrobial remedies can be too strong', NULL, '2026-03-22 21:15:29.156327+00'),
	(238, 104, 5, 10, NULL, NULL, '2026-03-22 21:15:29.15918+00'),
	(239, 55, 5, NULL, NULL, NULL, '2026-03-22 21:15:29.16144+00'),
	(240, 105, 5, 10, NULL, NULL, '2026-03-22 21:15:29.16387+00'),
	(241, 106, 5, NULL, NULL, 'mild', '2026-03-22 21:15:29.165719+00'),
	(242, 107, 5, 16, 'Many antimicrobial herbs can be used on the skin. A wash of this can be most effective', 'mild', '2026-03-22 21:15:29.167329+00'),
	(243, 108, 5, 10, NULL, 'mild', '2026-03-22 21:15:29.169085+00'),
	(244, 85, 5, NULL, NULL, 'mild', '2026-03-22 21:15:29.170565+00'),
	(245, 109, 5, 16, 'Many antimicrobial herbs can be used on the skin. A wash of this can be most effective', NULL, '2026-03-22 21:15:29.174061+00'),
	(246, 110, 5, NULL, NULL, NULL, '2026-03-22 21:15:29.175914+00'),
	(247, 56, 5, 11, 'Many volatile oil–containing herbs and some digestive bitters have an antimicrobial effect in the intestines', NULL, '2026-03-22 21:15:29.1778+00'),
	(248, 111, 5, 10, NULL, 'mild', '2026-03-22 21:15:29.179748+00'),
	(249, 59, 5, 10, NULL, NULL, '2026-03-22 21:15:29.181912+00'),
	(250, 59, 5, 16, 'Many antimicrobial herbs can be used on the skin. A wash of this can be most effective', NULL, '2026-03-22 21:15:29.184202+00'),
	(251, 112, 5, NULL, NULL, NULL, '2026-03-22 21:15:29.185996+00'),
	(252, 44, 6, NULL, NULL, 'mild', '2026-03-22 21:15:29.187818+00'),
	(258, 114, 6, NULL, NULL, 'mild', '2026-03-22 21:15:29.199057+00'),
	(259, 97, 6, NULL, NULL, 'mild', '2026-03-22 21:15:29.202174+00'),
	(260, 115, 6, NULL, NULL, 'mild', '2026-03-22 21:15:29.205828+00'),
	(261, 68, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.20961+00'),
	(262, 116, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.211365+00'),
	(263, 47, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.213296+00'),
	(264, 72, 6, NULL, NULL, 'mild', '2026-03-22 21:15:29.215109+00'),
	(265, 25, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.218953+00'),
	(266, 74, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.221434+00'),
	(267, 50, 6, NULL, NULL, 'mild', '2026-03-22 21:15:29.223684+00'),
	(268, 117, 6, NULL, NULL, 'mild', '2026-03-22 21:15:29.225511+00'),
	(269, 75, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.227412+00'),
	(270, 118, 6, NULL, NULL, 'mild', '2026-03-22 21:15:29.229265+00'),
	(271, 77, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.231514+00'),
	(272, 29, 6, NULL, NULL, 'strong', '2026-03-22 21:15:29.235441+00'),
	(273, 80, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.237676+00'),
	(274, 31, 6, NULL, NULL, 'strong', '2026-03-22 21:15:29.239716+00'),
	(275, 103, 6, NULL, NULL, 'strong', '2026-03-22 21:15:29.242314+00'),
	(276, 33, 6, NULL, NULL, 'mild', '2026-03-22 21:15:29.248401+00'),
	(277, 34, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.250894+00'),
	(278, 119, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.252726+00'),
	(279, 120, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.254443+00'),
	(280, 35, 6, NULL, NULL, 'strong', '2026-03-22 21:15:29.256168+00'),
	(281, 86, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.257898+00'),
	(282, 109, 6, NULL, NULL, 'mild', '2026-03-22 21:15:29.259745+00'),
	(283, 37, 6, NULL, NULL, 'mild', '2026-03-22 21:15:29.261824+00'),
	(284, 87, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.263768+00'),
	(285, 40, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.26858+00'),
	(286, 121, 6, NULL, NULL, 'strong', '2026-03-22 21:15:29.272113+00'),
	(287, 122, 6, NULL, NULL, 'mild', '2026-03-22 21:15:29.274829+00'),
	(288, 43, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.278215+00'),
	(289, 93, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.281557+00'),
	(290, 123, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.28526+00'),
	(291, 124, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.287698+00'),
	(292, 64, 7, 11, 'All of the carminative herbs tend to act as antispasmodics in the gut, and hepatics can have such an action for gallbladder conditions.', 'mild', '2026-03-22 21:15:29.289876+00'),
	(293, 65, 7, NULL, NULL, 'mild', '2026-03-22 21:15:29.292819+00'),
	(294, 66, 7, NULL, NULL, NULL, '2026-03-22 21:15:29.295503+00'),
	(295, 115, 7, NULL, NULL, NULL, '2026-03-22 21:15:29.297537+00'),
	(296, 98, 7, NULL, NULL, 'mild', '2026-03-22 21:15:29.299662+00'),
	(297, 25, 7, 9, NULL, 'strong', '2026-03-22 21:15:29.301974+00'),
	(298, 125, 7, 12, NULL, 'mild', '2026-03-22 21:15:29.303866+00'),
	(299, 74, 7, 11, 'All of the carminative herbs tend to act as antispasmodics in the gut, and hepatics can have such an action for gallbladder conditions.', 'strong', '2026-03-22 21:15:29.305858+00'),
	(300, 126, 7, NULL, NULL, 'strong', '2026-03-22 21:15:29.307974+00'),
	(301, 127, 7, NULL, NULL, 'mild', '2026-03-22 21:15:29.309614+00'),
	(302, 128, 7, NULL, NULL, 'strong', '2026-03-22 21:15:29.311325+00'),
	(303, 76, 7, 11, 'All of the carminative herbs tend to act as antispasmodics in the gut, and hepatics can have such an action for gallbladder conditions.', 'mild', '2026-03-22 21:15:29.313774+00'),
	(304, 78, 7, NULL, NULL, 'mild', '2026-03-22 21:15:29.316223+00'),
	(305, 129, 7, 11, 'All of the carminative herbs tend to act as antispasmodics in the gut, and hepatics can have such an action for gallbladder conditions.', 'strong', '2026-03-22 21:15:29.317859+00'),
	(306, 81, 7, NULL, NULL, NULL, '2026-03-22 21:15:29.319257+00'),
	(307, 53, 7, NULL, NULL, NULL, '2026-03-22 21:15:29.321021+00'),
	(308, 130, 7, 10, 'A range of antispasmodics are useful in the respiratory system', 'strong', '2026-03-22 21:15:29.322839+00'),
	(309, 82, 7, 9, NULL, NULL, '2026-03-22 21:15:29.324273+00'),
	(310, 131, 7, 9, NULL, 'strong', '2026-03-22 21:15:29.325675+00'),
	(311, 132, 7, 10, 'A range of antispasmodics are useful in the respiratory system', 'strong', '2026-03-22 21:15:29.326946+00'),
	(312, 132, 7, 14, 'Externally, Lobelia inflata can be helpful.', 'strong', '2026-03-22 21:15:29.328248+00'),
	(313, 133, 7, NULL, NULL, NULL, '2026-03-22 21:15:29.329568+00'),
	(314, 84, 7, 11, 'All of the carminative herbs tend to act as antispasmodics in the gut, and hepatics can have such an action for gallbladder conditions.', NULL, '2026-03-22 21:15:29.330695+00'),
	(315, 134, 7, 9, NULL, NULL, '2026-03-22 21:15:29.331895+00'),
	(316, 55, 7, 11, 'All of the carminative herbs tend to act as antispasmodics in the gut, and hepatics can have such an action for gallbladder conditions.', 'mild', '2026-03-22 21:15:29.333944+00'),
	(317, 135, 7, NULL, NULL, 'mild', '2026-03-22 21:15:29.33557+00'),
	(318, 136, 7, NULL, NULL, NULL, '2026-03-22 21:15:29.337154+00'),
	(319, 137, 7, NULL, NULL, NULL, '2026-03-22 21:15:29.338604+00'),
	(320, 120, 7, NULL, NULL, 'mild', '2026-03-22 21:15:29.340183+00'),
	(321, 108, 7, 10, 'A range of antispasmodics are useful in the respiratory system', 'mild', '2026-03-22 21:15:29.34157+00'),
	(322, 138, 7, 14, 'Primary muscle relaxant remedies', 'strong', '2026-03-22 21:15:29.342972+00'),
	(323, 139, 7, NULL, NULL, 'strong', '2026-03-22 21:15:29.34463+00'),
	(324, 140, 7, 10, 'A range of antispasmodics are useful in the respiratory system', 'strong', '2026-03-22 21:15:29.348706+00'),
	(325, 109, 7, NULL, NULL, 'mild', '2026-03-22 21:15:29.350667+00'),
	(326, 141, 7, NULL, NULL, NULL, '2026-03-22 21:15:29.352646+00'),
	(327, 57, 7, NULL, NULL, 'mild', '2026-03-22 21:15:29.354528+00'),
	(328, 142, 7, 13, 'The nervine antispasmodics, such as Valeriana officinalis and Scutellaria lateriflora, are also helpful.', 'strong', '2026-03-22 21:15:29.358041+00'),
	(329, 142, 7, 14, 'Primary muscle relaxant remedies', 'strong', '2026-03-22 21:15:29.360972+00'),
	(330, 143, 7, NULL, NULL, 'strong', '2026-03-22 21:15:29.363151+00'),
	(331, 121, 7, NULL, NULL, NULL, '2026-03-22 21:15:29.365012+00'),
	(332, 59, 7, 11, 'All of the carminative herbs tend to act as antispasmodics in the gut, and hepatics can have such an action for gallbladder conditions.', 'strong', '2026-03-22 21:15:29.366665+00'),
	(333, 90, 7, NULL, NULL, NULL, '2026-03-22 21:15:29.368414+00'),
	(334, 42, 7, NULL, NULL, NULL, '2026-03-22 21:15:29.37005+00'),
	(335, 91, 7, NULL, NULL, 'mild', '2026-03-22 21:15:29.372129+00'),
	(336, 144, 7, NULL, NULL, NULL, '2026-03-22 21:15:29.37418+00'),
	(337, 60, 7, NULL, NULL, NULL, '2026-03-22 21:15:29.375759+00'),
	(338, 145, 7, 9, NULL, 'strong', '2026-03-22 21:15:29.377305+00'),
	(339, 145, 7, 11, 'All of the carminative herbs tend to act as antispasmodics in the gut, and hepatics can have such an action for gallbladder conditions.', 'strong', '2026-03-22 21:15:29.379061+00'),
	(340, 145, 7, 13, 'The nervine antispasmodics, such as Valeriana officinalis and Scutellaria lateriflora, are also helpful.', 'strong', '2026-03-22 21:15:29.380855+00'),
	(341, 145, 7, 14, 'Primary muscle relaxant remedies', 'strong', '2026-03-22 21:15:29.382702+00'),
	(342, 61, 7, NULL, NULL, 'mild', '2026-03-22 21:15:29.384575+00'),
	(343, 146, 7, NULL, NULL, 'strong', '2026-03-22 21:15:29.386039+00'),
	(344, 93, 7, 9, NULL, 'strong', '2026-03-22 21:15:29.387672+00'),
	(345, 93, 7, 11, 'All of the carminative herbs tend to act as antispasmodics in the gut, and hepatics can have such an action for gallbladder conditions.', 'strong', '2026-03-22 21:15:29.389166+00'),
	(346, 93, 7, 12, NULL, 'strong', '2026-03-22 21:15:29.391002+00'),
	(347, 93, 7, 13, 'Here, Viburnum opulus and Viburnum prunifolium come into their own', 'strong', '2026-03-22 21:15:29.394457+00'),
	(348, 93, 7, 14, 'Primary muscle relaxant remedies', 'strong', '2026-03-22 21:15:29.396112+00'),
	(349, 94, 7, 11, 'All of the carminative herbs tend to act as antispasmodics in the gut, and hepatics can have such an action for gallbladder conditions.', 'strong', '2026-03-22 21:15:29.397864+00'),
	(350, 94, 7, 12, NULL, 'strong', '2026-03-22 21:15:29.399254+00'),
	(351, 94, 7, 13, 'Here, Viburnum opulus and Viburnum prunifolium come into their own', 'strong', '2026-03-22 21:15:29.401108+00'),
	(352, 94, 7, 14, 'Primary muscle relaxant remedies', 'strong', '2026-03-22 21:15:29.403779+00'),
	(353, 124, 7, NULL, NULL, NULL, '2026-03-22 21:15:29.405706+00'),
	(354, 147, 8, 11, NULL, 'strong', '2026-03-22 21:15:29.407388+00'),
	(355, 44, 8, 9, 'Astringents are rarely needed internally for this system, although they are used externally for bruises that can be seen under the skin. However, certain cardiovascular remedies are also astringents, including this', NULL, '2026-03-22 21:15:29.409072+00'),
	(356, 44, 8, 10, 'The anticatarrhal remedies often also have astringent properties.', NULL, '2026-03-22 21:15:29.411793+00'),
	(357, 44, 8, 12, NULL, NULL, '2026-03-22 21:15:29.413511+00'),
	(358, 44, 8, 16, 'Of the many external astringents, or styptics, an example is this', NULL, '2026-03-22 21:15:29.415664+00'),
	(425, 162, 10, 9, 'The primary cardiotonic herbs to consider, possibly this.', NULL, '2026-03-22 21:15:29.510833+00'),
	(359, 62, 8, 9, 'Astringents are rarely needed internally for this system, although they are used externally for bruises that can be seen under the skin. However, certain cardiovascular remedies are also astringents, including this', NULL, '2026-03-22 21:15:29.417141+00'),
	(360, 148, 8, 11, NULL, 'strong', '2026-03-22 21:15:29.418826+00'),
	(361, 46, 8, NULL, NULL, 'mild', '2026-03-22 21:15:29.420405+00'),
	(362, 149, 8, NULL, NULL, NULL, '2026-03-22 21:15:29.421848+00'),
	(363, 71, 8, 10, 'The anticatarrhal remedies often also have astringent properties.', NULL, '2026-03-22 21:15:29.427068+00'),
	(364, 71, 8, 11, NULL, NULL, '2026-03-22 21:15:29.429277+00'),
	(365, 71, 8, 16, 'Of the many external astringents, or styptics, an example is this', NULL, '2026-03-22 21:15:29.430709+00'),
	(366, 150, 8, NULL, NULL, 'strong', '2026-03-22 21:15:29.432417+00'),
	(367, 151, 8, 12, NULL, NULL, '2026-03-22 21:15:29.434196+00'),
	(368, 151, 8, 16, 'Of the many external astringents, or styptics, an example is this', NULL, '2026-03-22 21:15:29.435895+00'),
	(369, 51, 8, 10, 'The anticatarrhal remedies often also have astringent properties.', NULL, '2026-03-22 21:15:29.43726+00'),
	(370, 75, 8, 11, NULL, NULL, '2026-03-22 21:15:29.438577+00'),
	(371, 52, 8, 11, NULL, NULL, '2026-03-22 21:15:29.439854+00'),
	(372, 52, 8, 13, NULL, NULL, '2026-03-22 21:15:29.441496+00'),
	(373, 79, 8, 11, NULL, 'strong', '2026-03-22 21:15:29.442937+00'),
	(374, 79, 8, 16, 'Of the many external astringents, or styptics, an example is this', 'strong', '2026-03-22 21:15:29.44424+00'),
	(375, 54, 8, NULL, NULL, NULL, '2026-03-22 21:15:29.445677+00'),
	(376, 133, 8, NULL, NULL, 'mild', '2026-03-22 21:15:29.447031+00'),
	(377, 119, 8, NULL, NULL, 'strong', '2026-03-22 21:15:29.448248+00'),
	(378, 85, 8, 10, 'The anticatarrhal remedies often also have astringent properties.', 'mild', '2026-03-22 21:15:29.449539+00'),
	(379, 85, 8, 16, 'Of the many external astringents, or styptics, an example is this', 'mild', '2026-03-22 21:15:29.450744+00'),
	(380, 152, 8, 11, NULL, 'strong', '2026-03-22 21:15:29.451954+00'),
	(381, 140, 8, NULL, NULL, NULL, '2026-03-22 21:15:29.453132+00'),
	(382, 153, 8, 11, NULL, 'strong', '2026-03-22 21:15:29.454341+00'),
	(383, 153, 8, 16, 'Of the many external astringents, or styptics, an example is this', 'strong', '2026-03-22 21:15:29.455595+00'),
	(384, 154, 8, NULL, NULL, NULL, '2026-03-22 21:15:29.456904+00'),
	(385, 109, 8, NULL, NULL, 'mild', '2026-03-22 21:15:29.458151+00'),
	(386, 155, 8, NULL, NULL, NULL, '2026-03-22 21:15:29.459441+00'),
	(387, 156, 8, NULL, NULL, 'strong', '2026-03-22 21:15:29.460679+00'),
	(388, 56, 8, 11, NULL, 'mild', '2026-03-22 21:15:29.462034+00'),
	(389, 58, 8, NULL, NULL, 'mild', '2026-03-22 21:15:29.463579+00'),
	(390, 89, 8, 11, NULL, 'mild', '2026-03-22 21:15:29.46482+00'),
	(391, 61, 8, NULL, NULL, 'mild', '2026-03-22 21:15:29.466167+00'),
	(392, 157, 8, 13, NULL, 'strong', '2026-03-22 21:15:29.467506+00'),
	(393, 44, 9, 13, 'Many bitter herbs have the ability to initiate delayed menstrual periods. They may, however, cause some cramping, and must not be used during pregnancy. To a lesser degree, this, because of its mildness', 'mild', '2026-03-22 21:15:29.468829+00'),
	(394, 96, 9, 13, 'Many bitter herbs have the ability to initiate delayed menstrual periods. They may, however, cause some cramping, and must not be used during pregnancy', 'mild', '2026-03-22 21:15:29.470053+00'),
	(395, 97, 9, 11, 'takes into account the liver and pancreas as organs of the digestive system', 'strong', '2026-03-22 21:15:29.471231+00'),
	(396, 97, 9, 13, 'Many bitter herbs have the ability to initiate delayed menstrual periods. They may, however, cause some cramping, and must not be used during pregnancy', 'strong', '2026-03-22 21:15:29.472415+00'),
	(397, 97, 9, 15, 'By stimulating healthy body processes, bitters support the nervous system in cases of depression and general nervous debility. Any bitter can work, but those most often used are Gentiana lutea, Artemisia vulgaris, and Artemisia absinthium', 'strong', '2026-03-22 21:15:29.473521+00'),
	(398, 115, 9, 11, 'takes into account the liver and pancreas as organs of the digestive system', 'mild', '2026-03-22 21:15:29.474773+00'),
	(399, 115, 9, 13, 'Many bitter herbs have the ability to initiate delayed menstrual periods. They may, however, cause some cramping, and must not be used during pregnancy', 'mild', '2026-03-22 21:15:29.476072+00'),
	(400, 115, 9, 15, 'By stimulating healthy body processes, bitters support the nervous system in cases of depression and general nervous debility. Any bitter can work, but those most often used are Gentiana lutea, Artemisia vulgaris, and Artemisia absinthium', 'mild', '2026-03-22 21:15:29.477372+00'),
	(401, 158, 9, 11, 'takes into account the liver and pancreas as organs of the digestive system', 'strong', '2026-03-22 21:15:29.478603+00'),
	(402, 159, 9, 11, 'takes into account the liver and pancreas as organs of the digestive system', 'strong', '2026-03-22 21:15:29.479879+00'),
	(403, 50, 9, NULL, NULL, 'strong', '2026-03-22 21:15:29.481093+00'),
	(404, 102, 9, 11, 'takes into account the liver and pancreas as organs of the digestive system', 'strong', '2026-03-22 21:15:29.482419+00'),
	(405, 102, 9, 15, 'By stimulating healthy body processes, bitters support the nervous system in cases of depression and general nervous debility. Any bitter can work, but those most often used are Gentiana lutea, Artemisia vulgaris, and Artemisia absinthium', 'strong', '2026-03-22 21:15:29.483818+00'),
	(406, 30, 9, 11, 'takes into account the liver and pancreas as organs of the digestive system', 'strong', '2026-03-22 21:15:29.485351+00'),
	(407, 160, 9, 10, 'Certain bitters have expectorant actions, and in the case of Marrubium vulgare, we have an excellent remedy for all chest problems combined with the value of a potent bitter', 'strong', '2026-03-22 21:15:29.486919+00'),
	(408, 84, 9, NULL, NULL, 'mild', '2026-03-22 21:15:29.488182+00'),
	(409, 34, 9, 14, 'Anything that helps with digestion and assimilation of food will benefit the musculoskeletal system. A bitter that is particularly valuable for this system is Menyanthes trifoliata', NULL, '2026-03-22 21:15:29.489522+00'),
	(410, 110, 9, 11, 'takes into account the liver and pancreas as organs of the digestive system', 'strong', '2026-03-22 21:15:29.490692+00'),
	(411, 110, 9, 13, 'Many bitter herbs have the ability to initiate delayed menstrual periods. They may, however, cause some cramping, and must not be used during pregnancy', 'strong', '2026-03-22 21:15:29.492108+00'),
	(412, 161, 9, NULL, NULL, 'strong', '2026-03-22 21:15:29.493362+00'),
	(413, 122, 9, NULL, NULL, 'mild', '2026-03-22 21:15:29.494772+00'),
	(414, 44, 10, 9, 'Remedies that specifically benefit blood vessels', NULL, '2026-03-22 21:15:29.496021+00'),
	(415, 44, 10, 11, NULL, NULL, '2026-03-22 21:15:29.497389+00'),
	(416, 44, 10, 12, 'Most of the herbs that have a direct impact on the heart’s action also increase the amount of blood that passes through the kidneys, and so act as diuretics. Achillea millefolium is used in urinary problems, as is Cytisus scoparius. Any cardioactive properties must be taken into account, especially with Cytisus scoparius.', NULL, '2026-03-22 21:15:29.498664+00'),
	(417, 44, 10, 13, 'The cardiac tonics are not directly involved in the function of this system. Achillea millefolium may play a role as a gentle emmenagogue.', NULL, '2026-03-22 21:15:29.499993+00'),
	(418, 44, 10, 16, 'when a skin problem is related to varicosity in veins, cardiac tonics are very important', NULL, '2026-03-22 21:15:29.50151+00'),
	(419, 62, 10, 9, 'Remedies that specifically benefit blood vessels', NULL, '2026-03-22 21:15:29.502963+00'),
	(420, 62, 10, 16, 'when a skin problem is related to varicosity in veins, cardiac tonics are very important', NULL, '2026-03-22 21:15:29.504324+00'),
	(421, 21, 10, 9, 'Remedies that specifically benefit blood vessels', NULL, '2026-03-22 21:15:29.505629+00'),
	(422, 21, 10, 10, 'Any problem with the activity of the heart might have an effect on lung congestion due to a backup of blood waiting to be pumped. Thus, cardiac tonics may benefit the lungs by helping the heart. This is renowned for its antimicrobial and generally beneficial action on the lungs.', NULL, '2026-03-22 21:15:29.506971+00'),
	(423, 21, 10, 11, NULL, NULL, '2026-03-22 21:15:29.50825+00'),
	(424, 47, 10, 14, 'Herbs that act as circulatory stimulants are important here because they increase peripheral blood flow. This can reduce swelling and ease stiffness', NULL, '2026-03-22 21:15:29.509585+00'),
	(570, 125, 14, 12, NULL, 'strong', '2026-03-22 21:15:29.820719+00'),
	(426, 163, 10, 9, 'Primarily cardioactive remedies include Convallaria majalis and Digitalis lanata. Must be used with caution in order to avoid toxicity problems in heart patients.', NULL, '2026-03-22 21:15:29.512078+00'),
	(427, 73, 10, 9, 'The primary cardiotonic herbs to consider', NULL, '2026-03-22 21:15:29.513366+00'),
	(429, 73, 10, 16, 'when a skin problem is related to varicosity in veins, cardiac tonics are very important', NULL, '2026-03-22 21:15:29.518104+00'),
	(430, 164, 10, 9, 'Other plants that mimic this cardioactive effect but do not contain cardiac glycosides. Must still be used with caution in order to avoid toxicity problems in heart patients.', NULL, '2026-03-22 21:15:29.519549+00'),
	(431, 164, 10, 12, 'Most of the herbs that have a direct impact on the heart’s action also increase the amount of blood that passes through the kidneys, and so act as diuretics. Achillea millefolium is used in urinary problems, as is Cytisus scoparius. Any cardioactive properties must be taken into account, especially with Cytisus scoparius.', NULL, '2026-03-22 21:15:29.521201+00'),
	(432, 165, 10, 9, 'Remedies that specifically benefit blood vessels', NULL, '2026-03-22 21:15:29.522859+00'),
	(433, 131, 10, 11, NULL, NULL, '2026-03-22 21:15:29.524138+00'),
	(434, 131, 10, 15, 'Has a relaxing effect on the nervous system. Many nervines help the circulatory system by relaxing the mind and body as a whole', NULL, '2026-03-22 21:15:29.525613+00'),
	(435, 133, 10, 9, 'Other plants that mimic this cardioactive effect but do not contain cardiac glycosides. Must still be used with caution in order to avoid toxicity problems in heart patients.', NULL, '2026-03-22 21:15:29.527153+00'),
	(436, 134, 10, 11, NULL, NULL, '2026-03-22 21:15:29.528604+00'),
	(437, 134, 10, 15, 'Has a relaxing effect on the nervous system. Many nervines help the circulatory system by relaxing the mind and body as a whole', NULL, '2026-03-22 21:15:29.529969+00'),
	(438, 109, 10, 11, NULL, NULL, '2026-03-22 21:15:29.531134+00'),
	(439, 109, 10, 15, 'Has a relaxing effect on the nervous system. Many nervines help the circulatory system by relaxing the mind and body as a whole', NULL, '2026-03-22 21:15:29.532418+00'),
	(440, 39, 10, 9, 'Other plants that mimic this cardioactive effect but do not contain cardiac glycosides. Must still be used with caution in order to avoid toxicity problems in heart patients.', NULL, '2026-03-22 21:15:29.533992+00'),
	(441, 39, 10, 16, 'The only directly applicable remedy here', NULL, '2026-03-22 21:15:29.535597+00'),
	(442, 90, 10, 9, 'The primary cardiotonic herbs to consider', NULL, '2026-03-22 21:15:29.605311+00'),
	(444, 90, 10, 11, NULL, NULL, '2026-03-22 21:15:29.609257+00'),
	(445, 90, 10, 15, 'Has a relaxing effect on the nervous system. Many nervines help the circulatory system by relaxing the mind and body as a whole', NULL, '2026-03-22 21:15:29.611231+00'),
	(446, 90, 10, 16, 'when a skin problem is related to varicosity in veins, cardiac tonics are very important', NULL, '2026-03-22 21:15:29.612793+00'),
	(447, 166, 10, 9, 'Other plants that mimic this cardioactive effect but do not contain cardiac glycosides. Must still be used with caution in order to avoid toxicity problems in heart patients.', NULL, '2026-03-22 21:15:29.614238+00'),
	(448, 123, 10, 14, 'Herbs that act as circulatory stimulants are important here because they increase peripheral blood flow. This can reduce swelling and ease stiffness', NULL, '2026-03-22 21:15:29.615763+00'),
	(449, 124, 10, 14, 'Herbs that act as circulatory stimulants are important here because they increase peripheral blood flow. This can reduce swelling and ease stiffness', NULL, '2026-03-22 21:15:29.618071+00'),
	(450, 21, 11, 9, 'Carminatives may ease apparent cardiac symptoms by eliminating the pressure of flatulence and digestive pain. While most of the carminatives have no action on this system at all, volatile oils of this herb does have cardiovascular effects', NULL, '2026-03-22 21:15:29.621595+00'),
	(451, 21, 11, 10, 'Many carminative herbs support this system through antispasmodic, antimicrobial, or anticatarrhal actions', NULL, '2026-03-22 21:15:29.626015+00'),
	(452, 21, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.627914+00'),
	(453, 64, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.629565+00'),
	(454, 65, 11, 10, 'Many carminative herbs support this system through antispasmodic, antimicrobial, or anticatarrhal actions', NULL, '2026-03-22 21:15:29.631889+00'),
	(455, 65, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.634011+00'),
	(456, 65, 11, 14, 'a carminative that is also a specific anti-inflammatory for this system', NULL, '2026-03-22 21:15:29.636329+00'),
	(457, 66, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.638189+00'),
	(458, 66, 11, 14, 'a carminative that is also a specific anti-inflammatory for this system', NULL, '2026-03-22 21:15:29.640253+00'),
	(459, 97, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.642313+00'),
	(460, 98, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.644194+00'),
	(461, 167, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.646449+00'),
	(462, 127, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.648388+00'),
	(463, 168, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.650467+00'),
	(464, 76, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.652017+00'),
	(465, 77, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.653979+00'),
	(466, 77, 11, 14, 'a carminative that is also a specific anti-inflammatory for this system', NULL, '2026-03-22 21:15:29.655526+00'),
	(467, 129, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.657154+00'),
	(468, 129, 11, 15, 'Many volatile oil–containing remedies will soothe the nervous system', NULL, '2026-03-22 21:15:29.659518+00'),
	(469, 103, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.662077+00'),
	(571, 151, 14, 12, NULL, NULL, '2026-03-22 21:15:29.82212+00'),
	(572, 184, 14, 12, NULL, 'strong', '2026-03-22 21:15:29.823527+00'),
	(470, 103, 11, 12, 'Because of their volatile oil content, some carminatives act as diuretics and may even irritate the kidneys', NULL, '2026-03-22 21:15:29.664054+00'),
	(471, 131, 11, 9, 'Carminatives may ease apparent cardiac symptoms by eliminating the pressure of flatulence and digestive pain. While most of the carminatives have no action on this system at all, volatile oils of this herb does have cardiovascular effects', NULL, '2026-03-22 21:15:29.667802+00'),
	(472, 131, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.672672+00'),
	(473, 84, 11, 9, 'Carminatives may ease apparent cardiac symptoms by eliminating the pressure of flatulence and digestive pain. While most of the carminatives have no action on this system at all, volatile oils of this herb does have cardiovascular effects', NULL, '2026-03-22 21:15:29.674035+00'),
	(474, 84, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.675484+00'),
	(475, 84, 11, 15, 'Many volatile oil–containing remedies will soothe the nervous system', NULL, '2026-03-22 21:15:29.68008+00'),
	(476, 134, 11, 9, 'Carminatives may ease apparent cardiac symptoms by eliminating the pressure of flatulence and digestive pain. While most of the carminatives have no action on this system at all, volatile oils of this herb does have cardiovascular effects', NULL, '2026-03-22 21:15:29.681589+00'),
	(477, 134, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.682981+00'),
	(478, 134, 11, 15, 'Many volatile oil–containing remedies will soothe the nervous system', NULL, '2026-03-22 21:15:29.684305+00'),
	(479, 55, 11, 10, 'Many carminative herbs support this system through antispasmodic, antimicrobial, or anticatarrhal actions', NULL, '2026-03-22 21:15:29.685758+00'),
	(480, 55, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.687041+00'),
	(481, 135, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.688568+00'),
	(482, 120, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.689895+00'),
	(483, 108, 11, 10, 'Many carminative herbs support this system through antispasmodic, antimicrobial, or anticatarrhal actions', NULL, '2026-03-22 21:15:29.691064+00'),
	(484, 108, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.692177+00'),
	(485, 56, 11, 10, 'Many carminative herbs support this system through antispasmodic, antimicrobial, or anticatarrhal actions', NULL, '2026-03-22 21:15:29.693364+00'),
	(486, 56, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.694827+00'),
	(487, 169, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.696243+00'),
	(488, 145, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.69758+00'),
	(489, 145, 11, 15, 'Many volatile oil–containing remedies will soothe the nervous system', NULL, '2026-03-22 21:15:29.698936+00'),
	(490, 124, 11, 9, 'Carminatives may ease apparent cardiac symptoms by eliminating the pressure of flatulence and digestive pain. While most of the carminatives have no action on this system at all, volatile oils of this herb does have cardiovascular effects', NULL, '2026-03-22 21:15:29.700231+00'),
	(491, 124, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.701869+00'),
	(492, 23, 12, 10, 'Certain cholagogues are also antimicrobial and anticatarrhal and in this way benefit the whole system. Some are also mucous membrane tonics, including this', 'strong', '2026-03-22 21:15:29.70329+00'),
	(493, 158, 12, 11, NULL, 'strong', '2026-03-22 21:15:29.704665+00'),
	(494, 158, 12, 13, 'Cholagogue remedies such as Hydrastis canadensis and Berberis vulgaris have a marked action on the muscles of the uterus, as they are strong bitters', 'strong', '2026-03-22 21:15:29.705989+00'),
	(495, 170, 12, 11, NULL, 'strong', '2026-03-22 21:15:29.707282+00'),
	(496, 171, 12, NULL, NULL, 'mild', '2026-03-22 21:15:29.708967+00'),
	(497, 24, 12, 11, 'the bark', 'mild', '2026-03-22 21:15:29.710327+00'),
	(498, 172, 12, 11, NULL, 'mild', '2026-03-22 21:15:29.711626+00'),
	(499, 74, 12, 11, NULL, 'mild', '2026-03-22 21:15:29.712825+00'),
	(500, 173, 12, 11, NULL, 'mild', '2026-03-22 21:15:29.713979+00'),
	(501, 50, 12, 10, 'Certain cholagogues are also antimicrobial and anticatarrhal and in this way benefit the whole system. Some are also mucous membrane tonics, including this', 'mild', '2026-03-22 21:15:29.71524+00'),
	(502, 50, 12, 12, 'can be an effective diuretic in feverish conditions', 'mild', '2026-03-22 21:15:29.71655+00'),
	(503, 27, 12, 16, 'Taken internally, cholagogues often aid in cleansing the body and so may help clear skin problems. Examples are Iris versicolor, Taraxacum officinale, Fumaria officinalis, Hydrastis canadensis, Mahonia aquifolium, and Rumex crispus.', 'mild', '2026-03-22 21:15:29.717783+00'),
	(504, 102, 12, 11, NULL, 'strong', '2026-03-22 21:15:29.719032+00'),
	(505, 30, 12, 10, 'Certain cholagogues are also antimicrobial and anticatarrhal and in this way benefit the whole system. Some are also mucous membrane tonics, including this', 'strong', '2026-03-22 21:15:29.720201+00'),
	(506, 30, 12, 13, 'Cholagogue remedies such as Hydrastis canadensis and Berberis vulgaris have a marked action on the muscles of the uterus, as they are strong bitters', 'strong', '2026-03-22 21:15:29.721549+00'),
	(507, 30, 12, 16, 'may also be of use externally', 'strong', '2026-03-22 21:15:29.722972+00'),
	(514, 31, 12, 11, NULL, 'strong', '2026-03-22 21:15:29.732152+00'),
	(515, 31, 12, 16, 'Taken internally, cholagogues often aid in cleansing the body and so may help clear skin problems. Examples are Iris versicolor, Taraxacum officinale, Fumaria officinalis, Hydrastis canadensis, Mahonia aquifolium, and Rumex crispus.', 'strong', '2026-03-22 21:15:29.733676+00'),
	(516, 174, 12, 11, NULL, 'strong', '2026-03-22 21:15:29.735177+00'),
	(517, 175, 12, 11, NULL, 'mild', '2026-03-22 21:15:29.736462+00'),
	(518, 33, 12, 16, 'Taken internally, cholagogues often aid in cleansing the body and so may help clear skin problems. Examples are Iris versicolor, Taraxacum officinale, Fumaria officinalis, Hydrastis canadensis, Mahonia aquifolium, and Rumex crispus.', 'strong', '2026-03-22 21:15:29.737913+00'),
	(519, 134, 12, 11, NULL, NULL, '2026-03-22 21:15:29.739894+00'),
	(520, 176, 12, 11, NULL, 'mild', '2026-03-22 21:15:29.741402+00'),
	(521, 109, 12, 10, 'Certain cholagogues are also antimicrobial and anticatarrhal and in this way benefit the whole system. Some are also mucous membrane tonics, including this', 'mild', '2026-03-22 21:15:29.742845+00'),
	(522, 109, 12, 13, 'has a tonic and emmenagogue action, while most bitters stimulate the womb or menstrual activity', 'mild', '2026-03-22 21:15:29.744433+00'),
	(523, 109, 12, 15, 'Because they help with assimilation, cholagogues have an enlivening “side effect” in the nervous system. These remedies may actively ease debility and depression. Rosmarinus officinalis is a', 'mild', '2026-03-22 21:15:29.745831+00'),
	(524, 37, 12, 16, 'Taken internally, cholagogues often aid in cleansing the body and so may help clear skin problems. Examples are Iris versicolor, Taraxacum officinale, Fumaria officinalis, Hydrastis canadensis, Mahonia aquifolium, and Rumex crispus.', 'mild', '2026-03-22 21:15:29.747349+00'),
	(525, 56, 12, 10, 'Certain cholagogues are also antimicrobial and anticatarrhal and in this way benefit the whole system. Some are also mucous membrane tonics, including this', 'mild', '2026-03-22 21:15:29.748686+00'),
	(526, 177, 12, 11, NULL, 'mild', '2026-03-22 21:15:29.749931+00'),
	(527, 177, 12, 12, 'Cholagogues confer only indirect benefits to this system. However, Taraxacum officinale root is partially diuretic in action, although weaker than the leaves', 'mild', '2026-03-22 21:15:29.751165+00'),
	(528, 177, 12, 16, 'Taken internally, cholagogues often aid in cleansing the body and so may help clear skin problems. Examples are Iris versicolor, Taraxacum officinale, Fumaria officinalis, Hydrastis canadensis, Mahonia aquifolium, and Rumex crispus.', 'mild', '2026-03-22 21:15:29.752329+00'),
	(529, 45, 13, 11, 'These remedies can be applied freely whenever a soothing demulcent is indicated', NULL, '2026-03-22 21:15:29.753414+00'),
	(530, 45, 13, 16, 'The emollient herbs are all demulcent, including Symphytum officinale, Althaea officinalis, Plantago major, Stellaria media, Ulmus rubra, and Linum usitatissimum', NULL, '2026-03-22 21:15:29.754616+00'),
	(531, 178, 13, 15, 'Demulcents are of direct value in this system only when applied to the skin, as in shingles. However, skin tonics may be thought of as “surrogate” demulcents, especially Avena sativa.', NULL, '2026-03-22 21:15:29.756145+00'),
	(532, 48, 13, 11, 'These remedies can be applied freely whenever a soothing demulcent is indicated', NULL, '2026-03-22 21:15:29.75751+00'),
	(533, 49, 13, 11, 'These remedies can be applied freely whenever a soothing demulcent is indicated', NULL, '2026-03-22 21:15:29.758802+00'),
	(534, 179, 13, 12, 'Excellent kidney and bladder demulcents', NULL, '2026-03-22 21:15:29.760109+00'),
	(535, 78, 13, 10, 'soothe inflammation in the chest, throat and sinuses', NULL, '2026-03-22 21:15:29.761521+00'),
	(536, 78, 13, 11, 'These remedies can be applied freely whenever a soothing demulcent is indicated', NULL, '2026-03-22 21:15:29.762904+00'),
	(537, 180, 13, 11, 'These remedies can be applied freely whenever a soothing demulcent is indicated', NULL, '2026-03-22 21:15:29.764571+00'),
	(538, 180, 13, 16, 'The emollient herbs are all demulcent, including Symphytum officinale, Althaea officinalis, Plantago major, Stellaria media, Ulmus rubra, and Linum usitatissimum', NULL, '2026-03-22 21:15:29.76583+00'),
	(539, 83, 13, NULL, NULL, NULL, '2026-03-22 21:15:29.767281+00'),
	(540, 89, 13, 10, 'soothe inflammation in the chest, throat and sinuses', NULL, '2026-03-22 21:15:29.768639+00'),
	(541, 89, 13, 11, 'These remedies can be applied freely whenever a soothing demulcent is indicated', NULL, '2026-03-22 21:15:29.769901+00'),
	(542, 89, 13, 14, 'Vulneraries and anti-inflammatories have a more direct value in this system than demulcents as such. The undeniable value of Symphytum officinale here is related to its vulnerary properties', NULL, '2026-03-22 21:15:29.77108+00'),
	(543, 89, 13, 16, 'The emollient herbs are all demulcent, including Symphytum officinale, Althaea officinalis, Plantago major, Stellaria media, Ulmus rubra, and Linum usitatissimum', NULL, '2026-03-22 21:15:29.772341+00'),
	(544, 60, 13, 10, 'soothe inflammation in the chest, throat and sinuses', NULL, '2026-03-22 21:15:29.773728+00'),
	(545, 92, 13, 11, 'These remedies can be applied freely whenever a soothing demulcent is indicated', NULL, '2026-03-22 21:15:29.774913+00'),
	(546, 92, 13, 16, 'The emollient herbs are all demulcent, including Symphytum officinale, Althaea officinalis, Plantago major, Stellaria media, Ulmus rubra, and Linum usitatissimum', NULL, '2026-03-22 21:15:29.776263+00'),
	(547, 61, 13, 10, 'soothe inflammation in the chest, throat and sinuses', NULL, '2026-03-22 21:15:29.777743+00'),
	(548, 95, 13, NULL, NULL, NULL, '2026-03-22 21:15:29.781489+00'),
	(549, 44, 14, 9, 'As already noted, cardioactive remedies have a diuretic effect because they increase blood flow through the kidneys. All diuretics that help remove water from the body can be of benefit for the cardiovascular system, including Convallaria majalis, Cytisus scoparius, Taraxacum officinale, and Achillea millefolium. Care should be taken to ensure that the right herb is used for the specific condition. For example, Cytisus scoparius should not be used in people with high blood pressure.', 'strong', '2026-03-22 21:15:29.783231+00'),
	(550, 44, 14, 10, 'If chest congestion is related to heart problems, most of the diuretics will be of value.', 'strong', '2026-03-22 21:15:29.784589+00'),
	(551, 44, 14, 12, NULL, 'strong', '2026-03-22 21:15:29.786031+00'),
	(552, 44, 14, 14, 'Because of their cleansing actions, many diuretics help with problems of muscles and bones', 'strong', '2026-03-22 21:15:29.787485+00'),
	(553, 181, 14, 12, NULL, 'strong', '2026-03-22 21:15:29.788888+00'),
	(554, 148, 14, 11, 'Some laxative herbs also act as diuretics', NULL, '2026-03-22 21:15:29.790537+00'),
	(555, 148, 14, 12, NULL, NULL, '2026-03-22 21:15:29.792019+00'),
	(556, 66, 14, 11, 'Some laxative herbs also act as diuretics', 'strong', '2026-03-22 21:15:29.793408+00'),
	(557, 66, 14, 12, NULL, 'strong', '2026-03-22 21:15:29.794645+00'),
	(558, 66, 14, 14, 'Because of their cleansing actions, many diuretics help with problems of muscles and bones', 'strong', '2026-03-22 21:15:29.800232+00'),
	(559, 22, 14, 12, NULL, 'mild', '2026-03-22 21:15:29.802846+00'),
	(560, 46, 14, 12, NULL, 'strong', '2026-03-22 21:15:29.804651+00'),
	(561, 46, 14, 13, 'Antiseptic diuretics often have similar effects in the reproductive system.', 'strong', '2026-03-22 21:15:29.80637+00'),
	(562, 150, 14, 12, NULL, NULL, '2026-03-22 21:15:29.807791+00'),
	(563, 182, 14, 12, NULL, NULL, '2026-03-22 21:15:29.809241+00'),
	(564, 163, 14, 9, 'As already noted, cardioactive remedies have a diuretic effect because they increase blood flow through the kidneys. All diuretics that help remove water from the body can be of benefit for the cardiovascular system, including Convallaria majalis, Cytisus scoparius, Taraxacum officinale, and Achillea millefolium. Care should be taken to ensure that the right herb is used for the specific condition. For example, Cytisus scoparius should not be used in people with high blood pressure.', NULL, '2026-03-22 21:15:29.810884+00'),
	(565, 163, 14, 12, NULL, NULL, '2026-03-22 21:15:29.812739+00'),
	(566, 73, 14, 12, NULL, 'mild', '2026-03-22 21:15:29.815042+00'),
	(567, 183, 14, 12, NULL, NULL, '2026-03-22 21:15:29.816578+00'),
	(568, 164, 14, 9, 'As already noted, cardioactive remedies have a diuretic effect because they increase blood flow through the kidneys. All diuretics that help remove water from the body can be of benefit for the cardiovascular system, including Convallaria majalis, Cytisus scoparius, Taraxacum officinale, and Achillea millefolium. Care should be taken to ensure that the right herb is used for the specific condition. For example, Cytisus scoparius should not be used in people with high blood pressure.', 'strong', '2026-03-22 21:15:29.817901+00'),
	(569, 164, 14, 12, NULL, 'strong', '2026-03-22 21:15:29.819263+00'),
	(573, 50, 14, 10, 'If chest congestion is related to heart problems, most of the diuretics will be of value.', 'strong', '2026-03-22 21:15:29.824756+00'),
	(574, 50, 14, 12, NULL, 'strong', '2026-03-22 21:15:29.826081+00'),
	(575, 50, 14, 14, 'Because of their cleansing actions, many diuretics help with problems of muscles and bones', 'strong', '2026-03-22 21:15:29.82742+00'),
	(576, 117, 14, 12, NULL, 'strong', '2026-03-22 21:15:29.828625+00'),
	(577, 117, 14, 14, 'Because of their cleansing actions, many diuretics help with problems of muscles and bones', 'strong', '2026-03-22 21:15:29.829869+00'),
	(578, 28, 14, 10, 'If chest congestion is related to heart problems, most of the diuretics will be of value.', 'strong', '2026-03-22 21:15:29.830997+00'),
	(579, 28, 14, 12, NULL, 'strong', '2026-03-22 21:15:29.832126+00'),
	(580, 28, 14, 16, 'All of the diuretics can potentially help the skin through inner cleansing actions. Especially important are these', 'strong', '2026-03-22 21:15:29.833416+00'),
	(581, 31, 14, 11, 'Some laxative herbs also act as diuretics', 'mild', '2026-03-22 21:15:29.83509+00'),
	(582, 31, 14, 12, NULL, 'mild', '2026-03-22 21:15:29.836506+00'),
	(583, 103, 14, 12, NULL, 'strong', '2026-03-22 21:15:29.837776+00'),
	(584, 185, 14, 12, NULL, NULL, '2026-03-22 21:15:29.839227+00'),
	(585, 120, 14, 11, 'Some laxative herbs also act as diuretics', 'strong', '2026-03-22 21:15:29.840713+00'),
	(586, 120, 14, 12, NULL, 'strong', '2026-03-22 21:15:29.842068+00'),
	(587, 176, 14, 11, 'Some laxative herbs also act as diuretics', 'mild', '2026-03-22 21:15:29.843233+00'),
	(588, 176, 14, 12, NULL, 'mild', '2026-03-22 21:15:29.844662+00'),
	(589, 57, 14, 10, 'If chest congestion is related to heart problems, most of the diuretics will be of value.', NULL, '2026-03-22 21:15:29.846264+00'),
	(590, 57, 14, 12, NULL, NULL, '2026-03-22 21:15:29.848136+00'),
	(591, 186, 14, 12, NULL, 'mild', '2026-03-22 21:15:29.849884+00'),
	(592, 186, 14, 13, 'a mild diuretic.', 'mild', '2026-03-22 21:15:29.85183+00'),
	(593, 122, 14, 9, 'As already noted, cardioactive remedies have a diuretic effect because they increase blood flow through the kidneys. All diuretics that help remove water from the body can be of benefit for the cardiovascular system, including Convallaria majalis, Cytisus scoparius, Taraxacum officinale, and Achillea millefolium. Care should be taken to ensure that the right herb is used for the specific condition. For example, Cytisus scoparius should not be used in people with high blood pressure.', 'strong', '2026-03-22 21:15:29.853687+00'),
	(594, 122, 14, 11, 'Some laxative herbs also act as diuretics', 'strong', '2026-03-22 21:15:29.855162+00'),
	(595, 122, 14, 12, NULL, 'strong', '2026-03-22 21:15:29.856699+00'),
	(596, 122, 14, 16, 'All of the diuretics can potentially help the skin through inner cleansing actions. Especially important are these', 'strong', '2026-03-22 21:15:29.858345+00'),
	(597, 90, 14, 12, NULL, 'mild', '2026-03-22 21:15:29.859696+00'),
	(598, 95, 14, 12, NULL, NULL, '2026-03-22 21:15:29.861134+00'),
	(599, 44, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.862831+00'),
	(600, 96, 15, NULL, NULL, 'strong', '2026-03-22 21:15:29.864286+00'),
	(601, 97, 15, NULL, NULL, 'strong', '2026-03-22 21:15:29.865679+00'),
	(602, 115, 15, NULL, NULL, 'strong', '2026-03-22 21:15:29.867053+00'),
	(603, 70, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.868419+00'),
	(604, 72, 15, NULL, NULL, NULL, '2026-03-22 21:15:29.869678+00'),
	(605, 25, 15, NULL, NULL, NULL, '2026-03-22 21:15:29.870858+00'),
	(606, 102, 15, NULL, NULL, 'strong', '2026-03-22 21:15:29.872121+00'),
	(607, 30, 15, NULL, NULL, 'strong', '2026-03-22 21:15:29.873327+00'),
	(608, 53, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.874524+00'),
	(609, 82, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.875613+00'),
	(610, 131, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.876708+00'),
	(611, 160, 15, NULL, NULL, 'strong', '2026-03-22 21:15:29.87779+00'),
	(612, 187, 15, NULL, NULL, 'strong', '2026-03-22 21:15:29.878844+00'),
	(613, 84, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.879997+00'),
	(614, 55, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.881386+00'),
	(615, 135, 15, NULL, NULL, NULL, '2026-03-22 21:15:29.882609+00'),
	(616, 188, 15, NULL, NULL, NULL, '2026-03-22 21:15:29.883993+00'),
	(617, 120, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.885117+00'),
	(618, 35, 15, NULL, NULL, NULL, '2026-03-22 21:15:29.886224+00'),
	(619, 36, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.887276+00'),
	(620, 109, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.888388+00'),
	(621, 155, 15, NULL, NULL, NULL, '2026-03-22 21:15:29.889456+00'),
	(622, 110, 15, NULL, NULL, 'strong', '2026-03-22 21:15:29.890571+00'),
	(623, 56, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.89176+00'),
	(624, 121, 15, NULL, NULL, 'strong', '2026-03-22 21:15:29.892881+00'),
	(625, 161, 15, NULL, NULL, 'strong', '2026-03-22 21:15:29.893971+00'),
	(626, 59, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.895034+00'),
	(627, 90, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.896093+00'),
	(628, 91, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.897127+00'),
	(629, 189, 15, NULL, NULL, 'strong', '2026-03-22 21:15:29.898142+00'),
	(630, 145, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.89925+00'),
	(631, 146, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.900603+00'),
	(632, 93, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.901834+00'),
	(633, 94, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.903085+00'),
	(634, 190, 15, NULL, NULL, NULL, '2026-03-22 21:15:29.904241+00'),
	(635, 124, 15, NULL, NULL, 'strong', '2026-03-22 21:15:29.905466+00'),
	(636, 191, 16, 10, NULL, NULL, '2026-03-22 21:15:29.906503+00'),
	(637, 192, 16, 10, NULL, NULL, '2026-03-22 21:15:29.907738+00'),
	(638, 192, 16, 11, 'All of the stimulating expectorants may act as emetics if taken in too high a dose (for example, Cephaelis ipecacuanha)', NULL, '2026-03-22 21:15:29.908844+00'),
	(639, 193, 16, 10, NULL, NULL, '2026-03-22 21:15:29.909957+00'),
	(640, 54, 16, 10, NULL, NULL, '2026-03-22 21:15:29.911074+00'),
	(641, 54, 16, 16, 'By supporting respiration and thus the whole of a person’s health, these remedies may help the skin in a broad holistic way. Expectorants that may be used internally or externally for the skin include this', NULL, '2026-03-22 21:15:29.912209+00'),
	(642, 160, 16, 10, NULL, NULL, '2026-03-22 21:15:29.913456+00'),
	(643, 194, 16, 10, NULL, NULL, '2026-03-22 21:15:29.914726+00'),
	(644, 195, 16, 10, NULL, NULL, '2026-03-22 21:15:29.91577+00'),
	(645, 196, 16, 10, NULL, NULL, '2026-03-22 21:15:29.916986+00'),
	(646, 196, 16, 16, 'By supporting respiration and thus the whole of a person’s health, these remedies may help the skin in a broad holistic way. Expectorants that may be used internally or externally for the skin include this', NULL, '2026-03-22 21:15:29.918333+00'),
	(647, 197, 16, 10, NULL, NULL, '2026-03-22 21:15:29.919626+00'),
	(648, 197, 16, 15, 'can have relaxing nervine action.', NULL, '2026-03-22 21:15:29.920775+00'),
	(649, 38, 16, 10, NULL, NULL, '2026-03-22 21:15:29.923083+00'),
	(650, 166, 16, 10, NULL, NULL, '2026-03-22 21:15:29.92464+00'),
	(651, 198, 16, 10, NULL, NULL, '2026-03-22 21:15:29.925912+00'),
	(652, 45, 17, 10, NULL, NULL, '2026-03-22 21:15:29.927551+00'),
	(653, 67, 17, 10, NULL, NULL, '2026-03-22 21:15:29.928912+00'),
	(654, 48, 17, 10, NULL, NULL, '2026-03-22 21:15:29.930195+00'),
	(655, 49, 17, 10, NULL, NULL, '2026-03-22 21:15:29.931295+00'),
	(656, 126, 17, 10, NULL, NULL, '2026-03-22 21:15:29.932455+00'),
	(657, 78, 17, 10, NULL, NULL, '2026-03-22 21:15:29.933712+00'),
	(658, 199, 17, 10, NULL, NULL, '2026-03-22 21:15:29.934942+00'),
	(659, 30, 17, 10, NULL, NULL, '2026-03-22 21:15:29.936268+00'),
	(660, 30, 17, 13, 'can work as an expectorant while toning the mucous membranes of the respiratory system, may also be of value in the reproductive tract.', NULL, '2026-03-22 21:15:29.937458+00'),
	(661, 30, 17, 16, 'By supporting respiration and thus the whole of a person’s health, these remedies may help the skin in a broad holistic way. Expectorants that may be used internally or externally for the skin include this', NULL, '2026-03-22 21:15:29.938778+00'),
	(662, 53, 17, 10, NULL, NULL, '2026-03-22 21:15:29.940014+00'),
	(663, 53, 17, 15, 'can have relaxing nervine actions', NULL, '2026-03-22 21:15:29.94184+00'),
	(664, 132, 17, 10, NULL, NULL, '2026-03-22 21:15:29.943298+00'),
	(665, 132, 17, 14, 'a good muscle relaxant', NULL, '2026-03-22 21:15:29.9446+00'),
	(666, 108, 17, 10, NULL, NULL, '2026-03-22 21:15:29.945874+00'),
	(667, 108, 17, 11, 'The relaxing expectorants may be either demulcents (Symphytum officinale) or carminatives (Pimpinella anisum).', NULL, '2026-03-22 21:15:29.947182+00'),
	(668, 140, 17, 10, NULL, NULL, '2026-03-22 21:15:29.94868+00'),
	(669, 200, 17, 10, NULL, NULL, '2026-03-22 21:15:29.949795+00'),
	(670, 89, 17, 10, NULL, NULL, '2026-03-22 21:15:29.95085+00'),
	(671, 89, 17, 11, 'The relaxing expectorants may be either demulcents (Symphytum officinale) or carminatives (Pimpinella anisum).', NULL, '2026-03-22 21:15:29.951928+00'),
	(672, 89, 17, 16, 'By supporting respiration and thus the whole of a person’s health, these remedies may help the skin in a broad holistic way. Expectorants that may be used internally or externally for the skin include this', NULL, '2026-03-22 21:15:29.953254+00'),
	(673, 143, 17, 10, NULL, NULL, '2026-03-22 21:15:29.954802+00'),
	(674, 201, 17, 10, NULL, NULL, '2026-03-22 21:15:29.956084+00'),
	(675, 59, 17, 10, NULL, NULL, '2026-03-22 21:15:29.957407+00'),
	(676, 59, 17, 15, 'can have relaxing nervine actions', NULL, '2026-03-22 21:15:29.958655+00'),
	(677, 60, 17, 10, NULL, NULL, '2026-03-22 21:15:29.959912+00'),
	(678, 146, 17, 10, NULL, NULL, '2026-03-22 21:15:29.961173+00'),
	(679, 146, 17, 15, 'can have relaxing nervine actions', NULL, '2026-03-22 21:15:29.96275+00'),
	(680, 21, 18, 10, NULL, NULL, '2026-03-22 21:15:29.964255+00'),
	(681, 21, 18, 16, 'By supporting respiration and thus the whole of a person’s health, these remedies may help the skin in a broad holistic way. Expectorants that may be used internally or externally for the skin include this', NULL, '2026-03-22 21:15:29.965647+00'),
	(682, 57, 18, 10, NULL, NULL, '2026-03-22 21:15:29.966949+00'),
	(683, 57, 18, 16, 'By supporting respiration and thus the whole of a person’s health, these remedies may help the skin in a broad holistic way. Expectorants that may be used internally or externally for the skin include this', NULL, '2026-03-22 21:15:29.968197+00'),
	(684, 61, 18, 10, NULL, NULL, '2026-03-22 21:15:29.969338+00'),
	(685, 44, 19, NULL, NULL, NULL, '2026-03-22 21:15:29.970522+00'),
	(686, 148, 19, 11, NULL, NULL, '2026-03-22 21:15:29.971752+00'),
	(687, 202, 19, NULL, NULL, NULL, '2026-03-22 21:15:29.972986+00'),
	(688, 66, 19, NULL, NULL, NULL, '2026-03-22 21:15:29.97425+00'),
	(689, 113, 19, NULL, NULL, NULL, '2026-03-22 21:15:29.975355+00'),
	(690, 97, 19, NULL, NULL, NULL, '2026-03-22 21:15:29.976506+00'),
	(691, 23, 19, 10, 'Certain hepatics are also antimicrobial and anticatarrhal, which will benefit the respiratory system. Also, mucous membrane tonics help here, including herbs such as this', NULL, '2026-03-22 21:15:29.977632+00'),
	(692, 158, 19, 11, NULL, NULL, '2026-03-22 21:15:29.979032+00'),
	(693, 158, 19, 13, 'Hepatic plants such as Hydrastis canadensis and Berberis vulgaris have a pronounced action on the muscles of the uterus', NULL, '2026-03-22 21:15:29.980132+00'),
	(694, 159, 19, NULL, NULL, NULL, '2026-03-22 21:15:29.981341+00'),
	(695, 171, 19, 11, NULL, NULL, '2026-03-22 21:15:29.982539+00'),
	(696, 24, 19, NULL, NULL, NULL, '2026-03-22 21:15:29.983716+00'),
	(697, 203, 19, NULL, NULL, NULL, '2026-03-22 21:15:29.984789+00'),
	(698, 172, 19, NULL, NULL, NULL, '2026-03-22 21:15:29.98591+00'),
	(699, 74, 19, 11, NULL, NULL, '2026-03-22 21:15:29.987084+00'),
	(700, 173, 19, 11, NULL, NULL, '2026-03-22 21:15:29.988444+00'),
	(701, 76, 19, NULL, NULL, NULL, '2026-03-22 21:15:29.989787+00'),
	(702, 27, 19, 16, 'Taken internally, hepatic remedies often aid in cleansing and so clear skin problems.', NULL, '2026-03-22 21:15:29.991019+00'),
	(703, 28, 19, NULL, NULL, NULL, '2026-03-22 21:15:29.992217+00'),
	(704, 102, 19, 11, NULL, NULL, '2026-03-22 21:15:29.993514+00'),
	(705, 30, 19, 10, 'Certain hepatics are also antimicrobial and anticatarrhal, which will benefit the respiratory system. Also, mucous membrane tonics help here, including herbs such as this', NULL, '2026-03-22 21:15:29.994839+00'),
	(706, 30, 19, 13, 'Hepatic plants such as Hydrastis canadensis and Berberis vulgaris have a pronounced action on the muscles of the uterus', NULL, '2026-03-22 21:15:29.996054+00'),
	(707, 30, 19, 16, 'Taken internally, hepatic remedies often aid in cleansing and so clear skin problems.', NULL, '2026-03-22 21:15:29.997265+00'),
	(709, 53, 19, NULL, NULL, NULL, '2026-03-22 21:15:29.99964+00'),
	(710, 54, 19, NULL, NULL, NULL, '2026-03-22 21:15:30.000842+00'),
	(711, 31, 19, 11, NULL, NULL, '2026-03-22 21:15:30.002649+00'),
	(712, 31, 19, 16, 'Taken internally, hepatic remedies often aid in cleansing and so clear skin problems.', NULL, '2026-03-22 21:15:30.004355+00'),
	(713, 131, 19, NULL, NULL, NULL, '2026-03-22 21:15:30.005781+00'),
	(714, 175, 19, 11, NULL, NULL, '2026-03-22 21:15:30.006994+00'),
	(715, 33, 19, 16, 'Taken internally, hepatic remedies often aid in cleansing and so clear skin problems.', NULL, '2026-03-22 21:15:30.008192+00'),
	(716, 134, 19, NULL, NULL, NULL, '2026-03-22 21:15:30.009694+00'),
	(717, 34, 19, NULL, NULL, NULL, '2026-03-22 21:15:30.010739+00'),
	(718, 176, 19, 11, NULL, NULL, '2026-03-22 21:15:30.011863+00'),
	(719, 204, 19, NULL, NULL, NULL, '2026-03-22 21:15:30.013154+00'),
	(720, 205, 19, NULL, NULL, NULL, '2026-03-22 21:15:30.014365+00'),
	(721, 37, 19, 16, 'Taken internally, hepatic remedies often aid in cleansing and so clear skin problems.', NULL, '2026-03-22 21:15:30.015635+00'),
	(722, 206, 19, NULL, NULL, NULL, '2026-03-22 21:15:30.016901+00'),
	(723, 177, 19, 11, NULL, NULL, '2026-03-22 21:15:30.018239+00'),
	(724, 177, 19, 12, 'Hepatics confer only an indirect benefit to this system. However, Taraxacum officinale root is partially diuretic in action, although weaker than the leaves', NULL, '2026-03-22 21:15:30.019678+00'),
	(725, 177, 19, 16, 'Taken internally, hepatic remedies often aid in cleansing and so clear skin problems.', NULL, '2026-03-22 21:15:30.020885+00'),
	(726, 123, 19, NULL, NULL, NULL, '2026-03-22 21:15:30.022222+00'),
	(727, 115, 20, 12, 'Hypnotics are important here when used as muscle relaxants.', 'mild', '2026-03-22 21:15:30.023632+00'),
	(728, 115, 20, 13, 'Hypnotics are important here when used as muscle relaxants.', 'mild', '2026-03-22 21:15:30.024861+00'),
	(729, 128, 20, 12, 'Hypnotics are important here when used as muscle relaxants.', NULL, '2026-03-22 21:15:30.026145+00'),
	(730, 128, 20, 13, 'Hypnotics are important here when used as muscle relaxants.', NULL, '2026-03-22 21:15:30.027338+00'),
	(731, 129, 20, 11, 'The relaxing nervines and carminatives are important', 'strong', '2026-03-22 21:15:30.028709+00'),
	(733, 129, 20, 12, 'Hypnotics are important here when used as muscle relaxants.', 'strong', '2026-03-22 21:15:30.03112+00'),
	(734, 129, 20, 13, 'Hypnotics are important here when used as muscle relaxants.', 'strong', '2026-03-22 21:15:30.032262+00'),
	(735, 130, 20, 10, 'eases irritable coughs', 'strong', '2026-03-22 21:15:30.0334+00'),
	(736, 130, 20, 12, 'Hypnotics are important here when used as muscle relaxants.', 'strong', '2026-03-22 21:15:30.034661+00'),
	(737, 130, 20, 13, 'Hypnotics are important here when used as muscle relaxants.', 'strong', '2026-03-22 21:15:30.036212+00'),
	(738, 131, 20, 9, 'Notice that this herb are all in the “milder” category', 'mild', '2026-03-22 21:15:30.037816+00'),
	(739, 131, 20, 12, 'Hypnotics are important here when used as muscle relaxants.', 'mild', '2026-03-22 21:15:30.039182+00'),
	(740, 131, 20, 13, 'Hypnotics are important here when used as muscle relaxants.', 'mild', '2026-03-22 21:15:30.040592+00'),
	(741, 84, 20, 11, 'The relaxing nervines and carminatives are important', 'mild', '2026-03-22 21:15:30.042968+00'),
	(742, 84, 20, 12, 'Hypnotics are important here when used as muscle relaxants.', 'mild', '2026-03-22 21:15:30.045066+00'),
	(743, 84, 20, 13, 'Hypnotics are important here when used as muscle relaxants.', 'mild', '2026-03-22 21:15:30.046872+00'),
	(744, 137, 20, 11, 'will help with intestinal colic—for example', 'strong', '2026-03-22 21:15:30.048683+00'),
	(745, 137, 20, 12, 'Hypnotics are important here when used as muscle relaxants.', 'strong', '2026-03-22 21:15:30.050671+00'),
	(746, 137, 20, 13, 'Hypnotics are important here when used as muscle relaxants.', 'strong', '2026-03-22 21:15:30.052866+00'),
	(747, 35, 20, 12, 'Hypnotics are important here when used as muscle relaxants.', NULL, '2026-03-22 21:15:30.05479+00'),
	(748, 35, 20, 13, 'Hypnotics are important here when used as muscle relaxants.', NULL, '2026-03-22 21:15:30.056713+00'),
	(749, 139, 20, 11, 'will help with intestinal colic—for example', 'strong', '2026-03-22 21:15:30.058546+00'),
	(750, 139, 20, 12, 'Hypnotics are important here when used as muscle relaxants.', 'strong', '2026-03-22 21:15:30.059905+00'),
	(751, 139, 20, 13, 'Hypnotics are important here when used as muscle relaxants.', 'strong', '2026-03-22 21:15:30.061367+00'),
	(752, 139, 20, 14, 'All hypnotics help reduce muscle tension and even the pain associated with problems in this system. They may be used', 'strong', '2026-03-22 21:15:30.062674+00'),
	(753, 142, 20, 12, 'Hypnotics are important here when used as muscle relaxants.', NULL, '2026-03-22 21:15:30.063845+00'),
	(754, 142, 20, 13, 'Hypnotics are important here when used as muscle relaxants.', NULL, '2026-03-22 21:15:30.064976+00'),
	(755, 207, 20, 12, 'Hypnotics are important here when used as muscle relaxants.', 'mild', '2026-03-22 21:15:30.070166+00'),
	(756, 207, 20, 13, 'Hypnotics are important here when used as muscle relaxants.', 'mild', '2026-03-22 21:15:30.072364+00'),
	(757, 90, 20, 9, 'Notice that this herb are all in the “milder” category', 'mild', '2026-03-22 21:15:30.073938+00'),
	(758, 90, 20, 12, 'Hypnotics are important here when used as muscle relaxants.', 'mild', '2026-03-22 21:15:30.075146+00'),
	(759, 90, 20, 13, 'Hypnotics are important here when used as muscle relaxants.', 'mild', '2026-03-22 21:15:30.07631+00'),
	(760, 145, 20, 11, 'The relaxing nervines and carminatives are important', 'strong', '2026-03-22 21:15:30.077669+00'),
	(762, 145, 20, 12, 'Hypnotics are important here when used as muscle relaxants.', 'strong', '2026-03-22 21:15:30.080474+00'),
	(763, 145, 20, 13, 'Hypnotics are important here when used as muscle relaxants.', 'strong', '2026-03-22 21:15:30.082035+00'),
	(764, 145, 20, 14, 'All hypnotics help reduce muscle tension and even the pain associated with problems in this system. They may be used', 'strong', '2026-03-22 21:15:30.083352+00'),
	(765, 146, 20, 11, 'The relaxing nervines and carminatives are important', NULL, '2026-03-22 21:15:30.08493+00'),
	(766, 146, 20, 12, 'Hypnotics are important here when used as muscle relaxants.', NULL, '2026-03-22 21:15:30.086162+00'),
	(767, 146, 20, 13, 'Hypnotics are important here when used as muscle relaxants.', NULL, '2026-03-22 21:15:30.087521+00'),
	(768, 44, 21, NULL, NULL, NULL, '2026-03-22 21:15:30.08892+00'),
	(769, 208, 21, NULL, NULL, 'mild', '2026-03-22 21:15:30.090184+00'),
	(770, 209, 21, NULL, NULL, NULL, '2026-03-22 21:15:30.091531+00'),
	(771, 72, 21, NULL, NULL, 'mild', '2026-03-22 21:15:30.092829+00'),
	(772, 25, 21, NULL, NULL, 'mild', '2026-03-22 21:15:30.094093+00'),
	(773, 73, 21, NULL, NULL, 'strong', '2026-03-22 21:15:30.095205+00'),
	(774, 9, 21, NULL, NULL, NULL, '2026-03-22 21:15:30.096217+00'),
	(775, 210, 21, NULL, NULL, NULL, '2026-03-22 21:15:30.097517+00'),
	(776, 131, 21, NULL, NULL, NULL, '2026-03-22 21:15:30.098762+00'),
	(777, 137, 21, NULL, NULL, NULL, '2026-03-22 21:15:30.099968+00'),
	(778, 120, 21, NULL, NULL, NULL, '2026-03-22 21:15:30.101153+00'),
	(779, 142, 21, NULL, NULL, NULL, '2026-03-22 21:15:30.102739+00'),
	(780, 90, 21, NULL, NULL, 'strong', '2026-03-22 21:15:30.104272+00'),
	(781, 91, 21, NULL, NULL, 'strong', '2026-03-22 21:15:30.105603+00'),
	(782, 43, 21, NULL, NULL, 'mild', '2026-03-22 21:15:30.106993+00'),
	(783, 145, 21, NULL, NULL, NULL, '2026-03-22 21:15:30.108243+00'),
	(784, 146, 21, NULL, NULL, 'mild', '2026-03-22 21:15:30.109533+00'),
	(785, 93, 21, NULL, NULL, 'strong', '2026-03-22 21:15:30.110739+00'),
	(786, 94, 21, NULL, NULL, NULL, '2026-03-22 21:15:30.112034+00'),
	(787, 211, 21, NULL, NULL, 'strong', '2026-03-22 21:15:30.113446+00'),
	(788, 142, 22, NULL, NULL, NULL, '2026-03-22 21:15:30.114627+00'),
	(789, 81, 22, NULL, NULL, NULL, '2026-03-22 21:15:30.115665+00'),
	(790, 115, 23, NULL, NULL, NULL, '2026-03-22 21:15:30.116959+00'),
	(791, 212, 23, NULL, NULL, 'mild', '2026-03-22 21:15:30.118179+00'),
	(792, 69, 23, NULL, NULL, 'mild', '2026-03-22 21:15:30.119857+00'),
	(793, 213, 23, NULL, NULL, 'mild', '2026-03-22 21:15:30.121129+00'),
	(794, 25, 23, 10, 'Most sedatives will help with problems accompanied by chest tension, such as asthma, but specifically, we can mention this', NULL, '2026-03-22 21:15:30.122522+00'),
	(795, 25, 23, 13, NULL, NULL, '2026-03-22 21:15:30.123708+00'),
	(796, 25, 23, 14, 'All sedative remedies will help ease muscular tension and pain in this complex system', NULL, '2026-03-22 21:15:30.124828+00'),
	(797, 25, 23, 16, 'All nervines may help the skin in an indirect way, but the following have a good reputation for skin conditions', NULL, '2026-03-22 21:15:30.125939+00'),
	(798, 128, 23, NULL, NULL, 'strong', '2026-03-22 21:15:30.127248+00'),
	(799, 129, 23, 11, 'All of the antispasmodic remedies may be of value here in easing spasms or colic. However, sedatives that actively aid digestion include stronger herbs such as this', 'strong', '2026-03-22 21:15:30.128455+00'),
	(800, 81, 23, 16, 'All nervines may help the skin in an indirect way, but the following have a good reputation for skin conditions', NULL, '2026-03-22 21:15:30.12952+00'),
	(801, 53, 23, NULL, NULL, 'mild', '2026-03-22 21:15:30.130638+00'),
	(802, 130, 23, 10, 'Most sedatives will help with problems accompanied by chest tension, such as asthma, but specifically, we can mention this', 'strong', '2026-03-22 21:15:30.131851+00'),
	(803, 130, 23, 13, NULL, 'strong', '2026-03-22 21:15:30.13298+00'),
	(804, 82, 23, 11, 'All of the antispasmodic remedies may be of value here in easing spasms or colic. However, sedatives that actively aid digestion include mild herbs such as this', 'mild', '2026-03-22 21:15:30.134267+00'),
	(805, 131, 23, 9, 'a mild sedatives that are helpful to the cardiovascular system. However, most remedies that lessen overactivity of the nervous system will also aid the heart and have a positive impact on circulatory conditions, such as high blood pressure.', NULL, '2026-03-22 21:15:30.136175+00'),
	(806, 131, 23, 10, 'Most sedatives will help with problems accompanied by chest tension, such as asthma, but specifically, we can mention this', NULL, '2026-03-22 21:15:30.137908+00'),
	(807, 131, 23, 13, NULL, NULL, '2026-03-22 21:15:30.139207+00'),
	(808, 132, 23, 10, 'Most sedatives will help with problems accompanied by chest tension, such as asthma, but specifically, we can mention this', NULL, '2026-03-22 21:15:30.140346+00'),
	(809, 84, 23, 11, 'All of the antispasmodic remedies may be of value here in easing spasms or colic. However, sedatives that actively aid digestion include mild herbs such as this', NULL, '2026-03-22 21:15:30.142443+00'),
	(810, 134, 23, 9, 'a mild sedatives that are helpful to the cardiovascular system. However, most remedies that lessen overactivity of the nervous system will also aid the heart and have a positive impact on circulatory conditions, such as high blood pressure.', 'mild', '2026-03-22 21:15:30.145965+00'),
	(811, 134, 23, 11, 'All of the antispasmodic remedies may be of value here in easing spasms or colic. However, sedatives that actively aid digestion include mild herbs such as this', 'mild', '2026-03-22 21:15:30.148135+00'),
	(812, 137, 23, NULL, NULL, 'strong', '2026-03-22 21:15:30.149578+00'),
	(813, 138, 23, NULL, NULL, NULL, '2026-03-22 21:15:30.151004+00'),
	(814, 139, 23, NULL, NULL, 'strong', '2026-03-22 21:15:30.152235+00'),
	(815, 36, 23, NULL, NULL, NULL, '2026-03-22 21:15:30.153452+00'),
	(816, 142, 23, NULL, NULL, NULL, '2026-03-22 21:15:30.154693+00'),
	(817, 214, 23, NULL, NULL, NULL, '2026-03-22 21:15:30.15602+00'),
	(818, 90, 23, 9, 'a mild sedatives that are helpful to the cardiovascular system. However, most remedies that lessen overactivity of the nervous system will also aid the heart and have a positive impact on circulatory conditions, such as high blood pressure.', NULL, '2026-03-22 21:15:30.157444+00'),
	(819, 42, 23, 16, 'All nervines may help the skin in an indirect way, but the following have a good reputation for skin conditions', 'mild', '2026-03-22 21:15:30.159097+00'),
	(820, 144, 23, NULL, NULL, NULL, '2026-03-22 21:15:30.160437+00'),
	(821, 145, 23, NULL, NULL, 'strong', '2026-03-22 21:15:30.161989+00'),
	(822, 146, 23, NULL, NULL, NULL, '2026-03-22 21:15:30.163356+00'),
	(823, 93, 23, NULL, NULL, 'mild', '2026-03-22 21:15:30.164643+00'),
	(824, 94, 23, 14, 'All sedative remedies will help ease muscular tension and pain in this complex system', 'mild', '2026-03-22 21:15:30.165906+00'),
	(825, 44, 24, 9, 'Stimulant actions must be used with care in people with cardiovascular problems, but if applied with knowledge, appropriate stimulation can often aid and support an ailing heart', NULL, '2026-03-22 21:15:30.167254+00'),
	(826, 44, 24, 10, 'The diaphoretic chest remedies can be considered stimulant in action', NULL, '2026-03-22 21:15:30.168808+00'),
	(827, 44, 24, 12, 'Relevant stimulants with diuretic properties include this', NULL, '2026-03-22 21:15:30.170051+00'),
	(828, 21, 24, 10, 'The diaphoretic chest remedies can be considered stimulant in action', NULL, '2026-03-22 21:15:30.171174+00'),
	(829, 21, 24, 11, 'As already discussed, bitters may be considered stimulants', NULL, '2026-03-22 21:15:30.172381+00'),
	(830, 65, 24, 10, 'The diaphoretic chest remedies can be considered stimulant in action', NULL, '2026-03-22 21:15:30.173526+00'),
	(831, 113, 24, 10, 'The diaphoretic chest remedies can be considered stimulant in action', NULL, '2026-03-22 21:15:30.174597+00'),
	(832, 113, 24, 11, 'As already discussed, bitters may be considered stimulants', NULL, '2026-03-22 21:15:30.175848+00'),
	(833, 113, 24, 14, 'a stimulant of peripheral circulation. In general, rubefacient remedies are stimulants.', NULL, '2026-03-22 21:15:30.177037+00'),
	(834, 96, 24, 13, 'Stimulants for this system usually act as emmenagogues, and so should not be used during pregnancy. Important examples include this.', NULL, '2026-03-22 21:15:30.178228+00'),
	(835, 97, 24, 9, 'Stimulant actions must be used with care in people with cardiovascular problems, but if applied with knowledge, appropriate stimulation can often aid and support an ailing heart', NULL, '2026-03-22 21:15:30.179483+00'),
	(836, 97, 24, 11, 'As already discussed, bitters may be considered stimulants', NULL, '2026-03-22 21:15:30.180697+00'),
	(837, 97, 24, 13, 'Stimulants for this system usually act as emmenagogues, and so should not be used during pregnancy. Important examples include this.', NULL, '2026-03-22 21:15:30.182479+00'),
	(838, 115, 24, NULL, NULL, NULL, '2026-03-22 21:15:30.183776+00'),
	(839, 116, 24, 10, 'The diaphoretic chest remedies can be considered stimulant in action', NULL, '2026-03-22 21:15:30.18502+00'),
	(840, 116, 24, 11, 'As already discussed, bitters may be considered stimulants', NULL, '2026-03-22 21:15:30.186239+00'),
	(841, 116, 24, 14, 'a stimulant of peripheral circulation. In general, rubefacient remedies are stimulants.', NULL, '2026-03-22 21:15:30.187441+00'),
	(842, 47, 24, 14, 'a stimulant of peripheral circulation. In general, rubefacient remedies are stimulants.', NULL, '2026-03-22 21:15:30.188666+00'),
	(843, 98, 24, 11, 'As already discussed, bitters may be considered stimulants', NULL, '2026-03-22 21:15:30.189869+00'),
	(844, 192, 24, NULL, NULL, NULL, '2026-03-22 21:15:30.190985+00'),
	(845, 170, 24, NULL, NULL, NULL, '2026-03-22 21:15:30.192159+00'),
	(846, 150, 24, 15, NULL, NULL, '2026-03-22 21:15:30.193349+00'),
	(847, 127, 24, 11, 'As already discussed, bitters may be considered stimulants', NULL, '2026-03-22 21:15:30.194469+00'),
	(848, 50, 24, NULL, NULL, NULL, '2026-03-22 21:15:30.195778+00'),
	(849, 117, 24, 12, 'Relevant stimulants with diuretic properties include this', NULL, '2026-03-22 21:15:30.197116+00'),
	(850, 76, 24, NULL, NULL, NULL, '2026-03-22 21:15:30.19833+00'),
	(851, 118, 24, NULL, NULL, NULL, '2026-03-22 21:15:30.199892+00'),
	(852, 102, 24, 11, 'As already discussed, bitters may be considered stimulants', NULL, '2026-03-22 21:15:30.201324+00'),
	(853, 54, 24, NULL, NULL, NULL, '2026-03-22 21:15:30.202743+00'),
	(854, 103, 24, 12, 'Relevant stimulants with diuretic properties include this', NULL, '2026-03-22 21:15:30.204121+00'),
	(855, 160, 24, 10, 'The diaphoretic chest remedies can be considered stimulant in action', NULL, '2026-03-22 21:15:30.205461+00'),
	(856, 187, 24, NULL, NULL, NULL, '2026-03-22 21:15:30.206678+00'),
	(857, 55, 24, 10, 'The diaphoretic chest remedies can be considered stimulant in action', NULL, '2026-03-22 21:15:30.207896+00'),
	(858, 55, 24, 11, 'As already discussed, bitters may be considered stimulants', NULL, '2026-03-22 21:15:30.209142+00'),
	(859, 119, 24, 9, 'Stimulant actions must be used with care in people with cardiovascular problems, but if applied with knowledge, appropriate stimulation can often aid and support an ailing heart', NULL, '2026-03-22 21:15:30.210241+00'),
	(860, 119, 24, 11, 'As already discussed, bitters may be considered stimulants', NULL, '2026-03-22 21:15:30.211332+00'),
	(861, 215, 24, 9, 'Stimulant actions must be used with care in people with cardiovascular problems, but if applied with knowledge, appropriate stimulation can often aid and support an ailing heart', NULL, '2026-03-22 21:15:30.212641+00'),
	(862, 195, 24, NULL, NULL, NULL, '2026-03-22 21:15:30.213898+00'),
	(863, 204, 24, NULL, NULL, NULL, '2026-03-22 21:15:30.215146+00'),
	(864, 205, 24, NULL, NULL, NULL, '2026-03-22 21:15:30.216373+00'),
	(865, 109, 24, 9, 'Stimulant actions must be used with care in people with cardiovascular problems, but if applied with knowledge, appropriate stimulation can often aid and support an ailing heart', NULL, '2026-03-22 21:15:30.217618+00'),
	(866, 109, 24, 11, 'As already discussed, bitters may be considered stimulants', NULL, '2026-03-22 21:15:30.218857+00'),
	(867, 109, 24, 13, 'Stimulants for this system usually act as emmenagogues, and so should not be used during pregnancy. Important examples include this.', NULL, '2026-03-22 21:15:30.220065+00'),
	(868, 110, 24, 9, 'Stimulant actions must be used with care in people with cardiovascular problems, but if applied with knowledge, appropriate stimulation can often aid and support an ailing heart', NULL, '2026-03-22 21:15:30.221555+00'),
	(869, 110, 24, 11, 'As already discussed, bitters may be considered stimulants', NULL, '2026-03-22 21:15:30.222881+00'),
	(870, 110, 24, 13, 'Stimulants for this system usually act as emmenagogues, and so should not be used during pregnancy. Important examples include this.', NULL, '2026-03-22 21:15:30.224683+00'),
	(871, 38, 24, NULL, NULL, NULL, '2026-03-22 21:15:30.225975+00'),
	(872, 216, 24, NULL, NULL, NULL, '2026-03-22 21:15:30.2274+00'),
	(873, 161, 24, 13, 'Stimulants for this system usually act as emmenagogues, and so should not be used during pregnancy. Important examples include this.', NULL, '2026-03-22 21:15:30.228678+00'),
	(874, 123, 24, 9, 'Stimulant actions must be used with care in people with cardiovascular problems, but if applied with knowledge, appropriate stimulation can often aid and support an ailing heart', NULL, '2026-03-22 21:15:30.230056+00'),
	(875, 124, 24, 14, 'a stimulant of peripheral circulation. In general, rubefacient remedies are stimulants.', NULL, '2026-03-22 21:15:30.23125+00'),
	(876, 217, 24, 15, NULL, NULL, '2026-03-22 21:15:30.232484+00'),
	(877, 149, 24, 15, NULL, NULL, '2026-03-22 21:15:30.233726+00'),
	(879, 218, 24, 15, NULL, NULL, '2026-03-22 21:15:30.236356+00');


--
-- Data for Name: secondary_actions; Type: TABLE DATA; Schema: herbal; Owner: postgres
--

INSERT INTO "herbal"."secondary_actions" ("id", "name", "created_at") VALUES
	(35, 'Anticatarrhal', '2026-03-22 21:15:28.855694+00'),
	(36, 'Anti-inflammatory', '2026-03-22 21:15:28.855694+00'),
	(37, 'Antimicrobial', '2026-03-22 21:15:28.855694+00'),
	(38, 'Antispasmodic', '2026-03-22 21:15:28.855694+00'),
	(39, 'Astringent', '2026-03-22 21:15:28.855694+00'),
	(40, 'Bitter', '2026-03-22 21:15:28.855694+00'),
	(41, 'Diaphoretic', '2026-03-22 21:15:28.855694+00'),
	(42, 'Diuretic', '2026-03-22 21:15:28.855694+00'),
	(43, 'Emmenagogue', '2026-03-22 21:15:28.855694+00'),
	(44, 'Expectorant', '2026-03-22 21:15:28.855694+00'),
	(45, 'Hepatic', '2026-03-22 21:15:28.855694+00'),
	(46, 'Hypotensive', '2026-03-22 21:15:28.855694+00'),
	(47, 'Nervine', '2026-03-22 21:15:28.855694+00'),
	(48, 'Vulnerary', '2026-03-22 21:15:28.855694+00'),
	(49, 'Alterative', '2026-03-22 21:15:28.855694+00'),
	(50, 'Carminative', '2026-03-22 21:15:28.855694+00'),
	(51, 'Demulcent', '2026-03-22 21:15:28.855694+00'),
	(52, 'Laxative', '2026-03-22 21:15:28.855694+00'),
	(53, 'Tonic', '2026-03-22 21:15:28.855694+00'),
	(54, 'Cholagogue', '2026-03-22 21:15:28.855694+00'),
	(55, 'Circulatory stimulant', '2026-03-22 21:15:28.855694+00'),
	(56, 'Other action (or basis unclear)', '2026-03-22 21:15:28.855694+00'),
	(57, 'Analgesic', '2026-03-22 21:15:28.855694+00'),
	(58, 'Hypnotic', '2026-03-22 21:15:28.855694+00'),
	(59, 'Nervine relaxant', '2026-03-22 21:15:28.855694+00'),
	(60, 'Galactagogue', '2026-03-22 21:15:28.855694+00'),
	(61, 'Rubefacient', '2026-03-22 21:15:28.855694+00'),
	(62, 'Cardioactive', '2026-03-22 21:15:28.855694+00'),
	(63, 'Moderate', '2026-03-22 21:15:28.855694+00'),
	(64, 'Adaptogen', '2026-03-22 21:15:28.855694+00'),
	(65, 'Cardiotonic', '2026-03-22 21:15:28.855694+00');


--
-- Data for Name: herb_secondary_actions; Type: TABLE DATA; Schema: herbal; Owner: postgres
--

INSERT INTO "herbal"."herb_secondary_actions" ("id", "herb_id", "secondary_action_id", "created_at") VALUES
	(12, 21, 35, '2026-03-22 21:15:30.237944+00'),
	(13, 23, 35, '2026-03-22 21:15:30.239783+00'),
	(14, 26, 35, '2026-03-22 21:15:30.241087+00'),
	(15, 30, 35, '2026-03-22 21:15:30.242335+00'),
	(16, 35, 35, '2026-03-22 21:15:30.243679+00'),
	(17, 43, 35, '2026-03-22 21:15:30.245109+00'),
	(18, 28, 36, '2026-03-22 21:15:30.246545+00'),
	(19, 29, 36, '2026-03-22 21:15:30.247823+00'),
	(20, 30, 36, '2026-03-22 21:15:30.249152+00'),
	(21, 31, 36, '2026-03-22 21:15:30.250341+00'),
	(22, 34, 36, '2026-03-22 21:15:30.251477+00'),
	(23, 40, 36, '2026-03-22 21:15:30.252606+00'),
	(24, 21, 37, '2026-03-22 21:15:30.253966+00'),
	(25, 23, 37, '2026-03-22 21:15:30.255441+00'),
	(26, 26, 37, '2026-03-22 21:15:30.256656+00'),
	(27, 30, 37, '2026-03-22 21:15:30.257857+00'),
	(28, 32, 37, '2026-03-22 21:15:30.259036+00'),
	(29, 35, 37, '2026-03-22 21:15:30.260281+00'),
	(30, 36, 37, '2026-03-22 21:15:30.261616+00'),
	(31, 38, 37, '2026-03-22 21:15:30.262876+00'),
	(32, 21, 38, '2026-03-22 21:15:30.264071+00'),
	(33, 25, 38, '2026-03-22 21:15:30.265339+00'),
	(34, 36, 38, '2026-03-22 21:15:30.266543+00'),
	(35, 38, 38, '2026-03-22 21:15:30.267865+00'),
	(36, 42, 38, '2026-03-22 21:15:30.268975+00'),
	(37, 30, 39, '2026-03-22 21:15:30.270233+00'),
	(38, 43, 39, '2026-03-22 21:15:30.271331+00'),
	(39, 22, 40, '2026-03-22 21:15:30.272573+00'),
	(40, 30, 40, '2026-03-22 21:15:30.273903+00'),
	(41, 34, 40, '2026-03-22 21:15:30.275155+00'),
	(42, 21, 41, '2026-03-22 21:15:30.276674+00'),
	(43, 29, 41, '2026-03-22 21:15:30.277981+00'),
	(44, 41, 41, '2026-03-22 21:15:30.279228+00'),
	(45, 40, 41, '2026-03-22 21:15:30.280505+00'),
	(46, 22, 42, '2026-03-22 21:15:30.281979+00'),
	(47, 28, 42, '2026-03-22 21:15:30.283447+00'),
	(48, 29, 42, '2026-03-22 21:15:30.284864+00'),
	(49, 31, 42, '2026-03-22 21:15:30.286261+00'),
	(50, 34, 42, '2026-03-22 21:15:30.287426+00'),
	(51, 40, 42, '2026-03-22 21:15:30.288578+00'),
	(52, 43, 42, '2026-03-22 21:15:30.289814+00'),
	(53, 25, 43, '2026-03-22 21:15:30.291071+00'),
	(54, 38, 44, '2026-03-22 21:15:30.292474+00'),
	(55, 42, 44, '2026-03-22 21:15:30.293746+00'),
	(56, 21, 45, '2026-03-22 21:15:30.29487+00'),
	(57, 22, 45, '2026-03-22 21:15:30.296069+00'),
	(58, 24, 45, '2026-03-22 21:15:30.297507+00'),
	(59, 30, 45, '2026-03-22 21:15:30.298693+00'),
	(60, 31, 45, '2026-03-22 21:15:30.299885+00'),
	(61, 33, 45, '2026-03-22 21:15:30.301094+00'),
	(62, 34, 45, '2026-03-22 21:15:30.302268+00'),
	(63, 35, 45, '2026-03-22 21:15:30.303601+00'),
	(64, 37, 45, '2026-03-22 21:15:30.304977+00'),
	(65, 21, 46, '2026-03-22 21:15:30.306271+00'),
	(66, 25, 46, '2026-03-22 21:15:30.307596+00'),
	(67, 43, 46, '2026-03-22 21:15:30.308841+00'),
	(68, 25, 47, '2026-03-22 21:15:30.309991+00'),
	(69, 36, 47, '2026-03-22 21:15:30.31114+00'),
	(70, 42, 47, '2026-03-22 21:15:30.312387+00'),
	(71, 28, 48, '2026-03-22 21:15:30.313665+00'),
	(72, 30, 48, '2026-03-22 21:15:30.314881+00'),
	(73, 21, 49, '2026-03-22 21:15:30.316148+00'),
	(74, 23, 49, '2026-03-22 21:15:30.317438+00'),
	(75, 26, 49, '2026-03-22 21:15:30.318736+00'),
	(76, 30, 49, '2026-03-22 21:15:30.32006+00'),
	(77, 61, 49, '2026-03-22 21:15:30.321249+00'),
	(78, 51, 36, '2026-03-22 21:15:30.322477+00'),
	(79, 52, 36, '2026-03-22 21:15:30.323628+00'),
	(81, 58, 36, '2026-03-22 21:15:30.326085+00'),
	(82, 44, 37, '2026-03-22 21:15:30.327256+00'),
	(84, 46, 37, '2026-03-22 21:15:30.329647+00'),
	(86, 47, 37, '2026-03-22 21:15:30.336261+00'),
	(88, 54, 37, '2026-03-22 21:15:30.338998+00'),
	(89, 55, 37, '2026-03-22 21:15:30.340425+00'),
	(90, 56, 37, '2026-03-22 21:15:30.341903+00'),
	(91, 58, 37, '2026-03-22 21:15:30.34327+00'),
	(92, 59, 37, '2026-03-22 21:15:30.344646+00'),
	(94, 50, 38, '2026-03-22 21:15:30.347583+00'),
	(95, 53, 38, '2026-03-22 21:15:30.349038+00'),
	(96, 55, 38, '2026-03-22 21:15:30.350367+00'),
	(97, 56, 38, '2026-03-22 21:15:30.351595+00'),
	(98, 59, 38, '2026-03-22 21:15:30.352755+00'),
	(99, 44, 39, '2026-03-22 21:15:30.353867+00'),
	(100, 46, 39, '2026-03-22 21:15:30.355062+00'),
	(101, 51, 39, '2026-03-22 21:15:30.356186+00'),
	(102, 52, 39, '2026-03-22 21:15:30.357365+00'),
	(104, 56, 39, '2026-03-22 21:15:30.359693+00'),
	(105, 59, 39, '2026-03-22 21:15:30.360898+00'),
	(106, 44, 40, '2026-03-22 21:15:30.362202+00'),
	(107, 50, 40, '2026-03-22 21:15:30.363407+00'),
	(109, 47, 50, '2026-03-22 21:15:30.365869+00'),
	(110, 53, 50, '2026-03-22 21:15:30.367054+00'),
	(111, 55, 50, '2026-03-22 21:15:30.368351+00'),
	(112, 56, 50, '2026-03-22 21:15:30.369606+00'),
	(113, 58, 50, '2026-03-22 21:15:30.370649+00'),
	(114, 59, 50, '2026-03-22 21:15:30.371708+00'),
	(115, 45, 51, '2026-03-22 21:15:30.372864+00'),
	(116, 46, 51, '2026-03-22 21:15:30.37401+00'),
	(117, 48, 51, '2026-03-22 21:15:30.375243+00'),
	(118, 49, 51, '2026-03-22 21:15:30.376478+00'),
	(119, 60, 51, '2026-03-22 21:15:30.377825+00'),
	(120, 61, 51, '2026-03-22 21:15:30.379042+00'),
	(121, 44, 41, '2026-03-22 21:15:30.38025+00'),
	(123, 50, 41, '2026-03-22 21:15:30.382751+00'),
	(124, 53, 41, '2026-03-22 21:15:30.384028+00'),
	(125, 54, 41, '2026-03-22 21:15:30.385221+00'),
	(126, 55, 41, '2026-03-22 21:15:30.386333+00'),
	(127, 57, 41, '2026-03-22 21:15:30.387578+00'),
	(128, 58, 41, '2026-03-22 21:15:30.389274+00'),
	(129, 44, 42, '2026-03-22 21:15:30.390477+00'),
	(130, 45, 42, '2026-03-22 21:15:30.392691+00'),
	(131, 46, 42, '2026-03-22 21:15:30.393847+00'),
	(132, 57, 42, '2026-03-22 21:15:30.395043+00'),
	(133, 58, 42, '2026-03-22 21:15:30.396527+00'),
	(134, 60, 42, '2026-03-22 21:15:30.397759+00'),
	(135, 61, 42, '2026-03-22 21:15:30.398968+00'),
	(136, 44, 43, '2026-03-22 21:15:30.400194+00'),
	(137, 50, 43, '2026-03-22 21:15:30.401305+00'),
	(138, 56, 43, '2026-03-22 21:15:30.402581+00'),
	(139, 59, 43, '2026-03-22 21:15:30.403801+00'),
	(140, 45, 44, '2026-03-22 21:15:30.405023+00'),
	(141, 48, 44, '2026-03-22 21:15:30.406196+00'),
	(142, 49, 44, '2026-03-22 21:15:30.407374+00'),
	(143, 53, 44, '2026-03-22 21:15:30.408586+00'),
	(144, 57, 44, '2026-03-22 21:15:30.410006+00'),
	(145, 59, 44, '2026-03-22 21:15:30.41106+00'),
	(146, 60, 44, '2026-03-22 21:15:30.412247+00'),
	(147, 61, 44, '2026-03-22 21:15:30.413401+00'),
	(149, 50, 45, '2026-03-22 21:15:30.41607+00'),
	(151, 44, 46, '2026-03-22 21:15:30.418542+00'),
	(153, 50, 52, '2026-03-22 21:15:30.420916+00'),
	(154, 30, 52, '2026-03-22 21:15:30.422236+00'),
	(155, 57, 52, '2026-03-22 21:15:30.42353+00'),
	(156, 53, 47, '2026-03-22 21:15:30.42469+00'),
	(157, 44, 53, '2026-03-22 21:15:30.425897+00'),
	(158, 47, 53, '2026-03-22 21:15:30.427072+00'),
	(159, 26, 53, '2026-03-22 21:15:30.428213+00'),
	(160, 50, 53, '2026-03-22 21:15:30.429424+00'),
	(161, 30, 53, '2026-03-22 21:15:30.43051+00'),
	(162, 45, 48, '2026-03-22 21:15:30.431649+00'),
	(163, 52, 48, '2026-03-22 21:15:30.433289+00'),
	(164, 57, 48, '2026-03-22 21:15:30.434667+00'),
	(165, 61, 48, '2026-03-22 21:15:30.435897+00'),
	(166, 44, 35, '2026-03-22 21:15:30.437163+00'),
	(167, 45, 35, '2026-03-22 21:15:30.4385+00'),
	(168, 48, 35, '2026-03-22 21:15:30.439871+00'),
	(169, 49, 35, '2026-03-22 21:15:30.441725+00'),
	(170, 52, 35, '2026-03-22 21:15:30.443197+00'),
	(172, 53, 35, '2026-03-22 21:15:30.445851+00'),
	(173, 55, 35, '2026-03-22 21:15:30.447607+00'),
	(174, 56, 35, '2026-03-22 21:15:30.449194+00'),
	(175, 57, 35, '2026-03-22 21:15:30.450553+00'),
	(176, 58, 35, '2026-03-22 21:15:30.453817+00'),
	(177, 60, 35, '2026-03-22 21:15:30.455799+00'),
	(178, 61, 35, '2026-03-22 21:15:30.459814+00'),
	(180, 70, 37, '2026-03-22 21:15:30.463779+00'),
	(182, 81, 37, '2026-03-22 21:15:30.467779+00'),
	(183, 84, 37, '2026-03-22 21:15:30.469051+00'),
	(185, 86, 37, '2026-03-22 21:15:30.472945+00'),
	(188, 64, 38, '2026-03-22 21:15:30.480205+00'),
	(189, 65, 38, '2026-03-22 21:15:30.483209+00'),
	(190, 66, 38, '2026-03-22 21:15:30.48601+00'),
	(191, 67, 38, '2026-03-22 21:15:30.488111+00'),
	(193, 74, 38, '2026-03-22 21:15:30.493284+00'),
	(194, 76, 38, '2026-03-22 21:15:30.495899+00'),
	(195, 78, 38, '2026-03-22 21:15:30.498448+00'),
	(196, 81, 38, '2026-03-22 21:15:30.501339+00'),
	(198, 82, 38, '2026-03-22 21:15:30.507946+00'),
	(199, 84, 38, '2026-03-22 21:15:30.510536+00'),
	(201, 86, 38, '2026-03-22 21:15:30.515522+00'),
	(203, 57, 38, '2026-03-22 21:15:30.519484+00'),
	(204, 90, 38, '2026-03-22 21:15:30.523454+00'),
	(205, 91, 38, '2026-03-22 21:15:30.526704+00'),
	(206, 61, 38, '2026-03-22 21:15:30.529668+00'),
	(207, 93, 38, '2026-03-22 21:15:30.532339+00'),
	(208, 94, 38, '2026-03-22 21:15:30.535068+00'),
	(210, 62, 39, '2026-03-22 21:15:30.53924+00'),
	(211, 63, 39, '2026-03-22 21:15:30.543064+00'),
	(212, 70, 39, '2026-03-22 21:15:30.546599+00'),
	(213, 71, 39, '2026-03-22 21:15:30.549406+00'),
	(214, 75, 39, '2026-03-22 21:15:30.551811+00'),
	(216, 79, 39, '2026-03-22 21:15:30.557233+00'),
	(218, 85, 39, '2026-03-22 21:15:30.561719+00'),
	(219, 86, 39, '2026-03-22 21:15:30.563714+00'),
	(221, 58, 39, '2026-03-22 21:15:30.569054+00'),
	(222, 89, 39, '2026-03-22 21:15:30.571996+00'),
	(223, 90, 39, '2026-03-22 21:15:30.574221+00'),
	(224, 61, 39, '2026-03-22 21:15:30.576359+00'),
	(227, 84, 40, '2026-03-22 21:15:30.582073+00'),
	(228, 44, 50, '2026-03-22 21:15:30.585308+00'),
	(229, 64, 50, '2026-03-22 21:15:30.588283+00'),
	(230, 65, 50, '2026-03-22 21:15:30.591277+00'),
	(231, 66, 50, '2026-03-22 21:15:30.594573+00'),
	(232, 75, 50, '2026-03-22 21:15:30.59828+00'),
	(233, 76, 50, '2026-03-22 21:15:30.600942+00'),
	(234, 78, 50, '2026-03-22 21:15:30.604285+00'),
	(236, 82, 50, '2026-03-22 21:15:30.607245+00'),
	(237, 84, 50, '2026-03-22 21:15:30.608863+00'),
	(241, 90, 50, '2026-03-22 21:15:30.613455+00'),
	(242, 91, 50, '2026-03-22 21:15:30.615929+00'),
	(243, 70, 54, '2026-03-22 21:15:30.617811+00'),
	(244, 74, 54, '2026-03-22 21:15:30.623887+00'),
	(245, 30, 54, '2026-03-22 21:15:30.625723+00'),
	(246, 34, 54, '2026-03-22 21:15:30.627563+00'),
	(250, 78, 51, '2026-03-22 21:15:30.633807+00'),
	(251, 83, 51, '2026-03-22 21:15:30.635412+00'),
	(252, 88, 51, '2026-03-22 21:15:30.636762+00'),
	(253, 89, 51, '2026-03-22 21:15:30.638188+00'),
	(254, 91, 51, '2026-03-22 21:15:30.639521+00'),
	(255, 92, 51, '2026-03-22 21:15:30.64092+00'),
	(257, 95, 51, '2026-03-22 21:15:30.643788+00'),
	(259, 65, 41, '2026-03-22 21:15:30.646412+00'),
	(260, 67, 41, '2026-03-22 21:15:30.64784+00'),
	(266, 90, 41, '2026-03-22 21:15:30.655096+00'),
	(268, 63, 42, '2026-03-22 21:15:30.657314+00'),
	(269, 66, 42, '2026-03-22 21:15:30.658758+00'),
	(270, 73, 42, '2026-03-22 21:15:30.660058+00'),
	(273, 85, 42, '2026-03-22 21:15:30.663729+00'),
	(276, 90, 42, '2026-03-22 21:15:30.667337+00'),
	(277, 95, 42, '2026-03-22 21:15:30.668615+00'),
	(279, 63, 43, '2026-03-22 21:15:30.671173+00'),
	(280, 70, 43, '2026-03-22 21:15:30.67252+00'),
	(281, 72, 43, '2026-03-22 21:15:30.674367+00'),
	(283, 30, 43, '2026-03-22 21:15:30.677548+00'),
	(284, 53, 43, '2026-03-22 21:15:30.679779+00'),
	(285, 82, 43, '2026-03-22 21:15:30.683888+00'),
	(287, 90, 43, '2026-03-22 21:15:30.687145+00'),
	(288, 93, 43, '2026-03-22 21:15:30.688708+00'),
	(289, 94, 43, '2026-03-22 21:15:30.690127+00'),
	(291, 67, 44, '2026-03-22 21:15:30.692886+00'),
	(294, 78, 44, '2026-03-22 21:15:30.696919+00'),
	(295, 30, 44, '2026-03-22 21:15:30.698441+00'),
	(297, 83, 44, '2026-03-22 21:15:30.700884+00'),
	(298, 85, 44, '2026-03-22 21:15:30.702103+00'),
	(302, 44, 45, '2026-03-22 21:15:30.706738+00'),
	(303, 70, 45, '2026-03-22 21:15:30.707938+00'),
	(304, 74, 45, '2026-03-22 21:15:30.709169+00'),
	(305, 76, 45, '2026-03-22 21:15:30.710436+00'),
	(306, 78, 45, '2026-03-22 21:15:30.711624+00'),
	(308, 53, 45, '2026-03-22 21:15:30.713957+00'),
	(310, 91, 45, '2026-03-22 21:15:30.716727+00'),
	(312, 78, 52, '2026-03-22 21:15:30.719139+00'),
	(313, 66, 47, '2026-03-22 21:15:30.720415+00'),
	(314, 69, 47, '2026-03-22 21:15:30.721604+00'),
	(316, 81, 47, '2026-03-22 21:15:30.723781+00'),
	(318, 82, 47, '2026-03-22 21:15:30.726202+00'),
	(319, 84, 47, '2026-03-22 21:15:30.72749+00'),
	(320, 55, 47, '2026-03-22 21:15:30.72871+00'),
	(321, 90, 47, '2026-03-22 21:15:30.729928+00'),
	(322, 94, 47, '2026-03-22 21:15:30.731009+00'),
	(324, 25, 53, '2026-03-22 21:15:30.73317+00'),
	(325, 73, 53, '2026-03-22 21:15:30.734457+00'),
	(326, 75, 53, '2026-03-22 21:15:30.735696+00'),
	(328, 81, 53, '2026-03-22 21:15:30.738142+00'),
	(329, 61, 53, '2026-03-22 21:15:30.739427+00'),
	(330, 44, 48, '2026-03-22 21:15:30.740551+00'),
	(331, 63, 48, '2026-03-22 21:15:30.741724+00'),
	(333, 70, 48, '2026-03-22 21:15:30.744524+00'),
	(334, 75, 48, '2026-03-22 21:15:30.745808+00'),
	(335, 79, 48, '2026-03-22 21:15:30.747427+00'),
	(336, 81, 48, '2026-03-22 21:15:30.748811+00'),
	(337, 53, 48, '2026-03-22 21:15:30.750073+00'),
	(338, 83, 48, '2026-03-22 21:15:30.75115+00'),
	(339, 84, 48, '2026-03-22 21:15:30.752305+00'),
	(340, 85, 48, '2026-03-22 21:15:30.753473+00'),
	(341, 88, 48, '2026-03-22 21:15:30.754622+00'),
	(342, 89, 48, '2026-03-22 21:15:30.75593+00'),
	(347, 54, 49, '2026-03-22 21:15:30.797326+00'),
	(349, 46, 35, '2026-03-22 21:15:30.804001+00'),
	(351, 47, 35, '2026-03-22 21:15:30.807008+00'),
	(353, 101, 35, '2026-03-22 21:15:30.809682+00'),
	(355, 54, 35, '2026-03-22 21:15:30.81234+00'),
	(357, 105, 35, '2026-03-22 21:15:30.816606+00'),
	(359, 59, 35, '2026-03-22 21:15:30.820482+00'),
	(360, 97, 36, '2026-03-22 21:15:30.821953+00'),
	(361, 70, 36, '2026-03-22 21:15:30.823367+00'),
	(362, 81, 36, '2026-03-22 21:15:30.824592+00'),
	(363, 55, 36, '2026-03-22 21:15:30.825843+00'),
	(364, 85, 36, '2026-03-22 21:15:30.827119+00'),
	(366, 98, 38, '2026-03-22 21:15:30.868063+00'),
	(369, 108, 38, '2026-03-22 21:15:30.871739+00'),
	(370, 109, 38, '2026-03-22 21:15:30.872948+00'),
	(371, 110, 38, '2026-03-22 21:15:30.874124+00'),
	(376, 98, 39, '2026-03-22 21:15:30.879492+00'),
	(377, 99, 39, '2026-03-22 21:15:30.880661+00'),
	(379, 109, 39, '2026-03-22 21:15:30.883573+00'),
	(383, 96, 40, '2026-03-22 21:15:30.887899+00'),
	(384, 97, 40, '2026-03-22 21:15:30.889128+00'),
	(385, 102, 40, '2026-03-22 21:15:30.890265+00'),
	(387, 110, 40, '2026-03-22 21:15:30.892562+00'),
	(388, 97, 50, '2026-03-22 21:15:30.893812+00'),
	(390, 98, 50, '2026-03-22 21:15:30.895965+00'),
	(391, 99, 50, '2026-03-22 21:15:30.897054+00'),
	(392, 100, 50, '2026-03-22 21:15:30.898208+00'),
	(393, 103, 50, '2026-03-22 21:15:30.899303+00'),
	(395, 108, 50, '2026-03-22 21:15:30.901531+00'),
	(396, 109, 50, '2026-03-22 21:15:30.902773+00'),
	(398, 111, 50, '2026-03-22 21:15:30.904768+00'),
	(401, 85, 51, '2026-03-22 21:15:30.907825+00'),
	(404, 23, 41, '2026-03-22 21:15:30.911045+00'),
	(405, 47, 41, '2026-03-22 21:15:30.912277+00'),
	(408, 107, 41, '2026-03-22 21:15:30.915843+00'),
	(411, 101, 42, '2026-03-22 21:15:30.920073+00'),
	(412, 103, 42, '2026-03-22 21:15:30.921193+00'),
	(415, 96, 43, '2026-03-22 21:15:30.924876+00'),
	(416, 97, 43, '2026-03-22 21:15:30.925983+00'),
	(418, 98, 43, '2026-03-22 21:15:30.928222+00'),
	(419, 102, 43, '2026-03-22 21:15:30.929333+00'),
	(421, 107, 43, '2026-03-22 21:15:30.93142+00'),
	(422, 109, 43, '2026-03-22 21:15:30.932547+00'),
	(423, 110, 43, '2026-03-22 21:15:30.933599+00'),
	(425, 98, 44, '2026-03-22 21:15:30.935611+00'),
	(426, 99, 44, '2026-03-22 21:15:30.936672+00'),
	(427, 101, 44, '2026-03-22 21:15:30.937858+00'),
	(428, 54, 44, '2026-03-22 21:15:30.93887+00'),
	(429, 104, 44, '2026-03-22 21:15:30.939995+00'),
	(430, 105, 44, '2026-03-22 21:15:30.941213+00'),
	(431, 107, 44, '2026-03-22 21:15:30.942429+00'),
	(432, 108, 44, '2026-03-22 21:15:30.943483+00'),
	(434, 110, 44, '2026-03-22 21:15:30.945902+00'),
	(437, 96, 45, '2026-03-22 21:15:30.949262+00'),
	(439, 102, 45, '2026-03-22 21:15:30.952129+00'),
	(441, 54, 45, '2026-03-22 21:15:30.954497+00'),
	(442, 110, 45, '2026-03-22 21:15:30.956151+00'),
	(445, 106, 46, '2026-03-22 21:15:30.961987+00'),
	(446, 44, 52, '2026-03-22 21:15:30.963666+00'),
	(447, 96, 52, '2026-03-22 21:15:30.964961+00'),
	(448, 97, 52, '2026-03-22 21:15:30.966263+00'),
	(449, 102, 52, '2026-03-22 21:15:30.968635+00'),
	(451, 110, 52, '2026-03-22 21:15:30.974037+00'),
	(454, 109, 47, '2026-03-22 21:15:30.980245+00'),
	(456, 21, 53, '2026-03-22 21:15:30.983629+00'),
	(457, 97, 53, '2026-03-22 21:15:30.985263+00'),
	(458, 70, 53, '2026-03-22 21:15:30.986806+00'),
	(461, 102, 53, '2026-03-22 21:15:30.992783+00'),
	(464, 54, 53, '2026-03-22 21:15:30.999164+00'),
	(465, 110, 53, '2026-03-22 21:15:31.001097+00'),
	(468, 99, 48, '2026-03-22 21:15:31.008312+00'),
	(472, 65, 36, '2026-03-22 21:15:31.016509+00'),
	(473, 66, 36, '2026-03-22 21:15:31.01865+00'),
	(474, 68, 36, '2026-03-22 21:15:31.021582+00'),
	(475, 74, 36, '2026-03-22 21:15:31.025442+00'),
	(476, 75, 36, '2026-03-22 21:15:31.028164+00'),
	(477, 77, 36, '2026-03-22 21:15:31.03+00'),
	(479, 80, 36, '2026-03-22 21:15:31.033043+00'),
	(481, 86, 36, '2026-03-22 21:15:31.036149+00'),
	(482, 121, 36, '2026-03-22 21:15:31.037646+00'),
	(483, 22, 49, '2026-03-22 21:15:31.039142+00'),
	(484, 33, 49, '2026-03-22 21:15:31.045656+00'),
	(485, 118, 49, '2026-03-22 21:15:31.047665+00'),
	(486, 29, 49, '2026-03-22 21:15:31.049422+00'),
	(487, 80, 49, '2026-03-22 21:15:31.050783+00'),
	(488, 31, 49, '2026-03-22 21:15:31.052126+00'),
	(489, 34, 49, '2026-03-22 21:15:31.053438+00'),
	(490, 35, 49, '2026-03-22 21:15:31.054909+00'),
	(491, 37, 49, '2026-03-22 21:15:31.056559+00'),
	(492, 40, 49, '2026-03-22 21:15:31.057926+00'),
	(493, 43, 49, '2026-03-22 21:15:31.059193+00'),
	(497, 50, 42, '2026-03-22 21:15:31.064107+00'),
	(498, 117, 42, '2026-03-22 21:15:31.065548+00'),
	(500, 120, 42, '2026-03-22 21:15:31.068072+00'),
	(501, 122, 42, '2026-03-22 21:15:31.069457+00'),
	(502, 113, 55, '2026-03-22 21:15:31.070525+00'),
	(503, 116, 55, '2026-03-22 21:15:31.071541+00'),
	(504, 47, 55, '2026-03-22 21:15:31.072627+00'),
	(505, 119, 55, '2026-03-22 21:15:31.073707+00'),
	(506, 109, 55, '2026-03-22 21:15:31.074936+00'),
	(507, 123, 55, '2026-03-22 21:15:31.076209+00'),
	(508, 124, 55, '2026-03-22 21:15:31.077451+00'),
	(511, 114, 56, '2026-03-22 21:15:31.081355+00'),
	(512, 97, 56, '2026-03-22 21:15:31.082804+00'),
	(513, 115, 56, '2026-03-22 21:15:31.084064+00'),
	(514, 72, 56, '2026-03-22 21:15:31.085288+00'),
	(515, 25, 49, '2026-03-22 21:15:31.086496+00'),
	(516, 42, 49, '2026-03-22 21:15:31.087716+00'),
	(517, 25, 57, '2026-03-22 21:15:31.088957+00'),
	(518, 74, 57, '2026-03-22 21:15:31.090087+00'),
	(519, 128, 57, '2026-03-22 21:15:31.091142+00'),
	(520, 81, 57, '2026-03-22 21:15:31.092199+00'),
	(521, 130, 57, '2026-03-22 21:15:31.093245+00'),
	(522, 55, 57, '2026-03-22 21:15:31.094471+00'),
	(523, 137, 57, '2026-03-22 21:15:31.095692+00'),
	(524, 139, 57, '2026-03-22 21:15:31.097209+00'),
	(525, 145, 57, '2026-03-22 21:15:31.098432+00'),
	(527, 82, 35, '2026-03-22 21:15:31.100674+00'),
	(528, 84, 35, '2026-03-22 21:15:31.101977+00'),
	(530, 136, 35, '2026-03-22 21:15:31.104641+00'),
	(533, 90, 35, '2026-03-22 21:15:31.107743+00'),
	(534, 91, 35, '2026-03-22 21:15:31.108839+00'),
	(537, 124, 35, '2026-03-22 21:15:31.111992+00'),
	(541, 78, 36, '2026-03-22 21:15:31.117275+00'),
	(543, 53, 36, '2026-03-22 21:15:31.121031+00'),
	(544, 82, 36, '2026-03-22 21:15:31.122839+00'),
	(545, 84, 36, '2026-03-22 21:15:31.124367+00'),
	(546, 134, 36, '2026-03-22 21:15:31.125749+00'),
	(548, 57, 36, '2026-03-22 21:15:31.128362+00'),
	(549, 90, 36, '2026-03-22 21:15:31.129803+00'),
	(550, 60, 36, '2026-03-22 21:15:31.131395+00'),
	(551, 98, 37, '2026-03-22 21:15:31.133022+00'),
	(552, 126, 37, '2026-03-22 21:15:31.134818+00'),
	(553, 129, 37, '2026-03-22 21:15:31.136333+00'),
	(555, 82, 37, '2026-03-22 21:15:31.138795+00'),
	(558, 108, 37, '2026-03-22 21:15:31.143244+00'),
	(559, 138, 37, '2026-03-22 21:15:31.144719+00'),
	(560, 109, 37, '2026-03-22 21:15:31.146222+00'),
	(562, 129, 39, '2026-03-22 21:15:31.151013+00'),
	(563, 81, 39, '2026-03-22 21:15:31.152584+00'),
	(564, 133, 39, '2026-03-22 21:15:31.154511+00'),
	(565, 140, 39, '2026-03-22 21:15:31.156577+00'),
	(568, 93, 39, '2026-03-22 21:15:31.161643+00'),
	(569, 94, 39, '2026-03-22 21:15:31.163205+00'),
	(570, 115, 40, '2026-03-22 21:15:31.164648+00'),
	(571, 129, 40, '2026-03-22 21:15:31.166063+00'),
	(575, 115, 50, '2026-03-22 21:15:31.17119+00'),
	(577, 125, 50, '2026-03-22 21:15:31.173692+00'),
	(578, 127, 50, '2026-03-22 21:15:31.174947+00'),
	(580, 129, 50, '2026-03-22 21:15:31.177666+00'),
	(583, 131, 50, '2026-03-22 21:15:31.184086+00'),
	(585, 134, 50, '2026-03-22 21:15:31.187367+00'),
	(587, 135, 50, '2026-03-22 21:15:31.190068+00'),
	(588, 136, 50, '2026-03-22 21:15:31.191372+00'),
	(589, 120, 50, '2026-03-22 21:15:31.19272+00'),
	(591, 141, 50, '2026-03-22 21:15:31.195366+00'),
	(595, 145, 50, '2026-03-22 21:15:31.200649+00'),
	(596, 146, 50, '2026-03-22 21:15:31.201865+00'),
	(597, 124, 50, '2026-03-22 21:15:31.203051+00'),
	(598, 126, 51, '2026-03-22 21:15:31.204309+00'),
	(604, 25, 41, '2026-03-22 21:15:31.211424+00'),
	(607, 136, 41, '2026-03-22 21:15:31.214823+00'),
	(608, 109, 41, '2026-03-22 21:15:31.216249+00'),
	(610, 143, 41, '2026-03-22 21:15:31.218827+00'),
	(612, 146, 41, '2026-03-22 21:15:31.2212+00'),
	(613, 124, 41, '2026-03-22 21:15:31.222665+00'),
	(614, 65, 42, '2026-03-22 21:15:31.22395+00'),
	(615, 125, 42, '2026-03-22 21:15:31.225306+00'),
	(616, 133, 42, '2026-03-22 21:15:31.226775+00'),
	(617, 136, 42, '2026-03-22 21:15:31.227995+00'),
	(619, 138, 42, '2026-03-22 21:15:31.230355+00'),
	(622, 144, 42, '2026-03-22 21:15:31.235621+00'),
	(624, 115, 43, '2026-03-22 21:15:31.238038+00'),
	(627, 131, 43, '2026-03-22 21:15:31.241701+00'),
	(628, 135, 43, '2026-03-22 21:15:31.243894+00'),
	(629, 65, 44, '2026-03-22 21:15:31.245745+00'),
	(631, 125, 44, '2026-03-22 21:15:31.248615+00'),
	(632, 126, 44, '2026-03-22 21:15:31.250314+00'),
	(633, 76, 44, '2026-03-22 21:15:31.251802+00'),
	(635, 133, 44, '2026-03-22 21:15:31.254793+00'),
	(636, 136, 44, '2026-03-22 21:15:31.256189+00'),
	(637, 120, 44, '2026-03-22 21:15:31.257579+00'),
	(639, 143, 44, '2026-03-22 21:15:31.260301+00'),
	(641, 91, 44, '2026-03-22 21:15:31.263576+00'),
	(644, 146, 45, '2026-03-22 21:15:31.267959+00'),
	(645, 128, 58, '2026-03-22 21:15:31.269333+00'),
	(646, 129, 58, '2026-03-22 21:15:31.270576+00'),
	(647, 130, 58, '2026-03-22 21:15:31.271741+00'),
	(648, 84, 58, '2026-03-22 21:15:31.272863+00'),
	(649, 137, 58, '2026-03-22 21:15:31.273978+00'),
	(650, 138, 58, '2026-03-22 21:15:31.275143+00'),
	(651, 139, 58, '2026-03-22 21:15:31.276411+00'),
	(652, 90, 58, '2026-03-22 21:15:31.277628+00'),
	(653, 145, 58, '2026-03-22 21:15:31.279005+00'),
	(654, 131, 46, '2026-03-22 21:15:31.280344+00'),
	(655, 137, 46, '2026-03-22 21:15:31.281974+00'),
	(656, 142, 46, '2026-03-22 21:15:31.283531+00'),
	(657, 90, 46, '2026-03-22 21:15:31.28485+00'),
	(658, 145, 46, '2026-03-22 21:15:31.286106+00'),
	(659, 25, 59, '2026-03-22 21:15:31.287288+00'),
	(660, 128, 59, '2026-03-22 21:15:31.288765+00'),
	(661, 129, 59, '2026-03-22 21:15:31.290097+00'),
	(662, 81, 59, '2026-03-22 21:15:31.291226+00'),
	(663, 53, 59, '2026-03-22 21:15:31.292472+00'),
	(664, 130, 59, '2026-03-22 21:15:31.293605+00'),
	(665, 82, 59, '2026-03-22 21:15:31.294877+00'),
	(666, 131, 59, '2026-03-22 21:15:31.29623+00'),
	(667, 132, 59, '2026-03-22 21:15:31.297568+00'),
	(668, 133, 59, '2026-03-22 21:15:31.298658+00'),
	(669, 84, 59, '2026-03-22 21:15:31.299872+00'),
	(670, 134, 59, '2026-03-22 21:15:31.301051+00'),
	(671, 55, 59, '2026-03-22 21:15:31.302177+00'),
	(672, 136, 59, '2026-03-22 21:15:31.303441+00'),
	(673, 137, 59, '2026-03-22 21:15:31.304661+00'),
	(674, 138, 59, '2026-03-22 21:15:31.305922+00'),
	(675, 139, 59, '2026-03-22 21:15:31.307114+00'),
	(676, 140, 59, '2026-03-22 21:15:31.308604+00'),
	(677, 142, 59, '2026-03-22 21:15:31.310177+00'),
	(678, 90, 59, '2026-03-22 21:15:31.311631+00'),
	(679, 145, 59, '2026-03-22 21:15:31.31342+00'),
	(680, 93, 59, '2026-03-22 21:15:31.31524+00'),
	(681, 94, 59, '2026-03-22 21:15:31.31708+00'),
	(682, 115, 53, '2026-03-22 21:15:31.318688+00'),
	(684, 142, 53, '2026-03-22 21:15:31.321595+00'),
	(685, 91, 53, '2026-03-22 21:15:31.322969+00'),
	(686, 144, 53, '2026-03-22 21:15:31.328758+00'),
	(687, 60, 53, '2026-03-22 21:15:31.330525+00'),
	(688, 146, 53, '2026-03-22 21:15:31.331779+00'),
	(689, 136, 48, '2026-03-22 21:15:31.332932+00'),
	(693, 91, 48, '2026-03-22 21:15:31.337706+00'),
	(697, 51, 35, '2026-03-22 21:15:31.342366+00'),
	(700, 152, 35, '2026-03-22 21:15:31.34606+00'),
	(707, 79, 36, '2026-03-22 21:15:31.354159+00'),
	(709, 152, 36, '2026-03-22 21:15:31.35805+00'),
	(710, 153, 36, '2026-03-22 21:15:31.360198+00'),
	(714, 147, 37, '2026-03-22 21:15:31.367528+00'),
	(716, 153, 37, '2026-03-22 21:15:31.370195+00'),
	(720, 133, 38, '2026-03-22 21:15:31.375078+00'),
	(721, 140, 38, '2026-03-22 21:15:31.376624+00'),
	(725, 148, 40, '2026-03-22 21:15:31.381447+00'),
	(726, 140, 40, '2026-03-22 21:15:31.382752+00'),
	(733, 119, 41, '2026-03-22 21:15:31.390868+00'),
	(736, 148, 42, '2026-03-22 21:15:31.394361+00'),
	(738, 150, 42, '2026-03-22 21:15:31.397129+00'),
	(744, 155, 43, '2026-03-22 21:15:31.406213+00'),
	(747, 140, 44, '2026-03-22 21:15:31.410233+00'),
	(748, 89, 44, '2026-03-22 21:15:31.412135+00'),
	(750, 148, 45, '2026-03-22 21:15:31.414753+00'),
	(752, 150, 47, '2026-03-22 21:15:31.417233+00'),
	(753, 140, 47, '2026-03-22 21:15:31.418711+00'),
	(756, 148, 53, '2026-03-22 21:15:31.422931+00'),
	(757, 155, 53, '2026-03-22 21:15:31.424467+00'),
	(760, 148, 48, '2026-03-22 21:15:31.428274+00'),
	(764, 159, 35, '2026-03-22 21:15:31.433292+00'),
	(765, 50, 35, '2026-03-22 21:15:31.434466+00'),
	(767, 160, 35, '2026-03-22 21:15:31.436601+00'),
	(768, 44, 36, '2026-03-22 21:15:31.437771+00'),
	(774, 96, 37, '2026-03-22 21:15:31.444415+00'),
	(775, 97, 37, '2026-03-22 21:15:31.445808+00'),
	(776, 115, 37, '2026-03-22 21:15:31.446889+00'),
	(779, 160, 38, '2026-03-22 21:15:31.450521+00'),
	(784, 96, 50, '2026-03-22 21:15:31.456752+00'),
	(786, 159, 50, '2026-03-22 21:15:31.46075+00'),
	(788, 161, 50, '2026-03-22 21:15:31.463722+00'),
	(789, 96, 54, '2026-03-22 21:15:31.465099+00'),
	(790, 97, 54, '2026-03-22 21:15:31.46666+00'),
	(791, 115, 54, '2026-03-22 21:15:31.468213+00'),
	(792, 158, 54, '2026-03-22 21:15:31.469744+00'),
	(793, 159, 54, '2026-03-22 21:15:31.471062+00'),
	(794, 102, 54, '2026-03-22 21:15:31.472295+00'),
	(796, 161, 54, '2026-03-22 21:15:31.474953+00'),
	(804, 159, 43, '2026-03-22 21:15:31.48588+00'),
	(808, 161, 43, '2026-03-22 21:15:31.490444+00'),
	(809, 160, 44, '2026-03-22 21:15:31.491578+00'),
	(812, 97, 45, '2026-03-22 21:15:31.494772+00'),
	(813, 115, 45, '2026-03-22 21:15:31.495905+00'),
	(814, 158, 45, '2026-03-22 21:15:31.497175+00'),
	(815, 159, 45, '2026-03-22 21:15:31.498315+00'),
	(819, 161, 45, '2026-03-22 21:15:31.503483+00'),
	(820, 158, 52, '2026-03-22 21:15:31.505687+00'),
	(821, 159, 52, '2026-03-22 21:15:31.507098+00'),
	(825, 115, 47, '2026-03-22 21:15:31.512201+00'),
	(826, 159, 47, '2026-03-22 21:15:31.513504+00'),
	(831, 159, 53, '2026-03-22 21:15:31.519583+00'),
	(833, 160, 53, '2026-03-22 21:15:31.522241+00'),
	(837, 160, 48, '2026-03-22 21:15:31.527243+00'),
	(854, 103, 37, '2026-03-22 21:15:31.546656+00'),
	(862, 97, 38, '2026-03-22 21:15:31.556802+00'),
	(864, 131, 38, '2026-03-22 21:15:31.559146+00'),
	(866, 134, 38, '2026-03-22 21:15:31.561503+00'),
	(870, 145, 38, '2026-03-22 21:15:31.5665+00'),
	(872, 167, 39, '2026-03-22 21:15:31.568948+00'),
	(873, 77, 39, '2026-03-22 21:15:31.570354+00'),
	(881, 134, 41, '2026-03-22 21:15:31.580084+00'),
	(883, 135, 41, '2026-03-22 21:15:31.582321+00'),
	(887, 77, 42, '2026-03-22 21:15:31.592279+00'),
	(891, 77, 43, '2026-03-22 21:15:31.59786+00'),
	(894, 120, 43, '2026-03-22 21:15:31.602439+00'),
	(899, 64, 60, '2026-03-22 21:15:31.610032+00'),
	(900, 98, 60, '2026-03-22 21:15:31.611684+00'),
	(901, 77, 60, '2026-03-22 21:15:31.613226+00'),
	(903, 134, 46, '2026-03-22 21:15:31.615801+00'),
	(906, 129, 47, '2026-03-22 21:15:31.62109+00'),
	(907, 131, 47, '2026-03-22 21:15:31.622648+00'),
	(909, 134, 47, '2026-03-22 21:15:31.627515+00'),
	(911, 145, 47, '2026-03-22 21:15:31.632926+00'),
	(912, 21, 61, '2026-03-22 21:15:31.635401+00'),
	(913, 103, 61, '2026-03-22 21:15:31.63737+00'),
	(914, 120, 61, '2026-03-22 21:15:31.639668+00'),
	(917, 84, 53, '2026-03-22 21:15:31.648556+00'),
	(920, 24, 49, '2026-03-22 21:15:31.657329+00'),
	(928, 158, 36, '2026-03-22 21:15:31.676898+00'),
	(930, 27, 36, '2026-03-22 21:15:31.679584+00'),
	(933, 109, 36, '2026-03-22 21:15:31.683513+00'),
	(935, 158, 37, '2026-03-22 21:15:31.68735+00'),
	(936, 170, 37, '2026-03-22 21:15:31.689353+00'),
	(938, 33, 37, '2026-03-22 21:15:31.693341+00'),
	(942, 175, 38, '2026-03-22 21:15:31.698506+00'),
	(947, 23, 40, '2026-03-22 21:15:31.704959+00'),
	(948, 158, 40, '2026-03-22 21:15:31.706316+00'),
	(949, 171, 40, '2026-03-22 21:15:31.707606+00'),
	(950, 172, 40, '2026-03-22 21:15:31.708908+00'),
	(951, 173, 40, '2026-03-22 21:15:31.710232+00'),
	(953, 27, 40, '2026-03-22 21:15:31.713097+00'),
	(956, 174, 40, '2026-03-22 21:15:31.717526+00'),
	(957, 33, 40, '2026-03-22 21:15:31.718994+00'),
	(958, 176, 40, '2026-03-22 21:15:31.720478+00'),
	(959, 177, 40, '2026-03-22 21:15:31.72324+00'),
	(960, 158, 41, '2026-03-22 21:15:31.724915+00'),
	(961, 74, 41, '2026-03-22 21:15:31.726551+00'),
	(964, 24, 42, '2026-03-22 21:15:31.730679+00'),
	(965, 173, 42, '2026-03-22 21:15:31.732144+00'),
	(967, 27, 42, '2026-03-22 21:15:31.735483+00'),
	(969, 176, 42, '2026-03-22 21:15:31.738394+00'),
	(970, 23, 43, '2026-03-22 21:15:31.739872+00'),
	(971, 158, 43, '2026-03-22 21:15:31.741284+00'),
	(972, 171, 43, '2026-03-22 21:15:31.742651+00'),
	(973, 172, 43, '2026-03-22 21:15:31.743922+00'),
	(974, 173, 43, '2026-03-22 21:15:31.745328+00'),
	(976, 27, 43, '2026-03-22 21:15:31.747831+00'),
	(979, 174, 43, '2026-03-22 21:15:31.751777+00'),
	(980, 33, 43, '2026-03-22 21:15:31.754097+00'),
	(981, 176, 43, '2026-03-22 21:15:31.755824+00'),
	(983, 177, 43, '2026-03-22 21:15:31.758509+00'),
	(984, 174, 52, '2026-03-22 21:15:31.759872+00'),
	(985, 177, 52, '2026-03-22 21:15:31.76211+00'),
	(986, 37, 52, '2026-03-22 21:15:31.763693+00'),
	(988, 171, 53, '2026-03-22 21:15:31.766224+00'),
	(989, 24, 53, '2026-03-22 21:15:31.767476+00'),
	(993, 31, 53, '2026-03-22 21:15:31.772211+00'),
	(994, 176, 53, '2026-03-22 21:15:31.77343+00'),
	(995, 37, 53, '2026-03-22 21:15:31.774594+00'),
	(996, 177, 53, '2026-03-22 21:15:31.775675+00'),
	(1000, 45, 36, '2026-03-22 21:15:31.779868+00'),
	(1002, 83, 36, '2026-03-22 21:15:31.782425+00'),
	(1003, 89, 36, '2026-03-22 21:15:31.786103+00'),
	(1005, 92, 36, '2026-03-22 21:15:31.789297+00'),
	(1006, 61, 36, '2026-03-22 21:15:31.791036+00'),
	(1007, 179, 37, '2026-03-22 21:15:31.793015+00'),
	(1008, 60, 38, '2026-03-22 21:15:31.795644+00'),
	(1010, 83, 38, '2026-03-22 21:15:31.798684+00'),
	(1012, 45, 39, '2026-03-22 21:15:31.80384+00'),
	(1013, 83, 39, '2026-03-22 21:15:31.805745+00'),
	(1015, 60, 39, '2026-03-22 21:15:31.808708+00'),
	(1016, 92, 39, '2026-03-22 21:15:31.810292+00'),
	(1017, 61, 41, '2026-03-22 21:15:31.811623+00'),
	(1019, 179, 42, '2026-03-22 21:15:31.814199+00'),
	(1030, 180, 52, '2026-03-22 21:15:31.828823+00'),
	(1031, 78, 53, '2026-03-22 21:15:31.830169+00'),
	(1034, 95, 53, '2026-03-22 21:15:31.83435+00'),
	(1038, 60, 48, '2026-03-22 21:15:31.839816+00'),
	(1041, 28, 49, '2026-03-22 21:15:31.844044+00'),
	(1046, 117, 36, '2026-03-22 21:15:31.854822+00'),
	(1050, 181, 37, '2026-03-22 21:15:31.860736+00'),
	(1053, 186, 37, '2026-03-22 21:15:31.864793+00'),
	(1055, 148, 39, '2026-03-22 21:15:31.867672+00'),
	(1057, 150, 39, '2026-03-22 21:15:31.870107+00'),
	(1058, 164, 39, '2026-03-22 21:15:31.871826+00'),
	(1059, 28, 39, '2026-03-22 21:15:31.873439+00'),
	(1061, 163, 62, '2026-03-22 21:15:31.876075+00'),
	(1062, 164, 62, '2026-03-22 21:15:31.87732+00'),
	(1064, 182, 51, '2026-03-22 21:15:31.879538+00'),
	(1075, 176, 45, '2026-03-22 21:15:31.894188+00'),
	(1077, 73, 46, '2026-03-22 21:15:31.896996+00'),
	(1079, 31, 52, '2026-03-22 21:15:31.899295+00'),
	(1084, 181, 53, '2026-03-22 21:15:31.904874+00'),
	(1087, 28, 53, '2026-03-22 21:15:31.908207+00'),
	(1094, 109, 35, '2026-03-22 21:15:31.931117+00'),
	(1097, 72, 36, '2026-03-22 21:15:31.937632+00'),
	(1102, 59, 36, '2026-03-22 21:15:31.945272+00'),
	(1109, 161, 37, '2026-03-22 21:15:31.95589+00'),
	(1111, 189, 37, '2026-03-22 21:15:31.959685+00'),
	(1112, 70, 38, '2026-03-22 21:15:31.961158+00'),
	(1113, 72, 38, '2026-03-22 21:15:31.964529+00'),
	(1124, 146, 38, '2026-03-22 21:15:31.978881+00'),
	(1128, 97, 39, '2026-03-22 21:15:31.983705+00'),
	(1130, 188, 39, '2026-03-22 21:15:31.98594+00'),
	(1131, 155, 39, '2026-03-22 21:15:31.987203+00'),
	(1139, 102, 50, '2026-03-22 21:15:31.995952+00'),
	(1146, 110, 50, '2026-03-22 21:15:32.004044+00'),
	(1148, 121, 50, '2026-03-22 21:15:32.006424+00'),
	(1151, 189, 50, '2026-03-22 21:15:32.009801+00'),
	(1159, 160, 40, '2026-03-22 21:15:32.020139+00'),
	(1162, 121, 40, '2026-03-22 21:15:32.023806+00'),
	(1163, 161, 40, '2026-03-22 21:15:32.025308+00'),
	(1164, 189, 40, '2026-03-22 21:15:32.026544+00'),
	(1173, 188, 42, '2026-03-22 21:15:32.037493+00'),
	(1189, 82, 46, '2026-03-22 21:15:32.068664+00'),
	(1202, 146, 47, '2026-03-22 21:15:32.086918+00'),
	(1206, 72, 53, '2026-03-22 21:15:32.092414+00'),
	(1209, 131, 53, '2026-03-22 21:15:32.0957+00'),
	(1212, 189, 53, '2026-03-22 21:15:32.099289+00'),
	(1214, 190, 53, '2026-03-22 21:15:32.101925+00'),
	(1216, 97, 48, '2026-03-22 21:15:32.104261+00'),
	(1220, 38, 49, '2026-03-22 21:15:32.109025+00'),
	(1222, 194, 37, '2026-03-22 21:15:32.111462+00'),
	(1223, 196, 37, '2026-03-22 21:15:32.112642+00'),
	(1226, 54, 39, '2026-03-22 21:15:32.116154+00'),
	(1229, 195, 41, '2026-03-22 21:15:32.119772+00'),
	(1230, 160, 43, '2026-03-22 21:15:32.121435+00'),
	(1232, 196, 48, '2026-03-22 21:15:32.124011+00'),
	(1233, 201, 49, '2026-03-22 21:15:32.125354+00'),
	(1241, 67, 36, '2026-03-22 21:15:32.137925+00'),
	(1242, 48, 36, '2026-03-22 21:15:32.139513+00'),
	(1243, 49, 36, '2026-03-22 21:15:32.140736+00'),
	(1251, 126, 38, '2026-03-22 21:15:32.150916+00'),
	(1253, 199, 38, '2026-03-22 21:15:32.153655+00'),
	(1255, 132, 38, '2026-03-22 21:15:32.156366+00'),
	(1258, 143, 38, '2026-03-22 21:15:32.160521+00'),
	(1264, 201, 39, '2026-03-22 21:15:32.16785+00'),
	(1268, 67, 50, '2026-03-22 21:15:32.172497+00'),
	(1283, 132, 47, '2026-03-22 21:15:32.190131+00'),
	(1298, 148, 49, '2026-03-22 21:15:32.216238+00'),
	(1300, 27, 49, '2026-03-22 21:15:32.2188+00'),
	(1305, 177, 49, '2026-03-22 21:15:32.224978+00'),
	(1306, 123, 49, '2026-03-22 21:15:32.226183+00'),
	(1309, 33, 35, '2026-03-22 21:15:32.229598+00'),
	(1328, 158, 39, '2026-03-22 21:15:32.251025+00'),
	(1334, 159, 40, '2026-03-22 21:15:32.260306+00'),
	(1339, 113, 50, '2026-03-22 21:15:32.2676+00'),
	(1344, 123, 50, '2026-03-22 21:15:32.275097+00'),
	(1350, 175, 41, '2026-03-22 21:15:32.28265+00'),
	(1352, 123, 41, '2026-03-22 21:15:32.285094+00'),
	(1355, 113, 42, '2026-03-22 21:15:32.28864+00'),
	(1370, 113, 52, '2026-03-22 21:15:32.30705+00'),
	(1371, 171, 52, '2026-03-22 21:15:32.308318+00'),
	(1372, 24, 52, '2026-03-22 21:15:32.309571+00'),
	(1373, 173, 52, '2026-03-22 21:15:32.310812+00'),
	(1376, 33, 52, '2026-03-22 21:15:32.31523+00'),
	(1387, 33, 53, '2026-03-22 21:15:32.329582+00'),
	(1388, 123, 53, '2026-03-22 21:15:32.331064+00'),
	(1391, 148, 63, '2026-03-22 21:15:32.334281+00'),
	(1392, 113, 63, '2026-03-22 21:15:32.335706+00'),
	(1393, 97, 63, '2026-03-22 21:15:32.337006+00'),
	(1394, 158, 63, '2026-03-22 21:15:32.338311+00'),
	(1395, 159, 63, '2026-03-22 21:15:32.339654+00'),
	(1396, 171, 63, '2026-03-22 21:15:32.340884+00'),
	(1397, 24, 63, '2026-03-22 21:15:32.341956+00'),
	(1398, 172, 63, '2026-03-22 21:15:32.343191+00'),
	(1399, 173, 63, '2026-03-22 21:15:32.344507+00'),
	(1400, 102, 63, '2026-03-22 21:15:32.345768+00'),
	(1401, 30, 63, '2026-03-22 21:15:32.346969+00'),
	(1402, 31, 63, '2026-03-22 21:15:32.348136+00'),
	(1403, 175, 63, '2026-03-22 21:15:32.349501+00'),
	(1404, 33, 63, '2026-03-22 21:15:32.350791+00'),
	(1405, 34, 63, '2026-03-22 21:15:32.352365+00'),
	(1406, 176, 63, '2026-03-22 21:15:32.354114+00'),
	(1407, 205, 63, '2026-03-22 21:15:32.355551+00'),
	(1408, 37, 63, '2026-03-22 21:15:32.356946+00'),
	(1409, 206, 63, '2026-03-22 21:15:32.358162+00'),
	(1410, 9, 64, '2026-03-22 21:15:32.359517+00'),
	(1413, 208, 35, '2026-03-22 21:15:32.364086+00'),
	(1416, 25, 36, '2026-03-22 21:15:32.368177+00'),
	(1417, 145, 36, '2026-03-22 21:15:32.369399+00'),
	(1419, 44, 38, '2026-03-22 21:15:32.371689+00'),
	(1420, 72, 39, '2026-03-22 21:15:32.372781+00'),
	(1421, 25, 39, '2026-03-22 21:15:32.374051+00'),
	(1422, 131, 39, '2026-03-22 21:15:32.375173+00'),
	(1423, 137, 39, '2026-03-22 21:15:32.376374+00'),
	(1424, 142, 39, '2026-03-22 21:15:32.377629+00'),
	(1427, 145, 39, '2026-03-22 21:15:32.381923+00'),
	(1428, 146, 39, '2026-03-22 21:15:32.38332+00'),
	(1431, 73, 65, '2026-03-22 21:15:32.386622+00'),
	(1432, 131, 65, '2026-03-22 21:15:32.388029+00'),
	(1435, 146, 54, '2026-03-22 21:15:32.391839+00'),
	(1438, 208, 41, '2026-03-22 21:15:32.395658+00'),
	(1449, 208, 44, '2026-03-22 21:15:32.407974+00'),
	(1452, 91, 60, '2026-03-22 21:15:32.411412+00'),
	(1453, 208, 45, '2026-03-22 21:15:32.412608+00'),
	(1455, 146, 52, '2026-03-22 21:15:32.414939+00'),
	(1458, 137, 47, '2026-03-22 21:15:32.418769+00'),
	(1459, 142, 47, '2026-03-22 21:15:32.420115+00'),
	(1463, 93, 47, '2026-03-22 21:15:32.42586+00'),
	(1465, 211, 47, '2026-03-22 21:15:32.428367+00'),
	(1466, 208, 48, '2026-03-22 21:15:32.429789+00'),
	(1472, 84, 57, '2026-03-22 21:15:32.437244+00'),
	(1484, 129, 38, '2026-03-22 21:15:32.451534+00'),
	(1492, 137, 38, '2026-03-22 21:15:32.460257+00'),
	(1493, 138, 38, '2026-03-22 21:15:32.461949+00'),
	(1494, 142, 38, '2026-03-22 21:15:32.467519+00'),
	(1499, 212, 39, '2026-03-22 21:15:32.473766+00'),
	(1522, 212, 43, '2026-03-22 21:15:32.500587+00'),
	(1526, 132, 44, '2026-03-22 21:15:32.506106+00'),
	(1539, 69, 48, '2026-03-22 21:15:32.522394+00');


--
-- Name: action_descriptions_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: postgres
--

SELECT pg_catalog.setval('"herbal"."action_descriptions_id_seq"', 301, true);


--
-- Name: body_systems_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: postgres
--

SELECT pg_catalog.setval('"herbal"."body_systems_id_seq"', 16, true);


--
-- Name: herb_primary_actions_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: postgres
--

SELECT pg_catalog.setval('"herbal"."herb_primary_actions_id_seq"', 879, true);


--
-- Name: herb_secondary_actions_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: postgres
--

SELECT pg_catalog.setval('"herbal"."herb_secondary_actions_id_seq"', 1541, true);


--
-- Name: herbs_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: postgres
--

SELECT pg_catalog.setval('"herbal"."herbs_id_seq"', 218, true);


--
-- Name: primary_actions_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: postgres
--

SELECT pg_catalog.setval('"herbal"."primary_actions_id_seq"', 24, true);


--
-- Name: secondary_actions_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: postgres
--

SELECT pg_catalog.setval('"herbal"."secondary_actions_id_seq"', 65, true);


--
-- PostgreSQL database dump complete
--

-- \unrestrict HpaiwY8Yszu6KUg42qKJGrWw1I58Lut0jmsVHHyCtzyDi9LO5YfoY4HteSXq58L

RESET ALL;
-- Migration to add disorders system (generic for all body systems)
-- This supports the clinical application of herbal medicine by body system

SET search_path TO herbal, public;

-- ============================================================================
-- DISORDERS TABLE
-- ============================================================================
-- Stores all disorders/conditions across all body systems
CREATE TABLE herbal.disorders (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  body_system_id INTEGER REFERENCES herbal.body_systems(id) ON DELETE CASCADE,
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(name, body_system_id)
);

CREATE INDEX idx_disorders_body_system ON herbal.disorders(body_system_id);
CREATE INDEX idx_disorders_name ON herbal.disorders(name);

COMMENT ON TABLE herbal.disorders IS 'Clinical disorders/conditions organized by body system';
COMMENT ON COLUMN herbal.disorders.sort_order IS 'Display order within body system';

-- ============================================================================
-- DISORDER NOTES
-- ============================================================================
-- Stores free-form notes/context for each disorder (## Notes sections)
CREATE TABLE herbal.disorder_notes (
  id SERIAL PRIMARY KEY,
  disorder_id INTEGER REFERENCES herbal.disorders(id) ON DELETE CASCADE,
  note_text TEXT NOT NULL,
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_disorder_notes_disorder ON herbal.disorder_notes(disorder_id);

COMMENT ON TABLE herbal.disorder_notes IS 'Clinical notes and context for disorders';

-- ============================================================================
-- ACTIONS INDICATED
-- ============================================================================
-- Describes which herbal actions are therapeutically indicated for a disorder
CREATE TABLE herbal.disorder_actions_indicated (
  id SERIAL PRIMARY KEY,
  disorder_id INTEGER REFERENCES herbal.disorders(id) ON DELETE CASCADE,
  primary_action_id INTEGER REFERENCES herbal.primary_actions(id) ON DELETE CASCADE,
  description TEXT NOT NULL,
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(disorder_id, primary_action_id)
);

CREATE INDEX idx_disorder_actions_indicated_disorder ON herbal.disorder_actions_indicated(disorder_id);
CREATE INDEX idx_disorder_actions_indicated_action ON herbal.disorder_actions_indicated(primary_action_id);

COMMENT ON TABLE herbal.disorder_actions_indicated IS 'Therapeutic rationale for why specific actions are indicated for each disorder';

-- ============================================================================
-- DISORDER ACTION HERBS
-- ============================================================================
-- Links herbs to disorders via their therapeutic actions
CREATE TABLE herbal.disorder_action_herbs (
  id SERIAL PRIMARY KEY,
  disorder_id INTEGER REFERENCES herbal.disorders(id) ON DELETE CASCADE,
  herb_id INTEGER REFERENCES herbal.herbs(id) ON DELETE CASCADE,
  primary_action_id INTEGER REFERENCES herbal.primary_actions(id) ON DELETE CASCADE,
  note TEXT,
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(disorder_id, herb_id, primary_action_id)
);

CREATE INDEX idx_disorder_action_herbs_disorder ON herbal.disorder_action_herbs(disorder_id);
CREATE INDEX idx_disorder_action_herbs_herb ON herbal.disorder_action_herbs(herb_id);
CREATE INDEX idx_disorder_action_herbs_action ON herbal.disorder_action_herbs(primary_action_id);

COMMENT ON TABLE herbal.disorder_action_herbs IS 'Herbs organized by their therapeutic action for specific disorders';

-- ============================================================================
-- SPECIFIC REMEDIES
-- ============================================================================
-- Highlights particularly effective herbs for a disorder (specific remedies)
CREATE TABLE herbal.disorder_specific_remedies (
  id SERIAL PRIMARY KEY,
  disorder_id INTEGER REFERENCES herbal.disorders(id) ON DELETE CASCADE,
  herb_id INTEGER REFERENCES herbal.herbs(id) ON DELETE CASCADE,
  description TEXT NOT NULL,
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(disorder_id, herb_id)
);

CREATE INDEX idx_disorder_specific_remedies_disorder ON herbal.disorder_specific_remedies(disorder_id);
CREATE INDEX idx_disorder_specific_remedies_herb ON herbal.disorder_specific_remedies(herb_id);

COMMENT ON TABLE herbal.disorder_specific_remedies IS 'Particularly effective herbs (specific remedies) for each disorder';

-- ============================================================================
-- PRESCRIPTIONS
-- ============================================================================
-- Stores herbal formulas/prescriptions for disorders
CREATE TABLE herbal.disorder_prescriptions (
  id SERIAL PRIMARY KEY,
  disorder_id INTEGER REFERENCES herbal.disorders(id) ON DELETE CASCADE,
  title TEXT, -- e.g., "Mouthwash", "Internal use", "Gum application"
  instructions TEXT NOT NULL, -- Dosage and preparation instructions
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_disorder_prescriptions_disorder ON herbal.disorder_prescriptions(disorder_id);

COMMENT ON TABLE herbal.disorder_prescriptions IS 'Herbal formulas/prescriptions for treating disorders';
COMMENT ON COLUMN herbal.disorder_prescriptions.title IS 'Optional title like "Internal use", "Mouthwash", "Topical application"';

-- ============================================================================
-- PRESCRIPTION HERBS
-- ============================================================================
-- Individual herbs within a prescription formula with their proportions
CREATE TABLE herbal.prescription_herbs (
  id SERIAL PRIMARY KEY,
  prescription_id INTEGER REFERENCES herbal.disorder_prescriptions(id) ON DELETE CASCADE,
  herb_id INTEGER REFERENCES herbal.herbs(id) ON DELETE CASCADE,
  parts TEXT NOT NULL, -- e.g., "1 part", "2 parts", "35 ml"
  note TEXT, -- e.g., "root" for specific plant part
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_prescription_herbs_prescription ON herbal.prescription_herbs(prescription_id);
CREATE INDEX idx_prescription_herbs_herb ON herbal.prescription_herbs(herb_id);

COMMENT ON TABLE herbal.prescription_herbs IS 'Individual herbs in prescriptions with their proportions';
COMMENT ON COLUMN herbal.prescription_herbs.parts IS 'Proportion like "1 part", "2 parts", "35 ml"';
COMMENT ON COLUMN herbal.prescription_herbs.note IS 'Specific plant part or other notes like "root", "leaf"';

-- ============================================================================
-- PRESCRIPTION HERB ACTIONS
-- ============================================================================
-- Links herbs in prescriptions to their therapeutic role (actions) in that formula
-- This enables showing what each herb is doing in the formula
CREATE TABLE herbal.prescription_herb_actions (
  id SERIAL PRIMARY KEY,
  prescription_herb_id INTEGER REFERENCES herbal.prescription_herbs(id) ON DELETE CASCADE,
  primary_action_id INTEGER REFERENCES herbal.primary_actions(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(prescription_herb_id, primary_action_id)
);

CREATE INDEX idx_prescription_herb_actions_prescription_herb ON herbal.prescription_herb_actions(prescription_herb_id);
CREATE INDEX idx_prescription_herb_actions_action ON herbal.prescription_herb_actions(primary_action_id);

COMMENT ON TABLE herbal.prescription_herb_actions IS 'Links herbs in formulas to their therapeutic actions/roles';

-- ============================================================================
-- PERMISSIONS
-- ============================================================================
GRANT ALL ON ALL TABLES IN SCHEMA herbal TO postgres, anon, authenticated, service_role;
GRANT ALL ON ALL SEQUENCES IN SCHEMA herbal TO postgres, anon, authenticated, service_role;

-- ============================================================================
-- SUMMARY
-- ============================================================================
-- This schema supports:
-- 1. Disorders organized by body system
-- 2. Clinical notes for context
-- 3. Actions indicated (therapeutic rationale)
-- 4. Action herbs (herbs grouped by their actions for a disorder)
-- 5. Specific remedies (particularly effective herbs)
-- 6. Prescriptions (herbal formulas with dosage instructions)
-- 7. Prescription herbs (individual herbs with proportions)
-- 8. Prescription herb actions (what each herb does in the formula)
--
-- This design is fully generic and reusable for all body systems
-- Populate GI/Digestive System Disorders Data
-- Data extracted from GI.md
-- This migration auto-creates missing herbs and actions

SET search_path TO herbal, public;

-- ============================================================================
-- HELPER FUNCTIONS
-- ============================================================================

-- Function to get or create herb by latin name
CREATE OR REPLACE FUNCTION get_or_create_herb(p_latin_name TEXT, p_common_name TEXT DEFAULT NULL)
RETURNS INTEGER AS $$
DECLARE
  v_herb_id INTEGER;
  v_common_name TEXT;
BEGIN
  -- Try to find existing herb
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = p_latin_name;

  IF v_herb_id IS NULL THEN
    -- Extract common name from latin name if not provided
    v_common_name := COALESCE(p_common_name, INITCAP(SPLIT_PART(p_latin_name, ' ', 1)));

    -- Create new herb
    INSERT INTO herbal.herbs (latin_name, common_name)
    VALUES (p_latin_name, v_common_name)
    RETURNING id INTO v_herb_id;
  END IF;

  RETURN v_herb_id;
END;
$$ LANGUAGE plpgsql;

-- Function to get or create primary action by name
CREATE OR REPLACE FUNCTION get_or_create_action(p_action_name TEXT)
RETURNS INTEGER AS $$
DECLARE
  v_action_id INTEGER;
BEGIN
  -- Try to find existing action
  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = p_action_name;

  IF v_action_id IS NULL THEN
    -- Create new action
    INSERT INTO herbal.primary_actions (name)
    VALUES (p_action_name)
    RETURNING id INTO v_action_id;
  END IF;

  RETURN v_action_id;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- POPULATE GI DISORDERS
-- ============================================================================

DO $$
DECLARE
  v_digestive_id INTEGER;
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_prescription_herb_id INTEGER;
  v_herb_id INTEGER;
  v_action_id INTEGER;
BEGIN
  -- Get Digestive system ID
  SELECT id INTO v_digestive_id FROM herbal.body_systems WHERE name = 'Digestive';

  -- ============================================================================
  -- DISORDER: Constipation
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Constipation', v_digestive_id, 1)
  RETURNING id INTO v_disorder_id;

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id, 'Dosage: up to 5 ml of tincture three times a day', 1)
  RETURNING id INTO v_prescription_id;

  -- Prescription Herbs
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Rumex crispus', 'Yellow Dock'), '2 parts', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), '2 parts', 'root', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Pimpinella anisum', 'Anise'), '1 part', 3);

  -- ============================================================================
  -- DISORDER: Diarrhea
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Diarrhea', v_digestive_id, 2)
  RETURNING id INTO v_disorder_id;

  -- Specific Remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Filipendula ulmaria', 'Meadowsweet'),
    'May well be the best gentle overall treatment for diarrhea, as it seems to tone the lining of the small intestine', 1);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Agrimonia eupatoria', 'Agrimony'), 'Excellent remedy', 2);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Alchemilla spp.', 'Lady''s Mantle'), 'Excellent remedy', 3);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Geranium maculatum', 'Cranesbill'), 'Excellent remedy', 4);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Quercus spp.', 'Oak'), 'Stronger astringent, should be used only as a last resort', 5);

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id, 'Combine dried herbs and prepare as an infusion; drink regularly throughout the day until symptoms subside.', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Agrimonia eupatoria', 'Agrimony'), '1 part', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Geranium maculatum', 'Cranesbill'), '1 part', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), '1 part', 3);

  -- ============================================================================
  -- DISORDER: Aphthous Ulcers
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Aphthous Ulcers', v_digestive_id, 3)
  RETURNING id INTO v_disorder_id;

  -- Actions Indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Anti-inflammatory'),
    'Play a core role by reducing the localized mucosal reaction.', 1);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Antimicrobial'),
    'Inhibit the development of infection or prevent the spread of bacteria to the rest of the body, which can occur due to impaired buccal immune response.', 2);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Immune Support'),
    'Necessary if the ulcers suggest a systemic problem.', 3);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Alterative'),
    'Will help with any metabolic problems that might be present.', 4);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Demulcent'),
    'Help soothe and relieve symptoms.', 5);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Nervine'),
    'Assist the individual in coping with stress; counseling may also be indicated', 6);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Adaptogen'),
    'Assist the individual in coping with stress; counseling may also be indicated', 7);

  -- Action Herbs
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Echinacea spp.', 'Echinacea'), get_or_create_action('Antimicrobial'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Echinacea spp.', 'Echinacea'), get_or_create_action('Alterative'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Galium aparine', 'Cleavers'), get_or_create_action('Alterative'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Calendula officinalis', 'Calendula'), get_or_create_action('Alterative'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Galium aparine', 'Cleavers'), get_or_create_action('Lymphatic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Calendula officinalis', 'Calendula'), get_or_create_action('Lymphatic'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Calendula officinalis', 'Calendula'), get_or_create_action('Vulnerary'), 1);

  -- Specific Remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Salvia officinalis', 'Sage'),
    'This is a variety of ordinary sage that contains a stronger volatile oil. While it is rarely used in cooking, it makes a perfect herb to use as a mouthwash for aphthous ulcers and other inflammatory conditions of the mouth.', 1);

  -- Prescription 1: Mouthwash
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Mouthwash', 'Combine dried herbs and prepare as an infusion, to be gargled often.', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Salvia officinalis', 'Sage'), '1 part', 'var. rubia', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), '1 part', 2);

  -- Prescription 2: Internal use
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Internal use', 'Dosage - up to 3 ml of tincture three times a day', 2)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Echinacea spp.', 'Echinacea'), '1 part', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Galium aparine', 'Cleavers'), '1 part', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Calendula officinalis', 'Calendula'), '1 part', 3);

  -- ============================================================================
  -- DISORDER: Periodontal Disease
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Periodontal Disease', v_digestive_id, 4)
  RETURNING id INTO v_disorder_id;

  -- Actions Indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Antimicrobial'),
    'Essential to reduce populations of bacteria that contribute to the decay process.', 1);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Anti-inflammatory'),
    'Reduce any localized mucosal reaction.', 2);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Astringent'),
    'Lessen local bleeding and other exudations.', 3);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Circulatory Stimulant'),
    'Promote the circulation of blood in the gums, aiding in detoxification.', 4);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Immune Support'),
    'Necessary if gum disease suggests a systemic problem.', 5);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Alterative'),
    'Help the body deal with any systemic problems related to the disease.', 6);

  -- Specific Remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Commiphora molmol', 'Myrrh'),
    'May be considered a specific remedy here, as it has powerful antimicrobial effects against the pathogens that cause gum disease.', 1);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Krameria triandra', 'Rhatany'),
    'An astringent herb from Peru, has proved uniquely effective for gum disease. Some proprietary herbal toothpastes can help support treatment', 2);

  -- Prescription 1: Gum application
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Gum application',
    'Combine tinctures and apply to the gums three times a day using a very fine brush. An infusion of buccal anti-inflammatory herbs, such as Salvia and Matricaria, may be used as a mouthwash, Do not swallow.', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Commiphora molmol', 'Myrrh'), '1 part', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Echinacea spp.', 'Echinacea'), '1 part', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Krameria triandra', 'Rhatany'), '1 part', 3);

  -- Prescription 2: Internal use
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Internal use', 'Dosage - up to 5 ml of tincture combination three times a day', 2)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Echinacea spp.', 'Echinacea'), '1 part', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Galium aparine', 'Cleavers'), '1 part', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Zanthoxylum americanum', 'Prickly Ash'), '1 part', 3);

  -- Action Herbs
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Echinacea spp.', 'Echinacea'), get_or_create_action('Antimicrobial'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Echinacea spp.', 'Echinacea'), get_or_create_action('Alterative'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Galium aparine', 'Cleavers'), get_or_create_action('Alterative'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Zanthoxylum americanum', 'Prickly Ash'), get_or_create_action('Alterative'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Echinacea spp.', 'Echinacea'), get_or_create_action('Lymphatic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Galium aparine', 'Cleavers'), get_or_create_action('Lymphatic'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Zanthoxylum americanum', 'Prickly Ash'), get_or_create_action('Lymphatic'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Zanthoxylum americanum', 'Prickly Ash'), get_or_create_action('Circulatory Stimulant'), 1);

  -- ============================================================================
  -- DISORDER: GERD
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('GERD', v_digestive_id, 5)
  RETURNING id INTO v_disorder_id;

  -- Actions Indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Demulcent'),
    'soothe and coat the tissue of the esophagus, insulating the mucosal lining against acidic gastric contents.', 1);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Anti-inflammatory'),
    'reduce localized mucosal reactions.', 2);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Vulnerary'),
    'aid the natural healing of ulcerations and other lesions.', 3);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Astringent'),
    'lessen local bleeding and other exudatations.', 4);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Alterative'),
    'help the body deal with any systemic problems related to the disease.', 5);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Carminative'),
    'may be needed if there is general disruption of digestive process.', 6);

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id,
    'Dosage: up to 5 ml of tincture three times a day. In addition, an infusion of the anti-inflammatory herb Matricaria, sipped slowly throughout the day, can be helpful. As an alternative, a cold infusion of Althaea root can be taken whenever needed.', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Althaea officinalis', 'Marshmallow'), '2 parts', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Calendula officinalis', 'Calendula'), '1 part', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), '1 part', 3);

  -- Action Herbs
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Althaea officinalis', 'Marshmallow'), get_or_create_action('Demulcent'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Calendula officinalis', 'Calendula'), get_or_create_action('Lymphatic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Calendula officinalis', 'Calendula'), get_or_create_action('Vulnerary'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Calendula officinalis', 'Calendula'), get_or_create_action('Astringent'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Anti-inflammatory'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Calendula officinalis', 'Calendula'), get_or_create_action('Anti-inflammatory'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Carminative'), 1);

  -- ============================================================================
  -- DISORDER: Gastritis
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Gastritis', v_digestive_id, 6)
  RETURNING id INTO v_disorder_id;

  -- Actions Indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Demulcent'),
    'soothe the lining of the stomach, by either coating the stomach or exerting anti-inflammatory actions.', 1);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Antacid'),
    'have little more to offer than symptomatic relief.', 2);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Anti-inflammatory'),
    'reduce localized mucosal reactions.', 3);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Astringent'),
    'lessen local bleeding.', 4);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Vulnerary'),
    'enhance the stomach''s natural wound-healing abilities.', 5);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Nervine'),
    'help ease background stress involvement.', 6);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Alterative'),
    'help the body deal with any systemic problems related to the disease', 7);

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id,
    'Dosage: Take tincture in divided doses, to 5 ml in total, three times a day. An infusion of Matricaria or Melissa sipped slowly throughout the day will also help.', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Althaea officinalis', 'Marshmallow'), '3 parts', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Filipendula ulmaria', 'Meadowsweet'), '1 part', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), '1 part', 3);

  -- Action Herbs
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Althaea officinalis', 'Marshmallow'), get_or_create_action('Demulcent'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Filipendula ulmaria', 'Meadowsweet'), get_or_create_action('Anti-inflammatory'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Anti-inflammatory'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Filipendula ulmaria', 'Meadowsweet'), get_or_create_action('Astringent'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Vulnerary'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Nervine'), 1);

  -- ============================================================================
  -- DISORDER: Peptic Ulcers
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Peptic Ulcers', v_digestive_id, 7)
  RETURNING id INTO v_disorder_id;

  -- Actions Indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Demulcent'),
    'soothe the lining of the stomach, either by coating the stomach or exerting anti-inflammatory actions.', 1);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Anti-inflammatory'),
    'reduce localized mucosal reactions.', 2);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Antimicrobial'),
    'are indicated for dealing with H. pylori. However, these herbs must be active in the stomach in order for them to be effective.', 3);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Astringent'),
    'lessen local bleeding.', 4);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Vulnerary'),
    'speed natural wound healing', 5);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Carminative'),
    'will reduce any flatulence in the gastrointestinal tract.', 6);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Nervine'),
    'help ease background stress involvement.', 7);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Bitter'),
    'aid the healing process in the latter stages of treatment.', 8);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Alterative'),
    'help the body deal with any systemic problems related to the disease.', 9);

  -- Specific Remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Symphytum officinale', 'Comfrey'), '', 1);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Althaea officinalis', 'Marshmallow'), '', 2);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Filipendula ulmaria', 'Meadowsweet'), '', 3);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Calendula officinalis', 'Calendula'), '', 4);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), '', 5);

  -- Prescription 1
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id,
    'Focuses on reducing inflammation and beginning the healing process. Dosage: 5 ml of tincture combination three times a day. In addition, a cold infusion of these herbs (fresh or dried) may be drunk often to ease symptoms. Matricaria infusion drunk on an empty stomach will reduce inflammation and help reverse the ulcerative process. Caution: If symptoms have not subsided within a week, seek skilled diagnosis.', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Symphytum officinale', 'Comfrey'), '1 part', 'root', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Althaea officinalis', 'Marshmallow'), '1 part', 'root', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), '1 part', 3);

  -- Prescription 2
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id,
    'Focuses on the second step in the healing process, to tone and complete healing. Dosage: 5 ml of tincture combination three times a day. Caution: If symptoms have not subsided within a week, seek skilled diagnosis.', 2)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Hydrastis canadensis', 'Goldenseal'), '1 part', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Symphytum officinale', 'Comfrey'), '2 parts', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), '2 parts', 3);

  -- Action Herbs
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Symphytum officinale', 'Comfrey'), get_or_create_action('Demulcent'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Althaea officinalis', 'Marshmallow'), get_or_create_action('Demulcent'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Anti-inflammatory'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Hydrastis canadensis', 'Goldenseal'), get_or_create_action('Anti-inflammatory'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Symphytum officinale', 'Comfrey'), get_or_create_action('Astringent'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Hydrastis canadensis', 'Goldenseal'), get_or_create_action('Astringent'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Symphytum officinale', 'Comfrey'), get_or_create_action('Vulnerary'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Hydrastis canadensis', 'Goldenseal'), get_or_create_action('Vulnerary'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Vulnerary'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Nervine'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Carminative'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Hydrastis canadensis', 'Goldenseal'), get_or_create_action('Bitter'), 1);

  -- ============================================================================
  -- DISORDER: Hiatus Hernia
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Hiatus Hernia', v_digestive_id, 8)
  RETURNING id INTO v_disorder_id;

  -- Actions Indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Demulcent'),
    'soothe the lining of the stomach, by either coating the mucosa or exerting anti-inflammatory actions.', 1);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Anti-inflammatory'),
    'reduce localized mucosal reactions.', 2);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Vulnerary'),
    'speed natural wound healing and may help strengthen the diaphragm.', 3);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Astringent'),
    'lessen local bleeding.', 4);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Carminative'),
    'will help with any flatulence or colic.', 5);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Nervine'),
    'help ease background stress involvement', 6);

  -- Specific Remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Symphytum officinale', 'Comfrey'),
    'Symphytum has an especially valid role because of its content of allantoin, a constituent that promotes wound healing.', 1);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Althaea officinalis', 'Marshmallow'), '', 2);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Filipendula ulmaria', 'Meadowsweet'), '', 3);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Calendula officinalis', 'Calendula'), '', 4);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), '', 5);

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id,
    'Dosage: 5 ml of tincture combination three times a day. An infusion of these herbs (fresh or dried) may be drunk often to ease symptoms. Carminative nervines may be added if stress is a major component. (Valeriana officinalis is a good example.)', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Symphytum officinale', 'Comfrey'), '1 part', 'root', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Althaea officinalis', 'Marshmallow'), '1 part', 'root', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Filipendula ulmaria', 'Meadowsweet'), '1 part', 3);

  -- Action Herbs
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Symphytum officinale', 'Comfrey'), get_or_create_action('Demulcent'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Althaea officinalis', 'Marshmallow'), get_or_create_action('Demulcent'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Filipendula ulmaria', 'Meadowsweet'), get_or_create_action('Anti-inflammatory'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Symphytum officinale', 'Comfrey'), get_or_create_action('Vulnerary'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Symphytum officinale', 'Comfrey'), get_or_create_action('Astringent'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Filipendula ulmaria', 'Meadowsweet'), get_or_create_action('Astringent'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Filipendula ulmaria', 'Meadowsweet'), get_or_create_action('Carminative'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Valeriana officinalis', 'Valerian'), get_or_create_action('Nervine'), 1);

  -- ============================================================================
  -- DISORDER: Functional Dyspepsia
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Functional Dyspepsia', v_digestive_id, 9)
  RETURNING id INTO v_disorder_id;

  -- Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Functional dyspepsia, often referred to as "indigestion," is a vague and variable problem that is functional in nature but usually not caused by underlying structural issues.', 1);

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Specific remedies are often bitter carminatives or nervine carminatives.', 2);

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Often, the traditional simple (tea made from a single fresh remedy) is the best treatment.', 3);

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Indigestion may be disease-related, but for the most part, it results from eating too much or too quickly, eating high-fat foods, or eating during stressful situations. Smoking, alcohol, medications that irritate the stomach lining, fatigue, and ongoing stress can also aggravate or cause indigestion.', 4);

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Exercising with a full stomach may also cause indigestion,', 5);

  -- Specific Remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Gentiana lutea', 'Gentian'), '', 1);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Mentha piperita', 'Peppermint'), '', 2);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), '', 3);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Melissa officinalis', 'Lemon Balm'), '', 4);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Humulus lupulus', 'Hops'), '', 5);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Valeriana officinalis', 'Valerian'), '', 6);

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id,
    'For indigestion. Dosage: 2.5 ml of tincture combination 10 minutes before eating', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), '1 part', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Mentha piperita', 'Peppermint'), '1 part', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Gentiana lutea', 'Gentian'), '1 part', 3);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Valeriana officinalis', 'Valerian'), '1 part', 4);

  -- Action Herbs
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Mentha piperita', 'Peppermint'), get_or_create_action('Carminative'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Carminative'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Melissa officinalis', 'Lemon Balm'), get_or_create_action('Carminative'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Mentha piperita', 'Peppermint'), get_or_create_action('Anti-inflammatory'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Anti-inflammatory'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Melissa officinalis', 'Lemon Balm'), get_or_create_action('Anti-inflammatory'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Gentiana lutea', 'Gentian'), get_or_create_action('Bitter'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Bitter'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Valeriana officinalis', 'Valerian'), get_or_create_action('Nervine'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Nervine'), 2);

END $$;

-- Cleanup helper functions
DROP FUNCTION IF EXISTS get_or_create_herb(TEXT, TEXT);
DROP FUNCTION IF EXISTS get_or_create_action(TEXT);

-- ============================================================================
-- NOTE: This migration contains 9 disorders. Due to file size constraints,
-- the remaining disorders will be in a continuation file (011_populate_gi_disorders_part2.sql):
--
-- - Irritable Bowel Syndrome
-- - Ulcerative Colitis
-- - Diverticulitis
-- - Liver Disease
-- - Jaundice
-- - Chronic Hepatitis
-- - Viral Hepatitis
-- - Cirrhosis
-- - Cholecystitis
-- - Cholelithiasis
-- - Hemorrhoids
-- ============================================================================
-- Populate GI/Digestive System Disorders Data - Part 2
-- Continuation of 010_populate_gi_disorders.sql
-- Data extracted from GI.md

SET search_path TO herbal, public;

-- Recreate helper functions
CREATE OR REPLACE FUNCTION get_or_create_herb(p_latin_name TEXT, p_common_name TEXT DEFAULT NULL)
RETURNS INTEGER AS $$
DECLARE
  v_herb_id INTEGER;
  v_common_name TEXT;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = p_latin_name;
  IF v_herb_id IS NULL THEN
    v_common_name := COALESCE(p_common_name, INITCAP(SPLIT_PART(p_latin_name, ' ', 1)));
    INSERT INTO herbal.herbs (latin_name, common_name)
    VALUES (p_latin_name, v_common_name)
    RETURNING id INTO v_herb_id;
  END IF;
  RETURN v_herb_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_or_create_action(p_action_name TEXT)
RETURNS INTEGER AS $$
DECLARE
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = p_action_name;
  IF v_action_id IS NULL THEN
    INSERT INTO herbal.primary_actions (name)
    VALUES (p_action_name)
    RETURNING id INTO v_action_id;
  END IF;
  RETURN v_action_id;
END;
$$ LANGUAGE plpgsql;

DO $$
DECLARE
  v_digestive_id INTEGER;
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_prescription_herb_id INTEGER;
BEGIN
  SELECT id INTO v_digestive_id FROM herbal.body_systems WHERE name = 'Digestive';

  -- ============================================================================
  -- DISORDER: Irritable Bowel Syndrome
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Irritable Bowel Syndrome', v_digestive_id, 10)
  RETURNING id INTO v_disorder_id;

  -- Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Irritable bowel syndrome (IBS) is a common disorder characterized by cramping pain, gassiness, bloating, and changes in bowel habits. Symptoms can include constipation or diarrhea, or may alternate between constipation and diarrhea.', 1);

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'While stress, anxiety, and other psychological issues are often pivotal, they are but components in a multifactorial matrix. Another factor to consider is intolerance to such common foods as wheat, corn, dairy products, coffee, tea, and citrus fruit.', 2);

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Occasionally, infectious or parasitic organisms are involved', 3);

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Stress-reduction training or counseling and support can help relieve IBS symptoms.', 4);

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'The intensity is often related to the number of calories and the amount of fat in the meal. Fat, whether animal or vegetable, is a strong stimulus for colonic contractions.', 5);

  -- Actions Indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Astringent'),
    'reverse the diarrhea and reduce any pathological mucus production.', 1);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Bitter'),
    'promote appropriate digestive secretions, and often will normalize bowel function on their own.', 2);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Anti-inflammatory'),
    'reduce localized mucosal reactions.', 3);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Carminative'),
    'help with any flatulence or colic.', 4);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Antispasmodic'),
    'other than carminatives may be indicated if cramping is severe.', 5);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Vulnerary'),
    'are indicated if there is any hint of damage to the lining of the colon.', 6);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Nervine'),
    'help ease background stress.', 7);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Aperient'),
    'may be indicated temporarily if constipation is present. Do not use strong herbs, however, as there may be a rapid swing back to diarrhea.', 8);

  -- Specific Remedies (Action Herbs section mentions specific herbs)
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'),
    'can have a direct impact on IBS', 1);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Mentha piperita', 'Peppermint'),
    'can have a direct impact on IBS', 2);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Myrica cerifera', 'Bayberry'),
    'astringent', 3);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Symphytum officinale', 'Comfrey'),
    'wound-healing remedy', 4);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Plantago major', 'Plantain'),
    'wound-healing remedy', 5);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Dioscorea villosa', 'Wild Yam'),
    'colic-relieving antispasmodic', 6);

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id,
    'Dosage: 5 ml of tincture combination three times a day. In addition, a warm infusion of an appropriate carminative nervine should be drunk frequently.', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Myrica cerifera', 'Bayberry'), '2 parts', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Artemisia vulgaris', 'Mugwort'), '1 part', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), '1 part', 3);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Mentha piperita', 'Peppermint'), '1 part', 4);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Dioscorea villosa', 'Wild Yam'), '1 part', 5);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Valeriana officinalis', 'Valerian'), '1 part', 6);

  -- Action Herbs
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Myrica cerifera', 'Bayberry'), get_or_create_action('Astringent'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Artemisia vulgaris', 'Mugwort'), get_or_create_action('Bitter'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Bitter'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Dioscorea villosa', 'Wild Yam'), get_or_create_action('Anti-inflammatory'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Anti-inflammatory'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Carminative'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Mentha piperita', 'Peppermint'), get_or_create_action('Carminative'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Dioscorea villosa', 'Wild Yam'), get_or_create_action('Antispasmodic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Antispasmodic'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Mentha piperita', 'Peppermint'), get_or_create_action('Antispasmodic'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Vulnerary'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Nervine'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Valeriana officinalis', 'Valerian'), get_or_create_action('Nervine'), 2);

  -- ============================================================================
  -- DISORDER: Ulcerative Colitis
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Ulcerative Colitis', v_digestive_id, 11)
  RETURNING id INTO v_disorder_id;

  -- Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Inflammatory bowel disease (IBD) refers to two chronic intestinal disorders: Crohn''s disease and ulcerative colitis', 1);

  -- Actions Indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Astringent'),
    'may help stem blood loss.', 1);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Demulcent'),
    'soothe surface irritation.', 2);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Vulnerary'),
    'promote healing of ulcerations in the mucosal lining.', 3);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Anti-inflammatory'),
    'aid the body in its attempt to control inappropriate inflammatory reactions.', 4);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Carminative'),
    'help relieve abdominal discomfort.', 5);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Antispasmodic'),
    'help ease the muscular cramping in the bowel that causes much of the pain.', 6);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Immune Support'),
    'essential and must cover the whole range of issues involved.', 7);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Antimicrobial'),
    'help combat any secondary infection that might arise.', 8);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Eliminative Support'),
    'must be given to the other organs of elimination.', 9);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Nervine'),
    'will help address the psychological components of the condition.', 10);

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id,
    'Dosage: 5 ml of tincture combination three times a day. At least 1 clove of raw garlic should be eaten every day, and a warm infusion of an appropriate carminative nervine should be drunk often.', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Myrica cerifera', 'Bayberry'), '2 parts', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Dioscorea villosa', 'Wild Yam'), '2 parts', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Symphytum officinale', 'Comfrey'), '2 parts', 3);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Valeriana officinalis', 'Valerian'), '1 part', 4);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Agrimonia eupatoria', 'Agrimony'), '1 part', 5);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), '1 part', 6);

  -- Action Herbs
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Myrica cerifera', 'Bayberry'), get_or_create_action('Astringent'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Agrimonia eupatoria', 'Agrimony'), get_or_create_action('Astringent'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Symphytum officinale', 'Comfrey'), get_or_create_action('Astringent'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Symphytum officinale', 'Comfrey'), get_or_create_action('Demulcent'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Symphytum officinale', 'Comfrey'), get_or_create_action('Vulnerary'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Vulnerary'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Dioscorea villosa', 'Wild Yam'), get_or_create_action('Anti-inflammatory'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Anti-inflammatory'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Valeriana officinalis', 'Valerian'), get_or_create_action('Carminative'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Carminative'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Valeriana officinalis', 'Valerian'), get_or_create_action('Antispasmodic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Antispasmodic'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Valeriana officinalis', 'Valerian'), get_or_create_action('Nervine'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Nervine'), 2);

  -- ============================================================================
  -- DISORDER: Diverticulitis
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Diverticulitis', v_digestive_id, 12)
  RETURNING id INTO v_disorder_id;

  -- Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'A diverticulum is a small, saclike pouch or hernation of the colonic mucosa that bulges outward through a weak spot in the colon wall; these are collectively known as di-verticula. About half of all Americans aged 60 to 80 and almost everyone over the age of 80 has diverticulosis, or the condition characterized by the presence of diverticula.', 1);

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'When diverticula become inflamed, the disorder is called diverticulitis. This happens in 10% to 25% of people with diverticulosis.', 2);

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Pain and tenderness associated with constipation that alternates with diarrhea.', 3);

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Diverticulitis is common in industrialized countries where low-fiber diets are the norm, but rare in countries where people eat high-fiber diets rich in vegetables.', 4);

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Straining due to constipation increases pressure in the colon, which causes weak spots to bulge out and become diverticula.', 5);

  -- Actions Indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Antispasmodic'),
    'help relieve abdominal pain caused by cramping around diverticula.', 1);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Anti-inflammatory'),
    'reduce the generalized inflammatory response within the colon.', 2);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Antimicrobial'),
    'help the body deal with any infection that might be present.', 3);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Carminative'),
    'lessen discomfort due to flatulence.', 4);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Nervine'),
    'ease stress, which may be either causal or a result of the condition.', 5);

  -- Specific Remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Dioscorea villosa', 'Wild Yam'),
    'is a very useful specific here. It is a good antispasmodic and anti-inflammatory herb, but also has a specific impact upon this condition.', 1);

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id,
    'Dosage: 5 ml of tincture combination three times a day. An infusion of Matricaria or Mentha piperita sipped slowly throughout the day will help. One clove a day of garlic (Allium sativum) should be eaten raw as part of the diet, or an equivalent amount taken in supplement form. The supplement should be a 600 mg oil "perle" containing 6 mg of allicin.', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Dioscorea villosa', 'Wild Yam'), '2 parts', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Valeriana officinalis', 'Valerian'), '1 part', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Viburnum opulus', 'Cramp Bark'), '1 part', 3);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Mentha piperita', 'Peppermint'), '1 part', 4);

  -- Action Herbs
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Dioscorea villosa', 'Wild Yam'), get_or_create_action('Antispasmodic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Viburnum opulus', 'Cramp Bark'), get_or_create_action('Antispasmodic'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Mentha piperita', 'Peppermint'), get_or_create_action('Antispasmodic'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Dioscorea villosa', 'Wild Yam'), get_or_create_action('Anti-inflammatory'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Mentha piperita', 'Peppermint'), get_or_create_action('Anti-inflammatory'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Allium sativum', 'Garlic'), get_or_create_action('Antimicrobial'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Valeriana officinalis', 'Valerian'), get_or_create_action('Carminative'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Mentha piperita', 'Peppermint'), get_or_create_action('Carminative'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Valeriana officinalis', 'Valerian'), get_or_create_action('Nervine'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Mentha piperita', 'Peppermint'), get_or_create_action('Nervine'), 2);

  -- ============================================================================
  -- DISORDER: Liver Disease
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Liver Disease', v_digestive_id, 13)
  RETURNING id INTO v_disorder_id;

  -- Specific Remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), '', 1);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Silybum marianum', 'Milk Thistle'), '', 2);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Chelone glabra', 'Balmony'), '', 3);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Schisandra chinensis', 'Schisandra'), '', 4);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Glycyrrhiza glabra', 'Licorice'), '', 5);

END $$;

-- Cleanup helper functions
DROP FUNCTION IF EXISTS get_or_create_herb(TEXT, TEXT);
DROP FUNCTION IF EXISTS get_or_create_action(TEXT);

-- ============================================================================
-- NOTE: Part 2 contains disorders 10-13
-- Remaining disorders to be added in part 3:
-- - Jaundice
-- - Chronic Hepatitis
-- - Viral Hepatitis
-- - Cirrhosis
-- - Cholecystitis
-- - Cholelithiasis
-- - Hemorrhoids
-- ============================================================================
-- Populate GI/Digestive System Disorders Data - Part 3 (FINAL)
-- Continuation of 011_populate_gi_disorders_part2.sql
-- Data extracted from GI.md - Liver/Gallbladder disorders and Hemorrhoids

SET search_path TO herbal, public;

-- Recreate helper functions
CREATE OR REPLACE FUNCTION get_or_create_herb(p_latin_name TEXT, p_common_name TEXT DEFAULT NULL)
RETURNS INTEGER AS $$
DECLARE
  v_herb_id INTEGER;
  v_common_name TEXT;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = p_latin_name;
  IF v_herb_id IS NULL THEN
    v_common_name := COALESCE(p_common_name, INITCAP(SPLIT_PART(p_latin_name, ' ', 1)));
    INSERT INTO herbal.herbs (latin_name, common_name)
    VALUES (p_latin_name, v_common_name)
    RETURNING id INTO v_herb_id;
  END IF;
  RETURN v_herb_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_or_create_action(p_action_name TEXT)
RETURNS INTEGER AS $$
DECLARE
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = p_action_name;
  IF v_action_id IS NULL THEN
    INSERT INTO herbal.primary_actions (name)
    VALUES (p_action_name)
    RETURNING id INTO v_action_id;
  END IF;
  RETURN v_action_id;
END;
$$ LANGUAGE plpgsql;

DO $$
DECLARE
  v_digestive_id INTEGER;
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
BEGIN
  SELECT id INTO v_digestive_id FROM herbal.body_systems WHERE name = 'Digestive';

  -- ============================================================================
  -- DISORDER: Jaundice
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Jaundice', v_digestive_id, 14)
  RETURNING id INTO v_disorder_id;

  -- Specific Remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'),
    'In Europe, has traditionally been considered specific', 1);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Verbena officinalis', 'Vervain'),
    'In Europe, has traditionally been considered specific', 2);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Silybum marianum', 'Milk Thistle'),
    'because can help regenerate liver cells, this herb can help ensure that bile buildup does not cause hepatotoxicity', 3);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Chionanthus virginicus', 'Fringetree'), '', 4);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Leptandra virginica', 'Black Root'), '', 5);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Chelone glabra', 'Balmony'), '', 6);

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id,
    'Dosage: up to 2.5 ml of tincture combination three times a day, building up to 5 ml three times a day. An infusion of Stellaria media or distilled witch hazel may be applied topically to relieve itching.', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), '2 parts', 'root', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Verbena officinalis', 'Vervain'), '1 part', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Silybum marianum', 'Milk Thistle'), '1 part', 3);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Chionanthus virginicus', 'Fringetree'), '1 part', 4);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Peumus boldus', 'Boldo'), '1 part', 5);

  -- Action Herbs
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), get_or_create_action('Hepatic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Verbena officinalis', 'Vervain'), get_or_create_action('Hepatic'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Silybum marianum', 'Milk Thistle'), get_or_create_action('Hepatic'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Chionanthus virginicus', 'Fringetree'), get_or_create_action('Hepatic'), 4);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Peumus boldus', 'Boldo'), get_or_create_action('Hepatic'), 5);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), get_or_create_action('Bitter'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Peumus boldus', 'Boldo'), get_or_create_action('Bitter'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), get_or_create_action('Alterative'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Peumus boldus', 'Boldo'), get_or_create_action('Alterative'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), get_or_create_action('Tonic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Peumus boldus', 'Boldo'), get_or_create_action('Tonic'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Stellaria media', 'Chickweed'), get_or_create_action('Antipruritic'), 1);

  -- ============================================================================
  -- DISORDER: Chronic Hepatitis
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Chronic Hepatitis', v_digestive_id, 15)
  RETURNING id INTO v_disorder_id;

  -- Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'The term hepatitis embraces a number of specific syndromes with a range of causes and prognoses. They all share a core pathology of an inflammatory response in liver cells (hepatocytes) that can lead to cellular necrosis.', 1);

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'In chronic hepatitis, the necrosis and inflammation lasts longer than six months to a year.', 2);

  -- Actions Indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Hepatic'),
    'help support and improve liver function and metabolism.', 1);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Antimicrobial'),
    'will be critical if the hepatitis has an infectious basis, and will help with surface immune support even if no infection is present.', 2);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Bitter'),
    'help with whole-system toning.', 3);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Cholagogue'),
    'have a direct impact on the secretion and release of bile, and thus may be indicated if jaundice is present.', 4);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Eliminative Support'),
    'will help the whole body deal with the buildup of bilirubin and other metabolites, Laxatives, diuretics, and diaphoretics are the primary actions to consider.', 5);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Alterative'),
    'support the whole body in its healing work.', 6);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Tonic'),
    'support the whole body in its healing work.', 7);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Lymphatic'),
    'promote tissue drainage.', 8);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Nervine'),
    'may be needed for symptomatic support,', 9);

  -- Specific Remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Silybum marianum', 'Milk Thistle'),
    'Because of its regenerative potential, comes closest to being a textbook specific', 1);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'),
    'The tonic hepatics are all relevant', 2);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Peumus boldus', 'Boldo'),
    'The tonic hepatics are all relevant', 3);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Chionanthus virginicus', 'Fringetree'),
    'The tonic hepatics are all relevant', 4);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Leptandra virginica', 'Black Root'),
    'The tonic hepatics are all relevant', 5);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Chelone glabra', 'Balmony'),
    'The tonic hepatics are all relevant', 6);

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id,
    'Dosage: up to 2.5 ml of tincture three times a day, building up to 5 ml three times a day. Artemisia vulgaris is included as a bitter nervine, but this herb could be replaced with Verbena officianalis or another appropriate nervine.', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), '2 parts', 'root', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Silybum marianum', 'Milk Thistle'), '2 parts', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Echinacea spp.', 'Echinacea'), '1 part', 3);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Artemisia vulgaris', 'Mugwort'), '1 part', 4);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Chionanthus virginicus', 'Fringetree'), '1 part', 5);

  -- Action Herbs
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), get_or_create_action('Hepatic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Silybum marianum', 'Milk Thistle'), get_or_create_action('Hepatic'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Chionanthus virginicus', 'Fringetree'), get_or_create_action('Hepatic'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Peumus boldus', 'Boldo'), get_or_create_action('Hepatic'), 4);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Echinacea spp.', 'Echinacea'), get_or_create_action('Antimicrobial'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Silybum marianum', 'Milk Thistle'), get_or_create_action('Antihepatotoxic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Artemisia vulgaris', 'Mugwort'), get_or_create_action('Bitter'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), get_or_create_action('Bitter'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Peumus boldus', 'Boldo'), get_or_create_action('Bitter'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), get_or_create_action('Alterative'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Peumus boldus', 'Boldo'), get_or_create_action('Alterative'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), get_or_create_action('Tonic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Peumus boldus', 'Boldo'), get_or_create_action('Tonic'), 2);

  -- ============================================================================
  -- DISORDER: Viral Hepatitis
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Viral Hepatitis', v_digestive_id, 16)
  RETURNING id INTO v_disorder_id;

  -- Specific Remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Hypericum perforatum', 'St. John''s Wort'),
    'The use in this kind of viral infection is worth exploring. The compounds hypericin and pseudohypericin are known to disrupt viral replication by damaging the integrity of the lipid envelope.', 1);

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id, 'Dosage: 5 ml with water four times a day', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Echinacea angustifolia', 'Narrow-leaf Echinacea'), '35 ml', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Hypericum perforatum', 'St. John''s Wort'), '25 ml', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Silybum marianum', 'Milk Thistle'), '20 ml', 3);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Phyllanthus amarus', 'Stonebreaker'), '20 ml', 4);

  -- Action Herbs (comprehensive list from the file)
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Eleutherococcus senticosus', 'Siberian Ginseng'), get_or_create_action('Adaptogen'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Glycyrrhiza glabra', 'Licorice'), get_or_create_action('Adaptogen'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Panax ginseng', 'Asian Ginseng'), get_or_create_action('Adaptogen'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Rehmannia glutinosa', 'Rehmannia'), get_or_create_action('Adaptogen'), 4);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Withania somnifera', 'Ashwagandha'), get_or_create_action('Adaptogen'), 5);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Avena sativa', 'Oat'), get_or_create_action('Antidepressant'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Hypericum perforatum', 'St. John''s Wort'), get_or_create_action('Antidepressant'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Verbena officinalis', 'Vervain'), get_or_create_action('Antidepressant'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Bupleurum falcatum', 'Bupleurum'), get_or_create_action('Anti-inflammatory'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Anti-inflammatory'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Curcuma longa', 'Turmeric'), get_or_create_action('Anti-inflammatory'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Allium sativum', 'Garlic'), get_or_create_action('Antioxidant'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Ginkgo biloba', 'Ginkgo'), get_or_create_action('Antioxidant'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Silybum marianum', 'Milk Thistle'), get_or_create_action('Antioxidant'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Astragalus membranaceus', 'Astragalus'), get_or_create_action('Antiviral'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Lentinus edodes', 'Shiitake'), get_or_create_action('Antiviral'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Phyllanthus amarus', 'Stonebreaker'), get_or_create_action('Antiviral'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Picrorrhiza kurroa', 'Kutki'), get_or_create_action('Antiviral'), 4);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Thuja occidentalis', 'Thuja'), get_or_create_action('Antiviral'), 5);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Schisandra chinensis', 'Schisandra'), get_or_create_action('Detoxifying'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), get_or_create_action('Detoxifying'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Cynara scolymus', 'Artichoke'), get_or_create_action('Antihepatotoxic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Echinacea spp.', 'Echinacea'), get_or_create_action('Immunostimulant'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Ganoderma lucidum', 'Reishi'), get_or_create_action('Immunostimulant'), 2);

  -- ============================================================================
  -- DISORDER: Cirrhosis
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Cirrhosis', v_digestive_id, 17)
  RETURNING id INTO v_disorder_id;

  -- Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'The condition is characterized by widespread death of liver cells, accompanied by progressive fibrosis and distortion of liver architecture. This can be due to many causes, but in the United States and Europe is most commonly related to alcohol abuse.', 1);

  -- Actions Indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Hepatic'),
    'support and improve liver function and metabolism.', 1);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Cholagogue'),
    'have a direct upon the secretion and release of bile', 2);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Eliminative Support'),
    'will help the whole body deal with the buildup of bilirubin and other metabolites. Laxatives, diuretics, and diaphoretics are the primary actions to consider.', 3);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Alterative'),
    'support the whole body in its healing work.', 4);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Tonic'),
    'support the whole body in its healing work.', 4);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Bitter'),
    'help with whole-system toning.', 5);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Lymphatic'),
    'promote systemic tissue drainage.', 6);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Nervine'),
    'will support any psychological work needed in alcohol withdrawal.', 7);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Antimicrobial'),
    'will be helpful for surface immune support, even if no infection is present.', 8);

  -- Specific Remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Silybum marianum', 'Milk Thistle'),
    'comes closest to being a textbook specific, because of its regenerative potential. This wonderful remedy is essential to any treatment of cirrhosis.', 1);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'),
    'the tonic hepatic herbs are all relevant', 2);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Peumus boldus', 'Boldo'),
    'the tonic hepatic herbs are all relevant', 3);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Chionanthus virginicus', 'Fringetree'),
    'the tonic hepatic herbs are all relevant', 4);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Leptandra virginica', 'Black Root'),
    'the tonic hepatic herbs are all relevant', 5);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Chelone glabra', 'Balmony'),
    'the tonic hepatic herbs are all relevant', 6);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Hydrastis canadensis', 'Goldenseal'),
    'may be useful', 7);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Cynara scolymus', 'Artichoke'),
    'may be useful', 8);

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id,
    'Dosage: up to 2.5 ml of tincture three times a day, building up to 5 ml three times a day. The alcohol base of tinctures may pose a problem. If these remedies cannot be obtained in an alcohol-free glycerite form, the medicine can be put into a small amount of hot water; the alcohol will evaporate and leave behind the herbal component.', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Silybum marianum', 'Milk Thistle'), '2 parts', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Verbena officinalis', 'Vervain'), '1 part', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Chelone glabra', 'Balmony'), '1 part', 3);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Chionanthus virginicus', 'Fringetree'), '1 part', 4);

  -- ============================================================================
  -- DISORDER: Cholecystitis
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Cholecystitis', v_digestive_id, 18)
  RETURNING id INTO v_disorder_id;

  -- Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Cholecystitis, or gallbladder inflammation, is characterized by severe pain that becomes localized in the upper right quadrant of the abdomen, radiating to the right lower shoulder blade. Nausea and vomiting are common symptoms. Cholecystitis may be associated with gallstones, but the stones constitute a separate condition.', 1);

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Even though people can tolerate the absence of the gallbladder, a healthy gallbladder helps ensure efficient digestion, which directly decreases the risks of developing arte-riosclerosis, irritable bowel syndrome, hypertension, heart disease, stroke, and other major diseases.', 2);

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Diet and stress management are critical. Strong chemical pain relief may be indicated for severe cases.', 3);

  -- Actions Indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Hepatic'),
    'support the work of the liver and so will have a positive metabolic effect.', 1);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Anti-inflammatory'),
    'may help reduce the severity of swelling.', 2);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Antispasmodic'),
    'help ease colic in the gallbladder or ducts.', 3);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Eliminative Support'),
    'must be provided to help the whole body deal with the repercussions of digestive distress and systemic problems.', 4);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Alterative'),
    'support the whole body in its healing work', 5);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Tonic'),
    'support the whole body in its healing work', 5);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Nervine'),
    'help ease the strain from pain and general worry.', 6);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Antimicrobial'),
    'will provide surface immune support even if no infection is present.', 7);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Bitter'),
    'Caution: Bitters and strong cholagogues are contraindicated, because they increase the strength of peristaltic muscular contractions.', 8);

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id,
    'Dosage: up to 5 ml of tincture three times a day. An infusion of a carminative, antispasmodic nervine, such as Matricaria recu-tita, should be taken regularly throughout the day. In addition, the patient should take Silybum marianum tablets or capsules standardized to 80% silymarin. Recommended dosage is 1 capsule containing 140 mg of silymarin three times daily. NOTE: This prescription supplies antispasmodic, hepatic, nervine, and preventive antilithic actions. Many other herbs could have been used. Consider Chelone glabra, Verbena officinalis, and Mahonia aquifolium. The Eclectic physicians would have suggested that small amounts of Hydrastis canadensis and Lobelia inflata be added to such a mixture.', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Dioscorea villosa', 'Wild Yam'), '2 parts', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Chionanthus virginicus', 'Fringetree'), '2 parts', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Valeriana officinalis', 'Valerian'), '2 parts', 3);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), '1 part', 'root', 4);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Leptandra virginica', 'Black Root'), '1 part', 5);

  -- Action Herbs
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), get_or_create_action('Hepatic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Chionanthus virginicus', 'Fringetree'), get_or_create_action('Hepatic'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Leptandra virginica', 'Black Root'), get_or_create_action('Hepatic'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), get_or_create_action('Anti-inflammatory'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Dioscorea villosa', 'Wild Yam'), get_or_create_action('Antispasmodic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Valeriana officinalis', 'Valerian'), get_or_create_action('Antispasmodic'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), get_or_create_action('Alterative'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Leptandra virginica', 'Black Root'), get_or_create_action('Alterative'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), get_or_create_action('Tonic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Leptandra virginica', 'Black Root'), get_or_create_action('Tonic'), 2);

  -- ============================================================================
  -- DISORDER: Cholelithiasis
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Cholelithiasis', v_digestive_id, 19)
  RETURNING id INTO v_disorder_id;

  -- Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Gallstones appear to be caused by a combination of factors, including inherited body chemistry, body weight, gallbladder movement, and diet.', 1);

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Diet and stress management are critical. Strong chemical pain relief may be indicated for severe cases.', 2);

  -- Actions Indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Antilithic'),
    'have a long tradition of use in moving or even dissolving gallstones and easing pain.', 1);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Hepatic'),
    'support the work of the liver and have a positive metabolic effect.', 2);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Antispasmodic'),
    'relieve colic in the gallbladder or ducts.', 3);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Nervine'),
    'ease the strain from pain and general worry.', 4);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Eliminative Support'),
    'must be provided to help the whole body deal with the repercussions of digestive distress and systemic problems.', 5);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Alterative'),
    'support the whole body in its healing work.', 6);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Tonic'),
    'support the whole body in its healing work.', 7);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Antimicrobial'),
    'will help with surface immune support, even if no infection is present.', 8);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Bitter'),
    'Caution: Bitters and strong cholagogues are contraindicated, because they increase the strength of peristaltic muscular contractions.', 9);

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id,
    'Dosage: up to 5 ml of tincture three times a day. An infusion of a carminative, antispasmodic, nervine herb should be taken regularly throughout the day (for example, Matricaria recutita).', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Dioscorea villosa', 'Wild Yam'), '2 parts', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Valeriana officinalis', 'Valerian'), '2 parts', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Chelone glabra', 'Balmony'), '1 part', 3);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Leptandra virginica', 'Black Root'), '1 part', 4);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Chionanthus virginicus', 'Fringetree'), '1 part', 5);

  -- Action Herbs
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Chelone glabra', 'Balmony'), get_or_create_action('Hepatic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Chionanthus virginicus', 'Fringetree'), get_or_create_action('Hepatic'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Leptandra virginica', 'Black Root'), get_or_create_action('Hepatic'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Chelone glabra', 'Balmony'), get_or_create_action('Antilithic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Chionanthus virginicus', 'Fringetree'), get_or_create_action('Antilithic'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Dioscorea villosa', 'Wild Yam'), get_or_create_action('Antispasmodic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Valeriana officinalis', 'Valerian'), get_or_create_action('Antispasmodic'), 2);

  -- ============================================================================
  -- DISORDER: Hemorrhoids
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Hemorrhoids', v_digestive_id, 20)
  RETURNING id INTO v_disorder_id;

  -- Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Hemorrhoids are caused by increased pressure in the veins of the anus.', 1);

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Avoidance or elimination of constipation is often the key to alleviating hemorrhoids.', 2);

  -- Actions Indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Vascular Tonic'),
    'will help with the muscular tone and general state of well-being of the veins involved.', 1);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Astringent'),
    'will reduce bleeding, if present, and tighten the tissue locally. However, if they are used internally, take care to avoid constipation.', 2);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Bitter'),
    'assist digestive and eliminative processes and facilitate bowel motions.', 3);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Aperient'),
    'ensure easier bowel movements.', 4);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Laxative'),
    'ensure easier bowel movements.', 4);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Vulnerary'),
    'speed local healing of inflamed tissues.', 5);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Emollient'),
    'soothe irritated tissue if applied externally.', 6);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Anti-inflammatory'),
    'soothe inflamed tissues.', 7);

  -- Specific Remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Ranunculus ficaria', 'Pilewort'),
    'In Europe, nothing matches the action of the aptly named pilewort! Apart from this plant, most astringent or anti-inflammatory herbs will help if applied topically.', 1);

  -- Prescription 1: Internal
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id, 'Dosage: 5 ml of tincture three times a day', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Ginkgo biloba', 'Ginkgo'), '1 part', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Aesculus hippocastanum', 'Horse Chestnut'), '1 part', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), '1 part', 3);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Hydrastis canadensis', 'Goldenseal'), '1 part', 4);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Geranium maculatum', 'Cranesbill'), '1 part', 5);

  -- Prescription 2: Topical
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Topical application',
    'Apply this combination after every bowel movement and as needed. Salves containing any of many possible herbs may also be used. Useful herbs include Calendula officinalis, Hypericum perforatum, Matricaria recutita, Plantago spp., and Achillea millefolium.', 2)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Aesculus hippocastanum', 'Horse Chestnut'), '10 ml', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Hamamelis virginiana', 'Witch Hazel'), '80 ml', 'distilled', 2);

  -- Action Herbs
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Ginkgo biloba', 'Ginkgo'), get_or_create_action('Vascular Tonic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Aesculus hippocastanum', 'Horse Chestnut'), get_or_create_action('Vascular Tonic'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Geranium maculatum', 'Cranesbill'), get_or_create_action('Astringent'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), get_or_create_action('Bitter'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Hydrastis canadensis', 'Goldenseal'), get_or_create_action('Bitter'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), get_or_create_action('Aperient'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Hydrastis canadensis', 'Goldenseal'), get_or_create_action('Aperient'), 2);

END $$;

-- Cleanup helper functions
DROP FUNCTION IF EXISTS get_or_create_herb(TEXT, TEXT);
DROP FUNCTION IF EXISTS get_or_create_action(TEXT);

-- ============================================================================
-- COMPLETE! All 20 GI/Digestive disorders have been migrated.
--
-- Summary of disorders added in this file (Part 3):
-- 14. Jaundice
-- 15. Chronic Hepatitis
-- 16. Viral Hepatitis
-- 17. Cirrhosis
-- 18. Cholecystitis
-- 19. Cholelithiasis
-- 20. Hemorrhoids
--
-- Combined with Parts 1 and 2, all GI disorders from GI.md are now in the database!
-- ============================================================================
-- Link prescription herbs to their therapeutic actions
-- This migration populates the prescription_herb_actions junction table
-- by matching prescription herbs with their actions from disorder_action_herbs

SET search_path TO herbal, public;

-- For each prescription herb, find its matching actions from disorder_action_herbs
-- and create the linkage in prescription_herb_actions
INSERT INTO herbal.prescription_herb_actions (prescription_herb_id, primary_action_id)
SELECT DISTINCT
  ph.id as prescription_herb_id,
  dah.primary_action_id
FROM herbal.prescription_herbs ph
JOIN herbal.disorder_prescriptions dp ON ph.prescription_id = dp.id
JOIN herbal.disorder_action_herbs dah ON dah.disorder_id = dp.disorder_id
  AND dah.herb_id = ph.herb_id
WHERE NOT EXISTS (
  -- Don't create duplicates
  SELECT 1 FROM herbal.prescription_herb_actions pha
  WHERE pha.prescription_herb_id = ph.id
    AND pha.primary_action_id = dah.primary_action_id
)
ORDER BY ph.id, dah.primary_action_id;

-- Summary: Show how many prescription herb actions were linked
DO $$
DECLARE
  v_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO v_count FROM herbal.prescription_herb_actions;
END $$;
-- Sync herb_primary_actions from disorder_action_herbs
-- This migration fills gaps in herb_primary_actions by finding all unique
-- herb-action pairs from disorder contexts and adding them to the general catalog

SET search_path TO herbal, public;

-- Insert missing herb-action pairs from disorder_action_herbs into herb_primary_actions
-- We'll leave body_system_id NULL since these are general actions not specific to a system
INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
SELECT DISTINCT
  dah.herb_id,
  dah.primary_action_id,
  NULL::integer as body_system_id
FROM herbal.disorder_action_herbs dah
WHERE NOT EXISTS (
  -- Only insert if this herb-action pair doesn't already exist
  SELECT 1 FROM herbal.herb_primary_actions hpa
  WHERE hpa.herb_id = dah.herb_id
    AND hpa.primary_action_id = dah.primary_action_id
)
ORDER BY dah.herb_id, dah.primary_action_id;

-- Summary: Show how many herb-action pairs were added
DO $$
DECLARE
  v_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO v_count
  FROM herbal.herb_primary_actions
  WHERE body_system_id IS NULL;

END $$;
-- Update herb_primary_actions to include body_system_id from disorder context
-- This fixes entries created by migration 014 that have NULL body_system_id

SET search_path TO herbal, public;

-- Update the NULL body_system_id entries with the appropriate body system
-- from the disorder context where we found the herb-action relationship
UPDATE herbal.herb_primary_actions hpa
SET body_system_id = d.body_system_id
FROM herbal.disorder_action_herbs dah
JOIN herbal.disorders d ON dah.disorder_id = d.id
WHERE hpa.herb_id = dah.herb_id
  AND hpa.primary_action_id = dah.primary_action_id
  AND hpa.body_system_id IS NULL;

-- Summary: Show how many entries were updated
DO $$
DECLARE
  v_updated_count INTEGER;
  v_remaining_null INTEGER;
BEGIN
  -- Get count of entries that now have body systems
  SELECT COUNT(*) INTO v_updated_count
  FROM herbal.herb_primary_actions
  WHERE body_system_id IS NOT NULL;

  -- Check if any NULL entries remain
  SELECT COUNT(*) INTO v_remaining_null
  FROM herbal.herb_primary_actions
  WHERE body_system_id IS NULL;

END $$;
-- Add Immune System as a body system

SET search_path TO herbal, public;

-- Add Immune System to body_systems table
INSERT INTO herbal.body_systems (name)
VALUES ('Immune')
ON CONFLICT (name) DO NOTHING;
-- Populate tonic herbs organized by body system
-- From Immune System.md "Tonic Herbs by system" section

SET search_path TO herbal, public;

-- ============================================================================
-- HELPER FUNCTION: Insert herb if not exists and return its ID
-- ============================================================================
CREATE OR REPLACE FUNCTION herbal.ensure_herb(p_latin_name TEXT, p_common_name TEXT)
RETURNS INTEGER AS $$
DECLARE
  v_herb_id INTEGER;
BEGIN
  INSERT INTO herbal.herbs (latin_name, common_name)
  VALUES (p_latin_name, p_common_name)
  ON CONFLICT (latin_name) DO NOTHING
  RETURNING id INTO v_herb_id;

  IF v_herb_id IS NULL THEN
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = p_latin_name;
  END IF;

  RETURN v_herb_id;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- HELPER FUNCTION: Insert action if not exists and return its ID
-- ============================================================================
CREATE OR REPLACE FUNCTION herbal.ensure_action(p_action_name TEXT)
RETURNS INTEGER AS $$
DECLARE
  v_action_id INTEGER;
BEGIN
  INSERT INTO herbal.primary_actions (name)
  VALUES (p_action_name)
  ON CONFLICT (name) DO NOTHING
  RETURNING id INTO v_action_id;

  IF v_action_id IS NULL THEN
    SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = p_action_name;
  END IF;

  RETURN v_action_id;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- TONIC HERBS BY SYSTEM
-- ============================================================================

DO $$
DECLARE
  v_herb_id INTEGER;
  v_action_id INTEGER;
  v_system_id INTEGER;
BEGIN
  -- Get or create the Tonic action
  v_action_id := herbal.ensure_action('Tonic');

  -- ============================================================================
  -- CARDIOVASCULAR TONICS
  -- ============================================================================
  SELECT id INTO v_system_id FROM herbal.body_systems WHERE name = 'Cardiovascular';

  v_herb_id := herbal.ensure_herb('Crataegus spp.', 'hawthorn');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Allium sativum', 'garlic');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Ginkgo biloba', 'ginkgo');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- ============================================================================
  -- RESPIRATORY TONICS
  -- ============================================================================
  SELECT id INTO v_system_id FROM herbal.body_systems WHERE name = 'Respiratory';

  v_herb_id := herbal.ensure_herb('Verbascum thapsus', 'mullein');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Inula helenium', 'elecampane');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- ============================================================================
  -- DIGESTIVE TONICS
  -- ============================================================================
  SELECT id INTO v_system_id FROM herbal.body_systems WHERE name = 'Digestive';

  v_herb_id := herbal.ensure_herb('Filipendula ulmaria', 'meadowsweet');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Gentiana lutea', 'gentian');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note)
  VALUES (v_herb_id, v_action_id, v_system_id, 'beneficial for the liver')
  ON CONFLICT (herb_id, primary_action_id, body_system_id)
  DO UPDATE SET body_system_note = EXCLUDED.body_system_note;

  v_herb_id := herbal.ensure_herb('Matricaria recutita', 'chamomile');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Silybum marianum', 'milk thistle');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note)
  VALUES (v_herb_id, v_action_id, v_system_id, 'beneficial for the liver')
  ON CONFLICT (herb_id, primary_action_id, body_system_id)
  DO UPDATE SET body_system_note = EXCLUDED.body_system_note;

  v_herb_id := herbal.ensure_herb('Taraxacum officinale', 'dandelion');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note)
  VALUES (v_herb_id, v_action_id, v_system_id, 'root is beneficial for the liver')
  ON CONFLICT (herb_id, primary_action_id, body_system_id)
  DO UPDATE SET body_system_note = EXCLUDED.body_system_note;

  -- ============================================================================
  -- URINARY TONICS
  -- ============================================================================
  SELECT id INTO v_system_id FROM herbal.body_systems WHERE name = 'Urinary';

  v_herb_id := herbal.ensure_herb('Arctostaphylos uva-ursi', 'bearberry');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Zea mays', 'corn silk');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- ============================================================================
  -- REPRODUCTIVE TONICS (WOMEN)
  -- ============================================================================
  SELECT id INTO v_system_id FROM herbal.body_systems WHERE name = 'Reproductive';

  v_herb_id := herbal.ensure_herb('Mitchella repens', 'partridge berry');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note)
  VALUES (v_herb_id, v_action_id, v_system_id, 'for women')
  ON CONFLICT (herb_id, primary_action_id, body_system_id)
  DO UPDATE SET body_system_note = EXCLUDED.body_system_note;

  v_herb_id := herbal.ensure_herb('Rubus idaeus', 'red raspberry');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note)
  VALUES (v_herb_id, v_action_id, v_system_id, 'for women')
  ON CONFLICT (herb_id, primary_action_id, body_system_id)
  DO UPDATE SET body_system_note = EXCLUDED.body_system_note;

  -- ============================================================================
  -- REPRODUCTIVE TONICS (MEN)
  -- ============================================================================
  v_herb_id := herbal.ensure_herb('Serenoa repens', 'saw palmetto');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note)
  VALUES (v_herb_id, v_action_id, v_system_id, 'for men')
  ON CONFLICT (herb_id, primary_action_id, body_system_id)
  DO UPDATE SET body_system_note = EXCLUDED.body_system_note;

  -- ============================================================================
  -- NERVOUS SYSTEM TONICS
  -- ============================================================================
  SELECT id INTO v_system_id FROM herbal.body_systems WHERE name = 'Nervous';

  v_herb_id := herbal.ensure_herb('Avena sativa', 'oat');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Scutellaria lateriflora', 'skullcap');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Hypericum perforatum', 'St. John''s wort');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- ============================================================================
  -- MUSCULOSKELETAL TONICS
  -- ============================================================================
  SELECT id INTO v_system_id FROM herbal.body_systems WHERE name = 'Musculoskeletal';

  v_herb_id := herbal.ensure_herb('Apium graveolens', 'celery');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Urtica dioica', 'nettle');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- ============================================================================
  -- SKIN TONICS
  -- ============================================================================
  SELECT id INTO v_system_id FROM herbal.body_systems WHERE name = 'Skin';

  v_herb_id := herbal.ensure_herb('Galium aparine', 'cleavers');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Urtica dioica already created above
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Urtica dioica';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Trifolium pratense', 'red clover');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

END $$;

-- Clean up helper functions
DROP FUNCTION IF EXISTS herbal.ensure_herb(TEXT, TEXT);
DROP FUNCTION IF EXISTS herbal.ensure_action(TEXT);
-- Populate antimicrobial herbs for Digestive and Respiratory systems
-- From Immune System.md antimicrobial sections

SET search_path TO herbal, public;

-- ============================================================================
-- HELPER FUNCTIONS
-- ============================================================================
CREATE OR REPLACE FUNCTION herbal.ensure_herb(p_latin_name TEXT, p_common_name TEXT)
RETURNS INTEGER AS $$
DECLARE
  v_herb_id INTEGER;
BEGIN
  INSERT INTO herbal.herbs (latin_name, common_name)
  VALUES (p_latin_name, p_common_name)
  ON CONFLICT (latin_name) DO NOTHING
  RETURNING id INTO v_herb_id;

  IF v_herb_id IS NULL THEN
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = p_latin_name;
  END IF;

  RETURN v_herb_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION herbal.ensure_action(p_action_name TEXT)
RETURNS INTEGER AS $$
DECLARE
  v_action_id INTEGER;
BEGIN
  INSERT INTO herbal.primary_actions (name)
  VALUES (p_action_name)
  ON CONFLICT (name) DO NOTHING
  RETURNING id INTO v_action_id;

  IF v_action_id IS NULL THEN
    SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = p_action_name;
  END IF;

  RETURN v_action_id;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- ANTIMICROBIAL HERBS FOR DIGESTIVE SYSTEM
-- ============================================================================

DO $$
DECLARE
  v_herb_id INTEGER;
  v_action_id INTEGER;
  v_digestive_id INTEGER;
  v_respiratory_id INTEGER;
BEGIN
  -- Get or create the Antimicrobial action
  v_action_id := herbal.ensure_action('Antimicrobial');

  -- Get body system IDs
  SELECT id INTO v_digestive_id FROM herbal.body_systems WHERE name = 'Digestive';
  SELECT id INTO v_respiratory_id FROM herbal.body_systems WHERE name = 'Respiratory';

  -- ============================================================================
  -- DIGESTIVE ANTIMICROBIALS
  -- ============================================================================

  v_herb_id := herbal.ensure_herb('Allium sativum', 'garlic');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_digestive_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Artemisia absinthium', 'wormwood');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_digestive_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Capsicum annuum', 'cayenne');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_digestive_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Carum carvi', 'caraway');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_digestive_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Coriandrum sativum', 'coriander');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_digestive_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Gentiana lutea', 'gentian');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_digestive_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Hydrastis canadensis', 'goldenseal');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_digestive_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Rosmarinus officinalis', 'rosemary');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_digestive_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Syzygium aromaticum', 'clove');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_digestive_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Thymus vulgaris', 'thyme');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_digestive_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- ============================================================================
  -- RESPIRATORY ANTIMICROBIALS
  -- ============================================================================

  -- Allium sativum already created
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Allium sativum';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_respiratory_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Baptisia tinctoria', 'wild indigo');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_respiratory_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Commiphora molmol', 'myrrh');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_respiratory_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Echinacea spp.', 'echinacea');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_respiratory_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Eucalyptus spp.', 'eucalyptus');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_respiratory_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Hydrastis canadensis already created
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Hydrastis canadensis';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_respiratory_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Inula helenium already created as tonic
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Inula helenium';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_respiratory_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Ligusticum porteri', 'osha');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_respiratory_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Myroxylon balsamum var. pereirae', 'balsam of Peru');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_respiratory_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Pimpinella anisum', 'anise');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_respiratory_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Populus balsamifera var. balsamifera', 'balm of Gilead');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_respiratory_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Thymus vulgaris already created
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Thymus vulgaris';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_respiratory_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_herb_id := herbal.ensure_herb('Usnea spp.', 'usnea');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_respiratory_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

END $$;

-- Clean up helper functions
DROP FUNCTION IF EXISTS herbal.ensure_herb(TEXT, TEXT);
DROP FUNCTION IF EXISTS herbal.ensure_action(TEXT);
-- Populate Immune System disorders and data - Part 1
-- This includes: system notes, Overall disorder, Autoimmune Diseases, and Elimination/Detox

SET search_path TO herbal, public;

-- ============================================================================
-- HELPER FUNCTIONS
-- ============================================================================
CREATE OR REPLACE FUNCTION herbal.ensure_herb(p_latin_name TEXT, p_common_name TEXT)
RETURNS INTEGER AS $$
DECLARE
  v_herb_id INTEGER;
BEGIN
  INSERT INTO herbal.herbs (latin_name, common_name)
  VALUES (p_latin_name, p_common_name)
  ON CONFLICT (latin_name) DO NOTHING
  RETURNING id INTO v_herb_id;

  IF v_herb_id IS NULL THEN
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = p_latin_name;
  END IF;

  RETURN v_herb_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION herbal.ensure_action(p_action_name TEXT)
RETURNS INTEGER AS $$
DECLARE
  v_action_id INTEGER;
BEGIN
  INSERT INTO herbal.primary_actions (name)
  VALUES (p_action_name)
  ON CONFLICT (name) DO NOTHING
  RETURNING id INTO v_action_id;

  IF v_action_id IS NULL THEN
    SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = p_action_name;
  END IF;

  RETURN v_action_id;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- IMMUNE SYSTEM GENERAL NOTES
-- ============================================================================
-- Note: System-level notes (not disorder-specific) are stored as a special
-- disorder called "System Notes" or similar, or we could add them to a
-- disorder named "Overall" with sort_order 0

DO $$
DECLARE
  v_immune_system_id INTEGER;
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
  v_action_id INTEGER;
BEGIN
  -- Get Immune system ID
  SELECT id INTO v_immune_system_id FROM herbal.body_systems WHERE name = 'Immune';

  -- ============================================================================
  -- CREATE "OVERALL" DISORDER FOR GENERAL IMMUNE SUPPORT
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Overall', v_immune_system_id, 0)
  RETURNING id INTO v_disorder_id;

  -- Add general system notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'Herbal medicine is as limited as orthodox medicine if it is used only to affect T- and B-lymphocyte function, without the benefit of a broader holistic context.', 1),
    (v_disorder_id, 'Human immunity is ecology in action. In other words, there is a multifactorial relationship at play between individuals and their environment.', 2),
    (v_disorder_id, 'Immunity represents an ecological interface between inner and outer environments.', 3),
    (v_disorder_id, 'In human ecology, the immune system is governed by a complex of processes that allow resistance and embrace at the same time. To focus on only one side of this profound interaction is to miss the point and compromise understanding of the whole.', 4),
    (v_disorder_id, 'Immunity is an expression of homeostasis. We now know that in the presence of stress, a large and complex array of mechanical, chemical, and immune changes take place, as the body attempts to defend itself or restore homeostasis.', 5),
    (v_disorder_id, 'The term psychoneuroimmunology comes from our growing understanding of these mind-body connections. Psycho denotes thinking, emotions, and mood states; neuro implies involvement of the neurological and neuroendocrine systems; and immunology refers to cellular structures and the immune system.', 6),
    (v_disorder_id, 'Consider, for example, the commonly held belief in the Western herbal community that Panax ginseng is for men and Angelica sinensis (dong quai) is for women. This is simply not the case. Panax is the strongest yang tonic, while A. sinensis is the most yielding yin tonic. This leads to entirely different therapeutic implications.', 7),
    (v_disorder_id, 'It is too easy to discard the insights of traditional approaches in favor of research published in peer-reviewed journals. This is imprudent, because important insights may be gained when one takes into account the herbal wisdom garnered through generations of experience.', 8),
    (v_disorder_id, 'Herbal medicine is ecological medicine; it is based on an ecological relationship that has evolved through geological time.', 9),
    (v_disorder_id, 'In both the laboratory and the clinic, a growing number of herbal remedies have been shown to have marked effects upon the immune system. Some stimulate immune system responses, but most can best be described as modulators. That is, these remedies facilitate greater immune system flexibility in the body''s natural response to disease.', 10),
    (v_disorder_id, 'Nonspecific immunostimulants do not affect immune system memory cells, and because their pharmacological effects fade relatively quickly, they must be administered either at intervals or continuously.', 11),
    (v_disorder_id, 'The protective immunity conferred by immunostimulants happens quickly and has been termed paramunity.', 12),
    (v_disorder_id, 'Immunomodulation and immunoregulation are terms that have been proposed to denote any effect on immune system responsiveness. For example, herbs may also stimulate T-suppressor cells and thereby reduce immune resistance.', 13),
    (v_disorder_id, 'Immunoadjuvants are substances that enhance the production of antibodies without acting as antigens themselves. The effects of adjuvants are often thymus-dependent.', 14),
    (v_disorder_id, 'Herbalist Christopher Hobbs identifies three relevant levels of herbal activity: • Deep immune activation • Surface immune activation • Adaptogenic action or hormonal modulation', 15),
    (v_disorder_id, 'Autoimmune diseases are conditions in which lymphocytes produce antibodies that attack the body''s own cells and tissues as if they were foreign substances, thus causing pathological damage.', 16),
    (v_disorder_id, 'Conditions thought to have an autoimmune basis include rheumatoid arthritis, polyarthritis, chronic active hepatitis, multiple sclerosis, and psoriasis.', 17),
    (v_disorder_id, 'The real question involves knowing when to use immunostimulant herbs and, even more important, when not to. Stimulating immune system activity may be inappropriate in some conditions and vital in others.', 18),
    (v_disorder_id, 'In general, it seems safe to say that immunostimulant plants should be avoided in conditions that involve inappropriate activity of some aspect of the immune complex. In autoimmune conditions, for example, any stimulation might increase the production or pathological impact of antibodies.', 19);

  -- Add action herbs for Overall immune support
  -- Immunomodulator herbs
  v_action_id := herbal.ensure_action('Immunomodulator');

  v_herb_id := herbal.ensure_herb('Astragalus membranaceus', 'astragalus');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_herb_id := herbal.ensure_herb('Codonopsis tangshen', 'codonopsis');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  v_herb_id := herbal.ensure_herb('Ganoderma lucidum', 'reishi');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  v_herb_id := herbal.ensure_herb('Lentinus edodes', 'shiitake');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 4);

  v_herb_id := herbal.ensure_herb('Ligustrum lucidum', 'privet');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 5);

  v_herb_id := herbal.ensure_herb('Schisandra chinensis', 'schisandra');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 6);

  -- Antimicrobials
  v_action_id := herbal.ensure_action('Antimicrobial');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Allium sativum';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Baptisia tinctoria';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  v_herb_id := herbal.ensure_herb('Calendula officinalis', 'calendula');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Commiphora molmol';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 4);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 5);

  v_herb_id := herbal.ensure_herb('Thuja occidentalis', 'thuja');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 6);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Usnea spp.';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 7);


END $$;

-- ============================================================================
-- AUTOIMMUNE DISEASES
-- ============================================================================

DO $$
DECLARE
  v_immune_system_id INTEGER;
  v_disorder_id INTEGER;
BEGIN
  SELECT id INTO v_immune_system_id FROM herbal.body_systems WHERE name = 'Immune';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Autoimmune Diseases', v_immune_system_id, 1)
  RETURNING id INTO v_disorder_id;

  -- Add disorder-specific notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'Autoimmune diseases are conditions in which lymphocytes produce antibodies that attack the body''s own cells and tissues as if they were foreign substances, thus causing pathological damage.', 1),
    (v_disorder_id, 'Conditions thought to have an autoimmune basis include rheumatoid arthritis, polyarthritis, chronic active hepatitis, multiple sclerosis, and psoriasis.', 2),
    (v_disorder_id, 'The real question involves knowing when to use immunostimulant herbs and, even more important, when not to. Stimulating immune system activity may be inappropriate in some conditions and vital in others.', 3),
    (v_disorder_id, 'In general, it seems safe to say that immunostimulant plants should be avoided in conditions that involve inappropriate activity of some aspect of the immune complex. In autoimmune conditions, for example, any stimulation might increase the production or pathological impact of antibodies.', 4);

END $$;

-- ============================================================================
-- ELIMINATION AND DETOX ISSUES
-- ============================================================================

DO $$
DECLARE
  v_immune_system_id INTEGER;
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_immune_system_id FROM herbal.body_systems WHERE name = 'Immune';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Elimination and Detox Issues', v_immune_system_id, 2)
  RETURNING id INTO v_disorder_id;

  -- Alterative action
  v_action_id := herbal.ensure_action('Alterative');

  v_herb_id := herbal.ensure_herb('Arctium lappa', 'burdock');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Galium aparine';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Urtica dioica';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  -- Aperient/laxative
  v_action_id := herbal.ensure_action('Aperient');

  v_herb_id := herbal.ensure_herb('Rumex crispus', 'yellow dock');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Taraxacum officinale';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  -- Diaphoretic
  v_action_id := herbal.ensure_action('Diaphoretic');

  v_herb_id := herbal.ensure_herb('Achillea millefolium', 'yarrow');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_herb_id := herbal.ensure_herb('Eupatorium perfoliatum', 'boneset');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  v_herb_id := herbal.ensure_herb('Sambucus nigra', 'elder');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  -- Diuretic
  v_action_id := herbal.ensure_action('Diuretic');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Galium aparine';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Taraxacum officinale';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  -- Expectorant
  v_action_id := herbal.ensure_action('Expectorant');

  v_herb_id := herbal.ensure_herb('Marrubium vulgare', 'horehound');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Verbascum thapsus';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  v_herb_id := herbal.ensure_herb('Tussilago farfara', 'coltsfoot');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  -- Hepatic
  v_action_id := herbal.ensure_action('Hepatic');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Taraxacum officinale';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Silybum marianum';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  -- Lymphatic tonic
  v_action_id := herbal.ensure_action('Lymphatic tonic');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Calendula officinalis';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Galium aparine';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Trifolium pratense';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

END $$;

-- Clean up helper functions (will be recreated in next part)
DROP FUNCTION IF EXISTS herbal.ensure_herb(TEXT, TEXT);
DROP FUNCTION IF EXISTS herbal.ensure_action(TEXT);
-- Populate Immune System disorders and data - Part 2
-- This includes: Postoperative Recovery and Infection

SET search_path TO herbal, public;

-- ============================================================================
-- HELPER FUNCTIONS
-- ============================================================================
CREATE OR REPLACE FUNCTION herbal.ensure_herb(p_latin_name TEXT, p_common_name TEXT)
RETURNS INTEGER AS $$
DECLARE
  v_herb_id INTEGER;
BEGIN
  INSERT INTO herbal.herbs (latin_name, common_name)
  VALUES (p_latin_name, p_common_name)
  ON CONFLICT (latin_name) DO NOTHING
  RETURNING id INTO v_herb_id;

  IF v_herb_id IS NULL THEN
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = p_latin_name;
  END IF;

  RETURN v_herb_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION herbal.ensure_action(p_action_name TEXT)
RETURNS INTEGER AS $$
DECLARE
  v_action_id INTEGER;
BEGIN
  INSERT INTO herbal.primary_actions (name)
  VALUES (p_action_name)
  ON CONFLICT (name) DO NOTHING
  RETURNING id INTO v_action_id;

  IF v_action_id IS NULL THEN
    SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = p_action_name;
  END IF;

  RETURN v_action_id;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- POSTOPERATIVE RECOVERY
-- ============================================================================

DO $$
DECLARE
  v_immune_system_id INTEGER;
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_immune_system_id FROM herbal.body_systems WHERE name = 'Immune';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Postoperative Recovery', v_immune_system_id, 3)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'To support the body system that is the focus of the surgical procedure, choose relevant tonic remedies', 1),
    (v_disorder_id, 'Consider Urtica for skin and membranes, Crataegus and Ginkgo for blood vessels, and Hypericum for nerves.', 2);

  -- Adaptogen
  v_action_id := herbal.ensure_action('Adaptogen');

  v_herb_id := herbal.ensure_herb('Eleutherococcus senticosus', 'Siberian ginseng');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, note, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 'help the body adapt around the problem and avoid the possibility of collapse', 1);

  -- Alterative
  v_action_id := herbal.ensure_action('Alterative');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Urtica dioica';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, note, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 'avoid strong immunostimulants and instead use a mild alterative', 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Galium aparine';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, note, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 'avoid strong immunostimulants and instead use a mild alterative', 2);

  -- Hepatic
  v_action_id := herbal.ensure_action('Hepatic');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Silybum marianum';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, note, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 'support the liver''s detoxification process, facilitating the removal of the metabolites from the body and speeding the return to normal. This is the main herb to consider, as it is best to avoid stronger liver stimulants after an operation', 1);

  -- Vulnerary
  v_action_id := herbal.ensure_action('Vulnerary');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Calendula officinalis';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, note, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 'excellent for limiting the amount of scar tissue that forms without compromising the viability of the wound healing, when blended with Vitamin E oil', 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Hypericum perforatum';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, note, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 'excellent for limiting the amount of scar tissue that forms without compromising the viability of the wound healing, when blended with Vitamin E oil', 2);

END $$;

-- ============================================================================
-- INFECTION
-- ============================================================================

DO $$
DECLARE
  v_immune_system_id INTEGER;
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_immune_system_id FROM herbal.body_systems WHERE name = 'Immune';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Infection', v_immune_system_id, 4)
  RETURNING id INTO v_disorder_id;

  -- Antimicrobial
  v_action_id := herbal.ensure_action('Antimicrobial');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Baptisia tinctoria';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, note, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 'The Eclectics recommended this in combination with Echinacea for acute febrile infections.', 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Arctostaphylos uva-ursi';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, note, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 'appropriate for a bladder infection', 2);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Commiphora molmol';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, note, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 'good choice for topical application', 3);

  -- Diaphoretic
  v_action_id := herbal.ensure_action('Diaphoretic');

  v_herb_id := herbal.ensure_herb('Nepeta cataria', 'catnip');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, note, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 'good choice for children', 1);

  v_herb_id := herbal.ensure_herb('Armoracia rusticana', 'horseradish');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, note, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 'reserve this diaphoretic for adults', 2);

  -- Tonic
  v_action_id := herbal.ensure_action('Tonic');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Verbascum thapsus';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, note, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 'may be the right choice for a lung infection', 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Galium aparine';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, note, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 'more appropriate for lymphatic tissue infections', 2);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Crataegus spp.';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, note, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 'use this as a tonic if there is any concern about cardiovascular health', 3);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Ginkgo biloba';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, note, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 'use this as a tonic for an elderly patient', 4);

END $$;

-- Clean up helper functions (will be recreated in next part)
DROP FUNCTION IF EXISTS herbal.ensure_herb(TEXT, TEXT);
DROP FUNCTION IF EXISTS herbal.ensure_action(TEXT);
-- Populate Immune System disorders and data - Part 3
-- This includes: Antibiotic Recovery, Vaginitis, Genitourinary Tract Infections

SET search_path TO herbal, public;

-- ============================================================================
-- HELPER FUNCTIONS
-- ============================================================================
CREATE OR REPLACE FUNCTION herbal.ensure_herb(p_latin_name TEXT, p_common_name TEXT)
RETURNS INTEGER AS $$
DECLARE
  v_herb_id INTEGER;
BEGIN
  INSERT INTO herbal.herbs (latin_name, common_name)
  VALUES (p_latin_name, p_common_name)
  ON CONFLICT (latin_name) DO NOTHING
  RETURNING id INTO v_herb_id;

  IF v_herb_id IS NULL THEN
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = p_latin_name;
  END IF;

  RETURN v_herb_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION herbal.ensure_action(p_action_name TEXT)
RETURNS INTEGER AS $$
DECLARE
  v_action_id INTEGER;
BEGIN
  INSERT INTO herbal.primary_actions (name)
  VALUES (p_action_name)
  ON CONFLICT (name) DO NOTHING
  RETURNING id INTO v_action_id;

  IF v_action_id IS NULL THEN
    SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = p_action_name;
  END IF;

  RETURN v_action_id;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- ANTIBIOTIC RECOVERY
-- ============================================================================

DO $$
DECLARE
  v_immune_system_id INTEGER;
  v_disorder_id INTEGER;
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_immune_system_id FROM herbal.body_systems WHERE name = 'Immune';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Antibiotic Recovery', v_immune_system_id, 5)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'Once a course of antibiotics has been completed, herbs may be used to speed convalescence.', 1),
    (v_disorder_id, 'The focus here should be on general nutrition, as well as herbal tonics.', 2);

  -- Add Actions Indicated descriptions
  v_action_id := herbal.ensure_action('Bitter');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'will safely stimulate normal metabolism', 1);

  v_action_id := herbal.ensure_action('Diuretic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'Gentle diuretics and hepatics will support elimination', 2);

  v_action_id := herbal.ensure_action('Hepatic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'Gentle diuretics and hepatics will support elimination', 3);

  v_action_id := herbal.ensure_action('Tonic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'Specific tonics will support the tissue affected at the site of infection and the primary sites of symptomatic discomfort', 4);

  -- Add Immune Support note (not a specific action, but a general indication)
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id, 'Immune Support: This is important, and may entail both deep and surface work. Focus on deep immune support if: • The infection is a chronic or recurrent problem • The patient is very debilitated after the infection • The patient is elderly • The patient is under much stress of any kind, and thus at risk of becoming immunocompromised', 3);

END $$;

-- ============================================================================
-- VAGINITIS
-- ============================================================================

DO $$
DECLARE
  v_immune_system_id INTEGER;
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_immune_system_id FROM herbal.body_systems WHERE name = 'Immune';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Vaginitis', v_immune_system_id, 6)
  RETURNING id INTO v_disorder_id;

  -- Prescription 1: Capsule formula
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Capsule Formula', 'Mix equal parts of the powders thoroughly and encapsulate in size 00 capsules. Take 2 capsules three times daily for 5 days, then take 2 days off. Continue this cycle for 4 weeks, or until symptoms subside.', 1)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Juglans nigra', 'black walnut');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'equal parts', 'hull powder', 1);

  v_herb_id := herbal.ensure_herb('Larrea tridentata', 'chaparral');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'equal parts', 'powder', 2);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'equal parts', 'root powder', 3);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Hydrastis canadensis';
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'equal parts', 'root powder', 4);

  v_herb_id := herbal.ensure_herb('Althaea officinalis', 'marshmallow');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'equal parts', 'root powder', 5);

  v_herb_id := herbal.ensure_herb('Tabebuia impetiginosa', 'pau d''arco');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'equal parts', 'powder', 6);

  -- Prescription 2: Dusting Powder (Yoni Powder)
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Dusting Powder (Yoni Powder)', 'Combine all the ingredients and mix together using a wire whisk. Spoon some into a jar with a shaker top for easy application. Store the remainder in a glass jar with a tight-fitting lid.', 2)
  RETURNING id INTO v_prescription_id;

  -- Note: Non-herb ingredients (clay, cornstarch, tea tree oil) are not herbs and won't be added

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Juglans nigra';
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '2 tablespoons', 'hull powder', 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Commiphora molmol';
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '2 tablespoons', 'powder', 2);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Hydrastis canadensis';
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 tablespoon', 'root powder (organically cultivated)', 3);

END $$;

-- ============================================================================
-- GENITOURINARY TRACT INFECTIONS
-- ============================================================================

DO $$
DECLARE
  v_immune_system_id INTEGER;
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_immune_system_id FROM herbal.body_systems WHERE name = 'Immune';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Genitourinary Tract Infections', v_immune_system_id, 7)
  RETURNING id INTO v_disorder_id;

  -- Add disorder note
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id, 'A range of antimicrobials are uniquely suited to treating this part of the body. They are usually herbs rich in essential oils.', 1);

  -- Antimicrobial
  v_action_id := herbal.ensure_action('Antimicrobial');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Achillea millefolium';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_herb_id := herbal.ensure_herb('Agathosma betulina', 'buchu');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Arctostaphylos uva-ursi';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  v_herb_id := herbal.ensure_herb('Elymus repens', 'couch grass');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 4);

  v_herb_id := herbal.ensure_herb('Juniperus communis', 'juniper');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 5);

  v_herb_id := herbal.ensure_herb('Petroselinum crispum', 'parsley');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 6);

END $$;

-- Clean up helper functions (will be recreated in next part)
DROP FUNCTION IF EXISTS herbal.ensure_herb(TEXT, TEXT);
DROP FUNCTION IF EXISTS herbal.ensure_action(TEXT);
-- Populate Immune System disorders and data - Part 4
-- This includes: Prostatitis, Boils, Fungal Skin Infections, Cancer

SET search_path TO herbal, public;

-- ============================================================================
-- HELPER FUNCTIONS
-- ============================================================================
CREATE OR REPLACE FUNCTION herbal.ensure_herb(p_latin_name TEXT, p_common_name TEXT)
RETURNS INTEGER AS $$
DECLARE
  v_herb_id INTEGER;
BEGIN
  INSERT INTO herbal.herbs (latin_name, common_name)
  VALUES (p_latin_name, p_common_name)
  ON CONFLICT (latin_name) DO NOTHING
  RETURNING id INTO v_herb_id;

  IF v_herb_id IS NULL THEN
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = p_latin_name;
  END IF;

  RETURN v_herb_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION herbal.ensure_action(p_action_name TEXT)
RETURNS INTEGER AS $$
DECLARE
  v_action_id INTEGER;
BEGIN
  INSERT INTO herbal.primary_actions (name)
  VALUES (p_action_name)
  ON CONFLICT (name) DO NOTHING
  RETURNING id INTO v_action_id;

  IF v_action_id IS NULL THEN
    SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = p_action_name;
  END IF;

  RETURN v_action_id;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- PROSTATITIS
-- ============================================================================

DO $$
DECLARE
  v_immune_system_id INTEGER;
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_herb_id INTEGER;
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_immune_system_id FROM herbal.body_systems WHERE name = 'Immune';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Prostatitis', v_immune_system_id, 8)
  RETURNING id INTO v_disorder_id;

  -- Actions Indicated
  v_action_id := herbal.ensure_action('Antimicrobial');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'that work well in the urinary system are fundamental to treatment success.', 1);

  v_action_id := herbal.ensure_action('Tonic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'Prostate tonics are indicated, as for benign prostatic hyperplasia.', 2);

  v_action_id := herbal.ensure_action('Diuretic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'Diuretics will promote voiding of urine. However, they may be contraindicated if there is marked blockage due to prostate swelling.', 3);

  v_action_id := herbal.ensure_action('Demulcent');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'Demulcents that soothe the urinary system (demulcent diuretics) can help alleviate some of the symptoms.', 4);

  -- Specific Remedies
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Arctostaphylos uva-ursi';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'useful antimicrobial', 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Agathosma betulina';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'useful antimicrobial', 2);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Elymus repens';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'useful antimicrobial', 3);

  -- Note: The source has "Serena repens" but this is likely a typo for "Serenoa repens"
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Serenoa repens';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'useful prostatic tonic', 4);

  v_herb_id := herbal.ensure_herb('Hydrangea arborescens', 'hydrangea');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'useful prostatic tonic', 5);

  v_herb_id := herbal.ensure_herb('Turnera diffusa', 'damiana');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 6);

  v_herb_id := herbal.ensure_herb('Smilax spp.', 'sarsaparilla');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 7);

  -- Prescription (tincture + infusion)
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Tincture', 'Dosage: up to 5 ml of tincture three times a day. In addition, the patient should drink an infusion of equal parts of dried Zea mays and Achillea millefolium throughout the day.', 1)
  RETURNING id INTO v_prescription_id;

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Arctostaphylos uva-ursi';
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Agathosma betulina';
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 2);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 3);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Serenoa repens';
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 4);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Zea mays';
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 5);

  -- Action Herbs section
  v_action_id := herbal.ensure_action('Antimicrobial');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Arctostaphylos uva-ursi';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Agathosma betulina';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Achillea millefolium';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 4);

  -- Prostate tonic
  v_action_id := herbal.ensure_action('Prostate tonic');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Serenoa repens';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  -- Diuretic
  v_action_id := herbal.ensure_action('Diuretic');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Arctostaphylos uva-ursi';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Agathosma betulina';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Zea mays';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Achillea millefolium';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 4);

  -- Demulcent
  v_action_id := herbal.ensure_action('Demulcent');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Zea mays';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

END $$;

-- ============================================================================
-- BOILS
-- ============================================================================

DO $$
DECLARE
  v_immune_system_id INTEGER;
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_herb_id INTEGER;
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_immune_system_id FROM herbal.body_systems WHERE name = 'Immune';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Boils', v_immune_system_id, 9)
  RETURNING id INTO v_disorder_id;

  -- Disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'Also known as furuncles, are infections that manifest as localized abscesses starting in the hair follicles.', 1),
    (v_disorder_id, 'When deeper furuncles form and coalesce, the term carbuncle applies. A carbuncle may drain at several openings in the same region. The shoulders, face, scalp, buttocks, and armpits are common sites for carbuncles.', 2);

  -- Actions Indicated
  v_action_id := herbal.ensure_action('Alterative');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'offer the most benefit in the treatment of boils, although I am unable to give a satisfactory explanation of how they work or why!', 1);

  v_action_id := herbal.ensure_action('Antimicrobial');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'help the body rid itself of the infection. In this case, it is difficult to say whether they work through direct bactericidal effects or indirect stimulation of the immune response.', 2);

  v_action_id := herbal.ensure_action('Lymphatic tonic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'promote the general drainage of fluid.', 3);

  v_action_id := herbal.ensure_action('Diuretic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'are especially important in supporting the eliminative work of the kidneys.', 4);

  v_action_id := herbal.ensure_action('Hepatic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'are similarly helpful for the liver.', 5);

  v_action_id := herbal.ensure_action('Vulnerary');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'herbs may all be helpful topically.', 6);

  v_action_id := herbal.ensure_action('Anti-inflammatory');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'herbs may all be helpful topically.', 7);

  v_action_id := herbal.ensure_action('Antipruritic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'herbs may all be helpful topically.', 8);

  v_action_id := herbal.ensure_action('Astringent');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'herbs may all be helpful topically.', 9);

  -- Specific Remedies + note
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id, 'The stronger hepatic alteratives are often considered specifics. Their strength highlights the need to take care with dosage. Important examples of hepatic alteratives are listed here. In addition, Echinacea is strongly indicated.', 3);

  v_herb_id := herbal.ensure_herb('Iris versicolor', 'blue flag');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Larrea tridentata';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 2);

  v_herb_id := herbal.ensure_herb('Phytolacca americana', 'poke');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 3);

  v_herb_id := herbal.ensure_herb('Pulsatilla vulgaris', 'pasqueflower');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 4);

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Tincture + Infusion', 'Dosage: up to 5 ml of tincture three times a day. In addition, the patient should drink an infusion of Urtica dioica (preferably made from fresh herb) twice a day.', 1)
  RETURNING id INTO v_prescription_id;

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '3 parts', 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Galium aparine';
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '2 parts', 2);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Rumex crispus';
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 3);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Phytolacca americana';
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 4);

  -- Action Herbs
  v_action_id := herbal.ensure_action('Alterative');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Galium aparine';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Rumex crispus';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Phytolacca americana';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 4);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Urtica dioica';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 5);

  v_action_id := herbal.ensure_action('Antimicrobial');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_action_id := herbal.ensure_action('Lymphatic tonic');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Galium aparine';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Phytolacca americana';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  v_action_id := herbal.ensure_action('Diuretic');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Galium aparine';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Urtica dioica';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  v_action_id := herbal.ensure_action('Hepatic');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Rumex crispus';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

END $$;

-- ============================================================================
-- FUNGAL SKIN INFECTIONS
-- ============================================================================

DO $$
DECLARE
  v_immune_system_id INTEGER;
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_immune_system_id FROM herbal.body_systems WHERE name = 'Immune';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Fungal Skin Infections', v_immune_system_id, 10)
  RETURNING id INTO v_disorder_id;

  -- Specific Remedies
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Allium sativum';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Commiphora molmol';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'myrrh essential oil', 2);

  v_herb_id := herbal.ensure_herb('Melaleuca spp.', 'tea tree');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'tea tree oil', 3);

  -- Prescription (Lavender + Myrrh EO)
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Essential Oil Blend', 'A combination of equal parts lavender and myrrh essential oils is a long-standing treatment for athlete''s foot among aromatherapists in the United Kingdom. Myrrh is fungicidal and lavender is anti-inflammatory and vulnerary. For the first few days of treatment, dissolve the oils in rubbing alcohol and apply to skin until the skin no longer seems moist or weepy. Continue treatment with an ointment or cream containing 3% to 5% essential oil until the skin is completely clear. If the skin is deeply cracked and painful, calendula oil can be valuable as well.', 1)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Lavandula spp.', 'lavender');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 'essential oil', 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Commiphora molmol';
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 'essential oil', 2);

END $$;

-- ============================================================================
-- CANCER
-- ============================================================================

DO $$
DECLARE
  v_immune_system_id INTEGER;
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_immune_system_id FROM herbal.body_systems WHERE name = 'Immune';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Cancer', v_immune_system_id, 11)
  RETURNING id INTO v_disorder_id;

  -- Specific Remedies
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Arctium lappa';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Calendula officinalis';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 2);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Galium aparine';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 3);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Hydrastis canadensis';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 4);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Iris versicolor';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 5);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Larrea tridentata';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 6);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Phytolacca americana';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 7);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Rumex crispus';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 8);

  v_herb_id := herbal.ensure_herb('Sanguinaria canadensis', 'bloodroot');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 9);

  v_herb_id := herbal.ensure_herb('Scrophularia nodosa', 'figwort');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 10);

  v_herb_id := herbal.ensure_herb('Stillingia sylvatica', 'queen''s delight');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 11);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Thuja occidentalis';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 12);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Trifolium pratense';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 13);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Urtica dioica';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 14);

  v_herb_id := herbal.ensure_herb('Viola odorata', 'sweet violet');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 15);

  v_herb_id := herbal.ensure_herb('Viscum album', 'mistletoe');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 16);

END $$;

-- Clean up helper functions
DROP FUNCTION IF EXISTS herbal.ensure_herb(TEXT, TEXT);
DROP FUNCTION IF EXISTS herbal.ensure_action(TEXT);

-- Sync herbs from Immune System disorders to herb_primary_actions table
-- This ensures the Immune System shows the correct herb count

SET search_path TO herbal, public;

-- Insert herb-action pairs from disorder_action_herbs into herb_primary_actions
-- for the Immune System
INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
SELECT DISTINCT
  dah.herb_id,
  dah.primary_action_id,
  d.body_system_id
FROM herbal.disorder_action_herbs dah
JOIN herbal.disorders d ON dah.disorder_id = d.id
JOIN herbal.body_systems bs ON d.body_system_id = bs.id
WHERE bs.name = 'Immune'
ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

-- Summary: Show how many herbs were synced
DO $$
DECLARE
  v_herb_count INTEGER;
BEGIN
  SELECT COUNT(DISTINCT herb_id) INTO v_herb_count
  FROM herbal.herb_primary_actions hpa
  JOIN herbal.body_systems bs ON hpa.body_system_id = bs.id
  WHERE bs.name = 'Immune';

END $$;
-- DEPRECATED: This migration was run out of order before the disorders were created
-- The correct version is in migration 026
-- This file is kept as a placeholder to maintain migration numbering

SET search_path TO herbal, public;

-- No-op migration
DO $$
BEGIN
END $$;
-- Create Immune System disorders from "Immune System 2.md"
-- This migration creates the disorder entries that will receive specific remedies

SET search_path TO herbal, public;

-- ============================================================================
-- CREATE IMMUNE SYSTEM DISORDERS
-- ============================================================================

DO $$
DECLARE
  v_immune_system_id INTEGER;
  v_disorder_id INTEGER;
  v_sort_order INTEGER := 100; -- Start after existing disorders
BEGIN
  SELECT id INTO v_immune_system_id FROM herbal.body_systems WHERE name = 'Immune';

  IF v_immune_system_id IS NULL THEN
    RAISE EXCEPTION 'Immune system not found';
  END IF;

  -- Ear Infections
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Ear Infections', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Sore Throat
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Sore Throat', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Congestion
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Congestion', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Swollen Glands
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Swollen Glands', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Mumps
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Mumps', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Flu
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Flu', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Colds
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Colds', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Cough (soothe)
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Cough (soothe)', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Cough (suppress)
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Cough (suppress)', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Laryngitis
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Laryngitis', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Acute Bronchitis
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Acute Bronchitis', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Pneumonia
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Pneumonia', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Colic/Gastritis
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Colic/Gastritis', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Constipation
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Constipation', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Diarrhea
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Diarrhea', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Nausea
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Nausea', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Fevers
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Fevers', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Chicken Pox
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Chicken Pox', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;
  v_sort_order := v_sort_order + 1;

  -- Restlessness
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Restlessness', v_immune_system_id, v_sort_order)
  ON CONFLICT (name, body_system_id) DO NOTHING;

END $$;

-- ============================================================================
-- SUMMARY
-- ============================================================================
-- This migration creates disorder entries for all conditions from "Immune System 2.md"
-- These disorders will be populated with specific remedies by migration 024
-- Populate Immune System Specific Remedies
-- Based on "Immune System 2.md" - adds specific remedy herbs with their notes
-- This is the correct version that runs AFTER the disorders are created in migration 025

SET search_path TO herbal, public;

-- ============================================================================
-- HELPER FUNCTIONS
-- ============================================================================
CREATE OR REPLACE FUNCTION herbal.ensure_herb(p_latin_name TEXT, p_common_name TEXT)
RETURNS INTEGER AS $$
DECLARE
  v_herb_id INTEGER;
BEGIN
  INSERT INTO herbal.herbs (latin_name, common_name)
  VALUES (p_latin_name, p_common_name)
  ON CONFLICT (latin_name) DO NOTHING
  RETURNING id INTO v_herb_id;

  IF v_herb_id IS NULL THEN
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = p_latin_name;
  END IF;

  RETURN v_herb_id;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- EAR INFECTIONS
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Ear Infections';

  IF v_disorder_id IS NULL THEN
  ELSE
    -- Echinacea spp.
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 1)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Yerba Mansa
    v_herb_id := herbal.ensure_herb('Anemopsis californica', 'yerba mansa');
    INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, v_herb_id, '', 2)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

    -- Mullein
    v_herb_id := herbal.ensure_herb('Verbascum thapsus', 'mullein');
    INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, v_herb_id, 'external, flower oil', 3)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  END IF;
END $$;

-- ============================================================================
-- SORE THROAT
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Sore Throat';

  IF v_disorder_id IS NULL THEN
  ELSE
    -- Echinacea
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 1)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Licorice
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Glycyrrhiza glabra';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 2)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Garlic
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Allium sativum';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 3)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Ceanothus (Red Root)
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Ceanothus americanus';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 4)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Sage
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Salvia officinalis';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, 'essential oil, gargle', 5)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

  END IF;
END $$;

-- ============================================================================
-- CONGESTION
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Congestion';

  IF v_disorder_id IS NULL THEN
  ELSE
    -- Elder
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Sambucus nigra';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, 'flowers', 1)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Peppermint (first instance)
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Mentha piperita';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 2)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Yerba Mansa
    v_herb_id := herbal.ensure_herb('Anemopsis californica', 'yerba mansa');
    INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, v_herb_id, '', 3)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

    -- Lavender
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Lavandula angustifolia';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, 'inhalant, EO', 4)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Eucalyptus
    v_herb_id := herbal.ensure_herb('Eucalyptus globulus', 'eucalyptus');
    INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, v_herb_id, 'inhalant', 5)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

    -- Peppermint (inhalant - already added above, update description)
    -- Note: Can't add duplicate, already exists

    -- Thyme
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Thymus vulgaris';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, 'inhalant', 6)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

  END IF;
END $$;

-- ============================================================================
-- SWOLLEN GLANDS
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Swollen Glands';

  IF v_disorder_id IS NULL THEN
  ELSE
    -- Cleavers
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Galium aparine';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 1)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Elder
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Sambucus nigra';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, 'flowers', 2)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Sassafras
    v_herb_id := herbal.ensure_herb('Sassafras albidum', 'sassafras');
    INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, v_herb_id, '', 3)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

    -- Echinacea
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 4)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Red root (Ceanothus)
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Ceanothus americanus';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 5)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Poke
    v_herb_id := herbal.ensure_herb('Phytolacca americana', 'poke');
    INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, v_herb_id, 'root', 6)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  END IF;
END $$;

-- ============================================================================
-- MUMPS
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Mumps';

  IF v_disorder_id IS NULL THEN
  ELSE
    -- Echinacea
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 1)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Cleavers
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Galium aparine';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 2)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Goldenseal
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Hydrastis canadensis';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 3)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Garlic
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Allium sativum';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 4)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Myrrh
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Commiphora molmol';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 5)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

  END IF;
END $$;

-- ============================================================================
-- FLU
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Flu';

  IF v_disorder_id IS NULL THEN
  ELSE
    -- Peppermint
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Mentha piperita';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 1)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Echinacea
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 2)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Elder
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Sambucus nigra';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 3)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Valerian
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Valeriana officinalis';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 4)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

  END IF;
END $$;

-- ============================================================================
-- COLDS
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Colds';

  IF v_disorder_id IS NULL THEN
  ELSE
    -- Echinacea
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 1)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Cleavers
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Galium aparine';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 2)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Garlic
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Allium sativum';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 3)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Peppermint
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Mentha piperita';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 4)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Yarrow
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Achillea millefolium';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 5)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

  END IF;
END $$;

-- ============================================================================
-- COUGH (SOOTHE)
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Cough (soothe)';

  IF v_disorder_id IS NULL THEN
  ELSE
    -- Garlic
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Allium sativum';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 1)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Licorice
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Glycyrrhiza glabra';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 2)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Cleavers
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Galium aparine';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 3)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Echinacea
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 4)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

  END IF;
END $$;

-- ============================================================================
-- COUGH (SUPPRESS)
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Cough (suppress)';

  IF v_disorder_id IS NULL THEN
  ELSE
    -- Wild cherry
    v_herb_id := herbal.ensure_herb('Prunus serotina', 'wild cherry');
    INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, v_herb_id, 'bark', 1)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

    -- Licorice
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Glycyrrhiza glabra';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 2)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Peppermint
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Mentha piperita';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 3)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

  END IF;
END $$;

-- ============================================================================
-- LARYNGITIS
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Laryngitis';

  IF v_disorder_id IS NULL THEN
  ELSE
    -- Myrrh
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Commiphora molmol';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 1)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Cayenne
    v_herb_id := herbal.ensure_herb('Capsicum annuum', 'cayenne');
    INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, v_herb_id, 'gargle', 2)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  END IF;
END $$;

-- ============================================================================
-- ACUTE BRONCHITIS
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Acute Bronchitis';

  IF v_disorder_id IS NULL THEN
  ELSE
    -- Echinacea
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 1)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Elecampane
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Inula helenium';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 2)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Licorice
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Glycyrrhiza glabra';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 3)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Elder
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Sambucus nigra';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, 'flower', 4)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Ginger
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Zingiber officinale';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, 'compress', 5)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

  END IF;
END $$;

-- ============================================================================
-- PNEUMONIA
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Pneumonia';

  IF v_disorder_id IS NULL THEN
  ELSE
    -- Garlic
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Allium sativum';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 1)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Elecampane
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Inula helenium';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 2)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Yarrow
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Achillea millefolium';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 3)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Licorice
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Glycyrrhiza glabra';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 4)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Valerian
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Valeriana officinalis';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 5)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Echinacea
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 6)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

  END IF;
END $$;

-- ============================================================================
-- COLIC/GASTRITIS
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Colic/Gastritis';

  IF v_disorder_id IS NULL THEN
  ELSE
    -- Slippery elm
    v_herb_id := herbal.ensure_herb('Ulmus rubra', 'slippery elm');
    INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, v_herb_id, 'as a gruel', 1)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

    -- Ginger
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Zingiber officinale';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 2)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Catnip
    v_herb_id := herbal.ensure_herb('Nepeta cataria', 'catnip');
    INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, v_herb_id, '', 3)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  END IF;
END $$;

-- ============================================================================
-- CONSTIPATION
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Constipation';

  IF v_disorder_id IS NULL THEN
  ELSE
    -- Licorice
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Glycyrrhiza glabra';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 1)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

  END IF;
END $$;

-- ============================================================================
-- DIARRHEA
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Diarrhea';

  IF v_disorder_id IS NULL THEN
  ELSE
    -- Licorice
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Glycyrrhiza glabra';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 1)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

  END IF;
END $$;

-- ============================================================================
-- NAUSEA
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Nausea';

  IF v_disorder_id IS NULL THEN
  ELSE
    -- Peppermint
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Mentha piperita';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 1)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Ginger
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Zingiber officinale';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 2)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Angelica
    v_herb_id := herbal.ensure_herb('Angelica archangelica', 'angelica');
    INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, v_herb_id, '', 3)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

    -- Marshmallow
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Althaea officinalis';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 4)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Chamomile
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Matricaria chamomilla';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 5)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Peach
    v_herb_id := herbal.ensure_herb('Prunus persica', 'peach');
    INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, v_herb_id, 'leaf', 6)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  END IF;
END $$;

-- ============================================================================
-- FEVERS
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Fevers';

  IF v_disorder_id IS NULL THEN
  ELSE
    -- Elder
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Sambucus nigra';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, 'flowers', 1)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Peppermint
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Mentha piperita';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 2)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Yarrow
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Achillea millefolium';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 3)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Catnip (first instance)
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Nepeta cataria';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 4)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Echinacea
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 5)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Catnip (external - already added above, can't add duplicate)
    -- Note: The note "external, as a bath or with ACV" can't be added without duplicating

  END IF;
END $$;

-- ============================================================================
-- CHICKEN POX
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Chicken Pox';

  IF v_disorder_id IS NULL THEN
  ELSE
    -- Oats
    v_herb_id := herbal.ensure_herb('Avena sativa', 'oats');
    INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, v_herb_id, '', 1)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

    -- Echinacea
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 2)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Chickweed
    v_herb_id := herbal.ensure_herb('Stellaria media', 'chickweed');
    INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, v_herb_id, 'external, as a wash', 3)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  END IF;
END $$;

-- ============================================================================
-- RESTLESSNESS
-- ============================================================================
DO $$
DECLARE
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Restlessness';

  IF v_disorder_id IS NULL THEN
  ELSE
    -- Chamomile
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Matricaria chamomilla';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 1)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- Catnip
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Nepeta cataria';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, '', 2)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

    -- California Poppy
    v_herb_id := herbal.ensure_herb('Eschscholzia californica', 'california poppy');
    INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, v_herb_id, '', 3)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

    -- Lavender
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Lavandula angustifolia';
    IF v_herb_id IS NOT NULL THEN
      INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
      VALUES (v_disorder_id, v_herb_id, 'EO, external', 4)
      ON CONFLICT (disorder_id, herb_id) DO NOTHING;
    END IF;

  END IF;
END $$;

-- ============================================================================
-- CLEANUP
-- ============================================================================
DROP FUNCTION IF EXISTS herbal.ensure_herb(TEXT, TEXT);

-- ============================================================================
-- SUMMARY
-- ============================================================================
-- This migration adds specific remedy herbs for immune system disorders
-- Each herb has its associated notes (if any) stored in the description field
-- The data comes from "Immune System 2.md"
-- Populate Respiratory Systems - Part 1
-- This includes Lower and Upper Respiratory system disorders
-- File: Respiratory System.md

SET search_path TO herbal, public;

-- ============================================================================
-- ADD NEW BODY SYSTEMS
-- ============================================================================
-- Add Lower Respiratory and Upper Respiratory as separate systems

INSERT INTO herbal.body_systems (name)
VALUES ('Lower Respiratory'), ('Upper Respiratory')
ON CONFLICT (name) DO NOTHING;

-- ============================================================================
-- HELPER FUNCTIONS
-- ============================================================================
CREATE OR REPLACE FUNCTION herbal.ensure_herb(p_latin_name TEXT, p_common_name TEXT)
RETURNS INTEGER AS $$
DECLARE
  v_herb_id INTEGER;
BEGIN
  INSERT INTO herbal.herbs (latin_name, common_name)
  VALUES (p_latin_name, p_common_name)
  ON CONFLICT (latin_name) DO NOTHING
  RETURNING id INTO v_herb_id;

  IF v_herb_id IS NULL THEN
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = p_latin_name;
  END IF;

  RETURN v_herb_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION herbal.ensure_action(p_action_name TEXT)
RETURNS INTEGER AS $$
DECLARE
  v_action_id INTEGER;
BEGIN
  INSERT INTO herbal.primary_actions (name)
  VALUES (p_action_name)
  ON CONFLICT (name) DO NOTHING
  RETURNING id INTO v_action_id;

  IF v_action_id IS NULL THEN
    SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = p_action_name;
  END IF;

  RETURN v_action_id;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- LOWER RESPIRATORY SYSTEM - OVERALL
-- ============================================================================

DO $$
DECLARE
  v_lower_resp_id INTEGER;
  v_disorder_id INTEGER;
  v_action_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_lower_resp_id FROM herbal.body_systems WHERE name = 'Lower Respiratory';

  -- Create "Overall" disorder for Lower Respiratory
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Overall', v_lower_resp_id, 0)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'The lungs sit within the thoracic cage, where they stretch from the trachea (commonly called the windpipe) to below the heart.', 1),
    (v_disorder_id, 'About 10% of the lung is solid tissue and the rest is filled with air and blood.', 2),
    (v_disorder_id, 'The lungs'' main function is to rapidly exchange oxygen from inhaled air with carbon dioxide from the blood', 3),
    (v_disorder_id, 'The two main bronchi extend from the trachea into each lung, where they divide into smaller bronchi, and then a great number of smaller bronchioles. The bronchioles divide into a network of about 3 million alveolar ducts containing alveoli, commonly called air sacs.', 4),
    (v_disorder_id, 'Specific nerve sites located in the brain and the neck, called respi vatory centers, coordinate the performance of the ventila-tory apparatus. The respiratory centers respond to changes in oxygen, carbon dioxide, and acid levels in the blood.', 5),
    (v_disorder_id, 'Gas exchange between inhaled air and blood takes place in the alveoli. A very thin membrane separates the blood from the air in the alveoli and allows oxygen and nitrogen to diffuse into the blood. This barrier is 50 times thinner than a sheet of tissue paper, but a large surface area (80 square meters, or about as large as a tennis court) is available for gas exchange. In the resting state, it takes just about a minute for the total blood volume of the body to pass through the lungs. It takes a red cell a fraction of a second to pass through the capillary network. Gas exchange occurs almost instantaneously during this short time period', 6),
    (v_disorder_id, 'We are not only what we eat, but also what we breathe.', 7),
    (v_disorder_id, 'Many pathological tissue changes can be prevented if the environmental milieu of the cells is constantly rich in oxygen.', 8),
    (v_disorder_id, 'Air pollution in the country may be caused by dust from tractors plowing fields, trucks and cars driving on dirt or gravel roads, and rock quarries, as well as by smoke from wood and crop fires.', 9),
    (v_disorder_id, 'Ground-level ozone is created when engine and fuel gases that have already been released into the air interact in the presence of sunlight.', 10),
    (v_disorder_id, 'Ozone irritates the respiratory tract and eyes, and exposure to high levels results in chest tightness, coughing, and wheezing.', 11),
    (v_disorder_id, 'For every eight smokers, one nonsmoker dies from the effects of secondhand smoke.', 12),
    (v_disorder_id, 'Smoking is responsible for 32% of deaths due to cancer.', 13),
    (v_disorder_id, 'Smoking causes nearly 90% of all lung and throat cancers.', 14),
    (v_disorder_id, 'Alcohol is also a risk factor for some cancers, and the combination of alcohol and smoking greatly increases cancer risk.', 15),
    (v_disorder_id, 'Smoking decreases the strength of the sphincter muscle between the throat and stomach, which allows stomach contents to reflux, or flow backward, into the esophagus.', 16),
    (v_disorder_id, 'Smoking seems to affect the liver, too, by changing the way it handles drugs and alcohol.', 17),
    (v_disorder_id, 'Peptic ulcer disease is more likely to occur in smokers than in nonsmokers, and ulcers heal less readily and are more likely to recur in smokers.', 18),
    (v_disorder_id, 'Smoking has a direct effect on the growth of the fetus.', 19),
    (v_disorder_id, 'Natural menopause occurs earlier in smokers than in nonsmokers by one to two years.', 20),
    (v_disorder_id, 'Cigarettes and oral contraceptives are a dangerous combination that increases the risk of heart attacks, strokes, and other vascular complications.', 21),
    (v_disorder_id, 'A decrease of blood flow in the small vessels of the skin that may damage skin components, leading to skin wrinkling and an appearance of premature aging.', 22),
    (v_disorder_id, 'The respiratory zone, the actual site of gas exchange, is composed of the respiratory bronchioles, alveolar ducts, and alveoli. The conducting zone, sometimes called the dead air space, includes all other respiratory passageways, which serve as fairly rigid conduits to allow air to reach the gas exchange sites. The conducting zone organs also purify, humidify, and warm the incoming air.', 23),
    (v_disorder_id, 'The lower respiratory system consists of the respiratory zone, the alveoli, and respiratory bronchioles. The air-conducting bronchi and trachea are anatomically part of this system. The upper respiratory system consists of the conducting zone, made up of the nose, sinuses, pharynx, and larynx.', 24),
    (v_disorder_id, 'Expectorants are herbs that facilitate or accelerate the removal of bronchial secretions from the bronchi and trachea.', 25),
    (v_disorder_id, 'Stimulating Expectorants: For any given stimulating expectorant, either or both of the following mechanisms may be at play. Irritation of the bronchioles stimulates the expulsion of any material present. Liquefaction of viscid sputum encourages clearing by coughing.', 26),
    (v_disorder_id, 'The particular form of stimulation offered by this group of expectorants makes them relevant for productive coughs, in which sputum should be removed from the airways.', 27),
    (v_disorder_id, 'Relaxing expectorants may also act by reflex, but here the herbs work to soothe bronchial spasm and loosen mucous secretions.', 28),
    (v_disorder_id, 'They facilitate the production of a less viscous mucous secretion, which helps lift up stickier material from below. This makes relaxing expectorants useful for dry, irritating coughs. You will notice that this action is similar in some respects to that of demulcents, and both actions owe a lot to their content of mucilage and occasionally volatile oils.', 29),
    (v_disorder_id, 'Herbs known as pulmonaries, or amphoteric expectorants, have a beneficial effect upon both lung tissue and function.', 30),
    (v_disorder_id, 'We can generalize here that Inula has stimulant expectorant effects and Verbascum is more of a relaxing expectorant. Tussilago is the best of the three for children.', 31),
    (v_disorder_id, 'To avoid any potential toxicity problems, leaf and flower formulations of Tussilago should not be taken for more than one consecutive month, and root products should not be used internally.', 32),
    (v_disorder_id, 'Dyspnea, defined as an unpleasant sensation of difficulty in breathing.', 33);

  -- Add Action Herbs for Overall Lower Respiratory
  -- Pulmonary tonic
  v_action_id := herbal.ensure_action('Pulmonary tonic');
  v_herb_id := herbal.ensure_herb('Inula helenium', 'elecampane');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_herb_id := herbal.ensure_herb('Tussilago farfara', 'coltsfoot');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  v_herb_id := herbal.ensure_herb('Verbascum thapsus', 'mullein');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  -- Stimulating expectorant
  v_action_id := herbal.ensure_action('Stimulating expectorant');
  v_herb_id := herbal.ensure_herb('Cephaelis ipecacuanha', 'ipecac');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_herb_id := herbal.ensure_herb('Inula helenium', 'elecampane');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  v_herb_id := herbal.ensure_herb('Marrubium vulgare', 'white horehound');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  v_herb_id := herbal.ensure_herb('Sanguinaria canadensis', 'bloodroot');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 4);

  -- Relaxing expectorant
  v_action_id := herbal.ensure_action('Relaxing expectorant');
  v_herb_id := herbal.ensure_herb('Asclepias tuberosa', 'pleurisy root');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_herb_id := herbal.ensure_herb('Cetraria islandica', 'Iceland moss');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  v_herb_id := herbal.ensure_herb('Grindelia camporum', 'gumweed');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  v_herb_id := herbal.ensure_herb('Lobelia inflata', 'lobelia');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 4);

  v_herb_id := herbal.ensure_herb('Plantago spp.', 'plantain');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 5);

  v_herb_id := herbal.ensure_herb('Tussilago farfara', 'coltsfoot');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 6);

  -- Antispasmodic
  v_action_id := herbal.ensure_action('Antispasmodic');
  v_herb_id := herbal.ensure_herb('Drosera rotundifolia', 'sundew');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_herb_id := herbal.ensure_herb('Euphorbia pilulifera', 'pill-bearing spurge');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  v_herb_id := herbal.ensure_herb('Lactuca virosa', 'wild lettuce');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  v_herb_id := herbal.ensure_herb('Papaver spp.', 'poppy');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 4);

  v_herb_id := herbal.ensure_herb('Prunus serotina', 'wild cherry');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 5);

  -- Antimicrobial
  v_action_id := herbal.ensure_action('Antimicrobial');
  v_herb_id := herbal.ensure_herb('Allium sativum', 'garlic');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_herb_id := herbal.ensure_herb('Eucalyptus spp.', 'eucalyptus');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  v_herb_id := herbal.ensure_herb('Thymus vulgaris', 'thyme');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  -- Immune support
  v_action_id := herbal.ensure_action('Immune support');
  v_herb_id := herbal.ensure_herb('Echinacea spp.', 'echinacea');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  -- Anticatarrhal
  v_action_id := herbal.ensure_action('Anticatarrhal');
  v_herb_id := herbal.ensure_herb('Hyssopus officinalis', 'hyssop');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_herb_id := herbal.ensure_herb('Tussilago farfara', 'coltsfoot');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  -- Cardiotonic
  v_action_id := herbal.ensure_action('Cardiotonic');
  v_herb_id := herbal.ensure_herb('Crataegus spp.', 'hawthorn');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_herb_id := herbal.ensure_herb('Leonurus cardiaca', 'motherwort');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  v_herb_id := herbal.ensure_herb('Tilia platyphyllos', 'linden');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  -- Nervine
  v_action_id := herbal.ensure_action('Nervine');
  v_herb_id := herbal.ensure_herb('Hyssopus officinalis', 'hyssop');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_herb_id := herbal.ensure_herb('Lactuca virosa', 'wild lettuce');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  v_herb_id := herbal.ensure_herb('Leonurus cardiaca', 'motherwort');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  v_herb_id := herbal.ensure_herb('Lobelia inflata', 'lobelia');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 4);

END $$;

-- ============================================================================
-- LOWER RESPIRATORY SYSTEM - COUGH
-- ============================================================================

DO $$
DECLARE
  v_lower_resp_id INTEGER;
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_action_id INTEGER;
  v_herb_id INTEGER;
  v_presc_herb_id INTEGER;
BEGIN
  SELECT id INTO v_lower_resp_id FROM herbal.body_systems WHERE name = 'Lower Respiratory';

  -- Create Cough disorder
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Cough', v_lower_resp_id, 1)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'For treating coughs, always select the appropriate approach for the individual''s unique case. The key to treatment is achieving a correct balance among the various stimulating, demul-cent, antimicrobial, and antitussive herbs available. Treat the person and his or her experience, not just the cough.', 1),
    (v_disorder_id, 'Coughing is a reflex response that represents an attempt by the body to clear the airways. Usually, blockages are caused by mucus secreted by membranes lining the respiratory tract. These mucous secretions help to protect the respiratory tract from all kinds of irritants by trapping and flushing out smoke particles, bacteria, and viruses. Any cough that lasts more than a few days, does not respond to treatment, or produces blood should be investigated further, as it may be a sign of serious organic disease.', 2),
    (v_disorder_id, 'Cough may be related to gastroesophageal reflux disease (GERD). In this condition, acid reflux from the stomach backs up into the throat, causing either heartburn or cough.', 3),
    (v_disorder_id, 'Treatment: Acute inflammatory conditions of the respiratory system are primarily treated with mucilage-rich demulcents, which soothe inflamed tissue. It is difficult to explain the mechanism at play here, as the mucopolysaccharide molecules in demulcent herbs do not enter the bloodstream and thus cannot be directly active in the respiratory tissue.', 4),
    (v_disorder_id, 'Stimulant, saponin-containing expectorants are best used for subacute or chronic bronchitis, for which active expectoration is indicated.', 5);

  -- Prescription: Cough formula
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, NULL, 'Infuse 1 teaspoon of dried herb mixture in 1 cup of freshly boiled water; drink often until symptoms subside.', 1)
  RETURNING id INTO v_prescription_id;

  -- Add herbs to prescription
  v_herb_id := herbal.ensure_herb('Tussilago farfara', 'coltsfoot');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '2 parts', 1);

  v_herb_id := herbal.ensure_herb('Althaea officinalis', 'marshmallow');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '2 parts', 2);

  v_herb_id := herbal.ensure_herb('Hyssopus officinalis', 'hyssop');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '2 parts', 3);

  v_herb_id := herbal.ensure_herb('Glycyrrhiza glabra', 'licorice');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 4);

  v_herb_id := herbal.ensure_herb('Pimpinella anisum', 'anise');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 5);

END $$;

-- ============================================================================
-- SUMMARY
-- ============================================================================
-- This migration adds:
-- 1. Lower Respiratory and Upper Respiratory body systems
-- 2. Lower Respiratory - Overall disorder with extensive notes and action herbs
-- 3. Lower Respiratory - Cough disorder with prescription
--
-- Subsequent migrations will add remaining disorders and prescriptions
-- Populate Respiratory Systems - Part 2
-- Lower Respiratory: Bronchitis and Acute Bronchitis disorders
-- File: Respiratory System.md

SET search_path TO herbal, public;

-- ============================================================================
-- LOWER RESPIRATORY SYSTEM - BRONCHITIS
-- ============================================================================

DO $$
DECLARE
  v_lower_resp_id INTEGER;
  v_disorder_id INTEGER;
BEGIN
  SELECT id INTO v_lower_resp_id FROM herbal.body_systems WHERE name = 'Lower Respiratory';

  -- Create Bronchitis disorder
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Bronchitis', v_lower_resp_id, 2)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'Bronchitis is either an acute or a chronic inflammation of the mucous lining of the bronchial tubes, the main airways that carry air from the trachea to the lungs.', 1),
    (v_disorder_id, 'When the cells of the bronchial lining tissue are irritated bevond a certain point, cilia that normally trap and eliminate pollutants stop functioning.', 2),
    (v_disorder_id, 'Bronchitis makes breathing difficult and sometimes even painful. Pain may be related to the swelling of the mucous membrane in the trachea. Other common sions of bronchitis are persistent coughing, aching associated with fever, and mucus secretions. The patient will feel very fatigued due to the fact that the body is receiving less oxygen than it needs.', 3);

END $$;

-- ============================================================================
-- LOWER RESPIRATORY SYSTEM - ACUTE BRONCHITIS
-- ============================================================================

DO $$
DECLARE
  v_lower_resp_id INTEGER;
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_action_id INTEGER;
  v_herb_id INTEGER;
  v_presc_herb_id INTEGER;
BEGIN
  SELECT id INTO v_lower_resp_id FROM herbal.body_systems WHERE name = 'Lower Respiratory';

  -- Create Acute Bronchitis disorder
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Acute Bronchitis', v_lower_resp_id, 3)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'Acute bronchitis usually originates with a viral infection of the upper respiratory tract, such as a cold or sore throat, that can become a secondary bacterial infection and spread to the lungs.', 1),
    (v_disorder_id, 'It usually lasts about a week and is accompanied by a cough that produces thick green or yellow mucus.', 2),
    (v_disorder_id, 'It may be accompanied by fever that lasts a few days, but persistent fever suggests the development of a pneumonia complication.', 3),
    (v_disorder_id, 'The cough of acute bronchitis may last for several weeks or even months, a reflection of the amount of time it takes for the bronchial lining to heal.', 4),
    (v_disorder_id, 'Acute bronchitis can be confused with asthma.', 5),
    (v_disorder_id, 'Acute bronchitis most commonly develops as a complication of a cold in a healthy person.', 6),
    (v_disorder_id, 'Congestive mucus should be coughed up, so avoid the use of cough suppressants. The use of soothing, relaxing expectorants in combination with antimicrobials is often the key to successful treatment. Particularly important relaxing expectorants are Tussilago, Verbascum, Plantago, Cetraria, Trigonella, Althaea, and Pulmonaria.', 7);

  -- Actions Indicated
  v_action_id := herbal.ensure_action('Pulmonary tonic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'are not crucial if the bronchitis is not a recurrent problem. However, they are clearly indicated for immunocompromised people.', 1);

  v_action_id := herbal.ensure_action('Expectorant');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'are indicated; the choice between stimulating and relaxing expectorants will depend on the individual''s needs. Demulcents augment the action of relaxing expectorants, if necessary.', 2);

  v_action_id := herbal.ensure_action('Antispasmodic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'can help if coughing is very troublesome.', 3);

  v_action_id := herbal.ensure_action('Antimicrobial');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'are essential to deal with infection and to help the body defend against the development of secondary infection.', 4);

  v_action_id := herbal.ensure_action('Anti-inflammatory');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'may be indicated if there is extensive inflammation, and especially if the larynx or pharynx is involved.', 5);

  v_action_id := herbal.ensure_action('Anticatarrhal');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'improve the upper respiratory symptom picture.', 6);

  v_action_id := herbal.ensure_action('Diaphoretic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'are indicated if the patient has a fever.', 7);

  v_action_id := herbal.ensure_action('Cardiotonic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'herbs offer support if there is any history or suspicion of cardiovascular problems.', 8);

  -- Specific Remedies Note
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id, 'Specific Remedies: Osha (Ligusticum porteri), a plant of the American Southwest, is an excellent specific for cases of tracheobronchitis. The specifics listed here cover a range of expectorant, antimicrobial, and antispasmodic actions. Strictly speaking, none of them is guaranteed to work in all cases, as specifics must be chosen based on the unique needs of an individual with a particular clinical picture.', 8);

  -- Add Specific Remedies
  v_herb_id := herbal.ensure_herb('Allium sativum', 'garlic');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antimicrobial and immune support', 1);

  v_herb_id := herbal.ensure_herb('Althaea officinalis', 'marshmallow');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Demulcent and soothing', 2);

  v_herb_id := herbal.ensure_herb('Asclepias tuberosa', 'pleurisy root');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Relaxing expectorant', 3);

  v_herb_id := herbal.ensure_herb('Cephaelis ipecacuanha', 'ipecac');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Stimulating expectorant', 4);

  v_herb_id := herbal.ensure_herb('Cetraria islandica', 'Iceland moss');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Demulcent and nutritive', 5);

  v_herb_id := herbal.ensure_herb('Chondrus crispus', 'Irish moss');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Demulcent', 6);

  v_herb_id := herbal.ensure_herb('Drosera rotundifolia', 'sundew');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antispasmodic', 7);

  v_herb_id := herbal.ensure_herb('Glycyrrhiza glabra', 'licorice');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Anti-inflammatory and expectorant', 8);

  v_herb_id := herbal.ensure_herb('Hydrastis canadensis', 'goldenseal');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antimicrobial and anticatarrhal', 9);

  v_herb_id := herbal.ensure_herb('Hyssopus officinalis', 'hyssop');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Anticatarrhal and expectorant', 10);

  v_herb_id := herbal.ensure_herb('Inula helenium', 'elecampane');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Pulmonary tonic and expectorant', 11);

  v_herb_id := herbal.ensure_herb('Ligusticum porteri', 'osha');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Excellent specific for tracheobronchitis', 12);

  v_herb_id := herbal.ensure_herb('Lobelia inflata', 'lobelia');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antispasmodic and expectorant', 13);

  v_herb_id := herbal.ensure_herb('Marrubium vulgare', 'white horehound');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Expectorant', 14);

  v_herb_id := herbal.ensure_herb('Pimpinella anisum', 'anise');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antimicrobial and antispasmodic', 15);

  v_herb_id := herbal.ensure_herb('Plantago spp.', 'plantain');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Soothing expectorant', 16);

  v_herb_id := herbal.ensure_herb('Polygala senega', 'Seneca snakeroot');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Stimulating expectorant', 17);

  v_herb_id := herbal.ensure_herb('Populus balsamifera var. balsamifera', 'balm of Gilead');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Expectorant', 18);

  v_herb_id := herbal.ensure_herb('Primula veris', 'cowslip');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Expectorant', 19);

  v_herb_id := herbal.ensure_herb('Pulmonaria officinalis', 'lungwort');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Pulmonary tonic', 20);

  v_herb_id := herbal.ensure_herb('Sanguinaria canadensis', 'bloodroot');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Stimulating expectorant', 21);

  v_herb_id := herbal.ensure_herb('Symphytum officinale', 'comfrey');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Demulcent', 22);

  v_herb_id := herbal.ensure_herb('Symplocarpus foetidus', 'skunk cabbage');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antispasmodic', 23);

  v_herb_id := herbal.ensure_herb('Thymus vulgaris', 'thyme');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antimicrobial', 24);

  v_herb_id := herbal.ensure_herb('Trigonella foenum-graecum', 'fenugreek');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Demulcent expectorant', 25);

  v_herb_id := herbal.ensure_herb('Tussilago farfara', 'coltsfoot');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Pulmonary tonic and expectorant', 26);

  v_herb_id := herbal.ensure_herb('Verbascum thapsus', 'mullein');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Pulmonary tonic and expectorant', 27);

  v_herb_id := herbal.ensure_herb('Verbena officinalis', 'vervain');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Nervine support', 28);

  v_herb_id := herbal.ensure_herb('Viola odorata', 'sweet violet');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Expectorant', 29);

END $$;

-- ============================================================================
-- ACUTE BRONCHITIS - PRESCRIPTIONS
-- ============================================================================

DO $$
DECLARE
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_herb_id INTEGER;
  v_presc_herb_id INTEGER;
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Acute Bronchitis';

  -- Prescription 1: A Demulcent Tea for Acute Dry Cough
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'A Demulcent Tea for Acute Dry Cough', 'The infusion presented here, provided by Dr. Rudolf Fritz Weiss in Herbal Medicine, supplies the additional benefit of increased fluid intake. Infuse 2 teaspoons of dry herb combination in 1 cup of boiling water for 20 minutes; drink hot three times a day', 1)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Verbascum thapsus', 'mullein');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 1)
  RETURNING id INTO v_presc_herb_id;

  v_herb_id := herbal.ensure_herb('Tussilago farfara', 'coltsfoot');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 2)
  RETURNING id INTO v_presc_herb_id;

  v_herb_id := herbal.ensure_herb('Althaea officinalis', 'marshmallow');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 3)
  RETURNING id INTO v_presc_herb_id;

  v_herb_id := herbal.ensure_herb('Pimpinella anisum', 'anise');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 4)
  RETURNING id INTO v_presc_herb_id;

  -- Prescription 2: Prescription I to Promote Expectoration
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Prescription I to Promote Expectoration', 'Another approach increases the stimulating expectorant component, making it more appropriate for subacute and chronic bronchitis characterized by excessive sputum production. Infuse 2 teaspoons of dry herb combination in 1 cup of boiling water for 20 minutes; drink hot three times a day.', 2)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Primula veris', 'cowslip');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 1);

  v_herb_id := herbal.ensure_herb('Thymus vulgaris', 'thyme');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 2);

  v_herb_id := herbal.ensure_herb('Tussilago farfara', 'coltsfoot');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 3);

  -- Prescription 3: Prescription II to Promote Expectoration
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Prescription II to Promote Expectoration', 'An alternative yet equivalent approach for acute dry cough replaces Thymus vulgaris with Pimpinella anisum. This combination also boosts the stimulating expectorant action of the prescription by increasing the proportion of saponin-rich Primula veris. Infuse 2 teaspoons of dry herb combination in 1 cup of boiling water for 20 minutes; drink hot three times a day.', 3)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Primula veris', 'cowslip');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '2 parts', 1);

  v_herb_id := herbal.ensure_herb('Pimpinella anisum', 'anise');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 2);

  v_herb_id := herbal.ensure_herb('Tussilago farfara', 'coltsfoot');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 3);

  -- Prescription 4: A Prescription to Combat Infection in Acute Bronchitis
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'A Prescription to Combat Infection in Acute Bronchitis', 'Dosage: up to 5 ml of tincture three times a day. Allium sativum should be eaten raw (one clove a day) or garlic oil taken as a supplement.', 4)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Inula helenium', 'elecampane');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 1);

  v_herb_id := herbal.ensure_herb('Marrubium vulgare', 'white horehound');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 2);

  v_herb_id := herbal.ensure_herb('Tussilago farfara', 'coltsfoot');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 3);

  v_herb_id := herbal.ensure_herb('Hydrastis canadensis', 'goldenseal');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 4);

  v_herb_id := herbal.ensure_herb('Echinacea spp.', 'echinacea');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 5);

  -- Prescription 5: Steam Inhalation
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Steam Inhalation', 'Thymus, Eucalyptus, Matricaria, and Origanum are good choices for steam inhalations. Pure plant essential oils may also be used. Volatile oil-rich herbs are effective decongestants and support the internal treatment by addressing some associated symptoms. Add 1 tablespoon of dried herb combination to ½ liter (1 pint) of boiling water. Create a tent by draping a towel over the head to prevent the escape of vapors; inhale vapors rising from bowl. Inhale vapors for 5 to 10 minutes.', 5)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Matricaria recutita', 'chamomile');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 'flowers', 1);

  v_herb_id := herbal.ensure_herb('Thymus vulgaris', 'thyme');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 'herb', 2);

  v_herb_id := herbal.ensure_herb('Origanum vulgare', 'oregano');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 'herb', 3);

  -- Prescription 6: Essential Oil Inhalation (note about various oils)
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Essential Oil Inhalation', 'In the first stages of acute bronchitis, when the cough is dry and painful, steam inhalation with the oils listed here may provide a great deal of relief. Bergamot and eucalyptus oils are also effective in lowering fever, and all of these oils will help to reinforce the immune response to the infection. Dwarf pine needle oil (Pinus pumilio) has been the main oil used traditionally, but with the growing interest in aromatherapy, many volatile oils are now recognized as valuable remedies for inhalations. Mentha arvensis var. piperascens, the source of "Chinese white flower oil," is especially rich in menthol. Menthol is anti-inflammatory, especially for the mucous membranes of the upper respiratory tract. It stimulates mucous secretions and exerts antimicrobial and mild anaesthetic actions. As with many oils, it is best used at the onset of symptoms. Essential Oil Inhalation: Place 3 to 5 drops of essential oil in a bowl and add boiling water. Create a tent by draping a towel over the head to prevent the escape of vapors; inhale vapors rising from bowl. Inhale for 5 to 10 minutes, keeping the eyes closed to prevent irritation from vapor. Massaging or otherwise applying oils to chest, neck, or back fosters absorption through the skin, technically called percutaneous absorption. Be sure to dilute the oil first in an appropriate carrier oil, such as almond oil. Essential oils absorbed through the skin are often eliminated from the body via the lungs, allowing the constituents to come in contact with the site of lung infection or inflammation. A good technique is to apply the oil and then place a clean dry cloth over the area to ensure that oils are absorbed and do not evaporate.', 6)
  RETURNING id INTO v_prescription_id;

  -- Note: Essential oils - these herbs are just referenced as oils, not as traditional herbal preparations
  v_herb_id := herbal.ensure_herb('Citrus aurantium ssp. bergamia', 'bergamot');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 1);

  v_herb_id := herbal.ensure_herb('Eucalyptus globulus', 'eucalyptus');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 2);

  v_herb_id := herbal.ensure_herb('Lavandula spp.', 'lavender');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 3);

  v_herb_id := herbal.ensure_herb('Mentha arvensis var. piperascens', 'Asian mint');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 4);

  v_herb_id := herbal.ensure_herb('Mentha piperita', 'peppermint');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 5);

  v_herb_id := herbal.ensure_herb('Pinus pumilio', 'dwarf pine');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 6);

  v_herb_id := herbal.ensure_herb('Santalum album', 'sandalwood');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 7);

  v_herb_id := herbal.ensure_herb('Styrax benzoin', 'benzoin');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 8);

  v_herb_id := herbal.ensure_herb('Thymus vulgaris', 'thyme');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 9);

END $$;

-- ============================================================================
-- SUMMARY
-- ============================================================================
-- This migration adds:
-- 1. Bronchitis disorder with notes
-- 2. Acute Bronchitis disorder with:
--    - Disorder notes
--    - Actions Indicated
--    - Specific Remedies (29 herbs)
--    - 6 Prescriptions with herbs
-- Populate Respiratory Systems - Part 3
-- Lower Respiratory: Post-Bronchitis Recovery and Chronic Bronchitis
-- File: Respiratory System.md

SET search_path TO herbal, public;

-- ============================================================================
-- LOWER RESPIRATORY SYSTEM - POST-BRONCHITIS RECOVERY
-- ============================================================================

DO $$
DECLARE
  v_lower_resp_id INTEGER;
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_lower_resp_id FROM herbal.body_systems WHERE name = 'Lower Respiratory';

  -- Create Post-Bronchitis Recovery disorder
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Post-Bronchitis Recovery', v_lower_resp_id, 4)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'A bout of acute bronchitis is commonly followed by a period of debility.', 1),
    (v_disorder_id, 'Emphasis should be given to respiratory tonics, bitter tonics, and support for any body system or functions indicated for the individual.', 2),
    (v_disorder_id, 'Goals of treatment in the latter stages of acute bronchitis include clearing mucus from the lungs and preventing the development of complications, and any of the expectorant essential oils will be indicated.', 3),
    (v_disorder_id, 'Specific Remedies: Toning remedies to consider include Verbascum thapsus and Marrubium vulgare. Marrubium is especially useful, for not only is it a useful lung remedy, but it also has valuable bitter properties.', 4);

  -- Add Specific Remedies
  v_herb_id := herbal.ensure_herb('Verbascum thapsus', 'mullein');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Toning remedy for lungs', 1);

  v_herb_id := herbal.ensure_herb('Marrubium vulgare', 'white horehound');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Useful lung remedy with valuable bitter properties', 2);

  -- Prescription: Essential oils for recovery
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Essential Oils for Recovery', 'Applying essential oils in inhalations, baths, and local massage to chest and throat will shorten the time needed for full recovery.', 1)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Citrus aurantium ssp. bergamia', 'bergamot');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 1);

  v_herb_id := herbal.ensure_herb('Commiphora molmol', 'myrrh');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 2);

  v_herb_id := herbal.ensure_herb('Ocimum basilicum', 'basil');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 3);

  v_herb_id := herbal.ensure_herb('Origanum majorana', 'marjoram');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 4);

  v_herb_id := herbal.ensure_herb('Santalum album', 'sandalwood');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 5);

  v_herb_id := herbal.ensure_herb('Thymus vulgaris', 'thyme');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 6);

END $$;

-- ============================================================================
-- LOWER RESPIRATORY SYSTEM - CHRONIC BRONCHITIS
-- ============================================================================

DO $$
DECLARE
  v_lower_resp_id INTEGER;
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_action_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_lower_resp_id FROM herbal.body_systems WHERE name = 'Lower Respiratory';

  -- Create Chronic Bronchitis disorder
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Chronic Bronchitis', v_lower_resp_id, 5)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'Chronic bronchitis is a long-term condition unaccompanied by fever. It is characterized by a permanent cough with sputum that results from continual overproduction of mucus.', 1),
    (v_disorder_id, 'When infection, air pollution, smoking, or other external factors irritate the bronchi, the lungs are provoked to produce abnormally large amounts of mucus, which literally swamp the minute cilia. A deep layer of mucus covers the cilia, so they are no longer able to propel it out of the bronchi.', 2),
    (v_disorder_id, 'Chronic bronchitis is preventable, as the primary causal factors are pollutants.', 3),
    (v_disorder_id, 'Bronchi become narrowed due to thickening, the lungs lose some of their elasticity, damage also reduces the amount of alveolar tissue. Eventually, the heart may become strained.', 4),
    (v_disorder_id, 'Giving up smoking is the first and most important preventive measure. The other is improving nutrition, particularly cutting out or greatly reducing the consumption of foods that encourage the production of mucus. For most people, these are dairy products and refined starches.', 5),
    (v_disorder_id, 'Exercise can strengthen the muscles that facilitate breathing. Patients should exercise at least three times a week, starting with short sessions of gentle exercise and gradually building up to longer, more strenuous sessions.', 6),
    (v_disorder_id, 'Specific Remedies: Please refer to Specific Remedies provided for acute bronchitis. In addition, the steam inhalation and aromatherapy recommendations given for acute bronchitis are also relevant to chronic bronchitis.', 7);

  -- Actions Indicated
  v_action_id := herbal.ensure_action('Pulmonary tonic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'Essential for supporting respiratory function and the health and general tone of the lungs.', 1);

  v_action_id := herbal.ensure_action('Stimulating expectorant');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'Especially useful in cases characterized by heavy mucus production.', 2);

  v_action_id := herbal.ensure_action('Relaxing expectorant');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'Not as important in chronic as acute bronchitis; however, they often serve as good supportive remedies.', 3);

  v_action_id := herbal.ensure_action('Demulcent');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'will soothe any associated irritation.', 4);

  v_action_id := herbal.ensure_action('Diaphoretic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'Valuable when fever is an issue, but are not as vital here as in acute bronchitis.', 5);

  v_action_id := herbal.ensure_action('Antispasmodic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'can help if coughing or breathlessness is severe.', 6);

  v_action_id := herbal.ensure_action('Antimicrobial');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'help the body rid itself of any accompanying infection.', 7);

  v_action_id := herbal.ensure_action('Cardiotonic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'Essential for supporting cardiac function in the elderly, patients with cardiovascular weakness, or those with long-term chronic bronchitis.', 8);

  v_action_id := herbal.ensure_action('Nervine');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'and even adaptogen support may be useful in some cases.', 9);

END $$;

-- ============================================================================
-- CHRONIC BRONCHITIS - PRESCRIPTIONS
-- ============================================================================

DO $$
DECLARE
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Chronic Bronchitis';

  -- Prescription 1: Basic formula for debilitated patients
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, NULL, 'Add 1 teaspoon of dried herb mixture to 1 cup of boiling water and infuse for 20 minutes. Drink hot three times a day. This formulation is designed for a patient who is debilitated and weakened by chronic bronchitis. Thus, it contains a blend of stimulating and relaxing pulmonary tonics. Cetraria has long been used in the United Kingdom (the world capital of chronic bronchitis!) as nutritive support in such cases. To this may be added other herbs appropriate for the individual, such as Crataegus spp., Eleutherococcus senticosus, and Galium aparine.', 1)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Inula helenium', 'elecampane');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 1);

  v_herb_id := herbal.ensure_herb('Cetraria islandica', 'Iceland moss');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 2);

  v_herb_id := herbal.ensure_herb('Tussilago farfara', 'coltsfoot');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 3);

  v_herb_id := herbal.ensure_herb('Verbascum thapsus', 'mullein');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 4);

  -- Prescription 2: For Chronic Bronchitis with Infection
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'A Prescription for Chronic Bronchitis with Infection', 'Dosage: up to 5 ml of tincture three times a day. Allium sativum should be eaten raw (one clove a day) or garlic oil taken as a supplement.', 2)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Inula helenium', 'elecampane');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 1);

  v_herb_id := herbal.ensure_herb('Echinacea spp.', 'echinacea');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 2);

  v_herb_id := herbal.ensure_herb('Marrubium vulgare', 'white horehound');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 3);

  v_herb_id := herbal.ensure_herb('Verbascum thapsus', 'mullein');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 4);

  -- Prescription 3: For Chronic Recurrent Bronchitis with Dyspnea
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'A Prescription for Chronic Recurrent Bronchitis with Dyspnea', 'Add 1 part the Dyspnea formula as well. Dosage: up to 5 ml of tincture three times a day. Allium sativum should be eaten raw in the diet (one clove a day) or garlic oil taken as a supplement.', 3)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Inula helenium', 'elecampane');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 1);

  v_herb_id := herbal.ensure_herb('Marrubium vulgare', 'white horehound');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 2);

  v_herb_id := herbal.ensure_herb('Verbascum thapsus', 'mullein');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 3);

  -- Prescription 4: For Chronic Recurrent Bronchitis with Severe Congestion
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'A Prescription for Chronic Recurrent Bronchitis with Severe Congestion', 'Dosage: up to 5 ml of tincture three times a day. Allium sativum should be eaten raw in the diet (one clove a day) or garlic oil taken as a supplement.', 4)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Inula helenium', 'elecampane');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 1);

  v_herb_id := herbal.ensure_herb('Sanguinaria canadensis', 'bloodroot');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 2);

  v_herb_id := herbal.ensure_herb('Marrubium vulgare', 'white horehound');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 3);

  v_herb_id := herbal.ensure_herb('Verbascum thapsus', 'mullein');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 4);

END $$;

-- ============================================================================
-- SUMMARY
-- ============================================================================
-- This migration adds:
-- 1. Post-Bronchitis Recovery disorder with specific remedies and essential oil prescription
-- 2. Chronic Bronchitis disorder with:
--    - Disorder notes
--    - Actions Indicated
--    - 4 Prescriptions with herbs
-- Populate Respiratory Systems - Part 4
-- Lower Respiratory: Pertussis, Asthma, and Emphysema
-- File: Respiratory System.md

SET search_path TO herbal, public;

-- ============================================================================
-- LOWER RESPIRATORY SYSTEM - PERTUSSIS
-- ============================================================================

DO $$
DECLARE
  v_lower_resp_id INTEGER;
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_lower_resp_id FROM herbal.body_systems WHERE name = 'Lower Respiratory';

  -- Create Pertussis disorder
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Pertussis', v_lower_resp_id, 6)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'Pertussis, commonly known as whooping cough, is caused by the bacterium Bordetella pertussis. This highly contagious infection is transmitted when the bacteria are coughed or sneezed out by an infected person and breathed in by someone else, especially during the catarrhal and early paroxysmal stages of the disease.', 1),
    (v_disorder_id, 'The disease lasts about six weeks and has three well-defined stages. 1. Catarrhal. This stage begins slowly, with sneezing, free-flowing tears, and other signs typical of the common cold. 2. Paroxysmal. Developing after 10 to 14 days, this stage is characterized by paroxysmal coughing. 3. Convalescent. This stage usually begins within four weeks.', 2),
    (v_disorder_id, 'Long-term immune system support is essential after such an infection. In addition, support for the respiratory system and potentially even the cardiovascular system may be needed.', 3),
    (v_disorder_id, 'Specific Remedies: The European herbal tradition proposes a number of herbs as possible specifics. However, these are not dramatically effective and do not replace appropriate antibiotic treatment. Instead, they support antibiotic therapy.', 4);

  -- Add Specific Remedies
  v_herb_id := herbal.ensure_herb('Drosera rotundifolia', 'sundew');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Traditional specific for pertussis', 1);

  v_herb_id := herbal.ensure_herb('Thymus vulgaris', 'thyme');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antimicrobial support', 2);

  v_herb_id := herbal.ensure_herb('Pinguicula vulgaris', 'butterwort');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Traditional remedy', 3);

  v_herb_id := herbal.ensure_herb('Prunus serotina', 'wild cherry');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antispasmodic and cough suppressant', 4);

  v_herb_id := herbal.ensure_herb('Eryngium planum', 'sea holly');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Traditional remedy', 5);

  -- Prescription: For Pertussis and Other Paroxysmal Coughs
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'A Prescription for Pertussis and Other Paroxysmal Coughs', 'Infuse 1 teaspoon of dried herb mixture in 1 cup of boiling water for 20 minutes. This should be drunk hot several times a day. Hot infusions are valuable in that they replace lost fluids and promote diaphoresis.', 1)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Thymus vulgaris', 'thyme');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 1);

  v_herb_id := herbal.ensure_herb('Drosera rotundifolia', 'sundew');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 2);

  v_herb_id := herbal.ensure_herb('Prunus serotina', 'wild cherry');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 3);

  v_herb_id := herbal.ensure_herb('Pimpinella anisum', 'anise');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 4);

END $$;

-- ============================================================================
-- LOWER RESPIRATORY SYSTEM - ASTHMA
-- ============================================================================

DO $$
DECLARE
  v_lower_resp_id INTEGER;
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_action_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_lower_resp_id FROM herbal.body_systems WHERE name = 'Lower Respiratory';

  -- Create Asthma disorder
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Asthma', v_lower_resp_id, 7)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'Asthma is a chronic inflammatory disorder of the airways typified by wheezing, chest tightness, coughing exacerbations, and difficult breathing.', 1),
    (v_disorder_id, 'Asthma can develop at any time, but is most common in young children.', 2),
    (v_disorder_id, 'Replacement of the term asthma with a more descriptive name, reactive airway disease (RAD). People with RAD have bronchial passages that are more sensitive than normal to irritation.', 3),
    (v_disorder_id, 'The inflammation in turn fosters the production of excess mucus and a tightening of the muscles that wind around the bronchial tubes.', 4),
    (v_disorder_id, 'A dry cough is sometimes the only sign.', 5),
    (v_disorder_id, 'An estimated 75% of childhood asthma is allergy related, so controlling allergies may be pivotal to reducing the frequency of asthma attacks.', 6),
    (v_disorder_id, 'As much as 30% of all asthma may be caused by gastro-esophageal reflux, which causes the unpleasant symptom commonly known as heartburn.', 7),
    (v_disorder_id, 'Asthma that begins in childhood is closely linked with the presence of eczema, hay fever, urticaria (hives), and migraine in the patient or in close relatives.', 8);

  -- Actions Indicated
  v_action_id := herbal.ensure_action('Pulmonary tonic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'Important for long-term strengthening of the lungs, but offer little short-term relief for acute attacks.', 1);

  v_action_id := herbal.ensure_action('Expectorant');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'help prevent buildup of sputum in the lungs. However, use only relaxing expectorants, as stimulant expectorants can potentially aggravate breathing difficulties.', 2);

  v_action_id := herbal.ensure_action('Demulcent');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'soothe irritation and support the action of relaxing expectorants.', 3);

  v_action_id := herbal.ensure_action('Antispasmodic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'ease spasm responses in the muscles that facilitate respiration.', 4);

  v_action_id := herbal.ensure_action('Antimicrobial');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'help reduce the potential for secondary in-fection, which should be avoided at all costs.', 5);

  v_action_id := herbal.ensure_action('Anticatarrhal');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'aid the body in dealing with overproduction of sputum in lungs or sinuses.', 6);

  v_action_id := herbal.ensure_action('Cardiotonic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'support the heart in the face of lung congestion or strain,', 7);

  v_action_id := herbal.ensure_action('Nervine');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'support is always appropriate, both because stress is a potential trigger and because asthma can cause stress, which in turn can trigger further attacks.', 8);

  -- Specific Remedies Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id, 'Specific Remedies: Ephedra sinica (ma huang) and other Asian ephedra species prove exceptionally useful as bronchodilators. Although synthetic ephedrine is available, the whole herb is better tolerated and causes fewer adverse heart effects. Ephedra stimulates the sympathetic nervous system and thus relieves the bronchospasm that underlies asthma and certain other conditions, including emphysema. Allergic reactions respond well to Ephedra because of its action on the sympathetic nervous system. The ayurvedic herb Coleus forskohlii may be useful in asthma. The constituent forskolin raises cellular levels of CAMP, which results in relaxation of bronchial muscles and relief of asthma symptoms. Forskolin also inhibits the release of histamine and the synthesis of allergic compounds. The others herbs in this list have Antispasmodic and Bronchodilating effects.', 9);

  -- Add Specific Remedies
  v_herb_id := herbal.ensure_herb('Ephedra sinica', 'ma huang');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Exceptionally useful bronchodilator, better tolerated than synthetic ephedrine', 1);

  v_herb_id := herbal.ensure_herb('Coleus forskohlii', 'coleus');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Ayurvedic herb useful for bronchial muscle relaxation', 2);

  v_herb_id := herbal.ensure_herb('Ammi visnaga', 'khella');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antispasmodic and bronchodilator', 3);

  v_herb_id := herbal.ensure_herb('Drosera rotundifolia', 'sundew');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antispasmodic effects', 4);

  v_herb_id := herbal.ensure_herb('Euphorbia pilulifera', 'pill-bearing spurge');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antispasmodic and bronchodilator', 5);

  v_herb_id := herbal.ensure_herb('Grindelia camporum', 'gumweed');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antispasmodic and expectorant', 6);

  v_herb_id := herbal.ensure_herb('Prunus serotina', 'wild cherry');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antispasmodic effects', 7);

END $$;

-- ============================================================================
-- ASTHMA - PRESCRIPTIONS
-- ============================================================================

DO $$
DECLARE
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Asthma';

  -- Prescription 1: Dyspnea Formula for Asthma
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Dyspnea Formula for Asthma', 'Dosage: 5 ml of mixture three times a day. If Euphorbia pilulifera proves difficult to obtain, double the amount of Grindelia to make up for it.', 1)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Grindelia camporum', 'gumweed');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '24 parts', 'tincture', 1);

  v_herb_id := herbal.ensure_herb('Euphorbia pilulifera', 'pill-bearing spurge');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '24 parts', 'tincture', 2);

  v_herb_id := herbal.ensure_herb('Lobelia inflata', 'lobelia');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '12 parts', 'tincture', 3);

  v_herb_id := herbal.ensure_herb('Prunus serotina', 'wild cherry');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '12 parts', 'tincture', 4);

  v_herb_id := herbal.ensure_herb('Glycyrrhiza glabra', 'licorice');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '12 parts', 'tincture', 5);

  v_herb_id := herbal.ensure_herb('Leonurus cardiaca', 'motherwort');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '12 parts', 'tincture', 6);

  v_herb_id := herbal.ensure_herb('Ephedra sinica', 'ma huang');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '10 parts', 'tincture', 7);

  v_herb_id := herbal.ensure_herb('Pimpinella anisum', 'anise');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 'essential oil', 8);

  -- Prescription 2: For Childhood Atopic Asthma Associated with Eczema
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'A Prescription for Childhood Atopic Asthma Associated with Eczema', 'Add Dyspnea Formula - 2 parts. Dosage: up to 5 ml of tincture three times a day', 2)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Galium aparine', 'cleavers');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 1);

  v_herb_id := herbal.ensure_herb('Trifolium pratense', 'red clover');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 2);

  v_herb_id := herbal.ensure_herb('Urtica dioica', 'nettle');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 3);

  -- Additional Specific Remedies for acute asthmatic crisis
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id, 'Additional Specific Remedies: During an actual asthmatic crisis, inhalation of an antispasmodic oil is the only practical herbal help.', 10);

  v_herb_id := herbal.ensure_herb('Hyssopus officinalis', 'hyssop');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antispasmodic oil for acute crisis inhalation', 8);

  v_herb_id := herbal.ensure_herb('Lavandula spp.', 'lavender');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antispasmodic oil for acute crisis inhalation', 9);

  v_herb_id := herbal.ensure_herb('Pimpinella anisum', 'anise');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antispasmodic oil for acute crisis inhalation', 10);

  v_herb_id := herbal.ensure_herb('Pinus sylvestris', 'Scots pine');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antispasmodic oil for acute crisis inhalation', 11);

  v_herb_id := herbal.ensure_herb('Rosmarinus officinalis', 'rosemary');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antispasmodic oil for acute crisis inhalation', 12);

END $$;

-- ============================================================================
-- LOWER RESPIRATORY SYSTEM - EMPHYSEMA
-- ============================================================================

DO $$
DECLARE
  v_lower_resp_id INTEGER;
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_action_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_lower_resp_id FROM herbal.body_systems WHERE name = 'Lower Respiratory';

  -- Create Emphysema disorder
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Emphysema', v_lower_resp_id, 8)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'Emphysema, which often develops as a long-term complication of chronic bronchitis, is characterized by damage to the elastic walls of the sac-like alveoli in the lungs. This damage is caused by constant coughing.', 1);

  -- Actions Indicated
  v_action_id := herbal.ensure_action('Pulmonary tonic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'Important for long-term strengthening of the lungs but offer little short-term relief for acute attacks.', 1);

  v_action_id := herbal.ensure_action('Expectorant');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'Essential to minimize the buildup of sputum in the lungs. Stimulant expectorants are necessary here because of the lessening of tone that affects the walls of the alveoli.', 2);

  v_action_id := herbal.ensure_action('Demulcent');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'soothe irritation and support the work of expectorants.', 3);

  v_action_id := herbal.ensure_action('Antispasmodic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'ease spasm responses in the muscles that facilitate respiration.', 4);

  v_action_id := herbal.ensure_action('Antimicrobial');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'help reduce the potential for secondary infection, which should be avoided at all costs.', 5);

  v_action_id := herbal.ensure_action('Anticatarrhal');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'aid the body in dealing with overproduction of sputum in lungs or sinuses.', 6);

  v_action_id := herbal.ensure_action('Cardiotonic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'support the heart in the face of lung congestion or strain.', 7);

  v_action_id := herbal.ensure_action('Nervine');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'support is always appropriate, as stress will exacerbate emphysema.', 8);

  -- Prescription: For Emphysema
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'A Prescription for Emphysema', 'Add Dyspnea Formula (1 part) Dosage: up to 5 ml of tincture three times a day', 1)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Sanguinaria canadensis', 'bloodroot');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 1);

  v_herb_id := herbal.ensure_herb('Inula helenium', 'elecampane');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 2);

END $$;

-- ============================================================================
-- SUMMARY
-- ============================================================================
-- This migration adds:
-- 1. Pertussis disorder with specific remedies and prescription
-- 2. Asthma disorder with:
--    - Disorder notes
--    - Actions Indicated
--    - Specific Remedies (12 herbs)
--    - 2 Prescriptions
-- 3. Emphysema disorder with:
--    - Disorder notes
--    - Actions Indicated
--    - 1 Prescription
--
-- Lower Respiratory system disorders are now complete
-- Populate Respiratory Systems - Part 5
-- Upper Respiratory: All (Overall) and The Common Cold
-- File: Respiratory System.md

SET search_path TO herbal, public;

-- ============================================================================
-- UPPER RESPIRATORY SYSTEM - ALL (OVERALL)
-- ============================================================================

DO $$
DECLARE
  v_upper_resp_id INTEGER;
  v_disorder_id INTEGER;
  v_action_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_upper_resp_id FROM herbal.body_systems WHERE name = 'Upper Respiratory';

  -- Create "All" disorder for Upper Respiratory
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('All', v_upper_resp_id, 0)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'Many chronic catarrhal states represent the body''s response to a diet too rich in mucus-forming foods.', 1),
    (v_disorder_id, 'If the body is using the mucous membranes of the sinuses as a window for removing waste through the vehicle of the catarrh, then it is best to support rather than block this activity.', 2),
    (v_disorder_id, 'Blockage of the sinus cavities is very common and relatively easy to treat with herbs.', 3),
    (v_disorder_id, 'Specific Remedies: Anticatarrhal herbs do not substitute for the nurturing action of tonics for this part of the body. From the European perspective, here are some appropriate tonics that also possess anti-catarrhal properties.', 4);

  -- Add Action Herbs for Overall Upper Respiratory
  -- Antimicrobial
  v_action_id := herbal.ensure_action('Antimicrobial');

  v_herb_id := herbal.ensure_herb('Allium spp.', 'onion and garlic');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_herb_id := herbal.ensure_herb('Eucalyptus spp.', 'eucalyptus');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  v_herb_id := herbal.ensure_herb('Thymus vulgaris', 'thyme');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  v_herb_id := herbal.ensure_herb('Baptisia tinctoria', 'wild indigo');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 4);

  v_herb_id := herbal.ensure_herb('Commiphora molmol', 'myrrh');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 5);

  v_herb_id := herbal.ensure_herb('Ligusticum porteri', 'osha');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 6);

  -- Immune stimulant
  v_action_id := herbal.ensure_action('Immune stimulant');
  v_herb_id := herbal.ensure_herb('Echinacea spp.', 'echinacea');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  -- Anticatarrhal
  v_action_id := herbal.ensure_action('Anticatarrhal');
  v_herb_id := herbal.ensure_herb('Solidago virgaurea', 'goldenrod');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_herb_id := herbal.ensure_herb('Sambucus nigra', 'elder');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  v_herb_id := herbal.ensure_herb('Hyssopus officinalis', 'hyssop');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  v_herb_id := herbal.ensure_herb('Tussilago farfara', 'coltsfoot');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 4);

  v_herb_id := herbal.ensure_herb('Hydrastis canadensis', 'goldenseal');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 5);

  -- Astringents
  v_action_id := herbal.ensure_action('Astringent');
  v_herb_id := herbal.ensure_herb('Salvia officinalis', 'sage');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_herb_id := herbal.ensure_herb('Euphrasia spp.', 'eyebright');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  -- Diaphoretic
  v_action_id := herbal.ensure_action('Diaphoretic');
  v_herb_id := herbal.ensure_herb('Eupatorium perfoliatum', 'boneset');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_herb_id := herbal.ensure_herb('Tilia platyphyllos', 'linden');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  -- Add Specific Remedies (tonics with anti-catarrhal properties)
  v_herb_id := herbal.ensure_herb('Euphrasia spp.', 'eyebright');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Tonic with anti-catarrhal properties', 1);

  v_herb_id := herbal.ensure_herb('Hydrastis canadensis', 'goldenseal');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Tonic with anti-catarrhal properties', 2);

  v_herb_id := herbal.ensure_herb('Hyssopus officinalis', 'hyssop');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Tonic with anti-catarrhal properties', 3);

  v_herb_id := herbal.ensure_herb('Sambucus nigra', 'elder');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Tonic with anti-catarrhal properties', 4);

  v_herb_id := herbal.ensure_herb('Solidago virgaurea', 'goldenrod');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Tonic with anti-catarrhal properties', 5);

  v_herb_id := herbal.ensure_herb('Urtica dioica', 'nettle');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Tonic with anti-catarrhal properties', 6);

END $$;

-- ============================================================================
-- UPPER RESPIRATORY SYSTEM - THE COMMON COLD
-- ============================================================================

DO $$
DECLARE
  v_upper_resp_id INTEGER;
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_action_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_upper_resp_id FROM herbal.body_systems WHERE name = 'Upper Respiratory';

  -- Create The Common Cold disorder
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('The Common Cold', v_upper_resp_id, 1)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'When the mucous membranes of the nose and throat are inflamed by infection, they are far more vulnerable to attack by bacteria, and this can easily give rise to secondary infections that are more serious than the original cold, such as sinusitis, ear infections, and bronchitis.', 1),
    (v_disorder_id, 'For a short-term, acute infection, there is usually no need to focus on system support. However, if the individual has frequent or recurrent colds, the use of tonic remedies will be vital.', 2),
    (v_disorder_id, 'If the patient has a history of heart dis-ease, cardiotonics may be used as a precautionary measure. However, Tilia is most appropriate, as it is diaphoretic in addition to being a heart tonic.', 3);

  -- Actions Indicated
  v_action_id := herbal.ensure_action('Antimicrobial');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'help the immune system combat the viral infection and help prevent secondary infection.', 1);

  v_action_id := herbal.ensure_action('Immune stimulant');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'help the immune system combat the viral infection and help prevent secondary infection.', 2);

  v_action_id := herbal.ensure_action('Anticatarrhal');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'ease the symptomatic discomfort so characteristic of this problem. However, avoid trying to dry up mucus overproduction with herbal decongestants.', 3);

  v_action_id := herbal.ensure_action('Diaphoretic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'help with feverishness and support the body''s efforts to cope with elevated body temperature.', 4);

  v_action_id := herbal.ensure_action('Expectorant');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'help combat the development of secondary problems in the lower respiratory system.', 5);

  v_action_id := herbal.ensure_action('Lymphatic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'indicated if the lymph glands are swollen or there is a known history of such problems', 6);

  -- Specific Remedies Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'Specific Remedies: Aches and pains are common, and our materia medica offers a number of plants that will relieve these unpleasant feelings. Perhaps the best is the diaphoretic Eupatorium perfoliatum (boneset), especially if the patient has a fever. Boneset''s bitter taste is one of its therapeutic assets.', 4),
    (v_disorder_id, 'Do not inhibit nasal congestion with anticatarrhal drugs, as mucus production is part of the body''s normal response to infection. Herbal anticatarrhals work in a different, safer way than anticatarrhal drugs. Matricaria, Mentha piperita, or Eupatorium perfoliatum can help relieve much of the discomfort. Steam inhalations of eucalyptus and thyme oils will also help reduce the formation of catarrh.', 5),
    (v_disorder_id, 'To support the immune system, use antimicrobial herbs such as echinacea and goldenseal, as well as ton-ics, such as cleavers and nettles. These may be combined in capsules or as tinctures. Hydrastis canadensis will speed recovery from infection, as will raw garlic or garlic oil capsules.', 6);

END $$;

-- ============================================================================
-- THE COMMON COLD - SPECIFIC REMEDIES AND PRESCRIPTIONS
-- ============================================================================

DO $$
DECLARE
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'The Common Cold';

  -- Add Specific Remedies
  v_herb_id := herbal.ensure_herb('Achillea millefolium', 'yarrow');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Diaphoretic and antimicrobial', 1);

  v_herb_id := herbal.ensure_herb('Allium spp.', 'onion and garlic');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antimicrobial', 2);

  v_herb_id := herbal.ensure_herb('Armoracia rusticana', 'horseradish');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Stimulating antimicrobial', 3);

  v_herb_id := herbal.ensure_herb('Brassica spp.', 'mustard');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Stimulating and warming', 4);

  v_herb_id := herbal.ensure_herb('Capsicum spp.', 'cayenne');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Stimulating circulatory', 5);

  v_herb_id := herbal.ensure_herb('Eupatorium perfoliatum', 'boneset');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Best for aches and pains with fever', 6);

  v_herb_id := herbal.ensure_herb('Matricaria recutita', 'chamomile');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Anti-inflammatory and calming', 7);

  v_herb_id := herbal.ensure_herb('Mentha piperita', 'peppermint');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Relieves discomfort', 8);

  v_herb_id := herbal.ensure_herb('Sambucus nigra', 'elder');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Diaphoretic and anticatarrhal', 9);

  v_herb_id := herbal.ensure_herb('Tilia platyphyllos', 'linden');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Diaphoretic and cardiotonic', 10);

  v_herb_id := herbal.ensure_herb('Echinacea spp.', 'echinacea');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Immune support and antimicrobial', 11);

  v_herb_id := herbal.ensure_herb('Eucalyptus globulus', 'eucalyptus');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antimicrobial for steam inhalations', 12);

  v_herb_id := herbal.ensure_herb('Hydrastis canadensis', 'goldenseal');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Speeds recovery from infection', 13);

  v_herb_id := herbal.ensure_herb('Thymus vulgaris', 'thyme');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antimicrobial for steam inhalations', 14);

  -- Prescription 1: A Prescription for the Common Cold
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'A Prescription for the Common Cold', 'Infuse 1 to 2 teaspoons of dried herb mixture in 1 cup of boiling water, this should be drunk hot often until symptoms pass.', 1)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Sambucus nigra', 'elder');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 1);

  v_herb_id := herbal.ensure_herb('Mentha piperita', 'peppermint');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 2);

  v_herb_id := herbal.ensure_herb('Achillea millefolium', 'yarrow');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 3);

  -- Prescription 2: Herbal Footbath for Colds
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Herbal Footbath for Colds', 'Footbaths are a traditional treatment for colds. Dissolve 1 tablespoon of mustard powder in 4 pints of hot water. Bathe the feet for 10 minutes, twice a day.', 2)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Brassica spp.', 'mustard');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 tablespoon powder', 1);

  -- Prescription 3: Chamomile Steam Inhalation
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Chamomile Steam Inhalation', 'Place a handful of Matricaria flowers in a bowl and pour boiling water over them. Create a tent by draping a towel over the head to prevent the escape of vapors; inhale vapors rising from bowl for 5 to 10 minutes.', 3)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Matricaria recutita', 'chamomile');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'handful', 'flowers', 1);

  -- Prescription 4: Steam Inhalation Combination
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Steam Inhalation Combination', 'Add 1 tablespoon of dried herb mixture to ½ liter (1 pint) of boiling water. Follow inhalation instructions given for Chamomile Steam Inhalation.', 4)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Matricaria recutita', 'chamomile');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 'flowers', 1);

  v_herb_id := herbal.ensure_herb('Thymus vulgaris', 'thyme');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 'herb', 2);

  v_herb_id := herbal.ensure_herb('Origanum vulgare', 'oregano');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 'herb', 3);

  -- Prescription 5: Essential Oils for Common Cold
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Essential Oils for Common Cold', 'It clears congested nasal passages and soothes inflamed mucous membranes. At the same time, the essential oil will kill many bacteria. Some of the oils, especially Eucalyptus and Melaleuca, have an inhibitory effect on the cold virus. Use either of these two oils for inhalations in the earlier part of the day (possibly alternating with Rosmarinus and Mentha piperita), as they are mildly stimulating. At night, use inhalations of Lavandula or add a few drops of oil to a bath. Diffusing oil in the bedroom is helpful, especially if the patient has a cough.', 5)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Citrus aurantium ssp. bergamia', 'bergamot');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 1);

  v_herb_id := herbal.ensure_herb('Commiphora molmol', 'myrrh');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 2);

  v_herb_id := herbal.ensure_herb('Eucalyptus globulus', 'eucalyptus');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 3);

  v_herb_id := herbal.ensure_herb('Lavandula spp.', 'lavender');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 4);

  v_herb_id := herbal.ensure_herb('Melaleuca spp.', 'tea tree');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 5);

  v_herb_id := herbal.ensure_herb('Mentha arvensis var. piperascens', 'Asian mint');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 6);

  v_herb_id := herbal.ensure_herb('Mentha piperita', 'peppermint');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 7);

  v_herb_id := herbal.ensure_herb('Ocimum basilicum', 'basil');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 8);

  v_herb_id := herbal.ensure_herb('Origanum majorana', 'marjoram');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 9);

  v_herb_id := herbal.ensure_herb('Pinus pumilio', 'dwarf pine');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 10);

  v_herb_id := herbal.ensure_herb('Rosmarinus officinalis', 'rosemary');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 11);

  v_herb_id := herbal.ensure_herb('Santalum album', 'sandalwood');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 12);

  v_herb_id := herbal.ensure_herb('Styrax benzoin', 'benzoin');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 13);

  v_herb_id := herbal.ensure_herb('Thymus vulgaris', 'thyme');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 14);

  -- Prescription 6: Kitchen Remedy to Ward Off a Cold
  -- Note: This contains non-herbal ingredients (ginger, cinnamon, coriander, cloves, lemon)
  -- We'll include only the ones that might be considered herbs
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Kitchen Remedy to Ward Off a Cold', 'Decoct ingredients for 15 minutes in l pint of water; strain. Drink a cupful hot every 2 hours. Sweeten with organic honey to taste.', 6)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Zingiber officinale', 'ginger');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 ounce', 'fresh, sliced', 1);

  v_herb_id := herbal.ensure_herb('Cinnamomum verum', 'cinnamon');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 stick', 'broken', 2);

  v_herb_id := herbal.ensure_herb('Coriandrum sativum', 'coriander');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 teaspoon', 'seeds', 3);

  v_herb_id := herbal.ensure_herb('Syzygium aromaticum', 'clove');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '3', 4);

  v_herb_id := herbal.ensure_herb('Citrus limon', 'lemon');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 slice', '', 5);

END $$;

-- ============================================================================
-- SUMMARY
-- ============================================================================
-- This migration adds:
-- 1. Upper Respiratory - All disorder with action herbs and specific remedies
-- 2. The Common Cold disorder with:
--    - Disorder notes
--    - Actions Indicated
--    - Specific Remedies (14 herbs)
--    - 6 Prescriptions
-- Populate Respiratory Systems - Part 6
-- Upper Respiratory: Influenza and Influenza Convalescence
-- File: Respiratory System.md

SET search_path TO herbal, public;

-- ============================================================================
-- UPPER RESPIRATORY SYSTEM - INFLUENZA
-- ============================================================================

DO $$
DECLARE
  v_upper_resp_id INTEGER;
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_action_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_upper_resp_id FROM herbal.body_systems WHERE name = 'Upper Respiratory';

  -- Create Influenza disorder
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Influenza', v_upper_resp_id, 2)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'Influenza, commonly called the flu, is a severe form of viral respiratory tract infection with generalized bodily symptoms.', 1),
    (v_disorder_id, 'Typical clinical features of influenza include fever (100°F to 103°F in adults and even higher in children), headache, muscle aches, extreme fatigue, and respiratory symptoms, such as cough, sore throat, and runny or stuffy nose.', 2),
    (v_disorder_id, 'Gastrointestinal symptoms are rarely prominent.', 3),
    (v_disorder_id, 'Most people recover completely in one to two weeks.', 4),
    (v_disorder_id, 'Secondary bacterial infections are the greatest risk of influenza.', 5),
    (v_disorder_id, 'Treatment will be most effective if initiated at the very first sign of infection. A moderately hot bath containing a few drops of antiviral essential oil will often induce diaphoresis, followed by a deep, restful sleep.', 6),
    (v_disorder_id, 'It is a good idea to repeat this bath treatment for the next two or three days. Tea tree oil is particularly effective for this purpose. However, some people find it to be a mild skin irritant, and may not be able to tolerate more than 3 or 4 drops in a full bath.', 7);

  -- Actions Indicated
  v_action_id := herbal.ensure_action('Antimicrobial');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'support the immune system in combating viral infection and help prevent the development of secondary infection.', 1);

  v_action_id := herbal.ensure_action('Diaphoretic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'help with symptoms of fever and support the body''s efforts to cope with elevated temperature.', 2);

  v_action_id := herbal.ensure_action('Anticatarrhal');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'ease the symptomatic discomfort so characteristic of this problem. However, avoid trying to dry up mucus overproduction with herbal decongestants.', 3);

  v_action_id := herbal.ensure_action('Expectorant');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'help combat the development of secondary problems in the lower respiratory system.', 4);

  v_action_id := herbal.ensure_action('Lymphatic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'are indicated if the lymph glands are swollen or there is a known history of such problems.', 5);

  v_action_id := herbal.ensure_action('Bitter');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'support the body in dealing with the debility that often follows severe viral infections.', 6);

  v_action_id := herbal.ensure_action('Nervine');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'assist the body in dealing with high fever and associated distress.', 7);

  -- Specific Remedies
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id, 'Specific Remedies: As with the common cold, there are no miracle cures here. However, certain plants can make life much more bearable during a bout of flu. These are usually diaphoretics, and my favorite is Eupatorium perfolatum (boneset).', 8);

  v_herb_id := herbal.ensure_herb('Eupatorium perfoliatum', 'boneset');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Favorite diaphoretic for flu, especially effective', 1);

  -- Prescription: A Prescription for Influenza
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'A Prescription for Influenza', 'Dosage: 2.5 ml of tincture every 2 hours. In addition, the patient should drink a strong hot infusion of Eupatorium perfoliatum every hour. If the symptom picture calls for it, follow recommendations given earlier for the common cold.', 1)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Hydrastis canadensis', 'goldenseal');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 1);

  v_herb_id := herbal.ensure_herb('Echinacea spp.', 'echinacea');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 2);

  v_herb_id := herbal.ensure_herb('Eupatorium perfoliatum', 'boneset');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'infusion', '', 3);

END $$;

-- ============================================================================
-- UPPER RESPIRATORY SYSTEM - INFLUENZA CONVALESCENCE
-- ============================================================================

DO $$
DECLARE
  v_upper_resp_id INTEGER;
  v_disorder_id INTEGER;
  v_action_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_upper_resp_id FROM herbal.body_systems WHERE name = 'Upper Respiratory';

  -- Create Influenza Convalescence disorder
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Influenza Convalescence', v_upper_resp_id, 3)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'Recovery from influenza is often slow, and the convalescing patient may feel very weak and lacking in vitality. Caffeine-containing stimulant herbs should be avoided, as the lift they confer is only temporary and will slow down recovery.', 1),
    (v_disorder_id, 'Bitter tonics will speed recovery through their metabolism-stimulating effects.', 2);

  -- Add Action Herbs for Influenza Convalescence
  v_action_id := herbal.ensure_action('Anticatarrhal');
  v_herb_id := herbal.ensure_herb('Eupatorium perfoliatum', 'boneset');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_herb_id := herbal.ensure_herb('Hydrastis canadensis', 'goldenseal');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  v_herb_id := herbal.ensure_herb('Marrubium vulgare', 'white horehound');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  v_action_id := herbal.ensure_action('Bitter');
  v_herb_id := herbal.ensure_herb('Eupatorium perfoliatum', 'boneset');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_herb_id := herbal.ensure_herb('Gentiana spp.', 'gentian');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  v_herb_id := herbal.ensure_herb('Hydrastis canadensis', 'goldenseal');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  v_herb_id := herbal.ensure_herb('Marrubium vulgare', 'white horehound');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 4);

  v_action_id := herbal.ensure_action('Diaphoretic');
  v_herb_id := herbal.ensure_herb('Eupatorium perfoliatum', 'boneset');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_action_id := herbal.ensure_action('Tonic');
  v_herb_id := herbal.ensure_herb('Hydrastis canadensis', 'goldenseal');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_action_id := herbal.ensure_action('Expectorant');
  v_herb_id := herbal.ensure_herb('Marrubium vulgare', 'white horehound');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

END $$;

-- ============================================================================
-- SUMMARY
-- ============================================================================
-- This migration adds:
-- 1. Influenza disorder with:
--    - Disorder notes
--    - Actions Indicated
--    - Specific Remedies
--    - 1 Prescription
-- 2. Influenza Convalescence disorder with:
--    - Disorder notes
--    - Action Herbs-- Populate Respiratory Systems - Part 7 (FINAL)
-- Upper Respiratory: Hay Fever, Sinusitis, Laryngitis, and Tonsillitis
-- File: Respiratory System.md

SET search_path TO herbal, public;

-- ============================================================================
-- UPPER RESPIRATORY SYSTEM - HAY FEVER
-- ============================================================================

DO $$
DECLARE
  v_upper_resp_id INTEGER;
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_action_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_upper_resp_id FROM herbal.body_systems WHERE name = 'Upper Respiratory';

  -- Create Hay Fever disorder
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Hay Fever', v_upper_resp_id, 4)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'Hay fever, or allergic rhinitis, is a form of allergy that affects the lining of the nose and, often, the eyes and throat.', 1),
    (v_disorder_id, 'Tonic support should be provided for both the upper and lower respiratory systems.', 2);

  -- Actions Indicated
  v_action_id := herbal.ensure_action('Anticatarrhal');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'ease the symptomatic discomfort often characteristic of this problem. Again, avoid trying to dry up mucus overproduction with herbal deconges-tants, as this can end up being quite painful.', 1);

  v_action_id := herbal.ensure_action('Expectorant');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'will be needed if wheezing or pulmonary congestion develops. Relaxing expectorants will usually be most relevant.', 2);

  v_action_id := herbal.ensure_action('Antispasmodic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'essential if there is any marked difficulty with breathing.', 3);

  v_action_id := herbal.ensure_action('Bitter');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'help tone the whole body in the face of the immune systems response.', 4);

  v_action_id := herbal.ensure_action('Anti-inflammatory');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'soothe various symptoms of inflammation as and when they arise.', 5);

  v_action_id := herbal.ensure_action('Astringent');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'often ease the symptom picture, as many anti-catarrhals are also astringents.', 6);

  v_action_id := herbal.ensure_action('Adaptogen');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'and immune support may help long term. This overall system support should cover the liver, kidney, and any other systems that require support.', 7);

  -- Specific Remedies
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id, 'Specific Remedies: There is no particular specific remedy for hay fever. The well-known traditional Chinese remedy Ephedra sinica (ma huang) is a bronchodilator and has much to offer in the treatment of allergic reactions. Ayurveda and unani medicine use Ammi visnaga, a plant with a similar biochemical impact that is now being introduced to the Western world. In addition to these alkaloid-rich plants, certain herbs might be considered specific for various types and sites of symptoms that may arise. For example, Euphrasia spp. ease distress that occurs in the eyes.', 3);

  v_herb_id := herbal.ensure_herb('Ephedra sinica', 'ma huang');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Bronchodilator, effective for allergic reactions', 1);

  v_herb_id := herbal.ensure_herb('Ammi visnaga', 'khella');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Similar to Ephedra, from Ayurveda and unani medicine', 2);

  v_herb_id := herbal.ensure_herb('Euphrasia spp.', 'eyebright');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Eases eye distress', 3);

  -- Prescription: A Prescription for Hay Fever
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'A Prescription for Hay Fever', 'Dosage: 5 ml of tincture three times a day. Ideally, this treatment should be started two months before hay fever season is due to commence. Start with the following dosage regimen. Pre-Hay Fever Season Dosage Regimen: Weeks 1-2: 2.5 ml once a day, Weeks 3-4: 5 ml once a day, Weeks 5-6: 5 ml twice a day, Weeks 7-8: 5 ml three times a day. If this treatment cannot be initiated before the allergy flares up, then start with a full dose immediately, possibly increasing the dose to 5 ml four or five times a day (adults only).', 1)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Ephedra sinica', 'ma huang');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 1);

  v_herb_id := herbal.ensure_herb('Hydrastis canadensis', 'goldenseal');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 2);

  v_herb_id := herbal.ensure_herb('Euphrasia spp.', 'eyebright');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 3);

  v_herb_id := herbal.ensure_herb('Urtica dioica', 'nettle');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '2 parts', 4);

  v_herb_id := herbal.ensure_herb('Solidago virgaurea', 'goldenrod');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '2 parts', 5);

  -- Prescription 2: Essential oils for hay fever
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Essential Oils for Hay Fever', 'Various essential oils can help with symptoms of hay fever, but the specifics vary from person to person. Oils recommended by aromatherapists include all of those listed above for the common cold, with the addition of blue chamomile, lemon balm, and lavender. If steam inhalation makes the patient feel even worse, suggest that the person put some oil on a tissue to sniff whenever needed. A massage with any of these oils can also be helpful.', 2)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Matricaria recutita', 'blue chamomile');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 1);

  v_herb_id := herbal.ensure_herb('Melissa officinalis', 'lemon balm');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 2);

  v_herb_id := herbal.ensure_herb('Lavandula spp.', 'lavender');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 3);

END $$;

-- ============================================================================
-- UPPER RESPIRATORY SYSTEM - SINUSITIS
-- ============================================================================

DO $$
DECLARE
  v_upper_resp_id INTEGER;
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_action_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_upper_resp_id FROM herbal.body_systems WHERE name = 'Upper Respiratory';

  -- Create Sinusitis disorder
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Sinusitis', v_upper_resp_id, 5)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'The sinuses are four bony cavities positioned behind, above, and at each side of the nose and open into the nasal cavity. They act as a sound box to give resonance to the voice. Sinusitis is an inflammation of these air-containing cavities.', 1),
    (v_disorder_id, 'Because the openings from the nose into the sinuses are very narrow, they quickly become blocked when the mucous membranes swell during a cold, hay fever, or catarrh, trapping the infection inside the sinuses.', 2),
    (v_disorder_id, 'If the maxillary sinuses above the cheeks are infected, toothache may result.', 3);

  -- Actions Indicated
  v_action_id := herbal.ensure_action('Antimicrobial');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'pivotal in the treatment of this often entrenched condition. These herbs will help the body deal with any infection present, but also support the immune system in resisting the development of secondary infection.', 1);

  v_action_id := herbal.ensure_action('Anticatarrhal');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'ease the symptomatic discomfort characteristic of this problem and assist the body in eliminating buildup in the sinus cavities.', 2);

  v_action_id := herbal.ensure_action('Astringent');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'often also anticatarrhals, reduce overproduction of mucus.', 3);

  v_action_id := herbal.ensure_action('Anti-inflammatory');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'indicated, but most of the herbs with actions already listed here are also anti-inflammatory.', 4);

  v_action_id := herbal.ensure_action('Diaphoretic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'will be indicated if feverishness is part of the symptom picture.', 5);

  v_action_id := herbal.ensure_action('Analgesic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'may be necessary for temporary pain relief.', 6);

  v_action_id := herbal.ensure_action('Lymphatic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'aid the drainage and immune function of this vital system.', 7);

  v_action_id := herbal.ensure_action('Digestive support');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'indicated if overproduction of mucus causes stomach discomfort.', 8);

  v_action_id := herbal.ensure_action('Adaptogen');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'and immune support may help long term.', 9);

  -- Prescription 1: A Prescription for Sinusitis
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'A Prescription for Sinusitis', 'Dosage: 5 ml of tincture three times a day', 1)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Solidago virgaurea', 'goldenrod');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 1);

  v_herb_id := herbal.ensure_herb('Sambucus nigra', 'elder');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 2);

  v_herb_id := herbal.ensure_herb('Echinacea spp.', 'echinacea');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 3);

  v_herb_id := herbal.ensure_herb('Baptisia tinctoria', 'wild indigo');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 4);

  -- Prescription 2: Steam Inhalation for Upper Respiratory Tract
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Steam Inhalation for Upper Respiratory Tract', 'Combine ingredients in a bottle and shake well. Put a teaspoon of the mixture in a bowl and pour on ½ liter (1 pint) boiled water. Cover the head and the bowl with a towel or cloth and inhale. Caution: Keep the eyes closed', 2)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Styrax benzoin', 'benzoin');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '30 ml', 'Compound tincture', 1);

  v_herb_id := herbal.ensure_herb('Eucalyptus globulus', 'eucalyptus');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '2.5 ml', 'essential oil', 2);

  v_herb_id := herbal.ensure_herb('Mentha piperita', 'peppermint');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '6 drops', 'essential oil', 3);

  v_herb_id := herbal.ensure_herb('Lavandula spp.', 'lavender');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '5 drops', 'essential oil', 4);

  v_herb_id := herbal.ensure_herb('Pinus sylvestris', 'Scots pine');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '5 drops', 'essential oil', 5);

END $$;

-- ============================================================================
-- UPPER RESPIRATORY SYSTEM - LARYNGITIS
-- ============================================================================

DO $$
DECLARE
  v_upper_resp_id INTEGER;
  v_disorder_id INTEGER;
  v_action_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_upper_resp_id FROM herbal.body_systems WHERE name = 'Upper Respiratory';

  -- Create Laryngitis disorder
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Laryngitis', v_upper_resp_id, 6)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'Laryngitis is an acute inflammation of the larynx, or voice box, usually associated with a common cold or overuse of the voice.', 1),
    (v_disorder_id, 'It is usually caused by a bacterial or viral infection.', 2);

  -- Actions Indicated
  v_action_id := herbal.ensure_action('Demulcent');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'will soothe the mucous lining and ease discomfort.', 1);

  v_action_id := herbal.ensure_action('Anti-inflammatory');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'will reduce the immediate cause of distress.', 2);

  v_action_id := herbal.ensure_action('Antimicrobial');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'indicated if there is a causal microorganism involved. However, they are not indicated if inflammation is due to some other cause.', 3);

  v_action_id := herbal.ensure_action('Astringent');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'often effective as a local gargle, especially if the problem was precipitated by overuse of the vocal cords.', 4);

  v_action_id := herbal.ensure_action('Bitter');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'have a toning and stimulating effect on the mucosal lining.', 5);

  -- Specific Remedies
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id, 'Specific Remedies: Aromatherapy provides some oils that ease inflammation quite effectively, including cypress and bergamot oils. To use as a gargle, put 3 drops of essential oil in ½/2 cup of warm water. Gargle hourly.', 3);

  v_herb_id := herbal.ensure_herb('Cupressus sempervirens', 'cypress');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Essential oil for gargle, eases inflammation', 1);

  v_herb_id := herbal.ensure_herb('Citrus aurantium ssp. bergamia', 'bergamot');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Essential oil for gargle, eases inflammation', 2);

END $$;

-- ============================================================================
-- UPPER RESPIRATORY SYSTEM - TONSILLITIS
-- ============================================================================

DO $$
DECLARE
  v_upper_resp_id INTEGER;
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_action_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_upper_resp_id FROM herbal.body_systems WHERE name = 'Upper Respiratory';

  -- Create Tonsillitis disorder
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Tonsillitis', v_upper_resp_id, 7)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'Tonsils are composed of the same type of tissue that makes up the lymph nodes, and they are part of the body''s natural defense system. When the tonsils are infected. the lymph glands in the neck often simultaneously become enlarged and tender.', 1);

  -- Actions Indicated
  v_action_id := herbal.ensure_action('Lymphatic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'are of primary importance, as this is an infection of lymphatic tissue.', 1);

  v_action_id := herbal.ensure_action('Antimicrobial');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'help the immune system combat the infection, whatever the causal pathogen might be, and help prevent the development of secondary infection', 2);

  v_action_id := herbal.ensure_action('Anticatarhal');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'indicated if there is associated sinus congestion or middle ear involvement.', 3);

  v_action_id := herbal.ensure_action('Diaphoretic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'help the body cope with any associated fever.', 4);

  v_action_id := herbal.ensure_action('Expectorant');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'indicated if secondary problems develop in the lower respiratory system.', 5);

  -- Specific Remedies
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id, 'Specific Remedies: Lymphatic alteratives usually have local reputations as specifics for tonsillitis. In the United Kingdom, the most famous is Galium aparine (cleavers).', 2);

  v_herb_id := herbal.ensure_herb('Galium aparine', 'cleavers');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Famous specific for tonsillitis in UK', 1);

  -- Prescription 1: A Prescription for Tonsillitis
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'A Prescription for Tonsillitis', 'Dosage: up to 5 ml of tincture three times a day. Diaphoretics should be added if fever is an issue.', 1)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Galium aparine', 'cleavers');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '2 parts', 1);

  v_herb_id := herbal.ensure_herb('Echinacea spp.', 'echinacea');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '2 parts', 2);

  v_herb_id := herbal.ensure_herb('Baptisia tinctoria', 'wild indigo');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 3);

  v_herb_id := herbal.ensure_herb('Calendula officinalis', 'calendula');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 4);

  -- Prescription 2: Fomentation
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Fomentation', 'Make a strong infusion of dried herb mixture. Dip a cloth in the fomentation and wrap around the neck at night, repeating the procedure each night until the condition clears up.', 2)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Verbascum thapsus', 'mullein');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '3 parts', 1);

  v_herb_id := herbal.ensure_herb('Lobelia inflata', 'lobelia');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 2);

END $$;

-- ============================================================================
-- FINAL SUMMARY
-- ============================================================================
-- This migration completes the Respiratory Systems import with:
-- 1. Hay Fever disorder with actions indicated, specific remedies, and 2 prescriptions
-- 2. Sinusitis disorder with actions indicated and 2 prescriptions
-- 3. Laryngitis disorder with actions indicated and specific remedies
-- 4. Tonsillitis disorder with actions indicated, specific remedies, and 2 prescriptions
--
-- ALL RESPIRATORY SYSTEM DISORDERS ARE NOW COMPLETE!
-- Total: 9 Lower Respiratory + 8 Upper Respiratory = 17 disorders-- Link Respiratory Systems prescription herbs to their therapeutic actions
-- This migration populates the prescription_herb_actions junction table
-- for all respiratory system prescriptions

SET search_path TO herbal, public;

-- For each prescription herb in respiratory disorders, find its matching actions
-- from disorder_action_herbs and create the linkage in prescription_herb_actions
INSERT INTO herbal.prescription_herb_actions (prescription_herb_id, primary_action_id)
SELECT DISTINCT
  ph.id as prescription_herb_id,
  dah.primary_action_id
FROM herbal.prescription_herbs ph
JOIN herbal.disorder_prescriptions dp ON ph.prescription_id = dp.id
JOIN herbal.disorders d ON dp.disorder_id = d.id
JOIN herbal.body_systems bs ON d.body_system_id = bs.id
JOIN herbal.disorder_action_herbs dah ON dah.disorder_id = dp.disorder_id
  AND dah.herb_id = ph.herb_id
WHERE bs.name IN ('Lower Respiratory', 'Upper Respiratory')
  AND NOT EXISTS (
    -- Don't create duplicates
    SELECT 1 FROM herbal.prescription_herb_actions pha
    WHERE pha.prescription_herb_id = ph.id
      AND pha.primary_action_id = dah.primary_action_id
  )
ORDER BY ph.id, dah.primary_action_id;

-- Summary: Show how many prescription herb actions were linked for respiratory systems
DO $$
DECLARE
  v_count INTEGER;
  v_lower_count INTEGER;
  v_upper_count INTEGER;
BEGIN
  -- Total count for respiratory systems
  SELECT COUNT(DISTINCT pha.id) INTO v_count
  FROM herbal.prescription_herb_actions pha
  JOIN herbal.prescription_herbs ph ON pha.prescription_herb_id = ph.id
  JOIN herbal.disorder_prescriptions dp ON ph.prescription_id = dp.id
  JOIN herbal.disorders d ON dp.disorder_id = d.id
  JOIN herbal.body_systems bs ON d.body_system_id = bs.id
  WHERE bs.name IN ('Lower Respiratory', 'Upper Respiratory');

  -- Lower Respiratory count
  SELECT COUNT(DISTINCT pha.id) INTO v_lower_count
  FROM herbal.prescription_herb_actions pha
  JOIN herbal.prescription_herbs ph ON pha.prescription_herb_id = ph.id
  JOIN herbal.disorder_prescriptions dp ON ph.prescription_id = dp.id
  JOIN herbal.disorders d ON dp.disorder_id = d.id
  JOIN herbal.body_systems bs ON d.body_system_id = bs.id
  WHERE bs.name = 'Lower Respiratory';

  -- Upper Respiratory count
  SELECT COUNT(DISTINCT pha.id) INTO v_upper_count
  FROM herbal.prescription_herb_actions pha
  JOIN herbal.prescription_herbs ph ON pha.prescription_herb_id = ph.id
  JOIN herbal.disorder_prescriptions dp ON ph.prescription_id = dp.id
  JOIN herbal.disorders d ON dp.disorder_id = d.id
  JOIN herbal.body_systems bs ON d.body_system_id = bs.id
  WHERE bs.name = 'Upper Respiratory';

END $$;
-- Sync herbs from Respiratory Systems disorders to herb_primary_actions table
-- This ensures both Lower and Upper Respiratory Systems show the correct herb count

SET search_path TO herbal, public;

-- Insert herb-action pairs from disorder_action_herbs into herb_primary_actions
-- for the Lower Respiratory System
INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
SELECT DISTINCT
  dah.herb_id,
  dah.primary_action_id,
  d.body_system_id
FROM herbal.disorder_action_herbs dah
JOIN herbal.disorders d ON dah.disorder_id = d.id
JOIN herbal.body_systems bs ON d.body_system_id = bs.id
WHERE bs.name = 'Lower Respiratory'
ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

-- Insert herb-action pairs from disorder_action_herbs into herb_primary_actions
-- for the Upper Respiratory System
INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
SELECT DISTINCT
  dah.herb_id,
  dah.primary_action_id,
  d.body_system_id
FROM herbal.disorder_action_herbs dah
JOIN herbal.disorders d ON dah.disorder_id = d.id
JOIN herbal.body_systems bs ON d.body_system_id = bs.id
WHERE bs.name = 'Upper Respiratory'
ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

-- Summary: Show how many herbs were synced for each system
DO $$
DECLARE
  v_lower_herb_count INTEGER;
  v_upper_herb_count INTEGER;
BEGIN
  SELECT COUNT(DISTINCT herb_id) INTO v_lower_herb_count
  FROM herbal.herb_primary_actions hpa
  JOIN herbal.body_systems bs ON hpa.body_system_id = bs.id
  WHERE bs.name = 'Lower Respiratory';

  SELECT COUNT(DISTINCT herb_id) INTO v_upper_herb_count
  FROM herbal.herb_primary_actions hpa
  JOIN herbal.body_systems bs ON hpa.body_system_id = bs.id
  WHERE bs.name = 'Upper Respiratory';

END $$;
-- Add 15 herbs with their actions to both Upper and Lower Respiratory systems
-- Source: class materials listing herbs for both respiratory systems

SET search_path TO herbal, public;

-- Temporary helper: adds an action to an herb for both respiratory systems
CREATE OR REPLACE FUNCTION herbal.temp_add_resp_action(
  p_herb_id INTEGER,
  p_action_name TEXT,
  p_upper_id INTEGER,
  p_lower_id INTEGER
) RETURNS VOID AS $$
DECLARE
  v_action_id INTEGER;
BEGIN
  v_action_id := herbal.ensure_action(p_action_name);
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (p_herb_id, v_action_id, p_upper_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (p_herb_id, v_action_id, p_lower_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
END;
$$ LANGUAGE plpgsql;

DO $$
DECLARE
  v_upper_id INTEGER;
  v_lower_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_upper_id FROM herbal.body_systems WHERE name = 'Upper Respiratory';
  SELECT id INTO v_lower_id FROM herbal.body_systems WHERE name = 'Lower Respiratory';

  -- -------------------------------------------------------------------------
  -- California Spikenard (Aralia californica)
  -- -------------------------------------------------------------------------
  v_herb_id := herbal.ensure_herb('Aralia californica', 'California spikenard');
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Soothing', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Expectorant', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Tonic', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Antimicrobial', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Anti-inflammatory', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Adaptogen', v_upper_id, v_lower_id);

  -- -------------------------------------------------------------------------
  -- Catnip (Nepeta cataria)
  -- -------------------------------------------------------------------------
  v_herb_id := herbal.ensure_herb('Nepeta cataria', 'catnip');
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Carminative', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Antispasmodic', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Nervine Relaxant', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Diaphoretic', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Anticatarrhal', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Astringent', v_upper_id, v_lower_id);

  -- -------------------------------------------------------------------------
  -- Eyebright (Euphrasia officinalis)
  -- -------------------------------------------------------------------------
  v_herb_id := herbal.ensure_herb('Euphrasia officinalis', 'eyebright');
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Anticatarrhal', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Astringent', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Anti-inflammatory', v_upper_id, v_lower_id);

  -- -------------------------------------------------------------------------
  -- Ginkgo (Ginkgo biloba)
  -- -------------------------------------------------------------------------
  v_herb_id := herbal.ensure_herb('Ginkgo biloba', 'ginkgo');
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Anti-inflammatory', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Circulatory Tonic', v_upper_id, v_lower_id);

  -- -------------------------------------------------------------------------
  -- Elderflower (Sambucus spp.)
  -- -------------------------------------------------------------------------
  v_herb_id := herbal.ensure_herb('Sambucus spp.', 'elderflower');
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Anticatarrhal', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Diaphoretic', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Diuretic', v_upper_id, v_lower_id);

  -- -------------------------------------------------------------------------
  -- Wild Cherry Bark (Prunus serotina)
  -- -------------------------------------------------------------------------
  v_herb_id := herbal.ensure_herb('Prunus serotina', 'wild cherry bark');
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Antitussive', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Expectorant', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Astringent', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Nervine Relaxant', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Bitter', v_upper_id, v_lower_id);

  -- -------------------------------------------------------------------------
  -- Coltsfoot (Tussilago farfara)
  -- -------------------------------------------------------------------------
  v_herb_id := herbal.ensure_herb('Tussilago farfara', 'coltsfoot');
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Relaxing Expectorant', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Antitussive', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Demulcent', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Anticatarrhal', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Diuretic', v_upper_id, v_lower_id);

  -- -------------------------------------------------------------------------
  -- Western Coltsfoot (Petasites palmatus)
  -- -------------------------------------------------------------------------
  v_herb_id := herbal.ensure_herb('Petasites palmatus', 'western coltsfoot');
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Relaxing Expectorant', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Antispasmodic', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Nervine Relaxant', v_upper_id, v_lower_id);

  -- -------------------------------------------------------------------------
  -- Grindelia (Grindelia camporum)
  -- -------------------------------------------------------------------------
  v_herb_id := herbal.ensure_herb('Grindelia camporum', 'grindelia');
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Stimulating Expectorant', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Antispasmodic', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Anti-inflammatory', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Diuretic', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Hypotensive', v_upper_id, v_lower_id);

  -- -------------------------------------------------------------------------
  -- Pleurisy Root (Asclepias tuberosa)
  -- -------------------------------------------------------------------------
  v_herb_id := herbal.ensure_herb('Asclepias tuberosa', 'pleurisy root');
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Bitter', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Diaphoretic', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Expectorant', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Pectoral Relaxant', v_upper_id, v_lower_id);

  -- -------------------------------------------------------------------------
  -- Horehound (Marrubium vulgare)
  -- -------------------------------------------------------------------------
  v_herb_id := herbal.ensure_herb('Marrubium vulgare', 'horehound');
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Stimulating Expectorant', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Anti-inflammatory', v_upper_id, v_lower_id);

  -- -------------------------------------------------------------------------
  -- Yerba Santa (Eriodictyon californicum)
  -- -------------------------------------------------------------------------
  v_herb_id := herbal.ensure_herb('Eriodictyon californicum', 'yerba santa');
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Anticatarrhal', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Anti-inflammatory', v_upper_id, v_lower_id);

  -- -------------------------------------------------------------------------
  -- Devil''s Club (Oplopanax horridus)
  -- -------------------------------------------------------------------------
  v_herb_id := herbal.ensure_herb('Oplopanax horridus', 'devil''s club');
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Stimulating Expectorant', v_upper_id, v_lower_id);

  -- -------------------------------------------------------------------------
  -- Thyme (Thymus vulgaris)
  -- -------------------------------------------------------------------------
  v_herb_id := herbal.ensure_herb('Thymus vulgaris', 'thyme');
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Carminative', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Expectorant', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Antimicrobial', v_upper_id, v_lower_id);

  -- -------------------------------------------------------------------------
  -- False Solomon''s Seal (Smilacina racemosa)
  -- -------------------------------------------------------------------------
  v_herb_id := herbal.ensure_herb('Smilacina racemosa', 'false solomon''s seal');
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Relaxing Expectorant', v_upper_id, v_lower_id);
  PERFORM herbal.temp_add_resp_action(v_herb_id, 'Anti-inflammatory', v_upper_id, v_lower_id);

END $$;

-- Clean up temporary helper
DROP FUNCTION IF EXISTS herbal.temp_add_resp_action(INTEGER, TEXT, INTEGER, INTEGER);
-- Remove "Moderate" from secondary_actions — it is a relative strength level,
-- not an herbal action, and was ingested by mistake.

SET search_path TO herbal, public;

DELETE FROM herbal.herb_secondary_actions
WHERE secondary_action_id = (SELECT id FROM herbal.secondary_actions WHERE name = 'Moderate');

DELETE FROM herbal.secondary_actions WHERE name = 'Moderate';
-- Migration 038: Schema changes for Nervous System data
-- 1. Add 'moderate' to strength_level enum
-- 2. Add 'All' body system sentinel for global secondary actions
-- 3. Add body_system_id to herb_secondary_actions

SET search_path TO herbal, public;

-- ============================================================================
-- 1. Add 'moderate' to strength_level enum
-- ============================================================================
ALTER TYPE herbal.strength_level ADD VALUE IF NOT EXISTS 'moderate';

-- ============================================================================
-- 2. Add 'All' body system sentinel
-- ============================================================================
INSERT INTO herbal.body_systems (name) VALUES ('All') ON CONFLICT (name) DO NOTHING;

-- ============================================================================
-- 3. Add body_system_id to herb_secondary_actions
-- ============================================================================
ALTER TABLE herbal.herb_secondary_actions
  ADD COLUMN IF NOT EXISTS body_system_id INTEGER REFERENCES herbal.body_systems(id);

-- Set existing rows to 'All'
UPDATE herbal.herb_secondary_actions
SET body_system_id = (SELECT id FROM herbal.body_systems WHERE name = 'All')
WHERE body_system_id IS NULL;

-- Make NOT NULL now that all rows are populated
ALTER TABLE herbal.herb_secondary_actions
  ALTER COLUMN body_system_id SET NOT NULL;

-- Drop old unique constraint and replace with new one including body_system_id
ALTER TABLE herbal.herb_secondary_actions
  DROP CONSTRAINT IF EXISTS herb_secondary_actions_herb_id_secondary_action_id_key;

ALTER TABLE herbal.herb_secondary_actions
  ADD CONSTRAINT herb_secondary_actions_herb_id_secondary_action_id_body_system_key
  UNIQUE (herb_id, secondary_action_id, body_system_id);

CREATE INDEX IF NOT EXISTS idx_herb_secondary_actions_body_system
  ON herbal.herb_secondary_actions(body_system_id);

-- Migration 039: Nervine secondary actions for the Nervous System
-- Each herb in "Secondary Actions for Nervines" gets:
--   1. herb_primary_actions entry: action=Nervine, body_system=Nervous
--   2. herb_secondary_actions entry: secondary action=Tonic/Relaxant/etc, body_system=Nervous

SET search_path TO herbal, public;

DO $$
DECLARE
  v_nervous_id   INTEGER;
  v_all_id       INTEGER;
  v_nervine_id   INTEGER;
  v_sec_id       INTEGER;
  v_herb_id      INTEGER;
BEGIN
  SELECT id INTO v_nervous_id FROM herbal.body_systems WHERE name = 'Nervous';
  SELECT id INTO v_all_id     FROM herbal.body_systems WHERE name = 'All';

  -- Ensure Nervine primary action exists
  v_nervine_id := herbal.ensure_action('Nervine');

  -- ============================================================
  -- TONIC nervines
  -- ============================================================
  INSERT INTO herbal.secondary_actions (name) VALUES ('Tonic') ON CONFLICT (name) DO NOTHING;
  SELECT id INTO v_sec_id FROM herbal.secondary_actions WHERE name = 'Tonic';

  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Avena sativa', 'oats'),
    herbal.ensure_herb('Hypericum perforatum', 'St. John''s wort'),
    herbal.ensure_herb('Scutellaria lateriflora', 'skullcap')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_nervine_id, v_nervous_id) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
      VALUES (v_herb_id, v_sec_id, v_nervous_id) ON CONFLICT DO NOTHING;
  END LOOP;

  -- ============================================================
  -- RELAXANT nervines
  -- ============================================================
  INSERT INTO herbal.secondary_actions (name) VALUES ('Relaxant') ON CONFLICT (name) DO NOTHING;
  SELECT id INTO v_sec_id FROM herbal.secondary_actions WHERE name = 'Relaxant';

  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Cimicifuga racemosa', 'black cohosh'),
    herbal.ensure_herb('Eschscholzia californica', 'California poppy'),
    herbal.ensure_herb('Humulus lupulus', 'hops'),
    herbal.ensure_herb('Hypericum perforatum', 'St. John''s wort'),
    herbal.ensure_herb('Hyssopus officinalis', 'hyssop'),
    herbal.ensure_herb('Lavandula spp.', 'lavender'),
    herbal.ensure_herb('Leonurus cardiaca', 'motherwort'),
    herbal.ensure_herb('Matricaria recutita', 'chamomile'),
    herbal.ensure_herb('Melissa officinalis', 'lemon balm'),
    herbal.ensure_herb('Nepeta cataria', 'catnip'),
    herbal.ensure_herb('Passiflora incarnata', 'passionflower'),
    herbal.ensure_herb('Piper methysticum', 'kava kava'),
    herbal.ensure_herb('Piscidia erythrina', 'Jamaica dogwood'),
    herbal.ensure_herb('Pulsatilla vulgaris', 'pasqueflower'),
    herbal.ensure_herb('Scutellaria lateriflora', 'skullcap'),
    herbal.ensure_herb('Tilia platyphyllos', 'linden'),
    herbal.ensure_herb('Valeriana officinalis', 'valerian'),
    herbal.ensure_herb('Viscum album', 'mistletoe')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_nervine_id, v_nervous_id) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
      VALUES (v_herb_id, v_sec_id, v_nervous_id) ON CONFLICT DO NOTHING;
  END LOOP;

  -- ============================================================
  -- STIMULANT nervines
  -- ============================================================
  INSERT INTO herbal.secondary_actions (name) VALUES ('Stimulant') ON CONFLICT (name) DO NOTHING;
  SELECT id INTO v_sec_id FROM herbal.secondary_actions WHERE name = 'Stimulant';

  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Cola vera', 'kola nut'),
    herbal.ensure_herb('Coffea arabica', 'coffee'),
    herbal.ensure_herb('Ilex paraguayensis', 'yerba mate'),
    herbal.ensure_herb('Paullinia cupana', 'guarana'),
    herbal.ensure_herb('Rosmarinus officinalis', 'rosemary')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_nervine_id, v_nervous_id) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
      VALUES (v_herb_id, v_sec_id, v_nervous_id) ON CONFLICT DO NOTHING;
  END LOOP;

  -- ============================================================
  -- HYPNOTIC nervines
  -- ============================================================
  INSERT INTO herbal.secondary_actions (name) VALUES ('Hypnotic') ON CONFLICT (name) DO NOTHING;
  SELECT id INTO v_sec_id FROM herbal.secondary_actions WHERE name = 'Hypnotic';

  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Eschscholzia californica', 'California poppy'),
    herbal.ensure_herb('Humulus lupulus', 'hops'),
    herbal.ensure_herb('Lactuca virosa', 'wild lettuce'),
    herbal.ensure_herb('Passiflora incarnata', 'passionflower'),
    herbal.ensure_herb('Piper methysticum', 'kava kava'),
    herbal.ensure_herb('Piscidia erythrina', 'Jamaica dogwood'),
    herbal.ensure_herb('Valeriana officinalis', 'valerian')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_nervine_id, v_nervous_id) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
      VALUES (v_herb_id, v_sec_id, v_nervous_id) ON CONFLICT DO NOTHING;
  END LOOP;

  -- ============================================================
  -- ANTISPASMODIC nervines
  -- ============================================================
  INSERT INTO herbal.secondary_actions (name) VALUES ('Antispasmodic') ON CONFLICT (name) DO NOTHING;
  SELECT id INTO v_sec_id FROM herbal.secondary_actions WHERE name = 'Antispasmodic';

  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Piper methysticum', 'kava kava'),
    herbal.ensure_herb('Scutellaria lateriflora', 'skullcap'),
    herbal.ensure_herb('Valeriana officinalis', 'valerian'),
    herbal.ensure_herb('Viburnum opulus', 'cramp bark'),
    herbal.ensure_herb('Viburnum prunifolium', 'black haw')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_nervine_id, v_nervous_id) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
      VALUES (v_herb_id, v_sec_id, v_nervous_id) ON CONFLICT DO NOTHING;
  END LOOP;

  -- ============================================================
  -- ADAPTOGEN nervines
  -- ============================================================
  INSERT INTO herbal.secondary_actions (name) VALUES ('Adaptogen') ON CONFLICT (name) DO NOTHING;
  SELECT id INTO v_sec_id FROM herbal.secondary_actions WHERE name = 'Adaptogen';

  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Eleutherococcus senticosus', 'Siberian ginseng'),
    herbal.ensure_herb('Lentinus edodes', 'shiitake'),
    herbal.ensure_herb('Panax ginseng', 'Korean ginseng'),
    herbal.ensure_herb('Panax quinquefolius', 'American ginseng'),
    herbal.ensure_herb('Schisandra chinensis', 'schisandra'),
    herbal.ensure_herb('Withania somnifera', 'ashwagandha')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_nervine_id, v_nervous_id) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
      VALUES (v_herb_id, v_sec_id, v_nervous_id) ON CONFLICT DO NOTHING;
  END LOOP;

  -- ============================================================
  -- ANTIDEPRESSANT nervines
  -- ============================================================
  INSERT INTO herbal.secondary_actions (name) VALUES ('Antidepressant') ON CONFLICT (name) DO NOTHING;
  SELECT id INTO v_sec_id FROM herbal.secondary_actions WHERE name = 'Antidepressant';

  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Artemisia vulgaris', 'mugwort'),
    herbal.ensure_herb('Avena sativa', 'oats'),
    herbal.ensure_herb('Hypericum perforatum', 'St. John''s wort'),
    herbal.ensure_herb('Lavandula spp.', 'lavender'),
    herbal.ensure_herb('Turnera diffusa', 'damiana')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_nervine_id, v_nervous_id) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
      VALUES (v_herb_id, v_sec_id, v_nervous_id) ON CONFLICT DO NOTHING;
  END LOOP;

  -- ============================================================
  -- ANALGESIC nervines
  -- ============================================================
  INSERT INTO herbal.secondary_actions (name) VALUES ('Analgesic') ON CONFLICT (name) DO NOTHING;
  SELECT id INTO v_sec_id FROM herbal.secondary_actions WHERE name = 'Analgesic';

  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Dioscorea villosa', 'wild yam'),
    herbal.ensure_herb('Eschscholzia californica', 'California poppy'),
    herbal.ensure_herb('Gelsemium sempervirens', 'yellow jasmine'),
    herbal.ensure_herb('Piscidia erythrina', 'Jamaica dogwood'),
    herbal.ensure_herb('Stachys betonica', 'wood betony'),
    herbal.ensure_herb('Valeriana officinalis', 'valerian')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_nervine_id, v_nervous_id) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
      VALUES (v_herb_id, v_sec_id, v_nervous_id) ON CONFLICT DO NOTHING;
  END LOOP;

END $$;
-- Migration 040: Cross-system nervine data
-- Sources:
--   "Nervines and Body Systems" — nervines that also act on Circulatory/Respiratory/Digestive/Reproductive
--   "Hypnotics and Nervines for Specific Systems" (under Insomnia) — hypnotics for Circulatory/Digestive/Reproductive/Musculoskeletal/Skin
-- Populates herb_primary_actions with the target body system (not Nervous)

SET search_path TO herbal, public;

DO $$
DECLARE
  v_circ_id   INTEGER;
  v_resp_id   INTEGER;
  v_dig_id    INTEGER;
  v_repro_id  INTEGER;
  v_musc_id   INTEGER;
  v_skin_id   INTEGER;
  v_relax_id  INTEGER;
  v_antispas_id INTEGER;
  v_hypnotic_id INTEGER;
  v_herb_id   INTEGER;
BEGIN
  -- Body system IDs (using legacy names from migration 001)
  SELECT id INTO v_circ_id  FROM herbal.body_systems WHERE name = 'Cardiovascular';
  SELECT id INTO v_resp_id  FROM herbal.body_systems WHERE name = 'Respiratory';
  SELECT id INTO v_dig_id   FROM herbal.body_systems WHERE name = 'Digestive';
  SELECT id INTO v_repro_id FROM herbal.body_systems WHERE name = 'Reproductive';
  SELECT id INTO v_musc_id  FROM herbal.body_systems WHERE name = 'Musculoskeletal';
  SELECT id INTO v_skin_id  FROM herbal.body_systems WHERE name = 'Skin';

  v_relax_id    := herbal.ensure_action('Nervine relaxant');
  v_antispas_id := herbal.ensure_action('Antispasmodic');
  v_hypnotic_id := herbal.ensure_action('Hypnotic');

  -- ============================================================
  -- NERVINES AND BODY SYSTEMS — Circulatory
  -- ============================================================
  -- Relaxing
  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Melissa officinalis',   'lemon balm'),
    herbal.ensure_herb('Cimicifuga racemosa',   'black cohosh'),
    herbal.ensure_herb('Viscum album',          'mistletoe'),
    herbal.ensure_herb('Lavandula spp.',        'lavender'),
    herbal.ensure_herb('Tilia platyphyllos',    'linden'),
    herbal.ensure_herb('Leonurus cardiaca',     'motherwort'),
    herbal.ensure_herb('Valeriana officinalis', 'valerian')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_relax_id, v_circ_id) ON CONFLICT DO NOTHING;
  END LOOP;

  -- Antispasmodic
  v_herb_id := herbal.ensure_herb('Viburnum opulus', 'cramp bark');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_antispas_id, v_circ_id) ON CONFLICT DO NOTHING;

  -- ============================================================
  -- NERVINES AND BODY SYSTEMS — Respiratory
  -- ============================================================
  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Grindelia spp.',      'grindelia'),
    herbal.ensure_herb('Lobelia inflata',     'lobelia'),
    herbal.ensure_herb('Prunus serotina',     'wild cherry'),
    herbal.ensure_herb('Lactuca virosa',      'wild lettuce')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_antispas_id, v_resp_id) ON CONFLICT DO NOTHING;
  END LOOP;

  -- ============================================================
  -- NERVINES AND BODY SYSTEMS — Digestive
  -- ============================================================
  -- Relaxing
  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Matricaria recutita',  'chamomile'),
    herbal.ensure_herb('Humulus lupulus',      'hops'),
    herbal.ensure_herb('Melissa officinalis',  'lemon balm'),
    herbal.ensure_herb('Valeriana officinalis','valerian')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_relax_id, v_dig_id) ON CONFLICT DO NOTHING;
  END LOOP;

  -- Antispasmodic
  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Viburnum opulus',     'cramp bark'),
    herbal.ensure_herb('Foeniculum vulgare',  'fennel'),
    herbal.ensure_herb('Mentha piperita',     'peppermint'),
    herbal.ensure_herb('Dioscorea villosa',   'wild yam')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_antispas_id, v_dig_id) ON CONFLICT DO NOTHING;
  END LOOP;

  -- ============================================================
  -- NERVINES AND BODY SYSTEMS — Reproductive
  -- ============================================================
  -- Relaxing
  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Pulsatilla vulgaris',    'pasqueflower'),
    herbal.ensure_herb('Scutellaria lateriflora','skullcap'),
    herbal.ensure_herb('Valeriana officinalis',  'valerian')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_relax_id, v_repro_id) ON CONFLICT DO NOTHING;
  END LOOP;

  -- Antispasmodic
  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Viburnum prunifolium', 'black haw'),
    herbal.ensure_herb('Viburnum opulus',      'cramp bark')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_antispas_id, v_repro_id) ON CONFLICT DO NOTHING;
  END LOOP;

  -- ============================================================
  -- HYPNOTICS AND NERVINES FOR SPECIFIC SYSTEMS (under Insomnia)
  -- ============================================================

  -- Circulatory
  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Leonurus cardiaca',  'motherwort'),
    herbal.ensure_herb('Tilia platyphyllos', 'linden'),
    herbal.ensure_herb('Melissa officinalis','lemon balm')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_hypnotic_id, v_circ_id) ON CONFLICT DO NOTHING;
  END LOOP;

  -- Respiratory
  v_herb_id := herbal.ensure_herb('Lactuca virosa', 'wild lettuce');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_hypnotic_id, v_resp_id) ON CONFLICT DO NOTHING;

  -- Digestive
  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Matricaria recutita',  'chamomile'),
    herbal.ensure_herb('Verbena officinalis',  'vervain'),
    herbal.ensure_herb('Melissa officinalis',  'lemon balm'),
    herbal.ensure_herb('Humulus lupulus',      'hops'),
    herbal.ensure_herb('Valeriana officinalis','valerian'),
    herbal.ensure_herb('Passiflora incarnata', 'passionflower'),
    herbal.ensure_herb('Piscidia erythrina',   'Jamaica dogwood')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_hypnotic_id, v_dig_id) ON CONFLICT DO NOTHING;
  END LOOP;

  -- Reproductive
  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Pulsatilla vulgaris', 'pasqueflower'),
    herbal.ensure_herb('Piscidia erythrina',  'Jamaica dogwood')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_hypnotic_id, v_repro_id) ON CONFLICT DO NOTHING;
  END LOOP;

  -- Musculoskeletal
  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Piscidia erythrina',   'Jamaica dogwood'),
    herbal.ensure_herb('Valeriana officinalis','valerian')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_hypnotic_id, v_musc_id) ON CONFLICT DO NOTHING;
  END LOOP;

  -- Skin
  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Matricaria recutita', 'chamomile'),
    herbal.ensure_herb('Primula veris',       'cowslip')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_hypnotic_id, v_skin_id) ON CONFLICT DO NOTHING;
  END LOOP;

END $$;
-- Migration 041: Hypnotics by Strength
-- Sets relative_strength on herb_primary_actions for Hypnotic action under Nervous system
-- Strength levels: mild, moderate, strong (enum updated in 038)

SET search_path TO herbal, public;

DO $$
DECLARE
  v_nervous_id  INTEGER;
  v_hypnotic_id INTEGER;
  v_herb_id     INTEGER;
BEGIN
  SELECT id INTO v_nervous_id FROM herbal.body_systems WHERE name = 'Nervous';
  v_hypnotic_id := herbal.ensure_action('Hypnotic');

  -- ============================================================
  -- MILD hypnotics
  -- ============================================================
  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Matricaria recutita', 'chamomile'),
    herbal.ensure_herb('Melissa officinalis', 'lemon balm'),
    herbal.ensure_herb('Nepeta cataria',      'catnip'),
    herbal.ensure_herb('Tilia platyphyllos',  'linden'),
    herbal.ensure_herb('Trifolium pratense',  'red clover')
  ]) LOOP
    -- Ensure the herb_primary_actions row exists first
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
      VALUES (v_herb_id, v_hypnotic_id, v_nervous_id, 'mild')
      ON CONFLICT (herb_id, primary_action_id, body_system_id)
      DO UPDATE SET relative_strength = 'mild';
  END LOOP;

  -- ============================================================
  -- MODERATE hypnotics
  -- ============================================================
  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Leonurus cardiaca',    'motherwort'),
    herbal.ensure_herb('Pulsatilla vulgaris',  'pasqueflower'),
    herbal.ensure_herb('Scutellaria lateriflora','skullcap'),
    herbal.ensure_herb('Verbena officinalis',  'vervain')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
      VALUES (v_herb_id, v_hypnotic_id, v_nervous_id, 'moderate')
      ON CONFLICT (herb_id, primary_action_id, body_system_id)
      DO UPDATE SET relative_strength = 'moderate';
  END LOOP;

  -- ============================================================
  -- STRONG hypnotics
  -- ============================================================
  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Eschscholzia californica','California poppy'),
    herbal.ensure_herb('Humulus lupulus',         'hops'),
    herbal.ensure_herb('Lactuca virosa',          'wild lettuce'),
    herbal.ensure_herb('Passiflora incarnata',    'passionflower'),
    herbal.ensure_herb('Piper methysticum',       'kava kava'),
    herbal.ensure_herb('Valeriana officinalis',   'valerian')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
      VALUES (v_herb_id, v_hypnotic_id, v_nervous_id, 'strong')
      ON CONFLICT (herb_id, primary_action_id, body_system_id)
      DO UPDATE SET relative_strength = 'strong';
  END LOOP;

END $$;
-- Migration 042: Nervous system disorders part 1
-- Disorders: Ongoing Stress, Acute Stress, Depression, Insomnia
-- Includes: notes, actions indicated, specific remedies, prescriptions, actions supplied

SET search_path TO herbal, public;

DO $$
DECLARE
  v_nervous_id  INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
  v_herb_id     INTEGER;
  v_ph_id       INTEGER;
  v_action_id   INTEGER;
BEGIN
  SELECT id INTO v_nervous_id FROM herbal.body_systems WHERE name = 'Nervous';

  -- ============================================================
  -- DISORDER: Ongoing Stress
  -- ============================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Ongoing Stress', v_nervous_id, 10)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Ongoing Stress' AND body_system_id = v_nervous_id;

  -- Specific remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES
      (v_disorder_id, herbal.ensure_herb('Eleutherococcus senticosus','Siberian ginseng'), 'Adaptogen', 10),
      (v_disorder_id, herbal.ensure_herb('Panax ginseng','Korean ginseng'),                'Adaptogen', 20),
      (v_disorder_id, herbal.ensure_herb('Withania somnifera','ashwagandha'),              'Adaptogen', 30)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- ============================================================
  -- DISORDER: Acute Stress
  -- ============================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Acute Stress', v_nervous_id, 20)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Acute Stress' AND body_system_id = v_nervous_id;

  -- Specific remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES
      (v_disorder_id, herbal.ensure_herb('Passiflora incarnata','passionflower'), 'Nervine Relaxant', 10),
      (v_disorder_id, herbal.ensure_herb('Valeriana officinalis','valerian'),     'Nervine Relaxant', 20),
      (v_disorder_id, herbal.ensure_herb('Piper methysticum','kava kava'),        'Nervine Relaxant', 30),
      (v_disorder_id, herbal.ensure_herb('Lactuca virosa','wild lettuce'),        'Nervine Relaxant', 40)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription 1: Simple acute stress
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Acute Stress Reactions',
      'Dosage: up to 5 ml of tincture as needed. The stress response is cyclical, and different times of the day will be more challenging for each person. The dosage may be increased until symptoms are relieved, as this is largely symptomatic medication. The dosage regimen may also be altered as necessary, varying time of day and quantity of dose to suit individual needs.',
      10)
    ON CONFLICT DO NOTHING
    RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Scutellaria lateriflora','skullcap');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine tonic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Valeriana officinalis','valerian');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Carminative')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 2: Acute stress with indigestion and palpitations
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Acute Stress Reaction with Indigestion and Palpitations',
      'Dosage: up to 5 ml of tincture as needed. Motherwort (Leonurus cardiaca) supports the relaxing action of the other nervines, but also has a specific calming impact upon tachycardia.',
      20)
    ON CONFLICT DO NOTHING
    RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Scutellaria lateriflora','skullcap');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine tonic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Valeriana officinalis','valerian');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Carminative')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Leonurus cardiaca','motherwort');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Matricaria recutita','chamomile');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Bitter')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Carminative')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Artemisia vulgaris','mugwort');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 50);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Bitter')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Carminative')) ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 3: Acute stress with muscle tension
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Acute Stress Reaction with Associated Muscle Tension',
      'Dosage: up to 5 ml of tincture as needed.',
      30)
    ON CONFLICT DO NOTHING
    RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Scutellaria lateriflora','skullcap');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine tonic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Piper methysticum','kava kava');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 4: Hot chamomile compress
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'Hot Chamomile Compress for Muscle Tension',
      'Hot chamomile compresses work well to relax painful, tense muscles. Prepare a strong infusion, using a full cup of chamomile flowers and 2 quarts of water. Cover with a lid and allow to steep for about 10 minutes; strain. Dip a towel into the infusion, wring it out, and spread it (as hot as is tolerable) on the back, shoulders, and neck. Repeat the procedure 10 to 20 times, until there is a sense of relaxation and relief of tension.',
      40)
    ON CONFLICT DO NOTHING
    RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Matricaria recutita','chamomile');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
      VALUES (v_rx_id, v_herb_id, 'strong infusion', 'topical compress', 10);
  END IF;

  -- ============================================================
  -- DISORDER: Depression
  -- ============================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Depression', v_nervous_id, 30)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Depression' AND body_system_id = v_nervous_id;

  -- Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Depression is either a disorder in its own right or can be a symptom of another disorder, either mental or physical.', 10),
    (v_disorder_id, 'Major depression occurs in 10% to 20% of the world''s population in the course of a lifetime. Women are more often affected than men are, by a 2:1 ratio, and they seem to be at particular risk just before menstruation or immediately after childbirth.', 20),
    (v_disorder_id, 'Depression that is considered a reaction to some loss of or separation from a valued person or object is called reactive or exogenous depression. In contrast, the usually more severe form of depression without apparent cause is called endogenous depression.', 30),
    (v_disorder_id, 'TREATMENT OF DEPRESSION: In terms of the herbal component of treatment protocols for depression, attention to the liver and the digestive system in general is usually a good idea.', 40)
    ON CONFLICT DO NOTHING;

  -- Actions indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Nervine tonic'),     'Fundamental to any long-term change in the individual''s ability to cope and transform what must be changed.', 10),
    (v_disorder_id, herbal.ensure_action('Nervine relaxant'),  'May be indicated in the short term, or if the depression has an agitated or hyperactive aspect. These should not be strong herbs, which could trigger a more entrenched depression.', 20),
    (v_disorder_id, herbal.ensure_action('Bitter'),            'Bitters often bring about dramatic changes in patients'' perceptions of themselves and of their lives.', 30),
    (v_disorder_id, herbal.ensure_action('Antispasmodic'),     'Will alleviate muscular tension that might manifest as a bodily expression of psychological depression. Care should be taken not to use strong relaxants.', 40),
    (v_disorder_id, herbal.ensure_action('Adaptogen'),         'Support the adrenals in coping with the stress that the whole body is experiencing.', 50),
    (v_disorder_id, herbal.ensure_action('Hepatic'),           'Indicated to support the liver''s detoxification work, especially if the patient has been using prescription psychotropic drugs.', 60)
    ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  -- Specific remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, herbal.ensure_herb('Hypericum perforatum','St. John''s wort'),
      'Hypericum perforatum (St. John''s wort) has a long tradition of use. This herb requires time to work, and so must be taken for at least a month.', 10)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription: Moderate Depression
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Moderate Depression',
      'Dosage: up to 5 ml of tincture three times a day for at least 1 month.',
      10)
    ON CONFLICT DO NOTHING
    RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Hypericum perforatum','St. John''s wort');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine tonic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Avena sativa','oats');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine tonic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Artemisia vulgaris','mugwort');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Bitter')) ON CONFLICT DO NOTHING;
  END IF;

  -- ============================================================
  -- DISORDER: Insomnia
  -- ============================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Insomnia', v_nervous_id, 40)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Insomnia' AND body_system_id = v_nervous_id;

  -- Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'While sleeping approximately eight hours a night is vital to physical and mental health, dreaming is necessary for psychological health. Eight hours of sleep a night is the usually cited average, although 7 to 7½ hours is more accurate for most people.', 10),
    (v_disorder_id, 'Insomnia is especially related to conditions that result in pain, shortness of breath, cough, urination, nausea, diarrhea, or other bothersome symptoms that occur at night.', 20),
    (v_disorder_id, 'The key to successful treatment of insomnia is to find the cause and deal with it. Treatment should not depend upon substances, whether herbs or drugs.', 30),
    (v_disorder_id, 'Insomnia and Aromatherapy: Aromatherapy, a healing system based on the external application of herbs in the form of essential oils, has much to offer to those in search of restful sleep.', 40)
    ON CONFLICT DO NOTHING;

  -- Actions indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Hypnotic'),          'Herbs with a reputation for easing a person into sleep. They are usually strong nervine relaxants, rather than "plant knockout drops"!', 10),
    (v_disorder_id, herbal.ensure_action('Nervine relaxant'),  'Ease the tensions that often produce sleeplessness.', 20),
    (v_disorder_id, herbal.ensure_action('Antispasmodic'),     'Address any somatic muscular tightness that might be involved.', 30),
    (v_disorder_id, herbal.ensure_action('Nervine tonic'),     'Indicated if there is any suspicion that insomnia is related to nervous exhaustion (as it often is).', 40),
    (v_disorder_id, herbal.ensure_action('Adaptogen'),         'Will help in a way similar to nervine tonics, but should be used only in the morning to help deal with stress, as they might be too energizing at night.', 50)
    ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  -- Specific remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, herbal.ensure_herb('Leonurus cardiaca','motherwort'),
      'By choosing herbs that address the specific health issues compounding the sleep difficulties, better results are obtained than if one simply chooses a strong hypnotic. If a patient with insomnia also has heart palpitations, Leonurus cardiaca would be a good choice of nervine.', 10)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription 1: Basic insomnia
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id, 'A Prescription for Insomnia', 'Dosage: 5 ml of tincture 30 minutes before bedtime.', 10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Passiflora incarnata','passionflower');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hypnotic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Valeriana officinalis','valerian');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hypnotic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Carminative')) ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 2: Insomnia with menopausal problems
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Insomnia Associated with Menopausal Problems',
      'Dosage: 5 ml of tincture 30 minutes before bedtime, in addition to appropriate daytime treatments.',
      20)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Passiflora incarnata','passionflower');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hypnotic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Valeriana officinalis','valerian');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hypnotic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Carminative')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Leonurus cardiaca','motherwort');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Emmenagogue')) ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 3: Insomnia with indigestion
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Insomnia Associated with Indigestion',
      'Dosage: 7.5 ml of tincture 30 minutes before bedtime, in addition to appropriate daytime treatments. An infusion of Matricaria, Tilia, or Melissa at night may also be helpful.',
      30)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Passiflora incarnata','passionflower');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hypnotic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Valeriana officinalis','valerian');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hypnotic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Carminative')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Artemisia vulgaris','mugwort');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Carminative')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Bitter')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Melissa officinalis','lemon balm');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Carminative')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 4: Insomnia with depression
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Insomnia Associated with Depression',
      'Dosage: 7.5 ml of tincture 30 minutes before bedtime, in addition to appropriate daytime treatments. Note: Avoid the use of Humulus lupulus (hops) in depression.',
      40)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Passiflora incarnata','passionflower');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hypnotic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Valeriana officinalis','valerian');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hypnotic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Hypericum perforatum','St. John''s wort');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antidepressant')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Artemisia vulgaris','mugwort');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antidepressant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Bitter')) ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 5: Relaxing Antidepressant Essential Oil Formula
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'Relaxing Antidepressant Essential Oil Formula',
      'This can be used as either a massage or a bath oil. Lavender is the primary essential oil used to induce sleep. Always dilute oils before applying to skin: 10 to 12 drops per ounce of carrier oil (2% dilution). For baths, add up to 5 drops to warm water.',
      50)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Lavandula spp.','lavender'),         '3 drops oil', 10),
      (v_rx_id, herbal.ensure_herb('Neroli','neroli'),                   '3 drops oil', 20),
      (v_rx_id, herbal.ensure_herb('Salvia sclarea','clary sage'),       '2 drops oil', 30),
      (v_rx_id, herbal.ensure_herb('Origanum marjorana','marjoram'),     '2 drops oil', 40),
      (v_rx_id, herbal.ensure_herb('Cananga odorata','ylang ylang'),     '2 drops oil', 50),
      (v_rx_id, herbal.ensure_herb('Matricaria recutita','chamomile'),   '1 drop oil',  60);
  END IF;

  -- Prescription 6: Fragrant Insomnia Blend (diffuser)
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'Fragrant Insomnia Blend (for diffuser)',
      'Use in a diffuser to promote sleep.',
      60)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Lavandula spp.','lavender'),       '25 drops oil', 10),
      (v_rx_id, herbal.ensure_herb('Citrus sinensis','sweet orange'),  '10 drops oil', 20),
      (v_rx_id, herbal.ensure_herb('Matricaria recutita','chamomile'), '8 drops oil',  30),
      (v_rx_id, herbal.ensure_herb('Origanum marjorana','marjoram'),   '8 drops oil',  40),
      (v_rx_id, herbal.ensure_herb('Cananga odorata','ylang ylang'),   '6 drops oil',  50);
  END IF;

END $$;
-- Migration 043: Nervous system disorders part 2
-- Disorders: Withdrawal from Benzodiazepines, Anorexia Nervosa, Headache

SET search_path TO herbal, public;

DO $$
DECLARE
  v_nervous_id  INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
  v_herb_id     INTEGER;
  v_ph_id       INTEGER;
BEGIN
  SELECT id INTO v_nervous_id FROM herbal.body_systems WHERE name = 'Nervous';

  -- ============================================================
  -- DISORDER: Withdrawal from Benzodiazepines
  -- ============================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Withdrawal from Benzodiazepines', v_nervous_id, 50)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Withdrawal from Benzodiazepines' AND body_system_id = v_nervous_id;

  -- Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
    VALUES (v_disorder_id,
      'All of the commonly prescribed and abused minor tranquilizers, such as Valium and Xanax, can be safely replaced by herbal remedies when used in a broadly holistic context.',
      10)
    ON CONFLICT DO NOTHING;

  -- Actions indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Nervine tonic'),     'Fundamental to any long-term change in the individual''s ability to cope with life and transform what must be changed.', 10),
    (v_disorder_id, herbal.ensure_action('Nervine relaxant'),  'Will fulfill the tranquilizing role of the drug in the short term.', 20),
    (v_disorder_id, herbal.ensure_action('Nervine stimulant'), 'May be indicated in some cases, due to the long-term slowing of mind and body that results from use of these drugs in some people.', 30),
    (v_disorder_id, herbal.ensure_action('Antispasmodic'),     'Alleviate muscular tension that develops in response to withdrawal.', 40),
    (v_disorder_id, herbal.ensure_action('Bitter'),            'Act as safe metabolic stimulants.', 50),
    (v_disorder_id, herbal.ensure_action('Adaptogen'),         'Will support the adrenals through the stressful process the body will undergo.', 60),
    (v_disorder_id, herbal.ensure_action('Hepatic'),           'May be appropriate to support the detoxification process.', 70)
    ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  -- Specific remedies (Primary Relaxing and Tonic Nervines for Withdrawal)
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Avena sativa','oats'),                  'Primary Relaxing and Tonic Nervine for Withdrawal', 10),
    (v_disorder_id, herbal.ensure_herb('Passiflora incarnata','passionflower'), 'Primary Relaxing and Tonic Nervine for Withdrawal', 20),
    (v_disorder_id, herbal.ensure_herb('Scutellaria lateriflora','skullcap'),   'Primary Relaxing and Tonic Nervine for Withdrawal', 30),
    (v_disorder_id, herbal.ensure_herb('Valeriana officinalis','valerian'),     'Primary Relaxing and Tonic Nervine for Withdrawal', 40)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- disorder_action_herbs: "Nervines with Relevant Secondary Actions in Withdrawal"
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Verbena officinalis','vervain'),           herbal.ensure_action('Nervine tonic'),    10),
    (v_disorder_id, herbal.ensure_herb('Verbena officinalis','vervain'),           herbal.ensure_action('Hepatic'),          20),
    (v_disorder_id, herbal.ensure_herb('Artemisia vulgaris','mugwort'),            herbal.ensure_action('Antidepressant'),   30),
    (v_disorder_id, herbal.ensure_herb('Artemisia vulgaris','mugwort'),            herbal.ensure_action('Bitter'),           40),
    (v_disorder_id, herbal.ensure_herb('Eleutherococcus senticosus','Siberian ginseng'), herbal.ensure_action('Adaptogen'), 50),
    (v_disorder_id, herbal.ensure_herb('Hypericum perforatum','St. John''s wort'),herbal.ensure_action('Antidepressant'),   60),
    (v_disorder_id, herbal.ensure_herb('Silybum marianum','milk thistle'),         herbal.ensure_action('Antihepatotoxic'), 70)
    ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription to Help with Benzodiazepine Withdrawal',
      'Dosage: 2.5 ml to 5 ml of tincture three times a day.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Avena sativa','oats');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine tonic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Scutellaria lateriflora','skullcap');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine tonic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Valeriana officinalis','valerian');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Leonurus cardiaca','motherwort');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Eleutherococcus senticosus','Siberian ginseng');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 50);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Adaptogen')) ON CONFLICT DO NOTHING;
  END IF;

  -- ============================================================
  -- DISORDER: Anorexia Nervosa
  -- ============================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Anorexia Nervosa', v_nervous_id, 60)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Anorexia Nervosa' AND body_system_id = v_nervous_id;

  -- Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Anorexia nervosa is a problem typified by self-starvation.', 10),
    (v_disorder_id, 'In general, the patient will sleep poorly but, despite weight loss, will remain physically active, believing herself to be much fatter than she actually is. These symptoms suggest that anorexia nervosa may be associated with a disorder of the hypothalamus, a region of the brain that regulates menstruation, eating, body temperature, and sleep.', 20)
    ON CONFLICT DO NOTHING;

  -- Actions indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Bitter'),           'Indicated because they stimulate both appetite and general metabolism.', 10),
    (v_disorder_id, herbal.ensure_action('Nervine tonic'),    'Fundamental to any long-term change in the individual''s ability to cope with life and transform what must be changed.', 20),
    (v_disorder_id, herbal.ensure_action('Nervine relaxant'), 'Will alleviate associated anxiety.', 30),
    (v_disorder_id, herbal.ensure_action('Hepatic'),          'Will support the detoxification process and generally benefit the body.', 40)
    ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  -- Specific remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, herbal.ensure_herb('Verbena officinalis','vervain'),
      'Bitters are considered specifics here, but especially Verbena officinalis (vervain), a relaxing nervine with marked hepatic properties.', 10)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Anorexia Nervosa',
      'Dosage: 5 ml of tincture 10 to 15 minutes before eating, three times a day.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Gentiana lutea','gentian');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Bitter')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hepatic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Avena sativa','oats');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine tonic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Hypericum perforatum','St. John''s wort');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine tonic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Verbena officinalis','vervain');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine tonic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hepatic')) ON CONFLICT DO NOTHING;
  END IF;

  -- ============================================================
  -- DISORDER: Headache
  -- ============================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Headache', v_nervous_id, 70)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Headache' AND body_system_id = v_nervous_id;

  -- Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'For most headaches, even when the pain is severe, no underlying disease exists. Most headaches are caused by fatigue, emotional disorders, or allergies.', 10),
    (v_disorder_id, 'Headache pain results from the stimulation of pain-sensitive structures such as the meninges and the nerves of the cranium and upper neck — produced by inflammation, dilation of blood vessels in the head, or muscle spasms.', 20),
    (v_disorder_id, 'Headaches brought on by muscle spasms are classified as tension headaches. Those caused by dilation of blood vessels are called vascular headaches.', 30)
    ON CONFLICT DO NOTHING;

  -- Specific remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Artemisia absinthium','wormwood'),    'Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.', 10),
    (v_disorder_id, herbal.ensure_herb('Capsicum annuum','cayenne'),          'Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.', 20),
    (v_disorder_id, herbal.ensure_herb('Lavandula spp.','lavender'),          'Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.', 30),
    (v_disorder_id, herbal.ensure_herb('Matricaria recutita','chamomile'),    'Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.', 40),
    (v_disorder_id, herbal.ensure_herb('Melissa officinalis','lemon balm'),   'Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.', 50),
    (v_disorder_id, herbal.ensure_herb('Mentha piperita','peppermint'),       'Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.', 60),
    (v_disorder_id, herbal.ensure_herb('Origanum marjorana','marjoram'),      'Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.', 70),
    (v_disorder_id, herbal.ensure_herb('Piscidia erythrina','Jamaica dogwood'),'Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.', 80),
    (v_disorder_id, herbal.ensure_herb('Rosmarinus officinalis','rosemary'),  'Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.', 90),
    (v_disorder_id, herbal.ensure_herb('Ruta graveolens','rue'),              'Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.', 100),
    (v_disorder_id, herbal.ensure_herb('Sambucus nigra','elder'),             'Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.', 110),
    (v_disorder_id, herbal.ensure_herb('Scutellaria lateriflora','skullcap'), 'Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.', 120),
    (v_disorder_id, herbal.ensure_herb('Stachys betonica','wood betony'),     'Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.', 130),
    (v_disorder_id, herbal.ensure_herb('Thymus vulgaris','thyme'),            'Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.', 140),
    (v_disorder_id, herbal.ensure_herb('Valeriana officinalis','valerian'),   'Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.', 150)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription 1: Essential Oils for Headache
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'Essential Oils for Headache',
      'Many essential oils can be used to relieve headache. Particularly effective oils include Lavandula spp., Rosmarinus officinalis, and Mentha piperita, which can be used separately or in combination. Lavandula may be rubbed on the temples or made into a cold compress. Equal parts of Lavandula and Mentha piperita may be even more effective. If headache is caused by catarrh or sinus infection, inhalations will be very effective.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Lavandula spp.','lavender'),      'essential oil', 10),
      (v_rx_id, herbal.ensure_herb('Rosmarinus officinalis','rosemary'), 'essential oil', 20),
      (v_rx_id, herbal.ensure_herb('Mentha piperita','peppermint'),   'essential oil', 30);
  END IF;

  -- Prescription 2: Supportive Nervines for Tension Headaches (list)
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'Supportive Nervines for Tension Headaches',
      'A daily supplement of B-complex vitamins and vitamin C is also helpful. Relaxation exercises are invaluable, and the impact of various stressors should be softened.',
      20)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Artemisia vulgaris','mugwort'),      'as needed', 10),
      (v_rx_id, herbal.ensure_herb('Avena sativa','oats'),               'as needed', 20),
      (v_rx_id, herbal.ensure_herb('Matricaria recutita','chamomile'),   'as needed', 30),
      (v_rx_id, herbal.ensure_herb('Melissa officinalis','lemon balm'),  'as needed', 40),
      (v_rx_id, herbal.ensure_herb('Piper methysticum','kava kava'),     'as needed', 50),
      (v_rx_id, herbal.ensure_herb('Scutellaria lateriflora','skullcap'),'as needed', 60),
      (v_rx_id, herbal.ensure_herb('Tilia platyphyllos','linden'),       'as needed', 70),
      (v_rx_id, herbal.ensure_herb('Verbena officinalis','vervain'),     'as needed', 80);
  END IF;

  -- Prescription 3: Tension-Related Headaches tincture
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Tension-Related Headaches',
      'Dosage: 2.5 ml of tincture combination three times a day. If using dried herbs, infuse 2 teaspoons of the mixture in 1 cup of boiling water, drunk three times a day.',
      30)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Scutellaria lateriflora','skullcap');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 10);

    v_herb_id := herbal.ensure_herb('Valeriana officinalis','valerian');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 20);

    v_herb_id := herbal.ensure_herb('Avena sativa','oats');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
  END IF;

  -- Prescription 4: Tension Headache with Indigestion and Palpitations
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Tension Headache with Indigestion and Palpitations',
      'Dosage: 5 ml of tincture mixture three times a day. If using dried herbs, infuse 2 teaspoons of mixture to 1 cup of boiling water, drunk three times a day.',
      40)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Scutellaria lateriflora','skullcap'),  '2 parts', 10),
      (v_rx_id, herbal.ensure_herb('Valeriana officinalis','valerian'),    '2 parts', 20),
      (v_rx_id, herbal.ensure_herb('Leonurus cardiaca','motherwort'),      '1 part',  30),
      (v_rx_id, herbal.ensure_herb('Matricaria recutita','chamomile'),     '1 part',  40),
      (v_rx_id, herbal.ensure_herb('Artemisia vulgaris','mugwort'),        '1 part',  50);
  END IF;

  -- Prescription 5: Essential Oil Formula for Headache Relief
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'Essential Oil Formula for Headache Relief',
      'Use as a massage or bath oil to relieve headache.',
      50)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Lavandula spp.','lavender'),       '3 drops oil', 10),
      (v_rx_id, herbal.ensure_herb('Neroli','neroli'),                 '3 drops oil', 20),
      (v_rx_id, herbal.ensure_herb('Origanum marjorana','marjoram'),   '2 drops oil', 30),
      (v_rx_id, herbal.ensure_herb('Cananga odorata','ylang ylang'),   '2 drops oil', 40),
      (v_rx_id, herbal.ensure_herb('Matricaria recutita','chamomile'), '1 drop oil',  50),
      (v_rx_id, herbal.ensure_herb('Salvia sclarea','clary sage'),     '1 drop oil',  60);
  END IF;

END $$;
-- Migration 044: Nervous system disorders part 3
-- Disorders: Migraine, Neuritis, Tinnitus, Motion Sickness, Shingles

SET search_path TO herbal, public;

DO $$
DECLARE
  v_nervous_id  INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
  v_herb_id     INTEGER;
  v_ph_id       INTEGER;
BEGIN
  SELECT id INTO v_nervous_id FROM herbal.body_systems WHERE name = 'Nervous';

  -- ============================================================
  -- DISORDER: Migraine
  -- ============================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Migraine', v_nervous_id, 80)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Migraine' AND body_system_id = v_nervous_id;

  -- Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Orthodox medicine considers the underlying cause of migraine to be unknown. Common migraine may affect as many as 25% of Americans.', 10),
    (v_disorder_id, 'The immediate cause appears to relate to spasms in the muscular walls of the blood vessels of the brain and scalp. In approximately 15% of all cases, migraine attacks are preceded by warning signs known as auras.', 20),
    (v_disorder_id, 'Triggers don''t actually cause the pain; rather, they activate an already existing chemical mechanism in the brain. The more triggers present at any given time, the more likely that a headache will follow.', 30)
    ON CONFLICT DO NOTHING;

  -- Specific remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, herbal.ensure_herb('Tanacetum parthenium','feverfew'),
      'The most important herb for migraine prevention. Feverfew is a long-term treatment, not an immediate cure for a migraine attack.', 10)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription 1: Prevention of Migraines
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for the Prevention of Migraines',
      'Tanacetum parthenium: 125 mg of dried herb taken once daily. Lavandula officinalis: massage essential oil into temples at first sign of an attack.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Tanacetum parthenium','feverfew'),         '125 mg dried herb daily', 10),
      (v_rx_id, herbal.ensure_herb('Lavandula officinalis','lavender'),        'massage essential oil', 20);
  END IF;

  -- Prescription 2: Migraine with Stress and Hypertension
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Migraine Associated with Stress and Hypertension',
      'Dosage: 2.5 ml of tincture three times a day. In addition, the patient should follow instructions given in Prescription for Prevention of Migraine.',
      20)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Crataegus spp.','hawthorn'),           '1 part', 10),
      (v_rx_id, herbal.ensure_herb('Tilia platyphyllos','linden'),         '1 part', 20),
      (v_rx_id, herbal.ensure_herb('Stachys betonica','wood betony'),      '1 part', 30),
      (v_rx_id, herbal.ensure_herb('Scutellaria lateriflora','skullcap'),  '1 part', 40),
      (v_rx_id, herbal.ensure_herb('Viburnum opulus','cramp bark'),        '1 part', 50);
  END IF;

  -- Prescription 3: Cooling Compress for Migraine
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Cooling Compress for Migraine',
      'Pour 1 quart ice-cold water into a 2-quart glass bowl and add the essential oils. Soak a clean cloth in the water and apply it to the head, forehead, or neck at the first sign of a migraine. Do not allow the compress to come into contact with the eyes. An ice pack applied over the compress will help keep it from getting warm.',
      30)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Mentha piperita','peppermint'), '2 drops essential oil', 10),
      (v_rx_id, herbal.ensure_herb('Zingiber officinale','ginger'), '1 drop essential oil',  20),
      (v_rx_id, herbal.ensure_herb('Origanum marjorana','marjoram'),'1 drop essential oil',  30);
  END IF;

  -- ============================================================
  -- DISORDER: Neuritis
  -- ============================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Neuritis', v_nervous_id, 90)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Neuritis' AND body_system_id = v_nervous_id;

  -- Actions indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Nervine tonic'),    'Important to nourish the traumatized nerve tissue.', 10),
    (v_disorder_id, herbal.ensure_action('Nervine relaxant'), 'Ease associated pain and anxiety.', 20),
    (v_disorder_id, herbal.ensure_action('Anti-inflammatory'),'Reduce the inflammatory response.', 30),
    (v_disorder_id, herbal.ensure_action('Antispasmodic'),    'Help alleviate any muscular tension developed in response to the discomfort.', 40),
    (v_disorder_id, herbal.ensure_action('Adaptogen'),        'Support the body''s efforts to cope with the stress of the pain and any stress-related causes.', 50)
    ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  -- Prescription 1: Internal Use
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Neuritis — Internal Use',
      'Dosage: 5 ml of tincture three times a day.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Hypericum perforatum','St. John''s wort');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine tonic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Scutellaria lateriflora','skullcap');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine tonic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Avena sativa','oats');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine tonic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Eleutherococcus senticosus','Siberian ginseng');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Adaptogen')) ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 2: External Use
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Neuritis — External Use',
      'Three approaches to minimizing discomfort caused by touch. Gently applying menthol-rich peppermint oil produces a cooling, locally anesthetic effect. Applying infused oil of Hypericum will reduce neurological inflammation. Colloidal oatmeal can act as a dry lubricant between the skin and clothing, minimizing irritation.',
      20)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Mentha piperita','peppermint'),         'essential oil', 'or any menthol-rich mint oil', 10),
      (v_rx_id, herbal.ensure_herb('Hypericum perforatum','St. John''s wort'),'infused oil', 'topical application', 20),
      (v_rx_id, herbal.ensure_herb('Avena sativa','oats'),                  'colloidal oatmeal', 'dry lubricant on skin', 30);
  END IF;

  -- Prescription 3: Essential Oils for Pain (massage)
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'Essential Oils for Pain',
      'Combine ingredients and use for massage.',
      30)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Helichrysum italicum','helichrysum'),   '5 drops', 10),
      (v_rx_id, herbal.ensure_herb('Matricaria recutita','chamomile'),      '3 drops', 20),
      (v_rx_id, herbal.ensure_herb('Origanum marjorana','marjoram'),        '2 drops', 30),
      (v_rx_id, herbal.ensure_herb('Lavandula spp.','lavender'),            '2 drops', 40);
  END IF;

  -- ============================================================
  -- DISORDER: Tinnitus
  -- ============================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Tinnitus', v_nervous_id, 100)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Tinnitus' AND body_system_id = v_nervous_id;

  -- Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'One person out of 10 has some type of hearing impairment or ear problem, and 85% of these have some associated tinnitus.', 10),
    (v_disorder_id, 'Hypericum perforatum is the main herb to consider here for tinnitus associated with depression. Ginkgo biloba may help improve problems of the inner ear that result from a disturbance in blood supply.', 20)
    ON CONFLICT DO NOTHING;

  -- Specific remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Cimicifuga racemosa','black cohosh'),    'Specific remedy for tinnitus, particularly noise-induced tinnitus.', 10),
    (v_disorder_id, herbal.ensure_herb('Hydrastis canadensis','goldenseal'),     'Specific remedy for tinnitus.', 20),
    (v_disorder_id, herbal.ensure_herb('Ginkgo biloba','ginkgo'),                'May help improve inner ear problems resulting from disturbance in blood supply.', 30)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Tinnitus',
      'Dosage: up to 5 ml of tincture three times a day.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Cimicifuga racemosa','black cohosh'), '1 part', 10),
      (v_rx_id, herbal.ensure_herb('Hydrastis canadensis','goldenseal'),  '1 part', 20),
      (v_rx_id, herbal.ensure_herb('Ginkgo biloba','ginkgo'),             '1 part', 30);
  END IF;

  -- ============================================================
  -- DISORDER: Motion Sickness
  -- ============================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Motion Sickness', v_nervous_id, 110)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Motion Sickness' AND body_system_id = v_nervous_id;

  -- Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Zingiber officinale (ginger) can usually be relied upon. Research published in The Lancet showed it to be more effective than Dramamine in preventing symptoms of motion sickness. Ginger may be drunk as a fresh infusion, eaten as candied ginger, or taken as capsules of the powder (usual dosage: 2 to 4 capsules as needed).', 10),
    (v_disorder_id, 'Ballota nigra (black horehound) will also reduce this kind of nausea. One of the more effective allopathic treatments involves a dermal patch of scopolamine, a constituent of Atropa belladonna.', 20)
    ON CONFLICT DO NOTHING;

  -- Specific remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Zingiber officinale','ginger'),        'Primary specific for motion sickness — more effective than Dramamine per Lancet research.', 10),
    (v_disorder_id, herbal.ensure_herb('Ballota nigra','black horehound'),     'Also reduces nausea from motion sickness.', 20)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Motion Sickness',
      'Dosage: 5 ml of tincture 20 minutes before travel. In addition, the patient should eat a small piece of candied ginger just before travel and as needed.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Ballota nigra','black horehound'), '1 part', 10),
      (v_rx_id, herbal.ensure_herb('Mentha piperita','peppermint'),    '1 part', 20);
  END IF;

  -- ============================================================
  -- DISORDER: Shingles
  -- ============================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Shingles', v_nervous_id, 120)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Shingles' AND body_system_id = v_nervous_id;

  -- Actions indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Nervine tonic'),    'Will nourish traumatized nerve tissue.', 10),
    (v_disorder_id, herbal.ensure_action('Nervine relaxant'), 'May help ease the associated pain and will definitely lessen associated anxiety or tension.', 20),
    (v_disorder_id, herbal.ensure_action('Anti-inflammatory'),'Will reduce the inflammatory response.', 30),
    (v_disorder_id, herbal.ensure_action('Antispasmodic'),    'Will alleviate muscular tension developed in response to pain.', 40),
    (v_disorder_id, herbal.ensure_action('Antimicrobial'),    'May help deal with the virus infection, but it is very intransigent.', 50)
    ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Shingles',
      'Dosage: up to 5 ml of tincture four times a day. Topical application of Mentha piperita oil may reduce pain through a mild, local numbing effect (do not use if skin is extremely sensitive). Colloidal oatmeal powder may be dusted on affected skin to minimize pain caused by contact with clothes.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Avena sativa','oats');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine tonic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Hypericum perforatum','St. John''s wort');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine tonic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antimicrobial')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Echinacea spp.','echinacea');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Immune support')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Scutellaria lateriflora','skullcap');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
  END IF;

END $$;
-- Migration 045: Sync Nervous system herbs to herb_primary_actions
-- Pulls all herbs from disorder_action_herbs and prescription_herb_actions
-- for Nervous system disorders and ensures they appear in herb_primary_actions
-- under the Nervous body system with the correct action.

SET search_path TO herbal, public;

DO $$
DECLARE
  v_nervous_id INTEGER;
BEGIN
  SELECT id INTO v_nervous_id FROM herbal.body_systems WHERE name = 'Nervous';

  -- Sync from disorder_action_herbs for all Nervous system disorders
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT DISTINCT
    dah.herb_id,
    dah.primary_action_id,
    v_nervous_id
  FROM herbal.disorder_action_herbs dah
  JOIN herbal.disorders d ON d.id = dah.disorder_id
  WHERE d.body_system_id = v_nervous_id
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Sync from prescription_herb_actions via prescription_herbs → prescriptions → disorders
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT DISTINCT
    ph.herb_id,
    pha.primary_action_id,
    v_nervous_id
  FROM herbal.prescription_herb_actions pha
  JOIN herbal.prescription_herbs ph ON ph.id = pha.prescription_herb_id
  JOIN herbal.disorder_prescriptions dp ON dp.id = ph.prescription_id
  JOIN herbal.disorders d ON d.id = dp.disorder_id
  WHERE d.body_system_id = v_nervous_id
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

END $$;

-- Summary report
SELECT
  pa.name AS action,
  COUNT(DISTINCT hpa.herb_id) AS herb_count
FROM herbal.herb_primary_actions hpa
JOIN herbal.primary_actions pa ON pa.id = hpa.primary_action_id
JOIN herbal.body_systems bs ON bs.id = hpa.body_system_id
WHERE bs.name = 'Nervous'
GROUP BY pa.name
ORDER BY herb_count DESC, pa.name;
