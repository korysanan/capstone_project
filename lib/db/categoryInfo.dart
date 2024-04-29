class FoodCategoryInfo {
  int id;
  String name;
  String explanation;

  FoodCategoryInfo({
    required this.id,
    required this.name,
    required this.explanation,
  });

  factory FoodCategoryInfo.fromJson(Map<String, dynamic> json) =>
      FoodCategoryInfo(
        id: json["id"],
        name: json["name"],
        explanation: json["explanation"],
      );
}
