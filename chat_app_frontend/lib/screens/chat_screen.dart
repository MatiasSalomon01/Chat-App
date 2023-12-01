import 'package:chat_app_frontend/constants/colors.dart';
import 'package:chat_app_frontend/constants/supabase.dart';
import 'package:chat_app_frontend/helpers/sized_box_helper.dart';
import 'package:chat_app_frontend/models/models.dart';
import 'package:chat_app_frontend/models/user.dart';
import 'package:chat_app_frontend/providers/supabase_provider.dart';
import 'package:chat_app_frontend/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.user});
  final User user;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final messages = [
    //   MockDataChat(text: "ASdasdasdsa", isMe: true, putSeperator: false),
    //   MockDataChat(text: "asd", isMe: true, putSeperator: true),
    //   MockDataChat(text: "ASdasdfgdfgdasdsa", isMe: false, putSeperator: true),
    //   MockDataChat(text: "dfg", isMe: true, putSeperator: false),
    //   MockDataChat(text: "ASdasdasdsa", isMe: true, putSeperator: true),
    //   MockDataChat(text: "fdgdfg", isMe: false, putSeperator: true),
    //   MockDataChat(text: "ASdasdasdsa", isMe: true, putSeperator: true),
    //   MockDataChat(text: "rty", isMe: false, putSeperator: false),
    //   MockDataChat(text: "ASdasrtydasdsa", isMe: false, putSeperator: true),
    //   MockDataChat(text: "rtyrty", isMe: true, putSeperator: true),
    //   MockDataChat(text: "ASdasdasdsa", isMe: false, putSeperator: true),
    //   MockDataChat(text: "rtytr", isMe: true, putSeperator: true),
    //   MockDataChat(text: "ASdasgfhfghdasdsa", isMe: false, putSeperator: true),
    //   MockDataChat(
    //       text: "ASdahgfghgfsdasdsaaaaaaaaaaaaaaaa",
    //       isMe: true,
    //       putSeperator: true),
    //   MockDataChat(text: "ASdasdasdsa", isMe: false, putSeperator: true),
    //   MockDataChat(text: "rtytr", isMe: true, putSeperator: true),
    //   MockDataChat(text: "ASdasgfhfghdasdsa", isMe: false, putSeperator: true),
    // ];
    // final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: secondary,
      appBar: CustomAppBarChat(user: widget.user),
      body: Stack(
        children: [
          Column(
            children: [
              ChatMessages(receiverId: widget.user.id),
              TextFieldAndFloatingButton(receiverId: widget.user.id)
            ],
          ),
        ],
      ),
    );
  }
}

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key, required this.receiverId});

  final int receiverId;

  @override
  Widget build(BuildContext context) {
    final futureMessages =
        Provider.of<SupabaseProvider>(context).getMessages(myId, receiverId);

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
              FutureBuilder(
                future: futureMessages,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: grey),
                    );
                  }

                  var messages = snapshot.data!;
                  if (messages.isEmpty) return Container();

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      var isMe = messages[index].senderId == myId;
                      return Container(
                        margin: isMe
                            ? const EdgeInsets.only(left: 50)
                            : const EdgeInsets.only(right: 50),
                        child: Column(
                          children: [
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
                                      messages[index].text,
                                      style: const TextStyle(color: white),
                                    ),
                                    horizontalSpace(10),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        "23:18",
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
                            if (messages[index].putSeparator) verticalSpace(5)
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              // verticalSpace(5),
              // ...List.generate(
              //   messages.length,
              //   (index) => Container(
              //     margin: messages[index].isMe
              //         ? const EdgeInsets.only(left: 50)
              //         : const EdgeInsets.only(right: 50),
              //     child: Column(
              //       children: [
              //         Align(
              //           alignment: messages[index].isMe
              //               ? Alignment.centerRight
              //               : Alignment.centerLeft,
              //           child: Container(
              //             margin: const EdgeInsets.symmetric(
              //               horizontal: 8,
              //               vertical: 2,
              //             ),
              //             padding: const EdgeInsets.symmetric(
              //               horizontal: 10,
              //               vertical: 5,
              //             ),
              //             decoration: BoxDecoration(
              //               color: messages[index].isMe ? userGreen : primary,
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             child: Row(
              //               mainAxisSize: MainAxisSize.min,
              //               children: [
              //                 Text(
              //                   messages[index].text,
              //                   style: const TextStyle(color: white),
              //                 ),
              //                 horizontalSpace(10),
              //                 Padding(
              //                   padding: const EdgeInsets.only(top: 10),
              //                   child: Text(
              //                     "23:18",
              //                     style: TextStyle(
              //                       color: white.withOpacity(.6),
              //                       fontSize: 12,
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //         if (messages[index].putSeperator) verticalSpace(5)
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldAndFloatingButton extends StatefulWidget {
  const TextFieldAndFloatingButton({
    super.key,
    required this.receiverId,
  });

  final int receiverId;

  @override
  State<TextFieldAndFloatingButton> createState() =>
      _TextFieldAndFloatingButtonState();
}

class _TextFieldAndFloatingButtonState
    extends State<TextFieldAndFloatingButton> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8),
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: 45,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _controller,
              cursorColor: green,
              style: const TextStyle(color: grey, fontSize: 18, height: 1.3),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                prefixIcon: const Icon(Icons.emoji_emotions_rounded),
                prefixIconColor: grey,
                suffixIconColor: grey,
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(Icons.share),
                      horizontalSpace(10),
                      const Icon(Icons.camera_alt),
                    ],
                  ),
                ),
                hintStyle:
                    const TextStyle(color: grey, fontSize: 18, height: 1.3),
                hintText: 'Mensaje',
                fillColor: primary,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
              ),
              onFieldSubmitted: (value) {
                Provider.of<SupabaseProvider>(context, listen: false)
                    .sendMessage(value, myId, widget.receiverId);
              },
            ),
          ),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: greenAccent3,
            elevation: 0,
            child: const Icon(Icons.keyboard_voice_rounded),
          ),
        ],
      ),
    );
  }
}

class MockDataChat {
  final String text;
  final bool isMe;
  final bool putSeperator;

  MockDataChat(
      {required this.text, required this.isMe, required this.putSeperator});
}
