import 'package:flutter/material.dart';
import 'package:flutter_chatbot/ui/views/messaging/widgets/feedback_box.dart';

class FeedbackOverlay extends StatelessWidget {
  FeedbackOverlay({this.setFeedbackView});

  final Function(int) setFeedbackView;

  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: Colors.black.withOpacity(0.6),
      ),
      Align(
        alignment: Alignment.center,
        heightFactor: 4,
        child: FeedbackBox(setFeedbackView: setFeedbackView),
      )
    ]);
  }
}
