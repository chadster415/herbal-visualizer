'use client';

import { useState, useEffect, useRef, useMemo, useCallback } from 'react';
import dynamic from 'next/dynamic';
import { supabase } from '@/lib/supabase';
import { ArrowsPointingInIcon, PlusCircleIcon, MinusCircleIcon, TableCellsIcon, XMarkIcon, ChevronRightIcon } from '@heroicons/react/24/outline';

const ForceGraph2D = dynamic(() => import('react-force-graph-2d'), { ssr: false });

interface GraphNode {
  id: number;
  name: string;
  pairType: 'dui_yao' | 'western' | 'both';
  degree: number;
  x?: number;
  y?: number;
  vx?: number;
  vy?: number;
}

interface GraphLink {
  source: number | GraphNode;
  target: number | GraphNode;
  pairType: 'dui_yao' | 'western';
  pairSource?: string;
  tooltip?: string;
}

interface PairingsViewProps {
  onHerbClick: (herbId: number) => void;
  onFocusChange?: (herbId: number | null) => void;
  initialFocusId?: number | null;
}

const NODE_COLORS: Record<string, string> = {
  dui_yao: '#818cf8',
  western:  '#fbbf24',
  both:    '#34d399',
};


function resolveId(endpoint: number | GraphNode): number {
  return typeof endpoint === 'object' ? endpoint.id : endpoint;
}

