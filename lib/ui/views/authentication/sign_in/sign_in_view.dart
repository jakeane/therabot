import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/constants/strings.dart';
import 'package:flutter_chatbot/ui/views/authentication/sign_in/widgets/auth_view_header.dart';
import 'package:flutter_chatbot/ui/views/authentication/sign_in/widgets/sign_in_form.dart';
import 'package:flutter_svg/svg.dart';
import 'widgets/google_sign_in_button.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                  maxHeight: MediaQuery.of(context).size.height),
              child: SafeArea(
                  child: Center(
                      child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AuthViewHeader(),
                  SignInForm(),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: SvgPicture.asset("assets/images/OR.svg"),
                  ),
                  GoogleSignInButton(),
                  Spacer(),
                  Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, Strings.createAccountRoute);
                        },
                        child: Text(
                          "New user? Create an account",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.grey),
                        ),
                      )),
                ],
              )))),
        ),
      ),
    );
  }
}
