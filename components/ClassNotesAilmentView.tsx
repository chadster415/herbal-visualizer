'use client';

import { useState, useEffect, useRef, useMemo } from 'react';
import type { ReactNode } from 'react';
import Fuse from 'fuse.js';
import { supabase } from '@/lib/supabase';

function highlightName(text: string, terms: string[]): ReactNode[] {
  const valid = terms.filter((t) => t && t.length > 2);
  if (valid.length === 0) return [text];
  // Normalize curly apostrophes (U+2018, U+2019) to straight (U+0027) before
  // matching so "Devil’s Claw" (DB) matches "Devil’s claw" (notes).
  const S = String.fromCharCode(0x27);
  const normApos = (s: string) =>
    s.split(String.fromCharCode(0x2018)).join(S).split(String.fromCharCode(0x2019)).join(S);
  const normText = normApos(text);
  const toPattern = (t: string) =>
    normApos(t).replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
  const pattern = valid.map(toPattern).join('|');
  const parts = normText.split(new RegExp(`(${pattern})`, 'gi'));
  let pos = 0;
  return parts.map((part, i) => {
    const orig = text.slice(pos, pos + part.length);
    pos += part.length;
    return i % 2 === 1
      ? <strong key={i} className="font-bold text-teal-900">{orig}</strong>
      : orig;
  });
}

interface AilmentEntry {
  keyword: string;
  herbIds: number[];
  supplementIds: number[];
}

interface HerbSummary {
  id: number;
  common_name: string;
  latin_name: string;
  plant_part: string | null;
  synonyms: string[] | null;
}

interface SupplementSummary {
  id: number;
  name: string;
  category: string;
}

interface ClassNoteSnippet {
  id: number;
  herb_id: number | null;
  supplement_id: number | null;
  snippet_text: string;
  class_name: string;
  note_type: 'generated' | 'personal';
  section_header: string | null;
  sort_order: number;
  source_block: string | null;
}

interface DetailData {
  herbs: HerbSummary[];
  supplements: SupplementSummary[];
  snippetsByHerb: Map<number, ClassNoteSnippet[]>;
  snippetsBySupplement: Map<number, ClassNoteSnippet[]>;
}

interface ClassNotesAilmentViewProps {
  selectedAilmentKeyword: string | null;
  onAilmentChange: (keyword: string | null) => void;
  onHerbClick: (herbId: number) => void;
  onSupplementClick: (supplementId: number) => void;
}

