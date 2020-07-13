import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatbot/ui/views/messaging/widgets/chat_message.dart';

class ChatModel extends ChangeNotifier {
  final List<ChatMessage> chatList = [];

  void addChat(String text, String name, bool type, int id) {
    ChatMessage message = ChatMessage(
      text: text,
      name: name,
      type: type,
      id: id,
      index: chatList.length,
      feedback: -1,
      timestamp: FieldValue.serverTimestamp(),
      comment: "",
      selected: false,
    );
    chatList.add(message);
    notifyListeners();
  }

  void giveFeedback(int index, int feedback) {
    chatList[index].feedback = feedback;
    notifyListeners();
  }

  void addComment(int index) {
    chatList[index].comment = "hi";
    notifyListeners();
  }

  void changeSelected(int index) {
    if (index != chatList.length - 1) {
      chatList[index].selected = !chatList[index].selected;
      notifyListeners();
    }
  }

  Map<String, Object> getLastMessage() {
    return {
      "text": chatList.last.text,
      "name": chatList.last.name,
      "type": chatList.last.type,
      "timestamp": chatList.last.timestamp,
    };
  }
}