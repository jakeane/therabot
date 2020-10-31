import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/models/theme_model.dart';
import 'package:flutter_chatbot/app/services/firebase_auth_service.dart';
import 'package:flutter_chatbot/ui/views/authentication/create_account_view.dart';
import 'package:flutter_chatbot/ui/views/onboarding/onboard_pageview.dart';
import 'package:flutter_chatbot/app/routing/private_route.dart';
import 'package:flutter_chatbot/app/routing/public_route.dart';
import 'package:provider/provider.dart';
import '../app/constants/strings.dart';
import '../ui/views/authentication/sign_in_view.dart';
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
            initialRoute: Strings.signinRoute,
            routes: {
              Strings.signinRoute: (_) => PublicRoute(route: SignInView()),
              Strings.createAccountRoute: (_) => PublicRoute(
                    route: CreateAccountView(),
                  ),
              Strings.messagingViewRoute: (_) =>
                  PrivateRoute(route: MessagingView()),
              Strings.onBoardingRoute: (_) =>
                  PrivateRoute(route: OnBoardPageview()),
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
