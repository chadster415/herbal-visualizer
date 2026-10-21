# Graph Report - herbal-visualizer  (2026-10-21)

## Corpus Check
- 108 files · ~129,837 words
- Verdict: corpus is large enough that graph structure adds value.
- Unclassified: 5 file(s) not represented in the graph (top: .csv 2, (none) 1, .ico 1)

## Summary
- 792 nodes · 1242 edges · 61 communities (45 shown, 16 thin omitted)
- Extraction: 98% EXTRACTED · 2% INFERRED · 0% AMBIGUOUS · INFERRED: 20 edges (avg confidence: 0.88)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- Herb Data & Reference Sources
- API Routes
- AI/Anthropic API Routes
- Python Ingest Scripts
- Herb Filter & UI Utilities
- Intake & Body System UI
- Home Page & Inventory
- Formula Builder
- Database Types & Queries
- Herb Detail & Contraindications
- Dosing Calculator
- Herb Image & Inventory
- Disorder View
- Extraction Calculator
- Flower Essence Quiz
- Herb Detail Panel
- TypeScript Config
- System View & Search
- Energetics Quiz
- Constituent Energetics Inference
- Constituent Taste Inference
- App Architecture & Routing
- Herb Pairings Graph
- Action View
- Project Dependencies
- Dev Dependencies
- NPM Scripts
- Herb View & Data Fetching
- Menstruum Calculator
- Recipe & View Mode Docs
- External Dependencies
- DB Schema & Migration Docs
- Class Notes Ailment View
- Body Diagram Modal
- Help Modal
- Supplement Detail
- Deployment & Auth
- Flashcard Modal
- Scripts TypeScript Config
- Soul Condition View
- Class Quiz Modal
- Flower Essence Detail
- Setup & Schema Docs
- Auth Gateway
- Recipe & System Views
- ESLint Config
- Class Notes Synopsis
- Formula Method Modal
- Image Upload Handlers
- Tailwind Config
- Image Sync Script
- App Icons
- PostCSS Config
- Sample Data
- Colima Script
- Setup Script
- Vercel Config
- Herb Pairings Sources
- Constituent Concentration
- Recipe Data
- Class Notes Source Block

## God Nodes (most connected - your core abstractions)
1. `react` - 31 edges
2. `Home()` - 25 edges
3. `HerbDetailPanel()` - 25 edges
4. `supabase` - 25 edges
5. `EnergeticEmojis()` - 19 edges
6. `HerbView()` - 18 edges
7. `@heroicons/react` - 17 edges
8. `next` - 17 edges
9. `HerbFilterPanel()` - 16 edges
10. `compilerOptions` - 16 edges

## Surprising Connections (you probably didn't know these)
- `GET()` --calls--> `createServerClient()`  [EXTRACTED]
  app/api/herb-image/[herbId]/route.ts → lib/supabase-server.ts
- `POST()` --calls--> `verifySupabaseUser()`  [EXTRACTED]
  app/api/herb-image/presign/route.ts → lib/supabase-auth.ts
- `POST()` --calls--> `verifySupabaseUser()`  [EXTRACTED]
  app/api/recipe-image/presign/route.ts → lib/supabase-auth.ts
- `Home()` --calls--> `ActionView()`  [EXTRACTED]
  app/page.tsx → components/ActionView.tsx
