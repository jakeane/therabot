
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:therabot/widgets/auth/apple_sign_in_button.dart';
import 'package:therabot/widgets/page_base.dart';
import 'package:therabot/constants/strings.dart';
import 'package:therabot/widgets/auth/auth_header.dart';
import 'package:therabot/widgets/auth/sign_in_form.dart';
import 'package:therabot/widgets/auth/google_sign_in.dart';
import 'package:therabot/widgets/auth/goto_button.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

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
        const AuthHeader(),
        Column(children: [
          const SignInForm(),
          Container(
            margin: const EdgeInsets.only(top: 15),
            child: SvgPicture.asset("assets/images/OR.svg"),
          ),
          const GoogleSignInButton(),
          if (Platform.isIOS)
            const AppleSignInButton()
        ]),
        const Spacer(),
        GoToButton(
          message: "New user? Create an account.",
          navigate: navigate,
        )
      ],
    )));
  }
}