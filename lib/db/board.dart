class Board {
  int id;
  String title;
  String content;
  bool isNotice;
  DateTime createdTime;

  // POST 형태에 따라 수정

  Board({
    required this.id,
    required this.title,
    required this.content,
    required this.isNotice,
    required this.createdTime,
  });
}
