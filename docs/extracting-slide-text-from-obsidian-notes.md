# Extracting Slide Text from Obsidian Zoom Screenshot Notes

## Purpose

When you take screenshots during a Zoom class and embed them in Obsidian, this workflow extracts the text from each slide image and inserts it into the note — with the slide title as a `# header` above the image and the body text below it. Your existing handwritten notes are preserved in place.

## When to Use

- You have an Obsidian note full of `![[Screenshot...]]` embeds from a Zoom recording
- The screenshots are slides (not whiteboard or face-cam footage)
- You want the note to be searchable and readable without opening every image

---

## Step 1: Identify the Note and Screenshots

Open the Obsidian note and count the embedded screenshots:

```bash
grep -oE 'Screenshot [^|]+\|' "path/to/your/Note.md" | wc -l
```

List them in order:

```bash
grep -oE 'Screenshot [^|]+\|' "path/to/your/Note.md" | sed 's/|$//'
```

All screenshots should be in `/Users/<you>/Obsidian/Obsidian Vault/Attachments/`.

---

## Step 2: Split into Batches and Spawn Extraction Agents

For ~179 screenshots, use 5 parallel batches of ~36. Adjust batch size based on count.

For each batch, spawn an Agent (in background) with this prompt template:

```
You are extracting text from slide screenshots taken during a Zoom herbalism class.
Each image is a slide from the presentation.

Your task: Read each image file and extract its text. Write results to `/tmp/slide_extraction_batch_N.txt`.

OUTPUT FORMAT — write each slide entry exactly like this:
---SLIDE---
Screenshot YYYY-MM-DD_XXXXXXXXXX.jpg
HEADER: <title text if clearly present at top of slide, else leave blank>
BODY:
<all other text using bullet format (- item) for lists, plain text for prose>

Rules:
- HEADER: the large title text at the top of the slide. Leave blank if none.
- BODY: capture ALL readable text. For diagram labels, list as bullets.
- Use bullets when content is naturally a list; plain text for quotes/sentences.
- If slide is a photo with no text: write BODY: (no text content)
- Do NOT skip any file.

Image directory: /Users/<you>/Obsidian/Obsidian Vault/Attachments/

Process these files IN ORDER:
1. Screenshot ...
2. Screenshot ...
[list your batch here]

Write output to /tmp/slide_extraction_batch_N.txt and return the full content.
```

Run all 5 batch agents in a single message with `run_in_background: true` to run in parallel.

---

## Step 3: Verify Batch Output

As each agent completes, read its output file:

```
Read /tmp/slide_extraction_batch_N.txt
```

Check that:
- Every slide has an entry (correct count)
- Headers are captured for titled slides
- Body text is present for content slides
- Image-only slides show `(no text content)`

---

## Step 4: Run the Note Builder Script

Save the script below as `/tmp/build_note.py` and run it:

```bash
python3 /tmp/build_note.py
```

The script:
1. Reads all 5 batch files → builds a `filename → {header, body}` dict
2. Parses the original note line by line
3. For each `![[Screenshot...]]` embed:
   - Emits `# Header` above (if the slide had a title)
   - Emits the clean image embed
   - Emits extracted body text below
   - Preserves any existing user notes that followed the image
4. Writes to `/tmp/mandelbaum_slides_updated.md`

