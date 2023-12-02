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
    List<Message> messages = [];

    final List<dynamic> response = await supabase
        .from('Messages')
        .select()
        .eq('sender_id', senderId)
        .eq('receiver_id', receiverId);

    final List<dynamic> response2 = await supabase
        .from('Messages')
        .select()
        .eq('sender_id', receiverId)
        .eq('receiver_id', senderId);

    //Unir las listas
    response.addAll(response2);

    //Mapear
    for (var item in response) {
      Message message = Message.fromMap(item);
      messages.add(message);
    }

    //Agregar separador para espaciado de mensajes
    int previousId = 0;
    for (var message in messages) {
      if (previousId == 0) {
        previousId = message.senderId;
        continue;
      }

      if (message.senderId == previousId) {
        message.putSeparator = false;
        previousId = message.senderId;
      } else {
        message.putSeparator = true;
        previousId = message.senderId;
      }
    }

    //Ordenar por fecha
    messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    return messages;
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
}
