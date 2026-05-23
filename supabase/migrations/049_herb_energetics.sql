-- Migration 049: Add energetics columns to herbal.herbs
-- Three dimensions:
--   temperature : warming | cooling | neutral
--   moisture    : moistening | drying | neutral
--   tone        : toning | relaxing | neutral
-- Default is 'neutral' for all three, so unassigned herbs are safe.

SET search_path TO herbal, public;

-- Create enum types (idempotent)
DO $$ BEGIN
  CREATE TYPE herbal.temperature_energetic AS ENUM ('warming', 'cooling', 'neutral');
EXCEPTION WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
  CREATE TYPE herbal.moisture_energetic AS ENUM ('moistening', 'drying', 'neutral');
EXCEPTION WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
  CREATE TYPE herbal.tone_energetic AS ENUM ('toning', 'relaxing', 'neutral');
EXCEPTION WHEN duplicate_object THEN null;
END $$;

-- Add columns (idempotent)
ALTER TABLE herbal.herbs
  ADD COLUMN IF NOT EXISTS temperature herbal.temperature_energetic NOT NULL DEFAULT 'neutral',
  ADD COLUMN IF NOT EXISTS moisture   herbal.moisture_energetic    NOT NULL DEFAULT 'neutral',
  ADD COLUMN IF NOT EXISTS tone       herbal.tone_energetic        NOT NULL DEFAULT 'neutral';

DO $$ BEGIN RAISE NOTICE 'Energetics columns added. Assigning values...'; END $$;

-- ─── Adaptogens / Tonics ──────────────────────────────────────────────────────
UPDATE herbal.herbs SET temperature='neutral',  moisture='drying',    tone='toning'   WHERE id=1;   -- Wu Jia Pi
UPDATE herbal.herbs SET temperature='cooling',  moisture='neutral',   tone='relaxing' WHERE id=2;   -- Silk Tree
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=3;   -- Japanese Angelica Tree
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=4;   -- Manchurian Aralia
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=5;   -- Sakhalin Spikenard
UPDATE herbal.herbs SET temperature='neutral',  moisture='moistening',tone='neutral'  WHERE id=6;   -- Chickpea
UPDATE herbal.herbs SET temperature='neutral',  moisture='moistening',tone='toning'   WHERE id=7;   -- Dang Shen
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='toning'   WHERE id=8;   -- Asian Devil's Club
UPDATE herbal.herbs SET temperature='neutral',  moisture='neutral',   tone='toning'   WHERE id=9;   -- Siberian Ginseng
UPDATE herbal.herbs SET temperature='neutral',  moisture='neutral',   tone='toning'   WHERE id=10;  -- Hardy Rubber Tree
UPDATE herbal.herbs SET temperature='neutral',  moisture='neutral',   tone='toning'   WHERE id=11;  -- Reishi Mushroom
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='toning'   WHERE id=12;  -- Maral Root
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='relaxing' WHERE id=13;  -- Holy Basil
UPDATE herbal.herbs SET temperature='warming',  moisture='moistening',tone='toning'   WHERE id=14;  -- Korean Ginseng
UPDATE herbal.herbs SET temperature='neutral',  moisture='moistening',tone='toning'   WHERE id=15;  -- American Ginseng
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='toning'   WHERE id=16;  -- Rhodiola
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='toning'   WHERE id=17;  -- Schizandra
UPDATE herbal.herbs SET temperature='neutral',  moisture='neutral',   tone='toning'   WHERE id=18;  -- Guduchi
UPDATE herbal.herbs SET temperature='neutral',  moisture='neutral',   tone='toning'   WHERE id=19;  -- Arogyappacha
UPDATE herbal.herbs SET temperature='warming',  moisture='moistening',tone='toning'   WHERE id=20;  -- Ashwagandha

