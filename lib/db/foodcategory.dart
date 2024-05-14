class FoodCategory {
  int id;
  String name;
  String englishName;
  String imageUrl;

  FoodCategory({
    required this.id,
    required this.name,
    required this.englishName,
    required this.imageUrl,
  });

  factory FoodCategory.fromJson(Map<String, dynamic> json) {
    return FoodCategory(
      id: json['id'],
      name: json['name'],
      englishName: json['englishName'],
      imageUrl: json['imageUrl'],
    );
  }
}
