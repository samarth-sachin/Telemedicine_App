import '../models/conversation_node.dart';

class RemediesDatabase {
  static final Map<String, Remedy> remedies = {
    'fever_simple_remedy': Remedy(
      id: 'fever_simple_remedy',
      title: 'Simple Fever',
      description: 'Common fever, usually resolves in 24-48 hours with rest and hydration.',
      category: 'Fever',
      homeRemedies: [
        '💧 Drink plenty of water and fluids (8-10 glasses per day)',
        '🛏️ Get adequate rest and sleep',
        '🧊 Apply cold compress on forehead',
        '🥣 Have light, easy-to-digest meals',
        '🌡️ Monitor temperature every 4-6 hours',
      ],
      medications: [
        '💊 Dolo 650 or Crocin 500mg',
        '💊 Take 1 tablet every 6-8 hours',
        '💊 Maximum 3 tablets per day',
      ],
      warnings: [
        '⚠️ If fever exceeds 102°F, consult doctor',
        '⚠️ If fever persists beyond 3 days, seek medical help',
        '⚠️ Watch for severe symptoms like difficulty breathing',
      ],
    ),
    'fever_viral_remedy': Remedy(
      id: 'fever_viral_remedy',
      title: 'Viral Fever with Body Ache',
      description: 'Viral infection causing fever and body pain.',
      category: 'Fever',
      homeRemedies: [
        '💧 Increase fluid intake - water, ORS, coconut water',
        '🛏️ Complete bed rest for 2-3 days',
        '🧊 Cold sponging to reduce fever',
        '🍵 Ginger tea or herbal tea',
        '🥣 Light diet - soup, porridge, fruits',
        '💪 Avoid physical exertion',
      ],
      medications: [
        '💊 Dolo 650 - 1 tablet every 8 hours',
        '💊 Limcee (Vitamin C) 500mg - Once daily',
        '💊 Combiflam if body ache is severe',
      ],
      warnings: [
        '⚠️ High fever (103°F+) - immediate doctor consultation',
        '⚠️ Persistent symptoms beyond 5 days - medical checkup needed',
      ],
      requiresDoctorVisit: false,
    ),
    'fever_prolonged_remedy': Remedy(
      id: 'fever_prolonged_remedy',
      title: '⚠️ Prolonged Fever - Doctor Consultation Required',
      description: 'Fever lasting more than 3 days needs professional medical evaluation.',
      category: 'Fever',
      homeRemedies: [
        '🚨 CONSULT A DOCTOR IMMEDIATELY',
        '💧 Stay hydrated until you see doctor',
        '🌡️ Keep fever diary (temperature + time)',
        '📝 Note all symptoms',
      ],
      medications: [
        'Take only doctor-prescribed medications',
      ],
      warnings: [
        '🚨 URGENT: See a doctor within 24 hours',
        '⚠️ Could indicate: Dengue, Typhoid, Malaria, or other infections',
        '⚠️ Blood test may be required',
      ],
      requiresDoctorVisit: true,
    ),
    'headache_eye_strain_remedy': Remedy(
      id: 'headache_eye_strain_remedy',
      title: 'Eye Strain Headache',
      description: 'Headache caused by prolonged screen time or eye fatigue.',
      category: 'Headache',
      homeRemedies: [
        '👁️ Follow 20-20-20 rule: Every 20 minutes, look 20 feet away for 20 seconds',
        '😌 Close eyes and rest for 10-15 minutes',
        '🧊 Apply cold compress on eyes',
        '💆 Gentle head and neck massage',
        '💡 Reduce screen brightness',
        '🌙 Ensure proper lighting in room',
      ],
      medications: [
        '💊 Usually no medication needed',
        '💊 If severe: Paracetamol 500mg',
        '💊 Eye drops if eyes are dry (consult pharmacist)',
      ],
      warnings: [
        '⚠️ If headache persists despite rest, consult eye specialist',
      ],
    ),
    'headache_tension_remedy': Remedy(
      id: 'headache_tension_remedy',
      title: 'Tension Headache',
      description: 'Stress-related headache, very common and usually manageable.',
      category: 'Headache',
      homeRemedies: [
        '🧘 Practice deep breathing exercises',
        '💆 Massage temples and neck',
        '🛁 Take a warm shower',
        '🧊 Cold or warm compress on forehead',
        '😴 Rest in a quiet, dark room',
        '🍵 Drink chamomile or peppermint tea',
        '🚶 Light walk in fresh air',
      ],
      medications: [
        '💊 Paracetamol 500mg or Combiflam',
        '💊 Saridon for quick relief',
      ],
      warnings: [
        '⚠️ Avoid stress triggers',
        '⚠️ If frequent, maintain headache diary',
      ],
    ),
    'headache_migraine_remedy': Remedy(
      id: 'headache_migraine_remedy',
      title: 'Migraine Headache',
      description: 'Severe headache that may need medical intervention.',
      category: 'Headache',
      homeRemedies: [
        '🌙 Rest in completely dark, quiet room',
        '🧊 Ice pack on forehead and neck',
        '☕ Small amount of caffeine (coffee/tea) may help',
        '💧 Stay hydrated',
        '😴 Try to sleep',
      ],
      medications: [
        'Prescription migraine medication (if already prescribed)',
        'Consult doctor for proper diagnosis',
      ],
      warnings: [
        '🚨 URGENT: Consult neurologist if first-time severe headache',
        '⚠️ Avoid bright lights and loud sounds',
        '⚠️ If with vision changes, seek immediate help',
      ],
      requiresDoctorVisit: true,
    ),
    'cough_dry_remedy': Remedy(
      id: 'cough_dry_remedy',
      title: 'Dry Cough',
      description: 'Irritating cough without mucus.',
      category: 'Cough',
      homeRemedies: [
        '🍯 Honey with warm water (1 tsp, 2-3 times daily)',
        '🍵 Ginger tea with tulsi leaves',
        '💨 Steam inhalation twice daily',
        '🧣 Keep throat warm',
        '💧 Drink warm liquids frequently',
        '🍬 Suck on lozenges or hard candy',
        '😷 Avoid cold drinks and ice cream',
      ],
      medications: [
        '💊 Benadryl Cough Syrup - 10ml 3 times daily',
        '💊 Strepsils or Vicks lozenges',
        '💊 Avoid cough suppressants if mucus present',
      ],
      warnings: [
        '⚠️ If cough persists beyond 2 weeks, see doctor',
        '⚠️ Avoid cold and dusty environments',
      ],
    ),
    'cough_wet_remedy': Remedy(
      id: 'cough_wet_remedy',
      title: 'Wet Cough (Productive Cough)',
      description: 'Cough with mucus/phlegm.',
      category: 'Cough',
      homeRemedies: [
        '💧 Drink plenty of warm fluids',
        '💨 Steam inhalation 2-3 times daily',
        '🍯 Honey and ginger tea',
        '🧅 Onion and honey mixture',
        '🫖 Turmeric milk before bed',
        '🤧 Proper expectoration (don\'t suppress)',
      ],
      medications: [
        '💊 Ascoril Expectorant - 10ml 3 times daily',
        '💊 Mucolite syrup for thick mucus',
        '💊 Avoid Benadryl (cough suppressant)',
      ],
      warnings: [
        '⚠️ If mucus is yellow/green for >3 days, see doctor',
        '⚠️ If blood in cough, immediate medical attention',
      ],
    ),
    'stomach_indigestion_remedy': Remedy(
      id: 'stomach_indigestion_remedy',
      title: 'Indigestion',
      description: 'Discomfort after eating, common digestive issue.',
      category: 'Stomach',
      homeRemedies: [
        '🚶 Light walk after meals (10-15 minutes)',
        '🍵 Ginger or peppermint tea',
        '🧃 Lemon water with a pinch of salt',
        '🥄 Ajwain (carom seeds) with warm water',
        '🥣 Eat small, frequent meals',
        '😌 Avoid lying down immediately after eating',
        '🚫 Avoid spicy and oily foods',
      ],
      medications: [
        '💊 Digene or ENO - When needed',
        '💊 Gasex tablets - 2 tablets after meals',
        '💊 Pudinhara (digestive)',
      ],
      warnings: [
        '⚠️ If severe pain persists, consult doctor',
        '⚠️ Avoid overeating',
      ],
    ),
    'stomach_acidity_remedy': Remedy(
      id: 'stomach_acidity_remedy',
      title: 'Acidity / Heartburn',
      description: 'Burning sensation in chest and throat.',
      category: 'Stomach',
      homeRemedies: [
        '🥛 Cold milk (without sugar)',
        '🥥 Coconut water',
        '🍌 Eat banana',
        '🧃 Aloe vera juice',
        '😴 Sleep with head elevated',
        '🚫 Avoid spicy, oily, citrus foods',
        '☕ Avoid coffee and tea on empty stomach',
      ],
      medications: [
        '💊 ENO or Gelusil - Immediate relief',
        '💊 Pan 40 (Pantoprazole) - Empty stomach',
        '💊 Ranitidine 150mg - Before bed',
      ],
      warnings: [
        '⚠️ If occurs frequently, consult gastroenterologist',
        '⚠️ Severe chest pain - rule out heart issues',
      ],
    ),
    'bodyache_simple_remedy': Remedy(
      id: 'bodyache_simple_remedy',
      title: 'General Body Ache',
      description: 'Muscle soreness, usually from physical activity or stress.',
      category: 'Body Ache',
      homeRemedies: [
        '🛁 Warm water bath with Epsom salt',
        '💆 Gentle massage with warm oil',
        '🧘 Light stretching exercises',
        '😴 Adequate rest and sleep',
        '💧 Stay hydrated',
        '🥗 Nutritious diet with proteins',
        '🧊 Ice pack for specific sore areas',
      ],
      medications: [
        '💊 Combiflam - 1 tablet twice daily',
        '💊 Volini or Moov gel for external application',
        '💊 Muscle relaxant if prescribed by doctor',
      ],
      warnings: [
        '⚠️ If pain severe or persistent, consult doctor',
        '⚠️ Avoid strenuous activity until recovered',
      ],
    ),
    'bodyache_viral_remedy': Remedy(
      id: 'bodyache_viral_remedy',
      title: 'Body Ache with Fever (Viral)',
      description: 'Body pain accompanying viral infection.',
      category: 'Body Ache',
      homeRemedies: [
        '🛏️ Complete bed rest',
        '💧 Plenty of fluids - ORS, coconut water',
        '🍵 Ginger tea or herbal tea',
        '🥣 Light, nutritious meals',
        '💆 Gentle body massage',
        '🧊 Cold sponging if fever present',
      ],
      medications: [
        '💊 Dolo 650 - Every 8 hours',
        '💊 Becosules (B-Complex) - Once daily',
        '💊 Limcee (Vitamin C) 500mg',
      ],
      warnings: [
        '⚠️ If symptoms worsen, consult doctor',
        '⚠️ Monitor for dengue/viral fever symptoms',
      ],
      requiresDoctorVisit: false,
    ),
    // Additional Fever Remedies
    'fever_cough_remedy': Remedy(
      id: 'fever_cough_remedy',
      title: 'Fever with Cough',
      description: 'Respiratory infection with fever and cough.',
      category: 'Fever',
      homeRemedies: [
        '💧 Drink warm fluids',
        '💨 Steam inhalation',
        '🍯 Honey and ginger tea',
        '🛏️ Complete bed rest',
      ],
      medications: [
        '💊 Dolo 650',
        '💊 Ascoril LS Syrup',
      ],
      warnings: ['If fever persists, see doctor'],
    ),
    'fever_headache_remedy': Remedy(
      id: 'fever_headache_remedy',
      title: 'Fever with Headache',
      description: 'Flu-like symptoms.',
      category: 'Fever',
      homeRemedies: [
        '💧 Stay hydrated',
        '😴 Rest in dark room',
        '🧊 Cold compress',
      ],
      medications: ['Paracetamol'],
    ),
    // Additional Headache Remedies
    'headache_fever_remedy': Remedy(
      id: 'headache_fever_remedy',
      title: 'Headache with Fever',
      description: 'Infection-related headache.',
      category: 'Headache',
      homeRemedies: [
        '😴 Rest',
        '🧊 Apply cold compress',
        '💧 Drink fluids',
      ],
      medications: ['Paracetamol'],
    ),
    'headache_severe_remedy': Remedy(
      id: 'headache_severe_remedy',
      title: 'Severe Headache',
      description: 'Intense headache requiring attention.',
      category: 'Headache',
      homeRemedies: [
        '🌙 Dark, quiet room',
        '🧊 Ice pack',
        '😴 Sleep',
      ],
      medications: [
        '💊 Brufen 400mg or Combiflam',
        '💊 Consult doctor if very severe',
      ],
      requiresDoctorVisit: true,
    ),
    // Additional Cough Remedies
    'cough_persistent_remedy': Remedy(
      id: 'cough_persistent_remedy',
      title: 'Persistent Dry Cough',
      description: 'Long-lasting cough.',
      category: 'Cough',
      homeRemedies: [
        '🍯 Honey with warm water',
        '💨 Steam inhalation',
        '🍵 Herbal tea',
      ],
      medications: [
        '💊 Benadryl Cough Syrup',
        '💊 Consider doctor visit if >2 weeks',
      ],
      warnings: ['See doctor if persists'],
    ),
    'cough_infection_remedy': Remedy(
      id: 'cough_infection_remedy',
      title: 'Cough with Fever',
      description: 'Respiratory infection.',
      category: 'Cough',
      homeRemedies: [
        '💧 Warm fluids',
        '🛏️ Rest',
        '💨 Steam',
      ],
      medications: [
        '💊 Azithromycin 500mg (if doctor prescribes)',
        '💊 Ascoril LS or Cheston Cold',
      ],
    ),
    'cough_severe_remedy': Remedy(
      id: 'cough_severe_remedy',
      title: 'Severe Cough with Breathing Difficulty',
      description: 'Urgent medical attention needed.',
      category: 'Cough',
      homeRemedies: [
        '🚨 SEEK IMMEDIATE MEDICAL HELP',
        '💧 Stay calm and hydrated',
      ],
      requiresDoctorVisit: true,
    ),
    // Additional Stomach Remedies
    'stomach_general_remedy': Remedy(
      id: 'stomach_general_remedy',
      title: 'General Stomach Discomfort',
      description: 'Mild stomach issues.',
      category: 'Stomach',
      homeRemedies: [
        '🍵 Ginger tea',
        '🚶 Light walk',
        '🥣 Light meals',
      ],
    ),
    'stomach_cramps_remedy': Remedy(
      id: 'stomach_cramps_remedy',
      title: 'Stomach Cramps',
      description: 'Abdominal cramps.',
      category: 'Stomach',
      homeRemedies: [
        '🔥 Hot water bottle',
        '🍵 Chamomile tea',
        '💆 Gentle massage',
      ],
    ),
    'stomach_bloating_remedy': Remedy(
      id: 'stomach_bloating_remedy',
      title: 'Bloating and Gas',
      description: 'Digestive discomfort.',
      category: 'Stomach',
      homeRemedies: [
        '🚶 Walk after meals',
        '🥄 Ajwain water',
        '🍵 Peppermint tea',
      ],
    ),
    'stomach_constipation_remedy': Remedy(
      id: 'stomach_constipation_remedy',
      title: 'Constipation',
      description: 'Difficulty in bowel movements.',
      category: 'Stomach',
      homeRemedies: [
        '💧 Drink more water',
        '🥗 Fiber-rich diet',
        '🚶 Regular exercise',
        '🍌 Eat fruits',
      ],
    ),
    // Additional Body Ache Remedy
    'bodyache_weakness_remedy': Remedy(
      id: 'bodyache_weakness_remedy',
      title: 'Body Ache with Weakness',
      description: 'Fatigue and body pain.',
      category: 'Body Ache',
      homeRemedies: [
        '😴 Adequate rest',
        '🥗 Nutritious diet',
        '💊 Vitamin supplements',
        '💧 Stay hydrated',
      ],
    ),
  };

  static Remedy? getRemedy(String remedyId) {
    return remedies[remedyId];
  }

  static List<Remedy> getAllRemedies() {
    return remedies.values.toList();
  }

  static List<Remedy> getRemediesByCategory(String category) {
    return remedies.values
        .where((remedy) => remedy.category == category)
        .toList();
  }
}
