import 'package:flutter_chatbot/app/models/chat_model.dart';
import 'package:flutter_chatbot/ui/views/messaging/widgets/interactive_chat_window.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/models/chat_model.dart';
import '../../../app/models/theme_model.dart';

class MessagingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // The current home view is a simple full page window of the chatbot window.
    return (MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => ChatModel())],
        child: Container(
          color: Theme.of(context).dividerColor,
          child: SafeArea(
            child: InteractiveChatWindow(),
          ),
        )));
  }
}

// ChangeNotifierProvider(
//       create: (_) => ChatModel(),
//       child: InteractiveChatWindow(),
//     )
