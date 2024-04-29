class Comment {
  int id;
  int userId;
  bool isMine;
  String nickname;
  String createdAt;
  String? updatedAt;
  String content;

  Comment({
    required this.id,
    required this.userId,
    required this.isMine,
    required this.nickname,
    required this.createdAt,
    required this.updatedAt,
    required this.content,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        userId: json["userId"],
        isMine: json["isMine"],
        nickname: json['nickname'],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        content: json["content"],
      );
}
