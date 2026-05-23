'use client';

import { useState, useEffect, useRef } from 'react';
import { supabase } from '@/lib/supabase';
import type { Herb, PrimaryAction, SecondaryAction, BodySystem, StrengthLevel, Disorder } from '@/types/database';

interface HerbData extends Herb {
  herb_primary_actions: Array<{
    primary_actions: PrimaryAction;
    body_systems: BodySystem | null;
    body_system_note: string | null;
    relative_strength: StrengthLevel | null;
  }>;
  disorder_action_herbs?: Array<{
    disorders: Disorder & {
      body_systems: BodySystem;
    };
    primary_actions: PrimaryAction;
  }>;
  disorder_specific_remedies?: Array<{
    disorders: Disorder & {
      body_systems: BodySystem;
    };
    description: string;
  }>;
  herb_secondary_actions: Array<{
    secondary_actions: SecondaryAction;
  }>;
}

interface HerbViewProps {
  selectedHerbId?: number | null;
  onHerbIdChange?: (herbId: number | null) => void;
  onActionClick?: (actionId: number) => void;
  onActionNameClick?: (name: string) => void;
}

export function HerbView({ selectedHerbId, onHerbIdChange, onActionClick, onActionNameClick }: HerbViewProps) {
  const [herbs, setHerbs] = useState<HerbData[]>([]);
  const [selectedHerb, setSelectedHerb] = useState<HerbData | null>(null);
  const [searchTerm, setSearchTerm] = useState('');
  const [loading, setLoading] = useState(true);
  const herbRefs = useRef<Map<number, HTMLButtonElement>>(new Map());

  useEffect(() => {
    fetchHerbs();
  }, []);

  // Sync with external selectedHerbId prop
  useEffect(() => {
    if (selectedHerbId !== undefined && selectedHerbId !== null && herbs.length > 0) {
      const herb = herbs.find((h) => h.id === selectedHerbId);
      if (herb) {
        setSelectedHerb(herb);
        // Scroll the selected herb into view
        setTimeout(() => {
          const herbElement = herbRefs.current.get(selectedHerbId);
          if (herbElement) {
            herbElement.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
          }
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
            disorders (
              *,
              body_systems (*)
            ),
            primary_actions (*)
          ),
          disorder_specific_remedies (
            disorders (
              *,
              body_systems (*)
            ),
            description
          ),
          herb_secondary_actions (
            secondary_actions (*)
          )
        `)
        .order('common_name');

      if (error) throw error;
      setHerbs(data || []);
    } catch (error) {
      console.error('Error fetching herbs:', error);
    } finally {
      setLoading(false);
    }
  }

  const filteredHerbs = herbs.filter(
    (herb) =>
      herb.common_name.toLowerCase().includes(searchTerm.toLowerCase()) ||
      herb.latin_name.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const getStrengthColor = (strength: StrengthLevel | null) => {
    switch (strength) {
      case 'mild':
        return 'bg-yellow-100 text-yellow-800';
      case 'strong':
        return 'bg-orange-100 text-orange-800';
      case 'very_strong':
        return 'bg-red-100 text-red-800';
      default:
        return 'bg-gray-100 text-gray-800';
    }
  };

  if (loading) {
    return <div className="text-center py-8">Loading herbs...</div>;
  }

  return (
    <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
      {/* Herb List */}
      <div className="lg:col-span-1 bg-white rounded-lg shadow-lg p-6">
        <input
          type="text"
          placeholder="Search herbs..."
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          className="w-full px-4 py-2 border border-gray-300 rounded-lg mb-4 focus:ring-2 focus:ring-green-500 focus:border-transparent"
        />

        <div className="space-y-2 max-h-[70vh] overflow-y-auto">
          {filteredHerbs.map((herb) => (
            <button
              key={herb.id}
              ref={(el) => {
                if (el) {
                  herbRefs.current.set(herb.id, el);
                } else {
                  herbRefs.current.delete(herb.id);
                }
              }}
              onClick={() => {
                setSelectedHerb(herb);
                onHerbIdChange?.(herb.id);
              }}
              className={`w-full text-left p-3 rounded-lg border transition-all ${
                selectedHerb?.id === herb.id
                  ? 'ring-2 ring-green-500 ring-offset-1'
                  : ''
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
      <div className="lg:col-span-2 bg-white rounded-lg shadow-lg p-6">
        {selectedHerb ? (
          <div>
            <h2 className="text-3xl font-bold text-green-800 mb-2">
              {selectedHerb.common_name}
            </h2>
            <p className="text-xl italic text-gray-600 mb-6">
              {selectedHerb.latin_name}
            </p>

            {/* Primary Actions & Body Systems */}
            <div className="mb-6">
              <h3 className="text-xl font-semibold text-gray-800 mb-4">
                Primary Actions & Body Systems
              </h3>

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
                          <h4 className="text-lg font-semibold text-green-700">
                            {action.primary_actions.name}
                          </h4>
                          {action.body_systems && (
                            <p className="text-sm text-gray-600">
                              {action.body_systems.name}
                            </p>
                          )}
                        </div>
                        {action.relative_strength && (
                          <span
                            className={`px-3 py-1 rounded-full text-xs font-medium ${getStrengthColor(
                              action.relative_strength
                            )}`}
                          >
                            {action.relative_strength.replace('_', ' ')}
                          </span>
                        )}
                      </div>
                      {action.body_system_note && (
                        <p className="text-sm text-gray-700 mt-2">
                          {action.body_system_note}
                        </p>
                      )}
                    </button>
                  ))}
                </div>
              ) : (
                <p className="text-gray-500 italic">
                  No primary actions recorded for this herb.
                </p>
              )}
            </div>

            {/* Secondary Actions */}
            {selectedHerb.herb_secondary_actions.length > 0 && (
              <div className="mb-6">
                <h3 className="text-xl font-semibold text-gray-800 mb-3">
                  Secondary Actions
                </h3>
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

            {/* Disorders Section */}
            {((selectedHerb.disorder_action_herbs?.length ?? 0) > 0 ||
              (selectedHerb.disorder_specific_remedies?.length ?? 0) > 0) && (
              <div>
                <h3 className="text-xl font-semibold text-gray-800 mb-4">
                  Used for Disorders
                </h3>

                {/* Group disorders by disorder name */}
                <div className="space-y-4">
                  {(() => {
                    // Combine all disorders
                    const disorderMap = new Map<number, {
                      disorder: Disorder & { body_systems: BodySystem };
                      actions: PrimaryAction[];
                      specificRemedy?: string;
                    }>();

                    selectedHerb.disorder_action_herbs?.forEach((item) => {
                      if (!disorderMap.has(item.disorders.id)) {
                        disorderMap.set(item.disorders.id, {
                          disorder: item.disorders,
                          actions: [],
                        });
                      }
                      disorderMap.get(item.disorders.id)!.actions.push(item.primary_actions);
                    });

                    selectedHerb.disorder_specific_remedies?.forEach((item) => {
                      if (!disorderMap.has(item.disorders.id)) {
                        disorderMap.set(item.disorders.id, {
                          disorder: item.disorders,
                          actions: [],
                          specificRemedy: item.description,
                        });
                      } else {
                        disorderMap.get(item.disorders.id)!.specificRemedy = item.description;
                      }
                    });

                    return Array.from(disorderMap.values()).map((item) => (
                      <div
                        key={item.disorder.id}
                        className="border border-gray-200 rounded-lg p-4 bg-gray-50"
                      >
                        <div className="font-semibold text-lg text-gray-900 mb-1">
                          {item.disorder.name}
                        </div>
                        <div className="text-sm text-gray-600 mb-3">
                          {item.disorder.body_systems.name}
                        </div>

                        {item.specificRemedy && (
                          <div className="mb-3 p-2 bg-green-50 border border-green-200 rounded">
                            <span className="text-xs font-semibold text-green-800">
                              SPECIFIC REMEDY
                            </span>
                            <p className="text-sm text-gray-700 mt-1">
                              {item.specificRemedy}
                            </p>
                          </div>
                        )}

                        {item.actions.length > 0 && (
                          <div>
                            <span className="text-sm font-medium text-gray-700">
                              Actions:
                            </span>
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
    </div>
  );
}
