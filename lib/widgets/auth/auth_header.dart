import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double bottomMargin = MediaQuery.of(context).size.height * 0.28 - 185;

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 15),
          child: SvgPicture.asset(
            'assets/images/bot_logo.svg',
            width: 150,
            height: 150,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 0, bottom: bottomMargin),
          child: RichText(
              text: TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(fontSize: 64),
                  children: [
                TextSpan(
                    text: 'Thera',
                    style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(
                        fontSize: 64,
                        color: Theme.of(context).colorScheme.primary)
                      ),
                const TextSpan(text: 'bot')
              ])),
        ),
      ],
    );
  }
}
