import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';

// Define a custom Form widget.
class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();

  String email, password;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          // Add TextFormFields and RaisedButton here.
          Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              margin: EdgeInsets.only(top: 80),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: Theme.of(context).colorScheme.secondary)),
              width: 300,
              child: TextFormField(
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption,
                decoration: InputDecoration.collapsed(hintText: "Username"),
                onSaved: (value) => email = value,
              )),

          Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: Theme.of(context).colorScheme.secondary)),
              width: 300,
              child: TextFormField(
                textAlign: TextAlign.center,
                obscureText: true,
                style: Theme.of(context).textTheme.caption,
                decoration: InputDecoration.collapsed(hintText: "Password"),
                onSaved: (value) => password = value,
              )),
          Container(
            margin: EdgeInsets.only(top: 20),
            width: 300,
            child: FlatButton(
                onPressed: () {
                  _formKey.currentState.save();
                  Provider.of<AuthService>(context, listen: false)
                      .signInRegularAccount(email, password);
                },
                child: Text(
                  "Login",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.primary)),
                color: Theme.of(context).colorScheme.primary),
          )
        ]));
  }
}
