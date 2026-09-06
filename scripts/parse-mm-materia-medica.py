#!/usr/bin/env python3
"""
Parse Michael Moore's Herbal Materia Medica 5.0 and match entries to DB herbs.
Strategy:
  1. Exact Latin name match (case-insensitive, full name or genus-only when genus is unambiguous)
  2. Hand-curated synonym/alternate-name map for known discrepancies
  3. NO common-name fuzzy matching (too many false positives)
Outputs: lib/mm-materia-medica.ts
"""

import re
import subprocess

MM_FILE = "/Users/chadarmstrong/Library/Mobile Documents/com~apple~CloudDocs/Archive/Classes/Health and Plants/BHC/Apprenticeship/App/MM_Materia_Medica.txt"
OUT_TS  = "/Users/chadarmstrong/Library/Mobile Documents/com~apple~CloudDocs/Archive/Classes/Health and Plants/BHC/Apprenticeship/App/herbal-visualizer/lib/mm-materia-medica.ts"

# ── Hand-curated synonym map ──────────────────────────────────────────────────
# Maps MM normalized header (lowercase, no *) → DB latin_name(s) that it should match.
# Add entries here when MM uses old/synonymous/abbreviated names.
SYNONYM_MAP = {
    # MM genus-only → DB latin
    'achillea':              ['achillea millefolium'],
    'aconitum columbianum':  ['aconitum napellus'],    # MM's Western Monkshood → our Aconite entry
    'agrimonia':             ['agrimonia eupatoria'],
    'alchemilla':            ['alchemilla vulgaris'],
    'allium cepa':           ['allium cepa'],
    'aloe':                  ['aloe vera'],
    'alpinia':               ['rhizoma alpiniae officinari'],  # galangal rhizome TCM
    'althea':                ['althaea officinalis'],
    'angelica':              ['angelica archangelica'],
    'apocynum cannabinum':   ['apocynum cannabinum'],
    'arctium':               ['arctium lappa'],
    'arctostaphylos':        ['arctostaphylos uva-ursi', 'arctostaphylos manzanita'],
    'arnica':                ['arnica montana'],
    'artemisia absinthium':  ['artemisia absinthium'],
    'artemisia vulgaris':    ['artemisia vulgaris'],
    'asarum':                ['herba asari cum radice'],  # Chinese wild ginger TCM
    'astragalus membranaceus':['astragalus membranaceus'],
    'atropa belladonna':     [],  # not in MM
    'avena':                 ['avena sativa'],
    'baptisia':              ['baptisia tinctoria'],
    'barosma':               ['agathosma betulina'],  # buchu
    'berberis vulgaris':     ['berberis vulgaris'],
    'betula':                ['betula spp.'],
    'calendula officinalis': ['calendula officinalis'],
    'cannabis sativa':       ['cannabis sativa'],
    'capsella bursa-pastoris':['capsella bursa-pastoris'],
    'capsicum':              ['capsicum annuum'],
    'cardamomum':            ['elettaria cardamomum'],
    'carum':                 ['carum carvi'],
    'caulophyllum':          ['caulophyllum thalictroides'],
    'ceanothus':             ['ceanothus americanus'],
    'centaurium':            ['centaurium erythraea'],
    'cetraria':              ['cetraria islandica'],
    'chelidonium':           ['chelidonium majus'],
    'chelone':               ['chelone glabra'],
    'chionanthus':           ['chionanthus virginicus'],
    'chrysanthemum parthenium': ['tanacetum parthenium'],  # feverfew — old name
    'cimicifuga racemosa':   ['cimicifuga racemosa'],
    'cinnamomum':            ['cinnamomum spp.', 'cinnamomum aromaticum'],
    'cnicus benedictus':     ['cnicus benedictus'],
    'cola nitida':           ['cola acuminata', 'cola vera'],  # kola nut
    'colchicum':             [],  # autumn crocus — not in DB
    'crocus':                ['crocus sativus'],  # true saffron
    'collinsonia':           ['collinsonia canadensis'],
    'commiphora':            ['commiphora molmol'],  # MM entry is about myrrh specifically
    'commiphora molmol':     ['commiphora molmol'],
    'commiphora myrrha':     ['commiphora molmol'],
    'commiphora mukul':      ['commiphora mukul'],
    'convallaria':           ['convallaria majalis'],
    'coriandrum':            ['coriandrum sativum'],
    'crataegus':             ['crataegus spp.'],
    'curcuma':               ['curcuma longa'],
    'cynara':                ['cynara scolymus'],
    'cypripedium':           [],  # lady slipper — not in DB
    'daucus carota':         ['daucus carota'],
    'dioscorea':             ['dioscorea villosa'],
    'dipsacus':              ['radix dipsaci'],  # teasel root TCM
    'drosera':               ['drosera rotundifolia'],
    'echinacea angustifolia':['echinacea angustifolia'],
    'echinacea purpurea':    ['echinacea spp.'],
    'elettaria':             ['elettaria cardamomum'],
    'eleutherococcus':       ['eleutherococcus senticosus'],
    'ephedra':               ['ephedra sinica'],
    'equisetum':             ['equisetum arvense'],
    'eriodictyon':           ['eriodictyon californicum'],
    'eschscholzia':          ['eschscholzia californica'],
    'eucalyptus':            ['eucalyptus spp.'],
    'euonymus atropurpureus':['euonymus atropurpureus'],
    'eupatorium perfoliatum':['eupatorium perfoliatum'],
    'eupatorium purpureum':  ['eupatorium purpureum'],
    'euphrasia':             ['euphrasia spp.'],
    'fagopyrum':             ['fagopyrum esculentum'],
    'filipendula':           ['filipendula ulmaria'],
    'foeniculum':            ['foeniculum vulgare'],
    'fouquieria':            ['fouquieria splendens'],
    'fucus':                 ['fucus vesiculosus'],
    'fumaria':               ['fumaria officinalis'],
    'galega':                ['galega officinalis'],
    'galium aparine':        ['galium aparine'],
    'garrya':                ['garrya fremontii'],
    'gaultheria':            ['gaultheria procumbens'],
    'gelsemium':             ['gelsemium sempervirens'],
    'gentiana':              ['gentiana lutea'],
    'geranium maculatum':    ['geranium maculatum'],
    'ginkgo':                ['ginkgo biloba'],
    'glycyrrhiza':           ['glycyrrhiza glabra'],
    'grindelia':             ['grindelia camporum'],
    'guaiacum officinale':   ['guaiacum officinale'],
    'guayusa':               [],  # Ilex guayusa — confirmed absent from MM
    'hamamelis':             ['hamamelis virginiana'],
    'harpagophytum':         ['harpagophytum procumbens'],
    'humulus':               ['humulus lupulus'],
    'hydrangea':             ['hydrangea arborescens'],
    'hydrastis':             ['hydrastis canadensis'],
    'hypericum':             ['hypericum perforatum'],
    'hyssopus':              ['hyssopus officinalis'],
    'ilex paraguayensis':    ['ilex paraguayensis'],
    'inula':                 ['inula helenium'],
    'iris versicolor':       ['iris versicolor'],
    'juglans cinerea':       ['juglans cinerea'],
    'juglans nigra':         ['juglans nigra'],
    'juglans major':         [],  # Arizona black walnut — not in DB
    'juniperus':             ['juniperus communis'],
    'krameria':              ['krameria triandra'],
    'lactuca virosa':        ['lactuca virosa'],
    'larrea':                ['larrea tridentata'],
    'lavandula':             ['lavandula spp.'],
    'leonurus':              ['leonurus cardiaca'],
    'leptandra virginica':   ['leptandra virginica'],
    'ligusticum porteri':    ['ligusticum porteri'],
    'ligustrum lucidum':     ['ligustrum lucidum'],
    'linum':                 ['linum usitatissimum'],
    'lobelia':               ['lobelia inflata'],
    'lomatium':              ['lomatium dissectum'],
    'lycopus':               ['lycopus spp.'],
    'mahonia':               ['mahonia aquifolium'],
    'malva':                 ['malva sylvestris'],
    'marrubium':             ['marrubium vulgare'],
    'marsdenia condurango':  ['marsdenia condurango'],
    'matricaria':            ['matricaria recutita'],
    'medicago':              ['medicago sativa'],
    'melissa':               ['melissa officinalis'],
    'menispermum':           ['menispermum canadense'],
    'mentha piperita':       ['mentha piperita'],
    'mentha pulegium':       ['mentha pulegium'],
    'mentha arvensis':       ['mentha arvensis var. piperascens'],
    'mentha spicata':        ['mentha spicata'],
    'menyanthes':            ['menyanthes trifoliata'],
    'mitchella':             ['mitchella repens'],
    'momordica':             [],  # bitter melon — confirmed absent from MM
    'mucuna':                [],  # Mucuna pruriens / velvet bean — confirmed absent from MM
    'myrica':                ['myrica cerifera'],
    'myroxylon balsamum var. pereirae': ['myroxylon balsamum var. pereirae'],
    'myristica':             ['semen myristicae fragrantis'],  # nutmeg TCM
    'nepeta':                ['nepeta cataria'],
    'oenothera':             ['oenothera biennis'],
    'olea europaea':         ['olea europaea'],
    'oplopanax':             ['oplopanax horridus'],
    'origanum vulgare':      ['origanum vulgare'],
    'origanum majorana':     ['origanum majorana'],
    'panax ginseng':         ['panax ginseng'],
    'panax quinquefolius':   ['panax quinquefolius'],
    'papaver':               ['papaver spp.'],
    'parietaria':            ['parietaria judaica'],
    'passiflora':            ['passiflora incarnata'],
    'paullinia':             ['paullinia cupana'],
    'petroselinum':          ['petroselinum crispum'],
    'phytolacca':            ['phytolacca americana'],
    'pimpinella':            ['pimpinella anisum'],
    'pinguicula':            ['pinguicula vulgaris'],
    'pinus':                 ['pinus pumilio', 'pinus sylvestris'],
    'piper methysticum':     ['piper methysticum'],
    'piscidia':              ['piscidia erythrina'],
    'plantago':              ['plantago major'],
    'podophyllum':           ['podophyllum peltatum'],
    'polygala senega':       ['polygala senega'],
    'polygonatum':           ['polygonatum biflorum'],
    'polygonum bistorta':    ['polygonum bistorta'],
    'populus candicans':     ['populus candicans'],
    'populus tremuloides':   ['populus tremuloides'],
    'primula':               ['primula veris'],
    'prunus':                ['prunus serotina'],  # MM PRUNUS entry = wild/choke cherry specifically
    'prunus serotina':       ['prunus serotina'],
    'pulsatilla':            ['pulsatilla vulgaris'],
    'pulmonaria':            ['pulmonaria officinalis'],
    'quercus':               ['quercus spp.'],
    'rehmannia':             ['rehmannia glutinosa'],
    'rhamnus cathartica':    ['rhamnus cathartica'],
    'rhamnus purshiana':     ['rhamnus purshiana'],
    'rheum':                 ['rheum palmatum'],
    'rhus glabra':           [],  # MM smooth sumac; not added to DB (different from Scudder's Rhus tox)
    'rhus toxicodendron':    [],  # not in MM (MM has rhus glabra; tox = toxicodendron radicans)
    'rosa':                  ['rosa canina', 'rosa gallica'],
    'rosmarinus':            ['rosmarinus officinalis'],
    'rubus idaeus':          ['rubus idaeus'],
    'rubus villosus':        ['rubus villosus'],
    'rumex crispus':         ['rumex crispus'],
    'rumex acetosa':         ['rumex acetosa'],
    'ruta':                  ['ruta graveolens'],
    'salix':                 ['salix spp.'],
    'salvia':                ['salvia officinalis', 'salvia sclarea'],  # restrict genus to W. sages only
    'salvia officinalis':    ['salvia officinalis'],
    'salvia sclarea':        ['salvia sclarea'],
    'salvia miltiorrhiza':   ['salvia miltiorrhiza'],
    'sambucus':              ['sambucus nigra'],
    'sanguinaria':           ['sanguinaria canadensis'],
    'acmella':              [],  # Spilanthes / toothache plant — not in MM
    'santalum':              ['santalum album'],
    'spilanthes':           [],  # now Acmella oleracea — not in MM
    'sassafras':             ['sassafras albidum'],
    'scrophularia':          ['scrophularia nodosa'],
    'scutellaria lateriflora':['scutellaria lateriflora'],
    'senecio aureus':        ['senecio aureus'],
    'senna alexandrina':     ['senna alexandrina'],
    'serenoa':               ['serenoa repens'],
    'silybum':               ['silybum marianum'],
    'smilax':                ['smilax spp.'],
    'smilacina':             ['smilacina racemosa'],
    'solidago':              ['solidago virgaurea'],
    'stachys':               ['stachys officinalis'],
    'stellaria':             ['stellaria media'],
    'stillingia':            ['stillingia sylvatica'],
    'strychnos ignatii':     [],  # not in MM
    'strychnos nux-vomica':  [],  # not in MM
    'symplocarpus':          ['symplocarpus foetidus'],
    'symphytum':             ['symphytum officinale'],
    'syzygium':              ['syzygium aromaticum'],
    'tabebuia':              ['tabebuia impetiginosa'],
    'tanacetum parthenium':  ['tanacetum parthenium'],
    'tanacetum vulgare':     ['tanacetum vulgare'],
    'taraxacum':             ['taraxacum officinale'],
    'thuja':                 ['thuja occidentalis'],
    'thymus':                ['thymus vulgaris'],
    'tilia':                 ['tilia platyphyllos'],
    'toxicodendron radicans': [],  # not in MM (MM has rhus glabra; tox is Poison Ivy)
    'trifolium':             ['trifolium pratense'],
    'trigonella':            ['trigonella foenum-graecum'],
    'tussilago':             ['tussilago farfara'],
    'turnera':               ['turnera diffusa'],
    'ulmus rubra':           ['ulmus rubra'],
    'ulmus':                 ['ulmus rubra'],
    'uncaria tomentosa':     [],  # cat's claw — not in DB (MM has it as *UNCARIA TOMENTOSA)
    'urginea':               ['urginea maritima'],
    'urtica':                ['urtica dioica'],
    'usnea':                 ['usnea spp.'],
    'vaccinium myrtillus':   ['vaccinium myrtillus'],
    'vaccinium macrocarpon': ['vaccinium macrocarpon'],
    'valeriana':             ['valeriana officinalis'],
    'veratrum':              ['veratrum viride'],
    'verbascum':             ['verbascum thapsus'],
    'verbena officinalis':   ['verbena officinalis'],
    'verbena hastata':       ['verbena hastata'],
    'viburnum opulus':       ['viburnum opulus'],
    'viburnum prunifolium':  ['viburnum prunifolium'],
    'vinca major':           ['vinca major'],
    'viola odorata':         ['viola odorata'],
    'viscum album':          ['viscum album'],
    'vitex agnus-castus':    ['vitex agnus-castus'],
    'withania':              ['withania somnifera'],
    'xanthium':              ['fructus xanthii'],  # TCM cocklebur fruit
    'zanthoxylum':           ['zanthoxylum americanum'],
    'zea mays':              ['zea mays'],
    'zingiber':              ['zingiber officinale'],
    # MM uses old/alternate genus/species names → current DB entries
    'amygdalis persica':     ['prunus persica'],     # peach (old genus name)
    'anemone hirsutissima':  ['pulsatilla vulgaris'],# pasque flower (Pulsatilla ludoviciana = W. pasqueflower)
    'anisum':                ['pimpinella anisum'],  # anise seed
    'artemisia abrotanum':   ['artemisia abrotanum'], # southernwood
    'ballota':               ['ballota nigra'],      # black horehound
    'caryophyllus':          ['syzygium aromaticum'],# cloves (old Caryophyllus → Syzygium)
    'fagopyrum':             ['fagopyrum esculentum'],
    'ipecacuanha':           ['cephaelis ipecacuanha'],
    'iris':                  ['iris versicolor'],
    'polygonatum':           ['polygonatum biflorum'],
    'polygala senega':       ['polygala senega'],
    'populus':               ['populus tremuloides', 'populus candicans'],
    'sinapis':               ['brassica spp.'],      # mustard
    'thea':                  ['camellia sinensis'],  # old name for tea
    'vinca':                 ['vinca major'],
    'zanthoxylum':           ['zanthoxylum americanum'],
    # Older / alternate MM genus names → current DB entries
    'achyranthes':           [],
    'acorns calamus':        [],
    'acorus calamus':        [],  # calamus — not in DB
    'aesculus hippocastanum':['aesculus hippocastanum'],
    'agropyron repens':      ['elymus repens'],   # old name for couch grass
    'allium sativum':        ['allium sativum'],
    'ammi visnaga':          ['ammi visnaga'],
    'anemopsis':             ['anemopsis californica'],
    'angelica sinensis':     ['angelica sinensis'],
    'anthemis nobilis':      ['chamaemelum nobile'],  # old name for Roman chamomile
    'apium':                 ['apium graveolens'],
    'aralia racemosa':       ['aralia californica', 'aralia racemosa'],  # includes californica
    'armoracia':             ['armoracia rusticana'],
    'artemisia tridentata':  [],  # sagebrush — not in DB
    'asclepias tuberosa':    ['asclepias tuberosa'],
    'balsam of peru':        ['myroxylon balsamum var. pereirae'],
    'balsam of tolu':        ['myroxylon balsamum var. balsamum'],
    'baptisia':              ['baptisia tinctoria'],
    'caffea arabica':        ['coffea arabica'],
    'carthamus tinctoria':   ['flos carthami tinctorii'],  # TCM safflower
    'cassia marilandica':    [],  # American senna — not in DB (we have Senna alexandrina)
    'cephalanthus':          [],
    'cereus grandiflorus':   [],
    'centella asiatica':     [],  # gotu kola — not in DB
    'cichorium':             [],
    'cnicus benedictus':     ['cnicus benedictus'],
    'ephedra sinica':        ['ephedra sinica'],
    'eschscholzia californica': ['eschscholzia californica'],
    'fraxinus':              [],  # ash — not in DB
    'guaiacum officinale':   ['guaiacum officinale'],
    'leucanthemum':          [],  # oxe-eye daisy — not in DB
    'leptandra virginica':   ['leptandra virginica'],
    'ligusticum porteri':    ['ligusticum porteri'],
    'lomatium dissectum':    ['lomatium dissectum'],
    'mitchella repens':      ['mitchella repens'],
    'myroxylum pereirae':    ['myroxylon balsamum var. pereirae'],  # old spelling
    'oenothera':             ['oenothera biennis'],
    'oplopanax':             ['oplopanax horridus'],
    'paeonia':               ['cortex radicis moutan'],  # moutan bark TCM
    'panax quinquefolius':   ['panax quinquefolius'],
    'petasites':             ['petasites palmatus'],
    'picrasma':              [],
    'piper methysticum':     ['piper methysticum'],
    'piscidia erythrina':    ['piscidia erythrina'],
    'plantago major':        ['plantago major'],
    'polygonatum':           ['polygonatum biflorum'],
    'pseudostellaria':       ['pseudostellaria heterophylla'],
    'punica':                [],  # pomegranate — not in DB
    'pyrus':                 [],
    'rauvolfia':             [],
    'ribes':                 [],
    'rosmarinus officinalis':['rosmarinus officinalis'],
    'rumex crispus':         ['rumex crispus'],
    'salix alba':            ['salix spp.'],
    'scoparius':             ['cytisus scoparius'],
    'sesamum':               [],
    'spirulina':             [],
    'strophanthus':          [],
    'styrax benzoin':        ['styrax benzoin'],
    'swertia radiata':       [],  # green gentian — not in DB
    'tamarindus':            [],
    'tanacetum':             ['tanacetum parthenium', 'tanacetum vulgare'],
    'tussilago farfara':     ['tussilago farfara'],
    'uncaria rhynchophylla': [],
    'urginea maritima':      ['urginea maritima'],
}


