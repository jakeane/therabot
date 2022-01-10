import 'package:flutter/material.dart';
// import 'package:therabot/widgets/chatbot/avatar/_avatar_animation.dart';
import 'package:therabot/widgets/chatbot/avatar/avatar_animation.dart';
import 'package:therabot/widgets/chatbot/avatar/response_container.dart';

// Parent: MessageFeed
class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
    required this.botThinking,
    required this.setFeedbackView
  }) : super(key: key);

  final bool botThinking;
  final Function(int) setFeedbackView;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 140),
        child: Container(
            margin: const EdgeInsets.only(top: 2.5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AvatarAnimation(botThinking: botThinking),
                ResponseContainer(
                  botThinking: botThinking,
                  setFeedbackView: setFeedbackView,
                )
              ],
            )));
  }
}
