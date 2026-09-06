# Adding Herb Pairings from a New Source

This guide walks through the end-to-end process of adding a batch of herb pairs from a new book or primary source into the `herb_pairs` system.

---

## Overview of the pairing tables

| Table | Purpose |
|---|---|
| `herb_pairs` | One row per unique pair — `(herb1_id, herb2_id)` UNIQUE; `source TEXT NOT NULL`; `combined_summary` |
| `herb_pair_indications` | One or more indications per pair — `(pair_id, indication, sort_order)` |
| `herb_pair_herb_properties` | Per-herb roles within a pair — `(pair_id, herb_id, property, sort_order)` |

**UNIQUE constraint**: `herb_pairs` has UNIQUE(herb1_id, herb2_id). Always store `herb1_id = LEAST(id_a, id_b)` and `herb2_id = GREATEST(id_a, id_b)` to guarantee uniqueness regardless of which herb is "first" in the source text.

**No UNIQUE constraint on indications/properties**: Use `WHERE NOT EXISTS` guards so the migration is re-runnable.

---

## Sources loaded so far

| Migration | Source | Short name for `source` field |
|---|---|---|
| 242 | Ganora & Martello, "Ginger & Turmeric: a Classic Pair" (2026) | `'Ganora & Martello, ...'` |
| 242 | Priest & Priest, *Herbal Medication* (1982), pp. 56–78 | `'Priest & Priest, Herbal Medication (1982), pp. 56–78'` |
| 243 | BHC Apprenticeship class notes (instructor citations) | `'BHC Apprenticeship class notes'` |
| 257 | Scudder, *American Eclectic Materia Medica and Therapeutics* (12th ed., 1898) | `'Scudder, American Eclectic Materia Medica and Therapeutics (12th ed., 1898), via Henriette''s Herbal'` |

---

## Step-by-step process

### Step 1 — Prepare the source data

Ideally the source is extracted into a structured format before you begin writing SQL. The extraction file for Scudder lives at:
```
/Users/chadarmstrong/Downloads/Western Herb Pair documentation/Scudder 1898/
  scudder_herb_pairings_henriette_first_pass.txt
```

Pipe-delimited format used for Scudder:
```
Herb A | Herb B | Relationship / Role | Clinical Purpose or Indication | Historical Names A | Historical Names B | Evidence Summary | Source Entry | Source URL
```

Keep **duplicate rows** when the source gives materially different indications for the same pair — you'll merge them into one `herb_pairs` row with multiple `herb_pair_indications` rows.

---

### Step 2 — Identify herbs already in the DB

```sql
SELECT id, common_name, latin_name FROM herbal.herbs
WHERE lower(common_name) SIMILAR TO '%(herb a|herb b|...)%'
   OR lower(latin_name)  SIMILAR TO '%(genus a|genus b|...)%'
ORDER BY id;
```

Make a table of: each herb in the source → DB id (or "missing").

---

### Step 3 — Add missing herbs

For any herb not yet in the DB, follow **[adding-herb-data-from-books.md](adding-herb-data-from-books.md)** — Case 3 (new herb). Do this in a **separate migration** before the pairings migration.

The pairing migration should guard against missing herbs:
```sql
IF v_herb_a IS NULL OR v_herb_b IS NULL THEN
  RAISE EXCEPTION 'Herb(s) missing — run the herb-insertion migration first.';
END IF;
```

---

### Step 4 — Deduplicate source rows

If the source has multiple rows for the same pair (different indications), merge them:
- One `herb_pairs` INSERT with `combined_summary` that synthesizes all contexts
- Multiple `herb_pair_indications` rows, one per distinct clinical indication

---

### Step 5 — Write the pairings migration

**File naming**: `NNN_sourcename_pairings.sql`  
**Current highest**: 257. Next free: 258.

**Migration skeleton**:

