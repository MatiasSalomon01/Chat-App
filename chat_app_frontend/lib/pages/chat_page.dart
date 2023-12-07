import 'package:chat_app_frontend/helpers/sized_box_helper.dart';
import 'package:chat_app_frontend/models/chat_last_message.dart';
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
  late Stream<dynamic> streamUsers;
  late SupabaseProvider provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<SupabaseProvider>(context, listen: false);
    // getUsers();
    getStreamMessages();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Future<void> getUsers() async => await provider.getUsers();

  void getStreamMessages() {
    streamUsers = provider.getStreamUsers(provider.myId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: streamUsers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: grey),
          );
        }
        if (!snapshot.hasData) return Container();

        final chatLastMessages = (snapshot.data! as List<dynamic>)
            .map((item) => ChatLastMessage.fromMap(item))
            .toList();

        final users = provider.users
            .where((element) => element.id != provider.myId)
            .toList();

        for (var user in users) {
          var fdfd = chatLastMessages.any((element) =>
              element.senderId == provider.myId &&
              element.receiverId == user.id);
          if (!fdfd) continue;

          user.lastMessage = chatLastMessages
              .firstWhere((element) =>
                  element.senderId == provider.myId &&
                  element.receiverId == user.id)
              .text;
        }

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
