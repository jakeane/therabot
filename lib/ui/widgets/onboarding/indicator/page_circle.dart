import 'package:flutter/material.dart';

class PageCircle extends StatelessWidget {
  final bool isActive;

  PageCircle({this.isActive});

  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          color: isActive
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }
}
