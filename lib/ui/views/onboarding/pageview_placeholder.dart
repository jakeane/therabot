import 'package:flutter/material.dart';

class PageviewPlaceholder extends StatelessWidget {
  PageviewPlaceholder({this.pageNum});
  final int pageNum;

  List<String> headers = [
    "Talk with ChatBot",
    "Provide feedback",
    "Switch Modes",
    "ChatBot is designed for you"
  ];
  List<String> body = [
    "Chat about how you've been feeling and what has been on your mind",
    "Let ChatBot know what it does well and/or how it can do better",
    "Choose between dark and light mode",
    "ChatBot is here to listen to all your thoughts and feelings, so don't be afraid to share"
  ];

  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        headers[pageNum],
        style: Theme.of(context)
            .textTheme
            .button
            .copyWith(color: Color(0xFFF1F5F4)),
        textAlign: TextAlign.center,
      ),
      Container(
          margin: EdgeInsets.only(top: 20),
          width: MediaQuery.of(context).size.width * 0.66,
          child: Text(
            body[pageNum],
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ))
    ]));
  }
}
