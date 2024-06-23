class User {
  // final String token;
  final String username;
  final int userId;
  final int rolId;
  final int personaId;
  // final bool status;
  User(
      {required this.rolId,
      required this.personaId,
      required this.userId,
      required this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    print(json['data']);
    return User(
      rolId: json['data']['rol_id'],
      personaId: json['data']['persona_id'],
      username: json['data']['username'],
      userId: json['data']['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rolId': rolId,
      'personaId': personaId,
      'username': username,
      'userId': userId,
    };
  }
}
