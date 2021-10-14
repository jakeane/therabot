import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:therabot/store/chat_provider.dart';
import 'package:therabot/widgets/chatbot/avatar/bot_response.dart';
import 'package:therabot/widgets/chatbot/message/typing_indicator.dart';

// Parent: AvatarView
class ResponseContainer extends StatelessWidget {
  final bool botThinking;
  final Function(int) setFeedbackView;

  const ResponseContainer({
    Key? key,
    required this.botThinking,
    required this.setFeedbackView
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, chat, child) {
      return (chat.getBotResponse() != null)
          ? BotResponse(
              setFeedbackView: setFeedbackView,
              text: chat.getBotResponse()?.text ?? "",
              feedback: chat.getBotResponse()?.feedback ?? -1,
              bubbleColor: Theme.of(context).colorScheme.primaryVariant,
              textStyle: Theme.of(context).textTheme.bodyText2!)
          : (botThinking
              ? TypingIndicator(
                  beginTweenValue: Theme.of(context).dividerColor,
                  endTweenValue: Theme.of(context).colorScheme.secondary,
                )
              : Container());
    });
  }
}