-- ─── Alteratives / Lymphatics ────────────────────────────────────────────────
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=21;  -- Garlic
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=22;  -- Burdock
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=23;  -- Wild Indigo
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=24;  -- Fringetree
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='relaxing' WHERE id=25;  -- Black Cohosh
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=26;  -- Echinacea
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=27;  -- Fumitory
UPDATE herbal.herbs SET temperature='cooling',  moisture='moistening',tone='neutral'  WHERE id=28;  -- Cleavers
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=29;  -- Guaiacum
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='toning'   WHERE id=30;  -- Goldenseal
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=31;  -- Blue Flag
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=32;  -- Chaparral
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=33;  -- Oregon Grape
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=34;  -- Bogbean
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=35;  -- Poke
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='relaxing' WHERE id=36;  -- Pasqueflower
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=37;  -- Yellow Dock
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=38;  -- Bloodroot
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=39;  -- Figwort
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=40;  -- Sarsaparilla
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=41;  -- Queen's Delight
UPDATE herbal.herbs SET temperature='cooling',  moisture='moistening',tone='neutral'  WHERE id=42;  -- Red Clover
UPDATE herbal.herbs SET temperature='neutral',  moisture='drying',    tone='toning'   WHERE id=43;  -- Nettles

-- ─── Upper Respiratory / Anticatarrhal ────────────────────────────────────────
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='toning'   WHERE id=44;  -- Yarrow
UPDATE herbal.herbs SET temperature='cooling',  moisture='moistening',tone='relaxing' WHERE id=45;  -- Marshmallow
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='toning'   WHERE id=46;  -- Bearberry
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=47;  -- Cayenne
UPDATE herbal.herbs SET temperature='neutral',  moisture='moistening',tone='toning'   WHERE id=48;  -- Iceland Moss
UPDATE herbal.herbs SET temperature='cooling',  moisture='moistening',tone='neutral'  WHERE id=49;  -- Irish Moss
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=50;  -- Boneset
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='toning'   WHERE id=51;  -- Eyebright
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='toning'   WHERE id=52;  -- Cranesbill
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=53;  -- Hyssop
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=54;  -- Elecampane
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='relaxing' WHERE id=55;  -- Peppermint
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='toning'   WHERE id=56;  -- Sage
UPDATE herbal.herbs SET temperature='cooling',  moisture='neutral',   tone='neutral'  WHERE id=57;  -- Elder
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='toning'   WHERE id=58;  -- Goldenrod
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=59;  -- Thyme
UPDATE herbal.herbs SET temperature='warming',  moisture='moistening',tone='neutral'  WHERE id=60;  -- Coltsfoot
UPDATE herbal.herbs SET temperature='neutral',  moisture='moistening',tone='neutral'  WHERE id=61;  -- Mullein

