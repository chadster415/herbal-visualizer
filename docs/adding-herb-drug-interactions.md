# Adding Herb-Drug Interaction Sources

Each web source gets its own migration. The pattern is established — source 1 (ITM Online) is migration 463.

## What exists

**Table:** `herbal.herb_drug_interactions`
```
id, herb_id (FK → herbs), source_id (FK → sources), drug_or_class text, interaction_text text, severity text nullable, created_at
```

**`herbal.sources`** now has a `url` column.

**UI:** `HerbView.tsx` → `HerbDetailPanel` renders one collapsible red block per source in the Drug Interactions section. Collapsed shows count + source name + Ref link (the source URL). Expanded shows each entry as drug_or_class label + interaction_text.

**Completed sources:**
| Migration | short_name | display_name | URL |
|---|---|---|---|
| 463 | `itmonline` | ITM Online | http://www.itmonline.org/arts/herbdrug2.htm |
| 465 | `escop` | ESCOP Monographs | https://www.escop.com/interactions/ |
| 466 | `aafp` | American Family Physician | https://www.aafp.org/afp/2017/0715/p101 |
| 467 | `ethnomed` | EthnoMed (UW Medicine) | https://ethnomed.org/resource/chinese-and-western-herbal-medicine-a-guide-to-potential-risks-and-drug-interactions/ |

---

## Playbook for each new source

### Step 1 — Read the source file
The HTML files live at:
```
~/Library/Mobile Documents/com~apple~CloudDocs/Archive/Classes/Health and Plants/BHC/Apprenticeship/App/Herb Drug Interactions/
```
Read it with the Read tool (absolute path) — don't fetch the URL, the file is local.

### Step 2 — Find matching herbs in the DB
Run a broad psql query for all herb names mentioned in the source:
```bash
PGPASSWORD=postgres /opt/homebrew/Cellar/libpq/18.6/bin/psql -h 127.0.0.1 -p 54322 -U postgres -d postgres -c "
SELECT id, common_name, latin_name FROM herbal.herbs
WHERE lower(common_name) IN ('herb1', 'herb2', ...)
   OR lower(latin_name) LIKE '%genus%'
ORDER BY common_name;"
```
Only insert rows for herbs confirmed in the DB. Skip anything not found.

### Step 3 — Check next migration number
```bash
ls /Users/chadarmstrong/github/herbal-visualizer/supabase/migrations/ | tail -3
```
Use the next sequential number (e.g., if last is 463, use 464).

### Step 4 — Write the migration
File: `supabase/migrations/NNN_herb_drug_interactions_<sourcename>.sql`

Template:
```sql
-- Migration NNN: herb_drug_interactions — <Source Display Name>
-- Source: "<Full Title>" by <Author(s)>
-- <URL>

-- Insert source record
INSERT INTO herbal.sources (short_name, display_name, full_title, authors, year, url)
VALUES (
  '<short_name>',       -- unique slug, e.g. 'mskcc', 'drugs_com'
  '<Display Name>',     -- shown in UI next to interaction count
  '<Full article/page title>',
  '<Author or organization>',
  <year>,
  '<url>'
);

-- IMPORTANT: GRANT is required in addition to RLS policy (omitting causes 403/42501)
GRANT SELECT ON herbal.herb_drug_interactions TO anon, authenticated;

-- Insert interactions
DO $$
DECLARE v_src integer;
BEGIN
  SELECT id INTO v_src FROM herbal.sources WHERE short_name = '<short_name>';

  -- Herb Common Name (herb_id)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (<herb_id>, v_src, '<Drug or drug class>', '<Full interaction description>');

  -- ... repeat for each herb/interaction ...

END $$;
```

**Key rules:**
- One row per distinct drug/drug-class concern per herb. If a source says "may interact with anticoagulants AND may interact with MAO inhibitors," those are two rows.
- If a source says "may interact with anticoagulants" without naming a specific drug, use a class name like `'Anticoagulants / Antiplatelets'`.
- `severity` is nullable — only populate if the source explicitly rates it (e.g., "major", "moderate", "minor").
- Use SQL `''` to escape single quotes inside strings (not `\'`).
- No `--no-acl` in pg_dump; no `--if-exists` in migration (the table already exists).

### Step 5 — No UI changes needed
The UI already handles any number of sources generically. No TypeScript changes required for additional sources unless a new feature is needed.

### Step 6 — Verify
After the user runs the migration in the Supabase SQL Editor, confirm with:
```bash
PGPASSWORD=postgres /opt/homebrew/Cellar/libpq/18.6/bin/psql -h 127.0.0.1 -p 54322 -U postgres -d postgres -c "
SELECT s.display_name, h.common_name, di.drug_or_class
FROM herbal.herb_drug_interactions di
JOIN herbal.herbs h ON h.id = di.herb_id
JOIN herbal.sources s ON s.id = di.source_id
WHERE s.short_name = '<short_name>'
ORDER BY h.common_name, di.drug_or_class;"
```

---

## Context: how the UI renders this

In `HerbView.tsx → HerbDetailPanel` (around the Drug Interactions section):
- The Supabase query embeds `herb_drug_interactions ( id, drug_or_class, interaction_text, severity, sources ( id, short_name, display_name, url ) )` into every herb fetch.
- Interactions are grouped by `sources.id` client-side.
- Each group renders a collapsible red box button matching the Stockley's style.
- The **Ref** badge is a small `<a>` tag linking to `sources.url`, rendered inline in the subtitle.
- Expanded state is tracked in `expandedDrugSources: Set<number>` (keyed by source_id), reset on herb navigation.

To add a new field (e.g., `sort_order`) to the table, add a new migration rather than modifying 463.
