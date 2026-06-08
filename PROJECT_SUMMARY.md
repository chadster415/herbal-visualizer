# Project Summary: Herbal Medicine Visualizer

## What This Is

A Next.js app backed by a local Supabase instance that visualizes herbal medicine data from BHC Apprenticeship class materials. Data is organized by body system → disorders → herbs → actions. Protected by a Cloudflare Turnstile gateway.

**Live at:** `http://localhost:3000` (run `pnpm dev`)

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Frontend | Next.js 15 + React 19, App Router |
| Styling | Tailwind CSS |
| Language | TypeScript |
| Database | PostgreSQL via Supabase (`herbal` schema) |
| DB Client | Supabase JS |
| Package Manager | pnpm (`/opt/homebrew/bin/pnpm`) |
| Auth | Cloudflare Turnstile (gateway page) |

---

## File Structure

```
herbal-visualizer/
├── app/
│   ├── page.tsx                    — Main app shell, tab switching, back-nav history
│   ├── layout.tsx
│   ├── globals.css
│   ├── gateway/page.tsx            — Turnstile verification gate
│   └── api/
│       ├── verify-turnstile/       — Validates Turnstile token, sets _hv_verified cookie
│       ├── disorder-images/        — Serves disorder-related images
│       └── health/                 — Health check endpoint
│
├── components/
│   ├── HerbView.tsx                — Browse/search herbs; detail card with energetics, monograph link, elder badge
│   ├── ActionView.tsx              — Browse by primary action; shows herbs per action per system
│   ├── SystemView.tsx              — Browse body systems → disorders → herbs
│   ├── DisorderView.tsx            — Disorder detail: notes, actions indicated, specific remedies, prescriptions
│   ├── FlashcardModal.tsx          — Herb flashcard study mode
│   ├── EnergeticsQuizModal.tsx     — Quiz on herb energetics (temperature/moisture/tone)
│   ├── HerbFilterPanel.tsx         — Multi-filter panel (system, action, energetics, elder)
│   └── TextPageLinks.tsx           — Links to BHC class text pages
│
├── lib/supabase.ts                 — Supabase client (uses herbal schema)
├── middleware.ts                   — Redirects to /gateway if _hv_verified cookie missing
├── types/database.ts               — TypeScript types
└── supabase/migrations/            — 057 migrations (numbered, run manually in SQL Editor)
```

---

## View Modes (tabs in main app)

| Tab | Component | What it shows |
|-----|-----------|---------------|
| Herb | `HerbView` | Search herbs by name; detail card with actions, systems, energetics, monograph URL, elder badge |
| Action | `ActionView` | Browse primary actions; herbs grouped under each action by system |
| System | `SystemView` + `DisorderView` | Body systems → disorders → herbs grouped by action; disorder detail with prescriptions |

Additional modals: **Flashcards** (herb study), **Energetics Quiz**, **Filter Herbs** panel.

---

## Database Schema (`herbal` schema)

### Enum Types

```sql
herbal.strength_level       — 'mild' | 'moderate' | 'strong' | 'very_strong'
herbal.temperature_energetic — 'warming' | 'cooling' | 'neutral'
herbal.moisture_energetic    — 'moistening' | 'drying' | 'neutral'
herbal.tone_energetic        — 'toning' | 'relaxing' | 'neutral'
```

### Core Herb Tables

```sql
herbal.herbs
  id              SERIAL PK
  latin_name      TEXT UNIQUE NOT NULL
  common_name     TEXT NOT NULL
  temperature     temperature_energetic NOT NULL DEFAULT 'neutral'
  moisture        moisture_energetic    NOT NULL DEFAULT 'neutral'
  tone            tone_energetic        NOT NULL DEFAULT 'neutral'
  monograph_url   TEXT                  -- link to BHC Google Doc monograph
  created_at      TIMESTAMPTZ

herbal.primary_actions
  id          SERIAL PK
  name        TEXT UNIQUE NOT NULL
  description TEXT

herbal.secondary_actions
  id    SERIAL PK
  name  TEXT UNIQUE NOT NULL

herbal.body_systems
  id    SERIAL PK
  name  TEXT UNIQUE NOT NULL
  -- Values: GI, Immune, Lower Respiratory, Upper Respiratory, Nervous,
  --         Cardiovascular, Reproductive - Female, Reproductive - Male,
  --         Aging, All (sentinel for global secondary actions),
  --         and legacy: Digestive, Respiratory, Urinary, Musculoskeletal, Skin

herbal.herb_primary_actions
  id                SERIAL PK
  herb_id           → herbs
  primary_action_id → primary_actions
  body_system_id    → body_systems (nullable)
  body_system_note  TEXT
  relative_strength strength_level
  UNIQUE (herb_id, primary_action_id, body_system_id)

herbal.herb_secondary_actions
  id                  SERIAL PK
  herb_id             → herbs
  secondary_action_id → secondary_actions
  body_system_id      → body_systems NOT NULL (use 'All' for global)
  UNIQUE (herb_id, secondary_action_id, body_system_id)
```