-- ─── Musculoskeletal / Anti-inflammatory ─────────────────────────────────────
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='toning'   WHERE id=62;  -- Horse Chestnut
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='toning'   WHERE id=63;  -- Lady's Mantle (arvensis)
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='relaxing' WHERE id=64;  -- Dill
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='relaxing' WHERE id=65;  -- Angelica
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=66;  -- Celery Seed
UPDATE herbal.herbs SET temperature='warming',  moisture='neutral',   tone='relaxing' WHERE id=67;  -- Pleurisy Root
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=68;  -- Birch
UPDATE herbal.herbs SET temperature='cooling',  moisture='moistening',tone='neutral'  WHERE id=69;  -- Borage
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=70;  -- Calendula
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='toning'   WHERE id=71;  -- Shepherd's Purse
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='relaxing' WHERE id=72;  -- Blue Cohosh
UPDATE herbal.herbs SET temperature='neutral',  moisture='neutral',   tone='toning'   WHERE id=73;  -- Hawthorn
UPDATE herbal.herbs SET temperature='warming',  moisture='neutral',   tone='relaxing' WHERE id=74;  -- Wild Yam
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=75;  -- Meadowsweet
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='relaxing' WHERE id=76;  -- Fennel
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=77;  -- Wintergreen
UPDATE herbal.herbs SET temperature='neutral',  moisture='moistening',tone='relaxing' WHERE id=78;  -- Licorice
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='toning'   WHERE id=79;  -- Witch Hazel
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=80;  -- Devil's Claw
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='relaxing' WHERE id=81;  -- St. John's Wort
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='relaxing' WHERE id=82;  -- Lavender
UPDATE herbal.herbs SET temperature='cooling',  moisture='moistening',tone='relaxing' WHERE id=83;  -- Mallow
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='relaxing' WHERE id=84;  -- Chamomile
UPDATE herbal.herbs SET temperature='cooling',  moisture='moistening',tone='toning'   WHERE id=85;  -- Plantain
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=86;  -- Aspen
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=87;  -- Willow
UPDATE herbal.herbs SET temperature='cooling',  moisture='moistening',tone='neutral'  WHERE id=88;  -- Chickweed
UPDATE herbal.herbs SET temperature='cooling',  moisture='moistening',tone='neutral'  WHERE id=89;  -- Comfrey
UPDATE herbal.herbs SET temperature='cooling',  moisture='moistening',tone='relaxing' WHERE id=90;  -- Linden
UPDATE herbal.herbs SET temperature='warming',  moisture='moistening',tone='neutral'  WHERE id=91;  -- Fenugreek
UPDATE herbal.herbs SET temperature='neutral',  moisture='moistening',tone='neutral'  WHERE id=92;  -- Slippery Elm
UPDATE herbal.herbs SET temperature='neutral',  moisture='neutral',   tone='relaxing' WHERE id=93;  -- Cramp Bark
UPDATE herbal.herbs SET temperature='neutral',  moisture='neutral',   tone='relaxing' WHERE id=94;  -- Black Haw
UPDATE herbal.herbs SET temperature='cooling',  moisture='moistening',tone='neutral'  WHERE id=95;  -- Corn Silk

-- ─── Warming Aromatics / Bitters / Carminatives ───────────────────────────────
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=96;  -- Southernwood
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=97;  -- Wormwood
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='relaxing' WHERE id=98;  -- Caraway
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=99;  -- Myrrh
UPDATE herbal.herbs SET temperature='neutral',  moisture='drying',    tone='relaxing' WHERE id=100; -- Coriander
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=101; -- Eucalyptus
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=102; -- Gentian
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=103; -- Juniper
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=104; -- Osha
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=105; -- Balsam of Peru
UPDATE herbal.herbs SET temperature='neutral',  moisture='moistening',tone='neutral'  WHERE id=106; -- Olive
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='relaxing' WHERE id=107; -- Marjoram
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='relaxing' WHERE id=108; -- Aniseed
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='toning'   WHERE id=109; -- Rosemary
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='relaxing' WHERE id=110; -- Rue
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=111; -- Clove
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=112; -- Usnea
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=113; -- Horseradish
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=114; -- Arnica
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='relaxing' WHERE id=115; -- Mugwort
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=116; -- Mustard
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=117; -- Gravel Root
UPDATE herbal.herbs SET temperature='cooling',  moisture='moistening',tone='neutral'  WHERE id=118; -- Kelp
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='toning'   WHERE id=119; -- Bayberry
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=120; -- Parsley
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=121; -- Feverfew
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=122; -- Dandelion
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=123; -- Prickly Ash
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='relaxing' WHERE id=124; -- Ginger
UPDATE herbal.herbs SET temperature='neutral',  moisture='drying',    tone='neutral'  WHERE id=125; -- Wild Carrot
UPDATE herbal.herbs SET temperature='neutral',  moisture='moistening',tone='neutral'  WHERE id=126; -- Sundew
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='relaxing' WHERE id=127; -- Cardamom

