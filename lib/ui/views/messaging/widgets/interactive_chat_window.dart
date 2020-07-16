import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/models/chat_model.dart';
import 'package:flutter_chatbot/app/services/firebase_db_service.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const SERVER_IP = 'localhost';
const SERVER_PORT = '10001';
const URL = 'ws://$SERVER_IP:$SERVER_PORT/websocket';

// TODO
// done 1. Add feedback data to chatmessage properties
// done 2. Manage properties via StreamProvider
// done 3. Change thumbs up/down to checkmark and 'X'
// done 4. Show comment option after providing feedback
// 5. On comment press, provide fragment with dropdown options
// done 6. Only show checkmark/x on most recent message
// 7. For other messages, show feedback on bubble corner
// done 8. On bubble press, show feedback options
// 9. Remove username and avatar
// 10. Change Firebase query behavior (To every X messages for now)

// Todo Websocket Integration
// 1. Listen to the correct IP and locat host

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
    channel.stream.listen((event) {
      var data = jsonDecode(event) as Map;
      var text = data['text'];
      Provider.of<ChatModel>(context, listen: false)
          .addChat(text, "Covid Bot", false, messageID);

      print("channel:" + data['text']);
    });

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    channel.sink.close();

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
      appBar: AppBar(
        centerTitle: true,
        title: Text("Covid-19 Chatbot"),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        // StreamBuilder(
        //   stream: channel.stream,
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       print(snapshot.data.toString());
        //     } else {
        //       print("no data");
        //     }
        //     return snapshot.hasData ? Text(snapshot.data.toString()) : Text('');
        //   },
        // ),
        Flexible(
          child: Consumer<ChatModel>(
            builder: (context, chat, child) {
              return ListView.builder(
                padding: EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, index) =>
                    chat.getChatList()[chat.getChatList().length - index - 1],
                itemCount: chat.getChatList().length,
              );
            },
          ),
        ),
        Divider(height: 1.0),
        Container(
          decoration: new BoxDecoration(color: Theme.of(context).cardColor),
          child: _buildTextComposer(),
        ),
      ]),
    );
  }
}
