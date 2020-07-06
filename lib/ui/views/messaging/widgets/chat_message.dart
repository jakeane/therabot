import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/models/chat_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bubble/bubble.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {
  ChatMessage(
      {this.text,
      this.name,
      this.type,
      this.id,
      this.index,
      this.feedback,
      this.comment});
  final String text;
  final String name;
  final bool type;
  final int id;
  final int index;
  int feedback;
  String comment;

  List<Widget> otherMessage(context) {
    return <Widget>[
      Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: CircleAvatar(child: Text('CB')),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
                padding: const EdgeInsets.all(0.0),
                // Consumer listens to changes in feedback
                child: Consumer<ChatModel>(builder: (context, chat, child) {
                  return Row(
                    children: [
                      Bubble(
                        child: Text(text),
                        color: Color.fromRGBO(225, 225, 225, 1.0),
                      ),
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.check,
                          color: chat.chatList[index].feedback == 0
                              ? Colors.green
                              : Colors.grey,
                        ),
                        iconSize: 15,
                        onPressed: () {
                          Provider.of<ChatModel>(context, listen: false)
                              .giveFeedback(index, 0);
                        },
                      ),
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.times,
                          color: chat.chatList[index].feedback == 1
                              ? Colors.red
                              : Colors.grey,
                        ),
                        iconSize: 15,
                        onPressed: () {
                          Provider.of<ChatModel>(context, listen: false)
                              .giveFeedback(index, 1);
                        },
                      ),
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.comment,
                          color: chat.chatList[index].comment.isEmpty
                              ? Colors.grey
                              : Colors.lightBlue,
                        ),
                        iconSize: 15,
                        onPressed: () {
                          Provider.of<ChatModel>(context, listen: false)
                              .addComment(index);
                        },
                      )
                    ],
                  );
                })),
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
            Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: Bubble(
                child: Text(text),
                color: Color.fromRGBO(212, 234, 244, 1.0),
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(left: 16.0),
        child: CircleAvatar(
            child: Text(
          name[0],
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
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
