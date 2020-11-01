import 'package:flutter/material.dart';
import 'package:flutter_chatbot/ui/page_base.dart';
import 'package:flutter_chatbot/ui/widgets/auth/core/auth_view_header.dart';
import 'package:flutter_chatbot/ui/widgets/auth/forms/create_account_form.dart';
import 'package:flutter_chatbot/ui/widgets/auth/buttons/go_to_button.dart';

class CreateAccountView extends StatelessWidget {
  Widget build(BuildContext context) {
    void navigate() {
      Navigator.pop(context);
    }

    return PageBase(
        child: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AuthViewHeader(),
        CreateAccountForm(),
        GoToButton(
          message: "Already have an account? Login.",
          navigate: navigate,
        )
      ],
    )));
  }
}
