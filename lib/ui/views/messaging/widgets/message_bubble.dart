import 'package:flutter/material.dart';

class MessageBubble extends StatefulWidget {
  MessageBubble({this.text, this.bubbleColor, this.textColor});
  final String text;
  final Color bubbleColor;
  final Color textColor;

  @override
  _MessageBubble createState() => _MessageBubble();
}

class _MessageBubble extends State<MessageBubble> {
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: widget.bubbleColor,
      ),
      padding: EdgeInsets.all(15),
      constraints: BoxConstraints(
          maxWidth: (2 * MediaQuery.of(context).size.width / 3) + 20),
      child: Text(
        widget.text,
        style: TextStyle(color: widget.textColor),
      ),
    );
  }
}
