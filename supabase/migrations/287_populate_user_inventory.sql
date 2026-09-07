-- Populate user_inventory from Obsidian herbal instance notes
-- User: 6db84040-0e08-4588-8351-ceb0bb4d7bd9
-- 126 herbs inserted; unmatched items listed as comments below

INSERT INTO herbal.user_inventory (user_id, herb_id, in_stock, notes) VALUES
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 9, true, E'0.25 cup - powder - Location: kitchen/cube-shelf/basket/c\n1 cup - dry - Location: kitchen/runner/basket/b\n1 ounce - root - Location: kitchen/narrow-space\n4 ounce - dry - Location: storage/clear-bins\n4 ounce - root - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 11, true, E'1 cup - dry - Location: kitchen/runner/basket/a\n1 ounce - tincture - Location: kitchen/runner'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 13, true, E'1 ounce - tincture - Location: kitchen/desk\n16 ounce - tincture - Location: kitchen/tincture-cabinet\n2 cup - dry - Location: kitchen/cube-shelf/basket/a\n4 cup - dry - Location: storage/clear-bins\n4 cup - tincture - Location: kitchen/runner/underneath\n8 cup - dry - Location: kitchen/rolling-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 16, true, E'1 ounce - tincture - Location: kitchen/narrow-space\n2 cup - dry - Location: storage/clear-bins'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 17, true, E'1 cup - dry - Location: kitchen/runner/basket/a\n1 ounce - tincture - Location: kitchen/narrow-space\n4 ounce - tincture - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 20, true, E'0.25 cup - honey - Location: kitchen/runner\n0.5 cup - dry - Location: kitchen/cube-shelf/basket/b\n1 ounce - tincture - Location: kitchen/narrow-space\n2 ounce - tincture - Location: kitchen/narrow-space\n4 cup - dry - Location: kitchen/rolling-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 22, true, E'16 ounce - tincture - Location: kitchen/tincture-cabinet\n2 cup - dry - Location: kitchen/cube-shelf/basket/b\n2 cup - dry - Location: kitchen/cube-shelf/basket/b\n2 cup - dry - Location: kitchen/rolling-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 25, true, E'4 ounce - powder - Location: storage/clear-bins'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 26, true, E'0.5 ounce - glycerite - Location: kitchen/narrow-space\n1 cup - dry - Location: kitchen/cube-shelf/basket/c\n1 ounce - tincture - Location: kitchen/narrow-space\n1 ounce - tincture - Location: kitchen/narrow-space\n4 ounce - powder - Location: storage/clear-bins\n4 ounce - tincture - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 28, true, E'1 ounce - tincture - Location: kitchen/narrow-space\n1 ounce - whole - Location: kitchen/narrow-space\n16 ounce - whole - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 30, true, E'0.25 cup - powder - Location: kitchen/cube-shelf/basket/c'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 32, true, E'0.25 cup - powder - Location: kitchen/cube-shelf/basket/b\n1 ounce - essence - Location: kitchen/narrow-space\n4 cup - leaf - Location: kitchen/rolling-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 33, true, E'0.25 cup - dry - Location: kitchen/cube-shelf/basket/d\n4 ounce - dry - Location: storage/clear-bins\n4 ounce - dry - Location: storage/clear-bins\n4 ounce - tincture - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 36, true, E'1 ounce - tincture - Location: kitchen/narrow-space'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 38, true, E'0.25 cup - powder - Location: kitchen/cube-shelf/basket/b'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 39, true, E'4 ounce - tincture - Location: kitchen/tincture-cabinet\n8 cup - dry - Location: kitchen/rolling-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 43, true, E'0.33 cup - powder - Location: kitchen/cube-shelf/basket/d\n0.5 ounce - tincture - Location: kitchen/narrow-space\n0.5 ounce - tincture - Location: kitchen/narrow-space\n1 ounce - tincture - Location: kitchen/narrow-space\n1 ounce - tincture - Location: kitchen/narrow-space\n2 cup - powder - Location: kitchen/runner/basket/d\n8 cup - dry - Location: kitchen/rolling-cabinet\n8 ounce - tincture - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 44, true, E'0.5 cup - dry - Location: kitchen/runner/basket/a\n0.5 ounce - essence - Location: kitchen/narrow-space\n0.5 ounce - essential-oil - Location: kitchen/desk/underneath\n1 ounce - tincture - Location: kitchen/narrow-space\n1 ounce - tincture - Location: kitchen/narrow-space\n16 ounce - tincture - Location: kitchen/tincture-cabinet\n2 ounce - spray - Location: kitchen/narrow-space\n4 cup - dry - Location: kitchen/rolling-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 45, true, E'0.5 ounce - tincture - Location: kitchen/narrow-space\n1 cup - dry - Location: kitchen/cube-shelf/basket/d\n2 cup - powder - Location: storage/clear-bins\n3 cup - dry - Location: kitchen/atrium-corner\n4 cup - dry - Location: kitchen/rolling-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 46, true, E'1 ounce - whole - Location: storage/clear-bins'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 53, true, E'0.5 ounce - essential-oil - Location: kitchen/desk/underneath\n16 ounce - tincture - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 55, true, E'0.5 ounce - essential-oil - Location: kitchen/desk/underneath\n0.5 ounce - essential-oil - Location: kitchen/desk/underneath\n4 ounce - essential-oil - Location: kitchen/desk/underneath'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 56, true, E'0.25 ounce - essence - Location: kitchen/narrow-space\n1 cup - dry - Location: kitchen/cube-shelf/basket/c\n1 ounce - essence - Location: kitchen/narrow-space\n1 ounce - essential-oil - Location: kitchen/desk/underneath\n2 ounce - spray - Location: kitchen/wall-bookshelf\n2 ounce - tincture - Location: kitchen/narrow-space\n3 cup - whole - Location: storage/clear-bins\n4 ounce - tincture - Location: kitchen/tincture-cabinet\n4 ounce - tincture - Location: kitchen/tincture-cabinet\n4 ounce - tincture - Location: kitchen/tincture-cabinet\n8 cup - dry - Location: kitchen/rolling-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 57, true, E'1 ounce - tincture - Location: kitchen/narrow-space\n2 cup - dry - Location: kitchen/rolling-cabinet\n4 cup - tincture - Location: kitchen/island\n4 ounce - tincture - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 59, true, E'0.5 ounce - powder - Location: kitchen/side-bookshelf/basket/e\n1 ounce - essential-oil - Location: kitchen/desk/underneath\n2 cup - dry - Location: kitchen/runner/basket/b'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 61, true, E'0.5 cup - dry - Location: kitchen/cube-shelf/basket/d\n1 ounce - tincture - Location: kitchen/narrow-space'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 65, true, E'1 ounce - dry - Location: storage/clear-bins\n1 ounce - tincture - Location: kitchen/narrow-space\n16 ounce - tincture - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 70, true, E'1 cup - dry - Location: kitchen/cube-shelf/basket/b\n1 ounce - glycerite - Location: kitchen/narrow-space\n1 ounce - salve - Location: kitchen/desk/underneath\n1 ounce - tincture - Location: kitchen/desk\n2 ounce - oil - Location: kitchen/desk\n2 ounce - oil - Location: kitchen/desk/underneath\n4 ounce - glycerite - Location: kitchen/tincture-cabinet\n64 ounce - tincture - Location: kitchen/island\n8 ounce - oil - Location: kitchen/tincture-cabinet\n8 ounce - tincture - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 73, true, E'1 cup - dry - Location: kitchen/cube-shelf/basket/c\n1 cup - dry - Location: kitchen/cube-shelf/basket/c\n1 cup - dry - Location: kitchen/cube-shelf/basket/c\n1 ounce - tincture - Location: kitchen/narrow-space\n1 ounce - tincture - Location: kitchen/narrow-space\n8 ounce - tincture - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 74, true, E'2 cup - dry - Location: storage/clear-bins'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 75, true, E'1 cup - dry - Location: kitchen/cube-shelf/basket/d\n6 cup - dry - Location: kitchen/atrium-corner'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 76, true, E'1 ounce - tincture - Location: kitchen/narrow-space'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 78, true, E'1 ounce - glycerite - Location: kitchen/narrow-space\n2 ounce - glycerite - Location: kitchen/narrow-space\n4 cup - dry - Location: kitchen/rolling-cabinet\n4 ounce - glycerite - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 81, true, E'0.5 ounce - oil - Location: kitchen/desk\n16 ounce - oil - Location: kitchen/rolling-cabinet\n16 ounce - tincture - Location: kitchen/tincture-cabinet\n2 ounce - salve - Location: kitchen/desk\n4 ounce - oil - Location: kitchen/desk/underneath\n4 ounce - tincture - Location: kitchen/tincture-cabinet\n8 ounce - oil - Location: kitchen/tincture-cabinet\n8 ounce - oil - Location: kitchen/tincture-cabinet\n8 ounce - tincture - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 82, true, E'0.33 ounce - essential-oil - Location: bag\n0.33 ounce - essential-oil - Location: kitchen/desk/underneath\n0.33 ounce - essential-oil - Location: kitchen/desk/underneath\n0.33 ounce - essential-oil - Location: kitchen/desk/underneath\n1 ounce - essence - Location: kitchen/narrow-space\n1 ounce - essential-oil - Location: kitchen/desk/underneath\n1 ounce - essential-oil - Location: kitchen/desk/underneath\n8 cup - dry - Location: kitchen/rolling-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 84, true, E'1 ounce - tincture - Location: kitchen/narrow-space\n4 ounce - tincture - Location: kitchen/narrow-space\n4 ounce - tincture - Location: kitchen/tincture-cabinet\n6 cup - dry - Location: kitchen/rolling-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 85, true, E'1 cup - dry - Location: kitchen/cube-shelf/basket/d\n4 ounce - tincture - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 86, true, E'0.5 ounce - essence - Location: kitchen/narrow-space'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 87, true, E'1 ounce - dry - Location: kitchen/runner/basket/b\n2 cup - dry - Location: storage/clear-bins'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 88, true, E'4 ounce - powder - Location: storage/clear-bins'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 90, true, E'1 cup - dry - Location: kitchen/cube-shelf/basket/c\n1 ounce - glycerite - Location: kitchen/narrow-space\n1 ounce - tincture - Location: kitchen/narrow-space\n2 cup - dry - Location: storage/clear-bins\n4 cup - leaf - Location: kitchen/rolling-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 91, true, E'4 ounce - powder - Location: storage/clear-bins'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 92, true, E'4 cup - powder - Location: storage/blue-bin'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 99, true, E'0.25 cup - whole - Location: kitchen/cube-shelf/cloth-basket/b\n0.33 ounce - essential-oil - Location: kitchen/desk/underneath\n0.5 ounce - essential-oil - Location: kitchen/desk/underneath\n2 cup - resin - Location: kitchen/runner/basket/c\n4 ounce - resin - Location: kitchen/runner'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 100, true, E'2 cup - dry - Location: kitchen/atrium-corner\n4 cup - whole - Location: storage/clear-bins'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 101, true, E'0.5 ounce - essential-oil - Location: kitchen/desk/underneath\n0.5 ounce - essential-oil - Location: kitchen/desk/underneath'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 103, true, E'16 ounce - tincture - Location: kitchen/tincture-cabinet\n2 cup - dry - Location: kitchen/cube-shelf/basket/c'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 106, true, E'2 ounce - spray - Location: kitchen/desk/underneath'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 109, true, E'0.5 ounce - essential-oil - Location: kitchen/desk/underneath\n1 ounce - tincture - Location: kitchen/narrow-space\n1 ounce - tincture - Location: kitchen/narrow-space\n16 ounce - tincture - Location: kitchen/tincture-cabinet\n2 cup - dry - Location: kitchen/runner/basket/a\n2 ounce - tincture - Location: kitchen/narrow-space\n4 ounce - tincture - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 110, true, E'0.5 ounce - essential-oil - Location: kitchen/desk/underneath'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 111, true, E'2 ounce - essential-oil - Location: kitchen/desk/underneath'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 114, true, E'1 cup - oil - Location: kitchen/runner/basket/d\n2 ounce - salve - Location: kitchen/desk\n4 ounce - whole - Location: storage/clear-bins'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 115, true, E'0.5 cup - dry - Location: kitchen/cube-shelf/basket/d\n0.5 ounce - essential-oil - Location: kitchen/desk/underneath\n1 cup - dry - Location: kitchen/cube-shelf/cloth-basket/b\n1 ounce - tincture - Location: kitchen/narrow-space\n16 ounce - tincture - Location: kitchen/tincture-cabinet\n4 cup - dry - Location: kitchen/rolling-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 116, true, E'0.5 ounce - essence - Location: kitchen/narrow-space\n2 cup - dry - Location: storage/clear-bins\n2 cup - dry - Location: storage/clear-bins'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 122, true, E'4 cup - dry - Location: kitchen/rolling-cabinet\n6 cup - dry - Location: storage/blue-bin'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 123, true, E'16 ounce - tincture - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 124, true, E'1 ounce - tincture - Location: bag\n2 cup - dry - Location: storage/blue-bin\n8 ounce - tincture - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 127, true, E'1 cup - dry - Location: kitchen/cube-shelf/basket/b'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 128, true, E'0.5 ounce - tincture - Location: bag\n1 ounce - tincture - Location: kitchen/narrow-space\n16 ounce - tincture - Location: kitchen/tincture-cabinet\n16 ounce - tincture - Location: kitchen/tincture-cabinet\n2 cup - dry - Location: kitchen/cube-shelf/basket/b\n4 ounce - tincture - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 129, true, E'1 cup - dry - Location: kitchen/cube-shelf/basket/c'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 130, true, E'1 ounce - tincture - Location: kitchen/narrow-space\n1 ounce - tincture - Location: kitchen/narrow-space\n2 ounce - tincture - Location: kitchen/narrow-space\n8 ounce - tincture - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 131, true, E'1 cup - dry - Location: kitchen/cube-shelf/basket/d\n2 ounce - tincture - Location: kitchen/narrow-space\n4 ounce - tincture - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 132, true, E'2 cup - dry - Location: kitchen/cube-shelf/basket/c'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 134, true, E'0.5 ounce - essential-oil - Location: kitchen/desk/underneath\n0.5 ounce - tincture - Location: bag\n0.5 ounce - tincture - Location: kitchen/desk\n0.5 ounce - tincture - Location: kitchen/narrow-space\n0.5 ounce - tincture - Location: kitchen/narrow-space\n1 cup - dry - Location: kitchen/cube-shelf/basket/c\n1 ounce - glycerite - Location: kitchen/narrow-space\n1 ounce - tincture - Location: kitchen/narrow-space\n1 ounce - tincture - Location: kitchen/narrow-space\n2 cup - dry - Location: kitchen/cube-shelf/basket/c\n4 ounce - tincture - Location: kitchen/tincture-cabinet\n4 ounce - tincture - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 136, true, E'0.33 ounce - tincture - Location: bag\n1 cup - dry - Location: kitchen/cube-shelf/basket/b\n2 ounce - tincture - Location: kitchen/narrow-space\n2 ounce - tincture - Location: kitchen/narrow-space\n8 ounce - tincture - Location: kitchen/tincture-cabinet\n8 ounce - tincture - Location: kitchen/tincture-cabinet\n8 ounce - tincture - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 137, true, E'1 cup - dry - Location: kitchen/cube-shelf/basket/d\n1 ounce - tincture - Location: kitchen/narrow-space\n4 ounce - dry - Location: storage/clear-bins\n8 ounce - tincture - Location: kitchen/tincture-cabinet\n8 ounce - tincture - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 138, true, E'0.25 cup - dry - Location: kitchen/cube-shelf/basket/c\n2 cup - powder - Location: storage/clear-bins'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 140, true, E'1 cup - honey - Location: kitchen/pantry\n8 ounce - tincture - Location: kitchen/tincture-cabinet\n8 ounce - tincture - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 142, true, E'0.5 ounce - tincture - Location: kitchen/narrow-space\n1 ounce - tincture - Location: bag\n1 ounce - tincture - Location: kitchen/narrow-space\n1 ounce - tincture - Location: kitchen/narrow-space\n16 ounce - tincture - Location: kitchen/tincture-cabinet\n16 ounce - tincture - Location: kitchen/tincture-cabinet\n2 ounce - tincture - Location: kitchen/narrow-space\n4 ounce - tincture - Location: kitchen/tincture-cabinet\n8 ounce - tincture - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 144, true, E'1 cup - tincture - Location: kitchen/runner/underneath'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 145, true, E'0.25 cup - dry - Location: kitchen/runner/basket/b\n2 ounce - tincture - Location: kitchen/narrow-space\n4 cup - tincture - Location: kitchen/runner/underneath'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 146, true, E'0.5 ounce - powder - Location: kitchen/side-bookshelf/basket/e'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 148, true, E'1 ounce - tincture - Location: kitchen/narrow-space\n16 ounce - tincture - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 149, true, E'1 cup - dry - Location: kitchen/cube-shelf/basket/a\n1 ounce - dry - Location: kitchen/cube-shelf/basket/c\n2 cup - dry - Location: kitchen/cube-shelf/basket/a\n2 cup - dry - Location: kitchen/cube-shelf/basket/a\n2 cup - dry - Location: kitchen/cube-shelf/basket/a\n2 cup - dry - Location: kitchen/cube-shelf/basket/a'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 151, true, E'3 cup - dry - Location: storage/clear-bins'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 153, true, E'0.5 ounce - essence - Location: kitchen/narrow-space'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 167, true, E'0.33 ounce - essential-oil - Location: kitchen/desk/underneath\n0.5 ounce - essential-oil - Location: kitchen/desk/underneath\n1 cup - dry - Location: kitchen/cube-shelf/cloth-basket/a\n3 cup - dry - Location: kitchen/atrium-corner\n4 cup - dry - Location: storage/blue-bin\n8 ounce - tincture - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 178, true, E'0.5 ounce - essence - Location: kitchen/narrow-space\n1 ounce - tincture - Location: kitchen/narrow-space\n4 cup - tincture - Location: kitchen/island\n4 ounce - tincture - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 182, true, E'1 ounce - tincture - Location: kitchen/narrow-space'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 186, true, E'2 cup - powder - Location: kitchen/runner/basket/a\n2 ounce - tincture - Location: kitchen/narrow-space'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 189, true, E'2 cup - dry - Location: kitchen/cube-shelf/basket/d\n32 ounce - tincture - Location: kitchen/runner/basket/d'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 196, true, E'2 ounce - oil - Location: kitchen/desk/underneath'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 206, true, E'4 cup - dry - Location: kitchen/rolling-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 207, true, E'16 ounce - tincture - Location: kitchen/tincture-cabinet\n4 ounce - dry - Location: storage/clear-bins'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 217, true, E'4 ounce - tincture - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 225, true, E'0.5 cup - root - Location: storage/clear-bins\n1 cup - powder - Location: kitchen/cube-shelf/basket/b\n4 cup - root - Location: kitchen/rolling-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 288, true, E'1 cup - powder - Location: kitchen/cube-shelf/basket/b'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 302, true, E'0.33 ounce - essential-oil - Location: kitchen/desk/underneath\n0.33 ounce - essential-oil - Location: kitchen/desk/underneath\n1 ounce - essential-oil - Location: kitchen/desk/underneath'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 309, true, E'1 ounce - tincture - Location: kitchen/narrow-space\n16 ounce - tincture - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 313, true, E'0.25 cup - dry - Location: kitchen/runner/basket/a'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 320, true, E'1 cup - dry - Location: kitchen/cube-shelf/basket/d\n1 ounce - oxymel - Location: kitchen/fridge\n1 ounce - tincture - Location: kitchen/narrow-space'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 406, true, E'1 ounce - essential-oil - Location: kitchen/desk/underneath\n2 cup - dry - Location: kitchen/cube-shelf/cloth-basket/a'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 407, true, E'1 ounce - essential-oil - Location: kitchen/desk/underneath'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 413, true, E'1 cup - powder - Location: kitchen/runner/basket/c\n1 ounce - essential-oil - Location: kitchen/desk/underneath'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 414, true, E'0.25 cup - powder - Location: kitchen/cube-shelf/cloth-basket/b'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 420, true, E'4 cup - dry - Location: kitchen/cube-shelf/cloth-basket/a'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 469, true, E'0.25 cup - powder - Location: kitchen/cube-shelf/cloth-basket/b\n1 ounce - essential-oil - Location: kitchen/desk/underneath\n2 cup - dry - Location: kitchen/runner/basket/c'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 535, true, E'0.5 ounce - essential-oil - Location: kitchen/desk/underneath\n4 ounce - tincture - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 570, true, E'1 ounce - essential-oil - Location: kitchen/desk/underneath'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 742, true, E'1 ounce - essential-oil - Location: kitchen/desk/underneath'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 743, true, E'1 ounce - essential-oil - Location: kitchen/desk/underneath\n4 ounce - essential-oil - Location: kitchen/side-bookshelf/basket/e'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 745, true, E'1 ounce - essential-oil - Location: kitchen/desk/underneath'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 748, true, E'0.25 cup - powder - Location: kitchen/cube-shelf/basket/d\n0.5 ounce - essential-oil - Location: kitchen/desk/underneath\n1 ounce - essential-oil - Location: kitchen/desk/underneath\n1 ounce - essential-oil - Location: kitchen/desk/underneath\n8 ounce - tincture - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 849, true, E'0.25 cup - dry - Location: kitchen/cube-shelf/basket/d\n0.5 cup - whole - Location: storage/clear-bins\n1 cup - dry - Location: kitchen/runner/basket/a\n1 ounce - essential-oil - Location: kitchen/desk/underneath\n1 ounce - tincture - Location: kitchen/narrow-space\n16 ounce - cordial - Location: kitchen/fridge\n2 cup - dry - Location: kitchen/rolling-cabinet\n4 cup - dry - Location: kitchen/rolling-cabinet\n4 cup - whole - Location: storage/clear-bins'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 851, true, E'4 cup - dry - Location: kitchen/rolling-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 980, true, E'0.5 cup - dry - Location: storage/clear-bins\n2 cup - dry - Location: kitchen/cube-shelf/basket/d'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 981, true, E'1 ounce - tincture - Location: kitchen/narrow-space\n4 cup - tincture - Location: kitchen/runner/underneath\n4 ounce - tincture - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 983, true, E'1 ounce - glycerite - Location: kitchen/narrow-space\n1 ounce - glycerite - Location: kitchen/narrow-space\n2 ounce - tincture - Location: kitchen/narrow-space\n4 ounce - tincture - Location: kitchen/tincture-cabinet\n8 ounce - tincture - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 1124, true, E'0.5 ounce - tincture - Location: kitchen/narrow-space'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 1160, true, E'1 ounce - tincture - Location: kitchen/desk\n4 cup - tincture - Location: kitchen/island'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 1252, true, E'0.5 ounce - tincture - Location: kitchen/narrow-space\n2 cup - whole - Location: storage/clear-bins\n4 cup - dry - Location: kitchen/rolling-cabinet\n4 ounce - tincture - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 1546, true, E'0.25 cup - powder - Location: kitchen/cube-shelf/basket/c\n0.33 ounce - essential-oil - Location: kitchen/desk/underneath'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 1572, true, E'2 ounce - tincture - Location: kitchen/narrow-space'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 1595, true, E'1 ounce - essential-oil - Location: kitchen/desk/underneath\n2 cup - whole - Location: storage/clear-bins'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 1597, true, E'0.25 cup - whole - Location: kitchen/cube-shelf/cloth-basket/b\n0.33 ounce - essential-oil - Location: kitchen/desk/underneath\n0.5 ounce - essential-oil - Location: kitchen/desk/underneath\n2 cup - resin - Location: kitchen/runner/basket/c\n2 cup - resin - Location: storage/clear-bins'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 2229, true, E'16 ounce - tincture - Location: kitchen/tincture-cabinet\n2 cup - dry - Location: kitchen/cube-shelf/basket/c\n4 cup - tincture - Location: kitchen/runner/underneath\n4 ounce - tincture - Location: kitchen/tincture-cabinet\n6 cup - dry - Location: kitchen/rolling-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 2233, true, E'1 cup - dry - Location: storage/clear-bins\n4 cup - dry - Location: kitchen/rolling-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 2241, true, E'0.25 cup - dry - Location: kitchen/cube-shelf/basket/d'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 2246, true, E'1 ounce - tincture - Location: kitchen/narrow-space\n16 ounce - tincture - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 2285, true, E'0.5 ounce - glycerite - Location: kitchen/narrow-space\n0.5 ounce - tincture - Location: kitchen/narrow-space\n1 ounce - tincture - Location: kitchen/narrow-space'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 2363, true, E'1 ounce - tincture - Location: kitchen/narrow-space\n8 ounce - tincture - Location: kitchen/tincture-cabinet\n8 ounce - tincture - Location: kitchen/tincture-cabinet'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 2381, true, E'6 cup - dry - Location: storage/blue-bin'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 2498, true, E'1 cup - powder - Location: kitchen/cube-shelf/cloth-basket/a\n2 cup - whole - Location: kitchen/cube-shelf/cloth-basket/a'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 2601, true, E'2 ounce - oil - Location: kitchen/desk/underneath'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 2605, true, E'1 cup - dry - Location: storage/clear-bins'),
  ((SELECT id FROM auth.users WHERE email = 'chad.armstrong@gmail.com'), 2624, true, E'4 ounce - tincture - Location: kitchen/narrow-space\n4 ounce - tincture - Location: kitchen/tincture-cabinet');

