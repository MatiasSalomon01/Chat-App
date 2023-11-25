import 'package:chat_app_frontend/helpers/sized_box_helper.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    final List<int> chats = [
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
    ];
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (notification) {
        notification.disallowIndicator();
        return false;
      },
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            padding: index == 0
                ? const EdgeInsets.only(
                    bottom: 12,
                    left: 12,
                    right: 12,
                    top: 20,
                  )
                : index == chats.length - 1
                    ? const EdgeInsets.only(
                        bottom: 20,
                        left: 12,
                        right: 12,
                        top: 12,
                      )
                    : const EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage:
                      NetworkImage("https://picsum.photos/20$index"),
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
                          const Text(
                            'Titulo',
                            style: TextStyle(color: white, fontSize: 17),
                          ),
                          Text(
                            '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
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
                              'Subtitulo',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: grey, fontSize: 14),
                            ),
                          ),
                          Transform.rotate(
                            angle: .5,
                            child: Icon(
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
          );
        },
        // separatorBuilder: (context, index) => verticalSpace(30),
        itemCount: chats.length,
      ),
    );
  }
}
