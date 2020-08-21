import 'package:flutter/material.dart';

class TypingIndicator extends StatelessWidget {
  TypingIndicator(
      {Key key, @required this.controller, this.beginColor, this.endColor})
      : animation = TypingEnterAnimation(controller, beginColor, endColor),
        super(key: key);

  final TypingEnterAnimation animation;
  final Color beginColor;
  final Color endColor;
  final Animation<double> controller;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Row(children: [
      Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
              color: animation.dot1.value,
              borderRadius: BorderRadius.circular(10))),
      Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
              color: animation.dot2.value,
              borderRadius: BorderRadius.circular(10))),
      Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
              color: animation.dot3.value,
              borderRadius: BorderRadius.circular(10))),
    ]);
  }

  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation.controller,
      builder: (context, child) => _buildAnimation(context, child),
    );
  }
}

class TypingEnterAnimation {
  TypingEnterAnimation(this.controller, this.beginColor, this.endColor)
      : dot1 = ColorTween(begin: beginColor, end: endColor).animate(
            CurvedAnimation(
                parent: controller,
                curve: Interval(0, 0.5, curve: Curves.ease))),
        dot2 = ColorTween(begin: beginColor, end: endColor).animate(
            CurvedAnimation(
                parent: controller,
                curve: Interval(0.25, 0.75, curve: Curves.ease))),
        dot3 = ColorTween(begin: beginColor, end: endColor).animate(
            CurvedAnimation(
                parent: controller,
                curve: Interval(0.5, 1.0, curve: Curves.ease)));
  final AnimationController controller;
  final Color beginColor;
  final Color endColor;
  final Animation<Color> dot1;
  final Animation<Color> dot2;
  final Animation<Color> dot3;
}

class TypingBubble extends StatefulWidget {
  @override
  _TypingBubbleState createState() => _TypingBubbleState();
}

class _TypingBubbleState extends State<TypingBubble>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.blue,
      child: TypingIndicator(
          controller: _controller,
          beginColor: Theme.of(context).colorScheme.secondary,
          endColor: Theme.of(context).dividerColor),
    );
  }
}
