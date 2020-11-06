import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/services/firebase_auth_service.dart';
import 'package:flutter_chatbot/ui/widgets/auth/forms/entry_field.dart';
import 'package:flutter_chatbot/ui/widgets/auth/forms/form_submit.dart';
import 'package:provider/provider.dart';

// Need error handling design
class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();

  String email, password;
  String errorMessage = "";

  final List<String> errorCodes = [
    "invalid-email",
    "wrong-password",
    "user-not-found"
  ];

  final List<String> errors = [
    "The email address is badly formatted.",
    "The password is invalid or the user does not have a password.",
    "There is no user record corresponding to this identifier. The user may have been deleted.",
    "Email or password was wrong. Please try again."
  ];

  void saveEmail(String newValue) => email = newValue;
  void savePassword(String newValue) => password = newValue;

  void onSubmit() {
    setState(() {
      errorMessage = "";
    });
    _formKey.currentState.save();
    Provider.of<AuthService>(context, listen: false)
        .signInRegularAccount(email, password)
        .then((res) {
      print(res);
      if (res != "Success.") {
        setState(() {
          errorMessage = "Email or password was wrong. Please try again.";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          Text(
            errorMessage,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(fontSize: 12, color: Color(0xFFEB5757)),
          ),
          EntryField(
              hintText: "Email",
              topMargin: 10,
              obscureText: false,
              saveValue: saveEmail),
          EntryField(
              hintText: "Password",
              topMargin: 20,
              obscureText: true,
              saveValue: savePassword),
          FormSubmit(
            topMargin: 20,
            text: "Login",
            onSubmit: onSubmit,
          )
        ]));
  }
}
