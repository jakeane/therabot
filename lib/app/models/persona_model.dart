import 'dart:math';

import 'package:flutter/material.dart';

class PersonaModel extends ChangeNotifier {
  bool isMale = true;
  int age = 28;
  String issue = "generalized anxiety disorder";

  void setPrompt() {
    // Random number gen. normal distribution?
    isMale = Random.secure().nextBool();
    // Weighted selection of issues
    // notifyListeners();
  }

  Map<String, String> getPrompt() {
    return {
      "age": age.toString(),
      "gender": isMale ? "male" : "female",
      "issue": issue
    };
  }
}
