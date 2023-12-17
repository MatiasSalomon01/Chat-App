import 'package:animate_do/animate_do.dart';
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
  late final ScrollController _controller;
  bool showGoBeginning = false;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<SupabaseProvider>(context, listen: false);
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.offset > kToolbarHeight) {
        if (!showGoBeginning) setState(() => showGoBeginning = true);
      }

      if (_controller.offset < kToolbarHeight) {
        if (showGoBeginning) setState(() => showGoBeginning = false);
      }
    });
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
        child: Stack(
          // mainAxisSize: MainAxisSize.min,
          children: [
            SingleChildScrollView(
              reverse: true,
              controller: _controller,
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
            if (showGoBeginning)
              _GoBeginningButton(onTap: () => _controller.jumpTo(0)),
          ],
        ),
      ),
    );
  }
}

class _GoBeginningButton extends StatelessWidget {
  const _GoBeginningButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 5,
      right: 15,
      child: ZoomIn(
        duration: const Duration(milliseconds: 200),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: primary,
            ),
            child: const Icon(
              Icons.keyboard_double_arrow_down_rounded,
              color: grey,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
