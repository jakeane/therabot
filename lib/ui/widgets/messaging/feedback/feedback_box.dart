import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/constants/feedback_options.dart';
import 'package:flutter_chatbot/ui/widgets/messaging/feedback/feedback_item.dart';

class FeedbackBox extends StatelessWidget {
  final Function(int) setFeedbackView;

  FeedbackBox({this.setFeedbackView});

  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).dividerColor,
        ),
        child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
            itemCount: FeedbackOptions.options.length,
            itemBuilder: (context, index) {
              List<int> keys = FeedbackOptions.options.keys.toList();

              return FeedbackItem(
                  optionText: FeedbackOptions.options[keys[index]],
                  optionNum: keys[index],
                  setFeedbackView: setFeedbackView);
            }));
  }
}
