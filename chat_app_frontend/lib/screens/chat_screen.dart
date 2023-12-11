import 'package:chat_app_frontend/constants/colors.dart';
import 'package:chat_app_frontend/models/models.dart';
import 'package:chat_app_frontend/models/user.dart';
import 'package:chat_app_frontend/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondary,
      appBar: CustomAppBarChat(user: user),
      body: Stack(
        children: [
          Column(
            children: [
              ChatMessages(receiverId: user.id!),
              TextFieldAndFloatingButton(receiverId: user.id!)
            ],
          ),
        ],
      ),
    );
  }
}
