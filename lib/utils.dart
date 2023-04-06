import 'package:flutter/material.dart';

import 'app_theme.dart';

AlertDialog dialog(BuildContext context, String msg) {
  var brightness = MediaQuery.of(context).platformBrightness;
  bool isLightMode = brightness == Brightness.light;

  return AlertDialog(
    backgroundColor: isLightMode == true ? AppTheme.white : AppTheme.nearlyBlack,
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
