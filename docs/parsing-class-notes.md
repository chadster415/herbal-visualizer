# Playbook: Parsing Class Notes into the DB

Use this guide when adding a new BHC class. Hand it to Claude along with the note files and the request "parse class notes for Class NN".

---

## File naming rules

Each class can have up to 3 files under:
```
/Users/chadarmstrong/Obsidian/Obsidian Vault/Classes/Berkeley Herbal Center/Apprenticeship Intensive/
```

| Filename suffix | Action |
|---|---|
| `- Generated Notes.md` | Parse (`note_type = 'generated'`) |
| `- {your initials}.md` (anything without the above two suffixes) | Parse (`note_type = 'personal'`) |
| `- Transcript.md` | **Ignore** |

The `class_name` value to use in the DB is the filename prefix, e.g.:
`BHC - Class 61 - Repro IV Hormonal Matrix`

---

## What to produce

One SQL migration:
- `{N}_class_{nn}_{slug}_data.sql` — snippets (with source_block), keywords, ailment search synonyms

The schema (tables `class_note_snippets` and `herb_keywords`) already exists from migration 214. The `source_block` column exists from migration 216. The `ailment_search_terms` table (for disorder search synonyms) exists from migration 217. No schema migrations needed for additional classes.

---

## Step 1 — Fetch the herb DB and existing ailment keywords

Run these at the start:
```sql
SELECT id, common_name, latin_name, plant_part FROM herbal.herbs ORDER BY common_name;

SELECT DISTINCT keyword FROM herbal.herb_keywords WHERE category = 'ailment' ORDER BY keyword;
```

Build a working lookup: `common_name → id` and `latin_name → id`. Also include synonyms from `herb_synonyms` if that table exists.

Keep the ailment keyword list visible throughout Steps 2–4 — you will compare new keyword candidates against it before creating them.

---

## Step 2 — Identify herb mentions

Read both note files. For each line/bullet:

1. **Bold or italic herb names** — `**Vitex**`, `*Astragalus*` — highest confidence
2. **Capitalized bare names** — `Shepherd's Purse`, `Milk Thistle` — high confidence
3. **Lowercase mentions** — `dong quai`, `vitex`, `nettles` — match case-insensitively

**Common normalisations** (update this list as you encounter new ones):
| Note text | DB entry |
|---|---|
| Vitex | Chasteberry (Vitex agnus-castus) |
| Eleuthero | Siberian Ginseng (Eleutherococcus senticosus) |
| Schisandra / Schizandra | Schizandra (Schisandra chinensis) |
| Uva ursi | Bearberry (Arctostaphylos uva-ursi) |
| Trifolium | Red Clover (Trifolium pratense) |
| Reishi | Reishi Mushroom (Ganoderma lucidum) |
| Ginsengs / Ginseng (general) | Ginseng (Panax ginseng) |
| Red raspberry leaf / raspberry | Raspberry (Rubus idaeus, leaf part) |
| Cal Poppy / California Poppy | California Poppy (Eschscholzia californica) |
| Dong quai | Dong Quai (Angelica sinensis) |
| Nettles / nettle | Nettle (Urtica dioica, leaf) unless context says root |
| Lady's mantle | Lady's Mantle (Alchemilla vulgaris) |
| Dandelion root / Dandelion leaf | Dandelion (Taraxacum officinale, root or leaf) |
| Elder flower / Elder berry | Elder (Sambucus nigra, flower or berry) |
| Corn silk | Corn Silk (Zea mays) |
| Hawthorn berry / Hawthorn leaf | Hawthorn (Crataegus spp., berry or leaf) |

**Vitamins and minerals — check `herbal.supplements` first:**
Vitamins (Vitamin A, B1–B12, C, D, E, K) and minerals (Zinc, Iron, Magnesium, etc.) are in the `supplements` table as first-class entities, exactly like herbs. When the notes mention one by name, look it up by name in `supplements`. If it's there, create a snippet with `supplement_id` instead of `herb_id` (see Step 3). Do **not** skip them as "supplements".

