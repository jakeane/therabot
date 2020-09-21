import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart' as buttons;
import 'package:flutter_chatbot/app/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buttons.GoogleSignInButton(
      onPressed: () {
        Provider.of<AuthService>(context, listen: false).signInWithGoogle();
        ;
      },
      darkMode: true,
      textStyle: TextStyle(
        fontSize: 14,
        color: Colors.white,
      ),
    );
  }
}
