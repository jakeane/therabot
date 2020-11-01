import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/services/firebase_auth_service.dart';
import 'package:flutter_chatbot/ui/widgets/auth/forms/entry_field.dart';
import 'package:flutter_chatbot/ui/widgets/auth/forms/submit_button.dart';
import 'package:provider/provider.dart';

// Need error handling design
class CreateAccountForm extends StatefulWidget {
  @override
  _CreateAccountFormState createState() => _CreateAccountFormState();
}

class _CreateAccountFormState extends State<CreateAccountForm> {
  final _formKey = GlobalKey<FormState>();

  String email, password, confirmPassword;

  void saveEmail(String newValue) => email = newValue;
  void savePassword(String newValue) => password = newValue;
  void saveConfirmPassword(String newValue) => confirmPassword = newValue;

  void onSubmit() {
    _formKey.currentState.save();
    if (password == confirmPassword) {
      Provider.of<AuthService>(context, listen: false)
          .createRegularAccount(email, password);
    }
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
          EntryField(
              hintText: "Confirm Password",
              topMargin: 20,
              obscureText: true,
              saveValue: saveConfirmPassword),
          SubmitButton(
            topMargin: 50,
            text: "Create Account",
            onSubmit: onSubmit,
          )
        ]));
  }
}
