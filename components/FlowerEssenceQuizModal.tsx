'use client';

import { useEffect, useState } from 'react';
import { ArrowRightIcon, SparklesIcon, XMarkIcon } from '@heroicons/react/24/outline';
import { supabase } from '@/lib/supabase';

// ─── Types ───────────────────────────────────────────────────────────────────

type ThemeKey =
  | 'fearAnxiety'
  | 'sadnessDespair'
  | 'angerResentment'
  | 'guiltShame'
  | 'exhaustionDepletion'
  | 'relationshipsBelonging'
  | 'mindPatterns'
  | 'lifeDirection'
  | 'changeTransition'
  | 'sensitivityOverwhelm'
  | 'identityAuthenticity'
  | 'traumaGrief'
  | 'bodyEmbodiment'
  | 'spiritualityPsychic';

interface Stage1Q {
  text: string;
  theme: ThemeKey;
}

interface Stage2Q {
  text: string;
  essences: string[];
  theme: ThemeKey;
}

interface ThemeInfo {
  label: string;
  emoji: string;
  description: string;
}

interface EssenceResult {
  id: number;
  name: string;
  positive_qualities: string | null;
  patterns_of_imbalance: string | null;
  kit: string | null;
  score: number;
}

type Stage = 'intro' | 'stage1' | 'between' | 'stage2' | 'results';

// ─── Constants ────────────────────────────────────────────────────────────────

const STORAGE_KEY = 'flower-essence-quiz-state';

const THEME_INFO: Record<ThemeKey, ThemeInfo> = {
  fearAnxiety:            { label: 'Fear & Anxiety',              emoji: '😰', description: 'Worry, dread, panic, or anxiety — named or nameless' },
  sadnessDespair:         { label: 'Sadness & Despair',           emoji: '😔', description: 'Hopelessness, depression, discouragement, or grief' },
  angerResentment:        { label: 'Anger & Resentment',          emoji: '🔥', description: 'Irritability, bitterness, jealousy, or rage' },
  guiltShame:             { label: 'Guilt & Shame',               emoji: '😞', description: 'Self-criticism, inadequacy, shame, or persistent guilt' },
  exhaustionDepletion:    { label: 'Exhaustion & Depletion',      emoji: '🪫', description: 'Physical, emotional, or creative depletion and burnout' },
  relationshipsBelonging: { label: 'Relationships & Belonging',   emoji: '💔', description: "Loneliness, attachment, conflict, or disconnection" },
  mindPatterns:           { label: 'Mind & Mental Patterns',      emoji: '🌀', description: 'Repetitive thoughts, distraction, or mental loops' },
  lifeDirection:          { label: 'Life Purpose & Direction',    emoji: '🧭', description: 'Unclear calling, indecision, or difficulty committing' },
  changeTransition:       { label: 'Change & Transition',         emoji: '🦋', description: 'Stuck patterns, life transitions, or resistance to change' },
  sensitivityOverwhelm:   { label: 'Sensitivity & Overwhelm',    emoji: '🌊', description: "Absorbing others' energy, sensory overwhelm, or thin boundaries" },
  identityAuthenticity:   { label: 'Identity & Authenticity',    emoji: '🎭', description: 'Playing roles, hiding feelings, or disconnection from true self' },
  traumaGrief:            { label: 'Trauma & Deep Grief',         emoji: '🕊️', description: 'Unresolved shock, childhood wounds, or deep heartbreak' },
  bodyEmbodiment:         { label: 'Body & Embodiment',           emoji: '🌿', description: 'Relationship with the body, sexuality, or feeling at home in physical form' },
  spiritualityPsychic:    { label: 'Spirituality & Psychic Life', emoji: '✨', description: 'Spiritual seeking, psychic sensitivity, or awakening challenges' },
};

const STAGE1_QUESTIONS: Stage1Q[] = [
  { text: "Anxiety, fear, or worry — whether about specific things or a vague nameless unease — plays a significant role in my daily life", theme: 'fearAnxiety' },
  { text: "Sadness, hopelessness, discouragement, or a heavy quality of feeling has been present lately", theme: 'sadnessDespair' },
  { text: "Anger, irritability, resentment, or bitterness surface in me more than I'd like", theme: 'angerResentment' },
  { text: "Self-criticism, guilt, shame, or a persistent sense of not being good enough weighs on me", theme: 'guiltShame' },
  { text: "I feel genuinely depleted — physically drained, emotionally spent, or creatively dried up", theme: 'exhaustionDepletion' },
  { text: "Connection and belonging are a central struggle — whether through loneliness, conflict, over-attachment, or difficulty truly relating", theme: 'relationshipsBelonging' },
  { text: "My own mind is a significant challenge — repetitive thoughts, inability to focus, daydreaming, or compulsive mental loops", theme: 'mindPatterns' },
  { text: "I feel unclear, uncommitted, or lost when it comes to my life's direction, purpose, or calling", theme: 'lifeDirection' },
  { text: "I am navigating a significant transition, or feel stuck and resistant to a change I know I need to make", theme: 'changeTransition' },
  { text: "I am highly sensitive — easily overwhelmed by others' emotions, my environment, or too much stimulation", theme: 'sensitivityOverwhelm' },
  { text: "I feel disconnected from who I truly am, or find myself presenting a face rather than living from my real nature", theme: 'identityAuthenticity' },
  { text: "I carry the weight of past trauma, shock, or grief that has not fully healed", theme: 'traumaGrief' },
  { text: "My relationship with my own body — including physical comfort, sexuality, or feeling at home in physical form — is a live issue", theme: 'bodyEmbodiment' },
  { text: "Spiritual seeking, psychic sensitivity, or the gap between my inner spiritual life and daily reality feels unresolved", theme: 'spiritualityPsychic' },
];

