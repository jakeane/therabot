import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart' as buttons;
import 'package:flutter_chatbot/app/services/firebase_signin.dart';
import '../../../messaging/messaging_view.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buttons.GoogleSignInButton(
      onPressed: () {
        signInWithGoogle().then((result) {
          if (result != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MessagingView()),
            );
          }
        });
      },
      darkMode: true,
      textStyle: TextStyle(
        fontSize: 14,
        color: Colors.white,
      ),
    );
  }
}
