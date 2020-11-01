import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final double topMargin;
  final String text;
  final void Function() onSubmit;

  SubmitButton({this.topMargin, this.text, this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: topMargin),
      width: 300,
      child: FlatButton(
          onPressed: onSubmit,
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: BorderSide(color: Theme.of(context).colorScheme.primary)),
          color: Theme.of(context).colorScheme.primary),
    );
  }
}
