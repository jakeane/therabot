import 'package:flutter/material.dart';

class UserPrompt extends StatelessWidget {
  const UserPrompt({this.prompt});
  final List<TextSpan> prompt;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyText2;
    List<TextSpan> themedPrompt = prompt
        ?.map((e) => TextSpan(
            text: e.text, style: e.style.copyWith(color: textStyle.color)))
        ?.toList();

    return Container(
        padding: EdgeInsets.symmetric(vertical: textStyle.fontSize * 2),
        child: Text.rich(
          TextSpan(children: themedPrompt),
          textAlign: TextAlign.center,
        ));
  }
}
