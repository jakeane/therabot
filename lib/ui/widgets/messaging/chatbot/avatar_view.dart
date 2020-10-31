import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_chatbot/app/models/chat_model.dart';
import 'package:flutter_chatbot/ui/widgets/messaging/chatbot/bot_response.dart';
import 'package:flutter_chatbot/ui/widgets/messaging/chatbot/typing_indicator.dart';

class AvatarView extends StatelessWidget {
  AvatarView({this.botThinking, this.setFeedbackView});

  final bool botThinking;
  final Function(int) setFeedbackView;

  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: new BoxConstraints(minHeight: 140),
        child: Container(
            margin: EdgeInsets.only(top: 2.5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 100,
                  height: 140,
                  margin: EdgeInsets.only(right: 20),
                  // child: Lottie.asset("assets/gifs/happy_idle.json",
                  //     width: 100, height: 140)
                  child: new Image(
                    image: new AssetImage("assets/bots/bot_transparent.gif"),
                    width: 100,
                    height: 140,
                  ),
                ),
                Consumer<ChatModel>(builder: (context, chat, child) {
                  return (chat.getBotResponse() != null)
                      ? BotResponse(
                          setFeedbackView: setFeedbackView,
                          text: chat.getBotResponse().text,
                          feedback: chat.getBotResponse().feedback,
                          bubbleColor:
                              Theme.of(context).colorScheme.primaryVariant,
                          textStyle: Theme.of(context).textTheme.bodyText2)
                      : (botThinking
                          ? TypingIndicator(
                              beginTweenValue: Theme.of(context).dividerColor,
                              endTweenValue:
                                  Theme.of(context).colorScheme.secondary,
                            )
                          : Container());
                })
              ],
            )));
  }
}
