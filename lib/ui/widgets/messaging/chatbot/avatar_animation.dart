import 'package:flutter/material.dart';

class AvatarAnimation extends StatefulWidget {
  @override
  _AvatarAnimationState createState() => _AvatarAnimationState();
}

class _AvatarAnimationState extends State<AvatarAnimation>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<int> _animation;

  String currentAnimation = "idle2";

  final Map<String, String> animations = {
    "idle1": "assets/animations/idle/happy_idle1/CB1_Happy_Idle1.",
    "idle2": "assets/animations/idle/happy_idle2/CB1.Happy.Idle12",
  };

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    _animation = IntTween(begin: 1, end: 72).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          print("animation done");
          setState(() {
            if (currentAnimation == "idle2") {
              currentAnimation = "idle1";
            } else {
              currentAnimation = "idle2";
            }
          });
          _controller.reset();
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        String frame = _animation.value.toString().padLeft(2, '0');
        return Container(
            child: Image.asset(
          "${animations[currentAnimation]}$frame.png",
          gaplessPlayback: true,
          width: 100,
          height: 140,
        ));
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
