import 'package:flutter/material.dart';

import '../Widgets/text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: SingleChildScrollView(
          child: signInBody(context),
        ),
      ),
    );
  }

  Widget signInBody(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Image.asset("assets/logos/main_logo.png"),
          userControll(context),
        ],
      ),
    );
  }

  Widget userControll(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: const [
              Text(
                'ログイン',
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        CustomTextField(
          label: 'メールアドレス',
          onChangeFunc: (newText) {
            email = newText;
          },
          isPassword: false,
        ),
        CustomTextField(
          label: 'パスワード',
          onChangeFunc: (newText) {
            password = newText;
          },
          isPassword: true,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {},
            child: const Text(
              'ログイン',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('新規登録は'),
            TextButton(
              onPressed: () {},
              child: const Text('こちら'),
            ),
          ],
        ),
      ],
    );
  }
}
