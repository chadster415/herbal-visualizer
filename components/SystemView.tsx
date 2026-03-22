'use client';

import { useState, useEffect } from 'react';
import { supabase } from '@/lib/supabase';
import type { BodySystem, Herb, PrimaryAction, StrengthLevel } from '@/types/database';

interface SystemData extends BodySystem {
  herb_primary_actions: Array<{
    herbs: Herb;
    primary_actions: PrimaryAction;
    relative_strength: StrengthLevel | null;
  }>;
}

export function SystemView() {
  const [systems, setSystems] = useState<SystemData[]>([]);
  const [selectedSystem, setSelectedSystem] = useState<SystemData | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchSystems();
  }, []);

  async function fetchSystems() {
    try {
      const { data, error } = await supabase
        .from('body_systems')
        .select(`
          *,
          herb_primary_actions (
            herbs (*),
            primary_actions (*),
            relative_strength
          )
        `)
        .order('name');

      if (error) throw error;
      setSystems(data || []);
    } catch (error) {
      console.error('Error fetching systems:', error);
    } finally {
      setLoading(false);
    }
  }

  const groupByAction = (systemData: SystemData) => {
    const grouped = new Map<
      string,
      Array<{ herb: Herb; strength: StrengthLevel | null }>
    >();

    systemData.herb_primary_actions.forEach((item) => {
      const actionName = item.primary_actions.name;
      if (!grouped.has(actionName)) {
        grouped.set(actionName, []);
      }
      grouped.get(actionName)!.push({
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
    return <div className="text-center py-8">Loading body systems...</div>;
  }

  return (
    <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
      {/* System List */}
      <div className="lg:col-span-1 bg-white rounded-lg shadow-lg p-6">
        <h3 className="text-lg font-semibold text-gray-800 mb-4">Body Systems</h3>

        <div className="space-y-2">
          {systems.map((system) => (
            <button
              key={system.id}
              onClick={() => setSelectedSystem(system)}
              className={`w-full text-left p-3 rounded-lg transition-all ${
                selectedSystem?.id === system.id
                  ? 'bg-green-100 border-2 border-green-500'
                  : 'bg-gray-50 hover:bg-gray-100'
              }`}
            >
              <div className="font-semibold text-gray-900">{system.name}</div>
              <div className="text-xs text-gray-500 mt-1">
                {system.herb_primary_actions.length} herbs
              </div>
            </button>
          ))}
        </div>
      </div>

      {/* System Details */}
      <div className="lg:col-span-2 bg-white rounded-lg shadow-lg p-6 max-h-[80vh] overflow-y-auto">
        {selectedSystem ? (
          <div>
            <h2 className="text-3xl font-bold text-green-800 mb-6">
              {selectedSystem.name} System
            </h2>

            {selectedSystem.herb_primary_actions.length > 0 ? (
              <div className="space-y-6">
                {Array.from(groupByAction(selectedSystem)).map(
                  ([actionName, herbs]) => (
                    <div
                      key={actionName}
                      className="border-l-4 border-blue-500 pl-4 pb-4"
                    >
                      <h3 className="text-xl font-semibold text-gray-800 mb-3">
                        {actionName}
                      </h3>
                      <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-3">
                        {herbs.map((item, idx) => (
                          <div
                            key={idx}
                            className={`border rounded-lg p-3 transition-shadow hover:shadow-md ${getStrengthColor(
                              item.strength
                            )}`}
                          >
                            <div className="font-medium text-sm">
                              {item.herb.common_name}
                            </div>
                            <div className="text-xs italic text-gray-600">
                              {item.herb.latin_name}
                            </div>
                            {item.strength && (
                              <div className="text-xs mt-1 font-semibold">
                                {item.strength.replace('_', ' ')}
                              </div>
                            )}
                          </div>
                        ))}
                      </div>
                    </div>
                  )
                )}
              </div>
            ) : (
              <p className="text-gray-500 italic">
                No herbs recorded for this body system.
              </p>
            )}
          </div>
        ) : (
          <div className="flex items-center justify-center h-full text-gray-400">
            <p className="text-lg">Select a body system to view herbs and actions</p>
          </div>
        )}
      </div>
    </div>
  );
}
