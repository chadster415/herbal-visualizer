type ViewMode = 'herb' | 'action' | 'system' | 'soul_condition' | 'pairings' | 'class_notes' | 'inventory';
type OpenTool = 'formula-builder' | 'dosing-calculator' | 'double-extraction' | 'menstruum-calculator';

export interface NavLinkState {
  viewMode: ViewMode;
  selectedHerbId: number | null;
  selectedActionId: number | null;
  selectedSystemId: number | null;
  selectedDisorderId: number | null;
  selectedRecipeId: number | null;
  selectedSupplementId: number | null;
  selectedEssenceId: number | null;
  selectedSoulConditionCategory: string | null;
  pairingsInitialFocusId: number | null;
  selectedAilmentKeyword: string | null;
  classQuizOpen: boolean;
  openQuizClass: string | null;
  energeticsQuizOpen: boolean;
  flowerEssenceQuizOpen: boolean;
  openTool: OpenTool | null;
}

function toNum(val: string | null): number | null {
  if (!val) return null;
  const n = parseInt(val, 10);
  return isNaN(n) ? null : n;
}

const VALID_VIEWS = new Set<ViewMode>([
  'herb', 'action', 'system', 'soul_condition', 'pairings', 'class_notes', 'inventory',
]);

const NULL_NAV: Omit<NavLinkState, 'viewMode' | 'classQuizOpen' | 'openQuizClass' | 'energeticsQuizOpen' | 'flowerEssenceQuizOpen'> = {
  selectedHerbId: null, selectedActionId: null, selectedSystemId: null,
  selectedDisorderId: null, selectedRecipeId: null, selectedSupplementId: null,
  selectedEssenceId: null, selectedSoulConditionCategory: null,
  pairingsInitialFocusId: null, selectedAilmentKeyword: null, openTool: null,
};

export function encodeNavToSearch(s: NavLinkState): string {
  const p = new URLSearchParams();

  if (s.classQuizOpen) {
    p.set('quiz', 'class');
    if (s.openQuizClass) p.set('class', s.openQuizClass);
    return '?' + p.toString();
  }
  if (s.energeticsQuizOpen) { p.set('quiz', 'energetics'); return '?' + p.toString(); }
  if (s.flowerEssenceQuizOpen) { p.set('quiz', 'essence'); return '?' + p.toString(); }

  if (s.viewMode !== 'herb') p.set('view', s.viewMode);

  switch (s.viewMode) {
    case 'herb':
      if (s.selectedHerbId)       p.set('herb',       String(s.selectedHerbId));
      if (s.selectedSupplementId) p.set('supplement', String(s.selectedSupplementId));
      if (s.selectedEssenceId)    p.set('essence',    String(s.selectedEssenceId));
      break;
    case 'action':
      if (s.selectedActionId)     p.set('action',     String(s.selectedActionId));
      break;
    case 'system':
      if (s.selectedSystemId)     p.set('system',     String(s.selectedSystemId));
      if (s.selectedDisorderId)   p.set('disorder',   String(s.selectedDisorderId));
      if (s.selectedRecipeId)     p.set('recipe',     String(s.selectedRecipeId));
      break;
    case 'soul_condition':
      if (s.selectedSoulConditionCategory) p.set('category', s.selectedSoulConditionCategory);
      break;
    case 'pairings':
      if (s.pairingsInitialFocusId) p.set('herb', String(s.pairingsInitialFocusId));
      break;
    case 'class_notes':
      if (s.selectedAilmentKeyword) p.set('keyword', s.selectedAilmentKeyword);
      break;
  }

  if (s.openTool) p.set('tool', s.openTool);

  const str = p.toString();
  return str ? '?' + str : '';
}

export function decodeSearchToNav(search: string): NavLinkState {
  const p = new URLSearchParams(search);

  const VALID_TOOLS = new Set<OpenTool>(['formula-builder', 'dosing-calculator', 'double-extraction', 'menstruum-calculator']);
  const toolParam = p.get('tool');
  const openTool: OpenTool | null = VALID_TOOLS.has(toolParam as OpenTool) ? (toolParam as OpenTool) : null;

  const quiz = p.get('quiz');
  if (quiz === 'class')      return { ...NULL_NAV, viewMode: 'herb', classQuizOpen: true,  openQuizClass: p.get('class'), energeticsQuizOpen: false, flowerEssenceQuizOpen: false };
  if (quiz === 'energetics') return { ...NULL_NAV, viewMode: 'herb', classQuizOpen: false, openQuizClass: null,           energeticsQuizOpen: true,  flowerEssenceQuizOpen: false };
  if (quiz === 'essence')    return { ...NULL_NAV, viewMode: 'herb', classQuizOpen: false, openQuizClass: null,           energeticsQuizOpen: false, flowerEssenceQuizOpen: true };

  const rawView = p.get('view') ?? 'herb';
  const viewMode: ViewMode = VALID_VIEWS.has(rawView as ViewMode) ? (rawView as ViewMode) : 'herb';
  const base: NavLinkState = { ...NULL_NAV, viewMode, classQuizOpen: false, openQuizClass: null, energeticsQuizOpen: false, flowerEssenceQuizOpen: false, openTool };

  switch (viewMode) {
    case 'herb':
      base.selectedHerbId       = toNum(p.get('herb'));
      base.selectedSupplementId = toNum(p.get('supplement'));
      base.selectedEssenceId    = toNum(p.get('essence'));
      break;
    case 'action':
      base.selectedActionId = toNum(p.get('action'));
      break;
    case 'system':
      base.selectedSystemId   = toNum(p.get('system'));
      base.selectedDisorderId = toNum(p.get('disorder'));
      base.selectedRecipeId   = toNum(p.get('recipe'));
      break;
    case 'soul_condition':
      base.selectedSoulConditionCategory = p.get('category');
      break;
    case 'pairings': {
      const herbId = toNum(p.get('herb'));
      base.selectedHerbId = herbId;
      base.pairingsInitialFocusId = herbId;
      break;
    }
    case 'class_notes':
      base.selectedAilmentKeyword = p.get('keyword');
      break;
  }

  return base;
}
