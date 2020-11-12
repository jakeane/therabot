import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewConvoButton extends StatelessWidget {
  final Function newConvo;

  NewConvoButton({this.newConvo});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      margin: EdgeInsets.only(bottom: 5),
      child: FlatButton(
        onPressed: () {
          newConvo();
        },
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          FaIcon(
            FontAwesomeIcons.solidPlusSquare,
            color: Theme.of(context).textTheme.bodyText2.color,
          ),
          Container(
            margin: EdgeInsets.only(left: 5),
            child: Text(
              "New Conversation",
              style:
                  Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 18),
            ),
          )
        ]),
      ),
    );
  }
}
