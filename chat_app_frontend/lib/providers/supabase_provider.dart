import 'package:chat_app_frontend/models/models.dart';
import 'package:flutter/material.dart';

import '../constants/supabase.dart';

class SupabaseProvider extends ChangeNotifier {
  Future<List<User>> getUsers() async {
    List<User> users = [];
    final response = await supabase.from('Users').select().neq('id', 1);

    for (var item in response) {
      User user = User.fromMap(item);
      users.add(user);
    }

    return users;
  }

  Future<List<Message>> getMessages(int senderId, int receiverId) async {
    List<Message> messages = [];

    final response = await supabase
        .from('Messages')
        .select()
        .eq('sender_id', senderId)
        .eq('receiver_id', receiverId);

    for (var item in response) {
      Message message = Message.fromMap(item);
      messages.add(message);
    }

    return messages;
  }

  Future<void> sendMessage(String text, int senderId, int receiverId) async {
    var asd = await supabase.from('Messages').insert({
      'text': text,
      'created_at': DateTime.now().toIso8601String(),
      'sender_id': senderId,
      'receiver_id': receiverId,
      'put_separator': false,
    });
  }
}
