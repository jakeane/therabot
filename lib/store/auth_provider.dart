// import 'package:apple_sign_in/apple_sign_in.dart';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:therabot/store/database_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  // final AppleSignIn appleSignIn = AppleSignIn();

  bool _isNew = false;

  bool get isNew => _isNew;

  void changeIsNew() {
    _isNew = !_isNew;
  }

  User? getUser() {
    return _auth.currentUser;
  }

  String? getUserID() {
    return getUser()?.uid;
  }

  Future<String?> signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount == null) return null;
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
        
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    _isNew = authResult.additionalUserInfo?.isNewUser ?? false;

    final User? user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);

      final User? currentUser = _auth.currentUser;
      assert(user.uid == currentUser?.uid);

      // print('signInWithGoogle succeeded: $user');
      if (_isNew) FirebaseDbService.initUserData(user.uid);

      notifyListeners();
      return '$user';
    }
    notifyListeners();
    return null;
  }

  Future<String?> signInAppleAccount() async {

    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    final cred = await SignInWithApple.getAppleIDCredential(scopes: [AppleIDAuthorizationScopes.email], nonce: nonce);

    final oauthCred = OAuthProvider('apple.com').credential(idToken: cred.identityToken, rawNonce: rawNonce);

    final authResult = await _auth.signInWithCredential(oauthCred);
  
    _isNew = authResult.additionalUserInfo?.isNewUser ?? true;

    final user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);

      final currentUser = _auth.currentUser;
      assert(user.uid == currentUser?.uid);

      // print('signInWithGoogle succeeded: $user');
      if (_isNew) FirebaseDbService.initUserData(user.uid);

      notifyListeners();
      return '$user';
    }
    return null;
  }

  Future<String> signInRegularAccount(String email, String password) async {
    try {
      final UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User? user = authResult.user;

      if (user != null) {
        assert(!user.isAnonymous);
        final User? currentUser = _auth.currentUser;
        assert(user.uid == currentUser?.uid);

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
      final User? user = authResult.user;

      _isNew = true;

      if (user != null) {
        assert(!user.isAnonymous);
        final User? currentUser = _auth.currentUser;
        assert(user.uid == currentUser?.uid);

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

  String generateNonce([int length = 32]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
