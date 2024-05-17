import 'community_bookmark_service.dart';

class CommunityBookmarkData {
  // 북마크 리스트 선언
  static List<dynamic> communities_bookmarks = [];
  static List<dynamic> communities_likes = [];

  // 북마크 리스트에 저장
  static void setBookmarks(List<dynamic> newBookmarks) {
    communities_bookmarks = newBookmarks;
  }

  // 북마크 이름만 보내기 (이거 마이페이지에서 사용)
  static List<String> getBookmarkNames() {
    return communities_bookmarks
        .map((bookmark) => bookmark['title'] as String)
        .toList();
  }

  // 북마크 보유 여부 (true, false)
  static bool isBookmarked(int postId) {
    return communities_bookmarks
        .any((bookmark) => bookmark['id'] as int == postId);
  }

  // 북마크 삭제
  static void deleteBookmark(String communityTitle) {
    int? postId;

    for (var bookmark in communities_bookmarks) {
      if (bookmark['title'] == communityTitle) {
        postId = bookmark['id'] as int;
        CommunityBookmarkService.deleteBookmark(postId);
        break;
      }
    }
  }
}
