import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../globals.dart' as globals;
import 'custom-recipe-articles_bookmark_data.dart';

class RecipeBookmarkService {
  // 커뮤니티 북마크 조회
  static Future<void> fetchBookmarks() async {
    try {
      var response = await http.get(
        Uri.parse(
            'http://api.kfoodbox.click/my-custom-recipe-article-bookmarks'),
        headers: {
          'Accept': '*/*',
          'Cookie': globals.sessionId!,
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        if (data is Map<String, dynamic> && data.containsKey('bookmarks')) {
          RecipeBookmarkData.setBookmarks(data['bookmarks']);
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

  // 커뮤니티 북마크 추가
  static Future<void> addBookmark(int postId) async {
    try {
      var response = await http.post(
        Uri.parse(
            'http://api.kfoodbox.click/custom-recipe-articles/$postId/bookmark'),
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

  // 커뮤니티 북마크 삭제
  static Future<void> deleteBookmark(int postId) async {
    try {
      var response = await http.delete(
        Uri.parse(
            'http://api.kfoodbox.click/custom-recipe-articles/$postId/bookmark'),
        headers: {
          'Accept': '*/*',
          'Cookie': globals.sessionId!,
        },
      );

      if (response.statusCode == 200) {
        print("Bookmark deleted successfully.");
      } else {
        print("Failed to delete bookmark. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error delete bookmark: $e");
    }
  }

  // 커뮤니티 좋아요 생성
  static Future<void> addLike(int postId) async {
    try {
      var response = await http.post(
        Uri.parse(
            'http://api.kfoodbox.click/custom-recipe-articles/$postId/like'),
        headers: {
          'Accept': '*/*',
          'Cookie': globals.sessionId!,
        },
      );
      if (response.statusCode == 200) {
        print("Like added successfully.");
      } else {
        print("Failed to add Like. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error adding Like: $e");
    }
  }

  // 커뮤니티 좋아요 삭제
  static Future<void> deleteLike(int postId) async {
    try {
      var response = await http.delete(
        Uri.parse(
            'http://api.kfoodbox.click/custom-recipe-articles/$postId/like'),
        headers: {
          'Accept': '*/*',
          'Cookie': globals.sessionId!,
        },
      );
      if (response.statusCode == 200) {
        print("Like deleted successfully.");
      } else {
        print("Failed to deleted Like. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error deleted Like: $e");
    }
  }
}