- `Home()` --calls--> `ClassNotesAilmentView()`  [EXTRACTED]
  app/page.tsx → components/ClassNotesAilmentView.tsx

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **Phase 01 Fuzzy Disorder Search: DB column → keyword data → Fuse.js UI** — planning_phases_01_fuzzy_disorder_search_01_01_plan_migration_115, planning_phases_01_fuzzy_disorder_search_01_02_summary_migration_116, planning_phases_01_fuzzy_disorder_search_01_03_plan_fusejs_integration [EXTRACTED 1.00]
- **Herbal Schema Foundation Documentation (CLAUDE.md, PROJECT_SUMMARY, MIGRATION_GUIDE)** — claude_md_db_schema_overview, project_summary_db_schema, migration_guide_initial_setup [INFERRED 0.85]
- **Vercel Deploy Pipeline (workflow, env secrets, health check)** — _github_workflows_vercel_deploy_yml_deploy_workflow, _github_workflows_vercel_deploy_yml_env_secrets, _github_workflows_vercel_deploy_yml_health_check [EXTRACTED 1.00]
- **Herb Data Enrichment Pipeline (constituents → energetics → taste → menstruum)** — adding_herb_data_workflow, inferring_energetics_workflow, inferring_taste_workflow, adding_herb_data_menstruum_constituent_rules [EXTRACTED 0.95]
- **Five External Source Checks Protocol (MM, Stockley, Easley, Hoffmann, Tilgner)** — adding_herb_data_mm_materia_medica, adding_herb_data_stockleys, adding_herb_data_easley, adding_herb_data_hoffmann, adding_herb_data_tilgner [EXTRACTED 1.00]
- **Class Notes Ingestion Pipeline (snippets → keywords → quiz → synopsis)** — docs_parsing_class_notes_workflow, docs_parsing_class_notes_snippets_table, docs_parsing_class_notes_herb_keywords_table, docs_parsing_class_notes_quiz_generation, generating_synopsis_workflow [INFERRED 0.85]

## Communities (61 total, 16 thin omitted)

### Community 0 - "Herb Data & Reference Sources"
Cohesion: 0.05
Nodes (39): Thomas Easley's Dispensatory Reference Source, Five External Source Checks (MM, Stockley's, Easley, Hoffmann, Tilgner), David Hoffmann's Medical Herbalism Reference Source, Constituent-to-Menstruum Derivation Rules, MM Materia Medica Reference Source, parse-mm-materia-medica.py Parser Script, set_menstruum() DB Helper Function, Stockley's Drug Interactions Reference Source (+31 more)

### Community 1 - "API Routes"
Cohesion: 0.08
Nodes (27): POST(), DELETE(), GET(), s3, POST(), s3, DELETE(), POST() (+19 more)

### Community 2 - "AI/Anthropic API Routes"
Cohesion: 0.06
Nodes (30): @anthropic-ai/sdk, actionDescriptions, __dirname, __filename, supabase, Disorder, envPath, KeywordResult (+22 more)

### Community 3 - "Python Ingest Scripts"
Cohesion: 0.08
Nodes (15): fetch_categories(), generate_synonyms_for_batch(), main(), pg_array_literal(), parse_cross_refs(), parse_part_one(), parse_part_two(), sql_array() (+7 more)

### Community 4 - "Herb Filter & UI Utilities"
Cohesion: 0.07
Nodes (29): Action, BodySystem, cardBg(), checkPaneScroll(), DEFAULT_SECTIONS, HerbFilterPanel(), HerbFilterPanelProps, HerbMenstruumData (+21 more)

### Community 5 - "Intake & Body System UI"
Cohesion: 0.10
Nodes (27): Biology, BiologyScreen(), BODY_SYSTEMS, BodySystem, GENERAL_QUESTIONS, GeneralIntroScreen(), GeneralQuizScreen(), HerbCardList() (+19 more)

### Community 6 - "Home Page & Inventory"
Cohesion: 0.11
Nodes (20): Home(), InventoryEntry, InventoryMap, NavEntry, ViewMode, BodyDiagramModal(), InventoryView(), LoginModal() (+12 more)

### Community 7 - "Formula Builder"
Cohesion: 0.09
Nodes (24): BASE_ACTION_KEYWORDS, buildCandidates(), Candidate, Constitution, EMPTY_CANDIDATES, EMPTY_FOUR_CANDIDATES, EMPTY_FOUR_SELECTED, EMPTY_SELECTED (+16 more)

### Community 8 - "Database Types & Queries"
Cohesion: 0.10
Nodes (23): CategoryDetail, Constituent, ConstituentWithHerbs, DisorderActionHerb, DisorderActionIndicated, DisorderSpecificRemedy, FlowerEssenceCategory, FlowerEssenceCategoryWithEntries (+15 more)

