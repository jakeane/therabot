import 'package:flutter/material.dart';
import 'package:flutter_chatbot/views/home/home_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Chatbot",
      routes: {
        // Creates a material app with a single homepage so far.
        '/': (context) => HomeView(),
      },
    );
  }
}
