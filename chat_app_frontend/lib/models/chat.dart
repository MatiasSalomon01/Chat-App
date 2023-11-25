class Chat {
  final String name;
  final String lastMessage;
  final DateTime date;
  final bool isFixed;
  final String? profilePictureUrl;

  Chat({
    required this.name,
    required this.lastMessage,
    required this.date,
    this.isFixed = false,
    this.profilePictureUrl,
  });

  static List<Chat> getMockData() {
    return [
      Chat(
        name: "Titulo 1",
        lastMessage: "Esta es el ultimo mensaje enviado",
        date: DateTime.now(),
        isFixed: true,
        profilePictureUrl: "https://picsum.photos/200",
      ),
      Chat(
        name: "Titulo 2",
        lastMessage: "Esta es el ultimo mensaje enviado",
        date: DateTime.now(),
        profilePictureUrl: "https://picsum.photos/201",
      ),
      Chat(
        name: "Titulo 3",
        lastMessage: "Esta es el ultimo mensaje enviado",
        date: DateTime.now(),
        profilePictureUrl: "https://picsum.photos/202",
      ),
      Chat(
        name: "Titulo 4",
        lastMessage: "Esta es el ultimo mensaje enviado",
        date: DateTime.now(),
      ),
      Chat(
        name: "Titulo 5",
        lastMessage: "Esta es el ultimo mensaje enviado",
        date: DateTime.now(),
      ),
      Chat(
        name: "Titulo 6",
        lastMessage: "Esta es el ultimo mensaje enviado",
        date: DateTime.now(),
        profilePictureUrl: "https://picsum.photos/203",
      ),
      Chat(
        name: "Titulo 7",
        lastMessage: "Esta es el ultimo mensaje enviado",
        date: DateTime.now(),
      ),
      Chat(
        name: "Titulo 8",
        lastMessage: "Esta es el ultimo mensaje enviado",
        date: DateTime.now(),
      ),
      Chat(
        name: "Titulo 9",
        lastMessage: "Esta es el ultimo mensaje enviado",
        date: DateTime.now(),
      ),
      Chat(
        name: "Titulo 10",
        lastMessage: "Esta es el ultimo mensaje enviado",
        date: DateTime.now(),
      ),
    ];
  }
}
