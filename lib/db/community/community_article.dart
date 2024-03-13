class CommunityArticle {
  int id;
  int userId;
  String title;
  String content;
  bool isNotice;
  DateTime createdAt;
  DateTime updatedAt;

  CommunityArticle({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.isNotice,
    required this.createdAt,
    required this.updatedAt,
  });
}