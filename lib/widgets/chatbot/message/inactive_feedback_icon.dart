import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InactiveFeedbackIcon extends StatelessWidget {
  final int feedback;

  const InactiveFeedbackIcon({Key? key, required this.feedback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -10,
      right: -10,
      child: feedback == 1
        ? SvgPicture.asset("assets/svgs/FeedbackCheckPressed.svg")
        : SvgPicture.asset("assets/svgs/FeedbackExPressed.svg")
    );
  }
}
