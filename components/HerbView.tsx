'use client';

import { useState, useEffect, useRef, useCallback } from 'react';
import { supabase } from '@/lib/supabase';
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
  herb_constituents: Array<{
    constituent_id: number;
    concentration_level: ConcentrationLevel;
    notes: string | null;
    needs_review: boolean;
    sort_order: number;
    constituents: Constituent;
  }>;
  herb_menstruum: HerbMenstruum | null;
}

// flat cross-reference: constituent_id → list of {herb_id, level}
interface ConstituentHerbRef {
  herb_id: number;
  concentration_level: ConcentrationLevel;
}

interface HerbViewProps {
  selectedHerbId?: number | null;
  onHerbIdChange?: (herbId: number | null) => void;
  onActionClick?: (actionId: number) => void;
  onActionNameClick?: (name: string) => void;
  onDisorderClick?: (disorderId: number, systemId: number) => void;
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
  return badges;
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

export function HerbView({ selectedHerbId, onHerbIdChange, onActionClick, onActionNameClick, onDisorderClick }: HerbViewProps) {
  const [herbs, setHerbs] = useState<HerbData[]>([]);
  const [allProfiles, setAllProfiles] = useState<ConstituentProfile[]>([]);
  const [selectedHerb, setSelectedHerb] = useState<HerbData | null>(null);
  const [searchTerm, setSearchTerm] = useState('');
  const [highlightedIndex, setHighlightedIndex] = useState(-1);
  const [loading, setLoading] = useState(true);

  // constituent_id → array of herb refs (for tooltip & existing Constituents section)
  const [constituentIndex, setConstituentIndex] = useState<Map<number, ConstituentHerbRef[]>>(new Map());

  // hover tooltip state
  const [hoveredConstituentId, setHoveredConstituentId] = useState<number | null>(null);
  const [tooltipPos, setTooltipPos] = useState<{ x: number; y: number } | null>(null);
  const hoverTimerRef = useRef<ReturnType<typeof setTimeout> | null>(null);

  // section open/closed
  const [alternatesOpen, setAlternatesOpen] = useState(false);
  const [sectionsOpen, setSectionsOpen] = useState({
    primaryActions: true, secondaryActions: true,
    constituentProfile: true, constituents: true, disorders: true,
  });
  const toggleSection = (key: keyof typeof sectionsOpen) =>
    setSectionsOpen((prev) => ({ ...prev, [key]: !prev[key] }));

  const herbRefs = useRef<Map<number, HTMLButtonElement>>(new Map());
  const detailPanelRef = useRef<HTMLDivElement>(null);
  const sectionRefs = useRef<Partial<Record<keyof typeof sectionsOpen, HTMLDivElement | null>>>({});

  const scrollToSection = (key: keyof typeof sectionsOpen) => {
    setSectionsOpen((prev) => ({ ...prev, [key]: true }));
    setTimeout(() => {
      sectionRefs.current[key]?.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }, 50);
  };

  useEffect(() => {
    if (highlightedIndex < 0) return;
    const filtered = herbs.filter(
      (h) =>
        h.common_name.toLowerCase().includes(searchTerm.toLowerCase()) ||
        h.latin_name.toLowerCase().includes(searchTerm.toLowerCase())
    );
    const herb = filtered[highlightedIndex];
    if (herb) herbRefs.current.get(herb.id)?.scrollIntoView({ block: 'nearest' });
  }, [highlightedIndex, herbs, searchTerm]);

  useEffect(() => { fetchHerbs(); }, []);

  useEffect(() => {
    if (selectedHerbId != null && herbs.length > 0) {
      const herb = herbs.find((h) => h.id === selectedHerbId);
      if (herb) {
        setSelectedHerb(herb);
        setAlternatesOpen(false);
        setSectionsOpen({ primaryActions: true, secondaryActions: true, constituentProfile: true, constituents: true, disorders: true });
        setTimeout(() => {
          herbRefs.current.get(selectedHerbId)?.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
        }, 100);
      }
    }
  }, [selectedHerbId, herbs]);

  async function fetchHerbs() {
    try {
      const [herbResult, profileResult] = await Promise.all([
        supabase
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
            herb_secondary_actions ( secondary_actions (*) ),
            herb_constituents (
              constituent_id,
              concentration_level,
              notes,
              needs_review,
              sort_order,
              constituents (*)
            ),
            herb_menstruum (*)
          `)
          .order('common_name'),
        supabase
          .from('constituent_profiles')
          .select('*')
          .not('herb_id', 'is', null)
          .order('herb_id')
          .range(0, 4999),
      ]);

      if (herbResult.error) throw herbResult.error;

      const herbList: HerbData[] = (herbResult.data || []).map((h: HerbData) => ({
        ...h,
        herb_menstruum: Array.isArray(h.herb_menstruum)
          ? (h.herb_menstruum[0] ?? null)
          : h.herb_menstruum,
      }));

      // Build constituent → herbs cross-reference index (for existing Constituents section tooltips)
      const idx = new Map<number, ConstituentHerbRef[]>();
      for (const herb of herbList) {
        for (const hc of herb.herb_constituents ?? []) {
          if (!idx.has(hc.constituent_id)) idx.set(hc.constituent_id, []);
          idx.get(hc.constituent_id)!.push({ herb_id: herb.id, concentration_level: hc.concentration_level });
        }
      }

      setHerbs(herbList);
      setConstituentIndex(idx);
      setAllProfiles(profileResult.data ?? []);
    } catch (err) {
      console.error('Error fetching herbs:', err);
    } finally {
      setLoading(false);
    }
  }

  const navigateToHerb = useCallback((herbId: number) => {
    const herb = herbs.find((h) => h.id === herbId);
    if (!herb) return;
    setSelectedHerb(herb);
    setAlternatesOpen(false);
    setSectionsOpen({ primaryActions: true, secondaryActions: true, constituentProfile: true, constituents: true, disorders: true });
    onHerbIdChange?.(herbId);
    detailPanelRef.current?.scrollIntoView({ behavior: 'smooth', block: 'start' });
    setTimeout(() => {
      herbRefs.current.get(herbId)?.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
    }, 100);
  }, [herbs, onHerbIdChange]);

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
      .slice(0, 10)
      .map((r) => ({ herb: herbs.find((h) => h.id === r.herb_id), level: r.concentration_level }))
      .filter((x) => x.herb != null);
  })();

  const filteredHerbs = herbs.filter(
    (h) =>
      h.common_name.toLowerCase().includes(searchTerm.toLowerCase()) ||
      h.latin_name.toLowerCase().includes(searchTerm.toLowerCase())
  );

  function handlePillMouseEnter(constituentId: number, e: React.MouseEvent) {
    if (hoverTimerRef.current) clearTimeout(hoverTimerRef.current);
    const rect = (e.currentTarget as HTMLElement).getBoundingClientRect();
    setTooltipPos({ x: rect.left, y: rect.bottom + 6 });
    hoverTimerRef.current = setTimeout(() => setHoveredConstituentId(constituentId), 120);
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
    <div className="grid grid-cols-1 lg:grid-cols-3 gap-6 items-start">
      {/* Herb List */}
      <div className="lg:col-span-1 bg-white rounded-lg shadow-lg p-6">
        <div className="relative mb-4">
          <input
            type="text"
            placeholder="Search herbs..."
            value={searchTerm}
            onChange={(e) => { setSearchTerm(e.target.value); setHighlightedIndex(-1); }}
            onKeyDown={(e) => {
              if (e.key === 'ArrowDown') {
                e.preventDefault();
                setHighlightedIndex((i) => Math.min(i + 1, filteredHerbs.length - 1));
              } else if (e.key === 'ArrowUp') {
                e.preventDefault();
                setHighlightedIndex((i) => Math.max(i - 1, -1));
              } else if (e.key === 'Enter' && highlightedIndex >= 0) {
                const herb = filteredHerbs[highlightedIndex];
                setSelectedHerb(herb);
                setAlternatesOpen(false);
                setSectionsOpen({ primaryActions: true, secondaryActions: true, constituentProfile: true, constituents: true, disorders: true });
                onHerbIdChange?.(herb.id);
                setSearchTerm('');
                setHighlightedIndex(-1);
                detailPanelRef.current?.scrollIntoView({ behavior: 'smooth', block: 'start' });
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

        <div className="space-y-2 max-h-[70vh] overflow-y-auto px-1 py-1">
          {filteredHerbs.map((herb, idx) => (
            <button
              key={herb.id}
              ref={(el) => {
                if (el) herbRefs.current.set(herb.id, el);
                else herbRefs.current.delete(herb.id);
              }}
              onClick={() => {
                setSelectedHerb(herb);
                setAlternatesOpen(false);
                setSectionsOpen({ primaryActions: true, secondaryActions: true, constituentProfile: true, constituents: true, disorders: true });
                onHerbIdChange?.(herb.id);
                setSearchTerm('');
                setHighlightedIndex(-1);
                detailPanelRef.current?.scrollIntoView({ behavior: 'smooth', block: 'start' });
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
                  <div className="font-semibold text-gray-900">{herb.common_name}</div>
                  <div className="text-sm italic text-gray-600">{herb.latin_name}</div>
                </div>
                <span className="text-sm leading-none shrink-0 mt-0.5">
                  {[
                    herb.temperature === 'warming' ? '🔥' : herb.temperature === 'cooling' ? '❄️' : '',
                    herb.moisture === 'moistening' ? '💧' : herb.moisture === 'drying' ? '🌵' : '',
                    herb.tone === 'toning' ? '⚡' : herb.tone === 'relaxing' ? '🌊' : '',
                  ].join('')}
                </span>
              </div>
            </button>
          ))}
        </div>
      </div>

      {/* Herb Details */}
      <div ref={detailPanelRef} className="lg:col-span-2 bg-white rounded-lg shadow-lg p-6">
        {selectedHerb ? (
          <div>
            {/* Header */}
            <div className="flex items-start justify-between mb-2">
              <h2 className="text-3xl font-bold text-green-800">{selectedHerb.common_name}</h2>
              {selectedHerb.monograph_url && (
                <a
                  href={selectedHerb.monograph_url}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="ml-4 shrink-0 px-4 py-2 bg-green-700 text-white text-sm font-bold rounded hover:bg-green-800 transition-colors"
                >
                  MONOGRAPH
                </a>
              )}
            </div>
            <p className="text-xl italic text-gray-600 mb-3">{selectedHerb.latin_name}</p>

            {/* Section nav */}
            <div className="flex flex-wrap gap-1.5 mb-6 text-xs">
              {[
                { key: 'primaryActions' as const, label: 'Primary Actions' },
                ...(selectedHerb.herb_secondary_actions.length > 0 ? [{ key: 'secondaryActions' as const, label: 'Secondary Actions' }] : []),
                ...(selectedProfiles.length > 0 ? [{ key: 'constituentProfile' as const, label: 'Constituents' }] : []),
                ...((selectedHerb.herb_constituents?.length ?? 0) > 0 ? [{ key: 'constituents' as const, label: 'Constituent Detail' }] : []),
                ...((((selectedHerb.disorder_action_herbs?.length ?? 0) > 0) || ((selectedHerb.disorder_specific_remedies?.length ?? 0) > 0)) ? [{ key: 'disorders' as const, label: 'Disorders' }] : []),
              ].map(({ key, label }) => (
                <button
                  key={key}
                  onClick={() => scrollToSection(key)}
                  className="px-2.5 py-1 rounded-full border border-gray-300 text-gray-500 hover:border-green-500 hover:text-green-700 transition-colors"
                >
                  {label}
                </button>
              ))}
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
                    {[...selectedHerb.herb_secondary_actions].sort((a, b) => a.secondary_actions.name.localeCompare(b.secondary_actions.name)).map((item, idx) => (
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

            {/* ── Constituent Profile ───────────────────────────────────────── */}
            {selectedProfiles.length > 0 && (
              <div className="mb-6" ref={(el) => { sectionRefs.current.constituentProfile = el; }}>
                <SectionHeader title="Constituent Profile Markers" open={sectionsOpen.constituentProfile} onToggle={() => toggleSection('constituentProfile')} />
                {sectionsOpen.constituentProfile && (
                  <div>
                    <div className="flex flex-wrap gap-2 mb-4">
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
                            <div className="flex items-center gap-1.5 mt-0.5">
                              {p.class && <span className="text-xs text-gray-500">{p.class}</span>}
                              {p.class && p.subclass && <span className="text-xs text-gray-400">›</span>}
                              {p.subclass && <span className="text-xs text-amber-700 font-medium">{p.subclass}</span>}
                              {p.status && (
                                <span className={`text-xs px-1.5 py-0.5 rounded-full border font-medium ml-1 ${statusBadgeColor(p.status)}`}>
                                  {p.status}
                                </span>
                              )}
                              {p.importance && (
                                <span className={`text-xs px-1.5 py-0.5 rounded-full border font-medium ${importanceBadgeColor(p.importance)}`}>
                                  {p.importance}
                                </span>
                              )}
                            </div>
                            {p.notes && (
                              <p className="text-xs text-gray-600 italic mt-1 leading-snug max-w-[18rem]">{p.notes}</p>
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
                          Ranked Alternates Based on Markers ({computedAlternates.length})
                        </button>
                        {alternatesOpen && (
                          <div className="mt-3 space-y-2">
                            {computedAlternates.map(({ herb, similarity, exactConstituents, sharedSubclasses, sharedClasses }) => {
                              if (!herb) return null;
                              const m = herb.herb_menstruum;
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
                                      <span className="font-medium text-gray-900 text-sm">{herb.common_name}</span>
                                      <span className="text-xs italic text-gray-500 ml-2">{herb.latin_name}</span>
                                    </div>
                                    <div className="flex items-center gap-1.5 shrink-0">
                                      <span className={`text-xs px-2 py-0.5 rounded-full border font-semibold ${simColor}`}>
                                        {similarity}%
                                      </span>
                                      {m && (
                                        <span className="text-xs px-2 py-0.5 rounded-full bg-purple-100 text-purple-700 border border-purple-200">
                                          {m.primary_label}
                                        </span>
                                      )}
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
            {(selectedHerb.herb_constituents?.length ?? 0) > 0 && (
              <div className="mb-6" ref={(el) => { sectionRefs.current.constituents = el; }}>
                <SectionHeader title="General Constituents" open={sectionsOpen.constituents} onToggle={() => toggleSection('constituents')} />
                {sectionsOpen.constituents && (
                  <div>
                    <div className="flex flex-wrap gap-2 mb-4">
                      {[...selectedHerb.herb_constituents]
                        .sort((a, b) => {
                          const w = LEVEL_WEIGHT[b.concentration_level] - LEVEL_WEIGHT[a.concentration_level];
                          return w !== 0 ? w : a.sort_order - b.sort_order;
                        })
                        .map((hc) => {
                          const refs = constituentIndex.get(hc.constituent_id) ?? [];
                          const otherHerbCount = refs.filter(
                            (r) => r.herb_id !== selectedHerb.id && r.concentration_level !== 'trace'
                          ).length;
                          return (
                            <div
                              key={hc.constituent_id}
                              className="relative"
                              onMouseEnter={(e) => handlePillMouseEnter(hc.constituent_id, e)}
                              onMouseLeave={handlePillMouseLeave}
                            >
                              <span className={`inline-flex items-center gap-1 px-3 py-1 rounded-full text-xs font-medium border cursor-default select-none ${LEVEL_COLOR[hc.concentration_level]}`}>
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
                        <p className="text-xs font-semibold text-gray-400 uppercase tracking-widest mb-2">Best Menstruum</p>
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
          </div>
        ) : (
          <div className="flex items-center justify-center h-full text-gray-400">
            <p className="text-lg">Select an herb to view details</p>
          </div>
        )}
      </div>

      {/* Constituent hover tooltip — rendered via fixed positioning */}
      {hoveredConstituentId != null && tooltipPos != null && tooltipHerbs.length > 0 && (() => {
        const con = selectedHerb?.herb_constituents.find((c) => c.constituent_id === hoveredConstituentId);
        return (
          <div
            onMouseEnter={handleTooltipMouseEnter}
            onMouseLeave={handleTooltipMouseLeave}
            style={{ position: 'fixed', left: tooltipPos.x, top: tooltipPos.y, zIndex: 9999 }}
            className="bg-white border border-gray-200 rounded-lg shadow-xl p-3 w-64 max-h-72 overflow-y-auto"
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
                  <span className="text-xs text-gray-800 font-medium">{herb!.common_name}</span>
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
