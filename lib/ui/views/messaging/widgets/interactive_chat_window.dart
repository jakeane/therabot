import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/models/chat_model.dart';
import 'package:flutter_chatbot/app/models/theme_model.dart';
import 'package:flutter_chatbot/app/services/firebase_db_service.dart';
import 'package:flutter_chatbot/ui/views/messaging/widgets/text_composer.dart';
import 'package:flutter_chatbot/ui/views/messaging/widgets/bot_response.dart';
import 'package:flutter_chatbot/ui/views/messaging/widgets/copy_jumping.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

const SERVER_IP = 'localhost';
const SERVER_PORT = '10001';
const URL = 'ws://$SERVER_IP:$SERVER_PORT/websocket';

// TODO
// done 1. Set container padding to 20px
// done 2. Redesign typing bar according to style guide
// 3. Add bubble nips (with logic)
// 4. Import style guide components
// 5. Add new feedback buttons
// 6. Have settings button go to different view
// 7. Add message bubble spacing logic
// 8. Add typing bubble for bot
// 9. Add bot avatar placeholder and implement chat bubble logic
// 10. Add feedback flow
// 11. Placeholder GIFs for chatbot avatar
//      - Parse user's text
//      - Query for emotion with nrcLEX

// BUGS
// 1. Websocket error on Android
// 2. Press enter to send message
// 3. Multiline handle

class InteractiveChatWindow extends StatefulWidget {
  InteractiveChatWindow({Key key, this.title}) : super(key: key);

  // Takes a single input which is the title of the chat window
  final String title;
  final channel = WebSocketChannel.connect(Uri.parse(URL));

  @override
  _InteractiveChatWindow createState() => _InteractiveChatWindow();
}

class _InteractiveChatWindow extends State<InteractiveChatWindow> {
  final TextEditingController _textController = TextEditingController();
  final channel = WebSocketChannel.connect(Uri.parse(URL));

  String currentUserID;
  int previousMessagesCount = 0;
  int currentMessagesCount = 0;
  int messageID = 0;

  // Creates a focus node to autofocus the text controller when the chatbot responds
  FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    channel.stream.listen((event) async {
      var data = jsonDecode(event) as Map;
      var text = data['text'];

      // Could turn this into helper?
      text = text.toString().replaceAll(" .", ".");
      text = text.toString().replaceAll(" ?", "?");
      text = text.toString().replaceAll(" '", "'");
      text = text.toString().replaceAll("' ", "'");
      text = text.toString().replaceAll(" , ", ", ");
      text = toBeginningOfSentenceCase(text);

      await Future.delayed(Duration(seconds: 2));
      Provider.of<ChatModel>(context, listen: false)
          .addBotResponse(text, "Covid Bot", false, messageID);

      print("channel text: " + text);
    });

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    channel.sink.close();

    super.dispose();
  }

  // Handles user message and generates response from bot
  void response(query) async {
    if (currentUserID == null) {
      currentUserID = await FirebaseDbService.getCurrentUserID();
    }

    String jsonStringified = '{"text": "$query"}';
    channel.sink.add(jsonStringified);

    // Get the conversation number
    previousMessagesCount = currentMessagesCount;
    currentMessagesCount =
        Provider.of<ChatModel>(context, listen: false).getChatList().length;

    // print('Previous message count: $previousMessagesCount');
    // print('Current message count: $currentMessagesCount');

    if (newConversationStarted()) {
      // if the conversationCount is empty then
      final DocumentSnapshot getuserdoc =
          await FirebaseDbService.getUserDoc(currentUserID);

      if (getuserdoc.exists == false) {
        messageID = 0;
      } else {
        messageID = getuserdoc.data['messagesCount'];
      }
    }

    handleMessageData(currentUserID, messageID, query);
  }

  void _handleSubmitted(String text) {
    print('submitting');
    // if the inputted string is empty, don't do anything
    if (text == '') {
    } else {
      _textController.clear();
      messageID += 1;
      Provider.of<ChatModel>(context, listen: false)
          .addChat(text, "User", true, messageID);

      response(text);
    }
  }

  bool newConversationStarted() {
    bool result = false;

    if (previousMessagesCount == 0) {
      if (currentMessagesCount > 0) {
        result = true;
      }
    }
    return result;
  }

  // Called by response()
  void handleMessageData(String userID, int messageID, String query) async {
    FirebaseDbService.addMessageCount(userID, messageID);

    var userMessage =
        Provider.of<ChatModel>(context, listen: false).getLastMessage();
    FirebaseDbService.addMessageData(userID, messageID, userMessage);

    FirebaseDbService.addMessageCount(currentUserID, messageID);

    var botMessage =
        Provider.of<ChatModel>(context, listen: false).getLastMessage();

    FirebaseDbService.addMessageData(currentUserID, messageID, botMessage);

    myFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text("CBT Chatbot"),
      // ),
      // wrap in GestureDetector(onTap: () => FocusScope.of(context).unfocus())
      // For mobile this will remove the keyboard
      body: Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        IconButton(
          icon: FaIcon(FontAwesomeIcons.cog),
          color: Theme.of(context).dividerColor,
          onPressed: () {
            Provider.of<ThemeModel>(context, listen: false).setTheme();
          },
        ),
        Flexible(
          child: Consumer<ChatModel>(
            builder: (context, chat, child) {
              return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  reverse: true,
                  itemCount: chat.getChatList().length + 1,
                  itemBuilder: (_, index) {
                    if (index == 0) {
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
                                      image: new AssetImage(
                                          "assets/gifs/bot_transparent.gif"),
                                      width: 100,
                                      height: 140,
                                    ),
                                  ),
                                  Consumer<ChatModel>(
                                      builder: (context, chat, child) {
                                    return (chat.getBotResponse() != null)
                                        ? BotResponse(
                                            text: chat.getBotResponse().text,
                                            feedback:
                                                chat.getBotResponse().feedback,
                                            bubbleColor: Theme.of(context)
                                                .colorScheme
                                                .primaryVariant,
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2)
                                        : JumpingDotsProgressIndicator(
                                            beginTweenValue: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            endTweenValue:
                                                Theme.of(context).dividerColor,
                                          );
                                  })
                                ],
                              )));
                    }
                    return chat
                        .getChatList()[chat.getChatList().length - index];
                  });
            },
          ),
        ),
        Divider(height: 1.0),
        TextComposer(
          focusNode: myFocusNode,
          handleSubmit: (text) {
            _handleSubmitted(text);
          },
          controller: _textController,
        )
      ]),
    );
  }
}

// Widget _buildTextComposer() {
//     return IconTheme(
//       data: IconThemeData(color: Theme.of(context).accentColor),
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 8.0),
//         child: Row(
//           children: <Widget>[
//             Flexible(
//               child: TextField(
//                 autofocus: true,
//                 focusNode: myFocusNode,
//                 controller: _textController,
//                 onSubmitted: _handleSubmitted,
//                 decoration:
//                     InputDecoration.collapsed(hintText: "Send a message"),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 4.0),
//               child: IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: () => _handleSubmitted(_textController.text)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
