import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:therabot/screens/chatbot.dart';
import 'package:therabot/screens/create_account.dart';
import 'package:therabot/screens/onboard.dart';
import 'package:therabot/screens/sign_in.dart';
import 'package:therabot/store/auth_provider.dart';
import 'package:therabot/store/config_provider.dart';
import 'package:therabot/store/theme_provider.dart';
import 'package:therabot/constants/strings.dart';
import 'package:therabot/navigation/private_route.dart';
import 'package:therabot/navigation/public_route.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => ConfigProvider())
        ],
        child: Consumer<ThemeProvider>(builder: (context, theme, _) {
          return MaterialApp(
            title: 'Chatbot App',
            theme: theme.getTheme(),
            // theme: theme.getLight(),
            // darkTheme: theme.getDark(),
            // themeMode: theme.getIsDark() ? ThemeMode.dark : ThemeMode.light,
            initialRoute: Strings.signinRoute,
            routes: {
              Strings.signinRoute: (_) =>
                  const PublicRoute(route: SignInScreen()),
              Strings.createAccountRoute: (_) =>
                  const PublicRoute(route: CreateAccountScreen()),
              Strings.messagingViewRoute: (_) =>
                  const PrivateRoute(route: ChatbotScreen()),
              Strings.onBoardingRoute: (_) =>
                  const PrivateRoute(route: OnBoardPageview()),
            },
          );
        }));
  }
}
