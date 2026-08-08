# Adding Herb Data from Books

This guide covers how to add or extend herb data — contraindications, body system actions, and energetics — from a printed or scanned materia medica source.

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
- [ ] All INSERTs use `ON CONFLICT ... DO NOTHING` (migrations must be re-runnable).

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
