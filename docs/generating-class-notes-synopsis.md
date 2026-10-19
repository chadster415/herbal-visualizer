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

---

## What to bold

| Category | Examples |
|---|---|
| Herb names | `<strong>Aloe</strong>`, `<strong>Prickly Pear cactus</strong>` |
| Actions | `<strong>demulcent</strong>`, `<strong>anti-inflammatory</strong>`, `<strong>anticarcinogenic</strong>`, `<strong>immunomodulating</strong>`, `<strong>moistening</strong>` |
| Body systems | `<strong>bladder</strong>`, `<strong>gut lining</strong>`, `<strong>mucous tissues</strong>`, `<strong>cancer</strong>` |
| Disorders | `<strong>UTI</strong>`, `<strong>cystitis</strong>`, `<strong>heartburn</strong>`, `<strong>burns</strong>`, `<strong>abrasions</strong>`, `<strong>inflammation</strong>` |
| Contraindication clauses | `<strong>NO for wound wash on deep wounds — [herb] heals too fast; also avoid introducing oils into open tissue (no salves on open wounds).</strong>` |

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

Output: a single paragraph of plain HTML (only <strong> tags, no other markup). No preamble, no explanation.

CLASS NOTES:
[paste snippets here, one per line]
```

---

## DB storage

```sql
UPDATE herbal.herbs
SET class_notes_synopsis = '<strong>Herb</strong> is a ...'
WHERE common_name = 'Herb Name';
```

Or via migration file in `supabase/migrations/`.

---

## UI rendering

The synopsis block renders at the top of the Class Notes section in [HerbView.tsx](../components/HerbView.tsx). It uses `dangerouslySetInnerHTML` because the text contains `<strong>` tags:

```tsx
{herb.class_notes_synopsis && (
  <div className="border border-teal-300 rounded-lg px-4 py-3 bg-teal-100/60 mb-3">
    <p
      className="text-sm text-gray-800 leading-relaxed"
      dangerouslySetInnerHTML={{ __html: herb.class_notes_synopsis }}
    />
  </div>
)}
```

This block should appear above the `classNoteSnippets.map(...)` call.

---

## Example output

```html
<strong>Aloe</strong> is a <strong>moistening</strong>, <strong>cooling</strong>, <strong>bitter</strong>, and <strong>astringent</strong> herb that is <strong>anticarcinogenic</strong>, <strong>immunomodulating</strong>, and <strong>alkaline-rich</strong>, making it useful in <strong>cancer</strong> care — paired with chlorophyll as a gentle, initial approach to <strong>inflammation</strong> reduction in <strong>cancer</strong> support. It is best indicated for the <strong>bladder</strong> — <strong>UTI</strong> and <strong>cystitis</strong> — and supportive for the <strong>gut lining</strong>, especially for <strong>heartburn</strong>, taken as aloe juice with electrolytes and a little lime. Topically, <strong>Aloe</strong> is <strong>demulcent</strong>, <strong>emollient</strong>, and <strong>anti-inflammatory</strong> for <strong>burns</strong>, where <strong>Prickly Pear cactus</strong> can substitute; salves shine for <strong>abrasions</strong>. <strong>NO for wound wash on deep wounds — Aloe heals too fast; also avoid introducing oils into open tissue (no salves on open wounds).</strong> As a carrier for vaginal washes, note that oils can change the pH of <strong>mucous tissues</strong> — a wash or sitz bath is the better delivery method.
```
