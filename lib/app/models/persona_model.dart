import 'dart:math';

import 'package:flutter/material.dart';

class PersonaModel extends ChangeNotifier {
  bool isMale = true;
  int age = 28;
  String issue = "generalized anxiety disorder";

  List<String> issues = ["the big happy", "the big sad", "too many apples"];

  void setPrompt() {
    // Random number gen. normal distribution?
    age = Random.secure().nextInt(70);
    isMale = Random.secure().nextBool();
    issue = issues[Random.secure().nextInt(issues.length)];
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
