import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/constants/strings.dart';
import 'package:flutter_chatbot/ui/views/authentication/sign_in/widgets/anonymous_sign_in_button.dart';
import 'package:flutter_chatbot/ui/views/authentication/sign_in/widgets/sign_in_form.dart';
import 'package:flutter_svg/svg.dart';
import 'widgets/google_sign_in_button.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key key}) : super(key: key);

  @override
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
              SignInForm(),
              FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, Strings.createAccountRoute);
                },
                child: Text(
                  "New user? Create an account",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.grey),
                ),
              )
              // AnonymousSignInButton(),
              // Container(
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(20),
              //         border: Border.all(
              //             color: Theme.of(context).colorScheme.secondary)),
              //     width: 300,
              //     child: TextField(
              //       style: Theme.of(context).textTheme.caption,
              //       decoration: InputDecoration.collapsed(hintText: "Email"),
              //     )),
              // Container(
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(20),
              //         border: Border.all(
              //             color: Theme.of(context).colorScheme.secondary)),
              //     width: 300,
              //     child: TextField(
              // style: Theme.of(context).textTheme.caption,
              // decoration: InputDecoration.collapsed(hintText: "Password"),
              //     ))
            ],
          )),
        ),
      ),
    );
  }
}
