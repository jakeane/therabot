import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:therabot/types/chat.dart';

class ChatProvider extends ChangeNotifier {
  final List<MessageModel> _messageList = [];
  bool waiting = false;
  bool _highlightFeedback = false;

  List<MessageModel> getChatList() => _messageList;
  bool getHighlightFeedback() => _highlightFeedback;

  MessageModel? getBotResponse() =>
      (_messageList.isEmpty || _messageList.last.type
          ? null
          : _messageList.last);

  void addChat(String text, bool type) {
    var message = createMessage(text, type);
    _messageList.add(message);

    notifyListeners();
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
      if (_messageList.isEmpty || _messageList.last.type) return;
      _messageList.last.feedback = feedback;
      if (feedback == -1) {
        _messageList.last.detail = -1;
      }
    } else {
      _messageList[index].feedback = feedback;
    }
    notifyListeners();
  }

  void feedbackDetail(int index, int detail) {
    if (index == -1) {
      if (_messageList.isEmpty || _messageList.last.type) return;
      _messageList.last.detail = detail;
    } else {
      _messageList[index].detail = detail;
    }
    notifyListeners();
  }

  void restartConvo() {
    _messageList.clear();
  }

  bool isWaiting() {
    return waiting || !(_messageList.isNotEmpty && _messageList.last.type);
  }

  void setWaitingMessage() async {
    waiting = true;
    var waitingMessage = createMessage("Hold on, I'm thinking...", false);
    _messageList.add(waitingMessage);

    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 1000));

    _messageList.removeLast();
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

  List<Map<String, Object>>? getLastMessages() {
    if (_messageList.isEmpty) return null;

    List<Map<String, Object>> messages = [];

    while (_messageList.length > messages.length &&
        _messageList[_messageList.length - messages.length - 1].type) {
      var i = _messageList.length - messages.length - 1;
      messages.add({
        "index": _messageList[i].index,
        "type": _messageList[i].type,
        "text": _messageList[i].text,
        "feedback": "",
        "detail": "",
        "timestamp": _messageList[i].timestamp,
      });
    }

    return messages;
  }

  Map<String, Object>? getBotMessage() {
    if (_messageList.isNotEmpty && !_messageList.last.type) {
      return {
        "index": _messageList.last.index,
        "type": _messageList.last.type,
        "text": _messageList.last.text,
        "feedback": _messageList.last.feedback,
        "detail": _messageList.last.detail,
        "timestamp": _messageList.last.timestamp,
      };
    }
    return null;
  }

  Map<String, Object> getPromptData(MessageModel promptMessage) {
    return {
      "index": promptMessage.index,
      "type": promptMessage.type,
      "text": promptMessage.text,
      "feedback": promptMessage.feedback,
      "detail": promptMessage.detail,
      "timestamp": promptMessage.timestamp,
    };
  }
}
