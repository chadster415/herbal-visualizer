-- Batch H: broad flavonoid / hydroxycinnamic acid / iridoid herbs (97 herbs)
-- Rule: 25–60% alcohol; most water-effective.
-- Sub-groups (noted per herb):
--   Standard iridoid / flavonoid / phenylpropanoid glycoside: 25–45%
--   Sesquiterpene lactone / diterpene / resin / moderate alkaloid: 40–65%
--   Alkylamide / diterpenoid quinone / lignan / furanocoumarin specialty: 55–70%
-- 82 herbs via set_menstruum; 15 plant-part-specific entries via direct INSERT.

SET search_path TO herbal, public;

DO $$
BEGIN

  -- Alfalfa (Medicago sativa): isoflavones (formononetin, biochanin A), coumestans,
  -- flavonols, saponins — all polar and water/low-alcohol extractable
  PERFORM herbal.set_menstruum(
    'Medicago sativa', 25, 45, NULL, NULL, true,
    '25–45% alcohol or water',
    'Isoflavones, coumestans, and flavonols are polar and extract in water and 25–45% alcohol; saponin glycosides are amphipathic. Leaf and aerial parts are the medicinal form.',
    false
  );

  -- Arnica (Arnica montana): sesquiterpene lactones (helenalin, dihydrohelenalin),
  -- flavonoids — sesquiterpene lactones are lipophilic and toxic internally
  PERFORM herbal.set_menstruum(
    'Arnica montana', 50, 65, NULL, NULL, false,
    '50–65% alcohol (topical only)',
    'Sesquiterpene lactones (helenalin, dihydrohelenalin) are moderately lipophilic and require 50–65% alcohol for meaningful extraction. TOXIC internally except in homeopathic dilution — tincture is used exclusively topically for bruising and inflammation.',
    false
  );

  -- Arogyappacha (Trichopus zeylanicus): flavonoids, glycosides, saponins —
  -- adaptogenic Ayurvedic herb with limited Western extraction data
  PERFORM herbal.set_menstruum(
    'Trichopus zeylanicus', 40, 60, NULL, NULL, true,
    '40–60% alcohol or water decoction',
    'Contains flavonoids, glycosides, and saponins; 40–60% alcohol preferred for full-spectrum extraction. Limited Western pharmacokinetic data — range reflects general saponin/flavonoid extraction principles.',
    false
  );

  -- Artichoke (Cynara scolymus): cynarin (hydroxycinnamic acid dimer), chlorogenic acid,
  -- luteolin, cynaropicrin (sesquiterpene lactone)
  PERFORM herbal.set_menstruum(
    'Cynara scolymus', 35, 55, NULL, NULL, true,
    '35–55% alcohol or water decoction',
    'Cynarin and chlorogenic acid (hydroxycinnamic acids) are water-extractable; cynaropicrin (sesquiterpene lactone) and luteolin (flavone aglycone) require moderate alcohol. The 35–55% range captures the full bitter/hepatoprotective fraction.',
    false
  );

  -- Aspen (Populus tremuloides): salicin, populin (phenolic glycosides), flavonoids
  PERFORM herbal.set_menstruum(
    'Populus tremuloides', 25, 45, NULL, NULL, true,
    '25–45% alcohol or water decoction',
    'Salicin and populin (phenolic glycosides) are water-soluble and extract in water and 25–45% alcohol. Bark is the primary medicinal part; water decoction is the traditional preparation.',
    false
  );

  -- Bacopa (Bacopa monnieri): bacosides A & B (jujubogenin-type saponin glycosides),
  -- bacopasaponins — moderately polar saponins; low-moderate alcohol effective
  PERFORM herbal.set_menstruum(
    'Bacopa monnieri', 25, 45, NULL, NULL, true,
    '25–45% alcohol or water decoction',
    'Bacosides A & B (jujubogenin-type saponin glycosides) are moderately polar; water decoction is the traditional Ayurvedic preparation. 25–45% alcohol extracts the full bacoside complement. Aerial parts are the medicinal part.',
    false
  );

  -- Balm of Gilead (Populus candicans): salicin, flavonoids, resins (terpene acetates)
  -- buds contain more resin than bark, so slightly higher range than Aspen
  PERFORM herbal.set_menstruum(
    'Populus candicans', 35, 55, NULL, NULL, true,
    '35–55% alcohol or water decoction',
    'Buds contain salicin (phenolic glycoside), flavonoids, and terpene resins. The salicin fraction is water-extractable; 35–55% alcohol also captures the resin fraction. Higher range preferred for bud preparations.',
    false
  );

  -- Balmony (Chelone glabra): iridoid glycosides (catalpol, aucubin), flavonoids
  PERFORM herbal.set_menstruum(
    'Chelone glabra', 25, 45, NULL, NULL, true,
    '25–45% alcohol or water decoction',
    'Iridoid glycosides (catalpol, aucubin) and flavonoids are polar; both water and 25–45% alcohol are effective. Leaf and aerial parts are the medicinal form.',
    false
  );

  -- Bilberry (Vaccinium myrtillus): anthocyanins (delphinidin, cyanidin glycosides),
  -- flavonols — anthocyanins are amphipathic, water and low alcohol effective
  PERFORM herbal.set_menstruum(
    'Vaccinium myrtillus', 25, 45, NULL, NULL, true,
    '25–45% alcohol or water',
    'Anthocyanins (delphinidin, cyanidin glycosides) and flavonols are water-extractable and amphipathic. Low-moderate alcohol stabilises the anthocyanin fraction for tincture. Berries are the medicinal part.',
    false
  );

  -- Birch (Betula spp.): betulinic acid (pentacyclic triterpene), methyl salicylate,
  -- flavonoids, hydroxycinnamic acids — triterpene needs moderate alcohol
  PERFORM herbal.set_menstruum(
    'Betula spp.', 40, 60, NULL, NULL, true,
    '40–60% alcohol or water decoction',
    'Betulinic acid (pentacyclic triterpene) requires moderate alcohol for meaningful extraction; methyl salicylate and hydroxycinnamic acids are also present. Water decoction extracts the polar flavonoid and phenolic fraction; bark and leaf are medicinal.',
    false
  );

  -- Black Horehound (Ballota nigra): diterpenoids (marrubiin-type lactones),
  -- phenylpropanoid glycosides, flavonoids
  PERFORM herbal.set_menstruum(
    'Ballota nigra', 35, 50, NULL, NULL, true,
    '35–50% alcohol or water decoction',
    'Diterpenoid lactones and phenylpropanoid glycosides are the primary actives; 35–50% alcohol captures the diterpene and flavonoid fractions. Water decoction is also effective for the polar glycoside fraction.',
    false
  );

  -- Black Mustard (Brassica nigra): sinigrin (glucosinolate → allyl isothiocyanate),
  -- fixed oils — glucosinolates are water-soluble
  PERFORM herbal.set_menstruum(
    'Brassica nigra', 25, 40, NULL, NULL, true,
    '25–40% alcohol or water',
    'Sinigrin (glucosinolate) and related compounds are water-soluble; 25–40% alcohol also effective. The volatile allyl isothiocyanate formed on enzyme hydrolysis is lost during evaporation — use fresh preparations for maximum effect.',
    false
  );

  -- Black Root (Leptandra virginica): leptandrin (bitter glycoside/saponin), resins,
  -- flavonoids
  PERFORM herbal.set_menstruum(
    'Leptandra virginica', 40, 60, NULL, NULL, true,
    '40–60% alcohol or water decoction',
    'Leptandrin (bitter glycoside) and resins require moderate alcohol (40–60%); flavonoids are also water-extractable. Root is the medicinal part; use dried material — fresh root is an emetic/cathartic.',
    false
  );

  -- Blue Flag (Iris versicolor): irisin (triterpenoid glycoside), isoflavones,
  -- furfural, tannins, resins
  PERFORM herbal.set_menstruum(
    'Iris versicolor', 40, 60, NULL, NULL, true,
    '40–60% alcohol or water decoction',
    'Irisin (triterpenoid glycoside), isoflavones, and resins require moderate alcohol (40–60%) for full extraction. Rhizome is the medicinal part; root is toxic in large doses — use in small amounts only.',
    false
  );

  -- Blue Vervain (Verbena hastata): iridoid glycosides (verbenalin, hastatoside),
  -- flavonoids, bitter principles
  PERFORM herbal.set_menstruum(
    'Verbena hastata', 25, 45, NULL, NULL, true,
    '25–45% alcohol or water decoction',
    'Iridoid glycosides (verbenalin, hastatoside) and flavonoids are polar; both water and 25–45% alcohol are effective. Aerial parts are the medicinal form.',
    false
  );

  -- Bogbean (Menyanthes trifoliata): secoiridoids (loganin, swertiamarin),
  -- hydroxycinnamic acids, alkaloids (trace), flavonoids
  PERFORM herbal.set_menstruum(
    'Menyanthes trifoliata', 25, 45, NULL, NULL, true,
    '25–45% alcohol or water decoction',
    'Secoiridoids (loganin, swertiamarin) and hydroxycinnamic acids are polar and water-extractable; 25–45% alcohol for full-spectrum extraction. Leaf is the medicinal part.',
    false
  );

  -- Boldo (Peumus boldus): boldine (aporphine isoquinoline alkaloid), flavonoids,
  -- volatile oils (ascaridole)
  PERFORM herbal.set_menstruum(
    'Peumus boldus', 40, 60, NULL, NULL, true,
    '40–60% alcohol or water decoction',
    'Boldine (aporphine alkaloid) and flavonoids extract in 40–60% alcohol; water decoction also effective for the alkaloid fraction at moderate concentrations. Ascaridole (volatile terpenoid) is partially volatile — tincture captures more than decoction. Leaf is the medicinal part.',
    false
  );

  -- Borage (Borago officinalis): flavonoids, mucilage (flowers), GLA (fixed oil —
  -- not tincture-extractable), trace pyrrolizidine alkaloids
  PERFORM herbal.set_menstruum(
    'Borago officinalis', 25, 40, NULL, NULL, true,
    '25–40% alcohol or water infusion',
    'Flavonoids and mucilage extract in water and 25–40% alcohol. GLA (fixed oil) is not captured in aqueous/alcohol tinctures. Flowers preferred over leaves — leaf preparations carry higher pyrrolizidine alkaloid risk; avoid internal use in pregnancy.',
    false
  );

  -- Buckwheat (Fagopyrum esculentum): rutin (flavonol glycoside), quercetin —
  -- highly water-soluble; low alcohol needed for tincture
  PERFORM herbal.set_menstruum(
    'Fagopyrum esculentum', 25, 40, NULL, NULL, true,
    '25–40% alcohol or water',
    'Rutin and quercetin glycosides are highly water-soluble; water or 25–40% alcohol both effective. Herb (aerial parts / seeds) is the source.',
    false
  );

  -- Bugleweed (Lycopus spp.): lithospermic acid (hydroxycinnamic acid dimer),
  -- phenylpropanoid glycosides, iridoids — all polar
  PERFORM herbal.set_menstruum(
    'Lycopus spp.', 25, 45, NULL, NULL, true,
    '25–45% alcohol or water decoction',
    'Lithospermic acid and phenylpropanoid glycosides are polar and water/low-alcohol extractable. Aerial parts are the medicinal form.',
    false
  );

  -- Butterwort (Pinguicula vulgaris): iridoid glycosides, flavonoids —
  -- carnivorous plant, limited extraction data
  PERFORM herbal.set_menstruum(
    'Pinguicula vulgaris', 25, 40, NULL, NULL, true,
    '25–40% alcohol or water',
    'Iridoid glycosides and flavonoids are polar and water/low-alcohol extractable. Limited pharmacokinetic data — range reflects general iridoid extraction principles. Aerial parts used.',
    false
  );

  -- Cashew (Anacardium occidentale): anacardic acid (long-chain alkylphenol —
  -- lipophilic), cardanol, flavonoids, tannins — bark/leaf is medicinal, not nut
  PERFORM herbal.set_menstruum(
    'Anacardium occidentale', 40, 65, NULL, NULL, true,
    '40–65% alcohol or water decoction',
    'Anacardic acid and cardanol (long-chain alkylphenols) are lipophilic and require moderate-to-high alcohol (40–65%); tannins and flavonoids are also water-extractable. Bark is the medicinal part — not the caustic nut shell oil.',
    false
  );

  -- Centaury (Centaurium erythraea): secoiridoids (gentiopicrin, swertiamarin,
  -- centapicrin), xanthones, flavonoids
  PERFORM herbal.set_menstruum(
    'Centaurium erythraea', 25, 45, NULL, NULL, true,
    '25–45% alcohol or water decoction',
    'Secoiridoids (gentiopicrin, swertiamarin) and xanthones are polar; water and 25–45% alcohol both effective. Aerial parts are the medicinal form; extremely bitter.',
    false
  );

  -- Chaparral (Larrea tridentata): NDGA (nordihydroguaiaretic acid — lignan, lipophilic),
  -- flavonoids, resins — hepatotoxicity concerns with prolonged use
  PERFORM herbal.set_menstruum(
    'Larrea tridentata', 50, 65, NULL, NULL, true,
    '50–65% alcohol or water decoction',
    'NDGA (nordihydroguaiaretic acid, a lignan) and resins are moderately lipophilic and require 50–65% alcohol for full extraction; flavonoids are also water-extractable. CAUTION: associated with hepatotoxicity and renal damage with prolonged internal use — use only short-term under expert supervision.',
    false
  );

  -- Chickpea (Cicer arietinum): isoflavones (formononetin, biochanin A) —
  -- food herb; phytoestrogenic constituents are water/alcohol extractable
  PERFORM herbal.set_menstruum(
    'Cicer arietinum', 25, 40, NULL, NULL, true,
    '25–40% alcohol or water',
    'Isoflavones (formononetin, biochanin A) and flavonoids are polar; water and 25–40% alcohol both effective. Primarily a food herb — medicinal use focuses on phytoestrogenic activity.',
    false
  );

  -- Chinese Skullcap (Scutellaria baicalensis): baicalin (flavonoid glucuronide),
  -- baicalein (flavone aglycone — less polar), wogonin
  PERFORM herbal.set_menstruum(
    'Scutellaria baicalensis', 45, 65, NULL, NULL, true,
    '45–65% alcohol or water decoction',
    'Baicalin (flavonoid glucuronide) is water-extractable; baicalein (aglycone) and wogonin are less polar and require 45–65% alcohol for full extraction. Root is the medicinal part (Huang Qin in TCM).',
    false
  );

  -- Clove (Syzygium aromaticum): eugenol (phenylpropanoid volatile — 70–90% of
  -- essential oil), tannins, flavonoids — high volatile oil content
  PERFORM herbal.set_menstruum(
    'Syzygium aromaticum', 60, 75, NULL, NULL, true,
    '60–75% alcohol or water (volatile-retaining)',
    'Eugenol (phenylpropanoid, 70–90% of essential oil) is volatile and partially water-steam-distillable; 60–75% alcohol captures the full eugenol and tannin fraction. Water decoction loses significant eugenol to volatilisation. Flower buds are the medicinal part.',
    false
  );

  -- Coleus (Coleus forskohlii): forskolin (labdane diterpene — markedly lipophilic)
  -- Forskolin requires high alcohol for meaningful extraction
  PERFORM herbal.set_menstruum(
    'Coleus forskohlii', 50, 70, NULL, NULL, false,
    '50–70% alcohol',
    'Forskolin (labdane diterpene) is markedly lipophilic and requires 50–70% alcohol for significant extraction; not meaningfully water-extracted. Root is the medicinal part; standardised extracts (10–20% forskolin) are the typical commercial form.',
    false
  );

  -- Cowslip (Primula veris): saponins (primulasaponin — primulic acid glycosides),
  -- flavonoids, volatile oils — triterpenoid saponins, amphipathic
  PERFORM herbal.set_menstruum(
    'Primula veris', 25, 45, NULL, NULL, true,
    '25–45% alcohol or water decoction',
    'Primulasaponin (triterpenoid saponin glycoside) and flavonoids are amphipathic and extract in water and 25–45% alcohol. Flower, root, and leaf used medicinally.',
    false
  );

  -- Cranberry (Vaccinium macrocarpon): A-type proanthocyanidins, anthocyanins,
  -- hydroxycinnamic acids — all polar/amphipathic
  PERFORM herbal.set_menstruum(
    'Vaccinium macrocarpon', 25, 45, NULL, NULL, true,
    '25–45% alcohol or water',
    'A-type proanthocyanidins (unique to Vaccinium), anthocyanins, and hydroxycinnamic acids are polar and extract in water and 25–45% alcohol. Berries are the medicinal part; primarily used as juice/extract rather than tincture.',
    false
  );

  -- Damiana (Turnera diffusa): volatile oils (thymol, cineole), arbutin
  -- (hydroquinone glycoside), gonzalitosin (flavone), resins
  PERFORM herbal.set_menstruum(
    'Turnera diffusa', 50, 65, NULL, NULL, true,
    '50–65% alcohol or water decoction',
    'Volatile oils (thymol, cineole), arbutin, and resins require moderate-to-high alcohol (50–65%) for full extraction; water extracts the arbutin and flavonoid fraction. Leaf is the medicinal part.',
    false
  );

  -- Dan Shen (Salvia miltiorrhiza): tanshinones I, IIA, IIB (diterpenoid quinones —
  -- lipophilic), salvianolic acids (hydroxycinnamic acid dimers — water-soluble)
  PERFORM herbal.set_menstruum(
    'Salvia miltiorrhiza', 50, 70, NULL, NULL, true,
    '50–70% alcohol or water decoction',
    'Tanshinones (diterpenoid quinones) are lipophilic and require 50–70% alcohol; salvianolic acids (hydroxycinnamic acid dimers) are water-soluble and extract in water. The 50–70% range captures both the lipophilic tanshinone and water-soluble salvianolic acid fractions. Root is the medicinal part.',
    false
  );

  -- Devil''s Club (Oplopanax horridus): polyynes (falcarinol-type),
  -- triterpenoid saponins, volatile compounds — Western North American species
  PERFORM herbal.set_menstruum(
    'Oplopanax horridus', 40, 60, NULL, NULL, true,
    '40–60% alcohol or water decoction',
    'Polyynes (falcarinol-type) and triterpenoid saponins require 40–60% alcohol for full extraction; water decoction used traditionally by indigenous peoples. Root bark and stem bark are the medicinal parts.',
    false
  );

  -- English Daisy (Bellis perennis): sesquiterpene lactones, saponins,
  -- flavonoids, polyacetylenes
  PERFORM herbal.set_menstruum(
    'Bellis perennis', 40, 60, NULL, NULL, true,
    '40–60% alcohol or water decoction',
    'Sesquiterpene lactones and polyacetylenes are moderately lipophilic; saponins and flavonoids are amphipathic. The 40–60% range captures the full constituent spectrum. Aerial parts and flower heads are the medicinal form.',
    false
  );

  -- Eyebright (Euphrasia spp.): iridoid glycosides (aucubin),
  -- flavonoids (luteolin, quercetin), tannins
  PERFORM herbal.set_menstruum(
    'Euphrasia spp.', 25, 45, NULL, NULL, true,
    '25–45% alcohol or water',
    'Aucubin (iridoid glycoside), luteolin, and quercetin are polar; water and 25–45% alcohol both effective. Aerial parts are the medicinal form.',
    false
  );

  -- Figwort (Scrophularia nodosa): iridoid glycosides (harpagide, aucubin, harpagoside),
  -- flavonoids — polar constituents
  PERFORM herbal.set_menstruum(
    'Scrophularia nodosa', 25, 45, NULL, NULL, true,
    '25–45% alcohol or water decoction',
    'Iridoid glycosides (harpagide, aucubin) and flavonoids are polar; water and 25–45% alcohol both effective. Aerial parts and root are the medicinal forms.',
    false
  );

  -- Fringetree (Chionanthus virginicus): secoiridoids (chionanthin, phyllyrin),
  -- saponins, flavonoids
  PERFORM herbal.set_menstruum(
    'Chionanthus virginicus', 40, 60, NULL, NULL, true,
    '40–60% alcohol or water decoction',
    'Secoiridoids (chionanthin, phyllyrin) and saponins require moderate alcohol (40–60%); flavonoids are also water-extractable. Root bark is the medicinal part.',
    false
  );

  -- Hardy Rubber Tree (Eucommia ulmoides): geniposidic acid and aucubin (iridoids),
  -- chlorogenic acid, pinoresinol diglucoside (lignan) — lignans need moderate alcohol
  PERFORM herbal.set_menstruum(
    'Eucommia ulmoides', 40, 60, NULL, NULL, true,
    '40–60% alcohol or water decoction',
    'Iridoid glycosides (geniposidic acid, aucubin) and chlorogenic acid are water-extractable; pinoresinol diglucoside (lignan) requires moderate alcohol (40–60%). Bark is the medicinal part (Du Zhong).',
    false
  );

  -- Heartsease (Viola tricolor): rutin (flavonol glycoside), violutoside
  -- (phenylpropanoid glycoside), salicylates, mucilage
  PERFORM herbal.set_menstruum(
    'Viola tricolor', 25, 45, NULL, NULL, true,
    '25–45% alcohol or water',
    'Rutin, violutoside (phenylpropanoid glycoside), and salicylates are polar; water and 25–45% alcohol both effective. Aerial parts are the medicinal form.',
    false
  );

  -- Helichrysum (Helichrysum italicum): phloroglucinols (arenol, isognaphalin),
  -- arzanol (chalcone–phloroglucinol), neryl acetate (volatile ester), flavonoids
  PERFORM herbal.set_menstruum(
    'Helichrysum italicum', 50, 65, NULL, NULL, true,
    '50–65% alcohol or water decoction',
    'Phloroglucinols (arenol, arzanol) and neryl acetate (volatile ester) are moderately lipophilic and require 50–65% alcohol for full extraction; flavonoids are also water-extractable. Flower heads are the medicinal form.',
    false
  );

  -- Horehound (Marrubium vulgare): marrubiin (furanoid diterpene lactone),
  -- premarrubin, flavonoids — diterpene lactone requires moderate alcohol
  PERFORM herbal.set_menstruum(
    'Marrubium vulgare', 40, 60, NULL, NULL, true,
    '40–60% alcohol or water decoction',
    'Marrubiin (furanoid diterpene lactone) and premarrubin are moderately lipophilic; 40–60% alcohol required for full extraction. Flavonoids and bitter principles are also water-extractable. Aerial parts are the medicinal form.',
    false
  );

  -- Horseradish (Armoracia rusticana): sinigrin (glucosinolate → allyl isothiocyanate),
  -- peroxidase enzymes, flavonoids — glucosinolates are water-soluble
  PERFORM herbal.set_menstruum(
    'Armoracia rusticana', 25, 40, NULL, NULL, true,
    '25–40% alcohol or water',
    'Sinigrin (glucosinolate) is water-soluble; allyl isothiocyanate (formed on enzyme hydrolysis) is volatile and lost in evaporated preparations. Use fresh root preparations for maximum pungency. Root is the medicinal part.',
    false
  );

  -- Jamaican Dogwood (Piscidia piscipula): isoflavonoids, rotenoids (rotenone —
  -- lipophilic insecticide compound), organic acids
  PERFORM herbal.set_menstruum(
    'Piscidia piscipula', 50, 65, NULL, NULL, true,
    '50–65% alcohol or water decoction',
    'Rotenoids (rotenone-type) and isoflavonoids are moderately lipophilic; 50–65% alcohol needed for full extraction. Water decoction is less complete but captures the polar organic acid fraction. Root bark is the medicinal part.',
    false
  );

  -- Kutki (Picrorrhiza kurroa): iridoid glycosides (picroside I & II, kutkoside),
  -- phenolic glycosides — highly polar
  PERFORM herbal.set_menstruum(
    'Picrorrhiza kurroa', 25, 45, NULL, NULL, true,
    '25–45% alcohol or water decoction',
    'Picrosides I & II (iridoid glycosides) and kutkoside (phenolic glycoside) are highly polar and water-extractable; 25–45% alcohol for full-spectrum tincture. Rhizome is the medicinal part.',
    false
  );

  -- Lungwort (Pulmonaria officinalis): allantoin, mucilage, flavonoids, tannins,
  -- hydroxycinnamic acids — all polar and water/low-alcohol extractable
  PERFORM herbal.set_menstruum(
    'Pulmonaria officinalis', 25, 40, NULL, NULL, true,
    '25–40% alcohol or water infusion',
    'Allantoin, mucilage, and hydroxycinnamic acids are polar and extract well in water; 25–40% alcohol for tincture. Cold or warm water infusion is the traditional preparation. Leaf and aerial parts are the medicinal form.',
    false
  );

  -- Manzanita (Arctostaphylos manzanita): arbutin (hydroquinone glycoside),
  -- ursolic acid (triterpene), tannins — similar extraction to uva ursi
  PERFORM herbal.set_menstruum(
    'Arctostaphylos manzanita', 25, 40, NULL, NULL, true,
    '25–40% alcohol or water decoction',
    'Arbutin (hydroquinone glycoside) and tannins are polar and water-extractable; 25–40% alcohol effective for tincture. Leaf is the medicinal part.',
    false
  );

  -- Maral Root (Leuzea carthamoides): 20-hydroxyecdysone (ecdysteroid —
  -- polyhydroxylated steroid, highly polar), flavonoids
  PERFORM herbal.set_menstruum(
    'Leuzea carthamoides', 25, 45, NULL, NULL, true,
    '25–45% alcohol or water decoction',
    '20-Hydroxyecdysone (ecdysteroid) is highly water-soluble due to multiple hydroxyl groups; water and 25–45% alcohol both effective. Root is the medicinal part.',
    false
  );

  -- Mistletoe (Viscum album): viscumin (lectins — water-soluble proteins),
  -- phenylpropanoids (syringin), flavonoids — lectins not extracted in alcohol
  PERFORM herbal.set_menstruum(
    'Viscum album', 25, 40, NULL, NULL, true,
    '25–40% alcohol or water',
    'Viscumin (lectins) are water-soluble proteins not captured in alcohol preparations; phenylpropanoids (syringin) and flavonoids extract in water and 25–40% alcohol. Mistletoe preparations (e.g., Iscador) are typically aqueous injections. Aerial parts are the medicinal form.',
    false
  );

  -- Mouse Ear (Hieracium pilosella): umbelliferone (coumarin), chlorogenic acid,
  -- flavonoids (luteolin), tannins — all polar
  PERFORM herbal.set_menstruum(
    'Hieracium pilosella', 25, 40, NULL, NULL, true,
    '25–40% alcohol or water infusion',
    'Umbelliferone (coumarin), chlorogenic acid, and luteolin are polar and extract in water and 25–40% alcohol. Aerial parts are the medicinal form.',
    false
  );

  -- Mulberry Leaf (Morus alba): 1-deoxynojirimycin (alkaloid sugar analog — polar),
  -- flavonoids (quercetin, kaempferol), anthocyanins
  PERFORM herbal.set_menstruum(
    'Morus alba', 25, 40, NULL, NULL, true,
    '25–40% alcohol or water',
    '1-Deoxynojirimycin (iminosugar alkaloid) and flavonoids are polar and water/low-alcohol extractable. Leaf is the medicinal part.',
    false
  );

  -- Mustard (Brassica spp.): glucosinolates (sinigrin, sinalbin), fixed oils
  PERFORM herbal.set_menstruum(
    'Brassica spp.', 25, 40, NULL, NULL, true,
    '25–40% alcohol or water',
    'Glucosinolates are water-soluble; 25–40% alcohol for tincture. Fixed oils are not captured in aqueous/alcohol tinctures. Seed is the primary medicinal part.',
    false
  );

  -- Narrow-Leaf Echinacea (Echinacea angustifolia): isobutylamide alkylamides
  -- (lipophilic, numbing — require high alcohol), caffeic acid derivatives (polar)
  PERFORM herbal.set_menstruum(
    'Echinacea angustifolia', 60, 70, NULL, NULL, false,
    '60–70% alcohol',
    'Isobutylamide alkylamides (responsible for the tingling/numbing sensation) are lipophilic and require 60–70% alcohol for full extraction — not meaningfully water-extracted. Caffeic acid derivatives (echinacoside, cynarin) are water-soluble but alkylamides are considered the primary immunostimulant fraction. Root is the medicinal part.',
    false
  );

  -- Nasturtium (Tropaeolum majus): glucotropaeolin (glucosinolate →
  -- benzyl isothiocyanate), quercetin — glucosinolates are water-soluble
  PERFORM herbal.set_menstruum(
    'Tropaeolum majus', 25, 40, NULL, NULL, true,
    '25–40% alcohol or water',
    'Glucotropaeolin (glucosinolate) and quercetin are polar and water/low-alcohol extractable. Aerial parts (leaf, flower) are the medicinal form.',
    false
  );

  -- Ocotillo (Fouquieria splendens): isorhamnetin, quercetin (flavonols),
  -- hydroxycinnamic acids, fatty acids
  PERFORM herbal.set_menstruum(
    'Fouquieria splendens', 40, 55, NULL, NULL, true,
    '40–55% alcohol or water decoction',
    'Isorhamnetin and quercetin (flavonols) extract in water and low-moderate alcohol; fatty acids require moderate alcohol. Bark is the primary medicinal part; used in Southwest American herbal medicine.',
    false
  );

  -- Olive (Olea europaea): oleuropein (secoiridoid phenolic glycoside),
  -- hydroxytyrosol, luteolin — highly polar phenolic glycosides
  PERFORM herbal.set_menstruum(
    'Olea europaea', 25, 45, NULL, NULL, true,
    '25–45% alcohol or water decoction',
    'Oleuropein (secoiridoid glycoside) and hydroxytyrosol are highly polar; water and 25–45% alcohol both effective. Leaf is the primary medicinal part for tinctures.',
    false
  );

  -- Onion (Allium cepa): quercetin (flavonol), isorhamnetin glycosides,
  -- alliin (organosulfur) — all polar and water-extractable
  PERFORM herbal.set_menstruum(
    'Allium cepa', 25, 40, NULL, NULL, true,
    '25–40% alcohol or water',
    'Quercetin glycosides and alliin (organosulfur) are polar; water and 25–40% alcohol both effective. Primarily a food herb; bulb used medicinally.',
    false
  );

  -- Parsley Piert (Aphanes arvensis): flavonoids, tannins, salicylic acid
  PERFORM herbal.set_menstruum(
    'Aphanes arvensis', 25, 40, NULL, NULL, true,
    '25–40% alcohol or water infusion',
    'Flavonoids, tannins, and salicylic acid are polar and water/low-alcohol extractable. Aerial parts are the medicinal form.',
    false
  );

  -- Pasqueflower (Pulsatilla vulgaris): ranunculin (glycoside → protoanemonin
  -- on hydrolysis → anemonin on drying), saponins, flavonoids
  -- MUST use dried plant — fresh contains irritant protoanemonin
  PERFORM herbal.set_menstruum(
    'Pulsatilla vulgaris', 40, 60, NULL, NULL, true,
    '40–60% alcohol (dried herb only)',
    'Anemonin (from dried ranunculin) and saponins require moderate alcohol (40–60%); flavonoids are also water-extractable. MUST use dried plant only — fresh plant releases protoanemonin (mucous membrane irritant) on crushing. Avoid in pregnancy.',
    false
  );

  -- Pau d''arco (Tabebuia impetiginosa): lapachol, beta-lapachone (naphthoquinones
  -- — moderately lipophilic), xyloidone
  PERFORM herbal.set_menstruum(
    'Tabebuia impetiginosa', 50, 70, NULL, NULL, true,
    '50–70% alcohol or water decoction',
    'Lapachol and beta-lapachone (naphthoquinones) are moderately lipophilic and extract more fully in 50–70% alcohol; decoction is the traditional preparation and partially extracts lapachol at boiling temperatures. Inner bark is the medicinal part.',
    false
  );

  -- Pellitory of the Wall (Parietaria judaica): flavonoids, potassium nitrate,
  -- tannins, bitter glycosides
  PERFORM herbal.set_menstruum(
    'Parietaria judaica', 25, 40, NULL, NULL, true,
    '25–40% alcohol or water infusion',
    'Flavonoids and bitter glycosides are polar and water/low-alcohol extractable. Aerial parts are the medicinal form.',
    false
  );

  -- Periwinkle (Vinca major): vincamine (indole alkaloid), vinpocetine precursors,
  -- tannins, flavonoids
  PERFORM herbal.set_menstruum(
    'Vinca major', 40, 60, NULL, NULL, true,
    '40–60% alcohol or water decoction',
    'Vincamine (indole alkaloid) and related alkaloids require moderate alcohol (40–60%); tannins and flavonoids are also water-extractable. Aerial parts are the medicinal form.',
    false
  );

  -- Pilewort (Ranunculus ficaria): saponins (ficarin/hederagenin glycosides),
  -- tannins, vitamin C — DRIED plant only (fresh contains protoanemonin)
  PERFORM herbal.set_menstruum(
    'Ranunculus ficaria', 25, 45, NULL, NULL, true,
    '25–45% alcohol or water (dried herb only)',
    'Saponins (ficarin) and tannins are amphipathic; water and 25–45% alcohol both effective. DRIED plant only — fresh contains protoanemonin (irritant). Aerial parts are the medicinal form; used topically for haemorrhoids.',
    false
  );

  -- Pill-Bearing Spurge (Euphorbia pilulifera): euphol (triterpene), tannins,
  -- flavonoids, sterols
  PERFORM herbal.set_menstruum(
    'Euphorbia pilulifera', 40, 60, NULL, NULL, true,
    '40–60% alcohol or water decoction',
    'Euphol (triterpene) requires moderate alcohol (40–60%); tannins and flavonoids are also water-extractable. Aerial parts are the medicinal form; used for respiratory conditions.',
    false
  );

  -- Plantain (Plantago major): aucubin (iridoid glycoside), mucilage,
  -- allantoin, chlorogenic acid — all highly polar
  PERFORM herbal.set_menstruum(
    'Plantago major', 25, 40, NULL, NULL, true,
    '25–40% alcohol or water infusion',
    'Aucubin (iridoid glycoside), allantoin, and chlorogenic acid are highly polar; water infusion and 25–40% alcohol both effective. Leaf is the primary medicinal part.',
    false
  );

  -- Pleurisy Root (Asclepias tuberosa): cardenolide glycosides (viridiflorin),
  -- resins, flavonoids
  PERFORM herbal.set_menstruum(
    'Asclepias tuberosa', 40, 60, NULL, NULL, true,
    '40–60% alcohol or water decoction',
    'Cardenolide glycosides (viridiflorin) and resins require moderate alcohol (40–60%); flavonoids are also water-extractable. Root is the medicinal part; contains cardiac glycoside-type compounds — use at appropriate doses.',
    false
  );

  -- Prince Seng (Pseudostellaria heterophylla): cyclopeptide alkaloids
  -- (heterophyllins), polysaccharides, saponins, flavonoids
  PERFORM herbal.set_menstruum(
    'Pseudostellaria heterophylla', 25, 45, NULL, NULL, true,
    '25–45% alcohol or water decoction',
    'Polysaccharides and saponins are amphipathic; flavonoids and cyclopeptide alkaloids extract in water and 25–45% alcohol. Root is the medicinal part (Tai Zi Shen).',
    false
  );

  -- Privet (Ligustrum lucidum): oleuropein (secoiridoid), iridoid glycosides
  -- (nuezhenide, ligustroside), flavonoids, saponins
  PERFORM herbal.set_menstruum(
    'Ligustrum lucidum', 40, 60, NULL, NULL, true,
    '40–60% alcohol or water decoction',
    'Oleuropein (secoiridoid) and iridoid glycosides are water-extractable; saponins and flavonoids also extract in 40–60% alcohol. Ripe fruit (Nu Zhen Zi) is the medicinal part.',
    false
  );

  -- Queen''s Delight (Stillingia sylvatica): stillingin (diterpene ester resin),
  -- cyanogenic glycosides, volatile oils
  PERFORM herbal.set_menstruum(
    'Stillingia sylvatica', 50, 65, NULL, NULL, true,
    '50–65% alcohol or water decoction',
    'Stillingin (diterpene ester resin) and volatile constituents require 50–65% alcohol for meaningful extraction; cyanogenic glycosides are also water-extractable. Root is the medicinal part.',
    false
  );

  -- Rehmannia (Rehmannia glutinosa): catalpol (iridoid glycoside), stachyose
  -- and verbascose (oligosaccharides), rehmannin — polar constituents
  PERFORM herbal.set_menstruum(
    'Rehmannia glutinosa', 25, 45, NULL, NULL, true,
    '25–45% alcohol or water decoction',
    'Catalpol (iridoid glycoside) and oligosaccharides are highly polar and water-extractable; 25–45% alcohol for tincture. Root is the medicinal part; both raw (Sheng Di Huang) and prepared (Shu Di Huang) forms used.',
    false
  );

  -- Rhodiola (Rhodiola rosea): rosavins (phenylpropanoid glycosides — cinnamyl
  -- alcohol glycosides), salidroside (tyrosol glycoside), p-tyrosol
  PERFORM herbal.set_menstruum(
    'Rhodiola rosea', 25, 50, NULL, NULL, true,
    '25–50% alcohol or water decoction',
    'Rosavins (phenylpropanoid glycosides) and salidroside (tyrosol glycoside) are polar and water/low-alcohol extractable; 25–50% alcohol for tincture. Root is the medicinal part; standardised extracts typically specify 3% rosavins and 1% salidroside.',
    false
  );

  -- Roman Chamomile (Chamaemelum nobile): isobutyl angelate, isoamyl angelate
  -- (ester volatiles — lipophilic), sesquiterpene lactones (nobilin), flavonoids
  PERFORM herbal.set_menstruum(
    'Chamaemelum nobile', 45, 60, NULL, NULL, true,
    '45–60% alcohol or water infusion',
    'Volatile esters (isobutyl angelate) and sesquiterpene lactones (nobilin) require moderate alcohol (45–60%); flavonoids are also water-extractable. Flower heads are the medicinal part. Distinguished from German chamomile by its ester-rich volatile oil.',
    false
  );

  -- Rue (Ruta graveolens): furanocoumarins (bergapten, xanthotoxin — phototoxic),
  -- alkaloids (skimmianine, arborinine), volatile oils
  PERFORM herbal.set_menstruum(
    'Ruta graveolens', 50, 65, NULL, NULL, true,
    '50–65% alcohol or water decoction',
    'Furanocoumarins (bergapten, xanthotoxin — phototoxic) and alkaloids require 50–65% alcohol; volatile oils are partially volatile in water preparations. CAUTION: furanocoumarins cause phototoxic skin reactions; emmenagogue properties — contraindicated in pregnancy. Aerial parts used in small doses only.',
    false
  );

  -- Schizandra (Schisandra chinensis): dibenzocyclooctadiene lignans (schisandrin,
  -- gomisin A, schisandrol) — lipophilic lignans require high alcohol
  PERFORM herbal.set_menstruum(
    'Schisandra chinensis', 60, 70, NULL, NULL, true,
    '60–70% alcohol or water decoction',
    'Dibenzocyclooctadiene lignans (schisandrin, gomisin A, schisandrol) are moderately lipophilic and require 60–70% alcohol for full extraction; water decoction is the traditional TCM preparation but is less complete for the lignan fraction. Fruit is the medicinal part.',
    false
  );

  -- Sea Holly (Eryngium maritimum): saponins, flavonoids, hydroxycinnamic acids,
  -- furanocoumarins — moderate lipophilicity mix
  PERFORM herbal.set_menstruum(
    'Eryngium maritimum', 40, 55, NULL, NULL, true,
    '40–55% alcohol or water decoction',
    'Saponins, furanocoumarins, and flavonoids require moderate alcohol (40–55%); hydroxycinnamic acids are also water-extractable. Root is the primary medicinal part.',
    false
  );

  -- Self Heal (Prunella vulgaris): rosmarinic acid (hydroxycinnamic acid dimer),
  -- ursolic acid (triterpene), flavonoids, iridoids
  PERFORM herbal.set_menstruum(
    'Prunella vulgaris', 25, 50, NULL, NULL, true,
    '25–50% alcohol or water decoction',
    'Rosmarinic acid and flavonoids are water-extractable; ursolic acid (triterpene) requires moderate alcohol (up to 50%). Aerial parts are the medicinal form.',
    false
  );

  -- Shepherd''s Purse (Capsella bursa-pastoris): flavonoids (quercetin, diosmetin),
  -- oxalate, cyclic peptides — polar constituents
  PERFORM herbal.set_menstruum(
    'Capsella bursa-pastoris', 25, 40, NULL, NULL, true,
    '25–40% alcohol or water infusion',
    'Quercetin and diosmetin glycosides and cyclic peptides are polar; water and 25–40% alcohol both effective. Aerial parts are the medicinal form; use fresh plant when possible.',
    false
  );

  -- Sorrel (Rumex acetosa): oxalates, flavonoids (quercetin), tannins,
  -- anthraquinone traces
  PERFORM herbal.set_menstruum(
    'Rumex acetosa', 25, 40, NULL, NULL, true,
    '25–40% alcohol or water',
    'Oxalates, quercetin glycosides, and tannins are polar and water/low-alcohol extractable. Aerial parts (leaf and stem) are the medicinal form; avoid excessive use due to high oxalate content.',
    false
  );

  -- Sundew (Drosera rotundifolia): plumbagin (naphthoquinone — lipophilic),
  -- flavonoids, mucilage
  PERFORM herbal.set_menstruum(
    'Drosera rotundifolia', 50, 65, NULL, NULL, true,
    '50–65% alcohol or water',
    'Plumbagin (naphthoquinone) is moderately lipophilic and requires 50–65% alcohol for full extraction; flavonoids and mucilage are also water-extractable. Aerial parts are the medicinal form; used for respiratory conditions.',
    false
  );

  -- Violet (Viola odorata): rutin (flavonol glycoside), anthocyanins,
  -- salicylic acid, mucilage — all polar
  PERFORM herbal.set_menstruum(
    'Viola odorata', 25, 40, NULL, NULL, true,
    '25–40% alcohol or water infusion',
    'Rutin, anthocyanins, and mucilage are polar; water infusion and 25–40% alcohol both effective. Flower and leaf are the medicinal parts.',
    false
  );

  -- White Mustard (Brassica alba): sinalbin (glucosinolate → 4-hydroxybenzyl
  -- isothiocyanate), fixed oils — glucosinolates are water-soluble
  PERFORM herbal.set_menstruum(
    'Brassica alba', 25, 40, NULL, NULL, true,
    '25–40% alcohol or water',
    'Sinalbin (glucosinolate) is water-soluble; 25–40% alcohol for tincture. Fixed oils not captured in aqueous/alcohol preparations. Seed is the primary medicinal part.',
    false
  );

  -- Wintergreen (Gaultheria procumbens): methyl salicylate (volatile phenylpropanoid
  -- — steam-distillable), arbutin (hydroquinone glycoside — polar)
  PERFORM herbal.set_menstruum(
    'Gaultheria procumbens', 50, 65, NULL, NULL, true,
    '50–65% alcohol or water decoction',
    'Methyl salicylate (volatile phenylpropanoid) is partially lost in water decoction; 50–65% alcohol retains more of the volatile fraction while also extracting arbutin (polar glycoside). Leaf is the medicinal part.',
    false
  );

  -- Yerba Santa (Eriodictyon californicum): eriodictyol (flavanone), resins
  -- (eriodictyon — amorphous), homoeriodictyol
  PERFORM herbal.set_menstruum(
    'Eriodictyon californicum', 50, 65, NULL, NULL, true,
    '50–65% alcohol or water decoction',
    'Eriodictyol (flavanone) and amorphous resins require 50–65% alcohol for meaningful extraction; water decoction less complete for the resin fraction. Leaf is the medicinal part; used for respiratory conditions.',
    false
  );

  RAISE NOTICE 'Batch H (broad flavonoid / iridoid / hydroxycinnamic acid herbs — set_menstruum): 82 records inserted/updated.';
