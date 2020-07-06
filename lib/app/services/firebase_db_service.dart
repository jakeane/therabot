import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDbService {
  static final firestoreInstance = Firestore.instance;

  static Future<String> getCurrentUserID() async {
    var user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }

  static Future<DocumentSnapshot> getUserDoc(String userID) async {
    var userDoc =
        await firestoreInstance.collection('users').document(userID).get();
    return userDoc;
  }

  static void addMessageCount(String userID, int messageID) {
    firestoreInstance
        .collection('users')
        .document(userID)
        .setData(json.decode('{"messagesCount": $messageID}'), merge: true)
        .then((_) => print("messageCount set to $messageID"));
  }

  static void addMessageData(
      String userID, int messageID, Map<String, Object> messageData) {
    firestoreInstance
        .collection('users')
        .document(userID)
        .collection('messages')
        .document('message_id$messageID')
        .setData(messageData, merge: true)
        .then((_) {
      var messageName = messageData["name"];
      print("Added $messageName message to firestore");
    });
  }
}
