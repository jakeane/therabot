import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/models/chat_model.dart';
import 'package:flutter_chatbot/assets/assets.dart';
import 'package:flutter_chatbot/ui/widgets/messaging/feedback/feedback_box.dart';
import 'package:provider/provider.dart';

class FeedbackOverlay extends StatelessWidget {
  FeedbackOverlay({this.setFeedbackView});

  final Function(int) setFeedbackView;

  Widget build(BuildContext context) {
    return Stack(children: [
      GestureDetector(
        onTap: () {
          Provider.of<ChatModel>(context, listen: false).giveFeedback(-1, -1);
          setFeedbackView(-1);
        },
        child: Container(
          color: Colors.black.withOpacity(0.6),
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: Stack(overflow: Overflow.visible, children: [
          FeedbackBox(setFeedbackView: setFeedbackView),
          Positioned(
              top: 15,
              right: -5,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).dividerColor,
                ),
              )),
          Positioned(
              top: 0,
              right: -20,
              child: IconButton(
                  icon: Icon(Cb.feedbackexpressed),
                  iconSize: 25,
                  color: Theme.of(context).colorScheme.secondary,
                  padding: const EdgeInsets.all(0.0),
                  onPressed: () {
                    Provider.of<ChatModel>(context, listen: false)
                        .giveFeedback(-1, -1);
                    setFeedbackView(-1);
                  })),
        ]),
      )
    ]);
  }
}
