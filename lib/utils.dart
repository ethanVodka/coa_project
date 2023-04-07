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

Widget appBar(BuildContext context, String title) {
  var brightness = MediaQuery.of(context).platformBrightness;
  bool isLightMode = brightness == Brightness.light;
  return SizedBox(
    height: AppBar().preferredSize.height,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 8),
          child: SizedBox(
            width: AppBar().preferredSize.height - 8,
            height: AppBar().preferredSize.height - 8,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 22,
                color: isLightMode ? AppTheme.darkText : AppTheme.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
