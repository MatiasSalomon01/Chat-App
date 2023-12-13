import 'package:flutter/material.dart';

import '../models/models.dart';

class ChatScreenProvider extends ChangeNotifier {
  int _totalSelected = 0;

  int get totalSelected => _totalSelected;

  final List<int> _messagesIds = [];

  List<int> get messagesIds => _messagesIds;

  void registerSelectedText(bool value, int id) {
    if (value) {
      _totalSelected++;
      _messagesIds.add(id);
    }

    if (!value) {
      _totalSelected--;
      _messagesIds.remove(id);
    }

    notifyListeners();
  }

  void resetStateOfSelectedTexts() {
    _messagesIds.clear();
    _totalSelected = 0;
    notifyListeners();
  }

  late List<Message> _messages = [];

  List<Message> get messages => _messages;

  set messages(List<Message> value) {
    _messages = value;
  }
}
