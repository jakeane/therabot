import 'package:flutter/material.dart';
import 'package:therabot/constants/onboarding.dart';

class OnboardPage extends StatelessWidget {
  const OnboardPage({Key? key, required this.pageNum}) : super(key: key);
  final int pageNum;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      SizedBox(
          width: screenSize.width * 0.89,
          height: screenSize.height * 0.6,
          child: Image(image: AssetImage(Onboarding.assets[pageNum]))),
      Text(
        Onboarding.headers[pageNum],
        style: Theme.of(context)
            .textTheme
            .bodyText1
            ?.copyWith(fontSize: 24, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
      Container(
          margin: const EdgeInsets.only(top: 10),
          width: screenSize.width * 0.75,
          child: Text(
            Onboarding.body[pageNum],
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(fontSize: 22, fontWeight: FontWeight.w300),
            textAlign: TextAlign.center,
          ))
    ]));
  }
}
