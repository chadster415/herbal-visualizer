// Feature visibility config. Change these values to control who can see each feature.
// public: visible to all users
// private: visible only to logged-in users
// off: hidden from everyone
export type FeatureVisibility = 'public' | 'private' | 'off';

interface FeatureConfig {
  label: string;
  visibility: FeatureVisibility;
}

export const featureConfig = {
  // Browse views
  herbBrowser: { label: 'Herb Browser', visibility: 'public' },
  actionBrowser: { label: 'Action Browser', visibility: 'public' },
  bodySystemBrowser: { label: 'Body System Browser', visibility: 'public' },
  soulConditionBrowser: { label: 'Soul Condition Browser', visibility: 'public' },

  // Formulation tools
  herbPairings: { label: 'Herb Pairings', visibility: 'public' },
  formulaBuilder: { label: 'Formula Builder', visibility: 'public' },
  dosingCalculator: { label: 'Dosing Calculator', visibility: 'private' },
  doubleExtraction: { label: 'Double Extraction Calculator', visibility: 'private' },

  // Assessments
  energeticsQuiz: { label: 'Energetics Quiz', visibility: 'public' },
  intakeAssessment: { label: 'Intake Assessment', visibility: 'public' },
  flowerEssenceQuiz: { label: 'Flower Essence Quiz', visibility: 'public' },

  // Learning / quizzes
  classQuizzes: { label: 'Class Quizzes', visibility: 'public' },
  flashcards: { label: 'Flashcards', visibility: 'public' },
  classNotes: { label: 'Class Notes', visibility: 'public' },

  // User-specific
  inventory: { label: 'Inventory', visibility: 'private' },
} satisfies Record<string, FeatureConfig>;

export type FeatureKey = keyof typeof featureConfig;

export function isFeatureVisible(feature: FeatureKey, isLoggedIn: boolean): boolean {
  const { visibility } = featureConfig[feature] as FeatureConfig;
  if (visibility === 'off') return false;
  if (visibility === 'private') return isLoggedIn;
  return true;
}
