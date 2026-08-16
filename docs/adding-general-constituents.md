# Adding General Constituents to Herbs

This guide covers the workflow for enriching herbs that have few or no general constituents (`herb_constituents` table), and for cleaning up duplicate/synonym herb stubs.

## Context

The DB has two constituent data systems:
- **`constituent_profiles`** — flat import from the Herb Constituent Database CSV; authoritative; user-provided
- **`herb_constituents`** — general constituents shown on the herb detail page; Claude researches these from the web

This guide covers **`herb_constituents`** only.

## Finding Herbs That Need Work

```sql
-- Non-TCM herbs with few general constituents
SELECT h.common_name, h.latin_name, h.plant_part, COUNT(hc.constituent_id) as constituent_count
FROM herbal.herbs h
LEFT JOIN herbal.herb_constituents hc ON hc.herb_id = h.id
WHERE h.is_tcm = false
GROUP BY h.id, h.common_name, h.latin_name, h.plant_part
HAVING COUNT(hc.constituent_id) <= 5
ORDER BY constituent_count ASC, h.common_name ASC;
```

**As of migrations 178–180 (August 2026):** ~232 non-TCM herbs still have ≤5 general constituents.

## Identifying and Merging Duplicate Stubs

Many 0-constituent herbs are *spp.*, hybrid notation (`x`), or outdated synonym entries that duplicate an already-populated record. Check before researching constituents.

### Pattern: find potential dupes
```sql
SELECT h.id, h.common_name, h.latin_name, h.plant_part, COUNT(hc.constituent_id) as constituents
FROM herbal.herbs h
LEFT JOIN herbal.herb_constituents hc ON hc.herb_id = h.id
WHERE h.common_name ILIKE '%chamomile%'   -- or whatever common name
GROUP BY h.id ORDER BY constituents DESC;
```

Typical dupe signals: `spp.` in latin name, `×` hybrid notation, a synonym that differs from the populated entry.

### Check what data the stub has before deleting
```sql
SELECT 'primary_actions' as tbl, COUNT(*) FROM herbal.herb_primary_actions WHERE herb_id = <stub_id>
UNION ALL SELECT 'secondary_actions', COUNT(*) FROM herbal.herb_secondary_actions WHERE herb_id = <stub_id>
UNION ALL SELECT 'disorder_action_herbs', COUNT(*) FROM herbal.disorder_action_herbs WHERE herb_id = <stub_id>
UNION ALL SELECT 'prescription_herbs', COUNT(*) FROM herbal.prescription_herbs WHERE herb_id = <stub_id>
UNION ALL SELECT 'constituent_profiles', COUNT(*) FROM herbal.constituent_profiles WHERE herb_id = <stub_id>;
```

Most stubs only have `herb_primary_actions` (Organ Affinity entries). Check that those actions don't already exist on the target before merging.

### Merge pattern (migration block)
```sql
DO $$
BEGIN
  -- Move stub's primary actions to the target herb
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength, body_system_note)
  SELECT <target_id>, primary_action_id, body_system_id, relative_strength, body_system_note
  FROM herbal.herb_primary_actions
  WHERE herb_id = <stub_id>
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  DELETE FROM herbal.herb_primary_actions WHERE herb_id = <stub_id>;
  DELETE FROM herbal.herbs WHERE id = <stub_id>;

  RAISE NOTICE 'Merged <stub latin> (id=<stub_id>) into <target latin> (id=<target_id>)';
END $$;
```

### Merges completed (migrations 178–179)

| Stub removed | → Kept entry | Reason |
|---|---|---|
| Tulsi / *Ocimum tenuiflorum* | Holy Basil / *Ocimum sanctum* | Same species; tenuiflorum is accepted name |
| Chamomile / *Matricaria chamomilla* | Chamomile / *Matricaria recutita* | Same species; chamomilla is accepted name |
| Peppermint / *Mentha x piperita* | Peppermint / *Mentha piperita* | Same taxon; × is hybrid notation |
| Oregon Grape / *Berberis aquifolium* | Oregon Grape / *Mahonia aquifolium* | Same species; Berberis is accepted name |
| Linden / *Tilia spp.* | Linden / *Tilia platyphyllos* | spp. stub |
| Witch Hazel / *Hamamelis spp.* | Witch Hazel / *Hamamelis virginiana* | spp. stub |
| Wood Betony / *Betonica officinalis* | Wood Betony / *Stachys officinalis* | Synonym |
| Rosemary / *Salvia rosmarinus* | Rosemary / *Rosmarinus officinalis* | Salvia rosmarinus is accepted name |
| Guggul / *Commiphora guggul* | Guggul / *Commiphora mukul* | Synonym |
| Plantain / *Plantago spp.* | Plantain / *Plantago major* | spp. stub |
| Shiitake / *Lentinula edodes* | Shiitake / *Lentinus edodes* | stub merged into populated entry |
| Vervain / *Verbena spp.* | Vervain / *Verbena officinalis* | spp. stub |
| Violet / *Viola spp.* | Violet / *Viola odorata* | spp. stub |

