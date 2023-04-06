import 'package:coa_project/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

Future<void> onSignIn(BuildContext context, String email, String password) async {
  try {
    userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    user = FirebaseAuth.instance.currentUser!;
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
