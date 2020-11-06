import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/models/chat_model.dart';
import 'package:flutter_chatbot/assets/assets.dart';
import 'package:provider/provider.dart';

class ActiveFeedbackIcon extends StatelessWidget {
  final int feedback;

  ActiveFeedbackIcon({this.feedback});

  Widget build(BuildContext context) {
    return Positioned(
        top: -20,
        right: -20,
        child: IconButton(
            icon: feedback == 1
                ? Icon(Cb.feedbackcheckpressed)
                : Icon(Cb.feedbackexpressed),
            iconSize: 25,
            color: Theme.of(context).colorScheme.secondary,
            padding: const EdgeInsets.all(0.0),
            onPressed: () {
              Provider.of<ChatModel>(context, listen: false)
                  .giveFeedback(-1, -1);
            }));
  }
}
