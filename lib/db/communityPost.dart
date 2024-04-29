class CommunityPost {
  int id;
  int userId;
  bool isMine;
  bool isBookmarked;
  bool like;
  String title;
  String content;
  List<dynamic> imageUrls;
  String createdAt;
  String? updatedAt;
  String nickname;
  int likeCount;
  int commentCount;

  CommunityPost({
    required this.id,
    required this.userId,
    required this.isMine,
    required this.isBookmarked,
    required this.like,
    required this.title,
    required this.content,
    required this.imageUrls,
    required this.createdAt,
    required this.updatedAt,
    required this.nickname,
    required this.likeCount,
    required this.commentCount,
  });

  factory CommunityPost.fromJson(Map<String, dynamic> json) => CommunityPost(
        id: json["id"],
        userId: json["userId"],
        isMine: json["isMine"],
        isBookmarked: json["isBookmarked"],
        like: json["like"],
        title: json["title"],
        content: json["content"],
        imageUrls: json["imageUrls"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        nickname: json['nickname'],
        likeCount: json['likeCount'],
        commentCount: json['commentCount'],
      );
}
