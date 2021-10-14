import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  MessageModel({
    required this.text,
    required this.type,
    required this.index,
    required this.feedback,
    required this.detail,
    required this.timestamp
  });
  String text;
  bool type;
  int index;
  FieldValue timestamp;
  int feedback;
  int detail;
}
class BubbleModel {
  BubbleModel({
    required this.text,
    required this.type,
    required this.feedback,
    required this.consecutive
  });

  String text;
  bool type;
  int feedback;
  bool consecutive;
}

