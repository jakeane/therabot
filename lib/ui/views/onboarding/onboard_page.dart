import 'package:flutter/material.dart';

class OnboardPage extends StatelessWidget {
  OnboardPage({this.pageNum});
  final int pageNum;

  final List<String> assets = [
    "assets/images/onboardTalk.png",
    "assets/images/onboardFeedback.png",
    "assets/images/onboardModes.png",
    "assets/images/onboardTalk.png"
  ];

  final List<String> headers = [
    "Talk with ChatBot",
    "Provide feedback",
    "Switch Modes",
    "ChatBot is designed for you"
  ];

  final List<String> body = [
    "Chat about how you've been feeling and what has been on your mind",
    "Let ChatBot know what it does well and/or how it can do better",
    "Choose between dark and light mode",
    "ChatBot is here to listen to all your thoughts and feelings, so don't be afraid to share"
  ];

  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
          width: screenSize.width * 0.89,
          height: screenSize.height * 0.6,
          child: new Image(image: new AssetImage(assets[pageNum]))),
      Text(
        headers[pageNum],
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(fontSize: 24, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
      Container(
          margin: EdgeInsets.only(top: 10),
          width: screenSize.width * 0.75,
          child: Text(
            body[pageNum],
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(fontSize: 22, fontWeight: FontWeight.w300),
            textAlign: TextAlign.center,
          ))
    ]));
  }
}
