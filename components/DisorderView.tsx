'use client';

import { useState, useEffect } from 'react';
import { supabase } from '@/lib/supabase';
import { TextPageLinks } from './TextPageLinks';
import type {
  Disorder,
  DisorderNote,
  PrimaryAction,
  Herb,
  DisorderPrescription,
  PrescriptionHerb
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
    }
  >;
}

interface DisorderViewProps {
  bodySystemId?: number;
  onHerbClick?: (herbId: number) => void;
  onActionClick?: (actionId: number) => void;
}

export function DisorderView({ bodySystemId, onHerbClick, onActionClick }: DisorderViewProps) {
  const [disorders, setDisorders] = useState<DisorderData[]>([]);
  const [selectedDisorder, setSelectedDisorder] = useState<DisorderData | null>(null);
  const [loading, setLoading] = useState(true);
  const [imageManifest, setImageManifest] = useState<Record<string, number>>({});

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
      const { data, error } = await supabase
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
            )
          )
        `)
        .eq('body_system_id', bodySystemId)
        .order('sort_order');

      if (error) throw error;

      // Sort nested arrays by sort_order
      const sortedData = (data || []).map((disorder) => ({
        ...disorder,
        disorder_notes: disorder.disorder_notes.sort((a: DisorderNote, b: DisorderNote) => a.sort_order - b.sort_order),
        disorder_actions_indicated: disorder.disorder_actions_indicated.sort((a: any, b: any) => a.sort_order - b.sort_order),
        disorder_action_herbs: disorder.disorder_action_herbs.sort((a: any, b: any) => a.sort_order - b.sort_order),
        disorder_specific_remedies: disorder.disorder_specific_remedies.sort((a: any, b: any) => a.sort_order - b.sort_order),
        disorder_prescriptions: disorder.disorder_prescriptions
          .sort((a: DisorderPrescription, b: DisorderPrescription) => a.sort_order - b.sort_order)
          .map((prescription: any) => ({
            ...prescription,
            prescription_herbs: prescription.prescription_herbs.sort((a: PrescriptionHerb, b: PrescriptionHerb) => a.sort_order - b.sort_order),
          })),
      }));

      setDisorders(sortedData);
      if (sortedData.length > 0 && !selectedDisorder) {
        setSelectedDisorder(sortedData[0]);
      }
    } catch (error) {
      console.error('Error fetching disorders:', error);
    } finally {
      setLoading(false);
    }
  }

  // Group action herbs by primary action
  const groupActionHerbs = (actionHerbs: DisorderData['disorder_action_herbs']) => {
    const grouped: Record<number, {
      action: PrimaryAction;
      herbs: Array<{ herb: Herb; note: string | null; sort_order: number }>;
    }> = {};

    actionHerbs.forEach((item) => {
      if (!grouped[item.primary_actions.id]) {
        grouped[item.primary_actions.id] = {
          action: item.primary_actions,
          herbs: [],
        };
      }
      grouped[item.primary_actions.id].herbs.push({
        herb: item.herbs,
        note: item.note,
        sort_order: item.sort_order,
      });
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
        <label className="block text-sm font-medium text-gray-700 mb-2">
          Select Disorder
        </label>
        <select
          value={selectedDisorder?.id || ''}
          onChange={(e) => {
            const disorder = disorders.find((d) => d.id === parseInt(e.target.value));
            setSelectedDisorder(disorder || null);
          }}
          className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-transparent"
        >
          <option value="">Choose a disorder...</option>
          {disorders
            .slice()
            .sort((a, b) => {
              // Keep "Overall" at the top
              if (a.name === 'Overall') return -1;
              if (b.name === 'Overall') return 1;
              return a.name.localeCompare(b.name);
            })
            .map((disorder) => (
              <option key={disorder.id} value={disorder.id}>
                {disorder.name}
              </option>
            ))}
        </select>
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
            {selectedDisorder.disorder_notes.length > 0 && (
              <div className="bg-green-50 border border-green-200 border-l-4 border-l-green-600 rounded-lg p-4">
                <ul className="list-disc list-inside space-y-2">
                  {selectedDisorder.disorder_notes.map((note) => (
                    <li key={note.id} className="text-gray-700">
                      {note.note_text}
                    </li>
                  ))}
                </ul>
              </div>
            )}

            {/* Actions Indicated */}
            {selectedDisorder.disorder_actions_indicated.length > 0 && (
              <div className="border-l-4 border-blue-500 pl-4">
                <h3 className="text-xl font-semibold text-gray-800 mb-3">
                  Actions Indicated
                </h3>
                <div className="space-y-2">
                  {selectedDisorder.disorder_actions_indicated
                    .sort((a, b) => a.primary_actions.name.localeCompare(b.primary_actions.name))
                    .map((item) => (
                      <button
                        key={item.id}
                        onClick={() => onActionClick?.(item.primary_actions.id)}
                        className="w-full text-left border border-gray-200 rounded-lg p-3 hover:shadow-md hover:scale-[1.01] transition-all"
                      >
                        <div className="font-semibold text-green-700 mb-1">
                          {item.primary_actions.name}
                        </div>
                        <p className="text-sm text-gray-700">{item.description}</p>
                      </button>
                    ))}
                </div>
              </div>
            )}

            {/* Action Herbs */}
            {selectedDisorder.disorder_action_herbs.length > 0 && (
              <div className="border-l-4 border-green-500 pl-4">
                <h3 className="text-xl font-semibold text-gray-800 mb-3">
                  Action Herbs
                </h3>
                <div className="space-y-4">
                  {groupActionHerbs(selectedDisorder.disorder_action_herbs).map((group) => (
                    <div key={group.action.id}>
                      <button
                        onClick={() => onActionClick?.(group.action.id)}
                        className="text-lg font-semibold text-green-700 mb-2 hover:underline"
                      >
                        {group.action.name}
                      </button>
                      <div className="flex flex-wrap gap-2">
                        {group.herbs.map((item, idx) => (
                          <button
                            key={idx}
                            onClick={() => onHerbClick?.(item.herb.id)}
                            className="inline-flex flex-col items-start bg-green-50 hover:bg-green-100 border border-green-200 rounded-lg px-3 py-2 transition-all hover:shadow-md"
                          >
                            <span className="font-medium text-gray-900">
                              {item.herb.common_name}
                            </span>
                            <span className="text-xs italic text-gray-600">
                              {item.herb.latin_name}
                            </span>
                            {item.note && (
                              <span className="text-xs text-gray-500 mt-1">
                                {item.note}
                              </span>
                            )}
                          </button>
                        ))}
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            )}

            {/* Specific Remedies */}
            {selectedDisorder.disorder_specific_remedies.length > 0 && (
              <div className="border-l-4 border-amber-500 pl-4">
                <h3 className="text-xl font-semibold text-gray-800 mb-3">
                  Specific Remedies
                </h3>
                <div className="space-y-3">
                  {selectedDisorder.disorder_specific_remedies.map((item) => (
                    <button
                      key={item.id}
                      onClick={() => onHerbClick?.(item.herbs.id)}
                      className="w-full text-left border border-green-300 bg-green-50 rounded-lg p-3 hover:shadow-md hover:scale-[1.01] transition-all"
                    >
                      <div className="font-semibold text-gray-900">
                        {item.herbs.common_name}
                      </div>
                      <div className="text-sm italic text-gray-600 mb-1">
                        {item.herbs.latin_name}
                      </div>
                      <p className="text-sm text-gray-700">{item.description}</p>
                    </button>
                  ))}
                </div>
              </div>
            )}

            {/* Prescriptions */}
            {selectedDisorder.disorder_prescriptions.length > 0 && (
              <div className="border-l-4 border-purple-500 pl-4">
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
                                {prescHerb.herbs.common_name}
                              </span>
                              <span className="text-xs text-gray-500">
                                {prescHerb.parts}
                              </span>
                            </div>
                            <span className="text-xs italic text-gray-600">
                              {prescHerb.herbs.latin_name}
                            </span>
                            {prescHerb.note && (
                              <span className="text-xs text-gray-500 mt-0.5">
                                ({prescHerb.note})
                              </span>
                            )}
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
        ) : (
          <div className="flex items-center justify-center py-12 text-gray-400">
            <p className="text-lg">Select a disorder to view details</p>
          </div>
        )}
      </div>
    </div>
  );
}
