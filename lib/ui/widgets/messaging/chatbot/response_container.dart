import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/models/chat_model.dart';
import 'package:flutter_chatbot/ui/widgets/messaging/chatbot/bot_response.dart';
import 'package:flutter_chatbot/ui/widgets/messaging/chatbot/typing_indicator.dart';
import 'package:provider/provider.dart';

// Parent: AvatarView
class ResponseContainer extends StatelessWidget {
  final bool botThinking;
  final Function(int) setFeedbackView;

  ResponseContainer({this.botThinking, this.setFeedbackView});

  Widget build(BuildContext context) {
    return Consumer<ChatModel>(builder: (context, chat, child) {
      return (chat.getBotResponse() != null)
          ? BotResponse(
              setFeedbackView: setFeedbackView,
              text: chat.getBotResponse().text,
              feedback: chat.getBotResponse().feedback,
              bubbleColor: Theme.of(context).colorScheme.primaryVariant,
              textStyle: Theme.of(context).textTheme.bodyText2)
          : (botThinking
              ? TypingIndicator(
                  beginTweenValue: Theme.of(context).dividerColor,
                  endTweenValue: Theme.of(context).colorScheme.secondary,
                )
              : Container());
    });
  }
}