-- ============================================================
-- UNMATCHED: herbs not in herbal.herbs — add manually if needed
-- ============================================================
-- Amber | 1 ounce - essential-oil - Location: kitchen/desk/underneath
-- Bay | 0.25 cup - powder - Location: kitchen/cube-shelf/basket/b
-- Bee Balm | 16 ounce - tincture - Location: kitchen/tincture-cabinet
-- Bladderwrack Seaweed | 1 cup - leaf - Location: kitchen/cube-shelf/cloth-basket/a
-- Bladderwrack Seaweed | 1 ounce - tincture - Location: kitchen/narrow-space
-- Buckeye | 1 ounce - whole - Location: storage/clear-bins
-- Butterfly Pea | 8 ounce - dry - Location: storage/clear-bins
-- Calamus | 0.25 cup - powder - Location: kitchen/cube-shelf/basket/b
-- Calamus | 0.5 ounce - tincture - Location: bedroom
-- Calamus | 1 cup - powder - Location: kitchen/cube-shelf/basket/b
-- Calamus | 1 ounce - dry - Location: storage/clear-bins
-- Calamus | 16 ounce - tincture - Location: kitchen/tincture-cabinet
-- Camphor | 0.5 cup - Location: storage/clear-bins
-- Camphor | 1 ounce - essential-oil - Location: kitchen/desk/underneath
-- Cats Claw | 0.5 ounce - tincture - Location: kitchen/narrow-space
-- Cats Claw | 16 ounce - tincture - Location: kitchen/tincture-cabinet
-- Cats Claw | 2 cup - powder - Location: storage/clear-bins
-- Cedar wood | 0.25 cup - powder - Location: kitchen/cube-shelf/basket/b
-- Cedar wood | 1 cup - dry - Location: storage/clear-bins
-- Cedar wood | 1 ounce - essential-oil - Location: kitchen/desk/underneath
-- Cerato | 0.5 ounce - essence - Location: kitchen/narrow-space
-- Chaga mushroom | 2 cup - dry - Location: kitchen/cube-shelf/basket/b
-- Chili | 1 cup - powder - Location: kitchen/cube-shelf/cloth-basket/a
-- Chili | 4 cup - powder - Location: kitchen/cube-shelf/cloth-basket/a
-- Cinquefoil | 1 ounce - dry - Location: storage/clear-bins
-- Clematis | 0.5 ounce - essence - Location: kitchen/narrow-space
-- Colloidal Gold | 4 ounce - tincture - Location: kitchen/narrow-space
-- Colloidal Silver | 1 ounce - suspension - Location: kitchen/narrow-space
-- Copal - White | 2 cup - resin - Location: kitchen/runner/basket/c
-- Copal | 1 cup - powder - Location: storage/clear-bins
-- Copal | 2 ounce - resin - Location: kitchen/runner/basket/c
-- Devil's Shoestring | 1 ounce - dry - Location: storage/clear-bins
-- Dragon's Blood | 0.25 cup - powder - Location: kitchen/cube-shelf/cloth-basket/b
-- Dragon's Blood | 0.5 ounce - powder - Location: kitchen/side-bookshelf/basket/e
-- Dragon's Blood | 1 cup - dry - Location: kitchen/runner/basket/c
-- Fir needle | 1 ounce - essential-oil - Location: kitchen/desk/underneath
-- Frankincense and Myrrh Blend | 2 cup - resin - Location: storage/clear-bins
-- Grapefruit | 0.5 ounce - essential-oil - Location: kitchen/desk/underneath
-- Grapefruit | 1 ounce - essential-oil - Location: kitchen/desk/underneath
-- Ground Ivy | 16 ounce - tincture - Location: kitchen/tincture-cabinet
-- Gum Arabic - powdered | 1 cup - powder - Location: kitchen/runner/basket/c
-- Gum Mastic | 0.25 cup - powder - Location: kitchen/cube-shelf/cloth-basket/b
-- Heliotrope | 0.25 ounce - essential-oil - Location: kitchen/desk/underneath
-- High John the Conqueror | 0.25 cup - whole - Location: kitchen/cube-shelf/basket/c
-- Jasmine | 1 ounce - dry - Location: kitchen
-- Jasmine | 1 ounce - essential-oil - Location: kitchen/desk/underneath
-- Kousa Dogwood Bud | 0.25 ounce - essence - Location: kitchen/narrow-space
-- Lemongrass | 0.5 ounce - essential-oil - Location: kitchen/desk/underneath
-- Lemongrass | 0.5 ounce - oil - Location: kitchen/desk/underneath
-- Lilac | 1 ounce - essential-oil - Location: kitchen/desk/underneath
-- Lime | 1 ounce - essential-oil - Location: kitchen/desk/underneath
-- Makko | 2 cup - powder - Location: kitchen/runner/basket/c
-- Master root | 0.5 ounce - oil - Location: kitchen/desk/underneath
-- May Chang | 1 ounce - essential-oil - Location: kitchen/desk/underneath
-- Menthol | 1 cup - resin - Location: storage/clear-bins
-- Mimulus | 0.5 ounce - essence - Location: kitchen/narrow-space
-- Mint | 2 cup - dry - Location: kitchen/cube-shelf/basket/d
-- Oak moss | 1 ounce - essential-oil - Location: kitchen/desk/underneath
-- Orris root - dry | 1 cup - dry - Location: storage/blue-bin
-- Osmanthus | 0.5 cup - dry - Location: storage/clear-bins
-- Paprika | 4 cup - dry - Location: kitchen/cube-shelf/cloth-basket/a
-- Patchouli | 1 ounce - essential-oil - Location: kitchen/desk/underneath
-- Patchouli | 2 cup - dry - Location: storage/clear-bins
-- Rooibos | 4 cup - dry - Location: kitchen/cube-shelf/basket/a
-- Salt, pink | 0.25 cup - dry - Location: kitchen/runner/basket/e
-- Salt, pink | 0.25 cup - powder - Location: kitchen/runner/basket/e
-- Sesame | 2 cup - dry - Location: kitchen/cube-shelf/cloth-basket/a
-- Star Anise | 0.25 cup - dry - Location: kitchen/runner/basket/a
-- Star Anise | 1 cup - dry - Location: kitchen/runner/basket/b
-- Star Anise | 1 ounce - essential-oil - Location: kitchen/desk/underneath
-- Star Anise | 4 cup - whole - Location: storage/clear-bins
-- Sticky Monkeyflower | 0.5 ounce - essence - Location: kitchen/narrow-space
-- Sumac | 3 cup - powder - Location: storage/clear-bins
-- Sweet pea | 0.5 ounce - essence - Location: kitchen/narrow-space
-- Sweet pea | 1 ounce - essential-oil - Location: kitchen/desk/underneath
-- Tobacco | 1 cup - dry - Location: kitchen/runner/basket/b
-- Vetiver | 0.5 ounce - essential-oil - Location: kitchen/desk/underneath
-- Water Violet | 0.5 ounce - essence - Location: kitchen/narrow-space
-- Woodruff | 1 ounce - dry - Location: storage/clear-bins
