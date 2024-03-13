class Food {
  int id;
  int foodCategoryId;
  String name;
  int labelId;
  String explanation;
  String explanationSource;
  String recipeSource;

  Food({
    required this.id,
    required this.foodCategoryId,
    required this.name,
    required this.labelId,
    required this.explanation,
    required this.explanationSource,
    required this.recipeSource,
  });
}