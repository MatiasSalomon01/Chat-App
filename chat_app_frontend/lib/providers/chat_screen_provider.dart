import 'package:chat_app_frontend/extensions/datime_extensions.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class ChatScreenProvider extends ChangeNotifier {
  int _totalSelected = 0;

  int get totalSelected => _totalSelected;

  final List<Message> _messagesIds = [];

  List<Message> get messagesIds => _messagesIds;

  void registerSelectedText(bool value, Message id) {
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

  List<int> getMessageIds() {
    return _messagesIds.map((e) => e.id).toList();
  }

  String copyToClipboard() {
    String text = '';
    for (var message in _messagesIds) {
      text += '[${message.createdAt.getDateForClipboard()}]: ${message.text}\n';
    }
    return text;
  }
}
