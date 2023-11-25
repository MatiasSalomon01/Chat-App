class Story {
  final String title;
  final String subtitle;
  final String? profilePictureUrl;
  final int totalStories;

  Story({
    required this.title,
    required this.subtitle,
    this.profilePictureUrl,
    required this.totalStories,
  });

  static List<Story> mockData = [
    Story(
      title: "Mi estado",
      subtitle: "Añade una actualización",
      profilePictureUrl: "https://picsum.photos/200",
      totalStories: 0,
    ),
    Story(
      title: "Titulo 1",
      subtitle: "hace 25 minutos",
      profilePictureUrl: "https://picsum.photos/201",
      totalStories: 2,
    ),
    Story(
      title: "Titulo 2",
      subtitle: "11:54",
      profilePictureUrl: "https://picsum.photos/202",
      totalStories: 1,
    ),
    Story(
      title: "Titulo 3",
      subtitle: "03:56",
      profilePictureUrl: "https://picsum.photos/203",
      totalStories: 4,
    ),
    Story(
      title: "Titulo 4",
      subtitle: "15:32",
      profilePictureUrl: "https://picsum.photos/204",
      totalStories: 3,
    )
  ];
}
