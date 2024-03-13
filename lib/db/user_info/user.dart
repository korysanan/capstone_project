class User {
  final int id;
  final int languageId;
  final String email;
  final String password;
  final String nickname;
  final bool isAdmin;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.languageId,
    required this.email,
    required this.password,
    required this.nickname,
    required this.isAdmin,
    required this.createdAt,
    required this.updatedAt,
  });

  // 데이터베이스로부터 객체를 생성하기 위한 메서드
  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json['id'],
    languageId: json['language_id'],
    email: json['email'],
    password: json['password'],
    nickname: json['nickname'],
    isAdmin: json['is_admin'] == 1,
    createdAt: DateTime.parse(json['created_at']),
    updatedAt: DateTime.parse(json['updated_at']),
  );

  // 객체를 데이터베이스로 전송하기 위한 맵으로 변환
  Map<String, dynamic> toMap() => {
    'id': id,
    'language_id': languageId,
    'email': email,
    'password': password,
    'nickname': nickname,
    'is_admin': isAdmin ? 1 : 0,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}
