# Adding a New Case Study

Case studies appear as the first entry in a body system's disorder list, styled in purple. Their detail page shows the full SOAP structure: Subjective → Objective → Notes (Plan/lifestyle) → Actions Indicated → Prescriptions.

## What you'll create

Two sequential migrations:

| Migration | What it does |
|---|---|
| `NNN_case_studies.sql` (or add to it) | `is_case_study` column (once only), disorder, lifestyle notes, actions, prescriptions |
| `NNN+1_soap_sections.sql` (or add to it) | `heading` column (once only), Subjective and Objective notes |

If `is_case_study` and `heading` columns already exist (they were added in migrations 119 and 120), skip those `ALTER TABLE` blocks entirely — just insert the data.

---

## Migration file checklist

### Block 0 — Schema columns (skip if already done)

```sql
-- Only needed once across all case studies
DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns
    WHERE table_schema='herbal' AND table_name='disorders' AND column_name='is_case_study')
  THEN ALTER TABLE herbal.disorders ADD COLUMN is_case_study BOOLEAN NOT NULL DEFAULT FALSE;
  END IF;
END $$;

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns
    WHERE table_schema='herbal' AND table_name='disorder_notes' AND column_name='heading')
  THEN ALTER TABLE herbal.disorder_notes ADD COLUMN heading TEXT;
  END IF;
END $$;
```

---

### Block 1 — Disorder, lifestyle notes, and actions indicated

```sql
DO $$
DECLARE
  v_sys_id    INTEGER;
  v_dis_id    INTEGER;
  v_action_id INTEGER;
  v_herb_id   INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = '<system>';
  -- Body system names: 'Digestive', 'GI', 'Nervous', 'Cardiovascular',
  -- 'Reproductive - Female', 'Reproductive - Male', 'Immune', 'Respiratory - Lower',
  -- 'Respiratory - Upper', 'Urinary', 'Skin', 'Musculoskeletal', 'Aging'

  INSERT INTO herbal.disorders (name, body_system_id, sort_order, is_case_study)
  VALUES ('Case Study', v_sys_id, 0, TRUE)
  ON CONFLICT (name, body_system_id) DO NOTHING;

  SELECT id INTO v_dis_id FROM herbal.disorders
  WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  -- Lifestyle / Plan notes (section = 'general', sort_order 10–190)
  -- These appear under the green "Notes" box on the page.
  -- Use one row per bullet point. sort_order must be unique within this disorder.
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section) VALUES
    (v_dis_id, 'First recommendation', 10, 'general'),
    (v_dis_id, 'Second recommendation', 20, 'general')
    -- ...up to sort_order ~190
  ON CONFLICT DO NOTHING;

  -- Actions indicated (Assessment)
  -- Infer these from the herbs and presenting picture.
  -- Common ones for digestive: Adaptogen, Nervine, Carminative, Bitter tonic,
  --   Demulcent, Nutritive, Hepatic, Alterative, Antispasmodic
  v_action_id := herbal.ensure_action('Adaptogen');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'One sentence rationale.', 10)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  -- Repeat for each action...

  -- Disorder action herbs (which herbs fill each action — used in the "Actions Indicated" bubbles)
  v_action_id := herbal.ensure_action('Adaptogen');
  v_herb_id := herbal.ensure_herb('Asparagus racemosus', 'Shatavari');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10)
  ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Repeat per herb per action...

  RAISE NOTICE 'Case study Block 1 done';
END $$;
```

---

### Block 2 — Prescriptions

Each formula (tincture, decoction, etc.) is one `disorder_prescriptions` row. The `ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id` pattern makes it idempotent: herbs are only inserted when the prescription is new.

```sql
DO $$
DECLARE
  v_sys_id  INTEGER;
  v_dis_id  INTEGER;
  v_rx_id   INTEGER;
  v_herb_id INTEGER;
  v_ph_id   INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = '<system>';
  SELECT id INTO v_dis_id FROM herbal.disorders WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  -- One block per formula
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_dis_id, 'Tincture Name', 'Dosage instructions here.', 10)
  ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    -- Each herb: use ensure_herb to get/create the herb
    v_herb_id := herbal.ensure_herb('Latin name', 'Common name');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
    VALUES (v_rx_id, v_herb_id, '30–60 drops (60ml)', 'any extra note in italic', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs
      WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions
      VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Adaptogen')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions
      VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nutritive')) ON CONFLICT DO NOTHING;

    -- Repeat for each herb...
  END IF;

  -- Second formula
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_dis_id, 'Second Tincture', '2 droppers 3× daily. Total: 120ml.', 20)
  ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    -- herbs...
  END IF;

  RAISE NOTICE 'Case study Block 2 done';
END $$;
```

