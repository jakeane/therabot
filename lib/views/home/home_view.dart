import 'package:flutter/material.dart';
import 'package:flutter_chatbot/widgets/interactive_chat_window/interactive_chat_window.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // The current home view is a simple full page window of the chatbot window.
    return Container(child: InteractiveChatWindow(title: "Covid Bot"));
  }
}
