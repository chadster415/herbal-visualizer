# Inferring Taste from Constituents

Rules for assigning first-pass taste to herbs based on constituent profile, with confidence levels and SQL patterns for marking values as inferred. Follows the same methodology as [inferring-energetics-from-constituents.md](inferring-energetics-from-constituents.md).

Taste is the most subjective of the herbal properties and the most dependent on form of preparation, plant part, and processing. These rules assign the **dominant taste perception** of the whole herb in its most common preparation. Many herbs have a secondary or tertiary taste that cannot be captured by the single-value `taste_energetic` enum.

## Applied so far

| Migration | Herbs | Breakdown |
|---|---|---|
| 171 | 17 | 10 bitter, 5 pungent, 2 sweet |
| 172 | 100 | 62 bitter, 31 pungent, 7 sweet |
| 191 | 3 | 3 bitter (cardiac glycoside rule — new rule added August 2026) |
| **Total** | **120** | **75 bitter, 36 pungent, 9 sweet** |

---

## Rules

### Bitter

#### Iridoid / secoiridoid / epoxide iridoid glycoside — High confidence

Iridoid and secoiridoid glycosides are the dominant bitter principles in the Gentianaceae, Plantaginaceae, Scrophulariaceae, and related families. The bitterness of gentian, devil's claw, bogbean, and centaury all derive from this compound class. Epoxide iridoids (valepotriates) in Valerian are structurally related and similarly bitter.

**Threshold:** major or primary in `herb_constituents`, OR High/Moderate importance with Marker/Major/Present status in `constituent_profiles`.

**Herbs (confirmed):** Valerian, Devil's Claw, Balmony, Blue Flag, Bogbean, Centaury, Chasteberry, Cleavers, Eyebright, Figwort, Fringetree, Hardy Rubber Tree, Kutki, Olive, Partridgeberry, Plantain, Black Root, Silk Tassel (elliptica), Wood Betony

**Confounders:** Rehmannia has catalpol (iridoid at major) but traditional TCM classification assigns sweet to the processed root (Shu Di Huang). Japanese Honeysuckle has loganin/sweroside but is classified as sweet in TCM (Jin Yin Hua). Do not override TCM taste conventions with this rule.

---

#### Sesquiterpene lactone — High confidence

Sesquiterpene lactones are the primary bitter principles of the Asteraceae family. The compound class is structurally diverse but universally bitter. The α-methylene-γ-lactone moiety binds to taste receptors and also drives the anti-inflammatory activity.

**Threshold:** major or primary in `herb_constituents`, OR High/Moderate importance with Major/Marker status in `constituent_profiles`. Sesquiterpene lactone at **moderate** does not meet the threshold (see Mugwort conflict below).

**Herbs (confirmed):** Burdock, Blessed Thistle, Chicory, Feverfew, Wild Lettuce

**Confounders:**
- **Chamomile**: matricin (sesquiterpene lactone, High/Major in profiles) fires the bitter rule, but alpha-bisabolol and chamazulene (3 sesquiterpene volatile categories at primary/major in herb_constituents) also fire the pungent rule. Chamomile is both bitter and aromatic. **Skip** — genuinely ambiguous; do not infer taste.
- **Mugwort**: artabsin (sesquiterpene lactone, moderate — NOT major+). Bitter rule does not fire. Pungent rule fires from 3 volatile categories. Assigned pungent.
- **Chicory**: co-occurring inulin (polysaccharide) fires the sweet rule, but bitter sesquiterpene lactones dominate taste perception in the whole root. Bitter overrides sweet.

---

#### Anthraquinone — High confidence

Anthraquinone glycosides produce both the cooling temperature energetic and the bitter taste. The rule was established empirically across 6 herbs in the energetics dataset with no counter-examples.

**Threshold:** any level in `herb_constituents`; High/Moderate with Marker/Major/Present in `constituent_profiles`.

**Herbs (confirmed):** Yellow Dock, Buckthorn, Madder, Senna

---

