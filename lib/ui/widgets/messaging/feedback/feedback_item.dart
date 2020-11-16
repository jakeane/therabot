import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/models/chat_model.dart';
import 'package:provider/provider.dart';

class FeedbackItem extends StatelessWidget {
  final String optionText;
  final int optionNum;
  final Function(int) setFeedbackView;

  FeedbackItem({this.optionText, this.optionNum, this.setFeedbackView});

  Widget build(BuildContext context) {
    int detail = Provider.of<ChatModel>(context).getBotResponse().detail;

    Color buttonColor = detail == optionNum
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).textTheme.bodyText2.color;

    // Increase spacing between items and make buttons smaller
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
              child: Container(
            height: 35,

            // margin: EdgeInsets.only(right: 15),
            child: FlatButton(
              child: Text(
                optionText,
                softWrap: false,
                // optionNum.toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: buttonColor),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(color: buttonColor)),
              color: Theme.of(context).dividerColor,
              onPressed: () {
                setFeedbackView(optionNum);
              },
            ),
          ))
        ]));
  }
}