END $$;

-- ── Direct INSERTs for plant-part-specific entries (15) ──

-- Peach leaf (Prunus persica, herb_id 320):
-- Prunasin (cyanogenic glycoside), amygdalin, tannins, flavonoids
INSERT INTO herbal.herb_menstruum
  (herb_id, alcohol_pct_min, alcohol_pct_max, water_effective, primary_label, notes, needs_review)
VALUES (320, 25, 40, true, '25–40% alcohol or water',
  'Prunasin (cyanogenic glycoside) and tannins are water-extractable; 25–40% alcohol for tincture. Leaf used for antispasmodic/expectorant effect. Use dried material only.', false)
ON CONFLICT (herb_id) DO NOTHING;

-- Rose petal (Rosa spp., herb_id 850):
-- Anthocyanins, quercetin, tannins, hydroxycinnamic acids — all polar
INSERT INTO herbal.herb_menstruum
  (herb_id, alcohol_pct_min, alcohol_pct_max, water_effective, primary_label, notes, needs_review)
VALUES (850, 25, 40, true, '25–40% alcohol or water infusion',
  'Anthocyanins, quercetin, and tannins are polar and extract in water and 25–40% alcohol. Water infusion (rose water) is the traditional preparation; petal is the medicinal part.', false)
ON CONFLICT (herb_id) DO NOTHING;

