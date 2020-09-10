import 'package:flutter/material.dart';

class ChatState extends ChangeNotifier {
  bool _feedbackMode = false;
  int _selected = 0;

  bool get feedbackMode => _feedbackMode;
  int get selected => _selected;

  void changeFeedbackState() {
    _feedbackMode = !_feedbackMode;
    notifyListeners();
  }

  void setSelected(int select) {
    _selected = select;
    notifyListeners();
  }
}
