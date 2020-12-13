import 'package:flutter/material.dart';

class UserPrompt extends StatelessWidget {
  const UserPrompt({this.prompt});
  final List<TextSpan> prompt;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyText2;

    return Container(
        padding: EdgeInsets.symmetric(vertical: textStyle.fontSize * 2),
        child: Text.rich(
          TextSpan(children: prompt),
          textAlign: TextAlign.center,
        ));
  }
}
