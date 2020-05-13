import 'package:flutter/material.dart';
import 'package:flutter_chatbot/widgets/navigation_bar/navigation_bar.dart';
import 'package:flutter_chatbot/widgets/home_page_dialogflow/home_page_dialogflow.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget> [
          new HomePageDialogflow(),
        ],
      ),
    );
  }
}
