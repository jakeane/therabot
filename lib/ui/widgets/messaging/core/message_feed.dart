import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/models/chat_model.dart';
import 'package:flutter_chatbot/app/models/message_model.dart';
import 'package:flutter_chatbot/ui/widgets/messaging/chatbot/avatar_view.dart';
import 'package:flutter_chatbot/ui/widgets/messaging/message/chat_message.dart';
import 'package:provider/provider.dart';

class MessageFeed extends StatelessWidget {
  final bool botThinking;
  final Function setFeedbackView;

  MessageFeed({this.botThinking, this.setFeedbackView});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Consumer<ChatModel>(
            builder: (context, chat, child) {
              List<MessageModel> chatList = chat.getChatList();

              return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  reverse: true,
                  itemCount: chatList.length + 1,
                  itemBuilder: (_, index) {
                    return index == 0
                        ? AvatarView(
                            botThinking: botThinking,
                            setFeedbackView: setFeedbackView)
                        : () {
                            MessageModel message =
                                chatList[chatList.length - index];
                            return ChatMessage(
                              text: message.text,
                              type: message.type,
                              feedback: message.feedback,
                              consecutive: message.consecutive,
                            );
                          }();
                  });
            },
          )),
    );
  }
}
