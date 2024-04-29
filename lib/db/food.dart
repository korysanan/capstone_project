class Food {
  int id;
  String name;
  String englishName;
  List<dynamic> imageUrls;
  String explanation;
  String englishExplanation;
  String explanationSource;
  String recipeSource;
  List<dynamic> recipeIngredients; // db 자료형에따라 수정
  List<dynamic> recipeSequence;

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

  static List<RecipeSequence> getRecipeSequence(List<dynamic> list) {
    List<RecipeSequence> recipeSequence = [];
    for (var element in list) {
      recipeSequence.add(RecipeSequence(
          sequenceNum: element['sequenceNumber'], content: element['content']));
    }
    return recipeSequence;
  }

  factory Food.fromJson(Map<String, dynamic> json) => Food(
      id: json["id"],
      name: json["name"],
      englishName: json["englishName"],
      imageUrls: json["imageUrls"],
      explanation: json["explanation"],
      englishExplanation: json["englishExplanation"],
      explanationSource: json["explanationSource"],
      recipeSource: json["recipeSource"],
      recipeIngredients: json["recipeIngredients"],
      recipeSequence: getRecipeSequence(json['recipeSequence']));
}

class RecipeSequence {
  int sequenceNum;
  String content;

  RecipeSequence({
    required this.sequenceNum,
    required this.content,
  });
}
