import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/models/message_model.dart';

class ChatModel extends ChangeNotifier {
  final List<MessageModel> _chatList = [];
  MessageModel _botResponse;
  bool waiting = false;
  bool _highlightFeedback = false;

  List<MessageModel> getChatList() => _chatList;
  MessageModel getBotResponse() => _botResponse;
  bool getHighlightFeedback() => _highlightFeedback;

  void addChat(String text, bool type) {
    if (_botResponse != null) {
      _chatList.add(_botResponse);
      _botResponse = null;
    }

    if (_chatList.length > 0 && _chatList.last.type == type) {
      _chatList.last.consecutive = true;
    }

    MessageModel message = createMessage(text, type);
    _chatList.add(message);

    notifyListeners();
  }

  void addBotResponse(String text, bool type) {
    if (_botResponse != null) {
      _chatList.add(_botResponse);
      _botResponse = null;
    }

    _botResponse = createMessage(text, type);

    notifyListeners();
  }

  MessageModel createMessage(String text, bool type) {
    return MessageModel(
      text: text,
      type: type,
      index: _chatList.length,
      feedback: -1,
      detail: -1,
      timestamp: FieldValue.serverTimestamp(),
      comment: "",
      selected: false,
      consecutive: false,
    );
  }

  void giveFeedback(int index, int feedback) {
    if (index == -1) {
      _botResponse.feedback = feedback;
    } else {
      _chatList[index].feedback = feedback;
    }
    notifyListeners();
  }

  void feedbackDetail(int index, int detail) {
    if (index == -1) {
      _botResponse.detail = detail;
    } else {
      _chatList[index].detail = detail;
    }
    notifyListeners();
  }

  void restartConvo() {
    _chatList.clear();
    _botResponse = null;
  }

  bool isWaiting() {
    return _botResponse == null || waiting;
  }

  void setWaitingMessage() async {
    waiting = true;
    _botResponse = createMessage("Hold on, I'm thinking...", false);
    notifyListeners();

    await Future.delayed(Duration(milliseconds: 1000));

    _botResponse = null;
    waiting = false;
    notifyListeners();
  }

  void runHighlightFeedback() async {
    _highlightFeedback = true;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 100));
    _highlightFeedback = false;
    notifyListeners();
  }

  Map<String, Object> getLastMessage() {
    return {
      "index": _chatList.last.index,
      "type": _chatList.last.type,
      "text": _chatList.last.text,
      "feedback": null,
      "detail": null,
      "timestamp": _chatList.last.timestamp,
    };
  }

  Map<String, Object> getBotMessage() {
    if (_botResponse != null) {
      return {
        "index": _botResponse.index,
        "type": _botResponse.type,
        "text": _botResponse.text,
        "feedback": _botResponse.feedback,
        "detail": _botResponse.detail,
        "timestamp": _botResponse.timestamp,
      };
    }
    return null;
  }
}
