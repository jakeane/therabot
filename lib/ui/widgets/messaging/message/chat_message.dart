import 'package:flutter/material.dart';
import 'package:flutter_chatbot/ui/widgets/messaging/message/chat_nip.dart';
import 'package:flutter_chatbot/ui/widgets/messaging/message/decorated_bubble.dart';
import 'package:flutter_chatbot/ui/widgets/messaging/message/inactive_feedback_icon.dart';
import 'package:flutter_chatbot/ui/widgets/messaging/message/message_bubble.dart';

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.type, this.feedback, this.consecutive});
  final String text;
  final bool type;
  final int feedback;
  final bool consecutive;

  Widget otherMessage(context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      DecoratedBubble(
        text: text,
        maxWidth: (2 * MediaQuery.of(context).size.width / 3) + 20,
        feedback: feedback,
        feedbackIcon: InactiveFeedbackIcon(feedback: feedback),
      )
    ]);
  }

  Widget myMessage(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          overflow: Overflow.visible,
          children: [
            MessageBubble(
              text: text,
              bubbleColor: Theme.of(context).colorScheme.primary,
              textStyle: Theme.of(context).textTheme.bodyText1,
              maxWidth: (2 * MediaQuery.of(context).size.width / 3) + 20,
            ),
            if (!consecutive)
              Positioned(
                bottom: -5,
                right: 0,
                child: CustomPaint(
                  size: Size(20, 25),
                  painter: ChatNip(
                      nipHeight: 5,
                      color: Theme.of(context).colorScheme.primary,
                      isUser: true),
                ),
              ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: type ? myMessage(context) : otherMessage(context),
    );
  }
}
