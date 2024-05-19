import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../globals.dart' as globals;
import 'my_page_data.dart';

class MyPageService {
  static Future<void> fetchUserArticles() async {
    try {
      var response = await http.get(
        Uri.parse('http://api.kfoodbox.click/my-articles'),
        headers: {
          'Accept': '*/*',
          'Cookie': globals.sessionId!,
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        if (data is Map<String, dynamic> &&
            data.containsKey('communityArticles')) {
          MyPageData.setCommunityArticle(data['communityArticles']);
        } else {
          print("No community article found in response or not a list");
        }
        if (data is Map<String, dynamic> &&
            data.containsKey('customRecipeArticles')) {
          MyPageData.setRecipeArticle(data['customRecipeArticles']);
        } else {
          print("No reipce article found in response or not a list");
        }
      } else {
        print("Failed to fetch bookmarks. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching bookmarks: $e");
    }
  }
}
