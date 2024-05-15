class RecipePost {
  int id;
  int userId;
  bool isMine;
  bool isBookmarked;
  bool like;
  String title;
  String content;
  List<Map<String, dynamic>> sequences;
  List<Map<String, dynamic>> ingredients;
  List<String> imageUrls;
  String createdAt;
  String? updatedAt;
  String nickname;
  int likeCount;
  int commentCount;

  RecipePost({
    required this.id,
    required this.userId,
    required this.isMine,
    required this.isBookmarked,
    required this.like,
    required this.title,
    required this.content,
    required this.sequences,
    required this.ingredients,
    required this.imageUrls,
    required this.createdAt,
    required this.updatedAt,
    required this.nickname,
    required this.likeCount,
    required this.commentCount,
  });

  factory RecipePost.fromJson(Map<String, dynamic> json) {
    return RecipePost(
      id: json['id'],
      userId: json['userId'],
      isMine: json['isMine'],
      isBookmarked: json['isBookmarked'],
      like: json['like'],
      title: json['title'],
      content: json['content'],
      sequences: List<Map<String, dynamic>>.from(json['sequences']),
      ingredients: List<Map<String, dynamic>>.from(json['ingredients']),
      imageUrls: List<String>.from(json['imageUrls']),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      nickname: json['nickname'],
      likeCount: json['likeCount'],
      commentCount: json['commentCount'],
    );
  }
}
