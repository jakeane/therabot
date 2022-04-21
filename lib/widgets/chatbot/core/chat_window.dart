import 'dart:convert';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ionicons/ionicons.dart';
import 'package:therabot/constants/messaging_strings.dart';
import 'package:therabot/constants/prompts_data.dart';
import 'package:therabot/constants/strings.dart';
import 'package:therabot/store/config_provider.dart';
import 'package:therabot/types/chat.dart';
import 'package:therabot/store/theme_provider.dart';
import 'package:therabot/store/emotion_provider.dart';
import 'package:therabot/store/chat_provider.dart';
import 'package:therabot/store/database_service.dart';
import 'package:therabot/widgets/chatbot/core/message_feed.dart';
import 'package:therabot/widgets/chatbot/core/text_composer.dart';
import 'package:therabot/widgets/chatbot/crisis/crisis_overlay.dart';
import 'package:therabot/widgets/chatbot/feedback/feedback_overlay.dart';
import 'package:therabot/widgets/chatbot/settings/settings_overlay.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:intl/intl.dart';

const localIp = 'localhost';
const localPort = '8000';
const awsDns = 'ec2-52-24-20-184.us-west-2.us-west-2.compute.amazonaws.com';
const awsIp = '54.202.232.232';
const awsPort = '8888';
const localUrl = 'ws://$localIp:$localPort/websocket';
const awsUrl = 'ws://$awsIp:$awsPort/websocket';
const nrclexUrl =
    'https://gabho7ma71.execute-api.us-west-2.amazonaws.com/default/NRC_Lex';
int promptNum = 0; // for dev prompt testing purposes

class InteractiveChatWindow extends StatefulWidget {
  const InteractiveChatWindow({Key? key}) : super(key: key);

  @override
  _InteractiveChatWindow createState() => _InteractiveChatWindow();
}

class _InteractiveChatWindow extends State<InteractiveChatWindow> {
  final TextEditingController _textController = TextEditingController();
  final channel = WebSocketChannel.connect(Uri.parse(awsUrl));

  // SET FALSE BEFORE DEPLOYMENT
  // final breakMode = true;

  String convoID = "";
  bool botThinking = true;
  bool _settingsOpen = false;
  bool _feedbackOpen = false;
  bool _crisisOpen = false;

  List<TextSpan> prompt = [];

  // Waits until user has not typed for 5 seconds to send message
  RestartableTimer? _timer;

  // Creates a focus node to autofocus the text controller when the chatbot responds
  FocusNode? focusNode;

  @override
  void initState() {
    super.initState();

    channel.stream.listen((event) async {
      var data = jsonDecode(event) as Map;
      var text = data['text'];

      text = processBotText(text);

      if (MessagingStrings.botInitPhrases.indexOf(text) == 0) {
        var userData = await FirebaseDbService.getUserData();
        setState(() {
          convoID = userData?['convoID'] ?? '';
          prompt = PromptsData.getContext() ?? [];
        });

        var convo = await FirebaseDbService.getConvo(convoID);
        channel.sink.add(MessagingStrings.getConvoBegin(json.encode(convo)));

        if (convo.isEmpty) {
          await Future.delayed(const Duration(milliseconds: 2000));
        }

        if (Provider.of<ConfigProvider>(context, listen: false).getMode() !=
            Mode.dev) {
          FirebaseDbService.addConvoPrompt(
              convoID, prompt.map((element) => element.text).join());
        }
        Provider.of<ChatProvider>(context, listen: false)
            .addBotResponse(MessagingStrings.welcomeMessage, false);

        for (var exchange in convo) {
          if (exchange.user.isNotEmpty) {
            Provider.of<ChatProvider>(context, listen: false)
                .addChat(exchange.user, true);
          }
          if (exchange.bot.isNotEmpty) {
            Provider.of<ChatProvider>(context, listen: false)
                .addBotResponse(exchange.bot, false);
          }
        }

        Map<String, Object>? botMessage =
            Provider.of<ChatProvider>(context, listen: false).getBotMessage();

        setState(() {
          botThinking = botMessage == null;
        });
      } else if (!MessagingStrings.botInitPhrases.contains(text)) {
        await Future.delayed(const Duration(seconds: 1));

        int waitTime = text.length * 30;

        await Future.delayed(Duration(milliseconds: waitTime));
        Provider.of<ChatProvider>(context, listen: false)
            .addBotResponse(text, false);

        setState(() {
          botThinking = false;
        });

        Map<String, Object>? botMessage =
            Provider.of<ChatProvider>(context, listen: false).getBotMessage();

        if (botMessage != null) {
          botMessage['convoID'] = convoID;
          var mode =
              Provider.of<ConfigProvider>(context, listen: false).getMode();
          if (mode == Mode.trial || mode == Mode.prompt) {
            FirebaseDbService.addMessageData(botMessage);
          } else if (mode == Mode.dev) {
            print(botMessage);
          }
        }
      }
    });

    focusNode = FocusNode();

    Future.delayed(const Duration(milliseconds: 500)).then((_) {
      FirebaseDbService.getUserData().then((data) async {
        if (data != null) {
          Provider.of<ThemeProvider>(context, listen: false)
              .setTheme(data["isDark"]);
          convoID = data["convoID"];
        }
      });
    });
    initializeChat();
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
    await Future.delayed(const Duration(milliseconds: 250));
    channel.sink.add(MessagingStrings.convoInit);
  }

