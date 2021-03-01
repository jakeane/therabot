import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthViewHeader extends StatelessWidget {
  Widget build(BuildContext context) {
    double bottomMargin = MediaQuery.of(context).size.height * 0.28 - 185;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 15),
          child: SvgPicture.asset(
            'assets/images/bot_logo.svg',
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5, bottom: bottomMargin),
          child: RichText(
              text: TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(fontSize: 64),
                  children: [
                TextSpan(
                    text: 'Thera',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: 64,
                        color: Theme.of(context).colorScheme.primary)),
                TextSpan(text: 'bot')
              ])),
        ),
      ],
    );
  }
}
