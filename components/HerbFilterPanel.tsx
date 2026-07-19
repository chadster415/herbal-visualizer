'use client';

import { useState, useEffect, useRef, useMemo } from 'react';
import { supabase } from '@/lib/supabase';
import type { TemperatureEnergetic, MoistureEnergetic, ToneEnergetic } from '@/types/database';

// ─── Types ────────────────────────────────────────────────────────────────────

interface BodySystem { id: number; name: string; }
interface Action { id: number; name: string; }

interface HerbRow {
  id: number;
  common_name: string;
  latin_name: string;
  pinyin_name: string | null;
  temperature: TemperatureEnergetic;
  moisture: MoistureEnergetic;
  tone: ToneEnergetic;
  action_ids: Set<number>;
  system_ids: Set<number>;
  menstruum_label: string | null;
}

export interface HerbFilterPanelProps {
  isOpen: boolean;
  onClose: () => void;
  onHerbSelect: (herbId: number) => void;
  onSystemSelect?: (systemId: number) => void;
}

// ─── Static filter option definitions ────────────────────────────────────────

const TEMP_OPTIONS: { value: TemperatureEnergetic; label: string; emoji: string; on: string; off: string }[] = [
  { value: 'warming',  label: 'Warming',  emoji: '🔥', on: 'bg-amber-200 border-amber-400 text-amber-900', off: 'bg-amber-50 border-amber-200 text-amber-700 hover:bg-amber-100' },
  { value: 'cooling',  label: 'Cooling',  emoji: '❄️', on: 'bg-sky-200 border-sky-400 text-sky-900',       off: 'bg-sky-50 border-sky-200 text-sky-700 hover:bg-sky-100' },
  { value: 'neutral',  label: 'Neutral',  emoji: '',   on: 'bg-gray-200 border-gray-400 text-gray-900',    off: 'bg-gray-100 border-gray-300 text-gray-600 hover:bg-gray-200' },
];

const MOISTURE_OPTIONS: { value: MoistureEnergetic; label: string; emoji: string; on: string; off: string }[] = [
  { value: 'moistening', label: 'Moistening', emoji: '💧', on: 'bg-blue-200 border-blue-400 text-blue-900',   off: 'bg-blue-50 border-blue-200 text-blue-700 hover:bg-blue-100' },
  { value: 'drying',     label: 'Drying',     emoji: '🌵', on: 'bg-orange-200 border-orange-400 text-orange-900', off: 'bg-orange-50 border-orange-200 text-orange-700 hover:bg-orange-100' },
  { value: 'neutral',    label: 'Neutral',    emoji: '',   on: 'bg-gray-200 border-gray-400 text-gray-900',   off: 'bg-gray-100 border-gray-300 text-gray-600 hover:bg-gray-200' },
];

const TONE_OPTIONS: { value: ToneEnergetic; label: string; emoji: string; on: string; off: string }[] = [
  { value: 'toning',   label: 'Toning',   emoji: '⚡', on: 'bg-purple-200 border-purple-400 text-purple-900', off: 'bg-purple-50 border-purple-200 text-purple-700 hover:bg-purple-100' },
  { value: 'relaxing', label: 'Relaxing', emoji: '🌊', on: 'bg-teal-200 border-teal-400 text-teal-900',       off: 'bg-teal-50 border-teal-200 text-teal-700 hover:bg-teal-100' },
  { value: 'neutral',  label: 'Neutral',  emoji: '',   on: 'bg-gray-200 border-gray-400 text-gray-900',       off: 'bg-gray-100 border-gray-300 text-gray-600 hover:bg-gray-200' },
];

// ─── Helpers ──────────────────────────────────────────────────────────────────

function toggle<T>(set: Set<T>, val: T): Set<T> {
  const next = new Set(set);
  next.has(val) ? next.delete(val) : next.add(val);
  return next;
}

function cardBg(temp: TemperatureEnergetic) {
  if (temp === 'warming') return 'bg-amber-50 border-amber-200 hover:bg-amber-100';
  if (temp === 'cooling') return 'bg-sky-50 border-sky-200 hover:bg-sky-100';
  return 'bg-gray-50 border-gray-200 hover:bg-gray-100';
}

