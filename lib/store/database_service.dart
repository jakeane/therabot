import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    try {
      firestoreInstance
          .collection('convos')
          .doc(convoID)
          .set({"userID": authInstance.currentUser?.uid ?? "", "prompt": prompt});
    } catch (e) {
      return;
    }
  }

  static void initUserData(String userID) {
    try {
      firestoreInstance
          .collection('users')
          .doc(userID)
          .set({"isDark": true, "convoID": ''});
    } catch (e) {
      return;
    }
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
    try {
      String userID = authInstance.currentUser?.uid ?? "";

      firestoreInstance
          .collection('users')
          .doc(userID)
          .set({"convoID": newID}, SetOptions(merge: true));

    } catch (e) {
      return;
    }
  }

  static void saveTheme(bool isDark) {
    try {
      String userID = authInstance.currentUser?.uid ?? "";

      firestoreInstance
          .collection('users')
          .doc(userID)
          .set({"isDark": isDark}, SetOptions(merge: true));
    } catch (e) {
      return;
    }
  }

  static Future<List<Exchange>> getConvo(String convoID) async {
    try {
      var messageQuery = await firestoreInstance
        .collection('messages')
        .where('convoID', isEqualTo: convoID)
        .where('userID', isEqualTo: authInstance.currentUser?.uid)
        .get();

      var messages = messageQuery.docs
        .where((doc) => doc.exists)
        .map((doc) => doc.data())
        .map((doc) => Message(doc['type'], doc['index'], doc['text']))
        .where((msg) => msg.index != 0)
        .toList()
        ..sort((a, b) => a.index - b.index);

      var messageSequence = messages.fold<List<Exchange>>([], (msgPairs, msg) => (
        msg.type
          ? [...msgPairs, Exchange(msg.text, '')]
          : [
              ...msgPairs.sublist(0, msgPairs.length-1),
              Exchange(msgPairs.last.user, msg.text)
            ]
      ));

      return messageSequence;

    } catch (e) {
      return [];
    }

  }
}

class Exchange {
  final String user;
  final String bot;
  Exchange(this.user, this.bot);

  Map<String, dynamic> toJson() => {
    'user': user,
    'bot': bot
  };

  @override
  String toString() {
    return "{ user: $user, bot: $bot }";
  }
}

class Message {
  final bool type;
  final int index;
  final String text;

  Message(this.type, this.index, this.text);

  @override
  String toString() {
    return "Message $index from ${type ? 'user' : 'bot'}: $text";
  }
}
