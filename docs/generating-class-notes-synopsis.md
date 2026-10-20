# Generating a Class Notes Synopsis

A class notes synopsis is a single dense paragraph per herb that aggregates all class note snippets into a unified clinical picture. It lives in `herbal.herbs.class_notes_synopsis` (text, nullable) and renders at the top of the Class Notes section in the herb page.

This workflow is **standalone** — run it separately from the general class notes ingestion pipeline.

---

## Rules

1. **No detail loss** — every fact from every snippet is preserved. Do not compress, generalize, or omit.
2. **Exact duplicates merge** — if two snippets express the identical concept in the identical way, keep one instance.
3. **Near-duplicates stay separate** — two facts that share a theme but differ in application (e.g., burns vs. abrasions) remain as distinct statements.
4. **Qualifiers are sacred** — words like "especially," "best," "gentle initial," "can substitute," "no," "avoid" must survive verbatim. Dropping them changes clinical meaning.
5. **Contraindications get explicit signal** — safety notes stay legible as cautions; they are not softened or buried mid-sentence. Bold the entire contraindication clause.
6. **Application context is non-droppable** — a fact scoped to a delivery method or condition must keep that scope. Neither half survives without the other.
7. **Bold inline:** herb names, actions, body systems, disorders, and contraindication clauses using HTML `<strong>` tags (the UI renders via `dangerouslySetInnerHTML`).
8. **Use regular dashes only** — never em-dashes (`—`). Use `-` throughout.
9. **Link herb names** — wrap every bolded herb name (other than the subject herb itself) in an `<a href="?herb=ID">` tag so it navigates to that herb's page. See the Herb name linking section below.

---

## What to bold

| Category | Examples |
|---|---|
| Herb names | `<strong>Aloe</strong>`, `<strong>Prickly Pear cactus</strong>` |
| Actions | `<strong>demulcent</strong>`, `<strong>anti-inflammatory</strong>`, `<strong>anticarcinogenic</strong>`, `<strong>immunomodulating</strong>`, `<strong>moistening</strong>` |
| Body systems | `<strong>bladder</strong>`, `<strong>gut lining</strong>`, `<strong>mucous tissues</strong>`, `<strong>cancer</strong>` |
| Disorders | `<strong>UTI</strong>`, `<strong>cystitis</strong>`, `<strong>heartburn</strong>`, `<strong>burns</strong>`, `<strong>abrasions</strong>`, `<strong>inflammation</strong>` |
| Contraindication clauses | `<strong>NO for wound wash on deep wounds - [herb] heals too fast; also avoid introducing oils into open tissue (no salves on open wounds).</strong>` |

---

## Herb name linking

Herb names that have a record in the DB get wrapped in an anchor tag so the user can navigate directly to that herb's page. The color (#0d9488 teal) and click-to-navigate behavior are handled in the UI layer — **do not add inline styles**.

### Format

```html
<a href="?herb=ID"><strong>Herb Name</strong></a>
```

### Rules

- **Do not link the subject herb to itself** — the herb whose synopsis you are writing stays as plain `<strong>HerbName</strong>`.
- **Do not link inside `<strong>` contraindication clauses** — restructuring the bold tags to embed links inside them adds markup complexity for little benefit; leave herb names in those clauses as unlinked text within the `<strong>` block.
- **If a herb has no matching DB record**, leave it as plain `<strong>HerbName</strong>`.

### Looking up herb IDs

Query the live DB — do not guess or read migration files:

```bash
PGPASSWORD=postgres /opt/homebrew/Cellar/libpq/18.6/bin/psql -h 127.0.0.1 -p 54322 -U postgres -d postgres -c \
  "SELECT id, common_name FROM herbal.herbs WHERE common_name ILIKE '%name%' ORDER BY is_tcm, common_name;"
```

When a name doesn't match exactly, search with `ILIKE` and pick the non-TCM result (lower ID for ties). Common name mappings established so far:

| Snippet/synopsis name | DB common_name | ID |
|---|---|---|
| Tulsi | Holy Basil | 13 |
| Schisandra | Schizandra | 17 |
| Milky Oats / Oat Straw / Oat Tops | Oat | 178 |
| Angelica sinensis / Dang Gui | Dong Quai | 1009 |
| Elderberries / Elderberry | Elder | 57 |
| Prickly Pear cactus | Prickly Pear (Nopal) | 2748 |
| Asian Ginseng / Panax / Panax Ginseng | Ginseng | 14 |
| Reishi | Reishi Mushroom | 11 |
| Nettles | Nettle | 43 |
| Marshmallow / Marshmallow Root | Marshmallow | 45 |