const STAGE2_QUESTIONS: Stage2Q[] = [
  // fearAnxiety (6)
  { theme: 'fearAnxiety', essences: ['Mimulus', 'Garlic'], text: "My fears are specific and nameable — particular situations, places, people, or types of harm" },
  { theme: 'fearAnxiety', essences: ['Aspen'], text: "I experience vague, formless dread — a nameless anxiety I can't trace to any clear cause" },
  { theme: 'fearAnxiety', essences: ['Red Chestnut'], text: "My worry centers heavily on people I love — I'm preoccupied with fear that something bad will happen to them" },
  { theme: 'fearAnxiety', essences: ['Five-Flower Formula', 'Cherry Plum'], text: "I sometimes experience sudden, paralyzing terror or panic attacks" },
  { theme: 'fearAnxiety', essences: ['Cherry Plum'], text: "I fear losing mental or emotional control — that under extreme stress I might break down or act destructively" },
  { theme: 'fearAnxiety', essences: ["Angel's Trumpet", 'Angelica'], text: "My anxiety connects to fears about death, endings, or crossing into the unknown" },
  // sadnessDespair (6)
  { theme: 'sadnessDespair', essences: ['Mustard'], text: "Sadness or depression sometimes descends on me without a clear cause — like a cloud that simply arrives" },
  { theme: 'sadnessDespair', essences: ['Gorse', 'Wild Rose (also known as Dog Rose)'], text: "I've reached a point of resignation — I don't truly believe things will improve, and I've stopped hoping" },
  { theme: 'sadnessDespair', essences: ['Gentian', 'Borage'], text: "Even minor setbacks discourage me deeply; after disappointment I struggle to find faith and try again" },
  { theme: 'sadnessDespair', essences: ['California Wild Rose', 'Wild Rose (also known as Dog Rose)'], text: "Life feels hollow or purposeless — I go through the motions without genuine engagement or joy" },
  { theme: 'sadnessDespair', essences: ['Sweet Chestnut', 'Love-Lies-Bleeding'], text: "I have experienced extreme anguish — a dark night of the soul — feeling utterly at the end of my resources" },
  { theme: 'sadnessDespair', essences: ['Scotch Broom'], text: "I feel weighed down by pessimism about the future, the world, or the state of humanity" },
  // angerResentment (6)
  { theme: 'angerResentment', essences: ['Willow', 'Penstemon'], text: "I carry ongoing bitterness or resentment — a sense that life or people have treated me unfairly" },
  { theme: 'angerResentment', essences: ['Holly'], text: "I sometimes feel cut off from love — jealousy, envy, or even flashes of hatred that surprise me" },
  { theme: 'angerResentment', essences: ['Impatiens', 'Beech', 'Chamomile'], text: "I become impatient or irritable quickly, especially when others move slowly or fail to meet my standards" },
  { theme: 'angerResentment', essences: ['Vine', 'Tiger Lily', 'Larkspur'], text: "I can be domineering or controlling — I have strong views on how things should go and find yielding difficult" },
  { theme: 'angerResentment', essences: ['Snapdragon', 'Calendula'], text: "I express frustration sharply — through words or tone — in ways I later regret" },
  { theme: 'angerResentment', essences: ['Scarlet Monkeyflower'], text: "I carry rage or powerlessness that I haven't been able to express — it stays locked inside me" },
  // guiltShame (6)
  { theme: 'guiltShame', essences: ['Pine', 'Pink Monkeyflower'], text: "I carry guilt or self-blame, often apologizing or feeling at fault even when I'm not responsible" },
  { theme: 'guiltShame', essences: ['Larch', 'Buttercup'], text: "I hold back from trying things because I expect to fail or simply don't believe I'm good enough" },
  { theme: 'guiltShame', essences: ['Buttercup', 'Sunflower'], text: "I feel my gifts or way of being have no real value — that I am somehow lesser than others" },
  { theme: 'guiltShame', essences: ['Crab Apple', 'Pretty Face'], text: "I feel shame about my body, appearance, or something about myself — a sense of being flawed or impure" },
  { theme: 'guiltShame', essences: ['Elm'], text: "I feel overwhelmed by responsibilities and secretly fear I'm not truly up to what life asks of me" },
  { theme: 'guiltShame', essences: ['Pine', 'Beech', 'Crab Apple'], text: "I have a harsh inner critic — a voice that is exacting, punishing, and rarely satisfied" },
  // exhaustionDepletion (6)
  { theme: 'exhaustionDepletion', essences: ['Olive', 'Aloe Vera'], text: "I feel completely exhausted at a core level — deeply drained after a long period of effort or struggle" },
  { theme: 'exhaustionDepletion', essences: ['Hornbeam'], text: "I face each day or week with dread and inertia — though I usually manage once I begin" },
  { theme: 'exhaustionDepletion', essences: ['Oak', 'Vervain'], text: "I keep pushing past my limits out of duty — I rarely allow myself to rest until I am forced to" },
  { theme: 'exhaustionDepletion', essences: ['Indian Paintbrush', 'Iris'], text: "My creative work drains me — I struggle to sustain the physical energy that artistic or intellectual work requires" },
  { theme: 'exhaustionDepletion', essences: ['Nasturtium'], text: "I feel intellectually overworked and emotionally dry — my thinking runs but warmth and vitality are absent" },
  { theme: 'exhaustionDepletion', essences: ['Morning Glory', 'Rosemary'], text: "I struggle to fully inhabit the body and engage each new day — mornings and starting are especially hard" },
  // relationshipsBelonging (9)
  { theme: 'relationshipsBelonging', essences: ['Forget-Me-Not', 'Sweet Pea', 'Water Violet'], text: "I feel profoundly alone — either isolated, or surrounded by people but still deeply disconnected" },
  { theme: 'relationshipsBelonging', essences: ['Centaury'], text: "I consistently put others' needs before my own and find it very difficult to say no" },
  { theme: 'relationshipsBelonging', essences: ['Chicory', 'Bleeding Heart'], text: "I tend toward possessiveness or clinging in love — I fear losing people and can become controlling" },
  { theme: 'relationshipsBelonging', essences: ['Honeysuckle'], text: "I live much in the past — longing for relationships, places, or times that no longer exist" },
  { theme: 'relationshipsBelonging', essences: ['Evening Primrose', 'Sweet Pea', 'Mallow', 'Violet'], text: "I hold back from true intimacy or community — I struggle to feel I genuinely belong anywhere" },
  { theme: 'relationshipsBelonging', essences: ['Oregon Grape'], text: "I tend to expect hostility or ill will from others even when there's no clear reason to" },
  { theme: 'relationshipsBelonging', essences: ['Heather'], text: "I talk at length about my own problems and find it hard to truly listen to or focus on others" },
  { theme: 'relationshipsBelonging', essences: ['Quaking Grass', 'Violet'], text: "In group settings I either lose myself in the dynamic or feel unable to find my authentic place" },
  { theme: 'relationshipsBelonging', essences: ['Star Thistle'], text: "I struggle to give or share freely — I hold back out of fear there won't be enough" },
  // mindPatterns (6)
  { theme: 'mindPatterns', essences: ['White Chestnut (also known as Horse Chestnut)', 'Filaree'], text: "Unwanted thoughts, worries, or arguments replay in my mind and I struggle to quiet them" },
  { theme: 'mindPatterns', essences: ['Clematis'], text: "I drift easily into daydreaming or fantasy rather than staying present with what's in front of me" },
  { theme: 'mindPatterns', essences: ['Madia', 'Rabbitbrush', 'Cosmos'], text: "I'm easily distracted and struggle to sustain focus — my attention splinters across too many things" },
  { theme: 'mindPatterns', essences: ['Chestnut Bud'], text: "I repeat the same patterns or mistakes over and over, seemingly unable to learn from experience" },
  { theme: 'mindPatterns', essences: ["Shasta Daisy", "Hound's Tongue"], text: "I live very much in my head — over-analyzing, intellectualizing, finding it hard to access feeling or body" },
  { theme: 'mindPatterns', essences: ['Peppermint', 'Hornbeam'], text: "My mind feels chronically sluggish or foggy — it is hard to feel mentally alert, present, or sharp" },
  // lifeDirection (6)
  { theme: 'lifeDirection', essences: ['Wild Oat', 'Sage'], text: "I feel genuinely confused about my life direction — I've tried many paths but nothing feels like my true calling" },
  { theme: 'lifeDirection', essences: ['Cerato', 'Mullein'], text: "I doubt my own judgment and seek others' opinions or validation before I can trust my own knowing" },
  { theme: 'lifeDirection', essences: ['Scleranthus'], text: "When facing two options I waver endlessly — I can't commit or resolve in either direction" },
  { theme: 'lifeDirection', essences: ['Blackberry', 'Tansy', 'Cayenne'], text: "I have visions and intentions but struggle to translate them into concrete, sustained action" },
  { theme: 'lifeDirection', essences: ['Goldenrod', 'Walnut'], text: "I'm easily shaped by family expectations, peer pressure, or social norms — following my own path feels risky" },
  { theme: 'lifeDirection', essences: ['Mountain Pride', 'Mullein'], text: "I vacillate about asserting my convictions or taking a stand, even when I clearly know what's right" },
  // changeTransition (7)
  { theme: 'changeTransition', essences: ['Walnut', 'Honeysuckle'], text: "I am in the middle of a significant life transition and feel disoriented, unmoored, or resistant" },
  { theme: 'changeTransition', essences: ['Cayenne', 'Tansy', 'Blackberry'], text: "I feel stuck — I can see what needs to change but cannot generate the momentum to move forward" },
  { theme: 'changeTransition', essences: ['Sagebrush', 'Walnut'], text: "I cling to aspects of my identity or past even when I sense they no longer serve me" },
  { theme: 'changeTransition', essences: ['Morning Glory', 'Milkweed', 'Chaparral'], text: "I have habitual, compulsive, or addictive patterns I know I need to release but cannot seem to shift" },
  { theme: 'changeTransition', essences: ['Rock Rose', 'Oak'], text: "I hold myself to rigid standards and resist any suggestion that I should yield or adapt" },
  { theme: 'changeTransition', essences: ['Saguaro'], text: "I feel alienated from my roots, elders, or lineage — disconnected from any sense of tradition or continuity" },
  { theme: 'changeTransition', essences: ['Chrysanthemum', "Angel's Trumpet"], text: "I struggle with aging or feel strongly attached to a former, younger version of myself" },
  // sensitivityOverwhelm (7)
  { theme: 'sensitivityOverwhelm', essences: ['Pink Yarrow', 'Yarrow'], text: "I absorb others' emotions like a sponge — I often can't tell where my feelings end and theirs begin" },
  { theme: 'sensitivityOverwhelm', essences: ['Dill', 'Lavender', 'Corn'], text: "Sensory stimulation — noise, crowds, busyness — quickly overwhelms and depletes me" },
  { theme: 'sensitivityOverwhelm', essences: ['Indian Pink', 'Rabbitbrush'], text: "I become easily scattered or lose my center when life gets intense or too many things happen at once" },
  { theme: 'sensitivityOverwhelm', essences: ['Mountain Pennyroyal', 'Golden Yarrow'], text: "I pick up others' negative thoughts or mental energy, and it strongly affects my own state" },
  { theme: 'sensitivityOverwhelm', essences: ['Red Clover', 'Garlic'], text: "I'm susceptible to collective panic or anxiety — media, group fear, or social alarm pulls me in" },
  { theme: 'sensitivityOverwhelm', essences: ['Yarrow Special Formula', 'Corn'], text: "I feel environmentally sensitive — affected by EMF, pollution, geopathic stress, or living in cities" },
  { theme: 'sensitivityOverwhelm', essences: ['Yellow Star Tulip'], text: "I tend to act without full awareness of how my words and actions affect the people around me" },
  // identityAuthenticity (8)
  { theme: 'identityAuthenticity', essences: ['Agrimony'], text: "I put on a cheerful or positive face even when struggling inside — I hide my real feelings" },
  { theme: 'identityAuthenticity', essences: ['Fuchsia', 'Nicotiana (Flowering Tobacco)'], text: "I express emotions that aren't quite real — performing reactions rather than what is actually there" },
  { theme: 'identityAuthenticity', essences: ['Deerbrush'], text: "I act on mixed or unclear motives I don't fully understand — my actions don't always match my real values" },
  { theme: 'identityAuthenticity', essences: ['Cerato', 'Goldenrod'], text: "I defer to others' advice, expectations, or group norms rather than trusting my own inner knowing" },
  { theme: 'identityAuthenticity', essences: ['Zinnia'], text: "I take life very seriously — play, humor, and lightheartedness feel inaccessible to me" },
  { theme: 'identityAuthenticity', essences: ['Trumpet Vine', 'Violet'], text: "I struggle to assert my voice or presence — I fade into the background and don't speak up" },
  { theme: 'identityAuthenticity', essences: ['Trillium', 'Larkspur'], text: "I notice excessive ambition, possessiveness, or greed in myself — a desire for power or recognition that troubles me" },
  { theme: 'identityAuthenticity', essences: ['Self-Heal'], text: "I find it hard to take inner responsibility for my own healing — I'm overly dependent on external guidance" },
  // traumaGrief (8)
  { theme: 'traumaGrief', essences: ['Star of Bethlehem', 'Arnica'], text: "I carry the effects of past shock or trauma — something happened that I haven't fully recovered from" },
  { theme: 'traumaGrief', essences: ['Echinacea'], text: "Trauma or severe difficulty has shattered my sense of self — my core identity feels fragmented" },
  { theme: 'traumaGrief', essences: ['Mariposa Lily', 'Evening Primrose'], text: "I carry painful wounds around my mother or early caregiving — feelings of abandonment or not being wanted" },
  { theme: 'traumaGrief', essences: ['Golden Ear Drops', 'Black-Eyed Susan'], text: "I hold unprocessed childhood pain or memories — things I haven't been able to access or release" },
  { theme: 'traumaGrief', essences: ['Bleeding Heart', 'Yerba Santa'], text: "I carry grief from a heartbreak, loss, or betrayal that has left a deep wound" },
  { theme: 'traumaGrief', essences: ['Baby Blue Eyes', 'Saguaro'], text: "It is hard for me to trust people or feel safe — particularly connected to a wound with my father or authority figures" },
  { theme: 'traumaGrief', essences: ['Black Cohosh', 'Echinacea'], text: "I have been in, or am healing from, a relationship that was abusive, controlling, or threatened my safety" },
  { theme: 'traumaGrief', essences: ['Fairy Lantern', 'Milkweed'], text: "Part of me feels emotionally younger than my years — I struggle to inhabit adult responsibilities fully" },
  // bodyEmbodiment (8)
  { theme: 'bodyEmbodiment', essences: ['Manzanita', 'Shooting Star', 'Rosemary'], text: "I feel disconnected from or uncomfortable in my body — as if I'm not quite at home in physical form" },
  { theme: 'bodyEmbodiment', essences: ['Dogwood', 'Dandelion', 'Arnica'], text: "I sense trauma or tension stored in my body — pain, stiffness, or emotional memory held somatically" },
  { theme: 'bodyEmbodiment', essences: ['Easter Lily', 'Basil', 'Hibiscus'], text: "I experience inner conflict about sexuality — feeling it is somehow wrong, impure, or at odds with my spiritual values" },
  { theme: 'bodyEmbodiment', essences: ['Sticky Monkeyflower', 'Hibiscus', 'Poison Oak'], text: "I struggle to connect warmly with my own sexuality — I feel shut down, dissociated, or fearful of intimate contact" },
  { theme: 'bodyEmbodiment', essences: ['Calla Lily'], text: "I experience confusion or discomfort around my sexual identity or gender" },
  { theme: 'bodyEmbodiment', essences: ['Pomegranate', 'Alpine Lily', 'Quince'], text: "As a woman, I feel tension between my creative, professional, maternal, and personal roles" },
  { theme: 'bodyEmbodiment', essences: ['California Pitcher Plant', 'Manzanita'], text: "I feel disconnected from my instincts and bodily drives — or slightly fearful of my own animal nature" },
  { theme: 'bodyEmbodiment', essences: ['Iris (Blue Flag)', "Showy Lady's Slipper", "Yellow Lady's Slipper"], text: "I feel unable to integrate my spiritual purpose with my daily practical life and work" },
  // spiritualityPsychic (7)
  { theme: 'spiritualityPsychic', essences: ['Canyon Dudleya', 'Mugwort', "Saint John's Wort"], text: "I am going through, or have experienced, an intense spiritual awakening that has been destabilizing" },
  { theme: 'spiritualityPsychic', essences: ['Mugwort', 'Chaparral', "Queen Anne's Lace"], text: "My dream life or psychic impressions feel unruly — hard to integrate with ordinary daily life" },
  { theme: 'spiritualityPsychic', essences: ['Angelica', 'Forget-Me-Not'], text: "I feel cut off from spiritual guidance or protection — bereft of a sense of divine connection or support" },
  { theme: 'spiritualityPsychic', essences: ['Purple Monkeyflower', 'California Poppy'], text: "I have fears or conflicts about spiritual experience itself — guilt, fear of judgment, or fear of the paranormal" },
  { theme: 'spiritualityPsychic', essences: ['Lotus', 'Larkspur'], text: "I notice spiritual pride or inflation in myself — difficulty staying humble or grounded in my spiritual life" },
  { theme: 'spiritualityPsychic', essences: ['Shooting Star', 'Fawn Lily'], text: "I feel profoundly alien on Earth — as if I don't quite belong here among human beings" },
  { theme: 'spiritualityPsychic', essences: ["Star Tulip (also known as Cat's Ears)"], text: "I feel hardened or cut off from inner stillness — I struggle to meditate, pray, or access quiet receptive presence" },
];

