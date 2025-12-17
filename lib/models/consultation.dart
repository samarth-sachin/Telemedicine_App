import 'package:hive/hive.dart';
import 'chat_message.dart';

part 'consultation.g.dart';

@HiveType(typeId: 1)
class Consultation extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  DateTime timestamp;

  @HiveField(2)
  List<String> symptoms;

  @HiveField(3)
  String remedy;

  @HiveField(4)
  List<ChatMessage> messages;

  @HiveField(5)
  String consultationSummary;

  @HiveField(6)
  String severity; // 'mild', 'moderate', 'severe'

  Consultation({
    required this.id,
    required this.timestamp,
    required this.symptoms,
    required this.remedy,
    required this.messages,
    this.consultationSummary = '',
    this.severity = 'mild',
  });

  String getFormattedDate() {
    final day = timestamp.day.toString().padLeft(2, '0');
    final month = timestamp.month.toString().padLeft(2, '0');
    final year = timestamp.year;
    return '$day/$month/$year';
  }

  String getFormattedTime() {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