### Community 9 - "Herb Detail & Contraindications"
Cohesion: 0.10
Nodes (20): ContraindicationsModal(), Props, ClassNoteSnippet, ConstituentHerbRef, ConstituentProfile, DuiYaoHerbStub, DuiYaoPair, HerbDetailPanelProps (+12 more)

### Community 10 - "Dosing Calculator"
Cohesion: 0.12
Nodes (15): BOTTLE_SIZES, computePartsArray(), DosingCalculatorModal(), gcd(), HerbAction, HerbEntry, HerbOption, menstruumBadges() (+7 more)

### Community 11 - "Herb Image & Inventory"
Cohesion: 0.15
Nodes (14): HerbImage, Props, HerbRow, InventoryEntry, InventoryMap, InventoryViewProps, Props, RecipeImageUpload() (+6 more)

### Community 12 - "Disorder View"
Cohesion: 0.15
Nodes (16): DEFAULT_SUPP_COLORS, DisorderData, DisorderView(), DisorderViewProps, groupByHeading(), InventoryEntry, NoteGroup, parseFoodSources() (+8 more)

### Community 13 - "Extraction Calculator"
Cohesion: 0.16
Nodes (17): ALCOHOL_SOLUBLE_CLASSES, AlcoholBar(), BOTH_CLASSES, Calc, calculate(), classifySolubility(), ConstituentRow, DoubleExtractionCalculatorModal() (+9 more)

### Community 14 - "Flower Essence Quiz"
Cohesion: 0.14
Nodes (18): BetweenScreen(), EssenceResult, FlowerEssenceQuizModal(), INITIAL_THEME_SCORES, IntroScreen(), kitBadge(), Props, QuizScreen() (+10 more)

### Community 15 - "Herb Detail Panel"
Cohesion: 0.12
Nodes (11): getStrengthColor(), HerbDetailPanel(), calcTooltipPos(), handlePillClick(), handlePillMouseEnter(), highlightHerbName(), importanceBadgeColor(), menstruumBadges() (+3 more)

### Community 16 - "TypeScript Config"
Cohesion: 0.11
Nodes (18): compilerOptions, allowJs, esModuleInterop, incremental, isolatedModules, jsx, lib, module (+10 more)

### Community 17 - "System View & Search"
Cohesion: 0.18
Nodes (17): ActionData, HerbData, DisorderListItem, FuseEntry, InferredAilment, InventoryEntry, SystemData, SystemNote (+9 more)

### Community 18 - "Energetics Quiz"
Cohesion: 0.16
Nodes (15): Dimension, DIMENSION_INFO, DimInfo, EMPTY_HERBS, EnergeticsQuizModal(), fetchHerbsByDimension(), HerbEntry, HerbsByDimension (+7 more)

### Community 19 - "Constituent Energetics Inference"
Cohesion: 0.15
Nodes (14): analyzeMoisture(), analyzeTemperature(), CONFIDENCE_COLOR, ConstituentProfile, DIRECTION_LABEL, HerbConstituent, HIGH_IMPORTANCE, InferredEnergeticsModal() (+6 more)

### Community 20 - "Constituent Taste Inference"
Cohesion: 0.14
Nodes (14): analyzeTaste(), CONFIDENCE_COLOR, ConstituentProfile, DIRECTION_LABEL, HerbConstituent, HIGH_IMPORTANCE, InferredTasteModal(), LEVEL_WEIGHT (+6 more)

### Community 21 - "App Architecture & Routing"
Cohesion: 0.20
Nodes (9): SystemView Component (body system panel, disorder list, Fuse.js search), Fuzzy / Semantic Disorder Search Feature (Phase 01), Migration 115: Add search_keywords Column to herbal.disorders, Phase 01-01 Summary: search_keywords Migration Complete, Plan 01-02: Disorder Keyword Generation via Claude API Script, Phase 01-02 Summary: Pivoted to Inline Keyword Generation, Migration 116: Disorder search_keywords Data, Plan 01-03: Fuse.js Semantic Disorder Search Integration (+1 more)

