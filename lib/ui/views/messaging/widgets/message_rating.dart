import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MessageRating extends StatefulWidget {
  @override
  _MessageRatingState createState() => _MessageRatingState();
}

class _MessageRatingState extends State<MessageRating> {
  var _selected = [false, false];

  Widget build(BuildContext context) {
    return Row(children: [
      IconButton(
        icon: FaIcon(_selected[0]
            ? FontAwesomeIcons.solidThumbsUp
            : FontAwesomeIcons.thumbsUp),
        constraints: BoxConstraints.loose(Size(30, 30)),
        iconSize: 15,
        onPressed: () => setState(() {
          _selected = [true, false];
        }),
      ),
      IconButton(
        icon: FaIcon(_selected[1]
            ? FontAwesomeIcons.solidThumbsDown
            : FontAwesomeIcons.thumbsDown),
        constraints: BoxConstraints(),
        iconSize: 15,
        onPressed: () => setState(() {
          _selected = [false, true];
        }),
      )
    ]);
  }
}