-- Dandelion leaf (Taraxacum officinale, herb_id 1648):
-- Sesquiterpene lactones (taraxacin), hydroxycinnamic acids, flavonoids,
-- potassium-rich — set_menstruum skipped; another entry holds root record
INSERT INTO herbal.herb_menstruum
  (herb_id, alcohol_pct_min, alcohol_pct_max, water_effective, primary_label, notes, needs_review)
VALUES (1648, 25, 40, true, '25–40% alcohol or water',
  'Taraxacin (sesquiterpene lactone), hydroxycinnamic acids, and flavonoids are polar; water and 25–40% alcohol both effective. Leaf is diuretic (high potassium content replaces urinary losses); extract fresh or recently dried leaf.', false)
ON CONFLICT (herb_id) DO NOTHING;

-- Nettle root (Urtica dioica, herb_id 1649):
-- Lectins (UDA — Urtica dioica agglutinin), polysaccharides,
-- phytosterols, phenylpropanoids
INSERT INTO herbal.herb_menstruum
  (herb_id, alcohol_pct_min, alcohol_pct_max, water_effective, primary_label, notes, needs_review)
VALUES (1649, 25, 45, true, '25–45% alcohol or water decoction',
  'Urtica dioica agglutinin (lectin) and polysaccharides are water-soluble; phytosterols require moderate alcohol. 25–45% alcohol for tincture captures the full root profile. Root (not leaf) is used for BPH / anti-androgenic indications.', false)
