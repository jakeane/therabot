import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_chatbot/app/constants/strings.dart';
import 'package:flutter_chatbot/app/services/firebase_signin.dart';
import 'package:provider/provider.dart';

class PrivateRoute extends StatelessWidget {
  PrivateRoute({this.route});
  final Widget route;

  Widget build(BuildContext context) {
    return Consumer<AuthService>(builder: (context, auth, child) {
      if (auth.getUser() != null) {
        return route;
      } else {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context)
              .popUntil(ModalRoute.withName(Strings.landingRoute));
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