### Community 22 - "Herb Pairings Graph"
Cohesion: 0.18
Nodes (11): ForceGraph2D, GraphLink, GraphNode, NODE_COLORS, PairingsView(), load(), onKey(), resetFocus() (+3 more)

### Community 23 - "Action View"
Cohesion: 0.23
Nodes (10): ActionDescription, ActionView(), ActionViewProps, InventoryEntry, RecipeForAction, EmojiTip(), EnergeticEmojis(), InventoryTip() (+2 more)

### Community 24 - "Project Dependencies"
Cohesion: 0.17
Nodes (11): name, private, version, autoprefixer, postcss, react-dom, ts-node, @types/node (+3 more)

### Community 25 - "Dev Dependencies"
Cohesion: 0.17
Nodes (12): devDependencies, @anthropic-ai/sdk, autoprefixer, eslint, eslint-config-next, postcss, tailwindcss, ts-node (+4 more)

### Community 26 - "NPM Scripts"
Cohesion: 0.17
Nodes (12): scripts, build, dev, dev-db, ingest, lint, reset-db, restart-colima (+4 more)

### Community 27 - "Herb View & Data Fetching"
Cohesion: 0.24
Nodes (7): HerbView(), scrollEssenceInSidebar(), scrollHerbInSidebar(), scrollItemInSidebar(), scrollSupplementInSidebar(), solubilityLabel(), solubilityStyles()

### Community 28 - "Menstruum Calculator"
Cohesion: 0.22
Nodes (10): ABSORPTION_BY_PLANT_PART, ABSORPTION_CATEGORIES, ABSORPTION_OVERRIDES, AbsorptionLabel, guessAbsorptionLabel(), HerbOption, MenstruumCalculatorModal(), Props (+2 more)

### Community 29 - "Recipe & View Mode Docs"
Cohesion: 0.18
Nodes (9): Recipe Tables (recipes, recipe_body_systems, recipe_herbs, recipe_images, recipe_primary_actions), Adding Recipes Workflow, By Action View Mode, By Body System View Mode, By Herb View Mode, Herbal Database Schema (herbal.*), Herbal Medicine Visualizer Application, parse-data.ts Seed Regeneration Script (+1 more)

### Community 30 - "External Dependencies"
Cohesion: 0.18
Nodes (11): dependencies, @aws-sdk/client-s3, @aws-sdk/s3-request-presigner, fuse.js, @heroicons/react, @marsidev/react-turnstile, next, react (+3 more)

### Community 31 - "DB Schema & Migration Docs"
Cohesion: 0.20
Nodes (6): BHC Source File Format and 9-Block Migration Structure, Database Schema Overview (herbal schema tables), SQL Helper Functions (ensure_herb, ensure_action, ensure_constituent, set_menstruum), Data Entry Guide: Herb-Action-System Relationship Model, PROJECT_SUMMARY Database Schema (herbal schema tables and enums), PROJECT_SUMMARY Migration Conventions (idempotent, re-runnable, manual)

### Community 32 - "Class Notes Ailment View"
Cohesion: 0.24
Nodes (9): AilmentEntry, ClassNotesAilmentView(), ClassNotesAilmentViewProps, ClassNoteSnippet, DetailData, HerbSummary, highlightName(), SnippetList() (+1 more)

### Community 33 - "Body Diagram Modal"
Cohesion: 0.25
Nodes (7): BODY_REGIONS, BodySystem, Disorder, Props, REGION_COLORS, REGION_SYSTEM_NAMES, SYSTEMIC_REGIONS

### Community 34 - "Help Modal"
Cohesion: 0.25
Nodes (6): Feature, features, HelpModal(), HelpModalProps, Props, @heroicons/react

### Community 35 - "Supplement Detail"
Cohesion: 0.36
Nodes (7): categoryColor(), ClassNoteSnippet, DisorderRef, solubilityColor(), SupplementDetail(), SupplementDetailProps, Supplement

