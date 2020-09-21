import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/services/firebase_signin.dart';
import 'package:provider/provider.dart';

import '../../../app/constants/strings.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
                child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, Strings.messagingViewRoute);
            },
            child: Text("Go to Chat")),
        RaisedButton(
          onPressed: () {
            Provider.of<AuthService>(context, listen: false).signOut();
          },
          child: Text("Sign Out"),
        )
      ],
    ))));
  }
}
