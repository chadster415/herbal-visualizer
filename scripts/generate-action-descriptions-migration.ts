import { createClient } from '@supabase/supabase-js';
import * as fs from 'fs';
import * as path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const supabaseUrl = process.env.SUPABASE_URL || 'http://127.0.0.1:54321';
const supabaseKey = process.env.SUPABASE_KEY || 'sb_secret_N7UND0UgjKTVK-Uodkm0Hg_xSvEMPvz';
const supabase = createClient(supabaseUrl, supabaseKey);

// CSV data mapped by action name
const actionDescriptions: Record<string, string[]> = {
  'Adaptogens': [
    'Helps the body adapt to stress',
    'virtually non-toxic at high doses',
    'non-specific action throughout the body',
    'H-P-A axis = Hypothalamic Pituitary Adrenal - communication system involved in the stress response',
    'adaptogens help regulate this hormonal cascade',
    'non-specific state of resistance to stress: environmental, psych or physio',
    'helping the body adapt to and defend against the effects of environmental stress.',
    'The general aims of treatment with this action are to reduce stress reactions during the alarm phase of the stress response and to prevent or at least delay the state of exhaustion,',
    'smooth out the associated highs and lows. This conserves energy in the alarm phase for use in the resistance phase.'
  ],
  'Alteratives': [
    'alter the body from unhealthy to healthy via the body channels of elimination',
    'bowel, kidney, skin, liver',
    'aid in detoxification',
    'used to be called "blood cleanser"',
    'gradually restore proper function to the body and increase overall health and vitality.',
    'seem to alter the body\'s metabolic processes to improve tissues\' ability to deal with a range of body functions, from nutrition to elimination.',
    'should be considered first for cases of chronic inflammatory and degenerative diseases',
    'Skin is the body system for which these are often used'
  ],
  'Anticatarrhal': [
    'thin the mucus secretions and reduce congestion',
    'can be used for lungs, although aren\'t as effective in loosening deep-seated mucus as the more stimulating expectorant',
    'help the body remove excess mucus, whether in the sinuses or in other parts of the body. They are used mainly for ear, nose, and throat infections,',
    'Some of this action remedies work by producing a less viscous mucus secretion that is easier for the body to remove. Others reduce mucus secretion directly.'
  ],
  'Anti-inflammatory': [
    'reduces inflammation from sprains, strains, headaches, wounds or chronic internal conditions',
    'promote healthy inflammation, regulate it to turn on and turn off',
    'work well with musculoskeletal discomfort',
    'help the body combat inflammation'
  ],
  'Antimicrobial': [
    'disinfectants, used both internally and externally to prevent or cure infections',
    'a lot of cooking herbs - sage, oregano',
    'a sage-y smell usually indicates this action',
    'usually can be used both topically and internally',
    'help the body destroy or resist pathogenic microorganisms in some way',
    'we are talking about plants that support the immune process, augmenting the integrity of the individual\'s own defense system'
  ],
  'Antispasmodic': [
    'special kind of muscle relaxants',
    'help ease spasms and cramps and also very helpful in gently relaxing body extremities',
    'useful for variety of conditions: anxiety, nervousness, to hypertension, cold hands and feet',
    'prevent or ease spasms or cramps in the muscles. They thus reduce muscular tension in the body,',
    'facilitate physical relaxation of muscles without necessarily causing a sedative effect.',
    'the action that affects the peripheral nerves and the muscle tissue - may have an indirect relaxing action on the whole system.'
  ],
  'Astringent': [
    'tone and tighten tissues',
    'tannin rich herbs',
    'pulling or drawing effect',
    'drying',
    'most barks have this property',
    'tightening of the tissue',
    'sometimes called styptics when applied externally to stop bleeding, or anti-hemorrhagics when used for internal bleeding.',
    'produce a kind of temporary leather coat on the surface of tissue.',
    'Reduce irritation on the surface of tissues through a sort of numbing action',
    'Reduce surface inflammation',
    'Create a barrier against infection, great help with wounds and burns',
    'of great importance in round healing and conditions affecting the digestive system.'
  ],
  'Bitter': [
    'Stimulate appetite.',
    'Stimulate release of digestive juices from the pancreas, duodenum, and and liver',
    'Aid the liver in detoxification work and increase the flow of bile',
    'Help regulate secretion of pancreatic hormones that regulate blood sugar, insulin, and glucagon',
    'Help the gut wall repair damage by stimulating self-repair mechanisms.'
  ],
  'Cardiotonic': [
    'special affinity for the heart, regulating its beat, moderating hypertension, and usually tone the heart',
    'general category for herbal remedies that have some kind of action on the heart.'
  ],
  'Carminative': [
    'clear "wind" and gas/bloating in the body',
    'move energy in the body downward if scattered thoughts as well!',
    'rich in volatile oils',
    'ease discomfort caused by flatulence.'
  ],
  'Cholagogue': [
    'greek meaning bile, and as such has a cleaning and stimulating effect on the liver and gallbladder, allowing from the release of more bile',
    'helpful in aiding digestion, esp in the lower intestinal tract',
    'have the specific effect of stimulating the flow of bile from the liver.',
    'quite specific in that they act on the liver.',
    'indicated for disorders caused by insufficient or congested bile, such as intractable biliary constipation, jaundice, and mild hepatitis.',
    'contraindicated for painful gallstones, Increased contractile activity could further constrict the bile duct, leading to incredibly intense',
    'Because they help with assimilation, these have an enlivening "side effect" in the nervous system. These remedies may actively ease debility and'
  ],
  'Demulcent': [
    'soothing herbs rich in mucilage',
    'helps to heal mucosal barrier',
    'indication for gastric irritation, ulcers',
    'if someone is already damp, contraindication for this',
    'herbs with this action often have an apparently anti-inflammatory effect, but this is related to their ability to soothe inflamed surfaces, not to reductions in the cellular inflammatory response.',
    'rich in mucilage and can soothe and protect irritated or inflamed internal tissue. When used topically on the skin, these are called emollients.',
    'become slimy and gummy when they come in contact with water:',
    'Reduce irritation down the whole length of the bowel.',
    'Lessen the sensitivity of the digestive system to gastric acids and to digestive bitters'
  ],
  'Diuretic': [
    'gently promote elimination of water through the kidneys, as urine',
    'help the body rid itself of exces fluids by increasing the kidneys\' rate of urine production.',
    'Causes more blood to pass through the kidneys, which produces more urine',
    'Because of their cleansing actions, many of these help with problems of muscles and bones'
  ],
  'Emmenagogue': [
    'promote menstruation usually by slightly irritating the uterine lining',
    'severely contraindicated during pregnancy',
    'remedies that stimulate menstrual flow and activity'
  ],
  'Stimulating Expectorant': [
    'Irritate the bronchioles to stimulate expulsion of any material present',
    'Liquefy viscid sputum so that it can be cleared by coughing.'
  ],
  'Relaxing Expectorant': [
    'seem also to act by reflex, but here the reflex action works to soothe bronchial spasm and loosen mucus secretions.',
    'help to produce a thinner mucus that is easier to expel, allowing the more viscous mucus to move and thus be eliminated.',
    'useful for dry, irritating coughs.',
    'This action is similar in some respects to that of demulcents, and both actions owe much to their content of mucilage and, occasionally, volatile oils.'
  ],
  'Hepatic': [
    'herbal remedies that aid the work of the liver in a range of ways.',
    'Bitters and cholagogues all act as this action, but so do a whole array of other remedies that do not have those specific actions.'
  ],
  'Hypnotic': [
    'trance-inducing, a little more than simple sedatives',
    'can be very relaxing , useful in sleep conditions, headaches, tension, and for addiction recovery',
    'don\'t used with sedative medication already',
    'most are also hypotensives - lower blood pressure',
    'nervine remedies that help induce a deep and healing state of sleep.',
    'should always be used within the context of a holistic approach to sleep problems'
  ],
  'Hypotensive': [
    'lower blood pressure by acting either on the heart, arteries, capillaries, or the water balance in the body',
    'use semi-preventatively, when the blood pressure starts to creep up, not in acute conditions',
    'reduce elevated blood pressure, tending to normalize both systolic and diastolic pressure.'
  ],
  'Nervine Relaxants': [
    'most important in times of stress and confusion, as they can alleviate many of the accompanying symptoms.',
    'the best remedies for the "inflamed state of mind"'
  ],
  'Nervine Stimulant': [
    'an action that quickens and enlivens the physiological activity of the body.'
  ]
};

