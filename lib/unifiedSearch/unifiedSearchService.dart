import '../db/categoryFood.dart';
import '../db/article.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UnifiedSearchService {
  static const String url = 'https://api-v2.kfoodbox.click';

  static List<CategoryFood> toFoodList(List<dynamic> json) {
    List<CategoryFood> articles = [];
    for (var element in json) {
      articles.add(CategoryFood(
        id: element["id"],
        name: element['name'],
        englishName: element['englishName'],
      ));
    }
    return articles;
  }

  static Future<List<dynamic>> getFoodInfo(page, limit, query) async {
    try {
      final response = await http
          .get(Uri.parse('$url/foods?page=$page&limit=$limit&query=$query'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        List<CategoryFood> foods = toFoodList(jsonData['foods']);
        int totalCount = jsonData['totalCount'];
        if (limit == 1) {
          return [
            totalCount != 0,
            totalCount,
            foods.isNotEmpty ? foods[0] : null
          ];
        } else {
          return [totalCount != 0, totalCount, foods];
        }
      } else {
        print("Failed to get food. Status code: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static List<Article> toArticleList(List<dynamic> json) {
    List<Article> articles = [];
    for (var element in json) {
      articles.add(Article(
        id: element["id"],
        title: element['title'],
        content: element['content'],
        likeCount: element['likeCount'],
        commentCount: element['commentCount'],
        createdAt: element['createdAt'],
        nickname: element['nickname'],
      ));
    }
    return articles;
  }

  static Future<List<dynamic>> getCommunityInfo(query) async {
    try {
      String requestUrl = "$url/community-articles?limit=1&query=$query";

      final response = await http.get(Uri.parse(requestUrl));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        List<Article> articles = toArticleList(jsonData['articles']);
        int totalCount = jsonData['totalCount'];
        return [
          totalCount != 0,
          totalCount,
          articles.isNotEmpty ? articles[0] : null
        ];
      } else {
        print("Failed to get post. Status code: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<dynamic>> getRecipeInfo(query) async {
    try {
      String requestUrl = "$url/custom-recipe-articles?limit=1&query=$query";

      final response = await http.get(Uri.parse(requestUrl));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        List<Article> articles = toArticleList(jsonData['articles']);
        int totalCount = jsonData['totalCount'];
        return [
          totalCount != 0,
          totalCount,
          articles.isNotEmpty ? articles[0] : null
        ];
      } else {
        print("Failed to get post. Status code: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static String calUploadTime(String createdAt) {
    DateTime now = DateTime.now();
    try {
      DateTime created = DateTime.parse(createdAt);

      Duration diff = now.difference(created);
      if (!diff.isNegative) {
        if (diff.inMinutes < 60) {
          return '${diff.inMinutes} minutes ago';
        } else if (diff.inHours < 24)
          return '${diff.inHours} hours ago';
        else if (now.year == created.year)
          return '${created.month}/${created.day}';
      }
    } catch (e) {}
    return createdAt.split(' ').elementAt(0);
  }
}
