class FoodCategoryInfo {
  int id;
  String name;
  String englishName;
  String explanation;

  FoodCategoryInfo({
    required this.id,
    required this.name,
    required this.englishName,
    required this.explanation,
  });

  factory FoodCategoryInfo.fromJson(Map<String, dynamic> json) =>
      FoodCategoryInfo(
        id: json["id"],
        name: json["name"],
        englishName: json["englishName"],
        explanation: json["explanation"],
      );
}
