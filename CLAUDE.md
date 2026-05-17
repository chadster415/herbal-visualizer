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
| `herbs` | Medicinal herbs — `latin_name` (UNIQUE), `common_name` |
| `primary_actions` | Herbal actions — `name` (UNIQUE), `description` |
| `secondary_actions` | Secondary action tags — `name` (UNIQUE) |
| `body_systems` | Body systems — `name` (UNIQUE) |
| `herb_primary_actions` | Herb ↔ action ↔ body system linkage — UNIQUE on `(herb_id, primary_action_id, body_system_id)` |
| `herb_secondary_actions` | Herb ↔ secondary action — UNIQUE on `(herb_id, secondary_action_id)` |

### Disorder system tables

| Table | Purpose |
|---|---|
| `disorders` | Conditions per body system — `(name, body_system_id)` UNIQUE, has `sort_order` |
| `disorder_notes` | Free-text clinical notes for a disorder, `sort_order` |
| `disorder_actions_indicated` | Which actions are therapeutically indicated for a disorder, with rationale text — `(disorder_id, primary_action_id)` UNIQUE |
| `disorder_action_herbs` | Herbs grouped by action for a specific disorder — `(disorder_id, herb_id, primary_action_id)` UNIQUE |
| `disorder_specific_remedies` | Highlighted "specific remedy" herbs for a disorder — `(disorder_id, herb_id)` UNIQUE |
| `disorder_prescriptions` | Herbal formulas with dosage instructions, `sort_order` |
| `prescription_herbs` | Individual herbs in a prescription with `parts` (e.g., "1 part") and optional `note` |
| `prescription_herb_actions` | Which actions each herb fills in a prescription — `(prescription_herb_id, primary_action_id)` UNIQUE |

### Body systems currently in DB
GI, Immune, Lower Respiratory, Upper Respiratory (and legacy: Cardiovascular, Digestive, Respiratory, Urinary, Reproductive, Musculoskeletal, Nervous, Skin)

## Helper Functions (defined in migration 027, available throughout)

```sql
-- Get or create an herb, returns herb_id
herbal.ensure_herb(p_latin_name TEXT, p_common_name TEXT) RETURNS INTEGER

-- Get or create an action, returns primary_action_id
herbal.ensure_action(p_action_name TEXT) RETURNS INTEGER
```

## Migration Conventions
- Files live in `supabase/migrations/` and are numbered sequentially (currently up to 036)
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
  SELECT id INTO v_system_id FROM herbal.body_systems WHERE name = 'Lower Respiratory';

  v_herb_id := herbal.ensure_herb('Botanical name', 'common name');

  v_action_id := herbal.ensure_action('Expectorant');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (v_herb_id, v_action_id, v_system_id)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
END $$;
```

## Sync Pattern
Migration 035 shows how to sync herbs from `disorder_action_herbs` → `herb_primary_actions` for a system. Run this after bulk-adding disorder data to ensure the system herb count is accurate.

## Backups
```bash
PGPASSWORD=postgres /opt/homebrew/Cellar/libpq/18.1/bin/pg_dump \
  -h 127.0.0.1 -p 54322 -U postgres -d postgres \
  --schema=herbal --no-owner --no-acl --clean --if-exists \
  --file="supabase/backups/YYYYMMDD_HHMMSS_description.sql"
```
