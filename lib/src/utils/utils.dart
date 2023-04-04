import 'package:flutter/material.dart';

AlertDialog dialog(BuildContext context, String msg, bool isError) {
  String? title = isError ? 'エラー' : 'インフォーメーション';

  return AlertDialog(
    title: Text(title),
    content: Text(msg),
    actions: [
      TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('OK'))
    ],
  );
}
