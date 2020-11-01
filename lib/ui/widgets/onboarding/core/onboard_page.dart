import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/constants/onboarding.dart';

class OnboardPage extends StatelessWidget {
  OnboardPage({this.pageNum});
  final int pageNum;

  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
          width: screenSize.width * 0.89,
          height: screenSize.height * 0.6,
          child: new Image(image: new AssetImage(Onboarding.assets[pageNum]))),
      Text(
        Onboarding.headers[pageNum],
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
            Onboarding.body[pageNum],
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(fontSize: 22, fontWeight: FontWeight.w300),
            textAlign: TextAlign.center,
          ))
    ]));
  }
}
