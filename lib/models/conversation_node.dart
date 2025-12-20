class ConversationNode {
  final String id;
  final String botMessage;
  final List<String> suggestedReplies;
  final Map<String, String> transitions; // keyword -> next node id
  final String? remedyId;
  final bool isTerminal;
  final List<String> followUpQuestions;
  final String? severity;
  final String? onEnterSymptom;

  ConversationNode({
    required this.id,
    required this.botMessage,
    this.suggestedReplies = const [],
    this.transitions = const {},
    this.remedyId,
    this.isTerminal = false,
    this.followUpQuestions = const [],
    this.severity,
    this.onEnterSymptom,
  });

  ConversationNode copyWith({
    String? id,
    String? botMessage,
    List<String>? suggestedReplies,
    Map<String, String>? transitions,
    String? remedyId,
    bool? isTerminal,
    List<String>? followUpQuestions,
    String? severity,
    String? onEnterSymptom,
  }) {
    return ConversationNode(
      id: id ?? this.id,
      botMessage: botMessage ?? this.botMessage,
      suggestedReplies: suggestedReplies ?? this.suggestedReplies,
      transitions: transitions ?? this.transitions,
      remedyId: remedyId ?? this.remedyId,
      isTerminal: isTerminal ?? this.isTerminal,
      followUpQuestions: followUpQuestions ?? this.followUpQuestions,
      severity: severity ?? this.severity,
      onEnterSymptom: onEnterSymptom ?? this.onEnterSymptom,
    );
  }
}

class Remedy {
  final String id;
  final String title;
  final String description;
  final List<String> homeRemedies;
  final List<String> medications;
  final List<String> warnings;
  final bool requiresDoctorVisit;
  final String category;

  Remedy({
    required this.id,
    required this.title,
    required this.description,
    required this.homeRemedies,
    this.medications = const [],
    this.warnings = const [],
    this.requiresDoctorVisit = false,
    required this.category,
  });
}
