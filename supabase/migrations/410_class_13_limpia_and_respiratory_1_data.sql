-- Migration 410: Class 13 — Limpia and Respiratory 1 data
-- Source files parsed:
--   BHC - Class 13 - Limpia and Respiratory 1 - Rose.md (note_type = 'personal')
--   No Generated Notes file for this class.
--
-- Herb normalizations applied:
--   Aralia (Aralia californica) → California Spikenard (id=579)
--   Grindelia → Grindelia squarrosa (id=2231)
--   AI → Anti-inflammatory (standard abbreviation)
--
-- Herbs skipped (ceremonial context only, no medicinal content discussed):
--   Fennel, Rosemary, Rose geranium, Salvia/Mexican sage — listed only in limpia bouquet
--   Cinnamon, Lavender — mentioned in Agua Florida (ceremonial spray only)
--   Copal — sacred tree resin, not in DB, purely ceremonial
--   Mexican marigold (Pericon) — not in DB
--
-- Keyword merge decisions:
--   "irritable cough" → merged with existing 'spasmodic cough'
--   "upper respiratory problems" → merged with existing 'respiratory congestion'
--   "susto" / spiritual fright → merged with existing 'dissociation'
--   No new ailment keywords for this class.

SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets
             WHERE class_name = 'BHC - Class 13 - Limpia and Respiratory 1 - Rose') THEN
    RAISE NOTICE 'Class 13 snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- ── Limpia Steps ──────────────────────────────────────────────────────────────
  (115,
   'contraindication for a limpia? not when pregnant — because it moves big energy. Mugwort is also a big mover.',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Limpia Steps', 10,
   '- [[fennel]], [[mugwort]], Mexican marigold (Pericon - grandmother plant (first day of class)), rose geranium, [[rosemary]], salvia (Mexican [[sage]])
    - encourage California natives
- dip plants in a bowl of salt water to activate (or agua florida)
- prayer and intention
- smell the plants, breathe with the plants
- connect in to ancestors and call upon the energy of the Sun
    - outside? bare feet?
    - pull the energy of the Sun to support the process
- start at the head and go down
    - sweeping with plants
    - talk to the energy and ask them to move
    - joints are important
        - how emotions come in and out of our bodies
    - sweep, circle, flap
    - back of neck, mind, jaw, throat
    - lungs (grief)
    - heart, solar plexus, sexual areas
    - legs, knees, down
    - can do a second or third sweep - energy from the head into the earth
- at end, twist and break bouquet, then step on them, end that part of the process
- disposal -> maybe dig a hole in furthest corner of the backyard, or tree
    - use what you have and is meaningful

- egg - hold with index finger on top
    - spray with Agua Florida
    - prayer, ask for support
    - cross on top of head -> 4 directions
    - all over head, then work down, joints again, back, etc
    - if it breaks, it''s taken care of something
- contraindication for a limpia?
    - not when pregnant- because it moves big energy
    - [[mugwort]] is also a big mover'),

  -- ── Plant Actions for the Respiratory System ─────────────────────────────────
  (2231,
   'Stim Expectorant: Grindelia, Osha, Yerba Santa',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Plant Actions for the Respiratory System', 20,
   '- [[Expectorant]]
    - Stim [[Expectorant]]: Grindelia, [[Osha]], Yerba Santa
    - Relaxing [[Expectorant]]: [[Mullein]], [[Plantain]], [[Elecampane]]
- [[Anti-catarrhal|Anticatarrhal]]: [[Yerba Mansa]], [[Goldenseal Root|Goldenseal]], [[Databases/Herbs/Data/Garlic|Garlic]], Boneset
- **Tammi Sweet - Heartstone class anatomy**
- [[Demulcent]]: [[Mullein]], [[Marshmallow]], [[Licorice root|Licorice]] (careful HBP), Irish Moss
- [[Antispasmodic]]: Wild [[Cherry Bark]], [[Lobelia]] (drop dose, emetic if too much)

- [[Antimicrobial]]: [[Databases/Herbs/Data/Garlic|garlic]], [[thyme]], [[elecampane]], [[Usnea]]
- [[Antiviral]]: [[Databases/Herbs/Data/Garlic|Garlic]], [[elecampane]]
- Bronchodilator: [[Osha]], [[Lobelia]], [[Pine]]
- Antitussive: Wild [[Cherry Bark]], [[Thyme]]
- Lung Tonic: [[Mullein]], Prince Seng
- Nervines: [[Motherwort]] and [[Hawthorn]]'),

  (104,
   'Stim Expectorant: Grindelia, Osha, Yerba Santa | Bronchodilator: Osha, Lobelia, Pine',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Plant Actions for the Respiratory System', 30,
   '- [[Expectorant]]
    - Stim [[Expectorant]]: Grindelia, [[Osha]], Yerba Santa
    - Relaxing [[Expectorant]]: [[Mullein]], [[Plantain]], [[Elecampane]]
- [[Anti-catarrhal|Anticatarrhal]]: [[Yerba Mansa]], [[Goldenseal Root|Goldenseal]], [[Databases/Herbs/Data/Garlic|Garlic]], Boneset
- **Tammi Sweet - Heartstone class anatomy**
- [[Demulcent]]: [[Mullein]], [[Marshmallow]], [[Licorice root|Licorice]] (careful HBP), Irish Moss
- [[Antispasmodic]]: Wild [[Cherry Bark]], [[Lobelia]] (drop dose, emetic if too much)

- [[Antimicrobial]]: [[Databases/Herbs/Data/Garlic|garlic]], [[thyme]], [[elecampane]], [[Usnea]]
- [[Antiviral]]: [[Databases/Herbs/Data/Garlic|Garlic]], [[elecampane]]
- Bronchodilator: [[Osha]], [[Lobelia]], [[Pine]]
- Antitussive: Wild [[Cherry Bark]], [[Thyme]]
- Lung Tonic: [[Mullein]], Prince Seng
- Nervines: [[Motherwort]] and [[Hawthorn]]'),

  (590,
   'Stim Expectorant: Grindelia, Osha, Yerba Santa',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Plant Actions for the Respiratory System', 40,
   '- [[Expectorant]]
    - Stim [[Expectorant]]: Grindelia, [[Osha]], Yerba Santa
    - Relaxing [[Expectorant]]: [[Mullein]], [[Plantain]], [[Elecampane]]
- [[Anti-catarrhal|Anticatarrhal]]: [[Yerba Mansa]], [[Goldenseal Root|Goldenseal]], [[Databases/Herbs/Data/Garlic|Garlic]], Boneset
- **Tammi Sweet - Heartstone class anatomy**
- [[Demulcent]]: [[Mullein]], [[Marshmallow]], [[Licorice root|Licorice]] (careful HBP), Irish Moss
- [[Antispasmodic]]: Wild [[Cherry Bark]], [[Lobelia]] (drop dose, emetic if too much)

- [[Antimicrobial]]: [[Databases/Herbs/Data/Garlic|garlic]], [[thyme]], [[elecampane]], [[Usnea]]
- [[Antiviral]]: [[Databases/Herbs/Data/Garlic|Garlic]], [[elecampane]]
- Bronchodilator: [[Osha]], [[Lobelia]], [[Pine]]
- Antitussive: Wild [[Cherry Bark]], [[Thyme]]
- Lung Tonic: [[Mullein]], Prince Seng
- Nervines: [[Motherwort]] and [[Hawthorn]]'),

  (61,
   'Relaxing Expectorant: Mullein, Plantain, Elecampane | Demulcent: Mullein, Marshmallow, Licorice (careful HBP), Irish Moss | Lung Tonic: Mullein, Prince Seng',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Plant Actions for the Respiratory System', 50,
   '- [[Expectorant]]
    - Stim [[Expectorant]]: Grindelia, [[Osha]], Yerba Santa
    - Relaxing [[Expectorant]]: [[Mullein]], [[Plantain]], [[Elecampane]]
- [[Anti-catarrhal|Anticatarrhal]]: [[Yerba Mansa]], [[Goldenseal Root|Goldenseal]], [[Databases/Herbs/Data/Garlic|Garlic]], Boneset
- **Tammi Sweet - Heartstone class anatomy**
- [[Demulcent]]: [[Mullein]], [[Marshmallow]], [[Licorice root|Licorice]] (careful HBP), Irish Moss
- [[Antispasmodic]]: Wild [[Cherry Bark]], [[Lobelia]] (drop dose, emetic if too much)

- [[Antimicrobial]]: [[Databases/Herbs/Data/Garlic|garlic]], [[thyme]], [[elecampane]], [[Usnea]]
- [[Antiviral]]: [[Databases/Herbs/Data/Garlic|Garlic]], [[elecampane]]
- Bronchodilator: [[Osha]], [[Lobelia]], [[Pine]]
- Antitussive: Wild [[Cherry Bark]], [[Thyme]]
- Lung Tonic: [[Mullein]], Prince Seng
- Nervines: [[Motherwort]] and [[Hawthorn]]'),

  (85,
   'Relaxing Expectorant: Mullein, Plantain, Elecampane',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Plant Actions for the Respiratory System', 60,
   '- [[Expectorant]]
    - Stim [[Expectorant]]: Grindelia, [[Osha]], Yerba Santa
    - Relaxing [[Expectorant]]: [[Mullein]], [[Plantain]], [[Elecampane]]
- [[Anti-catarrhal|Anticatarrhal]]: [[Yerba Mansa]], [[Goldenseal Root|Goldenseal]], [[Databases/Herbs/Data/Garlic|Garlic]], Boneset
- **Tammi Sweet - Heartstone class anatomy**
- [[Demulcent]]: [[Mullein]], [[Marshmallow]], [[Licorice root|Licorice]] (careful HBP), Irish Moss
- [[Antispasmodic]]: Wild [[Cherry Bark]], [[Lobelia]] (drop dose, emetic if too much)

- [[Antimicrobial]]: [[Databases/Herbs/Data/Garlic|garlic]], [[thyme]], [[elecampane]], [[Usnea]]
- [[Antiviral]]: [[Databases/Herbs/Data/Garlic|Garlic]], [[elecampane]]
- Bronchodilator: [[Osha]], [[Lobelia]], [[Pine]]
- Antitussive: Wild [[Cherry Bark]], [[Thyme]]
- Lung Tonic: [[Mullein]], Prince Seng
- Nervines: [[Motherwort]] and [[Hawthorn]]'),

  (54,
   'Relaxing Expectorant: Mullein, Plantain, Elecampane | Antimicrobial: garlic, thyme, elecampane, Usnea | Antiviral: Garlic, elecampane',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Plant Actions for the Respiratory System', 70,
   '- [[Expectorant]]
    - Stim [[Expectorant]]: Grindelia, [[Osha]], Yerba Santa
    - Relaxing [[Expectorant]]: [[Mullein]], [[Plantain]], [[Elecampane]]
- [[Anti-catarrhal|Anticatarrhal]]: [[Yerba Mansa]], [[Goldenseal Root|Goldenseal]], [[Databases/Herbs/Data/Garlic|Garlic]], Boneset
- **Tammi Sweet - Heartstone class anatomy**
- [[Demulcent]]: [[Mullein]], [[Marshmallow]], [[Licorice root|Licorice]] (careful HBP), Irish Moss
- [[Antispasmodic]]: Wild [[Cherry Bark]], [[Lobelia]] (drop dose, emetic if too much)

- [[Antimicrobial]]: [[Databases/Herbs/Data/Garlic|garlic]], [[thyme]], [[elecampane]], [[Usnea]]
- [[Antiviral]]: [[Databases/Herbs/Data/Garlic|Garlic]], [[elecampane]]
- Bronchodilator: [[Osha]], [[Lobelia]], [[Pine]]
- Antitussive: Wild [[Cherry Bark]], [[Thyme]]
- Lung Tonic: [[Mullein]], Prince Seng
- Nervines: [[Motherwort]] and [[Hawthorn]]'),

  (309,
   'Anticatarrhal: Yerba Mansa, Goldenseal, Garlic, Boneset',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Plant Actions for the Respiratory System', 80,
   '- [[Expectorant]]
    - Stim [[Expectorant]]: Grindelia, [[Osha]], Yerba Santa
    - Relaxing [[Expectorant]]: [[Mullein]], [[Plantain]], [[Elecampane]]
- [[Anti-catarrhal|Anticatarrhal]]: [[Yerba Mansa]], [[Goldenseal Root|Goldenseal]], [[Databases/Herbs/Data/Garlic|Garlic]], Boneset
- **Tammi Sweet - Heartstone class anatomy**
- [[Demulcent]]: [[Mullein]], [[Marshmallow]], [[Licorice root|Licorice]] (careful HBP), Irish Moss
- [[Antispasmodic]]: Wild [[Cherry Bark]], [[Lobelia]] (drop dose, emetic if too much)

- [[Antimicrobial]]: [[Databases/Herbs/Data/Garlic|garlic]], [[thyme]], [[elecampane]], [[Usnea]]
- [[Antiviral]]: [[Databases/Herbs/Data/Garlic|Garlic]], [[elecampane]]
- Bronchodilator: [[Osha]], [[Lobelia]], [[Pine]]
- Antitussive: Wild [[Cherry Bark]], [[Thyme]]
- Lung Tonic: [[Mullein]], Prince Seng
- Nervines: [[Motherwort]] and [[Hawthorn]]'),

  (30,
   'Anticatarrhal: Yerba Mansa, Goldenseal, Garlic, Boneset',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Plant Actions for the Respiratory System', 90,
   '- [[Expectorant]]
    - Stim [[Expectorant]]: Grindelia, [[Osha]], Yerba Santa
    - Relaxing [[Expectorant]]: [[Mullein]], [[Plantain]], [[Elecampane]]
- [[Anti-catarrhal|Anticatarrhal]]: [[Yerba Mansa]], [[Goldenseal Root|Goldenseal]], [[Databases/Herbs/Data/Garlic|Garlic]], Boneset
- **Tammi Sweet - Heartstone class anatomy**
- [[Demulcent]]: [[Mullein]], [[Marshmallow]], [[Licorice root|Licorice]] (careful HBP), Irish Moss
- [[Antispasmodic]]: Wild [[Cherry Bark]], [[Lobelia]] (drop dose, emetic if too much)

- [[Antimicrobial]]: [[Databases/Herbs/Data/Garlic|garlic]], [[thyme]], [[elecampane]], [[Usnea]]
- [[Antiviral]]: [[Databases/Herbs/Data/Garlic|Garlic]], [[elecampane]]
- Bronchodilator: [[Osha]], [[Lobelia]], [[Pine]]
- Antitussive: Wild [[Cherry Bark]], [[Thyme]]
- Lung Tonic: [[Mullein]], Prince Seng
- Nervines: [[Motherwort]] and [[Hawthorn]]'),

  (21,
   'Anticatarrhal: Yerba Mansa, Goldenseal, Garlic, Boneset | Antimicrobial: garlic, thyme, elecampane, Usnea | Antiviral: Garlic, elecampane',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Plant Actions for the Respiratory System', 100,
   '- [[Expectorant]]
    - Stim [[Expectorant]]: Grindelia, [[Osha]], Yerba Santa
    - Relaxing [[Expectorant]]: [[Mullein]], [[Plantain]], [[Elecampane]]
- [[Anti-catarrhal|Anticatarrhal]]: [[Yerba Mansa]], [[Goldenseal Root|Goldenseal]], [[Databases/Herbs/Data/Garlic|Garlic]], Boneset
- **Tammi Sweet - Heartstone class anatomy**
- [[Demulcent]]: [[Mullein]], [[Marshmallow]], [[Licorice root|Licorice]] (careful HBP), Irish Moss
- [[Antispasmodic]]: Wild [[Cherry Bark]], [[Lobelia]] (drop dose, emetic if too much)

- [[Antimicrobial]]: [[Databases/Herbs/Data/Garlic|garlic]], [[thyme]], [[elecampane]], [[Usnea]]
- [[Antiviral]]: [[Databases/Herbs/Data/Garlic|Garlic]], [[elecampane]]
- Bronchodilator: [[Osha]], [[Lobelia]], [[Pine]]
- Antitussive: Wild [[Cherry Bark]], [[Thyme]]
- Lung Tonic: [[Mullein]], Prince Seng
- Nervines: [[Motherwort]] and [[Hawthorn]]'),

  (50,
   'Anticatarrhal: Yerba Mansa, Goldenseal, Garlic, Boneset',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Plant Actions for the Respiratory System', 110,
   '- [[Expectorant]]
    - Stim [[Expectorant]]: Grindelia, [[Osha]], Yerba Santa
    - Relaxing [[Expectorant]]: [[Mullein]], [[Plantain]], [[Elecampane]]
- [[Anti-catarrhal|Anticatarrhal]]: [[Yerba Mansa]], [[Goldenseal Root|Goldenseal]], [[Databases/Herbs/Data/Garlic|Garlic]], Boneset
- **Tammi Sweet - Heartstone class anatomy**
- [[Demulcent]]: [[Mullein]], [[Marshmallow]], [[Licorice root|Licorice]] (careful HBP), Irish Moss
- [[Antispasmodic]]: Wild [[Cherry Bark]], [[Lobelia]] (drop dose, emetic if too much)

- [[Antimicrobial]]: [[Databases/Herbs/Data/Garlic|garlic]], [[thyme]], [[elecampane]], [[Usnea]]
- [[Antiviral]]: [[Databases/Herbs/Data/Garlic|Garlic]], [[elecampane]]
- Bronchodilator: [[Osha]], [[Lobelia]], [[Pine]]
- Antitussive: Wild [[Cherry Bark]], [[Thyme]]
- Lung Tonic: [[Mullein]], Prince Seng
- Nervines: [[Motherwort]] and [[Hawthorn]]'),

  (45,
   'Demulcent: Mullein, Marshmallow, Licorice (careful HBP), Irish Moss',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Plant Actions for the Respiratory System', 120,
   '- [[Expectorant]]
    - Stim [[Expectorant]]: Grindelia, [[Osha]], Yerba Santa
    - Relaxing [[Expectorant]]: [[Mullein]], [[Plantain]], [[Elecampane]]
- [[Anti-catarrhal|Anticatarrhal]]: [[Yerba Mansa]], [[Goldenseal Root|Goldenseal]], [[Databases/Herbs/Data/Garlic|Garlic]], Boneset
- **Tammi Sweet - Heartstone class anatomy**
- [[Demulcent]]: [[Mullein]], [[Marshmallow]], [[Licorice root|Licorice]] (careful HBP), Irish Moss
- [[Antispasmodic]]: Wild [[Cherry Bark]], [[Lobelia]] (drop dose, emetic if too much)

- [[Antimicrobial]]: [[Databases/Herbs/Data/Garlic|garlic]], [[thyme]], [[elecampane]], [[Usnea]]
- [[Antiviral]]: [[Databases/Herbs/Data/Garlic|Garlic]], [[elecampane]]
- Bronchodilator: [[Osha]], [[Lobelia]], [[Pine]]
- Antitussive: Wild [[Cherry Bark]], [[Thyme]]
- Lung Tonic: [[Mullein]], Prince Seng
- Nervines: [[Motherwort]] and [[Hawthorn]]'),

  (78,
   'Demulcent: Mullein, Marshmallow, Licorice (careful HBP), Irish Moss',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Plant Actions for the Respiratory System', 130,
   '- [[Expectorant]]
    - Stim [[Expectorant]]: Grindelia, [[Osha]], Yerba Santa
    - Relaxing [[Expectorant]]: [[Mullein]], [[Plantain]], [[Elecampane]]
- [[Anti-catarrhal|Anticatarrhal]]: [[Yerba Mansa]], [[Goldenseal Root|Goldenseal]], [[Databases/Herbs/Data/Garlic|Garlic]], Boneset
- **Tammi Sweet - Heartstone class anatomy**
- [[Demulcent]]: [[Mullein]], [[Marshmallow]], [[Licorice root|Licorice]] (careful HBP), Irish Moss
- [[Antispasmodic]]: Wild [[Cherry Bark]], [[Lobelia]] (drop dose, emetic if too much)

- [[Antimicrobial]]: [[Databases/Herbs/Data/Garlic|garlic]], [[thyme]], [[elecampane]], [[Usnea]]
- [[Antiviral]]: [[Databases/Herbs/Data/Garlic|Garlic]], [[elecampane]]
- Bronchodilator: [[Osha]], [[Lobelia]], [[Pine]]
- Antitussive: Wild [[Cherry Bark]], [[Thyme]]
- Lung Tonic: [[Mullein]], Prince Seng
- Nervines: [[Motherwort]] and [[Hawthorn]]'),

  (49,
   'Demulcent: Mullein, Marshmallow, Licorice (careful HBP), Irish Moss',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Plant Actions for the Respiratory System', 140,
   '- [[Expectorant]]
    - Stim [[Expectorant]]: Grindelia, [[Osha]], Yerba Santa
    - Relaxing [[Expectorant]]: [[Mullein]], [[Plantain]], [[Elecampane]]
- [[Anti-catarrhal|Anticatarrhal]]: [[Yerba Mansa]], [[Goldenseal Root|Goldenseal]], [[Databases/Herbs/Data/Garlic|Garlic]], Boneset
- **Tammi Sweet - Heartstone class anatomy**
- [[Demulcent]]: [[Mullein]], [[Marshmallow]], [[Licorice root|Licorice]] (careful HBP), Irish Moss
- [[Antispasmodic]]: Wild [[Cherry Bark]], [[Lobelia]] (drop dose, emetic if too much)

- [[Antimicrobial]]: [[Databases/Herbs/Data/Garlic|garlic]], [[thyme]], [[elecampane]], [[Usnea]]
- [[Antiviral]]: [[Databases/Herbs/Data/Garlic|Garlic]], [[elecampane]]
- Bronchodilator: [[Osha]], [[Lobelia]], [[Pine]]
- Antitussive: Wild [[Cherry Bark]], [[Thyme]]
- Lung Tonic: [[Mullein]], Prince Seng
- Nervines: [[Motherwort]] and [[Hawthorn]]'),

  (140,
   'Antispasmodic: Wild Cherry Bark, Lobelia (drop dose, emetic if too much) | Antitussive: Wild Cherry Bark, Thyme',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Plant Actions for the Respiratory System', 150,
   '- [[Expectorant]]
    - Stim [[Expectorant]]: Grindelia, [[Osha]], Yerba Santa
    - Relaxing [[Expectorant]]: [[Mullein]], [[Plantain]], [[Elecampane]]
- [[Anti-catarrhal|Anticatarrhal]]: [[Yerba Mansa]], [[Goldenseal Root|Goldenseal]], [[Databases/Herbs/Data/Garlic|Garlic]], Boneset
- **Tammi Sweet - Heartstone class anatomy**
- [[Demulcent]]: [[Mullein]], [[Marshmallow]], [[Licorice root|Licorice]] (careful HBP), Irish Moss
- [[Antispasmodic]]: Wild [[Cherry Bark]], [[Lobelia]] (drop dose, emetic if too much)

- [[Antimicrobial]]: [[Databases/Herbs/Data/Garlic|garlic]], [[thyme]], [[elecampane]], [[Usnea]]
- [[Antiviral]]: [[Databases/Herbs/Data/Garlic|Garlic]], [[elecampane]]
- Bronchodilator: [[Osha]], [[Lobelia]], [[Pine]]
- Antitussive: Wild [[Cherry Bark]], [[Thyme]]
- Lung Tonic: [[Mullein]], Prince Seng
- Nervines: [[Motherwort]] and [[Hawthorn]]'),

  (132,
   'Antispasmodic: Wild Cherry Bark, Lobelia (drop dose, emetic if too much) | Bronchodilator: Osha, Lobelia, Pine',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Plant Actions for the Respiratory System', 160,
   '- [[Expectorant]]
    - Stim [[Expectorant]]: Grindelia, [[Osha]], Yerba Santa
    - Relaxing [[Expectorant]]: [[Mullein]], [[Plantain]], [[Elecampane]]
- [[Anti-catarrhal|Anticatarrhal]]: [[Yerba Mansa]], [[Goldenseal Root|Goldenseal]], [[Databases/Herbs/Data/Garlic|Garlic]], Boneset
- **Tammi Sweet - Heartstone class anatomy**
- [[Demulcent]]: [[Mullein]], [[Marshmallow]], [[Licorice root|Licorice]] (careful HBP), Irish Moss
- [[Antispasmodic]]: Wild [[Cherry Bark]], [[Lobelia]] (drop dose, emetic if too much)

- [[Antimicrobial]]: [[Databases/Herbs/Data/Garlic|garlic]], [[thyme]], [[elecampane]], [[Usnea]]
- [[Antiviral]]: [[Databases/Herbs/Data/Garlic|Garlic]], [[elecampane]]
- Bronchodilator: [[Osha]], [[Lobelia]], [[Pine]]
- Antitussive: Wild [[Cherry Bark]], [[Thyme]]
- Lung Tonic: [[Mullein]], Prince Seng
- Nervines: [[Motherwort]] and [[Hawthorn]]'),

  (59,
   'Antimicrobial: garlic, thyme, elecampane, Usnea | Antitussive: Wild Cherry Bark, Thyme',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Plant Actions for the Respiratory System', 170,
   '- [[Expectorant]]
    - Stim [[Expectorant]]: Grindelia, [[Osha]], Yerba Santa
    - Relaxing [[Expectorant]]: [[Mullein]], [[Plantain]], [[Elecampane]]
- [[Anti-catarrhal|Anticatarrhal]]: [[Yerba Mansa]], [[Goldenseal Root|Goldenseal]], [[Databases/Herbs/Data/Garlic|Garlic]], Boneset
- **Tammi Sweet - Heartstone class anatomy**
- [[Demulcent]]: [[Mullein]], [[Marshmallow]], [[Licorice root|Licorice]] (careful HBP), Irish Moss
- [[Antispasmodic]]: Wild [[Cherry Bark]], [[Lobelia]] (drop dose, emetic if too much)

- [[Antimicrobial]]: [[Databases/Herbs/Data/Garlic|garlic]], [[thyme]], [[elecampane]], [[Usnea]]
- [[Antiviral]]: [[Databases/Herbs/Data/Garlic|Garlic]], [[elecampane]]
- Bronchodilator: [[Osha]], [[Lobelia]], [[Pine]]
- Antitussive: Wild [[Cherry Bark]], [[Thyme]]
- Lung Tonic: [[Mullein]], Prince Seng
- Nervines: [[Motherwort]] and [[Hawthorn]]'),

  (112,
   'Antimicrobial: garlic, thyme, elecampane, Usnea',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Plant Actions for the Respiratory System', 180,
   '- [[Expectorant]]
    - Stim [[Expectorant]]: Grindelia, [[Osha]], Yerba Santa
    - Relaxing [[Expectorant]]: [[Mullein]], [[Plantain]], [[Elecampane]]
- [[Anti-catarrhal|Anticatarrhal]]: [[Yerba Mansa]], [[Goldenseal Root|Goldenseal]], [[Databases/Herbs/Data/Garlic|Garlic]], Boneset
- **Tammi Sweet - Heartstone class anatomy**
- [[Demulcent]]: [[Mullein]], [[Marshmallow]], [[Licorice root|Licorice]] (careful HBP), Irish Moss
- [[Antispasmodic]]: Wild [[Cherry Bark]], [[Lobelia]] (drop dose, emetic if too much)

- [[Antimicrobial]]: [[Databases/Herbs/Data/Garlic|garlic]], [[thyme]], [[elecampane]], [[Usnea]]
- [[Antiviral]]: [[Databases/Herbs/Data/Garlic|Garlic]], [[elecampane]]
- Bronchodilator: [[Osha]], [[Lobelia]], [[Pine]]
- Antitussive: Wild [[Cherry Bark]], [[Thyme]]
- Lung Tonic: [[Mullein]], Prince Seng
- Nervines: [[Motherwort]] and [[Hawthorn]]'),

  (2643,
   'Bronchodilator: Osha, Lobelia, Pine',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Plant Actions for the Respiratory System', 190,
   '- [[Expectorant]]
    - Stim [[Expectorant]]: Grindelia, [[Osha]], Yerba Santa
    - Relaxing [[Expectorant]]: [[Mullein]], [[Plantain]], [[Elecampane]]
- [[Anti-catarrhal|Anticatarrhal]]: [[Yerba Mansa]], [[Goldenseal Root|Goldenseal]], [[Databases/Herbs/Data/Garlic|Garlic]], Boneset
- **Tammi Sweet - Heartstone class anatomy**
- [[Demulcent]]: [[Mullein]], [[Marshmallow]], [[Licorice root|Licorice]] (careful HBP), Irish Moss
- [[Antispasmodic]]: Wild [[Cherry Bark]], [[Lobelia]] (drop dose, emetic if too much)

- [[Antimicrobial]]: [[Databases/Herbs/Data/Garlic|garlic]], [[thyme]], [[elecampane]], [[Usnea]]
- [[Antiviral]]: [[Databases/Herbs/Data/Garlic|Garlic]], [[elecampane]]
- Bronchodilator: [[Osha]], [[Lobelia]], [[Pine]]
- Antitussive: Wild [[Cherry Bark]], [[Thyme]]
- Lung Tonic: [[Mullein]], Prince Seng
- Nervines: [[Motherwort]] and [[Hawthorn]]'),

  (982,
   'Lung Tonic: Mullein, Prince Seng',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Plant Actions for the Respiratory System', 200,
   '- [[Expectorant]]
    - Stim [[Expectorant]]: Grindelia, [[Osha]], Yerba Santa
    - Relaxing [[Expectorant]]: [[Mullein]], [[Plantain]], [[Elecampane]]
- [[Anti-catarrhal|Anticatarrhal]]: [[Yerba Mansa]], [[Goldenseal Root|Goldenseal]], [[Databases/Herbs/Data/Garlic|Garlic]], Boneset
- **Tammi Sweet - Heartstone class anatomy**
- [[Demulcent]]: [[Mullein]], [[Marshmallow]], [[Licorice root|Licorice]] (careful HBP), Irish Moss
- [[Antispasmodic]]: Wild [[Cherry Bark]], [[Lobelia]] (drop dose, emetic if too much)

- [[Antimicrobial]]: [[Databases/Herbs/Data/Garlic|garlic]], [[thyme]], [[elecampane]], [[Usnea]]
- [[Antiviral]]: [[Databases/Herbs/Data/Garlic|Garlic]], [[elecampane]]
- Bronchodilator: [[Osha]], [[Lobelia]], [[Pine]]
- Antitussive: Wild [[Cherry Bark]], [[Thyme]]
- Lung Tonic: [[Mullein]], Prince Seng
- Nervines: [[Motherwort]] and [[Hawthorn]]'),

  (131,
   'Nervines: Motherwort and Hawthorn',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Plant Actions for the Respiratory System', 210,
   '- [[Expectorant]]
    - Stim [[Expectorant]]: Grindelia, [[Osha]], Yerba Santa
    - Relaxing [[Expectorant]]: [[Mullein]], [[Plantain]], [[Elecampane]]
- [[Anti-catarrhal|Anticatarrhal]]: [[Yerba Mansa]], [[Goldenseal Root|Goldenseal]], [[Databases/Herbs/Data/Garlic|Garlic]], Boneset
- **Tammi Sweet - Heartstone class anatomy**
- [[Demulcent]]: [[Mullein]], [[Marshmallow]], [[Licorice root|Licorice]] (careful HBP), Irish Moss
- [[Antispasmodic]]: Wild [[Cherry Bark]], [[Lobelia]] (drop dose, emetic if too much)

- [[Antimicrobial]]: [[Databases/Herbs/Data/Garlic|garlic]], [[thyme]], [[elecampane]], [[Usnea]]
- [[Antiviral]]: [[Databases/Herbs/Data/Garlic|Garlic]], [[elecampane]]
- Bronchodilator: [[Osha]], [[Lobelia]], [[Pine]]
- Antitussive: Wild [[Cherry Bark]], [[Thyme]]
- Lung Tonic: [[Mullein]], Prince Seng
- Nervines: [[Motherwort]] and [[Hawthorn]]'),

  (73,
   'Nervines: Motherwort and Hawthorn',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Plant Actions for the Respiratory System', 220,
   '- [[Expectorant]]
    - Stim [[Expectorant]]: Grindelia, [[Osha]], Yerba Santa
    - Relaxing [[Expectorant]]: [[Mullein]], [[Plantain]], [[Elecampane]]
- [[Anti-catarrhal|Anticatarrhal]]: [[Yerba Mansa]], [[Goldenseal Root|Goldenseal]], [[Databases/Herbs/Data/Garlic|Garlic]], Boneset
- **Tammi Sweet - Heartstone class anatomy**
- [[Demulcent]]: [[Mullein]], [[Marshmallow]], [[Licorice root|Licorice]] (careful HBP), Irish Moss
- [[Antispasmodic]]: Wild [[Cherry Bark]], [[Lobelia]] (drop dose, emetic if too much)

- [[Antimicrobial]]: [[Databases/Herbs/Data/Garlic|garlic]], [[thyme]], [[elecampane]], [[Usnea]]
- [[Antiviral]]: [[Databases/Herbs/Data/Garlic|Garlic]], [[elecampane]]
- Bronchodilator: [[Osha]], [[Lobelia]], [[Pine]]
- Antitussive: Wild [[Cherry Bark]], [[Thyme]]
- Lung Tonic: [[Mullein]], Prince Seng
- Nervines: [[Motherwort]] and [[Hawthorn]]'),

  -- ── Energetics: Cold and Damp Lung ───────────────────────────────────────────
  (104,
   'Cold and Damp Lung — use warming and drying remedies (stimulating expectorants): osha, grindelia and yerba santa',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Cold and Damp Lung', 230,
   '#### Cold and Damp Lung
- characterized by excess mucus (white or clear), wheezing and cold extremities
- crave hot drink and hot temps
- use warming and drying remedies (stimulating expectorants)
- [[osha]], grindelia and yerba santa'),

  (2231,
   'Cold and Damp Lung — use warming and drying remedies (stimulating expectorants): osha, grindelia and yerba santa',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Cold and Damp Lung', 240,
   '#### Cold and Damp Lung
- characterized by excess mucus (white or clear), wheezing and cold extremities
- crave hot drink and hot temps
- use warming and drying remedies (stimulating expectorants)
- [[osha]], grindelia and yerba santa'),

  (590,
   'Cold and Damp Lung — use warming and drying remedies (stimulating expectorants): osha, grindelia and yerba santa',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Cold and Damp Lung', 250,
   '#### Cold and Damp Lung
- characterized by excess mucus (white or clear), wheezing and cold extremities
- crave hot drink and hot temps
- use warming and drying remedies (stimulating expectorants)
- [[osha]], grindelia and yerba santa'),

  -- ── Energetics: Cold and Dry Lung ────────────────────────────────────────────
  (579,
   'Cold and Dry Lung — use warming and moistening agents: Aralia (California Spikenard) and Licorice',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Cold and Dry Lung', 260,
   '#### Cold and Dry lung
- characterized by cold extremities, dry mouth, not a lot of mucus, if so its sticky, a tickly cough
- use warming and moistening agents
    - Aralia (California Spikenard) and [[Licorice root|Licorice]]'),

  (78,
   'Cold and Dry Lung — use warming and moistening agents: Aralia (California Spikenard) and Licorice',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Cold and Dry Lung', 270,
   '#### Cold and Dry lung
- characterized by cold extremities, dry mouth, not a lot of mucus, if so its sticky, a tickly cough
- use warming and moistening agents
    - Aralia (California Spikenard) and [[Licorice root|Licorice]]'),

  -- ── Energetics: Hot and Damp Lung ────────────────────────────────────────────
  (112,
   'Hot and Damp Lung — use cooling and drying remedies: Usnea',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Hot and Damp Lung', 280,
   '#### Hot and Damp Lung
- characterized by excessive mucus that is yellow, green, or streaked with blood
- fever present, sharp painful coughing
- use cooling and drying remedies: [[Usnea]]'),

  -- ── Energetics: Hot and Dry Lung ─────────────────────────────────────────────
  (61,
   'Hot and Dry Lung — use cooling and moistening remedies: Mullein, Marshmallow, Elecampane',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Hot and Dry Lung', 290,
   '#### Hot and Dry Lung
- characterized by sharp pain, irritating cough
- use cooling and moistening remedies - [[Mullein]], [[Marshmallow]], [[Elecampane]], Honey'),

  (45,
   'Hot and Dry Lung — use cooling and moistening remedies: Mullein, Marshmallow, Elecampane',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Hot and Dry Lung', 300,
   '#### Hot and Dry Lung
- characterized by sharp pain, irritating cough
- use cooling and moistening remedies - [[Mullein]], [[Marshmallow]], [[Elecampane]], Honey'),

  (54,
   'Hot and Dry Lung — use cooling and moistening remedies: Mullein, Marshmallow, Elecampane',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Hot and Dry Lung', 310,
   '#### Hot and Dry Lung
- characterized by sharp pain, irritating cough
- use cooling and moistening remedies - [[Mullein]], [[Marshmallow]], [[Elecampane]], Honey'),

  -- ── Elecampane (dedicated section) ───────────────────────────────────────────
  (54,
   'Elecampane: expectorant and antitussive, antiviral and antimicrobial. Appropriate to use in most lung conditions. The mucilage has a relaxing effect, while the EO brings about stimulation — soothes irritation and promotes expectoration. Good for irritable coughs, bronchitis, asthma, or upper resp problems. Parts used: root. Cloudy tincture indicates inulin content. Also known as Elfwort.',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Elecampane', 320,
   '### [[Elecampane]] (Inula helenium)
- (tincture tasting above)
- [[expectorant]] and antitussive
- [[antiviral]] and [[antimicrobial]]
- appropriate to use in most lung conditions
- the mucilage has a relaxing effect, while the EO brings about stimulation, so the herb soothes irritation and promotes expectoration
- mixes well with [[thyme]]
- good for irritable coughs, bronchitis, asthma, or upper resp problems
- Helen of Troy was believed to have been gathering the herb when she was abducted by Paris. This story resulted in its botanical name
- magical uses: worn to attract love, and also protection
- Parts used: root
- cloudy good [[tincture]] indicates the inulin content
- goes nicely with a [[thyme]] honey
- also known as Elfwort'),

  (59,
   'Elecampane mixes well with thyme; goes nicely with a thyme honey',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Elecampane', 330,
   '### [[Elecampane]] (Inula helenium)
- (tincture tasting above)
- [[expectorant]] and antitussive
- [[antiviral]] and [[antimicrobial]]
- appropriate to use in most lung conditions
- the mucilage has a relaxing effect, while the EO brings about stimulation, so the herb soothes irritation and promotes expectoration
- mixes well with [[thyme]]
- good for irritable coughs, bronchitis, asthma, or upper resp problems
- Helen of Troy was believed to have been gathering the herb when she was abducted by Paris. This story resulted in its botanical name
- magical uses: worn to attract love, and also protection
- Parts used: root
- cloudy good [[tincture]] indicates the inulin content
- goes nicely with a [[thyme]] honey
- also known as Elfwort'),

  -- ── Aralia (dedicated section) ────────────────────────────────────────────────
  (579,
   'Aralia (California Spikenard / Queen of the Forest): warming, use in damp cough situation. Antiviral, alterative, carminative, nervine, anti-inflammatory. Both a cough suppressant and expectorant. Very good restorative after extreme lung damage. Grounding, balancing and calming. Root for respiratory distress; berries more adaptogenic.',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Aralia', 340,
   '### Aralia (Aralia californica)
- (tasting)
- def warming, use in a damp cough situation
- Queen of the Forest
- Known mystically as the bridge between air and water (often found in the forest with her feet wet (maybe creek bed, shaded))
- [[Antiviral]], [[Alterative]], [[Carminative]], [[Nervine]], AI
- Both a cough suppressant and [[expectorant]]
- very good restorative after extreme lung damage
- grounding, balancing and calming
- use both the root and berries
    - root more for respiratory distress, berries maybe more an [[adaptogen]]'),

  -- ── Osha (dedicated section) ──────────────────────────────────────────────────
  (104,
   'Osha: warming and drying — use with damp/cool coughs, or add marshmallow. Member of the parsley family (looks like poison hemlock). Very powerful antiviral and diaphoretic — use at first sign of infection. Bronchodilator (cough syrup). Apply topically to wounds. Powerful emmenagogue. Called "Bear Medicine".',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Osha', 350,
   '### [[Osha]]
- (tasting)
- warming and drying, so use with damp/cool coughs, or make with [[marshmallow]]
- member of the parsley family - be careful when sourcing/harvesting (looks like poison hemlock)
- grows in Idaho, Nevada, Montana, Wyoming, Colorado, New Mexico (Lingusticum porterii)
- California version of the plant is Oshala (L. grayii)
- very powerful [[antiviral]] and [[diaphoretic]] that helps you sweat out toxins and illnesses (use at first sign of infection)
- makes a great cough syrup (bronchodilator)
- apply to wounds and abrasions to fight infection
- be careful it is a powerful [[emmenagogue]]
- use spiritually to clear out old patterns and negativity (smoke)
- folklore: carrying [[Osha]] wards off snakes
- called "Bear Medicine"'),

  (45,
   'Osha is warming and drying — add marshmallow when patient needs mucous membrane protection',
   'BHC - Class 13 - Limpia and Respiratory 1 - Rose', 'personal', 'Osha', 360,
   '### [[Osha]]
- (tasting)
- warming and drying, so use with damp/cool coughs, or make with [[marshmallow]]
- member of the parsley family - be careful when sourcing/harvesting (looks like poison hemlock)
- grows in Idaho, Nevada, Montana, Wyoming, Colorado, New Mexico (Lingusticum porterii)
- California version of the plant is Oshala (L. grayii)
- very powerful [[antiviral]] and [[diaphoretic]] that helps you sweat out toxins and illnesses (use at first sign of infection)
- makes a great cough syrup (bronchodilator)
- apply to wounds and abrasions to fight infection
- be careful it is a powerful [[emmenagogue]]
- use spiritually to clear out old patterns and negativity (smoke)
- folklore: carrying [[Osha]] wards off snakes
- called "Bear Medicine"');

END $$;

-- Keywords
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  -- Mugwort
  (115, 'emmenagogue',           'action'),
  -- Grindelia
  (2231, 'expectorant',          'action'),
  (2231, 'respiratory congestion', 'ailment'),
  (2231, 'bronchitis',           'ailment'),
  (2231, 'common cold',          'ailment'),
  -- Osha
  (104, 'expectorant',           'action'),
  (104, 'antiviral',             'action'),
  (104, 'diaphoretic',           'action'),
  (104, 'bronchodilator',        'action'),
  (104, 'emmenagogue',           'action'),
  (104, 'antimicrobial',         'action'),
  (104, 'respiratory infection', 'ailment'),
  (104, 'respiratory congestion','ailment'),
  (104, 'acute illness',         'ailment'),
  (104, 'wound healing',         'ailment'),
  -- Yerba Santa
  (590, 'expectorant',           'action'),
  (590, 'respiratory congestion','ailment'),
  -- Mullein
  (61, 'expectorant',            'action'),
  (61, 'demulcent',              'action'),
  (61, 'lung tonic',             'action'),
  (61, 'respiratory congestion', 'ailment'),
  (61, 'chronic lung disease',   'ailment'),
  -- Plantain
  (85, 'expectorant',            'action'),
  (85, 'respiratory congestion', 'ailment'),
  -- Elecampane
  (54, 'expectorant',            'action'),
  (54, 'antiviral',              'action'),
  (54, 'antimicrobial',          'action'),
  (54, 'antitussive',            'action'),
  (54, 'bronchitis',             'ailment'),
  (54, 'asthma',                 'ailment'),
  (54, 'respiratory congestion', 'ailment'),
  (54, 'chronic lung disease',   'ailment'),
  (54, 'respiratory infection',  'ailment'),
  (54, 'spasmodic cough',        'ailment'),
  -- Yerba Mansa
  (309, 'anticatarrhal',         'action'),
  (309, 'respiratory congestion','ailment'),
  (309, 'sinus infection',       'ailment'),
  -- Goldenseal
  (30, 'anticatarrhal',          'action'),
  (30, 'respiratory congestion', 'ailment'),
  (30, 'sinus infection',        'ailment'),
  -- Garlic
  (21, 'anticatarrhal',          'action'),
  (21, 'antimicrobial',          'action'),
  (21, 'antiviral',              'action'),
  (21, 'respiratory infection',  'ailment'),
  (21, 'common cold',            'ailment'),
  -- Boneset
  (50, 'anticatarrhal',          'action'),
  (50, 'respiratory congestion', 'ailment'),
  (50, 'influenza',              'ailment'),
  -- Marshmallow
  (45, 'demulcent',              'action'),
  (45, 'respiratory congestion', 'ailment'),
  (45, 'chronic lung disease',   'ailment'),
  -- Licorice
  (78, 'demulcent',              'action'),
  (78, 'respiratory congestion', 'ailment'),
  (78, 'chronic lung disease',   'ailment'),
  -- Irish Moss
  (49, 'demulcent',              'action'),
  (49, 'respiratory congestion', 'ailment'),
  -- Wild Cherry Bark
  (140, 'antispasmodic',         'action'),
  (140, 'antitussive',           'action'),
  (140, 'spasmodic cough',       'ailment'),
  (140, 'bronchitis',            'ailment'),
  -- Lobelia
  (132, 'antispasmodic',         'action'),
  (132, 'bronchodilator',        'action'),
  (132, 'asthma',                'ailment'),
  (132, 'spasmodic cough',       'ailment'),
  -- Thyme
  (59, 'antimicrobial',          'action'),
  (59, 'antitussive',            'action'),
  (59, 'respiratory infection',  'ailment'),
  (59, 'spasmodic cough',        'ailment'),
  (59, 'bronchitis',             'ailment'),
  -- Usnea
  (112, 'antimicrobial',         'action'),
  (112, 'antiviral',             'action'),
  (112, 'respiratory infection', 'ailment'),
  -- Pine Needles
  (2643, 'bronchodilator',       'action'),
  (2643, 'asthma',               'ailment'),
  (2643, 'respiratory congestion','ailment'),
  -- Prince Seng
  (982, 'lung tonic',            'action'),
  (982, 'chronic lung disease',  'ailment'),
  -- Motherwort
  (131, 'nervine',               'action'),
  (131, 'nervous system support','ailment'),
  -- Hawthorn
  (73, 'nervine',                'action'),
  (73, 'nervous system support', 'ailment'),
  -- California Spikenard (Aralia)
  (579, 'antiviral',             'action'),
  (579, 'alterative',            'action'),
  (579, 'carminative',           'action'),
  (579, 'nervine',               'action'),
  (579, 'anti-inflammatory',     'action'),
  (579, 'expectorant',           'action'),
  (579, 'adaptogen',             'action'),
  (579, 'respiratory infection', 'ailment'),
  (579, 'chronic lung disease',  'ailment'),
  (579, 'bronchitis',            'ailment'),
  (579, 'asthma',                'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;
