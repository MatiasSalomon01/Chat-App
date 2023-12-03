class User {
  final int id;
  final String name;
  final String? profilePictureUrl;
  String? lastMessage;

  User({
    required this.id,
    required this.name,
    this.profilePictureUrl,
    this.lastMessage = "",
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['id'],
        name: map['name'],
        profilePictureUrl: map['profile_picture'],
        lastMessage: map["last_message"]);
  }
}
