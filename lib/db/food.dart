class Food {
  final int id;
  final String name;
  final String englishName;
  final List<String> imageUrls;
  final String explanation;
  final String englishExplanation;
  final String? explanationSource;
  final String? recipeSource;
  final List<Map<String, dynamic>> recipeIngredients;
  final List<Map<String, dynamic>> recipeSequence;

  Food({
    required this.id,
    required this.name,
    required this.englishName,
    required this.imageUrls,
    required this.explanation,
    required this.englishExplanation,
    required this.explanationSource,
    required this.recipeSource,
    required this.recipeIngredients,
    required this.recipeSequence,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'],
      name: json['name'],
      englishName: json['englishName'],
      imageUrls: List<String>.from(json['imageUrls']),
      explanation: json['explanation'],
      englishExplanation: json['englishExplanation'],
      explanationSource: json['explanationSource'],
      recipeSource: json['recipeSource'],
      recipeIngredients:
          List<Map<String, dynamic>>.from(json['recipeIngredients']),
      recipeSequence: List<Map<String, dynamic>>.from(json['recipeSequence']),
    );
  }
}
