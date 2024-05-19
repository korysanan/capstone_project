library globals;

import 'translate/translation_manager.dart';
String selectedLanguageCode = 'en'; // 기본 언어 코드

class Food {
  final int id;
  final String name;
  final String englishName;
  final String imageUrl;

  Food({required this.id, required this.name, required this.englishName, required this.imageUrl});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'],
      name: json['name'],
      englishName: json['englishName'],
      imageUrl: json['imageUrl'],
    );
  }
}

List<Food>? foods;

//const apiKey = '7f0cb90f-8897-474f-a7d0-570e0f6a5bd2:fx';
const apiKey = 'cc306a14-243b-4106-8133-633127ed6af8:fx';
String ODSay_apiKey = "NmHBe2KbysaotzsEo6+3ewb5Dke9KHGzmtW+QDXXvJM";
const googleTranslateApiKey = 'AIzaSyBq5r5xStMzDC56y1nx0HUoQdhi5JGOwJM';
//const googleTranslateApiKey = '';

// 글로벌 함수
String getText(String key) {
  return appTexts[selectedLanguageCode]?[key] ?? 'Undefined';
}

String? sessionId;
String? user_nickname;
String? user_email;
String? user_language;
int user_language_id = 18;

double my_latitude = 36.76327;
double my_longitude = 127.2820;
double arr_latitude = 37.4874119; //임시
double arr_longitude = 126.9116406; //임시
/*
double arr_latitude = 0.0;
double arr_longitude = 0.0;
*/
String? arr_restaurantName;

void updateUserLanguage(String newLanguage) {
  user_language = newLanguage;
}

void updateFoods(List<Food> newFoods) {
  foods = newFoods;
}

void setLanguageCode() {
  // user_language가 null이 아니고, 숫자로 변환 가능한 경우
  int? languageCode = int.tryParse(user_language ?? '');
  
  if (languageCode != null) {
    switch (languageCode) {
      case 1:
        selectedLanguageCode = 'ko'; // 한국어
        break;
      case 2:
        selectedLanguageCode = 'el'; // 그리스어
        break;
      case 3:
        selectedLanguageCode = 'nl'; // 네덜란드어
        break;
      case 4:
        selectedLanguageCode = 'no'; // 노르웨이어
        break;
      case 5:
        selectedLanguageCode = 'da'; // 덴마크어
        break;
      case 6:
        selectedLanguageCode = 'de'; // 독일어
        break;
      case 7:
        selectedLanguageCode = 'lv'; // 라트비아어
        break;
      case 8:
        selectedLanguageCode = 'ru'; // 러시아어
        break;
      case 9:
        selectedLanguageCode = 'ro'; // 루마니아어
        break;
      case 10:
        selectedLanguageCode = 'lt'; // 리투아니아어
        break;
      case 11:
        selectedLanguageCode = 'bg'; // 불가리아어
        break;
      case 12:
        selectedLanguageCode = 'sv'; // 스웨덴어
        break;
      case 13:
        selectedLanguageCode = 'es'; // 스페인어
        break;
      case 14:
        selectedLanguageCode = 'sk'; // 슬로바키아어
        break;
      case 15:
        selectedLanguageCode = 'sl'; // 슬로베니아어
        break;
      case 16:
        selectedLanguageCode = 'ar'; // 아랍어
        break;
      case 17:
        selectedLanguageCode = 'et'; // 에스토니아어
        break;
      case 18:
        selectedLanguageCode = 'en'; // 영어 (미국)
        break;
      case 19:
        selectedLanguageCode = 'eu'; // 영어 (영국)
        break;
      case 20:
        selectedLanguageCode = 'uk'; // 우크라이나어
        break;
      case 21:
        selectedLanguageCode = 'it'; // 이탈리아어
        break;
      case 22:
        selectedLanguageCode = 'id'; // 인도네시아어
        break;
      case 23:
        selectedLanguageCode = 'ja'; // 일본어
        break;
      case 24:
        selectedLanguageCode = 'zh'; // 중국어
        break;
      case 25:
        selectedLanguageCode = 'cs'; // 체코어
        break;
      case 26:
        selectedLanguageCode = 'tr'; // 터키어
        break;
      case 27:
        selectedLanguageCode = 'pt'; // 포르투갈어
        break;
      case 28:
        selectedLanguageCode = 'br'; // 포르투갈어 (브라질)
        break;
      case 29:
        selectedLanguageCode = 'pl'; // 폴란드어
        break;
      case 30:
        selectedLanguageCode = 'fr'; // 프랑스어
        break;
      case 31:
        selectedLanguageCode = 'fi'; // 핀란드어
        break;
      case 32:
        selectedLanguageCode = 'hu'; // 헝가리어
        break;
      default:
        selectedLanguageCode = 'en'; // 기본 값은 영어
        break;
    }
  }
}