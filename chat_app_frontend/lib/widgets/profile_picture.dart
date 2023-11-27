import 'package:flutter/material.dart';

import '../constants/colors.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
    required this.url,
    this.radius = 25,
  });

  final String? url;
  final double radius;

  @override
  Widget build(BuildContext context) {
    var imageUrl = url ?? "https://picsum.photos/200";
    return CircleAvatar(
      backgroundColor: primary,
      radius: radius,
      backgroundImage: NetworkImage(imageUrl),
    );
  }
}
