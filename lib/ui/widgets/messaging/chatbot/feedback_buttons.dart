import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/models/chat_model.dart';
import 'package:flutter_chatbot/assets/assets.dart';
import 'package:provider/provider.dart';

// Parent: BotResponse
class FeedbackButtons extends StatelessWidget {
  final Function(int) setFeedbackView;

  FeedbackButtons({this.setFeedbackView});

  Widget build(BuildContext context) {
    bool highlightFeedback =
        Provider.of<ChatModel>(context, listen: false).getHighlightFeedback();

    return Row(
      children: [
        IconButton(
          icon: Icon(Cb.feedbackcheck),
          iconSize: 40,
          color: highlightFeedback
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondaryVariant,
          padding: const EdgeInsets.only(right: 0, top: 8),
          onPressed: () {
            Provider.of<ChatModel>(context, listen: false).giveFeedback(-1, 1);
          },
        ),
        IconButton(
          icon: Icon(Cb.feedbackex),
          iconSize: 40,
          color: highlightFeedback
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondaryVariant,
          padding: const EdgeInsets.only(left: 0, top: 8),
          onPressed: () {
            Provider.of<ChatModel>(context, listen: false).giveFeedback(-1, 0);
            setFeedbackView(-1);
          },
        )
      ],
    );
  }
}
