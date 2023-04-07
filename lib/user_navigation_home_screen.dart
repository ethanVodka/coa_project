import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coa_project/home_user.dart';
import 'package:coa_project/user/user_about_screen.dart';
import 'package:coa_project/user/user_account_screen.dart';
import 'package:coa_project/user/user_booking_screen.dart';
import 'package:coa_project/user/user_help_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../app_theme.dart';
import 'custom_drawer/user_drawer_user_controller.dart';
import 'custom_drawer/user_home_drawer.dart';
import 'package:flutter/material.dart';

import 'models/user_model.dart';

class UserNavigationHomeScreen extends StatefulWidget {
  final User user;
  const UserNavigationHomeScreen({required this.user, super.key});

  @override
  UserNavigationHomeScreenState createState() => UserNavigationHomeScreenState();
}

class UserNavigationHomeScreenState extends State<UserNavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;
  AppUser? appUser;

  //ユーザ情報を取得して構造体に格納
  //この先複数回のアクセスを防ぐため
  Future<void> _setUser(User user) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(user.uid).collection('register').doc('user').get();
    String snapName = snapshot['name'];
    String snapPhone = snapshot['phone'];
    String snapEmail = snapshot['email'];

    appUser = AppUser(snapName, snapPhone, snapEmail);
  }

  @override
  void initState() {
    _setUser(widget.user);
    drawerIndex = DrawerIndex.home;
    screenView = const UserHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: UserDrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
            },
            screenView: screenView,
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      switch (drawerIndex) {
        case DrawerIndex.home:
          setState(() {
            screenView = const UserHome();
          });
          break;
        case DrawerIndex.bookking:
          setState(() {
            screenView = BookingScreen(user: appUser!);
          });
          break;
        case DrawerIndex.about:
          setState(() {
            screenView = const AboutScreen();
          });
          break;
        case DrawerIndex.help:
          setState(() {
            screenView = const HelpScreen();
          });
          break;
        case DrawerIndex.account:
          setState(() {
            screenView = const AccountScreen();
          });
          break;
        default:
          break;
      }
    }
  }
}
