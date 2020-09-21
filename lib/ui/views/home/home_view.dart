import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_chatbot/app/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';

import '../../../app/constants/strings.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Provider.of<AuthService>(context, listen: false).isNew) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, Strings.onBoardingRoute);
      });
    }

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
