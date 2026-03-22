-- Populate action descriptions from Herbal Actions CSV data
SET search_path TO herbal, public;

-- Clear existing action descriptions
DELETE FROM herbal.action_descriptions;

-- Adaptogens descriptions (ID 1)
INSERT INTO herbal.action_descriptions (primary_action_id, description, sort_order) VALUES
(1, 'Helps the body adapt to stress', 1),
(1, 'virtually non-toxic at high doses', 2),
(1, 'non-specific action throughout the body', 3),
(1, 'H-P-A axis = Hypothalamic Pituitary Adrenal - communication system involved in the stress response', 4),
(1, 'adaptogens help regulate this hormonal cascade', 5),
(1, 'non-specific state of resistance to stress: environmental, psych or physio', 6),
(1, 'helping the body adapt to and defend against the effects of environmental stress.', 7),
(1, 'The general aims of treatment with this action are to reduce stress reactions during the alarm phase of the stress response and to prevent or at least delay the state of exhaustion,', 8),
(1, 'smooth out the associated highs and lows. This conserves energy in the alarm phase for use in the resistance phase.', 9);

-- Alteratives descriptions (ID 2)
INSERT INTO herbal.action_descriptions (primary_action_id, description, sort_order) VALUES
(2, 'alter the body from unhealthy to healthy via the body channels of elimination', 1),
(2, 'bowel, kidney, skin, liver', 2),
(2, 'aid in detoxification', 3),
(2, 'used to be called "blood cleanser"', 4),
(2, 'gradually restore proper function to the body and increase overall health and vitality.', 5),
(2, 'seem to alter the body''s metabolic processes to improve tissues'' ability to deal with a range of body functions, from nutrition to elimination.', 6),
(2, 'should be considered first for cases of chronic inflammatory and degenerative diseases', 7),
(2, 'Skin is the body system for which these are often used', 8);

-- Anti-inflammatory descriptions (ID 4)
INSERT INTO herbal.action_descriptions (primary_action_id, description, sort_order) VALUES
(4, 'reduces inflammation from sprains, strains, headaches, wounds or chronic internal conditions', 1),
(4, 'promote healthy inflammation, regulate it to turn on and turn off', 2),
(4, 'work well with musculoskeletal discomfort', 3),
(4, 'help the body combat inflammation', 4);

-- Anticatarrhal descriptions (ID 3)
INSERT INTO herbal.action_descriptions (primary_action_id, description, sort_order) VALUES
(3, 'thin the mucus secretions and reduce congestion', 1),
(3, 'can be used for lungs, although aren''t as effective in loosening deep-seated mucus as the more stimulating expectorant', 2),
(3, 'help the body remove excess mucus, whether in the sinuses or in other parts of the body. They are used mainly for ear, nose, and throat infections,', 3),
(3, 'Some of this action remedies work by producing a less viscous mucus secretion that is easier for the body to remove. Others reduce mucus secretion directly.', 4);

-- Antimicrobial descriptions (ID 5)
INSERT INTO herbal.action_descriptions (primary_action_id, description, sort_order) VALUES
(5, 'disinfectants, used both internally and externally to prevent or cure infections', 1),
(5, 'a lot of cooking herbs - sage, oregano', 2),
(5, 'a sage-y smell usually indicates this action', 3),
(5, 'usually can be used both topically and internally', 4),
(5, 'help the body destroy or resist pathogenic microorganisms in some way', 5),
(5, 'we are talking about plants that support the immune process, augmenting the integrity of the individual''s own defense system', 6);

-- Antispasmodic descriptions (ID 7)
INSERT INTO herbal.action_descriptions (primary_action_id, description, sort_order) VALUES
(7, 'special kind of muscle relaxants', 1),
(7, 'help ease spasms and cramps and also very helpful in gently relaxing body extremities', 2),
(7, 'useful for variety of conditions: anxiety, nervousness, to hypertension, cold hands and feet', 3),
(7, 'prevent or ease spasms or cramps in the muscles. They thus reduce muscular tension in the body,', 4),
(7, 'facilitate physical relaxation of muscles without necessarily causing a sedative effect.', 5),
(7, 'the action that affects the peripheral nerves and the muscle tissue - may have an indirect relaxing action on the whole system.', 6);

