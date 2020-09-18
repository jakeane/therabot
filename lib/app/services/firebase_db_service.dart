import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDbService {
  static final firestoreInstance = FirebaseFirestore.instance;

  static Future<String> getCurrentUserID() async {
    var user = FirebaseAuth.instance.currentUser;
    return user.uid;
  }

  static Future<DocumentSnapshot> getUserDoc(String userID) async {
    var userDoc = await firestoreInstance.collection('users').doc(userID).get();
    return userDoc;
  }

  static void addMessageCount(String userID, int messageID) {
    firestoreInstance
        .collection('users')
        .doc(userID)
        .set(json.decode('{"messagesCount": $messageID}'))
        .then((_) => print("messageCount set to $messageID"));
  }

  static void addMessageData(
      String userID, int messageID, Map<String, Object> messageData) {
    firestoreInstance
        .collection('users')
        .doc(userID)
        .collection('messages')
        .doc('message_id$messageID')
        .set(messageData)
        .then((_) {
      var messageName = messageData["name"];
      print("Added $messageName message to firestore");
    });
  }
}
