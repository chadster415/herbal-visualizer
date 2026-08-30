'use client';

import { useState, useEffect, useRef, useCallback } from 'react';
import { PairingsView } from './PairingsView';
import { LinkIcon } from '@heroicons/react/24/outline';
import { supabase } from '@/lib/supabase';
import { EnergeticEmojis } from './EnergeticEmojis';
import { InferredEnergeticsModal } from './InferredEnergeticsModal';
import { InferredTasteModal } from './InferredTasteModal';
import { ContraindicationsModal } from './ContraindicationsModal';
import { CONTRAINDICATIONS } from '@/lib/contraindications-manifest';
import { HerbImageUpload } from './HerbImageUpload';
import { MM_MATERIA_MEDICA } from '@/lib/mm-materia-medica';
import { SupplementDetail } from './SupplementDetail';
import { FlowerEssenceDetail } from './FlowerEssenceDetail';
import type {
  Herb,
  PrimaryAction,
  SecondaryAction,
  BodySystem,
  StrengthLevel,
  Disorder,
  ConcentrationLevel,
  Constituent,
  HerbMenstruum,
  Supplement,
  FlowerEssencePlant,
} from '@/types/database';

// ─── Types ────────────────────────────────────────────────────────────────────

interface ConstituentProfile {
  id: number;
  herb_id: number | null;
  common_name: string;
  latin_name: string;
  plant_part: string | null;
  constituent: string;
  class: string | null;
  subclass: string | null;
  importance: string | null;
  status: string | null;
  notes: string | null;
  editorial_note: string | null;
}

interface HerbData extends Herb {
  herb_primary_actions: Array<{
    primary_actions: PrimaryAction;
    body_systems: BodySystem | null;
    body_system_note: string | null;
    relative_strength: StrengthLevel | null;
  }>;
  disorder_action_herbs?: Array<{
    disorders: Disorder & { body_systems: BodySystem };
    primary_actions: PrimaryAction;
  }>;
  disorder_specific_remedies?: Array<{
    disorders: Disorder & { body_systems: BodySystem };
    description: string;
  }>;
  herb_secondary_actions: Array<{ secondary_actions: SecondaryAction }>;
  herb_constituents?: Array<{
    constituent_id: number;
    concentration_level: ConcentrationLevel;
    notes: string | null;
    needs_review: boolean;
    sort_order: number;
    constituents: Constituent;
  }>;
  herb_menstruum?: HerbMenstruum | null;
  herb_monograph_links?: Array<{
    id: number;
    url: string;
    label: string | null;
    sort_order: number;
  }>;
}

interface ClassNoteSnippet {
  id: number;
  herb_id: number;
  snippet_text: string;
  class_name: string;
  note_type: 'generated' | 'personal';
  section_header: string | null;
  sort_order: number;
  source_block: string | null;
}

// flat cross-reference: constituent_id → list of {herb_id, level}
interface ConstituentHerbRef {
  herb_id: number;
  concentration_level: ConcentrationLevel;
}

interface DuiYaoHerbStub { id: number; common_name: string; latin_name: string; pinyin_name: string | null; }
interface DuiYaoPair {
  id: number;
  herb1_id: number;
  herb2_id: number;
  book_page: number | null;
  image_file: string | null;
  combined_summary: string | null;
  herb1: DuiYaoHerbStub;
  herb2: DuiYaoHerbStub;
  dui_yao_indications: { indication: string; sort_order: number }[];
  dui_yao_herb_properties: { herb_id: number; property: string; sort_order: number }[];
}

interface PriestPairing {
  id: number;
  herb_id: number;
  partner_herb_id: number | null;
  partner_name_raw: string;
  combination_context: string | null;
  sort_order: number;
  partner: { id: number; common_name: string; latin_name: string } | null;
}

interface HerbViewProps {
  selectedHerbId?: number | null;
  onHerbIdChange?: (herbId: number | null) => void;
  onHerbClick?: (herbId: number) => void;
  onActionClick?: (actionId: number) => void;
  onActionNameClick?: (name: string) => void;
  onDisorderClick?: (disorderId: number, systemId: number) => void;
  selectedSupplementId?: number | null;
  onSupplementClick?: (supplementId: number) => void;
  selectedEssenceId?: number | null;
  onEssenceClick?: (essenceId: number) => void;
  onSoulConditionClick?: (category: string) => void;
  pairingsMode?: boolean;
  onShowPairings?: (herbId: number) => void;
  onFocusChange?: (herbId: number | null) => void;
  pairingsInitialFocusId?: number | null;
}

// ─── Helpers ──────────────────────────────────────────────────────────────────

const LEVEL_WEIGHT: Record<ConcentrationLevel, number> = {
  trace: 0, minor: 1, moderate: 2, major: 3, primary: 4,
};

const LEVEL_COLOR: Record<ConcentrationLevel, string> = {
  primary:  'bg-green-100 text-green-800 border-green-300',
  major:    'bg-teal-100 text-teal-800 border-teal-300',
  moderate: 'bg-sky-100 text-sky-800 border-sky-300',
  minor:    'bg-gray-100 text-gray-700 border-gray-300',
  trace:    'bg-gray-50 text-gray-500 border-gray-200',
};

const STATUS_WEIGHT: Record<string, number> = {
  'Marker': 8, 'Major': 5, 'Present': 2, 'Reported': 1,
};

const IMP_WEIGHT: Record<string, number> = {
  'High': 5, 'Moderate': 3, 'Low-Moderate': 2, 'Low–Moderate': 2, 'Low': 1,
};

function statusBadgeColor(status: string | null) {
  switch (status) {
    case 'Marker':   return 'bg-amber-100 text-amber-800 border-amber-300';
    case 'Major':    return 'bg-orange-100 text-orange-700 border-orange-300';
    case 'Present':  return 'bg-sky-100 text-sky-700 border-sky-300';
    default:         return 'bg-gray-100 text-gray-500 border-gray-200';
  }
}

function importanceBadgeColor(importance: string | null) {
  switch (importance) {
    case 'High':         return 'bg-amber-100 text-amber-800 border-amber-300';
    case 'Moderate':     return 'bg-yellow-100 text-yellow-700 border-yellow-300';
    default:             return 'bg-gray-100 text-gray-600 border-gray-200';
  }
}

function getStrengthColor(strength: StrengthLevel | null) {
  switch (strength) {
    case 'mild':       return 'bg-yellow-100 text-yellow-800';
    case 'strong':     return 'bg-orange-100 text-orange-800';
    case 'very_strong':return 'bg-red-100 text-red-800';
    default:           return 'bg-gray-100 text-gray-800';
  }
}

function solubilityStyles(s: string | null) {
  switch (s) {
    case 'water-soluble':       return { badge: 'bg-sky-100 border-sky-200 text-sky-700',    card: 'bg-sky-50/40 border-sky-100 hover:bg-sky-50 hover:border-sky-200',    cardSelected: 'ring-2 ring-sky-400 ring-offset-1 bg-sky-50 border-sky-200' };
    case 'fat-soluble':         return { badge: 'bg-amber-100 border-amber-200 text-amber-700', card: 'bg-amber-50/40 border-amber-100 hover:bg-amber-50 hover:border-amber-200', cardSelected: 'ring-2 ring-amber-400 ring-offset-1 bg-amber-50 border-amber-200' };
    case 'water & fat-soluble': return { badge: 'bg-purple-100 border-purple-200 text-purple-700', card: 'bg-purple-50/40 border-purple-100 hover:bg-purple-50 hover:border-purple-200', cardSelected: 'ring-2 ring-purple-400 ring-offset-1 bg-purple-50 border-purple-200' };
    case 'oil-soluble':         return { badge: 'bg-amber-100 border-amber-200 text-amber-700', card: 'bg-amber-50/40 border-amber-100 hover:bg-amber-50 hover:border-amber-200', cardSelected: 'ring-2 ring-amber-400 ring-offset-1 bg-amber-50 border-amber-200' };
    default:                    return { badge: 'bg-indigo-100 border-indigo-200 text-indigo-700', card: 'bg-indigo-50/40 border-indigo-100 hover:bg-indigo-50 hover:border-indigo-200', cardSelected: 'ring-2 ring-indigo-500 ring-offset-1 bg-indigo-50 border-indigo-200' };
  }
}

function solubilityLabel(s: string | null) {
  switch (s) {
    case 'fat-soluble':         return 'fat-sol';
    case 'water-soluble':       return 'water-sol';
    case 'water & fat-soluble': return 'water+fat';
    default:                    return s ?? '';
  }
}

function menstruumBadges(m: HerbMenstruum) {
  const badges: { label: string; color: string }[] = [];
  if (m.alcohol_pct_min != null || m.alcohol_pct_max != null) {
    const range = m.alcohol_pct_min === m.alcohol_pct_max
      ? `${m.alcohol_pct_min}%`
      : `${m.alcohol_pct_min ?? '?'}–${m.alcohol_pct_max ?? '?'}%`;
    badges.push({ label: `Alcohol ${range}`, color: 'bg-purple-100 text-purple-800 border-purple-200' });
  }
  if (m.glycerin_pct != null)
    badges.push({ label: `Glycerin ${m.glycerin_pct}%`, color: 'bg-pink-100 text-pink-800 border-pink-200' });
  if (m.vinegar_pct != null)
    badges.push({ label: `Vinegar ${m.vinegar_pct}%`, color: 'bg-yellow-100 text-yellow-800 border-yellow-200' });
  if (m.water_effective)
    badges.push({ label: 'Water effective', color: 'bg-blue-100 text-blue-800 border-blue-200' });
  if (m.powder_effective)
    badges.push({ label: 'Powder effective', color: 'bg-yellow-100 text-yellow-900 border-yellow-300' });
  if (m.oil_effective)
    badges.push({ label: 'Oil effective', color: 'bg-orange-100 text-orange-900 border-orange-200' });
  return badges;
}

function powderEffectiveReason(constituents: HerbData['herb_constituents']): string {
  if (!constituents?.length) return 'constituent profile suits whole-herb ingestion';

  const cats = constituents.map((c) => c.constituents.category ?? '');
  const hasMod = (cat: string) =>
    constituents
      .filter((c) => c.constituents.category === cat)
      .some((c) => ['moderate', 'major', 'primary'].includes(c.concentration_level));

  const reasons: string[] = [];

  const polyCats = ['polysaccharide', 'sulfated polysaccharide', 'beta-glucan polysaccharide',
                    'acidic polysaccharide', 'alpha-glucan polysaccharide'];
  if (cats.some((c) => polyCats.includes(c)))
    reasons.push('polysaccharides / mucilage');

  const fosCats = ['fructo-oligosaccharide', 'fructooligosaccharide polysaccharide', 'oligosaccharide'];
  if (cats.some((c) => fosCats.includes(c)))
    reasons.push('prebiotic fiber (inulin / FOS)');

  if (cats.includes('lectin'))
    reasons.push('lectins (proteins, GI-active)');

  if (cats.includes('mineral') && hasMod('mineral'))
    reasons.push('minerals (lost in the marc)');

  const anthraCats = ['anthraquinone', 'anthraquinone glycoside'];
  if (cats.some((c) => anthraCats.includes(c)) && anthraCats.some((c) => hasMod(c)))
    reasons.push('anthraquinones (gut-bacterial activation)');

  return reasons.length > 0 ? reasons.join(', ') : 'constituent profile suits whole-herb ingestion';
}

