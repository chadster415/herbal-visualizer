# Herbal Visualizer — Claude Context

## Project Overview
A Next.js app backed by a local Supabase instance that visualizes herbal medicine data from BHC Apprenticeship class materials. Data is organized by body system → disorders → herbs → actions.

## Tech Stack
- **Frontend**: Next.js (app router), Tailwind CSS, TypeScript
- **Package manager**: pnpm at `/opt/homebrew/bin/pnpm` — always use this, never `npm`
- **Database**: Supabase (PostgreSQL), schema: `herbal`
- **Local Supabase**: runs on `127.0.0.1:54322`, password: `postgres`

## Database Schema (`herbal` schema)

### Core tables

| Table | Purpose |
|---|---|
| `herbs` | Medicinal herbs — UNIQUE on `(latin_name, plant_part)` (NULLS NOT DISTINCT); `common_name`, `plant_part` (NULL = whole herb), `pinyin_name` (TCM), `is_tcm` (bool), energetics cols (`temperature`, `moisture`, `tone`), `monograph_url` |
| `primary_actions` | Herbal actions — `name` (UNIQUE), `description` |
| `secondary_actions` | Secondary action tags — `name` (UNIQUE) |
| `body_systems` | Body systems — `name` (UNIQUE) |
| `body_system_notes` | System-level intro notes (the `# Notes` section above disorders) — `(body_system_id, sort_order)` UNIQUE |
| `herb_primary_actions` | Herb ↔ action ↔ body system linkage — UNIQUE on `(herb_id, primary_action_id, body_system_id)` |
| `herb_secondary_actions` | Herb ↔ secondary action ↔ body system — UNIQUE on `(herb_id, secondary_action_id, body_system_id)`; use `body_system_id` = 'All' for global |
| `aging_herbs` | Flat list of elder-recommended herb IDs — used to show elder badge in frontend |
| `action_pattern` | Maps each primary action to `'deficiency'` or `'excess'` pattern — used by intake assessment |

### Constituent tables

| Table | Purpose |
|---|---|
| `constituents` | Unique chemical constituents (`name` UNIQUE, `category`, `description`) |
| `herb_constituents` | Herb ↔ constituent join — `(herb_id, constituent_id)` UNIQUE; `concentration_level` enum, `notes`, `needs_review`, `sort_order` |
| `herb_menstruum` | One row per herb — recommended menstruum (alcohol %, glycerin %, vinegar %, water); `primary_label` short string for UI |
| `constituent_profiles` | Flat import from Herb Constituent Database CSV — `herb_id` (nullable), `common_name`, `latin_name`, `plant_part`, `constituent`, `class`, `subclass`, `importance`, `status` (Marker/Major/Present/Reported), `notes`, `editorial_note` |

### TCM / Dui Yao tables

| Table | Purpose |
|---|---|
| `dui_yao_pairs` | TCM herb pairs — `(herb1_id, herb2_id)` UNIQUE; `book_page`, `image_file`, `combined_summary` |
| `dui_yao_indications` | Major indications per pair — `pair_id`, `indication`, `sort_order` |
| `dui_yao_herb_properties` | Per-herb properties within a pair — `pair_id`, `herb_id`, `property`, `sort_order` |

### Disorder system tables

| Table | Purpose |
|---|---|
| `disorders` | Conditions per body system — `(name, body_system_id)` UNIQUE, has `sort_order` |
| `disorder_notes` | Free-text clinical notes for a disorder — `sort_order`, `section` ('general' default, or 'actions_indicated') |
| `disorder_actions_indicated` | Which actions are therapeutically indicated for a disorder, with rationale text — `(disorder_id, primary_action_id)` UNIQUE |
| `disorder_action_herbs` | Herbs grouped by action for a specific disorder — `(disorder_id, herb_id, primary_action_id)` UNIQUE |
| `disorder_specific_remedies` | Highlighted "specific remedy" herbs for a disorder — `(disorder_id, herb_id)` UNIQUE |
| `disorder_prescriptions` | Herbal formulas with dosage instructions, `sort_order` |
| `prescription_herbs` | Individual herbs in a prescription with `parts` (e.g., "1 part") and optional `note` |
| `prescription_herb_actions` | Which actions each herb fills in a prescription — `(prescription_herb_id, primary_action_id)` UNIQUE |

