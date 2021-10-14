import 'package:flutter/material.dart';

class PageBase extends StatelessWidget {
  final Widget child;

  const PageBase({Key? key, required this.child}) : super(key: key);

  @override
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