  @override
  void dispose() {
    focusNode?.dispose();
    channel.sink.add(MessagingStrings.convoDone);
    channel.sink.close();

    super.dispose();
  }

  void setSettingsView() {
    setState(() {
      _settingsOpen = !_settingsOpen;
    });
  }

  void setCrisisView() {
    setState(() {
      _crisisOpen = !_crisisOpen;
    });
  }

  void setFeedbackView(int detail) async {
    Provider.of<ChatProvider>(context, listen: false)
        .feedbackDetail(-1, detail);
    if (detail != -1) await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      _feedbackOpen = !_feedbackOpen;
    });
  }

  void newPrompt() {
    if (Provider.of<ConfigProvider>(context, listen: false).getMode() ==
        Mode.prompt) {
      Provider.of<ChatProvider>(context, listen: false)
          .addBotResponse(MessagingStrings.demoPrompts[promptNum++], false);
      if (promptNum >= MessagingStrings.demoPrompts.length) {
        promptNum = 0;
      }

      Map<String, Object>? botMessage =
          Provider.of<ChatProvider>(context, listen: false).getBotMessage();

      if (botMessage != null) {
        botMessage['convoID'] = convoID;
        FirebaseDbService.addMessageData(botMessage);
      }

      return;
    }
  }

  void newConvo() {
    channel.sink.add('{"text": "[DONE]"}');
    convoID = const Uuid().v4();
    FirebaseDbService.updateConvoID(convoID);

    SchedulerBinding.instance?.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacementNamed(Strings.messagingViewRoute);
    });
  }

  void handleSubmitted(String text) {
    BubbleModel? response =
        Provider.of<ChatProvider>(context, listen: false).getBotResponse();

    if (botThinking) {
      Provider.of<ChatProvider>(context, listen: false).setWaitingMessage();
    } else if (response != null &&
        response.feedback == -1 &&
        response.text != MessagingStrings.welcomeMessage &&
        Provider.of<ConfigProvider>(context, listen: false).getMode() !=
            Mode.trial &&
        Provider.of<ConfigProvider>(context, listen: false).getMode() !=
            Mode.prompt) {
      Provider.of<ChatProvider>(context, listen: false).runHighlightFeedback();
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
    Map<String, Object>? botMessage =
        Provider.of<ChatProvider>(context, listen: false).getBotMessage();

    if (botMessage != null) {
      if (Provider.of<ConfigProvider>(context, listen: false).getMode() ==
          Mode.prod) {
        botMessage['convoID'] = convoID;
        FirebaseDbService.addMessageData(botMessage);
      }

      _timer = RestartableTimer(const Duration(seconds: 5), sendMessage);
    }

    Provider.of<ChatProvider>(context, listen: false).addChat(text, true);

    String textJSON = jsonEncode(<String, String>{'text': text});
    Provider.of<EmotionProvider>(context, listen: false)
        .calculateEmotion(textJSON);

    focusNode?.requestFocus();
  }

  void sendMessage() {
    setState(() {
      botThinking = true;
    });

    Map<String, Object> userMessage =
        Provider.of<ChatProvider>(context, listen: false).getLastMessage();
    userMessage['convoID'] = convoID;

    String textJSON =
        jsonEncode(<String, String>{'text': "${userMessage['text']}"});

    channel.sink.add(textJSON);

    if (Provider.of<ConfigProvider>(context, listen: false).getMode() !=
        Mode.dev) {
      FirebaseDbService.addMessageData(userMessage);
    } else {
      print(userMessage);
    }
  }

  void resetTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.reset();
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
          const Divider(height: 1.0),
          TextComposer(
            focusNode: focusNode,
            handleSubmit: handleSubmitted,
            resetTimer: resetTimer,
            controller: _textController,
          )
        ]),
        Positioned(
          top: 10,
          right: 20,
          child: IconButton(
            icon: const FaIcon(FontAwesomeIcons.cog),
            color: Theme.of(context).dividerColor,
            onPressed: () {
              setSettingsView();
            },
          ),
        ),
        Positioned(
            top: 10,
            left: 20,
            child: TextButton(
              child: Row(
                children: [
                  Icon(
                    Ionicons.alert_circle_outline,
                    color: Theme.of(context).errorColor,
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                  Text(
                    "Crisis?",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: Theme.of(context).errorColor),
                  )
                ],
              ),
              onPressed: setCrisisView,
            )),
        if (_settingsOpen)
          SettingsOverlay(
            setSettingsView: setSettingsView,
            newConvo: newConvo,
            newPrompt: newPrompt,
          ),
        if (_feedbackOpen)
          FeedbackOverlay(
            setFeedbackView: setFeedbackView,
          ),
        if (_crisisOpen) CrisisOverlay(setCrisisView: setCrisisView)
      ],
    );
  }
}
