# Exposing the Herbal Schema to Supabase API

## The Issue

Your data is loaded correctly in the database, but the Supabase REST API can't access the `herbal` schema because it's not in the exposed schemas list.

## Solution

You need to update your Supabase configuration to expose the `herbal` schema.

### Option 1: Update via Supabase Config File (Recommended if using supabase CLI)

If you initialized Supabase with `supabase init`, you should have a config file.

1. Find your `supabase/config.toml` or `.supabase/config.toml`
2. Add `herbal` to the `db_schemas` setting:

```toml
[api]
schemas = ["public", "storage", "graphql_public", "herbal"]
```

3. Restart Supabase:
```bash
supabase stop
supabase start
```

### Option 2: Update Docker Compose (If using standalone Docker)

If you're running Supabase via Docker Compose directly:

1. Find your `docker-compose.yml`
2. Update the PostgREST service environment:

```yaml
rest:
  environment:
    PGRST_DB_SCHEMAS: "public,storage,graphql_public,herbal"
```

3. Restart:
```bash
docker-compose down
docker-compose up -d
```

### Option 3: Quick Fix - Restart Container with Env Var

```bash
# Stop the rest container
docker stop supabase_rest_intake

# Start it with updated schema
docker run -d \
  --name supabase_rest_intake \
  --network supabase_network_intake \
  -e PGRST_DB_SCHEMAS="public,storage,graphql_public,herbal" \
  # ... (copy other env vars from docker inspect supabase_rest_intake)
```

## Verification

After updating, test the connection:

```bash
cd herbal-visualizer
node test-connection.mjs
```

You should see:
```
✅ Herbs count: ...
✅ Garlic data: {...}
✅ Garlic has 3 primary action relationships
```

## Alternative: Use Public Schema Instead

If you don't want to reconfigure Supabase, we can move all tables to the `public` schema:

```sql
-- Move tables to public schema
ALTER TABLE herbal.herbs SET SCHEMA public;
ALTER TABLE herbal.primary_actions SET SCHEMA public;
ALTER TABLE herbal.body_systems SET SCHEMA public;
ALTER TABLE herbal.secondary_actions SET SCHEMA public;
ALTER TABLE herbal.herb_primary_actions SET SCHEMA public;
ALTER TABLE herbal.herb_secondary_actions SET SCHEMA public;

-- Move the enum type
ALTER TYPE herbal.strength_level SET SCHEMA public;

-- Update app config
-- In lib/supabase.ts, remove the schema config:
export const supabase = createClient(supabaseUrl, supabaseAnonKey);
// (remove the db: { schema: 'herbal' } part)
```

This is simpler but loses the schema isolation benefit.

