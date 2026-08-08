'use client';

import { useState, useEffect, useRef } from 'react';

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
    herbs: Herb;
  }>;
  disorder_prescriptions: Array<
    DisorderPrescription & {
      prescription_herbs: Array<
        PrescriptionHerb & {
          herbs: Herb;
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

interface DisorderViewProps {
  bodySystemId?: number;
  onHerbClick?: (herbId: number) => void;
  onActionClick?: (actionId: number) => void;
  onSupplementClick?: (supplementId: number) => void;
  selectedDisorderId?: number | null;
  onDisorderChange?: (id: number | null) => void;
}

export function DisorderView({ bodySystemId, onHerbClick, onActionClick, onSupplementClick, selectedDisorderId, onDisorderChange }: DisorderViewProps) {
  const [disorders, setDisorders] = useState<DisorderData[]>([]);
  const [selectedDisorder, setSelectedDisorder] = useState<DisorderData | null>(null);
  const [loading, setLoading] = useState(true);
  const [disorderListOpen, setDisorderListOpen] = useState(true);
  const [imageManifest, setImageManifest] = useState<Record<string, number>>({});
  const [strengthMap, setStrengthMap] = useState<Map<number, string>>(new Map());
  const actionsRef = useRef<HTMLDivElement | null>(null);
  const remediesRef = useRef<HTMLDivElement | null>(null);
  const prescriptionsRef = useRef<HTMLDivElement | null>(null);

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
              herbs (*)
            ),
            disorder_prescriptions (
              *,
              prescription_herbs (
                *,
                herbs (*),
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
        disorder_specific_remedies: disorder.disorder_specific_remedies.sort((a: any, b: any) => a.herbs.common_name.localeCompare(b.herbs.common_name)),
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
    <div className="space-y-4">
      {/* Disorder Selector */}
      <div>
        {selectedDisorder && (
          <div className="flex items-center gap-2 mb-2 sm:hidden">
            <span className="px-3 py-1.5 rounded-lg border text-sm font-medium bg-green-600 text-white border-green-600">
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
                      ? 'bg-green-600 text-white border-green-600'
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
        {selectedDisorder ? (
          <div className="space-y-8">
            <h2 className="text-3xl font-bold text-green-800 mb-2">
              {selectedDisorder.name}
            </h2>
            <TextPageLinks
              disorderName={selectedDisorder.name}
              pageCount={imageManifest[selectedDisorder.name] ?? 0}
            />

            {/* Notes */}
            {selectedDisorder.disorder_notes.filter((n) => n.section === 'general').length > 0 && (
              <div className="bg-green-50 border border-green-200 border-l-4 border-l-green-600 rounded-lg p-4">
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

            {/* Section nav */}
            {(() => {
              const pills = [
                ...((selectedDisorder.disorder_actions_indicated.length > 0 || selectedDisorder.disorder_action_herbs.length > 0) ? [{ label: 'Actions Indicated', ref: actionsRef }] : []),
                ...(selectedDisorder.disorder_specific_remedies.length > 0 ? [{ label: 'Specific Remedies', ref: remediesRef }] : []),
                ...(selectedDisorder.disorder_prescriptions.length > 0 ? [{ label: 'Prescriptions', ref: prescriptionsRef }] : []),
              ];
              if (pills.length < 2) return null;
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
                        <EnergeticEmojis temperature={h.herbs.temperature} moisture={h.herbs.moisture} tone={h.herbs.tone} className="text-sm leading-none shrink-0" />
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
                        <EnergeticEmojis temperature={item.herbs.temperature} moisture={item.herbs.moisture} tone={item.herbs.tone} className="text-sm leading-none shrink-0" />
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
                            <div className="flex items-baseline gap-2 mb-1">
                              <span className={`font-medium ${sc.name}`}>{ps.supplements.name}</span>
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
      </div>
    </div>
  );
}