export function ClassNotesAilmentView({
  selectedAilmentKeyword,
  onAilmentChange,
  onHerbClick,
  onSupplementClick,
}: ClassNotesAilmentViewProps) {
  const [ailments, setAilments] = useState<AilmentEntry[]>([]);
  const [ailmentSynonyms, setAilmentSynonyms] = useState<Map<string, string[]>>(new Map());
  const [searchQuery, setSearchQuery] = useState('');
  const [detail, setDetail] = useState<DetailData | null>(null);
  const [loading, setLoading] = useState(true);
  const [detailLoading, setDetailLoading] = useState(false);
  const [mobileListOpen, setMobileListOpen] = useState(false);
  const [collapsedSections, setCollapsedSections] = useState<Set<string>>(new Set());
  const detailPanelRef = useRef<HTMLDivElement>(null);
  const sectionRefs = useRef<Record<string, HTMLDivElement | null>>({});

  useEffect(() => {
    Promise.all([
      supabase.from('herb_keywords').select('keyword, herb_id, supplement_id').eq('category', 'ailment'),
      supabase.from('ailment_search_terms').select('ailment_keyword, synonyms'),
    ]).then(([{ data: kwData }, { data: synData }]) => {
      const herbMap = new Map<string, Set<number>>();
      const suppMap = new Map<string, Set<number>>();
      for (const row of kwData ?? []) {
        if (row.herb_id != null) {
          if (!herbMap.has(row.keyword)) herbMap.set(row.keyword, new Set());
          herbMap.get(row.keyword)!.add(row.herb_id);
        }
        if (row.supplement_id != null) {
          if (!suppMap.has(row.keyword)) suppMap.set(row.keyword, new Set());
          suppMap.get(row.keyword)!.add(row.supplement_id);
        }
      }
      const allKeywords = new Set([...herbMap.keys(), ...suppMap.keys()]);
      const sorted = [...allKeywords]
        .sort((a, b) => a.localeCompare(b))
        .map((keyword) => ({
          keyword,
          herbIds: [...(herbMap.get(keyword) ?? [])],
          supplementIds: [...(suppMap.get(keyword) ?? [])],
        }));
      setAilments(sorted);

      const synMap = new Map<string, string[]>();
      for (const row of synData ?? []) {
        synMap.set(row.ailment_keyword, row.synonyms ?? []);
      }
      setAilmentSynonyms(synMap);

      setLoading(false);
    });
  }, []);

  useEffect(() => {
    if (!selectedAilmentKeyword) { setDetail(null); return; }
    const entry = ailments.find((a) => a.keyword === selectedAilmentKeyword);
    const herbIds = entry?.herbIds ?? [];
    const supplementIds = entry?.supplementIds ?? [];
    if (herbIds.length === 0 && supplementIds.length === 0) {
      setDetail({ herbs: [], supplements: [], snippetsByHerb: new Map(), snippetsBySupplement: new Map() });
      return;
    }
    setDetailLoading(true);
    Promise.all([
      herbIds.length > 0
        ? supabase.from('herbs').select('id, common_name, latin_name, plant_part, synonyms').in('id', herbIds).order('common_name')
        : Promise.resolve({ data: [] }),
      supplementIds.length > 0
        ? supabase.from('supplements').select('id, name, category').in('id', supplementIds).order('name')
        : Promise.resolve({ data: [] }),
      herbIds.length > 0
        ? supabase.from('class_note_snippets').select('*').in('herb_id', herbIds).order('note_type').order('sort_order')
        : Promise.resolve({ data: [] }),
      supplementIds.length > 0
        ? supabase.from('class_note_snippets').select('*').in('supplement_id', supplementIds).order('note_type').order('sort_order')
        : Promise.resolve({ data: [] }),
    ]).then(([{ data: herbData }, { data: suppData }, { data: herbSnippets }, { data: suppSnippets }]) => {
      const snippetsByHerb = new Map<number, ClassNoteSnippet[]>();
      for (const s of (herbSnippets ?? []) as ClassNoteSnippet[]) {
        if (s.herb_id == null) continue;
        if (!snippetsByHerb.has(s.herb_id)) snippetsByHerb.set(s.herb_id, []);
        snippetsByHerb.get(s.herb_id)!.push(s);
      }
      const snippetsBySupplement = new Map<number, ClassNoteSnippet[]>();
      for (const s of (suppSnippets ?? []) as ClassNoteSnippet[]) {
        if (s.supplement_id == null) continue;
        if (!snippetsBySupplement.has(s.supplement_id)) snippetsBySupplement.set(s.supplement_id, []);
        snippetsBySupplement.get(s.supplement_id)!.push(s);
      }
      setDetail({
        herbs: (herbData ?? []) as HerbSummary[],
        supplements: (suppData ?? []) as SupplementSummary[],
        snippetsByHerb,
        snippetsBySupplement,
      });
      setDetailLoading(false);
    });
  }, [selectedAilmentKeyword, ailments]);

  const toggleSection = (key: string) => {
    setCollapsedSections((prev) => {
      const next = new Set(prev);
      if (next.has(key)) next.delete(key); else next.add(key);
      return next;
    });
  };

  const scrollToSection = (key: string) => {
    sectionRefs.current[key]?.scrollIntoView({ behavior: 'smooth', block: 'start' });
  };

  const selectAilment = (keyword: string | null) => {
    if (!keyword) setSearchQuery('');
    setCollapsedSections(new Set());
    onAilmentChange(keyword);
    if (typeof window !== 'undefined' && window.innerWidth < 1024) {
      setMobileListOpen(false);
      setTimeout(() => detailPanelRef.current?.scrollIntoView({ behavior: 'smooth', block: 'start' }), 50);
    }
  };

  const ailmentFuse = useMemo(() => {
    const entries = ailments.map((a) => ({
      ailment: a,
      synonyms: ailmentSynonyms.get(a.keyword) ?? [],
    }));
    return new Fuse(entries, {
      keys: [
        { name: 'ailment.keyword', weight: 2 },
        { name: 'synonyms', weight: 1 },
      ],
      threshold: 0.4,
      ignoreLocation: true,
      minMatchCharLength: 2,
    });
  }, [ailments, ailmentSynonyms]);

  const visibleAilments = searchQuery.length >= 2
    ? ailmentFuse.search(searchQuery).map((r) => r.item.ailment)
    : ailments;

  const totalCount = (a: AilmentEntry) => a.herbIds.length + a.supplementIds.length;

  if (loading) {
    return <div className="text-center py-8 text-gray-400">Loading class notes…</div>;
  }

  return (
    <div className="grid grid-cols-1 lg:grid-cols-3 gap-6 items-start">
      {/* ── Left panel: ailment keyword list ─────────────────────────────── */}
      <div className={`lg:col-span-1 bg-white rounded-lg shadow-lg lg:p-6 ${mobileListOpen ? 'p-6' : 'p-3'}`}>
        <div className={`flex items-center justify-between lg:mb-4 ${mobileListOpen ? 'mb-4' : ''}`}>
          <div>
            <h3 className="text-lg font-semibold text-gray-800">Class Notes</h3>
            <p className="text-xs text-amber-600 font-medium mt-0.5">Inferred ailments</p>
          </div>
          <button
            className="lg:hidden p-2 rounded-lg text-gray-500 hover:text-gray-700 hover:bg-gray-100 transition-all"
            onClick={() => setMobileListOpen((v) => !v)}
          >
            <svg className={`w-5 h-5 transition-transform ${mobileListOpen ? 'rotate-180' : ''}`} fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
            </svg>
          </button>
        </div>
        <div className={`${mobileListOpen ? '' : 'hidden'} lg:block`}>
          {selectedAilmentKeyword && (
            <button
              onClick={() => selectAilment(null)}
              className="w-full text-left px-2 py-1.5 rounded-md text-sm text-amber-700 hover:bg-amber-50 mb-2 transition-all"
            >
              ← All ailments
            </button>
          )}
          <div className="space-y-1 max-h-[60vh] overflow-y-auto pr-1">
            {ailments.map((a) => (
              <button
                key={a.keyword}
                onClick={() => selectAilment(a.keyword)}
                className={`w-full text-left px-3 py-2 rounded-lg transition-all flex items-center justify-between gap-2 ${
                  selectedAilmentKeyword === a.keyword
                    ? 'bg-amber-100 border border-amber-300 font-semibold text-amber-900'
                    : 'hover:bg-amber-50 text-gray-700'
                }`}
              >
                <span className="text-sm capitalize">{a.keyword}</span>
                <span className="text-xs text-gray-400 shrink-0">
                  {totalCount(a)} {totalCount(a) !== 1 ? 'entries' : 'entry'}
                </span>
              </button>
            ))}
          </div>
        </div>
      </div>

      {/* ── Right panel ───────────────────────────────────────────────────── */}
      <div ref={detailPanelRef} className="lg:col-span-2 bg-white rounded-lg shadow-lg p-6">
        {selectedAilmentKeyword ? (
          /* ── Ailment detail ─────────────────────────────────────────────── */
          <div>
            <div className="flex items-start gap-3 mb-6">
              <div>
                <h2 className="text-2xl font-bold text-gray-800 capitalize">{selectedAilmentKeyword}</h2>
                <div className="flex items-center gap-2 mt-1">
                  <span className="text-xs font-medium bg-amber-100 text-amber-700 border border-amber-200 px-2 py-0.5 rounded-full">
                    inferred from class notes
                  </span>
                  {detail && (
                    <span className="text-xs text-gray-400">
                      {detail.herbs.length + detail.supplements.length} {detail.herbs.length + detail.supplements.length !== 1 ? 'entries' : 'entry'}
                    </span>
                  )}
                </div>
              </div>
            </div>

            {/* Herb + supplement pills nav */}
            {!detailLoading && detail && (detail.herbs.length + detail.supplements.length) > 1 && (
              <div className="flex flex-wrap gap-1.5 mb-5">
                {detail.herbs.map((herb) => (
                  <button
                    key={`pill-herb-${herb.id}`}
                    onClick={() => scrollToSection(`herb-${herb.id}`)}
                    className="text-xs px-2.5 py-1 rounded-full bg-green-100 text-green-800 border border-green-200 hover:bg-green-200 transition-all whitespace-nowrap font-medium"
                  >
                    {herb.common_name}{herb.plant_part ? ` (${herb.plant_part})` : ''}
                  </button>
                ))}
                {detail.supplements.map((supp) => (
                  <button
                    key={`pill-supp-${supp.id}`}
                    onClick={() => scrollToSection(`supp-${supp.id}`)}
                    className="text-xs px-2.5 py-1 rounded-full bg-indigo-100 text-indigo-800 border border-indigo-200 hover:bg-indigo-200 transition-all whitespace-nowrap font-medium"
                  >
                    {supp.name}
                  </button>
                ))}
              </div>
            )}

            {detailLoading ? (
              <div className="text-sm text-gray-400 text-center py-8">Loading…</div>
            ) : detail && detail.herbs.length === 0 && detail.supplements.length === 0 ? (
              <p className="text-gray-400 italic">No entries found for this ailment.</p>
            ) : (
              <div className="space-y-5">
                {detail?.herbs.map((herb) => {
                  const snippets = detail.snippetsByHerb.get(herb.id) ?? [];
                  const key = `herb-${herb.id}`;
                  const isOpen = !collapsedSections.has(key);
                  return (
                    <div key={key} ref={(el) => { sectionRefs.current[key] = el; }} className="border border-gray-100 rounded-lg p-4 scroll-mt-4">
                      <div className="flex items-start gap-2">
                        <button
                          onClick={() => toggleSection(key)}
                          className="mt-0.5 shrink-0 text-gray-400 hover:text-gray-600 transition-colors"
                          aria-label={isOpen ? 'Collapse' : 'Expand'}
                        >
                          <svg className={`w-4 h-4 transition-transform ${isOpen ? '' : '-rotate-90'}`} fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                          </svg>
                        </button>
                        <div>
                          <button
                            onClick={() => onHerbClick(herb.id)}
                            className="font-semibold text-green-800 hover:text-green-600 hover:underline text-base leading-tight"
                          >
                            {herb.common_name}{herb.plant_part ? ` (${herb.plant_part})` : ''}
                          </button>
                          <div className="text-xs italic text-gray-400 mt-0.5">{herb.latin_name}</div>
                        </div>
                      </div>
                      {isOpen && (
                        <div className="mt-3">
                          <SnippetList snippets={snippets} highlightTerms={[herb.common_name, herb.latin_name, herb.latin_name.split(' ')[0], ...(herb.synonyms ?? [])]} />
                        </div>
                      )}
                    </div>
                  );
                })}

                {detail?.supplements.map((supp) => {
                  const snippets = detail.snippetsBySupplement.get(supp.id) ?? [];
                  const key = `supp-${supp.id}`;
                  const isOpen = !collapsedSections.has(key);
                  return (
                    <div key={key} ref={(el) => { sectionRefs.current[key] = el; }} className="border border-gray-100 rounded-lg p-4 scroll-mt-4">
                      <div className="flex items-center gap-2">
                        <button
                          onClick={() => toggleSection(key)}
                          className="shrink-0 text-gray-400 hover:text-gray-600 transition-colors"
                          aria-label={isOpen ? 'Collapse' : 'Expand'}
                        >
                          <svg className={`w-4 h-4 transition-transform ${isOpen ? '' : '-rotate-90'}`} fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                          </svg>
                        </button>
                        <button
                          onClick={() => onSupplementClick(supp.id)}
                          className="font-semibold text-indigo-800 hover:text-indigo-600 hover:underline text-base leading-tight"
                        >
                          {supp.name}
                        </button>
                        <span className="text-[10px] px-1.5 py-0.5 rounded-full border bg-indigo-50 border-indigo-200 text-indigo-700 font-semibold">
                          {supp.category}
                        </span>
                      </div>
                      {isOpen && (
                        <div className="mt-3">
                          <SnippetList snippets={snippets} highlightTerms={[supp.name]} />
                        </div>
                      )}
                    </div>
                  );
                })}
              </div>
            )}
          </div>
        ) : (
          /* ── Overview: all ailment keywords ─────────────────────────────── */
          <div>
            <div className="flex items-center gap-2 mb-5 flex-wrap">
              <h3 className="text-lg font-semibold text-gray-700">All Inferred Ailments</h3>
              <span className="text-xs font-medium bg-amber-100 text-amber-700 border border-amber-200 px-2 py-0.5 rounded-full">
                from class notes
              </span>
              <input
                type="text"
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                onKeyDown={(e) => { if (e.key === 'Escape') setSearchQuery(''); }}
                placeholder="Search ailments…"
                className="border border-gray-200 rounded-lg px-3 py-1 text-sm text-gray-700 placeholder-gray-400 focus:outline-none focus:border-amber-400 w-48"
              />
            </div>
            <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-2">
              {visibleAilments.length > 0 ? visibleAilments.map((a) => (
                <button
                  key={a.keyword}
                  onClick={() => selectAilment(a.keyword)}
                  className="text-left border border-amber-200 bg-amber-50/40 hover:bg-amber-100 hover:border-amber-300 rounded-lg px-3 py-2.5 transition-all"
                >
                  <div className="font-medium text-sm text-gray-800 capitalize">{a.keyword}</div>
                  <div className="text-xs text-amber-600 mt-0.5">
                    {totalCount(a)} {totalCount(a) !== 1 ? 'entries' : 'entry'}
                  </div>
                </button>
              )) : (
                <p className="col-span-3 text-sm text-gray-400 italic py-4">No ailments match "{searchQuery}".</p>
              )}
            </div>
          </div>
        )}
      </div>
    </div>
  );
}

