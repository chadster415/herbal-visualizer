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

function getStrengthColor(strength: StrengthLevel | null) {
  switch (strength) {
    case 'mild':       return 'bg-yellow-100 text-yellow-800';
    case 'strong':     return 'bg-orange-100 text-orange-800';
    case 'very_strong':return 'bg-red-100 text-red-800';
    default:           return 'bg-gray-100 text-gray-800';
  }
}

// Build menstruum detail badges
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

// ─── Component ────────────────────────────────────────────────────────────────

export function HerbView({ selectedHerbId, onHerbIdChange, onActionClick, onActionNameClick, onDisorderClick }: HerbViewProps) {
  const [herbs, setHerbs] = useState<HerbData[]>([]);
  const [selectedHerb, setSelectedHerb] = useState<HerbData | null>(null);
  const [searchTerm, setSearchTerm] = useState('');
  const [loading, setLoading] = useState(true);

  // constituent_id → array of herb refs (for tooltip & alternates)
  const [constituentIndex, setConstituentIndex] = useState<Map<number, ConstituentHerbRef[]>>(new Map());

  // hover tooltip state
  const [hoveredConstituentId, setHoveredConstituentId] = useState<number | null>(null);
  const [tooltipPos, setTooltipPos] = useState<{ x: number; y: number } | null>(null);
  const hoverTimerRef = useRef<ReturnType<typeof setTimeout> | null>(null);

  // alternates section open/closed
  const [alternatesOpen, setAlternatesOpen] = useState(false);

  const herbRefs = useRef<Map<number, HTMLButtonElement>>(new Map());
  const detailPanelRef = useRef<HTMLDivElement>(null);

  useEffect(() => { fetchHerbs(); }, []);

  useEffect(() => {
    if (selectedHerbId != null && herbs.length > 0) {
      const herb = herbs.find((h) => h.id === selectedHerbId);
      if (herb) {
        setSelectedHerb(herb);
        setAlternatesOpen(false);
        setTimeout(() => {
          herbRefs.current.get(selectedHerbId)?.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
        }, 100);
      }
    }
  }, [selectedHerbId, herbs]);

  async function fetchHerbs() {
    try {
      const { data, error } = await supabase
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
        .order('common_name');

      if (error) throw error;

      const herbList: HerbData[] = (data || []).map((h: HerbData) => ({
        ...h,
        herb_menstruum: Array.isArray(h.herb_menstruum)
          ? (h.herb_menstruum[0] ?? null)
          : h.herb_menstruum,
      }));

      // Build constituent → herbs cross-reference index
      const idx = new Map<number, ConstituentHerbRef[]>();
      for (const herb of herbList) {
        for (const hc of herb.herb_constituents ?? []) {
          if (!idx.has(hc.constituent_id)) idx.set(hc.constituent_id, []);
          idx.get(hc.constituent_id)!.push({ herb_id: herb.id, concentration_level: hc.concentration_level });
        }
      }

      setHerbs(herbList);
      setConstituentIndex(idx);
    } catch (err) {
      console.error('Error fetching herbs:', err);
    } finally {
      setLoading(false);
    }
  }

  // Navigate to a different herb (used from tooltip & alternates)
  const navigateToHerb = useCallback((herbId: number) => {
    const herb = herbs.find((h) => h.id === herbId);
    if (!herb) return;
    setSelectedHerb(herb);
    setAlternatesOpen(false);
    onHerbIdChange?.(herbId);
    detailPanelRef.current?.scrollIntoView({ behavior: 'smooth', block: 'start' });
    setTimeout(() => {
      herbRefs.current.get(herbId)?.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
    }, 100);
  }, [herbs, onHerbIdChange]);

  // Compute alternate herbs for selected herb
  const computedAlternates = (() => {
    if (!selectedHerb) return [];
    const currentConstituents = new Set(
      (selectedHerb.herb_constituents ?? [])
        .filter((c) => c.concentration_level !== 'trace')
        .map((c) => c.constituent_id)
    );
    if (currentConstituents.size === 0) return [];

    const scores = new Map<number, number>();
    for (const constituentId of currentConstituents) {
      const refs = constituentIndex.get(constituentId) ?? [];
      for (const ref of refs) {
        if (ref.herb_id === selectedHerb.id) continue;
        if (ref.concentration_level === 'trace') continue;
        scores.set(ref.herb_id, (scores.get(ref.herb_id) ?? 0) + LEVEL_WEIGHT[ref.concentration_level]);
      }
    }

    return [...scores.entries()]
      .sort((a, b) => b[1] - a[1])
      .slice(0, 8)
      .map(([herbId, score]) => {
        const herb = herbs.find((h) => h.id === herbId);
        const sharedConstituents = (selectedHerb.herb_constituents ?? [])
          .filter((c) => c.concentration_level !== 'trace')
          .filter((c) => {
            const refs = constituentIndex.get(c.constituent_id) ?? [];
            return refs.some((r) => r.herb_id === herbId && r.concentration_level !== 'trace');
          })
          .map((c) => ({ name: c.constituents.name, level: c.concentration_level }));
        return { herb, score, sharedConstituents };
      })
      .filter((a) => a.herb != null);
  })();

  // Tooltip herb list for hovered constituent
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
            onChange={(e) => setSearchTerm(e.target.value)}
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

        <div className="space-y-2 max-h-[70vh] overflow-y-auto">
          {filteredHerbs.map((herb) => (
            <button
              key={herb.id}
              ref={(el) => {
                if (el) herbRefs.current.set(herb.id, el);
                else herbRefs.current.delete(herb.id);
              }}
              onClick={() => {
                setSelectedHerb(herb);
                setAlternatesOpen(false);
                onHerbIdChange?.(herb.id);
                detailPanelRef.current?.scrollIntoView({ behavior: 'smooth', block: 'start' });
              }}
              className={`w-full text-left p-3 rounded-lg border transition-all ${
                selectedHerb?.id === herb.id ? 'ring-2 ring-green-500 ring-offset-1' : ''
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
            <p className="text-xl italic text-gray-600 mb-6">{selectedHerb.latin_name}</p>

            {/* Primary Actions & Body Systems */}
            <div className="mb-6">
              <h3 className="text-xl font-semibold text-gray-800 mb-4">Primary Actions & Body Systems</h3>
              {selectedHerb.herb_primary_actions.length > 0 ? (
                <div className="space-y-4">
                  {selectedHerb.herb_primary_actions.map((action, idx) => (
                    <button
                      key={idx}
                      onClick={() => onActionClick?.(action.primary_actions.id)}
                      className="w-full border border-gray-200 rounded-lg p-4 hover:shadow-md hover:scale-[1.02] transition-all cursor-pointer text-left"
                    >
                      <div className="flex items-start justify-between mb-2">
                        <div>
                          <h4 className="text-lg font-semibold text-green-700">{action.primary_actions.name}</h4>
                          {action.body_systems && (
                            <p className="text-sm text-gray-600">{action.body_systems.name}</p>
                          )}
                        </div>
                        {action.relative_strength && (
                          <span className={`px-3 py-1 rounded-full text-xs font-medium ${getStrengthColor(action.relative_strength)}`}>
                            {action.relative_strength.replace('_', ' ')}
                          </span>
                        )}
                      </div>
                      {action.body_system_note && (
                        <p className="text-sm text-gray-700 mt-2">{action.body_system_note}</p>
                      )}
                    </button>
                  ))}
                </div>
              ) : (
                <p className="text-gray-500 italic">No primary actions recorded for this herb.</p>
              )}
            </div>

            {/* Secondary Actions */}
            {selectedHerb.herb_secondary_actions.length > 0 && (
              <div className="mb-6">
                <h3 className="text-xl font-semibold text-gray-800 mb-3">Secondary Actions</h3>
                <div className="flex flex-wrap gap-2">
                  {selectedHerb.herb_secondary_actions.map((item, idx) => (
                    <button
                      key={idx}
                      onClick={() => onActionNameClick?.(item.secondary_actions.name)}
                      className="px-3 py-1.5 bg-teal-50 text-teal-800 border border-teal-200 rounded-full text-sm hover:bg-teal-100 hover:border-teal-400 transition-colors cursor-pointer"
                    >
                      {item.secondary_actions.name}
                    </button>
                  ))}
                </div>
              </div>
            )}

            {/* ── Constituents ─────────────────────────────────────────────── */}
            {(selectedHerb.herb_constituents?.length ?? 0) > 0 && (
              <div className="mb-6">
                <h3 className="text-xl font-semibold text-gray-800 mb-3">Constituents</h3>

                {/* Constituent pills */}
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
                          <span
                            className={`inline-flex items-center gap-1 px-3 py-1 rounded-full text-xs font-medium border cursor-default select-none ${LEVEL_COLOR[hc.concentration_level]}`}
                          >
                            {hc.constituents.name}
                            {hc.needs_review && (
                              <span title="Data needs review" className="opacity-60">*</span>
                            )}
                            {otherHerbCount > 0 && (
                              <span className="opacity-50 text-[10px]">({otherHerbCount})</span>
                            )}
                          </span>
                        </div>
                      );
                    })}
                </div>

                {/* Menstruum recommendations */}
                {selectedHerb.herb_menstruum && (
                  <div className="bg-gray-50 border border-gray-200 rounded-lg p-4">
                    <p className="text-xs font-semibold text-gray-400 uppercase tracking-widest mb-2">
                      Best Menstruum
                    </p>
                    <div className="flex flex-wrap gap-2 mb-2">
                      {menstruumBadges(selectedHerb.herb_menstruum).map((b) => (
                        <span
                          key={b.label}
                          className={`px-3 py-1 rounded-full text-xs font-medium border ${b.color}`}
                        >
                          {b.label}
                        </span>
                      ))}
                    </div>
                    {selectedHerb.herb_menstruum.notes && (
                      <p className="text-xs text-gray-600 mt-1 italic">{selectedHerb.herb_menstruum.notes}</p>
                    )}
                  </div>
                )}

                {/* Alternates chevron */}
                {computedAlternates.length > 0 && (
                  <div className="mt-4">
                    <button
                      onClick={() => setAlternatesOpen((o) => !o)}
                      className="flex items-center gap-2 text-sm font-semibold text-gray-600 hover:text-green-700 transition-colors"
                    >
                      <svg
                        className={`w-4 h-4 transition-transform ${alternatesOpen ? 'rotate-180' : ''}`}
                        fill="none" stroke="currentColor" viewBox="0 0 24 24"
                      >
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                      </svg>
                      Alternates ({computedAlternates.length})
                    </button>

                    {alternatesOpen && (
                      <div className="mt-3 space-y-2">
                        {computedAlternates.map(({ herb, sharedConstituents }) => {
                          if (!herb) return null;
                          const m = herb.herb_menstruum;
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
                                {m && (
                                  <span className="text-xs px-2 py-0.5 rounded-full bg-purple-100 text-purple-700 border border-purple-200 shrink-0">
                                    {m.primary_label}
                                  </span>
                                )}
                              </div>
                              <div className="flex flex-wrap gap-1">
                                {sharedConstituents.map((c) => (
                                  <span
                                    key={c.name}
                                    className={`text-xs px-1.5 py-0.5 rounded border ${LEVEL_COLOR[c.level]}`}
                                  >
                                    {c.name}
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

            {/* Disorders Section */}
            {((selectedHerb.disorder_action_herbs?.length ?? 0) > 0 ||
              (selectedHerb.disorder_specific_remedies?.length ?? 0) > 0) && (
              <div>
                <h3 className="text-xl font-semibold text-gray-800 mb-4">Used for Disorders</h3>
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

                    return Array.from(disorderMap.values()).map((item) => (
                      <div key={item.disorder.id} className="border border-gray-200 rounded-lg p-4 bg-gray-50">
                        <button
                          onClick={() => onDisorderClick?.(item.disorder.id, item.disorder.body_systems.id)}
                          className="text-left w-full mb-3 group"
                        >
                          <div className="font-semibold text-lg text-blue-700 group-hover:text-blue-900 group-hover:underline transition-colors">
                            {item.disorder.name}
                          </div>
                          <div className="text-sm text-gray-600">{item.disorder.body_systems.name}</div>
                        </button>

                        {item.specificRemedy && (
                          <div className="mb-3 p-2 bg-green-50 border border-green-200 rounded">
                            <span className="text-xs font-semibold text-green-800">SPECIFIC REMEDY</span>
                            <p className="text-sm text-gray-700 mt-1">{item.specificRemedy}</p>
                          </div>
                        )}

                        {item.actions.length > 0 && (
                          <div>
                            <span className="text-sm font-medium text-gray-700">Actions:</span>
                            <div className="flex flex-wrap gap-2 mt-2">
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
              </div>
            )}
          </div>
        ) : (
          <div className="flex items-center justify-center h-full text-gray-400">
            <p className="text-lg">Select an herb to view details</p>
          </div>
        )}
      </div>

      {/* Constituent hover tooltip — rendered in document flow via fixed positioning */}
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