### Enum types
- `herbal.strength_level` — `'mild' | 'moderate' | 'strong' | 'very_strong'`
- `herbal.temperature_energetic` — `'warming' | 'cooling' | 'neutral'`
- `herbal.moisture_energetic` — `'moistening' | 'drying' | 'neutral'`
- `herbal.tone_energetic` — `'toning' | 'relaxing' | 'neutral'`
- `herbal.concentration_level` — `'trace' | 'minor' | 'moderate' | 'major' | 'primary'`

### Body systems currently populated
GI, Immune, Respiratory - Lower, Respiratory - Upper, Nervous, Cardiovascular, Reproductive - Female, Reproductive - Male, Aging, Urinary, Skin, Musculoskeletal
(Also present but legacy/sparse: All (sentinel for global secondary actions), Digestive, Respiratory - Overall)

## Helper Functions

```sql
-- Get or create an herb with no specific plant part (null part), returns herb_id
herbal.ensure_herb(p_latin_name TEXT, p_common_name TEXT) RETURNS INTEGER

-- Get or create a part-specific herb (e.g., dandelion 'root' vs 'leaf'), returns herb_id
herbal.ensure_herb(p_latin_name TEXT, p_common_name TEXT, p_plant_part TEXT) RETURNS INTEGER

-- Get or create an action, returns primary_action_id
herbal.ensure_action(p_action_name TEXT) RETURNS INTEGER

-- Get or create a constituent, returns constituent_id
herbal.ensure_constituent(p_name TEXT, p_category TEXT, p_desc TEXT DEFAULT NULL) RETURNS INTEGER

-- Link a constituent to an herb by latin name (no-op if herb not found)
herbal.link_constituent(p_latin_name TEXT, p_constituent_name TEXT,
  p_level herbal.concentration_level DEFAULT 'moderate',
  p_sort_order INTEGER DEFAULT 0, p_notes TEXT DEFAULT NULL,
  p_needs_review BOOLEAN DEFAULT FALSE) RETURNS VOID

-- Upsert menstruum row for an herb
herbal.set_menstruum(p_latin_name TEXT, p_alcohol_min SMALLINT DEFAULT NULL,
  p_alcohol_max SMALLINT DEFAULT NULL, p_glycerin_pct SMALLINT DEFAULT NULL,
  p_vinegar_pct SMALLINT DEFAULT NULL, p_water_effective BOOLEAN DEFAULT FALSE,
  p_primary_label TEXT DEFAULT NULL, p_notes TEXT DEFAULT NULL,
  p_needs_review BOOLEAN DEFAULT FALSE) RETURNS VOID
```

## Project Structure

```
herbal-visualizer/
├── app/                          # Next.js app router
│   ├── page.tsx                  # SPA shell — manages view state, renders active view
│   ├── layout.tsx                # Root layout
│   ├── gateway/page.tsx          # Cloudflare Turnstile access gate (bot-check login wall)
│   └── api/
│       ├── health/route.ts       # Health check
│       ├── verify-turnstile/route.ts  # Validates Turnstile token, sets auth cookie
│       └── disorder-images/route.ts   # Serves dui yao pair images from public/
├── components/                   # All UI — all 'use client' React components
│   ├── SystemView.tsx            # Body system panel: system notes + disorder list
│   ├── DisorderView.tsx          # Disorder detail: notes, actions indicated, prescriptions
│   ├── HerbView.tsx              # Herb detail: energetics, actions by system, constituents
│   ├── ActionView.tsx            # Action detail: description, herbs grouped by body system
│   ├── HerbFilterPanel.tsx       # Filter/search sidebar for herbs
│   ├── EnergeticEmojis.tsx       # Energetics icon display (temperature/moisture/tone)
│   ├── TextPageLinks.tsx         # Converts monograph URLs to clickable links in text
│   ├── IntakeFormModal.tsx       # Physiomedicalist intake form → deficiency/excess herb suggestions
│   ├── FormulaBuilderModal.tsx   # Drag-and-drop formula builder
│   ├── FormulaMethodModal.tsx    # Formula extraction method calculator
│   ├── FlashcardModal.tsx        # Herb/action flashcard quiz
│   ├── EnergeticsQuizModal.tsx   # Energetics matching quiz
│   └── BodyDiagramModal.tsx      # Interactive body diagram navigator
├── lib/
│   └── supabase.ts               # Supabase client singleton (@/lib/supabase)
├── types/
│   └── database.ts               # TypeScript types for all DB row shapes
├── scripts/                      # One-off data ingestion scripts (not production)
├── middleware.ts                 # Enforces gateway cookie on all routes except /gateway
├── supabase/
│   ├── config.toml
│   ├── migrations/               # 001–100 SQL files (run manually in Supabase SQL Editor)
│   ├── backups/                  # pg_dump backup files
│   └── snippets/
└── public/                       # Static assets (dui yao pair images: dui_yao/*.jpg)
```

