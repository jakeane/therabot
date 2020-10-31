import 'package:flutter/material.dart';

class FeedbackItem extends StatelessWidget {
  final String optionText;
  final int optionNum;
  final Function(int) setFeedbackView;

  FeedbackItem({this.optionText, this.optionNum, this.setFeedbackView});

  Widget build(BuildContext context) {
    Color buttonColor = Theme.of(context).textTheme.bodyText2.color;

    return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Row(children: [
          Container(
            width: 60,
            height: 40,
            margin: EdgeInsets.only(right: 15),
            child: FlatButton(
              child: Text(
                optionNum.toString(),
                style: Theme.of(context)
                    .textTheme
                    .button
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
          ),
          Expanded(
            child: Text(
              optionText,
              softWrap: true,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          )
        ]));
  }
}
