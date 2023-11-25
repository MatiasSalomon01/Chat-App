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
      title: "Matias Salomon",
      subtitle: "Añade una actualización",
      profilePictureUrl: "https://picsum.photos/200",
      totalStories: 0,
    ),
    Story(
      title: "Titulo 1",
      subtitle: "hace 25 minutos",
      profilePictureUrl: "https://picsum.photos/200",
      totalStories: 2,
    ),
    Story(
      title: "Titulo 2",
      subtitle: "11:54",
      profilePictureUrl: "https://picsum.photos/200",
      totalStories: 1,
    ),
    Story(
      title: "03:56",
      subtitle: "Añade una actualización",
      profilePictureUrl: "https://picsum.photos/200",
      totalStories: 4,
    ),
    Story(
      title: "T15:32",
      subtitle: "Añade una actualización",
      profilePictureUrl: "https://picsum.photos/200",
      totalStories: 3,
    )
  ];
}
