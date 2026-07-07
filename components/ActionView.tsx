'use client';

import { useState, useEffect, useRef } from 'react';
import { supabase } from '@/lib/supabase';
import type { PrimaryAction, Herb, BodySystem, StrengthLevel } from '@/types/database';

interface ActionDescription {
  id: number;
  description: string;
  sort_order: number;
}

interface ActionData extends PrimaryAction {
  herb_primary_actions: Array<{
    herbs: Herb;
    body_systems: BodySystem | null;
    relative_strength: StrengthLevel | null;
  }>;
  action_descriptions: ActionDescription[];
}

interface ActionViewProps {
  onHerbClick?: (herbId: number) => void;
  selectedActionId?: number | null;
  onActionIdChange?: (actionId: number | null) => void;
}

export function ActionView({ onHerbClick, selectedActionId, onActionIdChange }: ActionViewProps) {
  const [actions, setActions] = useState<ActionData[]>([]);
  const [selectedAction, setSelectedAction] = useState<ActionData | null>(null);
  const [searchTerm, setSearchTerm] = useState('');
  const [loading, setLoading] = useState(true);
  const [agingHerbIds, setAgingHerbIds] = useState<Set<number>>(new Set());
  const actionRefs = useRef<Map<number, HTMLButtonElement>>(new Map());
  const systemRefs = useRef<Map<string, HTMLDivElement>>(new Map());

  useEffect(() => {
    fetchActions();
  }, []);

  // Sync with external selectedActionId prop
  useEffect(() => {
    if (selectedActionId !== undefined && selectedActionId !== null && actions.length > 0) {
      const action = actions.find((a) => a.id === selectedActionId);
      if (action) {
        setSelectedAction(action);
        // Scroll the selected action into view
        setTimeout(() => {
          const actionElement = actionRefs.current.get(selectedActionId);
          if (actionElement) {
            actionElement.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
          }
        }, 100);
      }
    }
  }, [selectedActionId, actions]);

  async function fetchActions() {
    try {
      const [actionsResult, agingResult] = await Promise.all([
        supabase
          .from('primary_actions')
          .select(`
            *,
            herb_primary_actions (
              herbs (*),
              body_systems (*),
              relative_strength
            ),
            action_descriptions (
              id,
              description,
              sort_order
            )
          `)
          .order('name'),
        supabase.from('aging_herbs').select('herb_id'),
      ]);

      if (actionsResult.error) throw actionsResult.error;
      setActions(actionsResult.data || []);

      if (agingResult.data) {
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        setAgingHerbIds(new Set(agingResult.data.map((r: any) => r.herb_id)));
      }
    } catch (error) {
      console.error('Error fetching actions:', error);
    } finally {
      setLoading(false);
    }
  }

  const filteredActions = actions.filter((action) =>
    action.herb_primary_actions.length > 0 &&
    action.name.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const groupByBodySystem = (actionData: ActionData) => {
    const grouped = new Map<string, Array<{ herb: Herb; strength: StrengthLevel | null }>>();

    actionData.herb_primary_actions.forEach((item) => {
      const systemName = item.body_systems?.name || 'General (No specific system)';
      if (!grouped.has(systemName)) {
        grouped.set(systemName, []);
      }
      grouped.get(systemName)!.push({
        herb: item.herbs,
        strength: item.relative_strength,
      });
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
      case 'mild':       return 'bg-yellow-100 text-yellow-700';
      case 'strong':     return 'bg-orange-100 text-orange-700';
      case 'very_strong': return 'bg-red-100 text-red-700';
      default:           return null;
    }
  };

  const getEnergeticEmojis = (herb: Herb) => {
    const emojis: string[] = [];
    if (herb.temperature === 'warming') emojis.push('🔥');
    if (herb.temperature === 'cooling') emojis.push('❄️');
    if (herb.moisture === 'moistening') emojis.push('💧');
    if (herb.moisture === 'drying')     emojis.push('🌵');
    if (herb.tone === 'toning')         emojis.push('⚡');
    if (herb.tone === 'relaxing')       emojis.push('🌊');
    return emojis.join('');
  };

  if (loading) {
    return <div className="text-center py-8">Loading actions...</div>;
  }

  return (
    <div className="grid grid-cols-1 lg:grid-cols-3 gap-6 items-start">
      {/* Action List */}
      <div className="lg:col-span-1 bg-white rounded-lg shadow-lg p-6">
        <input
          type="text"
          placeholder="Search actions..."
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          className="w-full px-4 py-2 border border-gray-300 rounded-lg mb-4 focus:ring-2 focus:ring-green-500 focus:border-transparent"
        />

        <div className="space-y-2 max-h-[70vh] overflow-y-auto">
          {filteredActions.map((action) => (
            <button
              key={action.id}
              ref={(el) => {
                if (el) {
                  actionRefs.current.set(action.id, el);
                } else {
                  actionRefs.current.delete(action.id);
                }
              }}
              onClick={() => {
                setSelectedAction(action);
                onActionIdChange?.(action.id);
              }}
              className={`w-full text-left p-3 rounded-lg transition-all ${
                selectedAction?.id === action.id
                  ? 'bg-green-100 border-2 border-green-500'
                  : 'bg-gray-50 hover:bg-gray-100'
              }`}
            >
              <div className="font-semibold text-gray-900">{action.name}</div>
              <div className="text-xs text-gray-500 mt-1">
                {action.herb_primary_actions.length} herbs
              </div>
            </button>
          ))}
        </div>
      </div>

      {/* Action Details */}
      <div className="lg:col-span-2 bg-white rounded-lg shadow-lg p-6">
        {selectedAction ? (
          <div>
            <h2 className="text-3xl font-bold text-green-800 mb-4">
              {selectedAction.name}
            </h2>

            {/* Action Descriptions as bullet points */}
            {selectedAction.action_descriptions && selectedAction.action_descriptions.length > 0 && (
              <div className="mb-6 bg-green-50 dark:bg-green-900/20 rounded-lg p-4 border-l-4 border-green-600">
                <ul className="list-disc list-inside space-y-2 text-gray-700 dark:text-gray-300">
                  {selectedAction.action_descriptions
                    .sort((a, b) => a.sort_order - b.sort_order)
                    .map((desc) => (
                      <li key={desc.id} className="leading-relaxed">
                        {desc.description}
                      </li>
                    ))}
                </ul>
              </div>
            )}

            {selectedAction.herb_primary_actions.length > 0 ? (() => {
              const sortedSystems = Array.from(groupByBodySystem(selectedAction))
                .sort(([a], [b]) => {
                  if (a.startsWith('General')) return 1;
                  if (b.startsWith('General')) return -1;
                  return a.localeCompare(b);
                });
              return (
              <>
                {sortedSystems.length > 1 && (
                  <div className="flex flex-wrap gap-1.5 mb-6 text-xs">
                    {sortedSystems.map(([systemName]) => (
                      <button
                        key={systemName}
                        onClick={() => systemRefs.current.get(systemName)?.scrollIntoView({ behavior: 'smooth', block: 'start' })}
                        className="px-2.5 py-1 rounded-full border border-gray-300 text-gray-500 hover:border-green-500 hover:text-green-700 transition-colors"
                      >
                        {systemName}
                      </button>
                    ))}
                  </div>
                )}
                <div className="space-y-6">
                {sortedSystems.map(([systemName, herbs]) => (
                    <div key={systemName} className="border-l-4 border-green-500 pl-4" ref={(el) => { if (el) systemRefs.current.set(systemName, el); else systemRefs.current.delete(systemName); }}>
                      <h3 className="text-xl font-semibold text-gray-800 mb-3">
                        {systemName}
                      </h3>
                      <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                        {herbs
                          .sort((a, b) => a.herb.common_name.localeCompare(b.herb.common_name))
                          .map((item, idx) => (
                          <button
                            key={idx}
                            onClick={() => onHerbClick?.(item.herb.id)}
                            className={`border rounded-lg py-1.5 px-3 hover:shadow-md hover:scale-105 transition-all cursor-pointer text-left ${getTemperatureCard(item.herb)}`}
                          >
                            <div className="flex items-center justify-between gap-1 mb-1">
                              <span className="font-medium">{item.herb.common_name}</span>
                              <div className="flex items-center gap-1 shrink-0">
                                <span className="text-sm leading-none">{getEnergeticEmojis(item.herb)}</span>
                                {selectedAction.name === 'Tonic' && agingHerbIds.has(item.herb.id) && (
                                  <span className="text-base leading-none" title="Recommended for elders">🧓</span>
                                )}
                              </div>
                            </div>
                            <div className="flex items-center justify-between gap-1">
                              <span className="text-sm italic text-gray-600">{item.herb.latin_name}</span>
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
                  )
                )}
                </div>
              </>
              );
            })() : (
              <p className="text-gray-500 italic">
                No herbs recorded for this action.
              </p>
            )}
          </div>
        ) : (
          <div className="flex items-center justify-center h-full text-gray-400">
            <p className="text-lg">Select an action to view herbs</p>
          </div>
        )}
      </div>
    </div>
  );
}
