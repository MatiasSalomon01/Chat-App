import 'package:chat_app_frontend/models/user.dart';
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

  // Future<List<User>> getMessages(int senderId, int receiverId) async {
  //   List<Message> users = [];
  //   final response = await supabase
  //       .from('Messages')
  //       .select()
  //       .eq('sender_id', senderId)
  //       .eq('receiver_id', receiverId);

  //   for (var item in response) {
  //     User user = User.fromMap(item);
  //     users.add(user);
  //   }

  //   return users;
  // }
}