ON CONFLICT (herb_id) DO NOTHING;

-- Comfrey leaf (Symphytum officinale, herb_id 1650):
-- Allantoin, rosmarinic acid (hydroxycinnamic acid), mucilage —
-- lower pyrrolizidine alkaloid content than root
INSERT INTO herbal.herb_menstruum
  (herb_id, alcohol_pct_min, alcohol_pct_max, water_effective, primary_label, notes, needs_review)
VALUES (1650, 25, 45, true, '25–45% alcohol or water infusion',
  'Allantoin, rosmarinic acid, and mucilage are polar and extract in water and 25–45% alcohol. Leaf contains lower pyrrolizidine alkaloid (PA) levels than root; avoid prolonged internal use and do not use in pregnancy. Topical application is the primary use.', false)
ON CONFLICT (herb_id) DO NOTHING;

-- Elder berry (Sambucus nigra, herb_id 1651):
-- Anthocyanins (sambucyanin, chrysanthemin), flavonols, hydroxycinnamic acids
INSERT INTO herbal.herb_menstruum
  (herb_id, alcohol_pct_min, alcohol_pct_max, water_effective, primary_label, notes, needs_review)
VALUES (1651, 25, 40, true, '25–40% alcohol or water',
  'Anthocyanins (sambucyanin) and flavonols are polar; water syrup/decoction is the traditional preparation. 25–40% alcohol for tincture. Berry is the medicinal part; raw berries contain sambunigrin (cyanogenic glycoside) — use only cooked or processed preparations.', false)
