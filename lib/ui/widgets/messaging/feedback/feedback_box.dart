import 'package:flutter/material.dart';
import 'package:flutter_chatbot/ui/widgets/messaging/feedback/feedback_item.dart';

class FeedbackBox extends StatelessWidget {
  final Function(int) setFeedbackView;

  FeedbackBox({this.setFeedbackView});

  final List<String> options = [
    "Harmful or abusive",
    "Irrelevant or off topic",
    "Inappropriate or offensive",
    "Ending conversation abruptly",
    "Other",
  ];

  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).dividerColor,
        ),
        child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            itemCount: options.length,
            itemBuilder: (context, index) {
              return FeedbackItem(
                  optionText: options[index],
                  optionNum: index + 1,
                  setFeedbackView: setFeedbackView);
            }));
  }
}
