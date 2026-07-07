-- Migration: Add editorial notes to constituent profiles (batch A-N)
-- 59 of 64 herbs; missing: Chicory, European Mistletoe, Grape Seed, Kelp, Pill-Bearing Spurge

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Agrimony is chemically defined by its tannin-rich polyphenol fraction, which accounts for much of its traditional astringent, gastrointestinal, and wound-healing activity. The inclusion of volatile terpenoids preserves the herb''s mild aromatic digestive properties while maintaining emphasis on the tannins that distinguish its medicinal chemistry.'
  WHERE common_name = 'Agrimony'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Aloe is defined by two chemically distinct medicinal fractions: the mannan-rich gel polysaccharides responsible for its demulcent and immunomodulating properties, and the anthraquinone glycosides of the latex that account for its stimulant laxative activity. Representing both fractions preserves the unique dual chemistry that distinguishes the species.'
  WHERE common_name = 'Aloe'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Angelica is chemically defined by its coumarins and aromatic essential oil constituents, which together account for much of its traditional circulatory, digestive, and antispasmodic activity. The inclusion of representative monoterpenes complements the characteristic coumarin chemistry while preserving the herb''s distinctive aromatic profile.'
  WHERE common_name = 'Angelica'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Aniseed is defined almost entirely by its phenylpropanoid-rich volatile oil, particularly trans-anethole, which accounts for its characteristic aroma and traditional carminative, expectorant, and antispasmodic uses. Minor aromatic constituents are included to represent the complete flavor profile while preserving the dominance of anethole.'
  WHERE common_name = 'Aniseed'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Arnica is chemically defined by its sesquiterpene lactones, particularly the helenalin derivatives, which account for much of its well-known topical anti-inflammatory activity. Flavonoids provide complementary antioxidant effects, but the profile intentionally emphasizes the lactone chemistry that distinguishes the genus.'
  WHERE common_name = 'Arnica'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Arogyappacha is defined primarily by its unique glycolipid chemistry, especially the arachyldigalactosides that underlie its adaptogenic reputation. The inclusion of flavonoids preserves the supporting antioxidant fraction while maintaining emphasis on the uncommon lipid constituents that distinguish the species.'
  WHERE common_name = 'Arogyappacha'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Artichoke is chemically defined by its caffeoylquinic acids together with its bitter sesquiterpene lactones, which account for much of its traditional hepatic, cholagogue, and digestive activity. The profile balances these complementary constituent families while preserving the hydroxycinnamate chemistry that characterizes the leaf.'
  WHERE common_name = 'Artichoke'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Ashwagandha is defined almost entirely by its withanolides, which account for much of its adaptogenic, anti-inflammatory, and neuroprotective reputation. The profile intentionally emphasizes representative members of this highly characteristic steroidal family before introducing minor supporting constituents, preserving the chemistry that distinguishes the genus.'
  WHERE common_name = 'Ashwagandha'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Asian Devil''s Club is chemically defined by its polyacetylenes together with characteristic triterpenoids, which account for much of its traditional adaptogenic, antimicrobial, and anti-inflammatory activity. The profile emphasizes these distinctive constituent families while avoiding common metabolites that contribute little to the species'' chemical identity.'
  WHERE common_name = 'Asian Devil''s Club'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Aspen is defined primarily by its phenolic glycosides, particularly the salicylate derivatives that account for its traditional analgesic, antipyretic, and anti-inflammatory uses. Representative flavonoids provide a complementary antioxidant fraction while preserving the salicylate chemistry that distinguishes the bark.'
  WHERE common_name = 'Aspen'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Balm of Gilead is chemically defined by its salicylate glycosides together with aromatic resin constituents, which account for much of its traditional analgesic, anti-inflammatory, and topical wound-healing activity. The profile preserves both the phenolic and resinous fractions that distinguish the fragrant poplar buds from the bark.'
  WHERE common_name = 'Balm of Gilead'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Balmony is defined primarily by its intensely bitter iridoid glycosides, which account for its longstanding use as a digestive and hepatic tonic. The inclusion of supporting flavonoids preserves the herb''s complementary antioxidant chemistry while maintaining emphasis on the bitter iridoid fraction that defines the species.'
  WHERE common_name = 'Balmony'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Balsam of Peru is chemically defined by its aromatic esters and phenylpropanoids, which account for its characteristic fragrance, antimicrobial activity, and historical use in wound care. The profile emphasizes these resin-derived aromatic constituents while avoiding nonspecific resin components that contribute little to the herb''s chemical identity.'
  WHERE common_name = 'Balsam of Peru'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Barberry is defined almost entirely by its isoquinoline alkaloids, particularly berberine and its related congeners, which account for much of its antimicrobial, bitter tonic, and gastrointestinal activity. The profile intentionally emphasizes this highly characteristic alkaloid chemistry before introducing unrelated supporting constituents.'
  WHERE common_name = 'Barberry'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Bayberry is chemically defined by its tannins together with characteristic flavonoids and triterpenoids, which account for much of its traditional astringent, circulatory, and mucosal tonic activity. The profile preserves the dominant astringent chemistry while representing the secondary constituents that contribute to the bark''s medicinal character.'
  WHERE common_name = 'Bayberry'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Bearberry is chemically defined by its hydroquinone glycosides, particularly arbutin, which account for much of its traditional urinary antiseptic activity. Hydrolyzable tannins provide complementary astringent effects while preserving the dominant phenolic glycoside chemistry that distinguishes the leaves.'
  WHERE common_name = 'Bearberry'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Birch is defined primarily by its pentacyclic triterpenoids and salicylate derivatives, which account for much of its traditional anti-inflammatory, analgesic, and topical applications. The inclusion of both constituent families preserves the complementary bark chemistry that distinguishes the genus.'
  WHERE common_name = 'Birch'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Bistort is chemically defined by its exceptionally tannin-rich polyphenol fraction, which accounts for much of its traditional astringent use in gastrointestinal disorders and wound care. Representative flavonoids provide complementary antioxidant activity while maintaining emphasis on the tannins that distinguish the rhizome.'
  WHERE common_name = 'Bistort'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Black catechu is defined almost entirely by its condensed tannins and catechin derivatives, which account for its intense astringency and longstanding use for gastrointestinal and oral conditions. The profile intentionally emphasizes these characteristic polyphenols while minimizing unrelated supporting constituents.'
  WHERE common_name = 'Black Catechu'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Black cohosh is chemically defined by its cycloartane triterpene glycosides, which account for much of its traditional use in women''s health and musculoskeletal conditions. The inclusion of phenolic acids preserves the secondary antioxidant fraction while maintaining emphasis on the distinctive triterpene chemistry that characterizes the rhizome.'
  WHERE common_name = 'Black Cohosh'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Black haw is chemically defined by its coumarins together with characteristic iridoids and triterpenoids, which account for much of its traditional antispasmodic activity, particularly for smooth muscle. The profile emphasizes the coumarin-rich chemistry while preserving representative constituents that contribute to the bark''s distinctive uterine and gastrointestinal actions.'
  WHERE common_name = 'Black Haw'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Black root is defined primarily by its iridoid glycosides, which account for its intensely bitter character and traditional hepatic and digestive applications. The inclusion of supporting phenolic constituents preserves the complementary antioxidant fraction while maintaining emphasis on the iridoids that distinguish the root.'
  WHERE common_name = 'Black Root'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Blackberry is chemically defined by its tannin-rich polyphenol fraction, which accounts for much of its traditional astringent use for gastrointestinal disorders and mucosal inflammation. Flavonoids and anthocyanins complement this dominant tannin chemistry while preserving the characteristic phytochemical profile of the leaves and fruit.'
  WHERE common_name = 'Blackberry'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Bloodroot is defined almost entirely by its benzophenanthridine alkaloids, particularly sanguinarine and chelerythrine, which account for both its antimicrobial activity and significant toxicity. The profile intentionally focuses on this distinctive alkaloid family because it overwhelmingly defines the pharmacology and chemotaxonomic identity of the species.'
  WHERE common_name = 'Bloodroot'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Blue cohosh is chemically defined by its quinolizidine alkaloids together with characteristic triterpenoid saponins, which account for much of its traditional use in women''s health and smooth muscle physiology. The profile balances these complementary constituent families while preserving the alkaloid chemistry that distinguishes the root.'
  WHERE common_name = 'Blue Cohosh'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Blue flag is chemically defined by its iridoid glycosides together with characteristic quinones and resinous terpenoids, which account for much of its traditional hepatic, lymphatic, and alterative activity. The profile emphasizes these defining constituents while avoiding ubiquitous supporting metabolites.'
  WHERE common_name = 'Blue Flag'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Bogbean is defined primarily by its secoiridoid glycosides, which account for its pronounced bitterness and traditional use as a digestive and hepatic tonic. Representative flavonoids provide complementary antioxidant activity while preserving the bitter glycoside chemistry that distinguishes the leaves.'
  WHERE common_name = 'Bogbean'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Boldo is chemically defined by its aporphine alkaloids together with aromatic monoterpenes, which account for much of its traditional hepatic, digestive, and cholagogue activity. The profile emphasizes boldine and the characteristic volatile oil chemistry that together distinguish the species.'
  WHERE common_name = 'Boldo'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Boneset is chemically defined by its sesquiterpene lactones together with characteristic polysaccharides and flavonoids, which account for much of its traditional immunomodulating, diaphoretic, and bitter tonic activity. The profile balances these constituent families while preserving the sesquiterpene chemistry that characterizes the aerial parts.'
  WHERE common_name = 'Boneset'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Borage is chemically defined by its pyrrolizidine alkaloids together with its distinctive gamma-linolenic acid-rich seed lipids, representing two chemically distinct medicinal fractions. The profile preserves both the nutritional lipid chemistry and the toxicological alkaloid fraction that together define the species.'
  WHERE common_name = 'Borage'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Buchu is chemically defined by its monoterpene-rich volatile oil, particularly sulfur-containing monoterpenes and oxygenated monoterpenes, which account for much of its traditional urinary antiseptic, diuretic, and aromatic digestive activity. The profile emphasizes these characteristic volatile constituents while preserving the chemistry that distinguishes the leaves.'
  WHERE common_name = 'Buchu'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Buckthorn is defined almost entirely by its anthraquinone glycosides, which account for its stimulant laxative activity. The profile intentionally emphasizes these characteristic anthraquinones while excluding ubiquitous supporting metabolites, preserving the chemistry that distinguishes the bark from other medicinal species.'
  WHERE common_name = 'Buckthorn'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Buckwheat is chemically defined by its flavonoid-rich polyphenol fraction, particularly rutin and related flavonols, which account for much of its traditional vascular-protective and antioxidant activity. The profile preserves this distinctive flavonoid chemistry while representing complementary phenolic constituents that support the herb''s medicinal profile.'
  WHERE common_name = 'Buckwheat'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Bugleweed is chemically defined by its phenolic acids together with characteristic flavonoids and terpenoids, which account for much of its traditional endocrine, cardiovascular, and anti-inflammatory activity. The profile emphasizes the abundant phenolic fraction while preserving representative constituents that distinguish the aerial parts.'
  WHERE common_name = 'Bugleweed'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Burdock is chemically defined by its fructan polysaccharides together with caffeoylquinic acids and lignans, which account for much of its traditional alterative, prebiotic, and antioxidant activity. The profile balances these complementary constituent families while preserving the fructan-rich chemistry that distinguishes the root.'
  WHERE common_name = 'Burdock'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Butternut is defined primarily by its naphthoquinones together with characteristic tannins, which account for its traditional antimicrobial, astringent, and cathartic properties. The profile emphasizes the quinone chemistry while preserving representative supporting constituents that characterize the bark.'
  WHERE common_name = 'Butternut'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Calendula is chemically defined by its triterpenoids together with flavonoids and carotenoids, which account for much of its traditional wound-healing, anti-inflammatory, and lymphatic activity. The profile balances these constituent families while preserving the triterpenoid chemistry that most strongly distinguishes the flowers.'
  WHERE common_name = 'Calendula'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'California poppy is defined almost entirely by its isoquinoline alkaloids, which account for its traditional sedative, anxiolytic, and mild analgesic activity. The profile intentionally emphasizes representative members of this characteristic alkaloid family while avoiding unrelated supporting constituents that contribute less to the herb''s identity.'
  WHERE common_name = 'California Poppy'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Caraway is chemically defined by its monoterpene-rich volatile oil, particularly carvone and limonene, which account for its characteristic aroma and traditional carminative, antispasmodic, and digestive activity. The profile preserves this defining volatile chemistry while representing complementary aromatic constituents.'
  WHERE common_name = 'Caraway'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Cardamom is chemically defined by its aromatic monoterpenes and monoterpene esters, which account for its characteristic fragrance and traditional digestive, carminative, and respiratory uses. The profile emphasizes these volatile constituents while preserving the balanced essential oil chemistry that distinguishes the seeds.'
  WHERE common_name = 'Cardamom'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Cascara sagrada is chemically defined by its anthraquinone glycosides, which account for its well-established stimulant laxative activity. The profile intentionally emphasizes these characteristic hydroxyanthracene derivatives while avoiding unrelated supporting constituents, preserving the chemistry that distinguishes the aged bark.'
  WHERE common_name = 'Cascara Sagrada'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Catnip is chemically defined by its iridoid-rich essential oil, particularly the nepetalactones, which account for its characteristic aroma, mild nervine activity, and insect-repellent properties. Representative terpenoids complement this defining chemistry while preserving the volatile profile that distinguishes the genus.'
  WHERE common_name = 'Catnip'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Cayenne is defined almost entirely by its capsaicinoids, which account for its pungency, circulatory stimulation, and analgesic activity. Carotenoids provide a complementary antioxidant fraction, but the profile intentionally emphasizes the capsaicinoid chemistry that overwhelmingly defines the fruit.'
  WHERE common_name = 'Cayenne'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Celandine is chemically defined by its benzophenanthridine and protoberberine alkaloids, which account for much of its traditional biliary, antispasmodic, and antimicrobial activity. The profile intentionally emphasizes these characteristic isoquinoline alkaloids while minimizing unrelated supporting constituents, preserving the chemistry that distinguishes the aerial parts and root.'
  WHERE common_name = 'Celandine'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Celery seed is chemically defined by its phthalides together with aromatic monoterpenes and furanocoumarins, which account for much of its traditional digestive, diuretic, and circulatory activity. The profile emphasizes these distinctive constituent families while preserving the volatile chemistry that characterizes the seeds.'
  WHERE common_name = 'Celery Seed'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Centaury is defined primarily by its secoiridoid glycosides, which account for its intense bitterness and traditional use as a digestive and hepatic tonic. Representative xanthones complement this defining bitter chemistry while preserving the characteristic phytochemical profile of the aerial parts.'
  WHERE common_name = 'Centaury'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Chasteberry is chemically defined by its diterpenoids together with flavonoids and iridoid glycosides, which account for much of its traditional endocrine-modulating activity. The profile balances these complementary constituent families while preserving the diterpenoid chemistry that most strongly distinguishes the fruit.'
  WHERE common_name = 'Chasteberry'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Chickweed is chemically defined by its triterpenoid saponins together with characteristic flavonoids, which account for much of its traditional soothing, alterative, and topical activity. The profile emphasizes the saponin-rich chemistry while preserving complementary polyphenols that contribute to the herb''s medicinal character.'
  WHERE common_name = 'Chickweed'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Coltsfoot is chemically defined by its mucilage polysaccharides together with sesquiterpenes and pyrrolizidine alkaloids, representing both its traditional demulcent activity and its important toxicological profile. The inclusion of both medicinal and toxic constituent families preserves the chemistry that defines the leaves.'
  WHERE common_name = 'Coltsfoot'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Dandelion is chemically defined by its sesquiterpene lactones together with inulin-type fructans and phenolic acids, which account for much of its traditional digestive, hepatic, and prebiotic activity. The profile balances these complementary constituent families while preserving the bitter lactone chemistry that distinguishes the root and leaf.'
  WHERE common_name = 'Dandelion'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Elecampane is chemically defined by its sesquiterpene lactones together with inulin-type fructans, which account for much of its traditional respiratory, digestive, and bitter tonic activity. The profile balances these constituent families while preserving the lactone chemistry that distinguishes the root.'
  WHERE common_name = 'Elecampane'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Garlic is chemically defined by its organosulfur compounds, particularly the cysteine sulfoxides and their enzymatic transformation products, which account for much of its traditional antimicrobial, cardioprotective, and circulatory activity. The profile emphasizes these highly characteristic sulfur constituents while preserving representative lipid-soluble sulfur compounds that complete the bulb''s distinctive chemistry.'
  WHERE common_name = 'Garlic'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Gentian is defined almost entirely by its secoiridoid glycosides, which account for its exceptional bitterness and longstanding use as a digestive and hepatic tonic. The inclusion of xanthones preserves the herb''s complementary phenolic chemistry while maintaining emphasis on the bitter glycosides that distinguish the root.'
  WHERE common_name = 'Gentian'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Ginger is chemically defined by its pungent phenolic ketones together with characteristic sesquiterpenes, which account for much of its traditional digestive, anti-inflammatory, antiemetic, and circulatory activity. The profile balances these complementary constituent families while preserving the gingerol chemistry that most strongly distinguishes the rhizome.'
  WHERE common_name = 'Ginger'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Ginkgo is chemically defined by two complementary constituent families: its terpene lactones and its flavonol glycosides, which together account for much of its traditional cognitive, circulatory, and antioxidant activity. The profile intentionally balances these two defining fractions because both are essential to the herb''s characteristic chemistry and modern standardization.'
  WHERE common_name = 'Ginkgo'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Gravel root is chemically defined by its sesquiterpenes together with characteristic flavonoids and pyrrolizidine alkaloids, which account for much of its traditional urinary, diuretic, and anti-inflammatory activity. The profile emphasizes the sesquiterpene-rich chemistry while preserving representative supporting constituents that characterize the root.'
  WHERE common_name = 'Gravel Root'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Holy basil is chemically defined by its phenylpropanoids together with aromatic terpenoids, which account for much of its traditional adaptogenic, antimicrobial, and anti-inflammatory activity. The profile balances these complementary volatile constituent families while preserving the eugenol-rich chemistry that distinguishes the leaves.'
  WHERE common_name = 'Holy Basil'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Indian gooseberry is chemically defined by its hydrolyzable tannins together with characteristic polyphenols, which account for much of its traditional antioxidant, adaptogenic, and gastrointestinal activity. The profile emphasizes the tannin-rich chemistry that distinguishes the fruit while preserving representative supporting phenolics that complement its medicinal profile.'
  WHERE common_name = 'Indian Gooseberry'
    AND (editorial_note IS NULL OR editorial_note = '');

UPDATE herbal.constituent_profiles
  SET editorial_note = 'Nettles are chemically defined by their flavonoids together with caffeoylquinic acids, lignans, and characteristic lectins, although the dominant chemistry varies between the aerial parts and root. The profile preserves these complementary constituent families while emphasizing the polyphenol-rich chemistry that underlies the herb''s traditional nutritive, anti-inflammatory, and urinary applications.'
  WHERE common_name = 'Nettles'
    AND (editorial_note IS NULL OR editorial_note = '');
