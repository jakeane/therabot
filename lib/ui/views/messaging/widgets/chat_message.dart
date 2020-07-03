import 'package:flutter/material.dart';
import 'package:flutter_chatbot/ui/views/messaging/widgets/message_rating.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bubble/bubble.dart';

class ChatMessage extends StatefulWidget {
  ChatMessage({this.text, this.name, this.type, this.id});
  final String text;
  final String name;
  final bool type;
  final int id;

  @override
  _ChatMessageState createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  var _selected = [false, false];

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
            Text(widget.name, style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
                padding: const EdgeInsets.all(0.0),
                child: Row(
                  children: [
                    Bubble(
                      child: Text(widget.text),
                      color: Color.fromRGBO(200, 200, 200, 1.0),
                    ),
                    IconButton(
                      icon: FaIcon(_selected[0]
                          ? FontAwesomeIcons.solidThumbsUp
                          : FontAwesomeIcons.thumbsUp),
                      constraints: BoxConstraints.loose(Size(30, 30)),
                      iconSize: 15,
                      onPressed: () => setState(() {
                        _selected = [true, false];
                      }),
                    ),
                    IconButton(
                      icon: FaIcon(_selected[1]
                          ? FontAwesomeIcons.solidThumbsDown
                          : FontAwesomeIcons.thumbsDown),
                      constraints: BoxConstraints(),
                      iconSize: 15,
                      onPressed: () => setState(() {
                        _selected = [false, true];
                      }),
                    ),
                  ],
                )),
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
            Text(widget.name, style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: Bubble(
                child: Text(widget.text),
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
          widget.name[0],
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
        children: widget.type ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}
