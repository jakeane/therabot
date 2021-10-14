import 'package:flutter/material.dart';
import 'package:therabot/constants/strings.dart';
import 'package:provider/provider.dart';
import 'package:therabot/store/auth_provider.dart';

class PrivateRoute extends StatelessWidget {
  const PrivateRoute({Key? key, required this.route}) : super(key: key);
  final Widget route;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (_, auth, child) {
      if (auth.getUser() != null) {
        return route;
      } else {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              Strings.signinRoute, (Route<dynamic> route) => false);
        });
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
