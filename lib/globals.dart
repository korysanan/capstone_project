import 'translate/translation_manager.dart';

int s = 0;

final apiKey = '7f0cb90f-8897-474f-a7d0-570e0f6a5bd2:fx';
String selectedLanguageCode = 'en'; // 기본 언어 코드

String getText(String key) {
  return appTexts[selectedLanguageCode]?[key] ?? 'Undefined';
}