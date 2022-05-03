import 'package:flutter/material.dart';
import 'package:therabot/widgets/chatbot/message/chat_nip.dart';
import 'package:therabot/widgets/chatbot/message/message_bubble.dart';

class DecoratedBubble extends StatelessWidget {
  final String text;
  final double maxWidth;
  final int feedback;
  final Widget feedbackIcon;
  final bool consecutive;

  const DecoratedBubble({
    Key? key,
    required this.text,
    required this.maxWidth,
    required this.feedback,
    required this.feedbackIcon,
    required this.consecutive
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, children: [
        MessageBubble(
          text: text,
          bubbleColor: Theme.of(context).colorScheme.primaryVariant,
          textStyle: Theme.of(context).textTheme.bodyText2!,
          maxWidth: maxWidth,
        ),
        if (!consecutive)
        Positioned(
          bottom: -5,
          child: CustomPaint(
            size: const Size(20, 25),
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