### Disorder System Tables

```sql
herbal.disorders
  id             SERIAL PK
  name           TEXT NOT NULL
  body_system_id → body_systems
  sort_order     INTEGER
  UNIQUE (name, body_system_id)

herbal.disorder_notes
  id          SERIAL PK
  disorder_id → disorders
  note_text   TEXT
  sort_order  INTEGER

herbal.disorder_actions_indicated
  id                SERIAL PK
  disorder_id       → disorders
  primary_action_id → primary_actions
  rationale         TEXT
  UNIQUE (disorder_id, primary_action_id)

herbal.disorder_action_herbs
  id                SERIAL PK
  disorder_id       → disorders
  herb_id           → herbs
  primary_action_id → primary_actions
  UNIQUE (disorder_id, herb_id, primary_action_id)

herbal.disorder_specific_remedies
  id          SERIAL PK
  disorder_id → disorders
  herb_id     → herbs
  UNIQUE (disorder_id, herb_id)

herbal.disorder_prescriptions
  id          SERIAL PK
  disorder_id → disorders
  title       TEXT
  dosage      TEXT
  sort_order  INTEGER

herbal.prescription_herbs
  id              SERIAL PK
  prescription_id → disorder_prescriptions
  herb_id         → herbs
  parts           TEXT   -- e.g. "1 part", "2 parts"
  note            TEXT

herbal.prescription_herb_actions
  id                   SERIAL PK
  prescription_herb_id → prescription_herbs
  primary_action_id    → primary_actions
  UNIQUE (prescription_herb_id, primary_action_id)
```

### Special Tables

```sql
herbal.aging_herbs
  herb_id  INTEGER PK → herbs
  -- Flat list of elder-recommended herbs.
  -- Frontend uses this to show the elder badge on Tonic herb cards.
```

### Helper Functions

```sql
-- Get or create an herb by latin name; returns herb_id
herbal.ensure_herb(p_latin_name TEXT, p_common_name TEXT) RETURNS INTEGER

-- Get or create a primary action by name; returns primary_action_id
herbal.ensure_action(p_action_name TEXT) RETURNS INTEGER
```

---

## Body Systems Currently Populated

| System | Migrations |
|--------|-----------|
| GI (Digestive) | 009–015 |
| Immune | 016–026 |
| Upper Respiratory | 027–036 |
| Lower Respiratory | 027–036 |
| Nervous | 038–045 |
| Cardiovascular | 048 |
| Reproductive - Female | 055 |
| Reproductive - Male | 055 |
| Aging | 057 |

---

## Migration Conventions

- Files in `supabase/migrations/`, numbered `001`–`057`
- Always `SET search_path TO herbal, public;` at the top
- Use `ON CONFLICT ... DO NOTHING` — all migrations are re-runnable
- Wrap each logical unit in `DO $$ ... END $$;` blocks
- Use `RAISE NOTICE` for progress feedback
- **User runs migrations manually** in the Supabase SQL Editor — never automate

### Common pattern: add herbs to a body system

```sql
DO $$
DECLARE
  v_system_id INTEGER;
BEGIN
  SELECT id INTO v_system_id FROM herbal.body_systems WHERE name = 'Cardiovascular';

  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  VALUES (
    herbal.ensure_herb('Crataegus spp.', 'hawthorn'),
    herbal.ensure_action('Cardiotonic'),
    v_system_id
  )
  ON CONFLICT DO NOTHING;
END $$;
```

### Sync pattern (after bulk disorder data)

After adding disorder herb data, run a sync block (see migration 035 as reference) to push `disorder_action_herbs` → `herb_primary_actions` so the system herb count stays accurate.

---

## Auth / Access Control

- `middleware.ts` checks for a `_hv_verified` cookie; if missing, redirects to `/gateway`
- `/gateway` shows a Cloudflare Turnstile widget
- `/api/verify-turnstile` validates the token and sets the cookie
- Protects all routes except `/gateway`, `/api/*`, `/_next/*`, `/favicon.ico`

---

## Configuration

**.env.local**
```env
NEXT_PUBLIC_SUPABASE_URL=http://localhost:54321
NEXT_PUBLIC_SUPABASE_ANON_KEY=<anon key from Supabase Studio → Settings → API>
NEXT_PUBLIC_TURNSTILE_SITE_KEY=<Cloudflare Turnstile site key>
TURNSTILE_SECRET_KEY=<Cloudflare Turnstile secret key>
```

Local Supabase runs on `127.0.0.1:54322`, password: `postgres`.

---

## Database Backup

```bash
PGPASSWORD=postgres /opt/homebrew/Cellar/libpq/18.1/bin/pg_dump \
  -h 127.0.0.1 -p 54322 -U postgres -d postgres \
  --schema=herbal --no-owner --no-acl --clean --if-exists \
  --file="supabase/backups/$(date +%Y%m%d_%H%M%S)_description.sql"
```