### Known pending: Kola

**Kola** (*Cola acuminata*, id=150) and **Kola Nut** (*Cola vera*, id=615) have identical constituent data but **conflicting primary actions** — one has Nervine Stimulant, the other Nervine Relaxant. Also: Cola acuminata has 3 secondary actions vs Cola vera's 1. Requires human review before merging.

## Adding Constituents

### Research
For each herb, research 6–12 key constituents from phytochemistry literature. Focus on:
- Therapeutically/pharmacologically significant compounds
- Marker compounds (what the herb is standardized to, if applicable)
- Characteristic constituent classes that distinguish the herb

### Helper functions
```sql
-- Create or get a constituent (no-op if name already exists)
PERFORM herbal.ensure_constituent('rosmarinic acid', 'hydroxycinnamic acid',
  'Description of the compound and its significance.');

-- Link constituent to herb by latin name (no-op if herb not found)
PERFORM herbal.link_constituent('Prunella vulgaris', 'rosmarinic acid', 'primary', 0);
```

`link_constituent` signature:
```
herbal.link_constituent(latin_name, constituent_name, level, sort_order, notes DEFAULT NULL, needs_review DEFAULT FALSE)
```

### Concentration levels
`primary` → `major` → `moderate` → `minor` → `trace`

Use `primary` for the defining marker compound. Use `major` for abundant but non-marker constituents. Most constituents are `moderate` or `minor`.

### Sort order convention
- 0 = primary/marker compounds
- 10, 20, 30… = major to minor, in order of therapeutic importance

### Existing constituent name conventions (check before creating)
Always query first to reuse existing names and categories:
```sql
SELECT name, category FROM herbal.constituents
WHERE name IN ('your', 'constituent', 'names')
ORDER BY name;
```

Key conventions observed in the DB:
| Name | Category |
|---|---|
| apigenin | flavone |
| beta-caryophyllene | sesquiterpene |
| beta-sitosterol | phytosterol |
| caffeic acid | hydroxycinnamic acid |
| chlorogenic acid | hydroxycinnamic acid |
| luteolin | flavone |
| oleanolic acid | pentacyclic triterpenoid |
| polyacetylenes | polyacetylene |
| quercetin | flavonol |
| rosmarinic acid | hydroxycinnamic acid |
| rutin | flavonol glycoside |
| tannins | polyphenol |
| triterpenoid saponins | saponin |
| ursolic acid | pentacyclic triterpenoid |
| piperine | piperidine alkaloid |
| rotenone | isoflavanone |
| piscidic acid | tartrate ester |
| hyperoside | flavonol glycoside |
| orientin | flavone C-glycoside |
| limonene | monoterpene |
| sabinene | bicyclic monoterpene |
| eugenol | phenylpropanoid |
| araloside A | triterpenoid saponin |

### Constituents added in batch 1 (migration 178)

| Herb | Key additions |
|---|---|
| Holy Basil (*Ocimum sanctum*) | orientin, vicenin-2, beta-caryophyllene, ocimumosides, oleanolic acid |
| Bacopa (*Bacopa monnieri*) | bacoside A (primary), bacoside B, apigenin, luteolin, quercetin, brahmine, stigmasterol |
| Black Pepper (*Piper nigrum*) | piperine (primary), chavicine, beta-caryophyllene, sabinene, limonene |
| Jamaican Dogwood (*Piscidia piscipula*) | rotenone, piscidic acid, jamaicin, milletone, isomilletone, piscidin, beta-sitosterol, tannins |
| Self Heal (*Prunella vulgaris*) | rosmarinic acid (primary), ursolic acid, oleanolic acid, caffeic acid, rutin, hyperoside, luteolin, prunellin, tannins |
| Spikenard (*Aralia racemosa*) | araloside A+B, oleanolic acid, continentalic acid, kaurenoic acid, beta-sitosterol, polyacetylenes, caffeic acid, chlorogenic acid |

## Duplicate Editorial Notes

Migration 180 fixed 7 herbs where `constituent_profiles.editorial_note` had two distinct values across rows. The fix standardizes all rows for a given herb to the most common note (majority vote).

To check for new occurrences:
```sql
SELECT h.common_name, COUNT(DISTINCT cp.editorial_note) as distinct_notes
FROM herbal.constituent_profiles cp
JOIN herbal.herbs h ON h.id = cp.herb_id
WHERE cp.editorial_note IS NOT NULL AND cp.editorial_note != ''
GROUP BY h.id, h.common_name
HAVING COUNT(DISTINCT cp.editorial_note) > 1
ORDER BY h.common_name;
```
