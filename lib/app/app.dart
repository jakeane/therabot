import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/models/theme_model.dart';
import 'package:flutter_chatbot/app/services/firebase_signin.dart';
import 'package:flutter_chatbot/ui/views/home/home_view.dart';
import 'package:flutter_chatbot/ui/views/home/landing_view.dart';
import 'package:flutter_chatbot/ui/views/onboarding/onboard_pageview.dart';
import 'package:flutter_chatbot/ui/views/private_route.dart';
import 'package:provider/provider.dart';
import '../app/constants/strings.dart';
import '../ui/views/authentication/sign_in/sign_in_view.dart';
import '../ui/views/messaging/messaging_view.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeModel()),
          ChangeNotifierProvider(create: (_) => AuthService())
        ],
        child: Consumer<ThemeModel>(builder: (context, theme, _) {
          return MaterialApp(
            title: 'Chatbot App',
            theme: theme.getTheme(),
            initialRoute: Strings.landingRoute,
            routes: {
              Strings.landingRoute: (context) => LandingView(),
              Strings.messagingViewRoute: (context) =>
                  PrivateRoute(route: MessagingView()),
              Strings.onBoardingRoute: (context) =>
                  PrivateRoute(route: OnBoardPages()),
            },
          );
        }));
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return SignInView();
          }
          return MessagingView();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

// return MaterialApp(
//       title: 'Material App',
//       theme: themeNotifier.getTheme(),
//       initialRoute: '/',
//       routes: {
//         Strings.homeRoute: (context) => SignInView(),
//         Strings.messsagingViewRoute: (context) => MessagingView(),
//       },
//     );
