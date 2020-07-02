import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/services/firebase_db_service.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/html.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './chat_message.dart';
import 'dart:convert';

const SERVER_IP = '108.16.206.168';
const SERVER_PORT = '1010';
const URL = 'ws://$SERVER_IP:$SERVER_PORT';

WebSocketChannel initializeWebSocketChannel(String url) {
  return HtmlWebSocketChannel.connect(url);
}

class InteractiveChatWindow extends StatefulWidget {
  InteractiveChatWindow({Key key, this.title}) : super(key: key);

  // Takes a single input which is the title of the chat window
  final String title;

  @override
  _InteractiveChatWindow createState() => _InteractiveChatWindow();
}

class _InteractiveChatWindow extends State<InteractiveChatWindow> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = TextEditingController();
  final WebSocketChannel channel = WebSocketChannel.connect(Uri.parse(URL));

  String currentUserID;
  int previousMessagesCount = 0;
  int currentMessagesCount = 0;
  int messageID = 0;

  // Creates a focus node to autofocus the text controller when the chatbot responds
  FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();

    super.dispose();
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                autofocus: true,
                focusNode: myFocusNode,
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                    InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_textController.text)),
            ),
          ],
        ),
      ),
    );
  }

  void response(query) async {
    if (currentUserID == null) {
      currentUserID = await FirebaseDbService.getCurrentUserID();
    }

    // Get the conversation number
    previousMessagesCount = currentMessagesCount;
    currentMessagesCount = _messages.length;

    print('Previous message count: $previousMessagesCount');
    print('Current message count: $currentMessagesCount');

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

    messageID += 1;

    FirebaseDbService.addMessageCount(currentUserID, messageID);

    var userMessage = {
      "text": _messages.first.text,
      "name": _messages.first.name,
      "type": _messages.first.type,
      "timestamp": FieldValue.serverTimestamp(),
    };
    FirebaseDbService.addMessageData(currentUserID, messageID, userMessage);

    // Talks to dialogflow
    _textController.clear();
    AuthGoogle authGoogle = await AuthGoogle(
            fileJson:
                "assets/credentials/simplechatbot-pkhufy-24d22513a231.json")
        .build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse response = await dialogflow.detectIntent(query);
    ChatMessage message = ChatMessage(
      text: response.getMessage() ??
          CardDialogflow(response.getListMessage()[0]).title,
      name: "Covid Bot",
      type: false,
    );
    // Add in the user message to the firestore message list
    setState(() {
      _messages.insert(0, message);
    });

    messageID += 1;

    FirebaseDbService.addMessageCount(currentUserID, messageID);

    var botMessage = {
      "text": _messages.first.text,
      "name": _messages.first.name,
      "type": _messages.first.type,
      "timestamp": FieldValue.serverTimestamp(),
    };
    FirebaseDbService.addMessageData(currentUserID, messageID, botMessage);

    myFocusNode.requestFocus();
  }

  void _handleSubmitted(String text) {
    // if the inputted string is empty, don't do anything
    if (text == '') {
    } else {
      _textController.clear();
      ChatMessage message = ChatMessage(
        text: text,
        name: "User",
        type: true,
      );
      setState(() {
        _messages.insert(0, message);
      });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Covid-19 Chatbot"),
      ),
      body: Column(children: <Widget>[
        Flexible(
            child: ListView.builder(
          padding: EdgeInsets.all(8.0),
          reverse: true,
          itemBuilder: (_, int index) => _messages[index],
          itemCount: _messages.length,
        )),
        Divider(height: 1.0),
        Container(
          decoration: new BoxDecoration(color: Theme.of(context).cardColor),
          child: _buildTextComposer(),
        ),
      ]),
    );
  }
}