```python
#!/usr/bin/env python3
import re

# 1. Load all batch extraction files into a slides dict
slides = {}
for n in range(1, 6):
    with open(f'/tmp/slide_extraction_batch_{n}.txt', 'r') as f:
        content = f.read()
    for part in content.split('---SLIDE---'):
        part = part.strip()
        if not part:
            continue
        lines = part.split('\n')
        filename = lines[0].strip()
        if not filename or not filename.startswith('Screenshot'):
            continue
        header = ''
        body_lines = []
        in_body = False
        for line in lines[1:]:
            if line.startswith('HEADER: '):
                header = line[8:].strip()
            elif line == 'HEADER:':
                header = ''
            elif line == 'BODY:':
                in_body = True
            elif in_body:
                body_lines.append(line)
        body = '\n'.join(body_lines).strip()
        if (body in ['(no text content)', '(no text content beyond title)',
                     '(no additional text content beyond title)']
                or body.startswith('(no text content')):
            body = ''
        slides[filename] = {'header': header, 'body': body}

print(f"Loaded {len(slides)} slides")

# 2. Read the original note — UPDATE THESE PATHS
INPUT = '/path/to/your/Obsidian Note.md'
OUTPUT = '/tmp/note_updated.md'

with open(INPUT, 'r') as f:
    original_lines = f.read().split('\n')

EMBED_RE = re.compile(r'(.*?)!\[\[(Screenshot [^|\]]+\.jpg)(?:\|[^\]]+)?\]\](.*)')

output = []
i = 0

while i < len(original_lines):
    line = original_lines[i]
    m = EMBED_RE.match(line)

    if m:
        prefix = m.group(1).strip()
        filename = m.group(2).strip()
        suffix = m.group(3).strip()
        slide = slides.get(filename, {'header': '', 'body': ''})
        header = slide['header']
        body = slide['body']

        if header:
            output.append(f'# {header}')

        output.append(f'![[{filename}|700]]')

        if body:
            for bline in body.split('\n'):
                output.append(bline)

        user_notes = []
        if prefix and prefix.strip('-').strip():
            p = prefix.strip()
            if not p.startswith('-'):
                p = '- ' + p
            user_notes.append(p)
        if suffix and suffix.strip('-').strip():
            s = suffix.strip()
            if not s.startswith('-'):
                s = '- ' + s
            user_notes.append(s)

        j = i + 1
        while j < len(original_lines):
            nline = original_lines[j]
            nstrip = nline.strip()
            if EMBED_RE.match(nline):
                break
            if nstrip == '?slide':
                break
            if nstrip == '':
                j += 1
                break
            if nstrip in ['-', '- ']:
                j += 1
                continue
            user_notes.append(nline)
            j += 1

        if body and user_notes:
            output.append('')
        for note in user_notes:
            output.append(note)
        output.append('')
        i = j

    else:
        stripped = line.strip()
        if stripped == '-':
            output.append('')
        else:
            output.append(line)
        i += 1

# Collapse multiple blank lines
cleaned = []
prev_blank = False
for line in output:
    is_blank = line.strip() == ''
    if is_blank and prev_blank:
        continue
    cleaned.append(line)
    prev_blank = is_blank

while cleaned and cleaned[-1].strip() == '':
    cleaned.pop()

with open(OUTPUT, 'w') as f:
    f.write('\n'.join(cleaned) + '\n')

print(f"Written to {OUTPUT} ({len(cleaned)} lines)")
```

---

## Step 5: Review and Overwrite

Spot-check the output:
- Beginning of note: headers and bullets look right
- Middle: user notes preserved below extracted content
- End: no stray artifacts

Then back up the original and replace:

```bash
cp "path/to/Note.md" "/tmp/note_original_backup.md"
cp /tmp/note_updated.md "path/to/Note.md"
```

---

## Notes and Edge Cases

- **Image-only slides** (herb photos, diagrams with no text): the slide header still appears as `# Herb Name`, and no body text is emitted — so you just get a clean header above the photo.
- **Mid-sentence screenshots** (where a screenshot was accidentally taken while typing): the partial text from before/after the embed is preserved as user notes below the image.
- **`?slide` markers**: passed through as-is — they mark slides that weren't captured.
- **Empty bullets** (`- ` with nothing after): converted to blank lines.
- **User notes after a blank line**: if there's a blank line between the image and the user's notes in the original, those notes appear as standalone pass-through text rather than attached user notes — they still appear in the right position in the file.
- **Batch count**: 36 images per agent works well. For larger decks (>200), consider 30 per batch.

---

## Reference

- Obsidian attachments: `/Users/<you>/Obsidian/Obsidian Vault/Attachments/`
- Batch output files: `/tmp/slide_extraction_batch_1.txt` through `_5.txt`
- Original backup: `/tmp/note_original_backup.md`
- Completed for: Richard Mandelbaum (Ashley BHC) - Zoom Slides.md (2026-10-04, 179 screenshots)
