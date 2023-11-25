import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../models/models.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.chat,
  });

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.topCenter,
      contentPadding: EdgeInsets.zero,
      shadowColor: transparent,
      insetPadding: const EdgeInsets.only(top: kToolbarHeight * 1.8),
      content: Container(
        height: 350,
        color: secondary,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: CircleAvatar(
                    radius: double.infinity,
                    backgroundImage: NetworkImage(
                      chat.profilePictureUrl ?? "https://picsum.photos/200",
                    ),
                  ),
                ),
                Container(
                  height: .2,
                  width: double.infinity,
                  color: grey,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Icon(
                        Icons.chat,
                        color: green,
                      ),
                      Icon(
                        Icons.call,
                        color: green,
                      ),
                      Icon(
                        Icons.videocam_rounded,
                        color: green,
                      ),
                      Icon(
                        Icons.info_outline,
                        color: green,
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
              color: Colors.black.withOpacity(.2),
              width: double.infinity,
              height: 45,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                chat.name,
                style: const TextStyle(color: white, fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
