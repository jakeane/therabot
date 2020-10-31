import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatbot/ui/widgets/messaging/message/chat_nip.dart';
import 'package:flutter_chatbot/ui/widgets/messaging/message/message_bubble.dart';
import 'package:flutter_chatbot/assets/assets.dart';

class ChatMessage extends StatelessWidget {
  ChatMessage(
      {this.text,
      this.name,
      this.type,
      this.id,
      this.index,
      this.feedback,
      this.timestamp,
      this.comment,
      this.selected,
      this.consecutive});
  final String text;
  final String name;
  final bool type;
  final int id;
  final int index;
  final FieldValue timestamp;
  int feedback;
  String comment;
  bool selected;
  bool consecutive;

  List<Widget> otherMessage(context) {
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: [
                MessageBubble(
                    text: text,
                    bubbleColor: Theme.of(context).colorScheme.primaryVariant,
                    textStyle: Theme.of(context).textTheme.bodyText2,
                    maxWidth: (2 * MediaQuery.of(context).size.width / 3) + 20),
                if (!consecutive)
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
                if (feedback != -1)
                  Positioned(
                    top: -7.5,
                    right: -7.5,
                    child: Icon(
                      Cb.feedbackcheckpressed,
                      size: 25,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
              ],
              overflow: Overflow.visible,
            )
          ],
        ),
      ),
    ];
  }

  List<Widget> myMessage(context) {
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Stack(
              children: [
                Container(
                    child: MessageBubble(
                  text: text,
                  bubbleColor: Theme.of(context).colorScheme.primary,
                  textStyle: Theme.of(context).textTheme.bodyText1,
                  maxWidth: (2 * MediaQuery.of(context).size.width / 3) + 20,
                )),
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
              overflow: Overflow.visible,
            ),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: type ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}