async function generateMigration() {
  console.log('Fetching primary actions from database...');

  const { data: primaryActions, error } = await supabase
    .schema('herbal')
    .from('primary_actions')
    .select('id, name')
    .order('name');

  if (error) {
    console.error('Error fetching primary actions:', error);
    return;
  }

  console.log('Found primary actions:', primaryActions);

  let sqlContent = `-- Populate action descriptions from Herbal Actions CSV data
SET search_path TO herbal, public;

-- Clear existing action descriptions
DELETE FROM herbal.action_descriptions;

`;

  for (const action of primaryActions || []) {
    const descriptions = actionDescriptions[action.name];

    if (descriptions && descriptions.length > 0) {
      sqlContent += `-- ${action.name} descriptions (ID ${action.id})\n`;
      sqlContent += `INSERT INTO herbal.action_descriptions (primary_action_id, description, sort_order) VALUES\n`;

      const values = descriptions.map((desc, idx) => {
        const escapedDesc = desc.replace(/'/g, "''");
        return `(${action.id}, '${escapedDesc}', ${idx + 1})`;
      });

      sqlContent += values.join(',\n') + ';\n\n';
    }
  }

  const migrationPath = path.join(__dirname, '../supabase/migrations/007_populate_action_descriptions.sql');
  fs.writeFileSync(migrationPath, sqlContent);

  console.log(`Migration file created at: ${migrationPath}`);
  console.log('\nYou can now run this SQL in the Supabase SQL editor.');
}

generateMigration().catch(console.error);
