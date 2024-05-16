import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthExceptionMessage(e.code);
    } catch (e) {
      throw 'An error occurred. Please try again later.';
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    if (kIsWeb) {
      return _signInWithGoogleWeb();
    } else {
      return _signInWithGoogleMobile();
    }
  }

  Future<UserCredential?> _signInWithGoogleMobile() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        return await _auth.signInWithCredential(credential);
      } else {
        throw 'Google sign-in aborted.';
      }
    } catch (e) {
      throw 'An error occurred. Please try again later.';
    }
  }

  Future<UserCredential?> _signInWithGoogleWeb() async {
    try {
      final GoogleAuthProvider googleProvider = GoogleAuthProvider();
      googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
      googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

      final UserCredential userCredential = await _auth.signInWithPopup(googleProvider);

      return userCredential;
    } catch (e) {
      throw 'An error occurred. Please try again later.';
    }
  }

  Future<UserCredential?> signInAnonymously() async {
    try {
      return await _auth.signInAnonymously();
    } catch (e) {
      throw 'An error occurred. Please try again later.';
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  String _mapFirebaseAuthExceptionMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      default:
        return 'An error occurred. Please try again later.';
    }
  }

  // Shared Preferences Methods
  Future<void> initSharedPreferences(
    TextEditingController emailController,
    TextEditingController passwordController,
    SharedPreferences prefs,
  ) async {
    emailController.text = prefs.getString('email') ?? '';
    passwordController.text = prefs.getString('password') ?? '';
  }

  Future<void> saveCredentials(
    SharedPreferences prefs,
    String email,
    String password,
    bool rememberMe,
  ) async {
    if (rememberMe) {
      await prefs.setString('email', email);
      await prefs.setString('password', password);
      await prefs.setBool('rememberMe', rememberMe);
    }
  }

  Future<void> clearCredentials(SharedPreferences prefs) async {
    await prefs.remove('email');
    await prefs.remove('password');
    await prefs.remove('rememberMe');
  }
}
