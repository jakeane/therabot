import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_chatbot/app/constants/strings.dart';
import 'package:flutter_chatbot/app/models/chat_model.dart';
import 'package:flutter_chatbot/app/services/firebase_db_service.dart';
import 'package:flutter_chatbot/app/services/firebase_auth_service.dart';
import 'package:flutter_chatbot/ui/widgets/messaging/core/message_feed.dart';
import 'package:flutter_chatbot/ui/widgets/messaging/feedback/feedback_overlay.dart';
import 'package:flutter_chatbot/ui/widgets/messaging/settings/settings_overlay.dart';
import 'package:flutter_chatbot/ui/widgets/messaging/core/text_composer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:intl/intl.dart';

const LOCAL_IP = 'localhost';
const LOCAL_PORT = '10001';
const AWS_IP = 'ec2-34-221-3-104.us-west-2.compute.amazonaws.com';
const AWS_PORT = '8080';
const LOCAL_URL = 'ws://$LOCAL_IP:$LOCAL_PORT/websocket';
const AWS_URL = 'ws://$AWS_IP:$AWS_PORT/websocket';

// ignore: todo
// TODO
// 1. Add message bubble spacing logic
// 2. Set up backend with dialogue model and emotions
// 3. Placeholder GIFs for chatbot avatar
//      - Parse user's text
//      - Query for emotion with nrcLEX
// 4. Save local data
//      - Theme
//      - UserID?
//      - Also current conversation?
// 5. Prevent user message consecutively
// 6. User cannot send without providing feedback

class InteractiveChatWindow extends StatefulWidget {
  InteractiveChatWindow({Key key, this.title}) : super(key: key);

  // Takes a single input which is the title of the chat window
  final String title;

  @override
  _InteractiveChatWindow createState() => _InteractiveChatWindow();
}

class _InteractiveChatWindow extends State<InteractiveChatWindow> {
  final TextEditingController _textController = TextEditingController();
  final channel = WebSocketChannel.connect(Uri.parse(LOCAL_URL));

  String convoID;
  bool botThinking = false;
  bool _settingsOpen = false;
  bool _feedbackOpen = false;

  final List<String> botInitPhrases = [
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
      text = processBotText(text);

      if (!botInitPhrases.contains(text)) {
        await Future.delayed(Duration(seconds: 1));

        setState(() {
          botThinking = true;
        });

        int waitTime = text.length * 30 + 2000;
        // print('waittime: $waitTime');

        await Future.delayed(Duration(milliseconds: waitTime));
        Provider.of<ChatModel>(context, listen: false)
            .addBotResponse(text, "Covid Bot", false);
      }

      // print("channel text: " + text);
    });

    myFocusNode = FocusNode();

    if (Provider.of<AuthService>(context, listen: false).isNew) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, Strings.onBoardingRoute);
      });
    } else {
      // if (Provider.of<ThemeModel>(context, listen: false).fetchTheme()) {
      //   FirebaseDbService.getUserData().then((data) async {
      //     if (data != null) {
      //       Provider.of<ThemeModel>(context, listen: false)
      //           .setTheme(data["isDark"]);
      // print(data);
      //       // convoID = data["convoID"];
      //     }
      //     initializeChat();
      //   });
      // } else {}
      initializeChat();
    }
  }

  String processBotText(String text) {
    text = text.toString().replaceAll(" .", ".");
    text = text.toString().replaceAll(" ?", "?");
    text = text.toString().replaceAll(" '", "'");
    text = text.toString().replaceAll("' ", "'");
    text = text.toString().replaceAll(" , ", ", ");
    return toBeginningOfSentenceCase(text);
  }

  void initializeChat() async {
    convoID = Uuid().v4();
    FirebaseDbService.updateConvoID(convoID);

    await Future.delayed(Duration(milliseconds: 100));
    channel.sink.add('{"text": "Hi"}');
    await Future.delayed(Duration(milliseconds: 500));
    channel.sink.add('{"text": "Begin"}');
    String welcomeMessage =
        "Hi! I am TheraBot. I am here to talk to you about any mental health problems you might be having.";
    Provider.of<ChatModel>(context, listen: false)
        .addBotResponse(welcomeMessage, "Covid Bot", false);
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    channel.sink.close();

    super.dispose();
  }

  void setSettingsView() {
    setState(() {
      _settingsOpen = !_settingsOpen;
    });
  }

  void setFeedbackView(int detail) async {
    Provider.of<ChatModel>(context, listen: false).feedbackDetail(-1, detail);
    if (detail != -1) await Future.delayed(Duration(milliseconds: 300));
    setState(() {
      _feedbackOpen = !_feedbackOpen;
    });
  }

  void restartConvo() {
    channel.sink.add('{"text": "[DONE]"}');
    Provider.of<ChatModel>(context, listen: false).restartConvo();
    initializeChat();
  }

  void handleSubmitted(String text) {
    setState(() {
      botThinking = false;
    });

    bool waiting = Provider.of<ChatModel>(context, listen: false).isWaiting();
    if (waiting) {
      Provider.of<ChatModel>(context, listen: false).setWaitingMessage();
    }
    // if the inputted string is empty, don't do anything
    else if (text != '') {
      _textController.clear();

      handleResponse(text);
    }
  }

  // Handles user message and generates response from bot
  void handleResponse(String text) async {
    Map<String, Object> botMessage =
        Provider.of<ChatModel>(context, listen: false).getBotMessage();
    botMessage["convoID"] = convoID;
    FirebaseDbService.addMessageData(botMessage);

    // print("Data: $botMessage\n--------");

    Provider.of<ChatModel>(context, listen: false).addChat(text, "User", true);

    String jsonStringified = '{"text": "$text"}';
    channel.sink.add(jsonStringified);

    Map<String, Object> userMessage =
        Provider.of<ChatModel>(context, listen: false).getLastMessage();
    userMessage["convoID"] = convoID;
    FirebaseDbService.addMessageData(userMessage);

    // print("Data: $userMessage\n--------");

    myFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          MessageFeed(
              botThinking: botThinking, setFeedbackView: setFeedbackView),
          Divider(height: 1.0),
          TextComposer(
            focusNode: myFocusNode,
            handleSubmit: handleSubmitted,
            controller: _textController,
          )
        ]),
        Positioned(
          top: 10,
          right: 20,
          child: IconButton(
            icon: FaIcon(FontAwesomeIcons.cog),
            color: Theme.of(context).dividerColor,
            onPressed: () {
              setSettingsView();
            },
          ),
        ),
        if (_settingsOpen)
          SettingsOverlay(
            setSettingsView: setSettingsView,
            restartConvo: restartConvo,
          ),
        if (_feedbackOpen)
          FeedbackOverlay(
            setFeedbackView: setFeedbackView,
          )
      ],
    );
  }
}
