'use client';

import { useState, useEffect, useRef } from 'react';
import { supabase } from '@/lib/supabase';
import type { BodySystem, Herb, PrimaryAction, StrengthLevel } from '@/types/database';
import { DisorderView } from './DisorderView';
import { EnergeticEmojis } from './EnergeticEmojis';

interface SystemNote {
  id: number;
  note_text: string;
  sort_order: number;
}

interface DisorderListItem {
  id: number;
  name: string;
  sort_order: number;
}

interface SystemData extends BodySystem {
  herb_primary_actions: Array<{
    herbs: Herb;
    primary_actions: PrimaryAction;
    relative_strength: StrengthLevel | null;
  }>;
  disorder_count?: number;
  system_notes?: SystemNote[];
  disorders?: DisorderListItem[];
}

interface SystemViewProps {
  onHerbClick?: (herbId: number) => void;
  onActionClick?: (actionId: number) => void;
  onSupplementClick?: (supplementId: number) => void;
  selectedSystemId?: number | null;
  onSystemChange?: (id: number | null) => void;
  selectedDisorderId?: number | null;
  onDisorderChange?: (id: number | null) => void;
}

export function SystemView({ onHerbClick, onActionClick, onSupplementClick, selectedSystemId, onSystemChange, selectedDisorderId, onDisorderChange }: SystemViewProps) {
  const [systems, setSystems] = useState<SystemData[]>([]);
  const [selectedSystem, setSelectedSystem] = useState<SystemData | null>(null);
  const [loading, setLoading] = useState(true);
  const [viewMode, setViewMode] = useState<'actions' | 'disorders'>('actions');
  const [disorderSearch, setDisorderSearch] = useState('');
  const [dropdownIndex, setDropdownIndex] = useState(-1);
  const [mobileListOpen, setMobileListOpen] = useState(true);
  const dropdownRef = useRef<HTMLDivElement>(null);
  const detailPanelRef = useRef<HTMLDivElement>(null);
  const scrollSkipRef = useRef(true);

  useEffect(() => {
    fetchSystems();
  }, []);

  useEffect(() => {
    if (dropdownIndex < 0 || !dropdownRef.current) return;
    const items = dropdownRef.current.querySelectorAll('li');
    items[dropdownIndex]?.scrollIntoView({ block: 'nearest' });
  }, [dropdownIndex]);

  useEffect(() => {
    if (scrollSkipRef.current) { scrollSkipRef.current = false; return; }
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }, [viewMode, selectedSystem?.id]);

  // Respond to external selectedSystemId changes (back button, body diagram modal, etc.)
  useEffect(() => {
    if (selectedSystemId == null) {
      setSelectedSystem(null);
      setMobileListOpen(true);
      return;
    }
    if (systems.length === 0) return;
    if (selectedSystem?.id === selectedSystemId) return;
    const system = systems.find((s) => s.id === selectedSystemId);
    if (system) {
      setSelectedSystem(system);
      setViewMode(selectedDisorderId != null ? 'disorders' : 'actions');
    }
  }, [selectedSystemId, systems]);

  async function fetchSystems() {
    try {
      const [{ data, error }, { data: disorderData }, { data: notesData }] = await Promise.all([
        supabase
          .from('body_systems')
          .select(`*, herb_primary_actions (herbs (*), primary_actions (*), relative_strength)`)
          .order('name'),
        supabase.from('disorders').select('id, name, body_system_id, sort_order').order('sort_order'),
        supabase.from('body_system_notes').select('body_system_id, id, note_text, sort_order').order('sort_order'),
      ]);

      if (error) throw error;

      const disorderMap = new Map<number, DisorderListItem[]>();
      disorderData?.forEach((d) => {
        if (!disorderMap.has(d.body_system_id)) disorderMap.set(d.body_system_id, []);
        disorderMap.get(d.body_system_id)!.push({ id: d.id, name: d.name, sort_order: d.sort_order });
      });

      const notesMap = new Map<number, SystemNote[]>();
      notesData?.forEach((n) => {
        if (!notesMap.has(n.body_system_id)) notesMap.set(n.body_system_id, []);
        notesMap.get(n.body_system_id)!.push({ id: n.id, note_text: n.note_text, sort_order: n.sort_order });
      });

      const systemsWithData = (data || [])
        .filter((system) => system.name !== 'All')
        .map((system) => ({
          ...system,
          disorders: disorderMap.get(system.id) ?? [],
          disorder_count: disorderMap.get(system.id)?.length ?? 0,
          system_notes: notesMap.get(system.id) ?? [],
        }));

      setSystems(systemsWithData);
    } catch (error) {
      console.error('Error fetching systems:', error);
    } finally {
      setLoading(false);
    }
  }

  const navigateToSystem = (system: SystemData) => {
    setSelectedSystem(system);
    setViewMode('actions');
    onSystemChange?.(system.id);
    onDisorderChange?.(null);
    if (typeof window !== 'undefined' && window.innerWidth < 1024) {
      setMobileListOpen(false);
      setTimeout(() => detailPanelRef.current?.scrollIntoView({ behavior: 'smooth', block: 'start' }), 50);
    }
  };

  const navigateToDisorder = (system: SystemData, disorderId: number) => {
    setSelectedSystem(system);
    setViewMode('disorders');
    onSystemChange?.(system.id);
    onDisorderChange?.(disorderId);
    if (typeof window !== 'undefined' && window.innerWidth < 1024) {
      setMobileListOpen(false);
      setTimeout(() => detailPanelRef.current?.scrollIntoView({ behavior: 'smooth', block: 'start' }), 50);
    }
  };

  const groupByAction = (systemData: SystemData) => {
    const grouped = new Map<string, Array<{ herb: Herb; strength: StrengthLevel | null }>>();
    systemData.herb_primary_actions.forEach((item) => {
      const actionName = item.primary_actions.name;
      if (!grouped.has(actionName)) grouped.set(actionName, []);
      grouped.get(actionName)!.push({ herb: item.herbs, strength: item.relative_strength });
    });
    return grouped;
  };

  const getTemperatureCard = (herb: Herb) => {
    switch (herb.temperature) {
      case 'warming': return 'bg-amber-50 border-amber-200 hover:bg-amber-100';
      case 'cooling': return 'bg-sky-50 border-sky-200 hover:bg-sky-100';
      default:        return 'bg-gray-50 border-gray-200 hover:bg-gray-100';
    }
  };

  const getStrengthBadge = (strength: StrengthLevel | null) => {
    switch (strength) {
      case 'mild':        return 'bg-yellow-100 text-yellow-700';
      case 'strong':      return 'bg-orange-100 text-orange-700';
      case 'very_strong': return 'bg-red-100 text-red-700';
      default:            return null;
    }
  };

  if (loading) {
    return <div className="text-center py-8">Loading body systems...</div>;
  }

  return (
    <div className="grid grid-cols-1 lg:grid-cols-3 gap-6 items-start">
      {/* System List */}
      <div className={`lg:col-span-1 bg-white rounded-lg shadow-lg lg:p-6 ${mobileListOpen ? 'p-6' : 'p-3'}`}>
        <div className={`flex items-center justify-between lg:mb-4 ${mobileListOpen ? 'mb-4' : ''}`}>
          <h3 className="text-lg font-semibold text-gray-800">Body Systems</h3>
          <button
            className="lg:hidden p-2 rounded-lg text-gray-500 hover:text-gray-700 hover:bg-gray-100 transition-all"
            onClick={() => setMobileListOpen((prev) => !prev)}
            aria-label="Toggle body systems list"
          >
            <svg className={`w-5 h-5 transition-transform duration-200 ${mobileListOpen ? 'rotate-180' : ''}`} fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
            </svg>
          </button>
        </div>
        <div className={`${mobileListOpen ? '' : 'hidden'} lg:block space-y-2`}>
          {systems.map((system) => (
            <button
              key={system.id}
              onClick={() => navigateToSystem(system)}
              className={`w-full text-left p-3 rounded-lg transition-all ${
                selectedSystem?.id === system.id
                  ? 'bg-green-100 border-2 border-green-500'
                  : 'bg-gray-50 hover:bg-gray-100'
              }`}
            >
              <div className="font-semibold text-gray-900">{system.name}</div>
              <div className="text-xs text-gray-500 mt-1">
                {(system.disorder_count ?? 0) > 0 && (
                  <div>{system.disorder_count} disorder{system.disorder_count !== 1 ? 's' : ''}</div>
                )}
                <div>{system.herb_primary_actions.length} herb{system.herb_primary_actions.length !== 1 ? 's' : ''}</div>
              </div>
            </button>
          ))}
        </div>
      </div>

      {/* Main panel */}
      <div ref={detailPanelRef} className="lg:col-span-2 bg-white rounded-lg shadow-lg p-6">
        {selectedSystem ? (
          // ── Detail view ────────────────────────────────────────────────────
          <div>
            <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3 mb-6">
              <h2 className="text-3xl font-bold text-green-800">
                {selectedSystem.name} System
              </h2>
              {(selectedSystem.disorder_count ?? 0) > 0 && (
                <div className="flex gap-2 shrink-0">
                  <button
                    onClick={() => setViewMode('disorders')}
                    className={`px-4 py-2 rounded-lg font-medium transition-all ${
                      viewMode === 'disorders'
                        ? 'bg-green-600 text-white'
                        : 'bg-gray-200 text-gray-700 hover:bg-gray-300'
                    }`}
                  >
                    Disorders ({selectedSystem.disorder_count})
                  </button>
                  <button
                    onClick={() => setViewMode('actions')}
                    className={`px-4 py-2 rounded-lg font-medium transition-all ${
                      viewMode === 'actions'
                        ? 'bg-green-600 text-white'
                        : 'bg-gray-200 text-gray-700 hover:bg-gray-300'
                    }`}
                  >
                    Actions &amp; Herbs
                  </button>
                </div>
              )}
            </div>

            {viewMode === 'disorders' && (selectedSystem.disorder_count ?? 0) > 0 ? (
              <div className="mt-4">
                <DisorderView
                  bodySystemId={selectedSystem.id}
                  onHerbClick={onHerbClick}
                  onActionClick={onActionClick}
                  onSupplementClick={onSupplementClick}
                  selectedDisorderId={selectedDisorderId}
                  onDisorderChange={onDisorderChange}
                />
              </div>
            ) : (
              <div className="space-y-6">
                {(selectedSystem.system_notes?.length ?? 0) > 0 && (
                  <div className="bg-green-50 border border-green-200 border-l-4 border-l-green-600 rounded-lg p-4">
                    <ul className="list-disc list-inside space-y-2">
                      {selectedSystem.system_notes!.map((note) => (
                        <li key={note.id} className="text-gray-700">{note.note_text}</li>
                      ))}
                    </ul>
                  </div>
                )}
                {selectedSystem.herb_primary_actions.length > 0 ? (
                  Array.from(groupByAction(selectedSystem))
                    .sort(([a], [b]) => a.localeCompare(b))
                    .map(([actionName, herbs]) => (
                      <div key={actionName} className="border-l-4 border-blue-500 pl-4 pb-4">
                        <h3 className="text-xl font-semibold text-gray-800 mb-3">{actionName}</h3>
                        <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-3">
                          {herbs.map((item, idx) => (
                            <button
                              key={idx}
                              onClick={() => onHerbClick?.(item.herb.id)}
                              className={`border rounded-lg py-2.5 px-3 hover:shadow-md hover:scale-105 transition-all cursor-pointer text-left ${getTemperatureCard(item.herb)}`}
                            >
                              <div className="flex items-center justify-between gap-1 mb-1">
                                <span className="font-medium text-sm">{item.herb.common_name}{item.herb.plant_part ? ` (${item.herb.plant_part})` : ''}</span>
                                <EnergeticEmojis temperature={item.herb.temperature} moisture={item.herb.moisture} tone={item.herb.tone} className="text-sm leading-none shrink-0" />
                              </div>
                              <div className="flex items-center justify-between gap-1">
                                <span className="text-xs italic text-gray-600">{item.herb.latin_name}</span>
                                {item.strength && getStrengthBadge(item.strength) && (
                                  <span className={`text-xs font-semibold px-1.5 py-0.5 rounded shrink-0 ${getStrengthBadge(item.strength)}`}>
                                    {item.strength.replace('_', ' ')}
                                  </span>
                                )}
                              </div>
                            </button>
                          ))}
                        </div>
                      </div>
                    ))
                ) : (
                  <p className="text-gray-500 italic">No herbs recorded for this body system.</p>
                )}
              </div>
            )}
          </div>
        ) : (
          // ── Overview: all systems + disorders ───────────────────────────────
          <div>
            <div className="flex flex-col sm:flex-row sm:items-center gap-2 mb-4">
              <h3 className="text-lg font-semibold text-gray-700 shrink-0">All Systems &amp; Disorders</h3>
              <div className="relative">
                {(() => {
                  const matches = disorderSearch.length >= 2
                    ? systems.flatMap((system) =>
                        (system.disorders ?? [])
                          .filter((d) => d.name.toLowerCase().includes(disorderSearch.toLowerCase()))
                          .map((disorder) => ({ disorder, system }))
                      )
                    : [];
                  const selectMatch = (idx: number) => {
                    const m = matches[idx];
                    if (!m) return;
                    navigateToDisorder(m.system, m.disorder.id);
                    setDisorderSearch('');
                    setDropdownIndex(-1);
                  };
                  return (
                    <>
                      <input
                        type="text"
                        value={disorderSearch}
                        onChange={(e) => { setDisorderSearch(e.target.value); setDropdownIndex(-1); }}
                        onKeyDown={(e) => {
                          if (e.key === 'Escape') { setDisorderSearch(''); setDropdownIndex(-1); }
                          else if (e.key === 'ArrowDown') { e.preventDefault(); setDropdownIndex((i) => Math.min(i + 1, matches.length - 1)); }
                          else if (e.key === 'ArrowUp') { e.preventDefault(); setDropdownIndex((i) => Math.max(i - 1, -1)); }
                          else if (e.key === 'Enter') { selectMatch(dropdownIndex); }
                        }}
                        placeholder="Search disorders…"
                        className="border border-gray-200 rounded-lg px-3 py-1 text-sm text-gray-700 placeholder-gray-400 focus:outline-none focus:border-green-400 w-52"
                      />
                      {disorderSearch.length >= 2 && (
                        <div ref={dropdownRef} className="absolute left-0 top-full mt-1 z-20 bg-white border border-gray-200 rounded-lg shadow-lg w-80 max-h-72 overflow-y-auto">
                          {matches.length > 0 ? (
                            <ul className="py-1">
                              {matches.map(({ disorder, system }, idx) => (
                                <li key={disorder.id}>
                                  <button
                                    onClick={() => selectMatch(idx)}
                                    onMouseEnter={() => setDropdownIndex(idx)}
                                    className={`w-full text-left px-3 py-2 flex items-baseline justify-between gap-2 ${idx === dropdownIndex ? 'bg-green-50' : 'hover:bg-green-50'}`}
                                  >
                                    <span className="text-sm text-gray-800">{disorder.name}</span>
                                    <span className="text-xs text-gray-400 shrink-0">{system.name}</span>
                                  </button>
                                </li>
                              ))}
                            </ul>
                          ) : (
                            <p className="text-sm text-gray-400 italic px-3 py-2">No matches</p>
                          )}
                        </div>
                      )}
                    </>
                  );
                })()}
              </div>
            </div>
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 items-start">
              {systems.map((system) => (
                <div key={system.id} className="border border-gray-100 rounded-lg p-3 flex flex-col gap-1.5">
                  <div className="flex items-start justify-between gap-2">
                    <button
                      onClick={() => navigateToSystem(system)}
                      className="font-semibold text-green-800 hover:text-green-600 hover:underline text-left leading-tight"
                    >
                      {system.name}
                    </button>
                    <button
                      onClick={() => navigateToSystem(system)}
                      className="text-xs text-green-700 hover:text-green-500 hover:underline whitespace-nowrap pt-0.5 shrink-0"
                    >
                      {system.herb_primary_actions.length} herbs
                    </button>
                  </div>
                  {(system.disorders?.length ?? 0) > 0 ? (
                    <ul className="space-y-0.5 border-t border-gray-100 pt-1.5">
                      {[...system.disorders!].sort((a, b) => a.name.localeCompare(b.name)).map((disorder) => (
                        <li key={disorder.id}>
                          <button
                            onClick={() => navigateToDisorder(system, disorder.id)}
                            className="text-sm text-left text-gray-500 hover:text-green-700 hover:underline w-full"
                          >
                            {disorder.name}
                          </button>
                        </li>
                      ))}
                    </ul>
                  ) : (
                    <p className="text-xs text-gray-400 italic border-t border-gray-100 pt-1.5">No disorders recorded</p>
                  )}
                </div>
              ))}
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
