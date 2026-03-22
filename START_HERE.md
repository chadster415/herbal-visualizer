# 🌿 START HERE - Herbal Medicine Visualizer

Welcome! This is your complete guide to getting the herbal medicine visualizer running.

## 📖 Choose Your Path

### 🏃 Want to Run It Now? (5 minutes)
👉 **[QUICK_START.md](QUICK_START.md)** - Three simple steps to get running

### 📚 Want to Understand It First?
👉 **[PROJECT_SUMMARY.md](PROJECT_SUMMARY.md)** - What's been built and why

### 🔧 Need Detailed Setup Instructions?
👉 **[MIGRATION_GUIDE.md](MIGRATION_GUIDE.md)** - Step-by-step database setup

### 📖 Want Full Documentation?
👉 **[README.md](README.md)** - Complete project documentation

### 🏗 Want to Understand the Architecture?
👉 **[OVERVIEW.md](OVERVIEW.md)** - Design decisions & comparisons

---

## ⚡ Super Quick Start (TL;DR)

Already have Supabase running? Here's all you need:

### 1. Install
```bash
pnpm install
```

### 2. Run SQL
Open Supabase SQL Editor, paste this file, click Run:
```
supabase/migrations/complete_setup.sql
```

### 3. Configure
```bash
echo "NEXT_PUBLIC_SUPABASE_URL=http://localhost:54321" > .env.local
echo "NEXT_PUBLIC_SUPABASE_ANON_KEY=your-key" >> .env.local
```

### 4. Launch
```bash
pnpm dev
```

Done! Open **http://localhost:3000**

---

## 🎯 What This App Does

Visualizes 562 medicinal herbs in three ways:

1. **By Herb** - Search for "garlic", see all its actions & systems
2. **By Action** - Browse "Alteratives", see all herbs with that action
3. **By Body System** - View "Respiratory", see all herbs that help it

With color-coded strength indicators (mild/strong/very strong).

---

## 🗄️ Database Info

- **Schema**: `herbal` (isolated, won't conflict with other projects)
- **Herbs**: 562 loaded
- **Actions**: 21 categories
- **Systems**: 8 body systems
- **Tables**: 6 total

---

## 📁 File Structure Quick Reference

```
📄 Documentation (you are here)
   ├── START_HERE.md ⭐ (this file)
   ├── QUICK_START.md
   ├── PROJECT_SUMMARY.md
   ├── MIGRATION_GUIDE.md
   ├── OVERVIEW.md
   └── README.md

🗄️ Database
   └── supabase/migrations/
       ├── complete_setup.sql ⭐ (run this!)
       ├── 001_herbal_schema.sql
       └── 002_seed_data.sql

⚛️ Application Code
   ├── app/page.tsx
   ├── components/*.tsx
   ├── lib/supabase.ts
   └── types/database.ts

🔧 Utilities
   └── scripts/parse-data.ts
```

---

## ❓ Common Questions

**Q: Will this mess up my existing Supabase data?**
A: No! It uses a dedicated `herbal` schema that's completely isolated.

**Q: Do I need Docker?**
A: Only if you don't have Supabase running yet. If you already have it, you're good to go.

**Q: Can I modify the data?**
A: Yes! Edit `Secondary Actions.txt` and run `pnpm exec ts-node scripts/parse-data.ts`

**Q: Can I deploy this?**
A: Yes! Push to GitHub, connect to Vercel, add your Supabase credentials, deploy.

**Q: What if I get stuck?**
A: Check [MIGRATION_GUIDE.md](MIGRATION_GUIDE.md) → Troubleshooting section

---

## 🎓 Documentation Index

| File | Purpose | Read This If... |
|------|---------|----------------|
| **START_HERE.md** | This file | You just opened the project |
| **QUICK_START.md** | Get running fast | You want to launch it ASAP |
| **PROJECT_SUMMARY.md** | High-level overview | You want to understand what was built |
| **MIGRATION_GUIDE.md** | Detailed setup | You need step-by-step instructions |
| **OVERVIEW.md** | Architecture & design | You want to understand how it works |
| **README.md** | Full documentation | You want comprehensive details |

---

## 🚀 Ready to Start?

1. Have Supabase running? ✅
2. Want to run it now? → **[QUICK_START.md](QUICK_START.md)**
3. Want to learn first? → **[PROJECT_SUMMARY.md](PROJECT_SUMMARY.md)**

Enjoy exploring herbal medicine! 🌿
