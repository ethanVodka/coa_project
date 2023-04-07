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
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  int _num = 1;

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
                          showTitleActions: true,
                          onConfirm: (date) {
                            setState(() {
                              _selectedDate = date;
                            });
                          },
                          currentTime: _selectedDate,
                          locale: LocaleType.jp,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(
                          _selectedDate.toString().substring(0, 10),
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
                          initialTime: _selectedTime,
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              _selectedTime = value;
                            });
                          }
                        });
                      },
                      child: Text(
                        _selectedTime.format(context),
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
                            setState(() {
                              if (_num > 1) {
                                _num--;
                              }
                            });
                          },
                          icon: Icon(Icons.remove, color: isLightMode ? AppTheme.darkText : AppTheme.white),
                        ),
                        Text(
                          _num.toString(),
                          style: TextStyle(
                            fontSize: 40,
                            color: isLightMode ? AppTheme.darkText : AppTheme.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (_num < 15) {
                                _num++;
                              }
                            });
                          },
                          icon: Icon(Icons.add, color: isLightMode ? AppTheme.darkText : AppTheme.white),
                        ),
                      ],
                    ),
                    Expanded(
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
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              title: const Text("確認", textAlign: TextAlign.center),
                              content: const Text("予約内容に間違いありませんか？"),
                              actions: [
                                TextButton(
                                  child: const Text("No"),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                TextButton(
                                  child: const Text("Yes"),
                                  onPressed: () {
                                    //データベースへ登録
                                    doBooking(widget.user, _selectedDate, _selectedTime, _num);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        'Booking',
                        style: TextStyle(
                          fontSize: 23,
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

  Future<void> doBooking(AppUser appUser, DateTime date, TimeOfDay time, int num) async {
    try {
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
    } catch (e) {
      showSnackBar(context, '予約失敗', false);
    }
  }
}
