import 'package:flutter/material.dart';

class GoToButton extends StatelessWidget {
  final String message;
  final Function navigate;

  GoToButton({this.message, this.navigate});

  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 15),
        child: FlatButton(
          onPressed: () {
            navigate();
          },
          child: Text(
            message,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.grey),
          ),
        ));
  }
}
