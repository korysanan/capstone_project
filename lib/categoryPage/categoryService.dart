import '../db/categoryFood.dart';
import '../db/food.dart';
import '../db/categoryInfo.dart';
import '../db/foodcategory.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategorySerrvices {
  static const String url = 'https://api-v2.kfoodbox.click';

  static List<FoodCategory> toFoodCategory(List<dynamic> json) {
    List<FoodCategory> foodCategories = [];
    for (var element in json) {
      foodCategories.add(FoodCategory(
        id: element["id"],
        name: element["name"],
        englishName: element['englishName'],
        imageUrl: element["imageUrl"],
      ));
    }
    return foodCategories;
  }

  static Future<List<FoodCategory>> getCategories() async {
    try {
      final response = await http.get(Uri.parse('$url/food-categories'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        List<FoodCategory> foodCategories =
            toFoodCategory(jsonData['foodCategories']);

        return foodCategories;
      } else {
        return <FoodCategory>[];
      }
    } catch (e) {
      return <FoodCategory>[];
    }
  }

  static Future<FoodCategoryInfo> getCategoryInfo(categoryId) async {
    try {
      final response =
          await http.get(Uri.parse('$url/food-categories/$categoryId'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        FoodCategoryInfo categoryInfo = FoodCategoryInfo.fromJson(jsonData);
        return categoryInfo;
      } else {
        return FoodCategoryInfo(
            id: 0, name: '', englishName: '', explanation: '');
      }
    } catch (e) {
      return FoodCategoryInfo(
          id: 0, name: '', englishName: '', explanation: '');
    }
  }

  static List<CategoryFood> toCategoryFood(List<dynamic> json) {
    List<CategoryFood> categoryFoods = [];
    for (var element in json) {
      categoryFoods.add(CategoryFood(
        id: element["id"],
        name: element["name"],
        englishName: element["englishName"],
      ));
    }
    return categoryFoods;
  }

  static Future<List<CategoryFood>> getCategoryFoods(categoryId) async {
    try {
      final response =
          await http.get(Uri.parse('$url/food-categories/$categoryId/foods'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        List<CategoryFood> categoryFoods = toCategoryFood(jsonData['foods']);
        return categoryFoods;
      } else {
        return <CategoryFood>[];
      }
    } catch (e) {
      return <CategoryFood>[];
    }
  }

  static Future<Food> getFoodInfo(foodId) async {
    try {
      final response = await http.get(Uri.parse('$url/foods/$foodId'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        Food foodInfo = Food.fromJson(jsonData);
        return foodInfo;
      } else {
        return Food(
            id: 0,
            name: '',
            englishName: '',
            imageUrls: [],
            explanation: '',
            englishExplanation: '',
            explanationSource: '',
            recipeSource: '',
            recipeIngredients: [],
            recipeSequence: []);
      }
    } catch (e) {
      print(e);
      return Food(
          id: 0,
          name: '',
          englishName: '',
          imageUrls: [],
          explanation: '',
          englishExplanation: '',
          explanationSource: '',
          recipeSource: '',
          recipeIngredients: [],
          recipeSequence: []);
    }
  }
}
