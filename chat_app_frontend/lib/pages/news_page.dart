import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../helpers/sized_box_helper.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (notification) {
        notification.disallowIndicator();
        return false;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Estados',
                  style: TextStyle(
                    color: white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(Icons.more_vert, color: grey)
              ],
            ),
            CustomListTileStory(
              story: Story.mockData[0],
              isMe: true,
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 4),
            ),
            const Text(
              'Recientes',
              style: TextStyle(
                color: grey,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            verticalSpace(24),
            ListView.separated(
              shrinkWrap: true,
              itemCount: Story.mockData.length - 1,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return CustomListTileStory(
                  story: Story.mockData[index + 1],
                  padding: const EdgeInsets.symmetric(vertical: 0),
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
