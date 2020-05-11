import 'package:flutter/material.dart';

void main() => runApp(FlutterChatbot());

class FlutterChatbot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => SignUpScreen(),
      },
    );
  }
}

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SizedBox(
          child: Text("Hello Professor Jacobson"),
        ),
      ),
    );
  }
}
