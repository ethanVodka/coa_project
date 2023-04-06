import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../utils.dart';

Future<void> onSignUp(BuildContext context, String email, String password, String passwordCheck) async {
  if (password != passwordCheck) {
    showDialog(
      context: context,
      builder: (context) {
        return dialog(context, 'パスワードを確認してください', true);
      },
    );
  } else {
    try {
      userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      user = FirebaseAuth.instance.currentUser!;
    } on FirebaseException catch (e) {
      if (e.code == 'weak^password') {
        showDialog(
          context: context,
          builder: (context) {
            return dialog(context, 'パスワードが短すぎます', true);
          },
        );
      } else if (e.code == 'email-already-in-use') {
        showDialog(
          context: context,
          builder: (context) {
            return dialog(context, 'メールアドレスは既に使われています', true);
          },
        );
      }
    }
  }
}