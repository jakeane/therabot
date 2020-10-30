import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/constants/strings.dart';
import 'package:flutter_chatbot/ui/views/authentication/sign_in/widgets/auth_view_header.dart';
import 'package:flutter_chatbot/ui/views/authentication/sign_in/widgets/create_account_form.dart';
import 'package:flutter_svg/svg.dart';

class CreateAccountView extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AuthViewHeader(),
              CreateAccountForm(),
              Spacer(),
              Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Already have an account? Login",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.grey),
                    ),
                  )),
            ],
          )),
        ),
      ),
    );
  }
}
