import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/models/therabot_model.dart';
import 'package:flutter_chatbot/ui/widgets/messaging/chatbot/avatar_animation.dart';
import 'package:flutter_chatbot/ui/widgets/messaging/chatbot/response_container.dart';
import 'package:provider/provider.dart';

// Parent: MessageFeed
class AvatarView extends StatelessWidget {
  AvatarView({this.botThinking, this.setFeedbackView});

  final bool botThinking;
  final Function(int) setFeedbackView;

  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(minHeight: 140),
        child: Container(
            margin: EdgeInsets.only(top: 2.5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Text(Provider.of<TherabotModel>(context).getEmotion()),
                    // AvatarAnimation()
                    Container(
                      width: 100,
                      height: 140,
                      margin: EdgeInsets.only(right: 20),
                      child: Image(
                        image: AssetImage("assets/bots/bot_transparent1.gif"),
                        width: 100,
                        height: 140,
                      ),
                    )
                  ],
                ),
                ResponseContainer(
                  botThinking: botThinking,
                  setFeedbackView: setFeedbackView,
                )
              ],
            )));
  }
}
