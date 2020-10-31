import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({this.text, this.bubbleColor, this.textStyle, this.maxWidth});
  final String text;
  final Color bubbleColor;
  final TextStyle textStyle;
  final double maxWidth;

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: bubbleColor,
      ),
      padding: EdgeInsets.all(15),
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
