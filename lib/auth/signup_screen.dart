import 'package:coa_project/auth/signup_model.dart';
import 'package:flutter/material.dart';

import '../app_theme.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? email;
  String? password;
  String? passwordCheck;
  String? name;
  String? phone;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isLightMode == false ? AppTheme.white : AppTheme.nearlyBlack,
      ),
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
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(60.0)),
                    child: Image.asset('assets/images/main_logo.png'),
                  ),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    'Sign Up',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
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
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'パスワード確認',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'パスワードを入力してください';
                    } else {
                      passwordCheck = value;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: '名前',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '名前を入力してください';
                    } else {
                      name = value;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: '電話番号',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '電話番号を入力してください';
                    } else {
                      phone = value;
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
                      if (email != null && password != null && passwordCheck != null && name != null && phone != null) {
                        onSignUp(context, email!, password!, passwordCheck!, name!, phone!);
                      }
                    } else {
                      //入力不備
                    }
                  },
                  icon: const Icon(Icons.person),
                  label: const Text(
                    'SIGNUP',
                    style: TextStyle(
                      fontSize: 20,
                      color: AppTheme.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
