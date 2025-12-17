import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/chat_message.dart';
import '../models/consultation.dart';
import '../models/conversation_node.dart';
import '../data/conversation_tree.dart';
import '../data/medical_trie.dart';
import '../data/levenshtein.dart';
import '../data/remedies_db.dart';
import '../storage/hive_manager.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/typing_indicator.dart';
import '../widgets/symptom_chip.dart';
import 'medical_insights_screen.dart';
import 'history_screen.dart';
import 'profile_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  final ConversationTree _conversationTree = ConversationTree();
  final MedicalTrie _medicalTrie = MedicalTrie();
  
  bool _isTyping = false;
  int _currentIndex = 0;
  List<String> _detectedSymptoms = [];
  String? _currentRemedyId;

  @override
  void initState() {
    super.initState();
    _initializeMedicalTrie();
    _sendInitialMessage();
  }

  void _initializeMedicalTrie() {
    // Populate Trie with medical keywords
    _medicalTrie.insert('fever', 'fever_start');
    _medicalTrie.insert('headache', 'headache_start');
    _medicalTrie.insert('cough', 'cough_start');
    _medicalTrie.insert('stomach', 'stomach_start');
    _medicalTrie.insert('pain', 'pain_assessment');
    _medicalTrie.insert('body ache', 'bodyache_start');
    _medicalTrie.insert('cold', 'cold_start');
  }

  void _sendInitialMessage() {
    Future.delayed(Duration(milliseconds: 500), () {
      ConversationNode welcomeNode = _conversationTree.getNode('welcome');
      _addBotMessage(welcomeNode.botMessage, welcomeNode.suggestedReplies);
    });
  }

  void _addBotMessage(String message, [List<String>? suggestions]) {
    setState(() {
      _messages.add(ChatMessage(
        text: message,
        isUser: false,
        timestamp: DateTime.now(),
      ));
      _isTyping = false;
    });
    _scrollToBottom();
  }

  void _addUserMessage(String message) {
    setState(() {
      _messages.add(ChatMessage(
        text: message,
        isUser: true,
        timestamp: DateTime.now(),
      ));
      _isTyping = true;
    });
    _scrollToBottom();
    _processUserInput(message);
  }

  void _processUserInput(String input) {
    Future.delayed(Duration(milliseconds: 800), () {
      // First try exact match with Trie
      String? trieResult = _medicalTrie.search(input.toLowerCase());
      
      if (trieResult != null) {
        _conversationTree.currentNodeId = trieResult;
        _moveToNextNode();
        return;
      }

      // Try to find next node based on current conversation
      String? nextNodeId = _conversationTree.findNextNode(input);
      
      if (nextNodeId != null) {
        _conversationTree.currentNodeId = nextNodeId;
        _moveToNextNode();
        return;
      }

      // Use Levenshtein distance for fuzzy matching
      List<String> allSymptoms = [
        'fever',
        'headache',
        'cough',
        'stomach pain',
        'body ache',
        'cold'
      ];
      
      String closestMatch = LevenshteinDistance.findClosestMatch(
        input.toLowerCase(),
        allSymptoms,
      );

      if (closestMatch.isNotEmpty) {
        setState(() {
          _isTyping = false;
        });
        _addBotMessage(
          'Did you mean "$closestMatch"?',
          ['Yes', 'No, something else'],
        );
      } else {
        setState(() {
          _isTyping = false;
        });
        _addBotMessage(
          'I\'m not sure I understand. Could you please describe your symptoms more clearly?',
          ['Fever', 'Headache', 'Cough', 'Stomach pain', 'Body ache'],
        );
      }
    });
  }

  void _moveToNextNode() {
    ConversationNode node =
        _conversationTree.getNode(_conversationTree.currentNodeId);
    setState(() {
      _isTyping = false;
    });
    _addBotMessage(node.botMessage, node.suggestedReplies);

    // If terminal node, show remedy
    if (node.isTerminal && node.remedyId != null) {
      _currentRemedyId = node.remedyId;
      Future.delayed(Duration(milliseconds: 1000), () {
        _showRemedy(node.remedyId!);
      });
    }
  }

  void _showRemedy(String remedyId) {
    Remedy? remedy = RemediesDatabase.getRemedy(remedyId);
    if (remedy == null) return;

    setState(() {
      _isTyping = true;
    });

    Future.delayed(Duration(milliseconds: 800), () {
      setState(() {
        _isTyping = false;
      });

      String remedyMessage = '📋 ${remedy.title}\n\n';
      remedyMessage += '${remedy.description}\n\n';
      remedyMessage += '🏠 Home Remedies:\n';
      for (var r in remedy.homeRemedies) {
        remedyMessage += '$r\n';
      }
      
      if (remedy.medications.isNotEmpty) {
        remedyMessage += '\n💊 Medications:\n';
        for (var med in remedy.medications) {
          remedyMessage += '$med\n';
        }
      }

      if (remedy.warnings.isNotEmpty) {
        remedyMessage += '\n⚠️ Important:\n';
        for (var warning in remedy.warnings) {
          remedyMessage += '$warning\n';
        }
      }

      _addBotMessage(remedyMessage);
      
      Future.delayed(Duration(milliseconds: 500), () {
        _showSaveConsultationOption();
      });
    });
  }

  void _showSaveConsultationOption() {
    setState(() {
      _isTyping = true;
    });
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isTyping = false;
      });
      _addBotMessage(
        'Would you like to save this consultation for future reference?',
        ['Yes, save it', 'No, thanks', 'Start new consultation'],
      );
    });
  }

  void _saveConsultation() async {
    if (_messages.isEmpty) return;

    String consultationId = DateTime.now().millisecondsSinceEpoch.toString();
    
    Consultation consultation = Consultation(
      id: consultationId,
      timestamp: DateTime.now(),
      symptoms: _detectedSymptoms,
      remedy: _currentRemedyId ?? 'general',
      messages: _messages,
      consultationSummary: 'Consultation saved',
      severity: 'mild',
    );

    await HiveManager.saveConsultation(consultation);

    setState(() {
      _isTyping = true;
    });

    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isTyping = false;
      });
      _addBotMessage(
        '✅ Consultation saved successfully! You can view it anytime in the History section.',
        ['Start new consultation', 'View history'],
      );
    });
  }

  void _resetConversation() {
    setState(() {
      _messages.clear();
      _detectedSymptoms.clear();
      _currentRemedyId = null;
      _conversationTree.reset();
    });
    _sendInitialMessage();
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    String message = _messageController.text.trim();
    if (message.isEmpty) return;

    // Handle special commands
    if (message.toLowerCase() == 'yes, save it') {
      _saveConsultation();
      _messageController.clear();
      return;
    }

    if (message.toLowerCase() == 'start new consultation' ||
        message.toLowerCase() == 'no, thanks') {
      _resetConversation();
      _messageController.clear();
      return;
    }

    _addUserMessage(message);
    _messageController.clear();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF2196F3),
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.favorite,
                color: Color(0xFF2196F3),
                size: 24,
              ),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TeleMedi',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Online • Offline Mode',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: _resetConversation,
            tooltip: 'New Consultation',
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages list
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(16),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length && _isTyping) {
                  return TypingIndicator();
                }
                return ChatBubble(message: _messages[index]);
              },
            ),
          ),
          // Suggested replies
          if (_messages.isNotEmpty &&
              !_messages.last.isUser &&
              !_isTyping)
            _buildSuggestedReplies(),
          // Input area
          _buildInputArea(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildSuggestedReplies() {
    ConversationNode currentNode =
        _conversationTree.getNode(_conversationTree.currentNodeId);
    
    if (currentNode.suggestedReplies.isEmpty) return SizedBox.shrink();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: currentNode.suggestedReplies
              .map((reply) => SymptomChip(
                    label: reply,
                    onTap: () => _addUserMessage(reply),
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Describe your symptoms...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF2196F3),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.send, color: Colors.white),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        
        switch (index) {
          case 0:
            // Already on chat screen
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MedicalInsightsScreen()),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HistoryScreen()),
            );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color(0xFF2196F3),
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_hospital),
          label: 'Insights',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