// ─── Utility functions ────────────────────────────────────────────────────────

function shortName(name: string) {
  return name.replace(/\s*\(also known as[^)]+\)/i, '').trim();
}

function kitBadge(kit: string | null): { label: string; cls: string } | null {
  if (!kit) return null;
  const k = kit.toLowerCase();
  if (k.includes('english')) return { label: 'Bach', cls: 'bg-blue-100 text-blue-700' };
  if (k.includes('seven')) return { label: 'FES 7', cls: 'bg-amber-100 text-amber-700' };
  if (k.includes('professional')) return { label: 'FES Pro', cls: 'bg-purple-100 text-purple-700' };
  if (k.includes('research')) return { label: 'Research', cls: 'bg-gray-100 text-gray-500' };
  return null;
}

// ─── Initial state ────────────────────────────────────────────────────────────

const INITIAL_THEME_SCORES: Record<ThemeKey, number> = {
  fearAnxiety: 0, sadnessDespair: 0, angerResentment: 0, guiltShame: 0,
  exhaustionDepletion: 0, relationshipsBelonging: 0, mindPatterns: 0,
  lifeDirection: 0, changeTransition: 0, sensitivityOverwhelm: 0,
  identityAuthenticity: 0, traumaGrief: 0, bodyEmbodiment: 0, spiritualityPsychic: 0,
};

