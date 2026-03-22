# Quick Start Guide

## 🚀 Three Steps to Get Running

### 1. Install Dependencies
```bash
cd herbal-visualizer
pnpm install
```

### 2. Run SQL Migration
Open your Supabase SQL Editor and paste this file:
```
supabase/migrations/complete_setup.sql
```
Click **Run**. Done! ✅

This creates:
- ✅ `herbal` schema (isolated from other projects)
- ✅ All tables with proper indexes
- ✅ 562 herbs loaded
- ✅ 21 primary actions loaded
- ✅ 8 body systems loaded

### 3. Configure & Start
```bash
# Update .env.local with your Supabase URL and key
echo "NEXT_PUBLIC_SUPABASE_URL=http://localhost:54321" > .env.local
echo "NEXT_PUBLIC_SUPABASE_ANON_KEY=your-key" >> .env.local

# Start the app
pnpm dev
```

Open: **http://localhost:3000**

---

## 🎯 What You Get

Three visualization modes:

1. **By Herb** - Search and explore individual herbs
2. **By Action** - Browse herbs by their medicinal actions
3. **By Body System** - See which herbs affect each system

All with color-coded strength indicators:
- 🟡 Yellow = Mild
- 🟠 Orange = Strong
- 🔴 Red = Very Strong

---

## 📁 Key Files

| File | Purpose |
|------|---------|
| `supabase/migrations/complete_setup.sql` | **Run this first** - Creates everything |
| `app/page.tsx` | Main page with view switcher |
| `components/HerbView.tsx` | By herb visualization |
| `components/ActionView.tsx` | By action visualization |
| `components/SystemView.tsx` | By system visualization |
| `lib/supabase.ts` | Database connection |

---

## 🔍 Verify It Worked

In Supabase SQL Editor, run:
```sql
SELECT COUNT(*) FROM herbal.herbs;
-- Should return: 562

SELECT * FROM herbal.body_systems;
-- Should return: 8 systems

SELECT h.common_name, pa.name as action, bs.name as system
FROM herbal.herbs h
JOIN herbal.herb_primary_actions hpa ON h.id = hpa.herb_id
JOIN herbal.primary_actions pa ON hpa.primary_action_id = pa.id
JOIN herbal.body_systems bs ON hpa.body_system_id = bs.id
LIMIT 5;
-- Should return: herb data
```

---

## 🛠 Troubleshooting

**Can't connect to database?**
- Check `.env.local` has correct URL and key
- Verify Supabase is running

**Empty results in app?**
- Verify migration ran: `SELECT * FROM herbal.herbs LIMIT 1;`
- Check browser console for errors

**Permission errors?**
```sql
GRANT USAGE ON SCHEMA herbal TO postgres, anon, authenticated;
GRANT ALL ON ALL TABLES IN SCHEMA herbal TO postgres, anon, authenticated;
```

---

## 📚 Next Steps

- Read [MIGRATION_GUIDE.md](MIGRATION_GUIDE.md) for detailed setup
- Read [OVERVIEW.md](OVERVIEW.md) to understand the architecture
- Edit data: `scripts/parse-data.ts` to regenerate from text file
