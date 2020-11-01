import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/models/message_model.dart';

class ChatModel extends ChangeNotifier {
  final List<MessageModel> _chatList = [];
  MessageModel _botResponse;

  List<MessageModel> getChatList() => _chatList;
  MessageModel getBotResponse() => _botResponse;

  void addChat(String text, String name, bool type, int id) {
    if (_botResponse != null) {
      _chatList.add(_botResponse);
      _botResponse = null;
    }

    if (_chatList.length > 0 && _chatList.last.type == type) {
      _chatList.last.consecutive = true;
    }

    MessageModel message = createMessage(text, name, type, id);
    _chatList.add(message);

    notifyListeners();
  }

  void addBotResponse(String text, String name, bool type, int id) {
    if (_botResponse != null) {
      _chatList.add(_botResponse);
      _botResponse = null;
    }

    _botResponse = createMessage(text, name, type, id);

    notifyListeners();
  }

  MessageModel createMessage(String text, String name, bool type, int id) {
    return MessageModel(
      text: text,
      name: name,
      type: type,
      id: id,
      index: _chatList.length,
      feedback: -1,
      timestamp: FieldValue.serverTimestamp(),
      comment: "",
      selected: false,
      consecutive: false,
    );
  }

  void giveFeedback(int index, int feedback) {
    if (index == -1) {
      _botResponse.feedback = feedback;
    } else {
      _chatList[index].feedback = feedback;
    }
    notifyListeners();
  }

  Map<String, Object> getLastMessage() {
    return {
      "text": _chatList.last.text,
      "name": _chatList.last.name,
      "type": _chatList.last.type,
      "timestamp": _chatList.last.timestamp,
    };
  }
}
