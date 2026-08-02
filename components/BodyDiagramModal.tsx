'use client';

import { useCallback, useEffect, useState } from 'react';
import { XMarkIcon } from '@heroicons/react/24/outline';
import { supabase } from '@/lib/supabase';

interface BodySystem {
  id: number;
  name: string;
}

interface Props {
  open: boolean;
  onClose: () => void;
  onSystemSelect: (systemId: number) => void;
}

// Which DB system names belong to each anatomical region
const REGION_SYSTEM_NAMES: Record<string, string[]> = {
  nervous:              ['Nervous'],
  'respiratory-upper':  ['Respiratory - Upper', 'Upper Respiratory'],
  cardiovascular:       ['Cardiovascular'],
  respiratory:          ['Respiratory', 'Respiratory - Overall'],
  'respiratory-lower':  ['Respiratory - Lower', 'Lower Respiratory'],
  digestive:            ['Digestive'],
  urinary:              ['Urinary'],
  reproductive:         ['Reproductive', 'Reproductive - Female', 'Reproductive - Male'],
  musculoskeletal:      ['Musculoskeletal'],
  skin:                 ['Skin'],
  immune:               ['Immune'],
  aging:                ['Aging'],
};

const REGION_COLORS: Record<string, string> = {
  nervous:             '#8b5cf6',
  'respiratory-upper': '#7dd3fc',
  cardiovascular:      '#ef4444',
  respiratory:         '#3b82f6',
  'respiratory-lower': '#60a5fa',
  digestive:           '#f97316',
  urinary:             '#eab308',
  reproductive:        '#ec4899',
  musculoskeletal:     '#d97706',
  skin:                '#10b981',
  immune:              '#14b8a6',
  aging:               '#9ca3af',
};

const BODY_REGIONS = [
  'nervous', 'respiratory-upper', 'cardiovascular', 'respiratory',
  'respiratory-lower', 'digestive', 'urinary', 'reproductive', 'musculoskeletal',
];
const SYSTEMIC_REGIONS = ['skin', 'immune', 'aging'];

