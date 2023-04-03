import 'package:coa_project/const.dart';
import 'package:coa_project/src/home_admin/admin_home_page.dart';
import 'package:coa_project/src/home_user/user_home_page.dart';
import 'package:coa_project/src/signin/signin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//ログイン済みユーザ
User? user = FirebaseAuth.instance.currentUser;

//ログイン済みユーザかチェック
Widget checkUser() {
  if (user == null) {
    //新規ユーザ
    return const SignInPage();
  } else {
    //既存ユーザー
    if (user?.uid == admin) {
      //承認済み
      return const AdminHome();
    } else {
      //非承認
      return const UserHome();
    }
  }
}
