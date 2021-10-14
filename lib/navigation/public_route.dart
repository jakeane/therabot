import 'package:flutter/material.dart';
import 'package:therabot/constants/strings.dart';
import 'package:therabot/store/auth_provider.dart';
import 'package:provider/provider.dart';

class PublicRoute extends StatelessWidget {
  const PublicRoute({Key? key, required this.route}) : super(key: key);
  final Widget route;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, auth, child) {
      if (auth.getUser() == null) {
        return route;
      } else {
        if (auth.isNew) {
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            Navigator.of(context).pushNamed(Strings.onBoardingRoute);
          });
        } else if (ModalRoute.of(context)?.settings.name !=
            Strings.messagingViewRoute) {
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            Navigator.of(context)
                .pushReplacementNamed(Strings.messagingViewRoute);
          });
        }
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    });
  }
}
