import 'dart:math';

import 'package:chat_app_frontend/models/chat_last_message.dart';
import 'package:chat_app_frontend/models/models.dart';
import 'package:flutter/material.dart';

import '../constants/supabase.dart';

class SupabaseProvider extends ChangeNotifier {
  int _myId = 0;
  int get myId => _myId;
  set myId(int value) {
    _myId = value;
    notifyListeners();
  }

  List<User> _users = [];

  List<User> get users => _users;

  set users(List<User> value) {
    _users = value;
    // notifyListeners();
  }

  // set users(List<User> value) {
  //   _users = value;
  //   notifyListeners();
  // }

  // Future<void> getUsers() async {
  //   print('****************** - GET USERS -');
  //   // List<User> users = [];
  //   final response = await supabase.from('Users').select().neq('id', myId);

  //   for (var item in response) {
  //     User user = User.fromMap(item);
  //     _users.add(user);
  //   }

  //   // final data = await supabase
  //   //     .from('ChatLastMessage')
  //   //     .select()
  //   //     .or('sender_id.eq.$myId,sender_id.eq.$myId')
  //   //     .withConverter((data) => (data as List<dynamic>)
  //   //         .map((item) => ChatLastMessage.fromMap(item))
  //   //         .toList());

  //   // for (var user in users) {
  //   //   if (data.isNotEmpty) {
  //   //     user.lastMessage = data
  //   //         .firstWhere((element) =>
  //   //             element.senderId == user.id || element.receiverId == user.id)
  //   //         .text;
  //   //   }
  //   // }
  //   notifyListeners();
  // }

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

  Future<void> insertLastMessage(ChatLastMessage lastMessage) async {
    print('****************** - INSERT LAST MESSAGE -');
    await supabase.from("ChatLastMessage").upsert(lastMessage.toMap());

    final otherLastMessage = ChatLastMessage(
        senderId: lastMessage.receiverId,
        receiverId: lastMessage.senderId,
        text: lastMessage.text,
        date: lastMessage.date);
    await supabase.from("ChatLastMessage").upsert(otherLastMessage.toMap());
  }

  Future<List<User>> usersToSelect() async {
    return await supabase.from('Users').select().withConverter(
        (data) => (data as List<dynamic>).map((e) => User.fromMap(e)).toList());
  }

  Stream getStreamUsers(int senderId) {
    return supabase
        .from('ChatLastMessage')
        .stream(primaryKey: ['sender_id', 'receiver_id'])
        .eq('sender_id', myId)
        .order('date');
  }

  Future<void> createUser(String username) async {
    var user = User(
      name: username,
      profilePictureUrl: 'https://picsum.photos/20${Random().nextInt(10)}',
    );

    var response = await supabase
        .from('Users')
        .insert(user.toMap())
        .select()
        .withConverter((data) =>
            (data as List<dynamic>).map((e) => User.fromMap(e)).toList());

    users.addAll(response);
    notifyListeners();
  }

  Future<void> deleteUser(int id) async {
    await supabase.from('Users').delete().eq('id', id);

    users.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
