import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../models/user_model.dart';
import '../utils.dart';

class AdminAccountScreen extends StatefulWidget {
  final AppUser? user;
  const AdminAccountScreen({required this.user, super.key});

  @override
  State<AdminAccountScreen> createState() => _AdminAccountScreenState();
}

class _AdminAccountScreenState extends State<AdminAccountScreen> {
  bool isEditable = false;

  String? name;
  String? phone;

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
            appBar(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              child: Image.asset('assets/images/user_icon.png', alignment: Alignment.center),
            ),
            Form(
              child: Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          _setUserInfo(isLightMode, widget.user!.name, '名前 :', (value) {
                            name = value;
                          }),
                          _setUserInfo(isLightMode, widget.user!.phone, '電話番号 :', (value) {
                            phone = value;
                          }),
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Visibility(
                              visible: isEditable,
                              child: ElevatedButton.icon(
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(isLightMode ? AppTheme.nearlyBlack : AppTheme.white)),
                                onPressed: () async {
                                  setState(() {
                                    isEditable = false;
                                  });
                                  if (name == null && phone == null) {
                                    return;
                                  }

                                  try {
                                    User user = FirebaseAuth.instance.currentUser!;

                                    if (name != widget.user!.name && name != null) {
                                      await FirebaseFirestore.instance.collection('users').doc(user.uid).collection('register').doc('user').update({
                                        'name': name,
                                      });

                                      widget.user?.name = name!;
                                    }
                                    if (phone != widget.user!.phone && phone != null) {
                                      await FirebaseFirestore.instance.collection('users').doc(user.uid).collection('register').doc('user').update({
                                        'phone': phone,
                                      });

                                      widget.user?.phone = phone!;
                                    }
                                    // ignore: use_build_context_synchronously
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return dialog(context, '更新完了しました');
                                      },
                                    );
                                  } catch (_) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return dialog(context, '更新に失敗しました');
                                      },
                                    );
                                  }

                                  setState(() {
                                    isEditable = false;
                                  });
                                },
                                icon: Icon(Icons.person, color: isLightMode ? AppTheme.white : AppTheme.nearlyBlack),
                                label: Text(
                                  'UPDATE',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: isLightMode ? AppTheme.white : AppTheme.nearlyBlack,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget appBar() {
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
                'Admin Account',
                style: TextStyle(
                  fontSize: 22,
                  color: isLightMode ? AppTheme.darkText : AppTheme.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              color: isLightMode ? Colors.white : AppTheme.nearlyBlack,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(AppBar().preferredSize.height),
                  child: Icon(
                    Icons.edit,
                    color: isLightMode ? AppTheme.darkGrey : AppTheme.white,
                  ),
                  onTap: () {
                    setState(() {
                      isEditable = !isEditable;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _setUserInfo(bool isLightMode, String text, String header, Function(String value) changeValue) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            header == '名前 :' ? Icons.person : Icons.phone,
            color: isLightMode ? AppTheme.nearlyBlack : AppTheme.white,
          ),
          labelText: header,
          labelStyle: TextStyle(
            color: isLightMode ? AppTheme.nearlyBlack : AppTheme.white,
          ),
        ),
        readOnly: !isEditable,
        controller: TextEditingController(text: text),
        style: TextStyle(
          fontSize: 24,
          color: isLightMode ? AppTheme.darkText : AppTheme.white,
          fontWeight: FontWeight.w700,
        ),
        onChanged: (value) {
          changeValue(value);
          TextEditingController(text: value);
        },
      ),
    );
  }
}
