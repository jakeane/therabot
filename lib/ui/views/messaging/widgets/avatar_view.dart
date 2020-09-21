import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_chatbot/app/models/chat_model.dart';
import 'package:flutter_chatbot/ui/views/messaging/widgets/bot_response.dart';
import 'package:flutter_chatbot/ui/views/messaging/widgets/typing_indicator.dart';

class AvatarView extends StatelessWidget {
  AvatarView({this.botThinking});

  final bool botThinking;

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
                  child: new Image(
                    image: new AssetImage("assets/gifs/bot_transparent.gif"),
                    width: 100,
                    height: 140,
                  ),
                ),
                Consumer<ChatModel>(builder: (context, chat, child) {
                  return (chat.getBotResponse() != null)
                      ? BotResponse(
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