**`parts` field conventions for tincture case studies:**
- Write the individual dose with volume: `'30–60 drops (60ml)'`
- Use `''` (empty string) if there is no dose info
- Do NOT use `NULL` for parts — the column expects a value

**`note` field on prescription herbs:**
- Use for any italic annotation below the action bubbles
- Common uses: `'root'`, `'Replaced initial Ashwagandha — caused irritability'`, `'fresh herb preferred'`
- Omit the `note` column entirely if there's nothing to add

---

### Block 3 — Sync herb_primary_actions

```sql
DO $$
DECLARE v_sys_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = '<system>';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT DISTINCT ph.herb_id, pha.primary_action_id, v_sys_id
  FROM herbal.prescription_herb_actions pha
  JOIN herbal.prescription_herbs ph ON ph.id = pha.prescription_herb_id
  JOIN herbal.disorder_prescriptions dp ON dp.id = ph.prescription_id
  JOIN herbal.disorders d ON d.id = dp.disorder_id
  WHERE d.body_system_id = v_sys_id AND d.is_case_study = TRUE
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  RAISE NOTICE 'Synced herb_primary_actions';
END $$;
```

---

### Block 4 — Subjective notes

**Sort order range: 200–590.** This avoids collisions with general notes (10–190).

```sql
DO $$
DECLARE
  v_sys_id INTEGER;
  v_dis_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = '<system>';
  SELECT id INTO v_dis_id FROM herbal.disorders WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  -- Demographics row (heading = NULL → renders as intro paragraph, not a bullet)
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section, heading)
  VALUES (v_dis_id, 'Patient is XX years old, YY lbs, Z''Z"', 200, 'subjective', NULL)
  ON CONFLICT DO NOTHING;

  -- Headed sub-sections (heading → renders as bold label with bulleted list below)
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section, heading) VALUES
    (v_dis_id, 'Chief complaint 1', 210, 'subjective', 'Primary Health Concerns'),
    (v_dis_id, 'Chief complaint 2', 220, 'subjective', 'Primary Health Concerns'),
    -- ...
    (v_dis_id, 'Diet detail 1',     250, 'subjective', 'Nutrition'),
    (v_dis_id, 'Diet detail 2',     260, 'subjective', 'Nutrition'),
    -- ...
    (v_dis_id, 'Bowel detail 1',    290, 'subjective', 'Elimination'),
    -- ...
    (v_dis_id, 'Energy symptom 1',  320, 'subjective', 'Energy and Mental State'),
    -- ...
    (v_dis_id, 'Digestive symptom', 340, 'subjective', 'Digestive Symptoms'),
    -- ...
    (v_dis_id, 'Other symptom 1',   400, 'subjective', 'Other Symptoms'),
    -- ...
    (v_dis_id, 'Morning supplements', 450, 'subjective', 'Current Supplements'),
    (v_dis_id, 'Bedtime supplements', 460, 'subjective', 'Current Supplements')
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Subjective notes inserted';
END $$;
```

**Grouping rule:** Notes with the same `heading` value and consecutive `sort_order` are rendered together under that heading. Keep all notes for a heading together in sort_order (no interleaving). Notes with `heading = NULL` render as plain paragraph text.

**Common heading labels used so far:**
`'Primary Health Concerns'`, `'Nutrition'`, `'Elimination'`, `'Energy and Mental State'`, `'Digestive Symptoms'`, `'Other Symptoms'`, `'Current Supplements'`

Use whatever headings match the presenting picture — they don't need to match this list.

---

### Block 5 — Objective notes

**Sort order range: 600–790.**

```sql
DO $$
DECLARE
  v_sys_id INTEGER;
  v_dis_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = '<system>';
  SELECT id INTO v_dis_id FROM herbal.disorders WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section, heading) VALUES
    (v_dis_id, 'Lab value 1 with range and interpretation', 600, 'objective', 'Lab Values'),
    (v_dis_id, 'Lab value 2 with range and interpretation', 610, 'objective', 'Lab Values')
  ON CONFLICT DO NOTHING;

  -- Physical exam findings (if any)
  -- (v_dis_id, 'Finding', 700, 'objective', 'Physical Exam'),

  RAISE NOTICE 'Objective notes inserted';
END $$;
```

