// globals.dart
library globals;

String selectedLanguageCode = 'en'; // 기본 언어 코드
Map<String, Map<String, String>> appTexts = {
  'en': {
    'myPageTitle': 'MyPage',
    'guest' : 'Guest',
    'login': 'Login',
    'signUp': 'Sign up',
    'kFoodBoxTitle': 'K-Food Box',
    "today's recommended food" : "Today's Recommended Food",
    'viewAllKoreanFoods': 'View All Korean foods',
    'community': 'Community',
    'custom recipes': 'Custom Recipes',
  },
  'ko': {
    'myPageTitle': '마이페이지',
    'guest' : '게스트',
    'login': '로그인',
    'signUp': '회원가입',
    'kFoodBoxTitle': 'K-푸드 박스',
    "today's recommended food" : "오늘의 추천 음식",
    'viewAllKoreanFoods': '한국 음식 전체보기',
    'community': '커뮤니티',
    'custom recipes': '커스텀 레시피',
  },
  'ja': {
    'myPageTitle': 'マイページ',
    'guest' : 'ゲスト',
    'login': 'ログイン',
    'signUp': 'サインアップ',
    'kFoodBoxTitle': 'Kフードボックス',
    "today's recommended food" : "今日のおすすめ",
    'viewAllKoreanFoods': '全ての韓国食品を見る',
    'community': 'コミュニティ',
    'custom recipes': 'カスタムレシピ',
  },
  'zh': {
    'myPageTitle': '我的页面',
    'guest' : '访客',
    'login': '登录',
    'signUp': '注册',
    'kFoodBoxTitle': '韩国食品盒',
    "today's recommended food" : "今日推荐食品",
    'viewAllKoreanFoods': '查看所有韩国食品',
    'community': '社区',
    'custom recipes': '自定义食谱',
  },
};

String getText(String key) {
  return appTexts[selectedLanguageCode]?[key] ?? 'Undefined';
}
