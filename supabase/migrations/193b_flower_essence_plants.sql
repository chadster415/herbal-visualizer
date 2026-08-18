-- ============================================================
-- Insert plant profiles
-- ============================================================

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Agrimony',
  'Agrimonia eupatoria',
  'yellow',
  'English Kit',
  'Emotional honesty, acknowledging and working with emotional pain, obtaining true inner peace',
  'Anxiety hidden by a mask of cheerfulness; denial and avoidance of emotional pain, addictive behavior to anesthetize feelings',
  'The Agrimony personality appears happy, enthusiastic, popular, and seemingly at peace with the world. However, if one is able to know such a person on a deeper level, it becomes clear that something is deeply troubling the soul. At the heart of such suffering is a secret torment that is hidden, not only from others, but most importantly from the Self. There may be a strong attraction to drugs, particularly alcohol, in order to maintain the mask of cheerfulness. Such persons have often been raised with strict social conventions of politeness or repression, and find it difficult to show or admit vulnerability or pain. This conditioning is particularly strong in men who have been taught that it is unmanly to show feelings. Another variation of this attitude appears among those on a spiritual path who try to emulate a state of bliss by denying or repressing troubling emotions. The Agrimony person needs to find peace as an inner soul reality, rather than an outer state of behavior which others validate. It is their lesson that true inner peace comes from honestly acknowledging pain and transforming it, rather than masking it with a superficial veneer of good cheer or polite tolerance.',
  ARRAY['Acceptance', 'Addiction', 'Avoidance', 'Calm', 'Cheerfulness', 'Co-Dependence', 'Community Life and Group Experience', 'Conflict', 'Denial', 'Eating Disorders', 'Escapism', 'False Persona', 'Healers', 'Healing Process', 'Honesty', 'Masculine Consciousness', 'Mid-Life Crisis', 'Perfectionism', 'Repression', 'Resistance', 'Shame', 'True to Self']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Aloe Vera',
  'Aloe vera',
  'yellow',
  'Professional Kit',
  'Creative activity balanced and centered in vital life-energy',
  'Overuse or misuse of fiery, creative forces; "burned-out" feeling',
  'Those needing Aloe Vera "burn the candle at both ends." They have an innate abundance of fiery forces, but tend to overuse these forces and literally "bum out." Typical of the Aloe Vera type are "workaholics" whose drive is so intense that they neglect their emotional and physical needs, often sacrificing rest, food, and social contact in order to accomplish their goals. Such an attitude cripples the ability to experience life in a heart-felt way, impoverishing the feeling life, and draining the body of vital energy. While will-power can carry such persons quite far, eventually they reach a point of exhaustion, burnout, or breakdown. Aloe Vera helps the soul and body aspects to come into greater harmony, by bringing the nourishment which comes from the water polarity of life — the flowing qualities of renewal and rejuvenation. When the soul learns to balance the fiery forces of the will with the fountain of feeling from the heart, a tremendous outpouring of positive creativity and spirituality can be realized.',
  ARRAY['Action', 'Ambition', 'Body', 'Creativity', 'Devitalization', 'Dryness', 'Energetic Patterns', 'Exhaustion and Fatigue', 'Heart', 'Masculine Consciousness', 'Materialism and Money', 'Menopause', 'Mid-life', 'Crisis', 'Moderation', 'Rejuvenation', 'Stress', 'Time Relationship', 'Vitality']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Alpine Lily',
  'Lilium parvum',
  'red-orange',
  'Research Kit',
  'For women, acceptance of one''s femininity grounded in a deepened experience of the female body',
  'Overly abstract sense of femininity; alienation from or rejection of female organs as "lower" disembodied,',
  'Alpine Lily helps the feminine soul experience a more vibrant relationship to the female body. While this remedy can sometimes be indicated for men who are addressing inner feminine aspects of themselves, it is primarily beneficial for women who harbor a psychological split in their relationship to the feminine principle. These women tend to favor that which is more cosmic and virginal, and find it difficult to identify with the earthly aspect of the feminine. They have many spiritual attributes and actively use higher feminine forces, but do not integrate this consciousness with the physical body. Negative impressions of the female body are often unconsciously absorbed from the mother or from the larger culture. Because the soul does not fully identify with or inhabit its female body, physical stress and disharmony can result in the reproductive organs, in the sexual function, or in the biological experience of pregnancy and nursing. Alpine Lily stimulates the integration of the feminine and female selves, promoting circulation between the higher and lower energy centers. The soul learns that its full energy and potential depends on the utilization of the bodily female as well as the spiritual feminine.',
  ARRAY['Acceptance', 'Adolescence', 'Alienation', 'Ambivalence', 'Body', 'Conflict', 'Feminine Consciousness', 'Groundedness', 'Heart', 'Inner Child', 'Instinctual Self', 'Lower Self', 'Menopause', 'Mother and Mothering', 'Perfectionism', 'Pregnancy', 'Self-Acceptance', 'Sexuality', 'Shame', 'Soulfulness', 'Vitality']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Angel''s Trumpet',
  'Datura candida',
  'white',
  'Research Kit',
  'Spiritual surrender at death or at times of deep transformation; opening the heart to the spiritual world',
  'Fear of death, resistance to letting go of life or to crossing the spiritual threshold; denial of the reality of the spiritual world',
  'Angel''s Trumpet is used especially for the soul''s capacity to experience death, or any profound transformation, in a way which is conscious and free. A key word in understanding Angel''s Trumpet is surrender — for situations when it is no longer appropriate to fight death, or for ego surrender, when the soul must utterly submit itself to a process of spiritualization. With Angel''s Trumpet, the soul can experience these processes as joyous transitions rather than as fearsome ordeals. The soul realizes that death is a form of birth when seen from the spiritual world, and comes to recognize those spiritual beings who wait on the other side. This remedy is helpful in hospice work, in wartime, during natural disasters and for all occasions when we are called to minister to loved ones who are departing from physical form. It is also helpful for therapists who must guide the soul through deeply transformative, "rebirthing" processes. Angel''s Trumpet facilitates profound soul opening, transforming the fear of death into the conscious awareness of spiritual life.',
  ARRAY['Aging', 'Attachment', 'Calm', 'Death and Dying', 'Denial', 'Emergency', 'Grace', 'Joy', 'Meditation', 'Non-Attachment', 'Perspective', 'Release', 'Resistance', 'Spiritual Emergency or Opening', 'Surrender', 'Transcendence', 'Transition']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Angelica',
  'Angelica archangelica',
  'white',
  'Research Kit',
  'Feeling protection and guidance from spiritual beings, especially at threshold experiences such as birth and death',
  'Feeling cut off, bereft of spiritual guidance and protection',
  'The modern human soul suffers in a way which is unique and tragic, for it must face profound spiritual isolation and separation through living in a materialistically dense and technologically abstract world culture. The Angelica flower essence addresses the soul''s experience of compression and restriction by quickening the thinking and perception processes. The soul becomes more able to perceive and discriminate its connection to the subtle sheaths surrounding the physical world. Angelica especially encourages the individual to develop a relationship with the spiritual world, transforming an overly abstract or intellectual viewpoint into a genuine feeling for spiritual presence and spiritual beings. This awareness is particularly enhanced for that group of spiritual beings who immediately border the human kingdom: the angels. Through a living relationship with the angelic realm, the human soul receives guardianship and guidance in daily affairs, and protection at times of crisis or during threshold experiences. This feeling of being protected and cared for is of enormous importance to the inner life, giving the soul great strength and courage for its work in transforming and healing the world. Angelica is broadly indicated for many flower essence formulas and is particularly important at threshold times such as birth, death, festival celebrations, or other major life passages.',
  ARRAY['Abandonment', 'Addiction', 'Adolescence', 'Aging', 'Awareness', 'Brokenheartedness', 'Centeredness', 'Certainty', 'Children', 'Death and Dying', 'Denial', 'Dreams and Sleep', 'Egotism', 'Emergency', 'Environment', 'Faith', 'Fear', 'Grace', 'Harmony', 'Healing Process', 'Influence', 'Inner Child', 'Insight', 'Lightness', 'Love', 'Materialism and Money', 'Meditation', 'Perspective', 'Pregnancy', 'Prejudice', 'Protection', 'Quiet', 'Receptivity', 'Rejection', 'Sensitivity', 'Soulfulness', 'Spiritual Emergency or Opening', 'Thinking', 'Toner', 'Trust']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Arnica',
  'Arnica mollis',
  'yellow',
  'Professional Kit',
  'Conscious embodiment, especially during shock or trauma; recovery from deep-seated shock or trauma',
  'Disconnection of Higher Self from body during shock or trauma; disassociation, unconsciousness',
  'Arnica helps to heal deep-seated shock or trauma which may become locked into the body and prevent full healing recovery. Especially during accidents or violent experiences, the Higher Self or soul disassociates from its physical vehicle, and may never properly re-enter certain parts of the body despite seeming recovery. This remedy can be especially helpful for unlocking many puzzling or psychosomatic illnesses, which do not respond to obvious treatment. When Arnica is used for such cases, the soul will often relive or re-experience the emotional trauma which accompanied the original experience. In this way the soul is finally able to integrate the experience and to fully inhabit the part of the body which suffers. Arnica can also be used on a short-term first-aid basis to allow rapid recovery from trauma. It especially helps the soul attain greater awareness of the parts of the psyche or body which may be under-utilized in the individual''s full expression of Self.',
  ARRAY['Addiction', 'Animals and Animal Care', 'Body', 'Emergency', 'Energetic Patterns', 'Healing Process', 'Massage', 'Psychosomatic', 'illness', 'Shock', 'Spiritual Emergency or Opening', 'Time Relationship', 'Vitality']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Aspen',
  'Populus tremula',
  'green/gray',
  'English Kit',
  'Trust and confidence to meet the unknown, drawing inner strength from the spiritual world',
  'Fear of the unknown, vague anxiety and apprehension, hidden fears, nightmares',
  'The Aspen personality has a disproportionately developed astral body, especially in relationship to the ego, or conscious awareness. Such persons readily receive impressions from other planes of reality; however, these intimations are perceived on the subconscious level, and often produce feelings of fear and foreboding. Aspen flower essence quiets and subdues the astral body so that the spiritual ego can gain greater strength and awareness. This flower is very helpful for children who are oversensitive to unseen and unknown influences, and can also be indicated for those who may have prematurely opened their astral sheaths through drug use or occult ritual. Aspen essence calms and harmonizes the innate psychic capacities of such individuals, by allowing the conscious mind to receive and process more information. In this way, Aspen brings greater strength and confidence, and balanced use of soul forces.',
  ARRAY['Addiction', 'Animals and Animal Care', 'Anxiety', 'Children', 'Courage', 'Faith', 'Fear', 'Insecurity', 'Insomnia', 'Manifestation', 'Nervousness', 'Paranoia', 'Sensitivity', 'Spiritual Emergency or Opening', 'Surrender', 'Trust']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Baby Blue Eyes',
  'Nemophila menziesii',
  'light blue',
  'Research Kit',
  'Childlike innocence and trust; feeling at home in the world, at ease with oneself, supported and loved; connected with the spiritual world',
  'Defensiveness, insecurity, mistrust of others; estrangement from the spiritual world; lack of support from the father in childhood',
  'Those who need Baby Blue Eyes feel unsure of themselves and are unable to trust in the goodness of others and of the world. Such individuals did not receive proper emotional support during childhood, and in particular may have lacked a healthy connection with the father or father-figure as a positive force of protection and guidance. If the father is absent, emotionally or physically, or if he is erratic and threatening (as with alcoholic violence), then the child is deprived of a basic sense of security and protection, and will grow up with a core belief that the world is an unsafe place in which to be. Such souls find it difficult to "let down their guard;" they tend to develop a protective shell of defensiveness, or intellectual cynicism. They especially find it difficult to be engaged in spiritual causes or pursuits, because they feel a lack of trust and support from the spiritual world. In extreme cases, this soul posture can lead not only to emotional isolation but also to antisocial or criminal tendencies, as the individual negates or reverses its positive spiritual connection. Baby Blue Eyes helps to restore the soul''s original innocence and childlike trust. The soul is helped in its healing by learning to recognize goodness in others and in the world, and thus to become more accepting, positive and open in its expressions and actions.',
  ARRAY['Abandonment', 'Acceptance', 'Addiction', 'Adolescence', 'Aging', 'Alienation', 'Aloofness', 'Blame', 'Children', 'Cynicism', 'Depression and Despair', 'Dullness', 'Faith', 'Father and Fathering', 'Feminine Consciousness', 'Forgiveness', 'Gloom', 'Hardness', 'Heart', 'Hostility', 'Inertia', 'Inner Child', 'Insecurity', 'Intimacy', 'Joy', 'Life Direction', 'Loneliness', 'Love', 'Masculine Consciousness', 'Perseverance', 'Pessimism', 'Rejection', 'Rejuvenation', 'Resentment', 'Self-Acceptance', 'Self-Actualization', 'Shadow Consciousness', 'Softness', 'Spiritual Emergency or Opening', 'Transcendence', 'Trust']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Basil',
  'Ocimum basilicum',
  'white',
  'Professional Kit',
  'Integration of sexuality and spirituality into a sacred wholeness',
  'Polarization of sexuality and spirituality, often leading to clandestine behavior or marital stress',
  'The soul in need of Basil tends to polarize and separate the experience of spirituality and sexuality, believing that these cannot be integrated. This affliction is most evident in relationships where there is a compulsive need to seek sexual liaisons outside the main partnership. Quite often sexual activity is associated with that which is secret or sinful. There is also a very strong attraction to pornography and other forms of illicit or illegal sexuality. The soul feels great tension between the polarities of spiritual purity and physical sexuality. In the unconscious struggle to reconcile these forces, the soul often capitulates to or becomes enmeshed in debasing and dehumanizing sexual activity. Once these polarities are brought together as a conscious unity, the soul no longer feels compelled to separate them into opposing and destructive activities. Basil flower essence helps the soul to experience the world and the Self as truly sacred and whole.',
  ARRAY['Addiction', 'Adolescence', 'Conflict', 'Desire', 'Escapism', 'Intimacy', 'Lower Self', 'Morality', 'Personal Relationships', 'Sexuality', 'Shame', 'Trust']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Beech',
  'Fagus sylvatica',
  'red',
  'English Kit',
  'Tolerance, acceptance of others'' differences and imperfections, seeing the good within each person and situation',
  'Criticalness, judgmental attitudes, intolerance; perfectionist expectations of others; oversensitivity to one''s social and physical environment',
  'The Beech remedy helps transform the tendency to be critical due to an inner sense of inferiority and hypersensitivity which is projected onto others. Very often such persons grew up in an environment of criticism and harsh expectation, and so they inwardly feel very vulnerable and insecure. However, they learn to cope by condemning others instead of healing themselves. Another characteristic of this type is hypersensitivity to personal environments, both physical and social. Their permeability to the influences around them leads to intolerance of imperfection in others. Beech softens the soul pain such persons feel; as they re-establish connection with their Higher Self, they sense the love and unconditional acceptance that radiates from the spiritual world. Through this warmth of soul, they are able to let go of their harsh and blaming ways, to accept others in the same way that they are accepted by the spiritual world.',
  ARRAY['Acceptance', 'Aging', 'Blame', 'Children', 'Community Life and Group Experience', 'Criticism', 'Destructiveness', 'Detail', 'Dislike', 'Environment', 'Forgiveness', 'Hardness', 'Home and Lifestyle', 'Hostility', 'Idealism', 'Immune Disturbances', 'Inner Child', 'Irritability', 'Judgment', 'Menopause', 'Mother and Mothering', 'Negativity', 'Perfectionism', 'Prejudice', 'Self-Expression', 'Sensitivity', 'Tolerance']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Black Cohosh',
  'Cimicifuga racemosa',
  'white',
  'Seven Herbs Kit',
  'Courage to confront rather than retreat from abusive or threatening situations',
  'Being caught in relationships or lifestyle which are abusive, addictive, violent; dark, brooding emotions',
  'The Black Cohosh personality has the task of learning to wrestle with shadow parts in the Self and in others. These souls have positive gifts of powerful magnetism and charisma, with especially strong activity in their lower energy centers. Therefore, they naturally attract to themselves many challenging people and situations, which they must learn to confront. They often experience quite tangible feelings of threat or fear, which are well-warranted due to actual circumstances. Their personal life, or the lives of those around them, usually contain themes of violence, abuse, or addiction. Such souls can easily get caught in a vicious cycle of destructive energy. The quality of the inner life is often disturbed, tending toward brooding, vengeful, or even morbid thoughts. These imbalances can be reflected in physical illnesses, especially toxic or congested disturbances in the reproductive organs or general metabolism. Black Cohosh flower essence imparts the ability to confront and actively transform negative, destructive, or threatening circumstances. In this way such souls gain enormous power, and learn to balance and harness their innate strength and physical prowess.',
  ARRAY['Abuse', 'Addiction', 'Catharsis', 'Children', 'Co-Dependence', 'Courage', 'Darkness', 'Death and Dying', 'Destructiveness', 'Fear', 'Feminine Consciousness', 'Gloom', 'Hate', 'Masculine Consciousness', 'Menopause', 'Negativity', 'Paranoia', 'Power', 'Rejection', 'Sexuality', 'Shadow Consciousness', 'Strength']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Black-Eyed Susan',
  'Rudbeckia hirta',
  'yellow/black center',
  'Professional Kit',
  'Awake consciousness capable of acknowledging all aspects of the Self; penetrating insight',
  'Avoidance or repression of traumatic or painful aspects of the personality',
  'Black-Eyed Susan is a powerful catalyst for confronting parts of the personality or traumatic episodes from the past that have been kept locked away in the recesses of the psyche. Often these unclaimed parts of the psyche operate as shadow parts of the personality; for example, a person who was raped or abused may begin to exhibit the same behavior toward others later in life. In other instances this enormous repression does not manifest outwardly, but inwardly, in self-destructive tendencies or as mental or physical illness. In many cases Black-Eyed Susan is indicated for individuals who suffer from emotional amnesia and paralysis, and are totally unaware of the healing issues they must confront. What is needed in these circumstances is an increase of awareness; the ability to shine the light of consciousness into the shadows of the psyche. A great release of energy is felt in the soul once such buried parts of the psyche are consciously encountered and addressed in an appropriate therapeutic environment. Black-Eyed Susan restores great light and conscious awareness, helping the soul to integrate and transform unclaimed parts of the psyche.',
  ARRAY['Abuse', 'Anger', 'Avoidance', 'Awareness', 'Breakthrough', 'Catalyst', 'Catharsis', 'Courage', 'Darkness', 'Death and Dying', 'Denial', 'Dreams and Sleep', 'Eating Disorders', 'Escapism', 'Fear', 'Healing Process', 'Honesty', 'Inner Child', 'Insight', 'Insomnia', 'Lower Self', 'Menopause', 'Mid-Life Crisis', 'Prejudice', 'Repression', 'Resistance', 'Self-Esteem', 'Shadow Consciousness', 'Time Relationship']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Blackberry',
  'Rubus ursinus',
  'white-pink',
  'Professional Kit',
  'Exuberant manifestation in the world; clearly directed forces of will, decisive action',
  'Inability to translate goals and ideals into concrete action or viable activities',
  'The Blackberry remedy helps the person who cannot make a viable connection with the will. The soul has many lofty visions and desires but is unable to translate these into concrete manifestation. Such people are often quite perplexed about the gap between their aims and what they actually accomplish. They give much consideration to their intentions, but lack the ability to organize these thoughts into specific priorities, or to manifest and execute such goals. Such persons often have a great deal of light around the head, which does not radiate and circulate properly throughout the body. The blood is often sluggish, as is the entire lower metabolism. As the light comes more into the limbs, the soul feels greater inner power to take real action in the world and to translate what is spiritual into actual change in the world. Blackberry flower essence bestows this radiant, awakened light to the will-life of the human soul.',
  ARRAY['Action', 'Breakthrough', 'Catalyst', 'Challenge', 'Children', 'Community Life and Group Experience', 'Creativity', 'Decisiveness', 'Desire', 'Energetic Patterns', 'Enthusiasm', 'Escapism', 'Frustration', 'Idealism', 'Immobility', 'Inertia', 'Inspiration', 'Life Direction', 'Manifestation', 'Motivation', 'Power', 'Procrastination', 'Resistance', 'Self-Actualization', 'Sluggishness', 'Thinking', 'Time Relationship', 'Will', 'Work and Career Goals']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Bleeding Heart',
  'Dicentra formosa',
  'pink',
  'Professional Kit',
  'Loving others unconditionally, with an open heart; emotional freedom',
  'Forming relationships based on fear or possessiveness; emotional Go-dependence',
  'Bleeding Heart flower essence is a very powerful heart cleanser and strengthener for those who must learn the deeper spiritual lessons of love and freedom. Those needing this remedy suffer enormous pain and brokenheartedness because their feelings have been poured out so completely into another soul who is no longer present. Perhaps this happens because a loved one has died, or a cherished friend or family member has moved away. Most frequently, such anguish arises in personal relationships which have dissolved, or in relationships that are greatly afflicted. Although love for another may have many genuine aspects, very often the Bleeding Heart type has made the error of living too extensively outside the boundaries of its own Self. This intense desire for connection is often felt by the partner as emotional dependence, causing the partner to feel a need for distance. Such a co-dependent relationship is devoid of real freedom and a balanced exchange of heart energies. The loss and pain which are consequently felt by those in need of Bleeding Heart are therefore necessary experiences, when viewed from a larger perspective. Through Bleeding Heart flower essence, the soul learns to fill itself from within with strong spiritual forces, so that the capacity to love another is based on the ability to honor and nourish the Self.',
  ARRAY['Abandonment', 'Acceptance', 'Adolescence', 'Aging', 'Animals and Animal Care', 'Attachment', 'Brokenheartedness', 'Co-Dependence', 'Compassion', 'Death and Dying', 'Desire', 'Destructiveness', 'Feminine Consciousness', 'Freedom', 'Grief', 'Heart', 'Inner Child', 'Loneliness', 'Love', 'Non-Attachment', 'Personal Relationships', 'Possessiveness', 'Pregnancy', 'Rejection', 'Release', 'Selfishness', 'Time Relationship']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Borage',
  'Borago officinalis',
  'blue',
  'Professional Kit',
  'Ebullient heart forces, buoyant courage and optimism',
  'Heavy-heartedness, lack of confidence in facing difficult circumstances',
  'Borage is an excellent heart remedy, especially for the feeling of heaviness in the heart, and perhaps throughout the body. The "Borago" plant was originally called "Corago," referring to a state of courage associated with it. The word courage implies a soul quality intimately related to the heart (cor is Latin for heart); for it is through this energy center that one''s essence is radiated outward to others. At times when the soul experiences too much grief, sadness, or other adversity, the heart can become contracted and heavy. We call this feeling "discouraged" or "disheartened." The soul needs to learn that it can counterbalance this fettered feeling in the heart by contacting that which is "light," or uplifting. Thus, the soul quality of courage is not so much connected to grit or strength, but to a condition of buoyancy in the soul which helps it to rise above, rather than sink into the weight of discouragement or depression. Borage flower essence helps the heart to experience this ebullience and lightness, filling the sod with fresh forces of optimism and enthusiasm. It is an excellent all-purpose balm and toner in many formulas when the soul needs upliftment and encouragement.',
  ARRAY['Animals and Animal Care', 'Body', 'Brokenheartedness', 'Cheerfulness', 'Courage', 'Death and Dying', 'Depression and Despair', 'Discouragement', 'Faith', 'Grief', 'Healing Process', 'Heart', 'Joy', 'Lightness', 'Manifestation', 'Menopause', 'Mid-Life Crisis', 'Pregnancy', 'Toner']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Buttercup',
  'Ranunculus occidentalis',
  'yellow',
  'Professional Kit',
  'Radiant inner light, unattached to outer recognition or fame',
  'Feelings of low self-worth, inability to acknowledge or experience one''s inner light and uniqueness',
  'In the natural evolution of the soul there are phases of life, if not entire lifetimes, which require that one''s essential light be contained in a quiet, simple way. Although such humble expressions may not appear remarkable by outer standards, they are enormously important times in which the soul gathers inward strength and consolidates its essence. It is important that such souls not judge themselves by conventional standards of achievement and success, becoming afflicted with feelings of self-doubt and diminished self-worth. Rather they need to recognize and honor the inner value and worth of who they truly are. In this way, they are able to shine forth with a radiant inner light that blesses and sanctifies even the most simple tasks and obligations. This remedy is very helpful for children, for those who may be physically handicapped or impaired, and for numerous phases and situations in the life cycle which require inner containment and simplicity. Buttercup flower essence helps the soul to realize and sustain its beautiful inner light, which becomes a source of great healing and peace for all whom it contacts.',
  ARRAY['Acceptance', 'Aging', 'Alienation', 'Appreciation', 'Children', 'Co-Dependence', 'Confidence', 'Creativity', 'Dislike', 'Doubt', 'Envy', 'Failure', 'Feminine Consciousness', 'Home and Lifestyle', 'Inadequacy', 'Inner Child', 'Life Direction', 'Manifestation', 'Menopause', 'Mid-Life Crisis', 'Mother and Mothering', 'Perfectionism', 'Personal Relationships', 'Prejudice', 'Pride', 'Rejection', 'Self-Acceptance', 'Self-Actualization', 'Self-Effacement', 'Self-Esteem', 'Self-Expression', 'Shame', 'Shyness', 'Work and Career Goals']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Calendula',
  'Calendula officinalis',
  'orange',
  'Professional Kit',
  'Healing warmth and receptivity, especially in the use of the spoken word and in dialogue with others',
  'Using cutting or sharp words; argumentative, lack of receptivity in communication with others',
  'The Calendula flower imparts a warm, golden light of healing for those souls who must learn to use "the Word" as a truly creative spiritual force. The Word (or Logos) is the source of all creation, ever renewing itself through the womb of Nature. Thus Calendula is also known as "Mary''s Gold;" for the golden sun-radiance of the Word must be birthed through the receptive feminine matrix. In every human communication there is always this masculine and feminine polarity, of that which is spoken and that which is heard, or received. Calendula flower essence helps those whose innate creative potential to use the spoken word often deteriorates into argument and misunderstanding. It is especially indicated for personal relationship work, and for all healing and teaching work when the art of communication must be intensively developed as a soul force. Calendula gives great forces of warmth and benign compassion to the human soul, especially helping to balance the active and receptive modes of communication.',
  ARRAY['Acceptance', 'Appreciation', 'Awareness', 'Communication', 'Community', 'Impatience', 'Intimacy', 'listening', 'Masculine Consciousness', 'Massage', 'Non-Attachment', 'Life', 'and', 'Group', 'Experience', 'Compassion', 'Conflict', 'Destructiveness', 'Grace', 'Healers', 'Personal Relationships', 'Prejudice', 'Receptivity', 'Self-Expression', 'Sensitivity', 'Sharing', 'Softness', 'Soothing', 'Speaking', 'Tolerance', 'Warmth']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'California Pitcher Plant',
  'Darlingtonia californica',
  'green/purple',
  'Professional Kit',
  'Earthy vitality, especially integration of the more Instinctual and bodily aspects of oneself',
  'Feeling listless, anemic; disassociated from or even fearful of the instinctual aspects of the Self',
  'It is important for the human soul to learn to distinguish, yet not extinguish, its relationship to the animal world. As human beings we have the capacity for self-awareness and self-reflection, but through these very gifts we can also alienate ourselves from what appears to be "lower" or more instinctual. California Pitcher Plant, which is carnivorous (insect eating) and grows in boggy areas, is indicated for people who are unable to integrate their animal-like instinctual desires with their sense of human individuality. This results in a splitting off of their desire-nature, or astrality, from the physical-etheric vehicle. Such a condition can manifest as a weakness in physical vigor and strength, and especially as an inability to digest food (assimilate physical matter). At other times these same, unintegrated astral forces can work too independently through the unconscious as a shadow force, especially distorting or dehumanizing the soul''s experience of sexuality. California Pitcher Plant helps the soul to harness and balance the immense forces of astrality and instinctual desire so that these energies can strengthen physical vitality, and serve human spirituality.',
  ARRAY['Body', 'Desire', 'Eating Disorders', 'Fear', 'Instinctual Self', 'Lower Self', 'Power', 'Sexuality', 'Shadow Consciousness', 'Strength']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'California Poppy',
  'Eschscholzia californica',
  'gold',
  'Professional Kit',
  'Finding spirituality within one''s heart; balancing light and love; developing an inner center of knowing',
  'Seeking outside oneself for false forms of light or higher consciousness, especially through escapism or addiction',
  'The saying "all that glitters is not gold" is an apt one to describe the lesson of the California Poppy. Many times when the soul first opens to an expanded vista of spirituality, it is pulled in the direction of Luciferic light. Such light appears to be beneficial, but it actually stuns and dazes the soul, robbing it of its own inner power. Those who need the California Poppy seek spiritual glamour or enticing psychic experiences outside themselves, rather than engaging in a balanced process of spiritual and moral development. They can be attracted to a vast spectrum of dazzling phenomena, including drug use (especially psychedelic drugs), occult ritual, religious cults, or charismatic teachers. The soul can also be mesmerized by social glamour and fame, and become easily immersed in the life of media stars, and many other fleeting fads or causes. Such souls have the "wide-eyed" expectation that the spiritual gold which they seek can be found somewhere outside themselves. Because they do not strengthen and develop a solid inner life, they are often susceptible to techniques or influences which open the psychic faculties too rapidly, especially before these energies are balanced with the heart and thinking forces. California Poppy stabilizes the golden light of the heart, encouraging more self-responsibility and quiet inner development. In this way the soul finds the true treasure it seeks — the radiant sun force of the awakened human heart.',
  ARRAY['Addiction', 'Adolescence', 'Balance', 'Community Life and Group Experience', 'Denial', 'Desire', 'Escapism', 'Fanaticism', 'Harmony', 'Honesty', 'Materialism and Money', 'Meditation', 'Morality', 'Restlessness', 'Seeking', 'Spiritual Emergency or Opening', 'Time Relationship', 'Wisdom', 'Work and Career Goals']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'California Wild Rose',
  'Rosa californica',
  'pink',
  'Professional Kit',
  'Love for the Earth and for human life, enthusiasm for doing and serving',
  'Apathy or resignation, inability to catalyze will forces through the heart',
  'California Wild Rose is among the most beautiful and fundamental of flower remedies, for it helps the soul to incarnate and really take hold of its responsibilities and tasks on Earth. It is often said that hate is not the opposite of love, only a distortion of it. Rather, it is apathy which is the true polarity of love. The ability to really care and to give oneself to life, to others, and to the Earth characterizes a truly loving soul. Many souls hold back or hesitate, not wanting to experience the pain or challenge of life on Earth. They find it hard to take emotional risks in relationships with others, preferring instead to anesthetize themselves from pain or suffering. Such souls can also suffer from deep-seated social alienation, being unable to rouse the inner fire of the heart toward compassionate caring and activity in the world. California Wild Rose is a very beneficial remedy for all stages of the life biography, and can be particularly helpful for adolescent and young adult life when the soul most especially longs to find its positive ideals, and seeks to serve the world through its life calling or vocation. California Wild Rose stimulates the love forces of the heart, so that the soul finds enthusiasm for earthly life, worldly tasks and human relationships.',
  ARRAY['Adolescence', 'Aging', 'Alienation', 'Aloofness', 'Altruism', 'Ambivalence', 'Apathy', 'Appreciation', 'Body', 'Brokenheartedness', 'Challenge', 'Cheerfulness', 'Children', 'Choice', 'Community Life and Group Experience', 'Cynicism', 'Depression and Despair', 'Dullness', 'Earth Healing and Nature Awareness', 'Eating Disorders', 'Energetic Patterns', 'Enthusiasm', 'Escapism', 'Exhaustion and Fatigue', 'Faith', 'Groundedness', 'Healing Process', 'Heart', 'Idealism', 'Inner Child', 'Involvement', 'Learning Difficulties', 'Life Direction', 'Love', 'Manifestation', 'Mid-Life Crisis', 'Motivation', 'Personal Relationships', 'Pessimism', 'Pregnancy', 'Rejuvenation', 'Resistance', 'Time Relationship', 'Toner', 'Vitality', 'Warmth', 'Will', 'Work and Career Goals']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Calla Lily',
  'Zantedeschia aethiopica',
  'white/yellow',
  'Research Kit',
  'Clarity about sexual identity, sexual self-acceptance; balance of masculine and feminine qualities',
  'Confusion, ambivalence about sexual identity or gender',
  'The beautiful Calla Lily helps those souls who are deeply troubled by their sexual gender. Many times such people have a strong, though usually unconscious, memory of dwelling in the spiritual world where sexual gender is not divided between male and female, but is a perfectly balanced androgynous state. It is therefore very difficult for such indivriduals to feel at home on Earth. In some instances requiring Calla lily, the soul may have favored one gender over the other in a series of lifetimes, which now must be balanced for further evolution. At other times, individuals may have been born into a karmic situation in which the parents strongly preferred a particular gender, or where the person does not fit into social conventions about sexuality. These mixed messages about sexual identity cause great confusion and anguish. Calla Lily helps the soul to bring about its right orientation to sexuality, and at a higher level, to integrate the qualities of male and female in a harmonious expression. Calla Lily teaches that masculine and feminine are soul qualities which can be united within the individual, rather than simply external, physical or biological traits. In this way the personality evolves toward greater balance and hannonious soul expression.',
  ARRAY['Acceptance', 'Adolescence', 'Alienation', 'Ambivalence', 'Balance', 'Children', 'Envy', 'False Persona', 'Feminine Consciousness', 'Inner Child', 'Insecurity', 'Masculine Consciousness', 'Pregnancy', 'Self-Esteem', 'Sexuality', 'Shame']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Canyon Dudleya',
  'Dudleya cymosa',
  'orange',
  'Research Kit',
  'Healthy spiritual opening, balanced psychic and physical energies; grounded presence in everyday life; positive charisma',
  'Distorted psychic experiences; preoccupied with mediumism; overinflated involvement in psychic or charismatic experiences',
  'Although the soul needs to experience emotional depth, it must guard against the temptation to inflate the emotional and psychic life, or to confuse it with true spiritual experience. Canyon Dudleya is indicated for those who need to bring more order, especially in the sense of "ordinariness," to the soul life. These souls have a great wealth of physical and emotional vitality which needs to be properly harnessed and harmonized by the spiritual ego. The temptation of such persons is to evade quiet, sustained development of the spiritual life in favor of intense, overly dramatic psychic-emotional experiences, which appear to be more real or more important than they truly are. Such persons can be easily attracted to mediumism, channeling, occult experimentation, or charismatic experiences which whip up the emotions or psychic fantasies. They are prone to neglect basic responsibilities, or the practical, simple ordering of their daily activities. Canyon Dudleya essence helps such a person to feel the quiet soul nourishment which is gained by appreciating the value of daily life experiences and relationships. Through realizing inner contentment, the soul does not need to stimulate itself excessively with psychic experience. Canyon Dudleya guides the soul towards more balanced spiritual opening and contained emotional presence.',
  ARRAY['Addiction', 'Attachment', 'Avoidance', 'Calm', 'Centeredness', 'Community Life and Group Experience', 'Egotism', 'Emergency', 'Energetic Patterns', 'Escapism', 'False Persona', 'Fanaticism', 'Feminine Consciousness', 'Groundedness', 'Healing Process', 'Home and Lifestyle', 'Honesty', 'Hysteria', 'Inner Child', 'Martyrdom', 'Menopause', 'Moderation', 'Mother and Mothering', 'Nervousness', 'Overwhelm', 'Perspective', 'Prejudice', 'Psychosomatic Illness', 'Relaxation', 'Restlessness', 'Self-Aggrandizement', 'Seriousness', 'Speaking', 'Spiritual Emergency or Opening', 'Work and Career Goals']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Cayenne',
  'Capsicum annuum',
  'white',
  'Professional Kit',
  'Fiery and energetic, inwardly mobile, capable of change and transformation',
  'Stagnation, inability to move forward toward change',
  'Cayenne flower essence provides a catalytic spark to the soul who may be stagnating in its growth cycle. Such individuals become overly phlegmatic and complacent, not really challenging themselves with new experiences or stimulus. At other times, there may be a quality of simply feeling stuck or immobilized, unable to make real progress or change, or being caught in a pattern of procrastination and resistance. Cayenne is an important general remedy for many life circumstances, as well as in many therapeutic processes. It stimulates an energetic response in the body and soul, helping to overcome apparent blocks to progress and transformation. Cayenne ignites and sparks the soul with its fiery essence. The individual becomes more awake, and more capable of initiating and sustaining spiritual and emotional development.',
  ARRAY['Action', 'Breakthrough', 'Catalyst', 'Catharsis', 'Decisiveness', 'Energetic Patterns', 'Enthusiasm', 'Habit Patterns', 'Immobility', 'Inertia', 'Manifestation', 'Motivation', 'Procrastination', 'Resistance', 'Sluggishness', 'Spontaneity', 'Time Relationship', 'Warmth', 'Will', 'Work and Career Goals']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Centaury',
  'Centaurium erythraea or Centaurium umbellatum',
  'pink',
  'English Kit',
  'Serving others from inner strength, with a healthy recognition of one''s own needs; acting from strength of inner purpose, saying "No" when appropriate',
  'Weak-willed, dominated by others, servile, acting to please; difficulty saying "No," neglecting one''s own needs',
  'The healthy soul needs to learn to balance its ego forces between the polarities of servitude and selfishness. Those who require Centaury lack sufficient ego strength, not realizing that the ability to give to and serve others requires a strong and radiant inner sense of Self. Such souls are easily depleted and devitalized; and more importantly, they lack a vibrant individuality which is so necessary for soul evolution. These persons are often under the illusion that they are being loving and helpful, but in reality they are not strong enough in their will forces to say "No," or to resist exploitation by others. Their vulnerability lies in their reliance on pleasing others to receive self-validation. Thus the compulsion to serve others is misplaced, for such a person neglects his or her own needs and cannot perceive the true, objective needs of others. In this way the Centaury type retards not only its own soul growth, but also the progress of those who need to learn from him or her. Centaury gives beneficial strength and integrity to such personalities, helping them to assume greater self-awareness and self-responsibility.',
  ARRAY['Abuse', 'Aging', 'Authority', 'Children', 'Co-Dependence', 'Compassion', 'Desire', 'Dutifulness', 'Freedom', 'Healers', 'Idealism', 'Individuality', 'Influence', 'Inner Child', 'Manifestation', 'Martyrdom', 'Mother and Mothering', 'Perfectionism', 'Power', 'Prejudice', 'Repression', 'Responsibility', 'Self-Actualization', 'Self-Effacement', 'Self-Esteem', 'Service', 'Sharing', 'Strength', 'Surrender', 'True to Self', 'Vulnerability', 'Will', 'Work and Career Goals']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Cerato',
  'Ceratostigma willmottiana',
  'blue',
  'English Kit',
  'Trusting one''s inner knowing, intuition; self-confidence, certainty',
  'Uncertainty or doubt of oneself; invalidating what one knows, over-dependent on advice from others',
  'There are times when the soul feels cut off from its own inner truth and therefore does not develop enough self-reliance. Cerato flower essence helps such persons to translate their already considerable spiritual abilities into active decision-making. This process requires that other spiritual beings have less influence, prompting the soul to develop independent judgment. At first this comes as a shock and such persons do not feel confident enough to make their own decisions, turning instead to others for advice and counsel. While seeking advice can be beneficial in many instances, it is regressive for those who need to develop a stronger sense of their own spirituality and wisdom. Cerato develops the ability to trust one''s inner knowing, facilitating innate spiritual wisdom and strength. In this way, the soul becomes more confident and certain of its true Self.',
  ARRAY['Anxiety', 'Authority', 'Certainty', 'Choice', 'Co-Dependence', 'Confidence', 'Decisiveness', 'Doubt', 'Eating Disorders', 'Healing Process', 'Hesitation', 'Indecision', 'Influence', 'Inner Child', 'Judgment', 'Manifestation', 'Morality', 'Perfectionism', 'Pregnancy', 'Resistance', 'Seeking', 'Self-Esteem', 'Trust', 'Wisdom']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Chamomile',
  'Matricaria chamomilla',
  'white/yellow center',
  'Professional Kit',
  'Serene, sun-like disposition, emotional balance',
  'Easily upset, moody and irritable, inability to release emotional tension',
  'When we say that someone has a sunny disposition, we inherently recognize that such a soul has a harmonious emotional life. Like the sun which shines with constancy for all to see, so the soul must learn to regulate and harmonize its emotional life. Those needing Chamomile flower essence are subject to very changeable moods and ever-fluctuating emotions. Their "inner weather" is stormy and easily "clouded" until they shift their consciousness to remember that the sun is always shining serenely behind all the outer phenomena. People needing Chamomile tend to accumulate psychic tension throughout the day, particularly in the stomach region. They will often have difficulty letting go of their emotional stress at night, and thus suffer from insomnia. This is particularly true of children, whose myriad stomach complaints are often emotionally based. Chamomile helps such souls to release tension from the stomach and solar plexus areas, and to harmonize their inner solar forces for greater emotional peace and stability. It subdues the many small emotions which vex the soul life, helping to consolidate these into a more fundamental soul essence of serenity and equanimity.',
  ARRAY['Addiction', 'Adolescence', 'Anger', 'Animals and Animal Care', 'Anxiety', 'Brokenheartedness', 'Calm', 'Children', 'Depression and Despair', 'Eating Disorders', 'Emergency', 'Harmony', 'Hysteria', 'Insomnia', 'Irritability', 'Learning Difficulties', 'Massage', 'Nervousness', 'Overwhelm', 'Perfectionism', 'Personal Relationships', 'Pregnancy', 'Quiet', 'Relaxation', 'Release', 'Sensitivity', 'Soothing', 'Stress', 'Tension']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Chaparral',
  'Larrea tridentata',
  'yellow',
  'Professional Kit',
  'Balanced psychic awareness, deep penetration and understanding of the transpersonal aspects of oneself',
  'Psychic and physical toxicity, disturbed dreams; chaotic inner life, drug addiction',
  'The psyche is very impressionable and absorbent — it takes in far more than the conscious mind can assimilate. The dream life acts as an important filter for the soul, digesting disturbing or chaotic experiences which may be too powerful to contact consciously. Chaparral is an important psychic and physical cleanser which is indicated when the soul has been overexposed to actual violence or disturbing images in the media. It is also a very beneficial remedy for drug detoxification, including heavy use of medical or psychiatric drugs. Drug use expands the psychic boundaries but diminishes and distorts the awake consciousness. Therefore the individual is plagued with enormous astral-emotional debris which lodges in the subconscious mind, and which must be cleansed for complete recovery. Chaparral is a very beneficial remedy for modern civilization when the soul is subject in so many ways to chaotic, violent and degrading images and experiences. It is broadly applicable, but works especially through the dream life to cleanse the psyche.',
  ARRAY['Addiction', 'Awareness', 'Catharsis', 'City Life', 'Cleansing', 'Dreams and Sleep', 'Insomnia', 'Purification', 'Repression', 'Sensitivity']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Cherry Plum',
  'Prunus cerasifera',
  'white',
  'English Kit',
  'Spiritual surrender and trust, feeling guided and protected by a Higher Power; balance and equanimity despite extreme stress',
  'Fear of losing control, or of mental and emotional breakdown; desperate, destructive impulses',
  'There are times when the soul has difficulty bearing the weight of its incarnation. The circumstances of life oppress and condense the soul, so that it literally feels that it cannot take any more pressure or stress. There is the fear that one will lose control and become erratic, destructive, or even suicidal or insane. The soul tries to protect against this fear of losing control by tightening its grip, which only leads to more pressure and stress. At these extreme times. Cherry Plum is indicated. It helps the individual to re-connect with the Higher Self, to surrender ("Let go and let God"). Once the Self renews its trust in a Higher Power, the mind can then stabilize, and the individual feels the capacity to cope with life''s challenges again. Cherry Plum flower essence brings strength and encouragement, helping the soul to overcome its extreme tension and fear.',
  ARRAY['Animals and Animal Care', 'Destructiveness', 'Eating Disorders', 'Emergency', 'Faith', 'Fear', 'Hysteria', 'Inner Child', 'Mother and Mothering', 'Nervousness', 'Overwhelm', 'Pregnancy', 'Release', 'Stress', 'Surrender', 'Trost']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Chestnut Bud',
  'Aesculus hippocastanum',
  'green buds',
  'English Kit',
  'Learning the lessons of life experience, understanding the laws of karma; wisdom',
  'Poor observation of life, failure to learn from experience; repeating mistakes',
  NULL,
  ARRAY['Addiction', 'Animals and Animal Care', 'Awakeness', 'Awareness', 'Children', 'Denial', 'Eating Disorders', 'Energetic Patterns', 'Escapism', 'Freedom', 'Habit Patterns', 'Healing Process', 'Inertia', 'Insight', 'Learning Difficulties', 'Manifestation', 'Morality', 'Release', 'Resistance', 'Study', 'Synthesis', 'Time Relationship', 'Wisdom', 'Three', 'of', 'the', 'Chestnut', 'remedies', '(Chestnut', 'Bud,', 'Red', 'Chestnut,', 'White', 'Chestnut)', 'address', 'obsessive-compulsive', 'behavior', 'in', 'the', 'personality.', 'Chestnut', 'Bud', 'is', 'used', 'to', 'help', 'break', 'free', 'of', 'overly', 'repetitive', 'and', 'habitual', 'patterns', 'which', 'retard', 'the', 'soul''s', 'full', 'development.', 'It', 'is', 'indicated', 'where', 'there', 'is', 'a', 'constant', 'repetition', 'of', 'life', 'experience', 'without', 'the', 'ability', 'of', 'the', 'soul', 'to', 'glean', 'wisdom', 'and', 'insight.', 'Chestnut', 'Bud', 'particularly', 'stimulates', 'the', 'cognitive', 'capacities', 'so', 'that', 'the', 'individual', 'is', 'able', 'to', 'grasp', 'more', 'completely', 'and', 'more', 'rapidly', 'the', 'essential', 'nature', 'of', 'the', 'experience', 'at', 'hand,', 'and', 'learn', 'the', 'appropriate', 'lessons.', 'In', 'this', 'way,', 'the', 'individual', 'is', 'freed', 'from', 'the', 'compulsive', 'need', 'to', 'repeat', 'mistakes', 'and', 're-create', 'regressive', 'patterns.', 'This', 'remedy', 'is', 'obviously', 'helpful', 'in', 'many', 'learning', 'situations,', 'and', 'is', 'also', 'useful', 'in', 'a', 'broader', 'way', 'when', 'the', 'soul', 'needs', 'to', 'break', 'through', 'deeply', 'resistant', 'karmic', 'patterns.']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Chicory',
  'Cichorium intybus',
  'blue',
  'English Kit',
  'Selfless love given freely, respecting the freedom and individuality of others',
  'Expressing love by being possessive, demanding, and needy; getting attention through negative behavior; self-centeredness',
  'Chicory is a very important remedy for emotional congestion and misdirected love forces. Those in need of this essence must learn to distinguish between personal emotions and desires, and genuine impersonal love and caring for another. Otherwise, the individual becomes selfish rather than selfless, manipulating the emotions of others for his or her own needs and desires. The energy which would ordinarily flow out from one''s heart is thwarted, so that emotions of self-pity, neediness and even martyrdom are experienced. A guise of seemingly loving behavior is very often used as an inappropriate way of soliciting and manipulating the psychic energy and attention of others. Particularly with children, the Chicory pattern manifests as negative attention-getting, fussiness and tantrums which pull on the other members of the family. Chicory flower essence nourishes the inner neediness of such souls and helps to re-balance and re-direct psychic currents of energy, especially as they flow through the heart and solar plexus.',
  ARRAY['Abandonment', 'Aging', 'Altniism', 'Animals and Animal Care', 'Attachment', 'Attention', 'Children', 'Co-Dependence', 'Egotism', 'Inner Child', 'Irritability', 'Love', 'Manifestation', 'Martyrdom', 'Mother and Mothering', 'Personal Relationships', 'Possessiveness', 'Power', 'Rejection', 'Release', 'Responsibility', 'Self-Concern', 'Selfishness', 'Sharing']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Chrysanthemum',
  'Chrysanthemum morifolium',
  'red-brown',
  'Research Kit',
  'Shifting the ego identification from one''s personality to a higher spiritual identity; feeling oneself as transpersonal and transcendent',
  'Fear of aging and mortality, identification with youth and lower personality; mid-life crisis',
  'The soul-spiritual part of ourselves is immortal; it chooses to continuously grow and evolve by incarnating in a particular body and expression of personality. If the soul loses connection with its true immortality, or if it overinflates the importance of a particular life, there will be great fear and avoidance of physical death. Such a soul has a psychological need to firmly establish its personality in the world as a defense against death and mortality. He or she seeks fame and fortune and falls too deeply into the forces of materialism. The spiritual part of the soul is often obliterated or blocked, although it will attempt to make its presence known through a strong awareness crisis (for instance, at mid-life), through a life-threatening illness, or through death itself. The Chrysanthemum flower gives such souls the ability to contact the true spiritual ego, and to contemplate the impermanent nature of earthly affairs in the light of the Higher Self.',
  ARRAY['Acceptance', 'Addiction', 'Aging', 'Alienation', 'Anxiety', 'Attachment', 'Avoidance', 'Courage', 'Death and Dying', 'Denial', 'Depression and Despair', 'Egotism', 'Escapism', 'False Persona', 'Father and Fathering', 'Fear', 'Greed', 'Individuality', 'Life Direction', 'Lower Self', 'Materialism and Money', 'Mid-Life Crisis', 'Non-Attachment', 'Nostalgia', 'Power', 'Release', 'Resistance', 'Self-Actualization', 'Selfishness', 'True to Self']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Clematis',
  'Clematis vitalba',
  'white',
  'English Kit',
  'Awake, focused presence; manifesting inspiration in practical life; embodiment',
  'Avoidance of the present by daydreaming; other-worldly and impractical ideals',
  'The soul in need of Clematis has a strong inner life; the ability to image and dream is particularly well-developed. But these capacities are so strong that they overwhelm and distort the soul''s connection with the body and the concrete physical world. This results in a personality that is overly dreamy, lacking a vibrant emotional and physical presence in the here-and-now. Thus the great talents of the Clematis types are largely untapped, and physical illness easily takes hold of the body because the warm forces of the ego are lacking. In extreme states such souls will be attracted to drugs, particularly psychotropic drugs, in order to continue the soul''s addiction to disincamatcd psychic activity. Clematis helps such persons to realize that the great gifts within them can be constructively channeled into the physical world; in this way the soul forces grow warmer, richer, and more present for others.',
  ARRAY['Addiction', 'Aging', 'Attention', 'Avoidance', 'Awakeness', 'Body', 'Children', 'Concentration and Focus', 'Daydreaming', 'Disorientation', 'Dreams and Sleep', 'Earth Healing and Nature Awareness', 'Escapism', 'Groundedness', 'Idealism', 'Learning Difficulties', 'Manifestation', 'Procrastination', 'Resistance', 'Scatteredness', 'Time Relationship']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Corn',
  'Zea mays',
  'yellow-white',
  'Professional Kit',
  'Alignment with the Earth, especially through the body and feet; grounded presence',
  'Inability to stay centered in the body; disorientation and stress, particularly in urban environments',
  'The Com essence addresses the soul''s need for spaciousness — its desire to live freely within the vast matrix of Nature and Cosmos. It is especially helpful for those ancient souls who find it extremely painful to "contract" into the modern conditions of living. They naturally prefer rural or uncrowded areas where they can feel in harmonious communion with the Earth. But these persons must also grow and evolve, learning how to make the body itself a microcosm of the Earth. The whole body, but especially the hands and feet, must learn to radiate this grounded spirituality. Without this shift in consciousness, the natural healing and teaching capacities which many of these souls harbor within them are never fully realized. Such individuals feel a great deal of pain and discomfort in the congestion and chaos of urban and technological environments or in any restricted living situations; and yet it is often necessary for them to experience just these conditions in order to promote the transition from a macrocosmic to microcosmic soul consciousness. Com helps to balance and guide the soul in expressing its vast spiritual nature through the limitations of the physical world and physical body.',
  ARRAY['Balance', 'Body', 'Centeredness', 'City Life', 'Disorientation', 'Earth Healing and Nature Awareness', 'Environment', 'Feminine Consciousness', 'Groundedness', 'Mother and Mothering', 'Overwhelm', 'Pregnancy', 'Spiritual Emergency or Opening']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Cosmos',
  'Cosmos bipinnatus',
  'red-purple/yellow',
  'Research Kit',
  'Integration of ideas and speech; ability to express thoughts with coherence and clarity',
  'Unfocused, disorganized communication; overexcited speech, overwhelmed by too many ideas',
  'Cosmos helps those souls whose higher mental bodies are not properly integrated with the speaking and thinking functions of the nervous system. Such individuals often feel frustrated and overwhelmed as they attempt to convey the true inspiration of their Higher Self through their thoughts and especially through their speech. These persons can be flooded by too much information, rendering the speech patterns rapid and inarticulate; or the thoughts may be superficially glib but lacking in deeper concepts. In extreme cases the speech may actually become dulled and the soul forces introverted, as the personality no longer makes contact with the higher mental function. Cosmos harmonizes the thinking and speaking patterns with the higher soul functions, so that the true spirit can shine forth from the personality.',
  ARRAY['Animals and Animal Care', 'Awakeness', 'Awareness', 'Calm', 'Communication', 'Concentration and Focus', 'Creativity', 'Disorientation', 'Dullness', 'Hysteria', 'Impatience', 'Inspiration', 'Intellectualism', 'Learning Difficulties', 'Lightness', 'Mental Clarity', 'Nervousness', 'Overwhelm', 'Self-Actualization', 'Self-Esteem', 'Self-Expression', 'Speaking', 'Study', 'Synthesis', 'Thinking', 'True to Self', 'Wisdom']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Crab Apple',
  'Malus sylvestris',
  'white, tinged with pink',
  'English Kit',
  'Cleansing, bringing a sense of inner purity',
  'Feeling unclean and impure, obsessed with imperfection',
  'The apple has strong mythological associations with Paradise, and of being cast out of Paradise. Indeed, the personality needing Crab Apple has difficulty accepting the imperfections of the physical plane. This manifests as rejection or disgust, and at its deepest level, a feeling of shame for the physical body and its imperfections. Such individuals are obsessively preoccupied with impurities, whether real or imagined. These feelings are also projected onto the environment, with an aversion to anything dirty or out of perfect order. It follows that such souls are prone to allergies and many forms of psychosomatic illness, because the body feels overwhelmed by the soul''s impossibly high standards of perfection. While Crab Apple is indicated for those whose concern for cleanliness is inordinate, it can also be used in a general way for any activity of purification, such as fasting. This flower essence instills a balanced relationship of the soul to the body and to life on Earth, helping one to realize that it is only through suffering the pain of imperfection that the soul is afforded the possibility of true evolution, rather than static perfection.',
  ARRAY['Acceptance', 'Adolescence', 'Body', 'Cleansing', 'Criticism', 'Destructiveness', 'Detail', 'Dislike', 'Earth Healing and Nature Awareness', 'Eating Disorders', 'Emergency', 'Environment', 'Hate', 'Healing Process', 'Home and Lifestyle', 'Immune Disturbances', 'Irritability', 'Manifestation', 'Massage', 'Materialism and Money', 'Menopause', 'Morality', 'Obsession', 'Perfectionism', 'Purification', 'Rejection', 'Self-Acceptance', 'Self-Concern', 'Sexuality', 'Shame']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Dandelion',
  'Taraxacum officinale',
  'yellow',
  'Professional Kit',
  'Dynamic, effortless energy; lively activity balanced with inner ease',
  'Overly tense, especially in the musculature of the body, overstriving and hard-driving',
  'The soul needing Dandelion essence feels a natural intensity and love for life. Such individuals are compulsive "doers" who enter with great zeal and zest into many activities. Unfortunately, they can over-plan and over-form their lives beyond the natural capacity of the body to sustain such intensity. Furthermore, such persons may become unable to experience more contained moments of reflective activity. The unexpressed inner life of the soul and the harsh demands on the body collide to create extreme tension, especially in the musculature. The Dandelion flower teaches these individuals how to listen more closely to emotional messages and bodily needs. As tension is released the soul feels more inner ease and balance, allowing spiritual forces to flow through the body in a dynamic, effortless way.',
  ARRAY['Body', 'Grief', 'Hardness', 'Heart', 'Masculine Consciousness', 'Massage', 'Mid-Life Crisis', 'Perfectionism', 'Relaxation', 'Release', 'Repression', 'Resistance', 'Study', 'Tension', 'Time Relationship', 'Work and Career Goals']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Deerbrush',
  'Ceanothus integerrimus',
  'white',
  'Professional Kit',
  'Gentle purity, clarity of purpose; sincerity of motive',
  'Mixed or conflicting motives; subconscious feelings which propel outer actions',
  'It is essential that the soul acquire inner truthfulness, acting with clear intention and nobility of purpose. Deception and illusion are great stumbling blocks along the path of soul initiation. Self-observation demands constant inner scrutiny by the personality, in order to align inner motive with outer deed. As much as we may be wary of others who deceive us, it is far more often that we deceive ourselves by lack of honesty in our relationships with others and in the countless affairs of daily life. Deerbrush helps the soul to attain purity; not the purity which is associated with a set of moral dictates, but consonance of mind and heart with motive and deed. As the soul grows in its ability to realize inner virtue, the outer actions become more resonant with the inner being. Such persons radiate truth and harmony, and heal others by their very presence.',
  ARRAY['Clarity', 'Cleansing', 'Communication', 'Denial', 'Desire', 'Earth Healing and Nature Awareness', 'Escapism', 'Grace', 'Guilt', 'Healers', 'Morality', 'Motivation', 'Prejudice', 'Purification', 'Softness', 'Soulfulness']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Dill',
  'Anethum graveolens',
  'yellow',
  'Professional Kit',
  'Experiencing and absorbing the fullness of life, especially its sensory aspects',
  'Overwhelm due to overstimulation, hypersensitivity to environment or to outer activity, sensory congestion',
  'The cacophony of modern living conditions can stun, and even stifle, the sensory capacities of most persons. With the advent of the technological age, the soul is literally bombarded with countless sense impressions — what one sees, hears, tastes, smells and touches in the course of a day can be quite staggering. Soul hygiene requires that these sensorial impressions be assimilated; otherwise psychic indigestion and nervous overwhelm result. In prior times, those who wished to develop spiritually sought remote environments and ascetic living conditions which diminished sensorial stimulation and freed the soul for higher spiritual work. Dill flower essence helps to harmonize the psychic life within the context of daily work and modern living. Through the Dill flower, the soul learns not only to discriminate and regulate sense experience, but even more importantly to allow the sense life itself to become a vehicle for enlightenment. Rather than being dulled and subdued, the senses can be refined and clarified, becoming ever more luminous and transparent. By consciously encountering sensory experience, a new kind of clairvoyance and clairsentience arises in the modern soul. Dill flower essence assists the soul in transforming sensory overwhelm into an ability to perceive the sense world as a manifestation of spiritual archetypes.',
  ARRAY['Animals and Animal Care', 'Awakeness', 'City Life', 'Clarity', 'Earth Healing and Nature Awareness', 'Eating Disorders', 'Emergency', 'Insomnia', 'Irritability', 'Moderation', 'Overwhelm', 'Relaxation', 'Restlessness', 'Stress']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Dogwood',
  'Cornus nuttallii',
  'yellow/white bracts',
  'Professional Kit',
  'Grace-filled movement, physical and etheric harmony',
  'Awkward and painful awareness of the body; emotional trauma stored deep within the body',
  'When we say that a soul is full of grace, we are referring to a particular fullness and flexibility of the etheric body, the most immediate sheath which surrounds the physical body. If there is repeated violation to the body — either through physical or sexual abuse, or by very harsh physical and materialistic living circumstances — the etheric body shrivels, and consequently the physical body hardens. The soul suffers greatly from an inability to live properly within the physical-etheric body. The emotions can become hardened, and the body is felt as awkward and ungainly. Quite often such a person unconsciously repeats earlier patterns of degradation by choosing abusive relationships or exhibiting self-destructive or accident-prone tendencies. The beautiful Dogwood flower essence helps to expand the etheric body and soften the physical body. The individual is able to feel more gentleness and inner sanctity, as the soul regains its state of grace through harmonious communion with the life or etheric body.',
  ARRAY['Abuse', 'Awkwardness', 'Body', 'Children', 'Communication', 'Creativity', 'Destructiveness', 'Erratic Behavior', 'Flexibility', 'Grace', 'Hardness', 'Inner Child', 'Massage', 'Rejection', 'Release', 'Sexuality', 'Softness']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Easter Lily',
  'Lilium longiflorum',
  'white',
  'Seven Herbs Kit',
  'Inner purity of soul, especially the ability to integrate sexuality and spirituality',
  'Feeling that sexuality is impure, unclean; inner conflicts about sexuality',
  'The white lily has long been a symbol of purity, as well as sexuality and child-bearing. It is extremely challenging for the soul to integrate the sexual life with the spiritual life. For good reason, many spiritual paths require celibacy as a condition of spiritual development. It is possible, however, for modern souls to reconcile these seeming polarities; in fact, new and important soul capacities will emerge as a result. Easter Lily is an important remedy to help those individuals who feel a great inner tension between their sexuality and spirituality. These conflicts can be in either direction — towards promiscuity which degrades and damages the astral body, or towards prudishness which severs the soul from the life forces of the lower body. It is an especially important remedy for women, and can help when there are impurities and disturbances in the sexual and reproductive organs. The most fundamental gift of the Easter Lily is to enable the soul to fully utilize the psychic energy currents which are associated with the sexual and reproductive organs.',
  ARRAY['Ambivalence', 'Cleansing', 'Conflict', 'Desire', 'Feminine Consciousness', 'Instinctual Self', 'Lower Self', 'Menopause', 'Morality', 'Pregnancy', 'Purification', 'Sexuality', 'Shame']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Echinacea',
  'Echinacea purpurea',
  'pink/purple',
  'Research Kit',
  'Core integrity, contacting and maintaining an integrated sense of Self, especially when severely challenged',
  'Feeling shattered by severe trauma or abuse which has destroyed one''s sense of Self; threatened by physical or emotional disintegration',
  'One of the most important initiations in the contemporary life of the soul is that of coming in right relationship to the Self, or spiritual ego. While inflation of the ego can be a formidable problem, there are equally devastating assaults to the positive spiritual identity of the human being. Until recent times, family, community, and Nature have provided the context for a certain kind of self-identity. But the increasing anonymity of modern civilization, along with countless other mechanizing and alienating forces, leaves many souls bereft of earthly or human nourishment. More importantly, acts of crime, violence, and sexual or emotional degradation, often beginning even in early childhood, shatter the dignity of the Self. Many souls live a phantom-like existence, seeming to have a functioning persona when in fact only a meager connection to the true spiritual Self exists. This is one of the underlying reasons, at the level of soul reality, for the vast outbreak of immune-related diseases. Echinacea flower essence stimulates and awakens the true inner Self. This is a fundamental remedy for many soul and physical illnesses, especially when the individual has experienced shattering and destructive forces. Echinacea restores the soul''s true self-identity and essential dignity, in relationship to the Earth and to the human family.',
  ARRAY['Abuse', 'Children', 'Earth Healing and Nature Awareness', 'Emergency', 'Exhaustion and Fatigue', 'Healing Process', 'Immune Disturbances', 'Individuality', 'Inner Child', 'Loneliness', 'Menopause', 'Rejection', 'Self-Acceptance', 'Self-Actualization', 'Self-Esteem', 'Shock', 'Strength', 'Transcendence', 'True to Self']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Elm',
  'Ulmus procera',
  'reddish brown',
  'English Kit',
  'Joyous service, faith and confidence to complete one''s task',
  'Overwhelmed by duties and responsibilities, feeling unequal to the task required',
  'The healthy soul expresses itself by wanting to care for and serve others, but at times this positive altruistic impulse can be stymied. Becoming responsible requires that one rightly assesses one''s "ability to respond." Over-perfectionist or unrealistic goals can result in fatigue and overwhelm at a later point when the individual is simply unable to measure up to the tasks assumed. Feelings of self-doubt, despondency, and deep feelings of loneliness can set in when the soul feels it must face an overwhelming task relying solely on its own ego forces. It is necessary at these times to shift the identity from that of hero or rescuer to an alignment with the true energy and inspiration of the Higher Self. In this way the individual is able to receive help from others and from the spiritual world. Elm balances the natural leadership capacities within the soul, especially by integrating these with the true directives of the Higher Self.',
  ARRAY['Altruism', 'Ambition', 'Anxiety', 'Challenge', 'Children', 'Co-Dependence', 'Community Life and Group Experience', 'Confidence', 'Depression and Despair', 'Dutifulness', 'Exhaustion and Fatigue', 'Failure', 'Father and Fathering', 'Guilt', 'Inadequacy', 'Inner Child', 'Leadership', 'Loneliness', 'Martyrdom', 'Masculine Consciousness', 'Mid-Life Crisis', 'Mother and Mothering', 'Overwhelm', 'Perfectionism', 'Relaxation', 'Responsibility', 'Stress', 'Time Relationship', 'Work and Career Goals']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Evening Primrose',
  'Oenothera hookeri',
  'yellow',
  'Research Kit',
  'Awareness and healing of painful early emotions absorbed from the mother; ability to open emotionally and form deep, committed relationships',
  'Feeling rejected, unwanted; avoidance of commitment in relationships, fear of parenthood; sexual and emotional repression',
  'The soul is most open, and receives its first impressions of life on Earth, while in utero or in very early infancy. At this time it is more of a moon-like being than a sun-being, receiving and reflecting the soul light of the parents, especially the mother. These early experiences of light and love are as formative for emotional development as proper nutrition is for the physical fetus. If the soul is neglected or abused while in utero or in very early infancy, a profound and deeply unconscious feeling of pain and rejection resides in the individual. Such persons feel unwanted and often cope by avoiding deep emotional contact or bonding; they retain a moon-like coldness in their souls and are unable to radiate warmth and love from their own center. There can also be a deeply repressed aversion to sexuality, particularly if the reproductive act which brought in the incarnating child was filled with turmoil, violence, or debased lust. Evening Primrose helps to catalyze the emotional awareness of such souls, especially regarding the original, core incarnation experiences which were so devastating. Evening Primrose literally rebirths the soul, providing a matrix of emotional nutrients that were lacking in the soul''s earliest feelings about incarnation.',
  ARRAY['Abandonment', 'Abuse', 'Alienation', 'Ambivalence', 'Avoidance', 'Barriers', 'Catharsis', 'Children', 'Cleansing', 'Courage', 'Dreams and Sleep', 'Eating Disorders', 'Escapism', 'Feminine Consciousness', 'Grief', 'Inadequacy', 'Inner Child', 'Insecurity', 'Intimacy', 'Involvement', 'Loneliness', 'Mother and Mothering', 'Personal Relationships', 'Pregnancy', 'Purification', 'Rejection', 'Release', 'Repression', 'Self-Esteem', 'Sexuality']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Fairy Lantern',
  'Calochortus albus',
  'white',
  'Research Kit',
  'Healthy maturation; acceptance of adult responsibilities',
  'Immaturity, helplessness, neediness, childish dependency; unable to take responsibility',
  'The early developmental process of childhood is critical for the human soul. When this is disturbed, many problems will manifest which inhibit full adult maturation. The soul who needs Fairy Lantern still clings to a childlike personality. In some instances, the true identity of the child was suppressed during its development and not allowed its rightful expression. More frequently, the parents or other family members excessively reinforce or restrict the personality in its identity as an immature child. Such a person learns that she or he will receive love only by remaining in an arrested, over-dependent childlike state. These souls become delicate and needy, lacking in inner strength to face the world or shoulder responsibility. They play the role of the puer eterna (eternal child) who needs to unconsciously repeat childhood throughout adult life, hoping to somehow transform this arrested stage of development. Fairy Lantern can also be used during childhood and adolescence for retarded phases of physical or emotional development. Fairy Lantern helps souls to move through these emotional blocks in the maturation process by maintaining a healthy relationship to the inner child, but as a fully functioning, mature adult.',
  ARRAY['Acceptance', 'Addiction', 'Adolescence', 'Alienation', 'Ambivalence', 'Authority', 'Avoidance', 'Body', 'Children', 'Co-Dependence', 'Confidence', 'Eating Disorders', 'Escapism', 'False Persona', 'Father and Fathering', 'Fear', 'Feminine Consciousness', 'Freedom', 'Healing Process', 'Hesitation', 'Home and Lifestyle', 'Inadequacy', 'Individuality', 'Inner Child', 'Insecurity', 'Life Direction', 'Masculine Consciousness', 'Menopause', 'Mid-Life Crisis', 'Mother and Mothering', 'Nostalgia', 'Personal Relationships', 'Power', 'Resistance', 'Responsibility', 'Self-Effacement', 'Self-Esteem', 'Seriousness', 'Sexuality', 'Strength', 'True to Self', 'Work and Career Goals']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Fawn Lily',
  'Erythronium purpurascens',
  'yellow with purple',
  'Research Kit',
  'Accepting and becoming involved with the world; sharing one''s spiritual gifts with others',
  'Withdrawal, isolation, self-protection; overly delicate, lacking the inner strength to face the world',
  'Souls in need of Fawn Lily have very highly developed forces of spirituality, so much so that it is difficult for them to cope with the stresses and strains of modern society. Such persons are naturally inclined to states of contemplation, meditation, and prayer. It is easier for them to stay in these modes of spirituality, rather than to be involved with the world. However, the soul can become overripe and overdeveloped in its spirituality. Such persons need to disseminate the great gifts which have accumulated in their beings in order to evolve and progress; otherwise they become too introverted and spiritually cold, lacking the ability to draw strength and vitality from the physical world. Fawn Lily stimulates the natural healing and teaching capacities of such individuals, so that the soul evolves from its archetype of cosmic virgin to world mother, or world-server.',
  ARRAY['Acceptance', 'Alienation', 'Aloofness', 'Ambivalence', 'Avoidance', 'Balance', 'Barriers', 'Body', 'Children', 'City Life', 'Community Life and Group Experience', 'Compassion', 'Conflict', 'Courage', 'Daydreaming', 'Devitalization', 'Eating Disorders', 'Escapism', 'Father and Fathering', 'Fear', 'Feminine Consciousness', 'Groundedness', 'Heart', 'Home', 'and', 'lifestyle', 'Idealism', 'Intimacy', 'Involvement', 'Love', 'Meditation', 'Mother and Mothering', 'Perfectionism', 'Psychosomatic Illness', 'Self-Concern', 'Selfishness', 'Service', 'Sharing', 'Spiritual Emergency or Opening', 'Vitality', 'Warmth', 'Work and Career Goals']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Filaree',
  'Erodium cicutarium',
  'violet',
  'Professional Kit',
  'Star-like vision, a cosmic overview which holds the events of ordinary life in perspective',
  'Disproportionate and obsessive worry; unable to gain a wider perspective on daily events',
  'There are times when the soul loses its proper perspective, becoming entirely too enmeshed and overly concerned with the mundane affairs of daily life. Such persons spend a great deal of time and psychic energy absorbed in small problems and compulsive concerns. It is essential for the soul''s development that these "energy leaks" be recognized. Such persons must marshal their psychic and physical energy for truly productive tasks; otherwise, the larger destiny goes unfulfilled or only partially addressed. They have tremendous inner strength and reserve, which can be of great value when it is properly channeled. Filaree helps such individuals to make a fundamental shift in their perspective by instilling a more cosmic overview, thus helping to put the affairs of the daily world in proper perspective. Filaree especially liberates overly suppressed psychic energy, allowing greater receptivity to spiritual inspiration and vision.',
  ARRAY['Anxiety', 'Calm', 'Community Life and Group Experience', 'Concentration and Focus', 'Criticism', 'Detail', 'Escapism', 'Fear', 'Home and Lifestyle', 'Manifestation', 'Materialism and Money', 'Non-Attachment', 'Obsession', 'Overview', 'Perfectionism', 'Perspective', 'Release', 'Self-Concern']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Five-Flower Formula',
  'A combination of Cherry Plum, Clematis, Impatiens, Rock Rose, and Star of Bethlehem',
  'multiple colors',
  'English Kit',
  'Calmness and stability in any emergency or time of high stress',
  'Panic, disorientation, loss of consciousness',
  'The Five-Flower Formula can be regarded as a single composite remedy for formulas, or used alone. It is most effective during any profound trauma or emergency, helping the person to cope with extreme pain and shock. This formula literally helps the soul-spiritual part of the Self to stay incarnated or connected with the physical body, even under extreme stress. It brings immediate balance and harmony in acute situations. It is less often indicated in the long-term therapeutic work of soul development; however, it can be employed in early stages when it seems difficult to make contact with the Higher Self, or when the Self needs to be stabilized before inner work can begin.',
  ARRAY['Addiction', 'Animals and Animal Care', 'Body', 'Breakthrough', 'Calm', 'Centeredness', 'Challenge', 'Children', 'Death and Dying', 'Disorientation', 'Emergency', 'Energetic Patterns', 'Fear', 'Hysteria', 'Pregnancy', 'Relaxation', 'Scatteredness', 'Shock', 'Stress']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Forget-Me-Not',
  'Myosotis sylvatica',
  'blue',
  'Research Kit',
  'Awareness of karmic connections in one''s personal relationships and with those in the spiritual world; deep mindfulness of subtle realms; soul-based relationships',
  'Loneliness, isolation; lack of awareness of spiritual connection with others',
  'If we are to heal the wounds imposed on human culture by its overly materialistic viewpoint, it is necessary to lift our consciousness of the human family to include those souls who live outside the earthly dimension. Our hearts can naturally feel grief and concern for a living child who is abandoned and lacks the loving care and attention of a family; however, our materialistic bias makes us totally oblivious to the needs of souls who have departed from the physical realm. This blindness prevents us from providing sustenance and support to such souls, and also from receiving guidance and counsel from them for our earthly affairs. Yet establishing healthy contact with souls beyond the physical dimension is not easy. Many attempt unlawful contact through lower astral currents using drugs, sexuality, mediumism, or dangerous occult techniques. Rather than using these methods, we must be able to make contact with such souls in a heartfelt, conscious manner. The path of soul communion beyond the earthly threshold is a path of love — it depends on our ability to believe in the continued existence of the soul who has departed from physical form; remaining faithful to, and continuing to nurture the bonds of love which began on Earth. Forget-Me-Not helps awaken the soul to this higher level of heart exchange. It is an important essence to consider following the initial stage of grief after the death of a loved one, and can be very helpful for those who have never fully resolved their feelings of isolation and abandonment following the loss of an important family member or friend during childhood. Forget-Me-Not can also be used by expectant parents who wish to establish a conscious link with the soul seeking to be incarnated through them, or it can be beneficial when one wishes to understand the deeper, karmic soul connection which inspires or challenges any current relationship. In all these instances, Forget-Me-Not guides us toward greater love for the human family, and greater awareness of the incredible depth, beauty, and possibility of soul-based relationships.',
  ARRAY['Acceptance', 'Awareness', 'Brokenheartedness', 'Certainty', 'Clarity', 'Communication', 'Death and Dying', 'Denial', 'Dreams and Sleep', 'Dullness', 'Escapism', 'Faith', 'Listening', 'Loneliness', 'Love', 'Meditation', 'Mother and Mothering', 'Nostalgia', 'Personal Relationships', 'Perspective', 'Pregnancy', 'Receptivity', 'Soulfulness', 'Spiritual Emergency or Opening', 'Transition', 'Trust']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Fuchsia',
  'Fuchsia hybrida',
  'red/purple',
  'Professional Kit',
  'Genuine emotional vitality, ability to express deep feelings',
  'False states of emotionality which cover more deeply-seated pain and trauma; psychosomatic symptoms',
  'The soul can be trapped and hindered in its progress through suppression and denial of core emotions. The individual needing Fuchsia tends to mask true feelings with various states of hyper-emotionality or psychosomatic symptoms. Such persons may cry easily or have myriad physical complaints such as headaches or stomachaches. This false emotionality or suffering acts as a foil or cover for the deeper emotions which appear too powerful and overwhelming for the psyche to integrate. The soul longs to express feelings, but hopes it can do so without taking the "plunge" into more awesome and painful emotions. Fuchsia helps such an individual towards emotional catharsis, so that the feeling life becomes more genuine, and conveys greater depth and presence. Emotions such as grief, deep-seated anger, or rejection can be encountered and effectively transformed through Fuchsia. The individual learns how to recognize pain and other strong feelings more immediately, thus freeing the soul life to become emotionally authentic and vital.',
  ARRAY['Acceptance', 'Anger', 'Avoidance', 'Awareness', 'Body', 'Breakthrough', 'Catharsis', 'Energetic Patterns', 'Escapism', 'Grief', 'Harmony', 'Healing Process', 'Honesty', 'Hysteria', 'Inner Child', 'Insight', 'Lower Self', 'Menopause', 'Psychosomatic Illness', 'Release', 'Repression', 'Resistance', 'Sexuality']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Garlic',
  'Allium sativum',
  'violet',
  'Professional Kit',
  'Unitive consciousness, sense of wholeness which imparts strength and active resistance',
  'Fearful, weak or easily influenced, prone to low vitality',
  'Garlic flower essence is a very important healing agent for those souls who become too diffuse in their astrality, and therefore subject to entities of many kinds. These souls have enormous psychic forces which are scattered or splintered, leaving them host to many other entities who prey off their life forces and gain unlawful entry into the auric field. A wide spectrum of disturbances can be treated by Garlic essence, from poor immune response with a tendency to parasitic or viral infection, to low-grade psychism, mediumism, or possession. Garlic addresses many forms of nervous fear which arise from the overly intense activity of various elemental beings in the astral body. In all of these cases there is a characteristic vacancy in the eyes and paleness of features, with the impression that soul-color and vitality is being drained or siphoned from the individuality. Garlic flower restores wholeness for such souls, helping them to consolidate and unify the astral body, and to bring it into greater harmony with the physical and etheric bodies and the spiritual ego.',
  ARRAY['Anxiety', 'Body', 'Calm', 'Confidence', 'Courage', 'Devitalization', 'Fear', 'Immune Disturbances', 'Influence', 'Insecurity', 'Nervousness', 'Protection', 'Speaking', 'Spiritual Emergency or Opening', 'Tension']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Gentian',
  'Gentiana amarella',
  'purple',
  'English Kit',
  'Perseverance, confidence; faith to continue despite apparent setbacks',
  'Discouragement after a setback; doubt',
  'The soul can become strong and vibrant only by becoming resilient. Obstacles and problems test the soul''s ability to respond, and to trust in the unfoldment of life. Those in need of Gentian become too easily discouraged and disheartened when problems and setbacks occur. Such souls view impediments as insurmountable problems, and are unable to discover solutions. The individual needs to learn that such vexing situations occur because they are exactly those lessons which are needed for growth and strength. Gentian gives encouragement, especially helping the soul to shift its mental perspective and see the long view. The doubting and skeptical qualities which the soul harbors are gradually transformed into deeper faith. Gentian flower essence helps the soul to acquire great inner fortitude and unwavering trust in the outcome of life events.',
  ARRAY['Adolescence', 'Aging', 'Challenge', 'Depression and Despair', 'Discouragement', 'Escapism', 'Failure', 'Frustration', 'Healing Process', 'Learning Difficulties', 'Life Direction', 'Manifestation', 'Perfectionism', 'Perseverance', 'Pessimism', 'Rejection']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Golden Ear Drops',
  'Dicentra chrysantha',
  'yellow',
  'Professional Kit',
  'Contacting one''s childhood experience as a source of emotional well-being; releasing painful memories from the past',
  'Suppressed toxic memories of childhood; feelings of pain and trauma about past events which affect present emotional balance',
  'Emotional amnesia is a survival mechanism for the soul, especially during childhood, or any period of life when the individual is vulnerable to exploitation or abuse. This unconscious residue of traumatic memories must eventually be encountered with more awareness, or else it works like a toxic poison which corrodes the present emotional life. Golden Ear Drops helps the soul to remember and feel unpleasant or painful episodes. This essence is an especially powerful cleanser of the heart, and may stimulate tears as a form of emotional discharge. Once the individual experiences this cleansing process, there is also the ability to contact the positive aspects of the past. This is especially true regarding the events of one''s childhood — when the personality suppresses painful aspects of the childhood experience, connection with the archetypal child as a source of positive spirituality is also severed. Golden Ear Drops helps the soul to remember and reclaim this past, so that it becomes a source of strength, wisdom, and insight.',
  ARRAY['Abuse', 'Alienation', 'Awareness', 'Catharsis', 'Cleansing', 'Dryness', 'Forgiveness', 'Grief', 'Guilt', 'Healing Process', 'Inner Child', 'Masculine Consciousness', 'Purification', 'Release', 'Repression', 'Resistance', 'Shame']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Golden Yarrow',
  'Achillea filipendulina',
  'yellow',
  'Research Kit',
  'Remaining open to others while still feeling inner protection; active social involvement which preserves the integrity of the Self',
  'For outgoing people who are overly influenced by their environment and by other people; protecting oneself from vulnerability to others by withdrawal and social isolation',
  'One of the greatest challenges in the life of the soul is that of learning to stay open and balanced, without compromising one''s basic integrity and health. Golden Yarrow assists with this balance, and is indicated for those whose natural inclination is to avoid public limelight or performance because of acute sensitivity. In such situations the soul becomes imprisoned in its introversion, unable to learn how to open itself within proper limits. This situation is especially pronounced for artists whose very involvement in the arts requires profound soul refinement. Such persons often find it difficult to cope with their sensitivity, and can turn to drugs or other activities which blunt and harden the soul. Unfortunately, this choice is self-defeating, for it also severs the individual from true artistic capacity and sensitivity. Golden Yarrow helps such a person to build a sheath which shields and protects, while still providing access to its innate sensitivity. In this way the soul comes to anchor inviolable light and strength within itself, which protects and encourages the delicate and gentle expression of the Self.',
  ARRAY['Action', 'Addiction', 'Adolescence', 'Ambivalence', 'Anxiety', 'Body', 'Centeredness', 'Children', 'City Life', 'Community Life and Group Experience', 'Competitiveness', 'Confidence', 'Courage', 'Creativity', 'Eating Disorders', 'Emergency', 'Fear', 'Groundedness', 'Healers', 'Immobility', 'Inadequacy', 'Insecurity', 'Intimacy', 'Involvement', 'Manifestation', 'Nervousness', 'Protection', 'Self-Actualization', 'Sensitivity', 'Softness', 'Speaking', 'Strength', 'Tension', 'True to Self', 'Vulnerability']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Goldenrod',
  'Solidago californica',
  'yellow',
  'Professional Kit',
  'Well-developed individuality, inner sense of Self balanced with group or social consciousness',
  'Easily influenced by group or family ties; inability to be true to oneself, subject to peer pressure or social expectations',
  'Our earliest sense of Self unfolds within the context of others — parents, extended family, and community. Gradually, through a healthy maturation process, the soul acquires a clear sense of its individuality. Some souls do not successfully complete this individuation process, remaining too subject to group mores and family ties. These souls need to establish their own inner values and beliefs, otherwise their inherent weakness is easily exploited. They tend to be adversely influenced by social pressures and conventions, conforming their behavior to social norms in order to win approval and acceptance. In some situations such souls will also display antisocial or obnoxious behavior as an extreme measure to acquire a self-image — this is especially true during adolescence. Goldenrod essence helps such persons to find a true relationship to the Higher Self. It encourages a vertical or individuated axis to counterbalance the overly broad, horizontal social axis, which influences the personality too strongly. In this way the soul acquires greater strength and inner conviction, learning to successfully balance the polarities of Self and Other.',
  ARRAY['Adolescence', 'Anxiety', 'Balance', 'Barriers', 'Centeredness', 'Certainty', 'Co-Dependence', 'Community Life and Group Experience', 'Eating Disorders', 'Egotism', 'Envy', 'False Persona', 'Greed', 'Honesty', 'Inadequacy', 'Individuality', 'Inner Child', 'Insecurity', 'Non-Attachment', 'Personal Relationships', 'Prejudice', 'Rejection', 'Seeking', 'Self-Esteem', 'True to Self']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Gorse',
  'Ulex europaeus',
  'golden yellow',
  'English Kit',
  'Deep and abiding faith and hope; equanimity and light-filled optimism',
  'Discouragement, darkness, hopelessness, resignation',
  'The soul must learn to live in equilibrium between the polarities of light and dark. Those needing Gorse have internalized darkness or pessimism in their outlook on life. This pessimism gives too much weight and depression to the soul, and erodes the soul''s natural buoyancy. Gorse restores hope to such souls, so that they are able to look with a brighter, more expectant, and joyful outlook on life situations. This quality of hope deeply affects physical as well as emotional healing, because the life force is nourished by light. Such persons need to counter the darkness they feel within themselves with strong forces of inner light and luminous insight. Through Gorse, the soul learns to use light as an alchemical agent for change and healing, directing a powerful, illuminating beacon even in the most trying moments and bleakest situations.',
  ARRAY['Apathy', 'Darkness', 'Depression and Despair', 'Gloom', 'Healing Process', 'Manifestation', 'Motivation', 'Pessimism', 'Time Relationship', 'Discouragement', 'Doubt', 'Pregnancy']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Heather',
  'Calluna vulgaris',
  'pink, purple',
  'English Kit',
  'Inner tranquillity; emotional self-sufficiency',
  'Over-talkative, self-absorbed; over-concerned with one''s own problems',
  'Heather flower essence helps those who become too absorbed in their own problems and worries. Such persons are deeply lonely and in great pain, but they seek contact with others in a dysfunctional manner. Feeling empty inside, the Heather type hopes to assuage its hunger by "feeding" off the psychic attention and sympathy of others. In most cases this excessive self-concern repels others from forming a truly empathetic bond. Thus the Heather type becomes increasingly lonely and dysfunctional. In extreme states, such a person may learn to manipulate psychic energy so that others are compelled to listen to and attend to their problems. Heather nourishes the soul''s feeling of profound emptiness so that it can become stronger within itself, and realize compassion. This is the key to experiencing love, for one is healed from one''s own suffering by learning to care for and perceive the suffering of others. Heather heals the soul by reversing psychic currents of energy which are directed too strongly toward the Self. By learning to find itself in caring for others, the Heather soul becomes self-fulfilled rather than self-absorbed.',
  ARRAY['Adolescence', 'Aging', 'Attention', 'Community Life and Group Experience', 'Compassion', 'Healing Process', 'Listening', 'Loneliness', 'Martyrdom', 'Obsession', 'Personal Relationships', 'Self-Concern', 'Self-Esteem', 'Self-Expression', 'Selfishness', 'Speaking']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Hibiscus',
  'Hibiscus rosa-sinensis',
  'red',
  'Research Kit',
  'Warmth and responsiveness in female sexuality; integration of soul warmth and bodily passion',
  'Inability to connect with one''s female sexuality; lack of warmth and vitality, often due to prior exploitation or abuse',
  'One of the most tragic assaults to the soul dignity of women is the exploitation and commercialization of female sexuality. This deeply wounds the souls of many women so that they no longer feel a warm connection to their sexuality. Often the sexuality is divorced from deeper feelings of love and warmth which come from the heart. In many cases sexual expression becomes cold and unresponsive, because the Soul can no longer contact this part of the Self and infuse it with love and caring. Hibiscus essence helps women to reclaim their sexuality, and to restore these soul forces with vitality and authenticity. It can aid many women who have been sexually traumatized, and is also generally beneficial for all modern women who have unconsciously absorbed media images and other stereotypes of dehumanized sexuality. This remedy is sometimes also indicated for men who need to develop a stronger relationship to feminine warmth and positive sexuality. Hibiscus creates flowing warmth throughout the body and soul, especially healing the sexuality.',
  ARRAY['Abuse', 'Aging', 'Body', 'Desire', 'Devitalization', 'Dryness', 'Feminine Consciousness', 'Groundedness', 'Instinctual Self', 'Intimacy', 'Lower Self', 'Menopause', 'Rejuvenation', 'Repression', 'Sexuality', 'Vitality', 'Warmth']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Holly',
  'Ilex aquifolium',
  'white, tinged with pink',
  'English Kit',
  'Feeling love and extending love to others; universal compassion, open heart',
  'Feeling cut off from love; jealousy, envy, suspicion, anger',
  'Above all else, the soul seeks in its evolution to experience real love. This is the most fundamental lesson for the soul, and at the same time the most challenging. Holly is therefore a foundational remedy with many broad-based applications, for it restores the soul''s ability to feel unity and wholeness. When we feel separate from others we can take no joy or compassionate interest in their affairs; instead our isolation is compounded into negative states of jealousy, envy, suspicion or anger. The soul grasps for its share of love as though it were a limited commodity, rather than realizing that love is an infinite resource which is divinely available to all. Holly essence nourishes the heart, helping the individual to make and sustain the shift from a limited and narrow conception of the Self, to one which is expansive and inclusive of others. In this way, the soul experiences wholeness or "holiness," for it feels permeated with divine love. This sense of sacred unity is the very special gift and teaching of Holly flower essence.',
  ARRAY['Abandonment', 'Acceptance', 'Adolescence', 'Aging', 'Anger', 'Animals and Animal Care', 'Appreciation', 'Brokenheartedness', 'Catharsis', 'Children', 'Cleansing', 'Community Life and Group Experience', 'Compassion', 'Competitiveness', 'Conflict', 'Cooperation', 'Cynicism', 'Death and Dying', 'Destructiveness', 'Dislike', 'Egotism', 'Envy', 'Fear', 'Forgiveness', 'Grace', 'Hate', 'Heart', 'Hostility', 'Inner Child', 'Joy', 'Love', 'Morality', 'Negativity', 'Paranoia', 'Personal Relationships', 'Prejudice', 'Rejection', 'Resentment', 'Selfishness', 'Sharing', 'Soulfulness']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Honeysuckle',
  'Lonicera caprifolium',
  'red/white',
  'English Kit',
  'Being fully in the present; learning from the past while releasing it',
  'Nostalgia; emotional attachment to the past, longing for what was',
  'Time is the life current of the incarnated soul. If it does not navigate the stream of time, it drowns in the past or parches its future possibilities. The soul needing Honeysuckle stifles life force and denies its true evolution by living too much in past events, places and relationships. Such a soul needs more inner flexibility and adaptability. Rather than face the challenge of change, it clings emotionally to a past which seems to have been more appealing. This perception is usually an illusion; for example, a past relationship or an earlier phase of one''s life can be glossed over with dreamy reverie, ignoring the actual pain and trauma that was part of the experience. The essential lesson of Honeysuckle has to do with the soul''s perceptive faculties; being able to learn from previous life experiences by seeing clearly their meaning and message. When this occurs it frees the soul to grow and change, to experience life with intention and purpose, as an ever-unfolding present and over-possible future.',
  ARRAY['Aging', 'Avoidance', 'Brokenheartedness', 'Concentration and Focus', 'Daydreaming', 'Envy', 'Escapism', 'Grief', 'Home', 'and', 'lifestyle', 'Loneliness', 'Mid-Life Crisis', 'Nostalgia', 'Prejudice', 'Rejection', 'Release', 'Resistance', 'Time Relationship']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Hornbeam',
  'Carpinus betulus',
  'yellow/green',
  'English Kit',
  'Energy, enthusiasm, involvement in life''s tasks',
  'Fatigue, weariness; daily tasks seen as an overwhelming burden',
  'The soul makes unlimited reserves of energy available to the body; unfortunately, these are seldom tapped to their full potential. At the soul level, energy is produced not by calories or fuel, but by full attention and positive connection to one''s work or life tasks. Those individuals who experience monotonous routine, or lack genuine interest or involvement in their work, can feel extreme tiredness and exhaustion completely out of proportion to the real capacity of the physical body. The Hornbeam essence re-orients the soul so that it can freshly perceive work or habits which may have become overly dull or routine. Hornbeam sometimes brings an inner realization that a new approach or new lifestyle is necessary to completely recapture one''s full energy. Above all, Hornbeam nourishes the sod with renewed strength and vitality so that it may live more effectively and more joyfully in the world.',
  ARRAY['Action', 'Challenge', 'Cheerfulness', 'Depression and Despair', 'Devitalization', 'Dreams and Sleep', 'Dullness', 'Dutifulness', 'Energetic Patterns', 'Exhaustion and Fatigue', 'Involvement', 'Joy', 'Manifestation', 'Overwhelm', 'Procrastination', 'Resistance', 'Seriousness', 'Sluggishness', 'Time Relationship', 'Work and Career Goals']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Hound''s Tongue',
  'Cynoglossum grande',
  'blue/white',
  'Professional Kit',
  'Holistic thinking; perceiving the physical world and physical life with spiritually clear thoughts',
  'Seeing the world in materialistic terms, weighed down or dulled by a mundane or overly scientific viewpoint',
  'The modern soul is evolving in its ability to think; this is a true spiritual gift which carries enormous creative potential. However, this thinking force is threatened in its development by overly intellectual and materialistic attitudes. For example, we may exactly analyze a tree for its fuel or timber capacity without ever seeing its spiritual identity. We may think of the sun as simply an explosion of hydrogen atoms, or the stars as a result of the "big bang," without realizing that real spiritual forces and beings live and breathe in the movements of the sun and stars. This is tantamount to seeing the human being as only a physical body composed of highly defined parts like bones, cartilage, cellular tissue, and DNA, without ever apprehending the wholeness and spiritual complexity of the being which stands before us. Sensitive persons rebel against this materialistic consciousness, but often do so in a way that denies the real thinking capacities. Hound''s Tongue stimulates and enlivens the thinking activity. It restores a sense of wonder and reverence for life, while also helping the soul to think in clear and specific ways about the spiritual dimensions of the physical world.',
  ARRAY['Creativity', 'Denial', 'Earth Healing and Nature Awareness', 'Body', 'Cynicism', 'Dullness', 'Eating Disorders', 'Insight', 'Inspiration', 'Intellectualism', 'Lightness', 'Masculine Consciousness', 'Materialism and Money', 'Meditation', 'Mental Clarity', 'Perspective', 'Study', 'Thinking', 'Transcendence', 'Wisdom']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Impatiens',
  'Impatiens glandulifera',
  'pink/mauve',
  'English Kit',
  'Patience, acceptance; flowing with the pace of life and others',
  'Impatience, irritation, tension, intolerance',
  'The souls who need Impatiens find it difficult to be within the flow of time; their tendency is to rush ahead of experience. In doing so, they deny themselves full immersion in life, even though they may appear very busy and engaged. In particular, these individuals miss the more gentle and subtle exchanges which can occur with others, or with the world around them. Their overabundance of fiery force flares up easily into irritation, impatience, intolerance, and anger. Although quite mentally agile and extremely capable, the great inner tension and excitability of such souls leads to various physical disease states or premature aging due to "burnout." The Impatiens type needs to experience not only the powerful flaming of life, but also its gentle flowering. Through the Impatiens essence, the soul learns to still the attention and deepen the breathing so that the inner Self becomes more receptive to the unfolding moment. The precious flower of life is then experienced in all of its fleeting fragility and delicate beauty.',
  ARRAY['Abuse', 'Acceptance', 'Aggressiveness', 'Anger', 'Animals and Animal Care', 'Children', 'Community Life and Group Experience', 'Competitiveness', 'Destructiveness', 'Earth Healing and Nature Awareness', 'Eating Disorders', 'Erratic Behavior', 'Exhaustion and Fatigue', 'Frustration', 'Healers', 'Healing Process', 'Heart', 'Home and Lifestyle', 'Impatience', 'Irritability', 'Joy', 'Learning Difficulties', 'Listening', 'Manifestation', 'Masculine Consciousness', 'Meditation', 'Moderation', 'Mother and Mothering', 'Perfectionism', 'Resistance', 'Restlessness', 'Stress', 'Tension', 'Thinking', 'Time Relationship', 'Tolerance', 'Work and Career Goals']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Indian Paintbrush',
  'Castilleja miniata',
  'red',
  'Professional Kit',
  'Lively, energetic creativity, exuberant artistic activity',
  'Low vitality and exhaustion, difficulty rousing physical forces to sustain the intensity of creative work; inability to bring creative forces into physical expression',
  'When the soul is engaged in highly creative work, it must integrate itself with its physical vehicle in the right way. If the body does not stay grounded and energized during creative work, it will suffer from low vitality, exhaustion and other forms of physical illness. Many souls do not fulfill their true artistic and creative potential because they are unable to harness spiritual energy in the right way. This phenomenon is similar to an electrical current of energy which needs to be properly polarized and grounded. Indian Paintbrush is very specific for this level of imbalance. It shows the soul how to use the will or lower metabolic forces to polarize spiritual energy, so that the physical body reflects a healthy alignment between Earth and Heaven. Indian Paintbrush also helps artists with the qualitative expression of their art, especially if such work lacks substance or connection with the physical world and natural processes. All in all, this essence helps the soul to learn how to use creative potential in a manner which is richly resonant with the physical world.',
  ARRAY['Body', 'Breakthrough', 'Catalyst', 'Creativity', 'Devitalization', 'Dryness', 'Energetic Patterns', 'Exhaustion and Fatigue', 'Frustration', 'Groundedness', 'Inspiration', 'Manifestation', 'Rejuvenation', 'Spiritual Emergency or Opening', 'Vitality', 'Will']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Indian Pink',
  'Silene californica',
  'red',
  'Professional Kit',
  'Remaining centered and focused, even under stress; managing and coordinating diverse forms of activity',
  'Psychic forces which are easily tom or shattered by too much activity; inability to stay centered during intense activity',
  'It is easy for the soul to experience equanimity when removed from daily stress and activity; but it is a far greater challenge to maintain one''s inner center despite chaos or pressure. Indian Pink helps those who are particularly vulnerable in this way, finding it difficult to anchor and center themselves. This remedy is quite specific to movement and activity. Those in need of Indian Pink are attracted to doing many things at once and live with much intensity. However, the astral body spins out of control, no longer stabilized by the ego, or spiritual Self. These individuals identify too much with the periphery of the circle and its agitated movement, rather than the point which remains fixed and inviolable. They are very tense and emotionally volatile, and can appear haggard and depleted because the etheric body is ravaged by too much astrality. Indian Pink assists such persons to identify with their spiritual center. By remaining more self-contained, they learn to orchestrate activity from the conscious Self, and therefore experience more health and harmony.',
  ARRAY['Action', 'Calm', 'Centeredness', 'City Life', 'Concentration and Focus', 'Disorientation', 'Emergency', 'Environment', 'Erratic Behavior', 'Home and Lifestyle', 'Irritability', 'Mother and Mothering', 'Nervousness', 'Overwhelm', 'Quiet', 'Scatteredness', 'Strength', 'Stress', 'Time Relationship']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Iris',
  'Iris douglasiana',
  'blue-violet',
  'Professional Kit',
  'Inspired artistry, deep soulfulness which is in touch with higher realms; radiant, iridescent vision and perspective',
  'Lacking inspiration or creativity; feeling weighed down by the ordinariness of the world; dullness',
  'It is the soul''s mission to build a rainbow bridge between spirit and matter. The pure light of the spirit needs to be ensouled, or colored with feeling. The rich darkness of matter needs to become luminous and filled with inner meaning. This is the path of the artist, and it is really true that every soul should express itself as an artist. As the physical body needs air to breathe, so does the soul need inspiration in order to live. As the physical body circulates blood in order to nourish itself, so does the soul live through the streaming and weaving of radiant color. Many modern individuals lack soul vitality; a gray pallor stifles them, they suffocate in the mundane and mechanical. Iris is a fundamental remedy for restoring and revitalizing the soul. It is indicated not only for those who are on a specific artistic path, but also for many individuals who need to bring passionate creativity to their life work. Iris essence impels the soul to create and cultivate beauty, within itself and within the world. It is an excellent, universally applicable remedy for initiating and sustaining development through flower essence therapy and other allied healing arts; for the flowers are the soul colors of Nature. Thus Iris helps the inner life of the human soul harmonize with the Soul of Nature, and in this way to become alive, vibrant, and truly "iridescent."',
  ARRAY['Action', 'Body', 'Breakthrough', 'Children', 'Creativity', 'Dryness', 'Dullness', 'Earth Healing and Nature Awareness', 'Eating Disorders', 'Environment', 'Feminine Consciousness', 'Freedom', 'Frustration', 'Home and Lifestyle', 'Immobility', 'Inadequacy', 'Inner Child', 'Inspiration', 'Learning Difficulties', 'Lightness', 'Manifestation', 'Materialism and Money', 'Menopause', 'Mid-Life Crisis', 'Mother and Mothering', 'Rejuvenation', 'Self-Actualization', 'Self-Expression', 'Soulfulness', 'Spiritual Emergency or Opening', 'Spontaneity', 'Study', 'Tension', 'Transcendence', 'Work and Career Goals']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Iris (Blue Flag)',
  'Iris versicolor',
  'blue-violet',
  'Seven Herbs Kit',
  'Integration of spiritual purpose with daily work, bringing spiritual power into the root chakra; spiritualized sexuality and grounded spirituality',
  'Estranged from one''s inner authority, inability to integrate higher spiritual purpose with real life and work; nervous exhaustion, sexual depletion',
  'It is the soul''s mission to build a rainbow bridge between spirit and matter. The pure light of the spirit needs to be ensouled, or colored with feeling. The rich darkness of matter needs to become luminous and filled with inner meaning. This is the path of the artist, and it is really true that every soul should express itself as an artist. As the physical body needs air to breathe, so does the soul need inspiration in order to live. As the physical body circulates blood in order to nourish itself, so does the soul live through the streaming and weaving of radiant color. Many modern individuals lack soul vitality; a gray pallor stifles them, they suffocate in the mundane and mechanical. Iris is a fundamental remedy for restoring and revitalizing the soul. It is indicated not only for those who are on a specific artistic path, but also for many individuals who need to bring passionate creativity to their life work. Iris essence impels the soul to create and cultivate beauty, within itself and within the world. It is an excellent, universally applicable remedy for initiating and sustaining development through flower essence therapy and other allied healing arts; for the flowers are the soul colors of Nature. Thus Iris helps the inner life of the human soul harmonize with the Soul of Nature, and in this way to become alive, vibrant, and truly "iridescent." Lady''s Slipper Seven Herbs Kit Lady''s Slipper helps the soul to incorporate its spirituality more completely into the body. It especially balances the relationship between the crown chakra and the lower energy centers. Those in need of this remedy are often unable to realize their inherent power and ability, so that their daily work or career is only a dim reflection of what is possible. A congestion of spiritual forces in the upper chakras results in psychic energy which is not properly circulated throughout the body. Such persons often suffer from weariness and exhaustion, especially depletion of their sexual forces. Lady''s Slipper is a tonic for the nervous system; it frees those spiritual capacities which reside in the upper energy centers to radiate more fully through the body. This redistribution of psychic energy is particularly pronounced in the feet; indeed, the ability to follow one''s destiny or "walk" one''s path has very much to do with intuitive powers which reside in the limbs. Lady''s Slipper calms and re-stabilizes the nervous system, helping the individual to regain inner composure and spiritual strength.',
  ARRAY['Alienation', 'Authority', 'Community Life and Group Experience', 'Conflict', 'Desire', 'Energetic Patterns', 'Exhaustion and Fatigue', 'Feminine Consciousness', 'Groundedness', 'Leadership', 'Life Direction', 'Manifestation', 'Nervousness', 'Power', 'Restlessness', 'Self-Actualization', 'Sexuality', 'Spiritual Emergency or Opening', 'Vitality', 'Work and Career Goals']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Yellow Lady''s Slipper',
  'Cypripedium parviflorum',
  'yellow',
  NULL,
  'Integration of spiritual purpose with daily work, bringing spiritual power into the root chakra; spiritualized sexuality and grounded spirituality',
  'Estranged from one''s inner authority, inability to integrate higher spiritual purpose with real life and work; nervous exhaustion, sexual depletion',
  'Lady''s Slipper helps the soul to incorporate its spirituality more completely into the body. It especially balances the relationship between the crown chakra and the lower energy centers. Those in need of this remedy are often unable to realize their inherent power and ability, so that their daily work or career is only a dim reflection of what is possible. A congestion of spiritual forces in the upper chakras results in psychic energy which is not properly circulated throughout the body. Such persons often suffer from weariness and exhaustion, especially depletion of their sexual forces. Lady''s Slipper is a tonic for the nervous system; it frees those spiritual capacities which reside in the upper energy centers to radiate more fully through the body. This redistribution of psychic energy is particularly pronounced in the feet; indeed, the ability to follow one''s destiny or "walk" one''s path has very much to do with intuitive powers which reside in the limbs. Lady''s Slipper calms and re-stabilizes the nervous system, helping the individual to regain inner composure and spiritual strength.',
  ARRAY['Alienation', 'Authority', 'Community Life and Group Experience', 'Conflict', 'Desire', 'Energetic Patterns', 'Exhaustion and Fatigue', 'Feminine Consciousness', 'Groundedness', 'Leadership', 'Life Direction', 'Manifestation', 'Nervousness', 'Power', 'Restlessness', 'Self-Actualization', 'Sexuality', 'Spiritual Emergency or Opening', 'Vitality', 'Work and Career Goals']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Showy Lady''s Slipper',
  'Cypripedium reginae',
  'pink and white',
  NULL,
  'Integration of spiritual purpose with daily work, bringing spiritual power into the root chakra; spiritualized sexuality and grounded spirituality',
  'Estranged from one''s inner authority, inability to integrate higher spiritual purpose with real life and work; nervous exhaustion, sexual depletion',
  'Lady''s Slipper helps the soul to incorporate its spirituality more completely into the body. It especially balances the relationship between the crown chakra and the lower energy centers. Those in need of this remedy are often unable to realize their inherent power and ability, so that their daily work or career is only a dim reflection of what is possible. A congestion of spiritual forces in the upper chakras results in psychic energy which is not properly circulated throughout the body. Such persons often suffer from weariness and exhaustion, especially depletion of their sexual forces. Lady''s Slipper is a tonic for the nervous system; it frees those spiritual capacities which reside in the upper energy centers to radiate more fully through the body. This redistribution of psychic energy is particularly pronounced in the feet; indeed, the ability to follow one''s destiny or "walk" one''s path has very much to do with intuitive powers which reside in the limbs. Lady''s Slipper calms and re-stabilizes the nervous system, helping the individual to regain inner composure and spiritual strength.',
  ARRAY['Alienation', 'Authority', 'Community Life and Group Experience', 'Conflict', 'Desire', 'Energetic Patterns', 'Exhaustion and Fatigue', 'Feminine Consciousness', 'Groundedness', 'Leadership', 'Life Direction', 'Manifestation', 'Nervousness', 'Power', 'Restlessness', 'Self-Actualization', 'Sexuality', 'Spiritual Emergency or Opening', 'Vitality', 'Work and Career Goals']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Larch',
  'Larix decidua',
  'red f./yellow m.',
  'English Kit',
  'Self-confidence, creative expression, spontaneity',
  'Lack of confidence, expectation of failure, self-censorship',
  'Larch helps those individuals who suffer from great self-doubt and poor self-esteem. The soul is lacking in confidence and thus projects failure, poor performance, or harsh judgment by others, far beyond the objective situation. In this way, the soul capacities stagnate, for such individuals severely censor and constrict their creative expression, and stifle their spontaneity. They are afraid to try anything new or risky, and therefore do little to grow and evolve. The Larch essence particularly heals the throat, or communication and creativity chakra. Many of those who need Larch are very closed down in this center, and may even have a physical affliction of the throat or other speaking impediments. Larch flower essence frees creative potential, giving the individual renewed confidence and expressiveness. Larch impels the soul from a self-limiting to a self-transcending mode of behavior.',
  ARRAY['Adolescence', 'Anxiety', 'Blame', 'Calm', 'Children', 'Communication', 'Confidence', 'Courage', 'Creativity', 'Discouragement', 'Doubt', 'Failure', 'Father and Fathering', 'Fear', 'Hesitation', 'Immobility', 'Inadequacy', 'Indecision', 'Inner Child', 'Life Direction', 'Manifestation', 'Masculine Consciousness', 'Motivation', 'Perfectionism', 'Perseverance', 'Pessimism', 'Pride', 'Procrastination', 'Rejection', 'Repression', 'Self-Acceptance', 'Self-Effacement', 'Self-Esteem', 'Self-Expression', 'Sexuality', 'Shame', 'Shyness', 'Speaking', 'Spontaneity', 'Work and Career Goals']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Larkspur',
  'Delphinium nuttallianum',
  'blue-violet',
  'Professional Kit',
  'Charismatic leadership, contagious enthusiasm, joyful service',
  'Leadership distorted by self-aggrandizement or burdensome dutifulness',
  'At many stages of its evolution, the soul assumes leadership responsibilities, in both large and small circles of influence. Unfortunately, leadership tasks are often assumed for the wrong reasons, and the soul either becomes weighted with burdensome duty, or inflated with self-importance. True spiritual leadership requires the radiance of charisma and contagious enthusiasm. When the soul is fired from within by positive identification with its inner ideals, its altruism can nourish and inspire others. Such leadership is not a matter of a forceful will which manipulates others, or dutiful execution of one''s responsibilities; rather, it is an inner joyfulness which energizes others. Larkspur helps those who are in positions of leadership to align their feeling life with their spiritual ideals. From this place, the soul learns to radiate inspired charismatic energy which motivates and encourages others.',
  ARRAY['Aggressiveness', 'Altruism', 'Ambition', 'Cheerfulness', 'Community Life and Group Experience', 'Dutifulness', 'Egotism', 'Enthusiasm', 'Idealism', 'Influence', 'Joy', 'Leadership', 'Lightness', 'Martyrdom', 'Masculine Consciousness', 'Materialism and Money', 'Power', 'Responsibility', 'Self-Aggrandizement', 'Service', 'Work and Career Goals']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Lavender',
  'Lavandula officinalis',
  'violet',
  'Professional Kit',
  'Spiritual sensitivity, highly refined awareness',
  'Nervousness, overstimulation of spiritual forces which depletes the physical body',
  'The Lavender flower helps those souls who are highly absorbent of spiritual influences. They tend to be very awake and quite mentally active, with a strong attraction to spiritual practices and various forms of meditation. However, they often absorb far more energy than can actually be processed through the body. "High-strung" and "wound-up" are words typically used to describe such personalities. They especially suffer from afflictions to the head, such as headaches or vision problems, and neck and shoulder tension. They are quite often plagued by insomnia or other nervous maladies. Lavender first works to sedate and soothe such persons; at a deeper level, it teaches one how to moderate and regulate one''s spiritual-psychic energy. In this way the soul learns to use its highly sensitive capacities in balance with the physical needs of the body.',
  ARRAY['Addiction', 'Aging', 'Calm', 'Dreams and Sleep', 'Emergency', 'Energetic Patterns', 'Exhaustion and Fatigue', 'Harmony', 'Healing Process', 'Immune Disturbances', 'Insomnia', 'Irritability', 'Massage', 'Meditation', 'Menopause', 'Moderation', 'Nervousness', 'Overwhelm', 'Perfectionism', 'Pregnancy', 'Protection', 'Psychosomatic Illness', 'Relaxation', 'Restlessness', 'Sensitivity', 'Shock', 'Soothing', 'Spiritual Emergency or Opening', 'Stress', 'Study', 'Tension', 'Time Relationship']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Lotus',
  'Nelumbo nucifera',
  'pink',
  'Professional Kit',
  'Open and expansive spirituality, meditative insight and synthesis',
  'Spiritual pride, inflated spirituality',
  'The soul is meant to wear a crown of light, and quite literally bears a subtle energy center called the crown chakra. This chakra gives the soul its sense of dignity, and awareness of its own regal or divine nature. Although the crown of light is a regal attribute, it can only be rightly worn by the soul which has acquired inner humility. Lotus is particularly indicated for imbalances in the crown chakra. It acts as a spiritual elixir or harmonizer, helping the soul to open itself to its inner divinity. However, an individual can also become overly developed in its spirituality. If the crown is overactive in relation to the other energy centers — especially the heart — the Lotus flower will re-direct and balance the spiritual forces. It particularly heals the tendency toward spiritual pride, or the illusion that one is "spiritually correct or superior." Lotus is an excellent, all-purpose remedy for enhancing and harmonizing the higher consciousness, and especially for integrating spirituality in a balanced way with the other energy centers.',
  ARRAY['Balance', 'Egotism', 'False Persona', 'Grace', 'Harmony', 'Lower Self', 'Meditation', 'Perfectionism', 'Pride', 'Receptivity', 'Self-Aggrandizement', 'Self-Esteem', 'Spiritual Emergency or Opening', 'Synthesis', 'Toner', 'Wisdom']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Love-Lies-Bleeding',
  'Amaranthus caudatus',
  'red',
  'Professional Kit',
  'Transcendent consciousness, the ability to move beyond personal pain, suffering or mental anguish by finding larger, transpersonal meaning in such suffering; compassionate awareness of and attention to the meaning of pain or suffering',
  'Intensification of pain and suffering due to isolation; profound melancholia due to the over-personalization of one''s pain',
  'The Love-Lies-Bleeding (Amaranthus) flower enables the soul to encounter and to transmute pain and suffering. Such pain is felt in an intense manner, either as mental anguish, deep-seated bodily torment, or disease. While such suffering usually has a physical component, the experience of agony is also deep within the soul itself. The effect of such torment is to push the consciousness deeply inward; such a person is truly deep-pressed, or in the throes of depression. Love-Lies-Bleeding does not play the role of an analgesic; it does not provide direct relief from such distress. It helps by moving the soul consciousness outward from over-personal identification and isolation, to transpersonal awareness of the meaning and purpose of such an experience. This energetic shift can often be experienced directly in the physical body, in the cessation of symptoms of pain or as a general stimulus to the immune system. However, more typically the individual is able to experience physical and mental suffering differently, within the context of a larger, shared human experience. For example, one suffering from a personal illness, a particular handicap, or addiction may be impelled to reach out to others who suffer similarly. The deepest teaching of Love-Lies-Bleeding is centered around the meaning of compassion and sacrifice. This realization within the soul is often called "Christ consciousness" — the capacity to suffer or to "bleed" not for ourselves but for all of humanity and for the redemption of the Earth itself. The ability to understand that one''s own pain is part of a larger, deeper experience of the human condition is the key to being able to truly experience love and compassion for all living beings.',
  ARRAY['Acceptance', 'Animals and Animal Care', 'Attachment', 'Awareness', 'Body', 'Brokenheartedness', 'Catharsis', 'Challenge', 'Community Life and Group Experience', 'Compassion', 'Death and Dying', 'Depression and Despair', 'Emergency', 'Escapism', 'Feminine Consciousness', 'Grief', 'Healing Process', 'Heart', 'Immune Disturbances', 'Loneliness', 'Love', 'Martyrdom', 'Non-Attachment', 'Release', 'Self-Concern', 'Sensitivity', 'Spiritual Emergency or Opening', 'Surrender', 'Transcendence', 'Vulnerability']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Madia',
  'Madia elegans',
  'yellow/red spots',
  'Professional Kit',
  'Precise thinking, disciplined focus and concentration',
  'Becoming easily distracted, inability to concentrate, dull or listless',
  'The healthy soul needs to learn to contract as well as expand — it must be able to narrow the consciousness, and limit the experience. One who can do this is able to focus and direct energy in a very clear and productive manner. Lacking this ability, the soul becomes easily distracted, or "spacey." This latter word is a good description of the person in need of Madia. Such an individual literally lives too much in space and not enough in present time; therefore its psychic forces are easily scattered. Madia is indicated for this basic imbalance in the soul life, but can also be helpful for seasonal distress, especially during the summer when hot weather makes one listless and distracted, or for a similar unfocused feeling which can occur in mid-afternoon. Madia pulls the soul into its center, so that the field of consciousness is pinpointed and focused. Its helps the soul to incarnate and direct its vast spiritual potential.',
  ARRAY['Aging', 'Attention', 'Awareness', 'Clarity', 'Concentration and Focus', 'Daydreaming', 'Decisiveness', 'Detail', 'Disorientation', 'Environment', 'Home and Lifestyle', 'Learning Difficulties', 'Manifestation', 'Mental Clarity', 'Quiet', 'Scatteredness', 'Speaking', 'Study', 'Time Relationship']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Mallow',
  'Sidalcea glaucescens',
  'pink-violet',
  'Professional Kit',
  'Warm and personable, open-hearted sharing and friendliness',
  'Socially insecure, fear of reaching out to others; creating barriers',
  'The soul flourishes through friendship and social exchange. Physical warmth is the basis of life, and likewise social warmth sustains the life of the human soul. Many individuals suffer from an inability to reach out to others. Often this stems from early childhood, but can also be due to other cultural or karmic factors. Such a personality has not learned to trust others, nor to trust his/her own capacity to radiate warmth to others. There is a profound inability to feel or to receive the warm flow of exchange which occurs when two souls touch energetically. Instead, the heart feels frozen, and those places which should be like portals are more like walls or barriers. The Mallow flower gently opens these obstructions to the feeling life, so that the soul can begin to experience the rich glow of social warmth that comes from loving exchange with others. Mallow helps the soul learn to trust the feelings buried in the heart, encouraging the individual towards greater social involvement.',
  ARRAY['Abandonment', 'Adolescence', 'Aloofness', 'Awkwardness', 'Barriers', 'Children', 'Community Life and Group Experience', 'Compassion', 'Healers', 'Insecurity', 'Intimacy', 'Involvement', 'Loneliness', 'Personal Relationships', 'Receptivity', 'Rejection', 'Self-Esteem', 'Sharing', 'Shyness', 'Trust', 'Warmth']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Manzanita',
  'Arctostaphylos viscida',
  'white-pink',
  'Professional Kit',
  'Embodiment, integration of spiritual Self with the physical world',
  'Estranged from the earthly world; aversion, disgust or revulsion toward the bodily Self and physical world',
  'The soul is a bridge between body and spirit; its task is a physical one every bit as much as a spiritual one. In some persons there is a particular aversion to the physical world and physical body. This can be the result of a current religious philosophy or spiritual program, or it can stem from deeply unconscious beliefs about the physical world which the soul has acquired in previous incarnations. This inner illness manifests as a feeling that the body is ugly and corrupted, or that it has little intrinsic worth compared to the spirit. The body is often highly objectified, exploited, or deprived through strict spiritual or ascetic regimens. Such an individual may have especially strong restrictions or rituals relating to food, with tendencies toward bulimia or anorexia. This harsh view of physical life and physical matter often hardens the body prematurely and can result in many illnesses, despite "perfect" health programs. Manzanita helps the individual to soften its relationship to the physical world, and re-direct its spiritual focus toward the body. Thus the soul comes to understand the body as a sacred shrine or temple of the spirit. Manzanita encourages the soul''s involvement with the physical world, especially the body; and imparts the teaching that matter is dead or inferior only to the degree that it remains unembraced by the soul''s consciousness.',
  ARRAY['Adolescence', 'Alienation', 'Ambivalence', 'Appreciation', 'Awareness', 'Awkwardness', 'Body', 'Children', 'Desire', 'Destructiveness', 'Dislike', 'Earth Healing and Nature Awareness', 'Eating Disorders', 'Groundedness', 'Healing Process', 'Instinctual Self', 'Massage', 'Mid-Life Crisis', 'Perfectionism', 'Pregnancy', 'Resistance', 'Sexuality']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Mariposa Lily',
  'Calochortus leichtlinii',
  'white/yellow center/purple spots',
  'Professional Kit',
  'Maternal consciousness, warm, feminine and nurturing; mother-child bonding, healing of the inner child',
  'Alienated from mother or from mothering, feelings of childhood abandonment or abuse',
  'The ability of the human soul to show nurturing and caring attention for others depends very much on whether it has received such nurturing itself. Each person should be able, as a divine birthright, to receive maternal love and unconditional support as a young infant and child. Many souls are deprived of a positive relationship to the mother. Especially in the modern world, cultural conditions de-humanize the relationship of the infant to the mother through birthing and child-rearing practices. Further deprivation may result from family trauma, divorce, economic hardship, or extreme situations of abuse, abandonment, and neglect. If the soul is crippled in its early relationship to the feminine, it feels cold and empty inside, and at its core, experiences itself as unloved and unwanted. The maturation process into adulthood is usually distorted — for males a rejection of or hostility to the feminine, and for females an alienation from their own mothering instincts. Mariposa Lily helps such souls heal this trauma by coming to terms with the painful past. It is an extremely important remedy, not only for infants and children, but also for many phases of adult therapy and positive parenting. Despite the wounding which may have occurred through an imperfect human mother, the soul can learn to forgive and heal, by experiencing the presence of the divine or archetypal mother who embraces the entire human family with gentle mercy and nurturing. This ability of the soul to feel and embrace the warm, loving presence of the maternal is the very important gift of the Mariposa Lily.',
  ARRAY['Abandonment', 'Abuse', 'Adolescence', 'Alienation', 'Animals and Animal Care', 'Children', 'Co-Dependence', 'Compassion', 'Death and Dying', 'Eating Disorders', 'Feminine Consciousness', 'Forgiveness', 'Healers', 'Healing Process', 'Heart', 'Home and Lifestyle', 'Inner Child', 'Intimacy', 'Involvement', 'Love', 'Menopause', 'Mother and Mothering', 'Personal Relationships', 'Pregnancy', 'Protection', 'Receptivity', 'Rejection', 'Self-Acceptance', 'Service', 'Sexuality', 'Softness', 'Soothing', 'Trust', 'Warmth']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Milkweed',
  'Asclepias cordifolia',
  'red-purple',
  'Research Kit',
  'Healthy ego strength; independence and self-reliance',
  'Extreme dependency and emotional regression, dulling the consciousness through drugs, alcohol, overeating; desire to escape from self-awareness',
  'Milkweed is indicated for extreme states of soul dependency and regression, characterized by lack of an independent ego identity. Such a condition can develop for many reasons — an accident or other life trauma which has made the individual overly dependent on family or institutionalized care; or gradual addiction to drugs, especially narcotics such as sedatives, opiates, and tranquilizers. Milkweed can sometimes be indicated for those on spiritual paths who deny the awake conscious ego function, or who believe that initiation can proceed only if the ego is annihilated. These regressive tendencies may also be the result of a disturbed maturation process in childhood which creates an unconscious desire for the ego to return to an infantile state. At its deepest karmic level, some souls may incarnate with impairments which disturb the natural maturation of the ego function. Because the core identity is poorly defined, there is difficulty coping with the normal demands and responsibilities of the adult ego. The soul seeks to blot out consciousness through drugs, overeating, excessive sleep, accidents, illness, or extreme spiritual practices. Milkweed nourishes the soul at a very deep level, leading to the ability to rebirth that part of the core self which has regressed. As the sod learns to experience the healthy function of its ego, it grows in strength and independence.',
  ARRAY['Addiction', 'Alienation', 'Awakeness', 'Co-Dependence', 'Community Life and Group Experience', 'Denial', 'Depression and Despair', 'Desire', 'Disorientation', 'Dreams and Sleep', 'Eating Disorders', 'Escapism', 'Healing Process', 'Inadequacy', 'Individuality', 'Inner Child', 'Learning Difficulties', 'Meditation', 'Mental Clarity', 'Mother and Mothering', 'Self-Actualization', 'Spiritual Emergency or Opening', 'Strength', 'True to Self']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Mimulus',
  'Mimulus guttatus',
  'yellow, red spots',
  'English Kit',
  'Courage and confidence to face life''s challenges',
  'Known fears of everyday life; shyness',
  'Mimulus is one of the most basic remedies for fear. Those needing this essence are hypersensitive and live with a great many small fears of ordinary and everyday events. They are especially afflicted in the solar plexus, which chums with great anxiety and unease. Eventually, if these fears are not met and transformed, the soul becomes quite darkened and introverted as it withdraws more and more from the stresses of daily living. Mimulus brings the light of courage back to such souls. It helps the individual shift its fixation from myriad lesser fears to awareness of a more basic, usually unconscious fear. This is a fear of the physical body, or of physical life itself, which can sometimes be traced to actual hesitation at the moment of incarnation. A pattern is thus set deep within the substrata of the soul which must be healed. Mimulus helps the soul to contact the strength and purpose of its Higher Self, and thus sets it free to experience life with greater curiosity, exuberance, and joy.',
  ARRAY['Aging', 'Animals and Animal Care', 'Anxiety', 'Calm', 'Children', 'Confidence', 'Courage', 'Escapism', 'Faith', 'Fear', 'Hesitation', 'Home and Lifestyle', 'Insecurity', 'Nervousness', 'Self-Concern', 'Self-Effacement', 'Shyness', 'Speaking', 'Time Relationship']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Morning Glory',
  'Ipomoea purpurea',
  'blue',
  'Professional Kit',
  'Sparkling vital force, feeling awake and refreshed, in touch with life',
  'Dull, toxic, or "hung over," inability to fully enter the body, especially in the morning; addictive habits',
  'The soul must constantly be on guard to align its astral body with its physical/etheric components. The astral (or star) body is naturally akin to the forces of night, and, if left unregulated, will not hesitate to devour the etheric (or life) body. Individuals with this imbalance typically crave late-night activity and have erratic eating and sleeping rhythms. The etheric body is more akin to the forces of day-time, especially early morning, and is greatly abused by such astraiity. If such abuse continues over a long period of time, the individual will experience increasing difficulty incarnating in the body, not only in the morning, but throughout the day. Unable to use the natural energy of the etheric body, the person will crave stimulants such as caffeine, and in extreme cases, cocaine or amphetamines. As this astraiity continues to predominate, the individual will display increasingly erratic patterns, possibly deteriorating into destructive and violent tendencies. Many levels of physical illness may occur, especially compromised immune response, nerve depletion, and disturbances in vital organs such as the liver. Morning Glory helps the soul come to greater awareness and respect for life and the life processes of the body. The individual learns to adjust its rhythm so that it is more in tune with the cycles of Nature. Through Morning Glory, the soul learns to experience more natural states of energy, and thus the gift of life itself.',
  ARRAY['Addiction', 'Attachment', 'Awakeness', 'Balance', 'Breakthrough', 'Destructiveness', 'Devitalization', 'Dreams and Sleep', 'Dullness', 'Earth Healing and Nature Awareness', 'Eating Disorders', 'Energetic Patterns', 'Erratic Behavior', 'Escapism', 'Exhaustion and Fatigue', 'Freedom', 'Habit Patterns', 'Hardness', 'Home and Lifestyle', 'Immobility', 'Immune Disturbances', 'Inertia', 'Moderation', 'Nervousness', 'Rejuvenation', 'Relaxation', 'Resistance', 'Restlessness', 'Sluggishness', 'Time Relationship', 'Toner', 'Transition', 'Vitality']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Mountain Pennyroyal',
  'Monardella odoratissima',
  'violet',
  'Professional Kit',
  'Strength and clarity of thought, mental integrity and positivity',
  'Absorbing negative thoughts of others, psychic contamination or possession',
  'Hygiene is as important to the life of the soul as it is for the physical body. Mountain Pennyroyal particularly addresses an individuals mental field which may be devitalized due to psychic congestion from too many negative or chaotic thought forms. There can also be mediumistic tendencies in such persons, so that they unconsciously absorb the negative thoughts of other persons or entities. When developed to an extreme state, the individual may no longer be able to think clearly for him/herself, or make rational decisions. There may be a tendency to possession, especially if the person is prone to using alcohol or other drugs. In these cases, seemingly conscious actions are actually carried out at the behest of others'' intentions rather than those of the true Self. Mountain Pennyroyal works as a purgative; it has the powerful ability to cleanse and expel negative thoughts, or the unhealthy intrusion of entities in the astral body. This essence clarifies the mental body and leads to greater vitality of the mental life, especially positive, clear thinking.',
  ARRAY['Addiction', 'Clarity', 'Cleansing', 'Healing Process', 'Home and Lifestyle', 'Influence', 'Mental Clarity', 'Negativity', 'Protection', 'Purification', 'Release', 'Sensitivity', 'Spiritual Emergency or Opening', 'Strength', 'Thinking', 'Vitality']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Mountain Pride',
  'Penstemon newberryi',
  'magenta',
  'Professional Kit',
  'Forthright masculine energy; warrior-like spirituality which confronts and transforms',
  'Vacillation and withdrawal in the face of challenge; lack of assertiveness, inability to take a stand for one''s convictions',
  'In learning to distinguish good from evil, or truth from untruth, the soul is compelled to take a stand in the world. The ability to act on what one knows to be true is of enormous importance. Especially in our modern world, it is of utmost urgency that the individual learn to transform feelings of dissatisfaction or disillusionment with the world into positive energy for change. Mountain Pride imparts to the soul the archetype of the spiritual warrior — the radiation of the positive masculine for both male and female souls. It is an especially important remedy for those persons who confuse peace with passivity. Such individuals must learn that positive activity is an important healing agent, not only for personal strength and soul development, but also for real peace in the world. Through Mountain Pride the soul learns to take a stand in the world and for the world, by aligning its own personal identity with forces of goodness and truth.',
  ARRAY['Action', 'Aggressiveness', 'Breakthrough', 'Challenge', 'Community Life and Group Experience', 'Competitiveness', 'Confidence', 'Courage', 'Cynicism', 'Death and Dying', 'Decisiveness', 'Dutifulness', 'Earth Healing and Nature Awareness', 'Escapism', 'Fear', 'Idealism', 'Leadership', 'Manifestation', 'Masculine Consciousness', 'Morality', 'Motivation', 'Perseverance', 'Power', 'Prejudice', 'Responsibility', 'Self-Expression', 'Service', 'Strength', 'Will']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Mugwort',
  'Artemisia douglasiana',
  'yellow',
  'Professional Kit',
  'Integrating psychic and dream experiences with daily life; multi-dimensional consciousness',
  'Inability to harmonize psychic forces, tendency to hysteria or emotionality, overactive psychic life out of touch with the physical world',
  'The soul is only half alive if it does not experience itself when asleep. The body may vegetate during sleep, but the soul has the capacity to awaken to another dimension of life. Mugwort enhances the receptive quality of the psyche, allowing greater awareness of dreams, so that the Self can gain insight about the affairs of daily life and can access guidance and direction from the spiritual world. This essence particularly helps the soul to navigate within the flow of psychic life, so that it is neither lost nor overwhelmed. It helps to balance transitions between day and night consciousness, assisting the individual to remain connected in a healthy way with the practical and physical world. This balance is very important, for when the moon forces become too predominant or inappropriately expressed, the soul becomes irrational, hysterical, or overly emotional. Mugwort helps to direct the psychic life into its proper sphere, gradually opening the soul to expanded consciousness.',
  ARRAY['Awareness', 'Balance', 'Daydreaming', 'Dreams and Sleep', 'Feminine Consciousness', 'Hysteria', 'Insight', 'Insomnia', 'Inspiration', 'Massage', 'Meditation', 'Pregnancy', 'Receptivity', 'Sensitivity', 'Spiritual Emergency or Opening', 'Toner']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Mullein',
  'Verbascum thapsus',
  'yellow',
  'Professional Kit',
  'Strong sense of inner conscience, truthfulness, uprightness',
  'Inability to hear one''s inner voice; weakness and confusion, indecisiveness; lying or deceiving oneself or others',
  'Consciousness must also include conscience; as the soul gains greater awareness of itself it also acquires an inner voice or moral life. This morality must be generated from within; as long as laws or dictates are stamped on the personality from the outside, the Self will not develop real strength of character. Mullein essence helps the individual at those times when it must wrestle with its own conscience. It can be extremely beneficial for those who lack moral fortitude, and who may resort to dishonesty or deceit in conducting the affairs of daily life. Through Mullein the soul awakens to its inner voice and develops the capacity to listen and respond to its true Self. This remedy can be especially helpful when one must take a stand for personal authenticity, despite social pressure or confusing social mores. The Mullein flower assists the soul in achieving greater moral uprightness, infused with qualities of Light and Truth.',
  ARRAY['Certainty', 'Choice', 'Decisiveness', 'Denial', 'Escapism', 'Guilt', 'Honesty', 'Indecision', 'Individuality', 'Judgment', 'Listening', 'Morality', 'Pregnancy', 'Prejudice', 'Receptivity', 'Self-Actualization', 'True to Self']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Mustard',
  'Sinapis arvensis',
  'yellow',
  'English Kit',
  'Emotional equanimity, finding joy in life',
  'Melancholy, gloom, despair; generalized depression without obvious cause',
  'Mustard is one of the important remedies for the soul''s experience of darkness. The soul in need of this essence feels suddenly overwhelmed with feelings of gloom and despair. This mood does not appear connected with obvious episodes or situations surrounding the person''s life. Instead, the feelings are much deeper and more overpowering, especially because the consciousness finds it difficult to penetrate to the cause or meaning of such depression. The reason for this experience lies deep within the subconscious memory, and often points to karmic circumstances beyond the present life. If the events preceding the depression are carefully reviewed the individual can usually identify an image, a word, a person, or a place which served as a trigger point for the unconscious to activate this darker material of the psyche. Mustard assists this healing response, helping one to come to terms with deep, unreconciled parts of the past. This essence is very helpful for complex states of depression, such as manic-depressive mood swings. It brings equilibrium and equanimity by helping the Self to balance extreme polarities of light and dark. Rather than experiencing light as separate from darkness, the soul is able to experience darkness as a transformative process. In this way. Mustard flower essence helps the soul to anchor and stabilize its light, leading to a sustained experience of gentle joyfulness and quiet radiance.',
  ARRAY['Acceptance', 'Adolescence', 'Anxiety', 'Cheerfulness', 'Courage', 'Darkness', 'Depression and Despair', 'Destructiveness', 'Discouragement', 'Gloom', 'Healing Process', 'Joy', 'Lightness', 'Loneliness', 'Martyrdom']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Nasturtium',
  'Tropaeolum majus',
  'orange-red',
  'Professional Kit',
  'Glowing vitality, flaming, radiant energy and warmth',
  'Feeling overly "dry" or intellectual; depletion of life-force and emotional verve',
  'Nasturtium is indicated for those times when the soul overuses or overextends the thinking forces, so that they are no longer in alignment with the lower, metabolic forces of life and warmth. This remedy is very helpful for students, those whose career demands strong intellectual activity, or for any phase of life where the intellect predominates. If these head forces are allowed to prevail, the soul life will become cold and disconnected from its physical body and from the larger physical body of the Earth. This imbalance predisposes the individual to many forms of physical illness, from colds and congestion in the head, to immune dysfunction and general hardening of the body. Nasturtium flower essence teaches the Self that the polarity of Light, or consciousness, must always be balanced with the opposite pole of Life, or experience. This essence brings warmth and vitality to the thinking process and, furthermore, helps the individual to direct its light into the practical experiences of daily life and physical reality.',
  ARRAY['Balance', 'Body', 'Creativity', 'Devitalization', 'Dryness', 'Earth Healing and Nature Awareness', 'Energetic Patterns', 'Exhaustion and Fatigue', 'Immune Disturbances', 'Intellectualism', 'Massage', 'Rejuvenation', 'Seriousness', 'Study', 'Thinking', 'Vitality', 'Warmth']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Nicotiana (Flowering Tobacco)',
  'Nicotiana alata',
  'white',
  'Research essence',
  'Peace which is deeply centered in the heart; integration of physical and emotional well-being through harmonious connection with the Earth',
  'Numbing of the emotions accompanied by mechanization or hardening of the body; inability to cope with deep feelings and finer sensibilities',
  'In the struggle to achieve balance, the soul needs to receive strength and stability from the Earth. However, if the heart is not sufficiently engaged in this process, the finer etheric sensibilities and feelings may be stymied. This soul disposition can be healed by Nicotiana, or Flowering Tobacco. The worldwide physical addiction to nicotine ac a smoking substance is a remarkably rapid and pervasive phenomenon, occurring only since the European discovery of the Americas. During this same period of time, the soul''s relationship to the Earth has changed dramatically. The Earth is now seen largely as a source for exploitation rather than nurturing, with its resources used to promote an increasingly technological and machine-based culture. A hardening has occurred in the physical bodies of most modern people, accompanied by a blunting of the emotions and reduced appreciation for that which is subtle and soulful. Those who are addicted to nicotine seek a way to stay grounded and to cope with the harsh forces they feel around them. Tobacco smoking is usually experienced as a sensation of relaxation and greater bodily ease, although more accurately this practice produces a numbing of the feelings. This reduction in the feeling life of the heart, accompanied by greater stimulation to the physical heart, enables the individual to adapt and even thrive in the harder, denser world of modern technology. While the flower essence of Nicotiana is strongly indicated for those who are healing their addiction to tobacco, it also has a much wider application, representing a soul condition which pervades the whole of modern culture. Nicotiana is a very important remedy for the heart, helping it to find true energy and sustenance which is not divorced from the life of feelings. It is very helpful for those who cope by numbing their feelings, hiding behind a tough or "cool" persona, or for those who seek stimulants of any kind that harden or falsify the body''s experience of the Earth. The flower essence of Nicotiana re-instills the true spiritual teaching of the Tobacco plant, which is used reverently and judiciously in peace pipe ceremonies by Native Americans. This teaching is that real peace arises from being able to feel deeply with the heart, and that these deep feelings give us our true connection to the Earth and all living beings.',
  ARRAY['Addiction', 'Aggressiveness', 'Aloofness', 'Anxiety', 'Avoidance', 'Balance', 'Body', 'Calm', 'City Life', 'Cynicism', 'Denial', 'Devitalization', 'Earth Healing and Nature Awareness', 'Eating Disorders', 'Energetic Patterns', 'Escapism', 'False Persona', 'Hardness', 'Heart', 'Loneliness', 'Lower Self', 'Masculine Consciousness', 'Nervousness', 'Power', 'Repression', 'Sensitivity', 'Strength', 'Tension', 'Vulnerability']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Oak',
  'Quercus robur',
  'red',
  'English Kit',
  'Balanced strength, accepting limits, knowing when to surrender',
  'Iron-willed, inflexible; overstriving beyond one''s limits',
  'Oak addresses many positive masculine soul traits of endurance, strength, and perseverance. These are the admirable qualities of the Mars-like hero, but they become a source of illness and dysfunction when they are not balanced with Venusian grace and gentle surrender. The Oak personality presses the limits of endurance; such persons are capable of enormous achievement. They are able to truly serve and help others because of their tremendous wellspring of willpower. However, this very strength can also become too rigid; the unrelenting demands and expectations which they have for themselves eventually take a toll on the physical health and inner happiness of the soul, until finally the individual is forced by circumstances to acknowledge that he/she is not all-powerful. Oak flower essence teaches such persons the positive attributes of surrender and acceptance of limitation. Through Oak the naturally strong capacities of the soul are balanced with the inner feminine Self, which learns to yield and to receive help from others when necessary.',
  ARRAY['Acceptance', 'Exhaustion and Fatigue', 'Ambition', 'Attachment', 'Competitiveness', 'Egotism', 'Failure', 'Flexibility', 'Hardness', 'Healers', 'Leadership', 'Martyrdom', 'Masculine Consciousness', 'Mid-Life Crisis', 'Overwhelm', 'Perseverance', 'Release', 'Responsibility', 'Surrender', 'Will', 'Work and Career Goals', 'Strength']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Olive',
  'Olea europaea',
  'white',
  'English Kit',
  'Revitalization through connection with one''s inner source of energy',
  'Complete exhaustion after a long struggle',
  'Olive essence relieves extreme physical symptoms of exhaustion and weariness. Despite the seemingly physical character of this remedy, it is nevertheless connected to a definite state of soul consciousness. Those needing this essence are usually over-identified with the physical body or the physical dimension. The healing crisis which they experience is actually a spiritual opening, which prompts them to look beyond the purely physical for health and sustenance. For many people. Olive can be their first spiritual opening, bringing the realization that the physical body is sustained by metaphysical forces. They learn that despite the fact that their physical forces are entirely spent, they can tap into another dimension of consciousness which gives renewal and restoration. Olive is helpful for many related, but lesser states of transformation — any time the physical body experiences utter fatigue and breakdown and the individual needs to reach to a higher place for its revitalization. Olive helps bring the awareness that the physical self is profoundly connected with higher states of soul-spiritual consciousness.',
  ARRAY['Addiction', 'Body', 'Depression and Despair', 'Devitalization', 'Energetic Patterns', 'Exhaustion and Fatigue', 'Healing Process', 'Immune Disturbances', 'Massage', 'Menopause', 'Pregnancy', 'Rejuvenation']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Oregon Grape',
  'Berberis aquifolium',
  'yellow',
  'Professional Kit',
  'Loving inclusion of others, positive expectation of good will from others, ability to trust',
  'Feeling paranoid or self-protective; unfair projection or expectation of hostility from others',
  'To trust in the goodness of others is to be nourished by the milk of human kindness. Regrettably, many souls are malnourished; they are unable to receive the sustaining love of others. Oregon Grape is indicated for those persons who are filled with paranoia; they see the world and those around them as hostile and unfair. These patterns were learned in childhood from the family or culture, and have not been healed; instead they fester in the soul and go on to infect all human relationships and social situations. Unfortunately, the soul who is gripped by this paranoid state creates the very reality he/she projects, for those who are treated in a hostile or mistrustful manner usually respond with an equal measure in return. Oregon Grape is widely applicable, but is especially indicated for the tension and ill-will which predominates in many urban environments. Through Oregon Grape the soul learns to break the basic pattern of mistrust. It realizes that it can look instead for the positive intentions of others, and create situations which generate good will and loving inclusion.',
  ARRAY['Abandonment', 'Aggressiveness', 'Appreciation', 'Blame', 'City Life', 'Community Life and Group Experience', 'Cynicism', 'Dislike', 'Faith', 'Fear', 'Hate', 'Hostility', 'Inner Child', 'Loneliness', 'Masculine Consciousness', 'Negativity', 'Paranoia', 'Personal Relationships', 'Pessimism', 'Prejudice', 'Rejection', 'Resentment', 'Trust']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Penstemon',
  'Penstemon davidsonii (violet-blue)',
  NULL,
  'Professional Kit',
  'Great inner fortitude despite outer hardships; perseverance',
  'Feeling persecuted or sorry for oneself; inability to bear life''s difficult circumstances',
  'The soul lesson of Penstemon is reminiscent of the biblical story of Job, where unusually harsh or severe life circumstances test the soul''s uttermost faith and tenacity. Those who need Penstemon seem to have been dealt an unfair blow in life; they may be born handicapped or become physically impaired through an accident. They may have lost a loved one, home, or possessions through a criminal act of violence or a natural catastrophe. Such souls have good reason to feel victimized; yet, in these moments of sorrow and pain, the soul must have the courage to rebuild itself and the faith to trust in a higher power. Penstemon has enormous strengthening powers, enabling the soul to tap into reservoirs of courage and resilience which are normally inaccessible to human consciousness. At its deepest level of transformation, Penstemon essence shows the soul that it has freely chosen even the harshest circumstances for its growth and evolution.',
  ARRAY['Acceptance', 'Adolescence', 'Aging', 'Animals and Animal Care', 'Barriers', 'Body', 'Challenge', 'Children', 'Competitiveness', 'Confidence', 'Courage', 'Death and Dying', 'Discouragement', 'Doubt', 'Failure', 'Frustration', 'Healing Process', 'Learning Difficulties', 'Manifestation', 'Martyrdom', 'Masculine Consciousness', 'Perseverance', 'Personal Relationships', 'Pessimism', 'Pregnancy', 'Prejudice', 'Self-Acceptance', 'Strength', 'Will']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Peppermint',
  'Mentha piperita',
  'violet',
  'Professional Kit',
  'Mindfulness, wakeful clarity, mental alertness',
  'Dull or sluggish, especially mental lethargy; unbalanced metabolism which depletes mental forces',
  'Peppermint imparts alert clarity and mental vibrancy. Those who need this remedy have a soul struggle between the lower and upper parts of their being, especially between the metabolic/digestive forces and the thinking/creative forces. In these cases, the life or metabolic forces overwhelm the consciousness with too much warmth, making the mental capacity dull and lethargic. Peppermint is at once cooling and warming. It cools down the lower organs, especially the liver, so that the consciousness can be freed for higher activity. It also stimulates the thinking forces so that they have a "digestive capacity" of a higher nature, making the thinking more lively, vital, and penetrating. Many people who need Peppermint have profound issues around eating and consciousness. They may crave the stimulation of food, only to find themselves sluggish and mentally incapacitated afterwards. It is as though two parts of the Self are warring for attention. Peppermint brings great healing and balancing energy, freeing the mind for higher thought, and helping the digestive, life forces work in their proper sphere.',
  ARRAY['Addiction', 'Aging', 'Apathy', 'Awakeness', 'Body', 'Clarity', 'Concentration and Focus', 'Dullness', 'Eating Disorders', 'Energetic Patterns', 'Exhaustion and Fatigue', 'Learning Difficulties', 'Lightness', 'Mental Clarity', 'Sluggishness', 'Study', 'Thinking', 'Vitality']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Pine',
  'Pinus sylvestris',
  'red f./yellow m.',
  'English Kit',
  'Self-acceptance, self-forgiveness; freedom from inappropriate guilt and blame',
  'Guilt, self-blame, self-criticism, inability to accept oneself',
  'Objective acknowledgment of one''s faults is an important soul virtue; when taken to an extreme, however, one can be wracked with undue guilt and misery. Those who need Pine get stuck in self-blame. At times a real circumstance from the past may result in deep feelings of regret and remorse; however, the Pine type often feels guilt which is entirely disproportionate to the actual events. These feelings may arise from childhood, when the person learned to internalize blame for dysfunction in the family system, or they may stem from a religious background which emphasizes sin and error more than salvation and grace. Pine helps the Self to learn true forgiveness by quite literally being for giving: learning to give oneself nourishment rather than withholding love from oneself; learning to release rather than retain energy. The individual is encouraged to move forward rather than stay entangled in self-deprecation and emotional paralysis. At its highest level. Pine teaches self-acceptance and inner esteem as a pathway to the soul''s realization of its own sacredness and divinity.',
  ARRAY['Abuse', 'Acceptance', 'Blame', 'Co-Dependence', 'Criticism', 'Depression and Despair', 'Destructiveness', 'Father and Fathering', 'Forgiveness', 'Grace', 'Guilt', 'Hardness', 'Hate', 'Manifestation', 'Healing Process', 'Inadequacy', 'Inner Child', 'Judgment', 'Lower Self', 'Morality', 'Perfectionism', 'Prejudice', 'Rejection', 'Self-Acceptance', 'Self-Effacement', 'Shame', 'Softness', 'Time Relationship']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Pink Monkeyflower',
  'Mimulus lewisii',
  'pink',
  'Research Kit',
  'Emotional openness and honesty; courage to take emotional risks with others',
  'Feelings of shame, guilt, unworthiness; fear of exposure and rejection, hiding essential Self from others, masking one''s feelings',
  'Pink Monkeyflower treats a type of fear which resides in the deepest recesses of the soul: the fear of being exposed, of others seeing one''s pain and vulnerability. Such persons experience a profound sense of shame, and thus have a need to hide or mask themselves as a form of protection. The Pink Monkeyflower type withdraws in a way that is more pronounced than ordinary shyness, for the soul is attempting to cover deeply internalized wounds from the past. Most frequently, early childhood trauma or abuse — or exploitative and debasing experiences at any phase in life — are the hidden factors in such behavior. These souls are highly sensitive and bear deep pain within themselves. They very much want to reach out and be loved by others, but often fail at making real contact. Such individuals are highly sensitive to being seen, both literally and metaphorically. They are also very vulnerable to being touched and making physical contact with others. Pink Monkeyflower gently opens such souls by helping them to take emotional risks again. In this way, they begin to experience the love and the contact which they so desperately need and want. Pink Monkeyflower is a remedy which is especially effective for the heart, teaching that it is only by remaining open and risking vulnerability that one can experience the warmth of human love and affection.',
  ARRAY['Abandonment', 'Abuse', 'Acceptance', 'Addiction', 'Adolescence', 'Aloofness', 'Anxiety', 'Attention', 'Avoidance', 'Awkwardness', 'Barriers', 'Body', 'Brokenheartedness', 'Children', 'Co-Dependence', 'Communication', 'Community Life and Group Experience', 'Courage', 'Cynicism', 'Eating Disorders', 'Escapism', 'False Persona', 'Father and Fathering', 'Fear', 'Feminine Consciousness', 'Freedom', 'Guilt', 'Hardness', 'Healers', 'Healing Process', 'Heart', 'Honesty', 'Inadequacy', 'Inner Child', 'Insecurity', 'Intimacy', 'Loneliness', 'Love', 'Masculine Consciousness', 'Massage', 'Obsession', 'Personal Relationships', 'Psychosomatic Illness', 'Rejection', 'Release', 'Repression', 'Resistance', 'Self-Effacement', 'Sensitivity', 'Sexuality', 'Shame', 'Sharing', 'Shock', 'Softness', 'Toner', 'Vulnerability']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Pink Yarrow',
  'Achillea millefolium var. rubra',
  'pink-purple',
  'Professional Kit',
  'Loving awareness of others from a self-contained consciousness; appropriate emotional boundaries',
  'Unbalanced sympathetic forces, overly absorbent auric field, lack of emotional clarity, dysfunctional merging with others',
  'emotional merging is unconscious; at other times, the individual willingly sponges up emotional debris. Such a soul is extremely "allergic" to emotional confusion and disharmony, and hopes to dissipate such discord by internalizing it. Pink Yarrow flower essence imparts greater objectivity and containment. It teaches that true compassion comes from the heart which is in touch with its own spiritual strength. Such a person learns to give love that does not absorb, but radiates; that heals not by sympathetic merging, but by compassionate presence.',
  ARRAY['Abuse', 'Animals and Animal Care', 'Blame', 'Calm', 'Children', 'City Life', 'Co-Dependence', 'Community Life and Group Experience', 'Compassion', 'Concentration and Focus', 'Death and Dying', 'Devitalization', 'Eating Disorders', 'Energetic Patterns', 'Environment', 'Feminine Consciousness', 'Guilt', 'Healers', 'Healing Process', 'Heart', 'Home and Lifestyle', 'Hysteria', 'Influence', 'Inner Child', 'Intimacy', 'Irritability', 'Love', 'Massage', 'Menopause', 'Negativity', 'Nervousness', 'Overwhelm', 'Paranoia', 'Personal Relationships', 'Power', 'Pregnancy', 'Protection', 'Sensitivity', 'Strength', 'Stress', 'True to Self', 'Vulnerability', 'Every', 'human', 'soul', 'seeks', 'at', 'its', 'deepest', 'level', 'to', 'be', 'compassionate,', 'to', 'open', 'its', 'feeling', 'life', 'to', 'others.', 'The', 'Pink', 'Yarrow', 'type', 'needs', 'to', 'distinguish', 'authentic', 'compassion', 'from', 'overly', 'sympathetic', 'identification', 'with', 'others.', 'For', 'such', 'persons,', 'the', 'boundaries', 'between', 'the', 'Self', 'and', 'others', 'are', 'quite', 'loose', 'and', 'ill-defined.', 'This', 'extreme', 'openness', 'predisposes', 'the', 'soul', 'to', 'easily', '"bleed,"', 'or', 'merge', 'with', 'its', 'environment,', 'particularly', 'the', 'emotional', 'aura', 'of', 'others.', 'As', 'a', 'consequence,', 'such', 'individuals', 'experience', 'emotional', 'confusion', 'and', 'oversensitivity,', 'unable', 'to', 'identify', 'which', 'feelings', 'originate', 'from', 'the', 'Self', 'and', 'which', 'from', 'others.', 'Sometimes', 'this']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Poison Oak',
  'Rhus diversiloba',
  'greenish-white',
  'Research Kit',
  'Emotional openness and vulnerability, ability to be close and make contact with others',
  'Fear of intimate contact, boundaries; fear of being violated; hostile or distant protective of personal',
  'Many souls have difficulty coping with their softer, more vulnerable feelings. This can be especially true for men, who are culturally influenced to display little intimacy or emotion. Those who need Poison Oak actually have within themselves very deep sensitivity, and can feel quite insecure about their personal boundaries. They fear that if they are too open or too intimate with others, their personal defenses will be violated. Such persons, however, rarely show their vulnerability and sensitivity, for they learn to cope by projecting an overly tough, Mars-like exterior. They erect negative barriers between themselves and others by showing hostility, anger, and irritability, thus keeping a "safe" emotional distance. At the deepest level, such persons are afraid of the inner feminine or of being engulfed by feminine values. This attitude can sometimes extend to feelings about Nature, so that the individual develops a relationship with Nature only through sports or activities that conquer the elements. Poison Oak teaches such souls to open gently by learning to identify and accept the softer side of themselves. In doing so, the soul creates boundaries that are inclusive rather than exclusive, learning that the essential strength of the Self also includes the most sensitive and gentle aspects.',
  ARRAY['Aggressiveness', 'Alienation', 'Anger', 'Avoidance', 'Barriers', 'Compassion', 'Earth Healing and Nature Awareness', 'Environment', 'Escapism', 'Fear', 'Feminine Consciousness', 'Hardness', 'Hostility', 'Impatience', 'Intimacy', 'Irritability', 'Masculine Consciousness', 'Materialism and Money', 'Negativity', 'Personal Relationships', 'Protection', 'Resistance', 'Sensitivity', 'Softness', 'Vulnerability']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Pomegranate',
  'Punica granatum',
  'red',
  'Professional Kit',
  'Warm-hearted feminine creativity, actively productive and nurturing at home or in the world',
  'Ambivalent or confused about the focus of feminine creativity, especially between values of career and home, creative and procreative, personal and global',
  'The individual who seeks to evolve through her feminine incarnation is given great possibility and choice in our modern era. Within the feminine soul are strong creative forces which can be used for biological mothering and family nurturing. But these same womb forces can also be used in the larger sphere of "world mother." Many women feel tom in their allegiance to traditional values of family and home, or service in the larger world. Those who attempt to balance both possibilities may feel that their energies are drained and compromised, so that neither role provides full, creative satisfaction. This crisis in the feminine soul may come at a particular stage in the life cycle, such as mid-life or menopause. The psychological tension may be so profound that physical illness is created, especially in the sexual organs. Without conscious awareness of this struggle, the soul does not have the power to choose and act freely. In the end many women short-change their ability to fully realize their feminine creative forces because of the inner confusion and turmoil which they feel. Pomegranate promotes conscious alignment with the feminine creative Self, so that a woman can see more clearly her right destiny and choices. Pomegranate helps the soul to stay connected to the Mother-Spirit-of-Love in all that it gives to the world.',
  ARRAY['Adolescence', 'Ambivalence', 'Balance', 'Body', 'Choice', 'Conflict', 'Creativity', 'Decisiveness', 'Feminine Consciousness', 'Instinctual Self', 'Life Direction', 'Menopause', 'Mother and Mothering', 'Pregnancy', 'Psychosomatic Illness', 'Sexuality', 'Work and Career Goals']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Pretty Face',
  'Triteleia ixioides',
  'yellow, brown stripes',
  'Research Kit',
  'Beauty that radiates from within; self-acceptance in relation to personal appearance',
  'Feeling ugly or rejected because of personal appearance; over-identified with physical appearance',
  'Perhaps at no other time in history have human beings sought so desperately to insure their self-worth by exterior standards of beauty. True beauty is a genuine attribute of the soul which every human being is capable of attaining. But great spiritual illness is created in those who seek to identify themselves only with cultural, cosmetic standards of beauty. Tremendous energy is drained from the soul when one tries to wear a cosmetic "mask" which can never be part of the true, living Self. Pretty Face is indicated for many different situations — for those born with physical deformities or ungainly features, and are especially karmically challenged to find their own inner worth and goodness; for those who, despite normal features, feel the need to excessively groom and alter their appearance; or for those who fear the aging process. In all these cases Pretty Face shifts the soul''s awareness from looking outside itself, to finding beauty within. This flower essence encourages the soul to contact its true inner luminosity, for it is this soul radiance which is the real component of beauty.',
  ARRAY['Abuse', 'Adolescence', 'Aging', 'Alienation', 'Anxiety', 'Awkwardness', 'Body', 'Communication', 'Confidence', 'Darkness', 'Eating Disorders', 'Envy', 'False Persona', 'Feminine Consciousness', 'Healing Process', 'Home and Lifestyle', 'Inadequacy', 'Inner Child', 'Insecurity', 'Lightness', 'Menopause', 'Mid-Life Crisis', 'Perfectionism', 'Prejudice', 'Pride', 'Rejection', 'Self-Acceptance', 'Self-Effacement', 'Self-Esteem', 'Shame']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Purple Monkeyflower',
  'Mimulus kelloggii',
  'purple',
  'Research essence',
  'Inner calm and clarity when experiencing any spiritual or psychic phenomenon; the courage to trust in one''s own spiritual experience or guidance; love-based rather than fear-based spirituality',
  'Fear of the occult, or of any spiritual experience; fear of retribution or censure if one departs from religious conventions of family or community',
  'Like the other Mimulus (Monkeyflower) species, Purple Monkeyflower addresses a state of fear within the soul. This flower particularly addresses fear related to experiences of a spiritual or psychic nature. Most typically, the Purple Monkeyflower is beneficial for those individuals whose great need for security and safety causes them to cling to conventional social-religious structures, even though these may not meet the real evolutionary needs of the soul. This prompts an inner conflict between the spiritual impulses received as inner guidance versus outer conventions or expectations. The fear of "going astray" and following one''s own authentic path can further be accentuated by harsh or judgmental religious dogma which includes threats of retribution or condemnation. This remedy is a powerful cleanser and stabilizer for projections based on cultural-religious superstition. Purple Monkeyflower is also indicated for intense fear, hallucinations, or paranoia that may result from abrupt or unexpected psychic opening, such as through drugs, cultic ritual abuse, or psychic manipulation. In such cases the soul develops profound fear of the spiritual world as being demonic or horrific. The path of healing for such souls is that of courage — to gain one''s own authentic experience by encountering spiritual phenomena in a calm and conscious manner. Through this courage, the soul is able to find true spiritual guidance, sustenance and support for life on Earth.',
  ARRAY['Abuse', 'Aging', 'Authority', 'Body', 'Calm', 'Children', 'Community Life and Group Experience', 'Confidence', 'Death and Dying', 'Emergency', 'False Persona', 'Freedom', 'Hysteria', 'Individuality', 'Inner Child', 'Meditation', 'Morality', 'Nervousness', 'Obsession', 'Paranoia', 'Protection', 'Repression', 'Self-Esteem', 'Sensitivity', 'Sexuality', 'Shame', 'Spiritual Emergency or Opening', 'Tension', 'Trust']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Quaking Grass',
  'Briza maxima',
  'green',
  'Professional Kit',
  'Harmonious social consciousness, finding higher identity in group work, flexibility',
  'Dysfunctional in group settings, inability to balance individual sense of Self and higher needs of group',
  'The soul must constantly balance its individuality with its social identity. A weak sense of Self can give nothing to the world; but too strong an ego can receive nothing from others. Quaking Grass is indicated for those who need to learn how to balance their sense of Self within a group context. This essence is not only very important for individuals, but also for entire groups or family systems to take together. It helps to create a group awareness which is greater than any single person, yet remains conscious of each individual identity. Most importantly. Quaking Grass helps the individual to see her/himself within a larger social matrix. Just as all parts of the physical body form one wholeness, so each individual can learn to see her/his role within a larger social body. This harmonious social consciousness is the special gift of the Quaking Grass flower.',
  ARRAY['Animals and Animal Care', 'Appreciation', 'Communication', 'Community Life and Group Experience', 'Conflict', 'Cooperation', 'Desire', 'Egotism', 'Flexibility', 'Harmony', 'Listening', 'Overview', 'Personal Relationships', 'Prejudice', 'Resistance', 'Tolerance', 'Work and Career Goals']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Queen Anne''s Lace',
  'Daucus carota',
  'white',
  'Research Kit',
  'Spiritual insight and vision; integration of psychic faculties with sexual and emotional aspects of Self',
  'Projection and lack of objectivity in psychic awareness; distortion of psychic perception or physical eyesight due to sexual or emotional imbalances',
  'Clairvoyance is often thought of in pseudo-mystical terms, but in fact, all human beings are clairvoyant to some extent. Whenever one is able to see not only the physical thing itself, but also the inherent qualities which emanate from the physical, one is seeing clairvoyantly. True clairvoyance is refined to ever more subtle levels in a gradual way, through inner purification of the emotional and instinctual life. Old forms of clairvoyance usually required that the individual sever conscious connection with the physical body and ordinary reality; however, modern clairvoyance depends very much on the ability to form a warm and grounded connection with the physical world. Queen Anne''s Lace is an important remedy for this transition of consciousness. It helps to remove debris in the emotional lens of the soul which distorts "clear-seeing." These imbalances in the "third eye" chakra, the center of clairvoyant faculties, often arise from disturbances in the lower chakras, when emotional and instinctual energies such as sexuality are not properly integrated by the individual. Queen Anne''s Lace harmonizes both "higher" and "lower" energies, so that one can stay connected with the Earth, yet also be emotionally clear and objective in one''s spiritual insight and vision. This essence is helpful for many who are seeking balanced psychic opening, or who may experience vision problems connected with emergent clairvoyance. The Queen Anne''s Lace flower helps to ground and stabilize, as well as to refine and sensitize the soul''s "clear-seeing."',
  ARRAY['Balance', 'Clarity', 'Aging', 'Attention', 'Awareness', 'Body', 'Concentration and Focus', 'Creativity', 'Denial', 'Disorientation', 'Emergency', 'Groundedness', 'Insight', 'Instinctual Self', 'Judgment', 'lightness', 'Lower Self', 'Meditation', 'Perspective', 'Psychosomatic Illness', 'Sensitivity', 'Sexuality', 'Spiritual Emergency or Opening', 'True to Self']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Quince',
  'Chaenomeles speciosa',
  'red',
  'Professional Kit',
  'Loving strength, balance of masculine initiating power and feminine nurturing power',
  'Inability to catalyze or reconcile feelings of strength and power with essential qualities of the feminine; distorted connection with the masculine Self or animus',
  'Love is a force which emanates from the heart, or feeling life, while power radiates primarily from the will sphere of the human being. Yet both these parts of the soul must eventually be integrated. Quince helps those who have difficulty reconciling these seeming opposites. It is especially indicated for women who need to come to terms with the "animus," or inner masculine part of their souls. Until it is consciously integrated, this masculine part may overwhelm the soul, creating a hard or calculating persona which is not consonant with the true feelings of the heart. At other times. Quince may be indicated for men or women who need to use their loving nature in a way that does not compromise their essential dignity and strength. Quince flower essence can be especially important for parents who must demonstrate nurturing and gentle qualities, as well as firm discipline and objectivity. The soul learns through the Quince essence that real power can be loving, and that true love also empowers.',
  ARRAY['Balance', 'Co-Dependence', 'Conflict', 'Father and Fathering', 'Feminine Consciousness', 'Hardness', 'Mother and Mothering', 'Power', 'Pregnancy', 'Self-Actualization', 'Softness', 'Strength']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Rabbitbrush',
  'Chrysothamnus nauseosus',
  'yellow',
  'Professional Kit',
  'Active and lively consciousness; alert, flexible and mobile state of mind',
  'Easily overwhelmed by details; unable to cope with simultaneous events or demanding situations',
  'Rabbitbrush is one of the essences which stimulates and vitalizes the awareness faculties of the soul. Its special gift is the ability to combine two seemingly opposite polarities: focused attention to detail, and a wide-ranging perspective which can encompass the "big picture." Most souls are able to master, at best, one of these modalities of awareness. If they develop focus and concentration, it is only by shutting out from their field of vision all that would distract. If they learn to see the full landscape of a situation, then the details blur, leaving only the broad outlines visible. The lesson of the person needing Rabbitbrush is to maintain a clear, precise awareness of a range of individual details, while simultaneously extending the field of awareness to include the larger, organizing principles which interrelate the various individual parts. Rabbitbrush essence is indicated for people who feel overwhelmed by the amount of detail, or by the jumble of simultaneous events which need attention. Many of the jobs in our modern society present such challenges — for example, managing a busy office. By developing the capacity to integrate many simultaneous details while maintaining awareness of the total situation, the soul acquires great agility and flexibility. The person who unconsciously draws the soul''s energy out of the body, and resists becoming fully engaged and fully focused in the physical world, will not be able to develop this potential, and will shrink from the seemingly overwhelming challenges of modern life. Rabbitbrush can help such souls to take greater interest in the world around them, thereby strengthening one''s ability to learn from physical existence.',
  ARRAY['Attention', 'Awakeness', 'Awareness', 'Concentration and Focus', 'Detail', 'Flexibility', 'Mental Clarity', 'Overview', 'Overwhelm', 'Perspective', 'Scatteredness', 'Study', 'Synthesis', 'Thinking', 'Work and Career Goals']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Red Chestnut',
  'Aesculus carnea',
  'red',
  'English Kit',
  'Caring for others with calm, inner peace, trust in the unfolding of life events',
  'Obsessive fear and worry for well-being of others, fearful anticipation of problems for others',
  'To genuinely care for another is a great virtue of the human soul. But this caring can cross the boundary of healthy compassion and turn instead into negative worry and anxiety for another. This is particularly true in a family system or other close relationship, when a parent or spouse is too closely identified with its role as caretaker, and thus becomes unconsciously enmeshed in the psychic space of another. Red Chestnut particularly addresses the mental imbalance which this condition produces. It shows the soul how worry and concern drain the individual of positive vital energy, and does little to help heal the actual situation. When the soul pulls back into its own sphere of consciousness it can effectively anchor itself and become an agent for real healing. The greatest of healing gifts which one can bestow upon another is the ability to radiate calm, loving thoughts. This unconditional regard for another''s welfare is the great gift of Red Chestnut.',
  ARRAY['Attachment', 'Calm', 'Co-Dependence', 'Doubt', 'Fear', 'Healers', 'Insomnia', 'Mother and Mothering', 'Obsession', 'Perfectionism', 'Pregnancy', 'Relaxation', 'Responsibility', 'Sensitivity']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Red Clover',
  'Trifolium pratense',
  'pink-red',
  'Professional Kit',
  'Self-aware behavior, calm and steady presence, especially in emergency situations',
  'Susceptible to mass hysteria and anxiety, easily influenced by panic or other forms of group thought',
  'The ability to maintain one''s own sense of individuality can be severely challenged in adverse situations, particularly where conditions of strong "mass consciousness" prevail. It is well known that many people lose their capacity to think and respond when caught in highly-charged "webs" of emotional energy, such as the group panic or hysteria which can arise during natural disasters, war, economic crisis, or when public emotions are inflamed by political or religious demagoguery. Conditions such as these can be seen from another level as a severe form of psychic infectious disease, which rapidly inflames a crowd of people, feeding on currents of fear and confusion. The individual loses his or her own identity and is used as a vehicle to serve the needs of an unleashed force of negativity. This situation can also arise in a family, especially during emergencies or crises, when the blood ties of the family become stronger than the self-awareness of the single individual, who is then propelled by hysterical or destructive energy. Red Clover flower essence is a powerful cleanser and balancer; it is especially related to the psychic properties of the blood, where the spiritual ego of each individual resides. Red Clover infuses strong forces of self-awareness so that the individual can think in a calm and steady way, and act from his/her own center of truth.',
  ARRAY['Animals and Animal Care', 'Calm', 'Centeredness', 'Challenge', 'Co-Dependence', 'Death and Dying', 'Disorientation', 'Emergency', 'Gloom', 'Hysteria', 'Inner Child', 'Leadership', 'Overwhelm', 'Prejudice', 'Protection', 'Speaking', 'Vulnerability']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Rock Rose',
  'Helianthemum nummularium',
  'yellow',
  'English Kit',
  'Flexibility, spontaneity, and flowing receptivity; following the spirit rather than the letter of the law',
  'Rigid standards for oneself, asceticism, self-denial',
  'Rock Rose flower essence addresses the soul''s need for courage, especially in very extreme circumstances. This remedy is indicated for moments when the soul has stepped almost completely outside the body and is in a survival mode of consciousness. The Self is forced to address a severe emergency, usually of life-threatening proportions such as violent attack or a traumatic accident. This remedy can also be indicated for the process of dying, when the ego is gripped by the fear that it will be utterly annihilated or destroyed. Rock Rose restores sun-like forces of courage to the human soul so it can meet these tremendous challenges with self-transcending strength. Although Rock Rose can be used alone, it is most commonly used in the composite "Five Flower Formula" (Star of Bethlehem, Impatiens, Cherry Plum and Clematis) for maximum benefit. Rock Water (solarized spring water) English Kit Rock Water, one of the original English remedies, is not made from a plant, but from the essence of a sacred, underground spring, where the Earth forces are concentrated and consecrated. Rock Water treats a condition of soul which is more mineral than plant-like; it is for those who have extremely rigid attitudes toward life. Although such souls have high philosophical ideals, they suffer from an inability to enjoy life, and their thoughts quickly crystallize into hardened dogma. They adopt schedules for work, or life patterns for eating and sleeping, which are overly restrictive and mechanical. If they are following a spiritual path, such individuals tend towards harsh asceticism, attempting to fit their lives into strict and narrow concepts of spiritual behavior. The essence of Rock Water helps such souls to develop more inner flexibility, and especially to feel the living, pulsing currents of their emotional life. In this way, such persons come more in touch with their feelings, which stream and flow from the inner being much as water courses from the Earth. This essence is sometimes indicated for those beginning flower essence therapy, or for those who cannot feel the results of flower essences. Rock Water opens the soul to the plant realm of consciousness, by helping it to experience the flowering, flowing qualities of the feeling life.',
  ARRAY['Barriers', 'Criticism', 'Desire', 'Dutifulness', 'Eating Disorders', 'Flexibility', 'Habit Patterns', 'Hardness', 'Idealism', 'Martyrdom', 'Masculine Consciousness', 'Morality', 'Obsession', 'Perfectionism', 'Repression', 'Resistance', 'Seriousness', 'Spiritual Emergency or Opening', 'Spontaneity', 'Tolerance']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Rosemary',
  'Rosmarinus officinalis',
  'violet-blue',
  'Research Kit',
  'Warm physical presence; embodiment; vibrantly incarnated physical/etheric warmth; higher ego forces which are not integrated with the physical body',
  'Forgetfulness, poorly incarnated in body, lacking',
  'Rosemary flower essence is a strong awakening and incarnating remedy. It is indicated for those souls whose incarnation is weak or disturbed, especially when the higher spiritual or thought faculties cannot work properly through the physical vehicle. This results in a reduced state of consciousness in the body, with a tendency toward absent-mindedness, forgetfulness, or hypoglycemic tendencies. In particular, the soul forces are lacking in warmth and full-bodied presence. Quite literally, this means that the physical extremities of the body are often cold and devitalized. At a deeper level, this lack of warmth stems from with the soul''s feeling of insecurity in the physical body. This can sometimes be traced to a karmic disposition of the soul which feels ambivalent about its incarnation and has learned to use its spiritual forces outside the world of physical matter. Very often this soul illness is caused by early childhood trauma, where extreme physical abuse or stress has forced the soul out of the body, so that it no longer trusts its connection with the physical world. Rosemary gives such persons the ability to feel warm and secure in their physical bodies. Through these renewed forces, the spirit''s flame bums more brightly in the body and gives its light and consciousness to the physical worid.',
  ARRAY['Abuse', 'Addiction', 'Aging', 'Awakeness', 'Body', 'Centeredness', 'Concentration and Focus', 'Devitalization', 'Disorientation', 'Dreams and Sleep', 'Eating Disorders', 'Energetic Patterns', 'Groundedness', 'Healing Process', 'Inner Child', 'Insecurity', 'Massage', 'Menopause', 'Mental Clarity', 'Nervousness', 'Spiritual Emergency or Opening', 'Stress', 'Warmth']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Sage',
  'Salvia officinalis',
  'violet',
  'Research Kit',
  'Drawing wisdom from life experience; reviewing and surveying one''s life process from a higher perspective',
  'Seeing life as ill-fated or undeserved; inability to perceive higher purpose and meaning in life events',
  'Sage flower essence enables the Self to learn and reflect about life experience, particularly enhancing the capacity to experience deep inner peace and wisdom. This remedy addresses a natural distillation process which occurs as the healthy person ages. Throughout the course of life, trials and tribulations are placed in the soul''s path so that it can distill impurities and volatile emotions, reaching an ever more clarified and refined state. Through the aging process, the soul should be able to attain increasing inner stability and peaceful acceptance of its condition. If one is unable to experience this graceful maturation process, life events seem ill-fated and undeserved, without higher purpose or meaning. The Sage remedy can be helpful during various life phases and transitions, when one needs to step back and consider the unfolding events of life. However, it is particularly indicated for advanced stages of the life biography, when the Self must learn to survey life experience, and to glean wisdom and insight. Through Sage, the soul comes more in touch with its own spiritual meaning and purpose, and thus acquires profound wisdom to heal and counsel others.',
  ARRAY['Acceptance', 'Aging', 'Appreciation', 'Attachment', 'Authority', 'Awareness', 'Blame', 'Community Life and Group Experience', 'Cynicism', 'Death and Dying', 'Faith', 'Father and Fathering', 'Forgiveness', 'Insight', 'Leadership', 'Life Direction', 'Masculine Consciousness', 'Materialism and Money', 'Menopause', 'Mid-Life Crisis', 'Non-Attachment', 'Overview', 'Perspective', 'Quiet', 'Self-Esteem', 'Time Relationship', 'Wisdom']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Sagebrush',
  'Artemisia tridentata',
  'yellow',
  'Professional Kit and Seven Herbs Kit',
  'Essential or "empty" consciousness, deep awareness of the inner Self, capable of transformation and change',
  'Over-identification with the illusory parts of oneself; purifying and cleansing the Self to release dysfunctional aspects of one''s personality or surroundings',
  'If the soul is not prepared to go through the psychological experience of "the abyss," or emptiness, it robs itself of the essential precondition for rebirth, or transformation. Especially in our modern culture which emphasizes materialism and ego-inflation, it is difficult for the personality to voluntarily practice emptiness and detachment. Many people cling too tightly to exterior props of existence through over-identification with possessions, lifestyle or social recognition, and thereby deny themselves the opportunity for true soul evolution. Often, the Higher Self intervenes by setting up a condition to cleanse the false persona through illness or misfortune. Sagebrush helps one to come in touch with the naked, essential Self, for it is here that truly free and spacious spiritual forces reign. As the soul recognizes what is absolutely essential to its identity and releases what no longer serves its evolution, it moves forward in its destiny with far greater forces of discrimination and inner freedom.',
  ARRAY['Addiction', 'Adolescence', 'Attachment', 'Breakthrough', 'Cleansing', 'Creativity', 'Death and Dying', 'Depression and Despair', 'Desire', 'Egotism', 'False Persona', 'Freedom', 'Greed', 'Grief', 'Habit Patterns', 'Healing Process', 'Home and Lifestyle', 'Honesty', 'Individuality', 'Life Direction', 'Materialism and Money', 'Menopause', 'Mid-Life Crisis', 'Non-Attachment', 'Purification', 'Quiet', 'Receptivity', 'Release', 'Self-Esteem', 'Soulfulness', 'Time Relationship', 'Transcendence', 'Transition', 'True to Self']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Saguaro',
  'Cereus giganteus',
  'white, yellow center',
  'Professional Kit',
  'Awareness of what is ancient and sacred, a sense of tradition or lineage; ability to learn from elders',
  'Conflict with images of authority, sense of separateness or alienation from the past',
  'In the soul''s struggle for freedom and self-determination, it can sometimes react negatively to all which has come from the past. In these instances, the individual lacks the insight to acknowledge that it has freely chosen its incarnation in a particular subculture, race, folk-soul, or family constellation. When these deep connections are not understood, the very influences from which the personality seeks liberation are often unconsciously internalized and negatively re-enacted in a subsequent phase of life. Saguaro addresses rebellious tendencies of the emotional life, refining these into positive qualities of awareness and insight. This remedy is particularly indicated for the adolescent and young adult phases of life. Saguaro can also be helpful when the individual requires a deeper understanding of his or her tradition, lineage, or culture, or needs to establish a more conscious relationship to elder authority and guidance. By actively embracing and understanding its past, the soul is free to grow and change in a more conscious and clear way.',
  ARRAY['Acceptance', 'Adolescence', 'Alienation', 'Ambivalence', 'Authority', 'Blame', 'Conflict', 'Criticism', 'Destructiveness', 'Father and Fathering', 'Feminine Consciousness', 'Prejudice', 'Resistance', 'Will', 'Wisdom']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Saint John''s Wort',
  'Hypericum perforatum',
  'yellow',
  'Professional Kit',
  'Illumined consciousness, light-filled awareness and strength',
  'Overly expanded state leading to psychic and physical vulnerability; deep fears, disturbed dreams',
  'As flowers need sunlight in order to grow, so also the soul needs light — both physical and spiritual — to flourish. However, some souls lose themselves in light because they have not developed proper rooting. Saint John''s Wort is indicated for those persons who are quite sensitive or over-receptive to the effects of light; they may be fair-skinned, easily sunburned, or find themselves adversely affected by intense heat or light. They are prone to many forms of environmental stress, including allergies. These individuals have a very active psychic life — the astral body expands greatly during sleep, often distorting its connection with the physical and etheric bodies, or with the ego. This weak association to the other bodies results in a propensity for invasion or attack from negative elemental forces or other entities, especially during sleep; dream disturbances, bed-wetting, or night sweats can be common symptoms. Saint John''s Wort flower essence has marvelous restorative powers; it provides protection and strength when the soul is in an overly expanded state. While it is generally indicated for those who are oversensitive to light, it can also be helpful for those deprived of light, such as Seasonal Affective Disorder. At its deepest level of transformation. Saint John''s Wort helps the soul to circulate light through the body and into the Earth. Rather than experiencing light as an external and merely physical reality, light works within the Self as a spiritual force which can illumine and anchor the consciousness.',
  ARRAY['Shock', 'Aging', 'Awakeness', 'Certainty', 'Children', 'Confidence', 'Darkness', 'Daydreaming', 'Death and Dying', 'Devitalization', 'Dreams and Sleep', 'Emergency', 'Fear', 'Groundedness', 'Insecurity', 'Insomnia', 'tightness', 'Massage', 'Protection', 'Sensitivity', 'Spiritual Emergency or Opening', 'Trust', 'Vulnerability']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Scarlet Monkeyflower',
  'Mimulus cardinalis',
  'red',
  'Professional Kit',
  'Emotional honesty, direct and clear communication of deep feelings, integration of the emotional "shadow"',
  'Fear of intense feelings, repression of strong emotions; inability to resolve issues of anger and powerlessness',
  'The Scarlet Monkeyflower treats a particular state of fear within the human soul: the soul''s fear of its own "shadow self" or lower emotions. Those who need this remedy often keep a "lid" on unpleasant emotions. These feelings remain bottled up in the psyche, subject to increasing levels of tension and pressure, until the individual explodes in blind rage or other raw emotions. Unfortunately, these episodes seem to confirm the worst fears — that there is an explosive, demonic force lurking inside — and so the soul is often caught in a vicious cycle of repressing emotional material, only to have it ooze out or explode full force when the ego''s "lid" can no longer hold it in. Scarlet Monkeyflower gives the soul courage to actively acknowledge and confront such feelings. These emotions of anger or other intense feelings often have a legitimate basis, but because they are not dealt with in a timely fashion, they loom out of proportion in the psyche. As these experiences are more quickly and honestly acknowledged, the sod learns that it is healthier to integrate such material than to repress it. Scarlet Monkeyflower imparts emotional depth, honesty, and vitality to the soul in its journey toward true wholeness.',
  ARRAY['Addiction', 'Anger', 'Avoidance', 'Awareness', 'Breakthrough', 'Catharsis', 'Communication', 'Courage', 'Death and Dying', 'Denial', 'Destructiveness', 'Escapism', 'Father and Fathering', 'Fear', 'Freedom', 'Hate', 'Honesty', 'Inner Child', 'Instinctual Self', 'Lower Self', 'Masculine Consciousness', 'Menopause', 'Mother and Mothering', 'Negativity', 'Perfectionism', 'Personal Relationships', 'Power', 'Rejection', 'Repression', 'Resistance', 'Shadow Consciousness', 'Shame']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Scleranthus',
  'Scleranthus annuus',
  'green',
  'English Kit',
  'Decisiveness, inner resolve, acting from the certainty of inner knowing',
  'Hesitation, indecision, confusion, wavering between two choices',
  'The experience of living on Earth is one of duality; the soul must constantly learn to establish its own inner balance through the tension of polarity. The individual who needs Scleranthus finds this level of inner activity to be very painful and challenging. Subconsciously, such a person longs for wholeness as a given external condition of life, not realizing that a far greater wholeness is achieved through the ability to choose and define who one is. Such individuals are by nature introverted and would prefer a quiet existence, but because of the need in their souls to evolve, they are often caught in one turmoil-creating incident or another. They tend to vacillate when making choices, and can postpone major, life-directing decisions for years. This extreme uncertainty drains the soul of much vitality and energy, and can permeate even into the physical body with numerous illnesses, especially characterized by a continual shifting of physical states and symptoms. Scleranthus flower essence helps such souls toward greater decisiveness and clarity of purpose. This enables the Self to make choices not only at the obvious, symptomatic level; at a deeper level the soul learns to choose greater involvement in its experience of earthly life.',
  ARRAY['Ambivalence', 'Balance', 'Breakthrough', 'Certainty', 'Choice', 'Confidence', 'Conflict', 'Decisiveness', 'Desire', 'Doubt', 'Erratic Behavior', 'Escapism', 'Hesitation', 'Immobility', 'Indecision', 'Judgment', 'Life Direction', 'Manifestation', 'Morality', 'Pregnancy', 'Psychosomatic Illness', 'Restlessness', 'Scatteredness']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Scotch Broom',
  'Cytisus scoparius',
  'yellow',
  'Professional Kit',
  'Positive and optimistic feelings about the world and about future events; sun-like forces of caring, encouragement, and purpose',
  'Feeling weighed down and depressed; overcome with pessimism and despair, especially regarding one''s personal relationship to world events',
  'We live in a time of great uncertainty, transformation, and upheaval. These powerful conditions can predispose many souls to feel very anxious and depressed about their lives and the future of the Earth. Such persons may be morbidly attracted to apocalyptic scenarios of the future, or exposure to mass media portrayal of world events may arouse intense feelings of pessimism and despair. These feelings burden the soul with extreme emotional weight so that the soul becomes heavy and "deep-pressed." At the core of such illness is the feeling of "What''s the use?" or "Why try?" The depression such persons experience is characterized not only by feelings about their personal lives, but about the world as a whole and their relationship to world events. Thus the soul is paralyzed in the positive use of its forces, unconsciously adding to the darkness of the "world-psyche." Scotch Broom gives tenacity and strength, enabling the individual to move from personal despair to impersonal service and concern for the welfare of the world. This essence helps the soul to meet the challenges of our times as opportunities for self-growth and for helping others. In making this transition, the soul shifts from its unconscious identification with world darkness to the vision of a more hopeful, positive world future.',
  ARRAY['Acceptance', 'Challenge', 'Darkness', 'Depression and Despair', 'Discouragement', 'Doubt', 'Earth Healing and Nature Awareness', 'Faith', 'Gloom', 'Manifestation', 'Motivation', 'Perseverance', 'Perspective', 'Pessimism', 'Service', 'Strength']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Self-Heal',
  'Prunella vulgaris',
  'violet',
  'Professional Kit',
  'Healthy, vital sense of Self; healing and beneficent forces arising from within oneself, deep sense of wellness and wholeness',
  'Inability to take inner responsibility for one''s healing, lacking in spiritual motivation for wellness, overly dependent on external help',
  'Self-Heal flower essence is one of the most fundamental and broadly applicable remedies for true soul healing and balance. Its very name is exquisitely evocative of its profound qualities; this essence addresses the capacity of the Self to become involved with and take responsibility for its own healing journey. No variety of outer measures and techniques can bring about genuine healing at any level unless the individual is quickened from within and motivated to seek and affirm the wholeness of life. Self-Heal flower essence addresses a very special relationship between the etheric, or life body, and the Spiritual Self. On the physical level, the etheric body restores wholeness to wounds and other afflictions by quite literally "re-covering" the body with its life sheath. The Higher Self can also draw upon this etheric life force and the possibility for recovery. Self-Heal flower essence is especially indicated for those who have lost belief in their own capacity to be well, or who have abdicated this inherent responsibility to healers or others. It is a very beneficial remedy for those who face great healing challenges, whether physical, mental, or spiritual. The great lesson and the powerful gift of Self-Heal is to enable the Self to affirm and to draw from the deep wellspring of etheric life, toward true recovery and restoration.',
  ARRAY['Addiction', 'Aging', 'Ambivalence', 'Animals and Animal Care', 'Body', 'Children', 'Cleansing', 'Confidence', 'Conflict', 'Denial', 'Doubt', 'Eating Disorders', 'Emergency', 'Energetic Patterns', 'Escapism', 'Exhaustion and Fatigue', 'Faith', 'Healers', 'Healing Process', 'Immune Disturbances', 'Individuality', 'Inner Child', 'Learning Difficulties', 'Massage', 'Menopause', 'Mid-Life Crisis', 'Psychosomatic Illness', 'Rejuvenation', 'Resistance', 'Seeking', 'Self-Acceptance', 'Self-Actualization', 'Shock', 'Toner', 'Trust', 'Vitality']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Shasta Daisy',
  'Chrysanthemum maximum',
  'white/yellow center',
  'Professional Kit',
  'Mandalic or holistic consciousness, synthesizing ideas into a living wholeness',
  'Over-intellectualization of reality, especially seeing information as bits and pieces rather than parts of a whole',
  'The thinking part of the soul functions by dividing phenomena into smaller, more easily understood components. However, if the analytical aspect of the mind holds too great a sway, the consciousness can no longer experience greater wholeness and meaning in its understanding of life. This is an especially powerful tendency in our modern culture, where the thinking and intellectual life is given great prominence and emphasis. Shasta Daisy imparts insight into the broader meanings and larger patterns of mental and emotional experience. This remedy can be very helpful for those involved in writing, teaching, research, or other intellectual professions. It is also beneficial in any therapeutic process where the essential emotional experience is broken into smaller parts. Shasta Daisy enables the Self to re-integrate and re-pattern the emotional life into new wholeness and self-identity. Shasta Daisy helps the soul become more capable of archetypal or wholistic consciousness, stimulating great forces of intelligence and insight into life experience.',
  ARRAY['Awareness', 'Children', 'Community Life and Group Experience', 'Concentration and Focus', 'Creativity', 'Detail', 'Harmony', 'Healers', 'Healing Process', 'Home and Lifestyle', 'Insight', 'Inspiration', 'Intellectualism', 'Manifestation', 'Mental Clarity', 'Overview', 'Perspective', 'Scatteredness', 'Study', 'Synthesis', 'Thinking', 'Toner', 'Wisdom']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Shooting Star',
  'Dodecatheon hendersonii',
  'violet/pink',
  'Professional Kit',
  'Humanized spirituality, cosmic consciousness warmed with caring for all that is human and earthly',
  'Profound feeling of alienation, especially not feeling at home on Earth, nor a part of the human family',
  'Shooting Star is a very special remedy for those souls who hold back from full participation in earthly life. They may have waited for a long period of time before seeking earthly incarnation, and may have sojourned in other cosmic dimensions which feel more familiar. These souls suffer in a profound way — an affliction which often receives little understanding from family or friends, or even from therapists. Such persons have often been preoccupied, even from childhood, with stories of extra-terrestrial existence, and they may feel that they are actively in touch with such forms of life. It is common for these individuals to have birth trauma or complications, since the soul often hesitates or pulls back at the moment of contraction into matter. Shooting Star helps such persons to find their right connection to earthly life. Rather than feeling merely imprisoned in matter, the soul comes to experience its body as a vehicle for true self-containment and awareness. In this way such individuals come to understand the meaning of love, for love is experienced in a uniquely human way through that which streams freely from the self-aware human heart. At its deepest level. Shooting Star teaches such souls that the Earth is the right place to humanize one''s cosmic consciousness, for it is the place to learn about heart-impelled love.',
  ARRAY['Alienation', 'Ambivalence', 'Awkwardness', 'Body', 'Children', 'Choice', 'Earth Healing and Nature Awareness', 'Environment', 'Escapism', 'Groundedness', 'Inner Child', 'Intimacy', 'Involvement', 'Life Direction', 'Personal Relationships', 'Pregnancy', 'Rejection']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Snapdragon',
  'Antirrhinum majus',
  'yellow',
  'Research Kit',
  'Lively, dynamic energy; healthy libido; verbal communication which is emotionally balanced',
  'Verbal aggression and hostility; repressed or misdirected libido; tension around jaw',
  'The positive Snapdragon type possesses strong physical presence. Such persons are highly energetic, with powerful wills and libidos. In some cases, these energies are so pronounced that they override the other chakras of the body. In other instances, these forces may have been culturally repressed, causing the energy to be improperly released elsewhere in the body. With both these patterns of imbalance, the individual will misdirect digestive and sexual forces which rightly belong in the lower energy centers, distorting them through expression in the communication center. The spoken word is misused in a harsh or destructive way, with the tendency toward biting sarcasm or lashing criticism. There can be extreme tension in the jaw and mouth, grinding of the teeth, or the need to eat foods which provide continuous biting, crunching, and chewing activity. Snapdragon helps such persons re-direct their powerful metabolic and sexual energy into its rightful channels. At its deepest level, the Snapdragon helps the soul to distinguish its use of creative forces — especially those which radiate from the lower energy centers, and those which are used for the spoken word. By harmonizing the relationship between these energy centers, the soul evolves in its use of creative power.',
  ARRAY['Abuse', 'Aggressiveness', 'Anger', 'Animals and Animal Care', 'Authority', 'Blame', 'Body', 'Communication', 'Community Life and Group Experience', 'Creativity', 'Criticism', 'Destructiveness', 'Eating Disorders', 'Feminine Consciousness', 'Hate', 'Honesty', 'Hostility', 'Instinctual Self', 'Irritability', 'Lower Self', 'Negativity', 'Personal Relationships', 'Power', 'Repression', 'Self-Aggrandizement', 'Self-Expression', 'Sexuality', 'Shadow Consciousness', 'Speaking', 'Strength', 'Tension', 'Will']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Star of Bethlehem',
  'Ornithogalum umbellatum',
  'white',
  'English Kit',
  'Bringing soothing, healing qualities, a sense of inner divinity',
  'Shock or trauma, either recent or from a past experience; need for comfort and reassurance from the spiritual world',
  'Star of Bethlehem is a deeply restorative remedy, with calm, soothing properties for people who have experienced shock or trauma. It is particularly helpful for individuals who have never adequately addressed a disturbance from the past. Such persons often seek to anesthetize this trauma in inappropriate ways, such as through drugs, occult ritual, or a numbing of awareness. There is a longing and seeking for a part of the Spiritual Self which seems inaccessible. The nervous system often becomes deadened, and the mental faculties are lacking in vibrancy and coherency. In some essential way, the personality is out of alignment with its higher components, and is stymied from full and vibrant functioning. Star of Bethlehem helps bring about this much-needed psychic and spiritual adjustment, although other therapeutic and counseling measures are often necessary to help the individual fully access the trauma and its causes. Star of Bethlehem is also one of the ingredients in the Five-Flower Formula indicated by Dr. Bach for broad-based emergency and first aid use.',
  ARRAY['Abuse', 'Addiction', 'Animals and Animal Care', 'Body', 'Calm', 'Children', 'Death and Dying', 'Emergency', 'Grief', 'Psychosomatic Illness', 'Sensitivity', 'Shock', 'Soothing', 'Stress']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Star Thistle',
  'Centaurea solstitialis',
  'yellow',
  'Professional Kit',
  'Generous and inclusive, a giving and sharing nature, feeling an inner sense of abundance',
  'Basing actions on a fear of lack, inability to give freely and openly, or to trust a higher providence',
  'Star Thistle addresses the capacity for generosity and sharing in the human soul. It is particularly indicated for "fear of lack," or the feeling that there is not enough. Such persons are malnourished at a deep level. There is often a disturbance in the bond with the mother, which is transferred as an unhealthy bond to matter (the Latin word mater means mother). Such persons seek to establish a matrix of security for the essential Self by gaining firm hold of the material world, with a tendency to hoard and carefully guard their material possessions. This state of consciousness can be present whether the individual is outwardly wealthy or poor. The Star Thistle type is often socially reclusive or antipathetic, having a difficult time learning to trust, or to share his/her Self or resources in an open, generous way. They are susceptible to premature physical aging, especially hardening or sclerotic diseases or disturbances in the liver. Despite possible wealth or status, such persons are often lonely at their deepest core, and feel profoundly unnourished and unfulfilled. Star Thistle helps such souls to feel more secure within themselves and therefore less dependent on external things. As the soul feels fuller, it learns to open itself, and to share and give more freely. The Star Thistle teaches that it is through giving that one finds inner nourishment, and through the sharing of the Self that one becomes richer and more abundantly "full"-filled.',
  ARRAY['Community Life and Group Experience', 'Cynicism', 'Fear', 'Greed', 'Insecurity', 'Materialism and Money', 'Morality', 'Mother and Mothering', 'Personal Relationships', 'Possessiveness', 'Resistance', 'Selfishness', 'Sharing']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Star Tulip (also known as Cat''s Ears)',
  'Calochortus tolmiei',
  'white/purple',
  'Professional Kit and Seven Herbs Kit',
  'Sensitive and receptive attunement; serene, inner listening to others and to higher worlds, especially in dreams and meditation',
  'Feelings of being hardened or cut-off, inability to feel quiet inner presence or attunement, unable to meditate or pray',
  'Star Tulip is an exquisite remedy for gently opening and expanding the life of the soul. It can be characterized as a "listening" remedy, helping the soul to become more aware of subtle influences, or of guidance from higher realms. This remedy is very beneficial for those who feel unable to contact their Higher Self, or who feel they cannot meditate or pray effectively. Star Tulip has a strong relationship to the "anima," or inner feminine. It is an excellent remedy for men who have denied their softer, more receptive side, or for women who may have built a shell of protection around themselves. Star Tulip opehs and sensitizes the soul, making it more aware of its connection to higher worlds. It enhances dreaming, prayer, meditation, and all intuitive capacities. It is an important essence for the beginning stages of the therapeutic process, helping to open and "soften" the emotional life, enabling the individual to recognize and retrieve important information about the inner healing process. At its deepest expression, Star Tulip builds a chalice-like vessel in the human soul, creating the capacity to receive and contain higher thought and inspiration.',
  ARRAY['Addiction', 'Aging', 'Awareness', 'Barriers', 'Clarity', 'Creativity', 'Death and Dying', 'Denial', 'Dreams and Sleep', 'Dullness', 'Environment', 'Feminine Consciousness', 'Grace', 'Hardness', 'Harmony', 'Home and Lifestyle', 'Insight', 'Inspiration', 'Intimacy', 'Listening', 'Masculine Consciousness', 'Massage', 'Meditation', 'Mother and Mothering', 'Pregnancy', 'Purification', 'Quiet', 'Receptivity', 'Resistance', 'Sensitivity', 'Softness', 'Soulfulness', 'Spiritual Emergency or Opening', 'Toner', 'Wisdom']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Sticky Monkeyflower',
  'Mimulus aurantiacus',
  'orange',
  'Professional Kit',
  'Balanced integration of human warmth and sexual intimacy; ability to express deep feelings of love and connectedness, especially in sexual relationships',
  'Repressed sexual feelings, or acting out inappropriate sexual behavior; inability to experience human warmth in sexual experiences; deep fear of sexuality and intimacy',
  'Through human sexuality one can come in deepest contact with another human being. The strongest soul ecstasy is afforded through such communion, but also the most painful soul illness. This distortion and suffering is especially pronounced in our modern society. That which is most profound is often the most profaned; indeed, human sexuality is publicized, commercialized, and exploited in every possible manner. Sticky Monkeyflower heals those who are challenged in their efforts to understand and affirm their true sexuality. Such persons have a deep fear of intimacy and human contact, sometimes avoiding relationships altogether. Often, they mask their fear by over-compensation, choosing numerous superficial sexual relationships which do not really engage full-hearted participation or emotional vulnerability. Such souls, at their very core, fear exposure of the Self to another human being. Thus, the expression of sexuality is often shallow or devoid of real presence. Sticky Monkeyflower helps such souls come in contact with the true feelings of the Self, and especially the relationship of sexual impulses and desires to the authentic emotions of the heart. When the soul honors this true Self, it is guided by the warmest impulses of love and compassion in its expression of human sexuality.',
  ARRAY['Adolescence', 'Awkwardness', 'Desire', 'Escapism', 'Fear', 'Inadequacy', 'Instinctual Self', 'Intimacy', 'Loneliness', 'Masculine Consciousness', 'Menopause', 'Obsession', 'Personal Relationships', 'Rejection', 'Repression', 'Sexuality', 'Warmth']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Sunflower',
  'Helianthus annuus',
  'yellow',
  'Professional Kit',
  'Balanced sense of individuality, spiritualized ego forces, sun-radiant personality',
  'Distorted sense of Self; inflation or self-effacement, low self-esteem or arrogance; poor relation to father or masculine aspect of Self',
  'The healthy Self shines forth from the soul, not unlike the sun which shines in the sky. This benign and wondrous soul quality of radiance at once inspires with its light, and heals with its warmth. All human souls have within them this capacity to shine like the sun, but many are afflicted in their ability to emanate this solar power in a balanced way. Some people mask their true sun-nature with feelings of self-effacement and low self-esteem. This condition darkens the true luster of the Self; in these instances the Sunflower essence brings to the soul the quality of light. Others want their brilliance to shine too strongly, glaring others with pompous self-glory and ego-aggrandizement. For these people. Sunflower brings out the quality of warmth, or loving compassion. Just as the soul absorbs from the mother the moon-like qualities of receptivity and nurturing, so does the soul learn from the father the sun-like qualities of the shining, expressive Self. Sunflower heals disturbances or distortions in the soul''s relationship to the masculine, often associated with a conflicted or deficient relationship with the father in childhood. This healing of the masculine Self is equally important for both men and women. The message of the Sunflower is so universal and foundational that it is beneficial at nearly every stage in the human life cycle. When the soul learns how to harness this great sun force within its Self, it is truly able to bless and heal other human beings and the Earth.',
  ARRAY['Action', 'Addiction', 'Adolescence', 'Aggressiveness', 'Alienation', 'Authority', 'Balance', 'Children', 'Co-Dependence', 'Compassion', 'Confidence', 'Conflict', 'Death and Dying', 'Egotism', 'False Persona', 'Father and Fathering', 'Feminine Consciousness', 'Healers', 'Healing Process', 'Inadequacy', 'Individuality', 'Inner Child', 'Leadership', 'Masculine Consciousness', 'Materialism and Money', 'Personal Relationships', 'Power', 'Pride', 'Self-Acceptance', 'Self-Actualization', 'Self-Aggrandizement', 'Self-Effacement', 'Self-Esteem', 'Self-Expression', 'Speaking', 'Strength', 'Transcendence']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Sweet Chestnut',
  'Castanea sativa',
  'green f./yellow m.',
  'English Kit',
  'Deep courage and faith which comes from knowing and trusting the spiritual world',
  'Strong despair and anguish; experiencing the "dark night of the soul"',
  'Sweet Chestnut heals the deepest form of soul anguish and despair — that which is often referred to as the "dark night of the soul." The conditions which require Sweet Chestnut are extreme, and the individual is often in the most negative and acute form of suffering; however, this remedy is the harbinger of great spiritual transformation. The one who needs Sweet Chestnut is tested literally to the breaking point of endurance. Although the cause of such pain is based on a deeply personal situation, there is nevertheless a profound existential quality related to this state, for the soul feels utterly alone in its suffering. Sweet Chestnut is often indicated in drug addiction or suicide therapy, when the individual feels that he or she has hit "rock bottom." It can be indicated for many other extreme conditions, such as the death of a loved one or realization that one has a life-threatening illness. Through these forms of intense suffering, the Self surrenders to a Higher Power and is able to be reborn. It is precisely in this way that transformational healing is possible, for when the soul is stretched to its limits it also becomes transcendent. Sweet Chestnut helps the soul surrender and open to a new spiritual identity.',
  ARRAY['Abandonment', 'Abuse', 'Brokenheartedness', 'Challenge', 'Darkness', 'Death and Dying', 'Depression and Despair', 'Faith', 'Loneliness', 'Martyrdom', 'Mid-Life Crisis', 'Rejection', 'Spiritual Emergency or Opening', 'Surrender', 'Transcendence']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Sweet Pea',
  'Lathyrus latifolius',
  'red-purple',
  'Professional Kit',
  'Commitment to community, social connectedness, a sense of one''s place on Earth',
  'Wandering, seeking, inability to form bonds with social community or to find one''s place on Earth',
  'Many souls are like pilgrims, searching and seeking for their place on Earth. When this condition is overemphasized, the individual is lost in wanderlust, unable to form true social bonds of caring and commitment. Such people move from one place to another, or from one community of friends to another, without becoming truly involved. They become hardened in their stance as "outsiders," and are deprived of true soul growth by being unable to establish roots in family or community life. At the heart of the suffering of one who needs Sweet Pea is a deep feeling of homelessness. Such persons do not have within themselves "a sense of place," or love for the Earth. This alienation can come from the experience of literal homelessness, or for those who were required to move a great deal during childhood. This imbalance is also related to urban and suburban living conditions — high-rise apartment complexes, urban ghettos, or anemic suburban developments — which rob the soul of its natural feeling of interest and connection to the Earth and the forces of Nature. The Sweet Pea helps such persons to come in contact with their feelings about "home." By acknowledging and experiencing this pain which has numbed the Self, the soul can begin to heal, and find its true connection to the Earth and to other human beings.',
  ARRAY['Abandonment', 'Adolescence', 'Alienation', 'Community Life and Group Experience', 'Conflict', 'Earth Healing and Nature Awareness', 'Environment', 'Escapism', 'Father and Fathering', 'Fear', 'Groundedness', 'Home and Lifestyle', 'Involvement', 'Life Direction', 'Loneliness', 'Personal Relationships', 'Rejection', 'Scatteredness', 'Seeking']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Tansy',
  'Tanacetum vulgare',
  'yellow',
  'Professional Kit',
  'Decisive and goal-oriented, deliberate and purposeful in action, self-directed',
  'Lethargy, procrastination, inability to take straightforward action; habits which undermine or subvert real intention of Self',
  'Tansy flower essence addresses the consciousness of the Self in a very special way. Those who need this remedy exhibit a great deal of sluggish, lethargic energy; they are very often indecisive, tend to procrastinate when making decisions or commitments, and appear lazy, indifferent, or nonchalant. Although their will forces are indeed stymied, it is usually ineffective to treat the will, or physical energy level of such persons directly. Healing insight comes through understanding why such persons hold back the real expression of their Self. This soul type responds to intense overwhelm, excitement, or any feeling of pressure or tension by withdrawing and restricting physical energy. Sometimes this is a temporary response to current life situations, but generally speaking one will find this way of handling energy to be a deeply unconscious and ingrained pattern which is associated with family and early childhood trauma. Such persons have been exposed to a great deal of chaos, confusion, emotional instability, or even violence, and have learned to suppress their natural response to situations as a way of keeping peace, or avoiding further emotional overwhelm. They energetically "downshift" as an avoidance mechanism for emotional distancing and coping. Tansy stimulates the self-awareness of such persons, helping them to contact their true strength and purpose. In this way, such souls become more decisive and straightforward in their response to others and to life, and come to realize more fully their true Self.',
  ARRAY['Action', 'Aloofness', 'Apathy', 'Body', 'Breakthrough', 'Catalyst', 'Co-Dependence', 'Decisiveness', 'Desire', 'Eating Disorders', 'Energetic Patterns', 'Hesitation', 'Home and Lifestyle', 'Immobility', 'Indecision', 'Inertia', 'Manifestation', 'Motivation', 'Procrastination', 'Repression', 'Resistance', 'Self-Actualization', 'Sluggishness', 'Time Relationship', 'Will', 'Work and Career Goals']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Tiger Lily',
  'Lilium humboldtii',
  'orange/brown spots',
  'Professional Kit',
  'Cooperative service with others, extending feminine forces into social situations; inner peace and harmony as a foundation for outer relationships',
  'Overly aggressive, competitive, hostile attitude; excessive "yang" forces, separatist tendencies',
  'The positive healing of ourselves and the larger world depends very much on the ability to shift from competitive, aggressive models of behavior to those which are cooperative and inclusive. This transition of consciousness involves the internalization of feminine values in the larger culture, especially in business and politics. Tiger Lily is an extremely beneficial remedy for helping the soul to transmute overly hostile or aggressive tendencies into positive social impulses. It helps the consciousness to move from a limited personal perspective toward values that include the greater whole. This essence especially benefits those who see themselves as separate from others, or as striving against others rather than working for the common good. In general, Tiger Lily balances overly yang, contracted energy, and is very helpful for many men who have not fully integrated the inner feminine (anima) part of themselves. Tiger Lily is also indicated for women who are addressing issues of the inner masculine (animus), and is particularly valuable at the time of menopause when more masculine energy is available to the consciousness. While Tiger Lily is broadly associated with feminine energy, it is uniquely related to the strength of the feminine forces, or the ability of the feminine Self to work actively within yang or masculine structures or contexts. The Tiger Lily helps the human soul to harness its essential power and strength in the service of higher good and world evolution.',
  ARRAY['Aggressiveness', 'Altruism', 'Ambition', 'Animals and Animal Care', 'City', 'Lfe', 'Community Life and Group Experience', 'Competitiveness', 'Cooperation', 'Earth Healing and Nature Awareness', 'Feminine Consciousness', 'Hostility', 'Instinctual Self', 'Leadership', 'Lower Self', 'Masculine Consciousness', 'Materialism and Money', 'Menopause', 'Personal Relationships', 'Power', 'Service']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Trillium',
  'Trillium chloropetalum',
  'purple',
  'Professional Kit',
  'Selfless service, altruistic sacrifice of personal desires for the common good, inner purity',
  'Greed and lust for possessions and power; excessive ambition, overcome with personal needs and desires; materialism and congestion',
  'Trillium flower essence is a very effective cleanser and balancer for the lowest human energy center, referred to as the survival (base) chakra. A person needing Trillium has a disproportionate amount of energy directed toward issues of personal power or welfare. This excessive concern for personal well-being ovemdes other, more altruistic feelings within the sod. Such a person easily falls prey to the forces of materialism and greed, feeling a need for many possessions and other forms of material wealth and power. This remedy can also be indicated for one who is in poverty, but believes that acquisition of wealth and power would bring fulfillment. This soul imbalance can also be reflected in the body, especially when the body retains too much matter and does not effectively eliminate toxic waste. At the deepest level, such souls are disconnected from their spiritual strength; they seek to overcome an unconscious feeling of impotence by the exercise of social and material power. Because their awareness is limited to the physical plane, such souls can measure their self-worth only by material standards. Trillium encourages these individuals to shift their awareness to a transpersonal level, to derive a sense of personal well-being from a relationship to a Higher Power. Once the forces contained in the lowest chakra are purified and freed, such persons have great capacity to ground and harness spiritual forces in the service of others and of the Earth.',
  ARRAY['Aggressiveness', 'Altruism', 'Ambition', 'Attachment', 'Competitiveness', 'Cooperation', 'Desire', 'Envy', 'Greed', 'Instinctual Self', 'Involvement', 'Lower Self', 'Masculine Consciousness', 'Materialism and Money', 'Mid-Life Crisis', 'Morality', 'Non-Attachment', 'Overview', 'Personal Relationships', 'Possessiveness', 'Power', 'Self-Aggrandizement', 'Selfishness', 'Service', 'Sharing', 'Will', 'Work and Career Goals']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Trumpet Vine',
  'Campsis tagliabuana',
  'red-orange',
  'Professional Kit',
  'Articulate and colorful in verbal expression; active, dynamic projection of oneself in social situations',
  'Lack of vitality or soul force in expression; inability to be assertive or to speak clearly, impediments in speech Confidence',
  'The capacity for human speech — to ensoul sound with thought and feeling — is one of the most extraordinary of human gifts. Yet for many souls, the ability to use the word as a creative force is stymied. Trumpet Vine flower essence is indicated for speech which tends to be mechanical, dull, or constricted, and can be very helpful for various speech impediments such as stuttering. It does not directly address fear or nervousness, but is nevertheless beneficial for many people who curtail their expression due to feelings of intimidation or shyness. With the help of Trumpet Vine, the soul is able to contact life energy residing in the lower chakras and to integrate these vital forces with the spoken word. Awareness and interest is brought to the expression itself, rather than focusing on the perception or Judgment of others. Trumpet Vine awakens the warm and colorful feeling life of the soul, helping these qualities flow into the human speech. As the soul learns to project and express itself, it grows in its creative capacity to share its unique essence with others, and with the world.',
  ARRAY['Aggressiveness', 'Anxiety', 'Children', 'Communication', 'Creativity', 'Dryness', 'Freedom', 'Leadership', 'Learning Difficulties', 'Manifestation', 'Self-Esteem', 'Self-Expression', 'Speaking', 'Vitality']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Vervain',
  'Verbena officinalis',
  'pink/mauve',
  'English Kit',
  'Ability to practice moderation, tolerance, and balance; "the middle way;" grounded idealism',
  'Overbearing or intolerant behavior; overenthusiasm or extreme fanaticism; nervous exhaustion from overstriving',
  'Vervain soul types naturally possesses strong forces of passionate idealism. They give themselves fully and completely to the work or cause in which they believe. However, they can become so convinced of the rightness and urgency of their beliefs that their natural charismatic capacities degenerate into those of the zealot or fanatic. Their true leadership ability is afflicted, for the Vervain type''s incredible intensity can overwhelm and prevent others from making their own energetic connection to the project or cause which is being promoted. Such an individual can be characterized as possessing not only great intensity but also great physical tension, which results in many nervous and digestive problems, and in extreme cases may lead to nervous breakdown. These persons are usually unaware of their true energy levels, and often push their bodies completely beyond their natural capacities. In fact, there is very little connection to the physical body or to the physical world, because this type lives so fervently in the world of ideas and ideals. Vervain is particularly an embodiment remedy, helping the soul to center and ground its tremendous enthusiasm. In this way, the body becomes a natural regulator and harmonizer for the abundant spiritual forces which pour out of such a person. When the fiery light of Vervain radiates through the medium of the body and the physical world, it becomes more luminous and contained. Such soul ardor is able to inspire, lead, and heal others.',
  ARRAY['Animals and Animal Care', 'Balance', 'Body', 'Certainty', 'Enthusiasm', 'Exhaustion and Fatigue', 'Fanaticism', 'Grace', 'Grouncledness', 'Idealism', 'Influence', 'Leadership', 'Moderation', 'Nervousness', 'Obsession', 'Perfectionism', 'Prejudice', 'Relaxation', 'Seriousness', 'Speaking', 'Stress', 'Tension', 'Tolerance', 'Will']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Vine',
  'Vitis vinifera',
  'green',
  'English Kit',
  'Selfless service, tolerance for the individuality of others',
  'Domineering, tyrannical, forcing one''s will on others',
  'The Vine personality possesses a strong will, with considerable power and force for leadership and organizational tasks. However, when these will forces are not aligned with the true Higher Self, they become selfish instead of selfless. The Vine soul type tends to impose its will on others, rather than leading them to their own power and self-awareness. The compulsive need to be in control creates a personality that is authoritative, domineering, tyrannical, and at its extreme, sadistic. The spiritual lesson for such an individual is contained in the words of Christ, "I am the Vine and ye are the branches." When the Vine soul type shifts identification from the lower willful self to the Higher Self, he or she learns that the essence of true leadership is not the ability to demand obedience from others, but rather inner obedience and devotion to a higher spiritual authority. The Vine essence helps such a soul to acquire true humility by realizing that spiritual senrice is the essence of authentic leadership. When such a soul shifts its archetypal consciousness from that of a king who rules to that of a shepherd who serves, the will forces become spiritualized and truly able to do good for others and for the Earth.',
  ARRAY['Abuse', 'Aggressiveness', 'Ambition', 'Animals and Animal Care', 'Authority', 'Children', 'Community Life and Group Experience', 'Earth Healing and Nature Awareness', 'Egotism', 'Fanaticism', 'Father and Fathering', 'Greed', 'Influence', 'Leadership', 'Lower Self', 'Masculine Consciousness', 'Materialism and Money', 'Morality', 'Perfectionism', 'Power', 'Prejudice', 'Repression', 'Self-Aggrandizement', 'Service', 'Shadow Consciousness', 'Tolerance', 'Will', 'Work and Career Goals']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Violet',
  'Viola odorata',
  'violet-blue',
  'Professional Kit',
  'Delicate, highly perceptive sensitivity, elevated spiritual perspective; sharing with others while remaining true to oneself',
  'Profound shyness, reserve, aloofness, fear of being submerged in groups',
  'The soul forces of the Violet type are highly refined, full of exquisite yet delicate sweetness. Such persons long to share themselves with others, but usually hold back due to a feeling of fragility in group situations, and fear that their sense of Self will be lost or submerged. Such a type often gravitates to a lifestyle or occupation where work is done silently and alone. The Violet personality inwardly feels a great deal of warmth, but he/she appears cool and aloof to others; even the body and especially the hands may be moist and cool. Although such persons may find a few others who are able to understand and accept their shyness, they suffer great feelings of loneliness, for they would like to share more of themselves than they actually do. The key to their unfoldment lies in being able to trust the warmth of others. Like the Violet flower, whose essential fragrance cannot be detected until the sun shines upon it and the air wafts it upward, so the Violet type must learn to let its essence flow into others. Violet flower essence helps such souls shift their awareness from fear of losing the Self, to trust that the Self will be warmed and revealed by others, so that their beautiful soul nature may be shared with the world.',
  ARRAY['Alienation', 'Aloofness', 'Ambivalence', 'Awkwardness', 'Children', 'Communication', 'Community Life and Group Experience', 'Escapism', 'Fear', 'Individuality', 'Intimacy', 'Involvement', 'Loneliness', 'Personal Relationships', 'Receptivity', 'Self-Effacement', 'Self-Expression', 'Sharing', 'Shyness']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Walnut',
  'Juglans regia',
  'green',
  'English Kit',
  'Freedom from limiting influences, making healthy transitions in life, courage to follow one''s own path and destiny',
  'Overly influenced by the beliefs and values of family or community, or by past experiences',
  'The human soul is akin to the plant in its patterns of growth. It grows slowly, almost imperceptibly from day to day, but there are moments when it makes radical, metamorphic changes, moving beyond its current form to something utterly new. Thus the plant transforms from root, to shoot, to leaf, to flower, to fruit, to seed. Walnut flower essence is an important remedy for times of great life transition; it assists the soul in making metamorphic change. It is indicated for those life passages when the Self must be completely and irrevocably transformed in order to continue its evolution. At these moments, the soul must be unwavering in its sense of inner purpose and conviction. If the mind experiences doubt or confusion, the progress of the Self is impeded, if not imperiled. Walnut is particularly helpful for those who may be easily influenced by family ties, community mores, social conventions, strong personalities, or past habits, and who are unable to muster the strength to make a break with the past and with the ideas of others. It is especially powerful in the mental field, helping to dispel any enchantment, illusion, or spell which may bind the soul to the past. This remedy can be broadly applied and is valuable for all life transitions including birth and death, moving, career changes, and ending or beginning relationships. Walnut helps the soul to perceive and follow its true Star of Destiny.',
  ARRAY['Adolescence', 'Animals and Animal Care', 'Authority', 'Barriers', 'Breakthrough', 'Co-Dependence', 'Concentration and Focus', 'Death and Dying', 'Desire', 'Dutifulness', 'Eating Disorders', 'Escapism', 'Freedom', 'Habit Patterns', 'Healing Process', 'Home and Lifestyle', 'Immune Disturbances', 'Influence', 'Life Direction', 'Manifestation', 'Mid-Life Crisis', 'Pregnancy', 'Prejudice', 'Protection', 'Sensitivity', 'Strength', 'Transition', 'True to Self']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Water Violet',
  'Hottonia palustris',
  'pale mauve, yellow center',
  'English Kit',
  'Sharing one''s gifts with others, appreciation of social relationships',
  'Aloof, withdrawn, disdainful of social relationships',
  'The Water Violet personality is generally very quiet and self-contained, with soul qualities of gracefulness and equanimity. Their sedate, calm manner enables them to handle many different occupational and life situations in a very capable manner. However, it is difficult to know such persons well, or to feel a warm and personable connection with them. Such persons often appear distant or aloof; more extreme types seem proud, haughty, or arrogant. They may become involved in community affairs, but only in accordance with their professional standing. Many such souls have chosen to be born into families of wealth and social prominence, and they are well-cultured and educated. But even among Water Violet types without this obvious upper-class background, one feels a quality which sets such a person apart; the soul conducts itself with great dignity and refinement. It has no need to draw attention to itself, but neither does it seem to have much need to give of itself to others. Many such souls are in fact highly evolved, or they may be strongly influenced by the subconscious memory of a prominent past life. Such individuals are blocked in their further evolution until they realize that the Self can evolve only so far as a separate identity. The true spiritual Self must expand to include all of humanity. Water Violet helps such souls make a transition to a more inclusive state of consciousness, one that helps them experience a compassionate and joyful connection to the human family.',
  ARRAY['Alienation', 'Aloofness', 'Avoidance', 'Barriers', 'Communication', 'Community Life and Group Experience', 'Compassion', 'Egotism', 'Escapism', 'Intimacy', 'Involvement', 'Perfectionism', 'Personal Relationships', 'Prejudice', 'Pride', 'Resistance', 'Selfishness', 'Service', 'Sharing', 'Shyness']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'White Chestnut (also known as Horse Chestnut)',
  'Aesculus hippocastanum',
  'white with pink, red and yellow centers',
  'English Kit',
  'Inner quiet; calm, clear mind',
  'Worrisome, repetitive thoughts, chattering mind',
  'White Chestnut flower essence is indicated for those who suffer from extreme mental agitation. Their thinking life is not free, but is highly compulsive and obsessive. The life energy is drained through excessive worry and anxiety, which is not directed outward toward others but is kept inside through a constant churning of the mind. Daily events, conversations, or other life episodes are continually replayed and analyzed, imprisoning the soul within the mental field. Such persons may suffer from insomnia, headaches, and other neurological disorders. They will often become addicted to sleeping pills, tranquilizers, aspirin, or other painkillers in an effort to subdue the mental pain and tension which they feel. White Chestnut helps such persons regain mental repose and inner peace. It redirects the extreme congestion of energy in the mental field, helping the individual to gain more awareness in the feeling life, especially in the solar plexus and in the heart. When these energy centers are re-balanced, the feelings are able to be processed before they become churning thoughts. White Chestnut frees the mental life for the calm, clear, and spacious activity of the Higher Mind.',
  ARRAY['Aging', 'Calm', 'Children', 'Clarity', 'Concentration and Focus', 'Dreams and Sleep', 'Exhaustion and Fatigue', 'Inertia', 'Insomnia', 'Meditation', 'Obsession', 'Quiet', 'Relaxation', 'Release', 'Restlessness', 'Speaking', 'Thinking']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Wild Oat',
  'Bromus ramosus',
  'green',
  'English Kit',
  'Work as an expression of inner calling; outward life which expresses one''s true goals and values; work experiences motivated by an inner sense of life purpose',
  'Confusion and indecision about life direction; trying many activities but chronically dissatisfied, lack of commitment or focus',
  'Soul health and happiness are very much dependent on the ability to realize one''s true life purpose and vocation. If the soul does not have the opportunity to evolve and to serve through its basic life work, it will suffer great distress. By these standards, we can appreciate the depth of sickness in our modern, technological world. Many people are unknowingly enslaved to the forces of materialism, for their primary motivation to work is a monetary one (whether they make much or little money). This situation drastically drains the soul''s true vitality; evenings, weekends, and holidays are spent simply recuperating or escaping from alienating or exploitative work situations. Dr. Bach recognized this fundamental soul ailment, and considered Wild Oat, along with Holly, to be one of the two basic remedies in his system. It is not improper to think of Wild Oat as relating to a particular type of person: one who is restless and seeking, who tries many jobs but is unable to commit to a true vocation. Indeed, many young people, or those experiencing mid-life crisis, have an acute need for this remedy. However, it is also important to regard Wild Oat as a broadly applicable polychrest, helping to transform the basic cultural illness of our age. Wild Oat helps the individual to recognize and respond to his/her true life calling, seeking forms of work that give the Self a sense of higher purpose and meaning, and the ability to truly serve and help others. Flouvr EowriCf',
  ARRAY['Adolescence', 'Certainty', 'Choice', 'Clarity', 'Concentration and Focus', 'Conflict', 'Decisiveness', 'Depression and Despair', 'Desire', 'Escapism', 'Freedom', 'Immobility', 'Indecision', 'Life Direction', 'Manifestation', 'Masculine Consciousness', 'Restlessness', 'Scatteredness', 'Seeking', 'Self-Actualization', 'Seriousness', 'Work and Career Goals']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Wild Rose (also known as Dog Rose)',
  'Rosa canina',
  'pink or white',
  'English Kit',
  'Will to live, joy in life',
  'Resignation, lack of hope, giving up on life; lingering illness',
  'The Wild Rose essence first developed by Dr. Bach addresses broad and important soul themes of motivation and interest in the world and in others. In this way, it is similar to the California Wild Rose. However, this English Rose specifically addresses the type of resignation in the soul which depletes one''s vitality. Physical incarnation in a body is an experience fraught with difficulty and struggle, and for the Wild Rose personality the effort hardly seems worth making. Such apathy suppresses the soul''s interest in life, and cuts off the individual from his or her inner sources of healing. This essence is very helpful for those who linger in long, drawn-out illness, and who seem to recover only fitfully and slowly. Wild Rose restores the vital forces of the soul, particularly its connection to the physical body and to the physical world, helping the individual regain an interest in earthly life. This essence teaches that life is a sacred and precious opportunity which the soul must make every effort to embrace, if it is to find the true meaning of love and physical incarnation.',
  ARRAY['Animals and Animal Care', 'Apathy', 'Challenge', 'Children', 'Depression and Despair', 'Exhaustion and Fatigue', 'Grief', 'Healing Process', 'Psychosomatic Illness', 'Surrender', 'Vitality', 'Will']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Willow',
  'Salix vitellina',
  'green',
  'English Kit',
  'Acceptance, forgiveness, taking responsibility for one''s life situation, flowing with life',
  'Feeling resentful, inflexible or bitter; feeling that life is unfair or that one is a victim',
  'If the physical body does not keep flexible, it becomes stiff and contracted. The good health of the soul also depends on its ability to be yielding, flowing, and "for-giving." The Willow flower heals bitterness and resentment; it is for those who tend to "hold on" and become attached to negative emotions. Such persons often feel victimized by the circumstances of life — they feel that others are to blame for their misfortune; that life has been unfair to them; or they resent those who appear to have more status, prosperity, or felicity than themselves. The aging process is especially difficult for Willow types. At an energetic level, such persons are unable to flow with the streaming of their lives. Negative feelings are dammed up and then become magnified and internalized, congesting the inner being. The physical body also suffers from this stress, tending to manifest such problems as stiff joints, rheumatism, arthritis, and other aches and pains. (It is interesting to note that Willow bark is the herbal precursor of aspirin, and is used particularly for such physical conditions.) Willow restores a more "spring-like" disposition, helping the soul to respond with greater resilience and inward mobility to challenges and problems. In this way the Self takes more responsibility for its condition, and learns to flow more gently and graciously with, rather than against, the flow of life.',
  ARRAY['Adolescence', 'Aging', 'Anger', 'Blame', 'Catharsis', 'Co-Dependence', 'Community Life and Group Experience', 'Cynicism', 'Death and Dying', 'Denial', 'Dislike', 'Feminine Consciousness', 'Flexibility', 'Forgiveness', 'Hate', 'Inner Child', 'irritability', 'Martyrdom', 'Negativity', 'Perfectionism', 'Rejection', 'Resentment', 'Responsibility', 'Tolerance']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Yarrow',
  'Achillea millefolium',
  'white',
  'Professional Kit',
  'Inner radiance and strength of aura, compassionate awareness, inclusive sensitivity, beneficent healing forces',
  'Extreme vulnerability to others and to the environment; easily depleted, overly absorbent of negative influences, psychic toxicity',
  'As the soul becomes more spiritually open, it necessarily becomes more refined, sensitive, and absorbent. In the past, many of those on spiritual paths were removed and protected from the daily conditions of living, so that the soul could safely and harmoniously expand its boundaries. modern conditions require that the path of spiritualization be connected to the physical world and to practical responsibilities. In this way, the light of the spirit is brought through the human soul right into the Earth as a healing force. Yarrow is a very important and highly beneficial remedy to harmonize this process. Those who typically need this remedy are easily affected by their surroundings, and can be prone to many forms of environmental illness, allergies, or psychosomatic diseases. Such persons have an extraordinary capacity for healing, counseling, or teaching, because they are readily able to receive psychic information and to understand the pain and suffering of others. At the same time they are easily depleted, and are quite vulnerable to the thoughts or negative intentions of others. Yarrow literally "knits together" the overly porous aura of such an individual so that it does not "bleed" so excessively into its en\rironment. Furthermore, it helps such a person re-balance and stabilize the abundant light which radiates in the upper energy centers, directing it into the lower centers so that the Self has more vitality and solidity. Yarrow flower essence has nearly universal application, and should be considered in many formulas for the profound soul shifts of our age. Yarrow bestows a shining shield of Light which protects and unifies the essential Self, allowing compassionate healing qualities to flow freely from one''s soul to others.',
  ARRAY['Children', 'City Life', 'Devitalization', 'Eating Disorders', 'Emergency', 'Energetic Patterns', 'Environment', 'Healers', 'Immune Disturbances', 'Irritability', 'Learning Difficulties', 'Lightness', 'Massage', 'Negativity', 'Pregnancy', 'Protection', 'Sensitivity', 'Spiritual Emergency or Opening', 'Strength', 'Stress', 'Toner', 'True to Self', 'Vulnerability']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Yarrow Special Formula',
  'Achillea millefolium (in a sea salt water base)',
  'white',
  'Research essence',
  'Enhancing integrity of etheric body, of vital formative forces',
  'Disturbance of life-force and vitality by noxious radiation, pollution, or other geopathic stress; residual effects of past exposure',
  'The very existence of our planet and the human species is threatened by the awesome and destructive force of nuclear weaponry and the extreme toxicity of nuclear waste. Nuclear energy is released through a process which directly attacks the "formative," or etheric qualities of matter, so that matter itself is literally "dis-integrated." This is distinguished from natural chemical processes, which transform matter but retain the essential quality of each element (e.g., forms of oxidation such as burning, rusting, or digestion). Nuclear reactions destroy the very integrity of the chemical elements involved, producing highly poisonous waste products which continue to disintegrate and destroy life. In essence, nuclear radiation is a death-oriented expression of light and fire, which assaults the very core of matter and the natural basis of life. Yarrow Special Formula is indicated for exposure to nuclear radiation and other forms of noxious environmental or geopathic stress. It was originally developed in response to practitioner requests after the Chernobyl nuclear plant disaster in 1986. This remedy combines the remarkable light and fire processes of the Yarrow plant with the strong formative forces of potentized sea salt. By strengthening the etheric body with strong formative forces which can meet the harmful attack of radiation. Yarrow Special Formula directly counteracts the destructive effects of radiation on the human energy field. This remedy is indicated not only for obvious exposure to nuclear fallout, but also for the many ways in which nuclear radiation and other forms of aberrant and highly toxic energy infiltrate the modern world. Examples include video-display terminals. X-rays, radiation therapy, high-altitude radiation, detection devices at airport terminals, and invasive electromagnetic fields. Yarrow Special Formula is an immensely important remedy; it stands as a counter-shield to the destructive forces which threaten and plague human and planetary life, imparting powerful vitalizing and restorative properties.',
  ARRAY['City Life', 'Devitalization', 'Emergency', 'Energetic Patterns', 'Environment', 'Immune Disturbances', 'Negativity', 'Pregnancy', 'Protection', 'Sensitivity', 'Strength', 'Stress', 'Study', 'Vulnerability']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Yellow Star Tulip',
  'Calochortus monophyllus',
  'yellow',
  'Research Kit',
  'Empathy, receptivity to the feelings and experiences of others; acting from inner truth and guidance',
  'Insensitivity to the sufferings of others; lack of awareness of the consequences of one''s actions on others',
  'Yellow Star Tulip refines the soul life by developing one''s capacity for receptive and insightful social presence. It does not work inwardly on the Self as much as it helps the soul direct all that has been developed within the inner life to go outward as a gift for helping and healing others, or working with the forces of Nature. Yellow Star Tulip develops the soul quality of empathy, so that one can intuit and act upon the deeper meaning and message of other beings. This remedy especially sensitizes one to the suffering of others, for without empathetic presence one cannot become truly compassionate. It can sometimes act as a "karmic truth serum," so that one feels more intensely the results of one''s actions toward another. Yellow Star Tulip breaks down the dysfunctional and egotistical barriers of the Self, enabling one to make sensitive contact with others and truly learn from them. This remedy is particularly important for those involved in the healing and teaching professions, who need to expand and refine their empathetic qualities. Yellow Star Tulip can also be used more broadly for relationship healing, and for helping those who display more extreme soul states such as sociopathic tendencies. The essence of this delicately beautiful flower helps refine the sensitivity and awareness of the Self so that it becomes more actively responsible and truly compassionate and caring.',
  ARRAY['Community Life and Group Experience', 'Compassion', 'Creativity', 'Dullness', 'Earth Healing and Nature Awareness', 'Environment', 'Feminine Consciousness', 'Healers', 'Insight', 'Intimacy', 'Listening', 'Love', 'Materialism and Money', 'Morality', 'Mother and Mothering', 'Personal Relationships', 'Pregnancy', 'Receptivity', 'Selfishness', 'Sensitivity', 'Service', 'Softness', 'Soulfulness', 'Warmth']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Yerba Santa',
  'Eriodictyon californicum',
  'violet',
  'Professional Kit and Seven Herbs Kit',
  'Free-flowing emotion, ability to harmonize breathing with feeling; capacity to express a full range of human emotion, especially pain and sadness',
  'Constricted feelings, particularly in the chest; internalized grief and melancholy, deeply repressed emotions',
  'Yerba Santa (Spanish for "Holy Herb") addresses the inner sanctity of the human soul. There is within every human heart an inviolable space which must be kept open and free; the Self breathes its soul essence in and out from this center. This part of the human being is the most sensitive, the most deeply feeling, and the most psychic. It is especially vulnerable to emotions of sadness, grief, or other related soul pain. If such emotions are not actively addressed by the consciousness, they will be stored and buried away in this part of the heart. The individual becomes profoundly melancholic, bearing deep internalized sadness, which is not simply related to daily events, but which pervades and colors the entire emotional life. This soul illness grips the body. Most characteristically, the sacred part of the Self — the heart and chest area — becomes hollowed rather than hallowed. The breathing is congested and disturbed, resulting in the tendency toward degenerative diseases of the lungs such as chest congestion, pneumonia, asthma, tuberculosis, or addiction to tobacco. Such a person appears to be wasting away; quite literally the soul is being consumed by the intense forces of grief and sadness which work negatively into the Self. Yerba Santa reverses this soul consumption, promoting the release of trauma and emotional impurities. Often, the individual contacts profound unclaimed grief, such as the loss of a beloved friend or parent early in life. Yerba Santa gradually restores the temple space of the heart, making it more spacious and light-filled. Through this blessed flower, the soul re-establishes its sanctuary, freeing the human heart to experience the world with renewed emotional presence.',
  ARRAY['Awareness', 'Body', 'Brokenheartedness', 'Children', 'Cleansing', 'Depression and Despair', 'Exhaustion and Fatigue', 'Grief', 'Healing Process', 'Heart', 'Inner Child', 'Massage', 'Psychosomatic Illness', 'Release', 'Repression', 'Soulfulness', 'Strength', 'Tension', 'Toner']
)
ON CONFLICT (name, latin_name) DO NOTHING;

