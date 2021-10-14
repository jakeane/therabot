import 'package:flutter/material.dart';

class GoToButton extends StatelessWidget {
  final String message;
  final Function navigate;

  const GoToButton({
    Key? key,
    required this.message,
    required this.navigate
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: FlatButton(
          onPressed: () {
            navigate();
          },
          child: Text(
            message,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: Colors.grey),
          ),
        ));
  }
}
