import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/constants/strings.dart';
import 'package:flutter_chatbot/app/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';

class StartChattingButton extends StatelessWidget {
  final int currentPageValue;
  final int totalPages;

  StartChattingButton({this.currentPageValue, this.totalPages});

  Widget build(BuildContext context) {
    return Visibility(
        visible: currentPageValue == totalPages - 1 ? true : false,
        child: Container(
          margin: EdgeInsets.only(bottom: 58),
          width: 300,
          height: 40,
          child: FloatingActionButton(
            onPressed: () {
              Provider.of<AuthService>(context, listen: false).changeIsNew();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Strings.messagingViewRoute, (Route<dynamic> route) => false);
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(26))),
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(
              "Start chatting",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ));
  }
}