### Community 36 - "Deployment & Auth"
Cohesion: 0.29
Nodes (5): Vercel Deploy GitHub Actions Workflow, Deployment Health Check (herbal-visualizer.vercel.app/api/health), CLAUDE.md: Project Context and Conventions for herbal-visualizer, PROJECT_SUMMARY Auth: _hv_verified Cookie and Turnstile Gateway, Tech Stack: Next.js 15 + React 19, Supabase, Tailwind, TypeScript, pnpm

### Community 37 - "Flashcard Modal"
Cohesion: 0.38
Nodes (6): buildDeck(), Card, FlashcardModal(), Herb, Props, shuffle()

### Community 38 - "Scripts TypeScript Config"
Cohesion: 0.29
Nodes (6): ./tsconfig.json, compilerOptions, isolatedModules, module, moduleResolution, extends

### Community 39 - "Soul Condition View"
Cohesion: 0.60
Nodes (6): SoulConditionView(), buildDetail(), handleKeyDown(), load(), scrollCategoryInSidebar(), selectCategory()

### Community 40 - "Class Quiz Modal"
Cohesion: 0.40
Nodes (4): ClassQuizModal(), Props, QuizQuestion, Stage

### Community 41 - "Flower Essence Detail"
Cohesion: 0.60
Nodes (4): FlowerEssenceDetail(), FlowerEssenceDetailProps, Section(), FlowerEssencePlant

### Community 42 - "Setup & Schema Docs"
Cohesion: 0.40
Nodes (5): Herbal Schema Isolation (separate PostgreSQL schema for herbal data), EXPOSE_SCHEMA: Exposing herbal Schema to Supabase REST API, Migration Guide: Initial Schema and Seed Data Setup, OVERVIEW: Multi-Dimensional Herbal Medicine Visualization Tool, Quick Start: Three-Step Setup (install, migrate, configure)

### Community 45 - "ESLint Config"
Cohesion: 0.50
Nodes (3): eslintConfig, eslint, eslint-config-next

### Community 46 - "Class Notes Synopsis"
Cohesion: 0.50
Nodes (3): herbs.class_notes_synopsis Column, HerbView.tsx Synopsis Renderer (dangerouslySetInnerHTML), Generating Class Notes Synopsis Workflow

## Knowledge Gaps
- **47 isolated node(s):** `react-dom`, `@types/node`, `@types/react`, `@types/react-dom`, `autoprefixer` (+42 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 435 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **16 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `react` connect `Herb Image & Inventory` to `Herb Filter & UI Utilities`, `Intake & Body System UI`, `Home Page & Inventory`, `Formula Builder`, `Herb Detail & Contraindications`, `Dosing Calculator`, `Disorder View`, `Extraction Calculator`, `Flower Essence Quiz`, `System View & Search`, `Energetics Quiz`, `Constituent Taste Inference`, `Herb Pairings Graph`, `Action View`, `Project Dependencies`, `Menstruum Calculator`, `Class Notes Ailment View`, `Body Diagram Modal`, `Help Modal`, `Supplement Detail`, `Flashcard Modal`, `Class Quiz Modal`, `Auth Gateway`?**
  _High betweenness centrality (0.129) - this node is a cross-community bridge._
- **What connects `react-dom`, `@types/node`, `@types/react` to the rest of the system?**
  _47 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Herb Data & Reference Sources` be split into smaller, more focused modules?**
  _Cohesion score 0.04717853839037928 - nodes in this community are weakly interconnected._
- **Why does `@supabase/supabase-js` connect `API Routes` to `Project Dependencies`, `AI/Anthropic API Routes`, `Herb Image & Inventory`?**
  _High betweenness centrality (0.081) - this node is a cross-community bridge._
- **Should `API Routes` be split into smaller, more focused modules?**
  _Cohesion score 0.08325624421831637 - nodes in this community are weakly interconnected._
- **Why does `next` connect `API Routes` to `Project Dependencies`, `AI/Anthropic API Routes`, `Auth Gateway`, `Herb Pairings Graph`?**
  _High betweenness centrality (0.065) - this node is a cross-community bridge._
- **Should `AI/Anthropic API Routes` be split into smaller, more focused modules?**
  _Cohesion score 0.05647840531561462 - nodes in this community are weakly interconnected._