ON CONFLICT (herb_id) DO NOTHING;

-- Hawthorn leaf & flower (Crataegus spp., herb_id 1652):
-- OPCs (oligomeric proanthocyanidins), vitexin, vitexin-2''-O-rhamnoside (C-glycosyl
-- flavones), hyperoside — all polar to amphipathic
INSERT INTO herbal.herb_menstruum
  (herb_id, alcohol_pct_min, alcohol_pct_max, water_effective, primary_label, notes, needs_review)
VALUES (1652, 25, 45, true, '25–45% alcohol or water decoction',
  'OPCs, vitexin (C-glycosyl flavone), and hyperoside are amphipathic and extract in water and 25–45% alcohol. Leaf and flower combination provides the cardiotonic flavonoid spectrum; standardised extracts typically specify vitexin-2''-O-rhamnoside content.', false)
ON CONFLICT (herb_id) DO NOTHING;

-- Chicory root (Cichorium intybus, herb_id 2227):
-- Inulin (fructo-oligosaccharide), sesquiterpene lactones (lactucopicrin,
-- chicoriin), hydroxycinnamic acids (chicoric acid)
INSERT INTO herbal.herb_menstruum
  (herb_id, alcohol_pct_min, alcohol_pct_max, water_effective, primary_label, notes, needs_review)
