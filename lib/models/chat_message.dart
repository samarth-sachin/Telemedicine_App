import 'package:hive/hive.dart';

part 'chat_message.g.dart';

@HiveType(typeId: 0)
class ChatMessage extends HiveObject {
  @HiveField(0)
  String text;

  @HiveField(1)
  bool isUser;

  @HiveField(2)
  DateTime timestamp;

  @HiveField(3)
  String? messageType; // 'text', 'remedy', 'suggestion'

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.messageType = 'text',
  });

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isUser': isUser,
      'timestamp': timestamp.toIso8601String(),
      'messageType': messageType,
    };
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      text: json['text'],
      isUser: json['isUser'],
      timestamp: DateTime.parse(json['timestamp']),
      messageType: json['messageType'] ?? 'text',
    );
  }
}
