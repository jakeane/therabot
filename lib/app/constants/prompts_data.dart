import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/models/theme_model.dart';

class PromptsData {
  static TextStyle textStyle = ThemeModel.getThemeStatic().textTheme.bodyText2;
  static TextStyle boldStyle = textStyle.copyWith(fontWeight: FontWeight.bold);

  static List<TextSpan> getContext() {
    return context[
        contextWeights[Random.secure().nextInt(contextWeights.length)]];
  }

  static final List<int> contextWeights = List.filled(6, 1) +
      List.filled(7, 2) +
      List.filled(4, 3) +
      List.filled(3, 4) +
      List.filled(6, 5) +
      List.filled(4, 6) +
      List.filled(3, 7) +
      List.filled(2, 8) +
      List.filled(4, 9) +
      List.filled(4, 10) +
      List.filled(6, 11) +
      List.filled(2, 12) +
      List.filled(7, 13) +
      List.filled(4, 14) +
      List.filled(3, 15) +
      List.filled(8, 16) +
      List.filled(5, 17) +
      List.filled(7, 18) +
      List.filled(8, 19) +
      List.filled(5, 20) +
      List.filled(6, 21) +
      List.filled(2, 22) +
      List.filled(2, 23) +
      List.filled(3, 24) +
      List.filled(3, 25) +
      List.filled(3, 26) +
      List.filled(3, 27) +
      List.filled(7, 28) +
      List.filled(7, 29) +
      List.filled(2, 30) +
      List.filled(2, 31) +
      List.filled(3, 32) +
      List.filled(6, 33) +
      List.filled(3, 34) +
      List.filled(5, 35) +
      List.filled(4, 36);

