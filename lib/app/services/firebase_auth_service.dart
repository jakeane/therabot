import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/services/firebase_db_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final AppleSignIn appleSignIn = AppleSignIn();

  bool _isNew = false;

  bool get isNew => _isNew;

  void changeIsNew() {
    _isNew = !_isNew;
  }

  User getUser() {
    return _auth.currentUser;
  }

  String getUserID() {
    return getUser().uid;
  }

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    _isNew = authResult.additionalUserInfo.isNewUser;

    final User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);

      // print('signInWithGoogle succeeded: $user');
      if (_isNew) FirebaseDbService.initUserData(user.uid);

      notifyListeners();
      return '$user';
    }
    notifyListeners();
    return null;
  }

  Future<String> signInAppleAccount() async {
    final result = await AppleSignIn.performRequests([
      AppleIdRequest(requestedScopes: [Scope.email])
    ]);

    switch (result.status) {
      case AuthorizationStatus.authorized:
        final appleIdCredential = result.credential;
        final oAuthProvider = OAuthProvider('apple.com');
        final credential = oAuthProvider.credential(
            accessToken:
                String.fromCharCodes(appleIdCredential.authorizationCode),
            idToken: String.fromCharCodes(appleIdCredential.identityToken));
        final authResult = await _auth.signInWithCredential(credential);
        _isNew = authResult.additionalUserInfo.isNewUser;

        final User user = authResult.user;

        if (user != null) {
          assert(!user.isAnonymous);
          assert(await user.getIdToken() != null);

          final User currentUser = _auth.currentUser;
          assert(user.uid == currentUser.uid);

          // print('signInWithGoogle succeeded: $user');
          if (_isNew) FirebaseDbService.initUserData(user.uid);

          notifyListeners();
          return '$user';
        }
        notifyListeners();
        return null;
      case AuthorizationStatus.cancelled:
        break;
      case AuthorizationStatus.error:
        print('error');
        print(result.error.toString());
        break;
    }
    return null;
  }

  Future<String> signInRegularAccount(String email, String password) async {
    try {
      final UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User user = authResult.user;

      if (user != null) {
        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);
        final User currentUser = _auth.currentUser;
        assert(user.uid == currentUser.uid);

        notifyListeners();
        return "Success.";
      }
      return "An issue occured. Please try again.";
    } on FirebaseAuthException catch (e) {
      // print('Failed with error code: ${e.code}');
      // print(e.message);
      return e.code;
    }
  }

  Future<String> createRegularAccount(String email, String password) async {
    try {
      final UserCredential authResult = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final User user = authResult.user;

      _isNew = true;

      if (user != null) {
        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);
        final User currentUser = _auth.currentUser;
        assert(user.uid == currentUser.uid);

        // print('regular signin succeeded: $user');
        FirebaseDbService.initUserData(user.uid);

        notifyListeners();
        return "Success.";
      }
      notifyListeners();
      return "An error occured. Please try again.";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  void signOut() async {
    // await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}
