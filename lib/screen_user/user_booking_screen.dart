import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../app_theme.dart';
import '../models/user_model.dart';
import '../utils.dart';

class BookingScreen extends StatefulWidget {
  final AppUser user;
  const BookingScreen({required this.user, super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = const TimeOfDay(hour: 20, minute: 00);
  int bookingNum = 0;
  //今後変更箇所
  int limitNum = 8;
  int selectNum = 0;
  void getCollections() async {
    int num = 0;
    DateTime start = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 0, 0);
    DateTime end = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 23, 59, 59);
    QuerySnapshot collectionList = await FirebaseFirestore.instance.collection('booking_list').where('date', isGreaterThanOrEqualTo: start).where('date', isLessThanOrEqualTo: end).get();
    List<QueryDocumentSnapshot> documents = collectionList.docs;
    if (documents.isNotEmpty) {
      for (var doc in documents) {
        num += int.parse(doc['num'].toString());
        setState(() {
          bookingNum = num;
        });
      }
    } else {
      setState(() {
        bookingNum = 0;
      });
    }
  }

  @override
  void initState() {
    getCollections();
    super.initState();
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
            appBar(context, 'Booking'),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.user.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        color: isLightMode ? AppTheme.darkText : AppTheme.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(isLightMode ? AppTheme.nearlyBlack : AppTheme.white)),
                      onPressed: () {
                        DatePicker.showDatePicker(
                          context,
                          minTime: DateTime.now(),
                          showTitleActions: true,
                          onConfirm: (date) {
                            if (date.weekday != DateTime.monday && date.weekday != DateTime.sunday) {
                              setState(() {
                                selectedDate = date;
                                getCollections();
                              });
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return dialog(context, '日、月曜日は定休日です');
                                },
                              );
                            }
                          },
                          currentTime: selectedDate,
                          locale: LocaleType.jp,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(
                          selectedDate.toString().substring(0, 10),
                          style: TextStyle(
                            fontSize: 40,
                            color: isLightMode ? AppTheme.white : AppTheme.nearlyBlack,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(isLightMode ? AppTheme.nearlyBlack : AppTheme.white)),
                      onPressed: () {
                        showTimePicker(
                          context: context,
                          initialTime: const TimeOfDay(hour: 20, minute: 00),
                        ).then((value) {
                          DateTime startTime = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 19, 59, 59);
                          DateTime endTime = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 22, 1, 1);
                          if (value != null) {
                            DateTime time = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, value.hour, value.minute);
                            if (time.isAfter(startTime) && time.isBefore(endTime)) {
                              setState(() {
                                selectedTime = value;
                              });
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return dialog(context, '8:00 ~ 22:00 の間で選択してください');
                                },
                              );
                            }
                          }
                        });
                      },
                      child: Text(
                        selectedTime.format(context),
                        style: TextStyle(
                          fontSize: 40,
                          color: isLightMode ? AppTheme.white : AppTheme.nearlyBlack,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (selectNum != 0) {
                              setState(() {
                                selectNum--;
                              });
                            }
                          },
                          icon: Icon(Icons.remove, color: isLightMode ? AppTheme.darkText : AppTheme.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Text(
                            '$selectNum/${limitNum - bookingNum}',
                            style: TextStyle(
                              fontSize: 40,
                              color: isLightMode ? AppTheme.darkText : AppTheme.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (limitNum - bookingNum > selectNum) {
                              setState(() {
                                selectNum++;
                              });
                            }
                          },
                          icon: Icon(Icons.add, color: isLightMode ? AppTheme.darkText : AppTheme.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.28,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(60.0)),
                        child: Image.asset('assets/images/booking.png'),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(isLightMode ? AppTheme.nearlyBlack : AppTheme.white),
                      ),
                      onPressed: () {
                        if (selectNum != 0) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: isLightMode == true ? AppTheme.white : AppTheme.nearlyBlack,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                title: Text(
                                  "確認",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: isLightMode ? AppTheme.nearlyBlack : AppTheme.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "予約内容に間違いありませんか？",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: isLightMode ? AppTheme.nearlyBlack : AppTheme.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      "日付 : ${selectedDate.toString().substring(0, 10)}\n時間 : ${selectedTime.format(context)}\n人数 : $selectNum",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: isLightMode ? AppTheme.nearlyBlack : AppTheme.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text("No"),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  TextButton(
                                    child: const Text("Yes"),
                                    onPressed: () {
                                      doBooking(widget.user, selectedDate, selectedTime, selectNum);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return dialog(context, '人数を選択してください');
                            },
                          );
                        }
                      },
                      child: Text(
                        'Booking',
                        style: TextStyle(
                          fontSize: 24,
                          color: isLightMode ? AppTheme.white : AppTheme.nearlyBlack,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List> getBookingList() async {
    List docList = [];
    await FirebaseFirestore.instance.collection('booking_list').get().then(
          (QuerySnapshot querySnapshot) => {
            // ignore: avoid_function_literals_in_foreach_calls
            querySnapshot.docs.forEach(
              (doc) {
                docList.add(doc.id);
              },
            ),
          },
        );
    return Future<List>.value(docList);
  }

  Future<void> doBooking(AppUser appUser, DateTime date, TimeOfDay time, int num) async {
    try {
      if (num != 0) {
        final DocumentReference ref = FirebaseFirestore.instance.collection('booking_list').doc();
        ref.set(
          {
            'name': appUser.name,
            'tel': appUser.phone,
            'email': appUser.email,
            'num': num,
            'date': date,
            'time': time.format(context),
          },
        );
        Navigator.pop(context);
        showSnackBar(context, '予約完了', true);
        setState(() {
          selectNum = 0;
        });
        getCollections();
      }
    } catch (e) {
      showSnackBar(context, '予約失敗', false);
    }
  }
}
