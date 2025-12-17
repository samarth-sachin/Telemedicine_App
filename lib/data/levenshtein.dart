class LevenshteinDistance {
  static int calculate(String s1, String s2) {
    String a = s1.toLowerCase();
    String b = s2.toLowerCase();

    List<List<int>> matrix = List.generate(
      a.length + 1,
      (i) => List.filled(b.length + 1, 0),
    );

    for (int i = 0; i <= a.length; i++) {
      matrix[i][0] = i;
    }

    for (int j = 0; j <= b.length; j++) {
      matrix[0][j] = j;
    }

    for (int i = 1; i <= a.length; i++) {
      for (int j = 1; j <= b.length; j++) {
        int cost = (a[i - 1] == b[j - 1]) ? 0 : 1;
        matrix[i][j] = [
          matrix[i - 1][j] + 1, // deletion
          matrix[i][j - 1] + 1, // insertion
          matrix[i - 1][j - 1] + cost, // substitution
        ].reduce((a, b) => a < b ? a : b);
      }
    }

    return matrix[a.length][b.length];
  }

  static String findClosestMatch(String input, List<String> candidates,
      {int threshold = 3}) {
    if (candidates.isEmpty) return '';

    String closestMatch = candidates[0];
    int minDistance = calculate(input, candidates[0]);

    for (String candidate in candidates) {
      int distance = calculate(input, candidate);
      if (distance < minDistance) {
        minDistance = distance;
        closestMatch = candidate;
      }
    }

    return minDistance <= threshold ? closestMatch : '';
  }

  static List<MapEntry<String, int>> findTopMatches(
      String input, List<String> candidates,
      {int topN = 3, int threshold = 4}) {
    List<MapEntry<String, int>> distances = [];

    for (String candidate in candidates) {
      int distance = calculate(input, candidate);
      if (distance <= threshold) {
        distances.add(MapEntry(candidate, distance));
      }
    }

    distances.sort((a, b) => a.value.compareTo(b.value));
    return distances.take(topN).toList();
  }

  static double calculateSimilarity(String s1, String s2) {
    int distance = calculate(s1, s2);
    int maxLength = s1.length > s2.length ? s1.length : s2.length;
    
    if (maxLength == 0) return 1.0;
    
    return 1.0 - (distance / maxLength);
  }
}
