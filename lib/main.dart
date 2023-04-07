import 'dart:io';
import 'package:coa_project/const.dart';
import 'package:coa_project/user_navigation_home_screen.dart';
import 'package:coa_project/admin_navigation_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_theme.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'auth/signin_screen.dart';
import 'firebase_options/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  ).then((_) => runApp(const CoaApp()));
}

class CoaApp extends StatelessWidget {
  const CoaApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: AppTheme.textTheme,
        platform: TargetPlatform.iOS,
      ),
      home: _checkUser(),
    );
  }

  //前回ユーザーから遷移画面を確定
  Widget _checkUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (user.uid == admin) {
        return AdminNavigationHomeScreen(user: user);
      } else {
        return UserNavigationHomeScreen(user: user);
      }
    } else {
      return const SignInScreen();
    }
  }
}
