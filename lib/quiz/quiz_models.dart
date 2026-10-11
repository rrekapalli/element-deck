class QuizQuestion {
  QuizQuestion({
    required this.id,
    required this.category,
    required this.stem,
    required this.options,
    required this.correctIndex,
    required this.explanation,
    this.equation,
  });

  final String id;
  final String category;
  final String stem;
  final List<String> options;
  final int correctIndex;
  final String explanation;
  final String? equation;

  String get categoryLabel => quizCategoryLabel(category);

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      id: json['id'] as String,
      category: json['category'] as String,
      stem: json['stem'] as String,
      options: (json['options'] as List<dynamic>).map((e) => '$e').toList(),
      correctIndex: (json['correctIndex'] as num).toInt(),
      explanation: json['explanation'] as String? ?? '',
      equation: json['equation'] as String?,
    );
  }
}

class QuizBank {
  QuizBank({required this.z, required this.levels});

  final int z;
  final Map<String, List<QuizQuestion>> levels;

  List<QuizQuestion> poolFor(String depth) {
    return levels[depth] ?? levels['intermediate'] ?? const [];
  }

  factory QuizBank.fromJson(Map<String, dynamic> json) {
    final raw = json['levels'] as Map<String, dynamic>? ?? {};
    return QuizBank(
      z: (json['z'] as num).toInt(),
      levels: {
        for (final e in raw.entries)
          e.key: (e.value as List<dynamic>)
              .map((q) => QuizQuestion.fromJson(q as Map<String, dynamic>))
              .toList(),
      },
    );
  }
}

String quizCategoryLabel(String category) {
  return switch (category) {
    'identity' => 'Identity',
    'electron_orbitals' => 'Electron Orbitals',
    'protons_nuclei' => 'Protons & Nuclei',
    'physical_properties' => 'Physical Properties',
    'engineering_uses' => 'Engineering Uses',
    'discovery_history' => 'Discovery & History',
    'light_reactions' => 'Light & Reactions',
    'neighbor_compare' => 'Neighbor Compare',
    _ => category,
  };
}

String quizTierName(int finishedPools) {
  if (finishedPools <= 0) return 'Observer';
  if (finishedPools <= 4) return 'Student';
  if (finishedPools <= 14) return 'Scholar';
  if (finishedPools <= 39) return 'Fellow';
  return 'Master';
}
