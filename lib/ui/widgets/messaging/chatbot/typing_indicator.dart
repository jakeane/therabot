import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_chatbot/ui/views/messaging/widgets/chat_nip.dart';

// BASED ON: https://github.com/wal33d006/progress_indicators

/// Adds a horizontal list of variable number of jumping dots
///
/// The animation is a smooth up/down continuous animation of each dot.
/// This animation can be used where a text is being expected from an async call
/// The below class is a private [AnimatedWidget] class which is called in the
/// [StatefulWidget].
class _PulsingDot extends AnimatedWidget {
  _PulsingDot({Key key, Animation<Color> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<Color> animation = listenable;
    return Container(
      child: Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
              color: animation.value, borderRadius: BorderRadius.circular(10))),
    );
  }
}

/// Creates a list with [numberOfDots] text dots, with 3 dots as default
/// default [fontSize] of 10.0, default [color] as black, [dotSpacing] (gap
/// between each dot) as 0.0 and default time for one cycle of animation
/// [milliseconds] as 250.
/// One cycle of animation is one complete round of a dot animating up and back
/// to its original position.
class TypingIndicator extends StatefulWidget {
  /// Starting and ending values for animations.
  final Color beginTweenValue;
  final Color endTweenValue;

  /// Creates a jumping do progress indicator.
  TypingIndicator({
    this.beginTweenValue,
    this.endTweenValue,
  });

  _TypingIndicatorState createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with TickerProviderStateMixin {
  int numberOfDots = 3;
  int microseconds = 937500;
  List<AnimationController> controllers = new List<AnimationController>();
  List<Animation<Color>> animations = new List<Animation<Color>>();
  List<Widget> _widgets = new List<Widget>();

  initState() {
    super.initState();
    for (int i = 0; i < numberOfDots; i++) {
      _addAnimationControllers();
      _buildAnimations(i);
      _addListOfDots(i);
    }

    controllers[0].forward();
    for (int i = 0; i < numberOfDots; i++) {
      controllers[i].forward();
    }
  }

  void _addAnimationControllers() {
    controllers.add(AnimationController(
        duration: Duration(microseconds: microseconds), vsync: this));
  }

  void _addListOfDots(int index) {
    _widgets.add(
      Padding(
        padding: EdgeInsets.only(right: index != 2 ? 3 : 0),
        child: _PulsingDot(
          animation: animations[index],
        ),
      ),
    );
  }

  void _buildAnimations(int index) {
    animations.add(
      ColorTween(begin: widget.beginTweenValue, end: widget.endTweenValue)
          .animate(CurvedAnimation(
              parent: controllers[index],
              curve: Interval(0.2 + index * 0.2, 0.6 + index * 0.2,
                  curve: Curves.decelerate),
              reverseCurve: Interval(0.2 + (numberOfDots - index - 1) * 0.2,
                  0.6 + (numberOfDots - index - 1) * 0.2,
                  curve: Curves.easeIn)))
            ..addStatusListener(
              (AnimationStatus status) {
                if (status == AnimationStatus.completed)
                  controllers[index].reverse();
                if (index == numberOfDots - 1 &&
                    status == AnimationStatus.dismissed) {
                  for (int i = 0; i < numberOfDots; i++) {
                    controllers[i].forward();
                  }
                }
              },
            ),
    );
  }

  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 87.5),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.primaryVariant,
              ),
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _widgets,
              ),
            ),
            Positioned(
              bottom: -5,
              child: CustomPaint(
                size: Size(20, 25),
                painter: ChatNip(
                    nipHeight: 5,
                    color: Theme.of(context).colorScheme.primaryVariant,
                    isUser: false),
              ),
            ),
          ],
          overflow: Overflow.visible,
        ));
  }

  dispose() {
    for (int i = 0; i < numberOfDots; i++) controllers[i].dispose();
    super.dispose();
  }
}
