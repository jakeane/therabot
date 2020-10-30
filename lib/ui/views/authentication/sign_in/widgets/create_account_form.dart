import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';

class CreateAccountForm extends StatefulWidget {
  @override
  _CreateAccountFormState createState() => _CreateAccountFormState();
}

class _CreateAccountFormState extends State<CreateAccountForm> {
  final _formKey = GlobalKey<FormState>();

  String email, password, confirmPassword;

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
                  decoration: InputDecoration.collapsed(hintText: "Email"),
                  onSaved: (value) => email = value)),

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
                  onSaved: (value) => password = value)),
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
                  decoration:
                      InputDecoration.collapsed(hintText: "Confirm Password"),
                  onSaved: (value) => confirmPassword = value)),
          Container(
            width: 300,
            margin: EdgeInsets.only(top: 50),
            child: FlatButton(
                onPressed: () {
                  _formKey.currentState.save();
                  Provider.of<AuthService>(context, listen: false)
                      .createRegularAccount(email, password);
                },
                child: Text(
                  "Create Account",
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