---

## Sort order reference

| Range | Section | Rendered as |
|---|---|---|
| 10–190 | `general` | Green "Notes" box (Plan: lifestyle) |
| 200–590 | `subjective` | Blue "Subjective" box |
| 600–790 | `objective` | Indigo "Objective" box |

Leave gaps between ranges in case you need to add entries later. Within each section, number by 10s so you can insert between existing entries.

---

## Decision guide: inferring actions

Map the herbs in the prescription to their primary actions, then add actions for the lifestyle/dietary plan:

| Herb | Likely actions |
|---|---|
| Shatavari | Adaptogen, Nutritive |
| Milky Oats / Avena sativa | Nervine, Nutritive |
| Gotu Kola | Adaptogen, Nervine |
| Vitex agnus-castus | Hormonal Regulator |
| Paeonia lactiflora | Antispasmodic, Hormonal Regulator |
| Glycyrrhiza glabra | Adaptogen, Anti-inflammatory |
| Achillea millefolium | Alterative, Astringent |
| Althaea officinalis | Demulcent |

For dietary/lifestyle plans:
- Warm foods + spices → **Carminative**
- High fat + protein emphasis → **Nutritive**
- Bitters before meals → **Bitter tonic** or **Digestive Stimulant**
- Fermented foods → **Probiotic** (or just note in lifestyle)
- Mucosal support → **Demulcent**

---

## Verifying herbs against the database before writing the migration

**Always query the DB for each herb before using `ensure_herb`.** If there is any uncertainty about the latin name or common name, raise it with the user before writing the migration — do not guess.

```bash
PGPASSWORD=postgres /opt/homebrew/Cellar/libpq/18.1/bin/psql \
  -h 127.0.0.1 -p 54322 -U postgres -d postgres \
  -c "SELECT id, latin_name, common_name, plant_part FROM herbal.herbs ORDER BY common_name;"
```

Or search for a specific genus:

```bash
PGPASSWORD=postgres /opt/homebrew/Cellar/libpq/18.1/bin/psql \
  -h 127.0.0.1 -p 54322 -U postgres -d postgres \
  -c "SELECT id, latin_name, common_name, plant_part FROM herbal.herbs WHERE latin_name ILIKE '%albizia%' OR common_name ILIKE '%albizia%';"
```

**Rules:**
- If there is an exact latin name match → use that row's `latin_name` and `common_name` exactly as stored.
- If there is a near match (different species, alternate common name, or spelling variant) → **stop and ask the user** before proceeding. Example: source says "Albizia" but DB has `Albizia julibrissin` (Silk Tree) and `Albizia lebbeck` — these are clinically different; confirm which one is intended.
- If the herb is genuinely absent from the DB → `ensure_herb` will create it; confirm the latin name spelling is correct before doing so.
- When in doubt, paste the candidate rows to the user and ask "is this the one?" One correction migration is much more disruptive than a quick confirmation.

## Quick reference: herb spelling conventions

See CLAUDE.md for the full list. Most relevant for case studies:

- `herbal.ensure_herb('Althaea officinalis', 'marshmallow')` — no capital, no "root"
- `herbal.ensure_herb('Glycyrrhiza glabra', 'Licorice')` — not "licorice root" as the herb name
- `herbal.ensure_herb('Vitex agnus-castus', 'Vitex')` — may already exist as 'Chasteberry'; `ensure_herb` handles the conflict gracefully
- For herbs with plant-part splits (Taraxacum, Urtica dioica, etc.) use the 3-arg form: `herbal.ensure_herb('Taraxacum officinale', 'Dandelion', 'root')`

---

## UI result

After running both migrations, the Case Study pill appears **first** in the disorder selector (before "Overall") in purple. The detail page renders in order:

1. **SUBJECTIVE** (blue card) — demographics intro, then headed symptom groups
2. **OBJECTIVE** (indigo card) — lab values and other measurables  
3. **Notes** (green card) — lifestyle/Plan recommendations  
4. **Actions Indicated** — assessment with herb bubbles  
5. **Prescriptions** — herb cards with doses and italic notes