Examples in DB: Zinc (id=24), Vitamin D (id=11), Vitamin C (id=10), Magnesium — check with:
```sql
SELECT id, name, category FROM herbal.supplements ORDER BY category, name;
```

**Skip these — not in the DB at all:**
- Preparations: castor oil, fire cider, castor pack, honey, apple cider vinegar
- Foods with no DB entry: blueberries, eggs, shellfish, cherries (check herbs and supplements before skipping)
- Flax seed IS in the herbs DB (Flax, Linum usitatissimum) — do not skip it
- Vague category words: "a lymphatic", "carminatives", "adaptogens" (the category, not a specific herb)

**Plant-part disambiguation:**
When the notes say "dandelion root" vs "dandelion leaf" — use the part-specific DB entry.
When the notes are ambiguous (just "nettle"), default to leaf.

---

## Step 2a — Scan for herb pairs

During the same reading pass as Step 2, watch for any two herbs explicitly noted as working well together. These get added to `herbal.herb_pairs` (the same table used for Priest & Priest and Ganora pairs).

**What qualifies:**
- Instructor explicitly says two herbs "work well together", are "synergistic", or are a "classic combination"
- Instructor cites research on a specific two-herb combination
- A named traditional pair attributed to a named source (book, author, practitioner)
- Different parts of the same plant used together with explicit synergy noted

