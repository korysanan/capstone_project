library globals;

import 'translate/translation_manager.dart';

String selectedLanguageCode = 'ko'; // 기본 언어 코드

final apiKey = '7f0cb90f-8897-474f-a7d0-570e0f6a5bd2:fx';
String ODSay_apiKey = "NmHBe2KbysaotzsEo6+3ewb5Dke9KHGzmtW+QDXXvJM";

// 글로벌 함수
String getText(String key) {
  return appTexts[selectedLanguageCode]?[key] ?? 'Undefined';
}

String? sessionId;
String? user_nickname;
String? user_email;
String? user_language;

void setLanguageCode() {
  // user_language가 null이 아니고, 숫자로 변환 가능한 경우
  int? languageCode = int.tryParse(user_language ?? '');
  
  if (languageCode != null) {
    switch (languageCode) {
      case 1:
        selectedLanguageCode = 'ko'; // 한국어
        break;
      default:
        selectedLanguageCode = 'en'; // 기본 값은 영어
        break;
    }
  }
}