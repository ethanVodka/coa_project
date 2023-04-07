import 'package:flutter/material.dart';

import 'app_theme.dart';

AlertDialog dialog(BuildContext context, String msg) {
  var brightness = MediaQuery.of(context).platformBrightness;
  bool isLightMode = brightness == Brightness.light;

  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
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

Future<void> showSnackBar(BuildContext context, String msg, bool isSuccess) async {
  final snackBar = SnackBar(
    content: Row(
      children: [
        _checkIsSuccess(isSuccess),
        const SizedBox(width: 20),
        Center(
          child: Text(
            msg,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    showCloseIcon: true,
    onVisible: () {},
    elevation: 4.0,
    backgroundColor: Colors.white,
    closeIconColor: Colors.grey,
    clipBehavior: Clip.hardEdge,
    dismissDirection: DismissDirection.horizontal,
    behavior: SnackBarBehavior.floating,
    padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
    margin: const EdgeInsetsDirectional.all(16),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Icon _checkIsSuccess(bool isSuccess) {
  if (isSuccess) {
    return const Icon(
      Icons.circle_outlined,
      color: Colors.green,
    );
  } else {
    return const Icon(
      Icons.cancel_outlined,
      color: Colors.red,
    );
  }
}
