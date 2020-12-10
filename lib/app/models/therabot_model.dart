import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class TherabotModel extends ChangeNotifier {
  static const NRCLEX_URL =
      'https://gabho7ma71.execute-api.us-west-2.amazonaws.com/default/NRC_Lex';

  final List<String> emotions = [
    'anger',
    'anticipation',
    'disgust',
    'fear',
    'joy',
    'sadness',
    'surprise',
    'trust'
  ];

  Queue<List<int>> emotionHist = Queue.of(List.filled(3, List.filled(8, 0)));

  String getEmotion() {
    List<List<int>> emotionList = emotionHist.toList();
    List<int> topEmot = [4];
    double topEmotVal = 0;

    for (int i = 0; i < emotionList[0].length; i++) {
      double emotVal = emotionList[0][i] +
          (0.5 * emotionList[1][i]) +
          (0.25 * emotionList[2][i]);

      if (emotVal > topEmotVal) {
        topEmotVal = emotVal;
        topEmot = [i];
      } else if (emotVal == topEmotVal) {
        topEmot.add(i);
      }
    }

    int result =
        topEmotVal == 0 ? 4 : topEmot[Random.secure().nextInt(topEmot.length)];

    return emotions[result];
  }

  void calculateEmotion(String textJSON) {
    post(NRCLEX_URL, body: textJSON).then((res) {
      List<int> emotion = jsonDecode(res.body)['result'].cast<int>();
      print("Emotion: $emotion");
      addEmotion(emotion);
    });
  }

  void addEmotion(List<int> emotion) {
    emotionHist.removeLast();
    emotionHist.addFirst(emotion);
    notifyListeners();
  }
}
