import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/models/therabot_model.dart';
import 'package:provider/provider.dart';

class AvatarAnimation extends StatefulWidget {
  @override
  _AvatarAnimationState createState() => _AvatarAnimationState();
}

class _AvatarAnimationState extends State<AvatarAnimation>
    with TickerProviderStateMixin {
  final String root = "assets/animations";

  AnimationController _controller;
  IntTween _intTween;
  Animation<int> _animation;

  String currentEmotion = "happy";
  String currentAnimation = "CB1.Happy.Idle1";

  final Map<String, List<String>> animations = {
    "happy": [
      "CB1.Happy.Idle1",
      "CB1.Happy.Idle2",
      "CB1.Happy.Idle3",
      "CB1.Happy.Idle4",
      "CB1.Happy.Idle5",
    ],
    "sad": [
      "CB1.Sad.Idle1",
      "CB1.Sad.Idle2",
      // "CB1.Sad.Idle3",
      // "CB1.Sad.Idle4",
      // "CB1.Sad.Idle5",
    ]
    // "idle1": "assets/animations/idle/happy_idle1/CB1_Happy_Idle1.",
    // "idle2": "assets/animations/idle/happy_idle2/CB1.Happy.Idle12",
  };

  final Map<String, String> animationFrameRoot = {
    "CB1.Happy.Idle1": "CB1_Happy_Idle1",
    "CB1.Happy.Idle2": "CB1_Happy_Idle2",
    "CB1.Happy.Idle3": "CB1_Happy_Idle3",
    "CB1.Happy.Idle4": "CB1_Happy_Idle4",
    "CB1.Happy.Idle5": "CB1_Happy_Idle5",
    "CB1.Sad.Idle1": "CB1_Sad_Idle1",
    "CB1.Sad.Idle2": "CB1_Sad_Idle2",
    "CB1.Sad.Idle3": "CB1_Sad_Idle3",
    "CB1.Sad.Idle4": "CB1_Sad_Idle4",
    "CB1.Sad.Idle5": "CB1.Sad.Idle5",
  };

  final Map<String, int> animationLengths = {
    "CB1.Happy.Idle1": 72,
    "CB1.Happy.Idle2": 99,
    "CB1.Happy.Idle3": 160,
    "CB1.Happy.Idle4": 109,
    "CB1.Happy.Idle5": 95,
    "CB1.Sad.Idle1": 85,
    "CB1.Sad.Idle2": 124,
    "CB1.Sad.Idle3": 192,
    "CB1.Sad.Idle4": 72,
    "CB1.Sad.Idle5": 72,
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(
            milliseconds:
                (animationLengths[currentAnimation] / 24 * 1000).round()));

    _intTween = IntTween(begin: 0, end: animationLengths[currentAnimation] - 1);

    _animation = _intTween.animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            currentEmotion = Provider.of<TherabotModel>(context, listen: false)
                .getAnimation();
            currentAnimation = animations[currentEmotion]
                [Random.secure().nextInt(animations[currentEmotion].length)];
            // print("Next animation: $currentAnimation");
            _intTween.end = animationLengths[currentAnimation] - 1;
            _controller.duration =
                Duration(milliseconds: (_intTween.end / 24 * 1000).round());
          });

          _controller.reset();
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        String frameNum = _animation.value.toString();
        String frame = _intTween.end > 100
            ? frameNum.padLeft(3, '0')
            : frameNum.padLeft(2, '0');
        return Container(
            width: 100,
            height: 140,
            padding: EdgeInsets.only(bottom: 35),
            child: OverflowBox(
                maxHeight: 180,
                maxWidth: 135,
                child: Image.asset(
                  "$root/$currentEmotion/$currentAnimation/${animationFrameRoot[currentAnimation]}_$frame.png",
                  gaplessPlayback: true,
                  width: 200,
                  height: 280,
                )));
      },
    );

    return Container(
      width: 100,
      height: 140,
      margin: EdgeInsets.only(right: 20),
      child: Image(
        image: AssetImage("assets/bots/bot_transparent1.gif"),
        width: 100,
        height: 140,
      ),
    );
  }
}
