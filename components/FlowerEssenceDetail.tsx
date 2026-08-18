'use client';

import type { FlowerEssencePlant } from '@/types/database';

interface FlowerEssenceDetailProps {
  essence: FlowerEssencePlant;
  onSoulConditionClick?: (category: string) => void;
}

function Section({ title, children }: { title: string; children: React.ReactNode }) {
  return (
    <div className="mt-6">
      <h3 className="text-sm font-semibold text-purple-500 uppercase tracking-widest mb-2">{title}</h3>
      {children}
    </div>
  );
}

export function FlowerEssenceDetail({ essence, onSoulConditionClick }: FlowerEssenceDetailProps) {
  return (
    <div>
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-start sm:justify-between mb-4">
        <div>
          <h2 className="text-3xl font-bold text-purple-800">
            {essence.name}
            <span className="ml-2 text-base font-normal text-purple-400">(essence)</span>
          </h2>
          {essence.latin_name && (
            <p className="text-xl italic text-gray-500 mt-0.5">{essence.latin_name}</p>
          )}
        </div>
        <div className="flex flex-wrap gap-2 mt-2 sm:mt-0 sm:ml-4 shrink-0">
          {essence.color && (
            <span className="px-3 py-1 rounded-full text-sm font-medium bg-violet-100 text-violet-700 border border-violet-200">
              {essence.color}
            </span>
          )}
          {essence.kit && (
            <span className="px-3 py-1 rounded-full text-sm font-medium bg-purple-50 text-purple-600 border border-purple-200">
              {essence.kit}
            </span>
          )}
        </div>
      </div>

      <div className="border-t border-purple-100 pt-4">
        {essence.positive_qualities && (
          <Section title="Positive Qualities">
            <p className="text-gray-700 leading-relaxed">{essence.positive_qualities}</p>
          </Section>
        )}

        {essence.patterns_of_imbalance && (
          <Section title="Patterns of Imbalance">
            <p className="text-gray-700 leading-relaxed">{essence.patterns_of_imbalance}</p>
          </Section>
        )}

        {essence.description && (
          <Section title="Description">
            <p className="text-gray-700 leading-relaxed whitespace-pre-line">{essence.description}</p>
          </Section>
        )}

        {essence.cross_references && essence.cross_references.length > 0 && (
          <Section title="Soul Condition Cross-References">
            <div className="flex flex-wrap gap-2">
              {essence.cross_references.map((ref) => (
                <button
                  key={ref}
                  onClick={() => onSoulConditionClick?.(ref)}
                  className="px-3 py-1 rounded-full text-sm bg-purple-50 text-purple-700 border border-purple-200 hover:bg-purple-100 hover:border-purple-300 transition-colors"
                >
                  {ref}
                </button>
              ))}
            </div>
          </Section>
        )}
      </div>
    </div>
  );
}
