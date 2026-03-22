# Running with Sample Data

## Quick Start - See It Working Now!

You've already run `complete_setup.sql` which loaded:
- ✅ Schema and tables
- ✅ 562 herbs
- ✅ 21 actions  
- ✅ 8 body systems

Now run the **sample relationships** to see the app work:

### Step 1: Add Sample Relationships

In Supabase SQL Editor, run:

```sql
-- Copy/paste this entire file:
supabase/migrations/003_sample_relationships.sql
```

This adds example data for 3 herbs:
- **Garlic** (Allium sativum) - 3 systems, 6 secondary actions
- **Burdock** (Arctium lappa) - 3 systems, 3 secondary actions
- **Echinacea** (Echinacea spp.) - 3 systems, 2 secondary actions

### Step 2: Start the App

```bash
cd herbal-visualizer
pnpm dev
```

Open http://localhost:3000

### Step 3: Test the Views

1. **By Herb**: Search for "garlic" - you'll see its Alterative actions for Cardiovascular, Respiratory, and Digestive systems

2. **By Action**: Click "Alteratives" - you'll see garlic, burdock, and echinacea grouped by body system

3. **By Body System**: Click "Digestive" - you'll see all 3 herbs that affect it

### What You'll See

The app is fully functional with this sample data! You'll see:
- Color-coded strength indicators
- Searchable herb list
- System notes (e.g., "The hypocholesteremic and hypotensive actions are well known")
- Secondary actions displayed

### Next Steps

Once you confirm it's working, you can:

1. **Add more herbs** - See [DATA_ENTRY_GUIDE.md](DATA_ENTRY_GUIDE.md)
2. **Use as-is** - The sample data demonstrates all functionality
3. **Add your most-used herbs** - Focus on the herbs you work with most

### Verification Queries

Check the data loaded correctly:

```sql
-- Should return 3 herbs with relationships
SELECT COUNT(DISTINCT herb_id) FROM herbal.herb_primary_actions;

-- See all Garlic's data
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

### Troubleshooting

**App shows empty lists?**
- Verify you ran `003_sample_relationships.sql`
- Check `.env.local` has correct Supabase credentials
- Look at browser console for errors

**Can't find the herbs?**
- They're in the list! Search for "garlic", "burdock", or "echinacea"

**Want more data?**
- See [DATA_ENTRY_GUIDE.md](DATA_ENTRY_GUIDE.md) for how to add more relationships
- Or ask me to generate more sample data from your text file!

## Summary

You now have a **working herbal medicine visualizer** with sample data! The app demonstrates all three visualization modes with real herb data from your text file.
