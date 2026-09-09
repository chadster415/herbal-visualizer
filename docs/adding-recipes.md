# Adding Recipes

Recipes live under body systems and can reference herbs in the database. They appear in three places: the Body System tab ("Recipes"), the Herb detail page ("Recipes" section before My Stock), and as a standalone recipe detail page with image upload.

---

## Database Tables

| Table | Purpose |
|---|---|
| `herbal.recipes` | Recipe metadata (name, description, instructions, taste, herbal_actions) |
| `herbal.recipe_body_systems` | Many-to-many: recipe ↔ body system |
| `herbal.recipe_herbs` | Herb ingredients (quantity, sort_order, optional herb_id) |
| `herbal.recipe_images` | One image per recipe (S3 key) |

---

## Step 1 — Identify Herb IDs and System IDs

Look up herbs and systems from the database:

```sql
-- Find herbs by name
SELECT id, common_name, latin_name FROM herbal.herbs
WHERE common_name ILIKE '%chamomile%' ORDER BY common_name;

-- All body systems
SELECT id, name FROM herbal.body_systems ORDER BY name;
```

Key systems: Nervous=15, Musculoskeletal=14, Digestive=11, Respiratory=10, Cardiovascular=9, Immune=17, Skin=16, Urinary=12, Reproductive=13

---

## Step 2 — Create a Migration File

Name it `NNN_recipe_<name>.sql` (next migration number). Use the CTE pattern:

```sql
SET search_path TO herbal;

WITH new_recipe AS (
  INSERT INTO recipes (name, description, preparation_label, instructions, taste, herbal_actions, sort_order)
  VALUES (
    'Recipe Name',
    E'First paragraph of description.\n\nSecond paragraph.',
    'Steeping',              -- or 'Preparation', 'Application', null
    '[
      {"label": "Hot Infusion", "text": "Instructions here."},
      {"label": "Cold Infusion", "text": "Instructions here."}
    ]'::jsonb,
    'taste description',
    ARRAY['nervine', 'restorative'],  -- herbal actions as array
    10                       -- sort_order (10, 20, 30... for ordering)
  )
  RETURNING id
),
sys AS (
  INSERT INTO recipe_body_systems (recipe_id, body_system_id)
  SELECT id, unnest(ARRAY[15, 14]) FROM new_recipe  -- list system IDs
  RETURNING recipe_id
)
INSERT INTO recipe_herbs (recipe_id, herb_id, quantity, sort_order)
SELECT id, herb_id, qty, ord
FROM new_recipe,
  (VALUES
    (84,  '1.25 parts', 10),   -- (herb_id, quantity, sort_order)
    (136, '1 part',     20),
    (142, '1 part',     30)
  ) AS v(herb_id, qty, ord);
```

### instructions JSONB format

The `instructions` field is a JSON array of preparation steps:

```json
[
  {"label": "Hot Infusion", "text": "Pour 1.5 cups hot water over 2 tablespoons. Steep 10–15 minutes."},
  {"label": "Cold Infusion", "text": "Combine 2 cups cold water and 1–2 tablespoons in a lidded jar..."}
]
```

Other label examples: `"Tincture"`, `"Poultice"`, `"Steam"`, `"Salve"`, `"Decoction"`

### Herb not in DB

If an ingredient isn't in the herbs table, use `herb_name_override` instead of `herb_id`:

```sql
INSERT INTO recipe_herbs (recipe_id, herb_id, herb_name_override, quantity, sort_order)
VALUES (:id, NULL, 'Rose petals', '1 part', 50);
```

---

## Step 3 — Run the Migration

Open the Supabase SQL Editor and paste the migration file contents. Run it there.

---

## Step 4 — Add a Recipe Image (optional)

After running the migration, navigate to the Body System → Recipes tab in the app. Select your recipe, then paste an image (⌘V) while logged in. The image uploads to S3 and is stored in `recipe_images`.

---

## Checklist for Each Recipe

- [ ] Herb IDs confirmed in DB (or `herb_name_override` used)
- [ ] Body system IDs correct
- [ ] Description written (paragraph breaks as `\n\n`)
- [ ] `preparation_label` set (or null if no prep section)
- [ ] `instructions` JSONB valid (test with `SELECT '...'::jsonb`)
- [ ] `taste`, `herbal_actions` filled in
- [ ] `sort_order` set (10, 20, 30... within a system)
- [ ] Migration file named `NNN_recipe_<slug>.sql`
- [ ] Migration run in SQL Editor
- [ ] Recipe appears in app under correct body system
- [ ] Image added via ⌘V paste (if available)

---

## Existing Recipes

| Migration | Name | Systems | Key Herbs |
|---|---|---|---|
| 291 | Dream | Nervous, Musculoskeletal | Chamomile, Catnip, Skullcap, Peppermint, Licorice, Hops |
