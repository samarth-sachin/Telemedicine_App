import '../models/conversation_node.dart';

class ConversationTree {
  late Map<String, ConversationNode> nodes;
  String currentNodeId = 'welcome';

  ConversationTree() {
    _initializeTree();
  }

  void _initializeTree() {
    nodes = {
      'welcome': ConversationNode(
        id: 'welcome',
        botMessage:
            '👋 Hello! I\'m TeleMedi, your personal health assistant. How can I help you today?',
        suggestedReplies: [
          'I have fever',
          'Headache',
          'Cough',
          'Stomach pain',
          'Body ache'
        ],
        transitions: {
          'fever': 'fever_start',
          'headache': 'headache_start',
          'cough': 'cough_start',
          'stomach': 'stomach_start',
          'pain': 'pain_assessment',
          'cold': 'cold_start',
          'body ache': 'bodyache_start',
        },
      ),
      // FEVER BRANCH
      'fever_start': ConversationNode(
        id: 'fever_start',
        botMessage: 'I understand you have fever. How long have you had it?',
        suggestedReplies: ['Less than 24 hours', '1-3 days', 'More than 3 days'],
        transitions: {
          'less': 'fever_duration_short',
          '24': 'fever_duration_short',
          '1': 'fever_duration_medium',
          '2': 'fever_duration_medium',
          '3': 'fever_duration_long',
          'more': 'fever_duration_long',
        },
      ),
      'fever_duration_short': ConversationNode(
        id: 'fever_duration_short',
        botMessage: 'Do you have any other symptoms like body ache, headache, or cold?',
        suggestedReplies: ['Yes, body ache', 'Yes, headache', 'No, just fever'],
        transitions: {
          'body': 'fever_with_bodyache',
          'headache': 'fever_with_headache',
          'no': 'fever_simple',
          'just': 'fever_simple',
        },
      ),
      'fever_simple': ConversationNode(
        id: 'fever_simple',
        botMessage: 'Got it. This seems like a simple fever. Let me suggest some remedies.',
        remedyId: 'fever_simple_remedy',
        isTerminal: true,
        severity: 'mild',
      ),
      'fever_with_bodyache': ConversationNode(
        id: 'fever_with_bodyache',
        botMessage: 'Fever with body ache could indicate viral infection. Here are some recommendations.',
        remedyId: 'fever_viral_remedy',
        isTerminal: true,
        severity: 'moderate',
      ),
      'fever_duration_long': ConversationNode(
        id: 'fever_duration_long',
        botMessage: 'Fever for more than 3 days needs medical attention. Please consult a doctor soon.',
        remedyId: 'fever_prolonged_remedy',
        isTerminal: true,
        severity: 'severe',
      ),
      // HEADACHE BRANCH
      'headache_start': ConversationNode(
        id: 'headache_start',
        botMessage: 'I see you have a headache. How would you describe the pain intensity?',
        suggestedReplies: ['Mild', 'Moderate', 'Severe'],
        transitions: {
          'mild': 'headache_mild',
          'moderate': 'headache_moderate',
          'severe': 'headache_severe',
        },
      ),
      'headache_mild': ConversationNode(
        id: 'headache_mild',
        botMessage: 'Is this headache accompanied by eye strain or screen time?',
        suggestedReplies: ['Yes', 'No'],
        transitions: {
          'yes': 'headache_eye_strain',
          'no': 'headache_tension',
        },
      ),
      'headache_eye_strain': ConversationNode(
        id: 'headache_eye_strain',
        botMessage: 'This sounds like eye strain headache. Here are some tips.',
        remedyId: 'headache_eye_strain_remedy',
        isTerminal: true,
        severity: 'mild',
      ),
      'headache_tension': ConversationNode(
        id: 'headache_tension',
        botMessage: 'This could be a tension headache. Let me help you with some relief methods.',
        remedyId: 'headache_tension_remedy',
        isTerminal: true,
        severity: 'mild',
      ),
      'headache_severe': ConversationNode(
        id: 'headache_severe',
        botMessage: 'Severe headache needs attention. Do you have nausea, vomiting or vision problems?',
        suggestedReplies: ['Yes', 'No'],
        transitions: {
          'yes': 'headache_migraine',
          'no': 'headache_severe_simple',
        },
      ),
      'headache_migraine': ConversationNode(
        id: 'headache_migraine',
        botMessage: 'This could be a migraine. I recommend seeing a doctor, but here are immediate relief tips.',
        remedyId: 'headache_migraine_remedy',
        isTerminal: true,
        severity: 'severe',
      ),
      // COUGH BRANCH
      'cough_start': ConversationNode(
        id: 'cough_start',
        botMessage: 'You have a cough. Is it a dry cough or wet cough with mucus?',
        suggestedReplies: ['Dry cough', 'Wet cough'],
        transitions: {
          'dry': 'cough_dry',
          'wet': 'cough_wet',
          'mucus': 'cough_wet',
        },
      ),
      'cough_dry': ConversationNode(
        id: 'cough_dry',
        botMessage: 'How long have you had this dry cough?',
        suggestedReplies: ['Less than a week', 'More than a week'],
        transitions: {
          'less': 'cough_dry_short',
          'week': 'cough_dry_long',
          'more': 'cough_dry_long',
        },
      ),
      'cough_dry_short': ConversationNode(
        id: 'cough_dry_short',
        botMessage: 'Recent dry cough is usually treatable at home. Here are some remedies.',
        remedyId: 'cough_dry_remedy',
        isTerminal: true,
        severity: 'mild',
      ),
      'cough_wet': ConversationNode(
        id: 'cough_wet',
        botMessage: 'Wet cough with mucus. Do you have fever or difficulty breathing?',
        suggestedReplies: ['Yes, fever', 'Yes, breathing difficulty', 'No'],
        transitions: {
          'fever': 'cough_wet_fever',
          'breathing': 'cough_severe',
          'no': 'cough_wet_simple',
        },
      ),
      'cough_wet_simple': ConversationNode(
        id: 'cough_wet_simple',
        botMessage: 'This seems like a common cold with mucus. Here are remedies to help.',
        remedyId: 'cough_wet_remedy',
        isTerminal: true,
        severity: 'mild',
      ),
      // STOMACH PAIN BRANCH
      'stomach_start': ConversationNode(
        id: 'stomach_start',
        botMessage: 'You have stomach pain. Where exactly is the pain located?',
        suggestedReplies: ['Upper abdomen', 'Lower abdomen', 'All over'],
        transitions: {
          'upper': 'stomach_upper',
          'lower': 'stomach_lower',
          'all': 'stomach_general',
        },
      ),
      'stomach_upper': ConversationNode(
        id: 'stomach_upper',
        botMessage: 'Upper stomach pain. Is it related to eating or acidity?',
        suggestedReplies: ['After eating', 'Burning sensation', 'Other'],
        transitions: {
          'eating': 'stomach_indigestion',
          'burning': 'stomach_acidity',
          'other': 'stomach_general',
        },
      ),
      'stomach_indigestion': ConversationNode(
        id: 'stomach_indigestion',
        botMessage: 'This sounds like indigestion. Here are some quick relief methods.',
        remedyId: 'stomach_indigestion_remedy',
        isTerminal: true,
        severity: 'mild',
      ),
      'stomach_acidity': ConversationNode(
        id: 'stomach_acidity',
        botMessage: 'Acidity or heartburn. Let me suggest some remedies.',
        remedyId: 'stomach_acidity_remedy',
        isTerminal: true,
        severity: 'mild',
      ),
      // BODY ACHE BRANCH
      'bodyache_start': ConversationNode(
        id: 'bodyache_start',
        botMessage: 'You have body ache. Do you also have fever or weakness?',
        suggestedReplies: ['Yes, fever', 'Yes, weakness', 'No, just ache'],
        transitions: {
          'fever': 'bodyache_fever',
          'weakness': 'bodyache_weakness',
          'just': 'bodyache_simple',
          'no': 'bodyache_simple',
        },
      ),
      'bodyache_simple': ConversationNode(
        id: 'bodyache_simple',
        botMessage: 'Simple body ache, possibly from physical activity or stress. Here are remedies.',
        remedyId: 'bodyache_simple_remedy',
        isTerminal: true,
        severity: 'mild',
      ),
      'bodyache_fever': ConversationNode(
        id: 'bodyache_fever',
        botMessage: 'Body ache with fever suggests viral infection. Here are recommendations.',
        remedyId: 'bodyache_viral_remedy',
        isTerminal: true,
        severity: 'moderate',
      ),
    };
  }

  ConversationNode getNode(String nodeId) {
    return nodes[nodeId] ?? nodes['welcome']!;
  }

  String? findNextNode(String userInput) {
    ConversationNode current = getNode(currentNodeId);
    String normalizedInput = userInput.toLowerCase();

    for (var entry in current.transitions.entries) {
      if (normalizedInput.contains(entry.key)) {
        return entry.value;
      }
    }
    return null;
  }

  void reset() {
    currentNodeId = 'welcome';
  }
}
