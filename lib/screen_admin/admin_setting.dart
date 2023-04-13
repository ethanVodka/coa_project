import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../app_theme.dart';
import '../utils.dart';

class StoreSetting extends StatefulWidget {
  const StoreSetting({super.key});

  @override
  State<StoreSetting> createState() => _StoreSettingState();
}

class _StoreSettingState extends State<StoreSetting> {
  DateTime selectDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
  int selectNum = 0;
  bool isEditNum = false;
  bool isEditDate = false;

  @override
  void initState() {
    _getLimit();
    super.initState();
  }

  void _getLimit() async {
    final snap = await FirebaseFirestore.instance.collection('store_settings').doc('limit').get();
    setState(() {
      selectNum = int.parse(snap.data()!['max_num'].toString());
    });
  }

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
          children: [
            appBar(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              child: Image.asset('assets/images/store_setting.png', alignment: Alignment.center),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          '休日 :',
                          style: TextStyle(
                            fontSize: 24,
                            color: isLightMode ? AppTheme.darkText : AppTheme.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(isLightMode ? AppTheme.nearlyBlack : AppTheme.white)),
                        onPressed: () {
                          DatePicker.showDatePicker(
                            context,
                            minTime: DateTime.now(),
                            showTitleActions: true,
                            onConfirm: (date) {
                              setState(() {
                                selectDate = date;
                              });
                              isEditDate = true;
                            },
                            currentTime: selectDate,
                            locale: LocaleType.jp,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            selectDate.toString().substring(0, 10),
                            style: TextStyle(
                              fontSize: 30,
                              color: isLightMode ? AppTheme.white : AppTheme.nearlyBlack,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0, top: 40.0),
                        child: Text(
                          '上限 :',
                          style: TextStyle(
                            fontSize: 24,
                            color: isLightMode ? AppTheme.darkText : AppTheme.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (selectNum > 0) {
                                  selectNum--;
                                }
                              });
                              isEditNum = true;
                            },
                            icon: Icon(Icons.remove, color: isLightMode ? AppTheme.darkText : AppTheme.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Text(
                              selectNum.toString(),
                              style: TextStyle(
                                fontSize: 40,
                                color: isLightMode ? AppTheme.darkText : AppTheme.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                selectNum++;
                              });
                              isEditNum = true;
                            },
                            icon: Icon(Icons.add, color: isLightMode ? AppTheme.darkText : AppTheme.white),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(isLightMode ? AppTheme.nearlyBlack : AppTheme.white),
                          ),
                          onPressed: () async {
                            try {
                              if (isEditNum) {
                                await FirebaseFirestore.instance.collection('store_settings').doc('limit').update({
                                  'max_num': selectNum,
                                });
                                isEditNum = false;
                              }
                              if (isEditDate) {
                                await FirebaseFirestore.instance.collection('store_settings').doc('rest_date').update({
                                  'date': selectDate,
                                });
                                isEditDate = false;
                              }
                              // ignore: use_build_context_synchronously
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return dialog(context, '更新しました');
                                },
                              );
                            } catch (_) {
                              // ignore: use_build_context_synchronously
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return dialog(context, '更新に失敗しました');
                                },
                              );
                            }
                          },
                          child: Text(
                            'Update',
                            style: TextStyle(
                              fontSize: 24,
                              color: isLightMode ? AppTheme.white : AppTheme.nearlyBlack,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
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
            padding: const EdgeInsets.only(top: 4, right: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              color: isLightMode ? Colors.white : AppTheme.nearlyBlack,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(AppBar().preferredSize.height),
                  child: Icon(
                    Icons.arrow_back,
                    color: isLightMode ? AppTheme.darkGrey : AppTheme.white,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                'Setting',
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
}
