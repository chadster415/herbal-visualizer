'use client';

interface Props {
  isOpen: boolean;
  onClose: () => void;
}

export function FormulaMethodModal({ isOpen, onClose }: Props) {
  if (!isOpen) return null;

  return (
    <div
      className="fixed inset-0 bg-black/50 z-50 flex items-center justify-center p-4"
      onClick={onClose}
    >
      <div
        className="bg-white rounded-xl shadow-2xl max-w-2xl w-full max-h-[85vh] overflow-y-auto"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Header */}
        <div className="sticky top-0 bg-white border-b border-gray-100 px-6 py-4 flex items-start justify-between rounded-t-xl">
          <div>
            <h2 className="text-xl font-bold text-green-800">The Art of Herbal Formulation</h2>
            <p className="text-sm text-gray-500 mt-0.5 italic">Herbal Formularies, Vol. 3 — Jill Stansbury</p>
          </div>
          <button
            onClick={onClose}
            className="ml-4 shrink-0 text-gray-400 hover:text-gray-600 transition-colors text-2xl leading-none"
            aria-label="Close"
          >
            ×
          </button>
        </div>

        {/* Body */}
        <div className="px-6 py-5 space-y-6 text-sm text-gray-700 leading-relaxed">

          {/* Intro */}
          <p>
            Rather than prescribing a single herb for a diagnosis, this approach builds a formula around
            at least three herbs that each play a distinct role — forming a <strong>triangle</strong>.
            The aim is to treat the <em>person</em> and their unique presentation, not the diagnosis alone.
          </p>

          {/* Triangle */}
          <div className="border border-green-200 rounded-lg overflow-hidden">
            <div className="bg-green-50 px-4 py-2 border-b border-green-200">
              <h3 className="font-semibold text-green-800">The Formula Triangle</h3>
            </div>
            <div className="divide-y divide-gray-100">

              <div className="px-4 py-3">
                <div className="flex items-baseline gap-2 mb-1">
                  <span className="font-semibold text-emerald-700">Base</span>
                  <span className="text-xs text-gray-400 italic">also called Lead herb or Director</span>
                </div>
                <p>
                  The nourishing foundation of the formula. Choose a tonic, restorative, alterative,
                  adaptogenic, or nutritive herb with a strong affinity for the primary organ system.
                  It should be broadly indicated, non-toxic, and suited to long-term use. This is the
                  easiest choice — it is often the herb best known for supporting a particular system.
                </p>
                <p className="mt-1 text-gray-500 italic">
                  Example: <em>Crataegus</em> as a cardiovascular base; <em>Withania</em> for exhaustion-driven insomnia.
                </p>
              </div>

              <div className="px-4 py-3">
                <div className="flex items-baseline gap-2 mb-1">
                  <span className="font-semibold text-sky-700">Synergist</span>
                  <span className="text-xs text-gray-400 italic">also called Adjuvant, Balancer, or Assistant</span>
                </div>
                <p>
                  Corrects or complements the base, helping drive it to the right tissues. Addresses
                  underlying contributing factors — other organ systems involved, energetic imbalances,
                  or constitutional patterns. Requires a deeper understanding of the full case than
                  choosing the base does.
                </p>
                <p className="mt-1 text-gray-500 italic">
                  Example: <em>Ginkgo</em> as a synergist to combat circulatory stress in a hypertensive smoker.
                </p>
              </div>

              <div className="px-4 py-3">
                <div className="flex items-baseline gap-2 mb-1">
                  <span className="font-semibold text-violet-700">Specific</span>
                  <span className="text-xs text-gray-400 italic">also called Kicker or Energetic Specific</span>
                </div>
                <p>
                  Selected not for a diagnosis, but for the precise <em>quality and expression</em> of
                  the individual&apos;s presentation: their pulse, tongue, affect, pathology, etiology,
                  and unique symptoms. This is what makes a formula truly individualized. The art of
                  choosing a specific comes from careful study, observation, and clinical practice.
                </p>
                <p className="mt-1 text-gray-500 italic">
                  Example: <em>Rauwolfia</em> as a specific for hypertension with a throbbing headache
                  in a Type-A, high-stress person.
                </p>
              </div>
            </div>
          </div>

          {/* Key principles */}
          <div className="space-y-4">

            <div>
              <h3 className="font-semibold text-gray-800 mb-1">Treat the Person, Not the Diagnosis</h3>
              <p>
                Two people with the same diagnosis may need entirely different formulas. A formula for
                insomnia with exhaustion rests on a chi tonic like <em>Panax</em>, while a restless,
                heat-excess insomnia calls for something cooling and relaxing like <em>Avena</em> or
                <em> Scutellaria</em>. The presenting symptoms, constitution, and life history all shape
                which herbs are most appropriate.
              </p>
            </div>

            <div>
              <h3 className="font-semibold text-gray-800 mb-1">Energetic Fine-Tuning</h3>
              <p>
                Herbs are chosen to match the patient&apos;s energetic state: hot or cold, damp or dry,
                tense or lax. TCM (yin/yang), Ayurveda (doshas), and Western four-elements theory all
                offer frameworks for this. Even without a formal system, simply noticing whether a
                patient runs hot or cold — and choosing herbs with opposite qualities — is a powerful
                guide.
              </p>
            </div>

            <div>
              <h3 className="font-semibold text-gray-800 mb-1">Supporting Vitality</h3>
              <p>
                Herbal medicine takes a <strong>physiologic</strong> approach: gently nourishing and
                restoring organ function over time rather than suppressing symptoms. The goal is to
                support the body&apos;s innate healing capacity — the <em>vital force</em> — rather than
                opposing disease directly. Tonifying, restorative base herbs ensure every formula
                begins with nourishment.
              </p>
            </div>

            <div>
              <h3 className="font-semibold text-gray-800 mb-1">How to Use This Builder</h3>
              <p>
                Start by identifying the primary body system and selecting actions you need the
                formula to perform. The builder suggests candidates for each triangle role — Base,
                Synergist, and Specific — filtered by those actions and scored against the patient&apos;s
                constitutional energetics. Use it as a starting point, then apply your clinical
                judgment to arrive at a finely tuned, individualized formula.
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
