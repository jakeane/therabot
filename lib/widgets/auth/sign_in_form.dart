import 'package:flutter/material.dart';
import 'package:therabot/store/auth_provider.dart';
import 'package:therabot/widgets/auth/entry_field.dart';
import 'package:therabot/widgets/auth/form_submit.dart';
import 'package:provider/provider.dart';

// Need error handling design
class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();

  String email = "", password = "";
  String errorMessage = "";

  void saveEmail(String? newValue) => email = newValue ?? "";
  void savePassword(String? newValue) => password = newValue ?? "";

  void onSubmit() {
    setState(() {
      errorMessage = "";
    });
    _formKey.currentState?.save();
    Provider.of<AuthProvider>(context, listen: false)
        .signInRegularAccount(email, password)
        .then((res) {
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
                ?.copyWith(fontSize: 12, color: const Color(0xFFEB5757)),
          ),
          // Make entry type email
          EntryField(
              hintText: "Email",
              topMargin: 0,
              obscureText: false,
              saveValue: saveEmail,
              textInputType: TextInputType.emailAddress),
          EntryField(
              hintText: "Password",
              topMargin: 20,
              obscureText: true,
              saveValue: savePassword,
              textInputType: TextInputType.visiblePassword),
          FormSubmit(
            topMargin: 20,
            text: "Login",
            onSubmit: onSubmit,
          )
        ]));
  }
}
