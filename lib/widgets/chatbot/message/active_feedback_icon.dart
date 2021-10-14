import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:therabot/store/chat_provider.dart';
import 'package:provider/provider.dart';

class ActiveFeedbackIcon extends StatelessWidget {
  final int feedback;

  const ActiveFeedbackIcon({Key? key, required this.feedback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: -20,
        right: -20,
        child: IconButton(
            icon: feedback == 1
                ? SvgPicture.asset("assets/svgs/FeedbackCheckPressed.svg")
                : SvgPicture.asset("assets/svgs/FeedbackExPressed.svg"),
            iconSize: 25,
            color: Theme.of(context).colorScheme.secondary,
            padding: const EdgeInsets.all(0.0),
            onPressed: () {
              Provider.of<ChatProvider>(context, listen: false)
                  .giveFeedback(-1, -1);
            }));
  }
}
