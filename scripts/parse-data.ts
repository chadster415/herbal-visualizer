import * as fs from 'fs';
import * as path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

interface ParsedHerb {
  latinName: string;
  commonName: string;
}

interface ParsedData {
  herbs: ParsedHerb[];
  primaryActions: Map<string, {
    herbs: Map<string, {
      bodySystems: string[];
      systemNotes: Map<string, string>;
      strength?: 'mild' | 'strong' | 'very_strong';
    }>;
    secondaryActions: Map<string, Set<string>>;
  }>;
}

function parseHerbName(line: string): ParsedHerb | null {
  const match = line.match(/^(.+?)\s*\((.+?)\)\s*$/);
  if (match) {
    return {
      latinName: match[1].trim(),
      commonName: match[2].trim()
    };
  }
  return null;
}

function parseTextFile(filePath: string): ParsedData {
  const content = fs.readFileSync(filePath, 'utf-8');
  const lines = content.split('\n');

  const data: ParsedData = {
    herbs: [],
    primaryActions: new Map()
  };

  let currentPrimaryAction = '';
  let currentSection = '';

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i].trim();

    if (!line) continue;

    // Primary action header
    if (line.startsWith('# ')) {
      currentPrimaryAction = line.substring(2).trim();
      currentSection = '';

      if (!data.primaryActions.has(currentPrimaryAction)) {
        data.primaryActions.set(currentPrimaryAction, {
          herbs: new Map(),
          secondaryActions: new Map()
        });
      }
      continue;
    }

    // Section header
    if (line.startsWith('## ')) {
      currentSection = line.substring(3).trim();
      continue;
    }

    // Primary herbs list
    if (currentPrimaryAction && !currentSection && !line.startsWith('##')) {
      const herb = parseHerbName(line);
      if (herb) {
        data.herbs.push(herb);
        const actionData = data.primaryActions.get(currentPrimaryAction)!;
        if (!actionData.herbs.has(herb.latinName)) {
          actionData.herbs.set(herb.latinName, {
            bodySystems: [],
            systemNotes: new Map()
          });
        }
      }
    }
  }

  return data;
}

// Generate SQL inserts
function generateSQL(data: ParsedData): string {
  const uniqueHerbs = new Map<string, ParsedHerb>();
  data.herbs.forEach(herb => {
    uniqueHerbs.set(herb.latinName, herb);
  });

  let sql = '-- Set schema\nSET search_path TO herbal, public;\n\n';
  sql += '-- Insert herbs into herbal schema\n';
  let herbId = 1;

  uniqueHerbs.forEach(herb => {
    const escapedLatin = herb.latinName.replace(/'/g, "''");
    const escapedCommon = herb.commonName.replace(/'/g, "''");
    sql += "INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (" + herbId + ", '" + escapedLatin + "', '" + escapedCommon + "') ON CONFLICT (latin_name) DO NOTHING;\n";
    herbId++;
  });

  sql += '\n-- Insert primary actions\n';
  let actionId = 1;

  data.primaryActions.forEach((_, actionName) => {
    const escapedAction = actionName.replace(/'/g, "''");
    sql += "INSERT INTO herbal.primary_actions (id, name) VALUES (" + actionId + ", '" + escapedAction + "') ON CONFLICT (name) DO NOTHING;\n";
    actionId++;
  });

  sql += '\n-- Body systems are already inserted in the schema migration\n';
  sql += '-- If you need to re-insert them:\n';
  sql += '-- DELETE FROM herbal.body_systems;\n';
  const bodySystems = ['Cardiovascular', 'Respiratory', 'Digestive', 'Urinary', 'Reproductive', 'Musculoskeletal', 'Nervous', 'Skin'];
  bodySystems.forEach((system, idx) => {
    sql += "-- INSERT INTO herbal.body_systems (id, name) VALUES (" + (idx + 1) + ", '" + system + "');\n";
  });

  return sql;
}

// Main execution
const filePath = path.join(__dirname, '../../Secondary Actions.txt');
const data = parseTextFile(filePath);
const sql = generateSQL(data);

fs.writeFileSync(path.join(__dirname, '../supabase/migrations/002_seed_data.sql'), sql);
console.log('SQL seed file generated!');
console.log('Found ' + data.herbs.length + ' herbs');
console.log('Found ' + data.primaryActions.size + ' primary actions');