# ── Parse the MM file ─────────────────────────────────────────────────────────

def parse_mm_entries(path):
    """Return dict: normalized_key → (original_header, entry_text)"""
    with open(path, 'r', encoding='utf-8') as f:
        lines = f.readlines()

    # Find the MATERIA MEDICA section start and OUTLINE OF PREPARATION METHODS end
    start = None
    end = None
    for i, line in enumerate(lines):
        stripped = line.strip()
        if stripped == 'MATERIA MEDICA' and start is None and i > 100:
            start = i + 2  # skip the trailing <<< separator line
        if 'OUTLINE OF PREPARATION METHODS' in stripped and start is not None:
            end = i
            break

    if start is None:
        raise ValueError("Could not find MATERIA MEDICA section")

    mm_lines = lines[start:end]

    entries = {}
    current_key = None
    current_header = None
    current_text = []

    for line in mm_lines:
        raw = line.rstrip('\n')
        stripped = raw.strip()

        # Skip separator lines and blank lines between entries
        if stripped.startswith('<<<<') or stripped.startswith('>>>>'):
            continue

        # Detect new entry: starts at column 0 with uppercase or *uppercase
        if raw and raw[0] in ('*', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I',
                               'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S',
                               'T', 'U', 'V', 'W', 'X', 'Y', 'Z'):
            check = raw.lstrip('*')
            # Must start with at least 2 uppercase chars (rules out indent lines)
            if check and len(check) >= 2 and check[0].isupper() and (check[1].isupper() or check[1] == ' '):
                # Save previous entry
                if current_key is not None:
                    text = '\n'.join(current_text).strip()
                    entries[current_key] = (current_header, text)
                # Start new entry
                current_header = stripped
                # Normalize key: lowercase, strip *, parenthetical parts after first word pair
                norm = stripped.lstrip('*').strip()
                # Remove parenthetical suffixes in the header (common names)
                norm = re.sub(r'\s*\(.*', '', norm).strip()
                # Remove bracketed notes like [including A. californica]
                norm = re.sub(r'\s*\[.*', '', norm).strip()
                # Remove trailing punctuation
                norm = norm.rstrip('.').strip()
                current_key = norm.lower()
                current_text = [stripped]
                continue

        # Continuation line
        if current_key is not None:
            current_text.append(raw)

    # Save last entry
    if current_key is not None:
        entries[current_key] = (current_header, '\n'.join(current_text).strip())

    return entries


