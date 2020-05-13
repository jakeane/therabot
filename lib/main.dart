import 'package:flutter/material.dart';
import 'package:flutter_chatbot/views/home/home_view.dart';
import 'package:flutter_chatbot/widgets/home_page_dialogflow/home_page_dialogflow.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Chatbot",
      routes: {
        '/': (context) => HomePageDialogflow(),
      },
    );
  }
}

