import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/models/theme_model.dart';
import 'package:provider/provider.dart';
import '../app/constants/strings.dart';
import '../ui/views/authentication/sign_in/sign_in_view.dart';
import '../ui/views/messaging/messaging_view.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      //Here we provide our ThemeManager to child widget tree
      create: (_) => ThemeModel(),

      //Consumer will call builder method each time ThemeManager
      //calls notifyListeners()
      child: Consumer<ThemeModel>(builder: (context, theme, _) {
        return MaterialApp(
          title: 'Chatbot App',
          theme: theme.getTheme(),
          initialRoute: '/',
          routes: {
            Strings.homeRoute: (context) => SignInView(),
            Strings.messsagingViewRoute: (context) => MessagingView(),
          },
        );
      }),
    );
    final themeNotifier = Provider.of<ThemeModel>(context);
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
