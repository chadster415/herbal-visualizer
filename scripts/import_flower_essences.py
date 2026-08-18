#!/usr/bin/env python3
"""
Parse Flower Essence Repertory - Cleaned.txt and generate SQL migration 193.
Run from the herbal-visualizer/ directory:
    python3 scripts/import_flower_essences.py
"""

import re
import sys
from pathlib import Path

SOURCE = Path('/Users/chadarmstrong/Downloads/Flower Essence Repertory - Cleaned.txt')
OUTPUT = Path('supabase/migrations/193_flower_essence_data.sql')


def sql_str(s):
    if s is None:
        return 'NULL'
    return "'" + str(s).replace("'", "''") + "'"


def sql_array(items):
    if not items:
        return "ARRAY[]::TEXT[]"
    return "ARRAY[" + ", ".join(sql_str(i) for i in items) + "]"


# ── Load ──────────────────────────────────────────────────────────────────────

with open(SOURCE, encoding='utf-8') as f:
    content = f.read()

# ── Split Part One / Part Two ─────────────────────────────────────────────────

split_m = re.search(
    r'={50,}\nPART TWO: INDIVIDUAL FLOWER ESSENCE PROFILES\n={50,}',
    content
)
if not split_m:
    sys.exit("ERROR: Could not find Part Two separator")

part_one_text = content[:split_m.start()]
part_two_text = content[split_m.end():]

# Part Two ends at the Kits index section
kits_m = re.search(r'\n# Kits\n', part_two_text)
if kits_m:
    part_two_text = part_two_text[:kits_m.start()]


# ── Parse Part One: Soul Condition entries ─────────────────────────────────────

def parse_part_one(text):
    """
    Returns:
      categories:   set of category name strings
      entries:      list of (category, plant_name, description)
      see_also:     list of (from_category, to_category) tuples
    """
    categories = set()
    entries = []
    see_also = []
    current_category = None
    lines = text.split('\n')
    i = 0
    n = len(lines)

    while i < n:
        line = lines[i]
        stripped = line.strip()

        # Category header
        cat_m = re.match(r'^== (.+)$', stripped)
        if cat_m:
            current_category = cat_m.group(1).strip()
            categories.add(current_category)
            i += 1
            continue

        # See Also line — parse relationships
        if stripped.startswith('(See also') and current_category:
            inner = re.match(r'^\(See also (.+?)\)$', stripped)
            if inner:
                targets = [t.strip() for t in inner.group(1).split(',')]
                for target in targets:
                    if target:
                        see_also.append((current_category, target))
            i += 1
            continue

        # Skip blanks, TOC dot lines
        if (not stripped
                or '......' in stripped
                or re.match(r'^[A-Z].*\.\.\s*\d', stripped)):
            i += 1
            continue

        # Skip anything before first category
        if not current_category:
            i += 1
            continue

        # Plant entry: must contain em dash separator
        if ' — ' in stripped:
            parts = stripped.split(' — ', 1)
            plant_name = parts[0].strip()
            description = parts[1].strip()

            # Collect wrapped continuation lines
            j = i + 1
            while j < n:
                nxt = lines[j].strip()
                if not nxt:
                    break
                if re.match(r'^== ', nxt):
                    break
                if ' — ' in nxt:
                    break
                if nxt.startswith('(See also'):
                    break
                description += ' ' + nxt
                j += 1

            if plant_name:
                entries.append((current_category, plant_name, description))
            i = j
            continue

        i += 1

    return categories, entries, see_also


categories, condition_entries, see_also_rels = parse_part_one(part_one_text)
print(f"Part One: {len(categories)} categories, {len(condition_entries)} condition entries, {len(see_also_rels)} see-also relationships")


# ── Cross-reference parser (greedy, longest-match) ────────────────────────────

def parse_cross_refs(raw_text, category_set):
    """
    Split a space-separated cross-reference string into known category names.
    Multi-word categories are matched greedily (longest first).
    Unknown tokens are kept as-is.
    """
    cats_sorted = sorted(category_set, key=lambda c: (-len(c.split()), c))
    tokens = raw_text.split()
    result = []
    i = 0
    while i < len(tokens):
        matched = False
        for cat in cats_sorted:
            cat_tokens = cat.split()
            end = i + len(cat_tokens)
            if tokens[i:end] == cat_tokens:
                result.append(cat)
                i = end
                matched = True
                break
        if not matched:
            result.append(tokens[i])
            i += 1
    return result


