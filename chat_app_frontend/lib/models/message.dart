class Message {
  final int id;
  final String text;
  final DateTime createdAt;
  final int senderId;
  final int receiverId;
  bool putSeparator;
  bool isSelected;

  Message({
    required this.id,
    required this.text,
    required this.createdAt,
    required this.senderId,
    required this.receiverId,
    this.putSeparator = false,
    this.isSelected = false,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      text: map['text'],
      createdAt: DateTime.parse(map['created_at']),
      senderId: map['sender_id'],
      receiverId: map['receiver_id'],
    );
  }
}
