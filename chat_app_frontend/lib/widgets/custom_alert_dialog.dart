import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../models/models.dart';
import '../models/user.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      shape: const OutlineInputBorder(borderSide: BorderSide(width: 0)),
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
                      user.profilePictureUrl!,
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
                user.name,
                style: const TextStyle(color: white, fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
