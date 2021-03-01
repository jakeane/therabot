import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/models/therabot_model.dart';
import 'package:provider/provider.dart';

class AvatarAnimation extends StatefulWidget {
  final bool botThinking;
  AvatarAnimation({this.botThinking});
  @override
  _AvatarAnimationState createState() => _AvatarAnimationState();
}

class _AvatarAnimationState extends State<AvatarAnimation>
    with TickerProviderStateMixin {
  final String root = "assets/animations";
  final String chatbot = "CB1";

  AnimationController _controller;
  IntTween _intTween;
  Animation<int> _animation;

  String currentEmotion = "happy_trust";
  String currentAnimation = "happy_trust1";

  final Map<String, bool> isEmotionHappy = {
    "terror": false,
    "sad_anticipation": false,
    "anxiety": false,
    "disgust": false,
    "sad_surprise": false,
    "happy_surprise": true,
    "anger": false,
    "happy_anticipation": true,
    "sad_trust": false,
    "happy_trust": true,
    "fear": false,
    "depression": false,
    "sad": false,
    "joy": true,
  };

  final Map<String, int> animationBuckets = {
    "terror": 2,
    "happy_nod": 6,
    "sad_think": 4,
    "sad_anticipation": 2,
    "happy_think": 4,
    "anxiety": 2,
    "disgust": 2,
    "sad_surprise": 2,
    "happy_surprise": 2,
    "happy_idle": 12,
    "anger": 2,
    "happy_anticipation": 2,
    "sad_nod": 6,
    "sad_idle": 12,
    "sad_trust": 2,
    "happy_trust": 2,
    "fear": 2,
    "depression": 2,
    "sad": 2,
    "joy": 3,
  };

  final Map<String, int> animationLengths = {
    "terror2": 267,
    "happy_nod6": 115,
    "happy_nod1": 158,
    "sad_think2": 135,
    "sad_anticipation2": 202,
    "happy_think1": 185,
    "anxiety2": 226,
    "sad_think4": 133,
    "sad_think3": 100,
    "disgust1": 172,
    "sad_surprise1": 123,
    "happy_surprise1": 130,
    "happy_idle2": 84,
    "anger1": 251,
    "happy_idle5": 159,
    "happy_anticipation2": 202,
    "sad_nod1": 158,
    "sad_nod6": 115,
    "happy_idle4": 123,
    "happy_idle3": 98,
    "happy_idle10": 93,
    "sad_idle12": 87,
    "sad_trust2": 123,
    "happy_trust1": 145,
    "happy_idle11": 95,
    "fear2": 257,
    "sad_idle2": 84,
    "depression1": 143,
    "sad_idle5": 159,
    "sad1": 216,
    "joy3": 198,
    "sad_idle4": 123,
    "sad_idle3": 98,
    "joy2": 221,
    "sad_think1": 185,
    "terror1": 247,
    "happy_think4": 133,
    "happy_think3": 100,
    "happy_nod2": 173,
    "happy_nod5": 103,
    "anxiety1": 226,
    "sad_anticipation1": 202,
    "happy_nod4": 126,
    "happy_nod3": 120,
    "happy_think2": 135,
    "anger2": 216,
    "happy_idle6": 191,
    "happy_idle1": 71,
    "sad_nod3": 136,
    "happy_idle8": 107,
    "sad_nod4": 110,
    "happy_anticipation1": 175,
    "disgust2": 156,
    "happy_surprise2": 107,
    "sad_surprise2": 122,
    "sad_nod5": 103,
    "happy_idle9": 108,
    "sad_nod2": 173,
    "happy_idle7": 132,
    "sad_idle11": 94,
    "sad_trust1": 145,
    "sad_idle10": 94,
    "fear1": 207,
    "happy_trust2": 122,
    "happy_idle12": 88,
    "sad_idle8": 107,
    "depression2": 137,
    "sad2": 256,
    "sad_idle6": 191,
    "sad_idle1": 71,
    "joy1": 154,
    "sad_idle7": 132,
    "sad_idle9": 108,
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(
            milliseconds:
                (animationLengths[currentAnimation] / 24 * 1000).round()));

    _intTween = IntTween(begin: 0, end: animationLengths[currentAnimation]);

    _animation = _intTween.animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            String nextEmotion =
                Provider.of<TherabotModel>(context, listen: false)
                    .getAnimation();
            // currentEmotion =
            //     ['joy', 'fear', 'happy_surprise'][Random.secure().nextInt(3)];
            currentAnimation = nextEmotion == currentEmotion
                ? "${isEmotionHappy[currentEmotion] ? 'happy' : 'sad'}_${widget.botThinking ? 'think' : 'idle'}${1 + Random.secure().nextInt(widget.botThinking ? 4 : 12)}"
                : "$nextEmotion${1 + Random.secure().nextInt(animationBuckets[nextEmotion])}";
            print(currentAnimation);
            currentEmotion = nextEmotion;
            // print("Next animation: $currentAnimation");
            _intTween.end = animationLengths[currentAnimation];
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
        String frame = frameNum.padLeft(4, '0');
        return Container(
            width: 100,
            height: 140,
            padding: EdgeInsets.only(bottom: 35),
            child: OverflowBox(
                maxHeight: 180,
                maxWidth: 135,
                child: Image.asset(
                  "$root/$chatbot/$currentAnimation/$currentAnimation.$frame.png",
                  gaplessPlayback: true,
                  width: 200,
                  height: 280,
                )));
      },
    );
  }
}
