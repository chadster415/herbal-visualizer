# Data Entry Guide

The schema and herbs are loaded, but you need to add the **relationships** between herbs, actions, and body systems.

## Current Status

✅ Schema created (`herbal` namespace)  
✅ 562 herbs loaded  
✅ 21 primary actions loaded  
✅ 8 body systems loaded  
❌ Herb-to-action-to-system relationships (empty)  
❌ Secondary actions for herbs (empty)

## Sample Data Provided

I've created `003_sample_relationships.sql` with example relationships for 3 herbs:
- Garlic (Allium sativum)
- Burdock (Arctium lappa)
- Echinacea (Echinacea spp.)

**Run this to see the app working with sample data:**

```sql
-- In Supabase SQL Editor
\i supabase/migrations/003_sample_relationships.sql
```

Or copy/paste the file contents into SQL Editor.

## How to Add More Relationships

### Option 1: Using SQL (Recommended for Bulk)

Use this template for each herb-action-system relationship:

```sql
-- Example: Add Goldenseal as an Alterative for Digestive system, strong strength
INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength, body_system_note)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Hydrastis canadensis'),
  (SELECT id FROM herbal.primary_actions WHERE name = 'Alteratives'),
  (SELECT id FROM herbal.body_systems WHERE name = 'Digestive'),
  'strong'::herbal.strength_level,
  'Optional note about this relationship'
ON CONFLICT DO NOTHING;
```

### Option 2: Using Supabase Table Editor

1. Open Supabase Studio
2. Go to **Table Editor**
3. Select `herbal.herb_primary_actions` table
4. Click **Insert** → **Insert row**
5. Fill in:
   - `herb_id`: Find ID from herbs table
   - `primary_action_id`: Find ID from primary_actions table
   - `body_system_id`: Find ID from body_systems table
   - `relative_strength`: mild, strong, or very_strong
   - `body_system_note`: (optional) notes

### Quick Reference IDs

Get IDs with these queries:

```sql
-- Find herb ID
SELECT id, latin_name, common_name FROM herbal.herbs WHERE common_name LIKE '%garlic%';

-- See all actions
SELECT id, name FROM herbal.primary_actions;

-- See all systems
SELECT id, name FROM herbal.body_systems;

-- See all secondary actions
SELECT id, name FROM herbal.secondary_actions;
```

## Adding Secondary Actions

```sql
-- Example: Add "Antimicrobial" secondary action to Goldenseal
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Hydrastis canadensis'),
  (SELECT id FROM herbal.secondary_actions WHERE name = 'Antimicrobial')
ON CONFLICT DO NOTHING;
```

## Bulk Data Entry Strategy

### 1. Work by Primary Action

Extract all herbs for one action from your text file, then insert them:

**From your text (Alteratives section):**
```
Respiratory. The main alteratives that also possess beneficial properties
for the lungs and respiratory system as a whole are Allium sativum,
Hydrastis canadensis, Sanguinaria canadensis, Baptisia tinctoria, and
Echinacea spp.
```

**Convert to SQL:**
```sql
-- Respiratory Alteratives
INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
VALUES
  ((SELECT id FROM herbal.herbs WHERE latin_name = 'Allium sativum'),
   (SELECT id FROM herbal.primary_actions WHERE name = 'Alteratives'),
   (SELECT id FROM herbal.body_systems WHERE name = 'Respiratory'),
   'mild'),
   
  ((SELECT id FROM herbal.herbs WHERE latin_name = 'Hydrastis canadensis'),
   (SELECT id FROM herbal.primary_actions WHERE name = 'Alteratives'),
   (SELECT id FROM herbal.body_systems WHERE name = 'Respiratory'),
   'strong'),
   
  ((SELECT id FROM herbal.herbs WHERE latin_name = 'Sanguinaria canadensis'),
   (SELECT id FROM herbal.primary_actions WHERE name = 'Alteratives'),
   (SELECT id FROM herbal.body_systems WHERE name = 'Respiratory'),
   'very_strong')
-- etc...
ON CONFLICT DO NOTHING;
```

### 2. Use a Spreadsheet

Create a CSV with columns:
- latin_name
- action_name  
- system_name
- strength
- note

Then convert to SQL INSERT statements.

### 3. Prioritize Key Herbs

Focus on the most commonly used herbs first:
- Garlic (Allium sativum)
- Echinacea (Echinacea spp.)
- Goldenseal (Hydrastis canadensis)
- Ginger (Zingiber officinale)
- Turmeric (Curcuma longa)
- etc.

## Verify Your Data

After adding relationships, check they appear:

```sql
-- See all relationships for Garlic
SELECT 
  h.common_name,
  pa.name as action,
  bs.name as system,
  hpa.relative_strength,
  hpa.body_system_note
FROM herbal.herbs h
JOIN herbal.herb_primary_actions hpa ON h.id = hpa.herb_id
JOIN herbal.primary_actions pa ON hpa.primary_action_id = pa.id
JOIN herbal.body_systems bs ON hpa.body_system_id = bs.id
WHERE h.latin_name = 'Allium sativum';
```

## Why Manual Entry?

Your text file is written in natural language with varying formats:
- "The main alteratives..." (prose)
- "Examples include..." (partial lists)
- "Such herbs include..." (embedded lists)
- Strength levels scattered across sections

A parser would need sophisticated NLP to extract this accurately. Manual entry ensures correctness and lets you add the nuanced notes.

## Time-Saving Tips

1. **Start with one action** - Complete all Alteratives first
2. **Use the sample file as template** - Copy/modify the structure
3. **Do 5-10 herbs thoroughly** - Better to have complete data for a few herbs than partial data for many
4. **Test as you go** - Run `pnpm dev` and check the app after each batch

## Need Help?

The app will work with whatever data you add - even just the 3 sample herbs show the functionality. Add more relationships as needed for your use case!