-- Astringent descriptions (ID 8)
INSERT INTO herbal.action_descriptions (primary_action_id, description, sort_order) VALUES
(8, 'tone and tighten tissues', 1),
(8, 'tannin rich herbs', 2),
(8, 'pulling or drawing effect', 3),
(8, 'drying', 4),
(8, 'most barks have this property', 5),
(8, 'tightening of the tissue', 6),
(8, 'sometimes called styptics when applied externally to stop bleeding, or anti-hemorrhagics when used for internal bleeding.', 7),
(8, 'produce a kind of temporary leather coat on the surface of tissue.', 8),
(8, 'Reduce irritation on the surface of tissues through a sort of numbing action', 9),
(8, 'Reduce surface inflammation', 10),
(8, 'Create a barrier against infection, great help with wounds and burns', 11),
(8, 'of great importance in round healing and conditions affecting the digestive system.', 12);

-- Bitter descriptions (ID 9)
INSERT INTO herbal.action_descriptions (primary_action_id, description, sort_order) VALUES
(9, 'Stimulate appetite.', 1),
(9, 'Stimulate release of digestive juices from the pancreas, duodenum, and and liver', 2),
(9, 'Aid the liver in detoxification work and increase the flow of bile', 3),
(9, 'Help regulate secretion of pancreatic hormones that regulate blood sugar, insulin, and glucagon', 4),
(9, 'Help the gut wall repair damage by stimulating self-repair mechanisms.', 5);

-- Cardiotonic descriptions (ID 10)
INSERT INTO herbal.action_descriptions (primary_action_id, description, sort_order) VALUES
(10, 'special affinity for the heart, regulating its beat, moderating hypertension, and usually tone the heart', 1),
(10, 'general category for herbal remedies that have some kind of action on the heart.', 2);

-- Carminative descriptions (ID 11)
INSERT INTO herbal.action_descriptions (primary_action_id, description, sort_order) VALUES
(11, 'clear "wind" and gas/bloating in the body', 1),
(11, 'move energy in the body downward if scattered thoughts as well!', 2),
(11, 'rich in volatile oils', 3),
(11, 'ease discomfort caused by flatulence.', 4);

-- Cholagogue descriptions (ID 12)
INSERT INTO herbal.action_descriptions (primary_action_id, description, sort_order) VALUES
(12, 'greek meaning bile, and as such has a cleaning and stimulating effect on the liver and gallbladder, allowing from the release of more bile', 1),
(12, 'helpful in aiding digestion, esp in the lower intestinal tract', 2),
(12, 'have the specific effect of stimulating the flow of bile from the liver.', 3),
(12, 'quite specific in that they act on the liver.', 4),
(12, 'indicated for disorders caused by insufficient or congested bile, such as intractable biliary constipation, jaundice, and mild hepatitis.', 5),
(12, 'contraindicated for painful gallstones, Increased contractile activity could further constrict the bile duct, leading to incredibly intense', 6),
(12, 'Because they help with assimilation, these have an enlivening "side effect" in the nervous system. These remedies may actively ease debility and', 7);

-- Demulcent descriptions (ID 13)
INSERT INTO herbal.action_descriptions (primary_action_id, description, sort_order) VALUES
(13, 'soothing herbs rich in mucilage', 1),
(13, 'helps to heal mucosal barrier', 2),
(13, 'indication for gastric irritation, ulcers', 3),
(13, 'if someone is already damp, contraindication for this', 4),
(13, 'herbs with this action often have an apparently anti-inflammatory effect, but this is related to their ability to soothe inflamed surfaces, not to reductions in the cellular inflammatory response.', 5),
(13, 'rich in mucilage and can soothe and protect irritated or inflamed internal tissue. When used topically on the skin, these are called emollients.', 6),
(13, 'become slimy and gummy when they come in contact with water:', 7),
(13, 'Reduce irritation down the whole length of the bowel.', 8),
(13, 'Lessen the sensitivity of the digestive system to gastric acids and to digestive bitters', 9);