# ── Parse Part Two: Individual Profiles ───────────────────────────────────────

def parse_part_two(text, category_set):
    profiles = []
    lines = text.split('\n')
    n = len(lines)

    def next_nonblank(start):
        j = start
        while j < n and not lines[j].strip():
            j += 1
        return j

    def is_plant_name(line):
        if not line or len(line) > 55:
            return False
        skip_prefixes = ('Positive qualities:', 'Patterns of imbalance:',
                         'Cross-references:', '==', '#', '=', '(')
        if any(line.startswith(p) for p in skip_prefixes):
            return False
        if line.isupper():
            return False
        return True

    def is_latin_line(line):
        if re.match(r'^[A-Z][a-z]+ [a-z]', line):
            return True
        if line.startswith('A combination of'):
            return True
        if 'solarized' in line.lower():
            return True
        return False

    def collect_section(rest, idx):
        """Collect rest + subsequent non-blank lines into one string."""
        parts = [rest.strip()] if rest.strip() else []
        j = idx
        while j < n and lines[j].strip():
            parts.append(lines[j].strip())
            j += 1
        return ' '.join(parts), j

    i = 0
    while i < n:
        i = next_nonblank(i)
        if i >= n:
            break

        line = lines[i].strip()

        if not is_plant_name(line):
            i += 1
            continue

        # Confirm next non-blank is a Latin name
        j = next_nonblank(i + 1)
        if j >= n:
            break
        if not is_latin_line(lines[j].strip()):
            i += 1
            continue

        # ── Profile header ────────────────────────────────────────────────────
        profile = {
            'name': line,
            'latin_name': None,
            'color': None,
            'kit': None,
            'positive_qualities': None,
            'patterns_of_imbalance': None,
            'cross_references': [],
            'description': None,
        }

        lat_line = lines[j].strip()
        i = j + 1

        # Check for color embedded in the Latin name line, e.g. "Cypripedium parviflorum (yellow)"
        COLOR_WORDS = {'white', 'yellow', 'blue', 'red', 'pink', 'violet',
                       'green', 'orange', 'purple', 'magenta', 'multiple',
                       'rose', 'mauve', 'lavender', 'cream', 'coral', 'indigo'}
        emb = re.search(r'\s*\(([^)]+)\)\s*$', lat_line)
        if emb:
            color_cand = emb.group(1)
            # Only treat as color if it contains a recognized color word
            if any(w in color_cand.lower().split() for w in COLOR_WORDS):
                profile['color'] = color_cand
                lat_line = lat_line[:emb.start()].strip()
        profile['latin_name'] = lat_line

        # Color line — standalone "(color)" line
        k = next_nonblank(i)
        if k < n and lines[k].strip().startswith('(') and not profile['color']:
            cm = re.match(r'^\(([^)]+)\)$', lines[k].strip())
            if cm:
                profile['color'] = cm.group(1)
                i = k + 1

        # Kit line
        k = next_nonblank(i)
        if k < n and ('Kit' in lines[k] or 'essence' in lines[k].lower()):
            profile['kit'] = lines[k].strip()
            i = k + 1

        # ── Profile body ──────────────────────────────────────────────────────
        desc_parts = []
        in_description = False

        while i < n:
            raw = lines[i]
            s = raw.strip()

            if not s:
                # Blank line: peek ahead for new profile start
                k = next_nonblank(i + 1)
                if k < n:
                    kk = next_nonblank(k + 1)
                    if (is_plant_name(lines[k].strip())
                            and kk < n
                            and is_latin_line(lines[kk].strip())):
                        i = k
                        break
                i += 1
                continue

            if s.startswith('Positive qualities:'):
                rest = s[len('Positive qualities:'):]
                profile['positive_qualities'], i = collect_section(rest, i + 1)
                in_description = False
                continue

            if s.startswith('Patterns of imbalance:'):
                rest = s[len('Patterns of imbalance:'):]
                profile['patterns_of_imbalance'], i = collect_section(rest, i + 1)
                in_description = False
                continue

            if s.startswith('Cross-references:'):
                rest = s[len('Cross-references:'):]
                raw_refs, i = collect_section(rest, i + 1)
                profile['cross_references'] = parse_cross_refs(raw_refs, category_set)
                in_description = False
                continue

            in_description = True
            desc_parts.append(s)
            i += 1

        profile['description'] = ' '.join(desc_parts).strip() or None
        profiles.append(profile)

    return profiles


