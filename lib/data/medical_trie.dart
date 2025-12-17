class TrieNode {
  Map<String, TrieNode> children = {};
  bool isEndOfWord = false;
  String? responseId;
  List<String> associatedSymptoms = [];

  TrieNode();
}

class MedicalTrie {
  final TrieNode root = TrieNode();

  void insert(String word, String responseId, {List<String>? symptoms}) {
    TrieNode current = root;
    String normalizedWord = word.toLowerCase().trim();

    for (int i = 0; i < normalizedWord.length; i++) {
      String char = normalizedWord[i];
      if (!current.children.containsKey(char)) {
        current.children[char] = TrieNode();
      }
      current = current.children[char]!;
    }

    current.isEndOfWord = true;
    current.responseId = responseId;
    if (symptoms != null) {
      current.associatedSymptoms = symptoms;
    }
  }

  String? search(String word) {
    TrieNode current = root;
    String normalizedWord = word.toLowerCase().trim();

    for (int i = 0; i < normalizedWord.length; i++) {
      String char = normalizedWord[i];
      if (!current.children.containsKey(char)) {
        return null;
      }
      current = current.children[char]!;
    }

    return current.isEndOfWord ? current.responseId : null;
  }

  List<String> searchPartial(String prefix) {
    TrieNode current = root;
    String normalizedPrefix = prefix.toLowerCase().trim();
    List<String> results = [];

    for (int i = 0; i < normalizedPrefix.length; i++) {
      String char = normalizedPrefix[i];
      if (!current.children.containsKey(char)) {
        return results;
      }
      current = current.children[char]!;
    }

    _collectAllWords(current, normalizedPrefix, results);
    return results;
  }

  void _collectAllWords(TrieNode node, String prefix, List<String> results) {
    if (node.isEndOfWord) {
      results.add(prefix);
    }
    node.children.forEach((char, childNode) {
      _collectAllWords(childNode, prefix + char, results);
    });
  }

  List<String> findSimilarSymptoms(String input) {
    List<String> allWords = [];
    _collectAllWords(root, '', allWords);
    return allWords;
  }
}