# ── Get DB herbs ──────────────────────────────────────────────────────────────

def get_db_herbs():
    result = subprocess.run([
        '/opt/homebrew/Cellar/libpq/18.1/bin/psql',
        '-h', '127.0.0.1', '-p', '54322', '-U', 'postgres', '-d', 'postgres',
        '-t', '-A', '-F', '|',
        '-c', "SELECT id, common_name, latin_name, plant_part FROM herbal.herbs ORDER BY common_name;"
    ], capture_output=True, text=True, env={'PGPASSWORD': 'postgres'})

    herbs = []
    for line in result.stdout.strip().split('\n'):
        if '|' in line:
            parts = line.split('|')
            herbs.append({
                'id': int(parts[0]),
                'common_name': parts[1],
                'latin_name': parts[2],
                'plant_part': parts[3] if len(parts) > 3 else ''
            })
    return herbs


# ── Matching logic ────────────────────────────────────────────────────────────

def normalize_latin(name):
    name = name.strip().lstrip('*').strip()
    name = re.sub(r'\s*\(.*', '', name)
    name = re.sub(r'\s*\[.*', '', name)
    name = name.rstrip('.').strip()
    return name.lower().strip()

def match_entries_to_herbs(entries, herbs):
    """Returns dict: herb_id → (header, entry_text)"""

    # Build latin→herb_id index
    latin_index = {}  # latin_name_lower → list of herb ids
    genus_index = {}  # genus_lower → list of herb ids
    for herb in herbs:
        ll = herb['latin_name'].lower()
        latin_index.setdefault(ll, []).append(herb['id'])
        g = ll.split()[0]
        genus_index.setdefault(g, []).append(herb['id'])

    mapping = {}  # herb_id → (header, text)
    unmatched = []

    for mm_key, (header, text) in entries.items():
        matched_ids = []

        # 1. Check synonym map first (most authoritative)
        if mm_key in SYNONYM_MAP:
            for target_latin in SYNONYM_MAP[mm_key]:
                tl = target_latin.lower()
                if tl in latin_index:
                    matched_ids.extend(latin_index[tl])
            if SYNONYM_MAP[mm_key] == []:
                # Explicitly not in DB
                continue

        # 2. Exact latin match
        if not matched_ids:
            if mm_key in latin_index:
                matched_ids.extend(latin_index[mm_key])

        # 3. Genus-only match (if MM key is a single word = genus)
        if not matched_ids:
            words = mm_key.split()
            if len(words) == 1:
                genus = words[0]
                if genus in genus_index:
                    matched_ids.extend(genus_index[genus])

        # 4. Two-word MM key where DB has spp. variant
        if not matched_ids:
            words = mm_key.split()
            if len(words) >= 2:
                genus = words[0]
                spp_key = genus + ' spp.'
                if spp_key in latin_index:
                    matched_ids.extend(latin_index[spp_key])

        if matched_ids:
            for herb_id in set(matched_ids):
                if herb_id not in mapping:
                    mapping[herb_id] = (header, text)
                # If herb already has a mapping, keep the first (more specific) one
        else:
            unmatched.append(mm_key)

    print(f"\n=== MATCHED: {len(mapping)} herbs ===")
    print(f"=== UNMATCHED MM entries: {len(unmatched)} ===")
    print("\nUnmatched (sample):")
    for u in sorted(unmatched)[:40]:
        print(f"  {u}")

    return mapping