INSERT INTO herbal.flower_essence_plants
  (name, latin_name, color, kit, positive_qualities,
   patterns_of_imbalance, description, cross_references)
VALUES (
  'Zinnia',
  'Zinnia elegans',
  'red',
  'Professional Kit',
  'Childlike humor and playfulness; experiencing the joyful inner child, lightheartedness, detached perspective on Self',
  'Overseriousness, dullness, heaviness, lack of humor; overly somber sense of Self, repressed inner child',
  'Humor is uniquely human. Other forms of life certainly experience joy and delight, but humor requires the ability to step outside oneself, and not take oneself so seriously. It is the human being, with its pronounced sense of Self, who has developed and very much needs the soul quality of humor. The capacity to laugh at one''s self, or to be "light-hearted," is quite literally a necessary balance to the somber heaviness of self-consciousness. Zinnia is a most wonderful remedy for this state of soul, helping the Self to contact its inner child. Every child is born with the innate capacity to laugh and play, to enter into life with the full exuberance of the winged soul. The adult ego all too often stifles and suppresses this part of the Self. This remedy is clearly indicated for those who are overly grave and earnest, who take themselves and life too seriously, or who tend toward workaholism or other forms of unbalanced intensity. The message of the Zinnia is not that one''s life should be frivolous or irresponsible, but rather that qualities of playfulness and laughter can be brought to one''s work and daily responsibilities. Zinnia flower essence brings the soul quality of humor to one''s humanness, teaching that the soul who is in "good spirits" is truly on a balanced spiritual path.',
  ARRAY['Cheerfulness', 'Creativity', 'Devitalization', 'Dryness', 'Dullness', 'Dutifulness', 'Earth Healing and Nature Awareness', 'Enthusiasm', 'Father and Fathering', 'Healers', 'Home and Lifestyle', 'Inner Child', 'Intellectualism', 'Joy', 'Lightness', 'Masculine Consciousness', 'Materialism and Money', 'Menopause', 'Mother and Mothering', 'Seriousness', 'Spontaneity', 'Study', 'Time Relationship', 'Work and Career Goals']
)
ON CONFLICT (name, latin_name) DO NOTHING;


