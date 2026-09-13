-- Migration 313: Update constituent_profiles editorial notes for Fo-Ti,
--   Japanese Knotweed, and Pedicularis densiflora

SET search_path TO herbal, public;

UPDATE herbal.constituent_profiles
SET editorial_note = 'Reynoutria multiflora root is characterized by stilbene glycosides, especially THSG, together with free and glycosylated anthraquinones such as emodin and physcion. These constituents support Fo-Ti''s antioxidant, anti-inflammatory, hepatoprotective, cardioprotective, and mild laxative actions, while its traditional reputation as a tonic and restorative herb is associated with the broader activity of its stilbene-rich fraction. Processing substantially alters the anthraquinone and stilbene profile and therefore affects both activity and safety.'
WHERE latin_name = 'Reynoutria multiflora';

UPDATE herbal.constituent_profiles
SET editorial_note = 'Reynoutria japonica root and rhizome are characterized by stilbenes and stilbene glycosides, particularly resveratrol and polydatin, together with anthraquinones such as emodin and physcion. These constituents support the herb''s anti-inflammatory, antioxidant, antimicrobial, and cardiovascular/circulatory actions, while the anthraquinone fraction contributes additional antimicrobial and mild laxative activity. Its combination of stilbene and anthraquinone chemistry is particularly distinctive.'
WHERE latin_name = 'Reynoutria japonica';

UPDATE herbal.constituent_profiles
SET editorial_note = 'Pedicularis densiflora appears to share the genus''s characteristic iridoid glycoside and phenylethanoid glycoside chemistry, represented most cautiously by aucubin and verbascoside. These constituent families are consistent with anti-inflammatory, analgesic, antioxidant, and tissue-soothing actions, which complement the herb''s traditional Western use as a skeletal-muscle relaxant for muscular tension, pain, and spasm. Species-specific phytochemical evidence remains limited, so the connection between its documented chemistry and distinctive muscle-relaxant reputation should be regarded as suggestive rather than established.'
WHERE latin_name = 'Pedicularis densiflora';
