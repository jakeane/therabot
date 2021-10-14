import 'package:flutter/material.dart';
import 'package:therabot/widgets/page_base.dart';
import 'package:therabot/widgets/auth/auth_header.dart';
import 'package:therabot/widgets/auth/create_account_form.dart';
import 'package:therabot/widgets/auth/goto_button.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void navigate() {
      Navigator.pop(context);
    }

    return PageBase(
        child: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const AuthHeader(),
        const CreateAccountForm(),
        const Spacer(),
        GoToButton(
          message: "Already have an account? Login.",
          navigate: navigate,
        )
      ],
    )));
  }
}
