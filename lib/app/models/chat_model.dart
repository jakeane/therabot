import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatbot/ui/views/messaging/widgets/chat_message.dart';

class ChatModel extends ChangeNotifier {
  final List<ChatMessage> _chatList = [];

  getChatList() => _chatList;

  void addChat(String text, String name, bool type, int id) {
    ChatMessage message = ChatMessage(
      text: text,
      name: name,
      type: type,
      id: id,
      index: getChatList().length,
      feedback: -1,
      timestamp: FieldValue.serverTimestamp(),
      comment: "",
      selected: false,
    );
    getChatList().add(message);
    notifyListeners();
  }

  void giveFeedback(int index, int feedback) {
    getChatList()[index].feedback = feedback;
    notifyListeners();
  }

  void addComment(int index) {
    getChatList()[index].comment = "hi";
    notifyListeners();
  }

  void changeSelected(int index) {
    if (index != getChatList().length - 1) {
      getChatList()[index].selected = !getChatList()[index].selected;
      notifyListeners();
    }
  }

  Map<String, Object> getLastMessage() {
    return {
      "text": getChatList().last.text,
      "name": getChatList().last.name,
      "type": getChatList().last.type,
      "timestamp": getChatList().last.timestamp,
    };
  }
}