**What does NOT qualify:**
- Three-or-more herb formulas (don't fit the two-herb pair structure)
- Herbs simply listed together in a formula without a pairing note
- Student experiments or personal preferences without instructor endorsement

**Check existing pairs first before adding:**
```sql
SELECT h1.common_name, h2.common_name, hp.source
FROM herbal.herb_pairs hp
JOIN herbal.herbs h1 ON h1.id = hp.herb1_id
JOIN herbal.herbs h2 ON h2.id = hp.herb2_id
ORDER BY h1.common_name;
```

**If new pairs are found:** create a separate migration file (numbered after the snippets migration) with this pattern:

```sql
-- Always normalize: herb1_id = LEAST, herb2_id = GREATEST
INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
VALUES (
  LEAST(herb1_id, herb2_id), GREATEST(herb1_id, herb2_id),
  'BHC Apprenticeship class notes',
  'Combined description of the pair and why they work together.'
)
ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

-- Get the pair id after insert
-- (herb_pair_indications and herb_pair_herb_properties have no UNIQUE constraint,
--  so use WHERE NOT EXISTS for re-runnability)
SELECT id INTO v_pair_id FROM herbal.herb_pairs
WHERE herb1_id = LEAST(herb1_id, herb2_id) AND herb2_id = GREATEST(herb1_id, herb2_id);

INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
SELECT v_pair_id, ind, ord FROM (VALUES
  ('Indication one', 10),
  ('Indication two', 20)
) AS t(ind, ord)
WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
SELECT v_pair_id, hid, prop, ord FROM (VALUES
  (herb1_id, 'What herb 1 contributes to the pair', 10),
  (herb2_id, 'What herb 2 contributes to the pair', 10)
) AS t(hid, prop, ord)
WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
```

Use `'BHC Apprenticeship class notes'` as the source unless the instructor attributes the pair to a specific book or practitioner (e.g. `'David Winston, as cited in BHC class notes'`).

**Wrap each pair's block in a DECLARE/DO $$ block** so v_pair_id scoping works correctly (see migration 243 for full example).

---

## Step 3 — Extract snippets

For each herb **or supplement** mention, capture:
- **`herb_id` / `supplement_id`**: Use `herb_id` for herbs; use `supplement_id` for vitamins and minerals found in `herbal.supplements`. Exactly one must be set per row.
- **`snippet_text`**: The bullet or sentence that mentions the herb or supplement. Include enough context to be clinically meaningful. For list formulas ("calendula, plantain, rose, yarrow"), include the full list and its purpose.
- **`section_header`**: The most specific header directly above the bullet (`####` > `###` > `##`). Clean it: remove "Decoction for", "Tinctures for", "Bath for" — keep the clinical subject.
- **`source_block`**: The full verbatim text of the section (from the header down to the next header at the same level). All snippets sharing the same `(note_type, section_header)` get the same source_block. If two raw headers clean to the same section_header (e.g. "## Decoction for Vaginitis" and "## Bath for Vaginitis" both → `Vaginitis`), concatenate both blocks with a blank line between them and label each with a bold heading (e.g. `**Decoction:**` / `**Bath:**`).
- **`note_type`**: `'generated'` or `'personal'`
- **`sort_order`**: Use sequential integers (10, 20, 30...) within each note file. Generated notes start at 10, personal notes also start at 10 (the note_type column distinguishes them).
- **`class_name`**: The filename prefix exactly.

**SQL pattern for supplement snippets** (use `supplement_id`, leave `herb_id` absent):
```sql
INSERT INTO herbal.class_note_snippets
  (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
VALUES
  (24, 'Zinc depletion through semen expression …', 'BHC - Class NN - …', 'generated', 'Section', 10, '…source…');
```

**Keywords for supplements** — use `supplement_id` instead of `herb_id`, and the partial index for ON CONFLICT:
```sql
INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
  (24, 'low testosterone', 'ailment'),
  (24, 'reproductive support', 'ailment')
ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;
```

**Guard block for supplement snippets** — use a supplement-specific check since the herb guard uses class_name + herb presence:
```sql
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets
             WHERE supplement_id = <id>
               AND class_name = 'BHC - Class NN - Name Here') THEN
    RAISE NOTICE 'Class NN supplement snippets already loaded, skipping';
    RETURN;
  END IF;
  -- INSERT supplement snippets here
END $$;
```

**Section header cleaning rules:**
| Raw header | Use as section_header |
|---|---|
| `## Decoction for Vaginitis` | `Vaginitis` |
| `## Bath for Vaginitis` | `Vaginitis` |
| `## Tinctures for Fibroids and Vaginitis` | `Fibroids and Vaginitis` |
| `## Tinctures for Hormone and Uterine Support` | `Hormone and Uterine Support` |
| `## Traditional Formulas and Variations` | `Traditional Formulas` |
| `## Herb Formula and Anxiety Support` | `Anxiety Support` |
| `## Nervous System Support and Herbs` | `Nervous System Support` |
| `## {Patient Name}` (e.g. `## Lisa`) | `{Patient Name} (Patient Case)` |

Strip procedural words from the front: "Decoction for", "Tinctures for", "Bath for", "Blend for", "Protocol for", "Formula for", "Tea for".

---

## Step 4 — Extract keywords

For each herb, extract **medically meaningful** keywords from:
1. The section headers where the herb appears
2. The sub-bullets describing the herb's use

**Keep:** conditions, ailments, symptoms, therapeutic actions/properties.
**Drop:** procedural words — decoction, tincture, tea, bath, infusion, blend, protocol, formula, preparation, extraction.

Examples:
- `## Decoction for Vaginitis` → keyword `vaginitis`
- `## Fibroids and Uterine Health` → keywords `fibroids`, `uterine health`
- `- Vitex for hormonally induced symptoms` → keywords `hormonal imbalance`, `hormonal support`
- `- Milk Thistle — helps with elimination of all things, enabling hormones to then be better processed` → keywords `liver support`, `estrogen metabolism`, `hormonal support`
- `- Uva ursi — Antimicrobial, anti-inflammatory` → keywords `antimicrobial`, `anti-inflammatory` (category = 'action')

**Categories:**
- `ailment` — a condition or disease (fibroids, vaginitis, UTI, anxiety, heavy bleeding, premenopause)
- `symptom` — a specific sign (headache, fatigue, cramps, base of skull headache)
- `action` — a therapeutic property (adaptogen, anti-inflammatory, hemostatic, sedative, diuretic)
- `general` — misc that doesn't fit above (perineal care, sitz bath)

**Before creating a new `ailment` keyword, check the existing keyword list from Step 1 and apply this judgment:**

| Situation | Rule |
|---|---|
| New phrase is identical to an existing keyword | Use the existing keyword |
| New phrase is a synonym or variant phrasing of an existing keyword | Use the existing keyword — don't add a near-duplicate |
| New phrase captures a meaningfully distinct clinical concept | Create a new keyword |
| Unsure | Prefer merging — fewer, cleaner keywords are better than many similar ones |

**Examples:**
- Notes say "menorrhagia" → use existing `heavy bleeding` (plain-English version is already in DB)
- Notes say "uterine wellness" → use existing `uterine health`
- Notes say "nervous system support" → new keyword; distinct from `stress` or `anxiety`
- Notes say "thyroid support" → new keyword if no close match exists

Document any merge decisions in the migration header comments.

---

## Step 5 — Generate ailment search synonyms

For every **new** `ailment` keyword introduced by this class (i.e., not already in `ailment_search_terms`), generate 3–6 search synonyms. These let the disorder search box surface inferred ailments even when the user types a related term they'd naturally reach for.

**What to include:**
- Medical/clinical equivalents: `heavy bleeding` → `menorrhagia`, `metrorrhagia`
- Common-language terms: `vaginitis` → `vaginal infection`, `yeast infection`, `bacterial vaginosis`
- Abbreviations both ways: `UTI` ↔ `urinary tract infection`
- Closely related concepts: `perimenopause` → `menopausal transition`, `pre-menopause`
- Variant spellings or phrasings: `hormonal imbalance` → `hormone imbalance`, `endocrine imbalance`

**What to skip:**
- Procedural words already stripped from keywords (decoction, tincture…)
- Keywords that are already other ailment keywords (don't duplicate; the synonym links are enough)

**Check which keywords are already in the table before adding:**
```sql
SELECT ailment_keyword FROM herbal.ailment_search_terms ORDER BY ailment_keyword;
```

**SQL pattern — use ON CONFLICT DO NOTHING so it's re-runnable:**
```sql
INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('new ailment keyword',   ARRAY['synonym one', 'synonym two', 'synonym three']),
  ('another new keyword',   ARRAY['alt term', 'related term'])
ON CONFLICT (ailment_keyword) DO NOTHING;
```

Only insert rows for ailment keywords that are genuinely new to this class.

---

## Step 6 — Write the migration

Use this guard at the top of the snippets INSERT block to make the migration re-runnable:

```sql
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets
             WHERE class_name = 'BHC - Class NN - Name Here') THEN
    RAISE NOTICE 'Class NN snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (herb_id, 'snippet text', 'BHC - Class NN - Name Here', 'generated', 'Section Header', 10,
     '- Full verbatim text of the section
- Second bullet
- Third bullet'),
    ...;
END $$;
```

For keywords, use `ON CONFLICT (herb_id, keyword) DO NOTHING` — the UNIQUE constraint handles idempotency automatically.

Include a comment block at the top of the migration listing:
- Which files were parsed
- Any herb name normalisations applied
- Any herbs skipped (not in DB) and why

---

## Step 7 — Verify before asking user to run

Before writing the final migration, verify:
1. Every `herb_id` actually exists in `herbal.herbs` — no orphan foreign keys
2. Every snippet is attributed to the right `note_type`
3. No procedural words made it into keywords
4. The `class_name` string is an exact match to the filename prefix (copy-paste it)
5. Every new `ailment` keyword has a corresponding row in the `ailment_search_terms` INSERT block

---

## Step 8 — Generate class quiz questions

After completing the snippets migration, generate 30 MCQ questions for this class. Create a separate migration file: `{N+1}_class_{nn}_{slug}_quiz.sql`

**Table schema** (already exists from migration 232):
- `class_name` — exact match to the class_name used in snippet migration
- `question_text` — the question
- `option_a` through `option_d` — four answer choices  
- `correct_option` — 'a', 'b', 'c', or 'd'
- `explanation` — 1-2 sentences explaining why the correct answer is right
- `snippet_text` — the verbatim note passage that supports the answer (taken directly from the snippets you just inserted)
- `section_header` — the section this snippet came from (same value as in class_note_snippets)
- `sort_order` — 10, 20, 30... 300 for the 30 questions

**Question quality rules**:
- Every question must be directly supported by a specific snippet from the class notes — use real herb names, dosages, and clinical relationships from the notes, not general knowledge
- `snippet_text` must be the actual note text (copy from the migration you just wrote)
- Write a mix of question types: which herb treats X, what does herb Y do, which formula contains Z, what is the dose/ratio of W, which herb is specific for condition Q
- Distractors (wrong options) must be plausible herbs or concepts from the same clinical domain — not obviously wrong
- Vary the correct option position: don't put correct answer in 'a' every time

**SQL pattern** (use a guard block identical to the snippet migration):
```sql
-- Migration NNN: Class NN quiz questions
SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_quiz_questions WHERE class_name = 'BHC - Class NN - Name Here') THEN
    RAISE NOTICE 'Class NN quiz questions already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_quiz_questions
    (class_name, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, snippet_text, section_header, sort_order)
  VALUES
    ('BHC - Class NN - Name Here',
     'Which herb is described as specific for X in these notes?',
     'Herb A', 'Herb B', 'Herb C', 'Herb D',
     'b',
     'The notes specifically name Herb B for X in the section on Y.',
     'The verbatim snippet text from the notes that supports this.',
     'Section Header', 10),
    -- ... 29 more rows ...
    ;
END $$;
```

**Checklist for quiz migration**:
- [ ] Exactly 30 questions total for this class
- [ ] Every question has a `snippet_text` copied verbatim from the snippets migration
- [ ] Correct options distributed across a, b, c, d (roughly 7-8 each)
- [ ] Distractors are clinically plausible, not trivially wrong
- [ ] Guard block uses class_name = exact match to snippets migration
- [ ] sort_order runs 10, 20, 30… 300

---

## Checklist per class

- [ ] Read both non-Transcript files
- [ ] Fetched current herb list from DB
- [ ] Scanned for herb pairs (two herbs explicitly noted as synergistic or a classic combination)
- [ ] Queried existing herb_pairs to avoid duplicates; wrote pair migration if new pairs found
- [ ] Queried `herbal.supplements` for any vitamins/minerals mentioned in the notes
- [ ] Normalised all informal/abbreviated herb names
- [ ] Documented skipped herbs/supplements (not in DB)
- [ ] Used `supplement_id` (not `herb_id`) for supplement snippets and keywords
- [ ] Wrote snippets with clean section_header values
- [ ] Populated source_block for every unique (note_type, section_header) combination
- [ ] Merged source_blocks when two raw headers clean to the same section_header
- [ ] Fetched existing ailment keywords from DB before extracting new ones
- [ ] Merged new keyword candidates into existing keywords where the clinical concept is the same
- [ ] Documented merge decisions in migration header comments
- [ ] Extracted clinically meaningful keywords only
- [ ] Queried `ailment_search_terms` to identify which ailment keywords are new
- [ ] Wrote synonyms for every new ailment keyword (3–6 per keyword)
- [ ] Migration file named `{N}_class_{nn}_{slug}_data.sql`
- [ ] Guard block checks by class_name
- [ ] Normalisations listed in migration header comments
- [ ] Quiz migration file created ({N+1}_class_{nn}_{slug}_quiz.sql)
- [ ] Exactly 30 questions with correct guard block
- [ ] All snippet_text values copied verbatim from the snippets migration
