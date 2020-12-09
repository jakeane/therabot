import 'package:flutter/material.dart';

class UserPrompt extends StatelessWidget {
  const UserPrompt({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Placeholder for persona generation
    bool isMale = true;
    int age = 28;
    String gender = isMale ? "male" : "female";
    String issue = "generalized anxiety disorder";

    TextStyle textStyle = Theme.of(context).textTheme.bodyText1;
    TextStyle underlinedStyle =
        textStyle.copyWith(decoration: TextDecoration.underline);

    return Container(
        padding: EdgeInsets.symmetric(vertical: textStyle.fontSize * 2),
        child: Text.rich(
          TextSpan(style: textStyle, children: [
            TextSpan(text: "You are a "),
            TextSpan(text: "$age year old", style: underlinedStyle),
            TextSpan(text: " "),
            TextSpan(text: gender, style: underlinedStyle),
            TextSpan(text: " with "),
            TextSpan(text: issue, style: underlinedStyle)
          ]),
          textAlign: TextAlign.center,
        ));
  }
}
