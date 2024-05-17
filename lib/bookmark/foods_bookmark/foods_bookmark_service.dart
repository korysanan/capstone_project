import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../globals.dart' as globals;
import 'foods_bookmark_data.dart';

class FoodBookmarkService {
  // 음식 북마크 조회
  static Future<void> fetchBookmarks() async {
    try {
      var response = await http.get(
        Uri.parse('http://api.kfoodbox.click/my-food-bookmarks'),
        headers: {
          'Accept': '*/*',
          'Cookie': globals.sessionId!,
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        if (data is Map<String, dynamic> && data.containsKey('bookmarks')) {
          FoodBookmarkData.setBookmarks(data['bookmarks']);
        } else {
          print("No 'bookmarks' key found in response or not a list");
        }
      } else {
        print("Failed to fetch bookmarks. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching bookmarks: $e");
    }
  }

  // 음식 북마크 추가
  static Future<void> addBookmark(int foodId) async {
    try {
      var response = await http.post(
        Uri.parse('http://api.kfoodbox.click/foods/$foodId/bookmark'),
        headers: {
          'Accept': '*/*',
          'Cookie': globals.sessionId!,
        },
      );

      if (response.statusCode == 200) {
        print("Bookmark added successfully.");
      } else {
        print("Failed to add bookmark. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error adding bookmark: $e");
    }
  }

  // 음식 북마크 삭제
  static Future<void> deleteBookmark(int foodId) async {
    try {
      var response = await http.delete(
        Uri.parse('http://api.kfoodbox.click/foods/$foodId/bookmark'),
        headers: {
          'Accept': '*/*',
          'Cookie': globals.sessionId!,
        },
      );

      if (response.statusCode == 200) {
        print("Bookmark deleted successfully.");
      } else {
        print("Failed to add bookmark. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error adding bookmark: $e");
    }
  }
}