-- ─── Nervines / Sedatives ─────────────────────────────────────────────────────
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='relaxing' WHERE id=128; -- California Poppy
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='relaxing' WHERE id=129; -- Hops
UPDATE herbal.herbs SET temperature='cooling',  moisture='moistening',tone='relaxing' WHERE id=130; -- Wild Lettuce
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='relaxing' WHERE id=131; -- Motherwort
UPDATE herbal.herbs SET temperature='neutral',  moisture='drying',    tone='relaxing' WHERE id=132; -- Lobelia
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=133; -- Bugleweed
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='relaxing' WHERE id=134; -- Lemon Balm
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='relaxing' WHERE id=135; -- Pennyroyal
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='relaxing' WHERE id=136; -- Catnip
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='relaxing' WHERE id=137; -- Passionflower
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='relaxing' WHERE id=138; -- Kava
UPDATE herbal.herbs SET temperature='neutral',  moisture='drying',    tone='relaxing' WHERE id=139; -- Jamaica Dogwood
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='relaxing' WHERE id=140; -- Wild Cherry Bark
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='toning'   WHERE id=141; -- Red Sage
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='relaxing' WHERE id=142; -- Skullcap
UPDATE herbal.herbs SET temperature='warming',  moisture='neutral',   tone='relaxing' WHERE id=143; -- Skunk Cabbage
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='relaxing' WHERE id=144; -- Damiana
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='relaxing' WHERE id=145; -- Valerian
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='relaxing' WHERE id=146; -- Vervain

-- ─── Astringents / Tannin-rich ────────────────────────────────────────────────
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='toning'   WHERE id=147; -- Black Catechu
UPDATE herbal.herbs SET temperature='neutral',  moisture='drying',    tone='toning'   WHERE id=148; -- Agrimony
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='toning'   WHERE id=149; -- Tea
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=150; -- Kola
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='toning'   WHERE id=151; -- Horsetail
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='toning'   WHERE id=152; -- Bistort
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='toning'   WHERE id=153; -- Oak
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=154; -- Rhubarb
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='toning'   WHERE id=155; -- Raspberry
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='toning'   WHERE id=156; -- Blackberry
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='toning'   WHERE id=157; -- Periwinkle
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=158; -- Barberry
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=159; -- Centaury
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=160; -- Horehound
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=161; -- Tansy

-- ─── Cardiovascular ───────────────────────────────────────────────────────────
UPDATE herbal.herbs SET temperature='neutral',  moisture='neutral',   tone='neutral'  WHERE id=162; -- Coleus
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=163; -- Lily of the Valley
UPDATE herbal.herbs SET temperature='neutral',  moisture='drying',    tone='neutral'  WHERE id=164; -- Scotch Broom
UPDATE herbal.herbs SET temperature='neutral',  moisture='drying',    tone='neutral'  WHERE id=165; -- Ginkgo
UPDATE herbal.herbs SET temperature='neutral',  moisture='drying',    tone='neutral'  WHERE id=166; -- Squill
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='toning'   WHERE id=167; -- Cinnamon

-- ─── Hepatics / Cholagogues ───────────────────────────────────────────────────
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=170; -- Celandine
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=171; -- Balmony
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=172; -- Artichoke
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=173; -- Wahoo
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=174; -- Butternut
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=175; -- Black Root
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=176; -- Boldo
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=177; -- Dandelion Root

-- ─── Demulcents / Nutritives ──────────────────────────────────────────────────
UPDATE herbal.herbs SET temperature='neutral',  moisture='moistening',tone='relaxing' WHERE id=178; -- Oat
UPDATE herbal.herbs SET temperature='cooling',  moisture='moistening',tone='neutral'  WHERE id=179; -- Couch Grass
UPDATE herbal.herbs SET temperature='neutral',  moisture='moistening',tone='neutral'  WHERE id=180; -- Flax

-- ─── Urinary ─────────────────────────────────────────────────────────────────
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=181; -- Buchu
UPDATE herbal.herbs SET temperature='neutral',  moisture='drying',    tone='toning'   WHERE id=182; -- Stoneroot
UPDATE herbal.herbs SET temperature='neutral',  moisture='moistening',tone='neutral'  WHERE id=183; -- Pumpkin
UPDATE herbal.herbs SET temperature='neutral',  moisture='drying',    tone='neutral'  WHERE id=184; -- Sea Holly
UPDATE herbal.herbs SET temperature='neutral',  moisture='moistening',tone='neutral'  WHERE id=185; -- Pellitory of the Wall
UPDATE herbal.herbs SET temperature='warming',  moisture='moistening',tone='toning'   WHERE id=186; -- Saw Palmetto
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=187; -- Condurango

