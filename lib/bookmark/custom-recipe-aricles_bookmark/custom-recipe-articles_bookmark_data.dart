import 'custom-recipe-articles_bookmark_service.dart';

class RecipeBookmarkData {
  // 북마크 리스트 선언
  static List<dynamic> recipe_bookmarks = [];
  static List<dynamic> recipe_likes = [];

  // 북마크 리스트에 저장
  static void setBookmarks(List<dynamic> newBookmarks) {
    recipe_bookmarks = newBookmarks;
  }

  // 북마크 이름만 보내기 (이거 마이페이지에서 사용)
  static List<String> getBookmarkNames() {
    return recipe_bookmarks
        .map((bookmark) => bookmark['title'] as String)
        .toList();
  }

  // 북마크 보유 여부 (true, false)
  static bool isBookmarked(int postId) {
    return recipe_bookmarks.any((bookmark) => bookmark['id'] as int == postId);
  }

  // 북마크 삭제
  static void deleteBookmark(String communityTitle) {
    int? postId;

    for (var bookmark in recipe_bookmarks) {
      if (bookmark['title'] == communityTitle) {
        postId = bookmark['id'] as int;
        RecipeBookmarkService.deleteBookmark(postId);
        break;
      }
    }
  }
}
