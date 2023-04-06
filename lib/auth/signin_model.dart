import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../user_navigation_home_screen.dart';
import '../utils.dart';

Future<void> onSignIn(BuildContext context, String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    if (userCredential.user != null) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => NavigationHomeScreen(user: userCredential.user!),
        ),
      );
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      showDialog(
        context: context,
        builder: (context) {
          return dialog(context, 'メールアドレスが見つかりません');
        },
      );
    } else if (e.code == 'wrong-password') {
      showDialog(
        context: context,
        builder: (context) {
          return dialog(context, 'パスワードが違います');
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return dialog(context, 'ログインに失敗しました');
        },
      );
    }
  }
}
