// restaurant_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

// 서버로부터 데이터를 불러오는 함수
Future<Map<String, dynamic>?> fetchRestaurantsData(int koreaRegionId, int restaurantCategoryId) async {
  // API URL 구성
  Uri url = Uri.parse('http://api.kfoodbox.click/korea-restaurants?koreaRegionId=$koreaRegionId&restaurantCategoryId=$restaurantCategoryId');

  try {
    // GET 요청
    var response = await http.get(url, headers: {'accept': '*/*'});

    if (response.statusCode == 200) {
      return json.decode(utf8.decode(response.bodyBytes));  
    } else {
      // 서버 에러 처리
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    // 네트워크 또는 요청 에러 처리
    print('An error occurred: $e');
  }
}