profiles = parse_part_two(part_two_text, categories)
print(f"Part Two: {len(profiles)} profiles")


# ── Sanity check ──────────────────────────────────────────────────────────────

print("\nFirst 5 profiles:")
for p in profiles[:5]:
    refs_preview = p['cross_references'][:3]
    print(f"  {p['name']} | {p['latin_name']} | {p['color']} | {p['kit']} | refs[0:3]={refs_preview}")

print(f"\nFirst 5 condition entries:")
for cat, name, desc in condition_entries[:5]:
    print(f"  [{cat}] {name}: {desc[:60]}...")


# ── Generate SQL ──────────────────────────────────────────────────────────────

sql = []

sql.append("""\
-- Migration 193: Flower Essence Repertory data
-- Source: Flower Essence Repertory - Cleaned.txt
-- Tables: flower_essence_plants, flower_essence_condition_entries,
--         flower_essence_category_see_also
-- Generated by scripts/import_flower_essences.py

SET search_path TO herbal, public;

-- ============================================================
-- Table: flower_essence_plants (Part Two profiles)
-- ============================================================

CREATE TABLE IF NOT EXISTS herbal.flower_essence_plants (
  id                    SERIAL PRIMARY KEY,
  name                  TEXT NOT NULL,
  latin_name            TEXT,
  color                 TEXT,
  kit                   TEXT,
  positive_qualities    TEXT,
  patterns_of_imbalance TEXT,
  description           TEXT,
  cross_references      TEXT[] DEFAULT ARRAY[]::TEXT[],
  UNIQUE (name, latin_name)
);

GRANT ALL ON TABLE herbal.flower_essence_plants
  TO postgres, anon, authenticated, service_role;
GRANT ALL ON SEQUENCE herbal.flower_essence_plants_id_seq
  TO postgres, anon, authenticated, service_role;
ALTER TABLE herbal.flower_essence_plants ENABLE ROW LEVEL SECURITY;
DO $$ BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE schemaname='herbal' AND tablename='flower_essence_plants'
      AND policyname='anon_read'
  ) THEN
    CREATE POLICY "anon_read" ON herbal.flower_essence_plants
      FOR SELECT USING (true);
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE schemaname='herbal' AND tablename='flower_essence_plants'
      AND policyname='service_write'
  ) THEN
    CREATE POLICY "service_write" ON herbal.flower_essence_plants
      FOR ALL TO service_role USING (true) WITH CHECK (true);
  END IF;
END $$;

-- ============================================================
-- Table: flower_essence_condition_entries (Part One)
-- ============================================================

CREATE TABLE IF NOT EXISTS herbal.flower_essence_condition_entries (
  id          SERIAL PRIMARY KEY,
  category    TEXT NOT NULL,
  plant_name  TEXT NOT NULL,
  plant_id    INTEGER REFERENCES herbal.flower_essence_plants(id),
  description TEXT,
  UNIQUE (category, plant_name)
);

CREATE INDEX IF NOT EXISTS idx_fece_category
  ON herbal.flower_essence_condition_entries(category);
CREATE INDEX IF NOT EXISTS idx_fece_plant_id
  ON herbal.flower_essence_condition_entries(plant_id);

GRANT ALL ON TABLE herbal.flower_essence_condition_entries
  TO postgres, anon, authenticated, service_role;
GRANT ALL ON SEQUENCE herbal.flower_essence_condition_entries_id_seq
  TO postgres, anon, authenticated, service_role;
ALTER TABLE herbal.flower_essence_condition_entries ENABLE ROW LEVEL SECURITY;
DO $$ BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE schemaname='herbal' AND tablename='flower_essence_condition_entries'
      AND policyname='anon_read'
  ) THEN
    CREATE POLICY "anon_read" ON herbal.flower_essence_condition_entries
      FOR SELECT USING (true);
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE schemaname='herbal' AND tablename='flower_essence_condition_entries'
      AND policyname='service_write'
  ) THEN
    CREATE POLICY "service_write" ON herbal.flower_essence_condition_entries
      FOR ALL TO service_role USING (true) WITH CHECK (true);
  END IF;
END $$;

-- ============================================================
-- Table: flower_essence_category_see_also (Part One See Also)
-- ============================================================

CREATE TABLE IF NOT EXISTS herbal.flower_essence_category_see_also (
  from_category TEXT NOT NULL,
  to_category   TEXT NOT NULL,
  PRIMARY KEY (from_category, to_category)
);

CREATE INDEX IF NOT EXISTS idx_fecsa_from
  ON herbal.flower_essence_category_see_also(from_category);
CREATE INDEX IF NOT EXISTS idx_fecsa_to
  ON herbal.flower_essence_category_see_also(to_category);

GRANT ALL ON TABLE herbal.flower_essence_category_see_also
  TO postgres, anon, authenticated, service_role;
ALTER TABLE herbal.flower_essence_category_see_also ENABLE ROW LEVEL SECURITY;
DO $$ BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE schemaname='herbal' AND tablename='flower_essence_category_see_also'
      AND policyname='anon_read'
  ) THEN
    CREATE POLICY "anon_read" ON herbal.flower_essence_category_see_also
      FOR SELECT USING (true);
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE schemaname='herbal' AND tablename='flower_essence_category_see_also'
      AND policyname='service_write'
  ) THEN
    CREATE POLICY "service_write" ON herbal.flower_essence_category_see_also
      FOR ALL TO service_role USING (true) WITH CHECK (true);
  END IF;
END $$;

-- ============================================================
-- Insert plant profiles
-- ============================================================
""")

