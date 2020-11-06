import 'package:flutter/material.dart';
import 'package:flutter_chatbot/ui/widgets/messaging/chatbot/feedback_buttons.dart';
import 'package:flutter_chatbot/ui/widgets/messaging/message/active_feedback_icon.dart';
import 'package:flutter_chatbot/ui/widgets/messaging/message/decorated_bubble.dart';

class BotResponse extends StatelessWidget {
  BotResponse(
      {this.setFeedbackView,
      this.text,
      this.feedback,
      this.bubbleColor,
      this.textStyle});
  final Function(int) setFeedbackView;
  final String text;
  final int feedback;
  final Color bubbleColor;
  final TextStyle textStyle;

  Widget build(BuildContext context) {
    bool isWaiting = text == "Hold on, I'm thinking...";

    return Container(
        margin: EdgeInsets.only(bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBubble(
              text: text,
              maxWidth: MediaQuery.of(context).size.width - 180,
              feedback: feedback,
              feedbackIcon: ActiveFeedbackIcon(feedback: feedback),
            ),
            feedback != -1 || isWaiting
                ? Container(
                    height: 48, color: Theme.of(context).backgroundColor)
                : FeedbackButtons(
                    setFeedbackView: setFeedbackView,
                  )
          ],
        ));
  }
}
