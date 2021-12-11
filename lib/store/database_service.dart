import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'dart:convert';

class FirebaseDbService {
  static final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  static final authInstance = FirebaseAuth.instance;

  static Future<DocumentSnapshot> getUserDoc(String userID) async {
    var userDoc = await firestoreInstance.collection('users').doc(userID).get();
    return userDoc;
  }

  static void addMessageData(Map<String, Object> messageData) {
    messageData["userID"] = authInstance.currentUser?.uid ?? "";

    firestoreInstance.collection('messages').add(messageData);
  }

  static void addConvoPrompt(String convoID, String prompt) {
    firestoreInstance
        .collection('convos')
        .doc(convoID)
        .set({"userID": authInstance.currentUser?.uid ?? "", "prompt": prompt});
  }

  static void initUserData(String userID) {
    firestoreInstance
        .collection('users')
        .doc(userID)
        .set({"isDark": true, "convoID": ''});
  }

  static Future<Map<String, dynamic>?> getUserData() async {
    if (authInstance.currentUser != null) {
      String userID = authInstance.currentUser?.uid ?? "";

      return await firestoreInstance
          .collection('users')
          .doc(userID)
          .get()
          .then((doc) {
        if (doc.exists) {
          return doc.data();
        } else {
          return null;
        }
      });
    }

    return null;
  }

  static void updateConvoID(String newID) {
    String userID = authInstance.currentUser?.uid ?? "";

    firestoreInstance
        .collection('users')
        .doc(userID)
        .set({"convoID": newID}, SetOptions(merge: true));
  }

  static void saveTheme(bool isDark) {
    String userID = authInstance.currentUser?.uid ?? "";

    firestoreInstance
        .collection('users')
        .doc(userID)
        .set({"isDark": isDark}, SetOptions(merge: true));
  }

  

  static Future<List<dynamic>> getConvo(String convoID) async {
    try {
      Response res = await get(Uri.parse('http://localhost:5001/flutter-chatbot-bbe5a/us-central1/getConversation?convoID=$convoID'));
      var data = json.decode(res.body)['data'] as List<dynamic>;
      return data;
    } catch(e) {
      print(e.toString());
      return [];
    }
  }
}

class Exchange {
  final String user;
  final String bot;
  Exchange(this.user, this.bot);

  Exchange.fromJson(Map<String, dynamic> json)
    : user = json['user'],
      bot = json['bot'];
}