VALUES (2227, 35, 55, true, '35–55% alcohol or water decoction',
  'Inulin (fructo-oligosaccharide) and chicoric acid (hydroxycinnamic acid) are water-soluble; lactucopicrin (sesquiterpene lactone) requires moderate alcohol (35–55%). Root is the medicinal part; inulin fraction is only bioactive in aqueous preparations.', false)
ON CONFLICT (herb_id) DO NOTHING;

-- Gotu Kola aerial parts (Centella asiatica, herb_id 2229):
-- Asiaticoside, madecassoside (triterpenoid saponins — amphipathic),
-- asiatic acid, madecassic acid (triterpenoid aglycones — lipophilic)
INSERT INTO herbal.herb_menstruum
  (herb_id, alcohol_pct_min, alcohol_pct_max, water_effective, primary_label, notes, needs_review)
VALUES (2229, 25, 50, true, '25–50% alcohol or water decoction',
  'Asiaticoside and madecassoside (triterpenoid saponin glycosides) are amphipathic and water-extractable; the free aglycones (asiatic acid, madecassic acid) require moderate alcohol. 25–50% captures both the glycoside and aglycone fractions.', false)
ON CONFLICT (herb_id) DO NOTHING;

-- Grindelia flowering tops (Grindelia squarrosa, herb_id 2231):
-- Grindelic acid (diterpene resin acid — lipophilic), flavonoids, phenylpropanoids
INSERT INTO herbal.herb_menstruum
  (herb_id, alcohol_pct_min, alcohol_pct_max, water_effective, primary_label, notes, needs_review)
