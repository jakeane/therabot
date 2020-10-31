import 'package:flutter_chatbot/app/models/chat_model.dart';
import 'package:flutter_chatbot/app/state/chat_state.dart';
import 'package:flutter_chatbot/ui/widgets/messaging/core/interactive_chat_window.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessagingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // The current home view is a simple full page window of the chatbot window.
    return (MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ChatModel()),
          ChangeNotifierProvider(create: (_) => ChatState())
        ],
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: SafeArea(
            child: InteractiveChatWindow(),
          ),
        )));
  }
}