for p in profiles:
    sql.append(
        "INSERT INTO herbal.flower_essence_plants\n"
        "  (name, latin_name, color, kit, positive_qualities,\n"
        "   patterns_of_imbalance, description, cross_references)\n"
        "VALUES (\n"
        f"  {sql_str(p['name'])},\n"
        f"  {sql_str(p['latin_name'])},\n"
        f"  {sql_str(p['color'])},\n"
        f"  {sql_str(p['kit'])},\n"
        f"  {sql_str(p['positive_qualities'])},\n"
        f"  {sql_str(p['patterns_of_imbalance'])},\n"
        f"  {sql_str(p['description'])},\n"
        f"  {sql_array(p['cross_references'])}\n"
        ")\nON CONFLICT (name, latin_name) DO NOTHING;\n"
    )

sql.append("""
-- ============================================================
-- Insert soul condition entries
-- ============================================================
""")

for cat, plant_name, desc in condition_entries:
    sql.append(
        "INSERT INTO herbal.flower_essence_condition_entries\n"
        "  (category, plant_name, description)\n"
        f"VALUES ({sql_str(cat)}, {sql_str(plant_name)}, {sql_str(desc)})\n"
        "ON CONFLICT (category, plant_name) DO NOTHING;\n"
    )

sql.append("""
-- ============================================================
-- Insert See Also relationships
-- ============================================================
""")

for from_cat, to_cat in see_also_rels:
    sql.append(
        "INSERT INTO herbal.flower_essence_category_see_also (from_category, to_category)\n"
        f"VALUES ({sql_str(from_cat)}, {sql_str(to_cat)})\n"
        "ON CONFLICT DO NOTHING;\n"
    )

sql.append("""
-- ============================================================
-- Link condition entries to plant profiles by name
-- ============================================================
UPDATE herbal.flower_essence_condition_entries e
SET plant_id = p.id
FROM herbal.flower_essence_plants p
WHERE e.plant_name = p.name
  AND e.plant_id IS NULL;
""")

OUTPUT.write_text('\n'.join(sql), encoding='utf-8')
print(f"\nWrote {OUTPUT}")
print(f"  {len(profiles)} plant profiles")
print(f"  {len(condition_entries)} condition entries")
print(f"  {len(see_also_rels)} see-also relationships")
