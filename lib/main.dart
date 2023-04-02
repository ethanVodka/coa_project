import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const CoaApp());
}

class CoaApp extends StatelessWidget {
  const CoaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Snack&Bar COA',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const Scaffold(),
    );
  }
}