// ─── Props ────────────────────────────────────────────────────────────────────

interface Props {
  isOpen: boolean;
  onClose: () => void;
  onEssenceSelect?: (essenceName: string) => void;
}

// ─── Main component ───────────────────────────────────────────────────────────

export function FlowerEssenceQuizModal({ isOpen, onClose, onEssenceSelect }: Props) {
  const [stage, setStage] = useState<Stage>('intro');
  const [s1Index, setS1Index] = useState(0);
  const [s2Index, setS2Index] = useState(0);
  const [themeScores, setThemeScores] = useState<Record<ThemeKey, number>>(INITIAL_THEME_SCORES);
  const [essenceScores, setEssenceScores] = useState<Record<string, number>>({});
  const [activeThemes, setActiveThemes] = useState<ThemeKey[]>([]);
  const [activeS2, setActiveS2] = useState<Stage2Q[]>([]);
  const [essenceResults, setEssenceResults] = useState<EssenceResult[]>([]);
  const [loadingResults, setLoadingResults] = useState(false);

  // Restore from localStorage on mount
  useEffect(() => {
    try {
      const saved = localStorage.getItem(STORAGE_KEY);
      if (saved) {
        const { stage: s, s1Index: s1, s2Index: s2, themeScores: ts, essenceScores: es, activeThemes: at } = JSON.parse(saved);
        const restoredThemes: ThemeKey[] = at ?? [];
        setStage(s);
        setS1Index(s1 ?? 0);
        setS2Index(s2 ?? 0);
        setThemeScores(ts ?? INITIAL_THEME_SCORES);
        setEssenceScores(es ?? {});
        setActiveThemes(restoredThemes);
        setActiveS2(STAGE2_QUESTIONS.filter(q => restoredThemes.includes(q.theme)));
        if (s === 'results') {
          fetchResults(es ?? {});
        }
      }
    } catch { /* ignore */ }
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  // Persist to localStorage whenever relevant state changes
  useEffect(() => {
    if (stage === 'intro') return;
    try {
      localStorage.setItem(STORAGE_KEY, JSON.stringify({
        stage, s1Index, s2Index, themeScores, essenceScores, activeThemes,
      }));
    } catch { /* ignore */ }
  }, [stage, s1Index, s2Index, themeScores, essenceScores, activeThemes]);

  const fetchResults = async (scores: Record<string, number>) => {
    setLoadingResults(true);
    setStage('results');
    const topNames = Object.entries(scores)
      .filter(([, v]) => v > 0)
      .sort((a, b) => b[1] - a[1])
      .slice(0, 10)
      .map(([n]) => n);
    if (topNames.length === 0) {
      setEssenceResults([]);
      setLoadingResults(false);
      return;
    }
    const { data } = await supabase
      .from('flower_essence_plants')
      .select('id, name, positive_qualities, patterns_of_imbalance, kit')
      .in('name', topNames);
    if (data) {
      setEssenceResults(
        data
          .map(d => ({ ...d, score: scores[d.name] || 0 }))
          .sort((a, b) => b.score - a.score),
      );
    }
    setLoadingResults(false);
  };

  const answerS1 = (yes: boolean) => {
    const q = STAGE1_QUESTIONS[s1Index];
    const updated = yes
      ? { ...themeScores, [q.theme]: (themeScores[q.theme] || 0) + 1 }
      : { ...themeScores };
    const isLast = s1Index + 1 >= STAGE1_QUESTIONS.length;
    if (isLast) {
      const sorted = (Object.entries(updated) as [ThemeKey, number][])
        .filter(([, v]) => v > 0)
        .sort((a, b) => b[1] - a[1])
        .slice(0, 5)
        .map(([k]) => k);
      setThemeScores(updated);
      setActiveThemes(sorted);
      setActiveS2(STAGE2_QUESTIONS.filter(q => sorted.includes(q.theme)));
      setStage('between');
    } else {
      setThemeScores(updated);
      setS1Index(i => i + 1);
    }
  };

  const answerS2 = (yes: boolean) => {
    const q = activeS2[s2Index];
    const updated = { ...essenceScores };
    if (yes) q.essences.forEach(name => { updated[name] = (updated[name] || 0) + 1; });
    const isLast = s2Index + 1 >= activeS2.length;
    if (isLast) {
      setEssenceScores(updated);
      fetchResults(updated);
    } else {
      setEssenceScores(updated);
      setS2Index(i => i + 1);
    }
  };

  const reset = () => {
    localStorage.removeItem(STORAGE_KEY);
    setStage('intro');
    setS1Index(0);
    setS2Index(0);
    setThemeScores(INITIAL_THEME_SCORES);
    setEssenceScores({});
    setActiveThemes([]);
    setActiveS2([]);
    setEssenceResults([]);
    setLoadingResults(false);
  };

  return (
    <div
      className={`fixed top-0 right-0 h-full w-full sm:w-[440px] z-40 bg-white dark:bg-gray-800 shadow-2xl border-l border-gray-200 dark:border-gray-700 flex flex-col transition-transform duration-300 ease-in-out ${isOpen ? 'translate-x-0' : 'translate-x-full'}`}
    >
      <div className="flex items-center justify-between px-6 py-4 border-b border-gray-200 dark:border-gray-700 shrink-0">
        <h2 className="text-lg font-bold text-purple-800 dark:text-purple-300 flex items-center gap-2">
          <SparklesIcon className="w-5 h-5" /> Flower Essence Quiz
        </h2>
        <button
          onClick={onClose}
          className="text-gray-400 hover:text-gray-600 dark:hover:text-gray-200"
          aria-label="Close"
        >
          <XMarkIcon className="w-5 h-5" />
        </button>
      </div>

      <div className="flex-1 overflow-y-auto px-6 py-6">
        {stage === 'intro' && (
          <IntroScreen onStart={() => setStage('stage1')} />
        )}
        {stage === 'stage1' && (
          <QuizScreen
            question={STAGE1_QUESTIONS[s1Index].text}
            index={s1Index}
            total={STAGE1_QUESTIONS.length}
            onAnswer={answerS1}
          />
        )}
        {stage === 'between' && (
          <BetweenScreen
            activeThemes={activeThemes}
            s2Count={activeS2.length}
            onContinue={() => setStage('stage2')}
            onRetake={reset}
          />
        )}
        {stage === 'stage2' && activeS2.length > 0 && (
          <QuizScreen
            question={activeS2[s2Index].text}
            index={s2Index}
            total={activeS2.length}
            onAnswer={answerS2}
          />
        )}
        {stage === 'results' && (
          <ResultsScreen
            results={essenceResults}
            loading={loadingResults}
            onRetake={reset}
            onEssenceSelect={onEssenceSelect}
          />
        )}
      </div>
    </div>
  );
}

// ─── Sub-components ───────────────────────────────────────────────────────────

function IntroScreen({ onStart }: { onStart: () => void }) {
  return (
    <div className="flex flex-col gap-5">
      <p className="text-gray-600 dark:text-gray-300 leading-relaxed">
        Flower essences address the emotional and psychological dimensions of wellbeing — patterns of fear, grief, confusion, depletion, and disconnection that shape how we experience ourselves and the world.
      </p>
      <p className="text-gray-600 dark:text-gray-300 leading-relaxed">
        This quiz uses a <strong>two-stage approach</strong>. First, 14 broad questions identify which emotional themes are most active for you right now. Then, targeted follow-up questions narrow down to specific essences matched to your experience.
      </p>
      <p className="text-sm text-purple-700 dark:text-purple-400 bg-purple-50 dark:bg-purple-900/20 border border-purple-200 dark:border-purple-700 rounded-lg px-4 py-3">
        Answer yes or no based on how you&apos;ve been feeling recently. There are no right or wrong answers — honesty with yourself matters most.
      </p>
      <button
        onClick={onStart}
        className="self-center px-8 py-3 bg-purple-600 hover:bg-purple-700 text-white rounded-lg font-medium transition-colors flex items-center gap-2"
      >
        Begin <ArrowRightIcon className="w-4 h-4" />
      </button>
    </div>
  );
}

function QuizScreen({
  question,
  index,
  total,
  onAnswer,
}: {
  question: string;
  index: number;
  total: number;
  onAnswer: (yes: boolean) => void;
}) {
  return (
    <div className="flex flex-col gap-6">
      <div>
        <div className="flex justify-between text-xs text-gray-400 mb-1">
          <span>Question {index + 1} of {total}</span>
          <span>{Math.round((index / total) * 100)}%</span>
        </div>
        <div className="h-2 bg-gray-100 dark:bg-gray-700 rounded-full overflow-hidden">
          <div
            className="h-full bg-purple-500 rounded-full transition-all duration-300"
            style={{ width: `${(index / total) * 100}%` }}
          />
        </div>
      </div>

      <div className="rounded-xl border-2 border-purple-200 dark:border-purple-700 bg-purple-50 dark:bg-purple-900/30 p-6 min-h-32 flex items-center justify-center">
        <p className="text-lg font-medium text-center text-gray-800 dark:text-gray-100">
          {question}
        </p>
      </div>

      <div className="flex gap-4">
        <button
          onClick={() => onAnswer(false)}
          className="flex-1 py-3 rounded-lg border-2 border-gray-200 hover:border-gray-400 hover:bg-gray-50 dark:hover:bg-gray-700 font-medium text-gray-600 dark:text-gray-300 transition-all"
        >
          No
        </button>
        <button
          onClick={() => onAnswer(true)}
          className="flex-1 py-3 rounded-lg border-2 border-purple-300 hover:border-purple-500 hover:bg-purple-50 dark:hover:bg-purple-900/30 font-medium text-purple-700 dark:text-purple-400 transition-all"
        >
          Yes
        </button>
      </div>
    </div>
  );
}

function BetweenScreen({
  activeThemes,
  s2Count,
  onContinue,
  onRetake,
}: {
  activeThemes: ThemeKey[];
  s2Count: number;
  onContinue: () => void;
  onRetake: () => void;
}) {
  if (activeThemes.length === 0) {
    return (
      <div className="flex flex-col gap-6 items-center text-center">
        <span className="text-4xl">🌸</span>
        <p className="text-gray-600 dark:text-gray-300 leading-relaxed">
          Your responses didn&apos;t strongly indicate any of the emotional themes right now. This may mean you&apos;re in a relatively settled place — or that none of the themes quite captured your experience.
        </p>
        <p className="text-sm text-gray-500 dark:text-gray-400">
          You might try answering again with different themes in mind, or consult directly with a flower essence practitioner.
        </p>
        <button
          onClick={onRetake}
          className="px-6 py-2 bg-purple-600 hover:bg-purple-700 text-white rounded-lg font-medium transition-colors"
        >
          Retake Quiz
        </button>
      </div>
    );
  }

  return (
    <div className="flex flex-col gap-5">
      <div>
        <h3 className="text-base font-semibold text-gray-800 dark:text-gray-100 mb-1">
          Stage 1 complete
        </h3>
        <p className="text-sm text-gray-500 dark:text-gray-400 leading-relaxed">
          Your responses suggest these areas are most active for you right now:
        </p>
      </div>

      <div className="flex flex-col gap-2">
        {activeThemes.map(key => {
          const info = THEME_INFO[key];
          return (
            <div
              key={key}
              className="flex items-start gap-3 rounded-lg border border-purple-200 dark:border-purple-700 bg-purple-50 dark:bg-purple-900/20 px-4 py-3"
            >
              <span className="text-xl mt-0.5 shrink-0">{info.emoji}</span>
              <div>
                <p className="font-medium text-gray-800 dark:text-gray-100 text-sm">{info.label}</p>
                <p className="text-xs text-gray-500 dark:text-gray-400">{info.description}</p>
              </div>
            </div>
          );
        })}
      </div>

      <p className="text-sm text-purple-700 dark:text-purple-400 bg-purple-50 dark:bg-purple-900/20 border border-purple-200 dark:border-purple-700 rounded-lg px-4 py-3">
        <strong>{s2Count} targeted question{s2Count !== 1 ? 's' : ''}</strong> ahead — matched to your themes. These will narrow down to specific flower essences.
      </p>

      <button
        onClick={onContinue}
        className="self-center px-8 py-3 bg-purple-600 hover:bg-purple-700 text-white rounded-lg font-medium transition-colors flex items-center gap-2"
      >
        Continue <ArrowRightIcon className="w-4 h-4" />
      </button>
    </div>
  );
}

function ResultsScreen({
  results,
  loading,
  onRetake,
  onEssenceSelect,
}: {
  results: EssenceResult[];
  loading: boolean;
  onRetake: () => void;
  onEssenceSelect?: (essenceName: string) => void;
}) {
  if (loading) {
    return (
      <div className="flex flex-col gap-4 items-center justify-center py-16 text-center">
        <div className="w-8 h-8 rounded-full border-2 border-purple-300 border-t-purple-600 animate-spin" />
        <p className="text-sm text-gray-500 dark:text-gray-400">Finding your essences…</p>
      </div>
    );
  }

  if (results.length === 0) {
    return (
      <div className="flex flex-col gap-6 items-center text-center">
        <span className="text-4xl">🌸</span>
        <p className="text-gray-600 dark:text-gray-300 leading-relaxed">
          No essences were strongly indicated by your responses. This can happen when the themes are present but the specific follow-up questions didn&apos;t resonate.
        </p>
        <p className="text-sm text-gray-500 dark:text-gray-400">
          Consider consulting with a flower essence practitioner for a more personalized assessment.
        </p>
        <button
          onClick={onRetake}
          className="px-6 py-2 bg-purple-600 hover:bg-purple-700 text-white rounded-lg font-medium transition-colors"
        >
          Retake Quiz
        </button>
      </div>
    );
  }

  return (
    <div className="flex flex-col gap-4">
      <div>
        <h3 className="text-base font-semibold text-gray-800 dark:text-gray-100 mb-1">
          Your top essences
        </h3>
        <p className="text-sm text-gray-500 dark:text-gray-400">
          Based on your responses, these essences resonated most strongly with your experience.
        </p>
      </div>

      <div className="flex flex-col gap-2">
        {results.map((result, i) => {
          const badge = kitBadge(result.kit);
          const displayName = shortName(result.name);
          return (
            <button
              key={result.id}
              onClick={() => onEssenceSelect?.(result.name)}
              disabled={!onEssenceSelect}
              className={`flex items-start gap-3 w-full text-left rounded-xl border border-purple-200 dark:border-purple-700 bg-white dark:bg-gray-800 px-4 py-3 transition-all ${onEssenceSelect ? 'hover:border-purple-400 hover:bg-purple-50 dark:hover:bg-purple-900/20 cursor-pointer' : 'cursor-default'}`}
            >
              <div className="w-7 h-7 rounded-full bg-purple-100 dark:bg-purple-900/50 text-purple-700 dark:text-purple-300 text-xs font-bold flex items-center justify-center shrink-0 mt-0.5">
                {i + 1}
              </div>
              <div className="flex-1 min-w-0">
                <div className="flex items-center gap-2 flex-wrap mb-0.5">
                  <span className="font-semibold text-gray-800 dark:text-gray-100 text-sm">{displayName}</span>
                  {badge && (
                    <span className={`px-1.5 py-0.5 rounded text-xs font-medium ${badge.cls}`}>
                      {badge.label}
                    </span>
                  )}
                  <span className="text-xs text-gray-400 ml-auto shrink-0">
                    {result.score} resonated
                  </span>
                </div>
                {result.positive_qualities && (
                  <p className="text-xs text-gray-500 dark:text-gray-400 italic line-clamp-3 leading-relaxed">
                    {result.positive_qualities}
                  </p>
                )}
              </div>
            </button>
          );
        })}
      </div>

      <p className="text-xs text-gray-400 dark:text-gray-500 text-center leading-relaxed px-2">
        These suggestions are a starting point. Flower essence selection is most effective when you resonate personally with an essence&apos;s description.
      </p>

      <button
        onClick={onRetake}
        className="self-center px-6 py-2 bg-purple-600 hover:bg-purple-700 text-white rounded-lg font-medium transition-colors"
      >
        Retake Quiz
      </button>
    </div>
  );
}
