//import 'package:capstone_project/translate/language_detect.dart';

import 'foods_bookmark_service.dart';

class FoodBookmarkData {
  // 북마크 리스트 선언 
  static List<dynamic> foods_bookmarks = [];
  // 북마크 리스트에 저장

  static void setBookmarks(List<dynamic> newBookmarks) {
    foods_bookmarks = newBookmarks;
    print(foods_bookmarks);
  }

  // 북마크 이름만 보내기 (이거 마이페이지에서 사용)
  static List<String> getBookmarkNames() {
    return foods_bookmarks.map((bookmark) => bookmark['name'] as String).toList();
  }

  // 북마크 보유 여부 (true, false)
  static bool isBookmarked(int foodId) {
    return foods_bookmarks.any((bookmark) => bookmark['id'] as int == foodId);
  }

  // 북마크 삭제
  static void deleteBookmark(String foodName) {
    int? foodId;

    for (var bookmark in foods_bookmarks) {
      if (bookmark['name'] == foodName) {
        foodId = bookmark['id'] as int;
        FoodBookmarkService.deleteBookmark(foodId);
        break;
      }
    }
  }
}