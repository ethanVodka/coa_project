import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../utils.dart';

class AminManagementScreen extends StatefulWidget {
  const AminManagementScreen({super.key});

  @override
  State<AminManagementScreen> createState() => _AminManagementScreenState();
}

class _AminManagementScreenState extends State<AminManagementScreen> {
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Scaffold(
      backgroundColor: isLightMode == true ? AppTheme.white : AppTheme.nearlyBlack,
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            appBar(context, 'Management'),
            Expanded(
              child: Container(
                  //ssssss
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
