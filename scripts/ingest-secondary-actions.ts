import { createClient } from '@supabase/supabase-js';
import * as fs from 'fs';
import * as path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const supabaseUrl = process.env.SUPABASE_URL || 'http://127.0.0.1:54321';
const supabaseKey = process.env.SUPABASE_KEY || 'sb_secret_N7UND0UgjKTVK-Uodkm0Hg_xSvEMPvz';
const supabase = createClient(supabaseUrl, supabaseKey);

interface Herb {
  latinName: string;
  commonName: string;
}

interface BodySystemAffinity {
  herbLatinName: string;
  bodySystem: string;
  note?: string;
}

interface SecondaryAction {
  herbLatinName: string;
  actionName: string;
}

interface RelativeStrength {
  herbLatinName: string;
  strength: 'mild' | 'strong' | 'very_strong';
}

function titleCase(str: string): string {
  return str
    .split(' ')
    .map(word => word.charAt(0).toUpperCase() + word.slice(1).toLowerCase())
    .join(' ');
}

function parseHerbLine(line: string): Herb | null {
  const match = line.match(/^(.+?)\s+\((.+?)\)$/);
  if (!match) return null;

  return {
    latinName: match[1].trim(),
    commonName: titleCase(match[2].trim())
  };
}

function parseFile(filePath: string) {
  const content = fs.readFileSync(filePath, 'utf-8');
  const lines = content.split('\n');

  let currentPrimaryAction: string | null = null;
  let currentHerbs: Herb[] = [];
  let currentSection: 'herbs' | 'body_systems' | 'secondary_actions' | 'relative_strengths' | null = 'herbs';
  let currentBodySystem: string | null = null;

  const data: {
    [primaryAction: string]: {
      herbs: Herb[];
      bodySystemAffinities: BodySystemAffinity[];
      secondaryActions: SecondaryAction[];
      relativeStrengths: RelativeStrength[];
    }
  } = {};

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i].trim();

    // Skip empty lines
    if (!line) continue;

    // Primary action (single #)
    if (line.match(/^# [A-Z]/)) {
      // Save previous primary action data
      if (currentPrimaryAction && data[currentPrimaryAction]) {
        // Already saved, just update reference
      }

      currentPrimaryAction = line.substring(2).trim();
      currentHerbs = [];
      currentSection = 'herbs';
      currentBodySystem = null;

      data[currentPrimaryAction] = {
        herbs: [],
        bodySystemAffinities: [],
        secondaryActions: [],
        relativeStrengths: []
      };
      continue;
    }

    // Section headers
    if (line === '## Body System Affinities') {
      currentSection = 'body_systems';
      currentBodySystem = null;
      continue;
    }

    if (line === '## Secondary Actions') {
      currentSection = 'secondary_actions';
      continue;
    }

    if (line === '## Relative Strengths') {
      currentSection = 'relative_strengths';
      continue;
    }

    if (!currentPrimaryAction) continue;

    // Parse based on current section
    if (currentSection === 'herbs') {
      const herb = parseHerbLine(line);
      if (herb) {
        currentHerbs.push(herb);
        data[currentPrimaryAction].herbs.push(herb);
      }
    } else if (currentSection === 'body_systems') {
      // Check if this is a body system name (single word starting with capital, or known body system name)
      const bodySystemNames = ['Cardiovascular', 'Respiratory', 'Digestive', 'Urinary', 'Reproductive', 'Musculoskeletal', 'Nervous', 'Skin'];
      if (bodySystemNames.includes(line)) {
        currentBodySystem = line;
      } else if (currentBodySystem) {
        // This is a herb line with optional note
        if (line.startsWith('ALL')) {
          // ALL means all herbs for this primary action
          const noteMatch = line.match(/^ALL,\s*(.+)$/);
          const note = noteMatch ? noteMatch[1].trim() : undefined;

          for (const herb of currentHerbs) {
            data[currentPrimaryAction].bodySystemAffinities.push({
              herbLatinName: herb.latinName,
              bodySystem: currentBodySystem,
              note
            });
          }
        } else {
          // Individual herb line
          const parts = line.split(',');
          const herbLatinName = parts[0].trim();
          const note = parts.length > 1 ? parts.slice(1).join(',').trim() : undefined;

          // Only add if herb is in the primary herb list
          if (currentHerbs.some(h => h.latinName === herbLatinName)) {
            data[currentPrimaryAction].bodySystemAffinities.push({
              herbLatinName,
              bodySystem: currentBodySystem,
              note
            });
          }
        }
      }
    } else if (currentSection === 'secondary_actions') {
      // Action name on one line, herbs on the next
      const actionName = line;
      i++; // Move to next line with herbs
      if (i < lines.length) {
        const herbsLine = lines[i].trim();
        const herbNames = herbsLine.split(',').map(h => h.trim());

        for (const herbLatinName of herbNames) {
          // Only add if herb is in the primary herb list
          if (currentHerbs.some(h => h.latinName === herbLatinName)) {
            data[currentPrimaryAction].secondaryActions.push({
              herbLatinName,
              actionName
            });
          }
        }
      }
    } else if (currentSection === 'relative_strengths') {
      // Strength level on one line, herbs on the next
      const strengthLine = line;
      let strength: 'mild' | 'strong' | 'very_strong';

      if (strengthLine.toLowerCase() === 'mild') {
        strength = 'mild';
      } else if (strengthLine.toLowerCase() === 'strong') {
        strength = 'strong';
      } else if (strengthLine.toLowerCase().includes('very strong')) {
        strength = 'very_strong';
      } else {
        continue;
      }

      i++; // Move to next line with herbs
      if (i < lines.length) {
        const herbsLine = lines[i].trim();
        const herbNames = herbsLine.split(',').map(h => h.trim());

        for (const herbLatinName of herbNames) {
          // Only add if herb is in the primary herb list
          if (currentHerbs.some(h => h.latinName === herbLatinName)) {
            data[currentPrimaryAction].relativeStrengths.push({
              herbLatinName,
              strength
            });
          }
        }
      }
    }
  }

  return data;
}