VALUES (2231, 50, 65, true, '50–65% alcohol or water decoction',
  'Grindelic acid (labdane diterpene resin acid) is moderately lipophilic and requires 50–65% alcohol for full extraction; flavonoids are also water-extractable. Flowering tops and buds are the medicinal part.', false)
ON CONFLICT (herb_id) DO NOTHING;

-- Hibiscus calyx (Hibiscus sabdariffa, herb_id 2233):
-- Anthocyanins (delphinidin-3-sambubioside, cyanidin-3-sambubioside),
-- hydroxycinnamic acids, organic acids (citric, malic, tartaric)
INSERT INTO herbal.herb_menstruum
  (herb_id, alcohol_pct_min, alcohol_pct_max, water_effective, primary_label, notes, needs_review)
VALUES (2233, 25, 40, true, '25–40% alcohol or water',
  'Anthocyanins and organic acids are highly water-soluble; water infusion (hibiscus tea) is the primary traditional preparation. 25–40% alcohol for tincture. Calyx is the medicinal part.', false)
ON CONFLICT (herb_id) DO NOTHING;

-- Japanese Honeysuckle flower bud (Lonicera japonica, herb_id 2234):
-- Chlorogenic acid and isomers (hydroxycinnamic acids), luteolin
-- (flavone), iridoid glycosides (loganin, secologanin)
INSERT INTO herbal.herb_menstruum
  (herb_id, alcohol_pct_min, alcohol_pct_max, water_effective, primary_label, notes, needs_review)
