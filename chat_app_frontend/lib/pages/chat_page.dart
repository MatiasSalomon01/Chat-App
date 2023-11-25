import 'package:chat_app_frontend/helpers/sized_box_helper.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (notification) {
        notification.disallowIndicator();
        return false;
      },
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: Chat.mockData.length,
        itemBuilder: (context, index) {
          return CustomListTile(
            pageIndex: index,
            chat: Chat.mockData[index],
            lastIndex: Chat.mockData.length - 1,
          );
        },
        // separatorBuilder: (context, index) => verticalSpace(10),
      ),
    );
  }
}