#### Flavan-3-ol (catechin) — High confidence

Flavan-3-ols (epicatechin, EGCG, catechin) produce the characteristic bitter/astringent taste of green tea, black tea, and catechu. At major or primary concentrations, they define the taste experience.

**Threshold:** major or primary in `herb_constituents`, OR High/Moderate with Marker/Major in `constituent_profiles`.

**Herbs (confirmed):** Tea (Camellia sinensis), Black Catechu

Note: Flavan-3-ols also fire the drying moisture rule in energetics inference. Both inferences may apply simultaneously to the same herb.

---

#### Alpha/beta hop acid and acylphloroglucinol — High confidence

Humulone and lupulone (alpha and beta acids of hops) and hyperforin (acylphloroglucinol of St. John's Wort) are resinous bitter compounds unique to their respective herbs. No general rule covers this class; these are named-compound assignments.

**Herbs (confirmed):** Hops, St. John's Wort

---

#### Alkaloid — Moderate confidence

Alkaloids are almost universally bitter to the human palate. The rule applies broadly across alkaloid subclasses (isoquinoline, quinolizidine, purine, pyrrolizidine, phenethylamine, piperidine, indole, beta-carboline). Confidence is **Moderate** because:

1. Not all alkaloids taste bitter at physiological concentrations encountered in herbal preparations (some taste sour or are perceived primarily by their physiological effect, not taste).
2. When a strong sweet (mucilaginous polysaccharide primary) counter-signal is present, alkaloid bitterness may be secondary in taste perception.

**Threshold:** major or primary in `herb_constituents`, OR High importance with Marker/Major status in `constituent_profiles`.

**Herbs (confirmed):** Wild Indigo, Barberry, Bloodroot, Boldo, Celandine, Corydalis, Cramp Bark, Fenugreek, Fumitory, Goat's Rue, Goldenseal, Guarana, Ipecac, Kola, Kola Nut, Lesser Periwinkle, Life Root, Ma Huang, Mulberry Leaf, Periwinkle, Peyote, Poppy, Prickly Ash, Ragwort, Rue, Scotch Broom, Silk Tassel (fremontii), Skunk Cabbage, Western Coltsfoot, Yellow Jasmine, Yerba Mate, Yohimbe

**Confounders:**
- **Comfrey**: alkaloids at major (pyrrolizidine) but polysaccharide/mucilage at primary. Sweet taste is dominant in traditional description; sweet assigned. Bitter not inferred.
- **Boldo**: alkaloids (boldine, High/Marker) + 3 volatile subcategories. Bitter signal is pharmacologically primary (boldine is the herb's defining constituent). Assigned bitter despite pungent co-signal.
- **Stoneroot**: alkaloids at major + 3 volatile categories. Genuinely conflicting; skipped.

---

#### Ellagitannin / condensed tannin — Moderate confidence

High-molecular-weight tannins (ellagitannins, gallotannins, proanthocyanidins) produce a characteristic astringent-bitter taste. "Astringent" is not a taste in the five-taste model so these herbs are mapped to **bitter**. Confidence is **Moderate** because tannin bitterness is often secondary to the puckering astringency that dominates the sensory experience.

**Threshold:** major or primary in `herb_constituents`, OR High/Moderate with Marker/Major in `constituent_profiles`.

**Herbs (confirmed):** Agrimony, Raspberry, Blackberry, Cranesbill, Horse Chestnut, White Pond Lily, Witch Hazel

**Confounders:**
- **Indian Gooseberry (Amla)**: emblicanins (ellagitannin, High/Marker → bitter) but Amla is traditionally classified as primarily **sour** from its very high organic acid content. The organic acid signal is not captured in current constituent data. Skipped — traditional sour classification probably correct.

---

#### Labdane diterpene (marrubiin) — High confidence, herb-specific

Marrubiin is the established bitter principle of Horehound (*Marrubium vulgare*) and has been formally assessed in bitter tonic pharmacology. This is a **named-compound exception**, not a general rule for labdane diterpenes (e.g., forskolin from Coleus does not produce bitter taste).

**Herbs (confirmed):** Horehound

---

#### Cardenolide / bufadienolide cardiac glycoside — High confidence (mechanism-based)

Cardenolides (e.g., convallatoxin, evobioside, digitoxin) and bufadienolides (e.g., scillaren A, proscillardin A) are intensely bitter by direct TAS2R bitter taste receptor activation — the same mechanism responsible for the well-documented bitterness of Digitalis glycosides. This rule is established from pharmacological mechanism rather than dataset correlation, which is why it is classified High confidence despite having fewer than 5 confirmed examples in the current herb dataset. All three cardiac-glycoside-dominant herbs in this DB are confirmed bitter in primary literature.

**Threshold:** cardenolide glycoside, cardenolide cardiac glycoside, cardiac glycoside, or bufadienolide glycoside at **major or primary** in `herb_constituents`. Generic "cardiac glycosides" category entries at major also fire the rule. The threshold excludes trace/minor cardiac glycoside contamination (e.g., some Digitalis leaves at negligible cardenolide content).

**Covers:** Cardenolide aglycone categories (bufadienolide aglycone, cardenolide aglycone) at major+ also qualify.

**Herbs (confirmed in DB):** Lily of the Valley, Wahoo, Squill

**Confounders:** None identified. The class is universally bitter in herbal tradition and TAS2R pharmacology. No sweet polysaccharide counter-signal has been observed for cardiac-glycoside-dominant herbs.

---

### Pungent

#### 3+ distinct volatile monoterpene/terpenoid subcategories — High confidence

The volatile oil dominated herbs of the Lamiaceae, Apiaceae, Cupressaceae, and related families are pungent. The rule fires when three or more distinct subcategories of volatile terpenoids are present. This approach tolerates the fact that individual monoterpenes may differ between specimens and cultivars; the pattern of diversity is more reliable than any single compound.

Volatile subcategory sets used:

**From `herb_constituents` (category field):**
monoterpene, bicyclic monoterpene, monoterpene alcohol, bicyclic monoterpene alcohol, monoterpene ketone, bicyclic monoterpene ketone, monoterpene oxide, monoterpene phenol, monoterpene ester, bicyclic monoterpene ester, monoterpene aldehyde, monoterpene furan, sesquiterpene, phenylpropanoid, resin

**From `constituent_profiles` (subclass field):**
Monoterpene, Monoterpene alcohol, Monoterpene aldehyde, Monoterpene ester, Monoterpene ketone, Monoterpene oxide, Monoterpenoid, Monoterpenoid phenol, Sesquiterpene, Sesquiterpene alcohol, Sesquiterpenoid, Phenylpropene, Phenylpropanoid ester, Aromatic aldehyde, Aromatic ester

Counts from the two tables are summed. The combined count captures herbs with rich volatile profiles documented primarily in profiles (e.g., Aniseed, Bergamot) and those primarily in herb_constituents (e.g., Peppermint, Sage).

**Herbs (confirmed):** Hyssop, Peppermint, Sage, Juniper, Lemon Balm, Agastache, Aniseed, Asian Mint, Balsam of Peru, Basil, Bergamot, Buchu, Cinnamon, Clary Sage, Coriander, Dill, Dwarf Pine, Eucalyptus, Guggul, Holy Basil, Marjoram, Mugwort, Myrrh, Neroli, Osha, Sassafras, Scots Pine, Southernwood, Sweet Orange, Tansy, Tea Tree, Thuja, Tolu Balsam, Wild Carrot, Yerba Mansa, Ylang Ylang

**Confounders:**
- **Chamomile**: 3 volatile sesquiterpene categories from herb_constituents (primary/major) → pungent rule fires. Also has sesquiterpene lactone matricin in profiles → bitter rule fires from profiles. Genuinely ambiguous. **Skip** — both signals are substantial.
- **Mugwort**: artabsin (sesquiterpene lactone) at **moderate** (not major+) → bitter rule does NOT fire. Pungent rule fires (3 volatile categories). Assigned pungent.
- **Boldo**: 3 volatile categories → pungent fires. Boldine alkaloid at High/Marker → bitter fires. Bitter assigned as pharmacologically primary.
- **Stoneroot**: alkaloids at major + 3 volatile categories. Both signals are substantial. **Skip**.
- **Benzoin**: resin-dominant with volatile subclasses in profiles (3 total), but the taste is characteristically sweet-balsamic rather than pungent. **Skip** — resin-only pungent signal with atypical taste character.

---

#### Phenylpropanoid at moderate+ — High confidence

Phenylpropanoids (trans-anethole, eugenol, cinnamaldehyde, safrole, methyleugenol) are the dominant volatile compounds in spices and strongly pungent herbs. This rule fires in addition to or instead of the volatile count rule.

**Threshold:** moderate or above in `herb_constituents`, OR High/Moderate with Marker/Major/Present in `constituent_profiles`.

**Already covered** by the volatile rule for most herbs (Cinnamon, Basil, Sassafras, etc.), since phenylpropanoid is included in the volatile category set.

---

### Sweet

#### Polysaccharide / mucilage at major/primary — High confidence

Mucilaginous polysaccharides form the physical substance of sweet-tasting demulcent herbs. The sweetness arises from the neutral polysaccharide backbone coating the mucous membranes rather than from discrete taste receptor binding. Presence of minor bitter alkaloids or iridoids does not override the dominant sweet-mucilaginous perception when polysaccharide is at primary level.

**Threshold:** major or primary in `herb_constituents`, OR High/Moderate with Marker/Major in `constituent_profiles`.

**Categories:** polysaccharide, mucilage, acidic polysaccharide, fructo-oligosaccharide; Profile class: Polysaccharide

**Herbs (confirmed):** Marshmallow, Linden, Coltsfoot, Comfrey (root and leaf), Couch Grass, Dang Shen, Iceland Moss, Mullein leaf

**Conflict resolution rules:**
- **Sweet vs bitter (iridoid):** If polysaccharide is at **primary** and iridoid is at **major**, assign sweet. Example: Mullein leaf. If both are at primary, evaluate traditional description — Mullein = sweet.
- **Sweet vs bitter (alkaloid):** If polysaccharide is at **primary** and alkaloid is at **major**, assign sweet. Example: Comfrey. Alkaloids may be pharmacologically active but are taste-secondary at these concentrations.
- **Sweet vs bitter (sesquiterpene lactone):** If sesquiterpene lactone is at **major or primary**, bitter wins regardless of polysaccharide level. Example: Chicory has inulin at major AND lactucin at major → bitter.

**Herbs skipped:**
- **Reishi Mushroom**: beta-glucans (polysaccharide, primary → sweet) vs ganoderic acids (triterpenoid, primary). Ganoderic acids are bitter triterpenes and define the characteristic bitter taste of reishi. However, no general triterpenoid → bitter rule has been validated against the dataset. Skip pending validation.
- **Irish Moss**: carrageenan polysaccharides at major, but taste is oceanic/bland rather than sweet in the herbal sense. Skip.
- **Siberian Ginseng**: polysaccharides at major but taste is mild/bland; eleutherosides at primary are a mixed phenylpropanoid-lignan glycoside class not matching clean rules. Skip.

---

### Sour

#### Organic acid at major/primary — High confidence

**Threshold:** major or primary in `herb_constituents`.

**Herbs in dataset matching this rule:** Spinach (oxalic acid, major), Wild Lettuce (lactucic acid, major).

- **Wild Lettuce** was assigned **bitter** because lactucin + lactucopicrin (sesquiterpene lactones, primary) fire the sesquiterpene lactone bitter rule, which outranks organic acid. Bitter assigned.
- **Spinach** has only one matching signal (oxalic acid, major) with no competing bitter signal → would qualify as **sour**. However, oxalic acid produces more of an astringent-mineral sensation than a prototypical sour taste. Note for future consideration.

No herbs in the current dataset have been assigned sour by inference.

**Traditional sour herbs** (Indian Gooseberry, Hibiscus, Rose Hip, Lemon Balm berries) are better assigned from primary taste source data than constituent inference; their organic acids are not consistently captured in herb_constituents.

---

### Salty

#### Mineral at major/primary — Moderate confidence

**Threshold:** major or primary in `herb_constituents`.

**Herbs matching this rule in dataset:** Corn Silk (potassium, major), Couch Grass (silica, major), Spinach (iron, major).

These herbs are **not** assigned salty because:
- Potassium in plant-bound form does not taste distinctly salty
- Silica has no taste
- Iron contributes a metallic note, not salty

No herbs in the current dataset receive an inferred salty taste. Genuinely salty-tasting herbs (Nettle, Kelp, Bladderwrack) have their saltiness from overall mineral density and oceanic context, which is better documented from primary taste sources than from individual mineral constituent entries.

---

## Conflict resolution hierarchy

When multiple taste signals fire for the same herb, apply this priority order:

1. **Pungent signal (volatile, 3+ categories) + NO major bitter principle** → pungent
2. **Bitter (sesquiterpene lactone major+)** → bitter, overrides sweet (polysaccharide) and sour (organic acid)
3. **Bitter (iridoid major+)** → bitter; if polysaccharide is also at primary, evaluate traditional description; polysaccharide-primary herbs with well-documented sweet character (Mullein) may be assigned sweet
4. **Bitter (alkaloid major+)** → bitter; if polysaccharide is at primary and traditional description is sweet (Comfrey), assign sweet
5. **Sweet (polysaccharide primary)** → sweet, unless competing bitter sesquiterpene lactone is also at major+
6. **Sour (organic acid major+)** → sour, unless competing sesquiterpene lactone is also at major+ (bitter overrides)
7. **Pungent + Bitter (both clear signals)** → skip; record in skipped section

---

## Herbs skipped (conflict or insufficient data)

| Herb | Conflict |
|---|---|
| Chamomile | sesquiterpene lactone (profiles, High/Major → bitter) + 3 volatile sesquiterpene categories (HC, primary → pungent) |
| Reishi Mushroom | ganoderic acids (triterpenoid, primary → would be bitter) + beta-glucans (polysaccharide, primary → sweet); no triterpenoid-bitter rule validated |
| Stoneroot | alkaloid (major → bitter) + 3 volatile categories (→ pungent) |
| Indian Gooseberry | ellagitannins (High/Marker → bitter) vs traditional sour classification from high organic acid content |
| Irish Moss | polysaccharides major but taste is oceanic/bland, not classically sweet |
| Siberian Ginseng | mild taste; no clean signal from current constituent categories |
| Rehmannia | catalpol (iridoid, major → bitter) conflicts with TCM sweet classification (Shu Di Huang) |
| Japanese Honeysuckle | iridoid glycosides → bitter conflicts with TCM sweet classification (Jin Yin Hua) |
| Benzoin | 3 resin-category volatile subclasses → pungent signal but sweet-balsamic traditional character |
| Privet (Ligustrum) | multiple secoiridoids (High/Marker → bitter) but TCM taste is "bitter and sweet" |

---

## How the UI uses this

The `InferredTasteModal` component re-runs `analyzeTaste(herbConstituents, profiles)` on the herb's constituent data at render time to display which rules fired and which constituents triggered them. The modal is opened by the amber `i` button that appears next to the inferred taste badge in the herb detail view.

Inferred taste badges appear in gray with italic "inferred" text, distinct from confirmed taste badges (green). This follows the same visual language as inferred energetics.

The `taste_inferred` flag in the database is the source of truth for which herbs received inferred taste. The modal's `analyzeTaste()` function may produce slightly different results if the constituent data changes, since it re-analyzes live data rather than reading the flag logic from the migration.
