# Project Overview

## What We Built

A multi-dimensional visualization tool for herbal medicine data that solves the problem you described - the Google Sheets flat structure couldn't handle the complexity of relationships between:
- Herbs (562 total)
- Primary Actions (21 categories)
- Secondary Actions
- Body Systems (8 systems)
- Relative Strengths (mild, strong, very strong)

## Why This Solution Works

### 1. Proper Data Model
Unlike a spreadsheet, we use a relational database with junction tables to handle the many-to-many relationships:
- One herb can have multiple actions
- One action can apply to multiple body systems
- Each herb-action-system combination can have unique notes and strength ratings

### 2. Three Different Views

**By Herb View**
- Search herbs by common or Latin name
- Click on any herb to see all its actions, body systems, and strength ratings
- Perfect for: "What does garlic do?"

**By Action View**
- Browse all herbal actions (Alteratives, Adaptogens, etc.)
- See which herbs have that action, grouped by body system
- Color-coded by strength
- Perfect for: "Which herbs are alteratives for the digestive system?"

**By Body System View**
- Select any body system
- See all herbs that affect it, organized by their primary action
- Perfect for: "What herbs help the respiratory system?"

### 3. Visual Design
- Color-coded strength indicators:
  - Yellow = Mild
  - Orange = Strong  
  - Red = Very Strong
- Responsive layout works on desktop and mobile
- Clean, herbalist-friendly green color scheme

## Data Flow

1. **Source**: Secondary Actions.txt (your original text file)
2. **Parser**: TypeScript script extracts structured data
3. **Database**: PostgreSQL with proper schema and indexes
4. **API**: Supabase provides real-time querying
5. **UI**: React components render three different views

## Key Features You Requested

✅ Visualize by single herb (latin or common name)
✅ Visualize by herbal action
✅ Visualize by body system
✅ Display relative strength with primary action
✅ Multi-dimensional (not flat like spreadsheet)
✅ Local database (Supabase, like grungras project)

## Next Steps (Optional Enhancements)

1. **Add Secondary Actions**: Currently focused on primary actions, could add the secondary action relationships

2. **Advanced Filtering**: 
   - Filter by strength level
   - Multiple system selection
   - Combination searches

3. **Visual Enhancements**:
   - Network graph visualization
   - Action/system matrix view
   - Printable herb profiles

4. **Data Entry**:
   - Admin interface to add new herbs
   - Edit existing data
   - Import/export functionality

5. **Mobile App**: Convert to React Native or PWA

## Technical Notes

- **Performance**: Indexes on all foreign keys for fast queries
- **Type Safety**: Full TypeScript coverage
- **Scalability**: Can handle thousands of herbs
- **Maintainability**: Clear separation of concerns
- **Data Integrity**: Foreign key constraints prevent orphaned data

## Comparison to Google Sheets

| Feature | Google Sheets | This App |
|---------|---------------|----------|
| Multi-dimensional | ❌ Flat | ✅ Relational |
| Search/Filter | Limited | ✅ Advanced |
| Views | Single table | ✅ Three views |
| Relationships | Manual | ✅ Automatic |
| Performance | Slow with data | ✅ Fast |
| Data Integrity | Manual | ✅ Enforced |
| Visualization | Charts only | ✅ Custom UI |

