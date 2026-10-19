-- Add class_notes_synopsis column to herbs table
-- Stores a synthesized synopsis paragraph aggregated from all class note snippets for the herb.
-- HTML <strong> tags are used for inline bolding (rendered via dangerouslySetInnerHTML in HerbView).

ALTER TABLE herbal.herbs
  ADD COLUMN IF NOT EXISTS class_notes_synopsis text;
