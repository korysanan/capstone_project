import "translate/language/lang_en.dart";
import "translate/language/lang_ko.dart";
import "translate/language/lang_ja.dart";
import "translate/language/lang_zh.dart";

int s = 1; // 세션

String selectedLanguageCode = 'en'; // 기본 언어 코드

Map<String, Map<String, String>> appTexts = {
  'en': langEn,
  'ko': langKo,
  'ja': langJa,
  'zh': langZh,
};

String getText(String key) {
  return appTexts[selectedLanguageCode]?[key] ?? 'Undefined';
}

