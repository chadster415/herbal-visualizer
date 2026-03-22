# Herbal Medicine Visualizer

A Next.js application for visualizing multi-dimensional herbal medicine data with three different view modes: by herb, by action, and by body system.

## Features

- **By Herb View**: Browse all herbs and see their primary actions, body systems, and relative strengths
- **By Action View**: View herbs grouped by their herbal actions (Alteratives, Adaptogens, etc.)
- **By Body System View**: See which herbs affect each body system (Cardiovascular, Respiratory, etc.)
- Search and filter functionality
- Responsive design with Tailwind CSS
- Local Supabase database for data management

## Tech Stack

- Next.js 15 with App Router
- React 19
- TypeScript
- Tailwind CSS
- Supabase (local)
- pnpm

## Getting Started

### Prerequisites

- Node.js 20+
- pnpm (or npm/yarn)
- Running Supabase instance (local or cloud)

### Installation

1. Install dependencies:
```bash
pnpm install
```

2. Set up the database schema:

Since this uses a dedicated `herbal` schema, you can run it on your existing Supabase instance without conflicts.

**Option A: One-Step SQL (Easiest)**
1. Open Supabase Studio at `http://localhost:54323` (or your Supabase URL)
2. Go to **SQL Editor**
3. Copy and paste the entire `supabase/migrations/complete_setup.sql` file
4. Click **Run**

**Option B: Step-by-step**
1. Run `supabase/migrations/001_herbal_schema.sql` (creates schema and tables)
2. Run `supabase/migrations/002_seed_data.sql` (loads 562 herbs and actions)

See [MIGRATION_GUIDE.md](MIGRATION_GUIDE.md) for detailed instructions.

3. Update your `.env.local` with your Supabase credentials:
```env
NEXT_PUBLIC_SUPABASE_URL=http://localhost:54321
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
```

4. Start the development server:
```bash
pnpm dev
```

5. Open [http://localhost:3000](http://localhost:3000) in your browser.

## Database Schema

The application uses a dedicated `herbal` schema (namespace) to keep data isolated from other projects. Tables include:

- `herbal.herbs` - Latin and common names of medicinal herbs
- `herbal.primary_actions` - Herbal action categories (Alteratives, Adaptogens, etc.)
- `herbal.secondary_actions` - Secondary herbal properties
- `herbal.body_systems` - Body systems (Cardiovascular, Respiratory, etc.)
- `herbal.herb_primary_actions` - Junction table linking herbs to actions and systems
- `herbal.herb_secondary_actions` - Junction table for secondary herb properties

This schema-based approach means you can safely run this alongside other projects in the same Supabase database.

## Data Source

The data is parsed from "Secondary Actions.txt" which contains comprehensive information about:
- 562 herbs with their Latin and common names
- 21 primary herbal action categories
- Body system affinities for each herb
- Relative strength ratings (mild, strong, very strong)

## Project Structure

```
herbal-visualizer/
├── app/
│   ├── globals.css
│   ├── layout.tsx
│   └── page.tsx
├── components/
│   ├── HerbView.tsx
│   ├── ActionView.tsx
│   └── SystemView.tsx
├── lib/
│   └── supabase.ts
├── types/
│   └── database.ts
├── scripts/
│   └── parse-data.ts
└── supabase/
    └── migrations/
        ├── 001_initial_schema.sql
        └── 002_seed_data.sql
```

## Usage

1. **By Herb**: Search for herbs by common or Latin name, click to see detailed information
2. **By Action**: Browse herbal actions, see which herbs have that action for different body systems
3. **By Body System**: Select a body system to see all herbs that affect it, grouped by action

## Development

To regenerate the seed data from the text file:

```bash
pnpm exec ts-node scripts/parse-data.ts
```

This will update `supabase/migrations/002_seed_data.sql`.

## License

MIT
