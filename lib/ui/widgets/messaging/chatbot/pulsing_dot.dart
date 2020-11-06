import 'package:flutter/material.dart';

// BASED ON: https://github.com/wal33d006/progress_indicators

/// Adds a horizontal list of variable number of jumping dots
class PulsingDot extends AnimatedWidget {
  PulsingDot({Key key, Animation<Color> animation})
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
