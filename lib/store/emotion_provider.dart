import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class EmotionProvider extends ChangeNotifier {
  static const String emotionUrl = 'http://35.167.240.2:8888/predict';
  static const String localUrl = 'http://0.0.0.0:8000/predict';
  static const double confThreshold = 0.1;

  List<String> emotions = [
    "joy",
    "happy_trust",
    "happy_surprise",
    "happy_anticipation",
    "sad",
    "depression",
    "disgust",
    "fear",
    "terror",
    "sad_surprise",
    "sad_anticipation",
    "anxiety",
    "anger",
    "sad_trust"
  ];

  Queue<List<double>> emotionHist =
      Queue.of(List.filled(3, List.filled(14, 0)));

  String getAnimation() {
    List<List<double>> emotionList = emotionHist.toList();

    List<double> currEmotion = emotions.asMap().entries.map((entry) {
      return (emotionList[0][entry.key] +
          (0.5 * emotionList[1][entry.key]) +
          (0.25 * emotionList[2][entry.key]));
    }).toList();

    double emotionMax = currEmotion.reduce(max);

    return emotionMax == 0
        ? 'neutral'
        : emotions[currEmotion.indexOf(emotionMax)];
  }

  void calculateEmotion(String textJSON) {
    post(Uri.parse(emotionUrl), body: textJSON).then((res) {
      List<double> emotionProbs =
          jsonDecode(res.body)['animations'].cast<double>();
      emotionHist.removeLast();
      emotionHist.addFirst(emotionProbs);
      notifyListeners();
    });
    notifyListeners();

  }
}
