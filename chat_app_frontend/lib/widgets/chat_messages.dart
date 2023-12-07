import 'package:chat_app_frontend/extensions/datime_extensions.dart';
import 'package:chat_app_frontend/models/chat_last_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/supabase.dart';
import '../helpers/sized_box_helper.dart';
import '../models/models.dart';
import '../providers/supabase_provider.dart';
import 'message_bubble.dart';

class ChatMessages extends StatefulWidget {
  const ChatMessages({super.key, required this.receiverId});

  final int receiverId;

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  late Stream<dynamic> streamMessages;
  List<Message> messages = [];
  late SupabaseProvider provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<SupabaseProvider>(context, listen: false);
    getStreamMessages();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getStreamMessages() {
    streamMessages =
        provider.getStreamMessages(provider.myId, widget.receiverId);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return false;
        },
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              verticalSpace(5),
              StreamBuilder(
                stream: streamMessages,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: grey),
                    );
                  }

                  messages = (snapshot.data! as List<dynamic>)
                      .map((item) => Message.fromMap(item))
                      .where((message) =>
                          (message.senderId == provider.myId &&
                              message.receiverId == widget.receiverId) ||
                          (message.senderId == widget.receiverId &&
                              message.receiverId == provider.myId))
                      .toList();

                  messages = provider.putSeparators(messages);

                  if (messages.isEmpty) return Container();
                  int itemCount = messages.length;

                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: itemCount,
                    itemBuilder: (context, index) {
                      final Message message = messages[index];
                      return MessageBubble(
                        message: message,
                        isMe: message.senderId == provider.myId,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
