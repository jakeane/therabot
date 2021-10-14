import 'package:flutter/material.dart';

class FormSubmit extends StatelessWidget {
  final double topMargin;
  final String text;
  final void Function() onSubmit;

  const FormSubmit({
    Key? key,
    required this.topMargin,
    required this.text,
    required this.onSubmit
  }) : super(key: key);

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
