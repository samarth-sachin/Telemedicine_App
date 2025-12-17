import 'package:hive_flutter/hive_flutter.dart';
import '../models/chat_message.dart';
import '../models/consultation.dart';

class HiveManager {
  static const String consultationsBoxName = 'consultations';
  static const String messagesBoxName = 'messages';

  static Future<void> initialize() async {
    await Hive.initFlutter();
    
    // Register adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ChatMessageAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(ConsultationAdapter());
    }

    // Open boxes
    await Hive.openBox<Consultation>(consultationsBoxName);
    await Hive.openBox<ChatMessage>(messagesBoxName);
  }

  // Consultation operations
  static Box<Consultation> get consultationsBox =>
      Hive.box<Consultation>(consultationsBoxName);

  static Future<void> saveConsultation(Consultation consultation) async {
    await consultationsBox.put(consultation.id, consultation);
  }

  static List<Consultation> getAllConsultations() {
    return consultationsBox.values.toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  static Consultation? getConsultation(String id) {
    return consultationsBox.get(id);
  }

  static Future<void> deleteConsultation(String id) async {
    await consultationsBox.delete(id);
  }

  static Future<void> clearAllConsultations() async {
    await consultationsBox.clear();
  }

  // Get consultations by date range
  static List<Consultation> getConsultationsByDateRange(
      DateTime start, DateTime end) {
    return consultationsBox.values
        .where((consultation) =>
            consultation.timestamp.isAfter(start) &&
            consultation.timestamp.isBefore(end))
        .toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  // Get symptom frequency (for health insights)
  static Map<String, int> getSymptomFrequency() {
    Map<String, int> frequency = {};
    
    for (var consultation in consultationsBox.values) {
      for (var symptom in consultation.symptoms) {
        frequency[symptom] = (frequency[symptom] ?? 0) + 1;
      }
    }
    
    return frequency;
  }

  // Get recent symptoms (last 30 days)
  static List<String> getRecentSymptoms({int days = 30}) {
    DateTime cutoffDate = DateTime.now().subtract(Duration(days: days));
    Set<String> symptoms = {};

    for (var consultation in consultationsBox.values) {
      if (consultation.timestamp.isAfter(cutoffDate)) {
        symptoms.addAll(consultation.symptoms);
      }
    }

    return symptoms.toList();
  }

  static int getTotalConsultations() {
    return consultationsBox.length;
  }

  static Future<void> close() async {
    await Hive.close();
  }
}
