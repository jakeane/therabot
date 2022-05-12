import 'package:flutter/material.dart';
import 'package:therabot/store/config_provider.dart';
import 'package:therabot/types/chat.dart';
import 'package:therabot/store/chat_provider.dart';
import 'package:therabot/widgets/chatbot/avatar/avatar.dart';
import 'package:therabot/widgets/chatbot/core/user_prompt.dart';
import 'package:therabot/widgets/chatbot/message/chat_message.dart';
import 'package:provider/provider.dart';

class MessageFeed extends StatelessWidget {
  final bool botThinking;
  final Function(int) setFeedbackView;
  final List<TextSpan> prompt;

  const MessageFeed({
    Key? key,
    required this.botThinking,
    required this.setFeedbackView,
    required this.prompt
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Consumer<ChatProvider>(
            builder: (context, chat, child) {
              List<MessageModel> chatList = chat.getChatList();
              
              // if a prompt is being rendered, thus adding another item to the ListView
              Mode mode = Provider.of<ConfigProvider>(context, listen: false).getMode();
              bool showPrompt = mode != Mode.trial && mode != Mode.prompt;

              /**
               * Check if the last message is from the chatbot
               * If so, it will be rendered with the chatbot avatar, not with the other messages
               * In that case, the ListView is one item shorter
               */
              bool hasBotResponse = chatList.isNotEmpty && !chatList.last.type;
              int brAdjustment = hasBotResponse ? -1 : 0;

              return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  reverse: true,
                  itemCount: chatList.length + (showPrompt ? 2 : 1) + brAdjustment,
                  itemBuilder: (_, index) {
                    if (index == 0) {
                      return Avatar(
                          botThinking: botThinking,
                          setFeedbackView: setFeedbackView);
                    } else if (showPrompt && index == chatList.length) {
                      return UserPrompt(prompt: prompt);
                    } else {
                      MessageModel message = chatList[chatList.length - index + brAdjustment];
                      var prevMsgType = index > 1
                        ? chatList[chatList.length - index + 1 + brAdjustment].type
                        : !message.type;

                      return ChatMessage(
                        text: message.text,
                        type: message.type,
                        feedback: message.feedback,
                        consecutive: message.type == prevMsgType,
                      );
                    }
                  });
            },
          )),
    );
  }
}