  static final Map<int, List<TextSpan>> context = {
    1: [
      TextSpan(
          text:
              "You are a ${20 + Random.secure().nextInt(16)} year old who just had a ",
          style: textStyle),
      TextSpan(text: "bad break up with his girlfriend.", style: boldStyle),
      TextSpan(text: " You are feeling ", style: textStyle),
      TextSpan(text: "suicidal and hopeless.", style: boldStyle),
    ],
    2: [
      TextSpan(
          text:
              "You are a ${20 + Random.secure().nextInt(51)} year old who has been ",
          style: textStyle),
      TextSpan(text: "depressed for 2 months", style: boldStyle),
      TextSpan(text: " and you are having ", style: textStyle),
      TextSpan(
          text: "thoughts of suicide without a plan or intent.",
          style: boldStyle),
    ],
    3: [
      TextSpan(
          text:
              "You are a ${30 + Random.secure().nextInt(21)} year old who has been ",
          style: textStyle),
      TextSpan(text: "depressed for most of your life", style: boldStyle),
      TextSpan(text: " and you are having ", style: textStyle),
      TextSpan(text: "thoughts of suicide", style: boldStyle),
      TextSpan(text: " with a ", style: textStyle),
      TextSpan(text: "plan to overdose on medications.", style: boldStyle),
    ],
    4: [
      TextSpan(
          text:
              "You are a ${20 + Random.secure().nextInt(21)} year old experiencing ",
          style: textStyle),
      TextSpan(text: "intrusive traumatic memories", style: boldStyle),
      TextSpan(text: " from your ", style: textStyle),
      TextSpan(text: "childhood", style: boldStyle),
      TextSpan(text: " when you were repeatedly ", style: textStyle),
      TextSpan(text: "sexually abused by your step father.", style: boldStyle),
    ],
    5: [
      TextSpan(
          text:
              "You are a ${20 + Random.secure().nextInt(11)} year old who has ",
          style: textStyle),
      TextSpan(text: "severe anxiety", style: boldStyle),
      TextSpan(text: " that is often ", style: textStyle),
      TextSpan(text: "triggered by social situations.", style: boldStyle),
    ],
    6: [
      TextSpan(
          text: "You are a ${25 + Random.secure().nextInt(21)} year old with ",
          style: textStyle),
      TextSpan(text: "panic attacks", style: boldStyle),
      TextSpan(text: " often ", style: textStyle),
      TextSpan(text: "in public", style: boldStyle),
      TextSpan(text: " and you've been ", style: textStyle),
      TextSpan(text: "avoiding going outside", style: boldStyle),
      TextSpan(text: " because you're ", style: textStyle),
      TextSpan(text: "afraid of having another.", style: boldStyle),
    ],
    7: [
      TextSpan(
          text: "You are a ${50 + Random.secure().nextInt(21)} year old whose ",
          style: textStyle),
      TextSpan(text: "husband died 3 months ago", style: boldStyle),
      TextSpan(text: " and ", style: textStyle),
      TextSpan(
          text:
              "you've had a depressed mood, low energy, and difficulty sleeping, wihtout suicidal thoughts.",
          style: boldStyle),
    ],
    8: [
      TextSpan(
          text:
              "You are a ${40 + Random.secure().nextInt(21)} year old diagnosed with ",
          style: textStyle),
      TextSpan(text: "end stage cancer 3 months ago", style: boldStyle),
      TextSpan(text: " and have been ", style: textStyle),
      TextSpan(text: "extremely depressed", style: boldStyle),
      TextSpan(text: " and have had ", style: textStyle),
      TextSpan(text: "thoughts of suicide.", style: boldStyle),
    ],
    9: [
      TextSpan(
          text: "You are a ${15 + Random.secure().nextInt(11)} year old with ",
          style: textStyle),
      TextSpan(text: "trouble getting work finished", style: boldStyle),
      TextSpan(text: " because you feel the ", style: textStyle),
      TextSpan(
          text: "need to double and triple check each step", style: boldStyle),
      TextSpan(text: " in your work.", style: textStyle),
    ],
    10: [
      TextSpan(
          text:
              "You are a ${25 + Random.secure().nextInt(21)} year old who has been ",
          style: textStyle),
      TextSpan(
          text: "more depressed the last 3 months, drinking alcohol heavily",
          style: boldStyle),
      TextSpan(text: "during that time.", style: textStyle),
    ],
    11: [
      TextSpan(
          text: "You are a ${14 + Random.secure().nextInt(17)} year old who ",
          style: textStyle),
      TextSpan(text: "just broke up with your boyfriend", style: boldStyle),
      TextSpan(text: " and now you're feeling ", style: textStyle),
      TextSpan(text: "suicidal.", style: boldStyle),
    ],
    12: [
      TextSpan(
          text:
              "You are a ${45 + Random.secure().nextInt(31)} year old who has had ",
          style: textStyle),
      TextSpan(text: "recurrence of your depression", style: boldStyle),
      TextSpan(
          text: " the last few months and you've started to ",
          style: textStyle),
      TextSpan(
          text: "hear voices telling you that you're no good.",
          style: boldStyle),
    ],
    13: [
      TextSpan(
          text: "You are a ${20 + Random.secure().nextInt(41)} year old who ",
          style: textStyle),
      TextSpan(text: "feels like \"I'm not good enough\"", style: boldStyle),
      TextSpan(text: " and ", style: textStyle),
      TextSpan(text: "\"I can't do anything right.\"", style: boldStyle),
    ],
    14: [
      TextSpan(
          text: "You are a ${20 + Random.secure().nextInt(31)} year old with ",
          style: textStyle),
      TextSpan(text: "panic attacks.", style: boldStyle),
      TextSpan(text: " They ", style: textStyle),
      TextSpan(text: "come on suddenly", style: boldStyle),
      TextSpan(text: " and you ", style: textStyle),
      TextSpan(text: "don't know what to do.", style: boldStyle),
    ],
    15: [
      TextSpan(
          text:
              "You are a ${30 + Random.secure().nextInt(21)} year old and you've been ",
          style: textStyle),
      TextSpan(text: "having panic attacks.", style: boldStyle),
      TextSpan(text: " You've gone to the ", style: textStyle),
      TextSpan(text: "ER three times", style: boldStyle),
      TextSpan(text: " and they told you there is ", style: textStyle),
      TextSpan(text: "nothing wrong", style: boldStyle),
      TextSpan(text: " and ", style: textStyle),
      TextSpan(text: "it's just anxiety.", style: boldStyle),
    ],
    16: [
      TextSpan(
          text: "You are a ${20 + Random.secure().nextInt(21)} year old who ",
          style: textStyle),
      TextSpan(
          text: "worries all the time about almost everything",
          style: boldStyle),
      TextSpan(text: " and you feel ", style: textStyle),
      TextSpan(text: "stressed all the time.", style: boldStyle),
    ],
    17: [
      TextSpan(
          text:
              "You are a ${25 + Random.secure().nextInt(11)} year old who feels ",
          style: textStyle),
      TextSpan(
          text:
              "\"I'm a worthless human being and I never do anything right.\"",
          style: boldStyle),
    ],
    18: [
      TextSpan(
          text:
              "You are a ${20 + Random.secure().nextInt(21)} year old who feels ",
          style: textStyle),
      TextSpan(
          text:
              "\"like people think bad things about me when I'm talking to them.\"",
          style: boldStyle),
    ],
    19: [
      TextSpan(
          text: "You are a ${14 + Random.secure().nextInt(36)} year old who ",
          style: textStyle),
      TextSpan(text: "feels worried about the future,", style: boldStyle),
      TextSpan(text: " and you are ", style: textStyle),
      TextSpan(text: "scared by the uncertainty.", style: boldStyle),
    ],
    20: [
      TextSpan(
          text:
              "You are a ${25 + Random.secure().nextInt(26)} year old who often thinks ",
          style: textStyle),
      TextSpan(
          text: "\"I'm going to end up alone. I'm a failure.\"",
          style: boldStyle),
    ],
    21: [
      TextSpan(
          text:
              "You are a ${15 + Random.secure().nextInt(21)} year old who is ",
          style: textStyle),
      TextSpan(
          text:
              "\"too afraid to talk to anyone.\" Small talk makes you uncomfortable.",
          style: boldStyle),
    ],
    22: [
      TextSpan(
          text:
              "You are a ${40 + Random.secure().nextInt(21)} year old who is ",
          style: textStyle),
      TextSpan(text: "\"too afraid to leave my house.\"", style: boldStyle),
      TextSpan(text: " You are ", style: textStyle),
      TextSpan(
          text: "unemployed and on disability because of your depression.",
          style: boldStyle),
    ],
    23: [
      TextSpan(
          text: "You are a ${25 + Random.secure().nextInt(26)} year old who ",
          style: textStyle),
      TextSpan(text: "has to wash you hands several times", style: boldStyle),
      TextSpan(text: " in order to ", style: textStyle),
      TextSpan(text: "feel less stressed.", style: boldStyle),
      TextSpan(text: " If you don't, ", style: textStyle),
      TextSpan(
          text: "you become highly anxious and feel like you might die.",
          style: boldStyle),
    ],
    24: [
      TextSpan(
          text: "You are a ${20 + Random.secure().nextInt(16)} year old who ",
          style: textStyle),
      TextSpan(text: "has to get up 5 hours before work", style: boldStyle),
      TextSpan(text: " to get ready. ", style: textStyle),
      TextSpan(
          text: "Otherwise, you feel really anxious and can't sleep.",
          style: boldStyle),
    ],
    25: [
      TextSpan(
          text: "You are a ${30 + Random.secure().nextInt(21)} year old who ",
          style: textStyle),
      TextSpan(
          text:
              "has to check and double check (and sometime triple check) locks",
          style: boldStyle),
      TextSpan(text: " before going to bed. You ", style: textStyle),
      TextSpan(text: "also check appliances numerous times", style: boldStyle),
      TextSpan(text: " to make sure they're turned off.", style: textStyle),
    ],
    26: [
      TextSpan(
          text:
              "You are a ${30 + Random.secure().nextInt(21)} year old who has avoided driving for ",
          style: textStyle),
      TextSpan(
          text: "fear of running over a person or animal;", style: boldStyle),
      TextSpan(text: " if you do drive, you find yourself ", style: textStyle),
      TextSpan(
          text: "going back to check multiple times to ease your anxiety.",
          style: boldStyle),
    ],
    27: [
      TextSpan(
          text:
              "You are a ${18 + Random.secure().nextInt(5)} year old who was ",
          style: textStyle),
      TextSpan(text: "raped at a dorm party.", style: boldStyle),
      TextSpan(
          text: " Now, you have started to experience feelings of ",
          style: textStyle),
      TextSpan(text: "numbness and detachment", style: boldStyle),
    ],
    28: [
      TextSpan(
          text: "You are a ${18 + Random.secure().nextInt(13)} year old ",
          style: textStyle),
      TextSpan(
          text: "\"feeling stressed about school and work", style: boldStyle),
      TextSpan(text: " and just ", style: textStyle),
      TextSpan(text: "need to talk to someone.\"", style: boldStyle),
    ],
    29: [
      TextSpan(
          text: "You are a ${18 + Random.secure().nextInt(18)} year old who ",
          style: textStyle),
      TextSpan(text: "just broke up with their partner,", style: boldStyle),
      TextSpan(text: " and you're ", style: textStyle),
      TextSpan(text: "feeling lonely and hopeless.", style: boldStyle),
    ],
    30: [
      TextSpan(
          text: "You are a ${15 + Random.secure().nextInt(11)} year old whose ",
          style: textStyle),
      TextSpan(text: "dog was hit by a car 2 weeks ago", style: boldStyle),
      TextSpan(text: " and now ", style: textStyle),
      TextSpan(text: "\"I can't stop crying.\"", style: boldStyle),
    ],
    31: [
      TextSpan(
          text: "You are a ${55 + Random.secure().nextInt(21)} year old whose ",
          style: textStyle),
      TextSpan(text: "spouse has Parkinson's disease", style: boldStyle),
      TextSpan(text: " and you are ", style: textStyle),
      TextSpan(text: "feeling extremely overwhelmed", style: boldStyle),
      TextSpan(text: " as his ", style: textStyle),
      TextSpan(text: "primary caregiver.", style: boldStyle),
    ],
    32: [
      TextSpan(
          text:
              "You are a ${50 + Random.secure().nextInt(31)} year old who was ",
          style: textStyle),
      TextSpan(text: "diagnosed with cancer,", style: boldStyle),
      TextSpan(text: " and \"I'm ", style: textStyle),
      TextSpan(text: "trying to cope", style: boldStyle),
      TextSpan(text: " right now.", style: textStyle),
    ],
    33: [
      TextSpan(
          text:
              "You are a ${25 + Random.secure().nextInt(51)} year old who has been ",
          style: textStyle),
      TextSpan(text: "depressed for the last couple months", style: boldStyle),
      TextSpan(text: " and you're ", style: textStyle),
      TextSpan(text: "tired all the time.", style: boldStyle),
    ],
    34: [
      TextSpan(
          text:
              "You are a ${25 + Random.secure().nextInt(51)} year old who has been ",
          style: textStyle),
      TextSpan(
          text: "feeling depressed for the last couple months",
          style: boldStyle),
      TextSpan(
          text: " and it seems to be getting worse. You sometimes ",
          style: textStyle),
      TextSpan(
          text: "hear voices telling you that you're worthless.",
          style: boldStyle),
      TextSpan(text: " You've never had voices before.", style: textStyle),
    ],
    35: [
      TextSpan(
          text: "You are a ${18 + Random.secure().nextInt(18)} year old who ",
          style: textStyle),
      TextSpan(
          text: "has fights with you friends and family,", style: boldStyle),
      TextSpan(text: " and you feel like ", style: textStyle),
      TextSpan(
          text: "you don't have any control over your emotions.",
          style: boldStyle),
      TextSpan(text: " Even the ", style: textStyle),
      TextSpan(text: "littlest things can set you off.", style: boldStyle),
    ],
    36: [
      TextSpan(
          text:
              "You are a ${18 + Random.secure().nextInt(18)} year old who feels ",
          style: textStyle),
      TextSpan(
          text: "\"I don't have a good sense of who I am.\"", style: boldStyle),
      TextSpan(text: " You've had ", style: textStyle),
      TextSpan(text: "many failed relationships", style: boldStyle),
      TextSpan(text: " in your life.", style: textStyle),
    ]
  };
}
