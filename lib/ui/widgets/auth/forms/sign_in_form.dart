import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/services/firebase_auth_service.dart';
import 'package:flutter_chatbot/ui/widgets/auth/forms/entry_field.dart';
import 'package:flutter_chatbot/ui/widgets/auth/forms/submit_button.dart';
import 'package:provider/provider.dart';

// Need error handling design
class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();

  String email, password;

  void saveEmail(String newValue) => email = newValue;
  void savePassword(String newValue) => password = newValue;

  void onSubmit() {
    _formKey.currentState.save();
    Provider.of<AuthService>(context, listen: false)
        .signInRegularAccount(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          EntryField(
              hintText: "Email",
              topMargin: 0,
              obscureText: false,
              saveValue: saveEmail),
          EntryField(
              hintText: "Password",
              topMargin: 20,
              obscureText: true,
              saveValue: savePassword),
          SubmitButton(
            topMargin: 20,
            text: "Login",
            onSubmit: onSubmit,
          )
        ]));
  }
}
