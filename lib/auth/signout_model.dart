import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

Future<void> onSignOut(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();
  } catch (e) {
    showDialog(
      context: context,
      builder: (context) {
        return dialog(context, 'ログアウトに失敗しました', true);
      },
    );
  }
}