import 'package:chat_app_frontend/helpers/sized_box_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../models/models.dart';
import '../providers/supabase_provider.dart';
import '../widgets/widgets.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<SupabaseProvider>(context).getUsers();

    return FutureBuilder(
      future: data,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: grey),
          );
        }

        final users = snapshot.data!;
        return NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowIndicator();
            return false;
          },
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: users.length,
            itemBuilder: (context, index) {
              return CustomListTile(
                pageIndex: index,
                user: users[index],
                lastIndex: users.length - 1,
              );
            },
            // separatorBuilder: (context, index) => verticalSpace(10),
          ),
        );
      },
    );
  }
}
