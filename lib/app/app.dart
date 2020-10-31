import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/models/theme_model.dart';
import 'package:flutter_chatbot/app/services/firebase_auth_service.dart';
import 'package:flutter_chatbot/ui/views/auth/create_account_view.dart';
import 'package:flutter_chatbot/ui/views/onboarding/onboard_pageview.dart';
import 'package:flutter_chatbot/app/routing/private_route.dart';
import 'package:flutter_chatbot/app/routing/public_route.dart';
import 'package:provider/provider.dart';
import '../app/constants/strings.dart';
import 'package:flutter_chatbot/ui/views/auth/sign_in_view.dart';
import 'package:flutter_chatbot/ui/views/messaging/messaging_view.dart';

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
