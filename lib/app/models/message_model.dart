import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  MessageModel(
      {this.text,
      this.type,
      this.index,
      this.feedback,
      this.detail,
      this.timestamp});
  String text;
  bool type;
  int index;
  FieldValue timestamp;
  int feedback;
  int detail;
}