```sql
-- Migration NNN: Herb pairs from [Book Title] ([Year])
-- Source: [Full citation]
-- Pairs: [list]

SET search_path TO herbal, public;

DO $$
DECLARE
  -- Existing herb IDs (constants — safe to hardcode if herb is long-established)
  v_herb_a  CONSTANT INTEGER := 192;  -- Ipecac (Cephaelis ipecacuanha)

  -- New herb IDs (resolved by latin_name — runtime-safe)
  v_herb_b  INTEGER;

  v_src     CONSTANT TEXT := 'Author, Book Title (Year)';
  v_pair_id INTEGER;
BEGIN

  -- Resolve new herb IDs
  SELECT id INTO v_herb_b FROM herbal.herbs
  WHERE latin_name = 'Genus species' AND plant_part = 'Root';

  -- Guard: abort if any new herb is missing
  IF v_herb_b IS NULL THEN
    RAISE EXCEPTION 'Herb missing — run the herb-insertion migration first.';
  END IF;

  -- ── Pair N: Herb A + Herb B ─────────────────────────────────────────────────
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (LEAST(v_herb_a, v_herb_b), GREATEST(v_herb_a, v_herb_b), v_src,
    'Combined summary: what the pair does and why these two herbs work together.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(v_herb_a, v_herb_b)
    AND herb2_id = GREATEST(v_herb_a, v_herb_b);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Primary indication', 10),
    ('Secondary indication', 20)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (v_herb_a, 'Role of Herb A in the pair', 10),
    (v_herb_b, 'Role of Herb B in the pair', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);

  RAISE NOTICE 'Pair N done: Herb A + Herb B (id=%)', v_pair_id;

  RAISE NOTICE 'Migration NNN complete — N pairs inserted.';
END $$;
```

---

### Step 6 — Handle pairs that already exist from another source

If a pair already exists in `herb_pairs` (from a different source), you have two options:

**Option A — Add a second indication only** (the pair was already documented):
```sql
SELECT id INTO v_pair_id FROM herbal.herb_pairs
WHERE herb1_id = LEAST(v_herb_a, v_herb_b) AND herb2_id = GREATEST(v_herb_a, v_herb_b);

INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
SELECT v_pair_id, ind, ord FROM (VALUES
  ('New indication from this source', 30)
) AS t(ind, ord)
WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications
  WHERE pair_id = v_pair_id AND indication ILIKE '%new indication keyword%');
```

**Option B — Skip with a comment** if the existing entry is already complete.

---

### Step 7 — Write the `source` field consistently

The `source TEXT NOT NULL` field should be a complete, citable reference — not just an author name. Examples:

```
'Priest & Priest, Herbal Medication (1982), pp. 56–78'
'Scudder, American Eclectic Materia Medica and Therapeutics (12th ed., 1898), via Henriette''s Herbal'
'BHC Apprenticeship class notes'
```

---

### Step 8 — Add a note to this file's sources table

After the migration is written, update the **Sources loaded so far** table above with the new migration number, source, and `source` field string.

---

## Quick checklist

- [ ] Source data structured and reviewed for duplicate pairs
- [ ] All herbs in source identified against DB (`SELECT id, common_name, latin_name ...`)
- [ ] Missing herbs added in a separate prior migration (following `adding-herb-data-from-books.md`)
- [ ] Source rows with multiple indications for the same pair merged into one `herb_pairs` row + multiple `herb_pair_indications` rows
- [ ] `herb1_id = LEAST(...)`, `herb2_id = GREATEST(...)` in every INSERT
- [ ] `ON CONFLICT (herb1_id, herb2_id) DO NOTHING` on every `herb_pairs` INSERT
- [ ] `WHERE NOT EXISTS` guard on every `herb_pair_indications` and `herb_pair_herb_properties` INSERT
- [ ] Migration is re-runnable (idempotent)
- [ ] Guard block raises EXCEPTION if any required herb is missing
- [ ] `source` field is a complete citable reference string
- [ ] `combined_summary` synthesizes the pair's overall clinical rationale (not just one indication)
- [ ] Sources table in this doc updated with the new migration
