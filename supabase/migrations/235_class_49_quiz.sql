-- Migration 235: Class 49 — Respiratory III and Clinical quiz questions
-- Source: supabase/migrations/229_class_49_respiratory_iii_clinical_data.sql
SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_quiz_questions
             WHERE class_name = 'BHC - Class 49 - Respiratory III and Clinical') THEN
    RAISE NOTICE 'Class 49 quiz questions already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_quiz_questions
    (class_name, question_text, option_a, option_b, option_c, option_d,
     correct_option, explanation, snippet_text, section_header, sort_order)
  VALUES
    -- Q1  correct: a
    ('BHC - Class 49 - Respiratory III and Clinical',
     'Which herb is described as the most potent antiviral in the respiratory materia medica, sometimes causing a rash from viral shedding?',
     'Lomatium', 'Osha', 'Elecampane', 'Aralia',
     'a',
     'The notes describe Lomatium as the most potent antiviral, so effective that viral shedding can push waste out through the skin as a rash — start low and be careful with dosing.',
     'Lomatium is the most potent antiviral in the respiratory materia medica. It can be so effective that viral shedding pushes waste out through the skin as a rash — start low and be careful with dosing.',
     'Antiviral', 10),

    -- Q2  correct: b
    ('BHC - Class 49 - Respiratory III and Clinical',
     'Which herb is said to be specific for lung tissue restoration?',
     'Reishi', 'Prince Seng', 'Schizandra', 'Mullein',
     'b',
     'The notes state that Prince Seng (Pseudostellaria heterophylla) is specific for lung tissue restoration.',
     'Prince Seng (Pseudostellaria heterophylla) is specific for lung tissue restoration.',
     'Tonics / Trophorestoratives', 20),

    -- Q3  correct: c
    ('BHC - Class 49 - Respiratory III and Clinical',
     'What unique property of Schizandra makes it specifically useful for deep, chronic lung congestion?',
     'It is the most potent antiviral in the respiratory system', 'It dilates the bronchi and relaxes spasm', 'It has a specific ability to liquify hardened, accumulated lung material', 'It mineralizes the body and shifts it toward alkaline',
     'c',
     'The notes describe Schizandra as having a specific ability to liquify hardened, accumulated lung material — useful for deep, chronic lung congestion.',
     'Schizandra has a specific ability to liquify hardened, accumulated lung material — useful for deep, chronic lung congestion.',
     'Tonics / Trophorestoratives', 30),

    -- Q4  correct: d
    ('BHC - Class 49 - Respiratory III and Clinical',
     'Elecampane is described in these notes as targeting which specific anatomical area of the lungs?',
     'The upper bronchi and trachea', 'The pleural membrane', 'The nasal passages and sinuses', 'The deep structures where the alveoli are gummed up and gas exchange is not happening properly',
     'd',
     'The notes say to think deep lung structures with Elecampane — where the alveoli are gummed up and gas exchange is not happening properly.',
     'Think deep lung structures with elecampane — where the alveoli are gummed up and gas exchange is not happening properly. Elecampane root is indicated for fibrocystic pulmonary disease.',
     'Tonics / Trophorestoratives', 40),

    -- Q5  correct: a
    ('BHC - Class 49 - Respiratory III and Clinical',
     'In these notes, which part of Mullein does the instructor prefer, and why is the other part avoided?',
     'Flowers are preferred; the leaf hairs are irritating', 'Leaves are preferred; the root causes constipation', 'Root is preferred; the leaves lack active constituents', 'Seed pods are preferred; the flowers are too weak',
     'a',
     'The notes state Lisa prefers Mullein flowers over the leaves because the leaf hairs are irritating; flowers are moistening and nourishing to the lung tissues.',
     'Lisa prefers mullein flowers over the leaves — the leaf hairs are irritating. Flowers are moistening and nourishing to the lung tissues.',
     'Tonics / Trophorestoratives', 50),

    -- Q6  correct: b
    ('BHC - Class 49 - Respiratory III and Clinical',
     'Which two herbs are listed as both nervines AND circulatory stimulants supporting blood flow and gas exchange in the respiratory system?',
     'Lobelia and Wild Cherry Bark', 'Motherwort and Hawthorn', 'Lomatium and Osha', 'Goldenrod and Yerba Mansa',
     'b',
     'The notes describe both Motherwort and Hawthorn as serving double duty — nervine and circulatory stimulant — supporting blood flow underlying lung gas exchange.',
     'both circ stim as well, support the blood flow gas exchange',
     'Nervines', 60),

    -- Q7  correct: c
    ('BHC - Class 49 - Respiratory III and Clinical',
     'Lobelia is listed under which two respiratory action categories in these notes?',
     'Anticatarrhal and trophorestorative', 'Antiviral and antitussive', 'Antispasmodic and bronchodilator', 'Demulcent and expectorant',
     'c',
     'The notes list Lobelia under both antispasmodic and bronchodilator categories, and also antitussive. The most prominent pairing in the notes is antispasmodic and bronchodilator.',
     'Lobelia is the key antispasmodic and bronchodilator — relaxes bronchial structures and can cause vomiting at higher doses.',
     'Antispasmodic / Bronchodilator', 70),

    -- Q8  correct: d
    ('BHC - Class 49 - Respiratory III and Clinical',
     'What is the low dose range for Lobelia mentioned in these notes?',
     '30–60 drops', '60–90 drops', '1–5 drops', '5–30 drops',
     'd',
     'The notes specify a low dose of 5–30 drops for Lobelia; higher doses can cause vomiting.',
     'Lobelia: Relaxes structures, can cause vomiting; Used in asthma, anaphylaxis; Dilates other structures (e.g., cervix); Low dose: 5-30 drops',
     'Antispasmodic / Bronchodilator', 80),

    -- Q9  correct: a
    ('BHC - Class 49 - Respiratory III and Clinical',
     'Wild Cherry Bark serves which two respiratory roles in these notes?',
     'Antitussive and antispasmodic', 'Trophorestorative and bronchodilator', 'Immune modulator and anticatarrhal', 'Nervine and circulatory stimulant',
     'a',
     'The notes describe Wild Cherry Bark as both antitussive and antispasmodic — the primary herb for calming spasmodic cough.',
     'Wild Cherry Bark is both antitussive and antispasmodic — the primary herb for calming spasmodic cough.',
     'Antispasmodic / Antitussive', 90),

    -- Q10  correct: b
    ('BHC - Class 49 - Respiratory III and Clinical',
     'Goldenrod is listed as an anticatarrhal with a specific indication. What is that indication?',
     'Thick, stuck mucus that won''t move', 'A runny nose that won''t stop', 'Dry, unproductive cough', 'Postnasal drip with sore throat',
     'b',
     'The notes describe Goldenrod as anticatarrhal specifically for the runny nose that won''t stop.',
     'goldenrod = runny nose that won''t stop, so makes sense here',
     'Anticatarrhal', 100),

    -- Q11  correct: c
    ('BHC - Class 49 - Respiratory III and Clinical',
     'What caution is noted about using anticatarrhals when mucus is overproducing?',
     'Anticatarrhals should always be started immediately to prevent pneumonia', 'Anticatarrhals must be combined with demulcents to avoid tissue damage', 'If someone is overproducing mucus, let it play out before trying to dry it up', 'Anticatarrhals are contraindicated in viral infections',
     'c',
     'The notes state that when someone is overproducing mucus, something wants to come up and out — let it play out before reaching for anticatarrhals.',
     'if someone is overproducing mucus, something wants to come up and out, but let it play out before trying to dry it up',
     'Anticatarrhal', 110),

    -- Q12  correct: d
    ('BHC - Class 49 - Respiratory III and Clinical',
     'Osha and Oshala are described as very drying antivirals. What must always be done when using them?',
     'Combine with high-dose Vitamin C to prevent tissue damage', 'Stop at the first sign of a productive cough', 'Limit use to 3 days maximum', 'Balance with moistening herbs to prevent drying the tissues and causing a cough',
     'd',
     'The notes state that Osha and Oshala are very drying — always balance with moistening herbs, as overuse can dry the tissues and result in a cough even after killing the microbes.',
     'Osha and Oshala are very drying antivirals — always balance with moistening herbs. Overuse can dry the tissues, kill the microbes, but then produce a cough from the resulting dryness.',
     'Antiviral', 120),

    -- Q13  correct: a
    ('BHC - Class 49 - Respiratory III and Clinical',
     'Angelica is added to which treatment category in an asthma formula in these notes?',
     'Antispasmodics', 'Pulmonary tonics', 'Anticatarrhals', 'Immune modulators',
     'a',
     'The notes state that Angelica is added to the antispasmodic formula in asthma, and also serves as a relaxing expectorant and bronchodilator.',
     'Antispasmodics - add Angelica',
     'Asthma', 130),

    -- Q14  correct: b
    ('BHC - Class 49 - Respiratory III and Clinical',
     'Which herb is stated as the most-used pulmonary trophorestorative in asthma treatment in these notes?',
     'Elecampane', 'Astragalus', 'Lobelia', 'Schizandra',
     'b',
     'The notes state that Astragalus is used the most as a pulmonary trophorestorative in asthma, alongside Elecampane and Yerba Mansa.',
     'Pulmonary tonics: astragalus used the most + Elecampane and Yerba Mansa',
     'Asthma', 140),

    -- Q15  correct: c
    ('BHC - Class 49 - Respiratory III and Clinical',
     'How is asthma described in these notes at a physiological level?',
     'A bacterial infection causing bronchial fibrosis', 'A fungal overgrowth causing mucus accumulation in the alveoli', 'An immune response where bronchial smooth muscles become inflamed, thickened, puckered, and hypertonic, restricting airflow', 'A neurological misfiring causing uncontrolled bronchial dilation',
     'c',
     'The notes describe asthma as an immune response in which bronchial smooth muscles become inflamed, thickened, puckered, and hypertonic — restricting flow and influencing air exchange.',
     'an immune response, in response to perceived antigens; bronchial smooth muscles get inflamed, thickened, puckered, and hypertonic — restricts flow, influences air exchange and waste buildup',
     'Asthma', 150),

    -- Q16  correct: d
    ('BHC - Class 49 - Respiratory III and Clinical',
     'For hay fever terrain preparation through the winter, which three herbs are recommended to lessen spring allergic responses?',
     'Lomatium, Osha, and Goldenrod', 'Lobelia, Wild Cherry Bark, and Angelica', 'Schizandra, Prince Seng, and Mullein', 'Reishi, Astragalus, and Licorice',
     'd',
     'The notes describe preparing through winter with reishi, astragalus, and licorice to lessen spring allergic responses and mineralize the body.',
     'prepping the terrain of the body through the winter — reishi, astragalus, licorice (?ratio in audio) — lessens allergic responses in the spring, esp licorice tea',
     'Hay Fever', 160),

    -- Q17  correct: a
    ('BHC - Class 49 - Respiratory III and Clinical',
     'Yerba Mansa is mentioned as an anticatarrhal that can be used in a specific topical method for hay fever. What is that method?',
     'A small amount of decoction added to the neti pot', 'Applied as a chest poultice with warm oil', 'Inhaled as a steam', 'Applied as a nasal spray diluted in saline',
     'a',
     'The notes state that Yerba Mansa can sometimes be used as a decoction, with a little bit added to the neti pot as a local anticatarrhal for hay fever.',
     'Yerba Mansa - sometimes little bit of decoction in neti pot',
     'Hay Fever', 170),

    -- Q18  correct: b
    ('BHC - Class 49 - Respiratory III and Clinical',
     'What correlation between organ health and seasonal allergies is noted in these notes?',
     'Poor kidney function correlates with worse winter respiratory infections', 'Liver issues tend to correlate with stronger seasonal allergies', 'Spleen deficiency worsens hay fever in spring', 'Adrenal fatigue worsens respiratory responses year-round',
     'b',
     'The notes state that liver issues tend to correlate with more seasonal allergies, and that preparation should involve shifting the body from acidic toward alkaline.',
     'liver issues tend to have more seasonal allergies',
     'Hay Fever', 180),

    -- Q19  correct: c
    ('BHC - Class 49 - Respiratory III and Clinical',
     'Gotu Kola is recommended in bronchitis to support which specific tissue concern?',
     'Mucosal lining regeneration in the trachea', 'Upper respiratory cilia regeneration', 'Deep connective tissue, targeting gas exchange and the integrity of alveolar tissues', 'Pleural membrane support',
     'c',
     'The notes state that in bronchitis recovery, Gotu Kola supports deep connective tissue — targeting gas exchange and the integrity of alveolar tissues.',
     'In bronchitis recovery, support deep connective tissue with Gotu Kola — targeting gas exchange and the integrity of alveolar tissues. Airway inflammation can take up to a month to fully recover.',
     'Bronchitis', 190),

    -- Q20  correct: d
    ('BHC - Class 49 - Respiratory III and Clinical',
     'How long can airway inflammation take to fully recover after bronchitis, according to these notes?',
     'Up to a week', 'Up to 3 days', 'Up to 6 weeks', 'Up to a month',
     'd',
     'The notes state that once the airway is inflamed, it can take up to a month to recover.',
     'once the airway is inflamed, it can take up to a month to recover',
     'Bronchitis', 200),

    -- Q21  correct: a
    ('BHC - Class 49 - Respiratory III and Clinical',
     'Which bronchitis symptom in these notes is described as a warning sign of possible advancement to pneumonia?',
     'Fever spike', 'Productive cough with yellow sputum', 'Gray or blue discoloration of the lips', 'Malaise lasting more than a week',
     'a',
     'The notes state that if fever spikes, be alert for advancement to pneumonia.',
     'if fever spikes, be alert of advance to pneumonia',
     'Bronchitis', 210),

    -- Q22  correct: b
    ('BHC - Class 49 - Respiratory III and Clinical',
     'What is the approximate dose of Astragalus specified in the dosing guidelines in these notes?',
     '1–2 mL (about 40 drops)', '2–4 mL (approximately 80 drops)', '0.5–1 mL (about 20 drops)', '5–10 mL (about 200 drops)',
     'b',
     'The notes specify Astragalus at 2–4 mL (approximately 80 drops) in the dosing guidelines.',
     'Astragalus: 2-4 mL, around 80 drops',
     'Dosing Notes', 220),

    -- Q23  correct: c
    ('BHC - Class 49 - Respiratory III and Clinical',
     'What is the dose range for Motherwort (Leonurus cardiaca) given in these notes?',
     '0.5–2 mL', '3–6 mL', '1–4 mL', '5–10 mL',
     'c',
     'The notes specify Leonurus cardiaca (Motherwort) at 1–4 mL in the dosing guidelines.',
     'Leonurus cardiaca (Motherwort): 1-4 mL',
     'Dosing Notes', 230),

    -- Q24  correct: d
    ('BHC - Class 49 - Respiratory III and Clinical',
     'For chronic and tonic conditions, how should dosing frequency and range be adjusted compared to acute conditions?',
     'Chronic conditions use the same high dose but less frequently', 'Chronic conditions always require the highest dose possible', 'Acute and chronic dosing are identical', 'Acute conditions use frequent dosing at the high therapeutic range; chronic/tonic uses medium-low range less frequently',
     'd',
     'The notes state that acute conditions require frequent dosing at the high therapeutic range, while chronic/tonic conditions use medium-low range and less frequent dosing.',
     'Acute conditions: frequent dosing, high therapeutic range; Chronic/tonic: medium-low range, less frequent',
     'Dosing Notes', 240),

    -- Q25  correct: a
    ('BHC - Class 49 - Respiratory III and Clinical',
     'What preparation method is described for Cherry Bark as an example of a traditionally made tincture?',
     'Harvested and prepped with brandy and honey, then strained', 'Dried bark macerated in 40% alcohol for 6 weeks', 'Fresh bark cold-infused in water overnight', 'Powdered bark dissolved in glycerin',
     'a',
     'The notes describe Cherry Bark as an example of a tincture harvested and prepped with brandy and honey, then strained for use.',
     'Cherry bark: harvested and prepped with brandy and honey, strained for use',
     'Percolation Notes', 250),

    -- Q26  correct: b
    ('BHC - Class 49 - Respiratory III and Clinical',
     'According to these notes, how does percolation differ from maceration in terms of astringency?',
     'Percolation is less astringent than maceration', 'Percolation has a more astringent quality than standard maceration', 'Both methods produce identical astringency', 'Maceration is always more astringent due to longer contact time',
     'b',
     'The notes state that percolation has a more astringent quality than standard maceration.',
     'Percolation has more astringent quality than standard maceration.',
     'Percolation Notes', 260),

    -- Q27  correct: c
    ('BHC - Class 49 - Respiratory III and Clinical',
     'What dietary additions are mentioned in these notes as helpful for asthma?',
     'High-fat dairy and fermented foods', 'Elimination of all grains and nightshades', 'Sulfur compounds from cruciferous vegetables and alliums', 'High-dose vitamin C from citrus',
     'c',
     'The notes mention that sulfur compounds from cruciferous vegetables and alliums are helpful in asthma.',
     'sulfur compounds in cruciferous veggies helpful; alliums too',
     'Asthma', 270),

    -- Q28  correct: d
    ('BHC - Class 49 - Respiratory III and Clinical',
     'Which extraction quality indicator is mentioned in these notes for assessing tincture quality?',
     'The smell of the finished product', 'Specific gravity measured with a hydrometer', 'A lighter color indicating purity', 'A darker color indicating better extraction',
     'd',
     'The notes state that color indicates extraction quality — a darker tincture is better.',
     'Color indicates extraction quality — darker tincture better',
     'Percolation Notes', 280),

    -- Q29  correct: a
    ('BHC - Class 49 - Respiratory III and Clinical',
     'What role does glycerin play in tincture-making as described in these notes?',
     'It holds tannins more strongly than alcohol alone', 'It reduces the astringency of tannin-rich herbs', 'It replaces alcohol in all resinous extractions', 'It improves the shelf life of mucilaginous herbs',
     'a',
     'The notes state that glycerin holds tannins — tannins are stronger with glycerin.',
     'Glycerin holds tannins — tannins stronger with glycerin',
     'Percolation Notes', 290),

    -- Q30  correct: b
    ('BHC - Class 49 - Respiratory III and Clinical',
     'What is the most common cause of bronchitis mentioned in these notes, and what secondary risk does it create?',
     'Bacterial infection that spreads to the sinuses', 'Viral infection that can then leave the lungs vulnerable to bacterial infection', 'Allergic reaction that leads to chronic inflammation', 'Fungal overgrowth that progresses to pneumonia',
     'b',
     'The notes state that the most common cause of bronchitis is viral, and that this can then leave the lungs vulnerable to secondary bacterial infection.',
     'most common cause is viral, can then leave lungs vulnerable to bacterial infection',
     'Bronchitis', 300)
  ;
END $$;