function herbEmojis(h: HerbRow) {
  return [
    h.temperature === 'warming' ? '🔥' : h.temperature === 'cooling' ? '❄️' : '',
    h.moisture === 'moistening' ? '💧' : h.moisture === 'drying' ? '🌵' : '',
    h.tone === 'toning' ? '⚡' : h.tone === 'relaxing' ? '🌊' : '',
  ].join('');
}

// ─── Component ────────────────────────────────────────────────────────────────

export function HerbFilterPanel({ isOpen, onClose, onHerbSelect, onSystemSelect }: HerbFilterPanelProps) {
  const [herbs, setHerbs] = useState<HerbRow[]>([]);
  const [bodySystems, setBodySystems] = useState<BodySystem[]>([]);
  const [actions, setActions] = useState<Action[]>([]);
  const [loading, setLoading] = useState(true);

  const [tempFilter, setTempFilter]       = useState<Set<TemperatureEnergetic>>(new Set());
  const [moistureFilter, setMoistureFilter] = useState<Set<MoistureEnergetic>>(new Set());
  const [toneFilter, setToneFilter]       = useState<Set<ToneEnergetic>>(new Set());
  const [systemFilter, setSystemFilter]   = useState<Set<number>>(new Set());
  const [actionFilter, setActionFilter]   = useState<Set<number>>(new Set());

  const loaded = useRef(false);

  useEffect(() => {
    if (isOpen && !loaded.current) {
      loaded.current = true;
      fetchData();
    }
  }, [isOpen]);

  async function fetchData() {
    setLoading(true);
    const [herbsRes, systemsRes, actionsRes] = await Promise.all([
      supabase
        .from('herbs')
        .select('id, common_name, latin_name, temperature, moisture, tone, pinyin_name, herb_primary_actions(primary_action_id, body_system_id), herb_menstruum(primary_label)')
        .eq('is_tcm', false)
        .order('common_name'),
      supabase.from('body_systems').select('id, name').order('name'),
      supabase.from('primary_actions').select('id, name').order('name'),
    ]);

    if (herbsRes.data) {
      setHerbs(
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        herbsRes.data.map((h: any) => {
          const menstruum = Array.isArray(h.herb_menstruum) ? h.herb_menstruum[0] : h.herb_menstruum;
          return {
            id: h.id,
            common_name: h.common_name,
            latin_name: h.latin_name,
            temperature: (h.temperature ?? 'neutral') as TemperatureEnergetic,
            moisture:    (h.moisture    ?? 'neutral') as MoistureEnergetic,
            tone:        (h.tone        ?? 'neutral') as ToneEnergetic,
            // eslint-disable-next-line @typescript-eslint/no-explicit-any
            action_ids: new Set<number>(h.herb_primary_actions.map((a: any) => a.primary_action_id).filter(Boolean)),
            // eslint-disable-next-line @typescript-eslint/no-explicit-any
            system_ids: new Set<number>(h.herb_primary_actions.map((a: any) => a.body_system_id).filter(Boolean)),
            menstruum_label: menstruum?.primary_label ?? null,
            pinyin_name: h.pinyin_name ?? null,
          };
        })
      );
    }
    if (systemsRes.data) setBodySystems(systemsRes.data);
    if (actionsRes.data) setActions(actionsRes.data);
    setLoading(false);
  }

  const hasFilters =
    tempFilter.size + moistureFilter.size + toneFilter.size +
    systemFilter.size + actionFilter.size > 0;

  const filteredHerbs = useMemo(() => {
    return herbs.filter((h) => {
      if (tempFilter.size > 0    && !tempFilter.has(h.temperature))                        return false;
      if (moistureFilter.size > 0 && !moistureFilter.has(h.moisture))                      return false;
      if (toneFilter.size > 0    && !toneFilter.has(h.tone))                                return false;
      if (systemFilter.size > 0  && ![...systemFilter].some((id) => h.system_ids.has(id))) return false;
      if (actionFilter.size > 0  && ![...actionFilter].some((id) => h.action_ids.has(id))) return false;
      return true;
    });
  }, [herbs, tempFilter, moistureFilter, toneFilter, systemFilter, actionFilter]);

  const systemMap = useMemo(
    () => new Map(bodySystems.map((s) => [s.id, s.name])),
    [bodySystems]
  );

  function clearAll() {
    setTempFilter(new Set());
    setMoistureFilter(new Set());
    setToneFilter(new Set());
    setSystemFilter(new Set());
    setActionFilter(new Set());
  }

  return (
    <>
      {/* Backdrop */}
      {isOpen && (
        <div
          className="fixed inset-0 z-30 bg-black/20"
          onClick={onClose}
        />
      )}

      {/* Slideover */}
      <div
        className={`fixed top-0 right-0 h-full w-[500px] z-40 bg-white shadow-2xl border-l border-gray-200 flex flex-col transition-transform duration-300 ease-in-out ${
          isOpen ? 'translate-x-0' : 'translate-x-full'
        }`}
      >
        {/* Header */}
        <div className="flex items-center justify-between px-5 py-4 border-b border-gray-200 shrink-0">
          <div>
            <h2 className="text-xl font-bold text-gray-900">Filter Herbs</h2>
            <p className="text-sm text-gray-500 mt-0.5">
              {hasFilters
                ? `${filteredHerbs.length} ${filteredHerbs.length === 1 ? 'herb matches' : 'herbs match'}`
                : `${herbs.length} herbs total`}
            </p>
          </div>
          <div className="flex items-center gap-3">
            {hasFilters && (
              <button
                onClick={clearAll}
                className="text-sm text-red-500 hover:text-red-700 font-medium transition-colors"
              >
                Clear all
              </button>
            )}
            <button
              onClick={onClose}
              className="p-2 rounded-lg hover:bg-gray-100 text-gray-400 hover:text-gray-600 transition-colors text-lg leading-none"
            >
              ✕
            </button>
          </div>
        </div>

        {/* Filter controls — scrollable, fixed max-height */}
        <div className="border-b border-gray-200 px-5 py-4 space-y-5 overflow-y-auto shrink-0 max-h-[46vh]">

          {/* Temperature */}
          <div>
            <p className="text-xs font-semibold text-gray-400 uppercase tracking-widest mb-2">Temperature</p>
            <div className="flex flex-wrap gap-2">
              {TEMP_OPTIONS.map((opt) => (
                <button
                  key={opt.value}
                  onClick={() => setTempFilter((prev) => toggle(prev, opt.value))}
                  className={`border rounded-full px-3 py-1 text-sm font-medium transition-all ${
                    tempFilter.has(opt.value) ? opt.on : opt.off
                  }`}
                >
                  {opt.emoji && <span className="mr-1">{opt.emoji}</span>}
                  {opt.label}
                </button>
              ))}
            </div>
          </div>

          {/* Moisture */}
          <div>
            <p className="text-xs font-semibold text-gray-400 uppercase tracking-widest mb-2">Moisture</p>
            <div className="flex flex-wrap gap-2">
              {MOISTURE_OPTIONS.map((opt) => (
                <button
                  key={opt.value}
                  onClick={() => setMoistureFilter((prev) => toggle(prev, opt.value))}
                  className={`border rounded-full px-3 py-1 text-sm font-medium transition-all ${
                    moistureFilter.has(opt.value) ? opt.on : opt.off
                  }`}
                >
                  {opt.emoji && <span className="mr-1">{opt.emoji}</span>}
                  {opt.label}
                </button>
              ))}
            </div>
          </div>

          {/* Tone */}
          <div>
            <p className="text-xs font-semibold text-gray-400 uppercase tracking-widest mb-2">Tone</p>
            <div className="flex flex-wrap gap-2">
              {TONE_OPTIONS.map((opt) => (
                <button
                  key={opt.value}
                  onClick={() => setToneFilter((prev) => toggle(prev, opt.value))}
                  className={`border rounded-full px-3 py-1 text-sm font-medium transition-all ${
                    toneFilter.has(opt.value) ? opt.on : opt.off
                  }`}
                >
                  {opt.emoji && <span className="mr-1">{opt.emoji}</span>}
                  {opt.label}
                </button>
              ))}
            </div>
          </div>

          {/* Body System */}
          {bodySystems.length > 0 && (
            <div>
              <p className="text-xs font-semibold text-gray-400 uppercase tracking-widest mb-2">Body System</p>
              <div className="flex flex-wrap gap-2">
                {bodySystems.map((sys) => (
                  <button
                    key={sys.id}
                    onClick={() => setSystemFilter((prev) => toggle(prev, sys.id))}
                    className={`border rounded-full px-3 py-1 text-sm font-medium transition-all ${
                      systemFilter.has(sys.id)
                        ? 'bg-green-200 border-green-400 text-green-900'
                        : 'bg-green-50 border-green-200 text-green-700 hover:bg-green-100'
                    }`}
                  >
                    {sys.name}
                  </button>
                ))}
              </div>
            </div>
          )}

          {/* Action */}
          {actions.length > 0 && (
            <div>
              <p className="text-xs font-semibold text-gray-400 uppercase tracking-widest mb-2">Action</p>
              <div className="flex flex-wrap gap-2">
                {actions.map((action) => (
                  <button
                    key={action.id}
                    onClick={() => setActionFilter((prev) => toggle(prev, action.id))}
                    className={`border rounded-full px-3 py-1 text-sm font-medium transition-all ${
                      actionFilter.has(action.id)
                        ? 'bg-violet-200 border-violet-400 text-violet-900'
                        : 'bg-violet-50 border-violet-200 text-violet-700 hover:bg-violet-100'
                    }`}
                  >
                    {action.name}
                  </button>
                ))}
              </div>
            </div>
          )}
        </div>

        {/* Results list */}
        <div className="flex-1 overflow-y-auto min-h-0">
          {loading ? (
            <div className="flex items-center justify-center h-32 text-gray-400 text-sm">
              Loading herbs…
            </div>
          ) : (
            <>
              {hasFilters && filteredHerbs.length === 0 && (
                <div className="flex flex-col items-center justify-center h-32 gap-1">
                  <p className="text-gray-400 text-sm">No herbs match all these filters.</p>
                  <button onClick={clearAll} className="text-sm text-red-400 hover:text-red-600 underline">
                    Clear filters
                  </button>
                </div>
              )}

              <div className="p-3 space-y-1.5">
                {filteredHerbs.map((herb) => {
                  const sortedSystemIds = [...herb.system_ids].sort((a, b) => {
                    const aSelected = systemFilter.has(a) ? 0 : 1;
                    const bSelected = systemFilter.has(b) ? 0 : 1;
                    if (aSelected !== bSelected) return aSelected - bSelected;
                    return (systemMap.get(a) ?? '').localeCompare(systemMap.get(b) ?? '');
                  });
                  return (
                    <button
                      key={herb.id}
                      onClick={() => onHerbSelect(herb.id)}
                      className={`w-full text-left border rounded-lg px-4 py-2.5 transition-all hover:shadow-md hover:scale-[1.005] ${cardBg(herb.temperature)}`}
                    >
                      <div className="flex items-center justify-between gap-2">
                        <span className="font-medium text-gray-900 text-sm">{herb.common_name}</span>
                        <span className="text-base leading-none shrink-0">{herbEmojis(herb)}</span>
                      </div>
                      {herb.pinyin_name && (
                        <div className="text-xs text-gray-500 mt-0.5">{herb.pinyin_name}</div>
                      )}
                      <div className="text-xs italic text-gray-500 mt-0.5">{herb.latin_name}</div>
                      {(sortedSystemIds.length > 0 || herb.menstruum_label) && (
                        <div className="flex items-center flex-wrap gap-1 mt-1.5">
                          {sortedSystemIds.map((sysId) => {
                            const name = systemMap.get(sysId);
                            if (!name) return null;
                            const isActive = systemFilter.has(sysId);
                            return (
                              <span
                                key={sysId}
                                onClick={(e) => {
                                  e.stopPropagation();
                                  onSystemSelect?.(sysId);
                                }}
                                className={`text-xs px-2 py-0.5 rounded-full border transition-colors cursor-pointer ${
                                  isActive
                                    ? 'bg-green-200 border-green-400 text-green-900 hover:bg-green-300'
                                    : 'bg-green-50 border-green-200 text-green-700 hover:bg-green-100'
                                }`}
                              >
                                {name}
                              </span>
                            );
                          })}
                          {herb.menstruum_label && (
                            <span className="text-xs px-2 py-0.5 rounded-full border bg-purple-50 border-purple-200 text-purple-700">
                              {herb.menstruum_label}
                            </span>
                          )}
                        </div>
                      )}
                    </button>
                  );
                })}
              </div>
            </>
          )}
        </div>
      </div>
    </>
  );
}
