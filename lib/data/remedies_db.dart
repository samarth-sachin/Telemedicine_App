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
        'Paracetamol 500mg (after consulting pharmacist)',
        'Take with food',
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
        'Paracetamol for fever and pain',
        'Vitamin C supplements',
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
        'Usually no medication needed',
        'If severe: Mild pain reliever after consulting pharmacist',
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
        'Paracetamol or Ibuprofen (if needed)',
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
        'Cough suppressant syrup (consult pharmacist)',
        'Throat lozenges',
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
        'Expectorant cough syrup',
        'Avoid cough suppressants',
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
        'Antacid (if needed)',
        'Digestive enzymes',
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
        'Antacid tablets or syrup',
        'Proton pump inhibitors (if prescribed)',
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
        'Mild pain reliever if needed',
        'Pain relief ointment/balm',
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
        'Paracetamol for fever and pain',
        'Multivitamin supplements',
      ],
      warnings: [
        '⚠️ If symptoms worsen, consult doctor',
        '⚠️ Monitor for dengue/viral fever symptoms',
      ],
      requiresDoctorVisit: false,
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
