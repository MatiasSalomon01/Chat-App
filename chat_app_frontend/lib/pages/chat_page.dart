import 'package:chat_app_frontend/helpers/sized_box_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../models/models.dart';
import '../providers/supabase_provider.dart';
import '../widgets/widgets.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // late final Future<List<User>> data;

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<List<User>> getUsers() =>
      Provider.of<SupabaseProvider>(context, listen: false).getUsers();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUsers(),
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
