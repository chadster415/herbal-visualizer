export type StrengthLevel = 'mild' | 'strong' | 'very_strong';

export interface Herb {
  id: number;
  latin_name: string;
  common_name: string;
  created_at: string;
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
