import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:therabot/store/helpers.dart';
import 'package:tuple/tuple.dart';

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
      firestoreInstance.collection('convos').doc(convoID).set(
          {"userID": authInstance.currentUser?.uid ?? "", "prompt": prompt});
    } catch (e) {
      return;
    }
  }

  static void initUserData(String userID) {
    try {
      firestoreInstance
          .collection('users')
          .doc(userID)
          .set({"isDark": true, "convoID": '', "promptNum": 0});
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

  static void updatePromptNum(int newPromptNum) {
    try {
      String userID = authInstance.currentUser?.uid ?? "";

      firestoreInstance
          .collection('users')
          .doc(userID)
          .set({"promptNum": newPromptNum}, SetOptions(merge: true));
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

  static Future<Tuple2<List<Message>, List<Exchange>>> getConvo(String convoID) async {
    try {
      var messageQuery = await firestoreInstance
          .collection('messages')
          .where('convoID', isEqualTo: convoID)
          .where('userID', isEqualTo: authInstance.currentUser?.uid)
          .get();

      List<Message> messages = messageQuery.docs
          .where((doc) => doc.exists)
          .map((doc) => doc.data())
          .map((doc) => Message(doc['type'], doc['index'], doc['text']))
          .where((msg) => msg.index != 0)
          .toList()
        ..sort((a, b) => a.index - b.index);

      var exchangeNum = 0;
      var userMessages = [''];
      var botMessages = [''];
      var newExchange = false;

      for (int i = 0; i < messages.length; i++) {
        if (messages.elementAt(i).type) {
          if (newExchange) {
            exchangeNum++;
            userMessages.add('');
            botMessages.add('');
            newExchange = false;
          }
          userMessages[exchangeNum] =
            concatMessages(userMessages[exchangeNum], messages[i].text);
        } else {
          botMessages[exchangeNum] = 
            concatMessages(botMessages[exchangeNum], messages[i].text);
          newExchange = true;
        }
      }

      List<Exchange> messageSequence = [];

      for (int i = 0; i <= exchangeNum; i++) {
        messageSequence
            .add(Exchange(userMessages.elementAt(i), botMessages.elementAt(i)));
      }

      return Tuple2(messages, messageSequence);
    } catch (e) {
      return const Tuple2([],[]);
    }
  }
}

class Exchange {
  final String user;
  final String bot;
  Exchange(this.user, this.bot);

  Map<String, dynamic> toJson() => {'user': user, 'bot': bot};

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
