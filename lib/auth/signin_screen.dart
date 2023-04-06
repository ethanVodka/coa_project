import 'package:coa_project/auth/signin_model.dart';
import 'package:coa_project/auth/signup_screen.dart';
import 'package:coa_project/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../user_navigation_home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String? email;
  String? password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;

    return Scaffold(
      backgroundColor: isLightMode == true ? AppTheme.white : AppTheme.nearlyBlack,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: 300,
                  height: 300,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(60.0)),
                    child: Image.asset('assets/images/main_logo.png'),
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Text(
                    'Sign In',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 50,
                      color: isLightMode ? AppTheme.darkText : AppTheme.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'メールアドレス',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'メールアドレスを入力してください';
                    } else {
                      email = value;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'パスワード',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'パスワードを入力してください';
                    } else {
                      password = value;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32.0),
                ElevatedButton.icon(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black)),
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      //入力データ確認
                      if (email != null && password != null) {
                        onSignIn(context, email!, password!);
                        if (userCredential != null) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (BuildContext context) => NavigationHomeScreen(user: user!),
                            ),
                          );
                        }
                      }
                    } else {
                      //入力不備
                    }
                  },
                  icon: const Icon(Icons.person),
                  label: const Text(
                    'SIGNIN',
                    style: TextStyle(
                      fontSize: 20,
                      color: AppTheme.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('新規登録は'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const SignUpScreen()));
                      },
                      child: const Text('こちら'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
