# Adding Herb Data from Books

This guide covers how to add or extend herb data — contraindications, body system actions, energetics, and constituent profiles — from a printed or scanned materia medica source.

---

## Sources used so far

| Source key | Full title | Used in |
|---|---|---|
| `Tilgner` | *Herbal Medicine From the Heart of the Earth* — Sharol Tilgner | Migrations 107–108 |

---

## Which tables are involved

| Data type | Table / column | Notes |
|---|---|---|
| Herb exists | `herbs` | Must exist before any other data can be linked |
| Contraindications text | `herbs.contraindications` | Free-form text; one block per herb |
| Contraindications source | `herbs.contraindications_source` | e.g. `'Tilgner'`, `'Hoffmann'` |
| Energetics | `herbs.temperature`, `.moisture`, `.tone` | Enums: `cooling/warming/neutral`, `drying/moistening/neutral`, `toning/relaxing/neutral` |
| Primary actions + body system | `herb_primary_actions` | UNIQUE on `(herb_id, primary_action_id, body_system_id)` |
| Body system note | `herb_primary_actions.body_system_note` | Why this action matters for this herb in this system |
| Relative strength | `herb_primary_actions.relative_strength` | `'mild' | 'moderate' | 'strong' | 'very_strong'` or NULL |
| Secondary action tags | `herb_secondary_actions` | Use `body_system_id` = `(SELECT id FROM body_systems WHERE name = 'All')` |
| Constituent profile markers | `constituent_profiles` | Flat rows from the Herb Constituent Database CSV — class/subclass/status; drives the "Constituent Profile Markers" UI section and the Alternates engine |
| General constituents (curated) | `constituents` + `herb_constituents` | Normalized compound dictionary + per-herb concentration level; drives the "General Constituents" pill display |

---

## The three constituent tables explained

These tables are distinct and serve different purposes:

| Table | UI section | What it holds |
|---|---|---|
| `constituents` | (shared lookup) | Global dictionary of every unique chemical compound. One row per compound across all herbs. `name` (UNIQUE), `category` (e.g. `'alkamide'`), `description`. |
| `herb_constituents` | **General Constituents** (colored pills) | Join table: which compounds are in which herb, at what `concentration_level` (`trace / minor / moderate / major / primary`). Also has `notes`, `sort_order`, `needs_review`. Curated data from migrations. The "General" in the UI name reflects the fact that the underlying `constituents` dictionary is shared — the same compound (e.g., `rutin`, `quercetin`) links to dozens of herbs, enabling cross-herb comparison. |
| `constituent_profiles` | **Constituent Profile Markers** (amber cards) | Flat import of the Herb Constituent Database CSV. One row per compound per herb, with `class`, `subclass`, `status` (`Marker / Major / Present / Reported`), `importance`, `notes`, `editorial_note`. Also drives the Ranked Alternates feature. |

### Why `constituent_profiles` has `common_name`, `latin_name`, and `plant_part` alongside `herb_id`

The table is a verbatim import of an external CSV — those columns came straight from the source file. The `herb_id` foreign key was added *after import* (migration 075) to link rows to our `herbs` table. Two reasons the name columns are kept:

1. **`herb_id` can be NULL** — when the CSV herb had no match in our `herbs` table at import time, the name columns are the only identification for that row. Without them the row would be uninterpretable.
2. **Source fidelity** — the external database's original spelling, common name variant, or plant part is preserved exactly as it came in, making future reconciliation possible.

When you add a new herb that has `constituent_profiles` rows, always fill in `common_name`, `latin_name`, and `plant_part` even if you also know the `herb_id`. If the herb doesn't exist in `herbs` yet, insert with `herb_id = NULL` and run the re-link UPDATE after the herb row is created (see Case 3 and Case 5 below).

---

## Case 1 — Herb already exists in DB, just adding contraindications

Simplest case. One migration, one UPDATE per herb.

```sql
SET search_path TO herbal, public;

UPDATE herbal.herbs
SET contraindications        = 'Contraindicated in pregnancy. Avoid with anticoagulants.',
    contraindications_source = 'Tilgner'
WHERE latin_name = 'Valeriana officinalis';
```

**Appending to existing text** (if the herb already has contraindications from a different source):
```sql
UPDATE herbal.herbs
SET contraindications        = contraindications || ' ' || 'Additional note from Hoffmann: avoid in liver disease.',
    contraindications_source = contraindications_source || ' / Hoffmann'
WHERE latin_name = 'Valeriana officinalis';
```