async function ingestData(data: ReturnType<typeof parseFile>) {
  console.log('Starting data ingestion...');

  // Clear existing data
  console.log('Clearing existing data...');
  await supabase.schema('herbal').from('herb_secondary_actions').delete().neq('id', 0);
  await supabase.schema('herbal').from('herb_primary_actions').delete().neq('id', 0);
  await supabase.schema('herbal').from('herbs').delete().neq('id', 0);
  await supabase.schema('herbal').from('primary_actions').delete().neq('id', 0);
  await supabase.schema('herbal').from('secondary_actions').delete().neq('id', 0);
  await supabase.schema('herbal').from('body_systems').delete().neq('id', 0);

  // Re-insert body systems
  console.log('Inserting body systems...');
  const bodySystems = ['Cardiovascular', 'Respiratory', 'Digestive', 'Urinary', 'Reproductive', 'Musculoskeletal', 'Nervous', 'Skin'];
  const { data: bodySystemsData, error: bsError} = await supabase
    .schema('herbal')
    .from('body_systems')
    .insert(bodySystems.map(name => ({ name })))
    .select();

  if (bsError) {
    console.error('Error inserting body systems:', bsError);
    return;
  }

  const bodySystemMap = new Map<string, number>();
  bodySystemsData?.forEach(bs => bodySystemMap.set(bs.name, bs.id));

  // Insert primary actions
  console.log('Inserting primary actions...');
  const primaryActions = Object.keys(data);
  const { data: primaryActionsData, error: paError } = await supabase
    .schema('herbal')
    .from('primary_actions')
    .insert(primaryActions.map(name => ({ name })))
    .select();

  if (paError) {
    console.error('Error inserting primary actions:', paError);
    return;
  }

  const primaryActionMap = new Map<string, number>();
  primaryActionsData?.forEach(pa => primaryActionMap.set(pa.name, pa.id));

  // Collect all unique herbs
  const allHerbs = new Map<string, Herb>();
  for (const primaryAction of Object.keys(data)) {
    for (const herb of data[primaryAction].herbs) {
      allHerbs.set(herb.latinName, herb);
    }
  }

  // Insert herbs
  console.log(`Inserting ${allHerbs.size} herbs...`);
  const { data: herbsData, error: herbsError } = await supabase
    .schema('herbal')
    .from('herbs')
    .insert(Array.from(allHerbs.values()).map(herb => ({
      latin_name: herb.latinName,
      common_name: herb.commonName
    })))
    .select();

  if (herbsError) {
    console.error('Error inserting herbs:', herbsError);
    return;
  }

  const herbMap = new Map<string, number>();
  herbsData?.forEach(h => herbMap.set(h.latin_name, h.id));

  // Collect all unique secondary actions
  const allSecondaryActions = new Set<string>();
  for (const primaryAction of Object.keys(data)) {
    for (const sa of data[primaryAction].secondaryActions) {
      allSecondaryActions.add(sa.actionName);
    }
  }

  // Insert secondary actions
  console.log(`Inserting ${allSecondaryActions.size} secondary actions...`);
  const { data: secondaryActionsData, error: saError } = await supabase
    .schema('herbal')
    .from('secondary_actions')
    .insert(Array.from(allSecondaryActions).map(name => ({ name })))
    .select();

  if (saError) {
    console.error('Error inserting secondary actions:', saError);
    return;
  }

  const secondaryActionMap = new Map<string, number>();
  secondaryActionsData?.forEach(sa => secondaryActionMap.set(sa.name, sa.id));

  // Insert herb-primary action relationships
  console.log('Inserting herb-primary action relationships...');
  let relationshipCount = 0;

  for (const primaryAction of Object.keys(data)) {
    const primaryActionId = primaryActionMap.get(primaryAction);
    if (!primaryActionId) continue;

    const actionData = data[primaryAction];

    // Get all herbs with their strengths
    const herbStrengthMap = new Map<string, 'mild' | 'strong' | 'very_strong'>();
    for (const rs of actionData.relativeStrengths) {
      herbStrengthMap.set(rs.herbLatinName, rs.strength);
    }

    // Get all body system affinities grouped by herb
    const herbBodySystemMap = new Map<string, Array<{ bodySystem: string, note?: string }>>();
    for (const bsa of actionData.bodySystemAffinities) {
      if (!herbBodySystemMap.has(bsa.herbLatinName)) {
        herbBodySystemMap.set(bsa.herbLatinName, []);
      }
      herbBodySystemMap.get(bsa.herbLatinName)!.push({
        bodySystem: bsa.bodySystem,
        note: bsa.note
      });
    }

    // For each herb in this primary action
    for (const herb of actionData.herbs) {
      const herbId = herbMap.get(herb.latinName);
      if (!herbId) continue;

      const strength = herbStrengthMap.get(herb.latinName);
      const bodySystems = herbBodySystemMap.get(herb.latinName) || [];

      if (bodySystems.length > 0) {
        // Insert one relationship per body system
        for (const bs of bodySystems) {
          const bodySystemId = bodySystemMap.get(bs.bodySystem);
          if (!bodySystemId) continue;

          const { error: hpaError } = await supabase
            .schema('herbal')
            .from('herb_primary_actions')
            .insert({
              herb_id: herbId,
              primary_action_id: primaryActionId,
              body_system_id: bodySystemId,
              body_system_note: bs.note || null,
              relative_strength: strength || null
            });

          if (hpaError) {
            console.error(`Error inserting herb-primary action relationship:`, hpaError);
          } else {
            relationshipCount++;
          }
        }
      } else {
        // No body system specified, insert with NULL body_system_id
        const { error: hpaError } = await supabase
          .schema('herbal')
          .from('herb_primary_actions')
          .insert({
            herb_id: herbId,
            primary_action_id: primaryActionId,
            body_system_id: null,
            body_system_note: null,
            relative_strength: strength || null
          });

        if (hpaError) {
          console.error(`Error inserting herb-primary action relationship without body system:`, hpaError);
        } else {
          relationshipCount++;
        }
      }
    }
  }

  console.log(`Inserted ${relationshipCount} herb-primary action relationships`);

  // Insert herb-secondary action relationships
  console.log('Inserting herb-secondary action relationships...');
  let secondaryRelationshipCount = 0;

  for (const primaryAction of Object.keys(data)) {
    const actionData = data[primaryAction];

    for (const sa of actionData.secondaryActions) {
      const herbId = herbMap.get(sa.herbLatinName);
      const secondaryActionId = secondaryActionMap.get(sa.actionName);

      if (!herbId || !secondaryActionId) continue;

      const { error: hsaError } = await supabase
        .schema('herbal')
        .from('herb_secondary_actions')
        .insert({
          herb_id: herbId,
          secondary_action_id: secondaryActionId
        });

      if (hsaError && !hsaError.message.includes('duplicate')) {
        console.error(`Error inserting herb-secondary action relationship:`, hsaError);
      } else if (!hsaError) {
        secondaryRelationshipCount++;
      }
    }
  }

  console.log(`Inserted ${secondaryRelationshipCount} herb-secondary action relationships`);
  console.log('Data ingestion complete!');
}

// Main execution
const filePath = path.join(__dirname, '../../Secondary Actions.txt');
const data = parseFile(filePath);

console.log('Parsed data structure:');
for (const [primaryAction, actionData] of Object.entries(data)) {
  console.log(`\n${primaryAction}:`);
  console.log(`  - ${actionData.herbs.length} herbs`);
  console.log(`  - ${actionData.bodySystemAffinities.length} body system affinities`);
  console.log(`  - ${actionData.secondaryActions.length} secondary actions`);
  console.log(`  - ${actionData.relativeStrengths.length} relative strengths`);
}

console.log('\nStarting database ingestion...');
ingestData(data).catch(console.error);
