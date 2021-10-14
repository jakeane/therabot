import 'package:flutter/material.dart';
import 'package:therabot/widgets/chatbot/message/chat_nip.dart';
import 'package:therabot/widgets/chatbot/message/decorated_bubble.dart';
import 'package:therabot/widgets/chatbot/message/inactive_feedback_icon.dart';
import 'package:therabot/widgets/chatbot/message/message_bubble.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({
    Key? key,
    required this.text,
    required this.type,
    required this.feedback,
    required this.consecutive
  }) : super(key: key);
  
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
          clipBehavior: Clip.none, children: [
            MessageBubble(
              text: text,
              bubbleColor: Theme.of(context).colorScheme.primary,
              textStyle: Theme.of(context).textTheme.bodyText1!,
              maxWidth: (2 * MediaQuery.of(context).size.width / 3) + 20,
            ),
            if (!consecutive)
              Positioned(
                bottom: -5,
                right: 0,
                child: CustomPaint(
                  size: const Size(20, 25),
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
      margin: EdgeInsets.only(bottom: consecutive ? 5 : 15),
      child: type ? myMessage(context) : otherMessage(context),
    );
  }
}