-- ─── Reproductive ────────────────────────────────────────────────────────────
UPDATE herbal.herbs SET temperature='neutral',  moisture='drying',    tone='toning'   WHERE id=188; -- Partridgeberry
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=189; -- Nasturtium
UPDATE herbal.herbs SET temperature='neutral',  moisture='neutral',   tone='toning'   WHERE id=190; -- Chasteberry

-- ─── Expectorants / Lower Respiratory ────────────────────────────────────────
UPDATE herbal.herbs SET temperature='neutral',  moisture='drying',    tone='neutral'  WHERE id=191; -- English Daisy
UPDATE herbal.herbs SET temperature='neutral',  moisture='moistening',tone='neutral'  WHERE id=192; -- Ipecac
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='toning'   WHERE id=193; -- Mouse Ear
UPDATE herbal.herbs SET temperature='warming',  moisture='moistening',tone='neutral'  WHERE id=194; -- Tolu Balsam
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=195; -- Seneca Snakeroot
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=196; -- Balm of Gilead
UPDATE herbal.herbs SET temperature='neutral',  moisture='moistening',tone='neutral'  WHERE id=197; -- Cowslip
UPDATE herbal.herbs SET temperature='cooling',  moisture='moistening',tone='relaxing' WHERE id=198; -- Violet
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=199; -- Gumweed
UPDATE herbal.herbs SET temperature='neutral',  moisture='moistening',tone='neutral'  WHERE id=200; -- Lungwort
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=201; -- Thuja

-- ─── GI / Liver / Skin ───────────────────────────────────────────────────────
UPDATE herbal.herbs SET temperature='cooling',  moisture='moistening',tone='neutral'  WHERE id=202; -- Aloe
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=203; -- Turmeric
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=204; -- Buckthorn
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=205; -- Cascara Sagrada
UPDATE herbal.herbs SET temperature='cooling',  moisture='moistening',tone='neutral'  WHERE id=206; -- Milk Thistle
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='relaxing' WHERE id=207; -- Wood Betony
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=208; -- Onion
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='toning'   WHERE id=210; -- Buckwheat
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=211; -- Mistletoe
UPDATE herbal.herbs SET temperature='neutral',  moisture='drying',    tone='relaxing' WHERE id=212; -- Black Horehound
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='relaxing' WHERE id=213; -- Roman Chamomile
UPDATE herbal.herbs SET temperature='warming',  moisture='moistening',tone='toning'   WHERE id=215; -- Ginseng (Panax spp.)
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=216; -- Senna
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=217; -- Coffee
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=218; -- Guarana
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='toning'   WHERE id=219; -- Lady's Mantle (spp.)
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='toning'   WHERE id=220; -- Rhatany
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=221; -- Narrow-Leaf Echinacea
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=222; -- Phyllanthus
UPDATE herbal.herbs SET temperature='cooling',  moisture='moistening',tone='neutral'  WHERE id=223; -- Rehmannia
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=224; -- Bupleurum
UPDATE herbal.herbs SET temperature='warming',  moisture='moistening',tone='toning'   WHERE id=225; -- Astragalus
UPDATE herbal.herbs SET temperature='neutral',  moisture='neutral',   tone='toning'   WHERE id=226; -- Shiitake
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=227; -- Kutki
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='toning'   WHERE id=228; -- Pilewort

