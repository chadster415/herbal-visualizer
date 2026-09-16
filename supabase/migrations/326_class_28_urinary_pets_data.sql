-- Migration 326: Class 28 snippets, keywords, and ailment search terms
-- BHC - Class 28 - Urinary 2 and Herbs for Pets - Shereel and Cheryl
-- Files parsed: BHC - Class 28 - Urinary 2 and Herbs for Pets - Shereel and Cheryl.md (personal notes only)
-- note_type: personal for all snippets
--
-- Herb normalisations:
--   SJW → St. John's Wort (id=81)
--   Oatstraw → Oat straw (id=2287, Avena sativa, straw)
--   Tulsi → Holy Basil (id=13)
--   Cal Poppy / California Poppy → California Poppy (id=128)
--   Nettles → Nettle leaf (id=43)
--   True Solomon's Seal → Solomon's Seal (id=1252)
--   Daisies → English Daisy (id=191, Bellis perennis)
--   mint → Peppermint (id=55)
--   Rosemary → Rosemary (id=109)
--   Hawthorn leaf and flower → Hawthorn (id=1652, Crataegus spp., leaf & flower)
--   Dandelion (leaf) → id=1648; Dandelion (root) → id=122
--   Frankincense → Frankincense (id=1597, Resina Olibani)
--   Willow → White Willow (id=87)
--
-- Herbs added in migration 325 (looked up by subquery):
--   Lion's Mane → (SELECT id FROM herbal.herbs WHERE latin_name='Hericium erinaceus' AND plant_part='fruiting body')
--   Maitake → (SELECT id FROM herbal.herbs WHERE latin_name='Grifola frondosa' AND plant_part='fruiting body')
--   Cordyceps → (SELECT id FROM herbal.herbs WHERE latin_name='Cordyceps militaris' AND plant_part='fruiting body')
--
-- Herbs skipped (non-herbal or preparations):
--   Castor oil, fire cider, castor pack, colostrum, lemon water — preparations/foods
--   MSM (methylsulfonylmethane) — not in herbs or supplements
--   Bach flower essences (Cherry Plum, Clematis, Rock Rose, Star of Bethlehem) — not in herbs DB
--   Strawberry flower essence — not in herbs DB
--   Probiotics — too general (no specific supplement row)
--
-- Keyword merge decisions:
--   "menorrhagia" type content → use existing 'heavy bleeding'
--   "cystitis" → use existing 'urinary tract infection'
--   "withdrawal symptoms" → new keyword 'substance withdrawal'

SET search_path TO herbal, public;

-- =====================================================================
-- Snippets (guard block — idempotent)
-- =====================================================================

DO $$
DECLARE
  v_class      TEXT := 'BHC - Class 28 - Urinary 2 and Herbs for Pets - Shereel and Cheryl';

  -- source blocks
  sb_urinary   TEXT;
  sb_case      TEXT;
  sb_pets      TEXT;
  sb_digestive TEXT;
  sb_chinese   TEXT;

BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets WHERE class_name = v_class) THEN
    RAISE NOTICE 'Class 28 snippets already loaded, skipping';
    RETURN;
  END IF;

  -- ── Source blocks ──────────────────────────────────────────────────────────

  sb_urinary := E'## Urinary 2 - Pathologies\n'
    '\n'
    '- [[diuretic]] herbs can remove sodium from the blood, and then all of a sudden the water level is too high in the body, and the body gets rid of the extra water\n'
    '- because diuretics remove sodium and hence water, can help high blood pressure, but also those herbs can provide the minerals we need that would otherwise be stripped from the blood by pharmaceutical drugs\n'
    '- [[St John''s Wort|SJW]] is great for helping to ease withdrawal symptoms\n'
    '    - possibly [[Databases/Herbs/Data/California Poppy|California Poppy]] as well\n'
    '\n'
    '### Cystitis\n'
    '- inflammation of the bladder caused by a bacterial infection \n'
    '- Imbalances - hot (air & fire) and wet (water & earth), Fire, Water & Earth\n'
    '### Kidney Stones\n'
    '- hard mineral and salt deposits in urine\n'
    '- Imbalances - dry, cold: Ether/ Air & Fire \n'
    '### Kidney infection\n'
    '- when bacteria or viruses infect one or both kidneys\n'
    '- Imbalances - hot, wet: Fire, Water, & Earth \n'
    '### Chronic degenerative kidney disease\n'
    '- gradual loss of kidney function from eliminating waste byproducts\n'
    '- Imbalances - hot, dry: Fire, Earth, Air\n'
    '### Incontinence\n'
    '- involuntary loss of urine\n'
    '- Various types: Stress, Overflow, Urge, and Mixed';

  sb_case := E'## Case Study\n'
    'Primary Concerns \n'
    'Familial Trauma was diagnosed with PTSD; having trouble sleeping, not wanting to get up; elevated cortisol levels; not moving as much as desired; experiencing incontinence and constipation. Loves food, but has changed diet due to increased weight; shifted to more plant-based foods, but enjoys African American food ways Was taking anti-depressant meds Has begun taking an online Qigong course to help regulate stress levels\n'
    '\n'
    'POC (Plan of Care) \n'
    'Herbs & Herbal Actions: \n'
    '\n'
    '[[Adaptogen]]\n'
    '[[Demulcent]]\n'
    '[[Nervine]]\n'
    '[[Alterative]]\n'
    '\n'
    'Herbal Formula: \n'
    '\n'
    '**[[Hot to Cold Infusion]]**\n'
    '[[Oats|Oatstraw]] - 3\n'
    '[[Tulsi]] - 2\n'
    '[[Databases/Herbs/Data/Lemon Balm|Lemon Balm]] - 1\n'
    '\n'
    '**Decoction**\n'
    '[[Burdock]] - 1\n'
    '[[Yellow Dock]] - 1\n'
    '\n'
    '\n'
    'Instructions: \n'
    '\n'
    'final formula:\n'
    '2P [[Valerian]]\n'
    '1P [[Databases/Herbs/Data/California Poppy|California poppy]]\n'
    '1/2 [[Hawthorn]] leaf and flower\n'
    '1/2 [[Tulsi]]\n'
    '1/2 [[Marshmallow]]\n'
    '1/2 [[Cinnamon]]\n'
    '\n'
    'Initial recommendations:\n'
    '- keep fiber intake up\n'
    '- good fats, olive oil, avocado, nuts\n'
    '- increase exercise\n'
    '- sunlight\n'
    '\n'
    '- [[dandelion leaf]]? would increase incontinence?\n'
    '- animal fats - decrease anxiety due to nourishment\n'
    '- [[Valerian]] - [[hypnotic]], sleep\n'
    '- [[Databases/Herbs/Data/California Poppy|Cal Poppy]] - hypnotic';

  sb_pets := E'# Notes - Afternoon - Cheryl Schwartz - Herbs for Pets\n'
    '\n'
    '- cats super sensitive to EO''s - use in large space and diluted\n'
    '- small dogs too\n'
    '\n'
    '- [[rosemary]] good anti-flea plant';

  sb_digestive := E'### Digestive\n'
    '- how to tell whether warm or cold?\n'
    '    - drinking a lot of water\n'
    '    - pant easily\n'
    '    - can''t take the sun\n'
    '    - GI issue? - use a cooling herb\n'
    '        - [[mint]], [[chamomile]]\n'
    '    - vomiting of blood? inflammation, dry\n'
    '    - breakdown of the cells\n'
    '\n'
    '- [[Fennel]] - warming - [[carminative]]\n'
    '    - can mix with [[Chamomile]] \n'
    '    - digestive - if vomit food several hours later with mucus\n'
    '- Dill - cooling\n'
    '\n'
    '- Probiotics?\n'
    '    - get rid of chronic diarrhea and nausea\n'
    '\n'
    'book: Prisoner''s Herbal - Nicole Rose - [[plantain]], [[chamomile]], daisy, [[yarrow]], self heal\n'
    ' Annie''s Nursery -> Curious Flora - plant shop in Richmond near Point Richmond\n'
    '\n'
    '- [[Yarrow]]\n'
    '    - hot to the 4th degree\n'
    '    - act to decrease blood vomiting\n'
    '    - burns \n'
    '    - anti-infective, antibacterial\n'
    '    - protector plant\n'
    '    - [[Yarrow]] + [[Marshmallow]] + [[Slippery Elm]]\n'
    '    - "Strengthen and Repair" formula\n'
    '        - combo of collostrum, aloe\n'
    '        - https://www.pethealthandnutritioncenter.com/products/repair-strengthen-digestive-tract-dogs-cats\n'
    '- Daisies\n'
    '    - + [[Calendula]], for wounds that don''t heal\n'
    '    - put herbal remedy in a little meatball for dogs\n'
    '    - for cats, put it in a little fish to mask the smell (of [[Yarrow]] too)\n'
    '\n'
    '- Anxiety can lead to:\n'
    '    - GI issues\n'
    '    - Respiratory issues\n'
    '    - Immune problems\n'
    '    - Mobility issues\n'
    '\n'
    '- to get away from the Fear, we have to be in the present moment, and the animals need that from us, they respond to our state\n'
    '- maintain a good open atmosphere between us and the animals\n'
    '\n'
    '- Kidneys - genetic predispositions, cellular memories\n'
    '    - Water\n'
    '    - gives rise to the warming, the circulation\n'
    '    - in order to keep things moving\n'
    '    - to ground, sit on your hands for a few seconds\n'
    '\n'
    '- sometimes you have to treat the person before you treat the animal\n'
    '- drops rubbed on the palm, then the animal';

  sb_chinese := E'### Chinese Elements progression\n'
    '- Heart / Fire\n'
    '    - hold the communication and the push\n'
    '    - suports the stomach\n'
    '    - your oomph\n'
    '    - Qi, Fiery Yang \n'
    '    - supports the earth\n'
    '- Stomach\n'
    '    - Earth\n'
    '    - gives oxygen to the lung through the food\n'
    '- Lung\n'
    '    - Metal\n'
    '    - mountains separated and created the rivers\n'
    '- Kidneys\n'
    '    - Water\n'
    '    - waters the wood\n'
    '- Liver\n'
    '    - Wood\n'
    '    - creates the fire (back to heart)\n'
    '\n'
    '- [[Rose]] - the most primal of the fragrances\n'
    '    - cools an overheated liver\n'
    '    - comforts the heart\n'
    '    - resist infection\n'
    '    - Rose Cordial strengthens the spirit of the heart\n'
    '    - [[rose]] water for animals with skin issues\n'
    '    - cooling, of tempers as well\n'
    '\n'
    '- Strawberry Flower Essence\n'
    '    - spreads out, grounding, first chakra\n'
    '    - for dignity and self-worth, maybe from a shelter\n'
    '    - just a couple of drops on hand, rub together and then pet the animal\n'
    '- Medicinal mushrooms\n'
    '    - for anxiety\n'
    '    - Lion''s Mane and [[Reishi]]\n'
    '    - Four Sigmatic coffee\n'
    '    - pre-biotic fiber and immune modulation\n'
    '    - Lion''s Mane - standing in kitchen not knowing what to do\n'
    '    - [[Reishi]] - power herb, supports the heart\n'
    '        - standing strong in yourself\n'
    '        - other power herbs:\n'
    '            - [[Nettle|Nettles]]\n'
    '            - [[Reishi]]\n'
    '            - [[Plantain]]\n'
    '            - True [[Solomons Seal]] - for bald spot from licking, clear the energy\n'
    '            - Lions'' Mane\n'
    '\n'
    '- Physical heart\n'
    '\n'
    '- [[Hawthorn]]\n'
    '    - best physical herb for the heart\n'
    '    - sweet, sour, stringent\n'
    '    - cooling, decrease anxiety\n'
    '    - create relation\n'
    '    - high in flavonoid rutinin\n'
    '    - can use physical and spirit doses\n'
    '    - restlessness, irritability, nervous from the heart\n'
    '    - opens up the coronary arteries, supports the tissue\n'
    '    - shen disturbance herb, good for ADHD\n'
    '    - normalize cholesterol levels\n'
    '    - stomach, GI disorders in TCM, Western use was for cardio \n'
    '\n'
    '- [[Dandelion Leaf|Dandelion]]\n'
    '    - leaf - diuretic\n'
    '        - contains potassium\n'
    '        - try to get off Lasix (furosamide) and onto [[dandelion leaf]], especially for edema\n'
    '    - root - good liver herb - fats digestion\n'
    '        -  mastitis and hepatitis\n'
    '        - nipple line meridian is the stomach\n'
    '        - [[Dandelion Leaf|dandelion]], [[cleavers]] and [[burdock]] poultice for breast cysts\n'
    '        - tincture? 5 drops to 1 cup water for small dog or cat\n'
    '            - homeopathic or flower essence\n'
    '            - med 10 drops per cup\n'
    '            - lg 20 drops in one quart\n'
    '    - flower essence for overstriving\n'
    '\n'
    '- Digestive Bitter Combinations: Urban Moonshine\n'
    '\n'
    '- [[Chamomile]]\n'
    '    - good for dogs and cats\n'
    '    - use the dry for digestion\n'
    '    - for behavior, though, use the fresh\n'
    '    - cools and relaxes\n'
    '    - used for horses with colic pain\n'
    '    - anything for soothing around the skin or mucosa (anal gland absesses)\n'
    '\n'
    '- [[Catnip]]\n'
    '    - relieves spasms\n'
    '    - infants, colic\n'
    '    - animal who internalizes and holds stress\n'
    '    - Liver gets congested and doesn''t want to move, have to relieve the tension it brings on to the stomach\n'
    '\n'
    '- [[Plantain]]\n'
    '    - smelly diarrhea\n'
    '    - clears damp heat\n'
    '    - insect bites\n'
    '    - foreign bodies\n'
    '    - + [[St John''s Wort|SJW]] in gauze for after dental in pets\n'
    '        - good for gum irritation or inside cheek\n'
    '    - spirit medicine -> going beyond nationalism, borders\n'
    '        - "white mans footprint"\n'
    '    - Colon Rescue by Animal Essentials: [[Slippery Elm]], [[Marshmallow]], [[Plantain]], [[Licorice root|Licorice]] - for diarrhea\n'
    '\n'
    '- Sadness and Grief stuck in the lungs\n'
    '    - asthma patients often problem with grief\n'
    '    - Fear and Grief (Kidneys and Lungs) interact with Asthma\n'
    '\n'
    '- [[Slippery Elm]]\n'
    '    - helps both the Earth and the Lung\n'
    '    - lubricant\n'
    '    - William LeSassier herbalist\n'
    '        - "relaxes the nerves in the lungs"\n'
    '\n'
    '- [[Mullein]]\n'
    '    - element tastes:\n'
    '        - Earth sweet\n'
    '        - lung acrid pungent\n'
    '        - kidney salty\n'
    '        - livers sour\n'
    '        - heart ??\n'
    '    - [[mullein]] indiv get dry\n'
    '\n'
    '- [[Cordyceps]] mushroom\n'
    '    - energy, vitality\n'
    '    - (Lions mane and [[reishi]] more about focus)\n'
    '    - increases oxygen, mobility\n'
    '    - Paul Stamets\n'
    '        - did a show with Caroline ..\n'
    '    - can grow mushrooms on mycelium, better\n'
    '        - resembles connective tissue\n'
    '        - use the fruiting bodies\n'
    '        - "Real Mushrooms" company\n'
    '\n'
    '- topicals you can use\n'
    '    - spray for hot spots:\n'
    '        - [[chamomile]]\n'
    '        - [[burdock]]\n'
    '        - [[alfalfa]]\n'
    '        - [[Dandelion Leaf|dandelion]]\n'
    '        - [[calendula]]\n'
    '        - [[St John''s Wort|SJW]]\n'
    '- lemon water\n'
    '    - for fungal infections\n'
    '- Boswellia ([[Frankincense]])\n'
    '    - good for mobility for older animals\n'
    '    - decreasing pain\n'
    '    - in capsules as a powder\n'
    '\n'
    '- David Winston (herbalist alchemist)\n'
    '    - [[White Willow|Willow]] bark, use tiny amount\n'
    '    - Devil''s claw or Boswellia or MSM for the cats instead (more gentle)\n'
    '\n'
    'Star of Bethlehem, Rescue Remedy (Five Flower: Rock Rose, [[Clematis]] Impatiens, [[Cherry Plum]], Star Bethlehem) \n'
    'Bach Flower essences \n'
    '    Emergency of any kind. Brings peacefulness and helps Restore calm, pain relief Loss, grief, terror, grounding \n'
    '\n'
    'Ok for cats: "George''s Fractionated Tasteless Aloe": https://www.amazon.com/...\n'
    '\n'
    'Maitake\n'
    '- one of the best mushrooms for diabetes - regulates BS';

  -- ── Insert all snippets ─────────────────────────────────────────────────────

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- 1
  (81,
   'SJW is great for helping to ease withdrawal symptoms; possibly California Poppy as well (in context of discussing diuretic herbs and medications)',
   v_class, 'personal', 'Urinary 2 Pathologies', 10, sb_urinary),

  -- 2
  (128,
   'SJW is great for helping to ease withdrawal symptoms; possibly California Poppy as well',
   v_class, 'personal', 'Urinary 2 Pathologies', 20, sb_urinary),

  -- 3
  (2287,
   'Hot to Cold Infusion for PTSD patient (incontinence, constipation, elevated cortisol): Oatstraw - 3, Tulsi - 2, Lemon Balm - 1',
   v_class, 'personal', 'Case Study', 30, sb_case),

  -- 4
  (13,
   'Hot to Cold Infusion: Oatstraw - 3, Tulsi - 2, Lemon Balm - 1; also in final tincture formula: 2P Valerian, 1P California Poppy, 1/2 Hawthorn leaf and flower, 1/2 Tulsi, 1/2 Marshmallow, 1/2 Cinnamon',
   v_class, 'personal', 'Case Study', 40, sb_case),

  -- 5
  (134,
   'Hot to Cold Infusion: Oatstraw - 3, Tulsi - 2, Lemon Balm - 1',
   v_class, 'personal', 'Case Study', 50, sb_case),

  -- 6
  (22,
   'Decoction: Burdock - 1, Yellow Dock - 1 (for patient with PTSD, constipation, elevated cortisol)',
   v_class, 'personal', 'Case Study', 60, sb_case),

  -- 7
  (37,
   'Decoction: Burdock - 1, Yellow Dock - 1',
   v_class, 'personal', 'Case Study', 70, sb_case),

  -- 8
  (145,
   'Final tincture formula: 2P Valerian, 1P California Poppy, 1/2 Hawthorn leaf and flower, 1/2 Tulsi, 1/2 Marshmallow, 1/2 Cinnamon; Valerian - hypnotic, sleep',
   v_class, 'personal', 'Case Study', 80, sb_case),

  -- 9
  (128,
   'Final tincture formula: 2P Valerian, 1P California Poppy, 1/2 Hawthorn leaf and flower, 1/2 Tulsi, 1/2 Marshmallow, 1/2 Cinnamon; Cal Poppy - hypnotic',
   v_class, 'personal', 'Case Study', 90, sb_case),

  -- 10
  (1652,
   'Final tincture formula: 2P Valerian, 1P California Poppy, 1/2 Hawthorn leaf and flower, 1/2 Tulsi, 1/2 Marshmallow, 1/2 Cinnamon',
   v_class, 'personal', 'Case Study', 100, sb_case),

  -- 11
  (45,
   'Final tincture formula: 2P Valerian, 1P California Poppy, 1/2 Hawthorn leaf and flower, 1/2 Tulsi, 1/2 Marshmallow, 1/2 Cinnamon',
   v_class, 'personal', 'Case Study', 110, sb_case),

  -- 12
  (167,
   'Final tincture formula: 2P Valerian, 1P California Poppy, 1/2 Hawthorn leaf and flower, 1/2 Tulsi, 1/2 Marshmallow, 1/2 Cinnamon',
   v_class, 'personal', 'Case Study', 120, sb_case),

  -- 13
  (1648,
   'Dandelion leaf? Would increase incontinence? (asked in context of urinary patient with incontinence — diuretic action could worsen symptoms)',
   v_class, 'personal', 'Case Study', 130, sb_case),

  -- 14
  (109,
   'Rosemary good anti-flea plant',
   v_class, 'personal', 'Herbs for Pets', 140, sb_pets),

  -- 15
  (55,
   'GI issue in pets? Use a cooling herb: mint, chamomile',
   v_class, 'personal', 'Digestive', 150, sb_digestive),

  -- 16
  (84,
   'GI issue? Use a cooling herb: mint, chamomile; Fennel can mix with Chamomile; digestive use for pets (vomit with mucus)',
   v_class, 'personal', 'Digestive', 160, sb_digestive),

  -- 17
  (76,
   'Fennel - warming - carminative; can mix with Chamomile; digestive use if pet vomits food several hours later with mucus',
   v_class, 'personal', 'Digestive', 170, sb_digestive),

  -- 18
  (64,
   'Dill - cooling (digestive use for pets)',
   v_class, 'personal', 'Digestive', 180, sb_digestive),

  -- 19
  (44,
   'Yarrow - hot to the 4th degree; act to decrease blood vomiting; burns; anti-infective, antibacterial; protector plant; Yarrow + Marshmallow + Slippery Elm - "Strengthen and Repair" formula (combo of colostrum, aloe)',
   v_class, 'personal', 'Digestive', 190, sb_digestive),

  -- 20
  (45,
   'Yarrow + Marshmallow + Slippery Elm - "Strengthen and Repair" formula; also in Colon Rescue (Slippery Elm, Marshmallow, Plantain, Licorice) for diarrhea',
   v_class, 'personal', 'Digestive', 200, sb_digestive),

  -- 21
  (92,
   'Yarrow + Marshmallow + Slippery Elm - "Strengthen and Repair" formula; also Colon Rescue: Slippery Elm, Marshmallow, Plantain, Licorice for diarrhea in pets',
   v_class, 'personal', 'Digestive', 210, sb_digestive),

  -- 22
  (191,
   'Daisies + Calendula, for wounds that don''t heal; put herbal remedy in a little meatball for dogs, or in fish for cats to mask the smell',
   v_class, 'personal', 'Digestive', 220, sb_digestive),

  -- 23
  (70,
   'Daisies + Calendula, for wounds that don''t heal in pets',
   v_class, 'personal', 'Digestive', 230, sb_digestive),

  -- 24
  (850,
   'Rose - the most primal of the fragrances; cools an overheated liver; comforts the heart; resists infection; Rose Cordial strengthens the spirit of the heart; rose water for animals with skin issues; cooling, of tempers as well',
   v_class, 'personal', 'Chinese Elements', 240, sb_chinese),

  -- 25
  (11,
   'Medicinal mushrooms for anxiety: Lion''s Mane and Reishi; Reishi - power herb, supports the heart, "standing strong in yourself"; pre-biotic fiber and immune modulation; listed as a power herb alongside Nettles, Plantain, True Solomon''s Seal',
   v_class, 'personal', 'Chinese Elements', 250, sb_chinese),

  -- 26
  ((SELECT id FROM herbal.herbs WHERE latin_name = 'Hericium erinaceus' AND plant_part = 'fruiting body'),
   'Lion''s Mane - for cognitive support: "standing in kitchen not knowing what to do"; pre-biotic fiber and immune modulation; listed as a power herb; Cordyceps more about energy, Lion''s Mane and Reishi more about focus',
   v_class, 'personal', 'Chinese Elements', 260, sb_chinese),

  -- 27
  (43,
   'Power herbs: Nettles, Reishi, Plantain, True Solomon''s Seal, Lion''s Mane',
   v_class, 'personal', 'Chinese Elements', 270, sb_chinese),

  -- 28
  (1252,
   'True Solomon''s Seal - for bald spot from licking in pets, clear the energy; listed as a power herb',
   v_class, 'personal', 'Chinese Elements', 280, sb_chinese),

  -- 29
  (1652,
   'Hawthorn - best physical herb for the heart; sweet, sour, stringent; cooling, decreases anxiety; high in flavonoid rutinin; can use physical and spirit doses; restlessness, irritability, nervous from the heart; opens up the coronary arteries, supports the tissue; shen disturbance herb, good for ADHD; normalize cholesterol levels; stomach and GI disorders in TCM',
   v_class, 'personal', 'Chinese Elements', 290, sb_chinese),

  -- 30
  (1648,
   'Dandelion leaf - diuretic; contains potassium; try to get off Lasix (furosemide) and onto dandelion leaf, especially for edema; pet dosing: 5 drops per 1 cup water for small dog/cat; 10 drops per cup for medium; 20 drops per quart for large',
   v_class, 'personal', 'Chinese Elements', 300, sb_chinese),

  -- 31
  (122,
   'Dandelion root - good liver herb, fats digestion; mastitis and hepatitis; dandelion, cleavers and burdock poultice for breast cysts',
   v_class, 'personal', 'Chinese Elements', 310, sb_chinese),

  -- 32
  (28,
   'Dandelion, cleavers and burdock poultice for breast cysts',
   v_class, 'personal', 'Chinese Elements', 320, sb_chinese),

  -- 33
  (22,
   'Dandelion, cleavers and burdock poultice for breast cysts; burdock also in topical spray for hot spots',
   v_class, 'personal', 'Chinese Elements', 330, sb_chinese),

  -- 34
  (84,
   'Chamomile - good for dogs and cats; use the dry for digestion, the fresh for behavior; cools and relaxes; used for horses with colic pain; anything for soothing around the skin or mucosa (anal gland abscesses)',
   v_class, 'personal', 'Chinese Elements', 340, sb_chinese),

  -- 35
  (136,
   'Catnip - relieves spasms; for infants, colic; for animal who internalizes and holds stress; liver gets congested and doesn''t want to move',
   v_class, 'personal', 'Chinese Elements', 350, sb_chinese),

  -- 36
  (85,
   'Plantain - smelly diarrhea; clears damp heat; insect bites; foreign bodies; Plantain + SJW in gauze after dental in pets - good for gum irritation or inside cheek; Colon Rescue: Slippery Elm, Marshmallow, Plantain, Licorice for diarrhea',
   v_class, 'personal', 'Chinese Elements', 360, sb_chinese),

  -- 37
  (81,
   'Plantain + SJW in gauze for after dental in pets - good for gum irritation or inside cheek; SJW also in topical hot spot spray',
   v_class, 'personal', 'Chinese Elements', 370, sb_chinese),

  -- 38
  (92,
   'Slippery Elm - helps both the Earth and the Lung; lubricant; William LeSassier: "relaxes the nerves in the lungs"; also in Colon Rescue (Slippery Elm, Marshmallow, Plantain, Licorice) for diarrhea',
   v_class, 'personal', 'Chinese Elements', 380, sb_chinese),

  -- 39
  (78,
   'Colon Rescue by Animal Essentials: Slippery Elm, Marshmallow, Plantain, Licorice - for diarrhea in pets',
   v_class, 'personal', 'Chinese Elements', 390, sb_chinese),

  -- 40
  (45,
   'Colon Rescue by Animal Essentials: Slippery Elm, Marshmallow, Plantain, Licorice - for diarrhea; also part of "Strengthen and Repair" formula (Yarrow + Marshmallow + Slippery Elm)',
   v_class, 'personal', 'Chinese Elements', 400, sb_chinese),

  -- 41
  (61,
   'Mullein - element tastes: Earth sweet, lung acrid pungent, kidney salty, liver sour; mullein individuals get dry',
   v_class, 'personal', 'Chinese Elements', 410, sb_chinese),

  -- 42
  ((SELECT id FROM herbal.herbs WHERE latin_name = 'Cordyceps militaris' AND plant_part = 'fruiting body'),
   'Cordyceps mushroom - energy, vitality; increases oxygen, mobility; Paul Stamets recommends fruiting bodies; "Real Mushrooms" company; Lion''s Mane and Reishi more about focus, Cordyceps more about energy',
   v_class, 'personal', 'Chinese Elements', 420, sb_chinese),

  -- 43
  (885,
   'Topical spray for hot spots (pets): chamomile, burdock, alfalfa, dandelion, calendula, SJW',
   v_class, 'personal', 'Chinese Elements', 430, sb_chinese),

  -- 44
  (70,
   'Topical spray for hot spots (pets): chamomile, burdock, alfalfa, dandelion, calendula, SJW; also used for wounds that don''t heal (with Daisies)',
   v_class, 'personal', 'Chinese Elements', 440, sb_chinese),

  -- 45
  (1597,
   'Boswellia (Frankincense) - good for mobility for older animals; decreasing pain; in capsules as a powder',
   v_class, 'personal', 'Chinese Elements', 450, sb_chinese),

  -- 46
  (87,
   'David Winston: Willow bark, use tiny amount for pain; Devil''s claw or Boswellia or MSM for cats instead (more gentle for felines)',
   v_class, 'personal', 'Chinese Elements', 460, sb_chinese),

  -- 47
  (80,
   'David Winston: Devil''s claw or Boswellia or MSM for cats instead of Willow bark (more gentle)',
   v_class, 'personal', 'Chinese Elements', 470, sb_chinese),

  -- 48
  ((SELECT id FROM herbal.herbs WHERE latin_name = 'Grifola frondosa' AND plant_part = 'fruiting body'),
   'Maitake - one of the best mushrooms for diabetes; regulates blood sugar',
   v_class, 'personal', 'Chinese Elements', 480, sb_chinese);

  RAISE NOTICE 'Class 28 snippets loaded (48 rows).';