-- Diuretic descriptions (ID 14)
INSERT INTO herbal.action_descriptions (primary_action_id, description, sort_order) VALUES
(14, 'gently promote elimination of water through the kidneys, as urine', 1),
(14, 'help the body rid itself of exces fluids by increasing the kidneys'' rate of urine production.', 2),
(14, 'Causes more blood to pass through the kidneys, which produces more urine', 3),
(14, 'Because of their cleansing actions, many of these help with problems of muscles and bones', 4);

-- Emmenagogue descriptions (ID 15)
INSERT INTO herbal.action_descriptions (primary_action_id, description, sort_order) VALUES
(15, 'promote menstruation usually by slightly irritating the uterine lining', 1),
(15, 'severely contraindicated during pregnancy', 2),
(15, 'remedies that stimulate menstrual flow and activity', 3);

-- Hepatic descriptions (ID 19)
INSERT INTO herbal.action_descriptions (primary_action_id, description, sort_order) VALUES
(19, 'herbal remedies that aid the work of the liver in a range of ways.', 1),
(19, 'Bitters and cholagogues all act as this action, but so do a whole array of other remedies that do not have those specific actions.', 2);

-- Hypnotic descriptions (ID 20)
INSERT INTO herbal.action_descriptions (primary_action_id, description, sort_order) VALUES
(20, 'trance-inducing, a little more than simple sedatives', 1),
(20, 'can be very relaxing , useful in sleep conditions, headaches, tension, and for addiction recovery', 2),
(20, 'don''t used with sedative medication already', 3),
(20, 'most are also hypotensives - lower blood pressure', 4),
(20, 'nervine remedies that help induce a deep and healing state of sleep.', 5),
(20, 'should always be used within the context of a holistic approach to sleep problems', 6);

-- Hypotensive descriptions (ID 21)
INSERT INTO herbal.action_descriptions (primary_action_id, description, sort_order) VALUES
(21, 'lower blood pressure by acting either on the heart, arteries, capillaries, or the water balance in the body', 1),
(21, 'use semi-preventatively, when the blood pressure starts to creep up, not in acute conditions', 2),
(21, 'reduce elevated blood pressure, tending to normalize both systolic and diastolic pressure.', 3);

-- Nervine Relaxants descriptions (ID 23)
INSERT INTO herbal.action_descriptions (primary_action_id, description, sort_order) VALUES
(23, 'most important in times of stress and confusion, as they can alleviate many of the accompanying symptoms.', 1),
(23, 'the best remedies for the "inflamed state of mind"', 2);

-- Nervine Stimulant descriptions (ID 24)
INSERT INTO herbal.action_descriptions (primary_action_id, description, sort_order) VALUES
(24, 'an action that quickens and enlivens the physiological activity of the body.', 1);

-- Relaxing Expectorant descriptions (ID 17)
INSERT INTO herbal.action_descriptions (primary_action_id, description, sort_order) VALUES
(17, 'seem also to act by reflex, but here the reflex action works to soothe bronchial spasm and loosen mucus secretions.', 1),
(17, 'help to produce a thinner mucus that is easier to expel, allowing the more viscous mucus to move and thus be eliminated.', 2),
(17, 'useful for dry, irritating coughs.', 3),
(17, 'This action is similar in some respects to that of demulcents, and both actions owe much to their content of mucilage and, occasionally, volatile oils.', 4);

-- Stimulating Expectorant descriptions (ID 16)
INSERT INTO herbal.action_descriptions (primary_action_id, description, sort_order) VALUES
(16, 'Irritate the bronchioles to stimulate expulsion of any material present', 1),
(16, 'Liquefy viscid sputum so that it can be cleared by coughing.', 2);