function SnippetList({ snippets, highlightTerms }: { snippets: ClassNoteSnippet[]; highlightTerms: string[] }) {
  if (snippets.length === 0) {
    return <p className="text-xs text-gray-400 italic">No snippets recorded.</p>;
  }
  return (
    <div className="space-y-2 pl-3 border-l-2 border-teal-100">
      {snippets.map((snippet) => (
        <div key={snippet.id} className="border border-teal-200 rounded-lg px-3 py-2 bg-teal-50/50">
          <p className="text-sm text-gray-800">{snippet.snippet_text}</p>
          <div className="flex flex-wrap items-center gap-2 mt-1.5">
            <a
              href="https://1drv.ms/f/c/2C944FF46704ED09/IgDp6eLOYY2nSqOl4q-5M-MjAXgrqOPXRbJsZZFM8nCRBeA?e=YPDjNw"
              target="_blank"
              rel="noopener noreferrer"
              className="text-xs text-teal-700 font-medium hover:text-teal-900 hover:underline"
              onClick={(e) => e.stopPropagation()}
            >
              {snippet.class_name}
            </a>
            {snippet.section_header && (
              <>
                <span className="text-xs text-teal-300">·</span>
                <span className="text-xs text-teal-600">{snippet.section_header}</span>
              </>
            )}
            <span className={`ml-auto text-[10px] px-1.5 py-0.5 rounded-full border font-semibold ${
              snippet.note_type === 'personal'
                ? 'bg-purple-50 border-purple-200 text-purple-700'
                : 'bg-sky-50 border-sky-200 text-sky-700'
            }`}>
              {snippet.note_type === 'personal' ? 'personal' : 'generated'}
            </span>
          </div>
          {snippet.source_block && (
            <details className="mt-1.5">
              <summary className="text-xs text-teal-500 cursor-pointer select-none hover:text-teal-700">
                View in context
              </summary>
              <blockquote className="mt-1.5 pl-3 border-l-2 border-teal-300 text-xs text-gray-600 whitespace-pre-wrap font-mono leading-relaxed">
                {highlightName(snippet.source_block, highlightTerms)}
              </blockquote>
            </details>
          )}
        </div>
      ))}
    </div>
  );
}
