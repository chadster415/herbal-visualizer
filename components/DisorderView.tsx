'use client';

import { useState, useEffect, useRef, useMemo } from 'react';

function parseFoodSources(text: string): string[] {
  const items: string[] = [];
  let depth = 0;
  let current = '';
  for (const char of text) {
    if (char === '(') { depth++; current += char; }
    else if (char === ')') { depth--; current += char; }
    else if (char === ',' && depth === 0) {
      const trimmed = current.trim();
      if (trimmed) items.push(trimmed);
      current = '';
    } else {
      current += char;
    }
  }
  const trimmed = current.trim();
  if (trimmed) items.push(trimmed);
  return items;
}


const SOLUBILITY_COLORS: Record<string, { bubble: string; name: string; dose: string; note: string; category: string }> = {
  'water-soluble':       { bubble: 'bg-blue-50 hover:bg-blue-100 border border-blue-200 hover:border-blue-300',     name: 'text-blue-900',   dose: 'text-blue-600',   note: 'text-blue-500',   category: 'text-blue-400' },
  'fat-soluble':         { bubble: 'bg-amber-50 hover:bg-amber-100 border border-amber-200 hover:border-amber-300', name: 'text-amber-900',  dose: 'text-amber-600',  note: 'text-amber-500',  category: 'text-amber-400' },
  'water & fat-soluble': { bubble: 'bg-purple-50 hover:bg-purple-100 border border-purple-200 hover:border-purple-300', name: 'text-purple-900', dose: 'text-purple-600', note: 'text-purple-500', category: 'text-purple-400' },
  'oil-soluble':         { bubble: 'bg-amber-50 hover:bg-amber-100 border border-amber-200 hover:border-amber-300', name: 'text-amber-900',  dose: 'text-amber-600',  note: 'text-amber-500',  category: 'text-amber-400' },
};
const DEFAULT_SUPP_COLORS = { bubble: 'bg-indigo-50 hover:bg-indigo-100 border border-indigo-200 hover:border-indigo-300', name: 'text-indigo-900', dose: 'text-indigo-600', note: 'text-indigo-500', category: 'text-indigo-400' };
import { supabase } from '@/lib/supabase';
import { TextPageLinks } from './TextPageLinks';
import { EnergeticEmojis } from './EnergeticEmojis';
import type {
  Disorder,
  DisorderNote,
  PrimaryAction,
  Herb,
  DisorderPrescription,
  PrescriptionHerb,
  Supplement,
} from '@/types/database';

type NoteGroup = { heading: string | null; notes: DisorderNote[] };
function groupByHeading(notes: DisorderNote[]): NoteGroup[] {
  const sorted = [...notes].sort((a, b) => a.sort_order - b.sort_order);
  const groups: NoteGroup[] = [];
  for (const note of sorted) {
    const last = groups[groups.length - 1];
    if (last && last.heading === (note.heading ?? null)) {
      last.notes.push(note);
    } else {
      groups.push({ heading: note.heading ?? null, notes: [note] });
    }
  }
  return groups;
}

interface DisorderData extends Disorder {
  disorder_notes: DisorderNote[];
  disorder_actions_indicated: Array<{
    id: number;
    description: string;
    sort_order: number;
    primary_actions: PrimaryAction;
  }>;
  disorder_action_herbs: Array<{
    id: number;
    note: string | null;
    sort_order: number;
    herbs: Herb;
    primary_actions: PrimaryAction;
  }>;
  disorder_specific_remedies: Array<{
    id: number;
    description: string;
    sort_order: number;
    source_id: number | null;
    herbs: Herb;
  }>;
  disorder_prescriptions: Array<
    DisorderPrescription & {
      prescription_herbs: Array<
        PrescriptionHerb & {
          herbs: Herb & { herb_menstruum?: { primary_label: string } | null };
          prescription_herb_actions: Array<{
            primary_actions: PrimaryAction;
          }>;
        }
      >;
      prescription_supplements: Array<{
        id: number;
        supplement_id: number;
        dose: string | null;
        note: string | null;
        sort_order: number;
        supplements: Supplement;
      }>;
    }
  >;
}

interface InventoryEntry { in_stock: boolean; notes: string; }

interface DisorderViewProps {
  bodySystemId?: number;
  onHerbClick?: (herbId: number) => void;
  onActionClick?: (actionId: number) => void;
  onSupplementClick?: (supplementId: number) => void;
  onTransferToDosing?: (herbs: Array<{ id: number; common_name: string; latin_name: string; plant_part: string | null }>) => void;
  selectedDisorderId?: number | null;
  onDisorderChange?: (id: number | null) => void;
  userInventory?: Map<number, InventoryEntry>;
}

