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
              List<BubbleModel> chatList = chat.getChatList();
              bool showPrompt = Provider.of<ConfigProvider>(context, listen: false).getMode() != Mode.trial 
                      && Provider.of<ConfigProvider>(context, listen: false).getMode() != Mode.prompt;

              return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  reverse: true,
                  itemCount: chatList.length + (showPrompt ? 2 : 1),
                  itemBuilder: (_, index) {
                    if (index == 0) {
                      return Avatar(
                          botThinking: botThinking,
                          setFeedbackView: setFeedbackView);
                    } else if (showPrompt && index == chatList.length + 1) {
                      return UserPrompt(
                        prompt: prompt,
                      );
                    } else {
                      BubbleModel message = chatList[chatList.length - index];
                      return ChatMessage(
                        text: message.text,
                        type: message.type,
                        feedback: message.feedback,
                        consecutive: message.consecutive,
                      );
                    }
                  });
            },
          )),
    );
  }
}
