class Article {
  int id;
  String title;
  String content;
  int likeCount;
  int commentCount;
  String createdAt;
  String nickname;

  Article({
    required this.id,
    required this.title,
    required this.content,
    required this.likeCount,
    required this.commentCount,
    required this.createdAt,
    required this.nickname,
  });
  factory Article.fromJson(Map<String, dynamic> json) => Article(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        likeCount: json['likeCount'],
        commentCount: json['commentCount'],
        createdAt: json["createdAt"],
        nickname: json['nickname'],
      );
}
