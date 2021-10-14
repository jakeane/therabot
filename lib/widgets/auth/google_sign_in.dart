import 'package:flutter/material.dart';
import 'package:therabot/store/auth_provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      width: 300,
      child: FlatButton(
          onPressed: () {
            Provider.of<AuthProvider>(context, listen: false).signInWithGoogle();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 5),
                child: SvgPicture.asset("assets/images/google.svg",
                    width: 20, height: 20),
              ),
              Text(
                "Login with Google",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: BorderSide(color: Theme.of(context).colorScheme.secondary)),
          color: Theme.of(context).backgroundColor),
    );
  }
}
