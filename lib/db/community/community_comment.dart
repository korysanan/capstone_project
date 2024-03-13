class CommunityComment {
  int id;
  int communityArticleId;
  int userId;
  String content;
  DateTime createdAt;
  DateTime updatedAt;

  CommunityComment({
    required this.id,
    required this.communityArticleId,
    required this.userId,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });
}