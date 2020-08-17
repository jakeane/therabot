import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatbot/ui/views/messaging/widgets/chat_message.dart';

class ChatModel extends ChangeNotifier {
  final List<ChatMessage> _chatList = [];
  ChatMessage _botResponse;

  getChatList() => _chatList;
  getBotResponse() => _botResponse;

  void addChat(String text, String name, bool type, int id) {
    if (_botResponse != null) {
      _chatList.add(_botResponse);
      _botResponse = null;
    }
    ChatMessage message = createMessage(text, name, type, id);
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

  ChatMessage createMessage(String text, String name, bool type, int id) {
    return ChatMessage(
      text: text,
      name: name,
      type: type,
      id: id,
      index: _chatList.length,
      feedback: -1,
      timestamp: FieldValue.serverTimestamp(),
      comment: "",
      selected: false,
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

  void addComment(int index) {
    _chatList[index].comment = "hi";
    notifyListeners();
  }

  void changeSelected(int index) {
    if (index != _chatList.length - 1) {
      _chatList[index].selected = !_chatList[index].selected;
      notifyListeners();
    }
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
