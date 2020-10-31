import 'package:flutter/material.dart';
import 'package:flutter_chatbot/assets/assets.dart';

class InactiveFeedbackIcon extends StatelessWidget {
  final int feedback;

  InactiveFeedbackIcon({this.feedback});

  Widget build(BuildContext context) {
    return Positioned(
      top: -7.5,
      right: -7.5,
      child: Icon(
        feedback == 1 ? Cb.feedbackcheckpressed : Cb.feedbackexpressed,
        size: 25,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
