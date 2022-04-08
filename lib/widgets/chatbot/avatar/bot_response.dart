import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:therabot/constants/messaging_strings.dart';
import 'package:therabot/store/config_provider.dart';
import 'package:therabot/widgets/chatbot/feedback/shake_container.dart';
import 'package:therabot/widgets/chatbot/message/active_feedback_icon.dart';
import 'package:therabot/widgets/chatbot/message/decorated_bubble.dart';

// Parent: ResponseContainer
class BotResponse extends StatelessWidget {
  const BotResponse({
    Key? key,
    required this.setFeedbackView,
    required this.text,
    required this.feedback,
    required this.bubbleColor,
    required this.textStyle
  }) : super(key: key);

  final Function(int) setFeedbackView;
  final String text;
  final int feedback;
  final Color bubbleColor;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    bool suppressFeedback =
        MessagingStrings.suppressFeedbackText.contains(text) ||
        Provider.of<ConfigProvider>(context, listen: false).getMode() == Mode.trial ||
        Provider.of<ConfigProvider>(context, listen: false).getMode() == Mode.prompt;

    return Container(
        margin: const EdgeInsets.only(bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBubble(
              text: text,
              maxWidth: MediaQuery.of(context).size.width - 180,
              feedback: feedback,
              feedbackIcon: ActiveFeedbackIcon(feedback: feedback),
            ),
            feedback != -1 || suppressFeedback
                ? Container(
                    height: 48, color: Theme.of(context).backgroundColor)
                : ShakeContainer(
                    setFeedbackView: setFeedbackView,
                  )
          ],
        ));
  }
}
