import 'package:chat_app_frontend/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../helpers/sized_box_helper.dart';
import '../models/models.dart';
import '../models/user.dart';
import '../screens/screens.dart';

class CustomListTile extends StatefulWidget {
  const CustomListTile({
    super.key,
    required this.pageIndex,
    required this.user,
    required this.lastIndex,
  });

  final int pageIndex;
  final int lastIndex;
  final User user;

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: secondary,
      child: InkWell(
        splashFactory: InkRipple.splashFactory,
        overlayColor: MaterialStateProperty.all(hoverColor),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(user: widget.user),
          ),
        ),
        child: Container(
          padding: calculatePadding(widget.pageIndex, widget.lastIndex),
          color: isPressed ? hoverColor : transparent,
          child: Row(
            children: [
              GestureDetector(
                onTap: () => showProfilePictureModal(context),
                child: ProfilePicture(url: widget.user.profilePictureUrl),
              ),
              horizontalSpace(12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.user.name,
                          style: const TextStyle(
                            color: white,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          formatedDate(DateTime.now()),
                          style: const TextStyle(color: grey, fontSize: 13),
                        ),
                      ],
                    ),
                    verticalSpace(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.user.lastMessage!,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: grey, fontSize: 14),
                          ),
                        ),
                        if (false)
                          Transform.rotate(
                            angle: .5,
                            child: const Icon(
                              Icons.push_pin_rounded,
                              color: grey,
                              size: 20,
                            ),
                          )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showProfilePictureModal(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(user: widget.user),
    );
  }

  EdgeInsets calculatePadding(int pageIndex, int lastIndex) => pageIndex == 0
      ? const EdgeInsets.only(
          bottom: 12,
          left: 12,
          right: 12,
          top: 20,
        )
      : pageIndex == lastIndex
          ? const EdgeInsets.only(
              bottom: 20,
              left: 12,
              right: 12,
              top: 12,
            )
          : const EdgeInsets.all(12);

  String formatedDate(DateTime date) =>
      '${date.day}/${date.month}/${date.year}';
}
