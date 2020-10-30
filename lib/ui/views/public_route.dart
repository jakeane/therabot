import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_chatbot/app/constants/strings.dart';
import 'package:flutter_chatbot/app/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';

class PublicRoute extends StatelessWidget {
  PublicRoute({this.route});
  final Widget route;

  Widget build(BuildContext context) {
    return Consumer<AuthService>(builder: (context, auth, child) {
      if (auth.getUser() == null) {
        return route;
      } else {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context)
              .pushReplacementNamed(Strings.messagingViewRoute);
        });
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    });
  }
}
