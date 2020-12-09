import 'package:cloud_firestore/cloud_firestore.dart';

class BubbleModel {
  BubbleModel(
      {this.text,
      this.type,
      this.index,
      this.feedback,
      this.detail,
      this.consecutive,
      this.timestamp});

  String text;
  bool type;
  int index;
  int feedback;
  int detail;
  bool consecutive;
  FieldValue timestamp;
}