---

## Case 2 — Herb exists in DB, adding body system actions

Use the `ensure_action` helper (creates the action if it doesn't exist).

```sql
SET search_path TO herbal, public;

DO $$
DECLARE
  v_herb_id   INTEGER;
  v_sys_id    INTEGER;
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Valeriana officinalis';
  IF v_herb_id IS NULL THEN RAISE NOTICE 'Herb not found'; RETURN; END IF;

  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Nervous';

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Hypnotic';
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES
    (v_herb_id, v_action_id, v_sys_id,
     'Classic sedative for insomnia; reduces sleep latency without morning grogginess', 'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  RAISE NOTICE 'Valerian actions: done.';
END $$;
```

**Body systems available** (check `SELECT id, name FROM herbal.body_systems ORDER BY name;` for full list):
Cardiovascular · Digestive · Immune · Musculoskeletal · Nervous · Reproductive - Female · Reproductive - Male · Respiratory - Lower · Respiratory - Upper · Skin · Urinary · Aging · All

**Creating a new primary action** (if not already in the table):
```sql
DO $$ BEGIN PERFORM herbal.ensure_action('Nootropic'); END $$;
```

---

## Case 3 — Herb does NOT exist in DB yet

**Step A** — add to `herbs` table (migration N):
```sql
SET search_path TO herbal, public;

INSERT INTO herbal.herbs (common_name, latin_name, plant_part)
VALUES ('Motherwort', 'Leonurus cardiaca', 'Aerial parts')
ON CONFLICT DO NOTHING;

-- If it also has constituent_profiles rows, link them:
UPDATE herbal.constituent_profiles cp
SET herb_id = h.id
FROM herbal.herbs h
WHERE cp.latin_name = h.latin_name
  AND cp.herb_id IS NULL;
```

**Step B** — populate data (migration N+1, same pattern as Case 2):
```sql
DO $$
DECLARE
  v_herb_id INTEGER;
  ...
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Leonurus cardiaca';
  ...
END $$;
```

---

## Case 4 — Batch of herbs from a book chapter

When working through a block of text (like a chapter of Tilgner), one migration per batch:

1. Identify which herbs from the text are already in the DB and which are missing:
   ```sql
   SELECT common_name, latin_name FROM herbal.herbs WHERE latin_name IN ('X','Y','Z');
   ```
2. Add any missing herbs first (Case 3 Step A).
3. Run a second migration for all the data — one DO block per herb.
4. Always set `contraindications_source` whenever you set `contraindications`.

---

## Case 5 — Adding `constituent_profiles` rows for an herb

Each row corresponds to one compound entry from the Herb Constituent Database. Always populate `common_name`, `latin_name`, and `plant_part` (the source columns) even when `herb_id` is known.

**If the herb already exists in `herbs`:**
```sql
SET search_path TO herbal, public;

DO $$
DECLARE v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Spilanthes acmella';
  IF v_herb_id IS NULL THEN RAISE NOTICE 'Herb not found'; RETURN; END IF;

  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes)
  VALUES
    (v_herb_id, 'Spilanthes', 'Spilanthes acmella', 'Aerial parts', 'spilanthol', 'Alkamide', 'N-alkylamide', 'High', 'Marker', 'Primary bioactive; responsible for tingling sensation'),
    (v_herb_id, 'Spilanthes', 'Spilanthes acmella', 'Aerial parts', 'echinacoside', 'Phenylpropanoid', 'Caffeic acid derivative', 'Moderate', 'Present', NULL)
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Spilanthes constituent_profiles: done.';
END $$;
```

**If the herb does NOT exist yet** — insert with `herb_id = NULL`, then re-link after the herb row is created:
```sql
-- Step 1: insert profiles with herb_id NULL
INSERT INTO herbal.constituent_profiles
  (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes)
VALUES
  (NULL, 'Spilanthes', 'Spilanthes acmella', 'Aerial parts', 'spilanthol', 'Alkamide', 'N-alkylamide', 'High', 'Marker', NULL)
ON CONFLICT DO NOTHING;

-- Step 2: after the herb exists in herbs, re-link
UPDATE herbal.constituent_profiles cp
SET herb_id = h.id
FROM herbal.herbs h
WHERE cp.latin_name = h.latin_name
  AND cp.herb_id IS NULL;
```

**`status` values** (controls sort order and badge color in UI):
- `Marker` — chemotaxonomic marker / defining compound for this herb
- `Major` — consistently present in significant quantity
- `Present` — reliably found but not defining
- `Reported` — found in at least one study; may not be consistent

**`importance` values**: `High | Moderate | Low | Low-Moderate`

---

## Case 6 — Adding `herb_constituents` rows (General Constituents)

These are the curated, concentration-weighted compound links that appear as colored pills in the **General Constituents** UI section. The underlying `constituents` table is a **shared global dictionary** — compounds like `rutin`, `quercetin`, or `rosmarinic acid` each exist once and link to dozens of herbs, which is why the section is called "General". When you add an herb, you are not creating isolated data but plugging it into a cross-herb phytochemical network.

**Data sources for General Constituents**: Claude may research compound classifications, categories, and biological activity descriptions from the general internet (PubChem, PhytoHub, published literature, etc.) when building `herb_constituents` data. The exception is the specific `constituent_profiles` data the user provides at the start of the process — that should be taken as given and not substituted or second-guessed from web sources.

### Step 1 — Check what already exists in `constituents`

Before calling `ensure_constituent`, check whether a compound is already in the dictionary. Re-using an existing entry is preferred — it keeps the cross-herb count accurate and avoids near-duplicate names.

```sql
-- See if a compound name or partial name already exists
SELECT id, name, category FROM herbal.constituents
WHERE name ILIKE '%spilanthol%'
ORDER BY name;

-- Or browse by category
SELECT id, name, category FROM herbal.constituents
WHERE category ILIKE '%alkamide%'
ORDER BY name;
```

If a compound already exists, use it directly (no `ensure_constituent` call needed):
```sql
SELECT id INTO v_c FROM herbal.constituents WHERE name = 'quercetin';
```

### Step 2 — Map concentration levels

Use this mapping (consistent with migrations 103, 145, 154):

| `constituent_profiles.status` | `constituent_profiles.importance` | `concentration_level` |
|---|---|---|
| `Marker` | any | `major` (or `primary` if it overwhelmingly defines the herb) |
| `Major` | `High` | `major` |
| `Major` / `Present` | `Moderate` | `moderate` |
| `Present` | `Low` / `Low-Moderate` | `minor` |
| `Reported` | any | `trace` |

Use `primary` only for a compound that is the singular defining constituent of the herb (e.g., spilanthol in Spilanthes, sinigrin in Black Mustard).

### Step 3 — Write the migration block

```sql
SET search_path TO herbal, public;

DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := (SELECT id FROM herbal.herbs WHERE latin_name = 'Spilanthes acmella');
  v_c INTEGER;
BEGIN
  -- New constituent not yet in DB: create it
  v_c := herbal.ensure_constituent(
    'spilanthol',
    'N-alkylamide',
    'Primary bioactive alkamide of Spilanthes acmella; responsible for the characteristic tingling sensation and immune-stimulating activity.'
  );
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'primary', 'Marker. Defines the herb''s characteristic tingling and immunostimulant activity.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Constituent already in DB: look it up
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'quercetin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', NULL, 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Spilanthes herb_constituents: done.';
END $$;
```

Alternatively, for herb-lookup-by-name rather than hardcoded id:
```sql
-- Using the link_constituent helper (looks up herb by latin_name internally):
PERFORM herbal.ensure_constituent('spilanthol', 'N-alkylamide', '...');
PERFORM herbal.link_constituent('Spilanthes acmella', 'spilanthol', 'primary', 10);
PERFORM herbal.link_constituent('Spilanthes acmella', 'quercetin',  'moderate', 20);
```

### Conventions
- `sort_order` — use multiples of 10 (10, 20, 30…). Higher concentration levels should come first in sort order.
- `notes` on `herb_constituents` — write herb-specific context (e.g., "highest in roots", "responsible for tingling"), not just a repeat of the constituent's `description`. Leave NULL if there is nothing herb-specific to add.
- `ensure_constituent` `description` — write what the compound *does* biologically, not where it is found. Keep it one sentence.
- Only include compounds that are meaningful for this herb's chemistry or cross-herb matching. Do not pad with ubiquitous nutrients (vitamins, minerals) unless they are genuinely distinctive.

---

## Case 7 — Inferring energetics from constituents

After `herb_constituents` is populated, apply the rules in [inferring-energetics-from-constituents.md](inferring-energetics-from-constituents.md) to assign a first-pass `temperature` and `moisture`. Always mark inferred values with the `_inferred` flag — they render at reduced opacity in the UI.

**Do this even if a source book provides confirmed energetics** — set the confirmed values first, then skip inference for those dimensions. Inference only fills dimensions that have no source-confirmed value.

```sql
-- Inferred values — both dimensions uncertain from source
UPDATE herbal.herbs
SET temperature = 'warming', temperature_inferred = true,
    moisture    = 'drying',  moisture_inferred    = true
WHERE latin_name = 'Spilanthes acmella';

-- Mixed — temperature confirmed from source, moisture inferred
UPDATE herbal.herbs
SET temperature = 'cooling',                        -- from Tilgner/Hoffmann etc.
    moisture    = 'drying', moisture_inferred = true -- inferred from monoterpene presence
WHERE latin_name = 'Spilanthes acmella';
```

**Do not infer tone** — no constituent-level rules exist for it. Only assign tone from a clinical source.

**Do not infer when** the constituent data is sparse (fewer than 3 compounds in `herb_constituents`), or when warming and cooling signals are present at comparable concentration levels — leave the field unset rather than guessing.

See [inferring-energetics-from-constituents.md](inferring-energetics-from-constituents.md) for the full rule tables and combined-pattern reference.

---

## Case 8 — Inferring taste from constituents

After `herb_constituents` is populated, apply the rules in [inferring-taste-from-constituents.md](inferring-taste-from-constituents.md) to assign a first-pass `taste`. Always mark inferred values with `taste_inferred = true` — they render at reduced opacity in the UI.

**Do this even if a source book provides a confirmed taste** — set the confirmed value first, then skip inference for that herb. Inference only fills herbs where `taste IS NULL`.

```sql
-- Inferred taste
UPDATE herbal.herbs
SET taste = 'bitter', taste_inferred = true
WHERE latin_name = 'Gentiana lutea'
  AND taste IS NULL;
```

**Do not infer sour or salty** — no reliable constituent-level rules exist for them. Only assign those values from a clinical source.

**Do not infer when** the constituent data is sparse (fewer than 3 compounds in `herb_constituents`), or when bitter and pungent signals are present at comparable concentration levels — leave `taste` unset rather than guessing.

See [inferring-taste-from-constituents.md](inferring-taste-from-constituents.md) for the full bitter/pungent/sweet rule tables, confidence levels, and conflict-resolution hierarchy.

---

## Case 9 — Adding `herb_menstruum` (best menstruum from constituents)

The `herb_menstruum` table stores the recommended extraction solvent for each herb. One row per herb, upserted via the `set_menstruum` helper.

### Constituent-to-menstruum rules

Use these rules to derive the alcohol range and water/vinegar/glycerin flags from the herb's constituent profile:

| Constituent class | Extraction | Notes |
|---|---|---|
| Volatile oils (monoterpenes, sesquiterpenes, eugenol, etc.) | 50–70% alcohol | Evaporate with heat; don't rely on hot water alone |
| Resins | 70–95% alcohol | Highly lipophilic; water is ineffective |
| Triterpenes / sterols | 60–75% alcohol | Lipophilic; require high alcohol |
| Isoquinoline alkaloids (berberine, sanguinarine, etc.) | 40–65% + 5–10% vinegar | Vinegar forms soluble salt; low pH improves extraction |
| Other alkaloids (tropane, quinolizidine, indole, etc.) | 40–65% + 5–10% vinegar | Same principle |
| Polysaccharides / beta-glucans | water decoction | Insoluble in alcohol; hot water required |
| Mucilage | cold or warm water | Heat-stable but avoid high alcohol |
| Cardiac / anthraquinone glycosides | 25–50% alcohol or water | Moderate alcohol or water decoction |
| Flavonoids / phenylpropanoids (caffeic acid, rosmarinic acid) | 25–60% alcohol or water | Broad solubility |
| Iridoid glycosides | 25–50% alcohol or cold water | Some are heat-labile — prefer cold |
| Saponins (steroidal, triterpenoid) | 40–60% alcohol | Moderate alcohol; add 5–10% vinegar for steroidal saponins |
| Tannins | water or 25–40% alcohol | Precipitate in high alcohol |

**Vinegar** (5–10%) is indicated only when alkaloid salt formation is needed — not as a default.

**`water_effective = true`** when water extraction produces meaningful therapeutic activity, not just a trace. Set for polysaccharide-dominant herbs, herbs used traditionally as tea/decoction, and flavonoid/rosmarinic-acid-dominant herbs.

**`primary_label`** is the short string shown in the UI — format as `'50–70% alcohol'`, `'water decoction'`, `'50–70% alcohol or water infusion'`, `'45–60% alcohol + 5–10% vinegar'`, etc. Use an en-dash (–) not a hyphen (-) for ranges.

### Migration pattern

Use the `set_menstruum` helper (upserts — safe to re-run):

```sql
SET search_path TO herbal, public;

DO $$
BEGIN
  PERFORM herbal.set_menstruum(
    'Ocimum sanctum',                       -- latin_name
    50::SMALLINT,                           -- alcohol_pct_min
    70::SMALLINT,                           -- alcohol_pct_max
    NULL,                                   -- glycerin_pct
    NULL,                                   -- vinegar_pct
    true,                                   -- water_effective
    '50–70% alcohol or water infusion',     -- primary_label
    'Volatile oils (eugenol, linalool, β-caryophyllene) and triterpenes (ursolic acid) extract in moderate-high alcohol; flavonoids and rosmarinic acid extract in both alcohol and water. Traditional Ayurvedic use as leaf infusion.',
    false                                   -- needs_review
  );
  RAISE NOTICE 'Holy Basil menstruum: done.';
END $$;
```

Or direct INSERT (for a herb with no existing record):
```sql
INSERT INTO herbal.herb_menstruum
  (herb_id, alcohol_pct_min, alcohol_pct_max, water_effective, primary_label, notes)
VALUES (
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Ocimum sanctum'),
  50, 70, true,
  '50–70% alcohol or water infusion',
  'Volatile oils and triterpenes require moderate-high alcohol; flavonoids and rosmarinic acid are effective in water.'
)
ON CONFLICT (herb_id) DO NOTHING;
```

### When to set `needs_review = true`

- The herb has conflicting phytochemical signals (e.g., both polysaccharides and resins)
- Clinical literature specifies a preparation that differs from the phytochemical inference
- Fewer than 3 meaningful constituents in `herb_constituents` — inference is low-confidence

---

## Checking external references when adding a new herb

**Do this automatically** — when a new herb is added to the DB (with or without constituent data), check both external reference books without waiting to be asked. The checks are fast; the omission is hard to notice later.

---

### 1. MM Materia Medica

The MM text file is at:
```
/Users/chadarmstrong/Library/Mobile Documents/com~apple~CloudDocs/Archive/Classes/Health and Plants/BHC/Apprenticeship/App/MM_Materia_Medica.txt
```
The parser that regenerates the manifest is at `scripts/parse-mm-materia-medica.py`.

**Step 1** — Search the MM file for the herb:
```bash
grep -i "spilanthes\|acmella\|paracress" \
  "/Users/chadarmstrong/Library/Mobile Documents/com~apple~CloudDocs/Archive/Classes/Health and Plants/BHC/Apprenticeship/App/MM_Materia_Medica.txt"
```

**Step 2** — If an entry exists (or might exist under a genus-only or synonym name), add the mapping to `SYNONYM_MAP` in `scripts/parse-mm-materia-medica.py`. Explicitly map to `[]` if confirmed absent:
```python
'spilanthes':  ['spilanthes acmella'],  # found
# or:
'spilanthes':  [],                       # confirmed absent
```

**Step 3** — Re-run the parser. It regenerates `lib/mm-materia-medica.ts` in place:
```bash
python3 "herbal-visualizer/scripts/parse-mm-materia-medica.py"
```

If the herb is absent from MM, add the `[]` entry anyway so future runs don't need to re-investigate.

---

### 2. Stockley's Drug Interactions

The PDF is at `/Users/chadarmstrong/Downloads/herbal_medicines_interactions-1.pdf`.
A pre-built herb→pages map (all 153 herb sections) is saved at `scripts/stockleys_herb_pages.json` — use this first before touching the PDF.

**Step 1** — Check the map:
```bash
python3 -c "
import json
with open('herbal-visualizer/scripts/stockleys_herb_pages.json') as f:
    m = json.load(f)
search = 'spilanthes'  # try common name, latin name, alternate names
hits = {k: v for k, v in m.items() if search.lower() in k.lower()}
print(hits or 'not found')
"
```

**Step 2** — If found, extract the pages as 150 DPI JPEG images:
```python
import subprocess, os, glob

PDF     = "/Users/chadarmstrong/Downloads/herbal_medicines_interactions-1.pdf"
herb_id = 999          # replace with the actual DB id
pages   = [22, 23]     # from the JSON map entry
out_dir = f"public/contraindications/{herb_id}"
os.makedirs(out_dir, exist_ok=True)

for page_num, pdf_page in enumerate(pages, 1):
    out_jpg = f"{out_dir}/page_{page_num:02d}.jpg"
    if os.path.exists(out_jpg):
        continue
    tmp = f"/tmp/stock_{herb_id}_{pdf_page}"
    subprocess.run(['/opt/homebrew/bin/pdftoppm', '-r', '150',
                    '-f', str(pdf_page), '-l', str(pdf_page),
                    '-jpeg', '-jpegopt', 'quality=85', PDF, tmp])
    matches = glob.glob(f"{tmp}*.jpg")
    if matches:
        os.rename(matches[0], out_jpg)
```

**Step 3** — Add to `lib/contraindications-manifest.ts` in alphabetical position:
```typescript
herb_id: page_count,  // HerbCommonName
```

If the herb is not in Stockley's, no action needed — the book covers 153 herb sections and many common herbs are absent.

---

## Migration file naming

```
NNN_description.sql
```
Current highest: **108**. Next free: **109**.

Files go in `supabase/migrations/`. The user runs them manually in the Supabase SQL Editor.

---

## Quick checklist for each herb block from a book

- [ ] Does the herb exist in `herbs`? If not, add it first.
- [ ] Energetics stated in text? Set `temperature` / `moisture` / `tone`.
- [ ] Contraindications paragraph? Set `contraindications` + `contraindications_source`.
- [ ] "Use:" list mapped to primary actions + body systems? Use `herb_primary_actions`.
- [ ] Any actions in the "Use:" list that don't exist in `primary_actions`? Use `ensure_action`.
- [ ] Remaining descriptive actions better as secondary tags? Use `herb_secondary_actions` with body_system_id = 'All'.
- [ ] Constituent profile data provided? Insert into `constituent_profiles` (see Case 5). Always populate `common_name`, `latin_name`, `plant_part` even when `herb_id` is set.
- [ ] After inserting a new herb + its profiles in separate steps, run the re-link UPDATE to set `herb_id` on any NULL-linked profile rows.
- [ ] General constituents data provided? Before writing `ensure_constituent` calls, query `herbal.constituents` to find compounds that already exist — re-use them rather than duplicating. Then insert into `herb_constituents` via `link_constituent` or direct INSERT (see Case 6).
- [ ] Energetics inferred from `herb_constituents`? Apply rules from `inferring-energetics-from-constituents.md` after constituents are added. Set `temperature_inferred = true` / `moisture_inferred = true` for any inferred dimension. Do not infer tone. Skip inference if fewer than 3 constituents or conflicting signals (see Case 7).
- [ ] Taste inferred from `herb_constituents`? Apply rules from `inferring-taste-from-constituents.md` after constituents are added. Set `taste_inferred = true` for inferred values. Do not infer sour or salty. Skip if fewer than 3 constituents or signals conflict (see Case 8).
- [ ] Best menstruum recorded? Check `SELECT * FROM herbal.herb_menstruum WHERE herb_id = v_herb_id`. If missing, apply the constituent-to-menstruum rules to set alcohol range, `water_effective`, and `primary_label` via `set_menstruum` (see Case 9).
- [ ] All INSERTs use `ON CONFLICT ... DO NOTHING` (migrations must be re-runnable).
- [ ] MM Materia Medica checked — grep the MM text file, update `SYNONYM_MAP` in `parse-mm-materia-medica.py`, re-run the parser (see "Checking external references").
- [ ] Stockley's checked — search `scripts/stockleys_herb_pages.json`; if found, extract images and add to `lib/contraindications-manifest.ts`.

---

## Mapping common book terminology to DB actions

| Book term | DB primary action name |
|---|---|
| Antiseptic | Antimicrobial |
| Anxiolytic | Nervine Relaxant |
| Venotonic | Vascular Tonic |
| Cardioprotective | Cardiotonic |
| Lymphatic stimulant | Lymphatic |
| Urinary antiseptic | Antimicrobial (in Urinary body system) |
| Bulking agent | Laxative (with Demulcent) |
| Nootropic | Nootropic (added in migration 107) |
| Hypoglycemic | Hypoglycemic (added in migration 107) |
| Styptic | Styptic (added in migration 107) |
