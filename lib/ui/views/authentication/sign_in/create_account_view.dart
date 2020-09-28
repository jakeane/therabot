import 'package:flutter/material.dart';
import 'package:flutter_chatbot/ui/views/authentication/sign_in/widgets/create_account_form.dart';
import 'package:flutter_chatbot/ui/views/authentication/sign_in/widgets/google_sign_in_button.dart';
import 'package:flutter_chatbot/ui/views/authentication/sign_in/widgets/sign_in_form.dart';
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/bot_logo.svg',
              ),
              SvgPicture.asset(
                'assets/images/therabot.svg',
              ),
              GoogleSignInButton(),
              CreateAccountForm()
            ],
          )),
        ),
      ),
    );
  }
}