# ── Generate TypeScript ───────────────────────────────────────────────────────

def ts_escape(s):
    s = s.replace('\\', '\\\\')
    s = s.replace('`', '\\`')
    s = s.replace('${', '\\${')
    return s

def generate_ts(mapping, herbs):
    herb_map = {h['id']: h for h in herbs}
    lines = [
        '// Auto-generated by parse-mm-materia-medica.py',
        '// Michael Moore Herbal Materia Medica 5.0 — herb_id → entry text',
        'export const MM_MATERIA_MEDICA: Record<number, string> = {',
    ]
    for herb_id in sorted(mapping.keys()):
        herb = herb_map.get(herb_id, {})
        name = herb.get('common_name', '?')
        latin = herb.get('latin_name', '?')
        _, text = mapping[herb_id]
        text = ts_escape(text)
        lines.append(f'  // {name} ({latin})')
        lines.append(f'  {herb_id}: `{text}`,')
        lines.append('')
    lines.append('};')
    return '\n'.join(lines) + '\n'


# ── Main ──────────────────────────────────────────────────────────────────────

if __name__ == '__main__':
    print("Parsing MM file...")
    entries = parse_mm_entries(MM_FILE)
    print(f"Found {len(entries)} MM entries")
    print("\nSample keys:")
    for k in list(entries.keys())[:20]:
        print(f"  {k!r}")

    print("\nFetching DB herbs...")
    herbs = get_db_herbs()
    print(f"Found {len(herbs)} DB herbs")

    print("\nMatching...")
    mapping = match_entries_to_herbs(entries, herbs)

    # Print matched list for review
    herb_map = {h['id']: h for h in herbs}
    print("\n=== MATCHED HERBS ===")
    for herb_id in sorted(mapping.keys()):
        h = herb_map[herb_id]
        _, text = mapping[herb_id]
        mm_header = text.split('\n')[0][:60]
        print(f"  {herb_id}: {h['common_name']} ({h['latin_name']}) ← {mm_header}")

    ts = generate_ts(mapping, herbs)
    with open(OUT_TS, 'w', encoding='utf-8') as f:
        f.write(ts)
    print(f"\nWrote {OUT_TS}")
