import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class TherabotModel extends ChangeNotifier {
  static const String EMOTION_URL = 'http://35.167.240.2:8888/predict';
  static const double CONF_THRESHOLD = 0.1;

  static const Map<String, List<double>> animationEmotions = {
    'terror': [2.75, 6.35, 2.95],
    'happy_anticipation': [5.26, 7.39, 5.53],
    'sad_anticipation': [5.26, 3.39, 5.53],
    'anxiety': [2.38, 4.78, 3.39],
    'disgust': [3.32, 5, 4.84],
    'happy_surprise': [7.44, 8.57, 5.17],
    'sad_surprise': [7.44, 4.57, 5.17],
    'anger': [2.5, 5.93, 5.14],
    'happy_trust': [7.24, 6.3, 6.95],
    'sad_trust': [7.24, 2.3, 6.95],
    'fear': [2.93, 6.14, 3.32],
    'depression': [2.44, 5.2, 3.33],
    'sad': [2.1, 3.49, 3.84],
    'joy': [8.21, 5.55, 7],
  };

  static const Map<String, List<double>> apiEmotions = {
    'sentimental': [6.27, 2.95, 6.73],
    'afraid': [2.25, 5.12, 2.71],
    'proud': [7, 5.55, 7.09],
    'faithful': [7.95, 4.48, 7.29],
    'terrified': [2.51, 6.1, 3.29],
    'joyful': [8.21, 5.53, 7.05],
    'angry': [2.53, 6.2, 4.11],
    'sad': [2.1, 3.49, 3.84],
    'jealous': [2.38, 5.9, 4.68],
    'grateful': [7.5, 4.29, 7],
    'prepared': [5.32, 4.15, 7.26],
    'embarrassed': [3.51, 5.38, 3.67],
    'excited': [8.11, 6.43, 7.33],
    'annoyed': [2.8, 5.29, 4.08],
    'lonely': [2.67, 4.37, 3.33],
    'ashamed': [2.52, 5.65, 4.63],
    'guilty': [3.09, 4.65, 4.5],
    'surprised': [6.57, 5.95, 4.72],
    'nostalgic': [6.68, 4.37, 5.05],
    'confident': [7.56, 4.62, 7.04],
    'furious': [2.57, 6.09, 3.89],
    'disappointed': [2.65, 4.47, 4.08],
    'caring': [7.64, 2.67, 6.56],
    'trusting': [7.24, 4.3, 6.95],
    'disgusted': [2.68, 4.89, 4.24],
    'anticipating': [6, 5.7, 5.36],
    'anxious': [3.8, 6.2, 4.15],
    'hopeful': [7.44, 4.84, 6.58],
    'content': [6.7, 3.17, 5.92],
    'impressed': [6.66, 4.9, 6.38],
    'apprehensive': [3.32, 4.77, 4.64],
    'devastated': [2.09, 5.5, 3.96]
  };

  Queue<List<double>> emotionHist = Queue.of(List.filled(3, List.filled(3, 6)));

  String getEmotion() {
    List<List<double>> emotionList = emotionHist.toList();

    List<double> currEmotion = [0, 1, 2].map((idx) {
      return (emotionList[0][idx] +
              (0.5 * emotionList[1][idx]) +
              (0.25 * emotionList[2][idx])) /
          1.75;
    }).toList();

    // print(currEmotion);
    return closestEmotion(currEmotion);
  }

  String getAnimation() {
    List<List<double>> emotionList = emotionHist.toList();

    List<double> currEmotion = [0, 1, 2].map((idx) {
      return (emotionList[0][idx] +
              (0.5 * emotionList[1][idx]) +
              (0.25 * emotionList[2][idx])) /
          1.75;
    }).toList();

    // print(currEmotion);
    return closestAnimation(currEmotion);
  }

  String closestAnimation(List<double> currEmotion) {
    String topEmotion = '';
    double shortestDist = double.maxFinite;
    double dist;

    animationEmotions.forEach((emotion, dims) {
      dist = [0, 1, 2]
          .fold(0, (total, i) => total + pow(dims[i] - currEmotion[i], 2));
      if (dist < shortestDist) {
        shortestDist = dist;
        topEmotion = emotion;
      }
    });
    return topEmotion;
  }

  String closestEmotion(List<double> currEmotion) {
    String topEmotion = '';
    double shortestDist = double.maxFinite;
    double dist;

    apiEmotions.forEach((emotion, dims) {
      dist = [0, 1, 2]
          .fold(0, (total, i) => total + pow(dims[i] - currEmotion[i], 2));
      if (dist < shortestDist) {
        shortestDist = dist;
        topEmotion = emotion;
      }
    });
    return topEmotion;
  }

  void calculateEmotion(String textJSON) {
    print('hi from calculateEmotion');
    post(EMOTION_URL, body: textJSON).then((res) {
      Map<String, double> emotionProbs =
          jsonDecode(res.body)['probabilities'].cast<String, double>();
      print("Emotions: $emotionProbs");
      List<double> emotion = processEmotion(emotionProbs);
      print("calc emotions: $emotion");
      addEmotion(emotion);
    });
  }

  List<double> processEmotion(Map<String, double> emotionProbs) {
    double confEmotions = 0;
    List<double> emotionState = [0, 0, 0];

    emotionProbs.forEach((key, value) {
      if (value >= CONF_THRESHOLD) {
        confEmotions += value;
        for (int i = 0; i < apiEmotions[key].length; i++) {
          emotionState[i] += value * apiEmotions[key][i];
        }
      }
    });

    if (emotionState.reduce((value, element) => value + element) == 0) {
      return [5, 5, 5];
    } else {
      for (int i = 0; i < emotionState.length; i++) {
        emotionState[i] /= confEmotions;
      }
      return emotionState;
    }
  }

  void addEmotion(List<double> emotion) {
    emotionHist.removeLast();
    emotionHist.addFirst(emotion);
  }
}
