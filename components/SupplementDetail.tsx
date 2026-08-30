'use client';

import { useState, useEffect } from 'react';
import { supabase } from '@/lib/supabase';
import type { Supplement } from '@/types/database';
import { EnergeticEmojis } from './EnergeticEmojis';

interface DisorderRef {
  prescriptionId: number;
  prescriptionTitle: string | null;
  disorderName: string;
  bodySystemId: number;
  disorderId: number;
  dose: string | null;
}

interface ClassNoteSnippet {
  id: number;
  snippet_text: string;
  class_name: string;
  note_type: string;
  section_header: string | null;
  source_block: string | null;
}

interface SupplementDetailProps {
  supplement: Supplement;
  onDisorderClick?: (disorderId: number, systemId: number) => void;
}

function categoryColor(category: string) {
  switch (category) {
    case 'Vitamin':     return 'bg-violet-100 text-violet-800 border-violet-300';
    case 'Mineral':     return 'bg-teal-100 text-teal-800 border-teal-300';
    case 'Amino Acid':  return 'bg-blue-100 text-blue-800 border-blue-300';
    case 'Enzyme':      return 'bg-orange-100 text-orange-800 border-orange-300';
    default:            return 'bg-gray-100 text-gray-700 border-gray-300';
  }
}

function solubilityColor(solubility: string) {
  switch (solubility) {
    case 'fat-soluble':         return 'bg-amber-100 text-amber-800 border-amber-300';
    case 'water-soluble':       return 'bg-sky-100 text-sky-800 border-sky-300';
    case 'water & fat-soluble': return 'bg-teal-100 text-teal-800 border-teal-300';
    default:                    return 'bg-gray-100 text-gray-600 border-gray-200';
  }
}

