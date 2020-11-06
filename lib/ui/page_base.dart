import 'package:flutter/material.dart';

class PageBase extends StatelessWidget {
  final Widget child;

  PageBase({this.child});

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width,
                    maxHeight: MediaQuery.of(context).size.height),
                child:
                    SafeArea(maintainBottomViewPadding: true, child: child))));
  }
}
