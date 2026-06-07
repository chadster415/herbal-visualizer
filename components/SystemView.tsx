'use client';

import { useState, useEffect } from 'react';
import { supabase } from '@/lib/supabase';
import type { BodySystem, Herb, PrimaryAction, StrengthLevel } from '@/types/database';
import { DisorderView } from './DisorderView';

interface SystemData extends BodySystem {
  herb_primary_actions: Array<{
    herbs: Herb;
    primary_actions: PrimaryAction;
    relative_strength: StrengthLevel | null;
  }>;
  disorder_count?: number;
}

interface SystemViewProps {
  onHerbClick?: (herbId: number) => void;
  onActionClick?: (actionId: number) => void;
  selectedSystemId?: number | null;
  onSystemChange?: (id: number | null) => void;
  selectedDisorderId?: number | null;
  onDisorderChange?: (id: number | null) => void;
}

export function SystemView({ onHerbClick, onActionClick, selectedSystemId, onSystemChange, selectedDisorderId, onDisorderChange }: SystemViewProps) {
  const [systems, setSystems] = useState<SystemData[]>([]);
  const [selectedSystem, setSelectedSystem] = useState<SystemData | null>(null);
  const [loading, setLoading] = useState(true);
  const [viewMode, setViewMode] = useState<'actions' | 'disorders'>('disorders');

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

      // Get disorder counts for each system
      const { data: disorderCounts } = await supabase
        .from('disorders')
        .select('body_system_id');

      const countMap = new Map<number, number>();
      disorderCounts?.forEach((d) => {
        countMap.set(d.body_system_id, (countMap.get(d.body_system_id) || 0) + 1);
      });

      const systemsWithCounts = (data || []).map((system) => ({
        ...system,
        disorder_count: countMap.get(system.id) || 0,
      }));

      setSystems(systemsWithCounts);

      // Restore selection when navigating back
      if (selectedSystemId != null) {
        const system = systemsWithCounts.find((s) => s.id === selectedSystemId);
        if (system) setSelectedSystem(system);
      }
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
    return <div className="text-center py-8">Loading body systems...</div>;
  }

  return (
    <div className="grid grid-cols-1 lg:grid-cols-3 gap-6 items-start">
      {/* System List */}
      <div className="lg:col-span-1 bg-white rounded-lg shadow-lg p-6">
        <h3 className="text-lg font-semibold text-gray-800 mb-4">Body Systems</h3>

        <div className="space-y-2">
          {systems.map((system) => (
            <button
              key={system.id}
              onClick={() => {
                setSelectedSystem(system);
                onSystemChange?.(system.id);
                onDisorderChange?.(null);
              }}
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

      {/* System Details */}
      <div className="lg:col-span-2 bg-white rounded-lg shadow-lg p-6">
        {selectedSystem ? (
          <div>
            <div className="flex items-center justify-between mb-6">
              <h2 className="text-3xl font-bold text-green-800">
                {selectedSystem.name} System
              </h2>

              {(selectedSystem.disorder_count ?? 0) > 0 && (
                <div className="flex gap-2">
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
                    Actions & Herbs
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
                  selectedDisorderId={selectedDisorderId}
                  onDisorderChange={onDisorderChange}
                />
              </div>
            ) : selectedSystem.herb_primary_actions.length > 0 ? (
              <div className="space-y-6">
                {Array.from(groupByAction(selectedSystem))
                  .sort(([a], [b]) => a.localeCompare(b))
                  .map(([actionName, herbs]) => (
                    <div
                      key={actionName}
                      className="border-l-4 border-blue-500 pl-4 pb-4"
                    >
                      <h3 className="text-xl font-semibold text-gray-800 mb-3">
                        {actionName}
                      </h3>
                      <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-3">
                        {herbs.map((item, idx) => (
                          <button
                            key={idx}
                            onClick={() => onHerbClick?.(item.herb.id)}
                            className={`border rounded-lg p-3 hover:shadow-md hover:scale-105 transition-all cursor-pointer text-left ${getTemperatureCard(item.herb)}`}
                          >
                            <div className="font-medium text-sm">{item.herb.common_name}</div>
                            <div className="text-xs italic text-gray-600">{item.herb.latin_name}</div>
                            <div className="flex items-center justify-between mt-1.5">
                              {item.strength && getStrengthBadge(item.strength) ? (
                                <span className={`text-xs font-semibold px-1.5 py-0.5 rounded ${getStrengthBadge(item.strength)}`}>
                                  {item.strength.replace('_', ' ')}
                                </span>
                              ) : <span />}
                              <span className="text-sm leading-none">{getEnergeticEmojis(item.herb)}</span>
                            </div>
                          </button>
                        ))}
                      </div>
                    </div>
                  )
                )}
              </div>
            ) : viewMode === 'disorders' ? (
              <p className="text-gray-500 italic">
                No disorders recorded for this body system.
              </p>
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
