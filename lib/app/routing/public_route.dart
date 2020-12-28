import 'package:flutter/material.dart';
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
        if (auth.isNew) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushNamed(Strings.onBoardingRoute);
          });
        } else if (ModalRoute.of(context).settings.name !=
            Strings.messagingViewRoute) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context)
                .pushReplacementNamed(Strings.messagingViewRoute);
          });
        }
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
