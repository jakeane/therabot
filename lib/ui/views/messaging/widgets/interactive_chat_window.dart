import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/models/chat_model.dart';
import 'package:flutter_chatbot/app/services/firebase_db_service.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/html.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './chat_message.dart';

const SERVER_IP = '108.16.206.168';
const SERVER_PORT = '1010';
const URL = 'ws://$SERVER_IP:$SERVER_PORT';

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

  // Handles user message and generates response from bot
  void response(query) async {
    if (currentUserID == null) {
      currentUserID = await FirebaseDbService.getCurrentUserID();
    }

    // Get the conversation number
    previousMessagesCount = currentMessagesCount;
    currentMessagesCount =
        Provider.of<ChatModel>(context, listen: false).chatList.length;

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

    // Talks to dialogflow
    _textController.clear();
    AuthGoogle authGoogle = await AuthGoogle(
            fileJson:
                "assets/credentials/simplechatbot-pkhufy-24d22513a231.json")
        .build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse response = await dialogflow.detectIntent(query);
    messageID += 1;
    String text = response.getMessage() ??
        CardDialogflow(response.getListMessage()[0]).title;
    Provider.of<ChatModel>(context, listen: false)
        .addChat(text, "Covid Bot", false, messageID);

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
        Flexible(
          child: Consumer<ChatModel>(
            builder: (context, chat, child) {
              return ListView.builder(
                padding: EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, index) =>
                    chat.chatList[chat.chatList.length - index - 1],
                itemCount: chat.chatList.length,
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
