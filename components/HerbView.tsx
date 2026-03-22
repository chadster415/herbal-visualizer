'use client';

import { useState, useEffect } from 'react';
import { supabase } from '@/lib/supabase';
import type { Herb, PrimaryAction, BodySystem, StrengthLevel } from '@/types/database';

interface HerbData extends Herb {
  herb_primary_actions: Array<{
    primary_actions: PrimaryAction;
    body_systems: BodySystem | null;
    body_system_note: string | null;
    relative_strength: StrengthLevel | null;
  }>;
}

export function HerbView() {
  const [herbs, setHerbs] = useState<HerbData[]>([]);
  const [selectedHerb, setSelectedHerb] = useState<HerbData | null>(null);
  const [searchTerm, setSearchTerm] = useState('');
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchHerbs();
  }, []);

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
              onClick={() => setSelectedHerb(herb)}
              className={`w-full text-left p-3 rounded-lg transition-all ${
                selectedHerb?.id === herb.id
                  ? 'bg-green-100 border-2 border-green-500'
                  : 'bg-gray-50 hover:bg-gray-100'
              }`}
            >
              <div className="font-semibold text-gray-900">{herb.common_name}</div>
              <div className="text-sm italic text-gray-600">{herb.latin_name}</div>
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

            <h3 className="text-xl font-semibold text-gray-800 mb-4">
              Primary Actions & Body Systems
            </h3>

            {selectedHerb.herb_primary_actions.length > 0 ? (
              <div className="space-y-4">
                {selectedHerb.herb_primary_actions.map((action, idx) => (
                  <div
                    key={idx}
                    className="border border-gray-200 rounded-lg p-4 hover:shadow-md transition-shadow"
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
                  </div>
                ))}
              </div>
            ) : (
              <p className="text-gray-500 italic">
                No primary actions recorded for this herb.
              </p>
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
