import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/constants/animations.dart';
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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(
            milliseconds:
                (Animations.animationLengths[currentAnimation] / 24 * 1000)
                    .round()));

    _intTween =
        IntTween(begin: 0, end: Animations.animationLengths[currentAnimation]);

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
                ? "${Animations.isEmotionHappy[currentEmotion] ? 'happy' : 'sad'}_${widget.botThinking ? 'think' : 'idle'}${1 + Random.secure().nextInt(widget.botThinking ? 4 : 12)}"
                : "$nextEmotion${1 + Random.secure().nextInt(Animations.animationBuckets[nextEmotion])}";
            print(currentAnimation);
            currentEmotion = nextEmotion;
            // print("Next animation: $currentAnimation");
            _intTween.end = Animations.animationLengths[currentAnimation];
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
