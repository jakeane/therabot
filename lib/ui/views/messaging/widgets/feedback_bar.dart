import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/state/chat_state.dart';
import 'package:flutter_chatbot/assets/assets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FeedbackBar extends StatelessWidget {
  FeedbackBar({this.selected});

  final int selected;

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        color: Theme.of(context).backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 65,
              height: 50,
              child: FlatButton(
                child: Text(
                  "1",
                  style: selected == 1
                      ? GoogleFonts.muli(
                          color: Theme.of(context).backgroundColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700)
                      : Theme.of(context).textTheme.button,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.secondaryVariant)),
                color: selected == 1
                    ? Theme.of(context).colorScheme.secondaryVariant
                    : Theme.of(context).backgroundColor,
                onPressed: () {
                  Provider.of<ChatState>(context, listen: false).setSelected(1);
                },
              ),
            ),
            Container(
              width: 65,
              height: 50,
              child: FlatButton(
                child: Text(
                  "2",
                  style: selected == 2
                      ? GoogleFonts.muli(
                          color: Theme.of(context).backgroundColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700)
                      : Theme.of(context).textTheme.button,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.secondaryVariant)),
                color: selected == 2
                    ? Theme.of(context).colorScheme.secondaryVariant
                    : Theme.of(context).backgroundColor,
                onPressed: () {
                  Provider.of<ChatState>(context, listen: false).setSelected(2);
                },
              ),
            ),
            Container(
              width: 65,
              height: 50,
              child: FlatButton(
                child: Text(
                  "3",
                  style: selected == 3
                      ? GoogleFonts.muli(
                          color: Theme.of(context).backgroundColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700)
                      : Theme.of(context).textTheme.button,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.secondaryVariant)),
                color: selected == 3
                    ? Theme.of(context).colorScheme.secondaryVariant
                    : Theme.of(context).backgroundColor,
                onPressed: () {
                  Provider.of<ChatState>(context, listen: false).setSelected(3);
                },
              ),
            ),
            Container(
              width: 65,
              height: 50,
              child: FlatButton(
                child: Text(
                  "4",
                  style: selected == 4
                      ? GoogleFonts.muli(
                          color: Theme.of(context).backgroundColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700)
                      : Theme.of(context).textTheme.button,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.secondaryVariant)),
                color: selected == 4
                    ? Theme.of(context).colorScheme.secondaryVariant
                    : Theme.of(context).backgroundColor,
                onPressed: () {
                  Provider.of<ChatState>(context, listen: false).setSelected(4);
                },
              ),
            ),
            Container(
              width: 65,
              height: 50,
              child: FlatButton(
                child: Text(
                  "5",
                  style: selected == 5
                      ? GoogleFonts.muli(
                          color: Theme.of(context).backgroundColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700)
                      : Theme.of(context).textTheme.button,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.secondaryVariant)),
                color: selected == 5
                    ? Theme.of(context).colorScheme.secondaryVariant
                    : Theme.of(context).backgroundColor,
                onPressed: () {
                  Provider.of<ChatState>(context, listen: false).setSelected(5);
                },
              ),
            ),
            // IconButton(
            //   icon: Icon(Cb.feedbackmultichoice),
            //   iconSize: 50.0,
            //   color: Theme.of(context).colorScheme.primary,
            //   padding: const EdgeInsets.all(0.0),
            //   onPressed: () => print("option 1"),
            // ),
            // IconButton(
            //   icon: Icon(Cb.feedbackmultichoice),
            //   iconSize: 50.0,
            //   color: Theme.of(context).colorScheme.primary,
            //   padding: const EdgeInsets.all(0.0),
            //   onPressed: () => print("option 2"),
            // ),
            // IconButton(
            //   icon: Icon(Cb.feedbackmultichoice),
            //   iconSize: 50.0,
            //   color: Theme.of(context).colorScheme.primary,
            //   padding: const EdgeInsets.all(0.0),
            //   onPressed: () => print("option 3"),
            // ),
            // IconButton(
            //   icon: Icon(Cb.feedbackmultichoice),
            //   iconSize: 50.0,
            //   color: Theme.of(context).colorScheme.primary,
            //   padding: const EdgeInsets.all(0.0),
            //   onPressed: () => print("option 4"),
            // ),
          ],
        ));
  }
}
