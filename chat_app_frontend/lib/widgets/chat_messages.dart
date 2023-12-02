import 'package:chat_app_frontend/extensions/datime_extensions.dart';
import 'package:chat_app_frontend/models/chat_last_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/supabase.dart';
import '../helpers/sized_box_helper.dart';
import '../models/models.dart';
import '../providers/supabase_provider.dart';

class ChatMessages extends StatefulWidget {
  const ChatMessages({super.key, required this.receiverId});

  final int receiverId;

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  // late final Future<List<Message>> futureMessages;
  late Stream<dynamic> streamMessages;
  List<Message> messages = [];
  late SupabaseProvider provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<SupabaseProvider>(context, listen: false);
    // getMessages();
    getStreamMessages();
  }

  @override
  void dispose() {
    final lastMessage = ChatLastMessage(
      senderId: myId,
      receiverId: widget.receiverId,
      text: messages.last.text,
      date: DateTime.now(),
    );

    provider.insertLastMessage(lastMessage);
    super.dispose();
  }

  // void getMessages() {
  //   futureMessages = Provider.of<SupabaseProvider>(context, listen: false)
  //       .getMessages(myId, widget.receiverId);
  // }

  void getStreamMessages() {
    streamMessages = provider.getStreamMessages(myId, widget.receiverId);
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
                          (message.senderId == myId &&
                              message.receiverId == widget.receiverId) ||
                          (message.senderId == widget.receiverId &&
                              message.receiverId == myId))
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
                      bool isMe = message.senderId == myId;

                      return Container(
                        margin: isMe
                            ? const EdgeInsets.only(left: 50)
                            : const EdgeInsets.only(right: 50),
                        child: Column(
                          children: [
                            if (message.putSeparator) verticalSpace(8),
                            Align(
                              alignment: isMe
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: isMe ? userGreen : primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      message.text,
                                      style: const TextStyle(color: white),
                                    ),
                                    horizontalSpace(10),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        message.createdAt.getHour(),
                                        style: TextStyle(
                                          color: white.withOpacity(.6),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
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
