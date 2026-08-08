import Anthropic from '@anthropic-ai/sdk';
import { createClient } from '@supabase/supabase-js';
import * as fs from 'fs';
import * as path from 'path';

// Load .env.local so the script works without inline env vars
const envPath = path.resolve(__dirname, '..', '.env.local');
if (fs.existsSync(envPath)) {
  for (const line of fs.readFileSync(envPath, 'utf8').split('\n')) {
    const trimmed = line.trim();
    if (!trimmed || trimmed.startsWith('#')) continue;
    const eq = trimmed.indexOf('=');
    if (eq === -1) continue;
    const key = trimmed.slice(0, eq).trim();
    const val = trimmed.slice(eq + 1).trim();
    process.env[key] = val;
  }
}

const LOCAL_URL = process.env.NEXT_PUBLIC_SUPABASE_URL || 'http://localhost:54321';
const SERVICE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY || 'sb_secret_N7UND0UgjKTVK-Uodkm0Hg_xSvEMPvz';

const supabase = createClient(LOCAL_URL, SERVICE_KEY, {
  db: { schema: 'herbal' },
});

const SYSTEM_PROMPT = `You are a medical terminology assistant helping build a search index for an herbal medicine education app. For each disorder provided, generate exactly 30 short search keywords or phrases (2-4 words max each) that cover: common symptoms a patient would describe, alternative medical names, related conditions, affected body parts, and common lay terms. Return ONLY valid JSON: an array of objects with shape {"id": number, "keywords": string[]}. No explanation, no markdown, no code blocks.`;

const BATCH_SIZE = 10;

interface Disorder {
  id: number;
  name: string;
}

interface KeywordResult {
  id: number;
  keywords: string[];
}

async function main() {
  const apiKey = process.env.ANTHROPIC_API_KEY;
  if (!apiKey) throw new Error('ANTHROPIC_API_KEY env var is required');
  console.log(`Using API key: ${apiKey.slice(0, 12)}…${apiKey.slice(-4)} (length ${apiKey.length})`);

  const anthropic = new Anthropic({ apiKey });

  const { data: disorders, error } = await supabase
    .from('disorders')
    .select('id, name')
    .order('name');

  if (error) throw new Error(`Failed to fetch disorders: ${error.message}`);
  if (!disorders || disorders.length === 0) throw new Error('No disorders found in DB');

  console.log(`Found ${disorders.length} disorders. Generating keywords in batches of ${BATCH_SIZE}…`);

  const totalBatches = Math.ceil(disorders.length / BATCH_SIZE);
  let totalUpdated = 0;

  for (let i = 0; i < disorders.length; i += BATCH_SIZE) {
    const batch: Disorder[] = disorders.slice(i, i + BATCH_SIZE);
    const batchNum = Math.floor(i / BATCH_SIZE) + 1;

    try {
      const response = await anthropic.messages.create({
        model: 'claude-haiku-4-5-20251001',
        max_tokens: 2048,
        system: SYSTEM_PROMPT,
        messages: [
          {
            role: 'user',
            content: JSON.stringify(batch.map((d) => ({ id: d.id, name: d.name }))),
          },
        ],
      });

      const text = response.content[0].type === 'text' ? response.content[0].text.trim() : '';
      let parsed: KeywordResult[];

      try {
        parsed = JSON.parse(text);
      } catch {
        console.error(`  Batch ${batchNum}/${totalBatches}: JSON parse failed — skipping. Response was:`, text.slice(0, 200));
        continue;
      }

      for (const { id, keywords } of parsed) {
        const { error: updateError } = await supabase
          .from('disorders')
          .update({ search_keywords: keywords })
          .eq('id', id);

        if (updateError) {
          console.error(`  Failed to update disorder id=${id}: ${updateError.message}`);
        } else {
          totalUpdated++;
        }
      }

      console.log(`Batch ${batchNum}/${totalBatches} done — ${Math.min(i + BATCH_SIZE, disorders.length)}/${disorders.length} disorders processed`);
    } catch (err) {
      console.error(`Batch ${batchNum}/${totalBatches} error:`, err);
    }
  }

  console.log(`\nDone! Updated ${totalUpdated}/${disorders.length} disorders with search keywords.`);
}

main().catch((err) => {
  console.error('Fatal error:', err);
  process.exit(1);
});
