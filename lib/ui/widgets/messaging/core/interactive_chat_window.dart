import 'dart:convert';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_chatbot/app/constants/messaging_strings.dart';
import 'package:flutter_chatbot/app/constants/prompts_data.dart';
import 'package:flutter_chatbot/app/constants/strings.dart';
import 'package:flutter_chatbot/app/models/bubble_model.dart';
import 'package:flutter_chatbot/app/models/chat_model.dart';
import 'package:flutter_chatbot/app/models/therabot_model.dart';
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
const AWS_DNS = 'ec2-52-24-20-184.us-west-2.us-west-2.compute.amazonaws.com';
const AWS_IP = '52.24.20.184';
const AWS_PORT = '8080';
const LOCAL_URL = 'ws://$LOCAL_IP:$LOCAL_PORT/websocket';
const AWS_URL = 'ws://$AWS_IP:$AWS_PORT/websocket';
const NRCLEX_URL =
    'https://gabho7ma71.execute-api.us-west-2.amazonaws.com/default/NRC_Lex';

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
  final channel = WebSocketChannel.connect(Uri.parse(AWS_URL));

  // SET FALSE BEFORE DEPLOYMENT
  final breakMode = true;

  String convoID;
  bool botThinking = true;
  bool _settingsOpen = false;
  bool _feedbackOpen = false;

  List<TextSpan> prompt;

  // Waits until user has not typed for 5 seconds to send message
  RestartableTimer _timer;

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

      if (MessagingStrings.botInitPhrases.indexOf(text) == 0) {
        convoID = Uuid().v4();
        FirebaseDbService.updateConvoID(convoID);
        prompt = PromptsData.getContext();
        await Future.delayed(Duration(milliseconds: 2000));
        channel.sink.add(MessagingStrings.convoBegin);
        Provider.of<ChatModel>(context, listen: false)
            .addBotResponse(MessagingStrings.welcomeMessage, false);
        setState(() {
          botThinking = false;
        });
      } else if (!MessagingStrings.botInitPhrases.contains(text)) {
        await Future.delayed(Duration(seconds: 1));

        int waitTime = text.length * 30;
        // print('waittime: $waitTime');

        await Future.delayed(Duration(milliseconds: waitTime));
        Provider.of<ChatModel>(context, listen: false)
            .addBotResponse(text, false);

        setState(() {
          botThinking = false;
        });
      }
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
    // print("Pre-process:  $text");

    String result = text
        .split(" . ")
        .map((sent) => toBeginningOfSentenceCase(sent))
        .join(". ")
        .split(" ! ")
        .map((sent) => toBeginningOfSentenceCase(sent))
        .join("! ")
        .split(" ? ")
        .map((sent) => toBeginningOfSentenceCase(sent))
        .join("? ")
        .replaceAll(" i ", " I ")
        .replaceAll(" ?", "?")
        .replaceAll(" .", ".")
        .replaceAll(" !", "!")
        .replaceAll(" ’", "’")
        .replaceAll("’ ", "’")
        .replaceAll(" '", "'")
        .replaceAll("' ", "'")
        .replaceAll(" , ", ", ");

    // print("Post-process: $result");
    return result;
  }

  void initializeChat() async {
    // convoID = Uuid().v4();
    // FirebaseDbService.updateConvoID(convoID);

    await Future.delayed(Duration(milliseconds: 250));
    channel.sink.add(MessagingStrings.convoInit);

    // await Future.delayed(Duration(milliseconds: 2000));
    // channel.sink.add('{"text": "Begin"}');
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    channel.sink.add(MessagingStrings.convoDone);
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

  void newConvo() {
    // channel.sink.add('{"text": "[DONE]"}');
    // Provider.of<ChatModel>(context, listen: false).restartConvo();
    // setState(() {
    //   botThinking = true;
    // });
    // convoID = Uuid().v4();
    // FirebaseDbService.updateConvoID(convoID);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacementNamed(Strings.messagingViewRoute);
    });
  }

  void handleSubmitted(String text) {
    BubbleModel response =
        Provider.of<ChatModel>(context, listen: false).getBotResponse();

    if (botThinking) {
      Provider.of<ChatModel>(context, listen: false).setWaitingMessage();
    } else if (response != null &&
        response.feedback == -1 &&
        response.text != MessagingStrings.welcomeMessage) {
      Provider.of<ChatModel>(context, listen: false).runHighlightFeedback();
    } else if (text != '') {
      _textController.clear();

      setState(() {
        botThinking = false;
      });

      handleResponse(text.trim());
    }
  }

  // Handles user message and generates response from bot
  void handleResponse(String text) async {
    Map<String, Object> botMessage =
        Provider.of<ChatModel>(context, listen: false).getBotMessage();

    if (botMessage != null) {
      if (!breakMode) {
        FirebaseDbService.addMessageData(botMessage);
      } else {
        print(botMessage);
      }

      _timer = new RestartableTimer(Duration(seconds: 5), sendMessage);
    }

    Provider.of<ChatModel>(context, listen: false).addChat(text, true);

    myFocusNode.requestFocus();
  }

  void sendMessage() {
    setState(() {
      botThinking = true;
    });

    Map<String, Object> userMessage =
        Provider.of<ChatModel>(context, listen: false).getLastMessage();

    String textJSON = jsonEncode(<String, String>{'text': userMessage['text']});

    Provider.of<TherabotModel>(context, listen: false)
        .calculateEmotion(textJSON);

    channel.sink.add(textJSON);

    if (!breakMode) {
      FirebaseDbService.addMessageData(userMessage);
    } else {
      print(userMessage);
    }
  }

  void resetTimer() {
    if (_timer != null && _timer.isActive) {
      _timer.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          MessageFeed(
            botThinking: botThinking,
            setFeedbackView: setFeedbackView,
            prompt: prompt,
          ),
          Divider(height: 1.0),
          TextComposer(
            focusNode: myFocusNode,
            handleSubmit: handleSubmitted,
            resetTimer: resetTimer,
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
        Positioned(
          top: 10,
          left: 20,
          child: IconButton(
            icon: FaIcon(FontAwesomeIcons.redoAlt),
            color: Theme.of(context).dividerColor,
            onPressed: () {
              newConvo();
            },
          ),
        ),
        if (_settingsOpen)
          SettingsOverlay(
            setSettingsView: setSettingsView,
            newConvo: newConvo,
          ),
        if (_feedbackOpen)
          FeedbackOverlay(
            setFeedbackView: setFeedbackView,
          )
      ],
    );
  }
}