VALUES (2234, 25, 45, true, '25–45% alcohol or water decoction',
  'Chlorogenic acid (hydroxycinnamic acid), luteolin, and iridoid glycosides are polar; water decoction (Jin Yin Hua in TCM) is the traditional preparation. 25–45% alcohol for tincture. Flower bud is the medicinal part.', false)
ON CONFLICT (herb_id) DO NOTHING;

-- White Peony root (Paeonia lactiflora, herb_id 2238):
-- Paeoniflorin (monoterpene glycoside — amphipathic), paeonol (phenol —
-- moderately lipophilic), albiflorin, oxypaeoniflorin
INSERT INTO herbal.herb_menstruum
  (herb_id, alcohol_pct_min, alcohol_pct_max, water_effective, primary_label, notes, needs_review)
VALUES (2238, 25, 50, true, '25–50% alcohol or water decoction',
  'Paeoniflorin (monoterpene glycoside) is amphipathic and water-extractable; paeonol (phenol) requires moderate alcohol. 25–50% captures both fractions. Root is the medicinal part (Bai Shao in TCM); water decoction is the traditional preparation.', false)
ON CONFLICT (herb_id) DO NOTHING;

-- Pipsissewa aerial parts (Chimaphila umbellata, herb_id 2239):
-- Arbutin (hydroquinone glycoside — polar), chimaphilin (quinone),
-- ursolic acid (triterpene), tannins
INSERT INTO herbal.herb_menstruum
  (herb_id, alcohol_pct_min, alcohol_pct_max, water_effective, primary_label, notes, needs_review)
VALUES (2239, 25, 45, true, '25–45% alcohol or water decoction',
  'Arbutin and tannins are polar; chimaphilin (quinone) requires moderate alcohol. 25–45% alcohol captures the full profile. Aerial parts are the medicinal form; used for urinary tract conditions.', false)
ON CONFLICT (herb_id) DO NOTHING;

-- Spilanthes aerial parts (Acmella oleracea, herb_id 2363):
-- Spilanthol (N-isobutylamide alkylamide — lipophilic, produces tingling sensation)
-- — alkylamides require high alcohol; not water-extractable
INSERT INTO herbal.herb_menstruum
  (herb_id, alcohol_pct_min, alcohol_pct_max, water_effective, primary_label, notes, needs_review)
VALUES (2363, 60, 70, false, '60–70% alcohol',
  'Spilanthol (N-isobutylamide alkylamide) is lipophilic and responsible for the characteristic tingling/numbing sensation; requires 60–70% alcohol for meaningful extraction and is not water-extractable. Aerial parts (especially flower heads) are the medicinal form.', false)
ON CONFLICT (herb_id) DO NOTHING;
