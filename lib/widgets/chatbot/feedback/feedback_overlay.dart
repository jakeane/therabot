import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:therabot/constants/feedback_options.dart';
import 'package:therabot/store/chat_provider.dart';

class FeedbackOverlay extends StatelessWidget {
  const FeedbackOverlay({Key? key, required this.setFeedbackView}) : super(key: key);

  final Function(int) setFeedbackView;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GestureDetector(
        onTap: () {
          Provider.of<ChatProvider>(context, listen: false).giveFeedback(-1, -1);
          setFeedbackView(-1);
        },
        child: Container(
          color: Colors.black.withOpacity(0.6),
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: Stack(clipBehavior: Clip.none, children: [
          FeedbackBox(setFeedbackView: setFeedbackView),
          Positioned(
              top: 15,
              right: -5,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).dividerColor,
                ),
              )),
          Positioned(
              top: 0,
              right: -20,
              child: IconButton(
                  icon: SvgPicture.asset("assets/svgs/FeedbackExPressed.svg"),
                  iconSize: 25,
                  color: Theme.of(context).colorScheme.secondary,
                  padding: const EdgeInsets.all(0.0),
                  onPressed: () {
                    Provider.of<ChatProvider>(context, listen: false).giveFeedback(-1, -1);
                    setFeedbackView(-1);
                  })
                  ),
        ]),
      )
    ]);
  }
}

class FeedbackBox extends StatelessWidget {
  final Function(int) setFeedbackView;

  const FeedbackBox({Key? key, required this.setFeedbackView}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).dividerColor,
        ),
        child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            itemCount: FeedbackOptions.options.length,
            itemBuilder: (context, index) {
              List<int> keys = FeedbackOptions.options.keys.toList();

              return FeedbackItem(
                  optionText: FeedbackOptions.options[keys[index]]!,
                  optionNum: keys[index],
                  setFeedbackView: setFeedbackView);
            }));
  }
}

class FeedbackItem extends StatelessWidget {
  final String optionText;
  final int optionNum;
  final Function(int) setFeedbackView;

  const FeedbackItem({
    Key? key,
    required this.optionText,
    required this.optionNum,
    required this.setFeedbackView
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int detail = Provider.of<ChatProvider>(context).getBotMessage()?['detail'] as int;

    Color? buttonColor = detail == optionNum
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).textTheme.bodyText2?.color;

    // Increase spacing between items and make buttons smaller
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
              child: SizedBox(
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
                    ?.copyWith(color: buttonColor),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(color: buttonColor!)),
              color: Theme.of(context).dividerColor,
              onPressed: () {
                setFeedbackView(optionNum);
              },
            ),
          ))
        ]));
  }
}