END $$;

-- =====================================================================
-- Keywords (unconditional, ON CONFLICT DO NOTHING)
-- =====================================================================

-- St. John's Wort (81)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (81, 'substance withdrawal', 'ailment'),
  (81, 'dental health',        'ailment'),
  (81, 'wound healing',        'ailment'),
  (81, 'nervine',              'action'),
  (81, 'antimicrobial',        'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- California Poppy (128)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (128, 'PTSD',         'ailment'),
  (128, 'sleep support','ailment'),
  (128, 'anxiety',      'ailment'),
  (128, 'hypnotic',     'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Oatstraw (2287)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2287, 'stress',        'ailment'),
  (2287, 'anxiety',       'ailment'),
  (2287, 'PTSD',          'ailment'),
  (2287, 'adrenal fatigue','ailment'),
  (2287, 'nervine',       'action'),
  (2287, 'nutritive',     'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Tulsi / Holy Basil (13)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (13, 'stress',        'ailment'),
  (13, 'adrenal fatigue','ailment'),
  (13, 'PTSD',          'ailment'),
  (13, 'adaptogen',     'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Lemon Balm (134)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (134, 'stress',        'ailment'),
  (134, 'anxiety',       'ailment'),
  (134, 'sleep support', 'ailment'),
  (134, 'nervine',       'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Burdock (22)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (22, 'constipation',     'ailment'),
  (22, 'liver support',    'ailment'),
  (22, 'breast cysts',     'ailment'),
  (22, 'lymphatic support','ailment'),
  (22, 'alterative',       'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Yellow Dock (37)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (37, 'constipation', 'ailment'),
  (37, 'liver support','ailment'),
  (37, 'alterative',   'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Valerian (145)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (145, 'sleep support','ailment'),
  (145, 'anxiety',      'ailment'),
  (145, 'hypnotic',     'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Hawthorn leaf/flower (1652)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1652, 'cardiovascular disease','ailment'),
  (1652, 'anxiety',               'ailment'),
  (1652, 'ADHD',                  'ailment'),
  (1652, 'hyperlipidemia',        'ailment'),
  (1652, 'shen disturbance',      'ailment'),
  (1652, 'cardiotonic',           'action'),
  (1652, 'adaptogen',             'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Marshmallow (45)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (45, 'diarrhea',       'ailment'),
  (45, 'GI inflammation','ailment'),
  (45, 'demulcent',      'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Cinnamon (167)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (167, 'blood sugar dysregulation','ailment'),
  (167, 'digestive tonic',          'ailment'),
  (167, 'carminative',              'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Dandelion leaf (1648)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1648, 'edema',                 'ailment'),
  (1648, 'incontinence',          'ailment'),
  (1648, 'hypertension',          'ailment'),
  (1648, 'urinary tract infection','ailment'),
  (1648, 'diuretic',              'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Rosemary (109)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (109, 'skin infection',  'ailment'),
  (109, 'antiparasitic',   'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Peppermint (55)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (55, 'digestive tonic', 'ailment'),
  (55, 'GI inflammation', 'ailment'),
  (55, 'carminative',     'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Chamomile (84)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (84, 'digestive tonic', 'ailment'),
  (84, 'colic',           'ailment'),
  (84, 'anxiety',         'ailment'),
  (84, 'GI inflammation', 'ailment'),
  (84, 'diarrhea',        'ailment'),
  (84, 'nervine',         'action'),
  (84, 'anti-inflammatory','action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Fennel (76)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (76, 'digestive tonic', 'ailment'),
  (76, 'GI inflammation', 'ailment'),
  (76, 'carminative',     'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Dill (64)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (64, 'digestive tonic','ailment'),
  (64, 'carminative',    'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Yarrow (44)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (44, 'wound healing',   'ailment'),
  (44, 'burns',           'ailment'),
  (44, 'diarrhea',        'ailment'),
  (44, 'antimicrobial',   'action'),
  (44, 'anti-inflammatory','action'),
  (44, 'hemostatic',      'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- English Daisy (191)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (191, 'wound healing',  'ailment'),
  (191, 'skin conditions','ailment'),
  (191, 'vulnerary',      'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Calendula (70)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (70, 'wound healing',   'ailment'),
  (70, 'skin infection',  'ailment'),
  (70, 'burns',           'ailment'),
  (70, 'anti-inflammatory','action'),
  (70, 'vulnerary',       'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Rose petal (850)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (850, 'liver congestion','ailment'),
  (850, 'anxiety',         'ailment'),
  (850, 'stress',          'ailment'),
  (850, 'skin conditions', 'ailment'),
  (850, 'anti-inflammatory','action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Reishi Mushroom (11)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (11, 'anxiety',           'ailment'),
  (11, 'immune support',    'ailment'),
  (11, 'cardiovascular disease','ailment'),
  (11, 'adaptogen',         'action'),
  (11, 'immune amphoteric', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Lion's Mane (subquery)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category)
SELECT h.id, kw.keyword, kw.category
FROM herbal.herbs h
CROSS JOIN (VALUES
  ('cognitive support', 'ailment'),
  ('brain fog',         'ailment'),
  ('anxiety',           'ailment'),
  ('immune support',    'ailment'),
  ('nootropic',         'action'),
  ('adaptogen',         'action')
) AS kw(keyword, category)
WHERE h.latin_name = 'Hericium erinaceus' AND h.plant_part = 'fruiting body'
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Nettle (43)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (43, 'inflammation',  'ailment'),
  (43, 'immune support','ailment'),
  (43, 'nutritive',     'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Solomon's Seal (1252)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1252, 'connective tissue disorders','ailment'),
  (1252, 'wound healing',             'ailment'),
  (1252, 'nutritive',                 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Dandelion root (122)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (122, 'liver support','ailment'),
  (122, 'hepatitis',    'ailment'),
  (122, 'mastitis',     'ailment'),
  (122, 'breast cysts', 'ailment'),
  (122, 'alterative',   'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Cleavers (28)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (28, 'lymphatic support','ailment'),
  (28, 'breast cysts',     'ailment'),
  (28, 'alterative',       'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Catnip (136)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (136, 'anxiety',       'ailment'),
  (136, 'colic',         'ailment'),
  (136, 'muscle spasms', 'ailment'),
  (136, 'antispasmodic', 'action'),
  (136, 'nervine',       'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Plantain (85)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (85, 'diarrhea',       'ailment'),
  (85, 'dental health',  'ailment'),
  (85, 'insect bites',   'ailment'),
  (85, 'wound healing',  'ailment'),
  (85, 'anti-inflammatory','action'),
  (85, 'antimicrobial',  'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Slippery Elm (92)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (92, 'diarrhea',      'ailment'),
  (92, 'chronic cough', 'ailment'),
  (92, 'dry gut',       'ailment'),
  (92, 'demulcent',     'action'),
  (92, 'nutritive',     'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Licorice (78)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (78, 'diarrhea',       'ailment'),
  (78, 'GI inflammation','ailment'),
  (78, 'demulcent',      'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Mullein (61)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (61, 'chronic lung disease','ailment'),
  (61, 'chronic cough',      'ailment'),
  (61, 'dry gut',            'ailment'),
  (61, 'expectorant',        'action'),
  (61, 'demulcent',          'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Cordyceps (subquery)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category)
SELECT h.id, kw.keyword, kw.category
FROM herbal.herbs h
CROSS JOIN (VALUES
  ('energy support',       'ailment'),
  ('fatigue',              'ailment'),
  ('respiratory infection','ailment'),
  ('immune support',       'ailment'),
  ('adaptogen',            'action'),
  ('anti-inflammatory',    'action')
) AS kw(keyword, category)
WHERE h.latin_name = 'Cordyceps militaris' AND h.plant_part = 'fruiting body'
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Alfalfa (885)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (885, 'skin infection','ailment'),
  (885, 'nutritive',     'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Boswellia / Frankincense (1597)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1597, 'arthritis',     'ailment'),
  (1597, 'chronic pain',  'ailment'),
  (1597, 'inflammation',  'ailment'),
  (1597, 'anti-inflammatory','action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- White Willow (87)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (87, 'arthritis',     'ailment'),
  (87, 'chronic pain',  'ailment'),
  (87, 'anti-inflammatory','action'),
  (87, 'analgesic',     'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Devil's Claw (80)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (80, 'arthritis',     'ailment'),
  (80, 'chronic pain',  'ailment'),
  (80, 'anti-inflammatory','action'),
  (80, 'analgesic',     'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Maitake (subquery)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category)
SELECT h.id, kw.keyword, kw.category
FROM herbal.herbs h
CROSS JOIN (VALUES
  ('type 2 diabetes',         'ailment'),
  ('blood sugar dysregulation','ailment'),
  ('immune support',          'ailment'),
  ('cancer support',          'ailment'),
  ('immune amphoteric',       'action'),
  ('hypoglycemic',            'action')
) AS kw(keyword, category)
WHERE h.latin_name = 'Grifola frondosa' AND h.plant_part = 'fruiting body'
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- =====================================================================
-- New ailment search synonyms (Class 28)
-- =====================================================================

INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('substance withdrawal',  ARRAY['drug withdrawal', 'medication withdrawal', 'detox support', 'withdrawal symptoms', 'tapering off medications']),
  ('PTSD',                  ARRAY['post-traumatic stress disorder', 'post-traumatic stress', 'trauma', 'hyperarousal', 'trauma response', 'complex PTSD']),
  ('edema',                 ARRAY['fluid retention', 'water retention', 'swelling', 'tissue swelling', 'leg swelling', 'pitting edema']),
  ('incontinence',          ARRAY['urinary incontinence', 'bladder leakage', 'overactive bladder', 'urge incontinence', 'stress incontinence', 'bladder urgency']),
  ('shen disturbance',      ARRAY['spirit disturbance', 'heart spirit imbalance', 'TCM shen', 'emotional heart disturbance', 'spirit agitation']),
  ('mastitis',              ARRAY['breast infection', 'breast inflammation', 'mammary infection', 'nursing mastitis', 'mammary gland infection']),
  ('breast cysts',          ARRAY['fibrocystic breast', 'mammary cysts', 'breast lumps', 'breast nodules', 'fibrocystic breast disease']),
  ('dental health',         ARRAY['oral health', 'gum health', 'tooth extraction recovery', 'gum irritation', 'mouth healing', 'dental pain', 'post-dental care']),
  ('colic',                 ARRAY['abdominal cramps', 'intestinal spasms', 'colic pain', 'digestive cramping', 'infant colic', 'horse colic']),
  ('insect bites',          ARRAY['bug bites', 'bee stings', 'insect stings', 'wasp stings', 'insect bite reaction', 'ant bites'])
ON CONFLICT (ailment_keyword) DO NOTHING;
