import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:therabot/types/chat.dart';

class ChatProvider extends ChangeNotifier {
  final List<BubbleModel> _bubbleList = [];
  final List<MessageModel> _messageList = [];
  BubbleModel? _botResponse;
  bool waiting = false;
  bool _highlightFeedback = false;

  List<BubbleModel> getChatList() => _bubbleList;
  BubbleModel? getBotResponse() => _botResponse;
  bool getHighlightFeedback() => _highlightFeedback;

  void addChat(String text, bool type) {
    if (_botResponse != null) {
      _bubbleList.add(_botResponse!);
      _botResponse = null;
    }

    BubbleModel bubble = createBubble(text, type);

    if (!(text.endsWith(".") || text.endsWith("!") || text.endsWith("?"))) {
      text += ".";
    }

    if (_messageList.isNotEmpty && _messageList.last.type == type) {
      _bubbleList.last.consecutive = true;

      _messageList.last.text += " $text";
    } else {
      _messageList.add(createMessage(text, type));
    }

    _bubbleList.add(bubble);

    notifyListeners();
  }

  void addBotResponse(String text, bool type) {
    if (_botResponse != null) {
      _bubbleList.add(_botResponse!);
      _botResponse = null;
    }

    _botResponse = createBubble(text, type);
    _messageList.add(createMessage(text, type));

    notifyListeners();
  }

  BubbleModel createBubble(String text, bool type) {
    return BubbleModel(
        text: text, type: type, feedback: -1, consecutive: false);
  }

  MessageModel createMessage(String text, bool type) {
    return MessageModel(
        text: text,
        type: type,
        index: _messageList.length,
        feedback: -1,
        detail: -1,
        timestamp: FieldValue.serverTimestamp());
  }

  void giveFeedback(int index, int feedback) {
    if (index == -1) {
      _botResponse!.feedback = feedback;
      if (feedback == -1) {
        _messageList.last.detail = -1;
      }
    } else {
      _bubbleList[index].feedback = feedback;
    }
    notifyListeners();
  }

  void feedbackDetail(int index, int detail) {
    if (index == -1) {
      _messageList.last.detail = detail;
    } else {
      _messageList[index].detail = detail;
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

    await Future.delayed(const Duration(milliseconds: 1000));

    _botResponse = null;
    waiting = false;
    notifyListeners();
  }

  void runHighlightFeedback() async {
    _highlightFeedback = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 100));
    _highlightFeedback = false;
    notifyListeners();
  }

  Map<String, Object> getLastMessage() {
    return {
      "index": _messageList.last.index,
      "type": _messageList.last.type,
      "text": _messageList.last.text,
      "feedback": "",
      "detail": "",
      "timestamp": _messageList.last.timestamp,
    };
  }

  Map<String, Object>? getBotMessage() {
    if (_botResponse != null) {
      return {
        "index": _messageList.last.index,
        "type": _messageList.last.type,
        "text": _messageList.last.text,
        "feedback": _botResponse!.feedback,
        "detail": _messageList.last.detail,
        "timestamp": _messageList.last.timestamp,
      };
    }
    return null;
  }
}
