import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/constants/strings.dart';
import 'package:flutter_chatbot/app/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';

class PrivateRoute extends StatelessWidget {
  PrivateRoute({this.route});
  final Widget route;

  Widget build(BuildContext context) {
    return Consumer<AuthService>(builder: (_, auth, child) {
      if (auth.getUser() != null) {
        return route;
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              Strings.signinRoute, (Route<dynamic> route) => false);
        });
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    });
  }
}
