import 'package:flutter/material.dart';
import 'package:flutter_chatbot/assets/assets.dart';
import 'package:flutter_chatbot/ui/views/messaging/widgets/message_bubble.dart';

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
            Stack(
              children: [
                MessageBubble(
                  text: widget.text,
                  bubbleColor: Theme.of(context).colorScheme.primaryVariant,
                  textStyle: Theme.of(context).textTheme.bodyText2,
                  maxWidth: MediaQuery.of(context).size.width - 160,
                ),
                if (_hasFeedback)
                  Positioned(
                      top: -20,
                      right: -20,
                      child: IconButton(
                        icon: Icon(Cb.feedbackcheckpressed),
                        iconSize: 25,
                        color: Theme.of(context)
                            .colorScheme
                            .primary, // Needs a specified color
                        padding: const EdgeInsets.all(0.0),
                        onPressed: () => print("stack"),
                      )),
              ],
              overflow: Overflow.visible,
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
