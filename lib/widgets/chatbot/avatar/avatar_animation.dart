import 'dart:math';

import 'package:flutter/material.dart';
import 'package:therabot/constants/animations.dart';
import 'package:therabot/store/emotion_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';

class AvatarAnimation extends StatefulWidget {
  final bool botThinking;
  const AvatarAnimation({Key? key, required this.botThinking}) : super(key: key);

  @override
  _AvatarAnimationState createState() => _AvatarAnimationState();
}

class _AvatarAnimationState extends State<AvatarAnimation>
    with TickerProviderStateMixin {
  final String root = "assets/animations";
  final String chatbot = "CB1_gif";

  GifController? _controller;

  String currentEmotion = "happy_trust";
  String currentAnimation = "happy_trust1";
  int framecount = 1;

  @override
  void initState() {
    super.initState();
    framecount = Animations.animationLengths[currentAnimation] ?? 1;
    _controller = GifController(
      vsync: this,
      duration: Duration(milliseconds: (framecount * 24 / 1000).round())
    );
    
    run();
  }

  void run() async {
    while (true) {
      
      _controller?.duration = Duration(milliseconds: (framecount / 24 * 1000).round());
      await _controller?.animateTo(framecount.toDouble());
      setState(() {
        String modelEmotion =
            Provider.of<EmotionProvider>(context, listen: false)
                .getAnimation();

        String nextEmotion =
            modelEmotion == 'neutral' ? currentEmotion : modelEmotion;
        currentAnimation = nextEmotion == currentEmotion
            ? "${Animations.isEmotionHappy[currentEmotion]! ? 'happy' : 'sad'}_${widget.botThinking ? 'think' : 'idle'}${1 + Random.secure().nextInt(widget.botThinking ? 4 : 12)}"
            : "$nextEmotion${1 + Random.secure().nextInt(Animations.animationBuckets[nextEmotion]!)}";
        currentEmotion = nextEmotion;
        framecount = Animations.animationLengths[currentAnimation] ?? 1;
      });
      _controller?.reset();
    }

  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   return Container(
      width: 100,
      height: 140,
      padding: const EdgeInsets.only(bottom: 35),
      child: OverflowBox(
          maxHeight: 180,
          maxWidth: 135,
          child: GifImage(
            controller: _controller!,
            image: AssetImage('assets/animations/CB1/$currentAnimation.gif'),
            gaplessPlayback: true,
            colorBlendMode: BlendMode.clear,
          )
      )
    );
  }
}
