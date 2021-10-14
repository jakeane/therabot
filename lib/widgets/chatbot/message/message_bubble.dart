import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.text,
    required this.bubbleColor,
    required this.textStyle,
    required this.maxWidth
  }) : super(key: key);

  final String text;
  final Color bubbleColor;
  final TextStyle textStyle;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: bubbleColor,
      ),
      padding: const EdgeInsets.all(15),
      constraints: BoxConstraints(
        maxWidth: maxWidth,
      ),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