export function PairingsView({ onHerbClick, onFocusChange, initialFocusId }: PairingsViewProps) {
  const [graphData, setGraphData] = useState<{ nodes: GraphNode[]; links: GraphLink[] }>({ nodes: [], links: [] });
  const [loading, setLoading] = useState(true);
  const [filter, setFilter] = useState<'all' | 'dui_yao' | 'western'>('all');
  const [focusedId, setFocusedId] = useState<number | null>(null);
  const [showSecondary, setShowSecondary] = useState(false);
  const [showTable, setShowTable] = useState(false);
  const [expandedPrimary, setExpandedPrimary] = useState<Set<number>>(new Set());
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const graphRef = useRef<any>(null);
  const pendingZoomRef = useRef(false);
  const prevInitialFocusRef = useRef<number | null | undefined>(undefined);
  const prevFilterRef = useRef<'all' | 'dui_yao' | 'western'>('all');
  const containerRef = useRef<HTMLDivElement>(null);
  const [graphWidth, setGraphWidth] = useState(600);
  const [graphHeight, setGraphHeight] = useState(600);
  const [graphReady, setGraphReady] = useState(false);
  const graphReadyRef = useRef(false);

  useEffect(() => {
    const el = containerRef.current;
    if (!el) return;
    const ro = new ResizeObserver(() => {
      setGraphWidth(el.clientWidth);
      setGraphHeight(el.clientHeight);
    });
    ro.observe(el);
    return () => ro.disconnect();
  }, []);

  useEffect(() => {
    async function load() {
      const [duiYaoRes, westernRes, herbsRes] = await Promise.all([
        supabase.from('dui_yao_pairs').select('herb1_id, herb2_id, combined_summary, dui_yao_indications(indication, sort_order)'),
        supabase.from('herb_pairs').select('herb1_id, herb2_id, source, combined_summary, herb_pair_herb_properties(herb_id, property, sort_order)'),
        supabase.from('herbs').select('id, common_name'),
      ]);



      const herbName = new Map((herbsRes.data ?? []).map((h) => [h.id, h.common_name as string]));
      const nodeMap = new Map<number, GraphNode>();
      const links: GraphLink[] = [];

      function touch(id: number, type: 'dui_yao' | 'western') {
        const name = herbName.get(id);
        if (!name) return;
        if (!nodeMap.has(id)) {
          nodeMap.set(id, { id, name, pairType: type, degree: 0 });
        } else {
          const n = nodeMap.get(id)!;
          if (n.pairType !== type) n.pairType = 'both';
        }
        nodeMap.get(id)!.degree++;
      }

      for (const { herb1_id, herb2_id, combined_summary, dui_yao_indications } of duiYaoRes.data ?? []) {
        touch(herb1_id, 'dui_yao');
        touch(herb2_id, 'dui_yao');
        const tooltipParts: string[] = [];
        if (combined_summary) tooltipParts.push(combined_summary);
        const indications = [...((dui_yao_indications as { indication: string; sort_order: number }[]) ?? [])]
          .sort((a, b) => a.sort_order - b.sort_order)
          .map((i) => `• ${i.indication}`);
        if (indications.length > 0) tooltipParts.push(`Indications:\n${indications.join('\n')}`);
        links.push({ source: herb1_id, target: herb2_id, pairType: 'dui_yao', tooltip: tooltipParts.join('\n\n') || undefined });
      }

      // eslint-disable-next-line @typescript-eslint/no-explicit-any
      for (const { herb1_id, herb2_id, source, combined_summary, herb_pair_herb_properties } of (westernRes.data ?? []) as any[]) {
        touch(herb1_id, 'western');
        touch(herb2_id, 'western');
        const propText = (herb_pair_herb_properties as { herb_id: number; property: string; sort_order: number }[] ?? [])
          .sort((a, b) => a.sort_order - b.sort_order)
          .map((p) => p.property)
          .join('\n');
        const tooltip = combined_summary || propText || undefined;
        links.push({ source: herb1_id, target: herb2_id, pairType: 'western', pairSource: source ?? undefined, tooltip });
      }

      setGraphData({ nodes: Array.from(nodeMap.values()), links });
      setLoading(false);
    }
    load();
  }, []);

  // When initialFocusId arrives, focus that node and zoom to it + its neighbors
  useEffect(() => {
    const prev = prevInitialFocusRef.current;
    prevInitialFocusRef.current = initialFocusId;

    if (initialFocusId == null) {
      if (prev !== undefined && prev !== null) {
        setFocusedId(null);
        setTimeout(() => graphRef.current?.zoomToFit(400, 40), 50);
      }
      return;
    }
    if (focusedId === initialFocusId) return; // eslint-disable-line react-hooks/exhaustive-deps
    setFocusedId(initialFocusId);
    pendingZoomRef.current = true;
    if (!loading) {
      const node = graphData.nodes.find((n) => n.id === initialFocusId);
      if (node?.x !== undefined) {
        pendingZoomRef.current = false;
        const neighborSet = new Set<number>();
        for (const link of displayData.links) {
          const src = resolveId(link.source);
          const tgt = resolveId(link.target);
          if (src === initialFocusId) neighborSet.add(tgt);
          if (tgt === initialFocusId) neighborSet.add(src);
        }
        const focId = initialFocusId;
        setTimeout(() => {
          const ft = !graphReadyRef.current;
          graphRef.current?.zoomToFit(ft ? 0 : 400, 60, (n: object) => {
            const id = (n as GraphNode).id;
            return id === focId || neighborSet.has(id);
          });
          if (ft) { graphReadyRef.current = true; setGraphReady(true); }
        }, 80);
      }
    }
  }, [initialFocusId]); // eslint-disable-line react-hooks/exhaustive-deps

  // After data loads: if focused herb has no pairings, clear focus
  useEffect(() => {
    if (loading) return;
    if (focusedId !== null && !graphData.nodes.some((n) => n.id === focusedId)) {
      setFocusedId(null);
    }
  }, [loading]); // eslint-disable-line react-hooks/exhaustive-deps

  useEffect(() => {
    if (prevFilterRef.current === filter) return;
    prevFilterRef.current = filter;
    setFocusedId(null);
  }, [filter]);

  // Reset secondary/table whenever focus changes
  useEffect(() => {
    setShowSecondary(false);
    setShowTable(false);
    setExpandedPrimary(new Set());
  }, [focusedId]);

  useEffect(() => {
    function onKey(e: KeyboardEvent) {
      if (e.key === 'Escape' && focusedId !== null) resetFocus();
    }
    window.addEventListener('keydown', onKey);
    return () => window.removeEventListener('keydown', onKey);
  }, [focusedId]); // eslint-disable-line react-hooks/exhaustive-deps

  const displayData = useMemo(() => {
    if (filter === 'all') return graphData;
    const filteredLinks = graphData.links.filter((l) => l.pairType === filter);
    const visibleIds = new Set(filteredLinks.flatMap((l) => [resolveId(l.source), resolveId(l.target)]));
    return {
      nodes: graphData.nodes.filter((n) => visibleIds.has(n.id)),
      links: filteredLinks,
    };
  }, [graphData, filter]);

  const neighborIds = useMemo(() => {
    if (focusedId === null) return new Set<number>();
    const ids = new Set<number>();
    for (const link of displayData.links) {
      const src = resolveId(link.source);
      const tgt = resolveId(link.target);
      if (src === focusedId) ids.add(tgt);
      if (tgt === focusedId) ids.add(src);
    }
    return ids;
  }, [focusedId, displayData.links]);

  // Second-hop nodes (neighbors of neighbors, excluding focused)
  const secondaryData = useMemo(() => {
    if (focusedId === null) return { ids: new Set<number>(), links: [] as GraphLink[] };
    const secondary = new Set<number>();
    const secondaryLinks: GraphLink[] = [];
    for (const link of displayData.links) {
      const src = resolveId(link.source);
      const tgt = resolveId(link.target);
      if (neighborIds.has(src) && !neighborIds.has(tgt) && tgt !== focusedId) {
        secondary.add(tgt);
        secondaryLinks.push(link);
      }
      if (neighborIds.has(tgt) && !neighborIds.has(src) && src !== focusedId) {
        secondary.add(src);
        secondaryLinks.push(link);
      }
    }
    return { ids: secondary, links: secondaryLinks };
  }, [focusedId, neighborIds, displayData.links]);

  const neighborTooltips = useMemo(() => {
    if (focusedId === null) return new Map<number, string>();
    const map = new Map<number, string>();
    for (const link of displayData.links) {
      const src = resolveId(link.source);
      const tgt = resolveId(link.target);
      if (src === focusedId && link.tooltip) map.set(tgt, link.tooltip);
      if (tgt === focusedId && link.tooltip) map.set(src, link.tooltip);
    }
    return map;
  }, [focusedId, displayData.links]);

  // When focused, color neighbors by how they connect to the focused herb (not their global type)
  const neighborLinkTypes = useMemo(() => {
    if (focusedId === null) return new Map<number, 'dui_yao' | 'western' | 'both'>();
    const map = new Map<number, 'dui_yao' | 'western' | 'both'>();
    for (const link of displayData.links) {
      const src = resolveId(link.source);
      const tgt = resolveId(link.target);
      const neighborId = src === focusedId ? tgt : tgt === focusedId ? src : null;
      if (neighborId === null) continue;
      const existing = map.get(neighborId);
      map.set(neighborId, !existing ? link.pairType : existing !== link.pairType ? 'both' : existing);
    }
    return map;
  }, [focusedId, displayData.links]);

  const secondaryTooltips = useMemo(() => {
    const map = new Map<number, string>();
    for (const link of secondaryData.links) {
      const src = resolveId(link.source);
      const tgt = resolveId(link.target);
      if (neighborIds.has(src) && link.tooltip && !map.has(tgt)) map.set(tgt, link.tooltip);
      if (neighborIds.has(tgt) && link.tooltip && !map.has(src)) map.set(src, link.tooltip);
    }
    return map;
  }, [secondaryData.links, neighborIds]);

  // Table data: primary rows + secondary rows grouped by primary herb ID
  const { primaryTableRows, secondaryByPrimary } = useMemo(() => {
    if (focusedId === null) return { primaryTableRows: [], secondaryByPrimary: new Map<number, { herbId: number; herbName: string; pairType: 'dui_yao' | 'western'; pairSource?: string; tooltip: string }[]>() };
    const nodeById = new Map(graphData.nodes.map((n) => [n.id, n]));

    const primaryRows: { herbId: number; herbName: string; pairType: 'dui_yao' | 'western'; pairSource?: string; tooltip: string }[] = [];
    for (const link of displayData.links) {
      const src = resolveId(link.source);
      const tgt = resolveId(link.target);
      let neighborId: number | null = null;
      if (src === focusedId) neighborId = tgt;
      else if (tgt === focusedId) neighborId = src;
      if (neighborId === null) continue;
      const node = nodeById.get(neighborId);
      if (!node) continue;
      primaryRows.push({ herbId: neighborId, herbName: node.name, pairType: link.pairType, pairSource: link.pairSource, tooltip: link.tooltip ?? '' });
    }

    // Group secondary connections by the primary herb they connect through
    const byPrimary = new Map<number, { herbId: number; herbName: string; pairType: 'dui_yao' | 'western'; pairSource?: string; tooltip: string }[]>();
    for (const row of primaryRows) byPrimary.set(row.herbId, []);
    for (const link of secondaryData.links) {
      const src = resolveId(link.source);
      const tgt = resolveId(link.target);
      let secondaryHerbId: number, viaHerbId: number;
      if (neighborIds.has(src)) { secondaryHerbId = tgt; viaHerbId = src; }
      else { secondaryHerbId = src; viaHerbId = tgt; }
      const secondaryNode = nodeById.get(secondaryHerbId);
      if (!secondaryNode) continue;
      byPrimary.get(viaHerbId)?.push({ herbId: secondaryHerbId, herbName: secondaryNode.name, pairType: link.pairType, pairSource: link.pairSource, tooltip: link.tooltip ?? '' });
    }

    return { primaryTableRows: primaryRows, secondaryByPrimary: byPrimary };
  }, [focusedId, displayData.links, graphData.nodes, secondaryData.links, neighborIds]);

  const getNodeLabel = useCallback(
    (node: object) => {
      const n = node as GraphNode;
      if (focusedId !== null && n.id !== focusedId) {
        const tooltip = neighborTooltips.get(n.id) ?? secondaryTooltips.get(n.id);
        if (tooltip) return tooltip;
      }
      return n.name;
    },
    [focusedId, neighborTooltips, secondaryTooltips],
  );

  const getNodeVisibility = useCallback(
    (node: object) => {
      const id = (node as GraphNode).id;
      if (focusedId === null) return true;
      return id === focusedId || neighborIds.has(id) || (showSecondary && secondaryData.ids.has(id));
    },
    [focusedId, neighborIds, showSecondary, secondaryData.ids],
  );

  const getLinkVisibility = useCallback(
    (link: object) => {
      if (focusedId === null) return true;
      const src = resolveId((link as GraphLink).source);
      const tgt = resolveId((link as GraphLink).target);
      if (src === focusedId || tgt === focusedId) return true;
      if (showSecondary) {
        return (neighborIds.has(src) && secondaryData.ids.has(tgt)) ||
               (neighborIds.has(tgt) && secondaryData.ids.has(src));
      }
      return false;
    },
    [focusedId, showSecondary, neighborIds, secondaryData.ids],
  );

  function resetFocus() {
    setFocusedId(null);
    setTimeout(() => graphRef.current?.zoomToFit(400, 40), 50);
  }

  const handleRecenter = useCallback(() => {
    if (focusedId === null) return;
    const fid = focusedId;
    const nb = neighborIds;
    const sec = showSecondary ? secondaryData.ids : new Set<number>();
    graphRef.current?.zoomToFit(400, 60, (nd: object) => {
      const id = (nd as GraphNode).id;
      return id === fid || nb.has(id) || sec.has(id);
    });
  }, [focusedId, neighborIds, showSecondary, secondaryData.ids]);

  const handleToggleSecondary = useCallback(() => {
    if (focusedId === null) return;
    const next = !showSecondary;
    setShowSecondary(next);
    const fid = focusedId;
    const nb = neighborIds;
    const sec = next ? secondaryData.ids : new Set<number>();
    setTimeout(() => graphRef.current?.zoomToFit(400, 60, (nd: object) => {
      const id = (nd as GraphNode).id;
      return id === fid || nb.has(id) || sec.has(id);
    }), 80);
  }, [showSecondary, focusedId, neighborIds, secondaryData.ids]);

  const handleNodeClick = useCallback(
    (node: object) => {
      const n = node as GraphNode & { x?: number; y?: number };
      if (n.id === focusedId) {
        onHerbClick(n.id);
        return;
      }
      setFocusedId(n.id);
      onFocusChange?.(n.id);
      const neighborSet = new Set<number>();
      for (const link of displayData.links) {
        const src = resolveId(link.source);
        const tgt = resolveId(link.target);
        if (src === n.id) neighborSet.add(tgt);
        if (tgt === n.id) neighborSet.add(src);
      }
      const clickedId = n.id;
      setTimeout(() => graphRef.current?.zoomToFit(400, 60, (nd: object) => {
        const id = (nd as GraphNode).id;
        return id === clickedId || neighborSet.has(id);
      }), 80);
    },
    [focusedId, onHerbClick, onFocusChange, displayData.links],
  );

  const handleBackgroundClick = useCallback(() => {
    if (focusedId !== null) resetFocus();
  }, [focusedId]); // eslint-disable-line react-hooks/exhaustive-deps

  const handleEngineStop = useCallback(() => {
    const firstTime = !graphReadyRef.current;
    const dur = firstTime ? 0 : 400;
    const reveal = () => { if (firstTime) { graphReadyRef.current = true; setGraphReady(true); } };

    if (pendingZoomRef.current) {
      pendingZoomRef.current = false;
      if (focusedId !== null) {
        const fid = focusedId;
        const nb = neighborIds;
        setTimeout(() => {
          graphRef.current?.zoomToFit(dur, 60, (nd: object) => {
            const id = (nd as GraphNode).id;
            return id === fid || nb.has(id);
          });
          reveal();
        }, 80);
        return;
      }
      graphRef.current?.zoomToFit(dur, 40);
      reveal();
    } else if (focusedId === null) {
      graphRef.current?.zoomToFit(dur, 40);
      reveal();
    }
  }, [focusedId, neighborIds]);

  const getNodeVal = useCallback((node: object) => Math.max(1, (node as GraphNode).degree), []);

  const getLinkLabel = useCallback((link: object) => {
    const l = link as GraphLink;
    if (l.pairType !== 'western' || !l.pairSource) return '';
    return l.pairSource.split(',')[0].trim();
  }, []);

  const paintNode = useCallback(
    (node: object, ctx: CanvasRenderingContext2D, globalScale: number) => {
      const n = node as GraphNode & { x: number; y: number };
      if (n.x === undefined) return;
      const isFocused = n.id === focusedId;
      const isSecondary = showSecondary && secondaryData.ids.has(n.id);
      const r = Math.sqrt(Math.max(1, n.degree)) * 3.5 + 4 + (isFocused ? 3 : 0) - (isSecondary ? 1.5 : 0);
      const effectiveType = (!isFocused && focusedId !== null && neighborLinkTypes.has(n.id))
        ? neighborLinkTypes.get(n.id)!
        : n.pairType;
      const color = NODE_COLORS[effectiveType];

      ctx.save();
      ctx.globalAlpha = isSecondary ? 0.5 : 1;
      ctx.shadowColor = color;
      ctx.shadowBlur = isFocused ? 22 : 10;
      ctx.beginPath();
      ctx.arc(n.x, n.y, r, 0, 2 * Math.PI);
      ctx.fillStyle = color;
      ctx.fill();
      ctx.restore();

      ctx.save();
      ctx.globalAlpha = isSecondary ? 0.5 : 1;
      ctx.beginPath();
      ctx.arc(n.x, n.y, r, 0, 2 * Math.PI);
      ctx.strokeStyle = isFocused ? '#ffffff' : 'rgba(255,255,255,0.85)';
      ctx.lineWidth = (isFocused ? 2.5 : 1.2) / globalScale;
      ctx.stroke();

      const fontSize = Math.max(3, (isFocused ? 12 : 10) / globalScale);
      ctx.font = `${isFocused ? 'bold ' : ''}${fontSize}px system-ui, -apple-system, sans-serif`;
      ctx.textAlign = 'center';
      ctx.textBaseline = 'top';
      ctx.fillStyle = isSecondary ? 'rgba(255,255,255,0.3)' : 'rgba(255,255,255,0.75)';
      ctx.fillText(n.name, n.x + 0.3 / globalScale, n.y + r + 1.3 / globalScale);
      ctx.fillStyle = isSecondary ? '#9ca3af' : (isFocused ? '#111827' : '#374151');
      ctx.fillText(n.name, n.x, n.y + r + 1 / globalScale);
      ctx.restore();
    },
    [focusedId, showSecondary, secondaryData.ids, neighborLinkTypes],
  );

  const paintLink = useCallback((link: object, ctx: CanvasRenderingContext2D) => {
    const l = link as GraphLink & { source: { x?: number; y?: number }; target: { x?: number; y?: number } };
    const sx = l.source.x, sy = l.source.y, tx = l.target.x, ty = l.target.y;
    if (sx === undefined || tx === undefined) return;
    const srcId = (l.source as unknown as { id?: number }).id;
    const tgtId = (l.target as unknown as { id?: number }).id;
    const isSecondaryLink = showSecondary && srcId !== undefined && tgtId !== undefined && (
      (neighborIds.has(srcId) && secondaryData.ids.has(tgtId)) ||
      (neighborIds.has(tgtId) && secondaryData.ids.has(srcId))
    );
    ctx.save();
    ctx.globalAlpha = isSecondaryLink ? 0.35 : 1;
    ctx.beginPath();
    if (l.pairType === 'western') {
      ctx.setLineDash([4, 3]);
      ctx.strokeStyle = 'rgba(245, 158, 11, 0.55)';
      ctx.lineWidth = 1.2;
    } else {
      ctx.setLineDash([]);
      ctx.strokeStyle = 'rgba(99, 102, 241, 0.65)';
      ctx.lineWidth = 1.8;
    }
    ctx.moveTo(sx, sy!);
    ctx.lineTo(tx, ty!);
    ctx.stroke();
    ctx.restore();
  }, [showSecondary, neighborIds, secondaryData.ids]);

  const focusedNode = focusedId !== null ? graphData.nodes.find((n) => n.id === focusedId) ?? null : null;

  return (
    <div className="flex flex-col flex-1 min-h-0">
      {/* Header + filter tabs */}
      <div className="px-5 py-3 border-b border-gray-100 flex items-center justify-between shrink-0">
        <h2 className="font-semibold text-gray-800 text-base">Herb Pairings Network</h2>
        {focusedId !== null ? (
          <button
            onClick={() => onHerbClick(focusedId)}
            className="px-3 py-1 text-xs font-medium text-green-700 border border-green-300 rounded-full hover:bg-green-50 transition-colors"
          >
            View herb →
          </button>
        ) : (
          <div className="flex gap-1.5">
            {(['all', 'dui_yao', 'western'] as const).map((f) => (
              <button
                key={f}
                onClick={() => setFilter(f)}
                className={`px-3 py-1 rounded-full text-xs font-medium transition-colors ${
                  filter === f ? 'bg-green-600 text-white shadow-sm' : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
                }`}
              >
                {f === 'all' ? 'All' : f === 'dui_yao' ? 'Dui Yao' : 'Western'}
              </button>
            ))}
          </div>
        )}
      </div>

      {/* Focus banner (only when focused) */}
      {focusedNode && (
        <div className="px-5 py-2 border-b border-gray-100 flex items-center gap-3 shrink-0 bg-gray-50">
          <span className="w-2.5 h-2.5 rounded-full shrink-0" style={{ backgroundColor: NODE_COLORS[focusedNode.pairType] }} />
          <div className="flex flex-col min-w-0">
            <span className="font-medium text-gray-900 text-sm leading-tight">{focusedNode.name}</span>
            <span className="text-xs text-gray-400 leading-tight">{neighborIds.size} connection{neighborIds.size !== 1 ? 's' : ''}</span>
          </div>
          <div className="ml-auto flex gap-1.5">
            <button
              onClick={handleRecenter}
              title="Recenter on selected herb and its connections"
              className="flex items-center gap-1 px-2.5 py-1 text-xs font-medium bg-white text-gray-700 border border-gray-200 rounded-full hover:bg-gray-50 transition-colors"
            >
              <ArrowsPointingInIcon className="w-3.5 h-3.5" />
              Recenter
            </button>
            <button
              onClick={handleToggleSecondary}
              title={showSecondary ? 'Hide secondary connections' : 'Show second-level connections from primary herbs'}
              className={`flex items-center gap-1 px-2.5 py-1 text-xs font-medium border rounded-full transition-colors ${
                showSecondary
                  ? 'bg-indigo-600 text-white border-indigo-500 hover:bg-indigo-700'
                  : 'bg-white text-gray-700 border-gray-200 hover:bg-gray-50'
              }`}
            >
              {showSecondary ? <MinusCircleIcon className="w-3.5 h-3.5" /> : <PlusCircleIcon className="w-3.5 h-3.5" />}
              2nd
            </button>
            <button
              onClick={() => setShowTable((v) => !v)}
              title={showTable ? 'Hide details table' : 'Show pairing descriptions in a table'}
              className={`flex items-center gap-1 px-2.5 py-1 text-xs font-medium border rounded-full transition-colors ${
                showTable
                  ? 'bg-indigo-600 text-white border-indigo-500 hover:bg-indigo-700'
                  : 'bg-white text-gray-700 border-gray-200 hover:bg-gray-50'
              }`}
            >
              <TableCellsIcon className="w-3.5 h-3.5" />
              Details
            </button>
          </div>
        </div>
      )}

      {/* Legend (always visible) */}
      <div className="px-5 py-2 border-b border-gray-50 flex flex-wrap gap-x-5 gap-y-1 items-center text-xs text-gray-500 shrink-0">
        <span className="flex items-center gap-1.5">
          <span className="w-2.5 h-2.5 rounded-full bg-indigo-400 inline-block shrink-0" />
          Dui Yao
        </span>
        <span className="flex items-center gap-1.5">
          <span className="inline-block shrink-0" style={{ width: 18, height: 0, borderBottom: '2px dashed #fbbf24', verticalAlign: 'middle', marginTop: -1 }} />
          <span className="w-2.5 h-2.5 rounded-full bg-amber-400 inline-block shrink-0 ml-1" />
          Western
        </span>
        <span className="flex items-center gap-1.5">
          <span className="w-2.5 h-2.5 rounded-full bg-emerald-400 inline-block shrink-0" />
          Both
        </span>
        {!focusedNode && (
          <span className="ml-auto text-gray-400 text-[11px] hidden sm:block">
            Click to focus · click again to view herb · Esc to reset
          </span>
        )}
      </div>

      {/* Canvas */}
      <div ref={containerRef} className="flex-1 min-h-0 relative overflow-hidden">
        {(loading || !graphReady) && (
          <div className="absolute inset-0 flex items-center justify-center text-gray-400 text-sm italic z-10">Loading pairings…</div>
        )}
        {!loading && (
          <div style={{ opacity: graphReady ? 1 : 0, transition: graphReady ? 'opacity 0.1s ease' : 'none' }}>
            <ForceGraph2D
              ref={graphRef}
              graphData={displayData}
              width={graphWidth}
              height={graphHeight}
              nodeLabel={getNodeLabel}
              nodeVal={getNodeVal}
              nodeCanvasObject={paintNode}
              nodeCanvasObjectMode={() => 'replace'}
              nodeVisibility={getNodeVisibility}
              linkLabel={getLinkLabel}
              linkCanvasObject={paintLink}
              linkCanvasObjectMode={() => 'replace'}
              linkVisibility={getLinkVisibility}
              onNodeClick={handleNodeClick}
              onBackgroundClick={handleBackgroundClick}
              onEngineStop={handleEngineStop}
              cooldownTicks={200}
              d3AlphaDecay={0.015}
              d3VelocityDecay={0.25}
              backgroundColor="#ffffff"
            />
          </div>
        )}

        {/* Table overlay */}
        {showTable && focusedId !== null && focusedNode && (
          <div className="absolute inset-0 z-20 bg-white/97 overflow-auto">
            <div className="sticky top-0 bg-white/95 backdrop-blur-sm border-b border-gray-100 px-5 py-3 flex items-center justify-between">
              <div>
                <button
                  onClick={() => onHerbClick(focusedNode.id)}
                  className="font-semibold text-gray-900 text-sm hover:text-indigo-600 hover:underline transition-colors"
                >
                  {focusedNode.name}
                </button>
                <span className="text-xs text-gray-400 ml-2">— pairing connections</span>
              </div>
              <button
                onClick={() => setShowTable(false)}
                className="p-1 text-gray-400 hover:text-gray-600 transition-colors"
              >
                <XMarkIcon className="w-4 h-4" />
              </button>
            </div>

            <div className="p-4 space-y-5">
              {/* Primary connections */}
              <section>
                <div className="flex items-center justify-between mb-2.5">
                  <h4 className="text-[11px] font-semibold uppercase tracking-widest text-gray-400">
                    Primary connections ({primaryTableRows.length})
                  </h4>
                  {primaryTableRows.some((r) => (secondaryByPrimary.get(r.herbId) ?? []).length > 0) && (() => {
                    const expandableIds = primaryTableRows
                      .filter((r) => (secondaryByPrimary.get(r.herbId) ?? []).length > 0)
                      .map((r) => r.herbId);
                    const allExpanded = expandableIds.every((id) => expandedPrimary.has(id));
                    return (
                      <button
                        onClick={() => setExpandedPrimary(allExpanded ? new Set() : new Set(expandableIds))}
                        className="flex items-center gap-1 mr-3 text-[11px] text-gray-400 hover:text-gray-600 transition-colors"
                      >
                        {allExpanded ? 'Collapse all' : 'Expand all'}
                        <ChevronRightIcon className={`w-3.5 h-3.5 transition-transform duration-150 ${allExpanded ? 'rotate-90' : ''}`} />
                      </button>
                    );
                  })()}
                </div>
                <div className="space-y-2">
                  {primaryTableRows.map((row) => {
                    const secondaries = secondaryByPrimary.get(row.herbId) ?? [];
                    const isExpanded = expandedPrimary.has(row.herbId);
                    return (
                      <div key={row.herbId} className="border border-gray-100 rounded-lg bg-gray-50">
                        <div className="p-3">
                          <div className="flex items-center gap-2 mb-1.5">
                            <span
                              className="w-2 h-2 rounded-full shrink-0"
                              style={{ backgroundColor: NODE_COLORS[row.pairType] }}
                            />
                            <button
                              onClick={() => onHerbClick(row.herbId)}
                              className="font-medium text-gray-900 text-sm hover:text-indigo-600 hover:underline transition-colors text-left"
                            >
                              {row.herbName}
                            </button>
                            <span className={`text-[10px] px-1.5 py-0.5 rounded-full font-medium shrink-0 ${
                              row.pairType === 'dui_yao'
                                ? 'bg-indigo-100 text-indigo-700'
                                : 'bg-amber-100 text-amber-700'
                            }`}>
                              {row.pairType === 'dui_yao' ? 'Dui Yao' : (row.pairSource ? row.pairSource.split(',')[0].trim() : 'Western')}
                            </span>
                            {secondaries.length > 0 && (
                              <button
                                onClick={() => setExpandedPrimary((prev) => {
                                  const next = new Set(prev);
                                  if (next.has(row.herbId)) next.delete(row.herbId);
                                  else next.add(row.herbId);
                                  return next;
                                })}
                                title={isExpanded ? 'Hide secondary connections' : `${secondaries.length} secondary connection${secondaries.length !== 1 ? 's' : ''}`}
                                className="ml-auto p-0.5 text-gray-400 hover:text-gray-600 transition-colors flex items-center gap-1"
                              >
                                <span className="text-[10px] text-gray-400">{secondaries.length}</span>
                                <ChevronRightIcon className={`w-3.5 h-3.5 transition-transform duration-150 ${isExpanded ? 'rotate-90' : ''}`} />
                              </button>
                            )}
                          </div>
                          {row.tooltip ? (
                            <p className="text-xs text-gray-600 whitespace-pre-line leading-relaxed">{row.tooltip}</p>
                          ) : (
                            <p className="text-xs text-gray-400 italic">No description available</p>
                          )}
                        </div>

                        {/* Inline secondary connections for this primary herb */}
                        {isExpanded && secondaries.length > 0 && (
                          <div className="border-t border-gray-100 mx-3 mb-3 pt-2.5 space-y-2.5">
                            {secondaries.map((sec) => (
                              <div key={sec.herbId} className="pl-3 border-l-2 border-gray-200">
                                <div className="flex items-center gap-1.5 mb-0.5">
                                  <span
                                    className="w-1.5 h-1.5 rounded-full shrink-0"
                                    style={{ backgroundColor: NODE_COLORS[sec.pairType] }}
                                  />
                                  <button
                                    onClick={() => onHerbClick(sec.herbId)}
                                    className="font-medium text-gray-700 text-xs hover:text-indigo-600 hover:underline transition-colors text-left"
                                  >
                                    {sec.herbName}
                                  </button>
                                  <span className={`text-[9px] px-1 py-0.5 rounded-full font-medium shrink-0 ${
                                    sec.pairType === 'dui_yao'
                                      ? 'bg-indigo-100 text-indigo-600'
                                      : 'bg-amber-100 text-amber-600'
                                  }`}>
                                    {sec.pairType === 'dui_yao' ? 'Dui Yao' : (sec.pairSource ? sec.pairSource.split(',')[0].trim() : 'Western')}
                                  </span>
                                </div>
                                {sec.tooltip ? (
                                  <p className="text-[11px] text-gray-500 whitespace-pre-line leading-relaxed">{sec.tooltip}</p>
                                ) : (
                                  <p className="text-[11px] text-gray-400 italic">No description</p>
                                )}
                              </div>
                            ))}
                          </div>
                        )}
                      </div>
                    );
                  })}
                </div>
              </section>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
