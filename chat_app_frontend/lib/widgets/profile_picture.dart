import 'package:flutter/material.dart';

import '../constants/colors.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
    required this.url,
  });

  final String? url;

  @override
  Widget build(BuildContext context) {
    var imageUrl = url ?? "https://picsum.photos/200";
    return CircleAvatar(
      backgroundColor: primary,
      radius: 25,
      backgroundImage: NetworkImage(imageUrl),
    );
  }
}