**Navigation model**: `app/page.tsx` is a single-page shell with a `ViewMode` state (`'herb' | 'action' | 'system'`) and a back-stack. It renders `SystemView`, `DisorderView`, `HerbView`, or `ActionView` based on current state. Modals (`IntakeFormModal`, `FormulaBuilderModal`, etc.) are layered on top.

**Auth**: Cloudflare Turnstile (bot-check only, no user accounts). `middleware.ts` checks for a cookie set by `/api/verify-turnstile` — unauthenticated requests redirect to `/gateway`.

## Migration Conventions
- Files live in `supabase/migrations/` and are numbered sequentially (currently up to 100)
- Always set `SET search_path TO herbal, public;` at the top
- Use `ON CONFLICT ... DO NOTHING` everywhere — migrations must be re-runnable
- Wrap each logical unit in its own `DO $$ ... END $$;` block
- Use `RAISE NOTICE` for progress feedback
- **User runs migrations manually** in the Supabase SQL Editor — never automate this

## Common Migration Pattern: Add Herbs to a Body System

```sql
DO $$
DECLARE
  v_system_id INTEGER;
  v_herb_id INTEGER;
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_system_id FROM herbal.body_systems WHERE name = 'Respiratory - Lower';

  -- Whole-herb (no specific part):
  v_herb_id := herbal.ensure_herb('Botanical name', 'common name');

  -- Part-specific herb (e.g., dandelion root vs leaf):
  -- v_herb_id := herbal.ensure_herb('Taraxacum officinale', 'Dandelion', 'root');

  v_action_id := herbal.ensure_action('Expectorant');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
END $$;
```

## Sync Pattern
Migration 035 shows how to sync herbs from `disorder_action_herbs` → `herb_primary_actions` for a system. When disorder data is entered via `prescription_herb_actions` (rather than `disorder_action_herbs`), sync from that table instead:

```sql
INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
SELECT DISTINCT ph.herb_id, pha.primary_action_id, v_sys_id
FROM herbal.prescription_herb_actions pha
JOIN herbal.prescription_herbs ph ON ph.id = pha.prescription_herb_id
JOIN herbal.disorder_prescriptions dp ON dp.id = ph.prescription_id
JOIN herbal.disorders d ON d.id = dp.disorder_id
WHERE d.body_system_id = v_sys_id
ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
```

## Prescription Herbs: parts vs. note
- `parts` = ratio in formula ("1 part", "2 parts") — use NULL if no ratio given
- `note` = qualifier for the individual herb ("root", "leaf", "fresh") — optional
- Example: `Althaea officinalis root - 2 parts` → `parts = '2 parts', note = 'root'`
- Example: `Taraxacum officinale - leaf` (single herb, no ratio) → `parts = NULL, note = 'leaf'`

## BHC Source File Format
Each system `.md` file follows this structure, which maps directly to DB tables:

```
# Notes                      → body_system_notes (one row per paragraph)
# Tonics for the X system    → herb_primary_actions with a tonic-type action
# Primary Actions            → herb_primary_actions (Block 2 of migration)
  ActionName
  Herb1, Herb2, ...

# Disorder: DisorderName     → disorders
## Notes                     → disorder_notes (one row per paragraph)
## Actions Indicated         → disorder_actions_indicated
  ActionName
  rationale text
## Specific Remedies         → disorder_specific_remedies
  Latin name (common name) - description text
## Prescription              → disorder_prescriptions + prescription_herbs
  Herb - N parts
  Title - Dosage: ...
### Actions Supplied         → prescription_herb_actions
  ActionName
  Herb1, Herb2
```

