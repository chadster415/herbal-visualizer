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
  const actionRefs = useRef<Map<number, HTMLButtonElement>>(new Map());

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
      const { data, error } = await supabase
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
        .order('name');

      if (error) throw error;
      setActions(data || []);
    } catch (error) {
      console.error('Error fetching actions:', error);
    } finally {
      setLoading(false);
    }
  }

  const filteredActions = actions.filter((action) =>
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

  const getStrengthColor = (strength: StrengthLevel | null) => {
    switch (strength) {
      case 'mild':
        return 'bg-yellow-100 text-yellow-800 border-yellow-300';
      case 'strong':
        return 'bg-orange-100 text-orange-800 border-orange-300';
      case 'very_strong':
        return 'bg-red-100 text-red-800 border-red-300';
      default:
        return 'bg-gray-100 text-gray-800 border-gray-300';
    }
  };

  if (loading) {
    return <div className="text-center py-8">Loading actions...</div>;
  }

  return (
    <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
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

            {selectedAction.herb_primary_actions.length > 0 ? (
              <div className="space-y-6">
                {Array.from(groupByBodySystem(selectedAction))
                  .sort(([a], [b]) => {
                    // Keep "General (No specific system)" at the bottom
                    if (a.startsWith('General')) return 1;
                    if (b.startsWith('General')) return -1;
                    // Otherwise sort alphabetically
                    return a.localeCompare(b);
                  })
                  .map(([systemName, herbs]) => (
                    <div key={systemName} className="border-l-4 border-green-500 pl-4">
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
                            className={`border rounded-lg p-3 ${getStrengthColor(
                              item.strength
                            )} hover:shadow-md hover:scale-105 transition-all cursor-pointer text-left`}
                          >
                            <div className="font-medium">{item.herb.common_name}</div>
                            <div className="text-sm italic">{item.herb.latin_name}</div>
                            {item.strength && (
                              <div className="text-xs mt-1 font-semibold">
                                {item.strength.replace('_', ' ')}
                              </div>
                            )}
                          </button>
                        ))}
                      </div>
                    </div>
                  )
                )}
              </div>
            ) : (
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
