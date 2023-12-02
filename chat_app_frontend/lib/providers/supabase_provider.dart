import 'package:chat_app_frontend/models/models.dart';
import 'package:flutter/material.dart';

import '../constants/supabase.dart';

class SupabaseProvider extends ChangeNotifier {
  Future<List<User>> getUsers() async {
    print('****************** - GET USERS -');
    List<User> users = [];
    final response = await supabase.from('Users').select().neq('id', 1);

    for (var item in response) {
      User user = User.fromMap(item);
      users.add(user);
    }

    return users;
  }

  Future<List<Message>> getMessages(int senderId, int receiverId) async {
    print('****************** - GET MESSAGES -');

    final List<Message> messages = await supabase
        .from('Messages')
        .select()
        .or('sender_id.eq.$senderId,sender_id.eq.$receiverId')
        .order('created_at', ascending: true)
        .withConverter((data) => (data as List<dynamic>)
            .map((item) => Message.fromMap(item))
            .toList());

    return putSeparators(messages);
  }

  Future<void> sendMessage(String text, int senderId, int receiverId) async {
    print('****************** - SEND MESSAGE -');
    await supabase.from('Messages').insert({
      'text': text,
      'created_at': DateTime.now().toIso8601String(),
      'sender_id': senderId,
      'receiver_id': receiverId,
    });
  }

  Stream getStreamMessages(int senderId, int receiverId) {
    return supabase
        .from('Messages')
        .stream(primaryKey: ['id']).order('created_at', ascending: true);
  }

  List<Message> putSeparators(List<Message> messages) {
    //Agregar separador para espaciado de mensajes
    int previousId = 0;
    for (var message in messages) {
      if (previousId == 0) {
        previousId = message.senderId;
        continue;
      }

      if (message.senderId == previousId) {
        message.putSeparator = false;
      } else {
        message.putSeparator = true;
      }

      previousId = message.senderId;
    }

    return messages;
  }
}