## Full System Import Block Structure (standard 9 blocks)
- **Block 0**: Ensure body system exists (`INSERT INTO body_systems ... ON CONFLICT DO NOTHING`)
- **Block 1**: Body system notes from `# Notes` section — each paragraph = one row, sort_order 10, 20, 30…
- **Block 2**: Primary actions from `# Primary Actions` section — one action per `ensure_action` call
- **Block 3–N**: One block per disorder (notes → actions indicated → specific remedies → prescriptions)
- **Block N+1**: Sync — push `prescription_herb_actions` → `herb_primary_actions` for the system

See migration 096 (Musculoskeletal) as the most recent full-pattern reference. For earlier examples: 062 (Urinary) or 063 (Skin).

## Pre-Import MD Scan Checklist
Before writing a migration, scan the source `.md` file for these common errors:

1. **Disorder header vs. prescription title mismatch** — `# Disorder: Dyseria` but prescription says "A Prescription for Dysuria"; the header is wrong
2. **Capitalized species epithets** — `Zea Mays` should be `Zea mays`; species names are always lowercase
3. **Copied Actions Supplied sections** — verify every herb listed under "### Actions Supplied" actually appears in that prescription's herb list; copy-paste errors are common. Watch especially for herbs mentioned in the dosage instructions (e.g., "An infusion of Urtica dioica should also be drunk") — these are *supplementary* herbs, not formula herbs, and must NOT be entered in `prescription_herb_actions`
4. **`arvensis` vs `arvense`** — the correct epithet for horsetail is *Equisetum arvense*; `arvensis` is a frequent OCR/copy error
5. **`vitamin B,`** — a lost subscript; should be `vitamin B6`
6. **Herbalist name capitalization** — e.g., "Mcintyre" → "McIntyre"
7. **`carminatives` in herb lists** — this is a category, not a herb; skip it when inserting herbs
8. **Common name / latin name mismatches** — e.g., *Alchemilla arvensis* ≠ lady's mantle (that's *Alchemilla vulgaris*); *Alchemilla arvensis* = parsley piert (*Aphanes arvensis*)

## Data Normalization: Known DB Conventions
- `Lycopus sp.` in source files → use `Lycopus spp.` to match existing DB entry
- `Cola vera` is already in DB (from nervous system migration 039) — use that latin name, not `Cola acuminata`
- `Althaea officinalis` common name → `'marshmallow'` (not "marshmallow leaf" or "marshmallow root")
- `Alchemilla vulgaris` common name → `'lady''s mantle'` (matches reproductive system)
- `Aphanes arvensis` common name → `'parsley piert'`
- When a system's `# Primary Actions` section omits Diuretic but Diuretic appears throughout the disorder data, add it in Block 2 using herbs drawn from the "Actions Supplied" sections

### Plant-part split herbs
These herbs exist as multiple rows (one per part) — always use the 3-arg `ensure_herb` for them:

| Latin name | Parts in DB |
|---|---|
| `Taraxacum officinale` | `'leaf'`, `'root'` |
| `Urtica dioica` | `'leaf'` |
| `Symphytum officinale` | `'root'` (comfrey) |
| `Sambucus nigra` | `'berry'`, `'flower'` (elder) |
| `Crataegus spp.` | `'berry'`, `'leaf'` (hawthorn) |

Use source context (e.g., "dandelion root" vs "dandelion leaf") to determine which part to reference. When source is ambiguous, default to the part most clinically associated with the action.

## Backups
```bash
PGPASSWORD=postgres /opt/homebrew/Cellar/libpq/18.1/bin/pg_dump \
  -h 127.0.0.1 -p 54322 -U postgres -d postgres \
  --schema=herbal --no-owner --clean --if-exists \
  --file="supabase/backups/YYYYMMDD_HHMMSS_description.sql"
```
Note: omit `--no-acl` so that GRANT statements are included — required when restoring to prod.

## Restore to prod
```bash
PGPASSWORD='<prod-password>' /opt/homebrew/Cellar/libpq/18.1/bin/psql \
  -h db.<project-ref>.supabase.co -p 5432 -U postgres -d postgres \
  -f "supabase/backups/YYYYMMDD_HHMMSS_description.sql"
```
Use the direct connection (db.*.supabase.co:5432), not the pooler URL, for DDL-heavy restores.