-- ─── Additional herbs added via later migrations ──────────────────────────────
UPDATE herbal.herbs SET temperature='neutral',  moisture='moistening',tone='toning'   WHERE id=271; -- Codonopsis tangshen
UPDATE herbal.herbs SET temperature='cooling',  moisture='moistening',tone='toning'   WHERE id=274; -- Privet (Ligustrum)
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=288; -- Black Walnut
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=291; -- Pau D'arco
UPDATE herbal.herbs SET temperature='cooling',  moisture='moistening',tone='neutral'  WHERE id=296; -- Hydrangea
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=302; -- Tea Tree
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='toning'   WHERE id=309; -- Yerba Mansa
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=313; -- Sassafras
UPDATE herbal.herbs SET temperature='cooling',  moisture='moistening',tone='relaxing' WHERE id=320; -- Peach
UPDATE herbal.herbs SET temperature='neutral',  moisture='drying',    tone='relaxing' WHERE id=338; -- Pill-Bearing Spurge
UPDATE herbal.herbs SET temperature='cooling',  moisture='moistening',tone='relaxing' WHERE id=340; -- Poppy
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=406; -- Oregano
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='relaxing' WHERE id=407; -- Bergamot
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='relaxing' WHERE id=410; -- Asian Mint
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=412; -- Dwarf Pine
UPDATE herbal.herbs SET temperature='cooling',  moisture='moistening',tone='neutral'  WHERE id=413; -- Sandalwood
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=414; -- Benzoin
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='relaxing' WHERE id=420; -- Basil
UPDATE herbal.herbs SET temperature='neutral',  moisture='moistening',tone='neutral'  WHERE id=441; -- Butterwort
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=448; -- Ma Huang
UPDATE herbal.herbs SET temperature='warming',  moisture='neutral',   tone='relaxing' WHERE id=450; -- Khella
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=469; -- Scots Pine
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=473; -- Onion and Garlic
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=535; -- Lemon
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='toning'   WHERE id=570; -- Cypress
UPDATE herbal.herbs SET temperature='warming',  moisture='neutral',   tone='neutral'  WHERE id=579; -- California Spikenard
UPDATE herbal.herbs SET temperature='cooling',  moisture='neutral',   tone='neutral'  WHERE id=583; -- Elderflower
UPDATE herbal.herbs SET temperature='warming',  moisture='moistening',tone='neutral'  WHERE id=586; -- Western Coltsfoot
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=590; -- Yerba Santa
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='toning'   WHERE id=591; -- Devil's Club
UPDATE herbal.herbs SET temperature='neutral',  moisture='moistening',tone='relaxing' WHERE id=593; -- False Solomon's Seal
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=615; -- Kola Nut
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=617; -- Yerba Mate
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='relaxing' WHERE id=645; -- Yellow Jasmine
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=657; -- Grindelia spp.
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='relaxing' WHERE id=742; -- Neroli
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='relaxing' WHERE id=743; -- Clary Sage
UPDATE herbal.herbs SET temperature='neutral',  moisture='neutral',   tone='relaxing' WHERE id=745; -- Ylang Ylang
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='relaxing' WHERE id=748; -- Sweet Orange
UPDATE herbal.herbs SET temperature='cooling',  moisture='neutral',   tone='neutral'  WHERE id=831; -- Helichrysum
UPDATE herbal.herbs SET temperature='cooling',  moisture='moistening',tone='neutral'  WHERE id=849; -- Rosehips
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='toning'   WHERE id=850; -- Rose
UPDATE herbal.herbs SET temperature='warming',  moisture='moistening',tone='toning'   WHERE id=851; -- Maca
UPDATE herbal.herbs SET temperature='cooling',  moisture='moistening',tone='relaxing' WHERE id=852; -- Shatavari
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='relaxing' WHERE id=853; -- Silk Tassel
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=858; -- Bugleweed (europaeus)
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='neutral'  WHERE id=877; -- Guggul
UPDATE herbal.herbs SET temperature='cooling',  moisture='moistening',tone='toning'   WHERE id=882; -- Indian Gooseberry
UPDATE herbal.herbs SET temperature='neutral',  moisture='moistening',tone='neutral'  WHERE id=885; -- Alfalfa
UPDATE herbal.herbs SET temperature='warming',  moisture='drying',    tone='relaxing' WHERE id=892; -- Wood Betony (Stachys betonica)
UPDATE herbal.herbs SET temperature='cooling',  moisture='drying',    tone='neutral'  WHERE id=956; -- Dan Shen

DO $$ BEGIN RAISE NOTICE 'Herb energetics assigned successfully.'; END $$;
