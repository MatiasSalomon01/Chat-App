class ChatLastMessage {
  final int senderId;
  final int receiverId;
  final String text;
  final DateTime date;

  ChatLastMessage({
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.date,
  });

  factory ChatLastMessage.fromMap(Map<String, dynamic> map) {
    return ChatLastMessage(
      senderId: map['sender_id'],
      receiverId: map['receiver_id'],
      text: map['text'],
      date: DateTime.parse(map["date"]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sender_id': senderId,
      'receiver_id': receiverId,
      'text': text,
      "date": date.toIso8601String(),
    };
  }
}
