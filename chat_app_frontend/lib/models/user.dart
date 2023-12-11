class User {
  final int? id;
  final String name;
  final String? profilePictureUrl;
  String? lastMessage;
  DateTime? lastMessageDate;

  User({
    this.id,
    required this.name,
    this.profilePictureUrl,
    this.lastMessage,
    this.lastMessageDate,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      profilePictureUrl: map['profile_picture'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profile_picture': profilePictureUrl,
    };
  }
}
