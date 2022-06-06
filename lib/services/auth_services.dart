// ignore_for_file: prefer_function_declarations_over_variables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../screens/home_screen.dart';

class Auth {
  void openSnackbar(BuildContext context, String msg) {
    final snackbar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  FirebaseAuth auth = FirebaseAuth.instance;
  final storage = const FlutterSecureStorage();

  Future<void> googleSignIn(BuildContext context) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential credentials = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        try {
          UserCredential userCredentials =
              await auth.signInWithCredential(credentials);
          storeToken(userCredentials);
          Navigator.of(context)
              .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
        } catch (e) {
          final errorSnackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(errorSnackbar);
        }
      }
    } catch (e) {
      openSnackbar(context, e.toString());
    }
  }

  Future<void> storeToken(UserCredential credentials) async {
    await storage.write(
        key: 'token', value: credentials.credential!.token.toString());
    await storage.write(key: 'userCredentials', value: credentials.toString());
  }

  Future<String?>? getToken() async {
    return await storage.read(key: 'token');
  }

  Future<void> logout(BuildContext context) async {
    try {
      await _googleSignIn.signOut();
      await auth.signOut();
      await storage.delete(key: 'token');
    } catch (e) {
      openSnackbar(context, e.toString());
    }
  }

  Future verifyOtp(
      BuildContext context, String phoneNumber, Function setData) async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      openSnackbar(context, 'Verification Completed.');
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      openSnackbar(context, exception.toString());
    };
    PhoneCodeSent codeSent =
        (String verificationId, [int? forceResendingToken]) {
      setData(verificationId);
      openSnackbar(context, 'An OTP has been sent.');
    };
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      openSnackbar(context, 'Timeout');
    };

    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      openSnackbar(context, e.toString());
    }
  }

  void signInWithPhone(BuildContext context, verificationId, smsCode) async {
    try {
      AuthCredential credentials = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      UserCredential userCredentials =
          await auth.signInWithCredential(credentials);
      Navigator.of(context)
          .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
    } catch (e) {
      openSnackbar(context, e.toString());
    }
  }
}
