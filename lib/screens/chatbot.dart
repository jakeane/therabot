import 'package:therabot/widgets/chatbot/core/chat_window.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:therabot/store/chat_provider.dart';
import 'package:therabot/store/emotion_provider.dart';

class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The current home view is a simple full page window of the chatbot window.
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ChatProvider()),
          ChangeNotifierProvider(create: (_) => EmotionProvider())
        ],
        child: Container(
            color: Theme.of(context).backgroundColor,
            child: Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              body: const SafeArea(
                child: InteractiveChatWindow(),
              ),
            )));
  }
}
