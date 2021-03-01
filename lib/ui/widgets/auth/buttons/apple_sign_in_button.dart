import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/services/firebase_auth_service.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class AppleSignInButton extends StatelessWidget {
  const AppleSignInButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      width: 300,
      child: FlatButton(
          onPressed: () {
            Provider.of<AuthService>(context, listen: false)
                .signInAppleAccount();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: 5),
                child: SvgPicture.asset(
                  "assets/images/apple.svg",
                  width: 20,
                  height: 20,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Text(
                "Login with Apple",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
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
