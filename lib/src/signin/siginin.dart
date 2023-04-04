import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../domain/user_model.dart';
import '../home_user/user_home_page.dart';
import '../utils/utils.dart';

void onPressedFunc(BuildContext context, String email, String password) {
  onSignIn(context, email, password);
  if (userCredential != null) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => UserHome(
          user: user!,
        ),
      ),
    );
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return dialog(context, 'ログインに失敗しました', true);
      },
    );
  }
}

Future<void> onSignIn(BuildContext context, String email, String password) async {
  try {
    userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      showDialog(
        context: context,
        builder: (context) {
          return dialog(context, 'メールアドレスが見つかりません', true);
        },
      );
    } else if (e.code == 'wrong-password') {
      showDialog(
        context: context,
        builder: (context) {
          return dialog(context, 'パスワードが違います', true);
        },
      );
    }
  }
}