export function DisorderView({ bodySystemId, onHerbClick, onActionClick, onSupplementClick, onTransferToDosing, selectedDisorderId, onDisorderChange, userInventory }: DisorderViewProps) {
  const [disorders, setDisorders] = useState<DisorderData[]>([]);
  const [selectedDisorder, setSelectedDisorder] = useState<DisorderData | null>(null);
  const [loading, setLoading] = useState(true);
  const [disorderListOpen, setDisorderListOpen] = useState(true);
  const [imageManifest, setImageManifest] = useState<Record<string, number>>({});
  const [strengthMap, setStrengthMap] = useState<Map<number, string>>(new Map());
  const subjectiveRef = useRef<HTMLDivElement | null>(null);
  const objectiveRef = useRef<HTMLDivElement | null>(null);
  const lifestyleRef = useRef<HTMLDivElement | null>(null);
  const actionsRef = useRef<HTMLDivElement | null>(null);
  const remediesRef = useRef<HTMLDivElement | null>(null);
  const prescriptionsRef = useRef<HTMLDivElement | null>(null);
  const foodSourcesRef = useRef<HTMLDivElement | null>(null);
  const [shopModalOpen, setShopModalOpen] = useState(false);
  const [checkedFoods, setCheckedFoods] = useState<Set<string>>(new Set());

  useEffect(() => {
    fetch('/api/disorder-images')
      .then((r) => r.json())
      .then(setImageManifest)
      .catch(() => {});
  }, []);


  useEffect(() => {
    if (bodySystemId) {
      setSelectedDisorder(null); // Reset selected disorder when body system changes
      fetchDisorders();
    }
  }, [bodySystemId]);

  async function fetchDisorders() {
    if (!bodySystemId) return;

    try {
      const [{ data, error }, { data: strengthData }] = await Promise.all([
        supabase
          .from('disorders')
          .select(`
            *,
            disorder_notes (*),
            disorder_actions_indicated (
              id,
              description,
              sort_order,
              primary_actions (*)
            ),
            disorder_action_herbs (
              id,
              note,
              sort_order,
              herbs (*),
              primary_actions (*)
            ),
            disorder_specific_remedies (
              id,
              description,
              sort_order,
              source_id,
              herbs (*)
            ),
            disorder_prescriptions (
              *,
              prescription_herbs (
                *,
                herbs (*, herb_menstruum(primary_label)),
                prescription_herb_actions (
                  primary_actions (*)
                )
              ),
              prescription_supplements (
                *,
                supplements (*)
              )
            )
          `)
          .eq('body_system_id', bodySystemId)
          .order('sort_order'),
        supabase
          .from('herb_primary_actions')
          .select('herb_id, relative_strength')
          .eq('body_system_id', bodySystemId),
      ]);

      if (error) throw error;

      const map = new Map<number, string>();
      strengthData?.forEach((r: any) => {
        if (r.relative_strength) map.set(r.herb_id, r.relative_strength);
      });
      setStrengthMap(map);

      // Sort nested arrays by sort_order
      const sortedData = (data || []).map((disorder) => ({
        ...disorder,
        disorder_notes: disorder.disorder_notes.sort((a: DisorderNote, b: DisorderNote) => a.sort_order - b.sort_order),
        disorder_actions_indicated: disorder.disorder_actions_indicated.sort((a: any, b: any) => a.sort_order - b.sort_order),
        disorder_action_herbs: disorder.disorder_action_herbs.sort((a: any, b: any) => a.sort_order - b.sort_order),
        disorder_specific_remedies: disorder.disorder_specific_remedies.sort((a: any, b: any) => {
          const nameOrder = a.herbs.common_name.localeCompare(b.herbs.common_name);
          if (nameOrder !== 0) return nameOrder;
          return (a.source_id ?? 0) - (b.source_id ?? 0);
        }),
        disorder_prescriptions: disorder.disorder_prescriptions
          .sort((a: DisorderPrescription, b: DisorderPrescription) => a.sort_order - b.sort_order)
          .map((prescription: any) => ({
            ...prescription,
            prescription_herbs: prescription.prescription_herbs.sort((a: PrescriptionHerb, b: PrescriptionHerb) => a.sort_order - b.sort_order),
            prescription_supplements: (prescription.prescription_supplements ?? []).sort((a: any, b: any) => a.sort_order - b.sort_order),
          })),
      }));

      setDisorders(sortedData);
      if (selectedDisorderId != null) {
        const match = sortedData.find((d) => d.id === selectedDisorderId) ?? null;
        if (match) { setSelectedDisorder(match); setDisorderListOpen(false); }
      } else {
        const overall = sortedData.find((d) => d.name === 'Overall') ?? null;
        if (overall) setSelectedDisorder(overall);
      }
    } catch (error) {
      console.error('Error fetching disorders:', error);
    } finally {
      setLoading(false);
    }
  }

  const getTemperatureCard = (herb: Herb) => {
    switch (herb.temperature) {
      case 'warming': return 'bg-amber-50 border-amber-200 hover:bg-amber-100';
      case 'cooling': return 'bg-sky-50 border-sky-200 hover:bg-sky-100';
      default:        return 'bg-gray-50 border-gray-200 hover:bg-gray-100';
    }
  };


  const getStrengthBadge = (strength: string | undefined) => {
    switch (strength) {
      case 'mild':        return 'bg-yellow-100 text-yellow-700';
      case 'strong':      return 'bg-orange-100 text-orange-700';
      case 'very_strong': return 'bg-red-100 text-red-700';
      default:            return null;
    }
  };

  // Aggregate food sources across all prescription supplements for the selected disorder
  const foodSourceMap = useMemo(() => {
    if (!selectedDisorder) return new Map<string, string[]>();
    const map = new Map<string, string[]>();
    selectedDisorder.disorder_prescriptions.forEach((rx) => {
      rx.prescription_supplements.forEach(({ supplements: supp }) => {
        if (!supp.dietary_sources) return;
        parseFoodSources(supp.dietary_sources).forEach((food) => {
          const key = food.toLowerCase();
          if (!map.has(key)) map.set(key, []);
          const existing = map.get(key)!;
          if (!existing.includes(supp.name)) existing.push(supp.name);
        });
      });
    });
    return map;
  }, [selectedDisorder]);

  // Foods grouped by supplement, for the modal display
  const supplementFoodGroups = useMemo(() => {
    if (!selectedDisorder) return [] as Array<{ supplement: string; foods: string[] }>;
    const map = new Map<string, string[]>();
    selectedDisorder.disorder_prescriptions.forEach((rx) => {
      rx.prescription_supplements.forEach(({ supplements: supp }) => {
        if (!supp.dietary_sources) return;
        const foods = parseFoodSources(supp.dietary_sources).sort((a, b) => a.localeCompare(b));
        if (!map.has(supp.name)) map.set(supp.name, []);
        foods.forEach((f) => {
          if (!map.get(supp.name)!.includes(f)) map.get(supp.name)!.push(f);
        });
      });
    });
    return Array.from(map.entries())
      .sort(([a], [b]) => a.localeCompare(b))
      .map(([supplement, foods]) => ({ supplement, foods }));
  }, [selectedDisorder]);

  // Canonical food name (first seen casing) list sorted alphabetically
  const foodSourceList = useMemo(() => {
    if (!selectedDisorder) return [] as Array<{ food: string; supplements: string[] }>;
    const seen = new Map<string, string>();
    selectedDisorder.disorder_prescriptions.forEach((rx) => {
      rx.prescription_supplements.forEach(({ supplements: supp }) => {
        if (!supp.dietary_sources) return;
        parseFoodSources(supp.dietary_sources).forEach((food) => {
          if (!seen.has(food.toLowerCase())) seen.set(food.toLowerCase(), food);
        });
      });
    });
    return Array.from(seen.keys())
      .sort()
      .map((key) => ({ food: seen.get(key)!, supplements: foodSourceMap.get(key) ?? [] }));
  }, [selectedDisorder, foodSourceMap]);

  // Group action herbs by primary action
  const groupActionHerbs = (actionHerbs: DisorderData['disorder_action_herbs']) => {
    const grouped: Record<number, { action: PrimaryAction; herbs: Array<{ herb: Herb; note: string | null; sort_order: number }> }> = {};
    actionHerbs.forEach((item) => {
      if (!grouped[item.primary_actions.id]) grouped[item.primary_actions.id] = { action: item.primary_actions, herbs: [] };
      grouped[item.primary_actions.id].herbs.push({ herb: item.herbs, note: item.note, sort_order: item.sort_order });
    });
    return Object.values(grouped);
  };

  if (loading) {
    return <div className="text-center py-8">Loading disorders...</div>;
  }

  if (!bodySystemId) {
    return (
      <div className="flex items-center justify-center h-full text-gray-400">
        <p className="text-lg">Select a body system to view disorders</p>
      </div>
    );
  }

  if (disorders.length === 0) {
    return (
      <div className="flex items-center justify-center h-full text-gray-400">
        <p className="text-lg">No disorders found for this body system</p>
      </div>
    );
  }

  return (
    <>
    <div className="space-y-4">
      {/* Disorder Selector */}
      <div>
        {selectedDisorder && (
          <div className="flex items-center gap-2 mb-2 sm:hidden">
            <span className={`px-3 py-1.5 rounded-lg border text-sm font-medium ${selectedDisorder.is_case_study ? 'bg-purple-600 text-white border-purple-600' : 'bg-green-600 text-white border-green-600'}`}>
              {selectedDisorder.name}
            </span>
            <button
              onClick={() => setDisorderListOpen((prev) => !prev)}
              className="flex items-center gap-1 text-xs text-gray-500 hover:text-gray-700 px-2 py-1 rounded-lg hover:bg-gray-100 transition-all"
              aria-label="Toggle disorder list"
            >
              <svg className={`w-4 h-4 transition-transform duration-200 ${disorderListOpen ? 'rotate-180' : ''}`} fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
              </svg>
            </button>
          </div>
        )}
        <div className={`flex-wrap gap-2 ${!selectedDisorder || disorderListOpen ? 'flex' : 'hidden sm:flex'}`}>
            {disorders
              .slice()
              .sort((a, b) => {
                if (a.is_case_study && !b.is_case_study) return -1;
                if (!a.is_case_study && b.is_case_study) return 1;
                if (a.name === 'Overall') return -1;
                if (b.name === 'Overall') return 1;
                return a.name.localeCompare(b.name);
              })
              .map((disorder) => (
                <button
                  key={disorder.id}
                  onClick={() => {
                    setSelectedDisorder(disorder);
                    onDisorderChange?.(disorder.id);
                    setDisorderListOpen(false);
                  }}
                  className={`px-3 py-1.5 rounded-lg border text-sm font-medium transition-all ${
                    selectedDisorder?.id === disorder.id
                      ? disorder.is_case_study
                        ? 'bg-purple-600 text-white border-purple-600'
                        : 'bg-green-600 text-white border-green-600'
                      : disorder.is_case_study
                        ? 'bg-white text-purple-700 border-purple-300 hover:bg-purple-50 hover:border-purple-400'
                        : 'bg-white text-gray-700 border-gray-300 hover:bg-green-50 hover:border-green-400'
                  }`}
                >
                  {disorder.name}
                </button>
              ))}
        </div>
      </div>

      {/* Disorder Details */}
      <div>
        {!selectedDisorder && (
          <div className="flex items-center justify-center py-16 text-gray-400">
            <p>Select a disorder to view details</p>
          </div>
        )}
        {selectedDisorder ? (
          <div className="space-y-8">
            <h2 className="text-3xl font-bold text-green-800 mb-2 flex items-center gap-3 flex-wrap">
              {selectedDisorder.name}
              {selectedDisorder.is_case_study && (
                <span className="text-sm font-medium bg-purple-100 text-purple-700 px-2.5 py-1 rounded-full border border-purple-200">
                  Case Study
                </span>
              )}
            </h2>
            {/* Section nav — positioned under title */}
            {(() => {
              const pills = [
                ...(selectedDisorder.disorder_notes.some((n) => n.section === 'subjective') ? [{ label: 'Subjective', ref: subjectiveRef }] : []),
                ...(selectedDisorder.disorder_notes.some((n) => n.section === 'objective') ? [{ label: 'Objective', ref: objectiveRef }] : []),
                ...(selectedDisorder.disorder_notes.some((n) => n.section === 'general') ? [{ label: selectedDisorder.is_case_study ? 'Lifestyle' : 'Notes', ref: lifestyleRef }] : []),
                ...((selectedDisorder.disorder_actions_indicated.length > 0 || selectedDisorder.disorder_action_herbs.length > 0) ? [{ label: 'Actions Indicated', ref: actionsRef }] : []),
                ...(selectedDisorder.disorder_specific_remedies.length > 0 ? [{ label: 'Specific Remedies', ref: remediesRef }] : []),
                ...(selectedDisorder.disorder_prescriptions.length > 0 ? [{ label: 'Prescriptions', ref: prescriptionsRef }] : []),
                ...(foodSourceList.length > 0 ? [{ label: 'Food Sources', ref: foodSourcesRef }] : []),
              ];
              if (pills.length === 0) return null;
              return (
                <div className="flex flex-wrap gap-1.5 text-xs">
                  {pills.map(({ label, ref }) => (
                    <button
                      key={label}
                      onClick={() => ref.current?.scrollIntoView({ behavior: 'smooth', block: 'start' })}
                      className="px-2.5 py-1 rounded-full border border-gray-300 text-gray-500 hover:border-green-500 hover:text-green-700 transition-colors"
                    >
                      {label}
                    </button>
                  ))}
                </div>
              );
            })()}

            <TextPageLinks
              disorderName={selectedDisorder.name}
              pageCount={imageManifest[selectedDisorder.name] ?? 0}
            />

            {/* Subjective */}
            {(() => {
              const notes = selectedDisorder.disorder_notes.filter((n) => n.section === 'subjective');
              if (notes.length === 0) return null;
              return (
                <div ref={subjectiveRef} className="bg-blue-50 border border-blue-200 border-l-4 border-l-blue-500 rounded-lg p-4">
                  <h3 className="text-xs font-semibold text-blue-600 uppercase tracking-widest mb-3">Subjective</h3>
                  <div className="space-y-3">
                    {groupByHeading(notes).map((group, i) => (
                      <div key={i}>
                        {group.heading && (
                          <p className="text-sm font-semibold text-blue-800 mb-1">{group.heading}</p>
                        )}
                        {!group.heading ? (
                          group.notes.map((n) => (
                            <p key={n.id} className="text-sm text-gray-700">{n.note_text}</p>
                          ))
                        ) : (
                          <ul className="list-disc list-inside space-y-1">
                            {group.notes.map((n) => (
                              <li key={n.id} className="text-sm text-gray-700">{n.note_text}</li>
                            ))}
                          </ul>
                        )}
                      </div>
                    ))}
                  </div>
                </div>
              );
            })()}

            {/* Objective */}
            {(() => {
              const notes = selectedDisorder.disorder_notes.filter((n) => n.section === 'objective');
              if (notes.length === 0) return null;
              return (
                <div ref={objectiveRef} className="bg-indigo-50 border border-indigo-200 border-l-4 border-l-indigo-500 rounded-lg p-4">
                  <h3 className="text-xs font-semibold text-indigo-600 uppercase tracking-widest mb-3">Objective</h3>
                  <div className="space-y-3">
                    {groupByHeading(notes).map((group, i) => (
                      <div key={i}>
                        {group.heading && (
                          <p className="text-sm font-semibold text-indigo-800 mb-1">{group.heading}</p>
                        )}
                        {!group.heading ? (
                          group.notes.map((n) => (
                            <p key={n.id} className="text-sm text-gray-700">{n.note_text}</p>
                          ))
                        ) : (
                          <ul className="list-disc list-inside space-y-1">
                            {group.notes.map((n) => (
                              <li key={n.id} className="text-sm text-gray-700">{n.note_text}</li>
                            ))}
                          </ul>
                        )}
                      </div>
                    ))}
                  </div>
                </div>
              );
            })()}

            {/* Notes / Lifestyle Recommendations */}
            {selectedDisorder.disorder_notes.filter((n) => n.section === 'general').length > 0 && (
              <div ref={lifestyleRef} className="bg-green-50 border border-green-200 border-l-4 border-l-green-600 rounded-lg p-4">
                <h3 className="text-xs font-semibold text-green-600 uppercase tracking-widest mb-3">
                  {selectedDisorder.is_case_study ? 'Lifestyle Recommendations' : 'Notes'}
                </h3>
                <ul className="list-disc list-inside space-y-2">
                  {selectedDisorder.disorder_notes
                    .filter((n) => n.section === 'general')
                    .map((note) => (
                      <li key={note.id} className="text-gray-700">
                        {note.note_text}
                      </li>
                    ))}
                </ul>
              </div>
            )}

            {/* Actions Indicated + Action Herbs (combined) */}
            {(selectedDisorder.disorder_actions_indicated.length > 0 || selectedDisorder.disorder_action_herbs.length > 0) && (() => {
              const herbsByAction = new Map<number, typeof selectedDisorder.disorder_action_herbs>();
              selectedDisorder.disorder_action_herbs.forEach((h) => {
                const id = h.primary_actions.id;
                if (!herbsByAction.has(id)) herbsByAction.set(id, []);
                herbsByAction.get(id)!.push(h);
              });

              const indicatedIds = new Set(selectedDisorder.disorder_actions_indicated.map((a) => a.primary_actions.id));

              const herbOnlyGroups = groupActionHerbs(
                selectedDisorder.disorder_action_herbs.filter((h) => !indicatedIds.has(h.primary_actions.id))
              );

              const HerbPills = ({ herbs }: { herbs: typeof selectedDisorder.disorder_action_herbs }) => (
                <div className="flex flex-wrap gap-2 mt-2">
                  {herbs.sort((a, b) => a.herbs.common_name.localeCompare(b.herbs.common_name)).map((h, idx) => (
                    <button
                      key={idx}
                      onClick={(e) => { e.stopPropagation(); onHerbClick?.(h.herbs.id); }}
                      className={`inline-flex flex-col items-start border rounded-lg px-3 py-1.5 transition-all hover:shadow-md ${getTemperatureCard(h.herbs)}`}
                    >
                      <div className="flex items-center gap-2">
                        <span className="font-medium text-gray-900 text-sm">{h.herbs.common_name}{h.herbs.plant_part ? ` (${h.herbs.plant_part})` : ''}</span>
                        <EnergeticEmojis temperature={h.herbs.temperature} moisture={h.herbs.moisture} tone={h.herbs.tone} temperatureInferred={h.herbs.temperature_inferred} moistureInferred={h.herbs.moisture_inferred} toneInferred={h.herbs.tone_inferred} className="text-sm leading-none shrink-0" inStock={userInventory?.get(h.herbs.id)?.in_stock} inventoryNotes={userInventory?.get(h.herbs.id)?.notes} />
                      </div>
                      <span className="text-xs italic text-gray-600">{h.herbs.latin_name}</span>
                    </button>
                  ))}
                </div>
              );

              const actionNotes = selectedDisorder.disorder_notes.filter((n) => n.section === 'actions_indicated');

              return (
                <div className="border-l-4 border-blue-500 pl-4" ref={actionsRef}>
                  <h3 className="text-xl font-semibold text-gray-800 mb-3">Actions Indicated</h3>
                  {actionNotes.length > 0 && (
                    <div className="mb-3 bg-blue-50 rounded-lg p-3">
                      <ul className="list-disc list-inside space-y-1">
                        {actionNotes.map((note) => (
                          <li key={note.id} className="text-sm text-gray-700">{note.note_text}</li>
                        ))}
                      </ul>
                    </div>
                  )}
                  <div className="space-y-2">
                    {selectedDisorder.disorder_actions_indicated
                      .sort((a, b) => a.primary_actions.name.localeCompare(b.primary_actions.name))
                      .map((item) => {
                        const herbs = herbsByAction.get(item.primary_actions.id) ?? [];
                        return (
                          <div key={item.id} className="border border-gray-200 rounded-lg p-3">
                            <button
                              onClick={() => onActionClick?.(item.primary_actions.id)}
                              className="w-full text-left"
                            >
                              <div className="font-semibold text-green-700 mb-1">{item.primary_actions.name}</div>
                              {item.description && <p className="text-sm text-gray-700">{item.description}</p>}
                            </button>
                            {herbs.length > 0 && <HerbPills herbs={herbs} />}
                          </div>
                        );
                      })}
                    {herbOnlyGroups.map((group) => (
                      <div key={group.action.id} className="border border-gray-200 rounded-lg p-3">
                        <button
                          onClick={() => onActionClick?.(group.action.id)}
                          className="font-semibold text-green-700 hover:underline"
                        >
                          {group.action.name}
                        </button>
                        <HerbPills herbs={selectedDisorder.disorder_action_herbs.filter((h) => h.primary_actions.id === group.action.id)} />
                      </div>
                    ))}
                  </div>
                </div>
              );
            })()}

            {/* Specific Remedies */}
            {selectedDisorder.disorder_specific_remedies.length > 0 && (
              <div className="border-l-4 border-amber-500 pl-4" ref={remediesRef}>
                <h3 className="text-xl font-semibold text-gray-800 mb-3">
                  Specific Remedies
                </h3>
                <div className="space-y-3">
                  {selectedDisorder.disorder_specific_remedies.map((item) => (
                    <button
                      key={item.id}
                      onClick={() => onHerbClick?.(item.herbs.id)}
                      className={`w-full text-left border rounded-lg py-1.5 px-3 hover:shadow-md hover:scale-[1.01] transition-all ${getTemperatureCard(item.herbs)}`}
                    >
                      <div className="flex items-center justify-between gap-2 mb-1">
                        <div className="font-semibold text-gray-900">{item.herbs.common_name}{item.herbs.plant_part ? ` (${item.herbs.plant_part})` : ''}</div>
                        <div className="flex items-center gap-1 shrink-0">
                          {item.source_id === 1 && (
                            <span className="px-1.5 py-0.5 rounded text-[10px] font-semibold bg-amber-100 text-amber-700 border border-amber-200">P&amp;P</span>
                          )}
                          <EnergeticEmojis temperature={item.herbs.temperature} moisture={item.herbs.moisture} tone={item.herbs.tone} temperatureInferred={item.herbs.temperature_inferred} moistureInferred={item.herbs.moisture_inferred} toneInferred={item.herbs.tone_inferred} className="text-sm leading-none" inStock={userInventory?.get(item.herbs.id)?.in_stock} inventoryNotes={userInventory?.get(item.herbs.id)?.notes} />
                        </div>
                      </div>
                      <div className="text-sm italic text-gray-600">{item.herbs.latin_name}</div>
                      {(() => {
                        const s = strengthMap.get(item.herbs.id);
                        const cls = getStrengthBadge(s);
                        return (
                          <div className="flex items-end justify-between gap-2 mt-1">
                            {item.description
                              ? <p className="text-sm text-gray-700">{item.description}</p>
                              : <span />}
                            {cls && <span className={`text-xs font-semibold px-1.5 py-0.5 rounded shrink-0 ${cls}`}>{s!.replace('_', ' ')}</span>}
                          </div>
                        );
                      })()}
                    </button>
                  ))}
                </div>
              </div>
            )}

            {/* Prescriptions */}
            {selectedDisorder.disorder_prescriptions.length > 0 && (
              <div className="border-l-4 border-purple-500 pl-4" ref={prescriptionsRef}>
                <h3 className="text-xl font-semibold text-gray-800 mb-3">
                  Prescriptions
                </h3>
                <div className="space-y-4">
                  {selectedDisorder.disorder_prescriptions.map((prescription) => (
                    <div
                      key={prescription.id}
                      className="border border-gray-200 rounded-lg p-4 bg-gray-50"
                    >
                      {prescription.title && (
                        <h4 className="text-lg font-semibold text-gray-800 mb-2">
                          {prescription.title}
                        </h4>
                      )}

                      <div className="mb-3 flex flex-wrap gap-3">
                        {prescription.prescription_herbs.map((prescHerb) => (
                          <button
                            key={prescHerb.id}
                            onClick={() => onHerbClick?.(prescHerb.herbs.id)}
                            className="relative inline-flex flex-col items-start bg-white hover:bg-green-50 border border-gray-200 rounded-lg px-3 py-2 transition-all hover:shadow-md group"
                          >
                            <div className="flex items-baseline gap-2 mb-1">
                              <span className="font-medium text-gray-900">
                                {prescHerb.herbs.common_name}{prescHerb.herbs.plant_part ? ` (${prescHerb.herbs.plant_part})` : ''}
                              </span>
                              <span className="text-xs text-gray-500">
                                {prescHerb.parts}
                              </span>
                            </div>
                            <span className="text-xs italic text-gray-600">
                              {prescHerb.herbs.latin_name}
                            </span>
                            {prescHerb.prescription_herb_actions.length > 0 && (
                              <div className="flex flex-wrap gap-1 mt-2">
                                {prescHerb.prescription_herb_actions.map((action, idx) => (
                                  <span
                                    key={idx}
                                    onClick={(e) => {
                                      e.stopPropagation();
                                      onActionClick?.(action.primary_actions.id);
                                    }}
                                    className="text-xs bg-blue-100 text-blue-800 px-1.5 py-0.5 rounded cursor-pointer hover:bg-blue-200 transition-all"
                                  >
                                    {action.primary_actions.name}
                                  </span>
                                ))}
                              </div>
                            )}
                            {prescHerb.herbs.herb_menstruum?.primary_label && (
                              <span className="text-xs mt-1 px-1.5 py-0.5 rounded border bg-purple-50 border-purple-200 text-purple-700">
                                {prescHerb.herbs.herb_menstruum.primary_label}
                              </span>
                            )}
                            {prescHerb.note && (
                              <span className="text-xs italic text-gray-500 mt-1 block">{prescHerb.note}</span>
                            )}
                          </button>
                        ))}
                        {prescription.prescription_supplements.map((ps) => {
                          const sc = SOLUBILITY_COLORS[ps.supplements.solubility ?? ''] ?? DEFAULT_SUPP_COLORS;
                          return (
                          <button
                            key={`supp-${ps.id}`}
                            onClick={() => onSupplementClick?.(ps.supplements.id)}
                            className={`relative inline-flex flex-col items-start ${sc.bubble} rounded-lg px-3 py-2 transition-all hover:shadow-md`}
                          >
                            <div className="flex items-center justify-between w-full gap-2 mb-1">
                              <span className={`font-medium ${sc.name}`}>{ps.supplements.name}</span>
                              {ps.supplements.category === 'Mineral' && ps.supplements.temperature !== 'warming' && (
                                <EnergeticEmojis temperature="cooling" className="text-base leading-none shrink-0" />
                              )}
                            </div>
                            {ps.dose && (
                              <span className={`text-xs font-medium ${sc.dose}`}>{ps.dose}</span>
                            )}
                            {ps.note && (
                              <span className={`text-[10px] italic ${sc.note}`}>{ps.note}</span>
                            )}
                            <span className={`text-[10px] mt-0.5 ${sc.category}`}>{ps.supplements.category}</span>
                          </button>
                          );
                        })}
                      </div>

                      {onTransferToDosing && prescription.prescription_herbs.length > 0 && (
                        <div className="mb-3">
                          <button
                            onClick={() => onTransferToDosing(prescription.prescription_herbs.map((ph) => ({
                              id: ph.herbs.id,
                              common_name: ph.herbs.common_name,
                              latin_name: ph.herbs.latin_name,
                              plant_part: ph.herbs.plant_part ?? null,
                            })))}
                            className="inline-flex items-center gap-1.5 text-xs px-3 py-1.5 rounded-md bg-purple-100 hover:bg-purple-200 text-purple-800 border border-purple-300 transition-all"
                          >
                            <svg xmlns="http://www.w3.org/2000/svg" className="h-3.5 w-3.5" viewBox="0 0 20 20" fill="currentColor">
                              <path fillRule="evenodd" d="M6 2a2 2 0 00-2 2v12a2 2 0 002 2h8a2 2 0 002-2V4a2 2 0 00-2-2H6zm1 2a1 1 0 000 2h6a1 1 0 100-2H7zm0 4a1 1 0 000 2h1a1 1 0 100-2H7zm5 0a1 1 0 100 2h1a1 1 0 100-2h-1zm-5 4a1 1 0 100 2h1a1 1 0 100-2H7zm5 0a1 1 0 100 2h1a1 1 0 100-2h-1z" clipRule="evenodd" />
                            </svg>
                            Open in Dosing Calculator
                          </button>
                        </div>
                      )}
                      <div className="text-sm text-gray-700 bg-white rounded p-3">
                        {prescription.instructions}
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            )}
          </div>
        ) : null}

        {/* Food Sources */}
        {selectedDisorder && foodSourceList.length > 0 && (
          <div ref={foodSourcesRef} className="border-l-4 border-teal-500 pl-4 mt-8">
            <div className="flex items-center justify-between mb-3 flex-wrap gap-2">
              <h3 className="text-xl font-semibold text-gray-800">
                Food Sources for {selectedDisorder.name}
              </h3>
              <button
                onClick={() => {
                  setCheckedFoods(new Set(foodSourceList.map((f) => f.food)));
                  setShopModalOpen(true);
                }}
                className="inline-flex items-center gap-1.5 text-sm px-4 py-2 rounded-lg bg-teal-600 hover:bg-teal-700 text-white font-medium transition-all shadow-sm"
              >
                <svg xmlns="http://www.w3.org/2000/svg" className="h-4 w-4" viewBox="0 0 20 20" fill="currentColor">
                  <path d="M3 1a1 1 0 000 2h1.22l.305 1.222a.997.997 0 00.01.042l1.358 5.43-.893.892C3.74 11.846 4.632 14 6.414 14H15a1 1 0 000-2H6.414l1-1H14a1 1 0 00.894-.553l3-6A1 1 0 0017 3H6.28l-.31-1.243A1 1 0 005 1H3zM16 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0zM6.5 18a1.5 1.5 0 100-3 1.5 1.5 0 000 3z" />
                </svg>
                Shop Ingredients
              </button>
            </div>
            <div className="flex flex-wrap gap-2">
              {foodSourceList.map(({ food, supplements }) => (
                <div
                  key={food}
                  className="flex items-center gap-1.5 bg-teal-50 border border-teal-200 rounded-full pl-3 pr-2 py-1"
                >
                  <span className="text-sm text-teal-900 font-medium">{food}</span>
                  <div className="flex gap-1">
                    {supplements.map((s) => (
                      <span key={s} className="text-[10px] bg-teal-100 text-teal-700 border border-teal-300 rounded-full px-1.5 py-0.5">
                        {s}
                      </span>
                    ))}
                  </div>
                </div>
              ))}
            </div>
          </div>
        )}
      </div>
    </div>

    {/* Shop Ingredients Modal */}
    {shopModalOpen && selectedDisorder && (
      <div
        className="fixed inset-0 z-50 flex items-center justify-center bg-black/40 p-4"
        onClick={(e) => { if (e.target === e.currentTarget) setShopModalOpen(false); }}
      >
        <div className="bg-white rounded-2xl shadow-2xl w-full max-w-md max-h-[80vh] flex flex-col">
          <div className="flex items-center justify-between px-5 py-4 border-b border-gray-200">
            <h2 className="text-lg font-semibold text-gray-900">Select Foods to Shop</h2>
            <button
              onClick={() => setShopModalOpen(false)}
              className="text-gray-400 hover:text-gray-600 transition-colors"
            >
              <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                <path fillRule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clipRule="evenodd" />
              </svg>
            </button>
          </div>

          <div className="flex items-center justify-between px-5 py-2 border-b border-gray-100 bg-gray-50">
            <span className="text-xs text-gray-500">{checkedFoods.size} of {foodSourceList.length} selected</span>
            <div className="flex gap-3">
              <button
                onClick={() => setCheckedFoods(new Set(foodSourceList.map((f) => f.food)))}
                className="text-xs text-teal-600 hover:text-teal-800 font-medium"
              >
                Select all
              </button>
              <button
                onClick={() => setCheckedFoods(new Set())}
                className="text-xs text-gray-400 hover:text-gray-600 font-medium"
              >
                Clear
              </button>
            </div>
          </div>

          <div className="overflow-y-auto flex-1 px-5 py-3 space-y-4">
            {supplementFoodGroups.map(({ supplement, foods }) => {
              const allChecked = foods.every((f) => checkedFoods.has(f));
              const someChecked = foods.some((f) => checkedFoods.has(f));
              return (
                <div key={supplement}>
                  <div className="flex items-center justify-between mb-1">
                    <span className="text-xs font-semibold text-teal-700 uppercase tracking-wide">{supplement}</span>
                    <button
                      onClick={() => {
                        const next = new Set(checkedFoods);
                        if (allChecked) foods.forEach((f) => next.delete(f));
                        else foods.forEach((f) => next.add(f));
                        setCheckedFoods(next);
                      }}
                      className="text-[10px] text-teal-600 hover:text-teal-800 font-medium"
                    >
                      {allChecked ? 'Deselect all' : someChecked ? 'Select rest' : 'Select all'}
                    </button>
                  </div>
                  <div className="space-y-0.5">
                    {foods.map((food) => (
                      <label
                        key={food}
                        className="flex items-center gap-3 py-1.5 cursor-pointer hover:bg-gray-50 -mx-2 px-2 rounded-lg"
                      >
                        <input
                          type="checkbox"
                          checked={checkedFoods.has(food)}
                          onChange={(e) => {
                            const next = new Set(checkedFoods);
                            if (e.target.checked) next.add(food); else next.delete(food);
                            setCheckedFoods(next);
                          }}
                          className="w-4 h-4 rounded border-gray-300 text-teal-600 focus:ring-teal-500 shrink-0"
                        />
                        <span className="text-sm text-gray-800">{food}</span>
                      </label>
                    ))}
                  </div>
                </div>
              );
            })}
          </div>

          <div className="px-5 py-4 border-t border-gray-200 flex flex-col gap-2">
            <button
              disabled={checkedFoods.size === 0}
              onClick={() => {
                const selected = foodSourceList.filter((f) => checkedFoods.has(f.food));
                const bySupplement = new Map<string, string[]>();
                selected.forEach(({ food, supplements }) => {
                  supplements.forEach((s) => {
                    if (!bySupplement.has(s)) bySupplement.set(s, []);
                    bySupplement.get(s)!.push(food);
                  });
                });
                const lines = [`Food Sources for ${selectedDisorder?.name ?? 'Disorder'}`, ''];
                Array.from(bySupplement.entries())
                  .sort(([a], [b]) => a.localeCompare(b))
                  .forEach(([supp, foods]) => {
                    lines.push(supp);
                    foods.sort().forEach((f) => lines.push(`• ${f}`));
                    lines.push('');
                  });
                navigator.clipboard.writeText(lines.join('\n').trimEnd());
              }}
              className="w-full flex items-center justify-center gap-2 py-2.5 rounded-lg border border-gray-300 hover:border-gray-400 disabled:opacity-40 disabled:cursor-not-allowed text-gray-700 text-sm font-medium transition-all"
            >
              Copy list to clipboard
            </button>
            <button
              disabled={checkedFoods.size === 0}
              onClick={() => {
                const selected = foodSourceList.filter((f) => checkedFoods.has(f.food));
                const bySupplement = new Map<string, string[]>();
                selected.forEach(({ food, supplements }) => {
                  supplements.forEach((s) => {
                    if (!bySupplement.has(s)) bySupplement.set(s, []);
                    bySupplement.get(s)!.push(food);
                  });
                });
                const sections = Array.from(bySupplement.entries())
                  .sort(([a], [b]) => a.localeCompare(b))
                  .map(([supp, foods]) => `
                    <section>
                      <h2>${supp}</h2>
                      <ul>${foods.sort().map((f) => `<li>${f}</li>`).join('')}</ul>
                    </section>`)
                  .join('');
                const html = `<!DOCTYPE html><html><head><meta charset="utf-8">
                  <title>Food Sources for ${selectedDisorder?.name ?? ''}</title>
                  <style>
                    body{font-family:Georgia,serif;max-width:640px;margin:40px auto;color:#111;line-height:1.6}
                    h1{color:#0f766e;font-size:1.4rem;margin-bottom:.2rem}
                    p.sub{color:#6b7280;margin:0 0 2rem;font-size:.85rem}
                    h2{font-size:1rem;font-weight:700;color:#374151;border-bottom:1px solid #e5e7eb;padding-bottom:.2rem;margin:1.5rem 0 .5rem}
                    ul{margin:0;padding-left:1.4rem}
                    li{margin:.2rem 0}
                    @media print{body{margin:20px}}
                  </style>
                </head><body>
                  <h1>Food Sources for ${selectedDisorder?.name ?? ''}</h1>
                  <p class="sub">From supplement prescriptions · ${new Date().toLocaleDateString()}</p>
                  ${sections}
                </body></html>`;
                const win = window.open('', '_blank');
                win?.document.write(html);
                win?.document.close();
                win?.print();
              }}
              className="w-full flex items-center justify-center gap-2 py-2.5 rounded-lg bg-teal-600 hover:bg-teal-700 disabled:opacity-40 disabled:cursor-not-allowed text-white font-semibold text-sm transition-all"
            >
              <svg xmlns="http://www.w3.org/2000/svg" className="h-4 w-4" viewBox="0 0 20 20" fill="currentColor">
                <path fillRule="evenodd" d="M5 4v3H4a2 2 0 00-2 2v3a2 2 0 002 2h1v2a2 2 0 002 2h6a2 2 0 002-2v-2h1a2 2 0 002-2V9a2 2 0 00-2-2h-1V4a2 2 0 00-2-2H7a2 2 0 00-2 2zm8 0H7v3h6V4zm0 8H7v4h6v-4z" clipRule="evenodd" />
              </svg>
              Print shopping list
            </button>
          </div>
        </div>
      </div>
    )}
    </>
  );
}
