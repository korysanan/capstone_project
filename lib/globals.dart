library globals;

//import 'package:shared_preferences/shared_preferences.dart';
import 'translate/translation_manager.dart';

// 글로벌 변수
int s = 1;
String selectedLanguageCode = 'en'; // 기본 언어 코드

final apiKey = '7f0cb90f-8897-474f-a7d0-570e0f6a5bd2:fx';

// 글로벌 함수
String getText(String key) {
  return appTexts[selectedLanguageCode]?[key] ?? 'Undefined';
}

String? sessionId;
String? user_nickname;
String? user_email;
String? user_language;