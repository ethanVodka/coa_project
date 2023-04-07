import 'package:coa_project/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../admin_navigation_home_screen.dart';
import '../user_navigation_home_screen.dart';
import '../utils.dart';

Future<void> onSignIn(BuildContext context, String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    if (userCredential.user != null) {
      if (userCredential.user!.uid == admin || userCredential.user!.uid == admin_2) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => AdminNavigationHomeScreen(user: userCredential.user!),
          ),
        );
      } else {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => UserNavigationHomeScreen(user: userCredential.user!),
          ),
        );
      }
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
