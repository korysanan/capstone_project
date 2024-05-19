import 'my_page_service.dart';

class MyPageData {
  // 자신이 작성한 게시물 리스트
  static List<dynamic> my_community_articles = [];
  static List<dynamic> my_recipe_articles = [];

  static void setCommunityArticle(List<dynamic> myArticles) {
    my_community_articles = myArticles;
  }

  static void setRecipeArticle(List<dynamic> myRecipes) {
    my_recipe_articles = myRecipes;
  }

  static List<String> getCommunityArticleNames() {
    return my_community_articles
        .map((article) => article['title'] as String)
        .toList();
  }

  static List<String> getRecipeArticleNames() {
    return my_recipe_articles
        .map((article) => article['title'] as String)
        .toList();
  }
}
