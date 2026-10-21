'use client';

import { useState } from 'react';

type DosingHerb = { id: number; common_name: string; latin_name: string; plant_part: string | null };

export function useModalState() {
  const [flashcardsOpen, setFlashcardsOpen] = useState(false);
  const [energeticsQuizOpen, setEnergeticsQuizOpen] = useState(false);
  const [herbFilterOpen, setHerbFilterOpen] = useState(false);
  const [formulaBuilderOpen, setFormulaBuilderOpen] = useState(false);
  const [dosingCalculatorOpen, setDosingCalculatorOpen] = useState(false);
  const [doubleExtractionOpen, setDoubleExtractionOpen] = useState(false);
  const [menstruumCalculatorOpen, setMenstruumCalculatorOpen] = useState(false);
  const [dosingInitialHerbs, setDosingInitialHerbs] = useState<DosingHerb[]>([]);
  const [intakeFormOpen, setIntakeFormOpen] = useState(false);
  const [bodyDiagramOpen, setBodyDiagramOpen] = useState(false);
  const [helpOpen, setHelpOpen] = useState(false);
  const [flowerEssenceQuizOpen, setFlowerEssenceQuizOpen] = useState(false);
  const [classQuizOpen, setClassQuizOpen] = useState(false);
  const [openQuizClass, setOpenQuizClass] = useState<string | null>(null);
  const [loginOpen, setLoginOpen] = useState(false);
  const [openDropdown, setOpenDropdown] = useState<'browse' | 'practice' | 'formulation' | 'quizzes' | null>(null);

  const closeAll = () => {
    setFlashcardsOpen(false);
    setEnergeticsQuizOpen(false);
    setHerbFilterOpen(false);
    setFormulaBuilderOpen(false);
    setDosingCalculatorOpen(false);
    setDoubleExtractionOpen(false);
    setMenstruumCalculatorOpen(false);
    setIntakeFormOpen(false);
    setBodyDiagramOpen(false);
    setHelpOpen(false);
    setFlowerEssenceQuizOpen(false);
    setClassQuizOpen(false);
    setLoginOpen(false);
    setOpenDropdown(null);
  };

  return {
    flashcardsOpen, setFlashcardsOpen,
    energeticsQuizOpen, setEnergeticsQuizOpen,
    herbFilterOpen, setHerbFilterOpen,
    formulaBuilderOpen, setFormulaBuilderOpen,
    dosingCalculatorOpen, setDosingCalculatorOpen,
    doubleExtractionOpen, setDoubleExtractionOpen,
    menstruumCalculatorOpen, setMenstruumCalculatorOpen,
    dosingInitialHerbs, setDosingInitialHerbs,
    intakeFormOpen, setIntakeFormOpen,
    bodyDiagramOpen, setBodyDiagramOpen,
    helpOpen, setHelpOpen,
    flowerEssenceQuizOpen, setFlowerEssenceQuizOpen,
    classQuizOpen, setClassQuizOpen,
    openQuizClass, setOpenQuizClass,
    loginOpen, setLoginOpen,
    openDropdown, setOpenDropdown,
    closeAll,
  };
}
