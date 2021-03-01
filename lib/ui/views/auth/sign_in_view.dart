import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/services/firebase_auth_service.dart';
import 'package:flutter_chatbot/ui/page_base.dart';
import 'package:flutter_chatbot/ui/widgets/auth/buttons/apple_sign_in_button.dart';
import 'package:flutter_chatbot/ui/widgets/auth/core/auth_view_header.dart';
import 'package:flutter_chatbot/ui/widgets/auth/forms/sign_in_form.dart';
import 'package:flutter_chatbot/ui/widgets/auth/buttons/google_sign_in_button.dart';
import 'package:flutter_chatbot/ui/widgets/auth/buttons/go_to_button.dart';
import 'package:flutter_chatbot/app/constants/strings.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void navigate() {
      Navigator.pushNamed(context, Strings.createAccountRoute);
    }

    return PageBase(
        child: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AuthViewHeader(),
        Column(children: [
          SignInForm(),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: SvgPicture.asset("assets/images/OR.svg"),
          ),
          GoogleSignInButton(),
          AppleSignInButton()
        ]),
        Spacer(),
        GoToButton(
          message: "New user? Create an account.",
          navigate: navigate,
        )
      ],
    )));
  }
}
