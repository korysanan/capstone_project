import 'package:http/http.dart' as http;
import 'dart:convert';
import '../globals.dart' as globals;

Future<void> updateUserLanguage(int languageId) async {
  String url = 'http://api.kfoodbox.click/my-language';
  try {
    var response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Cookie': globals.sessionId!, // Send session ID in headers
      },
      body: jsonEncode(<String, int>{
        'languageId': languageId
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      // 언어 설정 업데이트 성공
      globals.user_language = languageId.toString();  // 전역 변수 업데이트
      print('Language updated to ID: $languageId');
    } else {
      var responseBody = utf8.decode(response.bodyBytes);
      print('Failed to update language: $responseBody');
    }
  } catch (e) {
    print('Error updating language: $e');
  }
}