export function BodyDiagramModal({ open, onClose, onSystemSelect }: Props) {
  const [systems, setSystems] = useState<BodySystem[]>([]);
  const [hoveredRegion, setHoveredRegion] = useState<string | null>(null);
  const [activeRegion, setActiveRegion] = useState<string | null>(null);

  useEffect(() => {
    if (!open) return;
    supabase
      .from('body_systems')
      .select('id, name')
      .neq('name', 'All')
      .order('name')
      .then(({ data }) => setSystems(data ?? []));
  }, [open]);

  const regionSystems = useCallback(
    (regionId: string): BodySystem[] => {
      const names = REGION_SYSTEM_NAMES[regionId] ?? [];
      return systems.filter((s) => names.includes(s.name));
    },
    [systems]
  );

  const handleRegionClick = (regionId: string) => {
    const matched = regionSystems(regionId);
    if (matched.length === 1) {
      onSystemSelect(matched[0].id);
      onClose();
    } else if (matched.length > 1) {
      setActiveRegion(activeRegion === regionId ? null : regionId);
    }
  };

  const regionProps = (regionId: string) => ({
    fill: REGION_COLORS[regionId],
    fillOpacity: hoveredRegion === regionId ? 0.8 : 0.55,
    stroke: hoveredRegion === regionId ? REGION_COLORS[regionId] : 'transparent',
    strokeWidth: 2,
    className: 'cursor-pointer transition-all duration-150',
    onMouseEnter: () => setHoveredRegion(regionId),
    onMouseLeave: () => setHoveredRegion(null),
    onClick: () => handleRegionClick(regionId),
  });

  if (!open) return null;

  const hoveredLabel = hoveredRegion ? regionSystems(hoveredRegion).map((s) => s.name).join(' / ') : null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50" onClick={onClose}>
      <div
        className="bg-white rounded-2xl shadow-2xl w-full mx-4 p-6 relative flex gap-6"
        style={{ maxWidth: 600 }}
        onClick={(e) => e.stopPropagation()}
      >
        <button onClick={onClose} className="absolute top-4 right-4 text-gray-400 hover:text-gray-600">
          <XMarkIcon className="w-6 h-6" />
        </button>
        <h2 className="absolute top-4 left-6 text-lg font-bold text-green-800">Browse by Body System</h2>

        {/* SVG Body Diagram */}
        <div className="flex-shrink-0 mt-8">
          <svg viewBox="0 0 220 510" width="180" height="420" className="overflow-visible">
            {/* Silhouette */}
            <ellipse cx="110" cy="48" rx="36" ry="42" fill="#e5e7eb" />
            <rect x="98" y="87" width="24" height="22" fill="#e5e7eb" />
            <polygon points="62,108 158,108 148,295 72,295" fill="#e5e7eb" />
            <polygon points="35,112 63,108 57,285 28,288" fill="#e5e7eb" />
            <polygon points="157,108 185,112 192,288 163,285" fill="#e5e7eb" />
            <polygon points="72,295 108,295 105,490 68,490" fill="#e5e7eb" />
            <polygon points="112,295 148,295 152,490 115,490" fill="#e5e7eb" />

            {/* Musculoskeletal: arms + legs (behind other regions) */}
            {regionSystems('musculoskeletal').length > 0 && (
              <>
                <polygon points="35,112 63,108 57,285 28,288" {...regionProps('musculoskeletal')} />
                <polygon points="157,108 185,112 192,288 163,285" {...regionProps('musculoskeletal')} />
                <polygon points="72,295 108,295 105,490 68,490" {...regionProps('musculoskeletal')} />
                <polygon points="112,295 148,295 152,490 115,490" {...regionProps('musculoskeletal')} />
              </>
            )}

            {/* Respiratory - Lower: lower chest */}
            {regionSystems('respiratory-lower').length > 0 && (
              <rect x="70" y="180" width="80" height="50" rx="6" {...regionProps('respiratory-lower')} />
            )}

            {/* Cardiovascular: left chest */}
            {regionSystems('cardiovascular').length > 0 && (
              <ellipse cx="88" cy="148" rx="22" ry="30" {...regionProps('cardiovascular')} />
            )}

            {/* Respiratory - Overall: right chest */}
            {regionSystems('respiratory').length > 0 && (
              <ellipse cx="130" cy="148" rx="22" ry="30" {...regionProps('respiratory')} />
            )}

            {/* Digestive: upper abdomen */}
            {regionSystems('digestive').length > 0 && (
              <rect x="75" y="228" width="70" height="50" rx="6" {...regionProps('digestive')} />
            )}

            {/* Urinary: mid abdomen */}
            {regionSystems('urinary').length > 0 && (
              <ellipse cx="110" cy="270" rx="28" ry="18" {...regionProps('urinary')} />
            )}

            {/* Reproductive: pelvis */}
            {regionSystems('reproductive').length > 0 && (
              <ellipse cx="110" cy="290" rx="34" ry="13" {...regionProps('reproductive')} />
            )}

            {/* Respiratory - Upper: neck */}
            {regionSystems('respiratory-upper').length > 0 && (
              <rect x="92" y="80" width="36" height="34" rx="4" {...regionProps('respiratory-upper')} />
            )}

            {/* Nervous: head */}
            {regionSystems('nervous').length > 0 && (
              <ellipse cx="110" cy="48" rx="36" ry="42" {...regionProps('nervous')} />
            )}

            {/* Hover label */}
            <text x="110" y="508" textAnchor="middle" fontSize="11" fill="#374151" fontWeight="600">
              {hoveredLabel ?? ''}
            </text>
          </svg>
        </div>

        {/* Right panel: legend + systemic + multi-picker */}
        <div className="flex-1 flex flex-col gap-2 mt-10 overflow-y-auto" style={{ maxHeight: 390 }}>
          {/* Legend */}
          <p className="text-xs font-semibold text-gray-400 uppercase tracking-wide">Body Regions</p>
          <div className="flex flex-col gap-1">
            {BODY_REGIONS.map((regionId) => {
              const matched = regionSystems(regionId);
              if (matched.length === 0) return null;
              const isHovered = hoveredRegion === regionId;
              return (
                <button
                  key={regionId}
                  onClick={() => handleRegionClick(regionId)}
                  onMouseEnter={() => setHoveredRegion(regionId)}
                  onMouseLeave={() => setHoveredRegion(null)}
                  className={`flex items-center gap-2 text-sm text-left px-2 py-1.5 rounded-lg transition-all ${isHovered ? 'bg-gray-100' : 'hover:bg-gray-50'}`}
                >
                  <span className="w-3 h-3 rounded-full flex-shrink-0" style={{ backgroundColor: REGION_COLORS[regionId] }} />
                  <span className="text-gray-700">{matched.map((s) => s.name).join(' / ')}</span>
                </button>
              );
            })}
          </div>

          <p className="text-xs font-semibold text-gray-400 uppercase tracking-wide mt-3">Systemic</p>
          <div className="flex flex-col gap-1">
            {SYSTEMIC_REGIONS.map((regionId) => {
              const matched = regionSystems(regionId);
              if (matched.length === 0) return null;
              return matched.map((sys) => (
                <button
                  key={sys.id}
                  onClick={() => { onSystemSelect(sys.id); onClose(); }}
                  className="flex items-center gap-2 text-sm text-left px-2 py-1.5 rounded-lg hover:bg-gray-50 transition-all"
                >
                  <span className="w-3 h-3 rounded-full flex-shrink-0" style={{ backgroundColor: REGION_COLORS[regionId] }} />
                  <span className="text-gray-700">{sys.name}</span>
                </button>
              ));
            })}
          </div>

          {/* Multi-system picker */}
          {activeRegion && regionSystems(activeRegion).length > 1 && (
            <div className="mt-3 p-3 bg-green-50 rounded-xl border border-green-200">
              <p className="text-xs font-semibold text-green-700 mb-2">Choose a system:</p>
              {regionSystems(activeRegion).map((sys) => (
                <button
                  key={sys.id}
                  onClick={() => { onSystemSelect(sys.id); onClose(); }}
                  className="block w-full text-left px-3 py-1.5 text-sm text-green-800 hover:bg-green-100 rounded-lg transition-all"
                >
                  {sys.name}
                </button>
              ))}
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
