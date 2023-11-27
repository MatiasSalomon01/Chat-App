import 'package:chat_app_frontend/constants/colors.dart';
import 'package:chat_app_frontend/models/models.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.chat});
  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondary,
      body: Center(
        child: Text('Chat content'),
      ),
    );
  }
}
