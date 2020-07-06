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
      comment: "",
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
}
