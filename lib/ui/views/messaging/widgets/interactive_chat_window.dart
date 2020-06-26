import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/html.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final firestoreInstance = Firestore.instance;
  String currentUserID = '';
  int previousMessagesCount = 0;
  int currentMessagesCount = 0;
  int messageID = 0;

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
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    currentUserID = firebaseUser.uid;

    // Get the conversation number
    previousMessagesCount = currentMessagesCount;
    currentMessagesCount = _messages.length;

    print('Previous message count: $previousMessagesCount');
    print('Current message count: $currentMessagesCount');

    if (newConversationStarted()) {
      // if the conversationCount is empty then
      final DocumentSnapshot getuserdoc = await Firestore.instance
          .collection('users')
          .document(currentUserID)
          .get();

      if (getuserdoc.exists == false) {
        messageID = 0;
      }

      else {
        messageID = getuserdoc.data['messagesCount'];
      }
    }

    messageID += 1;

    firestoreInstance
            .collection("users")
            .document(firebaseUser.uid)
            .setData(json.decode('{"messagesCount": $messageID}'), merge: true)
            .then((_) {
          print("messageCount set to $messageID");
        });


    // userMessage['timestamp'] = firestoreInstance.s
    firestoreInstance
        .collection("users")
        .document(firebaseUser.uid)
        .collection("messages")
        .document("message_id$messageID")
        .setData({
          "text": _messages.first.text,
          "name": _messages.first.name,
          "type": _messages.first.type,
          "timestamp": FieldValue.serverTimestamp(),
        }, merge: true)
        .then((_) {
      print("Added user message to firestore");
    });

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

    firestoreInstance
            .collection("users")
            .document(firebaseUser.uid)
            .setData(json.decode('{"messagesCount": $messageID}'), merge: true)
            .then((_) {
          print("messageCount set to $messageID");
        });

    // Save the bot message to firestore
    firestoreInstance
        .collection("users")
        .document(firebaseUser.uid)
        .collection("messages")
        .document("message_id$messageID")
        .setData({
          "text": _messages.first.text,
          "name": _messages.first.name,
          "type": _messages.first.type,
          "timestamp": FieldValue.serverTimestamp(),
        }, merge: true)
        .then((_) {
      print("Added bot response to firestore");
    });
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

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.name, this.type});

  final String text;
  final String name;
  final bool type;

  List<Widget> otherMessage(context) {
    return <Widget>[
      Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: CircleAvatar(child: Text('CB')),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(this.name, style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: Text(this.text),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> myMessage(context) {
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(this.name, style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: Text(text),
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(left: 16.0),
        child: CircleAvatar(
            child: Text(
          this.name[0],
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}
