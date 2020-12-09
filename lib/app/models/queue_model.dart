import 'package:flutter/material.dart';
import 'package:async/async.dart';

class QueueModel extends ChangeNotifier {
  List<String> _messages = new List<String>();
  RestartableTimer _timer;

  void sendMessage() {
    String composedMessage = _messages.join(" ");
    print("Message sent: $composedMessage");
    _messages.clear();
  }

  void addMessage(String message) {
    if (_messages.isEmpty) {
      startTimer();
    }
    _messages.add(message);
  }

  void startTimer() {
    print("Starting timer");
    _timer = new RestartableTimer(Duration(seconds: 5), sendMessage);
  }

  void resetTimer() {
    if (_timer != null && _timer.isActive) {
      _timer.reset();
    }
  }
}
