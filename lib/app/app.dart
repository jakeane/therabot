import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/models/theme_model.dart';
import '../app/constants/strings.dart';
import '../ui/views/authentication/sign_in/sign_in_view.dart';
import '../ui/views/messaging/messaging_view.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: themeLight,
      darkTheme: themeDark,
      initialRoute: '/',
      routes: {
        Strings.homeRoute: (context) => SignInView(),
        Strings.messsagingViewRoute: (context) => MessagingView(),
      },
    );
  }
}