---

## Prompt

Use this prompt with all class note snippets for the herb pasted in:

```
You are generating a class notes synopsis for an herbal medicine herb page. Follow these rules exactly:

1. Preserve every fact — no detail loss, no compression.
2. Merge only exact duplicates.
3. Keep near-duplicates (same theme, different application) as separate statements.
4. Qualifiers ("especially," "best," "gentle initial," "can substitute," "no," "avoid") must survive verbatim.
5. Contraindications get explicit signal — keep them legible as cautions, bold the entire clause.
6. Application context is non-droppable — keep delivery method and condition paired together.
7. Bold herb names, actions, body systems, disorders, and contraindication clauses using HTML <strong> tags.
8. Use regular dashes (-) only — never em-dashes.

Output: a single paragraph of plain HTML (only <strong> tags, no other markup). No preamble, no explanation.

CLASS NOTES:
[paste snippets here, one per line]
```

After generating the raw synopsis, add `<a href="?herb=ID">` links around all bolded herb names (except the subject herb and names inside contraindication clauses). Look up IDs with the DB query above.

---

## DB storage

Write a migration file in `supabase/migrations/` with one UPDATE per herb using `common_name` as the key and dollar-quoting for the HTML value:

```sql
UPDATE herbal.herbs
SET class_notes_synopsis = $$<strong>Herb</strong> is a ...$$
WHERE common_name = 'Herb Name';
```

Do NOT run direct UPDATEs — synopses go to prod via migrations like everything else.

---

## UI rendering

The synopsis block renders at the top of the Class Notes section in [HerbView.tsx](../components/HerbView.tsx) inside `HerbDetailPanel`. It uses `dangerouslySetInnerHTML` with the `synopsis-text` CSS class (defined in `app/globals.css`) and an `onClick` handler that intercepts `?herb=ID` link clicks, calls `onNavigateToHerb`, and pushes to the back stack:

```tsx
{herb.class_notes_synopsis && (
  <div className="border border-teal-300 rounded-lg px-4 py-3 bg-teal-100/60 mb-3">
    <p
      className="text-sm text-gray-800 leading-relaxed synopsis-text"
      onClick={(e) => {
        const anchor = (e.target as HTMLElement).closest('a[href]');
        if (!anchor) return;
        const match = (anchor.getAttribute('href') ?? '').match(/[?&]herb=(\d+)/);
        if (!match) return;
        e.preventDefault();
        onNavigateToHerb?.(Number(match[1]));
      }}
      dangerouslySetInnerHTML={{ __html: herb.class_notes_synopsis }}
    />
  </div>
)}
```

The `.synopsis-text a` rule in `globals.css` sets `color: #0d9488` (teal-600) — no inline styles in the HTML values.

---

## Example output

```html
<strong>Aloe</strong> is a <strong>moistening</strong>, <strong>cooling</strong>, <strong>bitter</strong>, and <strong>astringent</strong> herb that is <strong>anticarcinogenic</strong>, <strong>immunomodulating</strong>, and <strong>alkaline-rich</strong>, making it useful in <strong>cancer</strong> care - paired with chlorophyll as a gentle, initial approach to <strong>inflammation</strong> reduction in <strong>cancer</strong> support. It is best indicated for the <strong>bladder</strong> - <strong>UTI</strong> and <strong>cystitis</strong> - and supportive for the <strong>gut lining</strong>, especially for <strong>heartburn</strong>, taken as aloe juice with electrolytes and a little lime. Topically, <strong>Aloe</strong> is <strong>demulcent</strong>, <strong>emollient</strong>, and <strong>anti-inflammatory</strong> for <strong>burns</strong>, where <a href="?herb=2748"><strong>Prickly Pear cactus</strong></a> can substitute; salves shine for <strong>abrasions</strong>. <strong>NO for wound wash on deep wounds - Aloe heals too fast; also avoid introducing oils into open tissue (no salves on open wounds).</strong> As a carrier for vaginal washes, note that oils can change the pH of <strong>mucous tissues</strong> - a wash or sitz bath is the better delivery method.
```
