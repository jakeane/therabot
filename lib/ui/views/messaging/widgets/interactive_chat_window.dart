import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/models/chat_model.dart';
import 'package:flutter_chatbot/app/models/theme_model.dart';
import 'package:flutter_chatbot/app/services/firebase_db_service.dart';
import 'package:flutter_chatbot/app/state/chat_state.dart';
import 'package:flutter_chatbot/ui/views/messaging/widgets/avatar_view.dart';
import 'package:flutter_chatbot/ui/views/messaging/widgets/feedback_bar.dart';
import 'package:flutter_chatbot/ui/views/messaging/widgets/text_composer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

const SERVER_IP = 'localhost';
const SERVER_PORT = '10001';
const URL = 'ws://$SERVER_IP:$SERVER_PORT/websocket';

// TODO
// 1. Have settings button go to different view
// 2. Add message bubble spacing logic
// 3. Add feedback flow
// 4. Login page
// 5. New user flow vs. returning user
// 6. Set up backend with dialogue model and emotions
// 7. Placeholder GIFs for chatbot avatar
//      - Parse user's text
//      - Query for emotion with nrcLEX

// BUGS
// 1. Websocket error on Android
// 2. Press enter to send message

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

  bool botThinking = false;

  List<String> botInitPhrases = [
    "Welcome to the overworld for the ParlAI messenger chatbot demo. Please type \"begin\" to start.",
    "Welcome to the ParlAI Chatbot demo. You are now paired with a bot - feel free to send a message.Type [DONE] to finish the chat."
  ];

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

      if (!botInitPhrases.contains(text)) {
        await Future.delayed(Duration(seconds: 1));

        setState(() {
          botThinking = true;
        });

        int waitTime = text.length * 30 + 2000;
        print('waittime: $waitTime');

        await Future.delayed(Duration(milliseconds: waitTime));
        Provider.of<ChatModel>(context, listen: false)
            .addBotResponse(text, "Covid Bot", false, messageID);
      }

      print("channel text: " + text);
    });

    initializeChat();

    myFocusNode = FocusNode();
  }

  void initializeChat() async {
    await Future.delayed(Duration(milliseconds: 100));

    channel.sink.add('{"text": "Hi"}');
    channel.sink.add('{"text": "Begin"}');
    String welcomeMessage =
        "Hi! I am TheraBot. I am here to talk to you about any mental health problems you might be having.";
    Provider.of<ChatModel>(context, listen: false)
        .addBotResponse(welcomeMessage, "Covid Bot", false, messageID);
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
    setState(() {
      botThinking = false;
    });
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
                    return index == 0
                        ? AvatarView(botThinking: botThinking)
                        : chat.getChatList()[chat.getChatList().length - index];
                  });
            },
          ),
        ),
        Divider(height: 1.0),
        Consumer<ChatState>(
          builder: (context, state, child) {
            return state.feedbackMode
                ? FeedbackBar(selected: state.selected)
                : TextComposer(
                    focusNode: myFocusNode,
                    handleSubmit: (text) {
                      _handleSubmitted(text);
                    },
                    controller: _textController,
                  );
          },
        ),
      ]),
    );
  }
}
