import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'chat_message.dart';

part 'consultation.g.dart';

@HiveType(typeId: 1)
class Consultation {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final DateTime timestamp;
  
  @HiveField(2)
  final List<String> symptoms;
  
  @HiveField(3)
  final String remedy;
  
  @HiveField(4)
  final List<ChatMessage> messages;
  
  @HiveField(5)
  final String consultationSummary;
  
  @HiveField(6)
  final String severity;

  Consultation({
    required this.id,
    required this.timestamp,
    required this.symptoms,
    required this.remedy,
    required this.messages,
    required this.consultationSummary,
    required this.severity,
  });

  String getFormattedDate() {
    return DateFormat('MMM dd, yyyy').format(timestamp);
  }

  String getFormattedTime() {
    return DateFormat('hh:mm a').format(timestamp);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timestamp': timestamp.toIso8601String(),
      'symptoms': symptoms,
      'remedy': remedy,
      'messages': messages.map((m) => m.toJson()).toList(),
      'consultationSummary': consultationSummary,
      'severity': severity,
    };
  }

  factory Consultation.fromJson(Map<String, dynamic> json) {
    return Consultation(
      id: json['id'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      symptoms: List<String>.from(json['symptoms'] as List),
      remedy: json['remedy'] as String,
      messages: (json['messages'] as List)
          .map((m) => ChatMessage.fromJson(m as Map<String, dynamic>))
          .toList(),
      consultationSummary: json['consultationSummary'] as String,
      severity: json['severity'] as String,
    );
  }
}
