import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/models/bubble_model.dart';
import 'package:flutter_chatbot/app/models/message_model.dart';

class ChatModel extends ChangeNotifier {
  final List<BubbleModel> _bubbleList = [];
  final List<MessageModel> _messageList = [];
  BubbleModel _botResponse;
  bool waiting = false;
  bool _highlightFeedback = false;

  int convoSize = 0;

  List<BubbleModel> getChatList() => _bubbleList;
  BubbleModel getBotResponse() => _botResponse;
  bool getHighlightFeedback() => _highlightFeedback;

  void addChat(String text, bool type) {
    if (_botResponse != null) {
      _bubbleList.add(_botResponse);
      _botResponse = null;
      convoSize += 1;
    }

    BubbleModel bubble = createBubble(text, type);

    if (_bubbleList.length > 0 && _bubbleList.last.type == type) {
      _bubbleList.last.consecutive = true;
    }

    _bubbleList.add(bubble);

    notifyListeners();
  }

  void addBotResponse(String text, bool type) {
    if (_botResponse != null) {
      _bubbleList.add(_botResponse);
      _botResponse = null;
    }

    _botResponse = createBubble(text, type);

    notifyListeners();
  }

  BubbleModel createBubble(String text, bool type) {
    return BubbleModel(
      text: text,
      type: type,
      index: convoSize,
      feedback: -1,
      consecutive: false,
    );
  }

  void giveFeedback(int index, int feedback) {
    if (index == -1) {
      _botResponse.feedback = feedback;
    } else {
      _bubbleList[index].feedback = feedback;
    }
    notifyListeners();
  }

  void feedbackDetail(int index, int detail) {
    if (index == -1) {
      _botResponse.detail = detail;
    } else {
      _bubbleList[index].detail = detail;
    }
    notifyListeners();
  }

  void restartConvo() {
    _bubbleList.clear();
    _botResponse = null;
  }

  bool isWaiting() {
    return _botResponse == null || waiting;
  }

  void setWaitingMessage() async {
    waiting = true;
    _botResponse = createBubble("Hold on, I'm thinking...", false);
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
      "index": _messageList.last.index,
      "type": _messageList.last.type,
      "text": _messageList.last.text,
      "feedback": null,
      "detail": null,
      "timestamp": _messageList.last.timestamp,
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