export function SupplementDetail({ supplement, onDisorderClick }: SupplementDetailProps) {
  const [disorderRefs, setDisorderRefs] = useState<DisorderRef[]>([]);
  const [classNoteSnippets, setClassNoteSnippets] = useState<ClassNoteSnippet[]>([]);

  useEffect(() => {
    if (!supplement) return;
    supabase
      .from('prescription_supplements')
      .select(`
        id,
        dose,
        prescription_id,
        disorder_prescriptions (
          id,
          title,
          disorders (
            id,
            name,
            body_system_id
          )
        )
      `)
      .eq('supplement_id', supplement.id)
      .then(({ data, error }) => {
        if (error || !data) return;
        const refs: DisorderRef[] = (data as any[]).map((row) => {
          const dp = row.disorder_prescriptions;
          const d = dp?.disorders;
          return {
            prescriptionId: row.prescription_id,
            prescriptionTitle: dp?.title ?? null,
            disorderName: d?.name ?? '',
            bodySystemId: d?.body_system_id ?? 0,
            disorderId: d?.id ?? 0,
            dose: row.dose,
          };
        }).filter((r) => r.disorderName);
        setDisorderRefs(refs);
      });
  }, [supplement.id]);

  useEffect(() => {
    if (!supplement) return;
    supabase
      .from('class_note_snippets')
      .select('id, snippet_text, class_name, note_type, section_header, sort_order, source_block')
      .eq('supplement_id', supplement.id)
      .order('class_name')
      .order('sort_order')
      .then(({ data }) => {
        if (data) setClassNoteSnippets(data as ClassNoteSnippet[]);
      });
  }, [supplement.id]);

  return (
    <div>
      {/* Header */}
      <div className="mb-4">
        <div className="flex items-start justify-between gap-3">
          <h2 className="text-3xl font-bold text-indigo-800">{supplement.name}</h2>
          {supplement.category === 'Mineral' && supplement.temperature !== 'warming' && (
            <EnergeticEmojis temperature="cooling" className="text-2xl leading-none shrink-0 mt-1" />
          )}
        </div>
        {supplement.subcategory && (
          <p className="text-sm text-gray-500 mt-0.5">{supplement.subcategory}</p>
        )}
        <div className="flex flex-wrap gap-2 mt-2">
          <span className={`text-xs font-semibold px-2 py-0.5 rounded-full border ${categoryColor(supplement.category)}`}>
            {supplement.category}
          </span>
          {supplement.solubility && (
            <span className={`text-xs font-semibold px-2 py-0.5 rounded-full border ${solubilityColor(supplement.solubility)}`}>
              {supplement.solubility}
            </span>
          )}
        </div>
      </div>

      <div className="space-y-5">
        {/* Description */}
        {supplement.description && (
          <div className="bg-indigo-50 border border-indigo-200 border-l-4 border-l-indigo-500 rounded-lg p-4">
            <p className="text-gray-800 leading-relaxed">{supplement.description}</p>
          </div>
        )}

        {/* Dosage */}
        {supplement.dose_range && (
          <div>
            <h3 className="text-base font-semibold text-gray-700 mb-1">Dosage</h3>
            <div className="bg-green-50 border border-green-200 rounded-lg px-4 py-3">
              <p className="text-gray-800 font-medium">{supplement.dose_range}</p>
              {supplement.dose_notes && (
                <p className="text-sm text-gray-600 mt-1">{supplement.dose_notes}</p>
              )}
            </div>
          </div>
        )}

        {/* Deficiency Signs */}
        {supplement.deficiency_signs && (
          <div>
            <h3 className="text-base font-semibold text-gray-700 mb-1">Signs of Deficiency</h3>
            <div className="bg-red-50 border border-red-200 rounded-lg px-4 py-3">
              <p className="text-gray-800">{supplement.deficiency_signs}</p>
            </div>
          </div>
        )}

        {/* Dietary Sources */}
        {supplement.dietary_sources && (
          <div>
            <h3 className="text-base font-semibold text-gray-700 mb-1">Food Sources</h3>
            <div className="bg-amber-50 border border-amber-200 rounded-lg px-4 py-3">
              <p className="text-gray-800">{supplement.dietary_sources}</p>
            </div>
          </div>
        )}

        {/* Absorption Notes */}
        {supplement.absorption_notes && (
          <div>
            <h3 className="text-base font-semibold text-gray-700 mb-1">Absorption &amp; Notes</h3>
            <div className="bg-gray-50 border border-gray-200 rounded-lg px-4 py-3">
              <p className="text-gray-800">{supplement.absorption_notes}</p>
            </div>
          </div>
        )}

        {/* Drug Depletors */}
        {supplement.drug_depletors && (
          <div>
            <h3 className="text-base font-semibold text-gray-700 mb-1">Medications That Deplete</h3>
            <div className="bg-orange-50 border border-orange-200 rounded-lg px-4 py-3">
              <p className="text-gray-800">{supplement.drug_depletors}</p>
            </div>
          </div>
        )}

        {/* Disorders Cross-Reference */}
        {disorderRefs.length > 0 && (
          <div>
            <h3 className="text-base font-semibold text-gray-700 mb-2">Prescribed For</h3>
            <div className="space-y-2">
              {disorderRefs.map((ref, idx) => (
                <button
                  key={idx}
                  onClick={() => onDisorderClick?.(ref.disorderId, ref.bodySystemId)}
                  className="w-full text-left border border-gray-200 rounded-lg px-4 py-3 bg-white hover:bg-green-50 hover:border-green-300 transition-all"
                >
                  <div className="font-medium text-gray-900">{ref.disorderName}</div>
                  {ref.prescriptionTitle && (
                    <div className="text-sm text-gray-500">{ref.prescriptionTitle}</div>
                  )}
                  {ref.dose && (
                    <div className="text-sm text-green-700 font-medium mt-0.5">{ref.dose}</div>
                  )}
                </button>
              ))}
            </div>
          </div>
        )}
        {/* Class Notes */}
        {classNoteSnippets.length > 0 && (
          <div>
            <h3 className="text-base font-semibold text-gray-700 mb-2">Class Notes</h3>
            <div className="space-y-3">
              {classNoteSnippets.map((snippet) => (
                <div key={snippet.id} className="border border-teal-200 border-l-4 border-l-teal-500 rounded-lg p-3 bg-teal-50">
                  <div className="flex items-center justify-between mb-1 gap-2">
                    <a
                      href={`https://apple.com/icloud/`}
                      className="text-xs font-semibold text-teal-700 hover:underline"
                      onClick={(e) => e.stopPropagation()}
                    >
                      {snippet.class_name}
                    </a>
                    <span className={`text-xs px-1.5 py-0.5 rounded-full border ${snippet.note_type === 'personal' ? 'bg-amber-50 text-amber-700 border-amber-300' : 'bg-gray-100 text-gray-500 border-gray-300'}`}>
                      {snippet.note_type}
                    </span>
                  </div>
                  {snippet.section_header && (
                    <p className="text-xs font-semibold text-teal-600 mb-1">{snippet.section_header}</p>
                  )}
                  <p className="text-sm text-gray-800 leading-relaxed">{snippet.snippet_text}</p>
                  {snippet.source_block && (
                    <details className="mt-2">
                      <summary className="text-xs text-teal-600 cursor-pointer hover:text-teal-800">Source</summary>
                      <blockquote className="mt-1 text-xs text-gray-600 whitespace-pre-wrap font-mono bg-white border border-teal-100 rounded p-2">
                        {snippet.source_block}
                      </blockquote>
                    </details>
                  )}
                </div>
              ))}
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
