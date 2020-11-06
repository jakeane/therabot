import 'package:flutter/material.dart';
import 'package:flutter_chatbot/ui/widgets/messaging/message/chat_nip.dart';
import 'package:flutter_chatbot/ui/widgets/messaging/message/message_bubble.dart';

class DecoratedBubble extends StatelessWidget {
  final String text;
  final double maxWidth;
  final int feedback;
  final Widget feedbackIcon;

  DecoratedBubble({this.text, this.maxWidth, this.feedback, this.feedbackIcon});

  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        MessageBubble(
          text: text,
          bubbleColor: Theme.of(context).colorScheme.primaryVariant,
          textStyle: Theme.of(context).textTheme.bodyText2,
          maxWidth: maxWidth,
        ),
        // if (!consecutive)
        Positioned(
          bottom: -5,
          child: CustomPaint(
            size: Size(20, 25),
            painter: ChatNip(
                nipHeight: 5,
                color: Theme.of(context).colorScheme.primaryVariant,
                isUser: false),
          ),
        ),
        if (feedback != -1)
          Positioned(
              top: -5,
              right: -5,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).backgroundColor,
                ),
              )),
        if (feedback != -1) feedbackIcon
      ],
    );
  }
}
