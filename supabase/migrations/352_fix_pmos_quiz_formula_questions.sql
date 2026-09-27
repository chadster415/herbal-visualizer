-- Fix two Class 71 PMOS quiz questions that tested formula ml proportions (not clinically useful).
-- Replacing with questions that test mechanism and clinical reasoning.

UPDATE herbal.class_quiz_questions
SET
    question_text      = 'Cinnamon has a traditional indication beyond metabolic support — what is it?',
    option_a           = 'Postpartum hemorrhage and loss of uterine tone',
    option_b           = 'Uterine fibroids and heavy menstrual bleeding',
    option_c           = 'Cervical ripening and labor induction',
    option_d           = 'Ovarian cyst resolution',
    correct_option     = 'a',
    explanation        = 'Beyond improving insulin sensitivity, Cinnamon is a classical herb for postpartum hemorrhage and loss of uterine tone — clinically relevant for the PMOS patient population.',
    snippet_text       = 'Cinnamon: postpartum hemorrhage, loss of uterine tone; also improves insulin sensitivity and glucose levels; has eugenol (anti-inflammatory).'
WHERE class_name = 'BHC - Class 71 - PMOS'
  AND sort_order = 330;

UPDATE herbal.class_quiz_questions
SET
    question_text      = 'Andrographis carries which important reproductive precaution?',
    option_a           = 'Avoid in patients with autoimmune conditions',
    option_b           = 'Contraindicated with progesterone supplementation',
    option_c           = 'Not for use in pregnancy; avoid when actively trying to conceive',
    option_d           = 'Do not combine with other bitter herbs',
    correct_option     = 'c',
    explanation        = 'Andrographis should not be used during pregnancy and is best avoided when a patient is actively trying to conceive — an important safety point for the PMOS patient.',
    snippet_text       = 'Andrographis: not for use during pregnancy or lactation (Easley); avoid when trying to conceive; specific for liver congestion with intolerance to fats.'
WHERE class_name = 'BHC - Class 71 - PMOS'
  AND sort_order = 390;
