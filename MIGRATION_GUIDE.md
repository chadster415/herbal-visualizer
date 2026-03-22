# Migration Guide for Existing Supabase

Since you already have a running Supabase instance, follow these steps to add the herbal medicine schema.

## Step 1: Run the Schema Migration

1. Open your Supabase Studio at `http://localhost:54323` (or your Supabase URL)
2. Navigate to **SQL Editor**
3. Copy and paste the contents of `supabase/migrations/001_herbal_schema.sql`
4. Click **Run** to execute

This will create:
- A new `herbal` schema (namespace)
- All tables within that schema
- The 8 body systems (pre-populated)

## Step 2: Run the Seed Data

1. Still in the SQL Editor
2. Copy and paste the contents of `supabase/migrations/002_seed_data.sql`
3. Click **Run** to execute

This will populate:
- 562 herbs with Latin and common names
- 21 primary action categories

## Step 3: Verify the Data

Run this query to verify everything loaded correctly:

```sql
-- Check herb count
SELECT COUNT(*) as herb_count FROM herbal.herbs;
-- Should return 562

-- Check primary actions
SELECT COUNT(*) as action_count FROM herbal.primary_actions;
-- Should return 21

-- Check body systems
SELECT * FROM herbal.body_systems;
-- Should return 8 systems

-- Sample query: get all herbs with their actions
SELECT 
  h.common_name,
  h.latin_name,
  pa.name as action,
  bs.name as body_system,
  hpa.relative_strength
FROM herbal.herbs h
LEFT JOIN herbal.herb_primary_actions hpa ON h.id = hpa.herb_id
LEFT JOIN herbal.primary_actions pa ON hpa.primary_action_id = pa.id
LEFT JOIN herbal.body_systems bs ON hpa.body_system_id = bs.id
ORDER BY h.common_name
LIMIT 20;
```

## Step 4: Update Environment Variables

Make sure your `.env.local` file has your Supabase credentials:

```env
NEXT_PUBLIC_SUPABASE_URL=http://localhost:54321
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-actual-anon-key
```

You can find your anon key in Supabase Studio under **Settings > API**.

## Step 5: Start the App

```bash
cd herbal-visualizer
pnpm dev
```

Open `http://localhost:3000`

## Schema Isolation

The `herbal` schema keeps this project's data completely separate from other projects in your Supabase instance. All tables are prefixed with the schema name:

- `herbal.herbs`
- `herbal.primary_actions`
- `herbal.body_systems`
- `herbal.herb_primary_actions`
- etc.

## Troubleshooting

### Permission Errors
If you get permission errors, run this in SQL Editor:

```sql
GRANT USAGE ON SCHEMA herbal TO postgres, anon, authenticated, service_role;
GRANT ALL ON ALL TABLES IN SCHEMA herbal TO postgres, anon, authenticated, service_role;
GRANT ALL ON ALL SEQUENCES IN SCHEMA herbal TO postgres, anon, authenticated, service_role;
```

### View All Schemas
To see all schemas in your database:

```sql
SELECT schema_name 
FROM information_schema.schemata 
ORDER BY schema_name;
```

### Drop Schema (if needed)
To completely remove the herbal schema:

```sql
DROP SCHEMA herbal CASCADE;
```

**Warning**: This will delete all herbal medicine data!

## File Locations

- Schema: `supabase/migrations/001_herbal_schema.sql`
- Seed Data: `supabase/migrations/002_seed_data.sql`
- Parser Script: `scripts/parse-data.ts`
