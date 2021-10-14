import 'package:flutter/material.dart';
import 'package:therabot/constants/strings.dart';
import 'package:therabot/store/auth_provider.dart';
import 'package:provider/provider.dart';

class StartChattingButton extends StatelessWidget {
  final int currentPageValue;
  final int totalPages;

  const StartChattingButton({
    Key? key,
    required this.currentPageValue,
    required this.totalPages
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: currentPageValue == totalPages - 1 ? true : false,
        child: Container(
          margin: const EdgeInsets.only(bottom: 58),
          width: 300,
          height: 40,
          child: FloatingActionButton(
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).changeIsNew();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Strings.messagingViewRoute, (Route<dynamic> route) => false);
            },
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(26))),
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(
              "Start chatting",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ));
  }
}
