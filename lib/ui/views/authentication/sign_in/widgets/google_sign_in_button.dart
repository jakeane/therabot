import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart' as buttons;
import 'package:flutter_chatbot/app/services/firebase_auth_service.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: 300,
      child: FlatButton(
          onPressed: () {
            Provider.of<AuthService>(context, listen: false).signInWithGoogle();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: 5),
                child: SvgPicture.asset("assets/images/google.svg",
                    width: 20, height: 20),
              ),
              Text(
                "Login with Google",
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

    // return buttons.GoogleSignInButton(
    //   onPressed: () {
    //     Provider.of<AuthService>(context, listen: false).signInWithGoogle();
    //     ;
    //   },
    //   darkMode: true,
    //   textStyle: TextStyle(
    //     fontSize: 14,
    //     color: Colors.white,
    //   ),
    // );
  }
}
