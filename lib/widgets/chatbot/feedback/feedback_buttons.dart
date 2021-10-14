import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:therabot/store/chat_provider.dart';

// Parent: ShakeContainer
class FeedbackButtons extends StatelessWidget {
  final Function(int) setFeedbackView;

  const FeedbackButtons({Key? key, required this.setFeedbackView}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: SvgPicture.asset("assets/svgs/FeedbackCheck.svg"),
          iconSize: 40,
          color: Theme.of(context).colorScheme.secondaryVariant,
          padding: const EdgeInsets.only(right: 0, top: 8),
          onPressed: () {
            Provider.of<ChatProvider>(context, listen: false).giveFeedback(-1, 1);
          },
        ),
        IconButton(
          icon: SvgPicture.asset("assets/svgs/FeedbackEx.svg"),
          iconSize: 40,
          color: Theme.of(context).colorScheme.secondaryVariant,
          padding: const EdgeInsets.only(left: 0, top: 8),
          onPressed: () {
            Provider.of<ChatProvider>(context, listen: false).giveFeedback(-1, 0);
            setFeedbackView(-1);
          },
        )
      ],
    );
  }
}
