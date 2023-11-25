import 'package:chat_app_frontend/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../helpers/sized_box_helper.dart';
import '../models/models.dart';

class CustomListTileStory extends StatelessWidget {
  const CustomListTileStory({
    super.key,
    required this.story,
    this.isMe = false,
    required this.padding,
  });

  final Story story;
  final bool isMe;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Row(
        children: [
          if (!isMe)
            Container(
              decoration: BoxDecoration(
                color: green,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xff25a663), width: 2),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: green,
                  shape: BoxShape.circle,
                  border: Border.all(color: secondary, width: 2),
                ),
                child: ProfilePicture(url: story.profilePictureUrl),
              ),
            )
          else
            Stack(
              children: [
                ProfilePicture(url: story.profilePictureUrl),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 22,
                    width: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xff00a884),
                      border: Border.all(color: secondary, width: 1.5),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: white,
                      size: 19,
                    ),
                  ),
                ),
              ],
            ),
          horizontalSpace(12),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  story.title,
                  style: const TextStyle(
                    color: white,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                verticalSpace(5),
                Text(
                  story.subtitle,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: grey, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
