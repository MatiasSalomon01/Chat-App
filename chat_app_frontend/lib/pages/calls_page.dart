import 'package:chat_app_frontend/constants/colors.dart';
import 'package:chat_app_frontend/helpers/sized_box_helper.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';

class CallsPage extends StatelessWidget {
  const CallsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (notification) {
        notification.disallowIndicator();
        return false;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          children: [
            CustomListTileStory(
              story: Story(
                title: "Crear enlace de llama",
                subtitle: "Comparte un enlace para tu llamada de WhatsApp",
                totalStories: 0,
              ),
              padding: EdgeInsets.zero,
              isMe: true,
              showButton: false,
              customAvatar: const CircleAvatar(
                radius: 25,
                backgroundColor: green,
                child: Icon(
                  Icons.link,
                  color: secondary,
                  size: 28,
                ),
              ),
            ),
            verticalSpace(20),
            const Text(
              'Recientes',
              style: TextStyle(
                color: white,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            verticalSpace(24),
            ListView.separated(
              shrinkWrap: true,
              itemCount: Call.mockData.length,
              itemBuilder: (context, index) {
                return CustomListTileCall(
                  call: Call.mockData[index],
                );
              },
              separatorBuilder: (context, index) => verticalSpace(24),
            ),
          ],
        ),
      ),
    );
  }
}
