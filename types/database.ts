export type StrengthLevel = 'mild' | 'strong' | 'very_strong';

export type TemperatureEnergetic = 'warming' | 'cooling' | 'neutral';
export type MoistureEnergetic = 'moistening' | 'drying' | 'neutral';
export type ToneEnergetic = 'toning' | 'relaxing' | 'neutral';
export type TasteEnergetic = 'sweet' | 'bitter' | 'pungent' | 'salty' | 'sour';

export interface Herb {
  id: number;
  latin_name: string;
  common_name: string;
  plant_part?: string | null;
  created_at: string;
  temperature?: TemperatureEnergetic;
  moisture?: MoistureEnergetic;
  tone?: ToneEnergetic;
  taste?: TasteEnergetic | null;
  temperature_inferred?: boolean;
  moisture_inferred?: boolean;
  tone_inferred?: boolean;
  taste_inferred?: boolean;
  monograph_url?: string | null;
  pinyin_name?: string | null;
  is_tcm?: boolean;
  contraindications?: string | null;
  contraindications_source?: string | null;
  synonyms?: string[];
}

export interface PrimaryAction {
  id: number;
  name: string;
  description?: string;
  created_at: string;
}

export interface SecondaryAction {
  id: number;
  name: string;
  created_at: string;
}

export interface BodySystem {
  id: number;
  name: string;
  created_at: string;
}

export interface HerbPrimaryAction {
  id: number;
  herb_id: number;
  primary_action_id: number;
  body_system_id: number;
  body_system_note?: string;
  relative_strength?: StrengthLevel;
  created_at: string;
}

export interface HerbSecondaryAction {
  id: number;
  herb_id: number;
  secondary_action_id: number;
  created_at: string;
}

// View types for queries
export interface HerbWithDetails extends Herb {
  primary_actions?: Array<{
    action: PrimaryAction;
    body_system: BodySystem;
    body_system_note?: string;
    relative_strength?: StrengthLevel;
  }>;
  secondary_actions?: SecondaryAction[];
}

export interface PrimaryActionWithHerbs extends PrimaryAction {
  herbs?: Array<{
    herb: Herb;
    body_system: BodySystem;
    relative_strength?: StrengthLevel;
  }>;
}

// Disorder types
export interface Disorder {
  id: number;
  name: string;
  body_system_id: number;
  sort_order: number;
  is_case_study: boolean;
  created_at: string;
}

export interface DisorderNote {
  id: number;
  disorder_id: number;
  note_text: string;
  sort_order: number;
  section: string;
  heading?: string | null;
  created_at: string;
}

export interface DisorderActionIndicated {
  id: number;
  disorder_id: number;
  primary_action_id: number;
  description: string;
  sort_order: number;
  created_at: string;
}

export interface DisorderActionHerb {
  id: number;
  disorder_id: number;
  herb_id: number;
  primary_action_id: number;
  note?: string;
  sort_order: number;
  created_at: string;
}

export interface DisorderSpecificRemedy {
  id: number;
  disorder_id: number;
  herb_id: number;
  description: string;
  sort_order: number;
  created_at: string;
}

export interface DisorderPrescription {
  id: number;
  disorder_id: number;
  title?: string;
  instructions: string;
  sort_order: number;
  created_at: string;
}

export interface PrescriptionHerb {
  id: number;
  prescription_id: number;
  herb_id: number;
  parts: string;
  note?: string;
  sort_order: number;
  created_at: string;
}

export interface PrescriptionHerbAction {
  id: number;
  prescription_herb_id: number;
  primary_action_id: number;
  created_at: string;
}

// View types for disorder queries
export interface DisorderWithDetails extends Disorder {
  body_system?: BodySystem;
  notes?: DisorderNote[];
  actions_indicated?: Array<{
    action: PrimaryAction;
    description: string;
    sort_order: number;
  }>;
  action_herbs?: Array<{
    action: PrimaryAction;
    herbs: Array<{
      herb: Herb;
      note?: string;
      sort_order: number;
    }>;
  }>;
  specific_remedies?: Array<{
    herb: Herb;
    description: string;
    sort_order: number;
  }>;
  prescriptions?: Array<{
    id: number;
    title?: string;
    instructions: string;
    sort_order: number;
    herbs: Array<{
      herb: Herb;
      parts: string;
      note?: string;
      actions?: PrimaryAction[];
      sort_order: number;
    }>;
  }>;
}

export interface HerbWithDisorders extends Herb {
  disorders?: Array<{
    disorder: Disorder;
    body_system: BodySystem;
    actions: PrimaryAction[];
  }>;
}

export type ConcentrationLevel = 'trace' | 'minor' | 'moderate' | 'major' | 'primary';

export interface Constituent {
  id: number;
  name: string;
  category: string;
  description?: string | null;
  created_at: string;
}

export interface HerbConstituent {
  id: number;
  herb_id: number;
  constituent_id: number;
  concentration_level: ConcentrationLevel;
  notes?: string | null;
  needs_review: boolean;
  sort_order: number;
  created_at: string;
  constituents: Constituent;
}

export interface HerbMonographLink {
  id: number;
  herb_id: number;
  url: string;
  label?: string | null;
  sort_order: number;
  created_at: string;
}

export interface HerbMenstruum {
  herb_id: number;
  alcohol_pct_min?: number | null;
  alcohol_pct_max?: number | null;
  glycerin_pct?: number | null;
  vinegar_pct?: number | null;
  water_effective: boolean;
  primary_label: string;
  notes?: string | null;
  needs_review: boolean;
  created_at: string;
}

export interface ConstituentWithHerbs extends Constituent {
  herb_constituents: Array<{
    herb_id: number;
    concentration_level: ConcentrationLevel;
    herbs: Pick<Herb, 'id' | 'common_name' | 'latin_name'>;
  }>;
}

export interface Supplement {
  id: number;
  name: string;
  category: string;        // 'Vitamin' | 'Mineral' | 'Amino Acid' | 'Enzyme' | 'Other'
  subcategory: string | null;
  solubility: string | null;
  description: string | null;
  dose_range: string | null;
  dose_notes: string | null;
  deficiency_signs: string | null;
  dietary_sources: string | null;
  absorption_notes: string | null;
  drug_depletors: string | null;
  temperature: string | null;   // explicit override; null = use category default
  sort_order: number;
  created_at: string;
}

export interface PrescriptionSupplement {
  id: number;
  prescription_id: number;
  supplement_id: number;
  dose: string | null;
  note: string | null;
  sort_order: number;
  created_at: string;
}

// Flower Essence tables (Part One = soul conditions, Part Two = plant profiles)

export interface FlowerEssencePlant {
  id: number;
  name: string;
  latin_name: string | null;
  color: string | null;
  kit: string | null;
  positive_qualities: string | null;
  patterns_of_imbalance: string | null;
  description: string | null;
  cross_references: string[] | null;
  created_at: string;
}

export interface FlowerEssenceConditionEntry {
  id: number;
  category: string;
  plant_name: string;
  plant_id: number | null;
  description: string | null;
}

export interface FlowerEssenceSeeAlso {
  from_category: string;
  to_category: string;
}

export interface FlowerEssenceCategory {
  category: string;
  search_keywords: string[];
}

export interface FlowerEssenceCategoryWithEntries extends FlowerEssenceCategory {
  entries: FlowerEssenceConditionEntry[];
  see_also_from: string[];
  see_also_to: string[];
}
