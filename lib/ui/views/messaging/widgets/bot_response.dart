import 'package:flutter/material.dart';
import 'package:flutter_chatbot/assets/assets.dart';

class BotResponse extends StatefulWidget {
  BotResponse({this.text, this.bubbleColor, this.textStyle});
  final String text;
  final Color bubbleColor;
  final TextStyle textStyle;

  @override
  _BotResponse createState() => _BotResponse();
}

class _BotResponse extends State<BotResponse> {
  bool _hasFeedback = false;

  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 2.5, bottom: 2.5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: widget.bubbleColor,
              ),
              padding: EdgeInsets.all(15),
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 160),
              child: Text(
                widget.text,
                style: widget.textStyle,
              ),
            ),
            _hasFeedback
                ? IconButton(
                    icon: Icon(Cb.feedbackcomment),
                    iconSize: 40,
                    color: Theme.of(context).colorScheme.secondaryVariant,
                    padding: const EdgeInsets.all(0.0),
                    onPressed: () {
                      print('comment');
                      setState(() {
                        _hasFeedback = !_hasFeedback;
                      });
                    },
                  )
                : Row(
                    children: [
                      IconButton(
                        icon: Icon(Cb.feedbackcheck),
                        iconSize: 40,
                        color: Theme.of(context).colorScheme.secondaryVariant,
                        padding: const EdgeInsets.all(0.0),
                        onPressed: () {
                          print('check');
                          setState(() {
                            _hasFeedback = !_hasFeedback;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Cb.feedbackex),
                        iconSize: 40,
                        color: Theme.of(context).colorScheme.secondaryVariant,
                        padding: const EdgeInsets.all(0.0),
                        onPressed: () {
                          print('ecks');
                          setState(() {
                            _hasFeedback = !_hasFeedback;
                          });
                        },
                      )
                    ],
                  )
          ],
        ));
  }
}