function highlightHerbName(text: string, terms: string[]): React.ReactNode[] {
  const valid = terms.filter(t => t && t.length > 2);
  if (valid.length === 0) return [text];
  const pattern = valid.map(t => t.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')).join('|');
  const parts = text.split(new RegExp(`(${pattern})`, 'gi'));
  return parts.map((part, i) =>
    i % 2 === 1
      ? <strong key={i} className="font-bold text-teal-900">{part}</strong>
      : part
  );
}

function SectionHeader({ title, open, onToggle }: { title: string; open: boolean; onToggle: () => void }) {
  return (
    <div
      onClick={onToggle}
      className="flex items-center gap-2 cursor-pointer select-none group mb-4"
    >
      <svg
        className={`w-5 h-5 text-gray-400 group-hover:text-gray-600 transition-transform ${open ? '' : '-rotate-90'}`}
        fill="none" stroke="currentColor" viewBox="0 0 24 24"
      >
        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
      </svg>
      <h3 className="text-xl font-semibold text-gray-800 group-hover:text-gray-600 transition-colors">{title}</h3>
    </div>
  );
}

// ─── Component ────────────────────────────────────────────────────────────────

export function HerbView({ selectedHerbId, onHerbIdChange, onHerbClick, onActionClick, onActionNameClick, onDisorderClick, selectedSupplementId, onSupplementClick, selectedEssenceId, onEssenceClick, onSoulConditionClick, pairingsMode, onShowPairings, onFocusChange, pairingsInitialFocusId }: HerbViewProps) {
  const [herbs, setHerbs] = useState<HerbData[]>([]);
  const [allProfiles, setAllProfiles] = useState<ConstituentProfile[]>([]);
  const [selectedHerb, setSelectedHerb] = useState<HerbData | null>(null);
  const [searchTerm, setSearchTerm] = useState('');
  const [highlightedIndex, setHighlightedIndex] = useState(-1);
  const [loading, setLoading] = useState(true);
  const [includeTCM, setIncludeTCM] = useState(false);
  const [supplements, setSupplements] = useState<Supplement[]>([]);
  const [selectedSupplement, setSelectedSupplement] = useState<Supplement | null>(null);
  const [essences, setEssences] = useState<FlowerEssencePlant[]>([]);
  const [selectedEssence, setSelectedEssence] = useState<FlowerEssencePlant | null>(null);
  const [pairedHerbIds, setPairedHerbIds] = useState<Set<number>>(new Set());
  const [duiYaoPairs, setDuiYaoPairs] = useState<DuiYaoPair[]>([]);
  const [duiYaoLoading, setDuiYaoLoading] = useState(false);
  const [priestPairings, setPriestPairings] = useState<PriestPairing[]>([]);
  const [priestPairingsLoading, setPriestPairingsLoading] = useState(false);
  const [mobileListOpen, setMobileListOpen] = useState(true);
  const [classNoteSnippets, setClassNoteSnippets] = useState<ClassNoteSnippet[]>([]);
  const [keywordHerbIds, setKeywordHerbIds] = useState<Set<number>>(new Set());
  const [keywordLabels, setKeywordLabels] = useState<Map<number, string[]>>(new Map());

  // constituent_id → array of herb refs (for tooltip & existing Constituents section)
  const [constituentIndex, setConstituentIndex] = useState<Map<number, ConstituentHerbRef[]>>(new Map());

  // per-herb detail cache (herb_constituents, herb_menstruum, herb_monograph_links)
  const [herbDetailCache, setHerbDetailCache] = useState<Record<number, {
    herb_constituents: HerbData['herb_constituents'];
    herb_menstruum: HerbMenstruum | null;
    herb_monograph_links: HerbData['herb_monograph_links'];
  }>>({});
  const [detailLoading, setDetailLoading] = useState(false);

  // hover tooltip state
  const [hoveredConstituentId, setHoveredConstituentId] = useState<number | null>(null);
  const [tooltipPos, setTooltipPos] = useState<{ x: number; y: number } | null>(null);
  const hoverTimerRef = useRef<ReturnType<typeof setTimeout> | null>(null);

  // section open/closed
  const [alternatesOpen, setAlternatesOpen] = useState(false);
  const [sectionsOpen, setSectionsOpen] = useState({
    primaryActions: true, secondaryActions: true,
    constituentProfile: true, constituents: true, disorders: true, pairings: true,
    contraindications: true, mmMateriaMedica: true, herbContraindications: true,
    classNotes: true,
  });
  const toggleSection = (key: keyof typeof sectionsOpen) =>
    setSectionsOpen((prev) => ({ ...prev, [key]: !prev[key] }));

  const [contraindicationsOpen, setContraindicationsOpen] = useState(false);
  const [inferredEnergeticsOpen, setInferredEnergeticsOpen] = useState(false);
  const [inferredTasteOpen, setInferredTasteOpen] = useState(false);
  const [monographDropdownOpen, setMonographDropdownOpen] = useState(false);
  const [addLinkOpen, setAddLinkOpen] = useState(false);
  const [newLinkUrl, setNewLinkUrl] = useState('');
  const [addLinkSaving, setAddLinkSaving] = useState(false);

  const herbRefs = useRef<Map<number, HTMLButtonElement>>(new Map());
  const supplementRefs = useRef<Map<number, HTMLButtonElement>>(new Map());
  const essenceRefs = useRef<Map<number, HTMLButtonElement>>(new Map());
  const vitaminsSectionRef = useRef<HTMLDivElement | null>(null);
  const essenceSectionRef = useRef<HTMLDivElement | null>(null);
  const detailPanelRef = useRef<HTMLDivElement>(null);
  const monographDropdownRef = useRef<HTMLDivElement>(null);
  const sectionRefs = useRef<Partial<Record<keyof typeof sectionsOpen, HTMLDivElement | null>>>({});

  const scrollToSection = (key: keyof typeof sectionsOpen) => {
    setSectionsOpen((prev) => ({ ...prev, [key]: true }));
    setTimeout(() => {
      sectionRefs.current[key]?.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }, 50);
  };

  // Scroll an element into view within the sidebar's overflow-y container
  function scrollItemInSidebar(el: HTMLElement) {
    let container: HTMLElement | null = el.parentElement;
    while (container) {
      const { overflowY } = getComputedStyle(container);
      if (overflowY === 'auto' || overflowY === 'scroll') break;
      container = container.parentElement;
    }
    if (!container) return;
    const cRect = container.getBoundingClientRect();
    const eRect = el.getBoundingClientRect();
    const scrollTop = eRect.top - cRect.top + container.scrollTop - 20;
    container.scrollTo({ top: Math.max(0, scrollTop), behavior: 'smooth' });
  }

  function scrollHerbInSidebar(herbId: number) {
    const el = herbRefs.current.get(herbId);
    if (el) scrollItemInSidebar(el);
  }

  function scrollSupplementInSidebar(supplementId: number) {
    const el = supplementRefs.current.get(supplementId);
    if (el) scrollItemInSidebar(el);
  }

  function scrollEssenceInSidebar(essenceId: number) {
    const el = essenceRefs.current.get(essenceId);
    if (el) scrollItemInSidebar(el);
  }

  const filteredHerbs = herbs.filter((h) => {
    if (!includeTCM && h.is_tcm) return false;
    const term = searchTerm.toLowerCase();
    return (
      h.common_name.toLowerCase().includes(term) ||
      h.latin_name.toLowerCase().includes(term) ||
      (h.pinyin_name ?? '').toLowerCase().includes(term) ||
      (h.synonyms ?? []).some((s) => s.toLowerCase().includes(term))
    );
  });

  const filteredSupplements = supplements.filter((s) => {
    const term = searchTerm.toLowerCase();
    return !term || s.name.toLowerCase().includes(term) || s.category.toLowerCase().includes(term);
  });

  const filteredEssences = essences.filter((e) => {
    const term = searchTerm.toLowerCase();
    return !term || e.name.toLowerCase().includes(term) || (e.latin_name ?? '').toLowerCase().includes(term);
  });

  // Herbs matched via herb_keywords but not already in filteredHerbs
  const keywordMatchedHerbs = searchTerm.trim().length >= 2
    ? herbs.filter((h) => {
        if (!includeTCM && h.is_tcm) return false;
        if (!keywordHerbIds.has(h.id)) return false;
        const term = searchTerm.trim().toLowerCase();
        const nameMatches = h.common_name.toLowerCase().includes(term)
          || (h.latin_name?.toLowerCase().includes(term) ?? false);
        return !nameMatches;
      })
    : [];

  useEffect(() => {
    if (highlightedIndex < 0) return;
    const herbCount = filteredHerbs.length + keywordMatchedHerbs.length;
    if (highlightedIndex < filteredHerbs.length) {
      scrollHerbInSidebar(filteredHerbs[highlightedIndex].id);
    } else if (highlightedIndex < herbCount) {
      scrollHerbInSidebar(keywordMatchedHerbs[highlightedIndex - filteredHerbs.length].id);
    } else {
      const suppIdx = highlightedIndex - herbCount;
      if (suppIdx < filteredSupplements.length) {
        scrollSupplementInSidebar(filteredSupplements[suppIdx].id);
      } else {
        const ess = filteredEssences[suppIdx - filteredSupplements.length];
        if (ess) scrollEssenceInSidebar(ess.id);
      }
    }
  }, [highlightedIndex, filteredHerbs, keywordMatchedHerbs, filteredSupplements, filteredEssences]);

  useEffect(() => {
    if (!monographDropdownOpen) return;
    function handleClickOutside(e: MouseEvent) {
      if (monographDropdownRef.current && !monographDropdownRef.current.contains(e.target as Node)) {
        setMonographDropdownOpen(false);
      }
    }
    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, [monographDropdownOpen]);

  useEffect(() => { fetchHerbs(); }, []);

  useEffect(() => {
    Promise.all([
      supabase.from('dui_yao_pairs').select('herb1_id, herb2_id'),
      supabase.from('priest_pairings').select('herb_id, partner_herb_id').not('partner_herb_id', 'is', null),
    ]).then(([duiRes, priestRes]) => {
      const ids = new Set<number>();
      for (const { herb1_id, herb2_id } of duiRes.data ?? []) { ids.add(herb1_id); ids.add(herb2_id); }
      for (const { herb_id, partner_herb_id } of priestRes.data ?? []) { if (partner_herb_id) { ids.add(herb_id); ids.add(partner_herb_id); } }
      setPairedHerbIds(ids);
    });
  }, []);

  useEffect(() => {
    supabase
      .from('supplements')
      .select('*')
      .order('name')
      .then(({ data }) => { if (data) setSupplements(data as Supplement[]); });
  }, []);

  useEffect(() => {
    supabase
      .from('flower_essence_plants')
      .select('*')
      .order('name')
      .then(({ data }) => { if (data) setEssences(data as FlowerEssencePlant[]); });
  }, []);

  // Keyword search: query herb_keywords + class_note_snippets when searchTerm changes
  useEffect(() => {
    const term = searchTerm.trim();
    if (term.length < 2) { setKeywordHerbIds(new Set()); setKeywordLabels(new Map()); return; }
    const escaped = term.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    Promise.all([
      supabase.from('herb_keywords').select('herb_id, keyword').ilike('keyword', `%${term}%`),
      supabase.from('class_note_snippets').select('herb_id, snippet_text').ilike('snippet_text', `%${term}%`),
    ]).then(([{ data: kw }, { data: sn }]) => {
      const labels = new Map<number, string[]>();
      // keyword matches: use the keyword itself as the label
      for (const row of (kw ?? []) as { herb_id: number; keyword: string }[]) {
        const existing = labels.get(row.herb_id) ?? [];
        labels.set(row.herb_id, [...existing, row.keyword]);
      }
      // snippet matches: extract the actual matching word(s) from the text
      for (const row of (sn ?? []) as { herb_id: number; snippet_text: string }[]) {
        const matches = row.snippet_text.match(new RegExp(`\\w*${escaped}\\w*`, 'gi')) ?? [];
        const words = [...new Set(matches.map(m => m.trim()).filter(Boolean))];
        const existing = labels.get(row.herb_id) ?? [];
        labels.set(row.herb_id, [...new Set([...existing, ...words])]);
      }
      setKeywordHerbIds(new Set(labels.keys()));
      setKeywordLabels(labels);
    });
  }, [searchTerm]);

  // Fetch class note snippets whenever the selected herb changes
  useEffect(() => {
    if (!selectedHerb) { setClassNoteSnippets([]); return; }
    supabase
      .from('class_note_snippets')
      .select('*')
      .eq('herb_id', selectedHerb.id)
      .order('note_type')
      .order('sort_order')
      .then(({ data }) => { setClassNoteSnippets((data ?? []) as ClassNoteSnippet[]); });
  }, [selectedHerb?.id]);

  useEffect(() => {
    if (selectedEssenceId == null) return;
    const scrollToDetail = () => {
      if (typeof window !== 'undefined' && window.innerWidth < 1024) {
        setMobileListOpen(false);
        setTimeout(() => detailPanelRef.current?.scrollIntoView({ behavior: 'smooth', block: 'start' }), 50);
      } else {
        window.scrollTo({ top: 0, behavior: 'smooth' });
      }
    };
    const found = essences.find((e) => e.id === selectedEssenceId);
    if (found) {
      setSelectedEssence(found);
      setSelectedHerb(null);
      setSelectedSupplement(null);
      scrollToDetail();
      setTimeout(() => scrollEssenceInSidebar(selectedEssenceId), 100);
      return;
    }
    supabase
      .from('flower_essence_plants')
      .select('*')
      .eq('id', selectedEssenceId)
      .single()
      .then(({ data }) => {
        if (data) {
          setSelectedEssence(data as FlowerEssencePlant);
          setSelectedHerb(null);
          setSelectedSupplement(null);
          if (!essences.find((e) => e.id === selectedEssenceId)) {
            setEssences((prev) => [...prev, data as FlowerEssencePlant]);
          }
          scrollToDetail();
          setTimeout(() => scrollEssenceInSidebar(selectedEssenceId), 100);
        }
      });
  }, [selectedEssenceId, essences]);

  useEffect(() => {
    if (selectedSupplementId == null) return;
    const found = supplements.find((s) => s.id === selectedSupplementId);
    if (found) {
      setSelectedSupplement(found);
      setSelectedHerb(null);
      setTimeout(() => scrollSupplementInSidebar(selectedSupplementId), 100);
      return;
    }
    supabase
      .from('supplements')
      .select('*')
      .eq('id', selectedSupplementId)
      .single()
      .then(({ data }) => {
        if (data) {
          setSelectedSupplement(data as Supplement);
          setSelectedHerb(null);
          if (!supplements.find((s) => s.id === selectedSupplementId)) {
            setSupplements((prev) => [...prev, data as Supplement]);
          }
          setTimeout(() => scrollSupplementInSidebar(selectedSupplementId), 100);
        }
      });
  }, [selectedSupplementId]);

  useEffect(() => {
    if (selectedHerb == null) { setDuiYaoPairs([]); return; }
    setDuiYaoPairs([]);
    setDuiYaoLoading(true);
    supabase
      .from('dui_yao_pairs')
      .select(`
        id, herb1_id, herb2_id, book_page, image_file, combined_summary,
        herb1:herbs!dui_yao_pairs_herb1_id_fkey(id, common_name, latin_name, pinyin_name),
        herb2:herbs!dui_yao_pairs_herb2_id_fkey(id, common_name, latin_name, pinyin_name),
        dui_yao_indications(indication, sort_order),
        dui_yao_herb_properties(herb_id, property, sort_order)
      `)
      .or(`herb1_id.eq.${selectedHerb.id},herb2_id.eq.${selectedHerb.id}`)
      .then(({ data, error }) => {
        if (!error && data) setDuiYaoPairs(data as unknown as DuiYaoPair[]);
        else setDuiYaoPairs([]);
        setDuiYaoLoading(false);
      });
  }, [selectedHerb?.id]);

  useEffect(() => {
    if (selectedHerb == null) { setPriestPairings([]); return; }
    setPriestPairings([]);
    setPriestPairingsLoading(true);
    supabase
      .from('priest_pairings')
      .select(`
        id, herb_id, partner_herb_id, partner_name_raw, combination_context, sort_order,
        partner:herbs!priest_pairings_partner_herb_id_fkey(id, common_name, latin_name)
      `)
      .eq('herb_id', selectedHerb.id)
      .order('sort_order')
      .then(({ data, error }) => {
        if (!error && data) setPriestPairings(data as unknown as PriestPairing[]);
        else setPriestPairings([]);
        setPriestPairingsLoading(false);
      });
  }, [selectedHerb?.id]);

  useEffect(() => {
    if (selectedHerbId == null) {
      setMobileListOpen(true);
      return;
    }
    if (herbs.length > 0) {
      const herb = herbs.find((h) => h.id === selectedHerbId);
      if (herb) {
        setSelectedSupplement(null);
        setAlternatesOpen(false);
        setMobileListOpen(false);
        setSectionsOpen({ primaryActions: true, secondaryActions: true, constituentProfile: true, constituents: true, disorders: true, pairings: true, contraindications: true, mmMateriaMedica: true, herbContraindications: true, classNotes: true });
        setTimeout(() => { scrollHerbInSidebar(selectedHerbId); }, 100);
        fetchHerbDetail(selectedHerbId);
      }
    }
  }, [selectedHerbId, herbs]);

  // Merge detail into selectedHerb when cache entry arrives
  useEffect(() => {
    if (selectedHerbId == null) return;
    const listItem = herbs.find(h => h.id === selectedHerbId);
    const detail = herbDetailCache[selectedHerbId];
    if (!listItem) return;
    setSelectedHerb({ ...listItem, ...(detail ?? {}) } as HerbData);
  }, [selectedHerbId, herbs, herbDetailCache]);

  async function fetchHerbs() {
    try {
      const herbResult = await supabase
        .from('herbs')
        .select(`
          *,
          herb_primary_actions (
            primary_actions (*),
            body_systems (*),
            body_system_note,
            relative_strength
          ),
          disorder_action_herbs (
            disorders ( *, body_systems (*) ),
            primary_actions (*)
          ),
          disorder_specific_remedies (
            disorders ( *, body_systems (*) ),
            description
          ),
          herb_secondary_actions ( secondary_actions (*) )
        `)
        .order('common_name');

      if (herbResult.error) throw herbResult.error;

      const herbList: HerbData[] = herbResult.data || [];

      setHerbs(herbList);
    } catch (err) {
      console.error('Error fetching herbs:', err);
    } finally {
      setLoading(false);
    }

    // Build constituent → herbs cross-reference index in background
    supabase.from('herb_constituents')
      .select('herb_id, constituent_id, concentration_level')
      .then(({ data }) => {
        if (!data) return;
        const idx = new Map<number, ConstituentHerbRef[]>();
        for (const row of data) {
          if (!idx.has(row.constituent_id)) idx.set(row.constituent_id, []);
          idx.get(row.constituent_id)!.push({ herb_id: row.herb_id, concentration_level: row.concentration_level });
        }
        setConstituentIndex(idx);
      });

    // Fetch constituent profiles in background
    supabase.from('constituent_profiles')
      .select('*').not('herb_id', 'is', null).order('herb_id').range(0, 4999)
      .then(({ data }) => { if (data) setAllProfiles(data as ConstituentProfile[]); });
  }

  async function fetchHerbDetail(herbId: number) {
    if (herbDetailCache[herbId]) return;
    setDetailLoading(true);
    const [hcRes, mmRes, linksRes] = await Promise.all([
      supabase.from('herb_constituents')
        .select('constituent_id, concentration_level, notes, needs_review, sort_order, constituents(*)')
        .eq('herb_id', herbId)
        .order('sort_order'),
      supabase.from('herb_menstruum').select('*').eq('herb_id', herbId).maybeSingle(),
      supabase.from('herb_monograph_links').select('id, url, label, sort_order').eq('herb_id', herbId).order('sort_order'),
    ]);
    const detail = {
      herb_constituents: (hcRes.data ?? []) as unknown as HerbData['herb_constituents'],
      herb_menstruum: (mmRes.data ?? null) as HerbMenstruum | null,
      herb_monograph_links: (linksRes.data ?? []) as HerbData['herb_monograph_links'],
    };
    setHerbDetailCache(prev => ({ ...prev, [herbId]: detail }));
    setDetailLoading(false);
  }

  async function handleAddLink() {
    if (!selectedHerb || !newLinkUrl.trim()) return;
    setAddLinkSaving(true);
    try {
      const res = await fetch('/api/monograph-links', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ herb_id: selectedHerb.id, url: newLinkUrl.trim() }),
      });
      if (!res.ok) throw new Error('Failed to add link');
      const newLink = await res.json();
      const updatedLinks = [...(selectedHerb.herb_monograph_links ?? []), newLink];
      const updated = { ...selectedHerb, herb_monograph_links: updatedLinks };
      setSelectedHerb(updated);
      setHerbDetailCache(prev => ({
        ...prev,
        [selectedHerb.id]: {
          ...prev[selectedHerb.id],
          herb_monograph_links: updatedLinks,
        }
      }));
      setAddLinkOpen(false);
      setNewLinkUrl('');
    } catch (err) {
      console.error('Error adding monograph link:', err);
    } finally {
      setAddLinkSaving(false);
    }
  }

  const navigateToHerb = useCallback((herbId: number) => {
    const herb = herbs.find((h) => h.id === herbId);
    if (!herb) return;
    setSelectedSupplement(null);
    setAlternatesOpen(false);
    setSectionsOpen({ primaryActions: true, secondaryActions: true, constituentProfile: true, constituents: true, disorders: true, pairings: true, contraindications: true, mmMateriaMedica: true, herbContraindications: true, classNotes: true });
    onHerbClick?.(herbId);
    fetchHerbDetail(herbId);
    window.scrollTo({ top: 0, behavior: 'smooth' });
    scrollHerbInSidebar(herbId);
  }, [herbs, onHerbClick, herbDetailCache]);

  // All profiles for the selected herb (used for both marker display and alternates)
  const selectedProfiles = selectedHerb
    ? allProfiles.filter((p) => p.herb_id === selectedHerb.id)
    : [];

  // True if the herb has alkaloids that benefit from acid extraction (excludes purines,
  // pyrrolizidines, and capsaicinoids where vinegar is unhelpful or counterproductive)
  const VINEGAR_SKIP_SUBCLASSES = new Set([
    'Purine alkaloid', 'Pyrrolizidine alkaloid', 'Capsaicinoid',
  ]);
  const herbHasExtractableAlkaloids = selectedProfiles.some(
    (p) => p.class === 'Alkaloid' && !VINEGAR_SKIP_SUBCLASSES.has(p.subclass ?? '')
  );

  // Alternates: multi-level chemical similarity scored against all profiles
  // Levels: exact constituent (×100) → same subclass (×50) → same class (×15)
  // Each weighted by Status × Importance; normalized against selected herb's self-score
  const computedAlternates = (() => {
    if (!selectedHerb || selectedProfiles.length === 0) return [];

    // Self-score: maximum possible score if everything matched exactly
    let selfScore = 0;
    for (const p of selectedProfiles) {
      selfScore += (STATUS_WEIGHT[p.status ?? ''] ?? 1) * (IMP_WEIGHT[p.importance ?? ''] ?? 1) * 100;
    }
    if (selfScore === 0) return [];

    // Build lookup indices over all other herbs' profiles
    const byName    = new Map<string, ConstituentProfile[]>();
    const bySubclass = new Map<string, ConstituentProfile[]>();
    const byClass   = new Map<string, ConstituentProfile[]>();

    for (const p of allProfiles) {
      if (p.herb_id == null || p.herb_id === selectedHerb.id) continue;
      const nk = p.constituent.toLowerCase();
      if (!byName.has(nk)) byName.set(nk, []);
      byName.get(nk)!.push(p);
      if (p.subclass) {
        const sk = p.subclass.toLowerCase();
        if (!bySubclass.has(sk)) bySubclass.set(sk, []);
        bySubclass.get(sk)!.push(p);
      }
      if (p.class) {
        const ck = p.class.toLowerCase();
        if (!byClass.has(ck)) byClass.set(ck, []);
        byClass.get(ck)!.push(p);
      }
    }

    const scores      = new Map<number, number>();
    const exactMap    = new Map<number, Set<string>>();
    const subclassMap = new Map<number, Set<string>>();
    const classMap    = new Map<number, Set<string>>();

    for (const p of selectedProfiles) {
      const W = (STATUS_WEIGHT[p.status ?? ''] ?? 1) * (IMP_WEIGHT[p.importance ?? ''] ?? 1);
      const nk = p.constituent.toLowerCase();

      const exactHerbs    = new Set<number>();
      const subclassHerbs = new Set<number>();

      // Level 1: exact constituent name
      for (const q of byName.get(nk) ?? []) {
        if (q.herb_id == null) continue;
        exactHerbs.add(q.herb_id);
        scores.set(q.herb_id, (scores.get(q.herb_id) ?? 0) + W * 100);
        if (!exactMap.has(q.herb_id)) exactMap.set(q.herb_id, new Set());
        exactMap.get(q.herb_id)!.add(p.constituent);
      }

      // Level 2: same subclass (skip herbs already matched at level 1 for this p)
      if (p.subclass) {
        for (const q of bySubclass.get(p.subclass.toLowerCase()) ?? []) {
          if (q.herb_id == null || exactHerbs.has(q.herb_id) || subclassHerbs.has(q.herb_id)) continue;
          subclassHerbs.add(q.herb_id);
          scores.set(q.herb_id, (scores.get(q.herb_id) ?? 0) + W * 50);
          if (!subclassMap.has(q.herb_id)) subclassMap.set(q.herb_id, new Set());
          subclassMap.get(q.herb_id)!.add(p.subclass);
        }
      }

      // Level 3: same class (skip herbs already matched at level 1 or 2 for this p)
      if (p.class) {
        const classHerbs = new Set<number>();
        for (const q of byClass.get(p.class.toLowerCase()) ?? []) {
          if (q.herb_id == null || exactHerbs.has(q.herb_id) || subclassHerbs.has(q.herb_id) || classHerbs.has(q.herb_id)) continue;
          classHerbs.add(q.herb_id);
          scores.set(q.herb_id, (scores.get(q.herb_id) ?? 0) + W * 15);
          if (!classMap.has(q.herb_id)) classMap.set(q.herb_id, new Set());
          classMap.get(q.herb_id)!.add(p.class);
        }
      }
    }

    return [...scores.entries()]
      .sort((a, b) => b[1] - a[1])
      .slice(0, 8)
      .map(([herbId, score]) => ({
        herb: herbs.find((h) => h.id === herbId),
        similarity: Math.min(100, Math.round((score / selfScore) * 100)),
        exactConstituents: [...(exactMap.get(herbId) ?? [])],
        sharedSubclasses:  [...(subclassMap.get(herbId) ?? [])],
        sharedClasses:     [...(classMap.get(herbId) ?? [])],
      }))
      .filter((a) => a.herb != null);
  })();

  // Tooltip herb list for hovered constituent (existing Constituents section)
  const tooltipHerbs = (() => {
    if (hoveredConstituentId == null) return [];
    return (constituentIndex.get(hoveredConstituentId) ?? [])
      .filter((r) => r.herb_id !== selectedHerb?.id && r.concentration_level !== 'trace')
      .sort((a, b) => LEVEL_WEIGHT[b.concentration_level] - LEVEL_WEIGHT[a.concentration_level])
      .map((r) => ({ herb: herbs.find((h) => h.id === r.herb_id), level: r.concentration_level }))
      .filter((x) => x.herb != null);
  })();


  function calcTooltipPos(el: HTMLElement) {
    const rect = el.getBoundingClientRect();
    const POPUP_W = 272;
    const x = Math.min(rect.left, window.innerWidth - POPUP_W - 8);
    const spaceBelow = window.innerHeight - rect.bottom - 6;
    const y = spaceBelow > 200 ? rect.bottom + 6 : Math.max(8, rect.top - 300);
    return { x, y };
  }

  function handlePillMouseEnter(constituentId: number, e: React.MouseEvent) {
    if (hoverTimerRef.current) clearTimeout(hoverTimerRef.current);
    setTooltipPos(calcTooltipPos(e.currentTarget as HTMLElement));
    hoverTimerRef.current = setTimeout(() => setHoveredConstituentId(constituentId), 120);
  }

  function handlePillClick(constituentId: number, e: React.MouseEvent) {
    e.stopPropagation();
    if (hoveredConstituentId === constituentId) {
      setHoveredConstituentId(null);
      setTooltipPos(null);
    } else {
      setTooltipPos(calcTooltipPos(e.currentTarget as HTMLElement));
      setHoveredConstituentId(constituentId);
    }
  }

  function handlePillMouseLeave() {
    if (hoverTimerRef.current) clearTimeout(hoverTimerRef.current);
    hoverTimerRef.current = setTimeout(() => {
      setHoveredConstituentId(null);
      setTooltipPos(null);
    }, 200);
  }

  function handleTooltipMouseEnter() {
    if (hoverTimerRef.current) clearTimeout(hoverTimerRef.current);
  }

  function handleTooltipMouseLeave() {
    setHoveredConstituentId(null);
    setTooltipPos(null);
  }

  if (loading) return <div className="text-center py-8">Loading herbs...</div>;

  return (
    <div className="grid grid-cols-1 lg:grid-cols-3 gap-6 items-start" onClick={() => { if (hoveredConstituentId != null) { setHoveredConstituentId(null); setTooltipPos(null); } }}>
      {/* Herb List */}
      <div className="lg:col-span-1 bg-white rounded-lg shadow-lg p-6">
        <div className="flex gap-2 items-center mb-4">
          <div className="relative flex-1">
            <input
              type="text"
              placeholder="Search herbs..."
              value={searchTerm}
              onChange={(e) => { setSearchTerm(e.target.value); setHighlightedIndex(-1); if (e.target.value) setMobileListOpen(true); }}
              onFocus={() => setMobileListOpen(true)}
              onKeyDown={(e) => {
                if (e.key === 'ArrowDown') {
                  e.preventDefault();
                  const total = filteredHerbs.length + keywordMatchedHerbs.length + filteredSupplements.length + filteredEssences.length;
                  setHighlightedIndex((i) => Math.min(i + 1, total - 1));
                } else if (e.key === 'ArrowUp') {
                  e.preventDefault();
                  setHighlightedIndex((i) => Math.max(i - 1, -1));
                } else if (e.key === 'Enter' && highlightedIndex >= 0) {
                  const herbCount = filteredHerbs.length + keywordMatchedHerbs.length;
                  setSearchTerm('');
                  setHighlightedIndex(-1);
                  setMobileListOpen(false);
                  if (highlightedIndex < filteredHerbs.length) {
                    const herb = filteredHerbs[highlightedIndex];
                    setSelectedSupplement(null);
                    setAlternatesOpen(false);
                    setSectionsOpen({ primaryActions: true, secondaryActions: true, constituentProfile: true, constituents: true, disorders: true, pairings: true, contraindications: true, mmMateriaMedica: true, herbContraindications: true, classNotes: true });
                    fetchHerbDetail(herb.id);
                    onHerbIdChange?.(herb.id);
                  } else if (highlightedIndex < herbCount) {
                    const herb = keywordMatchedHerbs[highlightedIndex - filteredHerbs.length];
                    setSelectedSupplement(null);
                    setAlternatesOpen(false);
                    setSectionsOpen({ primaryActions: true, secondaryActions: true, constituentProfile: true, constituents: true, disorders: true, pairings: true, contraindications: true, mmMateriaMedica: true, herbContraindications: true, classNotes: true });
                    fetchHerbDetail(herb.id);
                    onHerbIdChange?.(herb.id);
                  } else {
                    const suppIdx = highlightedIndex - herbCount;
                    if (suppIdx < filteredSupplements.length) {
                      const supp = filteredSupplements[suppIdx];
                      setSelectedSupplement(supp);
                      setSelectedHerb(null);
                      onSupplementClick?.(supp.id);
                    } else {
                      const ess = filteredEssences[suppIdx - filteredSupplements.length];
                      if (ess) {
                        setSelectedEssence(ess);
                        setSelectedHerb(null);
                        setSelectedSupplement(null);
                        onEssenceClick?.(ess.id);
                      }
                    }
                  }
                  if (typeof window !== 'undefined' && window.innerWidth < 1024) {
                    setTimeout(() => detailPanelRef.current?.scrollIntoView({ behavior: 'smooth', block: 'start' }), 50);
                  } else {
                    window.scrollTo({ top: 0, behavior: 'smooth' });
                  }
                } else if (e.key === 'Escape') {
                  setHighlightedIndex(-1);
                }
              }}
              className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-transparent"
            />
            {searchTerm && (
              <button
                onClick={() => setSearchTerm('')}
                className="absolute right-2 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600 px-1"
                aria-label="Clear search"
              >
                ×
              </button>
            )}
          </div>
          <button
            className="lg:hidden flex-shrink-0 p-2 rounded-lg text-gray-500 hover:text-gray-700 hover:bg-gray-100 transition-all"
            onClick={() => setMobileListOpen((prev) => !prev)}
            aria-label="Toggle herb list"
          >
            <svg className={`w-5 h-5 transition-transform duration-200 ${mobileListOpen ? 'rotate-180' : ''}`} fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
            </svg>
          </button>
        </div>

        <div className={`${mobileListOpen ? '' : 'hidden'} lg:block`}>
        <div className="flex flex-wrap items-center gap-x-4 gap-y-1 mb-3">
          <label className="flex items-center gap-2 cursor-pointer select-none text-sm text-gray-600">
            <input
              type="checkbox"
              checked={includeTCM}
              onChange={(e) => setIncludeTCM(e.target.checked)}
              className="h-4 w-4 rounded border-gray-300 text-green-600 focus:ring-green-500"
            />
            Include TCM-only herbs
          </label>
          <div className="ml-auto flex flex-col items-end gap-1">
            {filteredSupplements.length > 0 && (
              <button
                onClick={() => {
                  const el = vitaminsSectionRef.current;
                  if (!el) return;
                  let container: HTMLElement | null = el.parentElement;
                  while (container) {
                    const { overflowY } = getComputedStyle(container);
                    if (overflowY === 'auto' || overflowY === 'scroll') break;
                    container = container.parentElement;
                  }
                  if (!container) return;
                  const cRect = container.getBoundingClientRect();
                  const eRect = el.getBoundingClientRect();
                  container.scrollTo({ top: eRect.top - cRect.top + container.scrollTop - 8, behavior: 'smooth' });
                }}
                className="text-sm text-indigo-500 hover:text-indigo-700 hover:underline transition-colors"
              >
                Jump to vitamins &amp; supplements ↓
              </button>
            )}
            {filteredEssences.length > 0 && (
              <button
                onClick={() => {
                  const el = essenceSectionRef.current;
                  if (!el) return;
                  let container: HTMLElement | null = el.parentElement;
                  while (container) {
                    const { overflowY } = getComputedStyle(container);
                    if (overflowY === 'auto' || overflowY === 'scroll') break;
                    container = container.parentElement;
                  }
                  if (!container) return;
                  const cRect = container.getBoundingClientRect();
                  const eRect = el.getBoundingClientRect();
                  container.scrollTo({ top: eRect.top - cRect.top + container.scrollTop - 8, behavior: 'smooth' });
                }}
                className="text-sm text-purple-500 hover:text-purple-700 hover:underline transition-colors"
              >
                Jump to flower essences ↓
              </button>
            )}
          </div>
        </div>

        <div className="space-y-2 max-h-[70vh] overflow-y-auto px-1 py-1">
          {filteredHerbs.map((herb, idx) => (
            <div key={herb.id} className="relative group/herbcard">
            <button
              ref={(el) => {
                if (el) herbRefs.current.set(herb.id, el);
                else herbRefs.current.delete(herb.id);
              }}
              onClick={() => {
                setSearchTerm('');
                setHighlightedIndex(-1);
                setMobileListOpen(false);
                if (pairingsMode) {
                  onHerbClick?.(herb.id);
                } else {
                  setSelectedSupplement(null);
                  setAlternatesOpen(false);
                  setSectionsOpen({ primaryActions: true, secondaryActions: true, constituentProfile: true, constituents: true, disorders: true, pairings: true, contraindications: true, mmMateriaMedica: true, herbContraindications: true, classNotes: true });
                  fetchHerbDetail(herb.id);
                  onHerbIdChange?.(herb.id);
                  if (typeof window !== 'undefined' && window.innerWidth < 1024) {
                    setTimeout(() => detailPanelRef.current?.scrollIntoView({ behavior: 'smooth', block: 'start' }), 50);
                  } else {
                    window.scrollTo({ top: 0, behavior: 'smooth' });
                  }
                }
              }}
              className={`w-full text-left p-3 rounded-lg border transition-all scroll-my-1 ${
                selectedHerb?.id === herb.id ? 'ring-2 ring-green-500 ring-offset-1' :
                highlightedIndex === idx ? 'ring-2 ring-green-300 ring-offset-1' : ''
              } ${
                herb.temperature === 'warming' ? 'bg-amber-50 border-amber-200 hover:bg-amber-100' :
                herb.temperature === 'cooling' ? 'bg-sky-50 border-sky-200 hover:bg-sky-100' :
                'bg-gray-50 border-gray-200 hover:bg-gray-100'
              }`}
            >
              <div className="flex items-start justify-between gap-1">
                <div>
                  <div className="font-semibold text-gray-900">{herb.common_name}{herb.plant_part ? ` (${herb.plant_part})` : ''}</div>
                  {herb.pinyin_name && (
                    <div className="text-xs text-gray-500">{herb.pinyin_name}</div>
                  )}
                  <div className="text-sm italic text-gray-600">{herb.latin_name}</div>
                </div>
                <div className="flex items-center gap-1 shrink-0 mt-0.5">
                  {herb.is_tcm && (
                    <span className="text-[10px] px-1.5 py-0.5 rounded-full bg-red-50 border border-red-200 text-red-700 font-semibold">TCM</span>
                  )}
                  <EnergeticEmojis temperature={herb.temperature} moisture={herb.moisture} tone={herb.tone} taste={herb.taste} temperatureInferred={herb.temperature_inferred} moistureInferred={herb.moisture_inferred} toneInferred={herb.tone_inferred} tasteInferred={herb.taste_inferred} className="text-sm leading-none" />
                </div>
              </div>
            </button>
            {pairedHerbIds.has(herb.id) && (
              <button
                onClick={() => onShowPairings?.(herb.id)}
                className="absolute bottom-2 right-2 p-1 rounded text-gray-400 hover:text-indigo-500 transition-colors"
                title="View in pairings graph"
                tabIndex={-1}
              >
                <LinkIcon className="w-3.5 h-3.5" />
              </button>
            )}
            </div>
          ))}

          {/* Keyword-matched herbs from class notes */}
          {keywordMatchedHerbs.length > 0 && (
            <>
              <div className="pt-3 pb-1 px-1">
                <div className="border-t border-amber-200 mb-2" />
                <p className="text-xs font-semibold text-amber-600 uppercase tracking-widest">Found in class notes</p>
              </div>
              {keywordMatchedHerbs.map((herb, kwIdx) => (
                <button
                  key={`kw-${herb.id}`}
                  ref={(el) => { if (el) herbRefs.current.set(herb.id, el); else herbRefs.current.delete(herb.id); }}
                  onClick={() => {
                    setSearchTerm('');
                    setHighlightedIndex(-1);
                    setMobileListOpen(false);
                    setSelectedSupplement(null);
                    setAlternatesOpen(false);
                    setSectionsOpen({ primaryActions: true, secondaryActions: true, constituentProfile: true, constituents: true, disorders: true, pairings: true, contraindications: true, mmMateriaMedica: true, herbContraindications: true, classNotes: true });
                    fetchHerbDetail(herb.id);
                    onHerbIdChange?.(herb.id);
                    if (typeof window !== 'undefined' && window.innerWidth < 1024) {
                      setTimeout(() => detailPanelRef.current?.scrollIntoView({ behavior: 'smooth', block: 'start' }), 50);
                    } else {
                      window.scrollTo({ top: 0, behavior: 'smooth' });
                    }
                  }}
                  className={`w-full text-left p-3 rounded-lg border transition-all ${
                    highlightedIndex === filteredHerbs.length + kwIdx
                      ? 'ring-2 ring-amber-400 ring-offset-1 bg-amber-100 border-amber-300'
                      : selectedHerb?.id === herb.id
                        ? 'ring-2 ring-amber-400 ring-offset-1 bg-amber-50 border-amber-300'
                        : 'bg-amber-50/60 border-amber-200 hover:bg-amber-100 hover:border-amber-300'
                  }`}
                >
                  <div className="flex items-start gap-2">
                    <div className="flex-1 min-w-0">
                      <div className="font-semibold text-gray-900 text-sm">{herb.common_name}{herb.plant_part ? ` (${herb.plant_part})` : ''}</div>
                      <div className="text-xs italic text-gray-500">{herb.latin_name}</div>
                    </div>
                    {(keywordLabels.get(herb.id) ?? []).length > 0 && (
                      <div className="flex flex-wrap gap-1 justify-end shrink-0 pt-0.5">
                        {(keywordLabels.get(herb.id) ?? []).slice(0, 3).map((kw) => (
                          <span key={kw} className="text-[10px] text-amber-700 bg-white border border-amber-300 px-1.5 py-0.5 rounded-full whitespace-nowrap">
                            {kw}
                          </span>
                        ))}
                      </div>
                    )}
                  </div>
                </button>
              ))}
            </>
          )}

          {/* Supplements section */}
          {filteredSupplements.length > 0 && (
            <>
              <div ref={vitaminsSectionRef} className="pt-3 pb-1 px-1">
                <p className="text-xs font-semibold text-indigo-400 uppercase tracking-widest">Vitamins &amp; Supplements</p>
              </div>
              {filteredSupplements.map((supplement, suppIdx) => {
                const suppNavIdx = filteredHerbs.length + keywordMatchedHerbs.length + suppIdx;
                return (
                  <button
                    key={`supp-${supplement.id}`}
                    ref={(el) => { if (el) supplementRefs.current.set(supplement.id, el); else supplementRefs.current.delete(supplement.id); }}
                    onClick={() => {
                      setSelectedSupplement(supplement);
                      setSelectedHerb(null);
                      onSupplementClick?.(supplement.id);
                      setSearchTerm('');
                      setMobileListOpen(false);
                      if (typeof window !== 'undefined' && window.innerWidth < 1024) {
                        setTimeout(() => detailPanelRef.current?.scrollIntoView({ behavior: 'smooth', block: 'start' }), 50);
                      } else {
                        window.scrollTo({ top: 0, behavior: 'smooth' });
                      }
                    }}
                    className={`w-full text-left p-3 rounded-lg border transition-all ${
                      highlightedIndex === suppNavIdx
                        ? 'ring-2 ring-indigo-400 ring-offset-1 bg-indigo-100 border-indigo-300'
                        : selectedSupplement?.id === supplement.id
                          ? solubilityStyles(supplement.solubility).cardSelected
                          : solubilityStyles(supplement.solubility).card
                    }`}
                  >
                    <div className="flex items-center justify-between gap-2 min-w-0">
                      <div className="font-semibold text-gray-900 truncate">{supplement.name}</div>
                      {supplement.category === 'Mineral' && supplement.temperature !== 'warming' && (
                        <EnergeticEmojis temperature="cooling" className="text-base leading-none shrink-0" />
                      )}
                    </div>
                    <div className="flex items-center justify-between gap-2 mt-1.5">
                      <div className="text-sm text-indigo-600 min-w-0 truncate">{supplement.category}{supplement.subcategory ? ` · ${supplement.subcategory}` : ''}</div>
                      {supplement.solubility && (
                        <span className={`text-[10px] px-1.5 py-0.5 rounded-full border font-medium shrink-0 ${solubilityStyles(supplement.solubility).badge}`}>
                          {solubilityLabel(supplement.solubility)}
                        </span>
                      )}
                    </div>
                  </button>
                );
              })}
            </>
          )}

          {/* Flower Essences section */}
          {filteredEssences.length > 0 && (
            <>
              <div ref={essenceSectionRef} className="pt-3 pb-1 px-1">
                <p className="text-xs font-semibold text-purple-400 uppercase tracking-widest">Flower Essences</p>
              </div>
              {filteredEssences.map((essence) => (
                <button
                  key={`ess-${essence.id}`}
                  ref={(el) => { if (el) essenceRefs.current.set(essence.id, el); else essenceRefs.current.delete(essence.id); }}
                  onClick={() => {
                    setSelectedEssence(essence);
                    setSelectedHerb(null);
                    setSelectedSupplement(null);
                    onEssenceClick?.(essence.id);
                    setSearchTerm('');
                    setMobileListOpen(false);
                    if (typeof window !== 'undefined' && window.innerWidth < 1024) {
                      setTimeout(() => detailPanelRef.current?.scrollIntoView({ behavior: 'smooth', block: 'start' }), 50);
                    } else {
                      window.scrollTo({ top: 0, behavior: 'smooth' });
                    }
                  }}
                  className={`w-full text-left p-3 rounded-lg border transition-all ${
                    selectedEssence?.id === essence.id
                      ? 'ring-2 ring-purple-400 ring-offset-1 bg-purple-50 border-purple-200'
                      : 'bg-purple-50/40 border-purple-100 hover:bg-purple-50 hover:border-purple-200'
                  }`}
                >
                  <div className="flex items-center justify-between gap-2 min-w-0">
                    <div className="font-semibold text-gray-900 truncate">{essence.name} <span className="font-normal text-purple-400">(essence)</span></div>
                  </div>
                  {essence.latin_name && (
                    <div className="text-sm italic text-gray-500 mt-0.5 truncate">{essence.latin_name}</div>
                  )}
                </button>
              ))}
            </>
          )}
        </div>
        </div>
      </div>

      {/* Herb / Supplement / Essence Details — or Pairings graph */}
      {pairingsMode ? (
        <div className="lg:col-span-2 bg-white rounded-lg shadow-lg overflow-hidden flex flex-col" style={{ height: 'calc(100vh - 11rem)' }}>
          <PairingsView onHerbClick={(id) => onHerbClick?.(id)} onFocusChange={onFocusChange} initialFocusId={pairingsInitialFocusId} />
        </div>
      ) : null}
      <div ref={detailPanelRef} className={`lg:col-span-2 bg-white rounded-lg shadow-lg p-6${pairingsMode ? ' hidden' : ''}`}>
        {selectedSupplement && !selectedHerb && !selectedEssence ? (
          <SupplementDetail
            supplement={selectedSupplement}
            onDisorderClick={onDisorderClick}
          />
        ) : selectedEssence && !selectedHerb && !selectedSupplement ? (
          <FlowerEssenceDetail
            essence={selectedEssence}
            onSoulConditionClick={onSoulConditionClick}
          />
        ) : selectedHerb ? (
          <div>
            {/* Header */}
            <div className="flex flex-col sm:flex-row sm:items-start sm:justify-between mb-3">
              <div>
                <h2 className="text-3xl font-bold text-green-800">{selectedHerb.common_name}{selectedHerb.plant_part ? ` (${selectedHerb.plant_part})` : ''}</h2>
                {selectedHerb.pinyin_name && (
                  <p className="text-lg text-gray-500 mt-0.5">{selectedHerb.pinyin_name}</p>
                )}
                <p className="text-xl italic text-gray-600">{selectedHerb.latin_name}</p>
              </div>
              <div className="flex flex-col items-end gap-1.5 mt-2 sm:mt-0 sm:ml-4 shrink-0">
                {/* Monograph links — single link shown directly; multiple collapse into a dropdown */}
                {(() => {
                  const sorted = (selectedHerb.herb_monograph_links ?? []).slice().sort((a, b) => a.sort_order - b.sort_order);
                  const addBtn = (
                    <button
                      onClick={() => { setNewLinkUrl(''); setAddLinkOpen(true); }}
                      className="px-3 py-1 text-green-700 border border-green-300 rounded hover:bg-green-50 transition-colors text-sm font-bold leading-none shrink-0"
                      title="Add monograph link"
                    >
                      +
                    </button>
                  );
                  if (sorted.length === 0) return <div className="flex items-center gap-1.5">{addBtn}</div>;
                  if (sorted.length === 1) {
                    return (
                      <div className="flex items-center gap-1.5">
                        <a href={sorted[0].url} target="_blank" rel="noopener noreferrer"
                          className="px-4 py-2 bg-green-700 text-white text-sm font-bold rounded hover:bg-green-800 transition-colors">
                          {sorted[0].label || 'MONOGRAPH'}
                        </a>
                        {addBtn}
                      </div>
                    );
                  }
                  // Multiple links → dropdown
                  return (
                    <div ref={monographDropdownRef} className="flex items-center gap-1.5">
                      <div className="relative">
                        <button
                          onClick={() => setMonographDropdownOpen((v) => !v)}
                          className="flex items-center gap-2 px-4 py-2 bg-green-700 text-white text-sm font-bold rounded hover:bg-green-800 transition-colors"
                        >
                          MONOGRAPHS
                          <svg className={`w-3 h-3 transition-transform ${monographDropdownOpen ? 'rotate-180' : ''}`} fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                          </svg>
                        </button>
                        {monographDropdownOpen && (
                          <div className="absolute top-full right-0 mt-1 bg-white rounded-lg shadow-lg border border-gray-200 z-50 min-w-full">
                            {sorted.map((link) => (
                              <a
                                key={link.id}
                                href={link.url}
                                target="_blank"
                                rel="noopener noreferrer"
                                onClick={() => setMonographDropdownOpen(false)}
                                className="block px-4 py-2 text-sm text-green-700 font-semibold hover:bg-green-50 first:rounded-t-lg last:rounded-b-lg whitespace-nowrap"
                              >
                                {link.label || 'MONOGRAPH'}
                              </a>
                            ))}
                          </div>
                        )}
                      </div>
                      {addBtn}
                    </div>
                  );
                })()}
                {/* Energetics badges — all in one row, inferred ones get inline i buttons; extra top spacing from monograph */}
                {(() => {
                  const badges: { emoji: string; label: string; inferred: boolean; isTaste: boolean }[] = [];
                  if (selectedHerb.temperature === 'warming')  badges.push({ emoji: '🔥', label: 'Warming',      inferred: !!selectedHerb.temperature_inferred, isTaste: false });
                  if (selectedHerb.temperature === 'cooling')  badges.push({ emoji: '❄️', label: 'Cooling',      inferred: !!selectedHerb.temperature_inferred, isTaste: false });
                  if (selectedHerb.moisture === 'moistening')  badges.push({ emoji: '💧', label: 'Moistening',   inferred: !!selectedHerb.moisture_inferred,     isTaste: false });
                  if (selectedHerb.moisture === 'drying')      badges.push({ emoji: '🌵', label: 'Drying',       inferred: !!selectedHerb.moisture_inferred,     isTaste: false });
                  if (selectedHerb.tone === 'toning')          badges.push({ emoji: '⚡', label: 'Toning',       inferred: !!selectedHerb.tone_inferred,         isTaste: false });
                  if (selectedHerb.tone === 'relaxing')        badges.push({ emoji: '🌊', label: 'Relaxing',     inferred: !!selectedHerb.tone_inferred,         isTaste: false });
                  if (selectedHerb.taste === 'sweet')          badges.push({ emoji: '🍯', label: 'Sweet taste',  inferred: !!selectedHerb.taste_inferred,        isTaste: true });
                  if (selectedHerb.taste === 'bitter')         badges.push({ emoji: '☕', label: 'Bitter taste', inferred: !!selectedHerb.taste_inferred,        isTaste: true });
                  if (selectedHerb.taste === 'pungent')        badges.push({ emoji: '🌶️', label: 'Pungent taste', inferred: !!selectedHerb.taste_inferred,      isTaste: true });
                  if (selectedHerb.taste === 'salty')          badges.push({ emoji: '🧂', label: 'Salty taste',  inferred: !!selectedHerb.taste_inferred,        isTaste: true });
                  if (selectedHerb.taste === 'sour')           badges.push({ emoji: '🍋', label: 'Sour taste',   inferred: !!selectedHerb.taste_inferred,        isTaste: true });
                  if (badges.length === 0) return null;
                  const anyEnergeticsInferred = badges.some((b) => b.inferred && !b.isTaste);
                  const tasteInferred = badges.some((b) => b.inferred && b.isTaste);
                  return (
                    <div className="flex items-center gap-1.5 flex-wrap justify-end mt-2">
                      {badges.map(({ emoji, label, inferred }) => (
                        <span
                          key={label}
                          className={`inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full border text-sm font-medium ${
                            inferred
                              ? 'border-gray-200 bg-gray-50 text-gray-400'
                              : 'border-green-200 bg-green-50 text-green-700'
                          }`}
                        >
                          <span>{emoji}</span>
                          <span>{label}</span>
                          {inferred && <span className="text-xs opacity-60 italic">inferred</span>}
                        </span>
                      ))}
                      {anyEnergeticsInferred && (
                        <button
                          onClick={() => setInferredEnergeticsOpen(true)}
                          className="w-5 h-5 rounded-full border border-gray-300 text-gray-400 text-xs flex items-center justify-center hover:border-gray-500 hover:text-gray-600 transition-colors font-serif italic leading-none shrink-0"
                          title="How were these energetics inferred?"
                        >
                          i
                        </button>
                      )}
                      {tasteInferred && (
                        <button
                          onClick={() => setInferredTasteOpen(true)}
                          className="w-5 h-5 rounded-full border border-amber-300 text-amber-500 text-xs flex items-center justify-center hover:border-amber-500 hover:text-amber-700 transition-colors font-serif italic leading-none shrink-0"
                          title="How was this taste inferred?"
                        >
                          i
                        </button>
                      )}
                    </div>
                  );
                })()}
              </div>
            </div>

            {/* Section nav + expand/collapse all */}
            <div className="flex flex-wrap gap-1.5 mb-2 text-xs">
              {[
                { key: 'primaryActions' as const, label: 'Primary Actions', pink: false },
                ...(selectedHerb.herb_secondary_actions.length > 0 ? [{ key: 'secondaryActions' as const, label: 'Secondary Actions', pink: false }] : []),
                ...(classNoteSnippets.length > 0 ? [{ key: 'classNotes' as const, label: 'Class Notes', pink: false }] : []),
                ...(selectedProfiles.length > 0 ? [{ key: 'constituentProfile' as const, label: 'Constituents', pink: false }] : []),
                ...(((selectedHerb.herb_constituents?.length ?? 0) > 0 || selectedHerb.herb_menstruum) ? [{ key: 'constituents' as const, label: 'General Constituents', pink: false }] : []),
                ...((((selectedHerb.disorder_action_herbs?.length ?? 0) > 0) || ((selectedHerb.disorder_specific_remedies?.length ?? 0) > 0)) ? [{ key: 'disorders' as const, label: 'Disorders', pink: false }] : []),
                ...((duiYaoPairs.length > 0 || priestPairings.length > 0) ? [{ key: 'pairings' as const, label: 'Pairings', pink: false }] : []),
                ...(MM_MATERIA_MEDICA[selectedHerb.id] ? [{ key: 'mmMateriaMedica' as const, label: 'MM Materia Medica', pink: false }] : []),
                ...(CONTRAINDICATIONS[selectedHerb.id] ? [{ key: 'contraindications' as const, label: 'Drug Interactions', pink: true }] : []),
                ...(selectedHerb.contraindications ? [{ key: 'herbContraindications' as const, label: 'Contraindications', pink: true }] : []),
              ].map(({ key, label, pink }) => (
                <button
                  key={key}
                  onClick={() => scrollToSection(key)}
                  className={pink
                    ? 'px-2.5 py-1 rounded-full border border-red-200 text-red-400 bg-red-50 hover:border-red-400 hover:text-red-600 transition-colors'
                    : 'px-2.5 py-1 rounded-full border border-gray-300 text-gray-500 hover:border-green-500 hover:text-green-700 transition-colors'}
                >
                  {label}
                </button>
              ))}
            </div>

            {/* Herb image — paste ⌘V to upload */}
            <HerbImageUpload herbId={selectedHerb.id} />

            <div className="flex justify-end mb-5">
              <button
                onClick={() => {
                  const allOpen = Object.values(sectionsOpen).every(Boolean);
                  setSectionsOpen({ primaryActions: !allOpen, secondaryActions: !allOpen, constituentProfile: !allOpen, constituents: !allOpen, disorders: !allOpen, pairings: !allOpen, contraindications: !allOpen, mmMateriaMedica: !allOpen, herbContraindications: !allOpen, classNotes: !allOpen });
                }}
                className="flex items-center gap-1.5 px-3 py-1 rounded-full border border-gray-300 text-xs text-gray-500 hover:border-gray-400 hover:text-gray-700 transition-colors"
              >
                <svg className={`w-3 h-3 transition-transform ${Object.values(sectionsOpen).every(Boolean) ? '' : '-rotate-90'}`} fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                </svg>
                {Object.values(sectionsOpen).every(Boolean) ? 'Collapse all' : 'Expand all'}
              </button>
            </div>

            {/* Primary Actions & Body Systems */}
            <div className="mb-6" ref={(el) => { sectionRefs.current.primaryActions = el; }}>
              <SectionHeader title="Primary Actions & Body Systems" open={sectionsOpen.primaryActions} onToggle={() => toggleSection('primaryActions')} />
              {sectionsOpen.primaryActions && (
                selectedHerb.herb_primary_actions.length > 0
                  ? (() => {
                      const bySystem = new Map<string, typeof selectedHerb.herb_primary_actions>();
                      selectedHerb.herb_primary_actions.forEach((action) => {
                        const sysName = action.body_systems?.name ?? 'General';
                        if (!bySystem.has(sysName)) bySystem.set(sysName, []);
                        bySystem.get(sysName)!.push(action);
                      });
                      const sortedSystems = [...bySystem.entries()].sort(([a], [b]) => {
                        if (a === 'General') return 1;
                        if (b === 'General') return -1;
                        return a.localeCompare(b);
                      });
                      return (
                        <div className="space-y-6 pl-4 border-l-2 border-green-100">
                          {sortedSystems.map(([sysName, actions]) => (
                            <div key={sysName}>
                              <h4 className="text-sm font-semibold text-gray-500 uppercase tracking-wider mb-2 border-b border-gray-100 pb-1">
                                {sysName}
                              </h4>
                              <div className="grid grid-cols-1 sm:grid-cols-2 gap-2">
                                {[...actions].sort((a, b) => a.primary_actions.name.localeCompare(b.primary_actions.name)).map((action, idx) => (
                                  <button
                                    key={idx}
                                    onClick={() => onActionClick?.(action.primary_actions.id)}
                                    className="w-full bg-gray-50 border border-gray-200 rounded-lg py-1.5 px-4 hover:border-green-400 hover:shadow-sm hover:scale-[1.02] transition-all cursor-pointer text-left"
                                  >
                                    <div className="flex items-start justify-between">
                                      <h5 className="text-base font-semibold text-green-700">{action.primary_actions.name}</h5>
                                      {action.relative_strength && (
                                        <span className={`px-3 py-1 rounded-full text-xs font-medium ${getStrengthColor(action.relative_strength)}`}>
                                          {action.relative_strength.replace('_', ' ')}
                                        </span>
                                      )}
                                    </div>
                                    {action.body_system_note && (
                                      <p className="text-sm text-gray-700 mt-1">{action.body_system_note}</p>
                                    )}
                                  </button>
                                ))}
                              </div>
                            </div>
                          ))}
                        </div>
                      );
                    })()
                  : <p className="text-gray-500 italic">No primary actions recorded for this herb.</p>
              )}
            </div>

            {/* Secondary Actions */}
            {selectedHerb.herb_secondary_actions.length > 0 && (
              <div className="mb-6" ref={(el) => { sectionRefs.current.secondaryActions = el; }}>
                <SectionHeader title="Secondary Actions" open={sectionsOpen.secondaryActions} onToggle={() => toggleSection('secondaryActions')} />
                {sectionsOpen.secondaryActions && (
                  <div className="flex flex-wrap gap-2">
                    {[...new Map(selectedHerb.herb_secondary_actions.map(i => [i.secondary_actions.name, i])).values()].sort((a, b) => a.secondary_actions.name.localeCompare(b.secondary_actions.name)).map((item, idx) => (
                      <button
                        key={idx}
                        onClick={() => onActionNameClick?.(item.secondary_actions.name)}
                        className="px-3 py-1.5 bg-teal-50 text-teal-800 border border-teal-200 rounded-full text-sm hover:bg-teal-100 hover:border-teal-400 transition-colors cursor-pointer"
                      >
                        {item.secondary_actions.name}
                      </button>
                    ))}
                  </div>
                )}
              </div>
            )}

            {/* ── Detail loading indicator ─────────────────────────────────── */}
            {detailLoading && !selectedHerb.herb_constituents && (
              <div className="text-sm text-gray-400 py-4 text-center">Loading constituents…</div>
            )}

            {/* ── Class Notes ────────────────────────────────────────────── */}
            {classNoteSnippets.length > 0 && (
              <div className="mb-6" ref={(el) => { sectionRefs.current.classNotes = el; }}>
                <SectionHeader title="Class Notes" open={sectionsOpen.classNotes} onToggle={() => toggleSection('classNotes')} />
                {sectionsOpen.classNotes && (
                  <div className="pl-4 border-l-2 border-teal-100 space-y-2">
                    {classNoteSnippets.map((snippet) => (
                      <div key={snippet.id} className="border border-teal-200 rounded-lg px-4 py-3 bg-teal-50/50">
                        <p className="text-sm text-gray-800">{snippet.snippet_text}</p>
                        <div className="flex flex-wrap items-center gap-2 mt-1.5">
                          <a
                            href="https://1drv.ms/f/c/2C944FF46704ED09/IgDp6eLOYY2nSqOl4q-5M-MjAXgrqOPXRbJsZZFM8nCRBeA?e=YPDjNw"
                            target="_blank"
                            rel="noopener noreferrer"
                            className="text-xs text-teal-700 font-medium hover:text-teal-900 hover:underline"
                            onClick={(e) => e.stopPropagation()}
                          >
                            {snippet.class_name}
                          </a>
                          {snippet.section_header && (
                            <>
                              <span className="text-xs text-teal-300">·</span>
                              <span className="text-xs text-teal-600">{snippet.section_header}</span>
                            </>
                          )}
                          <span className={`ml-auto text-[10px] px-1.5 py-0.5 rounded-full border font-semibold ${
                            snippet.note_type === 'personal'
                              ? 'bg-purple-50 border-purple-200 text-purple-700'
                              : 'bg-sky-50 border-sky-200 text-sky-700'
                          }`}>
                            {snippet.note_type === 'personal' ? 'personal' : 'generated'}
                          </span>
                        </div>
                        {snippet.source_block && (
                          <details className="mt-2">
                            <summary className="text-xs text-teal-500 cursor-pointer select-none hover:text-teal-700">
                              View in context
                            </summary>
                            <blockquote className="mt-1.5 pl-3 border-l-2 border-teal-300 text-xs text-gray-600 whitespace-pre-wrap font-mono leading-relaxed">
                              {highlightHerbName(snippet.source_block, [
                                selectedHerb.common_name,
                                ...(selectedHerb.synonyms ?? []),
                              ])}
                            </blockquote>
                          </details>
                        )}
                      </div>
                    ))}
                  </div>
                )}
              </div>
            )}

            {/* ── Constituent Profile ───────────────────────────────────────── */}
            {selectedProfiles.length > 0 && (
              <div className="mb-6" ref={(el) => { sectionRefs.current.constituentProfile = el; }}>
                <SectionHeader title="Constituent Profile Markers" open={sectionsOpen.constituentProfile} onToggle={() => toggleSection('constituentProfile')} />
                {sectionsOpen.constituentProfile && (
                  <div>
                    <div className="flex flex-col gap-2 mb-4">
                      {[...selectedProfiles]
                        .sort((a, b) => {
                          const SO: Record<string, number> = { Marker: 0, Major: 1, Present: 2, Reported: 3 };
                          const IO: Record<string, number> = { High: 0, Moderate: 1, 'Low-Moderate': 2, 'Low–Moderate': 2, Low: 3 };
                          const s = (SO[a.status ?? ''] ?? 4) - (SO[b.status ?? ''] ?? 4);
                          return s !== 0 ? s : (IO[a.importance ?? ''] ?? 4) - (IO[b.importance ?? ''] ?? 4);
                        })
                        .map((p) => (
                          <div
                            key={p.id}
                            className="flex flex-col px-3 py-1.5 rounded-lg border bg-amber-50 border-amber-300 cursor-default select-none"
                          >
                            <span className="text-base font-semibold text-amber-900">{p.constituent}</span>
                            <div className="flex flex-col sm:flex-row sm:flex-wrap sm:items-center gap-1 sm:gap-1.5 mt-0.5">
                              {(p.class || p.subclass) && (
                                <div className="flex items-center gap-1.5">
                                  {p.class && <span className="text-xs text-gray-500">{p.class}</span>}
                                  {p.class && p.subclass && <span className="text-xs text-gray-400">›</span>}
                                  {p.subclass && <span className="text-xs text-amber-700 font-medium">{p.subclass}</span>}
                                </div>
                              )}
                              {(p.status || p.importance) && (
                                <div className="flex flex-wrap items-center gap-1.5">
                                  {p.status && (
                                    <span className={`text-xs px-1.5 py-0.5 rounded-full border font-medium ${statusBadgeColor(p.status)}`}>
                                      {p.status}
                                    </span>
                                  )}
                                  {p.importance && (
                                    <span className={`text-xs px-1.5 py-0.5 rounded-full border font-medium ${importanceBadgeColor(p.importance)}`}>
                                      {p.importance}
                                    </span>
                                  )}
                                </div>
                              )}
                            </div>
                            {p.notes && (
                              <p className="text-xs text-gray-600 italic mt-1 leading-snug">{p.notes}</p>
                            )}
                          </div>
                        ))}
                    </div>

                    {/* Editorial note(s) */}
                    {(() => {
                      const notes = [...new Set(
                        selectedProfiles.map((p) => p.editorial_note?.trim()).filter(Boolean) as string[]
                      )];
                      if (notes.length === 0) return null;
                      return (
                        <div className="mb-4 space-y-2">
                          {notes.map((note, i) => (
                            <p key={i} className="text-sm italic text-amber-800 bg-amber-50 border border-amber-200 rounded-lg px-3 py-2">
                              {note}
                            </p>
                          ))}
                        </div>
                      );
                    })()}

                    {/* Alternates */}
                    {computedAlternates.length > 0 && (
                      <div>
                        <button
                          onClick={() => setAlternatesOpen((o) => !o)}
                          className="flex items-center gap-2 text-sm font-semibold text-gray-600 hover:text-amber-700 transition-colors"
                        >
                          <svg
                            className={`w-4 h-4 transition-transform ${alternatesOpen ? '' : '-rotate-90'}`}
                            fill="none" stroke="currentColor" viewBox="0 0 24 24"
                          >
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                          </svg>
                          <span className="hidden sm:inline">Ranked Alternates Based on Markers ({computedAlternates.length})</span>
                          <span className="sm:hidden">Ranked Alternates ({computedAlternates.length})</span>
                        </button>
                        {alternatesOpen && (
                          <div className="mt-3 space-y-2">
                            {computedAlternates.map(({ herb, similarity, exactConstituents, sharedSubclasses, sharedClasses }) => {
                              if (!herb) return null;
                              const simColor = similarity >= 50
                                ? 'bg-emerald-100 text-emerald-700 border-emerald-300'
                                : similarity >= 25
                                ? 'bg-amber-100 text-amber-700 border-amber-300'
                                : 'bg-gray-100 text-gray-500 border-gray-200';
                              return (
                                <button
                                  key={herb.id}
                                  onClick={() => navigateToHerb(herb.id)}
                                  className={`w-full text-left border rounded-lg px-4 py-2.5 transition-all hover:shadow-md hover:scale-[1.005] ${
                                    herb.temperature === 'warming' ? 'bg-amber-50 border-amber-200 hover:bg-amber-100' :
                                    herb.temperature === 'cooling' ? 'bg-sky-50 border-sky-200 hover:bg-sky-100' :
                                    'bg-gray-50 border-gray-200 hover:bg-gray-100'
                                  }`}
                                >
                                  <div className="flex items-center justify-between gap-2 mb-1.5">
                                    <div>
                                      <span className="font-medium text-gray-900 text-sm">{herb.common_name}{herb.plant_part ? ` (${herb.plant_part})` : ''}</span>
                                      <span className="text-xs italic text-gray-500 ml-2">{herb.latin_name}</span>
                                    </div>
                                    <div className="flex items-center gap-1.5 shrink-0">
                                      <span className={`text-xs px-2 py-0.5 rounded-full border font-semibold ${simColor}`}>
                                        {similarity}%
                                      </span>
                                    </div>
                                  </div>
                                  <div className="flex flex-wrap gap-1">
                                    {exactConstituents.map((name) => (
                                      <span key={name} className="text-xs px-1.5 py-0.5 rounded border bg-amber-50 text-amber-800 border-amber-300">
                                        {name}
                                      </span>
                                    ))}
                                    {sharedSubclasses.map((sub) => (
                                      <span key={sub} className="text-xs px-1.5 py-0.5 rounded border bg-yellow-50 text-yellow-700 border-yellow-300 italic">
                                        {sub}
                                      </span>
                                    ))}
                                    {exactConstituents.length === 0 && sharedSubclasses.length === 0 && sharedClasses.map((cls) => (
                                      <span key={cls} className="text-xs px-1.5 py-0.5 rounded border bg-gray-50 text-gray-500 border-gray-200 italic">
                                        {cls}
                                      </span>
                                    ))}
                                  </div>
                                </button>
                              );
                            })}
                          </div>
                        )}
                      </div>
                    )}
                  </div>
                )}
              </div>
            )}

            {/* ── Constituents ─────────────────────────────────────────────── */}
            {((selectedHerb.herb_constituents?.length ?? 0) > 0 || selectedHerb.herb_menstruum) && (
              <div className="mb-6" ref={(el) => { sectionRefs.current.constituents = el; }}>
                <SectionHeader title="General Constituents" open={sectionsOpen.constituents} onToggle={() => toggleSection('constituents')} />
                {sectionsOpen.constituents && (
                  <div>
                    <div className="flex flex-wrap gap-2 mb-4">
                      {(selectedHerb.herb_constituents ?? []).slice()
                        .sort((a, b) => {
                          const w = LEVEL_WEIGHT[a.concentration_level] - LEVEL_WEIGHT[b.concentration_level];
                          return w !== 0 ? -w : a.sort_order - b.sort_order;
                        })
                        .map((hc) => {
                          const refs = constituentIndex.get(hc.constituent_id) ?? [];
                          const otherHerbCount = refs.filter(
                            (r) => r.herb_id !== selectedHerb.id && r.concentration_level !== 'trace'
                          ).length;
                          return (
                            <div
                              key={hc.constituent_id}
                              className="relative cursor-pointer"
                              onMouseEnter={(e) => handlePillMouseEnter(hc.constituent_id, e)}
                              onMouseLeave={handlePillMouseLeave}
                              onClick={(e) => handlePillClick(hc.constituent_id, e)}
                            >
                              <span className={`inline-flex items-center gap-1 px-3 py-1 rounded-full text-xs font-medium border cursor-default select-none ${LEVEL_COLOR[hc.concentration_level as ConcentrationLevel]}`}>
                                {hc.constituents.name}
                                {hc.needs_review && <span title="Data needs review" className="opacity-60">*</span>}
                                {otherHerbCount > 0 && <span className="opacity-50 text-[10px]">({otherHerbCount})</span>}
                              </span>
                            </div>
                          );
                        })}
                    </div>
                    {selectedHerb.herb_menstruum && (
                      <div className="bg-gray-50 border border-gray-200 rounded-lg p-4">
                        <div className="flex items-center gap-1.5 mb-2">
                          <p className="text-xs font-semibold text-gray-400 uppercase tracking-widest">Best Menstruum</p>
                          <span className="relative group cursor-help">
                            <span className="w-3.5 h-3.5 rounded-full bg-gray-300 hover:bg-gray-400 text-gray-600 text-[9px] font-bold flex items-center justify-center leading-none transition-colors select-none">i</span>
                            <div className="absolute left-1/2 -translate-x-1/2 bottom-full mb-2 w-64 bg-gray-900 text-white text-xs rounded-lg p-3 shadow-xl pointer-events-none opacity-0 group-hover:opacity-100 transition-opacity z-50 text-left normal-case tracking-normal font-normal">
                              <p className="font-semibold mb-2 text-gray-200">Constituent Solubility</p>
                              <ul className="space-y-1 text-gray-300">
                                <li><span className="text-white font-medium">Mucilage</span> — cold water only; alcohol destroys it</li>
                                <li><span className="text-white font-medium">Polysaccharides</span> — hot water or very dilute alcohol</li>
                                <li><span className="text-white font-medium">Tannins</span> — water or low alcohol + 5–10% glycerin</li>
                                <li><span className="text-white font-medium">Volatile oils</span> — glycerite preserves best; degrade in alcohol over time</li>
                                <li><span className="text-white font-medium">Resins</span> — high alcohol (70–90%) only; not water-soluble</li>
                                <li><span className="text-white font-medium">Alkaloids</span> — min 45% alcohol + 5–10% vinegar</li>
                                <li><span className="text-white font-medium">Saponins</span> — typically water-soluble</li>
                                <li><span className="text-white font-medium">Flavonoids / Glycosides</span> — water and alcohol</li>
                              </ul>
                              <div className="absolute left-1/2 -translate-x-1/2 top-full w-0 h-0 border-l-[5px] border-r-[5px] border-t-[5px] border-l-transparent border-r-transparent border-t-gray-900" />
                            </div>
                          </span>
                        </div>
                        <div className="flex flex-wrap gap-2 mb-2">
                          {menstruumBadges(selectedHerb.herb_menstruum).map((b) => (
                            <span key={b.label} className={`px-3 py-1 rounded-full text-xs font-medium border ${b.color}`}>
                              {b.label}
                            </span>
                          ))}
                          {herbHasExtractableAlkaloids && (
                            <span className="px-3 py-1 rounded-full text-xs font-medium border bg-amber-50 text-amber-800 border-amber-300">
                              + 5–10% vinegar
                            </span>
                          )}
                        </div>
                        {selectedHerb.herb_menstruum.notes && (
                          <p className="text-xs text-gray-600 mt-1 italic">{selectedHerb.herb_menstruum.notes}</p>
                        )}
                        {selectedHerb.herb_menstruum.powder_effective && (
                          <p className="text-xs text-yellow-700 mt-2 italic">
                            Powder effective — {powderEffectiveReason(selectedHerb.herb_constituents)} work better ingested whole than extracted into a menstruum.
                          </p>
                        )}
                        {selectedHerb.herb_menstruum.oil_effective && (
                          <p className="text-xs text-orange-700 mt-2 italic">
                            Oil effective — key constituents are lipophilic and extract well into a fixed oil (infused or cold-pressed).
                          </p>
                        )}
                        {herbHasExtractableAlkaloids && (
                          <p className="text-xs text-amber-700 mt-2 italic">
                            Alkaloids present — adding 5–10% apple cider vinegar improves their extraction.
                          </p>
                        )}
                      </div>
                    )}
                  </div>
                )}
              </div>
            )}

            {/* ── Disorders ────────────────────────────────────────────────── */}
            {((selectedHerb.disorder_action_herbs?.length ?? 0) > 0 ||
              (selectedHerb.disorder_specific_remedies?.length ?? 0) > 0) && (
              <div ref={(el) => { sectionRefs.current.disorders = el; }}>
                <SectionHeader title="Used for Disorders" open={sectionsOpen.disorders} onToggle={() => toggleSection('disorders')} />
                {sectionsOpen.disorders && (
                  <div className="space-y-4">
                    {(() => {
                      const disorderMap = new Map<number, {
                        disorder: Disorder & { body_systems: BodySystem };
                        actions: PrimaryAction[];
                        specificRemedy?: string;
                      }>();
                      selectedHerb.disorder_action_herbs?.forEach((item) => {
                        if (!disorderMap.has(item.disorders.id)) {
                          disorderMap.set(item.disorders.id, { disorder: item.disorders, actions: [] });
                        }
                        disorderMap.get(item.disorders.id)!.actions.push(item.primary_actions);
                      });
                      selectedHerb.disorder_specific_remedies?.forEach((item) => {
                        if (!disorderMap.has(item.disorders.id)) {
                          disorderMap.set(item.disorders.id, { disorder: item.disorders, actions: [], specificRemedy: item.description });
                        } else {
                          disorderMap.get(item.disorders.id)!.specificRemedy = item.description;
                        }
                      });
                      return Array.from(disorderMap.values()).sort((a, b) => a.disorder.name.localeCompare(b.disorder.name)).map((item) => (
                        <div key={item.disorder.id} className="border border-gray-200 rounded-lg py-1.5 px-4 bg-gray-50">
                          <button
                            onClick={() => onDisorderClick?.(item.disorder.id, item.disorder.body_systems.id)}
                            className="text-left w-full group"
                          >
                            <div className="font-semibold text-base text-blue-700 group-hover:text-blue-900 group-hover:underline transition-colors">
                              {item.disorder.name}
                            </div>
                            <div className="text-sm text-gray-600">{item.disorder.body_systems.name}</div>
                          </button>
                          {item.specificRemedy && (
                            <div className="mt-1 mb-2 p-2 bg-green-50 border border-green-200 rounded">
                              <span className="text-xs font-semibold text-green-800">SPECIFIC REMEDY</span>
                              <p className="text-sm text-gray-700 mt-1">{item.specificRemedy}</p>
                            </div>
                          )}
                          {item.actions.length > 0 && (
                            <div className="mt-1">
                              <span className="text-sm font-medium text-gray-700">Actions:</span>
                              <div className="flex flex-wrap gap-2 mt-1">
                                {item.actions.map((action, idx) => (
                                  <button
                                    key={idx}
                                    onClick={() => onActionClick?.(action.id)}
                                    className="text-xs bg-blue-100 text-blue-800 px-2 py-1 rounded hover:bg-blue-200 transition-all"
                                  >
                                    {action.name}
                                  </button>
                                ))}
                              </div>
                            </div>
                          )}
                        </div>
                      ));
                    })()}
                  </div>
                )}
              </div>
            )}
            {/* ── Pairings (Dui Yao + Priest & Priest) ─────────────────── */}
            {(duiYaoPairs.length > 0 || duiYaoLoading || priestPairings.length > 0 || priestPairingsLoading) && (
              <div className="mt-6" ref={(el) => { sectionRefs.current.pairings = el; }}>
                <SectionHeader title="Pairings" open={sectionsOpen.pairings} onToggle={() => toggleSection('pairings')} />
                {sectionsOpen.pairings && (
                  <div className="space-y-6">
                    {/* ── Dui Yao ── */}
                    {(duiYaoPairs.length > 0 || duiYaoLoading) && (
                      <div>
                        <p className="text-[10px] font-semibold text-gray-400 uppercase tracking-widest mb-3 px-1">Dui Yao</p>
                        {duiYaoLoading ? (
                          <p className="text-gray-400 text-sm italic">Loading pairings…</p>
                        ) : (
                          <div className="space-y-4">
                            {duiYaoPairs.map((pair) => {
                              const partner = pair.herb1_id === selectedHerb!.id ? pair.herb2 : pair.herb1;
                              const myProps = pair.dui_yao_herb_properties
                                .filter((p) => p.herb_id === selectedHerb!.id)
                                .sort((a, b) => a.sort_order - b.sort_order);
                              const partnerProps = pair.dui_yao_herb_properties
                                .filter((p) => p.herb_id === partner.id)
                                .sort((a, b) => a.sort_order - b.sort_order);
                              const indications = [...pair.dui_yao_indications].sort((a, b) => a.sort_order - b.sort_order);
                              return (
                                <div key={pair.id} className="border border-gray-200 rounded-lg overflow-hidden">
                                  <div className="bg-gray-50 px-4 py-2.5 flex items-start justify-between gap-2">
                                    <button
                                      onClick={() => navigateToHerb(partner.id)}
                                      className="text-left group"
                                    >
                                      <div className="font-semibold text-sm text-green-700 group-hover:text-green-900 group-hover:underline transition-colors">
                                        Paired with: {partner.common_name}
                                        {partner.pinyin_name && (
                                          <span className="ml-1.5 font-normal text-gray-500 group-hover:text-gray-700">({partner.pinyin_name})</span>
                                        )}
                                      </div>
                                      <div className="text-xs italic text-gray-500">{partner.latin_name}</div>
                                    </button>
                                    {pair.book_page && (
                                      <span className="shrink-0 text-xs text-gray-400 mt-0.5">p. {pair.book_page}</span>
                                    )}
                                  </div>
                                  {(myProps.length > 0 || partnerProps.length > 0) && (
                                    <div className="grid grid-cols-2 gap-3 px-4 py-3 border-t border-gray-100">
                                      {myProps.length > 0 && (
                                        <div>
                                          <p className="text-[10px] font-semibold text-gray-400 uppercase tracking-widest mb-1">{selectedHerb!.common_name}</p>
                                          <ul className="space-y-0.5">
                                            {myProps.map((prop, i) => (
                                              <li key={i} className="text-xs text-gray-700 flex gap-1.5">
                                                <span className="text-gray-400 shrink-0">•</span>{prop.property}
                                              </li>
                                            ))}
                                          </ul>
                                        </div>
                                      )}
                                      {partnerProps.length > 0 && (
                                        <div>
                                          <p className="text-[10px] font-semibold text-gray-400 uppercase tracking-widest mb-1">{partner.common_name}</p>
                                          <ul className="space-y-0.5">
                                            {partnerProps.map((prop, i) => (
                                              <li key={i} className="text-xs text-gray-700 flex gap-1.5">
                                                <span className="text-gray-400 shrink-0">•</span>{prop.property}
                                              </li>
                                            ))}
                                          </ul>
                                        </div>
                                      )}
                                    </div>
                                  )}
                                  {pair.combined_summary && (
                                    <div className="px-4 py-3 border-t border-gray-100">
                                      <p className="text-sm text-gray-700 leading-relaxed">{pair.combined_summary}</p>
                                    </div>
                                  )}
                                  {indications.length > 0 && (
                                    <div className="px-4 py-3 border-t border-gray-100">
                                      <p className="text-[10px] font-semibold text-gray-400 uppercase tracking-widest mb-1.5">Indications</p>
                                      <ol className="space-y-0.5 list-decimal list-inside">
                                        {indications.map((ind, i) => (
                                          <li key={i} className="text-xs text-gray-700">{ind.indication}</li>
                                        ))}
                                      </ol>
                                    </div>
                                  )}
                                </div>
                              );
                            })}
                          </div>
                        )}
                      </div>
                    )}
                    {/* ── Priest & Priest ── */}
                    {(priestPairings.length > 0 || priestPairingsLoading) && (
                      <div className={duiYaoPairs.length > 0 ? 'border-t border-gray-100 pt-6' : ''}>
                        <p className="text-[10px] font-semibold text-gray-400 uppercase tracking-widest mb-3 px-1">Priest &amp; Priest</p>
                        {priestPairingsLoading ? (
                          <p className="text-gray-400 text-sm italic">Loading pairings…</p>
                        ) : (
                          <div className="pl-4 border-l-2 border-amber-100 space-y-3">
                            {(() => {
                              const groups: { context: string | null; rows: PriestPairing[] }[] = [];
                              for (const row of priestPairings) {
                                const last = groups[groups.length - 1];
                                if (last && last.context === row.combination_context) {
                                  last.rows.push(row);
                                } else {
                                  groups.push({ context: row.combination_context, rows: [row] });
                                }
                              }
                              return groups.map((group, gi) => (
                                <div key={gi} className="py-2.5 border-b border-amber-50 last:border-0">
                                  <div className="flex flex-wrap gap-2 mb-1.5">
                                    {group.rows.map((p) => (
                                      p.partner ? (
                                        <button
                                          key={p.id}
                                          onClick={() => navigateToHerb(p.partner!.id)}
                                          className="px-3 py-1 rounded-full bg-amber-50 border border-amber-300 text-amber-900 text-sm font-medium hover:bg-amber-100 hover:border-amber-500 transition-colors"
                                        >
                                          {p.partner.common_name}
                                        </button>
                                      ) : (
                                        <span
                                          key={p.id}
                                          className="px-3 py-1 rounded-full bg-gray-50 border border-gray-200 text-gray-500 text-sm italic"
                                          title={`${p.partner_name_raw} — not in database`}
                                        >
                                          {p.partner_name_raw}
                                        </span>
                                      )
                                    ))}
                                  </div>
                                  {group.context && (
                                    <p className="text-xs text-gray-500 leading-relaxed">{group.context}</p>
                                  )}
                                </div>
                              ));
                            })()}
                            <p className="text-[10px] text-gray-400 italic pt-1">Source: Priest & Priest, Herbal Medication (1982)</p>
                          </div>
                        )}
                      </div>
                    )}
                  </div>
                )}
              </div>
            )}
            {/* ── Michael Moore Materia Medica ──────────────────────────── */}
            {MM_MATERIA_MEDICA[selectedHerb.id] && (() => {
              const rawText = MM_MATERIA_MEDICA[selectedHerb.id];
              const isPregnancyContraindicated = rawText.startsWith('*');
              const lines = rawText.split('\n');
              const header = lines[0].replace(/^\*/, '').trim();
              const bodyLines = lines.slice(1);
              const statusLine = bodyLines.find((l) => l.trim().startsWith('STATUS'));
              const statusCode = statusLine ? statusLine.replace(/.*STATUS\s*:\s*/, '').trim() : null;
              const bodyText = bodyLines
                .filter((l) => !l.trim().startsWith('STATUS'))
                .join('\n')
                .trim();
              const STATUS_LABELS: Record<string, string> = {
                'W': 'Wildcrafted', 'C': 'Cultivated', 'A': 'Abundant',
                'LA': 'Limited', 'Rare': 'Rare', 'E': 'Endangered', 'U': 'Unknown',
              };
              const statusParts = statusCode
                ? statusCode.split('/').map((s) => STATUS_LABELS[s.trim()] ?? s.trim())
                : [];
              return (
                <div className="mt-6" ref={(el) => { sectionRefs.current.mmMateriaMedica = el; }}>
                  <SectionHeader title="Michael Moore Materia Medica" open={sectionsOpen.mmMateriaMedica} onToggle={() => toggleSection('mmMateriaMedica')} />
                  {sectionsOpen.mmMateriaMedica && (
                    <div className="pl-4 border-l-2 border-green-100 space-y-3">
                      {isPregnancyContraindicated && (
                        <div className="flex items-center gap-1.5 px-3 py-1.5 bg-amber-50 border border-amber-200 rounded-lg w-fit">
                          <svg className="w-3.5 h-3.5 text-amber-600 shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 9v2m0 4h.01M10.29 3.86L1.82 18a2 2 0 001.71 3h16.94a2 2 0 001.71-3L13.71 3.86a2 2 0 00-3.42 0z" />
                          </svg>
                          <span className="text-xs font-semibold text-amber-800">Avoid in pregnancy</span>
                        </div>
                      )}
                      <p className="text-xs text-gray-400 italic">{header}</p>
                      <pre className="text-sm text-gray-700 whitespace-pre-wrap font-sans leading-relaxed">{bodyText}</pre>
                      {statusParts.length > 0 && (
                        <div className="flex items-center gap-2 flex-wrap pt-1">
                          <span className="text-xs font-semibold text-gray-400 uppercase tracking-widest">Ecological status</span>
                          {statusParts.map((part) => (
                            <span key={part} className="text-xs px-2 py-0.5 rounded-full bg-green-50 border border-green-200 text-green-800 font-medium">
                              {part}
                            </span>
                          ))}
                        </div>
                      )}
                      <p className="text-xs text-gray-400 pt-1">
                        Source: <span className="italic">Herbal Materia Medica 5.0</span> © Michael Moore (1995)
                      </p>
                    </div>
                  )}
                </div>
              );
            })()}
            {/* ── Drug Interactions ─────────────────────────────────────── */}
            {CONTRAINDICATIONS[selectedHerb.id] && (
              <div className="mt-6" ref={(el) => { sectionRefs.current.contraindications = el; }}>
                <SectionHeader title="Drug Interactions" open={sectionsOpen.contraindications} onToggle={() => toggleSection('contraindications')} />
                {sectionsOpen.contraindications && (
                  <div className="pl-4 border-l-2 border-red-100">
                    <button
                      onClick={() => setContraindicationsOpen(true)}
                      className="flex items-center gap-3 w-full text-left border border-red-200 rounded-lg px-4 py-3 bg-red-50 hover:bg-red-100 hover:border-red-300 transition-all group"
                    >
                      <svg className="w-5 h-5 text-red-500 shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 9v2m0 4h.01M10.29 3.86L1.82 18a2 2 0 001.71 3h16.94a2 2 0 001.71-3L13.71 3.86a2 2 0 00-3.42 0z" />
                      </svg>
                      <div>
                        <p className="text-sm font-semibold text-red-800">View Drug Interactions</p>
                        <p className="text-xs text-red-600 mt-0.5">
                          {CONTRAINDICATIONS[selectedHerb.id]} page{CONTRAINDICATIONS[selectedHerb.id] === 1 ? '' : 's'} · Stockley&rsquo;s Herbal Medicines Interactions
                        </p>
                      </div>
                      <svg className="w-4 h-4 text-red-400 ml-auto group-hover:text-red-600 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5l7 7-7 7" />
                      </svg>
                    </button>
                  </div>
                )}
              </div>
            )}
            {/* ── Contraindications (MM Materia Medica) ─────────────────── */}
            {selectedHerb.contraindications && (
              <div className="mt-6" ref={(el) => { sectionRefs.current.herbContraindications = el; }}>
                <SectionHeader title="Contraindications" open={sectionsOpen.herbContraindications} onToggle={() => toggleSection('herbContraindications')} />
                {sectionsOpen.herbContraindications && (
                  <div className="pl-4 border-l-2 border-red-100">
                    <div className="border border-red-200 rounded-lg px-4 py-3 bg-red-50">
                      <div className="flex items-start gap-3">
                        <svg className="w-5 h-5 text-red-500 shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 9v2m0 4h.01M10.29 3.86L1.82 18a2 2 0 001.71 3h16.94a2 2 0 001.71-3L13.71 3.86a2 2 0 00-3.42 0z" />
                        </svg>
                        <div>
                          <p className="text-sm text-red-800">{selectedHerb.contraindications}</p>
                          {selectedHerb.contraindications_source && (
                            <p className="text-xs text-red-400 mt-1">Source: {selectedHerb.contraindications_source}</p>
                          )}
                        </div>
                      </div>
                    </div>
                  </div>
                )}
              </div>
            )}

          </div>
        ) : (
          <div className="flex items-center justify-center h-full text-gray-400">
            <p className="text-lg">Select an herb, supplement, or flower essence to view details</p>
          </div>
        )}
      </div>

      {/* Inferred energetics explanation modal */}
      {selectedHerb && (
        <InferredEnergeticsModal
          isOpen={inferredEnergeticsOpen}
          onClose={() => setInferredEnergeticsOpen(false)}
          herbName={`${selectedHerb.common_name}${selectedHerb.plant_part ? ` (${selectedHerb.plant_part})` : ''}`}
          temperatureInferred={!!selectedHerb.temperature_inferred}
          moistureInferred={!!selectedHerb.moisture_inferred}
          herbConstituents={selectedHerb.herb_constituents ?? []}
          profiles={selectedProfiles}
        />
      )}

      {/* Inferred taste explanation modal */}
      {selectedHerb && selectedHerb.taste_inferred && (
        <InferredTasteModal
          isOpen={inferredTasteOpen}
          onClose={() => setInferredTasteOpen(false)}
          herbName={`${selectedHerb.common_name}${selectedHerb.plant_part ? ` (${selectedHerb.plant_part})` : ''}`}
          herbConstituents={selectedHerb.herb_constituents ?? []}
          profiles={selectedProfiles}
        />
      )}

      {/* Drug interactions modal */}
      {selectedHerb && CONTRAINDICATIONS[selectedHerb.id] && (
        <ContraindicationsModal
          isOpen={contraindicationsOpen}
          onClose={() => setContraindicationsOpen(false)}
          herbId={selectedHerb.id}
          pageCount={CONTRAINDICATIONS[selectedHerb.id]}
          herbName={selectedHerb.common_name}
        />
      )}

      {/* Add monograph link modal */}
      {addLinkOpen && (
        <div
          className="fixed inset-0 bg-black/40 z-50 flex items-center justify-center"
          onClick={() => setAddLinkOpen(false)}
        >
          <div
            className="bg-white rounded-lg shadow-xl p-6 w-full max-w-md mx-4"
            onClick={(e) => e.stopPropagation()}
          >
            <h3 className="text-lg font-bold text-gray-800 mb-4">Add Monograph Link</h3>
            <input
              type="url"
              value={newLinkUrl}
              onChange={(e) => setNewLinkUrl(e.target.value)}
              onKeyDown={(e) => { if (e.key === 'Enter') handleAddLink(); }}
              placeholder="https://docs.google.com/..."
              className="w-full border border-gray-300 rounded px-3 py-2 text-sm mb-4 focus:outline-none focus:border-green-500"
              autoFocus
            />
            <div className="flex justify-end gap-2">
              <button
                onClick={() => setAddLinkOpen(false)}
                className="px-4 py-2 text-sm text-gray-600 hover:text-gray-800 transition-colors"
              >
                Cancel
              </button>
              <button
                onClick={handleAddLink}
                disabled={!newLinkUrl.trim() || addLinkSaving}
                className="px-4 py-2 text-sm font-bold bg-green-700 text-white rounded hover:bg-green-800 disabled:opacity-50 transition-colors"
              >
                {addLinkSaving ? 'Adding...' : 'Add'}
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Constituent hover tooltip — rendered via fixed positioning */}
      {hoveredConstituentId != null && tooltipPos != null && tooltipHerbs.length > 0 && (() => {
        const con = selectedHerb?.herb_constituents?.find((c) => c.constituent_id === hoveredConstituentId);
        return (
          <div
            onMouseEnter={handleTooltipMouseEnter}
            onMouseLeave={handleTooltipMouseLeave}
            onClick={(e) => e.stopPropagation()}
            style={{ position: 'fixed', left: tooltipPos.x, top: tooltipPos.y, zIndex: 9999 }}
            className="bg-white border border-gray-200 rounded-lg shadow-xl p-3 w-64 max-h-96 overflow-y-auto"
          >
            <p className="text-xs font-semibold text-gray-500 mb-1 uppercase tracking-wide">
              {con?.constituents.name}
            </p>
            {con?.constituents.category && (
              <p className="text-xs text-gray-400 italic mb-2">{con.constituents.category}</p>
            )}
            {con?.constituents.description && (
              <p className="text-xs text-gray-600 mb-2">{con.constituents.description}</p>
            )}
            <p className="text-xs font-medium text-gray-600 mb-1">Also found in:</p>
            <div className="space-y-1">
              {tooltipHerbs.map(({ herb, level }) => (
                <button
                  key={herb!.id}
                  onClick={() => {
                    setHoveredConstituentId(null);
                    setTooltipPos(null);
                    navigateToHerb(herb!.id);
                  }}
                  className="w-full text-left flex items-center justify-between gap-2 px-2 py-1 rounded hover:bg-gray-50 transition-colors"
                >
                  <span className="text-xs text-gray-800 font-medium">{herb!.common_name}{herb!.plant_part ? ` (${herb!.plant_part})` : ''}</span>
                  <span className={`text-[10px] px-1.5 py-0.5 rounded-full border ${LEVEL_COLOR[level]}`}>
                    {level}
                  </span>
                </button>
              ))}
            </div>
          </div>
        );
      })()}
    </div>
  );
}
