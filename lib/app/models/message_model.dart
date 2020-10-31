import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  MessageModel(
      {this.text,
      this.name,
      this.type,
      this.id,
      this.index,
      this.feedback,
      this.timestamp,
      this.comment,
      this.selected,
      this.consecutive});
  String text;
  String name;
  bool type;
  int id;
  int index;
  FieldValue timestamp;
  int feedback;
  String comment;
  bool selected;
  bool consecutive;
}
